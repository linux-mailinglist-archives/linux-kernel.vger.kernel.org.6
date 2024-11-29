Return-Path: <linux-kernel+bounces-425448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579819DC238
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F7B281342
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689AE18A956;
	Fri, 29 Nov 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="o+aFeVaQ"
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020133.outbound.protection.outlook.com [40.93.198.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E9B155345
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876638; cv=fail; b=hhS/OFyK6PwIXyLYxxOvMwypStrS2f9yeOjcoegoCk2BLdsQO/hci6VZJ/KP66fwZ72CW5iAo8+02GYFDugsacb58tg9UzP0XwkAoT8M7gHevK8J7ElXUtmp0hZhv14yXmNZw61enrZxRKmtacvrjjUd3Ve869GC84n6Ss52Lo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876638; c=relaxed/simple;
	bh=z0NCb/sqe1RWvb9g2Sfgyo3mEyVV0K1zZBQtXLa39Dk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g+EYCv6o/NLDoYQjcoW2DzDpxNYBYpc0EOXiS3JUzdM/GsDgDw9HHngW+KProRMvEDHkHmBByz/XI983MSY4NEtAF9jJZIWQAU3A1dLbAMRofL25vacAdY3GYKo9Ekm8H6ToipdKh0hNIakoTVBXVfUDXtgRZcOFjCMaRUceCNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=o+aFeVaQ; arc=fail smtp.client-ip=40.93.198.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E93z81PgINqHM2e+MYwkFrIWXtJLQopAGnnKPJiPfD5QRk8px0v4ZOMF5Plv2s6XlD7jmIwidtfFDbIM6vX20slii7JAnB134kbLHCV93PQIQIHqpbAYQi5Bjy3hqGVi6i5X8g+/SLOwxAdb52DqDy5TwpB8XW/kI99I01x0w9SDeHrx2PuhVqpQmjDjZsQgizSoE9zNfyKFTg+quGC0HCbTxj3LuYxt9tr5aEdDxL7LK7r6PvSD2kVqIXSZmsyZxVfJjgAW370JsWkU0NHztDZBEJbMy0uYvo/xz5JUf9Iq0gMUmj0dS0uzjY/+qwVGhDLdyt6dUyeYXc5XE6SWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t16s0KaSNUM0T3SDDEnR14HUwmXP9j/JtcnTMud70pU=;
 b=QC40Uh6hs2CMK15E7lby6hawwzhzQ/9P3vogsLH3KDfvK5PxQGdjD/uV2YqCQi62I35sWtbjsWsjQ/St4alUcOw0APRH8svURBn0t4yS2ZWD3edSfNnVoeIBd1wtYUOclkBHoQUDgW8+UjKaGsXfdZsR7ooWz+lqfH0uTrwir6XtANTNd9OmQs25SiuEN+17Lig2gqAA4Cc7+g2xFrCBdmD0ku5eAHvWDAN1oiGR8Injw2kGgbRRqVhlALeTUvYydiLgAX+reR3O15Be+wIb+Gou/bnuxDzI+53unwxc6nYkt9WQJmNUeEUq986iqe996D2A8BWiKV1n5SG+ElBlGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t16s0KaSNUM0T3SDDEnR14HUwmXP9j/JtcnTMud70pU=;
 b=o+aFeVaQ8VOmASNXgdtH7ZmyV3UUWQ2bY/ykTroU6lthswlUzqIdem17TKtDuJ3Kii7lNAIx/MOko2PtsXIHixHdpdLv0r3eww9Sljj5aoIgJqYYfRrgT+RcZCthcKyfeAzbavTijlxJ/Re60dqXVHVeXyc12LqSjSX9X6iO4qI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6445.prod.exchangelabs.com (2603:10b6:a03:2a1::14) by
 SA6PR01MB8951.prod.exchangelabs.com (2603:10b6:806:42f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.5; Fri, 29 Nov 2024 10:37:13 +0000
Received: from SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119]) by SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119%5]) with mapi id 15.20.8230.000; Fri, 29 Nov 2024
 10:37:13 +0000
Message-ID: <95afbe5a-89a2-492b-9440-f7ec8e423a6a@os.amperecomputing.com>
Date: Fri, 29 Nov 2024 18:37:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Untangle NEXT_BUDDY and pick_next_task()
To: Peter Zijlstra <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 patches@amperecomputing.com, cl@linux.com, christian.loehle@arm.com,
 vineethr@linux.ibm.com
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-2-adamli@os.amperecomputing.com>
 <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
 <20241129095500.GD15382@noisy.programming.kicks-ass.net>
 <20241129101541.GA33464@noisy.programming.kicks-ass.net>
 <20241129101849.GB33464@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <20241129101849.GB33464@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To SJ0PR01MB6445.prod.exchangelabs.com
 (2603:10b6:a03:2a1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6445:EE_|SA6PR01MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: b00de600-df7b-4286-2ad7-08dd1061c950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXVHelppc0QramJLclAwSmNMNkFsZUVrY0d2d293SEhha09zdG9SeERvcHZB?=
 =?utf-8?B?ZnN1TUQzdXZ4L1o5VUMxYVFQeDlIMjhIblJyVDlZNlU4UEpUYkZzUEsyaElI?=
 =?utf-8?B?Q3FEQm5yaU0rUStWSXhYT1Vwam12UjVUc1hCd1BSSE1Oc1laamZ5WXBmRkpF?=
 =?utf-8?B?R002L0pBcGs0bEtGT0pyaUV4Q1IyZFFCTkMyUnp4UnpONlNCNkc5SFhuM09p?=
 =?utf-8?B?SWZZNHpUbHNYNXQvV01CcmJtS2tNZW5GMWUvZUpHeUJlYlhValN0dGNlZXpE?=
 =?utf-8?B?ZlEwYVRMUFlNZXFvQUppMmVpRCs0SHJCODFieWlwVUdIQ2ZLQ3BnU3pvUDBv?=
 =?utf-8?B?aUFmWDYya2FCTjRodEM1QXZ5WFZhWE1aYk9PcVF3bUtlYTl2S25ZUEhNZytH?=
 =?utf-8?B?dytjZnZVaWQrL2VJOU1MRkp1S0gzWE4vSWxDL2U4Wmh0QlU3U1phSTduOG5X?=
 =?utf-8?B?NVdod29lTkZoSHlnQzRIYnhYRkQxYWE0OERkNER3eTRoL0xXRXhSbXlTVUI0?=
 =?utf-8?B?K0lLZGl5RVBBbThHYTY4dEN4Y2xwYm4vSkI3NTlrTkd4dCtaLzBWaU9tSzJV?=
 =?utf-8?B?V2ZhRWFBaFN0N1g3T2RsTm44cllyblhCWDh0V0VGcTIyZGgrV2xCa3RpU0hS?=
 =?utf-8?B?YlJFN05yTGcvcDEreEdvb0JyRlNFWTgxaEsybDBkeU9CQlBOYklmNVprZHRC?=
 =?utf-8?B?M01Wa0w4VzhBeURyeVNTamRtMGpDcS9IMUw3bFoxejZldWNXMVE4bTRQRFJK?=
 =?utf-8?B?dXozbkV5MFVaR1JScWRzQ2RFcjgrS0Z1TGJBL3JnNGJXMWhmMXBqdUlaLzBv?=
 =?utf-8?B?UWxOMS9vczdmQTBkcGt1R3NwME8zbklKUUppSlpTUHhYT0pUMVkxcjBOU1NU?=
 =?utf-8?B?ekdpc3o0cjFpSkZYTFJ6SUF4a3FyK1R4a0U5QmdITkRLc0xtdjhPOUxFcXph?=
 =?utf-8?B?ZjNnSWtRSE53cHUvTjVWWERuMmx3MDliWndIM3Fac3JYaEFVUzRBbDFNa0Ny?=
 =?utf-8?B?NzNWSDB1bXRwZnlCeVJ0QzZrckdFRFJJTU1laUY4di9zSUxhTjVJRHprN3VE?=
 =?utf-8?B?Z2l0R1hibUVjZHRGSk5rd1hNdkdrcEFSeDQvbWJ0b3N1QzByNjQ5azN0WTAv?=
 =?utf-8?B?MkY1K0srSDRUQ2t3UFhLbUFBSGZ4QWFuS094MElkc3VXSVlKRmhXM2NESVla?=
 =?utf-8?B?WGIzNVMwUUlnRU9NTVhGTHRxNVV5K3NMWmhpN2liY2hTbERtWGJ4Mm9pWmdo?=
 =?utf-8?B?RStxUzZrWEFGRERaWXlnU0dKd2IxeExyUUlHZVM5dndOYVNVcm9xUnZWcHk2?=
 =?utf-8?B?dkVOSzdHenozeUloWks4YlhlMkdvR2xQZXl4YUFvVy80Uyt0RTZIQjhNOGxk?=
 =?utf-8?B?NDd5UGRuNWJPWU84N2IwSmNpb3JlcnI2cnN4RnZ1T0dEUTFUNVFNTlZ3cXVZ?=
 =?utf-8?B?K3grT3ZvY2VXYXl3aFM1Sm5XVHduK2N0bFpmZDFxVkhwVGlFVFBjNUNXNDQx?=
 =?utf-8?B?STJVb29melFMMkh0RG1hcHkvd1REdlFVak82SCs3a0VGMDNKcVNYc0hBOUZH?=
 =?utf-8?B?L0lVTmFVTU9JZDBiUi9YQWlLOUd6M250b0RpMjF5ZXdYako0ME00NGxZbmN2?=
 =?utf-8?B?eHZJdlYyZk9VMytHdTVMam82cXIxaGhwNW02U0JwWTMzZW94NVFFTXkxY2V5?=
 =?utf-8?B?V1Z2R2JqN21NS2pDU0cxRTdsZC9EaXFPQ2lJUmdJUzhMek5xRE9EeHJrWFBN?=
 =?utf-8?B?ck5CVU10MExyK2pOU3VGcVJBMzZocitvSXVYeW0wNitXQVc3YWZwUHJ6SVVC?=
 =?utf-8?B?a2Y5VDBaZHBva3B5RnJUUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amU1d0gzRG44SlowTmF3Yit6TlJ3YTlTZE5RN0J2dTZET3JkOFhrcnh2c2Vo?=
 =?utf-8?B?ZHdubWFlbHhkSW1uWGo3VzJYaGQ3V3NQVFh3SVcrdmVNZFNUUkxxWm5zYkpQ?=
 =?utf-8?B?dXhZbWNRTkppZDg3UDQxd0ZNcVkxR2tlTHJCSnB2aDJHb1puWXdPVWdaNnFY?=
 =?utf-8?B?aTBKdkRtZTZWTjVkOGxKMzBNVjNzSjIrem05OHlTZHRPSytPd3JrbXBlbWZu?=
 =?utf-8?B?Y0phcDRKRjBrVlJqRWtzWEVoVm1tOGVVdktXcFQ3cS9nemVWRlUwY05sV1ZO?=
 =?utf-8?B?MC9qMnUzVlRvODZCWldxR0dmQ2pieUdWaHlXQy9BZVJ0ZTRXbnpyTm1ZeHlj?=
 =?utf-8?B?YVNFYjRqbEE5NzNzSm1qbWdLV0pxWUJhYXBCc1BoVTNscnBKTDFESTIwUXBu?=
 =?utf-8?B?eHVnMUFKaEVNRS9SM01WaGxqT1JZR3ZYVnd6K1B3WXpaUGduRUlaTVVzanhl?=
 =?utf-8?B?U0ZCT211VFR6UlROdkx1Q1VlSnJ2N0pLM0lXTnM1NTIrRlY4akhsSU5WU09U?=
 =?utf-8?B?ZXFhRGxscktrd1R4cXdsdkJrVmY1UlpWeVlmc0UrMU96dEY4OUl2Z0x4Zmt5?=
 =?utf-8?B?NjlZUmUvTmVzcGFhUm9KS3k5bHl5Vm44blpPSVl4cWplcHJ0TEJ3ejZFU0JD?=
 =?utf-8?B?a0ljOFVNbThhVzZzdUhkaDllSko2a3QxbjRwYVNtZE5yREFPVllTWElWajV1?=
 =?utf-8?B?aGt5QnVCMXF5YTJFZHgzT2VlT2FLSHpoZXo3N1MvQ21BMTl1V2xZdk1Pd1NM?=
 =?utf-8?B?WlBGNFBOWC9iYW50bXNGQTVXWHNUdkExVEd2VkVqOUJZcFAyYUdlM1FLZHVJ?=
 =?utf-8?B?Vk5KUUdQTm5Pemx4RUsvQnFmSmRYbTVBeTVaZ3FOMXdrMVlSOXAxTy8xSFV3?=
 =?utf-8?B?WDVTVndOVzZYWllZbEh6eFNJN05uaS92L0lkdER2QUpROHk4ZmhyNUJZUEVO?=
 =?utf-8?B?alRpam5WUE5hVEJuZmdvMTdrZW5Zd3FwV0RaL1JPYm5jSnJObFFOWlFYMlY5?=
 =?utf-8?B?RUlKc1pWNGtrVkdzUUJNVFhrVXFVU3ExSVF0bVB3OS9OR2hkdHhuMDBtUVZG?=
 =?utf-8?B?TTF5ZHVXNEVKVmNydHRkWDZtVlBIVVQvSnovZDBuNis3VDZFOWlONVd4OVRR?=
 =?utf-8?B?T3orQTlncGxhS2lXcHpnSnBWa0M4Zk01cjhMbUdTenRHS04zN1YxT1lyVjZt?=
 =?utf-8?B?UFJIeXRCU0VNK2pFRExMd2ZQWHQzODBKR3FBVjFqdEdobmVwOWdOaFljRERs?=
 =?utf-8?B?ZWxXdHN0Z3NmNXNsNDlIcTRtbUJQWnBWbjgxOWxML0pUelNVVzA3ZFVYaEJn?=
 =?utf-8?B?eU9abFArMlZVNU5lWHloUXM2TVVCTzVHOHI2ZmJBY1ppS3NBUHFNaGl3ZXgr?=
 =?utf-8?B?UWVZV2pZZWR6MDFCUEJianJXTjQraTJsM2x6Z2VqOVYxZkVUOFkxSURFSkQv?=
 =?utf-8?B?K0xNNWE5Znl2SUNXRmExZkV2RFVxT2FTNFAwQnV4dE9BWTlhemxnK3dPZzdE?=
 =?utf-8?B?S0t2NlhrWWF3RHZ6RDJGSnhNbEl5TXQ5YzFlQ0o2QjNRaFhwUENyN2ZXVjQx?=
 =?utf-8?B?eU1TenpGZXdVdCs5ZnBFK09JcGVzM1hlb1ZzUGxmUFpGSitGV09HSllISW1F?=
 =?utf-8?B?ZDY0QzgwNlpYNlo1ZFVtTEszbW1YT0c0UEVCQjNHY3hBcG0xTVpSRHVOSjBh?=
 =?utf-8?B?YXhpb2s5aGo1R3lWNXptQkh0djhna2JuR256UUsxZk1yZjkySjA1bjIvV1Rm?=
 =?utf-8?B?UURsZ085bVBMQmU4b2dmbWpwMnlTR29UMGk5VFhBK3lUYXJXR1NYeEFwNmhq?=
 =?utf-8?B?MWZ1RXpGVFNlSnZ4eGJ5eG1JSVgvWDVXUVZjVHRidE1hUjYyVlNQTTVlRlU0?=
 =?utf-8?B?TzZIUkprQTRqcHhmbVVJVFF5ZmdkcXBETDFQMmtDNE41b3I4RDhRUFVac1Ey?=
 =?utf-8?B?ZXg2N3R3U0Y3djRwdTNuRVZPdlFDZ05YZVFJQTBSaVltS2prQ3FkR0EwWVB5?=
 =?utf-8?B?MEhZWXVKajJSbTY2V0luWTM1RUdkRUJ6VFVkV3dsWTJWUlBhRjYvTU5aSEJi?=
 =?utf-8?B?enJPY3dlZ1RkbHJOcld0dmJXdGZsK3lremxNOWNMUlFJNzFNSEZFL1R0OE1k?=
 =?utf-8?B?ajlkQmliTmdCK25xVUxVMkh2cDd1K0hJb3RoaUlWZkZhS2ZXTnVld2VhTXJi?=
 =?utf-8?Q?/gqh6N/t34+SSmn1P3tQGR0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00de600-df7b-4286-2ad7-08dd1061c950
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 10:37:13.5694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIhUBrTYIQuzXv2lyZgJ1awMLr4XYdaAuWQuRr6J982cCNsKcrhQ3i2Mh4HXw1Ay3rviJvFa321mlQ88gmKCoj53i1BaUtFB3bmPcl/aHeVJRXYehZphKpAmx/xsga+z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8951

On 11/29/2024 6:18 PM, Peter Zijlstra wrote:
> On Fri, Nov 29, 2024 at 11:15:41AM +0100, Peter Zijlstra wrote:
>> On Fri, Nov 29, 2024 at 10:55:00AM +0100, Peter Zijlstra wrote:
>>
>>> Anyway..  I'm sure I started a patch series cleaning up the whole next
>>> buddy thing months ago (there's more problems here), but I can't seem to
>>> find it in a hurry :/
>>
>> There was this..
> 
> And this I think.
> 
> Adam, what was the reason you were enabling NEXT_BUDDY in the first
> place?
> 
Hi Peter,

I am tuning Specjbb critical-jOPS, which is latency sensitive.
NEXT_BUDDY affects schedule latency so I tried to enable NEXT_BUDDY.
However Specjbb critical-jOPS drops with NEXT_BUDDY enabled (after my patch fixing panic).

I will test your new NEXT_BUDDY patches.

> I think someone (Ingo?) was proposing we kill the wakeup preempt thing;
> and I suspect you don't actually care about that but instead want either
> the cgroup or the yield_to_task()/KVM thing working.
> 
> ---
> Subject: sched/fair: Add CGROUP_BUDDY feature
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Nov 29 10:49:45 CET 2024
> 
> Add a feature to toggle the cgroup optimization.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c     |    3 ++-
>  kernel/sched/features.h |    8 +++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7126,7 +7126,8 @@ static int dequeue_entities(struct rq *r
>  			 * Bias pick_next to pick a task from this cfs_rq, as
>  			 * p is sleeping when it is within its sched_slice.
>  			 */
> -			if (task_sleep && se && !throttled_hierarchy(cfs_rq))
> +			if (sched_feat(CGROUP_BUDDY) &&
> +			    task_sleep && se && !throttled_hierarchy(cfs_rq))
>  				set_next_buddy(se);
>  			break;
>  		}
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -32,11 +32,17 @@ SCHED_FEAT(PREEMPT_SHORT, true)
>  SCHED_FEAT(NEXT_BUDDY, false)
>  
>  /*
> + * Optimization for cgroup scheduling where a dequeue + pick tries
> + * to share as much of the hierarchy as possible.
> + */
> +SCHED_FEAT(CGROUP_BUDDY, true)
> +
> +/*
>   * Allow completely ignoring cfs_rq->next; which can be set from various
>   * places:
>   *   - NEXT_BUDDY (wakeup preemption)
>   *   - yield_to_task()
> - *   - cgroup dequeue / pick
> + *   - CGROUP_BUDDY (cgroup dequeue / pick)
>   */
>  SCHED_FEAT(PICK_BUDDY, true)
>  

Thanks,
-adam

