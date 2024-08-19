Return-Path: <linux-kernel+bounces-292457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 817B6956FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015BB1F215DF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23DB172BCE;
	Mon, 19 Aug 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eYKAB4pj"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4306171E65
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083356; cv=fail; b=oj3FKtdyCAIh2boNfo/Jq2w0JudPBzOS83yA+u97we/zteZ218Qu/+EPhlzojn4hAXSSsejNpTz5V2JzOB923PFeecOV3eKYHi5sVGaG7L74OS6lde7AB+8tIT5eyCkUIJzd5FZUb5xT0dTWl6TrJp8WfxQgy88xSw+BOJhGLbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083356; c=relaxed/simple;
	bh=Hh0q3o0ccZLTR2dgGNnC93iysep2t/1zblPjKc+L/EE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c62t5v4bb7Y2ftKyS3Kfdd+iH3G36SHTfcmZZiS87ediIXFwqATYKpytaChVLVjHjxd3swOr8rkxCJwZYpGoR1TAGYd/R7AxGvb2Z3VITZo1uJJEaktKmvPAuQWrojDxSykkaDVCkyakVfAbLiGOc5bPP4QjtqmWr4/o5aaqO2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eYKAB4pj; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wO8Ml8bpm8pCOMfrFfmKQfvrmmlH7wG2mbUJBWJdZ/waYY/00M/VvbhfEV0Rmp4QsYhpNtcAQUlkUxbRPr4p35tg1/Eym2CTXPIcJNOCuUE9PyH4dp4NEHo0TcpQDf9LeJZZrPTSxC76ijM8jW8zGVpKtp7vXmglASFYGNHfMT+fqTCl0hrGHEMxanwsdlwIDMYqLKrI7aXS8Lunb+Xhw9IjROM2671Nrt09efiblTZHG4pUKEUC1brBO/AdElKMJhiIpO9fjCboIO5RNw926JOrupJMiOjtUH2Q5TmQTclxhyqSihv4fnQfUkokxdEjEdrgN1Ng4DVfu7jp6vGgjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEdVL+pyB93zAIEI3T1O9Db0QOqRxjZN/Oi8sHzMIOo=;
 b=UHxvUSRQOVwVzuPUvg6QdSV3Dg/94AVd/IXLDCpYPU4dhZ4b9aH1D74VLMvCN0woV7Kf6d/rQ0NzpIy8h6TdllfMUSxRBNF47+7umvht8eFQlJIYbLo1C7kCLVPhKXEVhQGPXYraiXyOdKzrGRVNlds3v8E4bViQmOSW40YRDkcEQBg6lyu4O4fTThX1c15YFZm/UgFEBoJGA+VCTabXc+44LcVsxq0Y3Am94LRClIHq7c8r8lW/VDHOPvlVEqWDov6aMExsPtTV0LCHGhYQmrokSvMhzrUetgHXxLfjog/r/GLIrpk/FnX9GH3Fnv1BmedmtF5YOs07zgcEBLqigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEdVL+pyB93zAIEI3T1O9Db0QOqRxjZN/Oi8sHzMIOo=;
 b=eYKAB4pjFgSf3QTFZ0YWxv9roZu0FfoPGqcZfZ+yMRhLeSt919KpVTvR0+JgIP7yyjLx38sRTRxLsMzZ75WssE06IH3K9OxX+XNhiMvmE6pcmiJQ0GhXNVjz6CpsRAupwH71m7/AQJsgEYg+zBgHrquVI5qAPxPKrWvLQQ1kaInvcRZXC3e5YcQUO+UdS2WhJZd0NdVxLnQCBLHoMWD8jDwPYOw6sRsKeGRLQRW6du3U9uWISXEORaA/Nx9gQGhcswayd0/VlNWpi5whSMuiYdzxPxzhJ+ey4WA6nNZPFhyLZGakZzEBq+YCIQy0cH+9EbutyovEJMJzSKTSAHN4gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9659.eurprd04.prod.outlook.com (2603:10a6:10:320::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:02:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:02:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 12:02:04 -0400
Subject: [PATCH v3 10/11] i3c: master: svc: wait for Manual ACK/NACK Done
 before next step
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-i3c_fix-v3-10-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
In-Reply-To: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724083326; l=3150;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Hh0q3o0ccZLTR2dgGNnC93iysep2t/1zblPjKc+L/EE=;
 b=7BuLoeBKoGN+8U+MgzzIxW/CbXsgpGth92q7FZLdgrl75sujgcY3Vn770RRHmPkABe5ZpElHX
 ZKTjPmremckD55edf0juU7bOPzxS60Bd+TmfOVafXzq/946HBi2H9zF
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f76cd1-dbde-48c2-03b6-08dcc068549c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SGJKU29HaHY5MnU4QXBYWUFqVmRtOW1XV042SkxEOWNRR2ZKcXFmUHJIUkVH?=
 =?utf-8?B?cElZV2dqdUNERzBaRS81RG1HN3hYQ2JnQm5tK0dCVXJ2UEMzM3h1K0gyNFIw?=
 =?utf-8?B?QkJUeHN6SlBVbWJURVlWUWxjelRzL3NLYW5QTVhOZG9LRHBGbDY1eFZySTVL?=
 =?utf-8?B?ZlYxSHFRVENDZ21vaXVNUHpqcEIxNEthY25XMktvSWVxME1jK3R5UzErQWpl?=
 =?utf-8?B?djF2SksvZnkrK2s5NG5ZajhQL1Uwb0ZoVlBuZEpVVzhudklPZElxWUxzQWRC?=
 =?utf-8?B?T2JhdGZDL1BqT1JFVWZEc0hHMWt6ek5YTEZZeTBFTkcwdHdOZFZzeXgrMzlC?=
 =?utf-8?B?ME9wODVnYnRTekNDckxqYzlWTFhNNXdzZHVoemsxNTI4RjFBbndtaTZadFFu?=
 =?utf-8?B?d2RIbDRUTDRZb3JQdk9Ua0xLZWthZS9iS0w2b1RXYXZ5eFdYR1h6QjVLcEtl?=
 =?utf-8?B?N3QzYjhnYmdhVENxMytOL01jQTc3cVk2Sm9McENXc251QnNORG5EaXhTbUZv?=
 =?utf-8?B?OHN1eGg1VzBYSlc1enVndzZxNWRHVjJTT3ZiRUJPWDk3OTJuQS9tQThnVU1I?=
 =?utf-8?B?M0QyZk81S0NRd0wyRWRBVmwvM2xUbjZTN0NhcEtUOVNRTkZGTFJYTytsdWF2?=
 =?utf-8?B?Mlo3RXBQVk5YNmg0d2RTQWhHSEV3K0hSbVJPUlFQQ1pIazY4MzZIKzhrMElU?=
 =?utf-8?B?WmdCNjNoTzQ5Sy85R3hTM09vT1NUd2xKMzVEalUxcWxNUENSTmNVMkVVcFRD?=
 =?utf-8?B?M0srQVZLYU5sWFhNNzRIRWswejRFQWloWjZvb3pSeFMzb2NKTEFHTjhWdmNp?=
 =?utf-8?B?bnJmTStORDNaUlpXNEhzSk9pb2gvNGFDbHM2Yzc4NTl0TXVBN3U3MmZFL3NM?=
 =?utf-8?B?MWcwMWduenZNdGZ3Z3FvYXNVV0VyV3NTYWJaamhTTUhLanhzVmF6emRqMDZD?=
 =?utf-8?B?T25HWG9iVldNaW9sZnNMbUNLQjdGRmJaaW1lN2UrK1ZqQnR0dDF3ZHU2V1RT?=
 =?utf-8?B?V01WUEhNbWE0dFhhMlNwdWNUUnlyMWtiYnBRa1ZoUjRaWS9VOVNkTW1HRjJl?=
 =?utf-8?B?V1NDcHFSMjdkUFNBbEdnbFpTK2FlUk9MVzcydGpJTG40WUVzeHg5UklxeE9J?=
 =?utf-8?B?NW1XajR2aUM0bVEzYjJrbXhXY0FnS0tCUDlIQlZPRFZIM0IvNWo5WjZmZThw?=
 =?utf-8?B?aXU4Tklha3FIc1BWMHZDWEhrQnVDU1M1WkNud2VsdGVQdVFsU21BWHRKeE1V?=
 =?utf-8?B?bWRodHpNRlEyWGg3a29rRy9VQWxNOFI1ZnJqTWx3a3FkaUovZjRUcEFrOTVH?=
 =?utf-8?B?TEFlNVRZMVp4REw1K0g1dWY1YkE1R1l1eXJ6dnpRd2U2NkxJdzNvM250T2xW?=
 =?utf-8?B?TnVMZm1SSWZlRkxRcEJ0YzZRb0htYVNRdXUwZ3NtRGQ5cE1DM00rNVp2OGtz?=
 =?utf-8?B?L2syWXVtYmcyRVpudXUzMXQ4V0t3cVdTMmQ3UnFZQjllME5OdHQrYUJSaG5j?=
 =?utf-8?B?WDV0NVpIV3RQOEFFY1hVUzdGSHR6QUVPcXVFd2tDK3JMenIxelp5WXlUeEZN?=
 =?utf-8?B?dkdtUEV1aWo0ZFJhMVc2emVQM2QvVjBwWG1qWUVtdERrbGswaU9TMmQyTHhQ?=
 =?utf-8?B?RzJ3L09oM3FVcmdpbEJ0Y1hYQkhCckM1VWNwUWx0MnpYZEc2cm9aVjFMd0xm?=
 =?utf-8?B?Y0J5M1RPL1B4U3NGSkUwVDBNb2tYYk5RcTN6cnp0QU5vTDlrelJWbWZYdWRv?=
 =?utf-8?B?SEZoM0cwUFNPQ2dRVk5PVTlHUkFyamZNVmdaQWVSQ0trUW9rRTFpejZDZ3d5?=
 =?utf-8?B?QW9lalZRNUtaMDlwZGdObHVhMmFHL2VTOG0rNkZnd2c2bXdYWVZoMGxDWWh2?=
 =?utf-8?B?Qkh5a051MERCVW9Qeit3Q0F6djQ3NlNwVjN1VVVlUXc3b3c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ditZVDBmOW1kUmVyTkFWL0FVWDJSMHFwSVFNUzlnQ2pYRzR4bGYwM1NuVEg5?=
 =?utf-8?B?VWZnQnpJWmIxWUM3NU5YOWtBTHdkeXVnWlRubk1PWm1RVGdYWW1BZHI3bk9X?=
 =?utf-8?B?djAvK2cycS9GZkdBVDNSM1A4QTBVVzRlT1F1enMycFVsc2thMHJWa0xJZmdZ?=
 =?utf-8?B?K3lLMUlUODN2RWxzYzAvMDRTRkpnNmVSL1dFMmc0dmljQ0g3N3lEdkdoVlQr?=
 =?utf-8?B?cHVyNUxoelBsdXNlS3prSkJYT1VmYzFiejRKdjloaTdmQVZQOUN6TGFmSXU0?=
 =?utf-8?B?cU9RS3dsSnZZWmN5ZTU4YzNiQmgyRElvU2hKYVRybFVRc2xYRWdHY0ZIUDgw?=
 =?utf-8?B?YTR6THZlb1hNR3QxVkJEcy9HVHMxcHZ6dzBIUXUrcVZqdklWNW9ESUMrRXlK?=
 =?utf-8?B?cUwwZUp5OFNDdjZWWU01QXdNR1VpUitaL0xteW9LTFI5aklsNHhldzNIWVNB?=
 =?utf-8?B?OHh1MEl4d0RxdGlVUmxSWVlDbEFKRUJyVit0QjZzZVdoOWxwZUxMdm5kL2x1?=
 =?utf-8?B?cDMyQWMxNUNtS2g0a1Y3RkZsbXJCdFh5SVZmSVlFbFVtWG5LZDZpOEFxUkI1?=
 =?utf-8?B?N0c1NTFRZjJJck1pbWNyUGovM2Nlekc0ZGdSNld0QjZ6YndtUXJVMlFiaHZU?=
 =?utf-8?B?Vk1oK1VqS2tqb2VneERxaFo1dm1GaG51S085TmZoYVN6b2Z4ZHlLd1hxZHUv?=
 =?utf-8?B?QXBFaWFTTXBhVnhBR0pXeW9lbi9xY0RXQmJ2ZjBUM1h4VFpjZW5rVHV0Qklp?=
 =?utf-8?B?N2FUKzBOK09sZHVjTHdmbGFuQ0xvUDZMaGRLWm53RlNhcTYvZ1M1aGYybHV6?=
 =?utf-8?B?RjAzSDdyZExoTm52R2hTanM3dWJpMHQvNXk1UVdTUlV1YnpReWpkOTMrNVNn?=
 =?utf-8?B?ZXpzRkVaYzRuU2N4RjVaQ1k5SEZwckl4VU4vaGxWcVp1Wk85WnpWa09nTGpE?=
 =?utf-8?B?Q1gyeUpMWnJ6MkRZa0Rhc051ZTUybmpidXZ0Qmp3QVhRZnZ3c2twMmRRN1BQ?=
 =?utf-8?B?Vzc3em9OTEsyeUc5RFAzS1RnSWg3VkEvODg0T1FMNVYrWS9lWlIycGptWjhy?=
 =?utf-8?B?V0tIeTA0bVpJblR1WXNPOGpDOGxBSFdqc2VNVG1WVlFhbk9UcTFraXVuSEQ1?=
 =?utf-8?B?MzVjemtoR0lLVDQ5a01XdmJPYWNqaFJsNkR2T0U1OWhKLzNGR2VNdVM2OEky?=
 =?utf-8?B?MW5ib1p4OFVkbDZLOWxMcUcweGg2bVd0dFQ1WUNaU3lGdDJucXVBQ0hBdEI5?=
 =?utf-8?B?aVVhQzE3RTVzYnRRa2NKT0M3QWM2dlhFL2c5dGZxSUVpcHU0eHBGaTJ2dTRw?=
 =?utf-8?B?UWhrZGZGUzc5bld2Ymx6ZWpUdWZyZ3pKT29vK2FsWmhpZGNMNHpFa2xrQk8z?=
 =?utf-8?B?bGtvUDl5SkRKUUJZaUhrNDJlY2tlZ1QrRTMyVXMwU2hUck9UQ25hV2xaZ2tn?=
 =?utf-8?B?Y0RKR2dUSjNnL2w2dzJCVjlKWlo0YTJrREQ3cWNiQ0toSE9Ta1JreG9ObFFB?=
 =?utf-8?B?d0VMZXpldllkRE0xMmJsWVBCRW9GMVFPcjZ4K1BPcmxISXA5YUgxNlorL0pv?=
 =?utf-8?B?dTRVK3hlb2JyR1NReENmQWxIaVFjN1loV0c0VkFXTmRpRGI1cGZ0OXl0ZFRa?=
 =?utf-8?B?MnZZdlY0blFaZVhjdVhZbUNnYUFJSDhxb2hKc0NBNHdHaENXYTlZT1JVLy9Y?=
 =?utf-8?B?WmlFSWhBN1lWM3dKOVcxN2cvQXV0MVlBUDk1UW91KzJjaG8xZ1NxQlQ4Yldk?=
 =?utf-8?B?TzdyVkJOd2djZ3hILzZ4clFTTFhUb2JTS0FPVGVzUmkwNFc3TXExc1lRRENh?=
 =?utf-8?B?TzFSWldpbnFKc1BVbkpLLzk4aHc5MlRRMzQvUHpUcXl0N0JRekp1cm5ua2pt?=
 =?utf-8?B?WHRzOTRheG02N3dHTzJzNWt2UGE2SStqdy9PaWFvMDlkT2FiT1hyb2xpSTE1?=
 =?utf-8?B?UitpYkpFQWlYd3ZQOHFUMU1XdFhDYzNSVWtQdlo1c2NUZ2xFQlZhTk5sVlZ6?=
 =?utf-8?B?S2NrdzkwUjF2YUF5OWFOODFHL3lCRnV2cTg4bE9tMmFLNWkwMHlOOWdiVjNt?=
 =?utf-8?B?YlpaVTEyNUVQbmlYM3lQUGhOaUF1VmJEbVVrS2lUOEJGT0lrYlpMZ2pKSDVQ?=
 =?utf-8?Q?l0GfKFMc4n/x5JX5H/ptcx8Ce?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f76cd1-dbde-48c2-03b6-08dcc068549c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:02:30.9044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7STn8EcBqX61Fw6yVPmEaWm82TI9VvttR976QGZjKtAzbxUvYXlpbCbDGgCypTUREKon4Z1pQCFpWX5dqN365g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9659

Wait for the controller to complete emitting ACK/NACK, otherwise the next
command may be omitted by the hardware.

Add command done check at svc_i3c_master_nack(ack)_ibi() and change return
type to int to indicate wait done timeout.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index fbb6cef405577..2010495906eb3 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -384,10 +384,12 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	return 0;
 }
 
-static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
+static int svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
 				   bool mandatory_byte)
 {
 	unsigned int ibi_ack_nack;
+	int ret;
+	u32 reg;
 
 	ibi_ack_nack = SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK;
 	if (mandatory_byte)
@@ -396,18 +398,31 @@ static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
 		ibi_ack_nack |= SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE;
 
 	writel(ibi_ack_nack, master->regs + SVC_I3C_MCTRL);
+
+	ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+					SVC_I3C_MSTATUS_MCTRLDONE(reg), 1, 1000);
+	return ret;
+
 }
 
-static void svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
+static int svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
 {
+	int ret;
+	u32 reg;
+
 	writel(SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK |
 	       SVC_I3C_MCTRL_IBIRESP_NACK,
 	       master->regs + SVC_I3C_MCTRL);
+
+	ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+					SVC_I3C_MSTATUS_MCTRLDONE(reg), 1, 1000);
+	return ret;
 }
 
 static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 mstatus)
 {
 	u32 ibitype;
+	int ret = 0;
 
 	ibitype = SVC_I3C_MSTATUS_IBITYPE(mstatus);
 
@@ -417,10 +432,10 @@ static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 msta
 	switch (ibitype) {
 	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
-		svc_i3c_master_nack_ibi(master);
+		ret = svc_i3c_master_nack_ibi(master);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void svc_i3c_master_ibi_work(struct work_struct *work)
@@ -871,7 +886,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			if (ret)
 				break;
 		} else if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			svc_i3c_master_handle_ibi_won(master, reg);
+			ret = svc_i3c_master_handle_ibi_won(master, reg);
+			if (ret)
+				break;
 			continue;
 		} else if (SVC_I3C_MSTATUS_MCTRLDONE(reg)) {
 			if (SVC_I3C_MSTATUS_STATE_IDLE(reg) &&
@@ -1145,7 +1162,9 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		 * start.
 		 */
 		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			svc_i3c_master_handle_ibi_won(master, reg);
+			ret = svc_i3c_master_handle_ibi_won(master, reg);
+			if (ret)
+				goto emit_stop;
 			continue;
 		}
 

-- 
2.34.1


