Return-Path: <linux-kernel+bounces-173979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34038C089C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E731F230D9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B763611D;
	Thu,  9 May 2024 00:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SO6aXHf+"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A063AC2B;
	Thu,  9 May 2024 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215549; cv=fail; b=p1Bj8OhLpn6FTd5kG9ifwpFoj3mG7CMaptqGaSmU0rCuRVodxa6qEsv2z+Q+ChMw3Pc8v1LCzqI8VkZ5sL8PBjERdS2TkWrfeE33VMrmzU9tQ4D4Gj1FKOAmc4Op0OvvqzIbfZzmv8HUgI0seF7BgxjpbJUCnqSyAlP6EwrfDh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215549; c=relaxed/simple;
	bh=CwB+dL5zyYX72han3czsGN72i36Ut3sOkzdA4ezN1vA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TGlg4WUSN+I/vxX+s0C7pFiOOGaXtMX1mlJ0btwxGLXtWmS5krXyCFbQ1Hii0M7m6b0p6UMCprDEmFPIrPPpgsDatfLR1karHRbSyLudkb/H0a8Jo9GSCyFq2SgJc96ovbL/TEp2BMtjqSweBy7vf8sYuw+I9BXkgt8XmX76k9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SO6aXHf+; arc=fail smtp.client-ip=40.107.7.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd6cDLeTGrbfMHcbeh7dvBn4sD9u29/18OXcEOsVC+dt5MzWjTwgHrunIg8NYJvZd2eOgUiPDP/GP3pNaWfmK6Y5ujYBDh796IboBGC9kmk2JdGzyFFRs5otzwuZ4eI+304zh4Aj/hyFnESE3VVOvlCFb8E615dLmnGhYhZagnv+DAbtG4AmPQTAn6q2Q2HXU2QnXuhVw7PneTnYLy1bnMkzLufDUTUSaElh8SOuKPdiNvFcg6oLeWW+leXHnnQa2dRKO0TqaCBqt4M3lJOCaAKmjbktrDjdoJylYFTM7e9KuszmHDRpHYgDXuqVfXNf6E+bumFiJBpF4Q25aU21VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KW3TEVYisXJpBSafePW3lqofXj3EwywSx5j4Jm9+RDw=;
 b=Q6qZ7dARUExSMp5sUFsgiI6LhZjcCH8pfxEo/R+vetRNIQLEq2FJq7WmgRDJlJeRzpH28WlIKvcsrTHI6jFs9WHDAeSOAhUQHjfJGYArfkdKVsnU0u3RPIeXiQZCjBonnd/GumbY4lTHzLNtdEyVKodFl4dqErLk8J+kvQ2/mW1IS0mJOvlk9wk9jcxDfoHjUyMuYM0axc5ns8m8rFA1UVdg4XaxCdsvFkTjUovPWCkNZlJDbpiLsJET5w3OqI3PYhLQcG/rUfLwiG7h8Yzvh8+VXwrT+/dbZayeIZT45MBX/efnrXa7rQNUfNoaPgWFj8ly5M7cpLW7Kk0qcL9TiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KW3TEVYisXJpBSafePW3lqofXj3EwywSx5j4Jm9+RDw=;
 b=SO6aXHf+u3BT9a5FPAa8N0HD0YX0A+XXOUcAPU7O6ne7iDMX5IUsmjIQm/c6LmEQHPKAG/7+pMKa7rF5m09ikx6j2I2uPpdk0o7682Wp5K4nORni3nebTcKJJb++R+0qD1uXC9b4UWsFuPfsD/hvBB3zZ7VTVSezilLRGAyuEEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by AM9PR04MB8273.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 00:45:39 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 00:45:39 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
Date: Thu, 09 May 2024 02:45:33 +0200
Subject: [PATCH 2/4] firmware: imx: Add SC APIs required for secvio module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-secvio-v1-2-90fbe2baeda2@nxp.com>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
In-Reply-To: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Franck LENORMAND <franck.lenormand@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Varun Sethi <V.Sethi@nxp.com>, Silvano Di Ninno <silvano.dininno@nxp.com>, 
 Pankaj Gupta <pankaj.gupta@nxp.com>, frank.li@nxp.com, 
 daniel.baluta@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>, 
 Iuliana Prodan <iuliana.prodan@nxp.com>, 
 Horia Geanta <horia.geanta@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: AS4P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::9) To AS1PR04MB9358.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dc::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9358:EE_|AM9PR04MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: e7063b96-69c3-4074-3eea-08dc6fc15921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|52116005|376005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnNQeklNRVp0Szc4ZmNCYVZmbThmYTEzamZKYkJmMm5OWFVPa0hGblFwa1hl?=
 =?utf-8?B?UGdJek5UVlNaWlJaMktOblBsRlpHd2h6ZVVVSlBPT1V1SnhRdXBDVGdKNlFY?=
 =?utf-8?B?YmM2WWhOY25waWlaMHVEeks3SUw2VGNKSGdBL3JBNmc2K3Q5RGlVb3FCQ3JF?=
 =?utf-8?B?Tmo0N0diazQ1d2NyZ0VVTTBMRzRZY1lSUktQeVlpZTErYUwvVDZoWFVhUitp?=
 =?utf-8?B?dFFqUGx0WkUzVU1hUHBTUmdXWG1OZTR1Si8yNzVsaVh6UzBIT1o1RGJrenZH?=
 =?utf-8?B?dXpTcGQvYURYVVp5eWl0cW1hZHBselNidVZpRHNpdUJGdUxqUkN2dkZIN1Zk?=
 =?utf-8?B?Y2s3MFBBU0J6OU1Ba1doVDI1VWxmTG03M0JDVjBlQTEySlpERFFoV1pTVkRV?=
 =?utf-8?B?THQvZVdzWWh5d0xrc2xFOTc3LzRsM0FhdGpaU2hMaTFQQWtYUkpUblQvQTRD?=
 =?utf-8?B?K1BITVAycFJ0K2xrT3FHcVZ4MVoveUZFZWdTd2ZIZTBQWG5WR1loK3U5eHRw?=
 =?utf-8?B?ZHBLeEhqMFhXa1VUaCtUWVBJVStla1R3TmREMGlQYU1uZW9qWUZZNllvM2tO?=
 =?utf-8?B?L05jdUdiTmFOYm5FOUNjamJubHI0dk53cDlVNCtvV09LL1FzK3VUY25JODFa?=
 =?utf-8?B?dkNNMTRiTCs4QW1JNkw3aHM3R0dWMmZrN2ErQUxDOVROdDc4QXpZY1hobit2?=
 =?utf-8?B?RTB5L3VnUzcwaFJ1SnlIMHJSVWJra0FkbnRTSWhpSm1HZDJzejJjVXFKZmFp?=
 =?utf-8?B?QUZQQWt4ZTJHMHZMV1FBUldHdXAycnhiVWppOGhWeUxYaGJickx1dmU2bEU5?=
 =?utf-8?B?RmN1eFhVUzI2RWFvaTVkZmIvS2cyaVhxU3QwZW92RHZPeGpCYVpKRUNQdHFy?=
 =?utf-8?B?ZHB1NVVQczQ4eFNvTy92eUU0YkhNMUF5TjI3M1N5aVlRTVBHRkgwTDdNSEJ5?=
 =?utf-8?B?bkdVUUlJbUVsT1NoWnJFZUE3MUdISUlOaGZjWXFNK2ljT3RsYktCWkRVbUxj?=
 =?utf-8?B?WEJubXYzVDJoeDBwUFhUcGVhR3pEdTJ1NmhQZDd6RG93U1FSMll6eS95TEJu?=
 =?utf-8?B?aDA5eERnK3p0Zk9Uam5Ndi9uYXlaUFMxV1RocGJqaGZVd1piamliSkNJeVpG?=
 =?utf-8?B?bndCa1FOWEhCaXZzTlBzOEUzVVhGMVRnZERveEZ2dUVWNmlhamRPL09EaElQ?=
 =?utf-8?B?M01HYWVvWFRISWJUbWdUbFlKV0xKKzN3MUJBMnc5Ny9zMHpMdFJqYXRuVGxL?=
 =?utf-8?B?VjhYRzlXWUg2NFpIVEdjd0M0dElGeXJIVkNYd3dETjZRalN1YmpFdHhNcE1O?=
 =?utf-8?B?WG1aQlczSUpjazAzVERuUTFwZlo5R3EwWUU1Yy8veWNxSm5UdlpqT0QrSm1S?=
 =?utf-8?B?cFV2V3MwazBrdExvSjBYQyt4dy93TVFSVlU3eHA1QmlKaDVpWVhFYjBVNzRP?=
 =?utf-8?B?OFRFbkJrNWdZQWtvZEFUWkF6cUorNFhaUi8xbWc5SjVhVEJMOVAxOUkxajhq?=
 =?utf-8?B?RFJoZk9XZzRoZzVybkVXRm53bGVkdERRNml4Ukh1b2FWd3VTU0ZJVGI4Q3Na?=
 =?utf-8?B?SGVvcHd5ZXJiVm0xR0thKzBMTDJDYXptY3FiTVhwcktCMkpPc3hCQVlFTVls?=
 =?utf-8?B?Zld5Q2I3ZWgvQzd3emlZV05XNkM4eGV2MnhESHdJeUZMRWRqSVdVZG1nanJm?=
 =?utf-8?B?djJRR25ad3pXWHU3Wng4Z3BldEZ6RDR4ek5Ya2ZCL3pvcllSeFJobWxNdHV3?=
 =?utf-8?B?NHdYYUxxMEpxbUtkcWUvcmpwOXU5NEoycFphV0pHK0dVZmJnQXE5d1F2Uysy?=
 =?utf-8?Q?glTJL0ZaFlLA3pHRKcY6UFRdUeL8x84p2VcP8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1hLZmd4eis0U1UxOGpzMkxPdGRpcXBVMXBhdHEwd1kyUnBWV2IrMmZQZWM5?=
 =?utf-8?B?UTZsM3hNL25uaEp2ajhWcHZHOFF6MzBlY2RoZFpxYXJMWU9HeFNmeTZwVlFk?=
 =?utf-8?B?b2JoQVQ3M0xMeE4wa1VZTVoxY05TVERXZGlMS0VheWwycmFmWjc5SWttSHVB?=
 =?utf-8?B?ME8vd0tOZ2Z2aEY1S1BWZ1NaeUs3amlWSTZqNnM2UHdMeEZxK1NURCttcmtT?=
 =?utf-8?B?S2w3KzN3a2lWZlBQMldBbGtCcFRYWVM0TGFWUlNEdDYvZjduT0xwWnNpVmZ6?=
 =?utf-8?B?VG56Q1FxWjlGLzdTd2RPQ1YrZHBDeHN6UVFTZDVwRjNOUkxMdm9RRXo4bzBx?=
 =?utf-8?B?SVZkZ2ljVTIrSkRnS0t3dHA5SWhVd0JTcjE2RkNxanhpZERXemdPejllQmc3?=
 =?utf-8?B?TENLWGllTEd3WEFJNVplaE4zNE83d3hPZnFLT2piVzdwUTM4b2F1aHpkQm01?=
 =?utf-8?B?UnZZOWNNZUdvMlJuUzQ3b2d5QytRTUZycU0zNTh3aG1LNUJpS1Zod1pYNzNB?=
 =?utf-8?B?TzgxMXVOeHYyMXpGK1kwbkVkb2VzbmE0TFQ1U0F4SUMrRlBRTFNxU2lFY1Yv?=
 =?utf-8?B?WWowOTcxNmlTTkNSbU5YOGRvZjdsV1ZjOVRVdkJjWnZZenhVRFdWVm96YlQ0?=
 =?utf-8?B?emdnRHZrSWlLQndPNnRXZUMvRzdjRDdwMWdRL1FKOUY4NE5VaWlybmUxYTA1?=
 =?utf-8?B?SkxxcHJrbUxzbytyNVhXMzZpeFA4eURkNU1JSG9CY3JyU3JqSzdkYVdGTzNL?=
 =?utf-8?B?V3pVeUkvVnptMFN0djFKREdnK0tkbU1hdW1qeGNoaGxPZGFJaE5oblg4NzZx?=
 =?utf-8?B?b2lLT1FBNmNLalpmZEI1WTFDYXo3bmh5S2lhRUVDYnJEMkJXcEVkZG5EOUE3?=
 =?utf-8?B?UStQU0krZUtEQjZ6K0dWaXQwZjhZb2MzbUFiY3NkcWlvc0x0a3ZjZEQzNVNj?=
 =?utf-8?B?eGpROVlsQzcxMTdOMHgzalVVZ3dCZXJCTEtydXBjUi9oVW9wWWtlVlVxak1W?=
 =?utf-8?B?a2VyNVNWbUFnSXo0ZXlyaTRzeGxBY292WVZUT0xiSDB2Z3YwRCtmY1VHeHNK?=
 =?utf-8?B?eDVzUWZYdyt5em12UUtvZmdEdVFpMkhJRjh0L2VuS2t1NlpvbGRqeGpjRTB2?=
 =?utf-8?B?QXF4N1RGSHJlZUpGekZhaXFweFJRUm4vYjZwUmtSMEx6WEREWWRLMTIzMVBn?=
 =?utf-8?B?OEkwWEVKbUJDWkZWdU1iaDhwcjRrdjI4eGVGY1d1L0ttV0hCRTNXQ0ZBc3kz?=
 =?utf-8?B?dWRKNWRxMFRzWUluVzA2dUx4RloyRHNBWktWWm1ydUFrclI5WW5SOUQ4UUlO?=
 =?utf-8?B?eFdWZTVUTVNFZ3dKQTdRbFc2QzdGTUpQWDAwUEVxVzNhNk9qMnh1M3NocUtn?=
 =?utf-8?B?QzJVTnJ4cU1IL3hRQTZsYmpmUjFjU2grVGFicTVVa1BTSDMrSEIvbXhrbjhv?=
 =?utf-8?B?WGVneDVuTFRTemVteHhiNHBIZ2lvRUtPWWdwM2JoRjJrNDJFelord1BVWWlK?=
 =?utf-8?B?am4wb3VoY2Fhc0RrZFNZNitQWlk2OU1DQ3VYVUpCUy9pZHdGcklTVjQreWtH?=
 =?utf-8?B?SlZEbWFKRytNN29zeDJiMDdVaFF0bENyNk9ydFZOZmRMYnVnc2NPRmhyTjcr?=
 =?utf-8?B?clJDVzdsaGI2TGlucERGRWY5MUIzYUZub0Rld2djNFRkdFYwL2dBUnJ1NHNt?=
 =?utf-8?B?TkpzV205dzhHR1oxZEdudnlMcDEzb1VrSTc3b2hZYnNuVnIwVXNyRm13blpp?=
 =?utf-8?B?UWFmUmFzOWJ6S2FwRENNQUNwYWtuOGQvd0VtazlBalpjYmI1QWVPTjRHU1Z0?=
 =?utf-8?B?b3k5QmM1a3JiTmlKSVZwd0p0YmZYVlQwOGZXVyt2YXRpM3MydlZzQkhkUVYv?=
 =?utf-8?B?SzR6QTJiT1Bsa1d4cS9vR1p3VmJTZzd3anQ1dlFQRnZ6dXp0WkFUR0UraWtr?=
 =?utf-8?B?aExlMXk3TFJ3MnZlODBqVkd0ekVkQzgzTk5abW1wem1kSmdoN0d2S1YyNkpr?=
 =?utf-8?B?a01EbSt3QVlvOXdyWHlFcEh2T3puQlhUZm95eG5kOTlOM1pNT3p6MzhIZGZ1?=
 =?utf-8?B?VmQvUjd5UStJTnkwQlB3R2dDSFpneEhmL3lDUUVtZ0lHZ2RUaithM2prbkpB?=
 =?utf-8?Q?MAUmOY4wpjDNABTwyxfx5Uhb0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7063b96-69c3-4074-3eea-08dc6fc15921
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 00:45:39.5607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e84Ylbiz+qzaxQG9W2gyaQWgQXrwWn+/lQukJJXphu9JL32P5MGDXzXPSRPsoNhqb/m/YTcPbH++WyVpvcva/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8273

The Security Violation module requires below System Controller
Security controller API to interact with SNVS block via SCFW
    - imx_sc_seco_build_info
    - imx_sc_seco_secvio_enable
    - imx_sc_seco_secvio_config
    - imx_sc_seco_secvio_dgo_config

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta<horia.geanta@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/firmware/imx/Makefile         |   2 +-
 drivers/firmware/imx/imx-scu.c        |   4 +-
 drivers/firmware/imx/seco.c           | 216 ++++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/ipc.h      |   1 +
 include/linux/firmware/imx/sci.h      |   4 +
 include/linux/firmware/imx/svc/seco.h |  69 +++++++++++
 6 files changed, 294 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8f9f04a513a8..b53d2dee8ff3 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
-obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o seco.o
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 1dd4362ef9a3..c96dc73689a8 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -242,9 +242,11 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 		 * APIs are defined as void function in SCU firmware, so they
 		 * should be treated as return success always.
 		 */
-		if ((saved_svc == IMX_SC_RPC_SVC_MISC) &&
+		if (((saved_svc == IMX_SC_RPC_SVC_MISC) &&
 			(saved_func == IMX_SC_MISC_FUNC_UNIQUE_ID ||
 			 saved_func == IMX_SC_MISC_FUNC_GET_BUTTON_STATUS))
+			 || (saved_svc == IMX_SC_RPC_SVC_SECO &&
+			 saved_func == IMX_SC_SECO_FUNC_BUILD_INFO))
 			ret = 0;
 	}
 
diff --git a/drivers/firmware/imx/seco.c b/drivers/firmware/imx/seco.c
new file mode 100644
index 000000000000..2d6bf301ac87
--- /dev/null
+++ b/drivers/firmware/imx/seco.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020, 2024 NXP
+ *
+ * File containing client-side RPC functions for the SECO service. These
+ * function are ported to clients that communicate to the SC.
+ */
+
+#include <linux/firmware/imx/sci.h>
+
+struct imx_sc_msg_seco_get_build_id {
+	struct imx_sc_rpc_msg hdr;
+	u32 version;
+	u32 commit;
+} __packed __aligned(4);
+
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit)
+{
+	struct imx_sc_msg_seco_get_build_id msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_BUILD_INFO;
+	hdr->size = 1;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	if (version)
+		*version = msg.version;
+	if (commit)
+		*commit = msg.commit;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_build_info);
+
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc)
+{
+	struct imx_sc_rpc_msg msg;
+	struct imx_sc_rpc_msg *hdr = &msg;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_ENABLE;
+	hdr->size = 1;
+
+	return imx_scu_call_rpc(ipc, &msg, true);
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_enable);
+
+struct imx_sc_msg_req_seco_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data0;
+	u32 data1;
+	u32 data2;
+	u32 data3;
+	u32 data4;
+	u8 id;
+	u8 access;
+	u8 size;
+} __packed __aligned(4);
+
+struct imx_sc_msg_resp_seco_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data0;
+	u32 data1;
+	u32 data2;
+	u32 data3;
+	u32 data4;
+} __packed __aligned(4);
+
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size)
+{
+	struct imx_sc_msg_req_seco_config msg;
+	struct imx_sc_msg_resp_seco_config *resp;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_CONFIG;
+	hdr->size = 7;
+
+	/* Check the pointers on data are valid and set it if doing a write */
+	switch (size) {
+	case 5:
+		if (data4) {
+			if (access)
+				msg.data4 = *data4;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 4:
+		if (data3) {
+			if (access)
+				msg.data3 = *data3;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 3:
+		if (data2) {
+			if (access)
+				msg.data2 = *data2;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 2:
+		if (data1) {
+			if (access)
+				msg.data1 = *data1;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 1:
+		if (data0) {
+			if (access)
+				msg.data0 = *data0;
+		} else {
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	msg.id = id;
+	msg.access = access;
+	msg.size = size;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	resp = (struct imx_sc_msg_resp_seco_config *)&msg;
+
+	/* Pointers already checked so we just copy the data if reading */
+	if (!access)
+		switch (size) {
+		case 5:
+			*data4 = resp->data4;
+		fallthrough;
+		case 4:
+			*data3 = resp->data3;
+		fallthrough;
+		case 3:
+			*data2 = resp->data2;
+		fallthrough;
+		case 2:
+			*data1 = resp->data1;
+		fallthrough;
+		case 1:
+			*data0 = resp->data0;
+		}
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_config);
+
+struct imx_sc_msg_req_seco_dgo_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data;
+	u8 id;
+	u8 access;
+} __packed __aligned(4);
+
+struct imx_sc_msg_resp_seco_dgo_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data;
+} __packed __aligned(4);
+
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data)
+{
+	struct imx_sc_msg_req_seco_dgo_config msg;
+	struct imx_sc_msg_resp_seco_dgo_config *resp;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_DGO_CONFIG;
+	hdr->size = 3;
+
+	if (access) {
+		if (data)
+			msg.data = *data;
+		else
+			return -EINVAL;
+	}
+
+	msg.access = access;
+	msg.id = id;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	resp = (struct imx_sc_msg_resp_seco_dgo_config *)&msg;
+
+	if (!access && data)
+		*data = resp->data;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_dgo_config);
diff --git a/include/linux/firmware/imx/ipc.h b/include/linux/firmware/imx/ipc.h
index 0b4643571625..df38ab8e7e2e 100644
--- a/include/linux/firmware/imx/ipc.h
+++ b/include/linux/firmware/imx/ipc.h
@@ -25,6 +25,7 @@ enum imx_sc_rpc_svc {
 	IMX_SC_RPC_SVC_PAD = 6,
 	IMX_SC_RPC_SVC_MISC = 7,
 	IMX_SC_RPC_SVC_IRQ = 8,
+	IMX_SC_RPC_SVC_SECO = 9,
 };
 
 struct imx_sc_rpc_msg {
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index df17196df5ff..947e49d8bebc 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -15,6 +15,10 @@
 #include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/pm.h>
 #include <linux/firmware/imx/svc/rm.h>
+#include <linux/firmware/imx/svc/seco.h>
+
+#define IMX_SC_IRQ_SECVIO            BIT(6)    /* Security violation */
+#define IMX_SC_IRQ_GROUP_WAKE           3   /* Wakeup interrupts */
 
 #if IS_ENABLED(CONFIG_IMX_SCU)
 int imx_scu_enable_general_irq_channel(struct device *dev);
diff --git a/include/linux/firmware/imx/svc/seco.h b/include/linux/firmware/imx/svc/seco.h
new file mode 100644
index 000000000000..508444c02d39
--- /dev/null
+++ b/include/linux/firmware/imx/svc/seco.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2020, 2024 NXP
+ *
+ * Header file containing the public API for the System Controller (SC)
+ * Security Controller (SECO) function.
+ *
+ * SECO_SVC (SVC) Security Controller Service
+ *
+ * Module for the Security Controller (SECO) service.
+ */
+
+#ifndef _SC_SECO_API_H
+#define _SC_SECO_API_H
+
+#include <linux/errno.h>
+#include <linux/firmware/imx/sci.h>
+
+/*
+ * This type is used to indicate RPCs/RM/SECO function calls.
+ */
+enum imx_sc_seco_func {
+	IMX_SC_SECO_FUNC_UNKNOWN = 0,
+	IMX_SC_SECO_FUNC_BUILD_INFO = 16,
+	IMX_SC_SECO_FUNC_SECVIO_ENABLE = 25,
+	IMX_SC_SECO_FUNC_SECVIO_CONFIG = 26,
+	IMX_SC_SECO_FUNC_SECVIO_DGO_CONFIG = 27,
+};
+
+#if IS_ENABLED(CONFIG_IMX_SCU)
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit);
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc);
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size);
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data);
+#else /* IS_ENABLED(CONFIG_IMX_SCU) */
+static inline
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* IS_ENABLED(CONFIG_IMX_SCU) */
+
+#endif /* _SC_SECO_API_H */

-- 
2.25.1


