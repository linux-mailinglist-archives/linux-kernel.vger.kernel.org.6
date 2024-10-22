Return-Path: <linux-kernel+bounces-375782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8439A9AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD75A280EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2F3146A93;
	Tue, 22 Oct 2024 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="ZEw9JAPU"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2107.outbound.protection.outlook.com [40.107.20.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD73232
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581378; cv=fail; b=rLD8hUUPn32OyFIGQETeAyDhTve+lX2llSgbkx5MUP603pYv0nuJVrA1M3ypFqIBxdh/Te9fBhWsgdrD2NCpG+PCoQ6zNqu+6gf3mKqrCH+2Uz+YtFP9lGIZEc1qTllX1B5zykKl08+8BWKgCHi/Wa9FC0WgfPcjENVa3v8d6nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581378; c=relaxed/simple;
	bh=USmT3mhvXTpP4uboeYDSA0Nh0iF+QzJVsV4nd8rANdM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MZZmWeEkWwpXcNB+lMQsKvLXw2CUzqPXG6skcgZj0VNaHXqX5TJ5h0O28etlICNb+bJvVLu75N/Hpt65ZVqpWLIacg/WEE//XkgxFhm0nCiDAgCBmh8TP32dP6L9r8rbThRWlD3BZeTkXoaZklftvXWaSldZLZ9dxP9o6R0Jj8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=ZEw9JAPU; arc=fail smtp.client-ip=40.107.20.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXosO7/x7/YT5RxmxD2E/Dp6hBJfjJuKOLVmzJJ1FWPM5rgzFLTlQUPf542uotociyzkNz+rTq3gVl6GdROOSgNTi9Vsdue5hMUjzujEHavG6544lTld4A1hotXrVCXv9Fd/ddY1sG6TjtUEEXEDh0xxrR5/3FbRQQ0H3e4ImBv8HohqadP8mC/jrmBf1+GDojm/GCwn/mGX6UeVaD64Zo6NZiRJLdO9mQL151XRugqWl8AxU9RQrp0v1ZOg8Ql+AVDx9VbEtMaBsqFO0NtszMq4K7r8MKP1596t3Cxhl/uH6sRM/oJBlBuUEKkwobjNqRlQKnAa9ZgzviNi7IfPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMMM35om+MRR3h7c1/DJEu853oEYUVf8ccg67AS1fc4=;
 b=PvQqRTyHFc2P608OJTgrfqjCJiB/B/xlDXWEcVCk8JQ+1+0LteSNOtvDsni/qTj1nQK+9vZC1S0IwYrOCVQR6N4kjJ9QK7dxF2GVG07jJ2t7A8XHXeJN0bpiVZL9pxFzmhs0nkT4tSzn+kWJcIyngPhOPly3xCA0gSwL4VovEFuT0TbNizQhGQBkcGOgu+ArE7X82d+PwbYywZ6wWFdk3tkFJw6flj+gsa2sSti6wKBfY1wx7GDiVvFhwOCcuVy/L+g6IWRvBt0hGv+X2tIcSFOIDrBVxCnXFIVu7HsmCcY3up2FUZJrAlS8zq7fiTJWDKU9NoxbJN8eElgxeX3hYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMMM35om+MRR3h7c1/DJEu853oEYUVf8ccg67AS1fc4=;
 b=ZEw9JAPUK1V7JtfMhx8l2puI2aktYcwMb4Ya7bHf/Zv/TlMsckx9dR2vSKrsaIM7p+LlcK7oAt3g8YZ78+ma8gn9A3bCXkW20gSBftH81IsFTRJXWFTImVM/akEy0XqOP77WUWZAutsD64oLzP0+ZFIO8V2P8SWEpKoDZUkGgnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM0PR10MB3729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:185::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 07:16:13 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8093.013; Tue, 22 Oct 2024
 07:16:13 +0000
Message-ID: <379853e6-bb96-4556-82b8-27ed49f974b8@kontron.de>
Date: Tue, 22 Oct 2024 09:16:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] phy: freescale: fsl-samsung-hdmi: Clean up
 fld_tg_code calculation
To: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com, sandor.yu@nxp.com, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20241020165102.340838-1-aford173@gmail.com>
 <20241020165102.340838-3-aford173@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20241020165102.340838-3-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::12) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM0PR10MB3729:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf00cb9-a8d7-4e58-4e5d-08dcf269693d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3o5NWhyaWJ3M0l4WnlJMEF3ejZrRlhmSTd4TElIcWt3akMyRHhYWjRxdU1M?=
 =?utf-8?B?c2h2WjFmVWhxSU0rMWdrT0lXdmh3VmRxeDc3SzJoQUMrZks4L2VEZXpFaTMw?=
 =?utf-8?B?YnFKY05zMWxWRFAzQ3BDT25oR0ZVU3FsYmQwR0l2RUtoVXZzN2tFTUY2Q3FZ?=
 =?utf-8?B?LzBKRm5mZ1ZlNFpJOVBBSVEzTWVKSkpXWnBsV3VYa2lCL0FXM0NSbnFJQjBY?=
 =?utf-8?B?TEhBWjdBcmtsY0p6Yk82aHA4RVJWbjM3OEowOFNEWnljSnQvS2dvclJsdXNK?=
 =?utf-8?B?TlcyK3Zuak9BRW1Ya1g2cUhyUUxGcFdsR2JGTW5iNks0dTdCM25sUTE2VHk3?=
 =?utf-8?B?V1pVc0I0cURHaUlNSzFXYitaczhMMGRrclI4WHdEM0tyUmdDYXZkT3pMbDJD?=
 =?utf-8?B?aE5NbzBjMmQ0eG5wWTVEVGFuY0ZocFhQY0Q2TmJJNHM1YTJtOTBvZUJiL1dZ?=
 =?utf-8?B?VXptdDNTb3F2eTEyUE1hbWJOWGJVVTIxZEtEekhXTERLdlhaU3ZTaVRkRmxH?=
 =?utf-8?B?amlxWmJwSFBkbjNuVGx1MWdWUHN1MFoydFZLRmErLy9QTm5rR3RMdHJlNjlq?=
 =?utf-8?B?NUpEREZLYUpIMVdwVk1VaThBdTBTQWExajVEK0k2c2VFSFZNT0VVQjZZb2pR?=
 =?utf-8?B?NjVVRUh4R2NGenp3WkU4dk5uSjNJd21tY2RRaXFMYWZLNHZQWk5DRmF2UEdR?=
 =?utf-8?B?SWllenVmODlyeWZpV0xERXNCQXo4L3JGdWpLQ0J0OWhhRkpBZEtNSWtJN3Vx?=
 =?utf-8?B?VHIvNHlacUswc0tvS25kVTdaYTExZS9BdjhUcDNjMzUyK2ZDTUZsL1VTTVAr?=
 =?utf-8?B?c0hvUVJmNzQ0VjllcUtDb2tMRk0yMCtHSkxmMGYyWEY4eURxYVhnVklBTXh3?=
 =?utf-8?B?ejlsaUFlSE1ZTEJJeHhQZ0VpNHZIT3g0NW92WDIwd2pwcXIyNDJGZVlNQlc0?=
 =?utf-8?B?aS9Kd1lzT3lxc1Y5S2ExRTBPaWRpb0QwcUZRY0tyMXZwMUR1dlRmVVdtV1Rx?=
 =?utf-8?B?YmNEWTdwWW1ZTWJIUkRQY3NZTnV1ZzlWWHJiSURSZldqM1NsVzZZVS9Zb0NG?=
 =?utf-8?B?Q1B1Q1FZZFZvTHdlVFRYQUl0TUlvMEtxbVZ1TmFQc2tKRmV0UUFlcHVMb0I3?=
 =?utf-8?B?ckhWNElFNWl2QUlPM2ZrUWNxRHRuWFNwR0lYaTJUa0VxdFI4ZGhFNEkwem1N?=
 =?utf-8?B?Mk5xeHMyZllUbXNTK0tPVDFZcXI2Y1d6bHdDb1RBdS9kNzVkZ2xoZXU4Y0Fj?=
 =?utf-8?B?cVBiQ0JYNTI5Z2xPTWVOOUU3amtxbHE3OUlOcXhLTHZlekVKYzFVc3p4Q3dI?=
 =?utf-8?B?dDhaLy90Wm0raXpHSklzcFhVdE51TkZSQ0d1ZENtMk5xK1V5bjRzSHpDR3JI?=
 =?utf-8?B?Ui9BbnBNTnFBL3orR0FVdk1DbWl6R2M0UW5nV2V1cHNqUEdteWFhUkJLSXJr?=
 =?utf-8?B?Zk5BUUQ0RkkrVk1ncWRLbldhT1Q0d202eld6NFpaVTRYYUU4RldaT2dwNGhP?=
 =?utf-8?B?Ujd4VCs3Q2Z0VmpONjFJSEVLVER3YVFqcXJNd215b1ZVREhCUjl5dEVuUkdr?=
 =?utf-8?B?UU1keEtQaUZtY3N5aWVRVlM4WWNDTklxZll4MUZaRXplUTZKTmgybGgzODl2?=
 =?utf-8?B?T2hleUlhcks1dnY5dmF5aEJ6dUNWNERqaWkxelZkOTBhL2w2OWR0Q2V0QU0z?=
 =?utf-8?B?NG1PYVA1R2REd1FDVDY5U2FPalBBZHpwaHJRVTN2U0xFd1hFdmI0dEE5ZHEx?=
 =?utf-8?Q?sBt4bNKSU6/mRAFrAwgODL0abi7KQRUlGMK8W/h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjJjQmRrRTE3WlBESVliUFovNzFJUXhUa1RNZGgwMHlVMVRNTzFQTis4THdI?=
 =?utf-8?B?V29BNnA4cmgzRGkxQTJhOTFRQ3dRYTk4VUdlZlFrdmsrWU1XeS9YMlgvbTNv?=
 =?utf-8?B?STlQUm9ieTRPUjVZeDl5b0YycktMZmhuRGgxVW1IWDRzUFY4czMzbHIwZVdK?=
 =?utf-8?B?OUhRc0s4VVFZM3dwcmpzYzFOQ1FzY3lydzZKOEhWQVFCeUlKcVZjbUh5L3BU?=
 =?utf-8?B?NXZtZTdzUnVUbklJK0VrWU1HYlpnWU0wUW1YZ1BzTjBJRnBxQnRuZXFDVmtB?=
 =?utf-8?B?MlppblBWa0hnbmRwTXFkMEp5RS96TkVCRU9GR0tMV3VSWDFjRys4Y1NiRkxY?=
 =?utf-8?B?UGhOVGVjSEx6TnV6eHp4akdtbmJVZjBrZ3ZET3ZJaG16V1lQSFpBYXdsRC9o?=
 =?utf-8?B?MXNaQVFTSzIyL1NaMUVybi9tU0YyZmc1Q0RudGFQVCtCcldUV1QxUTIrSkV0?=
 =?utf-8?B?QmtkQTFkM2dCcHpaWHZCVnRGdlNNb2NzMjM5b0ZlUnh4b1pGUkI1UU42dk5l?=
 =?utf-8?B?Q01EMmMzOVM5eDlGaFNtbjBKaGttK3F3MUY3MXhjUzNudGU2YTRpZmVObXEw?=
 =?utf-8?B?NWpoOFVvWkZUNkFldi9acWNEUjA1RjdNclBwdFhFWnh4UXdva1NGWUZHcElC?=
 =?utf-8?B?MmU1d3ZOTE9JeHVkcFY3TUlzTUtBckJHM3RpSDlta1R6d1QrclJVV1BKRzlR?=
 =?utf-8?B?SDZsdGJVUEZhd3V2OFNlOW1WSzNZMlNCTnJPN3loR0lFRlFWTlhyVGhpZDhH?=
 =?utf-8?B?VFljMzlUS2huSzMzWDVleVNld2FlM05DZkJLY3VVVnJiS3FwajExb0twMTN1?=
 =?utf-8?B?eFcwQ3FHdkNoYTd4dlVnYm15NEdJczZHdE9LOStycjU0RnNtZmpRT0tRSnBh?=
 =?utf-8?B?dHFzSkRCK2JVT0ZRWXp1WDFVR0F6WVVjR3NnTS9qa2hVbTBFcE1URjUvK3FD?=
 =?utf-8?B?RUZQcFhNVXZwRyttLzVYcHNaMnBIWW9PU3B6MFB0ZWNQQW4yMjA1RWQvVEJh?=
 =?utf-8?B?OVdtTHJFSE5xVW5VRUtEb2xqTE9GcWZ6MHFJa0VrdzE0L3I1RlhVaUQyQmFa?=
 =?utf-8?B?SnVYaU1EMjA3Z2xWWGlEaDNOT3JuQXlTT0JhUkdPZURpREhFZENsSkhEczlC?=
 =?utf-8?B?cFlGVUJya3llb0lYVWNkZDN5U1ExSTFKODI5STgxVUNOQk9IbWQ5M2tISmJS?=
 =?utf-8?B?UGxNR25qa3VtTTR3U040OVZlcW5keE9RWGgvbUxLRnpIOWVTZW9DM3pEeVNP?=
 =?utf-8?B?aUNEaGZTMFppeUNDSGVVVVhPNFBwVEc3dU8xd29ob3l6QUdlalRtMVhXUFVF?=
 =?utf-8?B?SXZvZzVmN2RLd0RFNTA4SmZlNEIwZ3JIRHdYak9wcVhncDRhbTRzTW8wdmNL?=
 =?utf-8?B?b01MUVBXdWlNTkJUdUh1VU9MTzZENk90TVBtSUJZZnRRNjN6bWZYUy8wRUZE?=
 =?utf-8?B?WWNNWmtuWkJEWXNaYkZTTlZPbUJNaUFOOTBYb1NIOU84c3ZPdTdvbGFkUm05?=
 =?utf-8?B?QUZsSEJmMlJFRmNvY1M5OFk0Y1lqbEltNklSUnR4ckthU1JRVFk0Z1dkN040?=
 =?utf-8?B?WGVLd0hKeFoyOFNRMUlkRnI0RUZqQTFnZnBHQUNEeHUzdWNuQjVwd1dUY0N6?=
 =?utf-8?B?SWVOWlVFSzV5RkZTbUI3U2c0UHZaTlBhVm4xRFA5SEZ5WVhRb2cxTjJjL29G?=
 =?utf-8?B?VDgvbHNEekhGbDlkNXozOFRuSDBwcEN5dG5UKzdZRm9UWVVQeDFnSENmZ2lh?=
 =?utf-8?B?WnQ5emxrOXVNeVpiQUVlVzRnVi9VZyt1b2lJMEk4VnVoU1Q3MlFCUW8reGNY?=
 =?utf-8?B?Z3E1M1p0cm8yTFc1eEd2UlRnYUlKWk9qU3ZrblJINndhRU5yUU9GSGd2YTJy?=
 =?utf-8?B?YTBiRE1MNUFsUm5wdjExd3NBMU9BVmFiWEhjcnczNjRJRGxjYmxNOVc0WUhT?=
 =?utf-8?B?VGlTTkQyQUJhUWhsOTR0ZS80REQ4MUdXeHNBQTc1M0c2VmtnQUE0UmZxbnJW?=
 =?utf-8?B?MSs4cjdFUmFwYVdoMS95ektYQ2RHY0x5aHN6UEFzT0xyRG5Gd2hVT0d4R3Bw?=
 =?utf-8?B?ZFNpT3BkYm1FaHBhc0lNb2VGWVJOYytmU2Z0d2dlVHhOQWhPT3VpbjRUMUtF?=
 =?utf-8?B?L01oMzRKT1VZR00yUG5sbWg0RlIvdjBLSnRrUHRxUnZhM250WmZnd05GTERZ?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf00cb9-a8d7-4e58-4e5d-08dcf269693d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 07:16:13.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PKCFjpKpr8B3m72+m9Y50eXZ61hHL/T9DCm7CFQLy1KYvSFe7gQoOt2IvaMKIQos/Iri7zqL4QUj/fwvi+asgNctjxNvS/bOlAvrRBu75A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3729

On 20.10.24 6:50 PM, Adam Ford wrote:
> Currently, the calcuation for fld_tg_code is based on a lookup table,
> but there are gaps in the lookup table, and frequencies in these
> gaps may not properly use the correct divider.  Based on the description
> of FLD_CK_DIV, the internal PLL frequency should be less than 50 MHz,
> so directly calcuate the value of FLD_CK_DIV from pixclk.
> This allow for proper calcuation of any pixel clock and eliminates a
> few gaps in the LUT.
> 
> Since the value of the int_pllclk is in Hz, do the fixed-point
> math in Hz to achieve a more accurate value and reduces the complexity
> of the caluation to 24MHz * (256 / int_pllclk).
> 
> Fixes: 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 32 +++++++-------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index 719f8972cb5a..0bfe0c0907a0 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -331,25 +331,17 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
>  {
>  	u32 pclk = cfg->pixclk;
>  	u32 fld_tg_code;
> -	u32 pclk_khz;
> -	u8 div = 1;
> -
> -	switch (cfg->pixclk) {
> -	case  22250000 ...  47500000:
> -		div = 1;
> -		break;
> -	case  50349650 ...  99000000:
> -		div = 2;
> -		break;
> -	case 100699300 ... 198000000:
> -		div = 4;
> -		break;
> -	case 205000000 ... 297000000:
> -		div = 8;
> -		break;
> +	u32 int_pllclk;
> +	u8 div;
> +
> +	/* Find int_pllclk speed */
> +	for (div = 0; div < 4; div++) {
> +		int_pllclk = pclk / (1 << div);
> +		if (int_pllclk < (50 * MHZ))
> +			break;
>  	}
>  
> -	writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs + PHY_REG(12));
> +	writeb(FIELD_PREP(REG12_CK_DIV_MASK, div), phy->regs + PHY_REG(12));
>  
>  	/*
>  	 * Calculation for the frequency lock detector target code (fld_tg_code)
> @@ -362,10 +354,8 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
>  	 *        settings rounding up always too. TODO: Check if that is
>  	 *        correct.
>  	 */
> -	pclk /= div;
> -	pclk_khz = pclk / 1000;
> -	fld_tg_code = 256 * 1000 * 1000 / pclk_khz * 24;
> -	fld_tg_code = DIV_ROUND_UP(fld_tg_code, 1000);
> +
> +	fld_tg_code =  DIV_ROUND_UP(24 * MHZ * 256, int_pllclk);
>  
>  	/* FLD_TOL and FLD_RP_CODE taken from downstream driver */
>  	writeb(FIELD_PREP(REG13_TG_CODE_LOW_MASK, fld_tg_code),


