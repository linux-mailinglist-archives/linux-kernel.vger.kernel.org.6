Return-Path: <linux-kernel+bounces-368420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D382F9A0F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87FA1C22F80
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44802141CC;
	Wed, 16 Oct 2024 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oChTYEXC"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184F213EE7;
	Wed, 16 Oct 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095830; cv=fail; b=AdotacTrmhsg4jcd/GfNJOZmXwmRsBbgGfiCerulqeYPzWw1+Bg9F5fmnZvJuLxiBSp2FySzNdEaXH0phksrNCcdIWeML7DUsm1kyW9VQyYohWSJP/kDWqgwS2nfGVCQRwY88Sixhpn9bk6c7Dp6IGLMe6l3m41fntiIkv1BywQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095830; c=relaxed/simple;
	bh=xWgDpdNSCn+E+vZkwmdFHphGMaJ5PhzTrqsP91jNJ8s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HnxCbsHLuabGHL0ehEAW/dcQeWiVONl9Hi8AY8HZT5bLPJzCgPvt0fmAKWltZKvvJDSc5lhGp6JUWBpAfM8SiPLTt1RCDdw6Q8BhvslO6UPnparXVIfXm/JZEDAMlzhRqcC0SpPLcUO3t83X61KpjynFaBgUWiOA11y+S787uTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oChTYEXC; arc=fail smtp.client-ip=40.107.104.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWDxLvo5HMmVz+8VX6o/EyRC/F7Azx3NzLYX58eK7afsUMiiBQFmnr+x2S3yCwWbu+t2VQ4/vbulZX5foO0XiYhBLn32bKKWHhZW1XLtZ6RnaFYeeCJPOQ55whFR5uixwoUM87XfTwOzepGTBj5De8p2jI/UguKeprs43kcvTBiWvETkAaAg2sI8yvww6uQ6GF0mBQ5ji3qOte31Gv9lGjF1gBjQcSstN79okAsoPikO93r3CmjVFNWtUELnkLVXhECdnp3GZ+fhVun1cXDtg0ta3jlX7To9O01HKNERuViPqF8R0aibHTMGDdWPgfaWOhO/L04c4uiauZM06REGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BvO9qJPX/lBcUMzwlmpeM3J0Ez2h4HC4nr4GbH0qOA=;
 b=MUS+ZdSBarZlYC7HM1QoNVfFnZsbYs0uZ+doPZm0pF3u+wFMb0+GQUNzYs6s3LvWwU1Bn4w9J8qmcSsAOBUfqNQphCWhwhpbHguv9uqOKPD9yaiYNpf52CaOi9O3pZE/sFF4I+WqAej2vsmyRJygZ+OI2M7iCngAI7NPlY6iHF/pZAHCepqmMfTzuXEkO145ZEU9DfLnvoDl4bp6vgzsfSF9dqPTv9VYuo0O19DC8f6FGhTFHaxeYIbH5lvJ08pak6pjxyTWZ6PmhAID90Hfbw+gXAyeF5GXEjGd/PwvHQFJqxJt4e0HFKd7D+eCRft9EfyyanuvBVBemKd5SUb6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BvO9qJPX/lBcUMzwlmpeM3J0Ez2h4HC4nr4GbH0qOA=;
 b=oChTYEXC6uSBNx+MCnwPE+v2jrUZwmD5A38FmOYNjnMuMD+zUCB7sgmI0YgVEotMx2jIjbKKLAiievchbDqhvpXYmGqoTNdFfaW6gRxAiA5buNbc8YizOqOhsu/y0717bvJiZr3Uazalb8X2PsOw1NAGSvvcot3P+WfKrSJV6V5EChcwe6y9vV09mPQ2bhwqQ6cs8D/JoGDtnUJAj7/QtjE9mKQCpWYQr9seTkemV4ByBf7GafuwZzn/qOUnqMm4ty9WAErMpj9WuTrisQlIrj4euXV7qwIgGBtIwhj3TpqW8xZKVYB0RERb/PmMlMCA6+mE4HeTnuOmfLcgp5RbNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7)
 by AM0PR04MB6884.eurprd04.prod.outlook.com (2603:10a6:208:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 16:23:46 +0000
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72]) by DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:23:46 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Wed, 16 Oct 2024 21:49:02 +0530
Subject: [PATCH v9 5/5] firmware: imx: adds miscdev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx-se-if-v9-5-fd8fa0c04eab@nxp.com>
References: <20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com>
In-Reply-To: <20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729095547; l=36725;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=xWgDpdNSCn+E+vZkwmdFHphGMaJ5PhzTrqsP91jNJ8s=;
 b=653KXwvR+s3IrGoGILPlNhFxjxgedi3pUjza/lgGUA8fncvw9Larj/BdJ0i45Iqk3YNLJM3U0
 k58W2jyw8zmCysTphtFL2l/ngep/tZ4IOTNAA4dA52mRAqQny3fBX0k
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To DU2PR04MB8599.eurprd04.prod.outlook.com
 (2603:10a6:10:2da::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8599:EE_|AM0PR04MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2da472-791f-4a50-cd25-08dcedfee893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MStvMTZNaHhNdXFDZkQ1VWI4UVk5THU3U05wNVUzc3ZyYlF6eDZnS0dsUlRv?=
 =?utf-8?B?Y3B0TEZpNVZMdkY0Z21XTFJ5aWtCSE9ObnNUSEdGUGw4dlduSzcyTHpGQWpq?=
 =?utf-8?B?NTZaNjZ2RUJpeGMrTnAydUNhV0lJUSt6VlpKT3VJOHIxWXREc29ZT1U5UkZP?=
 =?utf-8?B?T3QvdGwxeWlyVHdxYmExRUVoNDFSZ21XTC9QUDljaUF5Qkh2OHNOS285Mm55?=
 =?utf-8?B?YStvc2NPZ2xacXFUWUUwRDNSS25hcHo3ZEludnM1MzFXSS9UNERrYzRkd2JX?=
 =?utf-8?B?cUNvS29zMkxjdklpUFBkci9VRWpjK0lsR2l3YnYveVc1TW84QTc2YlZJVDRX?=
 =?utf-8?B?YVVPS3ZzblByNTY0M2ZjRkxkaXhkU3dKb2kwclVJTEdlSUV6Q2ZOa2YzaGZj?=
 =?utf-8?B?ZnFmbXJ5UmgyMllHZ1hUWjBqUnlPdmwzU3RSSjgwTzFjVWpRd3hVUFFFSXlu?=
 =?utf-8?B?TGErbEN5RWN6NkhXOHk1RUdPWGpBZll3RnRiMjg2NGZEN2l1d2tKSHl1WVZh?=
 =?utf-8?B?WC9ITFB6WFdpSlhKeDdYNGdYZmZuWjhyUGptc3hNMEFmZEx2ZWxPMmwwSU40?=
 =?utf-8?B?T05NVllCa1ovYUQwY0pDSTdRTWhpdEhNRXNkNGxpTlVsanVRWk1ZOTJxMHRv?=
 =?utf-8?B?aVlRR0xDRzFVRDlSRkhkaGIxS09tK3J3NXYxcXVGZkZFdXB5eWExSUIvRzRk?=
 =?utf-8?B?QUFQODk2aEF1RXBOZnBrb1RpVlMvaFNWWFo5KzZ2L0sva2NZU1kvUVd3ZVJN?=
 =?utf-8?B?ZWFrRWE1bXVnZEVsY1I1cFBSMjcxTDVpUWlQSlZEVDlPY3dRMVdOUjAxWGIw?=
 =?utf-8?B?MVNodU5kRVB5ZUlXZFpuY2ZNL1VsWUlqRXFmcjNsNWErYTBHUkdGSVE1WXJP?=
 =?utf-8?B?clNHTEhIdnVJRjBTRnpIVDhkZjdGcjNYT2dTMHpISGw0bHNOSThDMUs3STJs?=
 =?utf-8?B?MTVIZHlZN1ZGQWVGSVFkaThRM2x4ZWw5YWs4Z3E0RVhTQ05FSWRoUTJWVTNx?=
 =?utf-8?B?YlhRZE5RU3MwdXR4VDQyOW1ZaE1aa0JpVUxRYXBhd25RbnBoc3pwL2V6b2dk?=
 =?utf-8?B?Njg0cXNFTERYcGdlYVJjT3djWFV2UzFWRzJLTUxHSWlSODRhVVV1ZXRTbnNR?=
 =?utf-8?B?aWxPWHRaMWIweTVNV2xLMHYweEd1Ui9pL0VhREswNHBGOVExdlhNb29iUm5v?=
 =?utf-8?B?RDI2cEYvYTljUGU0TjZGczYva05TM21OZGRZTmdxcFI1UFlOWXV3ZVhibGho?=
 =?utf-8?B?YlRTcjcyUlpxUUpJclB6dllndTNBYUx4Y2VJT2h2WTBiMEpKeWpJN1pyRzFR?=
 =?utf-8?B?d1psd0tkR3AxYWZrdDk2eW1ldnJ5QVJCTFdYd0JyZ2p1YlBNSTJ3cVhCK2Rv?=
 =?utf-8?B?REpTS3NsTlVKbmg3RHBCSlpUc1ZJeHJ3cW5LSWZSUkVZMXNPUENqaEpGd2ht?=
 =?utf-8?B?Q0syem9HdktKcDgxVEdhdmx3aUljTjMxaHE1MmNGd0VrZW91b3JYTjJ6NTFv?=
 =?utf-8?B?Nzd2R2ZPTnRmdFRZdUhaV2luWDMybjhScUNMQXNKckVoZFMyMDlqZTV0UStM?=
 =?utf-8?B?Y1lBYm44c3B4Z0NwdFVRNVRIdFVsUW93U3FtMGhPM0NORDdIci9LYzd1SlJY?=
 =?utf-8?B?K3h3cnBKeFZ1ZmYwNGJmUDl0TFVPUTZiWU90OXlnOU5zT21tWkZVMlMyYTE1?=
 =?utf-8?B?L0pqNDhkR09jbnNtV0t5UlFBbFF6TC92UDJSd0RhS3AxRXovNWxxbWpPUmMz?=
 =?utf-8?B?aGtBRnRiZHl5MnlZNFNaR1l4d2Nqamw0cHVXRFFiT21DbkVzSzR4bllTV3JR?=
 =?utf-8?Q?wX1kU5Y8JTh0GhAJNv/JAeDbMiStAHlBb9uJc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8599.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHRJckpKZmd4U0MxMU8zT2RrTG41U3AyTnlTeWJNMzZ6TmR0c21EeWVxTWRS?=
 =?utf-8?B?Tkxnc051TVF4M3FjWEZ2Z0pNVHh2bUpuVm1zM05Sa2Z1NlZucGhRRCtPV2lt?=
 =?utf-8?B?WURNWEFzNm5FZ3lESHd3a0xMRE5hejdZNVpIaExoRSs5cEYzajZEMXFiWk1r?=
 =?utf-8?B?a0oyTUhjbEpuRDRLZWNNaXJ1TVBZekhXWDlFUHN5ZldlclhremNTMjk1alRt?=
 =?utf-8?B?STdNSU04NzVaTUl0M01YVWZtSjd5RFdrVDFJV29XNjRFbk1ZMzZtek9hZkZO?=
 =?utf-8?B?cEcwZXVzbkF1YXMvbVNqUFFVWVdQWmdpbHk1TUN3QWpydXZsZExHTC9sQjdB?=
 =?utf-8?B?VlhDN1g4bDQwblIrWDNsT1o3Y3AvWHp0Ulh0STBSOVpSVzZ1eXVMVnRuMjBh?=
 =?utf-8?B?aE9DOURJRksrMWZFSG9WWU9UL2dxeTNBaU8vR3dIQXA3MkRWZHlOenFtMG44?=
 =?utf-8?B?Z09aQ2xiVkhRMjQ1aFp5MXdEZEQ4WHVuakcrcUNsNWpvNTdVZitqcEpDZkth?=
 =?utf-8?B?cmF6Y0hVaWtZcGVnNGU5ZSs4blRQcXB3MTJHS0tCaFl0V2ptQk02L0UwT3h2?=
 =?utf-8?B?SWlkNEREUWc2eDdSVnVFbC9xQ1dkNloxZXplUlZaQ3h0bVFwaXNGN1I4Zmpz?=
 =?utf-8?B?dHNMUEZHZTBacEZZUExEckU1RFlPSkN4am9ZekhmckxKTjFWcUpsY1ZXNmsv?=
 =?utf-8?B?WUUrcnNZTW8zSUkybFZ0NCtReG50cUVzQ3g4cG9HZ3FYcGxvTU5pZHFwVHFR?=
 =?utf-8?B?N3VPbzQ0c2dTcDIrVkpSNGJwVW9qK3Q1UVNOdnlIMnFYZmNTc3Z3Y2hOWUxq?=
 =?utf-8?B?M21mejFIc1NIczdUb2RFdmZoWnBDc0UxeWxnM2c5SWprTWZ6ZG5sRnl1dVNT?=
 =?utf-8?B?VndKMnR0dkYrL29jNU9jdzZqWWp1OHlkR2NtZmI5NTBFdHNGV2FqeDBzclBC?=
 =?utf-8?B?L3hsdGo1WnhDQXNhYXRhWHdRV1A4c0RYSllEakppMElDejdZbFkwbWRaZkZa?=
 =?utf-8?B?U1pDMTc2TEp2VWpDeSt1dGJsWk11Z25wVE02SmphcFoxNlJHelFOVW9IZ2J3?=
 =?utf-8?B?U1doUWN5RUlOZnlNOEZ6VzA0NFVJT1lnSy9xMnVYTjJaQWZFRkh1YTN5dTZl?=
 =?utf-8?B?WXdxU2grRmdBN3M1b1d4TnpDZ1c3c0VZdGd5WktOY3prVVRNbjJHLzBVOU5y?=
 =?utf-8?B?elRtNCtuY3V2dE11NUVoelVzdkVsazBjaGJIUTdkOW56aTh2czMrNmhTNEJt?=
 =?utf-8?B?VVg3ZEF5OFhvbzBydnAxaUlQVUtFUWRSbVQ1SU5oZ2oyaVZyR3pVek92cTV6?=
 =?utf-8?B?QmJRUERUb0ptZmd5Q1VvSXBsQkRib0VGWVFDdHBJTUhVTSs0Rkk0TlJhYTJN?=
 =?utf-8?B?TklnLzkzdjQ0RUgxc01Oc0dia2ExR0NnaW5NN0tINDlaeG55dWtOak9SZ2do?=
 =?utf-8?B?KzdaczRGcE9CY2E0REptZEhaT0dvZlVyam1PZXU5NHJPN21YWmNaZW1ETUQ5?=
 =?utf-8?B?TG5HU1o0YllGRGNZUUtaRzBWL3djMUZhOWRFSmFzOHVYV2txcHRKK3EyaVgz?=
 =?utf-8?B?cVJ4dHdoSEhmdFZINnlUVFA3Mkh5eEpobmpUQ0ZoQ2V4YWwzOHU0clVkVFYr?=
 =?utf-8?B?aVB3d3RDKy9RYldQVklOQ0VEcWxKU0lRU05MRlF3K0trUU0vdTNjTDVySEtx?=
 =?utf-8?B?K1djaTVlbXhqMFNuOVE4VnU1SEhVemdqbFdGbkpINjFGamhFci9CMlZIejFM?=
 =?utf-8?B?MGthQ0xpcEMyK3NDbWJFc2c4a3VqV2xGRzQzT3BYMzNKODR4eFJQalRLQzV6?=
 =?utf-8?B?QVJPOGNRaEFrMDN5RFNzZUVrUWM0d3FBZ2N3d29MamlmRTBPeDBXNHl6UG9Z?=
 =?utf-8?B?Y1hPRVkwb0JZbTRnbE1JeXhuL3Y4RHBDcmxucEhOWlZJZTN3aWhra1ZORVND?=
 =?utf-8?B?d2Q2bnhocHBnRlAyY0syNmdCNHRMS1hBMTUwSW83Sm5iQ3RzUHhmQ0gxY3J2?=
 =?utf-8?B?dDdQOFgvaElFR2FCcFEzbXNQQUJlUDYraGxqSEd0QTRDK1ZPMjZ4M09JVGJp?=
 =?utf-8?B?WDNaYTdGTnBzZHV5Mmx3WFZ0aUk2aWN6SGYvSmRHWFJ2K0ZOc2dCc0R6SHo3?=
 =?utf-8?Q?YytVVvKRW0vKGKcufZJBSORx3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2da472-791f-4a50-cd25-08dcedfee893
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8599.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:23:46.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1Aw+V0Ado40esLrzbRb6NJx8CAQ9l+8YMGEpzHGamzlznISqSQK3ElzOg+uD0VUyTr0CD0GgOYxhXyqEwBkTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6884

Adds the driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like
EdgeLock Enclave from:
- User-Space Applications via character driver.

ABI documentation for the NXP secure-enclave driver.

User-space library using this driver:
- i.MX Secure Enclave library:
  -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
- i.MX Secure Middle-Ware:
  -- URL: https://github.com/nxp-imx/imx-smw.git

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 Documentation/ABI/testing/se-cdev   |  43 ++
 drivers/firmware/imx/ele_base_msg.c |   8 +-
 drivers/firmware/imx/ele_common.c   |  39 +-
 drivers/firmware/imx/ele_common.h   |   6 +-
 drivers/firmware/imx/se_ctrl.c      | 779 ++++++++++++++++++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h      |  42 +-
 include/uapi/linux/se_ioctl.h       |  94 +++++
 7 files changed, 990 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
new file mode 100644
index 000000000000..3451c909ccc4
--- /dev/null
+++ b/Documentation/ABI/testing/se-cdev
@@ -0,0 +1,43 @@
+What:		/dev/<se>_mu[0-9]+_ch[0-9]+
+Date:		May 2024
+KernelVersion:	6.8
+Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
+Description:
+		NXP offers multiple hardware IP(s) for secure enclaves like EdgeLock-
+		Enclave(ELE), SECO. The character device file descriptors
+		/dev/<se>_mu*_ch* are the interface between userspace NXP's secure-
+		enclave shared library and the kernel driver.
+
+		The ioctl(2)-based ABI is defined and documented in
+		[include]<linux/firmware/imx/ele_mu_ioctl.h>.
+		ioctl(s) are used primarily for:
+			- shared memory management
+			- allocation of I/O buffers
+			- getting mu info
+			- setting a dev-ctx as receiver to receive all the commands from FW
+			- getting SoC info
+			- send command and receive command response
+
+		The following file operations are supported:
+
+		open(2)
+		  Currently the only useful flags are O_RDWR.
+
+		read(2)
+		  Every read() from the opened character device context is waiting on
+		  wait_event_interruptible, that gets set by the registered mailbox callback
+		  function, indicating a message received from the firmware on message-
+		  unit.
+
+		write(2)
+		  Every write() to the opened character device context needs to acquire
+		  mailbox_lock before sending message on to the message unit.
+
+		close(2)
+		  Stops and frees up the I/O contexts that were associated
+		  with the file descriptor.
+
+Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
+		https://github.com/nxp-imx/imx-smw.git
+		crypto/skcipher,
+		drivers/nvmem/imx-ocotp-ele.c
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
index 53c83eddd52a..329badcc3d14 100644
--- a/drivers/firmware/imx/ele_base_msg.c
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -67,7 +67,7 @@ int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info)
 	tx_msg->data[0] = upper_32_bits(get_info_addr);
 	tx_msg->data[1] = lower_32_bits(get_info_addr);
 	tx_msg->data[2] = sizeof(*s_info);
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_GET_INFO_REQ_MSG_SZ,
 			       rx_msg,
@@ -145,7 +145,7 @@ int ele_ping(struct se_if_priv *priv)
 		goto exit;
 	}
 
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_PING_REQ_SZ,
 			       rx_msg,
@@ -200,7 +200,7 @@ int ele_service_swap(struct se_if_priv *priv,
 	tx_msg->data[3] = lower_32_bits(addr);
 	tx_msg->data[4] = se_add_msg_crc((uint32_t *)&tx_msg[0],
 						 ELE_SERVICE_SWAP_REQ_MSG_SZ);
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
 			       rx_msg,
@@ -261,7 +261,7 @@ int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr)
 	tx_msg->data[0] = lower_32_bits(addr);
 	tx_msg->data[2] = addr;
 
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_FW_AUTH_REQ_SZ,
 			       rx_msg,
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index f7c760bbc7a3..97f34e4e5d2c 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -18,9 +18,10 @@ u32 se_add_msg_crc(u32 *msg, u32 msg_len)
 	return crc;
 }
 
-int ele_msg_rcv(struct se_if_priv *priv,
+int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
 		struct se_clbk_handle *se_clbk_hdl)
 {
+	struct se_if_priv *priv = dev_ctx->priv;
 	int err = 0;
 
 	do {
@@ -31,12 +32,13 @@ int ele_msg_rcv(struct se_if_priv *priv,
 		 */
 		err = wait_for_completion_interruptible(&se_clbk_hdl->done);
 		if (err == -ERESTARTSYS) {
-			if (priv->waiting_rsp_clbk_hdl.rx_msg) {
+			if (priv->waiting_rsp_clbk_hdl.dev_ctx) {
 				priv->waiting_rsp_clbk_hdl.signal_rcvd = true;
 				continue;
 			}
 			dev_err(priv->dev,
-				"Err[0x%x]:Interrupted by signal.\n",
+				"%s: Err[0x%x]:Interrupted by signal.\n",
+				se_clbk_hdl->dev_ctx->devname,
 				err);
 			err = -EINTR;
 			break;
@@ -46,10 +48,11 @@ int ele_msg_rcv(struct se_if_priv *priv,
 	return err ? err : se_clbk_hdl->rx_msg_sz;
 }
 
-int ele_msg_send(struct se_if_priv *priv,
+int ele_msg_send(struct se_if_device_ctx *dev_ctx,
 		 void *tx_msg,
 		 int tx_msg_sz)
 {
+	struct se_if_priv *priv = dev_ctx->priv;
 	struct se_msg_hdr *header;
 	int err;
 
@@ -62,7 +65,8 @@ int ele_msg_send(struct se_if_priv *priv,
 	if (header->size << 2 != tx_msg_sz) {
 		err = -EINVAL;
 		dev_err(priv->dev,
-			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			"%s: User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			dev_ctx->devname,
 			*(u32 *)header,
 			header->size << 2, tx_msg_sz);
 		goto exit;
@@ -70,7 +74,9 @@ int ele_msg_send(struct se_if_priv *priv,
 
 	err = mbox_send_message(priv->tx_chan, tx_msg);
 	if (err < 0) {
-		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
+		dev_err(priv->dev,
+			"%s: Error: mbox_send_message failure.",
+			dev_ctx->devname);
 		return err;
 	}
 	err = tx_msg_sz;
@@ -80,29 +86,32 @@ int ele_msg_send(struct se_if_priv *priv,
 }
 
 /* API used for send/receive blocking call. */
-int ele_msg_send_rcv(struct se_if_priv *priv,
+int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
 		     void *tx_msg,
 		     int tx_msg_sz,
 		     void *rx_msg,
 		     int exp_rx_msg_sz)
 {
 	int err;
+	struct se_if_priv *priv = dev_ctx->priv;
 
 	guard(mutex)(&priv->se_if_cmd_lock);
 
+	priv->waiting_rsp_clbk_hdl.dev_ctx = dev_ctx;
 	priv->waiting_rsp_clbk_hdl.rx_msg_sz = exp_rx_msg_sz;
 	priv->waiting_rsp_clbk_hdl.rx_msg = rx_msg;
 
-	err = ele_msg_send(priv, tx_msg, tx_msg_sz);
+	err = ele_msg_send(dev_ctx, tx_msg, tx_msg_sz);
 	if (err < 0)
 		goto exit;
 
-	err = ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
+	err = ele_msg_rcv(dev_ctx, &priv->waiting_rsp_clbk_hdl);
 
 	if (priv->waiting_rsp_clbk_hdl.signal_rcvd) {
 		err = -EINTR;
 		priv->waiting_rsp_clbk_hdl.signal_rcvd = false;
 	}
+	priv->waiting_rsp_clbk_hdl.dev_ctx = NULL;
 
 exit:
 	return err;
@@ -149,7 +158,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 	if (header->tag == priv->if_defs->cmd_tag) {
 		se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
 		dev_dbg(dev,
-			"Selecting cmd receiver for mesg header:0x%x.",
+			"Selecting cmd receiver:%s for mesg header:0x%x.",
+			se_clbk_hdl->dev_ctx->devname,
 			*(u32 *) header);
 
 		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
@@ -158,7 +168,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 		 */
 		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
 			dev_err(dev,
-				"CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				"%s: CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				se_clbk_hdl->dev_ctx->devname,
 				*(u32 *) header,
 				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
 
@@ -169,13 +180,15 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 	} else if (header->tag == priv->if_defs->rsp_tag) {
 		se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
 		dev_dbg(dev,
-			"Selecting resp waiter for mesg header:0x%x.",
+			"Selecting resp waiter:%s for mesg header:0x%x.",
+			se_clbk_hdl->dev_ctx->devname,
 			*(u32 *) header);
 
 		if (rx_msg_sz != se_clbk_hdl->rx_msg_sz
 				&& !exception_for_size(priv, header)) {
 			dev_err(dev,
-				"Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				"%s: Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				se_clbk_hdl->dev_ctx->devname,
 				*(u32 *) header,
 				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
 
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index 3d8b6f83fb9d..9bded800c103 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -14,12 +14,12 @@
 #define IMX_ELE_FW_DIR                 "imx/ele/"
 
 uint32_t se_add_msg_crc(uint32_t *msg, uint32_t msg_len);
-int ele_msg_rcv(struct se_if_priv *priv,
+int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
 		struct se_clbk_handle *se_clbk_hdl);
-int ele_msg_send(struct se_if_priv *priv,
+int ele_msg_send(struct se_if_device_ctx *dev_ctx,
 		 void *tx_msg,
 		 int tx_msg_sz);
-int ele_msg_send_rcv(struct se_if_priv *priv,
+int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
 		     void *tx_msg,
 		     int tx_msg_sz,
 		     void *rx_msg,
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
index 40d815d0ac9b..f41c6441eac1 100644
--- a/drivers/firmware/imx/se_ctrl.c
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sys_soc.h>
+#include <uapi/linux/se_ioctl.h>
 
 #include "ele_base_msg.h"
 #include "ele_common.h"
@@ -313,6 +314,762 @@ static int se_load_firmware(struct se_if_priv *priv)
 	return ret;
 }
 
+static int init_se_shared_mem(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_out);
+	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_in);
+
+	/*
+	 * Allocate some memory for data exchanges with S40x.
+	 * This will be used for data not requiring secure memory.
+	 */
+	se_shared_mem_mgmt->non_secure_mem.ptr
+			= dma_alloc_coherent(priv->dev,
+					     MAX_DATA_SIZE_PER_USER,
+					     &se_shared_mem_mgmt->non_secure_mem.dma_addr,
+					     GFP_KERNEL);
+	if (!se_shared_mem_mgmt->non_secure_mem.ptr)
+		return -ENOMEM;
+
+	se_shared_mem_mgmt->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+
+	return 0;
+}
+
+static void cleanup_se_shared_mem(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	/* Unmap secure memory shared buffer. */
+	if (se_shared_mem_mgmt->secure_mem.ptr)
+		devm_iounmap(priv->dev,
+				(void __iomem *)se_shared_mem_mgmt->secure_mem.ptr);
+
+	se_shared_mem_mgmt->secure_mem.ptr = NULL;
+	se_shared_mem_mgmt->secure_mem.dma_addr = 0;
+	se_shared_mem_mgmt->secure_mem.size = 0;
+	se_shared_mem_mgmt->secure_mem.pos = 0;
+
+	/* Free non-secure shared buffer. */
+	dma_free_coherent(priv->dev, MAX_DATA_SIZE_PER_USER,
+			  se_shared_mem_mgmt->non_secure_mem.ptr,
+			  se_shared_mem_mgmt->non_secure_mem.dma_addr);
+
+	se_shared_mem_mgmt->non_secure_mem.ptr = NULL;
+	se_shared_mem_mgmt->non_secure_mem.dma_addr = 0;
+	se_shared_mem_mgmt->non_secure_mem.size = 0;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+}
+
+/* Need to copy the output data to user-device context.
+ */
+static int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_buf_desc *b_desc, *temp;
+	bool do_cpy = true;
+
+	list_for_each_entry_safe(b_desc, temp, &se_shared_mem_mgmt->pending_out, link) {
+		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr && do_cpy) {
+
+			dev_dbg(priv->dev,
+				"Copying output data to user.");
+			if (do_cpy && copy_to_user(b_desc->usr_buf_ptr,
+					 b_desc->shared_buf_ptr,
+					 b_desc->size)) {
+				dev_err(priv->dev,
+					"Failure copying output data to user.");
+				do_cpy = false;
+			}
+		}
+
+		if (b_desc->shared_buf_ptr)
+			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+		list_del(&b_desc->link);
+		kfree(b_desc);
+	}
+
+	return do_cpy ? 0 : -EFAULT;
+}
+
+/*
+ * Clean the used Shared Memory space,
+ * whether its Input Data copied from user buffers, or
+ * Data received from FW.
+ */
+static void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct list_head *pending_lists[] = {&se_shared_mem_mgmt->pending_in,
+						&se_shared_mem_mgmt->pending_out};
+	struct se_buf_desc *b_desc, *temp;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		list_for_each_entry_safe(b_desc, temp,
+					 pending_lists[i], link) {
+
+			if (b_desc->shared_buf_ptr)
+				memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+			list_del(&b_desc->link);
+			kfree(b_desc);
+		}
+	}
+	se_shared_mem_mgmt->secure_mem.pos = 0;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+}
+
+static int add_b_desc_to_pending_list(void *shared_ptr_with_pos,
+			       struct se_ioctl_setup_iobuf *io,
+			       struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_buf_desc *b_desc = NULL;
+
+	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
+	if (!b_desc)
+		return -ENOMEM;
+
+	b_desc->shared_buf_ptr = shared_ptr_with_pos;
+	b_desc->usr_buf_ptr = io->user_buf;
+	b_desc->size = io->length;
+
+	if (io->flags & SE_IO_BUF_FLAGS_IS_INPUT) {
+		/*
+		 * buffer is input:
+		 * add an entry in the "pending input buffers" list so
+		 * that copied data can be cleaned from shared memory
+		 * later.
+		 */
+		list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_in);
+	} else {
+		/*
+		 * buffer is output:
+		 * add an entry in the "pending out buffers" list so data
+		 * can be copied to user space when receiving Secure-Enclave
+		 * response.
+		 */
+		list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_out);
+	}
+
+	return 0;
+}
+
+/* interface for managed res to unregister a character device */
+static void if_misc_deregister(void *miscdevice)
+{
+	misc_deregister(miscdevice);
+}
+
+static int init_device_context(struct se_if_priv *priv, int ch_id,
+			struct se_if_device_ctx **new_dev_ctx,
+			const struct file_operations *se_if_fops)
+{
+	const struct se_if_node_info *info = container_of(priv->if_defs,
+							typeof(*info),
+							if_defs);
+	struct se_if_device_ctx *dev_ctx;
+	int ret = 0;
+
+	if (ch_id)
+		dev_ctx = kzalloc(sizeof(*dev_ctx), GFP_KERNEL);
+	else
+		dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);
+
+	if (!dev_ctx) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	dev_ctx->priv = priv;
+
+	if (ch_id)
+		dev_ctx->devname = kasprintf(GFP_KERNEL, "%s_ch%d",
+					     info->se_name, ch_id);
+	else
+		dev_ctx->devname = devm_kasprintf(priv->dev,
+						  GFP_KERNEL, "%s_ch%d",
+						  info->se_name, ch_id);
+	if (!dev_ctx->devname) {
+		ret = -ENOMEM;
+		if (ch_id)
+			kfree(dev_ctx);
+
+		return ret;
+	}
+
+	mutex_init(&dev_ctx->fops_lock);
+
+	*new_dev_ctx = dev_ctx;
+
+	if (ch_id) {
+		list_add_tail(&dev_ctx->link, &priv->dev_ctx_list);
+		priv->active_devctx_count++;
+
+		ret = init_se_shared_mem(dev_ctx);
+		if (ret < 0) {
+			kfree(dev_ctx->devname);
+			kfree(dev_ctx);
+			*new_dev_ctx = NULL;
+			return ret;
+		}
+
+		return ret;
+	}
+
+	/* Only for ch_id = 0:
+	 * - register the misc device.
+	 * - add action
+	 */
+	dev_ctx->miscdev = devm_kzalloc(priv->dev, sizeof(*dev_ctx->miscdev), GFP_KERNEL);
+	if (!dev_ctx->miscdev) {
+		ret = -ENOMEM;
+		*new_dev_ctx = NULL;
+		return ret;
+	}
+
+	dev_ctx->miscdev->name = dev_ctx->devname;
+	dev_ctx->miscdev->minor = MISC_DYNAMIC_MINOR;
+	dev_ctx->miscdev->fops = se_if_fops;
+	dev_ctx->miscdev->parent = priv->dev;
+	ret = misc_register(dev_ctx->miscdev);
+	if (ret) {
+		dev_err(priv->dev, "failed to register misc device %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = devm_add_action(priv->dev, if_misc_deregister,
+			      dev_ctx->miscdev);
+	if (ret) {
+		dev_err(priv->dev,
+			"failed[%d] to add action to the misc-dev\n",
+			ret);
+		misc_deregister(dev_ctx->miscdev);
+	}
+
+	return ret;
+}
+
+static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx *dev_ctx,
+					    u64 arg)
+{
+	const struct se_if_node_info *info = container_of(dev_ctx->priv->if_defs,
+							typeof(*info),
+							if_defs);
+	struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info;
+	struct se_if_node_info_list *info_list
+				= container_of(info,
+						typeof(*info_list),
+						info[info->se_if_id]);
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int err = 0;
+
+	if (copy_from_user(&cmd_snd_rcv_rsp_info, (u8 __user *)arg,
+			   sizeof(cmd_snd_rcv_rsp_info))) {
+		dev_err(priv->dev,
+			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	if (cmd_snd_rcv_rsp_info.tx_buf_sz < SE_MU_HDR_SZ) {
+		dev_err(priv->dev,
+			"%s: User buffer too small(%d < %d)\n",
+			dev_ctx->devname,
+			cmd_snd_rcv_rsp_info.tx_buf_sz,
+			SE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(cmd_snd_rcv_rsp_info.rx_buf_sz, GFP_KERNEL);
+	if (!rx_msg) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	tx_msg = memdup_user(cmd_snd_rcv_rsp_info.tx_buf,
+			     cmd_snd_rcv_rsp_info.tx_buf_sz);
+	if (IS_ERR(tx_msg)) {
+		err = PTR_ERR(tx_msg);
+		goto exit;
+	}
+
+	if (tx_msg->header.tag != priv->if_defs->cmd_tag) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (tx_msg->header.ver == priv->if_defs->fw_api_ver &&
+		!info_list->load_hsm_fw.is_fw_loaded) {
+		err = se_load_firmware(priv);
+		if (err) {
+			dev_err(priv->dev, "Could not send the message as FW is not loaded.");
+			err = -EPERM;
+			goto exit;
+		}
+	}
+	err = ele_msg_send_rcv(dev_ctx,
+			       tx_msg,
+			       cmd_snd_rcv_rsp_info.tx_buf_sz,
+			       rx_msg,
+			       cmd_snd_rcv_rsp_info.rx_buf_sz);
+	if (err < 0)
+		goto exit;
+
+	dev_dbg(priv->dev,
+		"%s: %s %s\n",
+		dev_ctx->devname,
+		__func__,
+		"message received, start transmit to user");
+
+	/* We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	err = se_dev_ctx_cpy_out_data(dev_ctx);
+	if (err < 0)
+		goto exit;
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     rx_msg,
+			     cmd_snd_rcv_rsp_info.rx_buf_sz, false);
+
+	if (copy_to_user(cmd_snd_rcv_rsp_info.rx_buf, rx_msg,
+			 cmd_snd_rcv_rsp_info.rx_buf_sz)) {
+		dev_err(priv->dev,
+			"%s: Failed to copy to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+exit:
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+
+	if (copy_to_user((void __user *)arg, &cmd_snd_rcv_rsp_info,
+			 sizeof(cmd_snd_rcv_rsp_info))) {
+		dev_err(priv->dev,
+			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+	return err;
+}
+
+static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
+				u64 arg)
+{
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_if_node_info *info;
+	struct se_ioctl_get_if_info if_info;
+	int err = 0;
+
+	info = container_of(priv->if_defs, typeof(*info), if_defs);
+
+	if_info.se_if_id = info->se_if_id;
+	if_info.interrupt_idx = 0;
+	if_info.tz = 0;
+	if_info.did = info->se_if_did;
+	if_info.cmd_tag = priv->if_defs->cmd_tag;
+	if_info.rsp_tag = priv->if_defs->rsp_tag;
+	if_info.success_tag = priv->if_defs->success_tag;
+	if_info.base_api_ver = priv->if_defs->base_api_ver;
+	if_info.fw_api_ver = priv->if_defs->fw_api_ver;
+
+	dev_dbg(priv->dev,
+		"%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
+			dev_ctx->devname,
+			if_info.se_if_id, if_info.interrupt_idx,
+			if_info.tz, if_info.did);
+
+	if (copy_to_user((u8 __user *)arg, &if_info, sizeof(if_info))) {
+		dev_err(priv->dev,
+			"%s: Failed to copy mu info to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+/*
+ * Copy a buffer of data to/from the user and return the address to use in
+ * messages
+ */
+static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
+					    u64 arg)
+{
+	struct se_shared_mem *shared_mem = NULL;
+	struct se_ioctl_setup_iobuf io = {0};
+	int err = 0;
+	u32 pos;
+
+	if (copy_from_user(&io, (u8 __user *)arg, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed copy iobuf config from user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	dev_dbg(dev_ctx->priv->dev,
+		"%s: io [buf: %p(%d) flag: %x]\n",
+		dev_ctx->devname,
+		io.user_buf, io.length, io.flags);
+
+	if (io.length == 0 || !io.user_buf) {
+		/*
+		 * Accept NULL pointers since some buffers are optional
+		 * in FW commands. In this case we should return 0 as
+		 * pointer to be embedded into the message.
+		 * Skip all data copy part of code below.
+		 */
+		io.ele_addr = 0;
+		goto copy;
+	}
+
+	/* No specific requirement for this buffer. */
+	shared_mem = &dev_ctx->se_shared_mem_mgmt.non_secure_mem;
+
+	/* Check there is enough space in the shared memory. */
+	if (shared_mem->size < shared_mem->pos ||
+		round_up(io.length, 8u) >= (shared_mem->size - shared_mem->pos)) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Not enough space in shared memory\n",
+			dev_ctx->devname);
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	/* Allocate space in shared memory. 8 bytes aligned. */
+	pos = shared_mem->pos;
+	shared_mem->pos += round_up(io.length, 8u);
+	io.ele_addr = (u64)shared_mem->dma_addr + pos;
+
+	memset(shared_mem->ptr + pos, 0, io.length);
+	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
+	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
+		/*
+		 * buffer is input:
+		 * copy data from user space to this allocated buffer.
+		 */
+		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
+				   io.length)) {
+			dev_err(dev_ctx->priv->dev,
+				"%s: Failed copy data to shared memory\n",
+				dev_ctx->devname);
+			err = -EFAULT;
+			goto exit;
+		}
+	}
+
+	err = add_b_desc_to_pending_list(shared_mem->ptr + pos,
+					 &io,
+					 dev_ctx);
+	if (err < 0)
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to allocate/link b_desc.",
+			dev_ctx->devname);
+
+copy:
+	/* Provide the EdgeLock Enclave address to user space only if success.*/
+	if (copy_to_user((u8 __user *)arg, &io, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy iobuff setup to user.",
+			dev_ctx->devname);
+		err = -EFAULT;
+		goto exit;
+	}
+exit:
+	return err;
+}
+
+/* IOCTL to provide SoC information */
+static int se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx,
+					     u64 arg)
+{
+	const struct se_if_node_info_list *info_list;
+	struct se_ioctl_get_soc_info soc_info;
+	int err = -EINVAL;
+
+	info_list = device_get_match_data(dev_ctx->priv->dev);
+	if (!info_list)
+		goto exit;
+
+	soc_info.soc_id = info_list->soc_id;
+	soc_info.soc_rev = se_soc_rev;
+
+	err = (int)copy_to_user((u8 __user *)arg, (u8 *)(&soc_info), sizeof(soc_info));
+	if (err) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy soc info to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+/*
+ * File operations for user-space
+ */
+
+/* Write a message to the MU. */
+static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
+				size_t size, loff_t *ppos)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	dev_dbg(priv->dev,
+		"%s: write from buf (%p)%zu, ppos=%lld\n",
+		dev_ctx->devname,
+		buf, size, ((ppos) ? *ppos : 0));
+
+	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (size < SE_MU_HDR_SZ) {
+		dev_err(priv->dev,
+			"%s: User buffer too small(%zu < %d)\n",
+			dev_ctx->devname,
+			size, SE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	tx_msg = memdup_user(buf, size);
+	if (IS_ERR(tx_msg)) {
+		err = PTR_ERR(tx_msg);
+		goto exit;
+	}
+
+	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     tx_msg, size, false);
+
+	err = ele_msg_send(dev_ctx, tx_msg, size);
+	if (err < 0)
+		goto exit;
+exit:
+	mutex_unlock(&dev_ctx->fops_lock);
+	return err;
+}
+
+/*
+ * Read a message from the MU.
+ * Blocking until a message is available.
+ */
+static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
+			       size_t size, loff_t *ppos)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	dev_dbg(priv->dev,
+		"%s: read to buf %p(%zu), ppos=%lld\n",
+		dev_ctx->devname,
+		buf, size, ((ppos) ? *ppos : 0));
+
+	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	err = ele_msg_rcv(dev_ctx, &priv->cmd_receiver_clbk_hdl);
+	if (err < 0) {
+		dev_err(priv->dev,
+			"%s: Err[0x%x]:Interrupted by signal.\n",
+			dev_ctx->devname, err);
+		dev_dbg(priv->dev,
+			"Current active dev-ctx count = %d.\n",
+			dev_ctx->priv->active_devctx_count);
+		goto exit;
+	}
+
+	/* We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	err = se_dev_ctx_cpy_out_data(dev_ctx);
+	if (err < 0)
+		goto exit;
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     priv->cmd_receiver_clbk_hdl.rx_msg,
+			     priv->cmd_receiver_clbk_hdl.rx_msg_sz,
+			     false);
+
+	if (copy_to_user(buf, priv->cmd_receiver_clbk_hdl.rx_msg,
+			 priv->cmd_receiver_clbk_hdl.rx_msg_sz)) {
+		dev_err(priv->dev,
+			"%s: Failed to copy to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+	err = priv->cmd_receiver_clbk_hdl.rx_msg_sz;
+exit:
+	priv->cmd_receiver_clbk_hdl.rx_msg_sz = 0;
+
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+
+	mutex_unlock(&dev_ctx->fops_lock);
+	return err;
+}
+
+/* Open a character device. */
+static int se_if_fops_open(struct inode *nd, struct file *fp)
+{
+	struct miscdevice *miscdev = fp->private_data;
+	struct se_if_priv *priv = dev_get_drvdata(miscdev->parent);
+	struct se_if_device_ctx *misc_dev_ctx = priv->priv_dev_ctx;
+	struct se_if_device_ctx *dev_ctx;
+	int err = 0;
+
+	if (mutex_lock_interruptible(&misc_dev_ctx->fops_lock))
+		return -EBUSY;
+
+	priv->dev_ctx_mono_count++;
+	err = init_device_context(priv,
+				  priv->dev_ctx_mono_count ?
+					priv->dev_ctx_mono_count
+					: priv->dev_ctx_mono_count++,
+				  &dev_ctx, NULL);
+	if (err) {
+		dev_err(priv->dev,
+			"Failed[0x%x] to create device contexts.\n",
+			err);
+		goto exit;
+	}
+
+	fp->private_data = dev_ctx;
+
+exit:
+	mutex_unlock(&misc_dev_ctx->fops_lock);
+	return err;
+}
+
+/* Close a character device. */
+static int se_if_fops_close(struct inode *nd, struct file *fp)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	/* check if this device was registered as command receiver. */
+	if (priv->cmd_receiver_clbk_hdl.dev_ctx == dev_ctx) {
+		priv->cmd_receiver_clbk_hdl.dev_ctx = NULL;
+		kfree(priv->cmd_receiver_clbk_hdl.rx_msg);
+		priv->cmd_receiver_clbk_hdl.rx_msg = NULL;
+	}
+
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+	cleanup_se_shared_mem(dev_ctx);
+
+	priv->active_devctx_count--;
+	list_del(&dev_ctx->link);
+
+	mutex_unlock(&dev_ctx->fops_lock);
+	kfree(dev_ctx->devname);
+	kfree(dev_ctx);
+
+	return 0;
+}
+
+/* IOCTL entry point of a character device */
+static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	/* Prevent race during change of device context */
+	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	switch (cmd) {
+	case SE_IOCTL_ENABLE_CMD_RCV:
+		if (!priv->cmd_receiver_clbk_hdl.dev_ctx) {
+			if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
+				priv->cmd_receiver_clbk_hdl.rx_msg
+					= kzalloc(MAX_NVM_MSG_LEN,
+						  GFP_KERNEL);
+				if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
+					err = -ENOMEM;
+					break;
+				}
+			}
+			priv->cmd_receiver_clbk_hdl.rx_msg_sz = MAX_NVM_MSG_LEN;
+			priv->cmd_receiver_clbk_hdl.dev_ctx = dev_ctx;
+			err = 0;
+		} else {
+			err = -EBUSY;
+		}
+		break;
+	case SE_IOCTL_GET_MU_INFO:
+		err = se_ioctl_get_mu_info(dev_ctx, arg);
+		break;
+	case SE_IOCTL_SETUP_IOBUF:
+		err = se_ioctl_setup_iobuf_handler(dev_ctx, arg);
+		break;
+	case SE_IOCTL_GET_SOC_INFO:
+		err = se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
+		break;
+	case SE_IOCTL_CMD_SEND_RCV_RSP:
+		err = se_ioctl_cmd_snd_rcv_rsp_handler(dev_ctx, arg);
+		break;
+	default:
+		err = -EINVAL;
+		dev_dbg(priv->dev,
+			"%s: IOCTL %.8x not supported\n",
+			dev_ctx->devname,
+			cmd);
+	}
+
+	mutex_unlock(&dev_ctx->fops_lock);
+
+	return (long)err;
+}
+
+/* Char driver setup */
+static const struct file_operations se_if_fops = {
+	.open		= se_if_fops_open,
+	.owner		= THIS_MODULE,
+	.release	= se_if_fops_close,
+	.unlocked_ioctl = se_ioctl,
+	.read		= se_if_fops_read,
+	.write		= se_if_fops_write,
+};
+
 /* interface for managed res to free a mailbox channel */
 static void if_mbox_free_channel(void *mbox_chan)
 {
@@ -348,6 +1105,7 @@ static int se_if_request_channel(struct device *dev,
 
 static void se_if_probe_cleanup(void *plat_dev)
 {
+	struct se_if_device_ctx *dev_ctx, *t_dev_ctx;
 	struct platform_device *pdev = plat_dev;
 	struct device *dev = &pdev->dev;
 	struct se_fw_load_info *load_fw;
@@ -372,6 +1130,18 @@ static void se_if_probe_cleanup(void *plat_dev)
 		load_fw->imem.buf = NULL;
 	}
 
+	if (priv->dev_ctx_mono_count) {
+		list_for_each_entry_safe(dev_ctx, t_dev_ctx, &priv->dev_ctx_list, link) {
+			list_del(&dev_ctx->link);
+			priv->active_devctx_count--;
+		}
+	}
+
+	if (priv->priv_dev_ctx && priv->priv_dev_ctx->miscdev) {
+		devm_remove_action(dev, if_misc_deregister, &priv->priv_dev_ctx->miscdev);
+		misc_deregister(priv->priv_dev_ctx->miscdev);
+	}
+
 	/* No need to check, if reserved memory is allocated
 	 * before calling for its release. Or clearing the
 	 * un-set bit.
@@ -456,6 +1226,7 @@ static int se_if_probe(struct platform_device *pdev)
 			goto exit;
 		}
 	}
+	INIT_LIST_HEAD(&priv->dev_ctx_list);
 
 	if (info->reserved_dma_ranges) {
 		ret = of_reserved_mem_device_init(dev);
@@ -467,6 +1238,14 @@ static int se_if_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = init_device_context(priv, 0, &priv->priv_dev_ctx, &se_if_fops);
+	if (ret) {
+		dev_err(dev,
+			"Failed[0x%x] to create device contexts.\n",
+			ret);
+		goto exit;
+	}
+
 	ret = se_soc_info(priv);
 	if (ret) {
 		dev_err(dev,
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
index de0d4a1bcb9e..a7f740e83a7c 100644
--- a/drivers/firmware/imx/se_ctrl.h
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -13,6 +13,7 @@
 #define MAX_FW_LOAD_RETRIES		50
 
 #define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
+#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
 #define MAX_NVM_MSG_LEN			(256)
 #define MESSAGING_VERSION_6		0x6
 #define MESSAGING_VERSION_7		0x7
@@ -31,7 +32,7 @@
 struct se_clbk_handle {
 	struct completion done;
 	bool signal_rcvd;
-	atomic_t pending_hdr;
+	struct se_if_device_ctx *dev_ctx;
 	u32 rx_msg_sz;
 	/* Assignment of the rx_msg buffer to held till the
 	 * received content as part callback function, is copied.
@@ -46,6 +47,40 @@ struct se_imem_buf {
 	u32 state;
 };
 
+struct se_buf_desc {
+	u8 *shared_buf_ptr;
+	void __user *usr_buf_ptr;
+	u32 size;
+	struct list_head link;
+};
+
+struct se_shared_mem {
+	dma_addr_t dma_addr;
+	u32 size;
+	u32 pos;
+	u8 *ptr;
+};
+
+struct se_shared_mem_mgmt_info {
+	struct list_head pending_in;
+	struct list_head pending_out;
+
+	struct se_shared_mem secure_mem;
+	struct se_shared_mem non_secure_mem;
+};
+
+/* Private struct for each char device instance. */
+struct se_if_device_ctx {
+	struct se_if_priv *priv;
+	struct miscdevice *miscdev;
+	const char *devname;
+
+	struct mutex fops_lock;
+
+	struct se_shared_mem_mgmt_info se_shared_mem_mgmt;
+	struct list_head link;
+};
+
 /* Header of the messages exchange with the EdgeLock Enclave */
 struct se_msg_hdr {
 	u8 ver;
@@ -89,6 +124,11 @@ struct se_if_priv {
 
 	struct gen_pool *mem_pool;
 	const struct se_if_defines *if_defs;
+
+	struct se_if_device_ctx *priv_dev_ctx;
+	struct list_head dev_ctx_list;
+	u32 active_devctx_count;
+	u32 dev_ctx_mono_count;
 };
 
 #endif
diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioctl.h
new file mode 100644
index 000000000000..582e3fef086e
--- /dev/null
+++ b/include/uapi/linux/se_ioctl.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef SE_IOCTL_H
+#define SE_IOCTL_H
+
+/* IOCTL definitions. */
+
+struct se_ioctl_setup_iobuf {
+	void __user *user_buf;
+	u32 length;
+	u32 flags;
+	u64 ele_addr;
+};
+
+struct se_ioctl_shared_mem_cfg {
+	u32 base_offset;
+	u32 size;
+};
+
+struct se_ioctl_get_if_info {
+	u8 se_if_id;
+	u8 interrupt_idx;
+	u8 tz;
+	u8 did;
+	u8 cmd_tag;
+	u8 rsp_tag;
+	u8 success_tag;
+	u8 base_api_ver;
+	u8 fw_api_ver;
+};
+
+struct se_ioctl_cmd_snd_rcv_rsp_info {
+	u32 __user *tx_buf;
+	int tx_buf_sz;
+	u32 __user *rx_buf;
+	int rx_buf_sz;
+};
+
+struct se_ioctl_get_soc_info {
+	u16 soc_id;
+	u16 soc_rev;
+};
+
+/* IO Buffer Flags */
+#define SE_IO_BUF_FLAGS_IS_OUTPUT	(0x00u)
+#define SE_IO_BUF_FLAGS_IS_INPUT	(0x01u)
+#define SE_IO_BUF_FLAGS_USE_SEC_MEM	(0x02u)
+#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR	(0x04u)
+#define SE_IO_BUF_FLAGS_IS_IN_OUT	(0x10u)
+
+/* IOCTLS */
+#define SE_IOCTL			0x0A /* like MISC_MAJOR. */
+
+/*
+ * ioctl to designated the current fd as logical-reciever.
+ * This is ioctl is send when the nvm-daemon, a slave to the
+ * firmware is started by the user.
+ */
+#define SE_IOCTL_ENABLE_CMD_RCV	_IO(SE_IOCTL, 0x01)
+
+/*
+ * ioctl to get the buffer allocated from the memory, which is shared
+ * between kernel and FW.
+ * Post allocation, the kernel tagged the allocated memory with:
+ *  Output
+ *  Input
+ *  Input-Output
+ *  Short address
+ *  Secure-memory
+ */
+#define SE_IOCTL_SETUP_IOBUF	_IOWR(SE_IOCTL, 0x03, \
+					struct se_ioctl_setup_iobuf)
+
+/*
+ * ioctl to get the mu information, that is used to exchange message
+ * with FW, from user-spaced.
+ */
+#define SE_IOCTL_GET_MU_INFO	_IOR(SE_IOCTL, 0x04, \
+					struct se_ioctl_get_if_info)
+/*
+ * ioctl to get SoC Info from user-space.
+ */
+#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
+					struct se_ioctl_get_soc_info)
+
+/*
+ * ioctl to send command and receive response from user-space.
+ */
+#define SE_IOCTL_CMD_SEND_RCV_RSP _IOWR(SE_IOCTL, 0x07, \
+					struct se_ioctl_cmd_snd_rcv_rsp_info)
+#endif

-- 
2.34.1


