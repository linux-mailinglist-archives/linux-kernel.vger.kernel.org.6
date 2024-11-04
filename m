Return-Path: <linux-kernel+bounces-395122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 710D39BB8D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF84282ED6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7053D1BD504;
	Mon,  4 Nov 2024 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bY4pFoLG"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178833B791;
	Mon,  4 Nov 2024 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733813; cv=fail; b=LsyQePkhOSpJLqZEbdrLRn9HvcQlFlwbUzhs5oLMhT4wxelpwUH4+i2jrXoOYv8rx/Bm8tlOQxrMRlVjUwFacg3xLAzlGjrc9BDj9xzcuUFvjjSmA98SB6bvksrQRbVUKsAcxG3OOfgFoLUZm6EXYpRTyEk8QA2vHs26Rw+lM3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733813; c=relaxed/simple;
	bh=IGxCSSxIbyx7KpzpMgCvm1+l6pctK4ayxMlVdHtnxqg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Pd+1aV/0wTD6iMIYaE0osYIdOvuyauFxeECZqaGcan0hXlQOLF/59ovim1Bpsk+iKC6Pax6okrqSpwPKoyYWr0Rky1xt/uMnlHq3yjAg27NZzcCBL8vY7C2diW8vPbUWxEhcE77LBsbQzRkz25OTFxHL0a13slCWtMGHMmZ6F04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bY4pFoLG; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efWujf1DstjriZcXBMswvt40imYYV5BKekavJpbjBbwwtOe/KFrOvUZSCbDTlFahOp6cFE6mECg4TKf6AvufRwZY7W/gXZqvPnT41n6LfI/BVBt4PTdjq68ImPOogoZWwyLFqyC2DMJJHKbRjqWZEMe9pA5Ygjs5XqBlHBPWsooZaofdncVk3lbNWei9bcZPzFmBHODBMFXzFTuk2Odfaewa+s3FBRCtXlEf4tz+zh1CrvKGbn5wxGn1iYObfBDOG8LUFmihmCSw7h1zsNbS7TqJ/9Xv9P1rBdvQqaGRHjpVr5JuNql0TvKW6l+0/OTXVz8SwUZT19Q6eFNquycQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HUqc5naAgQqmm7YB54N/PtqzruVRXE3YF5ERz69fvw=;
 b=EuInjUlo0QhoN+GH1h7DRaLbH59W2t7nU0defthYcM7uK8gSL1TZG+O15WmXH1FxztWuB/zYdFM0X8QRhcKT04lWs4GKLmG1IRoSjwKjKzr/veAcWbH1BTHqnU93E6z20SSU0UBoPAL44A/ENSAcCtGpQypgpu78bDMOGReaOSmzDfthbZnqtcoRKg98rzPYlPKhJ++ncXkGUMmNA51tRouXDIFh/owpr1wr5U1tQRufY/+Jx9bI062ZPYK8l591uMfZBivElRLLhg6T6z4jVLHfJzWsjdPqnrO6FFpbKyt7bUsRoFXzruQBxkALlBVCyElGs0MUmBNCwVuERjUvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HUqc5naAgQqmm7YB54N/PtqzruVRXE3YF5ERz69fvw=;
 b=bY4pFoLGNSiQof8QfCIISuaCE/yfeLObANOZuxdJ3+JvPKSHcb+tm4GwFVz8WGWNZSHZ4e0WPn2CibM8TZPsieIdvUJsmRO2FZF/pqQ2GDk/DALAjBvMWg6GLlSylzIlpy+E1Vkn9ttO1E36HUKNj6Ymhydgs/c4+RA7UVDKOPEAma8C+v+ZZ2+T3yPL2Uwbnbb5xI0PuvZo2QhqTkkX3IJ4T0oDTbrwRZOYOimNHBjFgsgIpJ74i0LVHCPEW7gvA0XRiOENnJYdnsQEl/ulJ7QmTgT3K+XZUh1kWqCMC15RWtUER1G9uqiP3EBGQsHZ3wQSiLUFGpDkoyUY427rLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS1PR04MB9430.eurprd04.prod.outlook.com (2603:10a6:20b:4da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 15:23:25 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 15:23:25 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v10 0/5] v10: firmware: imx: driver for NXP secure-enclave
Date: Mon, 04 Nov 2024 20:48:37 +0530
Message-Id: <20241104-imx-se-if-v10-0-bf06083cc97f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM7lKGcC/13QzU7DMAwH8FeZcqbIdr458R6Ig9ekLIe1U4uqo
 mnvjjchmuxoK7+/7VzVkueSF/V2uKo5r2Up0ygFwstB9Scev3JXkjQUARmw4Lty3rpFukPHBsB
 aiDr1Tsn7y5yHsj3CPj6lPpXle5p/Htkr3rt/KQhVyooddOR7y86biC69j9vltZ/O6p6xUuVI1
 47ECRoShshWx9bp3Tmst161OPaJQspse8OtM7vzYGtn7vMoAUDGwPi0p60cUu2sOOfYxwiag6f
 WucpR45y4nMmJOQZ63tPvLoKpnX/8y5CIj96QM60L/w4Bm/uCuIjW6CBDfdKti7VztYvihhQGh
 h5M5uPubrfbLzVUKIxhAgAA
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730733536; l=19879;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=IGxCSSxIbyx7KpzpMgCvm1+l6pctK4ayxMlVdHtnxqg=;
 b=sVzuoSTscV9tojmgNAPP5VGEiMJw1HPvDxwbaYEukepfQk9CKFOueHhxpSf9vZAAZ2mli2ZSN
 Wr+CPdFIEnqAzmr8BXMG54DbHVNAobo6SGmRsF3viP7Uw8H5naIfMg4
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AS1PR04MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebefa6a-5f31-49e7-ed8f-08dcfce4a02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azZweE4wTG5Vam5KalgxRlQ3czBQTzY3aFpIN2FaVHE1bk1qNFYrNWRnU1E0?=
 =?utf-8?B?SEdYczRlbVBLSllMYjAwT0dZSWFWdDl6Z3hpRTdWMW5STG9jdGJST2UzTVgw?=
 =?utf-8?B?V0hxK2hYMnhxc1FqZjIrRDRWQ2Q1RHdmaXRkeUVZNzlZbGY4V2UyL1MzSW9S?=
 =?utf-8?B?VEYza1c5ZEViRUpjcWRqVnFtNnVxend2SnM1MWZ6c1BaTTRhV3FrQXN0b0Zm?=
 =?utf-8?B?bCs3KzNpNVdoQ2c0bEV0VnZMSksrVDdITXExSmR5OXFKZlRiYlFEdjFUUS9v?=
 =?utf-8?B?bFhYNWNpRVZVdjViVXVxUVBnejBIQ1dvd0VrQWY0YncxL29nWW4vMjUyb1NT?=
 =?utf-8?B?NjdpdmVkODFaWmE5dlB6bzJ6RE9GdXNhaHBEL25VeEtsUWRDODBYb2FId2tn?=
 =?utf-8?B?Yngrbzcrek5uWHJiSkM4TjJJdVh2S0REc0tkTktkU2lwZXI1Qi9vbThaNUM0?=
 =?utf-8?B?ZXIwaUwyRU1ITVNVbVRXZ0g1dzNQQnRoWHMycHNaRUZ5dEJ6YitvdnQ4MXhQ?=
 =?utf-8?B?ZjZBaVB0aTBVd2J2S0RhOUJhaXp6V3pscDFkK3pwaTlaamdUN1pId21ITGla?=
 =?utf-8?B?cUFSN21SQ09GVEJQdnVrNHhJa2FNQ0M1RkVqTnpwVTRyQTlEeEVPeFVJVTB2?=
 =?utf-8?B?RTdaWmU5QVp1V1Qrc2tvOXZmV2E3K3VrTmJOb21ranBzbmdNVi9qWGw2NHky?=
 =?utf-8?B?QlozTFV5Yi92bDNjNUtSMysrRERyWE1MRTRyK2lqaWc4NzRzQVdHMjFpL2N0?=
 =?utf-8?B?eWxJbTRjeEdMNTZVUmM3cGU4SW5jZ2ZRU1o4aHR2SlRLbHJrdDBob2w0MFpV?=
 =?utf-8?B?SHBWWWRJSGhxWFJDOEJZSEtLM1ZJV2U4VWY3RUZDTWlEUWM3aThhdk9nTndu?=
 =?utf-8?B?NmRVTlpZcmJkY21DaUwyK0c1emJ5U0kxZi91M08rdFA3c090a25GeEZEVC95?=
 =?utf-8?B?Ujlma0ZVWGpRN3N5RXpCck4yYkZXYVZkbVhMS29VL3EvWER1VjdCMnRUbWRm?=
 =?utf-8?B?eXRTVVJITnRMbGlQLy81bnlkNk5PWVNZTFo4cG1sOTk5eStjRGxlOXFIR0lR?=
 =?utf-8?B?MVVFaCtOcExGa1Q4V0VjM0pHL1RJRkV1SitETDhhQ29WN1FaemttY01rNXFv?=
 =?utf-8?B?NzhEdGp5cDllSG82M3RMb2xrN29YeHNlNEVRSDdtU1RDdHl2TWM0bEdGT0ow?=
 =?utf-8?B?UEc0WUNSak1KelpETFI2SXNXV0I3TjU0RVhIOEZZSk81cUhSN1pueWFzMStw?=
 =?utf-8?B?cVRMYUFCd01uNngzSXZnTzFPTTRmVkwrR1lZdnN5a3dKQml6NmRKTVkreUZT?=
 =?utf-8?B?OWZScWtqVkVtNUVjUEhIWjlRL1lweUJHa3hpZFJ6ZXY1Q1laeHJhREVLL2F1?=
 =?utf-8?B?L2ovd1FHeStjWmw1Q1FJdVY2QXc4aUpUTHVSOXo5QkRSYVd1d3k5S3Z5dThz?=
 =?utf-8?B?c2RaUjVIbnRtbFdIb2tIa0x6a015LzZ1eHV1TnlZQ1hzNmdNT01HRDM5MUhC?=
 =?utf-8?B?VTFrWnhxRlhNalpRRlhubnV2RlNNWnBHcVl6a0dlVDVITjJtSGEzT1RWd290?=
 =?utf-8?B?czRPQS9lK0tHelM5ZmVld2pIZzVQcXJTVmdQTWx6Sm15SUFueFhzNE9EOUR4?=
 =?utf-8?B?bDlzdkxMenlMUjZRSmJPUXIwL1I0Y3c4bGJOT3BndkJIQ3RrbFhIYksvQ0Nw?=
 =?utf-8?B?bFZlUno4MG0vSnJJRGJycjFoQ1FTVThoT1p5VmlwR0JmNkUrdGZUYnA2UWlS?=
 =?utf-8?B?RzFBcG9GUVlUdFh2VXVqVmpoVlBUWGd5WFRLU3p3TVJUSEhhc3NGdjBocjRZ?=
 =?utf-8?B?dHluWWd0MVZmTW1QOHJDWkhPZkVZVGorYWRkcjBYU0hLWDlIcVpoSFJ4L1cw?=
 =?utf-8?Q?E0rkekKYaOsg+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGQrSVpsTUxxYjJwTzlkK0czZDJpN0R6Nzg1TWxsU29laE5qaWM5YmJMV3Yr?=
 =?utf-8?B?VnJHcEwzWGpMUVljcjd1dHY1NnFFdmR6R0JQUS92Z2JwK1FlM2tmQmZKZkFO?=
 =?utf-8?B?ZzJIVGZQTFNRR09OVTJ2cmhuVzdGK29STktTVm9PNnhpSExiaHplNDhXQ1gv?=
 =?utf-8?B?aU51NE81bkpMVlhMNVpTL3h3WjRqWG9FTXJlbEJQSzVxU1NaZ0ZxaGF1aVM4?=
 =?utf-8?B?ekc2RFdIZTNKTk9SU3gzM01HZE9qMWNMZ1dGT2ZBYTkzd3F5TXE3VHpTMWZZ?=
 =?utf-8?B?MHZJR2VleGhyR2lxSkxNYUVnejRsc2hram9ycElWRGFxb3hGeTYyNGVuazBV?=
 =?utf-8?B?NFpXam1iQnVoTmRTUGhyR0hqdW1ucnpqZ0c3U1NQdmdJVmFDUVJMZmVLVDNW?=
 =?utf-8?B?eDBwcDdCYnd5WExYeWNIZXFLMnFIVUZXVVBiN3Q4c2YwcTFGV2E5RWl3UUEx?=
 =?utf-8?B?dFRCUGdldnVYT21Yb1Q4RVVHbkU0cmx3Slc4MzVZbWtzYzhOWDUreld1RzNl?=
 =?utf-8?B?UDFaSDNoZjdZV2RNSnRkWllxamp2eDQ4VGxPcHNnUmF3MnpvZEZOUzBid1Q0?=
 =?utf-8?B?MWxuR25iUG82dytMZEpKbndFdG5pNkxkUEpqMWVHQWQxWUVHT2E0cXZVM3d5?=
 =?utf-8?B?bWsxdjV1ZmEwcXU4WEhuV0NzV1piQXBydTJwNnNBRmZlb0NNbEc1VDZibXNz?=
 =?utf-8?B?UGs3V0orMDMzNkU4dTFmbXhFb0NGMGVCNVRnYVB1dUpOVDNoWHlkMlh1R1ZD?=
 =?utf-8?B?VG5OL0FxYzBQaDZoT1pQZUNoMTR2Z3BkcUlmNzYwbExHeFdzQ1Q0OTJxRjZ1?=
 =?utf-8?B?Mk1UTnl4WUlRR2d2UjY1Ty9BS0xZcFNibTlwS3VHOTBiMkl1a0JsMjl3QzF0?=
 =?utf-8?B?ekcrRnRXUkthRHVJM3hBaEo5S1d3YmluaWhCaFUrWUphVDc5bHZheldkdHhR?=
 =?utf-8?B?eDY0YjNTSS9GQzcwamZiQ2VaaytabGFGN3JCR1BBMTJ1RVZlQXBNY29HNHVP?=
 =?utf-8?B?NE1IZ3h3a3o5UUcxRVBKRDB1bHNxY2ZtSjVWZitZbUxWWWlhajl0V1hqRW0y?=
 =?utf-8?B?UXJUZjBwVmhLMmloV1o3enEwa3RrVE5iQWp3VndxVk51dCtOQzlEeEs2STc3?=
 =?utf-8?B?VUhGazNIWmFaR01yTzBFU3hScnJiclpmR2VUc0hLcTdseU1mbVZMUTViVW9J?=
 =?utf-8?B?eGo1MGFJS2JmekZmV0RIdGh6TzRxZjJYRjNpS3JPSUtIV0UrRkt5OUdMK1Bn?=
 =?utf-8?B?NmV5TzI2WDJZd0ZSbFFTUU1Ea2hXVWFabkp4NFBPK1VBK3FaOExsUWk0azFt?=
 =?utf-8?B?UkxIbjFKdERzL21uRmxJa3NxRUUzd2dOZXRvSUcrUGlIZXlHSWV0c1Q5N1kz?=
 =?utf-8?B?UHNySXZyVitINHNkai9XRVQrampneDZQNWwyU2lXdU1KRWIxOUxtcTlDSWZt?=
 =?utf-8?B?VFRkRC9rb2hHZEhsKzI3bE1uWGIxcVorbURORUg4Q1VmMHZ3WHk3ZVh2ZjZq?=
 =?utf-8?B?N2kwUmEwZEw3UWVZTXJ1Um1zdlI0LysrY1lzTnJpVnFVaGV5b0huVkF2ZXA0?=
 =?utf-8?B?MHJnd05sd1oxQmNyTkVWMGszaU12Rnk2R3NvZTJEUEF1eEZBNktTc0dKUEs0?=
 =?utf-8?B?WUdCOVcyUTc0UzJpcXFXOTMzS1FvakNJOThEbnpjbjljZGFGL3NFejhzYmFx?=
 =?utf-8?B?RHpBQ0xhZXdSV2Rlb0lQWHpReUhvR2xoMkVud05lQlROSjFLa0VtY3kzdk9K?=
 =?utf-8?B?cllLZXdvRDI3aTdqNkMyd1NnMVMzdGlZVUhwVTg2L3M4MDBOMXhuYUJhTmk3?=
 =?utf-8?B?M01mVHpWYWZ4N04xVktrSmw0ekNwTUhJZmpZdlQ1WU8vTmxRZGNjdGI0NUV0?=
 =?utf-8?B?U3Myb1Q3dVRod1M3V1R3UG9UcDU3NUhobkwvSmVVV1k0bWJsOXUzTDdvVU5s?=
 =?utf-8?B?blFhNm9zMFJEUGZRd3pFZExLc1hKOTE5a1lDK0c4dUU3TGdrQU91bVpJQVda?=
 =?utf-8?B?dFdTVEJLSmxPSDRDUUt1NVhJTjhxZi9vTStRZ0lsK0lnVmRqcXhQNGhJRXBW?=
 =?utf-8?B?cXBlQVVZeDd6eWJvYnFpdndBUkdCTm9OalRncE1nZWdTakpXZUJJd2tGUTR6?=
 =?utf-8?Q?Hu9H7RtNNohozslD3IzYnZ/T9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebefa6a-5f31-49e7-ed8f-08dcfce4a02b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 15:23:25.5134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yB1ix8m1RuGDG35RdhQ5j7OKEGwlHLcLRXkyWChCBTDg1tQYbmLvselbVDyJD3BtUYoo2oliEI5x7dxp8jn4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9430

Changes in v10:
5/5
- replaced the u8, u16, u32, u64, with __u8, __u16, __u32, __u64 in
  'include/uapi/linux/se_ioctl.h'.

4/5
- No change

3/5
- No change

2/5
- No change

1/5
- No change

Reference:
- Link to v9: https://lore.kernel.org/r/20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com

Changes in v9:

4/5
- change se_if_remove function signature, required after rebase to v6.12-rc1.
- move the info->macros to a structure "struct se_if_defines if_defs".
- Removed "info" from "struct se_if_defines if_defs".
- Moved "mem_pool" from "struct se_if_defines if_defs" to "priv".
- Fetching "info" using container-of.

5/5
- Fetching "info" using container-of.
- Fixed issue reported by sparse.

Reference:
- Link to v8: https://lore.kernel.org/r/20241015-imx-se-if-v8-0-915438e267d3@nxp.com

Changes in v8:

5/5
- Remove the check for SE_IF_CTX_OPENED.
- replaced dev_ctx->priv-dev, priv->dev, whereever possible.
- func "if_misc_deregister" moved before func "init_device_context".
- func "init_device_context" before func "se_ioctl_cmd_snd_rcv_rsp_handler".
- func "se_if_fops_write" and "se_if_fops_read", are moved after func "se_ioctl_get_mu_info".
- non static functions "se_dev_ctx_cpy_out_data, se_dev_ctx_shared_mem_cleanup & init_device_context" are moved static and local scope.
- Removed back & forth between the two structs "struct se_if_device_ctx *dev_ctx" and "struct se_shared_mem_mgmt_info *se_shared_mem_mgmt"
- removed the NULL check for bdesc.
- fops_open, is corrected for acquiring the fops_lock.
- Fops_close, mutex unlock is removed. Infact check for waiting_rsp_clbk_hdl.dev_ctx, is removed.
- sema_init(&dev_ctx->fops_lock, 1);, replaced with Mutex.
- structure member se_notify, is removed.

4/5
- removed initializing err to zero in func ele_fetch_soc_info(),
- replaced 'return 0', with 'goto exit', if the condition (!priv->mem_pool) is true.
- replaced "struct *dev" with "struct se_if_priv *priv", in base_message API(s) and others.
- Created a separate structure "struct se_if_defines" to maintain interface's fixed values like cmd_tag, rsp_tag, success_tag etc.
- removed the macros "WORD_SZ", "SOC_VER_MASK", "DEFAULT_IMX_SOC_VER", "RESERVED_DMA_POOL".
- Added handling for "ctrl+c", by postponing the interrupt, till the response to the "command in flight" is received.
- Removed the mutext lock "se_if_lock".
- furnction prototype for "se_save_imem_state" and "se_restore_imem_state", is changed to pass "imem" by reference.
- Added a new structure "struct se_fw_load_info", dedicated to contain FW loading relevant info. It is a member of struct info_list.
- split "imem_mgmt_file_in_rfs" into two "prim_fw_nm_in_rfs" and "seco_fw_nm_in_rfs", to be part of "struct se_fw_load_info".
- moved the function "se_load_firmware" prior to func "if_mbox_free_channel".
- function "se_load_firmware" is updated to use "request_firmware", instead of "request_firmware_no_wait".
- function "se_load_firmware" is updated to load "primary" fw image, if the imem_state is not BAD. Then load the "secondary FW" image.
- Added a new mutex_lock in the function "se_load_firmware", for ensuring FW loading done once, when there are multiple application are in play.
- instead of "wait_queue_head_t wq", used "sruct completion".
- add devm_add_action with action as se_if_probe_cleanup.

Reference:
- Link to v7: https://lore.kernel.org/r/20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com

Changes in v7:

5/5
- struct se_clbk_handle, is added with a member struct se_if_device_ctx *dev_ctx.
- func call to ele_miscdev_msg_rcv() & ele_miscdev_msg_send(), are removed.
- func se_ioctl_cmd_snd_rcv_rsp_handler(), is modified to remove the func call to ele_miscdev_msg_rcv() & ele_miscdev_msg_send()
- func se_ioctl_cmd_snd_rcv_rsp_handler is callig func ele_msg_send_rcv(), instead.
- Mutext "se_cmd_if_lock", handling is removed from this patch.
- func ele_miscdev_msg_send() is replaced with func ele_msg_send(), in fops_write.
- func ele_miscdev_msg_rcv() is replaced with func ele_msg_rcv(), in fops_read.
- fops_open is modified to create the new dev_ctx instance (using func init_device_context()), which is not registered as miscdev.
- Only one dev_ctx is registered as miscdev and its reference is stored in the struct se_if_priv, as priv_dev_ctx.
- Separate func cleanup_se_shared_mem() & func init_se_shared_mem(), for shared memory handling part of struct dev_ctx.
- Input param for func(s) ele_msg_rcv(), ele_msg_send() & ele_msg_send_rcv(), is replaced from struct se_if_priv to struct se_if_device_ctx.

4/5
- A new structure is defined name struct "se_clbk_handle", to contain members processed in mailbox call-back function.
- "struct se_if_priv" is modified to contain the two structures of "se_clbk_handle" - waiting_rsp_clbk_hdl & cmd_receiver_clbk_hdl.
- func ele_msg_rcv() is modified to take a new additional input reference param "struct se_clbk_handle *se_clbk_hdl".
- func ele_msg_send() is modified to take a new additional input tx_msg_sz.
- func ele_msg_send_rcv(), is modified to take 2 more inputs - tx_msg_sz & exp_rx_msg_sz.
- func se_val_rsp_hdr_n_status(), is modified to take input of rx_msg buffer, instead of header value, as input param.
- each caller of the func ele_msg_send_rcv(), is sending these two additional input params.
- func se_if_callback(), is modified to work on two structures of "se_clbk_handle" - waiting_rsp_clbk_hdl & cmd_receiver_clbk_hdl.
- Variable "max_dev_ctx", is removed from info & priv struture, as well its usage.
- New member variable "se_img_file_to_load", is added to structure "priv".
- Other member variables - rx_msg(ptr), rx_msg_sz, completion done & list of dev_ctxs, is removed from priv struture, along with their usage.
- func se_resume(), updated to wakeup the two "wq", part of "struct se_clbk_handle": priv->waiting_rsp_clbk_hdl & priv->cmd_receiver_clbk_hdl.

3/5
- Node name is changed from senclave-firmware@0 to "secure-enclave"

2/5
- Node name is changed to "secure-enclave".

Reference:
- Link to v6: https://lore.kernel.org/r/20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com

Changes in v6:

5/5
- replaced scope_gaurd with gaurd.

4/5
- replaced scope_gaurd with gaurd.
- remove reading the regs property from dtb.
- Added NULL check for priv data fetched from device, as a sanity check, for ele_base_msg apis)

3/5
- replace firmware with senclave-firmware.

2/5
- replace firmware with senclave-firmware.
- drop description for mbox
- Replaced "items:" with maxItems:1 for "memory-region"
- Replaced "items:" with maxItems:1 for "sram"
- remove regs property.
- remove "$nodename"

Reference:
- Link to v5: https://lore.kernel.org/r/20240712-imx-se-if-v5-0-66a79903a872@nxp.com

Changes in v5:

2/5
- updated the description of mboxes
- updated the description & items for mbox-names.
- updated the description of memory-region
- move "additional properties: false" after allOf block.
- removed other example except one.

4/5
- Corrected the indentation in Kconfig.
- info members:mbox_tx_name & mbox_rx_name, are replaced with macros.

5/5
- Replaced "for  secure enclaves", with "for secure enclaves"
- Replaced "user space" with "userspace".
- End the line "[include]<linux/firmware/imx/ele_mu_ioctl.h>" with a period.

Reference:
- Link to v4: https://lore.kernel.org/r/20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com

Changes in v4:

1/5
a. Removed - from EdgeLock Enclave.

b. Removed , after "Each of the above feature,"

c. replace "can exists" with "can exist".

d.
-messaging units(MU) per SE. Each co-existing 'se' can have one or multiple exclusive
-MU(s), dedicated to itself. None of the MU is shared between two SEs.
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs.
 Communication of the MU is realized using the Linux mailbox driver.

e.
-All those SE interfaces 'se-if' that is/are dedicated to a particular SE, will be
-enumerated and provisioned under the very single 'SE' node.
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").

f. Removed ",". Replaced for "Each 'se-if'," with "Each se-if'.

g. removed ","
-  This layer is responsible for ensuring the communication protocol, that is defined
+  This layer is responsible for ensuring the communication protocol that is defined

h. removed "-"
-  - FW can handle one command-message at a time.
+  - FW can handle one command message at a time.

i.
-  Using these multiple device contexts, that are getting multiplexed over a single MU,
-  user-space application(s) can call fops like write/read to send the command-message,
-  and read back the command-response-message to/from Firmware.
-  fops like read & write uses the above defined service layer API(s) to communicate with
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
   Firmware.

j. Uppercase for word "Linux".

2/5
a. Rephrased the description to remove list of phandles.

b. Moved required before allOf:
+required:
+  - compatible
+  - reg
+  - mboxes
+  - mbox-names
+
+additionalProperties: false
+
 allOf:

c. replaced not: required: with properties: <property-name>: false.
   # memory-region
-      not:
-        required:
-          - memory-region
+      properties:
+        memory-region: false

   # sram
-    else:
-      not:
-        required:
-          - sram

d. Reduced examples. keeping example of i.MX95.
e. node-name is changed to "firmware@<hex>"

3/5
- node name changed to "firmware@<hex>".

4/5
- used sizeof(*s_info)
- return early, rather than doing goto exit, in ele_get_info().
- Use upper_32_bits() and lower_32_bits()
- use rx_msg here instead of priv->rx_msg
- Moved the status check to validate_rsp_hdr. Rename the function to "se_val_rsp_hdr_n_status"
- typecasting removed header = (struct se_msg_hdr *) msg;
- Converted the API name with prefix imx_ele_* or imx_se_*, to ele_* and se_*, respectively.
- Removed the functions definition & declaration for: free_phybuf_mem_pool() & get_phybuf_mem_pool()
- removed the mbox_free_channel() calls from clean-up.
- Flag "priv->flags" is removed.
- Converted the int se_if_probe_cleanup() to void se_if_probe_cleanup().
- Replaced NULL initialization of structure members: priv->cmd_receiver_dev & priv->waiting_rsp_dev , with comments.
- Removed the function's declaration get_phy_buf_mem_pool1

5/5
Changes to Documentation/ABI/testing/se-cdev.
a. Removed "-" from "secure-enclave" and "file-descriptor".

b. Removed "-" from "shared-library"

c. Replaced "get" with "getting".

d. Added description for the new IOCTL "send command and receive command response"

e. Replaced "wakeup_intruptible" with "wait_event_interruptible"

f. Removed ";"

g. Removd "," from "mailbox_lock,"

h. Replaced "free" with "frees"

i. In mailbox callback function, checking the buffer size before
copying.

Reference:
- Link to v3: https://lore.kernel.org/r/20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com

Changes in v3:
5/5:
- Initialize tx_msg with NULL.
- memdup_user() returns an error pointer, not NULL. correct it by adding check for err_ptr.
- new IOCTL is added to send & recieve the message.
- replaced the while loop till list is empty, with list_for_each_entry.
- replaced __list_del_entry, with list_del.
- Removed the dev_err message from copy to user.
- Removed the casting of void *.
- corrected the typcasting in copy to user.
- removed un-necessary goto statement.
- Removed dead code for clean-up of memory.
- Removed un-mapping of secured memory
- Passing se_if_priv structure to init_device_context.
- Updated the below check to replace io.length with round_up(io.length).
	if (shared_mem->size < shared_mem->pos|| io.length >= shared_mem->size - shared_mem->pos)
- Created a function to cleanup the list of shared memory buffers.
- Used list_for_each_entry_safe(). created a separate functions: se_dev_ctx_cpy_out_data() & se_dev_ctx_shared_mem_cleanup()

4/5
- Changed the compatible string to replace "-ele", to "-se".
- Declaration of imx_se_node_info, is done as const in the whole file
- Remove the unused macros from ele_base_msg.h
- Remove the function declaration get_phy_buf_mem_pool1, from the header file.
- Replace the use of dmam_alloc_coherent to dma_alloc_coherent
- Check for function pointer, before calling the fucntion pointer in imx_fetch_se_soc_info
- Removed the unused flag for SE_MU_IO_FLAGS_USE_SEC_MEM.
-  Removed the unused macros WORD_SZ
- instead of struct device *dev, struct se_if_priv *priv, is used as argument to the funtions:se_save_imem_state, se_restore_imem_state, imx_fetch_se_soc_info
- Removed ret from validate_rsp_hdr.
- changed the prefix of the funtion: plat_add_msg_crc and plat_fill_cmd_msg_hdr.
- indentation correction for info structures.
- remove the check for priv not null from se_if_probe_cleanup
- Removed the casting of void *.
- se_load_firmware function is corrected for not freeing the buffer when allocation fails.
- Checking if get_imx_se_node_info() can return NULL, in se_if_probe()
- imem.size has type u32. return value from se_save_imem_state() will be assigned to imem.size in case of success only.
- removed the flag un-setting in case of failure. priv->flags &= (~RESERVED_DMA_POOL);
- removed the function call for devm_of_platform_populate(dev);
- Checking for not-NULL,  before calling the funtion pointer se_fetch_soc_info.
- Removed the checking for reserved memory flag, before freeing up the reserved memory, in se_probe_if_cleanup.

3/5
- Changed the compatible string to replace "-ele", to "-se".

2/5
- to fix the warning error, replaced the "-ele" & "-v2x" in compatible string, to "-se".
- Added an example for ele@0 for compatible string "fsl,imx95-se"

Reference
- Link to v2: https://lore.kernel.org/r/20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com

Changes in v2:

4/4
- Split this patch into two: 1. base driver & 2. Miscdev
- Initialize the return variable "err" as 0, before calling 'return err', in the file ele_common.c
- Fix the usage of un-iniitialized pointer variable, by initializing them with NULL, in ele_base_msg.c.
- Fix initializing the ret variable, to return the correct error code in case of issue.
- replaced dmam_alloc_coherent with dma_alloc_coherent.
- Replace the use of ELE_GET_INFO_READ_SZ, with sizeof(soc_info).
- Replaced -1 with -EPERM
- Removed the safety check on func-input param, in ele_get_info().
- fix the assigning data[1] with lower 32 address, rather than zero, for ele_fw_authenticate API.
- Correctly initializing the function's return error code, for file  ele_base_msg.c.
- replaced 'return' with 'goto'.
- Use length in bytes.
- Corrected the structure se_msg_hdr.
- Moved setting of rx_msg  to priv, into the function imx_ele_msg_send_rcv
- Will add lockdep_assert_held, to receive path, in v2.
- corrected the spacing at "ret  = validate_rsp_hdr"
- FIELD_GET() used for RES_STATUS
- Re-write the structure soc_info, matching the information provided in response to this api.
- The "|" goes to the end of the previous line.
- Moved the locking and unlocking of the command lock to the caller of the function.
- removed the safety check for device private data.
- Structure memory reference, used to read message header.
- In the interrupt call back function, remove assigning waiting_rsp_dev to NULL, in case of response message rcv from FW.
- do while removed.
- replaced BIT(1) for RESERVED_DMA_POOL, to BIT(0)
- The backslash is removed while assigning the file name with absolute path to structure variable.fw_name_in_rfs =.
- Update the 'if' condition by removing "idx < 0".
- mbox_request_channel_byname() uses a "char" for the name not a u8. Corrected.
- devm managed resources, are not cleaned now, in function se_probe_if_cleanup
- Used dev_err_probe().
- Used %pe to print error string.
- remove "__maybe_unused" for "struct platform_device *enum_plat_dev __maybe_unused;"
- used FIELD_GET(), for  RES_STATUS. Removed the use of MSG_TAG, MSG_COMMAND, MSG_SIZE, MSG_VER.
- Depricated the used of member of struct se_if_priv, bool no_dev_ctx_used;
- Moved the text explaing the synchronization logic via mutexes, from patch 1/4 to se_ctrl.h.
- removed the type casting of info_list = (struct imx_se_node_info_list *) device_get_match_data(dev->parent);
- Used static variable priv->soc_rev in the se_ctrl.c, replaced the following condition: if (info_list->soc_rev) to if (priv->soc_rev) for checking if this flow is already executed or not.
- imx_fetch_soc_info will return failure if the get_info function fails.
- Removed devm_free from imx_fetch_soc_info too.

3/3
- Made changes to move all the properties to parent node, without any child node.

2/4
- Use Hex pattern string.
- Move the properties to parent node, with no child node.
- Add i.MX95-ele to compatible nodes to fix the warning "/example-2/v2x: failed to match any schema with compatible: ['fsl,imx95-v2x']"

1/1
- Corrected the spelling from creats to creates.
- drop the braces around the plural 's' for interfaces
- written se in upper case SE.
- Replace "multiple message(s)" with messages.
- Removed too much details about locks.

Testing
- make CHECK_DTBS=y freescale/imx8ulp-evk.dtb;
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-se.yaml
- make C=1 CHECK=scripts/coccicheck drivers/firmware/imx/*.* W=1 > r.txt
- ./scripts/checkpatch.pl --git <>..HEAD
- Tested the Image and .dtb, on the i.MX8ULP.

Reference
- Link to v1: https://lore.kernel.org/r/20240510-imx-se-if-v1-0-27c5a674916d@nxp.com

---
Pankaj Gupta (5):
      Documentation/firmware: add imx/se to other_interfaces
      dt-bindings: arm: fsl: add imx-se-fw binding doc
      arm64: dts: imx8ulp-evk: add nxp secure enclave firmware
      firmware: imx: add driver for NXP EdgeLock Enclave
      firmware: imx: adds miscdev

 Documentation/ABI/testing/se-cdev                  |   43 +
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   |   91 ++
 .../driver-api/firmware/other_interfaces.rst       |  121 ++
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   17 +-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   13 +-
 drivers/firmware/imx/Kconfig                       |   13 +
 drivers/firmware/imx/Makefile                      |    2 +
 drivers/firmware/imx/ele_base_msg.c                |  279 ++++
 drivers/firmware/imx/ele_base_msg.h                |   94 ++
 drivers/firmware/imx/ele_common.c                  |  333 +++++
 drivers/firmware/imx/ele_common.h                  |   51 +
 drivers/firmware/imx/se_ctrl.c                     | 1331 ++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h                     |  134 ++
 include/linux/firmware/imx/se_api.h                |   14 +
 include/uapi/linux/se_ioctl.h                      |   96 ++
 15 files changed, 2629 insertions(+), 3 deletions(-)
---
base-commit: 607c67544a955d27a91698aaa00a5f7fd0d7d14c
change-id: 20240507-imx-se-if-a40055093dc6

Best regards,
-- 
Pankaj Gupta <pankaj.gupta@nxp.com>


