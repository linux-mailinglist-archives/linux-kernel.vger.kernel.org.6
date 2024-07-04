Return-Path: <linux-kernel+bounces-241005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C2C9275AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57BDDB218C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2877F1AE0AD;
	Thu,  4 Jul 2024 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WKjjog0b"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A6F1AB503;
	Thu,  4 Jul 2024 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720094592; cv=fail; b=rVLWX9v8Q79YyRCFZKnbUeHarBGNs/N11G64/Y29EKYeRGHNLrh1qN3YqSJ+8OIcxsI8/cvl6NXZaBNdS3s3ooBm7MYHy7XNSBQJy8dQzDVU2MzuJHfTtqPxOKf1wJ2tLRfgbfgZzT0QLS7wGyDooxVzTDFJUQT9r5cXsgevwZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720094592; c=relaxed/simple;
	bh=d6DsN70DE3vxP51P7rgQgltcBTKwBkGNZyK4zLE+7vg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lDHmxpLFR4B7bSKRPMgg/qX5GlZwfue6mu2IINpa2AjD7xYmZpAtKoyk/uiQvb5Oj+IBTCx/6M1zstl9snn3/7FtYFFZvra8B8PwRmtsZ2icpYpK1uJrr/BTbq4qb4RJinvfCEs2rIdr06yqqQIUc3J66vkcny5489Qa6ONIlvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WKjjog0b; arc=fail smtp.client-ip=40.107.241.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1P2qPm839GLf4gOz5TyaVz3hZYqt2JVcc/OfErNPxijfDWNIAYhA3rumkKmqFohHhYu4M+8cQRwDbxgjtDl45dCCMVSyducAdp5uaNv0K5i2pklRld0Hqc+DqX9xA7SM0Nc1SxqTDQFsIZNkzNgYROkGpaXldE43pf3qDQvqJOnV7nDZVrgEKLcC8FgKFsDHsTbokJkDwD6TWF+fypSmRL5z7sJy9zF+YuplXovJ5NYPDUkjE+m+fo/Wy7bVkvoEUoi9+tlMOEOzdciZsXrpknws+Fa6dKsyucZU+w4+bmgKFTQUAj4cRxp4aBjvaoqeaqk/61QPyCF4B9itNKW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0sdSqBJWwrJh8J3xzxxEfaqgLcJvz4ECVIUMsAknCw=;
 b=kvx4QTa16Pqi++Awtda+kibr5XBvRtnHJEeqEnih226yzrG+KdMToqbuK6eSNTyHF/1WdV22po+0GCrgflpQyX/csYSpVSmZahvz4EB8CWHb/4byvnulgaTbsY4k9S57ZJcZmv3/Wb40fCwLfuzwMn0Dg7pxytMyY+Jmkc0iB+FqfVfECZXX2yPtHehkOGBkg5YT96NaMQIYu51vXQxNEknA/37omG99mYts1cbVyQ4cJuU4s7jCWCiPtVlUC+Nb8fXR3nSYWx8AOcdsaAE13rFof4I5qT89E/KJ/2UEjFKfvWebNf9Dif9sxueEfeq5IuZKpGKzv0jn4LWI0JVnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0sdSqBJWwrJh8J3xzxxEfaqgLcJvz4ECVIUMsAknCw=;
 b=WKjjog0bDOEXB/szxWMnaT5JUrVfI5RRSyhB3kCE6egi51noXk7lYoELmdhyqifdkVPIOfb0T3hZfct7wHfCoygtR03GkwlAJLE4OEtRU93243CAG4rq5I1HYLBRx8LdzHvWggTukvbC5vYkvRioJg8zQY87CmewNXFG64Z0KNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS8PR04MB9192.eurprd04.prod.outlook.com (2603:10a6:20b:44f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 12:03:05 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 12:03:05 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH] arm64: dts: s32g: Disable usdhc write-protect
Date: Thu,  4 Jul 2024 15:03:00 +0300
Message-ID: <20240704120300.2849264-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0118.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::23) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS8PR04MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: c7eb9429-8aa2-4ba9-7c5a-08dc9c2142e5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0pvYlFHN1kxelRyNkNjakxid1d6RUVCRWVVQmR5aFo0b0h6UUFCaXBPY3pS?=
 =?utf-8?B?Q0JtUnBjUXdtME1jbmVCZ3VCK1R5dTZCREVnMnJaQktvNzZ1Wm0wMCtRcDlC?=
 =?utf-8?B?ZUdveER0Qk8yNWRTeWthYW9VcmtLVVU3US9mQUZHSXplRi9jaHJZWVd0VzBp?=
 =?utf-8?B?WDVYTkJQUE9IaXA5bjFwYjVOS3ByMkV0ejhjVzcvMW9wUWRTUTBGeTRWYk1T?=
 =?utf-8?B?bXpWdXBXOUg4aGlCZnZ3aC9oNWdrZ0pSeXd2S2JTWnZ0V2trZEZhSVY0ZjFL?=
 =?utf-8?B?ZENXc3I1dXNCYk5MNjBUZW0vSFR6YlE0K0lXU29nNDlSK0ZVY2g3TmNDaUtz?=
 =?utf-8?B?ci9zby9uOEs1L29qY0s5MkcyeTdjd3lHZUNQdEdDWE14V1VlTE9EOE1qQVhU?=
 =?utf-8?B?WS8rOXlqbWx3TVNnZkxzQjdWeUJDcGtjYWlSVUF1RlVDU2hOaEZHZW1kcEw2?=
 =?utf-8?B?bWY0UStzVnRLaW5zbndPb3FmUEFrZXRnekVKbDlRbUVtNHlQZkFjbExUTjlG?=
 =?utf-8?B?cVcxK3dza0VGM2J6YWNSTWZTM2o4SjYyK0hSU3Y5cndJRHBMWjdzU3crWkox?=
 =?utf-8?B?TU80YURLenJzQzdscFNmVllpVlplcmphcytCVFRjL0NPSUdwMVhqcVN6U0xk?=
 =?utf-8?B?QktJNnF5V3NkczJNYXh6YzhmNi8wU0RmNjhjcDBLdUxyNitqZFZrVmM2Nys0?=
 =?utf-8?B?SzRtcmdaNzJsbkdNTzY1S3UvUmVhbDU2b3BGOW5ZNzFuOThXcGpiUndLSUVL?=
 =?utf-8?B?L1hLc1h5U1BCZi9YZGFlUnBFc0RweEgxRWdQbVR0SktJbUtoMVo2Rm9pVmJo?=
 =?utf-8?B?cW1qZ1hLRmFLdkNYUlRJY2M5Y1ZlUzd0eVQvYU1RZkQyL1Iwa09kcmYxWG1T?=
 =?utf-8?B?NXE5NVNtZzFDRWJENmdsY0hHSHNuRno5RHNPYmlaTGNFeUNSY2NmcDJNaGhY?=
 =?utf-8?B?N2xINEtNZzE1dHRVVmQ5azYvRGI4SFJNRDhoY2p2dDFyRTBxVXZ6dGd5RnZ1?=
 =?utf-8?B?UVJtV1pzZHBFRFFOOStFUmgyaGFSTXFBTFA3S3NoVmVCK3d4U3IySDVmRHdE?=
 =?utf-8?B?OXUzeDZuTTI4aTQ4MGdPanRIOFNjcEJXZmowQjJsWG9tY01aNm8ra3RRQ2g3?=
 =?utf-8?B?QWYrelpFZXhYa2JwWGRsc2JnOEhVdjhNNDRLVkJ0eHBqODJKSWh3cU5IQ2t2?=
 =?utf-8?B?T3I0di9Iamp3eWVyRk9ieDllSDJWTWNoVnJBaHE4VzUycEJtSEwxYmVteElz?=
 =?utf-8?B?MzdFNkwvcUtOSjZVdkxhaWJFc25pcmlIUnB4c1FGN1ZlZ3JYbmdiUGNsRFo4?=
 =?utf-8?B?RDFtQzBLNWxkSTV5dkd4MHYwSlVJenY5R2ZxbkY3S3hrZlJkbEI0SUo0R2RQ?=
 =?utf-8?B?dzdYS2lLak5NdjRQSUhXMDRxbGl1TEdma2lXa1BsWHZ2ZVFsMloreGQydjd1?=
 =?utf-8?B?Y25zSmRMMVFNNDJQVHN6bHI1NzhmVk10QWw2WGNaK1JqbDRSTUxoRDZoQk1Z?=
 =?utf-8?B?emhva0FKcER6N3lvWDB1eXl1Q0tyZzI0enAvT0svZS9xK3FwZjdTajVCdjdm?=
 =?utf-8?B?MXJBdFR0VHRVTFErdW9FbklvYXpEVjMrVE9WUUFta2NCK0VYNjg5aUVHQk92?=
 =?utf-8?B?R3ZUc21BZlJUVENDQk1ORGpEK1Jnc0pDZjJpWkZRa2dISlFIdyt3RVVLd3Vw?=
 =?utf-8?B?bzh4dnRxOHFDeVlWU1RIazE4ekpIVkhhYVFVd21tTGZqZVVsakkyUE4zN3Bz?=
 =?utf-8?B?dXFVZXFqVjR0ZkJRNERjUzI0QWdjeVJQRVpyZ2FDVk9Pa2h3eDNQNGVMbGNu?=
 =?utf-8?B?SzQwTkxsbjFZSmNYdGtMUzlhSUFWNW15c3dXMWNQODlOM0FxSUpWSTRMQUpm?=
 =?utf-8?Q?zPvQkMoPbu6E8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzdhYTk4K0lkdmZocVhESExZV1VWM1pRcUN1MkVKZDRtMDh0UFFCaDVCdG5R?=
 =?utf-8?B?S0VNaHhXMkxiOWY2QzdsU3M1SDc5OTViZGJ1UzJ6VWViVGFzTTFvcnZmYmZp?=
 =?utf-8?B?MHlGNEtySWJwc3BiOGNTNFJtYzZsaTdxVFpERHliMVk1THhwbVg5N0hUNk1u?=
 =?utf-8?B?ZzN0eExYVzg3V0ROSWdkTEFodjRjQnBsMkdVSGhUaEpmaXpWa1FNVWU0R2ly?=
 =?utf-8?B?UjZ6Q2VwSUliYWQxS3p0SThNNzd0VXV5UzFPNWEwZXFmcW44bnl6RS9rTHFx?=
 =?utf-8?B?VXRuZnpZdjVLUXUrWnVWeG84K2F2Tlg5dC9kbEZnbnN5NHk4ZzNuNktyelJG?=
 =?utf-8?B?RmczZjd1NnRsOVg3MzY1cDBtL3V2dDBWQkRWMTNEbnc5bi8wRGRMSTljMzBU?=
 =?utf-8?B?WEJTNjQvaVUyVWplTVBwRG1PWnE4N3pmZHdoOWl2MHErZnJkeVUzVEFBbjBV?=
 =?utf-8?B?bnRnNGZKTi9xdVhwcWxGd2lyREFoSG1JKzdPbDBSSi9lcFRZK3JkRDdUbFpK?=
 =?utf-8?B?OHZONXM2Z2Z3K1pNQ2tQV0VjLzVONnlLMU1ZZHNTQkwvOFhkMkV2MEdIMXdh?=
 =?utf-8?B?QWd6ZE4wbHVUNGsxQ2JtSTVMbU9EMXZOY0RzM0pKcmpZSHFTRkxsWFRJNlFB?=
 =?utf-8?B?N2ErK2N2SjROZlQ4eFY2aVRCVFE3bnR5K3lHQ2ZpeG5GNTRjRWJrSTJWL0d3?=
 =?utf-8?B?Y1dmZXE4UmZURDUzaG8wb2lOaTF4SXlNZHZUWFZKU3M4c0FwWTNFNW5LUnk0?=
 =?utf-8?B?a0l5djB6N3BGeVBGZzExY01hNGZRNFZRejl5cnRmZXZ2c1c2S3d2ZFlad1Vl?=
 =?utf-8?B?emZOZHNjTjYrQ3BvWmlqbmRlb29KS1ZoTEU3SDIwVXhqQmpsYTdXZm5zOHpI?=
 =?utf-8?B?VHhaUnQ4SEcvN0Z3NEViWWk5ZGVXQ0lFUFJOSUZQQWlXYUJ4NllyMWxJdG1G?=
 =?utf-8?B?ZGJIWFR4S1JSZGZ2VFcwb1JsaTI3QXpBdlNUZjY0TkZ6U21TT3JFWnhsWXpI?=
 =?utf-8?B?QnQrSzh4T0p3R3lsQTVzaGt5UXdnNW51RzNoL3VwZm5uKzhhbUF1eUpuSCtM?=
 =?utf-8?B?bHpZcTRPYno3MDlmYU4rOWJnM1d6M25hQnFuSmc1Z3h0NEJhb0pEU2ZRVGl3?=
 =?utf-8?B?V0wwUzhkMnRVcTYveVdvTzhVSUYxNEZUbU1CZmN5RlYwdXpzaVZ5WDRxZG5p?=
 =?utf-8?B?ZHFIaWNmNWJLdXNHRUMwRHRzU3hQQ3Jham0zOTcrVDA3MUpXb0RjTmpDUC9m?=
 =?utf-8?B?Y3FHRHNUNytOb0wyTlRDQXA5aHF5Ukc1QTZhSjN3c1g1V0JhemhvaklKcWZY?=
 =?utf-8?B?eHdmdXcyb3ljbHBnUmFxbWRxNWFVN3d3VktZaERya1BXdTNYT3ZCaWRHTzJG?=
 =?utf-8?B?TGpKaFVUTExMNlZyTHNIUFdQRlgwalZiVVdSQlNnY3NoRXpvZUo2bkx6QmxL?=
 =?utf-8?B?UkNaVis1YXpGZ1l1UzVHZmlIL0p5cmxjdE4vakduTmRPNUpIUmhTQmE0T1Nu?=
 =?utf-8?B?NWtDc3Y5OVpWbURyTElNWFpsWXlGbTY0NVEwbEc5dlRVS09nRUpPQmdTWkxY?=
 =?utf-8?B?czNKV0VCMkxZZjkxQ3FCNXYwOXhvUjVoNjFYNlJZazlnZFpZT0ZaaUxuUUx2?=
 =?utf-8?B?RTZFcjlzbE9iNTRaU1hnWjdlZVlaSk1jUFRPT3NiNDl6eEcvQW5JN2hETjh3?=
 =?utf-8?B?d1lwV0J0Vk5HVHpXQVhtOUdIeXN2MkVqL3ZPZlFTLzUySHl3TllOc2FzRW5m?=
 =?utf-8?B?R2FySDZ0ZUI3YXI3MjVKUnBHdmh2UndOVEROT2ZpRU5SNExHS0YyN255VzlO?=
 =?utf-8?B?WE40OW1nRElnWkhmYjNibnVUMlVFOTBrV05oVVVMZFhKT0FFdnFxZUoxNFJO?=
 =?utf-8?B?VnJVcmlWTEJra20xTFFFcnVkZHJrS1Avb1duc3BXSkx3ZG4wTmNRZk1UMTdT?=
 =?utf-8?B?dlRPVytSbGZYczFpQk10UCtVNE8rKzR6U09xUjlheURmdmI0L2JiWUxkdXlp?=
 =?utf-8?B?M2hxWUJvZGxGem5FZW1RaFpKVUwzNUR2NXJIaGtZM3cyR1lzYkNKWnlHOHlJ?=
 =?utf-8?B?YzViR1VWU1YxOENGWHhDNTBRVGE0S1N4V25iS3NNVm9aL1YrWkR3SGZjSm5C?=
 =?utf-8?B?dGp5cTg1ZE9pcndiMkxsa0ticWs0MEZEYUMrd0liemdTWDFyaElzT1plQUI3?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7eb9429-8aa2-4ba9-7c5a-08dc9c2142e5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 12:03:05.2788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuA4Gv+1qdAs0cJQhSXX5SGRryKeK0AKev5dLoZgHd9+Dcdy1oZpXJ/QwDNs2nJ5iyXPBd/lTQgJGGqNMiGUSnFMOXxL9onFM2+Mi8vSG5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9192

SDHCI controller found on NXP S32G based platforms do not
define a pin for SD-Card write protection.

Hence, adding 'disable-wp' usdhc device-tree property in order to fix
observed warnings on SD boot as the following:
"host does not support reading read-only switch, assuming write-enable"

Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 1 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index fc19ae2e8d3b..2ad8cfe964be 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -145,6 +145,7 @@ usdhc0: mmc@402f0000 {
 			clocks = <&clks 32>, <&clks 31>, <&clks 33>;
 			clock-names = "ipg", "ahb", "per";
 			bus-width = <8>;
+			disable-wp;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index c1b08992754b..9d38bdc23cff 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
- * Copyright 2021-2023 NXP
+ * Copyright 2021-2024 NXP
  *
  * Authors: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
  *          Ciprian Costea <ciprianmarian.costea@nxp.com>
@@ -204,6 +204,7 @@ usdhc0: mmc@402f0000 {
 				 <&clks 31>,
 				 <&clks 33>;
 			clock-names = "ipg", "ahb", "per";
+			disable-wp;
 			status = "disabled";
 		};
 
-- 
2.45.2


