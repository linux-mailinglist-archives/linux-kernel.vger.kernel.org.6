Return-Path: <linux-kernel+bounces-282711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7B94E7BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25871C21BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730451581FC;
	Mon, 12 Aug 2024 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="mBpcyqqP"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2100.outbound.protection.outlook.com [40.107.21.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043AA1586E7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447594; cv=fail; b=SS3l1119mj2unA9fRqjZfrAKexYH7IiutYWZUKejk3Sy3Dlr9WuXEFnZTSkCsH3mcjlnJd6Au1aH2i7pI8/kBXhNDRREXsxFQCcJGfTz0j0YvKmaNay951+Gbk9RaeHNHHYJuQQ57pUZcZFj/UlKIX9hIbz6Et6rUuv5+oS0huY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447594; c=relaxed/simple;
	bh=L02ghRzp6oCXwW5G0bnm1yWj8oQPVVuaWD+E7O616g0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=omvNNVD0dWPS6h5ENV40EOTWlT20n5FnY7O8ma/l1jjEZr5VT8aLyuEkbHq+6rMsocEU0oTK35t2UYLW2GVJmFwKFGGvrx6oICqzp+YCArjzQoGmqa2f7fDUAUSDGOm0I8ZDAawNQniCVpAekLVG/woe0H7RzTKw5A93XOUNwLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=mBpcyqqP; arc=fail smtp.client-ip=40.107.21.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3x5CtY7BWU+FWRw/u/zTvOhmLig+Xbt9MTN7qdBeMxhmB4WnrTwK4+h3GMe469fv1btR76NRnnczRUALglshrlneYGLY7/BbplqkN/1SJoswilGMyRswyENzwZhsEm4tejLEKrdV/vOiDhG1g6Fg4Sn/070SpoowJ4n0F0Qrr4fAkXCVuRTPFNDGysHYU3m5eliO41Bx6qCATuGNQLgcLavqQdNJ4XK0xv6b8eV9R8GBPNp8iHqTP8/drLjvsvlKrKBLiFJrOHNha0g4EDGLW4ytHrWTPEg9Bu6RFcfjPZ9SnYeB7/YRFjVSGQSFf3DFTyIvWgDvA1QeX4NXOXPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjmBolHNZgTiCWJ66U6nKMs1bONKqYIFxEuRLUtf9Vg=;
 b=bnAV7xcu3KVnlFuZa+A6s8Btr4yYD+3m8YafItK5snnzdREDQSSQQ705IulX5Zc3507Pjyt2ShwQIDBXvrTZFP7xnmW0IGAmAmMEzj5b7IWDLaDwbKHoLHwtR6gz0RJdW9GR1NDUFYr3GmFjyLuA1hbWTm2QIItbbErRka0UH2hHOsPZHTI9ffewNS8ZiV0FwPo3suBuVhZyDDSuHqMHM/OaBLGAwA1+5KP+VQPxQYIgxLtg6kEMBT9vwNvkH/aEig/QWVrAN+a/dVVHO2yJupWnrzpEsEQ48QfTI5f4s3Y03aJbrKfDMVHt3uDDM5274oZ0SHnuspRxMvx0EVhrLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjmBolHNZgTiCWJ66U6nKMs1bONKqYIFxEuRLUtf9Vg=;
 b=mBpcyqqPv4IvBMWXlnjhbZFvVxFRUHW+i0xqgjqes5MD2t1ZNFzK/fzQHn+1bqAabiuPC4sFHHCjlAxq/o6+A7Uc8iwc1u38dt7BpJR0iaKM9lpj55RhvYjjZEP7rq6jBq+Gae31t4++UIuI/zYTpXv0/iGsEGQfo6xPmX4ebLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB7360.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:444::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 07:26:26 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7849.018; Mon, 12 Aug 2024
 07:26:26 +0000
Message-ID: <1b72edfc-e1fb-4987-b874-7fe977ff56a3@kontron.de>
Date: Mon, 12 Aug 2024 09:26:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spinand: set bitflip_threshold to 75% of ECC
 strength
To: Daniel Golle <daniel@makrotopia.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <2117e387260b0a96f95b8e1652ff79e0e2d71d53.1723427450.git.daniel@makrotopia.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <2117e387260b0a96f95b8e1652ff79e0e2d71d53.1723427450.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::16) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca96cd4-afcc-4e89-b954-08dcbaa01348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUIva1BYQTRqWXh6VWJaenRtRXZpYVg2MVRSZ3RwenZicEFFMWo0MEpCZEhl?=
 =?utf-8?B?YWlNQ21KU3ZIekZpeWR1aER3UTdpckFacGZKNWYwK0VjZ1BDZFdhQUtITCtw?=
 =?utf-8?B?QlRhSHd1cHl1bGRqVnlLUUx5Q3BKM1NhVmExZmlteUJwcDVGSWdJZXNvaVBr?=
 =?utf-8?B?S3Z1cjc1V0QrOTZZRkwwZkMwWmgzVlJFWGwyQ0RRdXhqbG9YV0p0ZDhvZ1Qz?=
 =?utf-8?B?OHdWbGFLUEhNTVpyM3FZRHUvQ2Y5UWQwZGFiVHNXUk94bnlReUpNYkk0VFlr?=
 =?utf-8?B?Y05OV3B0ZExMRC81ci8xd0ZoZitCbU1RMjl2NVk2Z1c0RTBuVUVaWHZ1Wnhp?=
 =?utf-8?B?L2FoY2xQa1k5ZE5sSDRYSE4va1FVTGFxdDVoT0RqelZaY09JNlMvVzZYQlZH?=
 =?utf-8?B?UUp3MnNTYlpoazVaN3d0clVXT3J0azNYcm9OZWllMGRJNEhkYzRQV2xnOXBD?=
 =?utf-8?B?UWZPY1NzWDl1ekZvUFB4ZmlKYjc5b01JSjRlMDduUWZZT0VweGgzS3ErcU4w?=
 =?utf-8?B?cjU1UzZkV2xvK3ozZVUyVitDenJpd3EzcFJsVzl1VjJkWGlLUHl0WDB4Q0Yr?=
 =?utf-8?B?UWxLYW0zZDhGQWY0RDRTM3ZXeXI1YzAxMGhwdHJhRmVIaWZaMWRoU1lic3RX?=
 =?utf-8?B?SDFuK1pYelA5L1hnM0tQM1dCN3BjNGduUkY0K0NwZnVVdzRpSGxYbUtWaVV3?=
 =?utf-8?B?Zk9BMm1jazhOQW4rOUNOK3J5V28rRkdRSngrTm5Ia3Qrdlc2bS8zdy8yNkZa?=
 =?utf-8?B?UEFDWnFQa0h1bTFxcHRwTXRpbHhsb2JDV3BKcWxWNHB1OTlpOGY1VE9QYWVI?=
 =?utf-8?B?VmU3RGxDeWFmd1J4NEdRN24yTWI2emNTRm9PNksvZGY2M3NFWEFjM3FvQzJt?=
 =?utf-8?B?dHlXR05oNEhPVmZOU0pZQ21Rd0tNc1N0dVBZaWt0d3lrd0dWcys3L2hJMWcz?=
 =?utf-8?B?VXp0QW9reDVpMXQxVFIrcVYzNnk0ZGtFVXlnT1FLNEZYUWgrazdIQWVNaEpv?=
 =?utf-8?B?SnNieUJGVjd3ekxEcnhLdWd1Vzhrb1RYSkpUdmJsSlVkKzZIT0dMUkJYenNj?=
 =?utf-8?B?REwxbWVhT3ZSRkcwRmFmYUlKYzN1RnErM2ZYVnlPeGlxU1JVOHp1emJIWEVD?=
 =?utf-8?B?d2hOUGJ5dnVaNzFLeTBZSlI4V1VVc3dhUlhROExGeHZSSDVZYUhJbUdPMjRC?=
 =?utf-8?B?akw3dHFpb0FueXVMSERSaTJVUWRaOXVjSnFzcE44RGwzSTFiSFg4SHIyOE9Q?=
 =?utf-8?B?a3ZJR0Q1UUg0WDFNS3NWS2lITXlwWHlNRm0vZlE3ZFdVemRKZFhRTzZucjUr?=
 =?utf-8?B?RHNyNExMaGkzSUU2WEp6d1Z5RmtZdFl4OEsxQUNBNGZpbzE2OVVhNklXNGFJ?=
 =?utf-8?B?SmczUEdEWmJVL3Y3WGVRQzhXT0VvRHY4VThpVVN6RDB1dmV2RU9RL0xaSEl3?=
 =?utf-8?B?bW9TUjF5ZU9iNnNSZkxmRkMzckpzZno4eHI0SkEwQkE3dlV2T1UzaXZKQ01a?=
 =?utf-8?B?SFF6RTZOK0c1UnNON3VJRkVwelZkdEtscjduYnBSbzd2OFhtTUxSYW1LMGM3?=
 =?utf-8?B?ZmF4NWY5d2J2cktBSnJwRHlBT2dyaXloRUtTeERuRHJ6OEdwZVB3dUM0Tity?=
 =?utf-8?B?TUhiakZqZVcydW4wckx0dGFWTTdVZmlFaHNINzJnV0lwdUFjL29vaDFBeCs2?=
 =?utf-8?B?dE9BYW8zTFphRjFqU1R1dHFVbWxsQnFzdUdJTXg4M1ZZdmc4VGU1aU1OQ1hR?=
 =?utf-8?B?UWNKdkJKNGtvRVJEaU84UloxKzlpTTA0K05Zb1FHeUYvbzhXcHpyZzNhbDBv?=
 =?utf-8?B?SW5xdERIZU95WFpzc1V4Uzc0NHhTcm9wNkFySi94UUFybWRGLzNicHZybWdP?=
 =?utf-8?Q?AnvobisZkhoeD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0Y1Q0NHdDQveERWTnRoSDFDdmU4cFFtS2hGUUdRVU8zU1FqSzQwRHA3RUNv?=
 =?utf-8?B?WDRHUXp4MEJIRWNrYVlhMjlQU29Nc0dmWlpJKzZ6N2ptd2lUaVd4cWJ3M0x4?=
 =?utf-8?B?TkxXTkhrSXRnTVpnRnNFR2p5MHZDQ3VTam1UOElMa3FmSWE3SHU1VkI4S3pU?=
 =?utf-8?B?UkFKeU1tZC8vc0N4ZkNKNzQ2eEdtamdpVURLdWZVdnNzUDFMYWs5SFFmc1hx?=
 =?utf-8?B?dWt5dk5TQkk2SjdtZCsyZ2p3UW03RmtiVGJKbzQyTDBHekhsb1ZXS1hGeGpv?=
 =?utf-8?B?WitxaDl4bzdRNXNXbmRnVXF1dVlGWThWOVNZbGNYempPVlE1NUdZT3pSa1J6?=
 =?utf-8?B?R1dCTUUxUHkyZ1Y1YkZRWkFDbzI0Z29BUjNFUll4K0MwbTBuaW90K3R2MGFz?=
 =?utf-8?B?ckFOaUtSR01GZmZ2dndyanppSFZtM0RQQjZmZlM3VGZ5cTBscDRVdUtrdkh3?=
 =?utf-8?B?YUlGeHc3eDhsZXEyejMvYmRsRytiM0s5Ymp4aWxTVUxLY0RwWjNoNzVZeEN6?=
 =?utf-8?B?ZmlYUUhxN3BtRmZEb245YXI0RVRWckhlTFdvZFhmTGtUc3NZaTVVN3N6SHBt?=
 =?utf-8?B?Q250T3haUk5BSFZIMlp2WTFLWTNyVjlXT1VTdktJYkhmT0hzT2ZrbG4yUmp4?=
 =?utf-8?B?SktxeXA3VWpTZ210TGpFUlA2NmhMVERVUmp4Y3Z0V0tQVkxVZnNPdGY2SFpu?=
 =?utf-8?B?SWdiYUg2VnJ1RXVoRDdKWHNkZ294NGNsV1lFb1pINk1RdFA4UzZKQStiZlFQ?=
 =?utf-8?B?UUl1NTh2eVhwNHdFRG9SM28rcGlydTBNOHp0Y0tYOE8xZ0g5UGZXdG9zUDFr?=
 =?utf-8?B?QzMwbE0yWUdEeHZlWWdNcEc3QXl4UmJoKytrVVI0LzdSdW40eW5FQlZPeVZM?=
 =?utf-8?B?Z0pBalJRV0dTWmk5Mmp6T2dZR25OaGdyZDcxbXYyMHFFUFNNanJXa0xDaURm?=
 =?utf-8?B?RUlVTGhWZTFqZWhNNWh4bkdhOXAyYTJha0dzOUZ4ZEY2SkR4NHRjZG94Nmk5?=
 =?utf-8?B?U2VCV0VmcmJNSk5IcTMxQkIrOTVHOG1RRmdmTGN5V0s5bnVhdEZ2Qy9RSitj?=
 =?utf-8?B?bjhwK0o4dkdmY0grWXhvcytiT01aZnJ0RERZSjVnWmJCRlU5QjQwOXR5ZW41?=
 =?utf-8?B?dEpFbUl3Tyt6MjFRZkwwK1VNS1BnT2lSdmducXE2U2doYm9Xc283SzlLdlE4?=
 =?utf-8?B?a2IvNkJueDlVWHhtTkZQYisxczdkVVRVMTBuemp6QTk3RFBSdFo2V1FUd2JK?=
 =?utf-8?B?OG5PalhOUmpLUzBVVkE3V2hyQTd5WjFiL3AyUTd1RVI4YXU1WW5OajZ1SjRq?=
 =?utf-8?B?RTRtb2ZxR2M4RFZoSFVTRnhYVmg3YUpMcEFLdVNFSWJISCtpS21vR0JuOThk?=
 =?utf-8?B?L2p4UFRiUHFrZjdEYjdPUTQwZjhYK2ZzVUZrRzhUUEZ0dUNwRGhlMkRrMXVN?=
 =?utf-8?B?UzJ3ZEFuKy9sVlp2eDZFSjJGZml3QkpuUGtEQXd2SDl5ZURaNDUrSGM5S0lh?=
 =?utf-8?B?WU1JM2U2Y0xaQURMSUk4cW5iSTlPTEtldmUrN2s5SGlKQVE5eU0vMnM4RWgz?=
 =?utf-8?B?dTc3NmQxejVodHdpSy9icVlkNkxKZ2FuYndYbWVHNC9XaWtHTXFwMVdBRnBh?=
 =?utf-8?B?NUd1Q2NrMExsaUJ2Qm03V3lWOWhLc3I1NGQ2MDN4KzlIQlo1QjY2QkJzVTdW?=
 =?utf-8?B?UFBnWUNyai93L0UvWmlWMUdmVDdzTDdXWGZ5Uk5aU25HMThNQ1A5aGF2NTVp?=
 =?utf-8?B?TC8wcEUrY2swQzZZZ3BlTGdTaFZJWjJacUp5MW1NdVBvT05TZW5oNS9Ld2JY?=
 =?utf-8?B?ci8xRDJtRGJKcm11SDlMNjRyOVFJL055VExBRkpuWEZHTUh4NzNxUUlJVFZL?=
 =?utf-8?B?YSszV0tvMEZIU1pIUkY0b3RNUU1wR1Mva0YrbzB6VEZBcGtzVnJWV3ZSdDI3?=
 =?utf-8?B?Y2p0R3RseCtER2tBS1RxUEpmMWIwQVFPSzA1RzNmalpHc01DT2FFSlBsNWor?=
 =?utf-8?B?WDRNUzlxVFB2NHAyVkQ4V3lTTWkxc0RhVkFZUnZtYmlqRXpQLy9ubURjTEk0?=
 =?utf-8?B?dVFTSmZVNmtxTlQ2MmxxNVRtY2NselVSYlVERmc5M3ZhY2VCWDl4NmdNYjIw?=
 =?utf-8?B?eXZQRW5Cdkd6aWpYVG93VEdsd002VDkwS2lUUWNVUnBmeUNzYzZrdllRcERr?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca96cd4-afcc-4e89-b954-08dcbaa01348
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 07:26:26.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+PC+olGgEqVb89IJHpmRVbZ443IFWvL0+QNCZL8eIGs4Ge+ulsqLEcFzV557HpKYBFNuxU5bkpPaXf1ShXfaYcPZIXGjOIeAjZ+FlQ8Mqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7360

Hi Daniel,

On 12.08.24 3:56 AM, Daniel Golle wrote:
> Reporting an unclean read from SPI-NAND only when the maximum number
> of correctable bitflip errors has been hit seems a bit late.
> UBI LEB scrubbing, which depends on the lower MTD device reporting
> correctable bitflips, then only kicks in when it's almost too late.
> 
> Set bitflip_threshold to 75% of the ECC strength, which is also the
> default for raw NAND.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/mtd/nand/spi/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index e0b6715e5dfed..018c854d06193 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1287,6 +1287,7 @@ static int spinand_init(struct spinand_device *spinand)
>  	/* Propagate ECC information to mtd_info */
>  	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
>  	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
> +	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);

Is this just a theoretical adjustment or did you encounter any issues on
a real device? If the latter, could you add a sentence about your
use-case to the commit message?

In general the change looks good to me, so feel free to add:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

But it would still be good to hear further opinions.

Thanks
Frieder

