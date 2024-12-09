Return-Path: <linux-kernel+bounces-437522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA2A9E9461
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B86166ECF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C815C223703;
	Mon,  9 Dec 2024 12:34:50 +0000 (UTC)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6E622A1C7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747690; cv=none; b=KxkSjKtsAr9dDTqpLnGHffuL8xKTyrErzqUJ2NEMq1FbSoYROQAyJh72gQULItlCewRUdAcLRIHJZxPP618xaFx28p85y0cWpfc95qBD2Hq8jtYOpTtAHclwlElzhevrdNeS+w8bRUb953iEpr5cKt5lxX+Vr81pxFK1iS+pPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747690; c=relaxed/simple;
	bh=A7EBPqGJfzArsJljFZoiBtyTWPxlogmb3Pukp8Ki9xg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lwo5FJd2RMmCr+UWqtMjLRPbPq0RLfaPdcVyD9bzls6K//YCUtc7UzNI5X1qVdQXZXJqV7ovyA9VmcL7TYaRQ4mwIf6TuSB8YSQd34idPWBKptvY0A8tjqg297U1+y51Inyh8luwfKB7NJMh6Rpxa79S0NcwqMFQF3DZvJuNkxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso2241918f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747686; x=1734352486;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6zADNAvVtqcpE/OaU5x0O/t6KRo4MPVSsTtv7Xa4P8=;
        b=bcG/11ZA91s83JH/72KshtilWPjawE1iD8FGZRvCKOE7gIZOSvxd7behlLFq3vKUtm
         WqUNThCzK92y3kyxVfsny2EQ32Yg9Y752an6l6RBcATDF/kfoOdURRlpj8eYoKwz7zmK
         35H73GrkISVEewOxkswvey/sYQ9KsD/tmBb+FtexX8dHHO636Zj09RtAOm73EHOFkxIz
         VdHcXKnNulNaq2VYbl7pCAy0EbidmrU/vzG08PbWa5qVDbdwnGvhc5sTxRXKl/aV63y4
         pcpu7izeqP0vosT7ghN28wPJSbBHbGTJd4lCRxEKG3dK3GCvG5EGzQPezXB/9x8LWf3t
         QCxw==
X-Forwarded-Encrypted: i=1; AJvYcCXOjXuiA3SvSvsgh+ExSf08HhGNm6gi6ZdoPBGZyTRXyIGPoFNDG5IerDQju43tNcuAdgQzn/rECZKPy4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzYSyEhLYkI6ZhsUhBzGHam2slDBrd9q102qa75wlKhK9ZfHA
	f9TROUrFPMPaaYo0/0aD3cBErY017FO2Rjobme3h2YKGWd1ahamp
X-Gm-Gg: ASbGncvY3veHtPCjbpUF9MF934gs/zmoxBPQYot7Eku3YFTRNlHo3fHSKdBaQyzwc+l
	2wtNBh37KUR7Qponq7ZaS3KqC5VnsI9WsAAMq5s1aBOo4clfjtcaiHOAAChft4xV7+4RYs8d/I5
	vPmrDakZpDBYYelJnKc1Gl3FdiboM/BQJHZc3riX9b6LWRnrqDa+icWkXV/tYVs1b+Fe6qmdT1B
	hg2gcLBBJfdkUyNev7GIsuQZtBx9ikCh594uX9Dowwvru6hfMG/V2mNIoJMonYH/sxgyCkLQDdQ
	HaQ0VQ==
X-Google-Smtp-Source: AGHT+IHyo1w9VdfZ3UDd7JkwIwh6xUlDRol0MqCIlFxX2pJPoAIdDEAN3eAwaS1jNXsd7jQPQnV8eQ==
X-Received: by 2002:a05:6000:2809:b0:385:fb40:e549 with SMTP id ffacd0b85a97d-386453fd7femr124719f8f.55.1733747686381;
        Mon, 09 Dec 2024 04:34:46 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cc26sm12820028f8f.38.2024.12.09.04.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 04:34:45 -0800 (PST)
Message-ID: <991b3afe-9570-40ff-b34a-cb0d0bf1adfa@ovn.org>
Date: Mon, 9 Dec 2024 13:34:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Joel Fernandes <joel@joelfernandes.org>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com,
 shraash@google.com
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org>
 <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
 <20241209105514.GK21636@noisy.programming.kicks-ass.net>
 <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/9/24 13:29, Vineeth Remanan Pillai wrote:
> On Mon, Dec 9, 2024 at 5:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Fri, Dec 06, 2024 at 11:57:30AM -0500, Vineeth Remanan Pillai wrote:
>>
>>> I was able to reproduce this WARN_ON couple of days back with
>>> syzkaller. dlserver's dl_se gets enqueued during a update_curr while
>>> the dlserver is stopped. And subsequent dlserver start will cause a
>>> double enqueue.
>>
>> Right, I spotted that hole late last week. There is this thread:
>>
>>   https://lore.kernel.org/all/20241209094941.GF21636@noisy.programming.kicks-ass.net/T/#u
>>
>> Where I just added this thunk:
>>
>>   @@ -1674,6 +1679,12 @@ void dl_server_start(struct sched_dl_entity *dl_se)
>>
>>  void dl_server_stop(struct sched_dl_entity *dl_se)
>>  {
>> +       if (current->dl_server == dl_se) {
>> +               struct rq *rq = rq_of_dl_se(dl_se);
>> +               trace_printk("stop fair server %d\n", cpu_of(rq));
>> +               current->dl_server = NULL;
>> +       }
>> +
>>         if (!dl_se->dl_runtime)
>>                 return;
>>
>> Which was my attempt at plugging said hole. But since I do not have
>> means of reproduction, I'm not at all sure it is sufficient :/
>>
> I think I was able to get to the root cause last week. So the issue
> seems to be that dlserver is stopped in the pick_task path of dlserver
> itself when the sched_delayed is set:
> __pick_next_task
> => pick_task_dl -> server_pick_task
>      => pick_task_fair
>           => pick_next_entity (if (sched_delayed))
>                => dequeue_entities
>                      => dl_server_stop
> 
> Now server_pick_task returns NULL and then we set dl_yielded and call
> update_curr_dl_se. But dl_se is already dequeued and now the code is
> confused and it does all sorts of things including setting a timer to
> enqueue it back. This ultimately leads to double enqueue when dlserver
> is started next time(based on timing of dl_server_start)
> 
> I think we should not call update_curr_dl_se when the dlserver is
> dequeued. Based on this I have a small patch and it seems to solve the
> issue:
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d9d5a702f1a6..a9f3f020e421 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2419,12 +2419,18 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
> 
>         if (dl_server(dl_se)) {
>                 p = dl_se->server_pick_task(dl_se);
> -               if (!p) {
> +               if (p) {
> +                       rq->dl_server = dl_se;
> +               } else if (WARN_ON_ONCE(on_dl_rq(dl_se))) {
> +                       /*
> +                        * If server_pick_task returns NULL and dlserver is
> +                        * enqueued, we have a problem. Lets yield and do a
> +                        * pick again.
> +                        */
>                         dl_se->dl_yielded = 1;
>                         update_curr_dl_se(rq, dl_se, 0);
>                         goto again;
>                 }
> -               rq->dl_server = dl_se;
>         } else {
>                 p = dl_task_of(dl_se);
>         }
> 
> I can send a formal patch if this looks okay to you all..

Thanks!

I can try this out on my setup today over the night (it takes a long time
to reproduce the issue on my setup).

Best regards, Ilya Maximets.

