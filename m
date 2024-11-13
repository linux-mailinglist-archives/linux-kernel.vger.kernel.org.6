Return-Path: <linux-kernel+bounces-407151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C09C6971
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB53284880
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0A317C98C;
	Wed, 13 Nov 2024 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="b11823fI"
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011035.outbound.protection.outlook.com [52.103.67.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A6E2594;
	Wed, 13 Nov 2024 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480211; cv=fail; b=kg+EK01bSY3ZfzNDb4xA91JHiyruu9fU0CRF5D8fz0lWGMRqdjTxA4kB7dc59Xo0qF4sudacfvRNmAEFFUaA/wYU0+JU1QXiFeYmFGyE3+tK/a/ew0bIe94izJOSp1WxTQRdJHuSFhkTV6J+4eej09oG89kwtq1Ku0yhKXzmdvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480211; c=relaxed/simple;
	bh=nlZ+LMawH4VAOOkkvU/HwW+JsWW6UjeGPawhaMRbBxs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sdvIS4Kpr1cKkQJaVmazP8RakpQ7Wy7sNE1pWxIHXmuTSsahQy6xfK2n/4/THqZgyacdnpR/u2431OK2hBxX7BIRk81CG2FCwuZdbIdceQEEf0Y68RwLTvLOfKC1YPLAy1tiFRKFe8HGcE8ton13DAlZCakk3aBddCChE4xVQvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=b11823fI; arc=fail smtp.client-ip=52.103.67.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoYoIMBIC4EgxGamUlvJ+Ti+duKRAaODBhMncOB/BN8Rp94LrIxoCBAm444FXwAJtVcjpPTK5ZazkawVUCKg+lJ6OMRC29ymIPJ55W4JX1315FiBfiBhQCFEOncVGhELs5Bq7cvLDjkuD1N9ShqzLW5oZOtObFp3DivYNWxN6bNAW3dy3vvSUvO1oeFxWBruqvkarNsOHwH4rsF+2Dx/zr/s4yzQ4wVqRyAGT8yquZ90/4fHI9bmkTTaeZ09jHIrxlzhgl2mS5dxiae2SzyWyLjV4LMqQV9Ge7IjN4wIw/g+pr7kSTNN88COavRfX2DTO6Wj9VMUeuZrtBlN87JWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nLT50cmzbKuoelNT6OmB6gKOsYGwagSNu4JPQDp9KU=;
 b=tNT4zUs/XWPoGGi4WjCEVDKNFuXQSvczV1smUB48XRPQXITn1zfBw0WT7gx4qgJaiuwEC+cHw450RcRFhe9Q/ntxfWZhUzxyUl3R78teiaEGVBsZxXXCzk5oRscJwndjPD/woImNwnAWU7BjBXBze/zHI3rDhaJv24QPZB8hpRUMr7vCbAiG1pNMS1TdtOY19RjRA7K4g4+dPVOf3tb3KFBO+KcX/bBexG4SvBwBoHLyQrbYkISny4YiN7CJQSatL3Y6fsqImeuZunMOwpfPC8Hf/cuXGvBl1yvFPQppXQzkAxptl6m0zQj6mfXKu1xRc0h+i/0FPe1wVuEVnVCYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nLT50cmzbKuoelNT6OmB6gKOsYGwagSNu4JPQDp9KU=;
 b=b11823fIPvCXsHhomRf1Ag5QwdAuq1E4mu5g9J2xFETQyD6bqdTN9msef/KkLzsGPr3XyXP2GSWAHSSF0vtojfPmX7cXrETAv2t026VkJqfkikQ2wNnYTz5iKac04pw50u9vmMphZVuPcLbm12OJjCmMeeTlNyTjZ5isM7yeYb7OpRN1quatwh9T+JuthnS3GIUdHBbK9mHg1fQX8RxbgjGDa904VHnMOBYwUj+4wov4XwWr1tr6+mmiHz3mw0FXcukXFCd56msFQctcTLJftfMnsmNUnghQSfxykLGSM422dfHtxzQs3DTCL77Be9bnADATR6MI3XeBm7eIqjACRg==
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:214::7)
 by PN3P287MB0917.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:176::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 06:43:21 +0000
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d]) by PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 06:43:21 +0000
Message-ID:
 <PN1P287MB28185C9DA26A773775BDC4C6FE5A2@PN1P287MB2818.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 13 Nov 2024 14:43:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
To: Thomas Gleixner <tglx@linutronix.de>, Chen Wang <unicornxw@gmail.com>,
 u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 robh@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <cover.1731296803.git.unicorn_wang@outlook.com>
 <8076fe2af9f2b007a42c986ed193ba50ff674bfa.1731296803.git.unicorn_wang@outlook.com>
 <87cyizmzhf.ffs@tglx>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <87cyizmzhf.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To PN1P287MB2818.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:214::7)
X-Microsoft-Original-Message-ID:
 <51e60288-2bc3-4267-b39d-0f8b90ec8f24@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN1P287MB2818:EE_|PN3P287MB0917:EE_
X-MS-Office365-Filtering-Correlation-Id: 658f539c-1a5b-43b2-5f23-08dd03ae772e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|6090799003|5072599009|461199028|19110799003|15080799006|7092599003|4302099013|3412199025|440099028|10035399004|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFFMM0h2MGhVdE9KTmFUbjNDQk9NQjRxb0RWVGN2cGFhSnEzL1ZENGFBYWx4?=
 =?utf-8?B?VE41a2V4azVJNUFKYjFIc0tMOS9XWjNzeTkrTjBCdFY0SWRXMUVDV2RRekp4?=
 =?utf-8?B?U3E0TU5NaXdJMjIwdUNPTVJDeHl4M0x2M29uMFUrNTJKSU81dmR2MVl3MlhQ?=
 =?utf-8?B?NmgrZ0JDT0NuUG9MeXJQd0hKRmJhMzRWUC93cXlTSUwvMUY1YUJtaEhQQXBx?=
 =?utf-8?B?ZEttdWFBK2U1aXhDQytlTW1zWGR6QlVVUm1MNFNIZk81SHdtejQzb2NUTTY5?=
 =?utf-8?B?ZFM4OGg1bXNJUmFreHFaMlF2aGdSbktrZW96Y0xWam9qS1VMOUxURStLTFdi?=
 =?utf-8?B?UkYwM1owZkM3eXU2WEJLWmUyakljQWFGWGVCZGVoRlFaaWlDVklVclpWRkQv?=
 =?utf-8?B?YXJ4bFhZWW5kZUMwaTdFVWMxWFZzQVhVNG1EUGMvUXJLOG52SldHcGY1bTls?=
 =?utf-8?B?K0gvdnBlcmJjSU1Wb3RoODJhNnluVXZnUHdDV1VEaGkzcnc2VzNZekR4OWxr?=
 =?utf-8?B?UDZscE53T3ZKK1hUeTdwdEtaSWlvTVRkNXNXM2ZUNnJHMmpTd0s5TUwreTBj?=
 =?utf-8?B?aWkyaVFVOFg4bEZMSno0NktlK1pBbXJPUlBpL1VteTFrZXFyQXgxaGRGRU5F?=
 =?utf-8?B?QVJPVlk3ZXpMUE8vTjdpZmNQUk1YczRSSmZ6V1k1N2hMSDlNMmphTi9QMkkx?=
 =?utf-8?B?ajEwUzRLQ0NXR2lKZWkwM3hEUllQMEx6YTE0QXJhOG9DemoydkJlYUlKMGNT?=
 =?utf-8?B?a1M5V2o3NHVGeHJFbmJWRDEvNldWckFBUXdGcjJRZ3MxZ2hQdUpSNFVvVFAv?=
 =?utf-8?B?dExJamRFRnVnOEJSelF2Ry8wQ0dWMm1tRUlOaGt1NmpybzlCZGRNVTk2eHEv?=
 =?utf-8?B?UE1acmxOOFpTa3ZEM0FlN1FwUjZJekFwQ0RzQ1hHaExQVjVKMzlxVDlYZHhq?=
 =?utf-8?B?ZS9aZFJ6MWxURGpMYkdnd085WkJJTTkrM25EcjYwMVAzN3A5YTFRMitSUmJl?=
 =?utf-8?B?WkJaWXZLVGFmMDAwb0tnYTBvS0IxbUhKMjM0ME5pWW5yWTJoaGxnOTZYb1ls?=
 =?utf-8?B?NUtwSlB1RE1OblR2Qys5dGF2ck8vZkxHbFpOblNNL3d1OGtXQ3p3ZWNrdG9F?=
 =?utf-8?B?cERmdUU3SVhmM2l6Wm1ybURmWkhWRkZicEdod0lId1BJV29NWmRydzc1d05k?=
 =?utf-8?B?QzF3ZEllOFdDMXpPZUV4Mm5aK1JjY0UyT2xzV3BkdGVSaGFRSWsrREhIYU1G?=
 =?utf-8?B?ZnJSaDV1bWpFWFhydkZLdTcycHIvWWh1K2FKbG1HaU8wbHhXUXl2YnZhQ0Ju?=
 =?utf-8?B?Yks5bzh6ak5mMmVtbTNTeURveHRhY2hHQ3VLRHFzNVVZQlNoYUlwZGVuQ1Zt?=
 =?utf-8?B?NkRPQ29mRStFMXNWdTVMOEVsczdab1k0MzB3UzhRc0czVHpCWUhiaktCQ3l1?=
 =?utf-8?B?dTFwZTMrdFFZb2JsSXoxbWhJRTkxL05mYlZKdFdJeDRJbGlmcTlXOGJlOGdm?=
 =?utf-8?B?Q0dQbWpIeFdsdm5mQ1BXVEd3V0ptWVhVRUVNYUg3SXF1OUYvL1g1ZUwvTUtv?=
 =?utf-8?Q?fat9P0wmXtUH2OgC7Rt8rTmfYDGV4JGGbBg/btdauzHito?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0ZocEhxRXFtM0JncEttQy9sT1pLRUQ5R2ZWZk9MWTZIcGxneTlhYVlUeWU4?=
 =?utf-8?B?NHRmRFp3YVU1KytFU3JzcW1ZMnhTa0hheVpwVkdnWVg4Q29HTk1Ub3pUQmRl?=
 =?utf-8?B?azJHUHRNaUF1ZTRDeWV1TjdnSHI3LzdWc0h2dXQ5Rm9RcFpBanNWd2FJTVdC?=
 =?utf-8?B?dFkxYW9LdFlzYWUrc0RRaURWWEVESmFUajI5d2xkUk50VEN3RmlnWUp0UlE0?=
 =?utf-8?B?b0c3ZUFaV1pWeHBibUtFYy9ESXNiclhUd1FsbW5uTWZGQ25LMVVqV2hkVkha?=
 =?utf-8?B?M1l5WTQraitkZzlzMm1jZmtBamxaakpZV01NV3p2aWNxOWRFU0UrRXdUa2xy?=
 =?utf-8?B?WWg5RVdMYXNjM001bVlaRWhwbVFnQ1BuM002OVdrMHRSbFFRZURqZy8weUlS?=
 =?utf-8?B?aGMxcnhVZitSVzlFcmJBU0RNVVIvcHpldTREMXQ1Yk9vOGc4UWVjdGFGSy9P?=
 =?utf-8?B?WTY3SXVDNEFOUVN3aW9Xa3R5MUgvMTd6ZmVrMjdiMnNkY3VuWi9CbmVFWmVq?=
 =?utf-8?B?dy9SRVFHSE05V0RhbWI1ODh5SjUxK1ZFZy9mZzRKcDFrTGN4OXhyN2NJSzU5?=
 =?utf-8?B?ODgvaGZQSDB6dncwMVFmTEFYaHhXVGZtWDVOUmM5citoVGN5bkViSUdUYUFT?=
 =?utf-8?B?Zys5QjZnRm0xa3FxZTZrcSs1SUx3Ym1LQUZmTFcyUktuUUJkSGIxZXkvWW9H?=
 =?utf-8?B?UEFVSHpvTS9PUWNzUUZCb3ptTmlKdG1DR0lSMXRyU0JZQzMvNUZ6MHp0WXdV?=
 =?utf-8?B?ZlB0R2R3VmpMTTVRT0RDWEI3T0IrN0lPWC9URTVkUHEvNjlTMWttNXdVN1VF?=
 =?utf-8?B?c2pZZ1hjRmhrbDVBd3owWlM4ZS9UaG8yTEdneWtKSEpoMkpiZC9UK3FFVUdV?=
 =?utf-8?B?Y0ZKeGlLOVlsTlV0TXU0OFhyK2pLV2VMYUdHTHhUbHdibjZuZTI3dXB3bGRG?=
 =?utf-8?B?WHY4YnQzTFFnSkI3ZHBTbVpwUVJqdktUOE4vTjRFWWxkVC8zYXh2SnRpa2RL?=
 =?utf-8?B?MlJCaXJpd2g3LzBjSGZSNUc2R1dhaHM4M243ZlYweURJQ3VaT2s4RFpNaytm?=
 =?utf-8?B?amFOakZOM2FIRENCMmhHTFV4QkZKVVlodU8xTFZDWUw2NDJvSWxCcW9BYjFH?=
 =?utf-8?B?b3pCK0pZYVlFaHJnUURmYTVsVlBhODlUMTVaQ28vTFFva2ZiQW1adnBJUEJi?=
 =?utf-8?B?T1BIRFVBR2RaRDNCcnFtVStUTVpXZnEzaklNeGlMMnhrWHJwMFdDNWVneE5j?=
 =?utf-8?B?MUJiMHUxZFh6NkRNL3FSdFBQeXZxN3BkcElVanlsK3luTks5RGNxWDRoaFls?=
 =?utf-8?B?UlA5VmlCcTcyYWpIcWZybkk3Ukl2cG83Qnp4V0k4dEVlaVBkdFZmTHhmUjZR?=
 =?utf-8?B?anhpUzc2a1VMTWQrbkVwekd2L1RtaDRtL0pEUjU4UUdDaFNtUHdvSHExak5r?=
 =?utf-8?B?ODNKTVpLT2FTWjNKVXM5SXNlMTVpUUh0aHc3ZmJ4bXRkRG1FbUt0MDd3RDZx?=
 =?utf-8?B?SXFqd1pkWmRvV3lsL1NwOG1uT0Y3T1ZQb1o0WTU4V2lSam9nY0NDN09IQXdZ?=
 =?utf-8?B?ZWIzUm5tQUNZdEI5RkUxVjNxN2RlVEpSa3BIRVdEekVtcjZIVFhMUWVjYjdD?=
 =?utf-8?B?UVp5OFcwQmNuaEw1WEdtMmtvU0VKbkh3cTZyVEI2cWFhQ256a2ZIUGQwdFow?=
 =?utf-8?Q?70mp3o17GTZ95tyXKFFL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658f539c-1a5b-43b2-5f23-08dd03ae772e
X-MS-Exchange-CrossTenant-AuthSource: PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 06:43:21.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0917


On 2024/11/13 14:14, Thomas Gleixner wrote:
> On Mon, Nov 11 2024 at 12:01, Chen Wang wrote:
>> +struct sg2042_msi_data {
>> +	void __iomem	*reg_clr; /* clear reg, see TRM, 10.1.33, GP_INTR0_CLR */
> Please make these tail comments tabular aligned so they actually stand
> out.
>
>    https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#comment-style
Got, will fix this.
>> +
>> +	u64		doorbell_addr; /* see TRM, 10.1.32, GP_INTR0_SET */
>> +
>> +	u32		irq_first; /* The vector number that MSIs starts */
>> +	u32		num_irqs;  /* The number of vectors for MSIs */
>> +
>> +	unsigned long	*msi_map;
>> +	struct mutex	msi_map_lock; /* lock for msi_map */
>> +};
>> +
>> +static int sg2042_msi_allocate_hwirq(struct sg2042_msi_data *priv, int num_req)
>> +{
>> +	int first;
>> +
>> +	mutex_lock(&priv->msi_map_lock);
> Please use
>
>         guard(mutex)(&priv->msi_map_lock);
>
> which removes all the mutex_unlock() hackery and boils this down
Thanks, will double check.
>
>> +
>> +	first = bitmap_find_free_region(priv->msi_map, priv->num_irqs,
>> +					get_count_order(num_req));
>> +	if (first < 0) {
>> +		mutex_unlock(&priv->msi_map_lock);
>> +		return -ENOSPC;
>> +	}
>> +
>> +	mutex_unlock(&priv->msi_map_lock);
>> +
>> +	return priv->irq_first + first;
> to
>
> 	guard(mutex)(&priv->msi_map_lock);
> 	first = bitmap_find_free_region(priv->msi_map, priv->num_irqs,
> 					get_count_order(num_req));
> 	return first >= 0 ? priv->irq_first + first : -ENOSPC;
>
> See?
>
>> +}
>> +
>> +static void sg2042_msi_free_hwirq(struct sg2042_msi_data *priv,
>> +				  int hwirq, int num_req)
>> +{
>> +	int first = hwirq - priv->irq_first;
>> +
>> +	mutex_lock(&priv->msi_map_lock);
> Ditto.
>
>> +	bitmap_release_region(priv->msi_map, first, get_count_order(num_req));
>> +	mutex_unlock(&priv->msi_map_lock);
>> +}
>> +static void sg2042_msi_irq_compose_msi_msg(struct irq_data *data,
>> +					   struct msi_msg *msg)
>> +{
>> +	struct sg2042_msi_data *priv = irq_data_get_irq_chip_data(data);
>> +
>> +	msg->address_hi = upper_32_bits(priv->doorbell_addr);
>> +	msg->address_lo = lower_32_bits(priv->doorbell_addr);
>> +	msg->data = 1 << (data->hwirq - priv->irq_first);
>> +
>> +	pr_debug("%s hwirq[%d]: address_hi[%#x], address_lo[%#x], data[%#x]\n",
>> +		 __func__,
> No point in having this line break. You have 100 characters. Please fix
> this all over the place.
Got.
>
>> +		 (int)data->hwirq, msg->address_hi, msg->address_lo, msg->data);
> (int) ? Why can't you use the proper conversion specifier instead of %d?
Will double-check.
>
>> +static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain,
>> +					  unsigned int virq,
>> +					  unsigned int nr_irqs, void *args)
>> +{
>> +	struct sg2042_msi_data *priv = domain->host_data;
>> +	int hwirq, err, i;
>> +
>> +	hwirq = sg2042_msi_allocate_hwirq(priv, nr_irqs);
>> +	if (hwirq < 0)
>> +		return hwirq;
>> +
>> +	for (i = 0; i < nr_irqs; i++) {
>> +		err = sg2042_msi_parent_domain_alloc(domain, virq + i, hwirq + i);
>> +		if (err)
>> +			goto err_hwirq;
>> +
>> +		pr_debug("%s: virq[%d], hwirq[%d]\n",
>> +			 __func__, virq + i, (int)hwirq + i);
> No line break required.
>
>> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
>> +					      &sg2042_msi_middle_irq_chip, priv);
>> +	}
>> +static int sg2042_msi_init_domains(struct sg2042_msi_data *priv,
>> +				   struct device_node *node)
>> +{
>> +	struct irq_domain *plic_domain, *middle_domain;
>> +	struct device_node *plic_node;
>> +	struct fwnode_handle *fwnode = of_node_to_fwnode(node);
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations
Thanks, will double-check.
>> +	if (!of_find_property(node, "interrupt-parent", NULL)) {
>> +		pr_err("Can't find interrupt-parent!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	plic_node = of_irq_find_parent(node);
>> +	if (!plic_node) {
>> +		pr_err("Failed to find the PLIC node!\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	plic_domain = irq_find_host(plic_node);
>> +	of_node_put(plic_node);
>> +	if (!plic_domain) {
>> +		pr_err("Failed to find the PLIC domain\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	middle_domain = irq_domain_create_hierarchy(plic_domain, 0, priv->num_irqs,
>> +						    fwnode,
>> +						    &pch_msi_middle_domain_ops,
>> +						    priv);
> So now you have created a domain. How is that supposed to be used by the
> PCI layer?

Here I create the domain and attached it to the fwnode. In PCI driver, 
it can set this msi controller as its ""interrupt-parent" and find the 
domain attached as below:

static int pcie_probe(struct platform_device *pdev)
{
     struct device *dev = &pdev->dev;
     parent_node = of_irq_find_parent(dev->of_node);
     parent_domain = irq_find_host(parent_node);
     ...
}

>> +	if (!middle_domain) {
>> +		pr_err("Failed to create the MSI middle domain\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>> +static int sg2042_msi_probe(struct platform_device *pdev)
>> +{
> ....
>
>> +	data->msi_map = bitmap_zalloc(data->num_irqs, GFP_KERNEL);
>> +	if (!data->msi_map)
>> +		return -ENOMEM;
>> +
>> +	return sg2042_msi_init_domains(data, pdev->dev.of_node);
> In case of error this leaks data->msi_map, no?
Thanks, I will correct this.
>> +static struct platform_driver sg2042_msi_driver = {
>> +	.driver = {
>> +		.name = "sg2042-msi",
>> +		.of_match_table = of_match_ptr(sg2042_msi_of_match),
>> +	},
>> +	.probe = sg2042_msi_probe,
>> +};
> Please see the documentation I pointed you to above and search for
> struct initializers.
>
> Thanks,
>
>          tglx

