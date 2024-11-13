Return-Path: <linux-kernel+bounces-407795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259D69C746F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB141F27633
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEB3139578;
	Wed, 13 Nov 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSOatUJq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895E7E575
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508509; cv=none; b=qWWBALy0T130fdvXyEHxHvvoaZmNUAOOzHhNhlLp1x2pDnrIclgVjsMgIJC+WAo0vNuZA7rZSQETaAIeD22gatPjMsv+OJNEtd8OeLSzfHZpGcafexj5OLKdy6Vrqz9akezG9pJaPzctNzCVIOU5Lpq5xnQhWjcxkDgFS2+D4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508509; c=relaxed/simple;
	bh=P3R//SZSv/xe4zqtc04jhKKWltm47Ihq50vY4SHsF7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DwEDR1wJ22rF/qF0rrPW2Hf/Y7WMCmn8q8NWu9VG3Z13xmn6H0fZVu9ZFd2Y4C+kPhORwm3Bsh3wqNuJXIIm/rodIorfoppTBODSBZiU+ydrDxj5nWIF8v45aAA5cXHSRb2rkShGukpeN+1t4fi4lF4nsIH0PwPSi1uvSNlIr7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSOatUJq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731508506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oJplbswoh43LIADKAUU4vKselo8ZeJLTrzA4NQkOHP4=;
	b=PSOatUJqPRx95UhElmPnfzL62cMHzCXWOKseHTI1An9L1JvUEgGD64LaLlxxck49ezw5m+
	UPt/4n55wzc8bO425vz1uCmzJMtFvbj910/zsECLpcLGGDmAYa+fswb6maVZha/XKaN8Ek
	Tv3YokQyjxfUYmkRSjQpPCgeEWFhsAc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-nPzpgfQaOsuNqONOCbUlGQ-1; Wed, 13 Nov 2024 09:35:05 -0500
X-MC-Unique: nPzpgfQaOsuNqONOCbUlGQ-1
X-Mimecast-MFC-AGG-ID: nPzpgfQaOsuNqONOCbUlGQ
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d366683f4aso106122356d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731508504; x=1732113304;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJplbswoh43LIADKAUU4vKselo8ZeJLTrzA4NQkOHP4=;
        b=MAfssv0NYLBiXJr5UJYBjWBbp/Z/mPPacH/9nKKAZrwcWjCvulEDj4dQH+/0qc+sMY
         /TyVpYsCVDcE5zdEsAAmHJ2kJGJ8luqfbutICMrXFU7s0oJEKXGMtWoxB/sX1f/++nVr
         driBTBLXfr4BwxZpj6ldGhbhgxQ2wcB83yfR3X1ITg5Ao/G5JUXtzOIU6ZDrTEm+RaZh
         yWYWs/AMa4UV+ywvA4F+Ev8D7u02jrXbvwR34X9S8JbfbRJT2DIUlY3UjHeGj5McgOR7
         U9GIlzEmKvZq2cKrvWF6k9RCk0tnbMaFtFW7sD8JBpjSu2ffP2eYA2J+leme7MoALDCq
         +uRA==
X-Gm-Message-State: AOJu0YxG3F3Avz754Nut2A5hYRJ8bblw/b8kJyDU9wWVnFMo931mJeM/
	Mo7Evz9opOwjWHNcXcBxYR19HUXZkT9tzbYdzBuZpY2Ez1k5MjkwL71fOj0MdvcW0CGq2wqKM8j
	pY9uxa1dysQwwZGXdaUsOcUkBQ700nI0b0GdqzDfXc/Hw7cqtEZ3b822U06yvlA==
X-Received: by 2002:a05:6214:498a:b0:6cb:d4ed:aa59 with SMTP id 6a1803df08f44-6d39e101b91mr293657836d6.4.1731508504554;
        Wed, 13 Nov 2024 06:35:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUodK0G9mWVIX4VZxws8VvrQsdSTqynWKuuLqrKLCN2w5XFTfrCWh2vp4Bx5IgJYr0L35nog==
X-Received: by 2002:a05:6214:498a:b0:6cb:d4ed:aa59 with SMTP id 6a1803df08f44-6d39e101b91mr293657576d6.4.1731508504206;
        Wed, 13 Nov 2024 06:35:04 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3966303e6sm85049856d6.99.2024.11.13.06.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:35:03 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de
Cc: linux-kernel@vger.kernel.org, chenridong@huawei.com,
 wangweiyang2@huawei.com
Subject: Re: [PATCH] freezer, sched: report the frozen task stat as 'D'
In-Reply-To: <20241111135431.1813729-1-chenridong@huaweicloud.com>
References: <20241111135431.1813729-1-chenridong@huaweicloud.com>
Date: Wed, 13 Nov 2024 15:34:59 +0100
Message-ID: <xhsmhv7wrb3sc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 11/11/24 13:54, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Before the commit f5d39b020809 ("freezer,sched: Rewrite core freezer
> logic"), the frozen task stat was reported as 'D' in cgroup v1.
> However, after rewriting core freezer logic, the frozen task stat is
> reported as 'R'. This is confusing, especially when a task with stat of
> 'S' is frozen.
>
> This can be reproduced as bellow step:
> cd /sys/fs/cgroup/freezer/
> mkdir test
> sleep 1000 &
> [1] 739         // task whose stat is 'S'
> echo 739 > test/cgroup.procs
> echo FROZEN > test/freezer.state
> ps -aux | grep 739
> root     739  0.1  0.0   8376  1812 pts/0    R    10:56   0:00 sleep 1000
>
> As shown above, a task whose stat is 'S' was changed to 'R' when it was
> frozen. To solve this issue, simply maintain the same reported state as
> before the rewrite.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  include/linux/sched.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f0f23efdb245..878acce2f8d6 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1630,8 +1630,9 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
>  	 * We're lying here, but rather than expose a completely new task state
>  	 * to userspace, we can make this appear as if the task has gone through
>  	 * a regular rt_mutex_lock() call.
> +	 * Report the frozen task uninterruptible.
>  	 */
> -	if (tsk_state & TASK_RTLOCK_WAIT)
> +	if (tsk_state & TASK_RTLOCK_WAIT || tsk_state & TASK_FROZEN)

Hmph, for RTLOCK this was good enough since !PREEMPT_RT really would be
TASK_UNINTERRUPTIBLE. 

For the freezer AFAICT there's more variation, following your example:

  crash> task -R __state,saved_state 195
  PID: 195      TASK: ffff888004abab80  CPU: 1    COMMAND: "sh"
    __state = 32768    -> 0x8000 aka TASK_FROZEN
    saved_state = 8193 -> 0x2001 aka TASK_INTERRUPTIBLE | TASK_FREEZABLE

so we ought to read ->saved_state, but as pointed out in [1] this is
racy...

[1]: https://lore.kernel.org/lkml/20220120162520.570782-3-valentin.schneider@arm.com/

>  		state = TASK_UNINTERRUPTIBLE;
>  
>  	return fls(state);
> -- 
> 2.34.1


