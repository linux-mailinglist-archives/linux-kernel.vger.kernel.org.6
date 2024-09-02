Return-Path: <linux-kernel+bounces-310636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B30967F78
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B11BB21DC7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE71154C1D;
	Mon,  2 Sep 2024 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lk+0biKP"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4B2AE99;
	Mon,  2 Sep 2024 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258529; cv=fail; b=eOyKRQeX3Hb3enkPiq+Itxw1nSOUEjdrpZq1FroxaFg3nbDd84pqpaCY5IK0u12RaOFQH+TLhsSFDKiCZdDd9TLzm+9Gs5ezhAoUzVYu8m7a0rglHUpL31yGmPteMEaFvPzbKnLELhmPzk/O5kI/z+PDNCiwSu5TJ24Z2Heticg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258529; c=relaxed/simple;
	bh=aB+OwRYVmIMVFwvtkebJqPfMlK2U87UtSjhy11RgQ6I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hXGdStaZEm8uqyaw9jU28PJTj83dYIFdzWdU+ldWQQMhLjfoQsHYzWOl/khKAayLWU78fVDCbVXMt0kRsmSP5WpqX9F7JaKH9VedOAX/f/9nCAvCXxhpXC/Q5oT34mHeqRuRC0dxbYXU38ylq54OTcD40SHq/uF8ERgQTnVqxCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lk+0biKP; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6YXmHK8uZ+vCBK99PUm7NVDju2zY3hqPEWcwPcMLL0BPOG4VKV0AcxAI4ETsZ88en1LoRKyGhdK1C+17AN/RHU8f3jECNG/NzlP5KiDaVKmMbS5utIjIuA0KZvmSuF3BWc1BNrPhgBH4jt2uY32mN0MIGsVvWa+M515XISYpy6iNPjcSNJx6X93fji05DjkZopu37NVk15hwba1dQu4wEz+ZxO/SlX9pj4doFNv6ZomNy7IGpXJ635wE3CmZFSUxeXplnzkBvmqD7bg4pgcVOAsWB0F/sIoFuLuwst05uEHhTd8Rln5sZQxL7bnj7CErWh6iNO33x9JxhTNtkwtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EjJSPoCsWEBx9sxwLOLE4XUQ2PFS/9opkddK0BYASY=;
 b=UOCyq9losMB53PwS9njAzjnUmznKAzg7qEiEoCgGkUCS2sGbkN/gd9hbI7fU/dPm47MhUpU2K3Y4oKdDYDMMEMjyCiqUeqd77dKqJu0e2h5Q/hVRWjkmJrHVeS5ffsUrKGUtEGkvv+Gl6ZGtOKHHpNDbNPTq1ZTYvfP89wljYyY7Yzeb74lpojTUIlBpURILJDbOwxefZ2M8U0xja9pze+E3kj8zu3/Z9rnsEFnEpYdRpxxz5OhxRvbheuHlIgRphn3SuxttnT/DOihEc58Cek7hGc4OxkvyJCiDxWHLSWwnDDFkeIsvIm2GjRpuZ+Bht716i7OwEzbRjOHZkFMPrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EjJSPoCsWEBx9sxwLOLE4XUQ2PFS/9opkddK0BYASY=;
 b=lk+0biKPzG0dbLvBkKQHgLTaetR0ZQh1fIg+G6at4KNoKSoslPBpmtQwiEqW+wp8QUFhKMXOEFwRAeJJ2dy/KYiYssiIbRHTIuZ60F2ndOZqEZTT1U5IVUC1A0ZyINe6Vnep38KmO5C0Ylc66ayBE8YOJcM9jlhinA4NPLD18qX3a3uSXemo+1A29Y6D899qWW0Qp69ddn3jRe16QEf2PA2p5sdMHQXTmt7nRD+AVJk220tlyWQOdTaXnV2bngAs9Lz/Nwd1xD07C851iFSbvLc8kS2N7GeKAwY7QXItsuWjBDNZIYCIC3PfuHHI5uxlCNt5HML3RS8Xbwpd6Y2YKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:53e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 06:28:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 06:28:44 +0000
Message-ID: <4ccbc9ad-7d19-430c-95aa-d726b6b83412@siemens.com>
Date: Mon, 2 Sep 2024 08:28:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: pl2303: account for deficits of clones
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <a07922bd-4550-41d8-a7cd-8943baf6f8fb@siemens.com>
 <2024090203-challenge-paper-e1fe@gregkh>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2024090203-challenge-paper-e1fe@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a37d21-2025-4268-6986-08dccb187e5d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXJ0RFV2cVlPbjgybjlZSVlIUlV2bHBhN1I3M1g0Q3F6ajk4L2F1em9TMWh5?=
 =?utf-8?B?aWphWnhyN3I4Q3lmMjVpOHFzanBiWmN3OVJLL1J6c0RTQzgzYUtzNEtqdXVI?=
 =?utf-8?B?ZUJidmRucE5oRGxidDMrZG9IMnR6T3FmTWhXQVJaeWVVV2dlVEE1ZnBDTEE5?=
 =?utf-8?B?UEJaazkrZWtHYm1ETDBjVEpoZUx3aUVXU1Z2Z3dGbDJjTEUyU1l5M29rTk95?=
 =?utf-8?B?VWYycHRFb2hHb1ltdzEyUGczdzlacmxNYmNWN0pVaU1ZT2JLdzQxRU9sKzhr?=
 =?utf-8?B?RFBsTUlzK0lUMTVBOUhKU2UxWkZTUGRzU1RPS2taaThRTUdlb2FwY3dGd0ZT?=
 =?utf-8?B?WGVyck1SVkwwczAycWJrS0d4Szlpa1Y4YkR2dlR5dGxvdUlkcFZMSGFwVUNT?=
 =?utf-8?B?dUZBczBkWUduVDFnc0lxcXAwVkNNUTRLWkNCUldFbzJHald4MjdOZjRnTldG?=
 =?utf-8?B?ZGRKTHZ1QmltbGpxSVdFaGEzOElxNEdIc0gyUlhEa2NlZld4WHNEZk1pMjFq?=
 =?utf-8?B?bTUyZ2xlalBqN2RwZnozSEIwN0Z1MDNtakpBRXFHd3RLMHdSMy9LUWUxMzVp?=
 =?utf-8?B?WGFIU1JIZXFpaG00WXRiSXRLM0NSSy9DbWZzSTZlSUptYlJ2ZktQNEpCMUZW?=
 =?utf-8?B?TkJRc0lpaHFTdzVVLy9odjNkRGplclc3RDEzenJ3WmdFUWExaFpoaXJGSi9r?=
 =?utf-8?B?N1RMZCt3MGdsczdvaWJucHJiTVFDbm5Tc29pVWFLNzBRcHdnQ0dFbmtDdis2?=
 =?utf-8?B?bkhweXdaWkVqQ3NkU2ZTYldVTDlGQXpFTU5TZGprc2hpVHRITHZURXkxY2Zo?=
 =?utf-8?B?Ri9SWHhSRTFXbXR5bXFSOEYybDUzV3BOd0w1RkE4bUlKUXJldkxhQXYyOXp1?=
 =?utf-8?B?d205SU53cXZRRS9Xakt3MllNdWZEd0tlR3V1OUg1QTAyVzU1Q2hSTmZRcHYw?=
 =?utf-8?B?M0RhNWUrV1ljZ1lXK0YrMkx2UWUyWXJ1ek8weWsrU3ZNcUk3b0FXdUJxVkRQ?=
 =?utf-8?B?cGxPREdGZ2w2UzdJcXNMTEljVFFxcXhGcC9BYVpab2lYWDlUald2bHlpSjBD?=
 =?utf-8?B?NjJ4cUlITlNpa1V5M0JmN1JlUUlxMHpmVHRXSk8vNVFFTHQwVXVmRERIaXRm?=
 =?utf-8?B?Sk5wYjZudnFMTmdaVW9oU0ZmbmtSakcyK0RsckJLQm1uU0RjNVcwNjc3Q0Jv?=
 =?utf-8?B?VHFTaXNtd0FIYktYUFdnUnNxeGtpNkNDQ2ZSL3Z1UlNCa3BCK0xVS3dPZ3VB?=
 =?utf-8?B?WDIrdXR4dS9GMXEyZldubkpUNjhTUTlUdithYTBZcXRLUFBHcytQUzljeWkx?=
 =?utf-8?B?RXZIa3JERUltRjRSdmlXSUlzbEpTakxOQTJaeTZQaVc1MGV5a0h5WE5Ta2RK?=
 =?utf-8?B?RkxETE00UW5HRG1FV2NnZERnN0QzRTJRR1p1bmptVklQdTRBY1MrSkU2RWVn?=
 =?utf-8?B?NGQ5RS90SHUrU3pWMEZiZEZlL0ZPckpIN3VtNEFFcm12VnlxQVBYdXRCb3VV?=
 =?utf-8?B?eTJnM2FpTW45OHhtSEo1L1hoOU5udmdWaFkvSTZydWNUb1hsYXU4R2lPRm5P?=
 =?utf-8?B?UGNHOS83WmlaNnJsd0MvSW9Ed25ZSzdHZ1ZBT1pyQ0JRejV2aG1qNU1ycFdN?=
 =?utf-8?B?b0dLbkZSK1VZVHh0dmFrMGlzYlZMWEZVcnJWTzd3dXpDZjBIeGJ6Nk92b2xJ?=
 =?utf-8?B?SDZyYnpncUhTbWV1eEptdndzMGJiY2hJZUswTnNHL0JtK2VFdE1JbG40dmVM?=
 =?utf-8?Q?IWVmU/p9P9zZ3z9Oa0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHlqeVM2Q3Jtd2t2cVN6bzIrZ3pYZjJ4Y3JEUTdiNTIrSERWaGhsa1JtUHUz?=
 =?utf-8?B?UzBPbE5PZGJLV1lyRUhNZk1zdDZWY3NtUHVYMXFNLzdjeDVLVkFTNWt6aUdT?=
 =?utf-8?B?RlFxZ1FQOEZrd251SFN4NFdoTFYzbDFIVkthR2dLOE1pNVJrWDRqVzFxSWJt?=
 =?utf-8?B?MDNzVDFXZ3oxcTZmRmxoTXVodDhvUmxGVzRZTmNRaWE5d1N5RDlSOGl5TEF3?=
 =?utf-8?B?Qjg5MVliQzhYZzNLajQ2Vjc5ejFKa1FpaWc3TEROTmpxSWliRjlsQ0F3cVh0?=
 =?utf-8?B?U1NyYkdEU2RTUHRmM3Y1Vk9xcXpNOXBrR2ZZRTl3UmhXZFR4bHFNRnZJVlVp?=
 =?utf-8?B?aWxqZE8wTXZOYjMzeGxMU2xqcll0TGNXUUNoYklzZEVqTVk2akJCUksvZHRT?=
 =?utf-8?B?MENKTGVkYUh3VTBDTTVMMlNlSnBGOWV6NkN5cmp5dE9PblVCdjVteFlGbm00?=
 =?utf-8?B?d0xnT054NVh2M3lWOUZWMVI3eU9CT3ZkazNXUDdCeFd6dWgrS2RlNnljN204?=
 =?utf-8?B?ZGRvUFAwd3IzZEZLWHcxYW02SEFzeTNIZFE2YWtYN1NycmVyZUs4bmdCc01k?=
 =?utf-8?B?U0p0TEk0dTBhMThNOXM5dVBKenFORkJFVmVwbnk2MDU5ZlNBaStEU2hkYU9C?=
 =?utf-8?B?MUdoUitDcjBpc1ZvelFSdEQvOXFuWGlNYVRhOFVMK0xrQnY0L2ZJcm9wWEgy?=
 =?utf-8?B?K2tkdHpacTJGNXQ1RWdheFcvL1lKb014aXhNYy9pODdjaVdtVmlmZmIzcnlh?=
 =?utf-8?B?U3VlYkxWMU9sUWJXMWVvZlJuSVhjcGdndnB2OXNiWTBqczE1VDdEZ3FIdjBE?=
 =?utf-8?B?ZEVUQ3dwZGJUdUZPcU1rVHZMeDVTVzdoUmZhUXVCdTNCYldheXdOaUIrTjJZ?=
 =?utf-8?B?ZUcwRXp1TVF1WGhmN01sa01VQ0R4dEZSaEcwbGxjL2RoMk90NlV2MFdROFBi?=
 =?utf-8?B?bTQzMXNCRGNKR21MWjBFbktTaExuNEN6TW9GNVErT0l3TjRDRnRBVnZFV3gw?=
 =?utf-8?B?YStZMkw5UU5kTVllVUtvWDZ6S3JuNk13RUtwQ2IyV29VQTRCS005VUg0Ukx0?=
 =?utf-8?B?VEdmTEhPclFESHc0L2xsYU9ELzFlRC93UmRpalNWdjJqMEtkU0RPeEZCQ21Z?=
 =?utf-8?B?Z3pEL2w2cUE2dldwNm5LQjZMcDhaaWVjWU9SR0lvcGRvdTRQbkJsMXY1TE9h?=
 =?utf-8?B?YjE3SXhyQ2xCTzVCRHVKb2FZOTVyc2VOQVFQczlITDNHcitiWlpmWHhIMXEx?=
 =?utf-8?B?OHRwb0I5UlhWdkp2WXVNQm9rZFhMMlBESGhKaXFiWHV2bUMvNFBGNVptU3c0?=
 =?utf-8?B?NzAwTkJlWldQYXBCRUg1NFRQSVBYTkozVGpKTGZwc3lURU40MGhpSDdENUo0?=
 =?utf-8?B?ZHpjTTZzVEp4RXRjWmdKb2R1UGk2eEtPNXVURVFCWlNEd1Bwb0pBRVZwMjlj?=
 =?utf-8?B?MU1LMVhvaXdoTCtmNXBwUlExajFGZG9jeU9jdjZyV1FOVDF1LytOM29pMnE4?=
 =?utf-8?B?SHR6TUpsRHZlbWxrUEsvalkyRGFrd3BZZ05WK2lIeXRCTm9vNVRwVDhXS21Q?=
 =?utf-8?B?d0x5b1ZDQnF4ZVRPT1VFQzN6N25VQ08xcFpmNnF1d2xTUTZkTVRFZ25waDM3?=
 =?utf-8?B?SUZyb0pQVjhpMzJiUEt1WDVZa3FZaTltK2RXMmk1M2hzbjZjckFFYUwrMHVO?=
 =?utf-8?B?U1BCMmJMZEhITVVZSUdwNXlSWXNaYTl0V3NVQ1N5NFdhVEdScVJoN0xXUmk0?=
 =?utf-8?B?VUNiUGZ1QVpQMlBMWlo1bXV1RFAzYmRJYWVxdnNncFJBclk1RnNKSU5qM1BQ?=
 =?utf-8?B?Y0ZLa0VDaENvTTJwdllhelI0aVkwSThid3ZtZzhlZE9ZTjh5M3lPMlFaRnVP?=
 =?utf-8?B?SGdzbDVtWUY4MWdvUEE0ZDMzU0tGQXpiZXVIUHEyUGpWRkp5d0VKc3JRYWVn?=
 =?utf-8?B?c25RTHZlSVl5MjczdUx4bVk2N2czYVBpdURzbmtkWEhiaWptT293dWNjRytq?=
 =?utf-8?B?aWpmdXZURzVkVXBEeDNaWEgrMWxmNjZmalVZM0FRc1ltUjlHTHQyUTA0STh4?=
 =?utf-8?B?OFpaSk91OFRvR2F4bmpQTHZIdnVXMzNFbkhuWGErVjFoREFtaXJxelIzUGVo?=
 =?utf-8?Q?gcbC860p4BockSDA4f8jEu9nU?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a37d21-2025-4268-6986-08dccb187e5d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 06:28:44.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEy6+KZo0eNqxyYjSWlks2Duv9IUri+BJoFXuqDo0z7FCK2AJHRATJaBJ2jGjCzXnqEPek9gKlszcb02V/ZqNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6338

On 02.09.24 08:06, Greg Kroah-Hartman wrote:
> On Sun, Sep 01, 2024 at 11:11:29PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> There are apparently incomplete clones of the HXD type chip in use.
>> Those return -EPIPE on GET_LINE_REQUEST and BREAK_REQUEST. Avoid
>> flooding the kernel log with those errors. Rather use the
>> line_settings cache for GET_LINE_REQUEST and signal missing support by
>> returning -ENOTTY from pl2303_set_break.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  drivers/usb/serial/pl2303.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
>> index d93f5d584557..04cafa819390 100644
>> --- a/drivers/usb/serial/pl2303.c
>> +++ b/drivers/usb/serial/pl2303.c
>> @@ -731,12 +731,13 @@ static int pl2303_get_line_request(struct usb_serial_port *port,
>>  				GET_LINE_REQUEST, GET_LINE_REQUEST_TYPE,
>>  				0, 0, buf, 7, 100);
>>  	if (ret != 7) {
>> -		dev_err(&port->dev, "%s - failed: %d\n", __func__, ret);
>> +		struct pl2303_private *priv = usb_get_serial_port_data(port);
>>  
>> -		if (ret >= 0)
>> -			ret = -EIO;
>> +		dev_dbg(&port->dev, "%s - failed, falling back on cache: %d\n",
>> +			__func__, ret);
>> +		memcpy(buf, priv->line_settings, 7);
> 
> Ugh, how is this device working in other operating systems?
> 

I don't know. Also, the last downstream driver Prolific posted [1]
didn't point to this specialty.

I opened a few of those adapter cables (some received from [2], others
from a different source), and the chips were not labeled (in contrast to
the picture from [2]). So I'm suspecting clones to be in play. Reminds
me of the quest for sane WIFI USB adapters.

>>  
>> -		return ret;
>> +		return 0;
>>  	}
>>  
>>  	dev_dbg(&port->dev, "%s - %7ph\n", __func__, buf);
>> @@ -1078,8 +1079,8 @@ static int pl2303_set_break(struct usb_serial_port *port, bool enable)
>>  				 BREAK_REQUEST, BREAK_REQUEST_TYPE, state,
>>  				 0, NULL, 0, 100);
>>  	if (result) {
>> -		dev_err(&port->dev, "error sending break = %d\n", result);
>> -		return result;
>> +		dev_dbg(&port->dev, "error sending break = %d\n", result);
>> +		return -ENOTTY;
> 
> Are you sure that ENOTTY is correct here?  Why not just send back
> -EINVAL or something like that telling userspace that this is not
> allowed for this device?

I was copying from serial_break() which now returns -ENOTTY if the
handler is NULL. If you prefer -EINVAL, I can change. Just looking for a
consistent code.

Jan

[1]
https://prolificusa.com/wp-content/uploads/2021/01/PL2303G_Linux_Driver_v1.0.6.zip
[2]
https://www.berrybase.de/en/usb-ttl/uart/rs232-adapter-mit-pl2303hx-chipsatz

-- 
Siemens AG, Technology
Linux Expert Center


