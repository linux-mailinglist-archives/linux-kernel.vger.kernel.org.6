Return-Path: <linux-kernel+bounces-334610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E1497D995
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 20:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14C52844C9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC417CA09;
	Fri, 20 Sep 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aVa7exFQ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2047.outbound.protection.outlook.com [40.92.23.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5718EB0
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726856556; cv=fail; b=oi/GrRZ+xfjaZmht2HnNMh28fv+Ce9slMeSN2bmgSCPQbpZK70psCM57Ur+LqIE2a9H7/+oKzNHa9rii3wq23gN89yrwkTr3hd+xhmtg9B5+2GmSmvX0kMAP/lU8CGZEi/GY2g3hzFLC7MyZ7W8f2aEwvKfeF1gOaWL1csayVGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726856556; c=relaxed/simple;
	bh=+hQUtaHAPoeiuWgpk7mqD4OJqh2lFvlvt55NRvamMF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=reb/5iCsU+j7hy/qNkJI+uQqtNk/kZU8YhhpFbluwozE+hNFlzg0dw7NKyC0mSy8yDcEawfn2UI9AWIHERqZZixWuwjAXj+SXWhwwtyjEDFofJKPuXwZZBapei5VOVxxrcEvhqEJC4ubtqtdrgJpOueKA4Y412TrkPnmqRo49u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aVa7exFQ; arc=fail smtp.client-ip=40.92.23.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+cpvmz0JO3uxKfXQBgydw4mBW1Blu83G+qIyuZ7aLi/mSHEX0ThG3IdDK/KdJe0v6ZnWzG+bimY8yv+/QJpR6ZRXhw9vEYbHPKNDxrC9PFqWsKqcR6t1V88qitX5ayG/ChYGF9gyvWVIn6XYoAHyD52gkAzBhBNXgkLzY7QRg495KzcbjmCTH77EGWRzYZHHv3H4iR+4PTeP6DIo7ENv44CrbySZu2+0P8uUmBA/jpoAeZUt2ZH7kgv4a4qP+4mgKIna0QkzO+P7N4jEgSy6LmHxQ4oUC3Aq9blA1cOrCwppGPnt+9AdxKh4RloObolFBHIe3sJ8IJVg2NwFy/LJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9exgvxaJhPb5swOue1KL9QMhTdEZ06oSAP1azOPm3tY=;
 b=TvCMgTXKWzSHBzSQjGteRICOlhALu1J1dgOrXgl9fbC+G2FVxQPE5V+hVGALqS8rpqfFhjEAI0Blq52Uw+ita7zoNl3ZpGWGXBfXIpvC7JqU5CQkKMj4JWZo3v894MKwy2HQg156rriacULNvjtujjmdTyT+BKoCR3drodJZ13HlQ7eHe/IBBfa8tzwd7ej4Xa3gr2o1TiHbVFm+w+s0lgpjbfT+75kEp3+57eqIkyNkh+sF53Ay9Wohb8HhZWD74DItmwOzp7imO38RFvM2iUJ22+DAnyO1YvQKGZPG+hDJ3WBARLQToyqowRqD8X098GXJ81sVVUIenuxyjvZFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9exgvxaJhPb5swOue1KL9QMhTdEZ06oSAP1azOPm3tY=;
 b=aVa7exFQjqvuR1AseWm9tTqksf3Xh7d5Fit13y+Yst4zylU2qX1V9SnahhDhsS9pbtaBsUttdry/JtNqoWwc1miE85SKBrGIjxUSZljNSTSiCi8r6QVqQSekXuwB5xUkKrNJGxHfpjTjqmuTdbg0/CKiqzbuv8TUyEpMbp+QXg8YWdg62II1jAj4d1eetDVlDl+S3km/vpD75Qs5i1hieNt2+Fl1BytqAO/cvjTpvb5FLQAQgFF+1HAW3q8Oxqwigo9C2BnAQS6w068tvoJlinHXSik1ERt5aJhgM6O8SIOkc0Kx5wKy7eWAY1dMrB8ES73Q5baNc9YV2clL37wVyQ==
Received: from LV3P223MB1042.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:1ac::17)
 by PH7P223MB0595.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:1ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Fri, 20 Sep
 2024 18:22:32 +0000
Received: from LV3P223MB1042.NAMP223.PROD.OUTLOOK.COM
 ([fe80::73cb:43b2:8700:eb39]) by LV3P223MB1042.NAMP223.PROD.OUTLOOK.COM
 ([fe80::73cb:43b2:8700:eb39%3]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 18:22:31 +0000
From: Steven Davis <goldside000@outlook.com>
To: ankur.a.arora@oracle.com
Cc: akpm@linux-foundation.org,
	frederic@kernel.org,
	goldside000@outlook.com,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de
Subject: Re: [PATCH] irq_work: Replace wait loop with rcuwait_wait_event
Date: Fri, 20 Sep 2024 14:22:16 -0400
Message-ID:
 <LV3P223MB1042D6E8F26C131780375218F76C2@LV3P223MB1042.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <87ikurhvf1.fsf@oracle.com>
References: <87ikurhvf1.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::32) To LV3P223MB1042.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::17)
X-Microsoft-Original-Message-ID:
 <20240920182216.6024-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P223MB1042:EE_|PH7P223MB0595:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8d49c0-4a94-45a6-1e18-08dcd9a130ef
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7042599003|5072599009|8060799006|461199028|15080799006|6090799003|19110799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	rJx5yeruyvuCemEYL/jMPyj3yLW+LQS3wKg054gps36Toln/Luym64ko58Oe6XMWnJlV1UmB4hMNE2pOQRgSWfq8hGiHtvdehT2JXOrkRApaElXkY82qvFJVqaJtxDU7zwdVNA2C9iB2470bAcmfth9UF1oR/F1vs2WhC8Vjqcd99O8x5oLWZbrtLhVlYPu5iccIaJB7AeyD11jG3H3wT6tM4VL4wzKX8ugzeigp5QcKMVjziMAndeJA/Wd8uo0V1aD1ojV6zeOfzi1TvgpM3OGpzyiBts8/iVDRFow8uPpbgdzAFslg6XzLpurvtUFc14clLP5tp6hTzZO8h7QMb7Wsi4GE7jeteq6h9kPpU1P5kx4ctgd5fsnpjfdnkVwRvX+K1vFQyTBb1o7MaVf8J3M2m0b70Z0+5Eh8Et3PPBgR0W9IYxzl8zcrALL6dWbsS3OfFgZZLHc0Z1N7JVQa24tWytkh2L2ErZjVcpExo6z/QOI762j4Qw/Mb96qcTTZX+E7+Z9D9TiMxI0+GHWD1AyDsnArh0tDa3VGR2umsoCE55G4e2mUaCrLORr5DtnZy+DQNtJyrriJlqTTGQb3VASxvCEqNtDyslsc8uwzBpk/Ed3QRH0l8C7+74pyi8I5KXhSmKrJkbtXkEAW3UXsFZBGwT1B7Mr66IcD0Fj27HBYtXJg5ar1VxYi5iPy/NulN+7JuT8n6MEYty8pFk/CaoWkAsUnOrunTXaSV5QXWN8sGlDeupdBVzIxqQmqEBDVjwaq94TzOMpTTnFwOUmGUrAUYh9y4t2qaFExrVgaWw0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWhZS2xuMkswbTJLd215eEVqQUpzc0Y2ZEE2cDhjTm5WMHRKOHY0aUs5VVht?=
 =?utf-8?B?MHJBYUNicjhCVExSaVVPYjNCendRUzBVT1QvNG1teGtaT0ZLcm1BdHZ5cGF3?=
 =?utf-8?B?ak9BOU10Sm82cmxkMGtUaDJrZEtoSzV3emlxVEFXTEMyT28rVk82UEZ4SW4v?=
 =?utf-8?B?cjN6VkR5Ti9md3U4eUROMjl6cGZQQi9jMWhFbGVROElkTGs3OENVZzhOWWxt?=
 =?utf-8?B?eXdCUmJhQUMveGo4SmJMRFp3UXo5SCtQY2xUa0hUQzg1WDR2YnUySm1yVUtS?=
 =?utf-8?B?TkQ3aDY5ZHFaVU9oN3BlL1lKdFBQeVlrQ2wwbjZyMlVTWGNDeDh5ZEFhTFFy?=
 =?utf-8?B?K0VDUlFXNXNGRTZtSnhzRmtkNm1lSVNzemx6ckUvblVFalJPM1hSdW0rM3FJ?=
 =?utf-8?B?NUdzaVBJQmtJRGJQNHFBSHpsSldtYVZjaTBLSFl4U2hJalZaYkMwS0JxUUl2?=
 =?utf-8?B?T3pyQUdyV0hkNm85MldUcHdLOVhjZ0lSb0txR05pQldnNGNsb1NzTCtqNzFj?=
 =?utf-8?B?dDQyb3ZjajVQdGdwbjJ2eFhKV0NvTHhURmtTQXBrd0NSSmhiajFLMm9tRFZE?=
 =?utf-8?B?MElNMzFVdEhhZFQ5ei96endkZkhNTGF2cWpFMmNCdlg5dEtSNlNJelFuWHN5?=
 =?utf-8?B?NnM4Z1NwTEZvRHp5VjlYc1dUdk5pR0RwajJYTk9DSTVnaGdwdmE5TzZncGxN?=
 =?utf-8?B?Z0ZXaHM5MWoweWpRY2xOaWRmbDhpQi9GZ21DZFFSUFJOMUF5ZHprT1VxZXUr?=
 =?utf-8?B?a1E2RHQ3NjZ2WExEQzRWODh1bmtzbXdMSEVpazRockRDdmZ5eWZ0S3BXb0hB?=
 =?utf-8?B?cnl1eFlreGpYMWlxc3N3ZnBBbURLa3VvUEN4VXdYeHY5NkVKblhHaGhYZWo2?=
 =?utf-8?B?QVF0YWRYenFmUmRNZm5lYklubDV0RE9CVmgvc0JaNFFaVlFGV2xRcWNWQURR?=
 =?utf-8?B?MFlKWE1jcEpldmZ0ODdXUXlLTmt2bEVNbElodXpad0c4dnVaQTZ4UjBCeENy?=
 =?utf-8?B?VjFUdXhtbWxVbHhmRnQwNXVwRHZSNit5ZWEwWUVlUHQyR1JXR0RDaFRTcUZi?=
 =?utf-8?B?MUpLOVRCbnd5d21KcTVjbWRkNFhHamR2TWdrdUV2Z2VlRVZ0b2t1alVEWG9t?=
 =?utf-8?B?TUtDTS9lc3hRc0dDM0tmME42YWtiZm42S1VmQlYydzBkcFRtWGtPMG9yNFk1?=
 =?utf-8?B?c0k0NkNGMkpHdFk4bW9DMTlCVFB0YWM2L0lRWWxUSk41QmVGY0J0UG1CeEFk?=
 =?utf-8?B?UXdHdlVTVlhEaFVoNmhYaWZjRm1pbFJ1SE5uU0hNS0ZLVnJRL2lIcEpDcUM3?=
 =?utf-8?B?S1pseG80ejZIY0VwaE1WNmdUQ2ZWaDhCOWtSeDlDbk1pYTRHRGIva1ZOMnZ2?=
 =?utf-8?B?OE01UVJhSkJiYXdtVjQvUVZ3amxUbjUrb3J3Umxxdzh2RVlrQlJDbFhRRWsx?=
 =?utf-8?B?QUVMZlRnZlJQUngyLy9aK0dVdnJVSHM2aSt4QTVSNVk0ZlZNK1BSR1A1ZHpN?=
 =?utf-8?B?YnVZSUVReXFaM1ErTEMrYU1JTXlCWi90SFpXOGRhTmUyNzVtTjM4NE5Mc3lF?=
 =?utf-8?B?SGZ5ME5vQkNKTDFsQ2VoNGZTTm9lZWlxTkZvdXNaSWp4OWs1L1N3VHhESy9x?=
 =?utf-8?B?Y0FmZzQ2TXNpa0NzWjR0MDNFUzNPclRjelJJeWRUazFmbEE2dkFJWWlDNzhz?=
 =?utf-8?Q?A3y8l5BB/JKvz9Yv4T9k?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8d49c0-4a94-45a6-1e18-08dcd9a130ef
X-MS-Exchange-CrossTenant-AuthSource: LV3P223MB1042.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 18:22:31.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P223MB0595

On Thu, 19 Sep 2024 at 20:10:42 -0700, Ankur Arora wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
>
>> Le Thu, Sep 19, 2024 at 11:43:26AM -0400, Steven Davis a écrit :
>>> The previous implementation of irq_work_sync used a busy-wait
>>> loop with cpu_relax() to check the status of IRQ work. This
>>> approach, while functional, could lead to inefficiencies in
>>> CPU usage.
>>>
>>> This commit replaces the busy-wait loop with the rcuwait_wait_event
>>> mechanism. This change leverages the RCU wait mechanism to handle
>>> waiting for IRQ work completion more efficiently, improving CPU
>>> responsiveness and reducing unnecessary CPU usage.
>>>
>>> Signed-off-by: Steven Davis <goldside000@outlook.com>
>>> ---
>>>  kernel/irq_work.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
>>> index 2f4fb336dda1..2b092a1d07a9 100644
>>> --- a/kernel/irq_work.c
>>> +++ b/kernel/irq_work.c
>>> @@ -295,8 +295,7 @@ void irq_work_sync(struct irq_work *work)
>>>  		return;
>>>  	}
>>>
>>> -	while (irq_work_is_busy(work))
>>> -		cpu_relax();
>>> +	rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work), TASK_UNINTERRUPTIBLE);
>>
>> Dan Carpenter brought to my attention this a few weeks ago for another problem.:
>>
>> perf_remove_from_context() <- disables preempt
>> __perf_event_exit_context() <- disables preempt
>> -> __perf_remove_from_context()
>>    -> perf_group_detach()
>>       -> perf_put_aux_event()
>>          -> put_event()
>>             -> _free_event()
>>                -> irq_work_sync()
>
> irq_work_sync() is also annotated with might_sleep() (probably how Dan
> saw it) so in principle the rcuwait_wait_event() isn't wrong there.

The might_sleep() annotation does seem to indicate a preempt context. My main 
goal with this patch is to increase performance and responsiveness, and I believe
that rcu_wait_event() will do that. Let me know of any further improvements or 
drawbacks to this approach, though.

	Steven 

> --
> ankur

