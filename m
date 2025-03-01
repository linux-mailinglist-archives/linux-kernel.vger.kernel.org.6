Return-Path: <linux-kernel+bounces-539867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C078A4AA11
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1ACF1897DB7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8821D5AB8;
	Sat,  1 Mar 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ela6pAFQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A94C1C07F6;
	Sat,  1 Mar 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740822659; cv=none; b=NY1Jzx7LtAKV76OL9Kfc7rqtCZvnw7QIpAE9Ailw9Rj5dzQtSiyn98OXDvTeX75ue0tWieCZR+p1CYMajCPXzL2NIX3aXlBRn/Gy1MY6ymSkg8i9x6Z/s8zmtgvro6FIZXzi400xwiPxw780MJpzZLdgCt2ihl142kHMX1AbUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740822659; c=relaxed/simple;
	bh=Zsl5GqVcGbIl0ha1csyXywJKnB7g2NSWOH7bGSi4Mo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YwTjTlFlrMTZiJ/1PdWxVCrCZorJn0g0whM0ZSqCJE4L/KJdZNe2QgwBg4Ix+UE6Urwo6LmaaZXpP4b9deG/IU7o3J1jVurT+U93y3CoMvdfv1slp9CKLYtLSkc1xde3bVPj3SYSWYY5iYytPHMhBUcYZ6GTca6MNJnlJRhXBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ela6pAFQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5216NHOL007137;
	Sat, 1 Mar 2025 09:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l1vVa2H6DzcKH4oNJOABxP+f+11SMWGl7AuIYBQ0pW4=; b=Ela6pAFQ4IEDfTwx
	ca6W4i7QzRDUgafuu49WM6emrPMVgsPdTCRUniPZ5sTay3ZD1Z8j3ZXfld0Ye8CO
	zBH2ceGmxeeGb+MF/RfEfL4wnSPKJz6cYh3lWWyKvLkrqVskz9+CcNmcLS9OD7Cy
	OIT2YbUa7WdF8WJP1O7XiaTXDVtUjDf5pzo6JYo+oO6cRk85gR2frjkAQulz9qOn
	wQxORKHJApndVraLD//zoq2LI+xHIfu1H8YcDFkkFYlWTvMR9wflUZf2LZEaTk4A
	0TAob+5NHNkdXPNqKLTUFV7B/sRZU0gbbfLWYMn1g+NyOLR0NPqvmIz840pNX4Lj
	s+2zhg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t89rj9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Mar 2025 09:50:48 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5219ols2016643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Mar 2025 09:50:47 GMT
Received: from [10.253.39.67] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Mar 2025
 01:50:45 -0800
Message-ID: <c57573e5-8208-495f-ba53-4d9962c0e9b6@quicinc.com>
Date: Sat, 1 Mar 2025 17:50:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [sound?] BUG: sleeping function called from invalid
 context in snd_card_locked
To: Takashi Iwai <tiwai@suse.de>
CC: <syzbot+4cb9fad083898f54c517@syzkaller.appspotmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <perex@perex.cz>, <syzkaller-bugs@googlegroups.com>, <tiwai@suse.com>
References: <6610cdb8-072e-47fe-b9bc-f4f5b9a79f8e@quicinc.com>
 <87y0xp9jr8.wl-tiwai@suse.de>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <87y0xp9jr8.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4mEgf8hX0BzhagwyZF-WZ1xHBREnYjJ5
X-Proofpoint-GUID: 4mEgf8hX0BzhagwyZF-WZ1xHBREnYjJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_03,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010077

On 3/1/2025 5:34 PM, Takashi Iwai wrote:
> On Sat, 01 Mar 2025 10:25:55 +0100,
> Zhongqiu Han wrote:
>>
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14e3d7a4580000
>>> kernel config:
>> https://syzkaller.appspot.com/x/.config?x=8f2f8fb6ad08b539
>>> dashboard link:
>> https://syzkaller.appspot.com/bug?extid=4cb9fad083898f54c517
>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
>> for Debian) 2.40
>>
>>
>> BUG: sleeping function called from invalid context and
>> raw_local_irq_restore() called with IRQs enabled seems can be
>> fixed by below change. if it is valid, will arise the PATCH.
> 
> snd_timer_process_callbacks() gets called from two places, one from
> snd_timer_work() and another from snd_timer_interrupt() where both
> caller cover already with guard(spinlock_irqsave).  That is, it's a
> nested lock, hence without _irqsave().
> 
> IMO, the question is rather why the check of "!in_interrupt()" in
> snd_seq_client_use_ptr() passed in this call path.
> 
> 
> thanks,
> 
> Takashi
> 

Thanks Takashi for the discussion.

I have an initial check:
func snd_seq_check_queue is called from func snd_seq_timer_interrupt,
and the scoped_guard can not cover it. maybe this the reason of
!in_interrupt() check pass.

just like my patch shared, snd_timer_process_callbacks called 
spin_unlock but not spin_unlock_irqrestore, which caused
irqs_disabled(): 1 , and then caused the BUG.


BUG: sleeping function called from invalid context at 
kernel/locking/mutex.c:562
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1167, name: 
kworker/0:1H


please feel free and kindly correct me if any misunderstanding.

>>
>> #syz test:
>>
>> diff --git a/sound/core/timer.c b/sound/core/timer.c
>> index fbada79380f9..5290c1b9f2b8 100644
>> --- a/sound/core/timer.c
>> +++ b/sound/core/timer.c
>> @@ -767,6 +767,7 @@ static void snd_timer_process_callbacks(struct
>> snd_timer *timer,
>>   {
>>          struct snd_timer_instance *ti;
>>          unsigned long resolution, ticks;
>> +       unsigned long flags;
>>
>>          while (!list_empty(head)) {
>>                  ti = list_first_entry(head, struct snd_timer_instance,
>> @@ -780,10 +781,10 @@ static void snd_timer_process_callbacks(struct
>> snd_timer *timer,
>>                          ti->pticks = 0;
>>                          resolution = ti->resolution;
>>                          ti->flags |= SNDRV_TIMER_IFLG_CALLBACK;
>> -                       spin_unlock(&timer->lock);
>> +                       spin_unlock_irqrestore(&timer->lock, flags);
>>                          if (ti->callback)
>>                                  ti->callback(ti, resolution, ticks);
>> -                       spin_lock(&timer->lock);
>> +                       spin_lock_irqsave(&timer->lock, flags);
>>                          ti->flags &= ~SNDRV_TIMER_IFLG_CALLBACK;
>>                  }
>>          }
>> @@ -805,14 +806,16 @@ static void snd_timer_clear_callbacks(struct
>> snd_timer *timer,
>>   static void snd_timer_work(struct work_struct *work)
>>   {
>>          struct snd_timer *timer = container_of(work, struct snd_timer,
>> task_work);
>> +       unsigned long flags;
>>
>>          if (timer->card && timer->card->shutdown) {
>>                  snd_timer_clear_callbacks(timer, &timer->sack_list_head);
>>                  return;
>>          }
>>
>> -       guard(spinlock_irqsave)(&timer->lock);
>> +       spin_lock_irqsave(&timer->lock, flags);
>>          snd_timer_process_callbacks(timer, &timer->sack_list_head);
>> +       spin_unlock_irqrestore(&timer->lock, flags);
>>   }
>>
>>   /*
>>
>>
>>
>>
>>
>> Thanks
>> Zhongqiu Han


-- 
Thx and BRs,
Zhongqiu Han

