Return-Path: <linux-kernel+bounces-241340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778A79279F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A591F2617A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D59E1B1415;
	Thu,  4 Jul 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="m5cgBpvT"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2120.outbound.protection.outlook.com [40.107.21.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710861AC252;
	Thu,  4 Jul 2024 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106626; cv=fail; b=MyCGY6rVDP4qyegRnHFci/0Sot7ZpqGpzQFnexZ5AEKDPbQYW9ufpqOOnGVRZWcUQ86rn1L8L0ZARm9kg9MLgWuhw96M8LRFHoLQAPuKKqCkvexE0ADb5jf1yMD2YQtJ6eljzBI7kEmbgmLzLNKzYWlS9sTJKK2UIgeg3ZhAZ/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106626; c=relaxed/simple;
	bh=y/BMKg9qkc78GP4f78Xf4oU8zVffFP+i0ySAljwKdlk=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=eOvE8q80lJoIJs63PwU/N+vQfvDJmtzr+cUVBvl0HxuYaULbU+ICHridlMi3otYDJnk2QMcjfIS4qcX771ovS2HsC5wjNSS//lwQqLj06QRdJYD/K5/JMBNaeUTqWbfKgBYEhNK9uk3J/xi5iz9Dc8RTZp5lbb7jLMomCDdm0n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=m5cgBpvT; arc=fail smtp.client-ip=40.107.21.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBFAD3VxrAgfebR+S9Dldr4TGJ8CnCLmCQDnMjB0loHXrgecEW8UhROECDALi5vPIXyjajqpZz8fKi7e0xIE4h5eEGUTt7wA6VgqaxMmWb2SCKLYEege4YFhUz/fKYgUi6Q8xkEYPjWoFflNvJ/NnU/fJlxw1W5KJkAFes072GVUz4eDIQ7dbZDJSAU3xtjaCAeIjmy+NwX5Rfkh0OSMDA8s48lvhDmb/t1Smp9UKP6d7GdtlkXze5sudZ7hmncm9ROLJCSACC2yWCHXlyoNFfQK8FoKghMz6Dh6MHrTi9W9cN5wrS45xbnmlAJ6e/9FMH+13qak3Z2bFMUJSeadWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfkfFgrB23A2GZ/3PtMWi/pCsUJhwZCVPbN1zsPZWI8=;
 b=Z6GbsTqjuq/sCLOPwCV8kdSS08QoIIWBXX36FWJtrUVtigH330GHYFrT+QsQwyhL208EaAa5Yx/PzAag+eaR0MagBIqApcWIrNouSlWFj48epqTM/uQ1nUnQJegVMrCOdscKC/kFPdgFtBTacTQtRk4zf2UKNoXjg9wYlciXQ9tqpyX8To+RYeWNu7ztiHiIXUY4WRwALvzilLCmXb60tqPZQYnz6KjYF1FBuy88DKQbmOmCpohanErXxBYa72OkBh23JL+WNZITDFDMJukQNYlkfY75S0Z5N66E+UppUU86miyMyxs79uyPhA2f+Cgu8KOtyLCUOB0TfwcUgkCB3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfkfFgrB23A2GZ/3PtMWi/pCsUJhwZCVPbN1zsPZWI8=;
 b=m5cgBpvTfkdLPaVv8zi+vEH+LqSfgG2otz4Cr4J1szwr+pa+dGNvycmb3HcQjtTLIjtW3bNbNUhCpxxW11jN6IN8pQgVL7m8G/T6SHldvK6TLJDGFXu8kT/I85FsQbGqQVzBhDNj1dkbYEAcy0kTaz88NzFhZcoHsgV9X6im/II=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI1PR04MB9786.eurprd04.prod.outlook.com (2603:10a6:800:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Thu, 4 Jul
 2024 15:23:39 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%5]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 15:23:39 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jul 2024 17:23:38 +0200
Subject: [PATCH] arm64: dts: ti: k3-am642-sr-som: mux ethernet phy reset
 signals input
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-am64-phy-lockup-v1-1-4a38ded44f9d@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAHm+hmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwMT3cRcMxPdgoxK3Zz85OzSAl1DA/PURNO0tEQjIwsloK6CotS0zAq
 widGxtbUA9BxJm2EAAAA=
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::17) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI1PR04MB9786:EE_
X-MS-Office365-Filtering-Correlation-Id: d3dd612b-0314-4dba-d41c-08dc9c3d481c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tk94UzF1T0FvckRCZXcxd3RHSUtFeXRoK2hnYU5FVVE2NEFYNDB2YVlSNUVw?=
 =?utf-8?B?Y2NGdXk5U3pvVi9YVTdoMGhaa2t3TGs4V3d4cERGcUJOTmJuVjQvOWJUUDNI?=
 =?utf-8?B?MEdSbEloMFo3MWlMRm52ZlFGZDA5eVFKMElVYjFZNjZ3ay8rTlpucDF6RkRr?=
 =?utf-8?B?aTlNRzd4VjFYcTRuL1FMaUNSbkpLbHJRbktOSHVqK0NUaWJEZFRFMEpHWFVJ?=
 =?utf-8?B?SFNQcDQvNUNEWUVScnZYOVZoaG14L1YrTzA4UDRXMzNES21GcjY3TXY2REhn?=
 =?utf-8?B?dUkrdmxySjg2UloydjludkQ3SlBzTUMzemRvQkxTQllycGozSFBTV0V1NUJC?=
 =?utf-8?B?U2ZFck8vdi9zc0xZaHVnMVU3eDc3aXdwVGpOV3kzdCtDV3RlSjYrcEgxNlhS?=
 =?utf-8?B?bG5xZHpTMmNSc0hUK3FUV1UxekpubklONmgwem95VDJmVHZQUkluckxLakZO?=
 =?utf-8?B?Q3NWMzd0NjJhSXR4dm1WQW5nQ2pvTUsxQTRhR254QTZhaWUyS0l0T0ozbFpn?=
 =?utf-8?B?QU0zSXFsZzQzR1FsMUN2ZFN1VTFCa2pmSUdpQ2IrTm5GK0oyUHZjT1pNQUQ2?=
 =?utf-8?B?NXZ6OVZycUFkOTBpd1JwZ2RWUEo2OW83Q3ZoMG9jUmVBMjU2Nm5wSkN2bU0r?=
 =?utf-8?B?c3RDaXFVVDAvdCs1SVRLd3IxbFdXekZONzRvazFZR2dYL2FmY3JFbXNNaWIz?=
 =?utf-8?B?NnZDcEZ3K3ZwSTJocGVOd2g4MjJ6QWZTbE82ZVp0UW10N21BRUttcFF0MDRD?=
 =?utf-8?B?V2NtNFp1Sm9ueSs0MWl1b2JaeTNtSGkwTE02OVdZbGdZOTBRUjh5bGhxZDQx?=
 =?utf-8?B?OXRna2ZTR2dubEUwSnBhNWdlclVqcUpoclMrVEVNa2hrMHdZUFpqMEJyREVW?=
 =?utf-8?B?MFdSUXhBSUV5c1V5blg5bDFHbS9mbW8yRTB3VXNlNzJicU82V2tZR1h5cGZU?=
 =?utf-8?B?RE9BMUlkUGpXTHBvaWR5ZUY0clB6NUt2ZlUxenpaVjB5T1V1WWNZczY3cDFY?=
 =?utf-8?B?ZDdMcmhjSWUyVWM3Z2s4RVVDekwzZS9yZTFaMUNWRUFPaXd4R0p4SWRIbEQz?=
 =?utf-8?B?cXZEOGtIR0ExSm9heHNXdEh1ZDVTY3RvRU9LUkxoUWxuQkRiUDk0ekJwZUFP?=
 =?utf-8?B?YUpvTVZweHNsWkg5dnlrZnovNVlVL1gvaDJrS0NHckJkNk1nNEFTU1VYMjJG?=
 =?utf-8?B?NDZhKytTV1RsVGdFVVpkSkQxUmpoQlN5OTRCaDN3NmdTamFsRzlXTHV6WU54?=
 =?utf-8?B?djEwcE5ERS9nRFpkY1JQOXV1THI2UDMwRVB0aHJKTkJjM2IwWjlPYU9kMG5r?=
 =?utf-8?B?ekNCSGlxZjFmVGFFOTZnL25xa1RHWlFKUUlINU0xTmIwMEdXZ0JwelVYQWww?=
 =?utf-8?B?b3V0bzduZEJ0ZWlRN2tEdTdianhkOFFxMlRhekFYMlhlQzNlL0d6aDNpT2Y2?=
 =?utf-8?B?MWFwSUpkTzNNL1VhTlArQXA4OXNBR204dkxOZ1Y5TCsrZmN1Wk1zQ3lGc3Jr?=
 =?utf-8?B?c01iNUwrbmk5eUZ2Y3FtV1FENERZRzFYVk43dVhsdXpxc01uNzFjbEhTMlA2?=
 =?utf-8?B?Mml1ZzE2dlRIQWRMclI5L2NBcTUza3hsRExLT1RVZWpJTE9lUC9DQWlBS29u?=
 =?utf-8?B?L3VZMCtRckk5eDZsa29qVDRULzk2SHVkeWhiQ2dya3pPVjI1RlhCR3FNa0hp?=
 =?utf-8?B?NVZFcElzcTR1dWs5dWNnaXpNQS9uWi9TWEx4OHk1UFQyMWRaMnJHM3ZHcDZa?=
 =?utf-8?B?NVJrcHBpSzlSZnNtd0pVNHNTUElOdk9IcHVXdW1EMjBEMnZVNUxxRjc5K0x1?=
 =?utf-8?B?OXd2VlRhY0xVRU45VTFuZlNVVWhobHdxQlJacEUxcG81c2VpNTZ1bzMrY3pa?=
 =?utf-8?B?MVdyWXdnQkxiOEw5bUdkNmZjUEVwMzhDeEczZHpvRUJtTWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnhKcTlNcjVhd1RqYzBPMVlCeE9XYThvOFArZlhEMFZKbi9Qd2lqMnZqSUoy?=
 =?utf-8?B?ZVR3Z28wbEdnbkg1YmJvdEhFbElRSS9lRzhFSVJucVFkMENVNm9SakUvbU9m?=
 =?utf-8?B?alNzNUtlRUxDRW9YUzVxNkhkS08yK3FRQkhsWU1aVlZ4aFlqeHAwR1pFcERy?=
 =?utf-8?B?a005SHRwN0gxMVJBMTBBU2x0cG9ibWxrYnVlLzFHMGkrMXpCZElEQXhZcVJO?=
 =?utf-8?B?N1ExSm5PYTZHMjJqUU1JeUw5czBMdmFaaFBHc1ZQZXhyZjcvWWU5d0tqVWIv?=
 =?utf-8?B?ODgzMVRZUFpnR0RqUVJtQ1g2dDFnaCtMTjU1NllML0k4RGVFMXhtZkp5SVdX?=
 =?utf-8?B?Y3I0S0ppejJJNW9SV1VyTVhBWVhXZ1Urd1NJSUIxbVNlVWQ0SnkwVnVBNWZL?=
 =?utf-8?B?UzE5ZEVFUnpHV1V0UXkwTlFlNlZLb0tXREZKanZXVGx4R0U0eWIyV01OL1hO?=
 =?utf-8?B?QXhQaVpZeDV4WEZZcXprMjFXc1I5WGJLWFRJZWJ2US9oUUxWNk5yUHBLaitZ?=
 =?utf-8?B?MWlla2g4eWJYcjk0ZWhDVGhnZXlPU0x4TjBhc1VnQjNtUG4wWHFvVU4zT0pl?=
 =?utf-8?B?dUFkalArd3pZSlYyZVZ5dHhDNmZxSGN2WHh2bUFYTDB1bTMyNTBmZG54eTZE?=
 =?utf-8?B?dWZmbG9lamRRQkJ5YVdacTNsQWwxWGY3U1F4Z1VmTnd2KzBnbHFaMzFkZElR?=
 =?utf-8?B?bVo2NWRvWWc4OUNxbzRmQVNWSXA5R0haUjNSMzViU0k1a3lyeWhSN1Axc0Fr?=
 =?utf-8?B?Z0dvWU5Uck5VTCt4R2hvMDJLYVZ3RjNrZXJBT2VaR2RkSGFNQ0o2TnZmN1k5?=
 =?utf-8?B?a0JOMFZuNFlaaDhYWkp0N2xxMmwwRnRvSWdsVFM1a1Faekt1N2RXUnA3ZDdG?=
 =?utf-8?B?QWo3SEhCTDQyWitON29iMUhrSWVnSWdJcXNTcnlCZTJzaHdrMmViUGdqc0Uy?=
 =?utf-8?B?WTRvS3BtN0wwQjdFZWk2Ymt6SUc5OFYyU3pxUk82SGpUZG1yWk9GajBYY1My?=
 =?utf-8?B?bVIrcDdBM1dPRzFhbnNpSjU0cExoN3RqV1MrS2N5eS9TNWY5d3ZlL2xuMjRj?=
 =?utf-8?B?ZVJYRk5wYzIwaEhPQ0V2NmF0VmZJYVJRMDFOa1FTeW5OS1hkbVlNSHAySGg5?=
 =?utf-8?B?VjA3UkZVRVEyWEVGQjJIbSt4MjgxWFdIWGNiME9zZ2UxQ3M4R01UKzdzK1Nn?=
 =?utf-8?B?VHAwcmpOWWttckkzbzRjNU92MU5wTnNTM25ERXdsUVZYYU1aWi9YeU1CM1pZ?=
 =?utf-8?B?TjZaSUQ4THduYjZBbFdkTjVEY0hXOVlEYVFpY05HR3dyYWVLdXpWdzF1MjMz?=
 =?utf-8?B?TTBJTm5sSDZQRlBIVERISkNFeEhhZS9mTktBSGx6aC9pZEJFdWpZaUlDSnZS?=
 =?utf-8?B?RjdGZkNWZ2FXTmYrYUFRVVZibW9MT1RId2NwbW1PZVdyb2ZxM1hickt0NDRL?=
 =?utf-8?B?elVlRTVBbWlwbUFCZDRrUEtOa21BeGx2Q0lzTjBWT0w1bnFIYzFhQm0zeFBB?=
 =?utf-8?B?cmlUZG9BeE9tN1ZibGc4Mmc1WkFMUU03V3JReTU0T0g0eEdlT3U5QXdFTVAz?=
 =?utf-8?B?K2FEYUtxWld6ellpU0k5TGl0N04rcm8rZnFqdWNWMlVycVV4aHRJaEs0NFRi?=
 =?utf-8?B?VWxsVVNjNXFLT29hQklqVHZDaGNWR3B4WktPRENkZzJYUjlsQ2dYOGZtSDJm?=
 =?utf-8?B?ZGdwVEUrQ05wSVBUQ01GWlMrRVBRa2pLaE5wOFdZY3hCWFIvTjlCb0tKS0tD?=
 =?utf-8?B?TGpiMTA5cXk0djVBN09mK0N0dUk4a2xHWWhHK1hNRjMrdHRJWGhSWWFTTTd6?=
 =?utf-8?B?RlBrSENERnpOTkZESDlpdVJzbXhFSFdxMGpISHBjMmdEb3A5WVFhM204TkNh?=
 =?utf-8?B?S0NobzA5YmgyTHpsTUZXaFh3RCs3N0UzNERlTkpTUXZ5bTNSSDlrVjVtUkFw?=
 =?utf-8?B?S2xObWJ2c2R6SWZmaWczMTBKNHdkajNmeVhxMkVKZFl4aFo3TEZqbnUrVll5?=
 =?utf-8?B?T1lMRVJvNVFQcTRrakdPeThSZFZqb0J6Q1hiM0dDb2JCWndaSkExNlRsZEpY?=
 =?utf-8?B?TjBUbzhQc1RqbmhpdWtkVjlMQWp2bllKWmpaa05GSFd6STJyNE8rTTVlNldN?=
 =?utf-8?Q?x6EFiMffexTsQXBd1d6MQEVYC?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dd612b-0314-4dba-d41c-08dc9c3d481c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 15:23:39.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+7iSWFITMRjwQaPmMG6h996cfsaW5YwyYZmjdL9OqyGFxj/3gymdQ3Q2B4D/jJ1jdU3ak03Kd/8x+exZep3FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9786

Specifically on AM64 SoM design, the DP83869 phys have a chance to lock
up if reset gpio are toggled. Update the pinmux to input-only, strongly
enforcing that these signals are left floating at all times.

This avoids sporadic phy initialisation errors mostly encountered during
power-on and reset.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
index c19d0b8bbf0f..b1f06071df4c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
@@ -320,7 +320,7 @@ AM64X_IOPAD(0x0278, PIN_INPUT, 7) /* EXTINTn.GPIO1_70 */
 	ethernet_phy0_default_pins: ethernet-phy0-default-pins {
 		pinctrl-single,pins = <
 			/* reset */
-			AM64X_IOPAD(0x0154, PIN_OUTPUT, 7) /* PRG1_PRU1_GPO19.GPIO0_84 */
+			AM64X_IOPAD(0x0154, PIN_INPUT, 7) /* PRG1_PRU1_GPO19.GPIO0_84 */
 			/* reference clock */
 			AM64X_IOPAD(0x0274, PIN_OUTPUT, 5) /* EXT_REFCLK1.CLKOUT0 */
 		>;
@@ -329,7 +329,7 @@ AM64X_IOPAD(0x0274, PIN_OUTPUT, 5) /* EXT_REFCLK1.CLKOUT0 */
 	ethernet_phy1_default_pins: ethernet-phy1-default-pins {
 		pinctrl-single,pins = <
 			/* reset */
-			AM64X_IOPAD(0x0150, PIN_OUTPUT, 7) /* PRG1_PRU1_GPO18.GPIO0_20 */
+			AM64X_IOPAD(0x0150, PIN_INPUT, 7) /* PRG1_PRU1_GPO18.GPIO0_20 */
 			/* led0, external pull-down on SoM */
 			AM64X_IOPAD(0x0128, PIN_INPUT, 7) /* PRG1_PRU1_GPO8.GPIO0_73 */
 			/* led1/rxer */
@@ -340,7 +340,7 @@ AM64X_IOPAD(0x011c, PIN_INPUT, 7) /* PRG1_PRU1_GPO5.GPIO0_70 */
 	ethernet_phy2_default_pins: ethernet-phy2-default-pins {
 		pinctrl-single,pins = <
 			/* reset */
-			AM64X_IOPAD(0x00d4, PIN_OUTPUT, 7) /* PRG1_PRU0_GPO7.GPIO0_52 */
+			AM64X_IOPAD(0x00d4, PIN_INPUT, 7) /* PRG1_PRU0_GPO7.GPIO0_52 */
 			/* led0, external pull-down on SoM */
 			AM64X_IOPAD(0x00d8, PIN_INPUT, 7) /* PRG1_PRU0_GPO8.GPIO0_53 */
 			/* led1/rxer */

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240704-am64-phy-lockup-107ea5ffa228

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


