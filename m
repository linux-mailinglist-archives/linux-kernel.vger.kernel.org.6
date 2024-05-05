Return-Path: <linux-kernel+bounces-169170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B16A8BC46E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA69C1F2150B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1CA136E29;
	Sun,  5 May 2024 22:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EmgbG2++"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58891339A2;
	Sun,  5 May 2024 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714947298; cv=fail; b=KrHRix8e0FXIB6IYVuOuCStIxUPe5xJHYfCQkcpmZoQLG8+WmrciRo2dAwqHFBY32rBp/lerAQqxs+uG31o7c55y+WwTZVDC+pVs0umU7bQSuhJyvw50draeyIJs9rn7c+JMtmXXuvaU6oX5CH/dGBCRqnj4PmNage96Bp1PTlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714947298; c=relaxed/simple;
	bh=zQKQnJYq00b4ywnw0trq+X1cuAKPBNOPke9h7IK9L7k=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=O0jtWvEFjrRnBYeogWyvVspbrysCW4bxhEr7eHEcwl85ItMj+eBf3m+3W1yQagWvDzKMNFKEATKKirmq/3+MUVZfzbF6W0rzjo48jiJSGTTfl0nmT2jMmn/YJ9G4an16o3KkqIRCLa/T2owr9ukLPb60V7hyLsC6zwjiIw3z3jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EmgbG2++; arc=fail smtp.client-ip=40.107.7.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYJgjxthWJwX1KIO7j8n2F1lH5KOoluzOuvcPZTEO4DAmj4f+EbN2FkvXET2R+MIa7lwBWDuhDQg3OQzobSscuayCCvk3qrf9YnZfNcwtYORn7sugzGsXIMq3hJAwmFiyHf9XwrqCz4uoGl4TRVo5FfcCYILQ+JujnegTpO+LaIRFa/bJbJqPFiJbuuhTao7X24XWZG/rs94dLw4mZZ52CVrttQjHDlJwGLJHEYxx2BhR5uRa+29ALoaV6nG4JdbZ/xrHZF61/EkqEQYdlam/+fpDBYPqw4cD3O7XpmGemmXZ0rfGIwgpwQq2br24h3284s/2jsezoqZ/aS4XE6jMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck/pERlRKZVZK4I8QpTViZ/KGHgdSzAa1jW/z4kfFo0=;
 b=VUtxQ2JgycxAhrS+5Ig2hQmtKeItqkh3YODdCCCX5PHqbAZXKB8jWU5sz8+Rp6Ge/TTLa8jerSP3zOulbk2boJ1LLTe93Vu6Z2PAzmL0MrPV+A7bNE7qGvdNl/Cvw6y7vEfqgLtz6KaXLHBcRohEkuBeH2+WLGE4lAqcqi0n+elBe41S3ig17x3M8tuTd34c21p0PkxiZvOm9utUSZl7P6u3+tPFLzsWOHseDJ7WpyYUY3Sz7WBpwQIyYrM9aw3YFLtPHZZnQCL09yyHEDXpEjUJeaHc3QXWsSzR8kfruX5wLuEGK33LBfyXYejw3o7IsSNTPxlFnX7JTHchKKLdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck/pERlRKZVZK4I8QpTViZ/KGHgdSzAa1jW/z4kfFo0=;
 b=EmgbG2++2R1cA9vZYRBXVLhey6JsJLnQyjcsYvWjgRi8C8uGtv4ArrjNNSLVzEhcHvqFtNPpWfqB6axEHgCgTKdzut24oThwvv4Nozia7+mzIBn6KkbOrjbFvazBBou6fdx81qkADbi4/NgzRxGic2r/cZor1ImQ9QqQuBARaGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6818.eurprd04.prod.outlook.com (2603:10a6:208:186::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 22:14:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 22:14:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v5 0/3] arm64: dts: add i.MX95 and EVK board
Date: Mon, 06 May 2024 06:22:42 +0800
Message-Id: <20240506-imx95-dts-v3-v5-0-5ec9b99cfb2f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALIGOGYC/3WMywrCMBBFf0VmbSQkGdu48j/EhWkmdhZ9kJRQK
 f13024KgnA358I5CySKTAlupwUiZU489AXwfIKmffVvEuwLg5LKSKNqwd1sUfgpiayFI0IbJCF
 aB0UZIwWe99zjWbjlNA3xs9ez3t4/oTIpqitqi6GunQ33fh4vzdDBlsnmUFHqH9UUFTV63yjnq
 dKHuq7rF5JJZUDhAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Peng Fan <peng.fan@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714947780; l=2329;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=zQKQnJYq00b4ywnw0trq+X1cuAKPBNOPke9h7IK9L7k=;
 b=jXcKMtGAe/rZSRhHIgK3i2GU+jH0UZuG16PzvWiqDau0GaCbqyZKAwT7SsYaQ0+p87X4k/rio
 p9MJBjGvHZPCk5MU+AhQLtTOFOw/lpUIfImLHj4h3uzm/ZlvpoKlXAi
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: e1dcd4fe-2fd8-4af8-1167-08dc6d50c928
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|1800799015|7416005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGF4eHBTb3FwTzlTYzhneGJPVHlzM1lhS0J6Q3ZmS3praURoUUxxejdaNklo?=
 =?utf-8?B?K09rWmtPYjJyVHhYVG5mbmd2Ky9vT0g2RnRja0dKcFhzY3FaU3U3R2NFSUto?=
 =?utf-8?B?b3JSdnFIeGdFeDMxbVgyY3VIbTBTSkFOU3NXeFVCSkZiSTNlNTZjbjNtRmF2?=
 =?utf-8?B?bUd4WFMrWEYvaVVDbW00WWJnakhlVldTbTVwKzBjL3EyOEFzalhYNzY4MytQ?=
 =?utf-8?B?ekFlQjJXSFpvYXJDakNReWlTRDZLMkxkS1l3NzA1U0dTSldLNEltT24vZzZr?=
 =?utf-8?B?eC9pc2lEaWo3Vy9pTWZNZHlNd0VPcDJwZEZRdXROaGFwT29ta2lDQnJTa05z?=
 =?utf-8?B?ZGJXKy9CbVMxVFJEWDFsVkhadWpLNmYyZTR0Z0FvbXJkT2cwVnpZallsYWs5?=
 =?utf-8?B?aVU4NCtyWTJaeWlSZG5ZR0FVNjdySVdIWUVINTI2cGdNVzk0T0VBWFQ0cXpq?=
 =?utf-8?B?eXZMY3MxQmVJUEJ3WmphNTdXWWc5V1RhbW54TGVzMG9VYy9aN1JEVE9oQ1hK?=
 =?utf-8?B?UE9CcGZYNjBjdStKM0pNcWhwQW81WG9IWmtkN2I1Uys4NFNKWHV1YktDZkZT?=
 =?utf-8?B?eFlWQU9uSDdBOGVwVEc2UjEzK0l1RmVSQ1liZTVSc3VvcmIyVktZeWNrRU5H?=
 =?utf-8?B?dWFOWUxpeUZTV3Z6ako5ZjZ2S1BMMUNYVHBtWS9yRU5RSEZrTjlSWDlvTERB?=
 =?utf-8?B?Y3ovamU2ckRiQzE0UlgyeTNEdHc3TW8vYTU4RnlBb0JPektxQ0J6NjVBRlNS?=
 =?utf-8?B?eTR1Y0lCTUE4dko0Sms4MnhJcjJGdGlGV3AyelUyWGx2T211Zkp4NWdncnFM?=
 =?utf-8?B?VXdPUlVEbytWQUVLSFFSSTNwcXRyMUU2SHVaVG9NN2ZlRERJd0VRdWRYS2k0?=
 =?utf-8?B?cHd2VjM5ZVZlOFA0cjkwZGhjYy9oNDJXamJlNi95dkQyTndNTjVaTzNjdk5N?=
 =?utf-8?B?V0dXSjBmN25HVUh0TlZBZEZtMzI0UFZWWDUrUkZFeVFqNmlBRHRmY09sV3B2?=
 =?utf-8?B?UzBkUXdLeHNpdU1rR1o5dmJqVU9EMk5sVEhUWXZYNng0MmVpL3BZc3BXb3NL?=
 =?utf-8?B?enFHV1RpbFNWOXBLNTNXTVhSUk5qdlN5TUZTSDErRC9tY2U4ZGVOZDRkK3J4?=
 =?utf-8?B?cC9ndE9QNDZGZGJmK2RPbVpNRGEra0paelBpUVEzQlBoOUhJWWxtcG9HWEZj?=
 =?utf-8?B?UkNzNndhQU9wRkpTcC9HTGJxVHByN3NUNlhKZzl0WlJ6VkF3d0ZCeGFNY3ky?=
 =?utf-8?B?WEdJMXA4a21VRU0rMHJvUlQ3R2tBUGxBVDZPZ1lMSXVWMFN2ZGpyNVo3UWlz?=
 =?utf-8?B?NTZvajdVL2JaZkJvWEFJZGJvaWV4cjl2eTR3UkczUS9seDR2VVlJenFGSEdQ?=
 =?utf-8?B?RkErdm96NlBxZ1J3aVB1OW4zdFpIbHdSYWg0S1NMaEZKQVozcW5uYXVLU2pw?=
 =?utf-8?B?WjZEYVFnR0FKRGRrdkI4R1Y4aVE5alJ3dkVOTDViTUxwZ3BaOGJxM1ZLMFhU?=
 =?utf-8?B?MGthRVRISGVUQkJJWENEd2xXc2U1dStxT1AxRFhDcURlK3htRUk1ZW10NVdL?=
 =?utf-8?B?dExnTjBqQkI2S1MrY1JEdnduLythTFhxYnk3OW0yNmM1YzNoRDVpbXJDcmVk?=
 =?utf-8?B?YU9kcmFXeTliakFQdVNuZFJka1ZYTWhkbUpjcDE3dHJ4SEtQd1ZYcFZYUThQ?=
 =?utf-8?B?ZFQ1dW1wM1dRY0pUSDFvdDk5aVBGVGxlUXFnazhHSnhuRnVjeVBCVWx3eUJJ?=
 =?utf-8?Q?JDZqffCXe7EGp+Wt5k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDZFQ1hQSFhNM0NucEFrNWN6MnZsbHFnWjhpOXFrVmlPREp2b1N2ZjhxV0R4?=
 =?utf-8?B?UUlsRVY4QmRaWSs2ck9IaTVua3VNdnhmNWc4TE45cU9RSHhCaE1SYzRSd3FN?=
 =?utf-8?B?UkNON2hLbitORGxZamE5eGhKb3ozZ0krOFFqYkdIdkoyZmJEVHcvbmU5ZHdW?=
 =?utf-8?B?MDNudVV5UXpTcXlienN3Wm5rc1dSSTVqOXQ2cVhPN3dJaTRWQVpnOUFJenZu?=
 =?utf-8?B?ZHdJVCt3VVVtQTBmV1BheWNWRi81ellpUU9JK0NNTm9HajdGWC92bU1leFR4?=
 =?utf-8?B?d29OK09iR01UNjREbitjUUZEYTZwa0dkOVJ2WnJwM1lBS2hCbGE1dGpEb08v?=
 =?utf-8?B?VTB4Q2FUZlFYQytmajBmQlNRaWlyU2lNd3l3elUrUDdsQ2Z4cVdQZ3RDMjUz?=
 =?utf-8?B?OFlxUmNkVHhpTE9UVEZSQXlwdzNWVVZ2dG1mN1dRRUZKZEhMRFN2bm5IOXBp?=
 =?utf-8?B?UTNoN29IQlV2MDdPVnpzQzRDL0FQd3Ywb09qeWwwNFlNRDdQUktIV2tpVkY4?=
 =?utf-8?B?VzlyUTFhNzhBeXlyaXhCMk90SVRRNFRNZ1ZwV1NURXJYNXAySFNMc0JwVHZh?=
 =?utf-8?B?NE41NitsR240MDVZdUI3ekt2Vmx1R0lWbitOWU52N09HNWlacWpvYWRvVXNu?=
 =?utf-8?B?WElBcHMyY3I5aHpFQTgvN1JrTlZRZHQ1MWgrUm1kTGZiNHMzVlcreHBld1Yz?=
 =?utf-8?B?Nnh3ZXcrUFFIVTlUUk05VG0rNGQ3cDVKUDVMMGM2WUlrdjhmOXZqU3pOVFZG?=
 =?utf-8?B?bG4xdjdDRVdlRW94bXRpTy8vRER1VXZYaTN5cEtINmNMZEppeks4eEg3UzVa?=
 =?utf-8?B?WEdFaGEwbnJCVnYvRGQ5SzA4a2N2QWFXbVhlZFRHZFFaK3NjNFpEOEU5OHNt?=
 =?utf-8?B?SStMeE1zNWxVcDhUUU9yNXllTDNGVHo5cXhXUERvVEgwZkhMT2dlTEV5a2N1?=
 =?utf-8?B?Ri9NclhrNnFjN0NRY3dCUlQ0U01xcm9YbTFiWnUwNzZPMEQzaEhVc0RZWkp0?=
 =?utf-8?B?TGV5U01hMDVKYzByY05qVDE2VjFmenNmZzJSelBmZTdzZFNEeFBjYVpINWY3?=
 =?utf-8?B?VndpS1djdFAwblJ1amVzL1oxUnc2akNTOGw0RTAxdTk3aHQ4YlhDcEtlOS8r?=
 =?utf-8?B?V0duaTRyQXlLN1RKalJ4TGNONFJJaFVvSXJkamFDWmZ5QWhhY2VqOTJycGxm?=
 =?utf-8?B?aUpyOFlqRGgvZnRUNDgwbi8yWkVGbmp3bGthUlp5bXpiY1ROK0JtcWExVU54?=
 =?utf-8?B?Y2VYZ2U2WUdmSjBRc3ZDOEdVTzE0UEkvbGoxd0ZIUnNvQ2Z1L3JlRW9wRm9k?=
 =?utf-8?B?K2NXTVFBUEF1WjRqRWhTTDdLbmx6azBHZFpKUStlWENuMWJIZXF5V0R3Rnpy?=
 =?utf-8?B?R1VNTkdiMDNGMkZLWWRYZ3VXV09uNTFXVkVzdmkzSlg1SktDQ2NNblE0UzNU?=
 =?utf-8?B?TFA0aHRWUlNpNk8wSXpLSnR0VVVQNjBIblhsaWYyM3BFV3hZalZYNk9rOWM0?=
 =?utf-8?B?c1RHMStzZk83WmdYL0ZScnFJOFNpL0k5RnBYTGdpdW1zWmU2T2VQL3NLa0tQ?=
 =?utf-8?B?SzNkdUFNeHZ6dFlhdDVSNnNuc3ZPVXJyd2hxQUxOdTJvTEFodGlPZVRmQjhY?=
 =?utf-8?B?MEMwc2RVcGtCYnN5K1VKaXVZR0p6M3BuWEhxc0Fwa1RNQi9JU3JTMDFDNlYr?=
 =?utf-8?B?MVAzRW1PaTJqNjhwZnVnakUvV215Y2hGNE5MSEFwaDRaUkdEYWNBS296eTcr?=
 =?utf-8?B?a0VoWXJBdU9rV2tIT2hSUHo3ZzVzTHhlS0tOUmFmcUZSMy9PZHdNeWZqeWhh?=
 =?utf-8?B?WWJwbytNZ09qc01iQTM2eTR0WDlIVk1ORjZRR3VVdk04bzZic29uMVF6Y3VP?=
 =?utf-8?B?RXY1cGtwSG9uR0pQd3dLNmdYUDQvajIrbktCTzFvOTFmaUpYRlFyVU04UWVV?=
 =?utf-8?B?SmhySHhNdzhRV0h0Z2JOMm1uY0pmd0ZVYUo4UW02YjNzZit0QU5vcTRNMmdp?=
 =?utf-8?B?d2ZHcitXRjVZNFg2OFlEZEpWcC9waWVmRWY4Z0JTdVFza2swWHJXbFJQUjFW?=
 =?utf-8?B?aXVqZ29IS25PL1J6SmZCOEpoY2EweVFhdUtZS1lWak5YbmFtMklSbDgvZi9C?=
 =?utf-8?Q?NObpkWLsZdAHfrhoaqkhWZpCC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dcd4fe-2fd8-4af8-1167-08dc6d50c928
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 22:14:52.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0ks7sJgiumluz7xka92u3vdjLt/WfTDkW1NuqnxuQATXFFYQVWMvHrXidHLVuC6T40zddSzN3MeDHuW+G9EfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6818

Add a minimal i.MX95 dtsi and EVK board dts.
i.MX95 has a M33 running SCMI firmware, but as of now, the scmi pinctrl
driver still not ready for i.MX95, so we count on bootloader to
configure the pinctrl for lpuart and sdhc and it boots well. After pinctrl
driver ready, we could move to use scmi pinctrl.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v5:
- Drop unused regulator and alias for now.
- Fix CHECK_DTB warning.
- Link to v4: https://lore.kernel.org/r/20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com

Changes in v4:
- Sort nodes by address
- Drop coresight nodes
- Align clock rates for SDHC1-3
- Drop wdog3 board specific property
- Link to v3: https://lore.kernel.org/r/20240428-imx95-dts-v3-v3-0-765395f88b9f@nxp.com

Changes in v3:
- Drop irqsteer node because binding not accepted
- Pass dtbs_check
- Link to v2: https://lore.kernel.org/r/20240226-imx95-dts-v2-0-00e36637b07e@nxp.com

Changes in v2:
- Addressed Rob and Krzysztof's comments, and fix dts_check issue
  To pass the dtbs_check, need apply:
  https://lore.kernel.org/all/20240226070910.3379108-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130243.3820915-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130516.3821803-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130826.3824251-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240219-imx-mailbox-v8-1-75535a87794e@nxp.com/

- Link to v1: https://lore.kernel.org/r/20240218-imx95-dts-v1-0-2959f89f2018@nxp.com

---
Peng Fan (3):
      dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
      arm64: dts: freescale: add i.MX95 basic dtsi
      arm64: dts: freescale: add i.MX95 19x19 EVK minimal board dts

 Documentation/devicetree/bindings/arm/fsl.yaml    |    6 +
 arch/arm64/boot/dts/freescale/Makefile            |    1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |   70 ++
 arch/arm64/boot/dts/freescale/imx95-clock.h       |  187 ++++
 arch/arm64/boot/dts/freescale/imx95-power.h       |   55 ++
 arch/arm64/boot/dts/freescale/imx95.dtsi          | 1050 +++++++++++++++++++++
 6 files changed, 1369 insertions(+)
---
base-commit: bb7a2467e6beef44a80a17d45ebf2931e7631083
change-id: 20240428-imx95-dts-v3-bee59f0e559b

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


