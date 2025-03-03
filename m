Return-Path: <linux-kernel+bounces-544619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23867A4E327
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9441C17F470
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481F20A5EA;
	Tue,  4 Mar 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGu5L1CD"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B2420A5D6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101296; cv=pass; b=g8ScUkFRvGC+F+1Wl29s1EWKRqxwiWuAfkegJdWjUu78Hm9dZu1GdPbzwAGwwYZbN8NiXGvHxMUR2g7e6cshJwn7uJzpb3GcXFDNAmnEHI9FSg2S5NrjGOGJzkFM4GPX60ojreTQjFYJieGits6yk94HcAS3sXDJ48e0EHqoh40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101296; c=relaxed/simple;
	bh=O/n1cN/pULZnhP8Vt1zz2rQUzfGlW0aWxCPzENDiiIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaoxVpzCPkmc2ri2y4rOklDsKBvD+Cx1jqt1GGDk6cs4mpFgYZrs/BgnlHjnq/pJ2IV3/EdEqbBdfI+xrEYg+xTSo0v11vBzQXBI/zn96qyu/q5h4fxj/XqQy8D6Mawqg6014fdlhMIUNV/d+H103HqedHQWBjxkWqq34FUX43I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGu5L1CD; arc=none smtp.client-ip=209.85.218.51; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 93BE240F1CDA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:14:52 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bGu5L1CD
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fM469Q2zFyq7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:13:04 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 7087442742; Tue,  4 Mar 2025 18:12:45 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGu5L1CD
X-Envelope-From: <linux-kernel+bounces-541439-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGu5L1CD
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 5BC7A42A0A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:56:41 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id BB1B72DCE3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:56:40 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E125D3B62D4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6C1F63F0;
	Mon,  3 Mar 2025 10:53:35 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A21F2B99
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999209; cv=none; b=Qn0bLwO1MOMLVIm+ZAsrcGyIHHD3BH8nBpsl8pObuMu5S8X/6VnnzQsjyIvgGqRfJIHAz9CMP8haLdrDeL7g2fckpMSQJIsCaw3Wy1uYe3NA6Ag7ECY/INskfi8/EvNUSv8FPoA1z5NeRuWOpWmmgQrlu6Biwdfv2jmlJLagPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999209; c=relaxed/simple;
	bh=O/n1cN/pULZnhP8Vt1zz2rQUzfGlW0aWxCPzENDiiIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqDuif5DDFRX2R3IWUhI8EjrpmOoxlL383f7AWjgg5AN7lQwT/xKNlLnRh4WCLMIziw/B2k45l0hqUUqkKcx+9pGZXBfzOTbp86gyFvXff+zkUj1qZtYdSZ8VU2V1pm68oQRsIhZ+z3DsEiT8a3AqMMNzU/Y0hz+QGbucpbRPKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGu5L1CD; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abf3cf3d142so328493666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740999205; x=1741604005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfC4EUHzjOvx/sqQD97WH0wCB9NYOdqvIzRt50L23LI=;
        b=bGu5L1CDpKQEN0eNK801DXPKf5OnRvPqNfnRZ3EBmr6mpxRl+ZE32mxke1f68GvlO5
         sQoFZ1l7+uW4W7IS8ZGeoXBMju9cIEifBVGQEqebHNM6wE8z4suprLYBJVb4BAdQQQyJ
         LUwEaa11C0W3ICPPXC9cmMpHcO/8aAe2dc+dAI07w7+8PG/Ef+x1vRHyDLiy7SAD3PLZ
         u9ax55L8KcUAFPWsOInIeLl6oZSmKkxWHQM61pLunDJiO5sk3+pHxy29ZTOH0vzdLKg0
         g2CEpDyVB3/RLv+o3YIkOksjsVmLtzA/YeQ+z1AZFiLd1Jw3fKwHSEPAFo3R/dJ8houg
         ZTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740999205; x=1741604005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfC4EUHzjOvx/sqQD97WH0wCB9NYOdqvIzRt50L23LI=;
        b=l6TiQvelkO9HvX5LWg+5JXxBocRbQnAKpZ40f39rIzYt2VosHRdETH7NZTO7Uvgzzu
         /0GYDf/yn+oA0J1noE4SVgtWVzjRJ5sVXn66Awd+Kw9GODzGXTWYS+luhXhCqW/MHLM7
         XqSjjaMGDisrxlUR03yFBCrwI3U72/aHTJetZGCoIuArnWZ9dPqXTyOgDBMYz++SGv72
         OvthzZRybATXnyr2GAqxgXiXv+5qJz8BcxJZs+bGlsItI4A4rqxS2OEsG84Rkzt867k+
         dvNpIdPEYJEacLbu2W6HzHpZ//NiJvZO0t1smrfWQoOrcTiIkTOM11lnAedTW7L9XqsN
         sCUg==
X-Forwarded-Encrypted: i=1; AJvYcCVEMFYBj1a5DU6pvMBu9+ctZiLFo6xqfCxyWvZPVe8MaAL6YnLyJkA5yhtdd7NuePcdvUv+Jh48jF8ZnrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYHuBmdKMjt3mU9paoRIncWXDpB4DALMBhepoTtF9tLI81R0c
	hTv3kLUmUJF4od88yAPD+4mTqX0zrvwvoocAHSJN0ZLNo6rY8MoYtF1zWwQmRV370Z0pHLfdwIQ
	iTIebdf56h23fhj6Xom16Fzlqg9F4mxf3
X-Gm-Gg: ASbGnctKJAlBZbKbENTl6hctzukrqkUVw0tB1/NQUdJXpRMnabqYN3HJdK3TpSciXYz
	3V+7YsgNlM292D7MtwMs8/kpAD2YtVy2Sh3fdwQrKcOvgns0Z2Ru1er0+X+c1y9EXHBV/b627G1
	1fQnsphq0dSc5hlXyi/GtpFANm6eDW
X-Google-Smtp-Source: AGHT+IF0CRYuLH+z8KBMJFQOwVjjvDozeVaHE/3Zb/Pc7Uxep3lMRMAGDPxcLvQDWFg6kRK+yvlSoWyBQSFgFFwxD7g=
X-Received: by 2002:a05:6402:234e:b0:5de:a6a8:5ec6 with SMTP id
 4fb4d7f45d1cf-5e4d6ad8686mr38469039a12.10.1740999204974; Mon, 03 Mar 2025
 02:53:24 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301055102.88746-1-ioworker0@gmail.com> <20250303152907.d61151bbdaf0b8a6a8f9978f@kernel.org>
In-Reply-To: <20250303152907.d61151bbdaf0b8a6a8f9978f@kernel.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 3 Mar 2025 18:52:48 +0800
X-Gm-Features: AQ5f1JqSBFbm8-vzNy-VSmgmHzxXYeGD676WZJ47IHD3xAFGOxOdw01VQdfNDUA
Message-ID: <CAK1f24=EH4d2Zboke82YY3DjxfDwJBtoZDPEfDvD6vYiGROMKg@mail.gmail.com>
Subject: Re: [PATCH 1/1] hung_task: show the blocker task if the task is hung
 on semaphore
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, longman@redhat.com, anna.schumaker@oracle.com, 
	boqun.feng@gmail.com, joel.granados@kernel.org, kent.overstreet@linux.dev, 
	leonylgao@tencent.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	senozhatsky@chromium.org, tfiga@chromium.org, 
	Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fM469Q2zFyq7
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741705991.03794@uN16+UQZ25Uo4GwKpoAvNw
X-ITU-MailScanner-SpamCheck: not spam

Hi Masami,

Thanks a lot for taking time to review!

On Mon, Mar 3, 2025 at 2:29=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Sat,  1 Mar 2025 13:51:02 +0800
> Lance Yang <ioworker0@gmail.com> wrote:
>
> > Inspired by mutex blocker tracking[1], this patch makes a trade-off to
> > balance the overhead and utility of the hung task detector.
>
> Thanks for adding new one!
>
> >
> > Unlike mutexes, semaphores lack explicit ownership tracking, making it
> > challenging to identify the root cause of hangs. To address this, we
> > introduce a last_holder field to the semaphore structure, which is
> > updated when a task successfully calls down() and cleared during up().
> >
> > The assumption is that if a task is blocked on a semaphore, the holders
> > must not have released it. While this does not guarantee that the last
> > holder is one of the current blockers, it likely provides a practical h=
int
> > for diagnosing semaphore-related stalls.
>
> Yeah, if we can have something like the owner_list, we can find the
> longest time blocker (owner) but it takes more {memory, performance}
> overheads.

You're right. Let's keep it simple and light for now without more
 {memory, performance} overheads ;p

>
> >
> > With this change, the hung task detector can now show blocker task's in=
fo
> > like below:
> >
> > [Sat Mar  1 02:39:52 2025] INFO: task cat:1437 blocked for more than 12=
2 seconds.
> > [Sat Mar  1 02:39:52 2025]       Tainted: G           OE      6.14.0-rc=
3+ #9
> > [Sat Mar  1 02:39:52 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout=
_secs" disables this message.
> > [Sat Mar  1 02:39:52 2025] task:cat             state:D stack:0     pid=
:1437  tgid:1437  ppid:1007   task_flags:0x400000 flags:0x00000004
> > [Sat Mar  1 02:39:52 2025] Call trace:
> > [Sat Mar  1 02:39:52 2025]  __switch_to+0x1ec/0x380 (T)
> > [Sat Mar  1 02:39:52 2025]  __schedule+0xc30/0x44f8
> > [Sat Mar  1 02:39:52 2025]  schedule+0xb8/0x3b0
> > [Sat Mar  1 02:39:52 2025]  schedule_timeout+0x1d0/0x208
> > [Sat Mar  1 02:39:52 2025]  __down_common+0x27c/0x600
> > [Sat Mar  1 02:39:52 2025]  __down+0x24/0x50
> > [Sat Mar  1 02:39:52 2025]  down+0xe0/0x140
> > [Sat Mar  1 02:39:52 2025]  read_dummy+0x3c/0xa0 [hung_task_sem]
> > [Sat Mar  1 02:39:52 2025]  full_proxy_read+0xfc/0x1d0
> > [Sat Mar  1 02:39:52 2025]  vfs_read+0x1a0/0x858
> > [Sat Mar  1 02:39:52 2025]  ksys_read+0x100/0x220
> > [Sat Mar  1 02:39:52 2025]  __arm64_sys_read+0x78/0xc8
> > [Sat Mar  1 02:39:52 2025]  invoke_syscall+0xd8/0x278
> > [Sat Mar  1 02:39:52 2025]  el0_svc_common.constprop.0+0xb8/0x298
> > [Sat Mar  1 02:39:52 2025]  do_el0_svc+0x4c/0x88
> > [Sat Mar  1 02:39:52 2025]  el0_svc+0x44/0x108
> > [Sat Mar  1 02:39:52 2025]  el0t_64_sync_handler+0x134/0x160
> > [Sat Mar  1 02:39:52 2025]  el0t_64_sync+0x1b8/0x1c0
> > [Sat Mar  1 02:39:52 2025] INFO: task cat:1437 blocked on a semaphore l=
ikely last held by task cat:1436
> > [Sat Mar  1 02:39:52 2025] task:cat             state:S stack:0     pid=
:1436  tgid:1436  ppid:1007   task_flags:0x400000 flags:0x00000004
> > [Sat Mar  1 02:39:52 2025] Call trace:
> > [Sat Mar  1 02:39:52 2025]  __switch_to+0x1ec/0x380 (T)
> > [Sat Mar  1 02:39:52 2025]  __schedule+0xc30/0x44f8
> > [Sat Mar  1 02:39:52 2025]  schedule+0xb8/0x3b0
> > [Sat Mar  1 02:39:52 2025]  schedule_timeout+0xf4/0x208
> > [Sat Mar  1 02:39:52 2025]  msleep_interruptible+0x70/0x130
> > [Sat Mar  1 02:39:52 2025]  read_dummy+0x48/0xa0 [hung_task_sem]
> > [Sat Mar  1 02:39:52 2025]  full_proxy_read+0xfc/0x1d0
> > [Sat Mar  1 02:39:52 2025]  vfs_read+0x1a0/0x858
> > [Sat Mar  1 02:39:52 2025]  ksys_read+0x100/0x220
> > [Sat Mar  1 02:39:52 2025]  __arm64_sys_read+0x78/0xc8
> > [Sat Mar  1 02:39:52 2025]  invoke_syscall+0xd8/0x278
> > [Sat Mar  1 02:39:52 2025]  el0_svc_common.constprop.0+0xb8/0x298
> > [Sat Mar  1 02:39:52 2025]  do_el0_svc+0x4c/0x88
> > [Sat Mar  1 02:39:52 2025]  el0_svc+0x44/0x108
> > [Sat Mar  1 02:39:52 2025]  el0t_64_sync_handler+0x134/0x160
> > [Sat Mar  1 02:39:52 2025]  el0t_64_sync+0x1b8/0x1c0
> >
> > [1] https://lore.kernel.org/all/174046694331.2194069.154729520502408074=
69.stgit@mhiramat.tok.corp.google.com
> >
> > Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  include/linux/sched.h      |  1 +
> >  include/linux/semaphore.h  | 15 ++++++++++-
> >  kernel/hung_task.c         | 52 ++++++++++++++++++++++++++-----------
> >  kernel/locking/semaphore.c | 53 ++++++++++++++++++++++++++++++++++----
> >  4 files changed, 100 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 0cebdd736d44..5dfdca879ac4 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1219,6 +1219,7 @@ struct task_struct {
> >
> >  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> >       struct mutex                    *blocker_mutex;
> > +     struct semaphore                *blocker_sem;
>
> Can we make this a union because only one blocker is active at a time?
> Waiman has been suggested the update way;
>
> https://lore.kernel.org/all/9f9150b4-1cf5-4380-b431-419f70775a7d@redhat.c=
om/
>
> If we can use MSB or LSB of those pointers, it is the smallest memory
> footprint.

Nice! Thanks for sharing the link and the idea. I will look into it and see
if we can make it work ;)

>
> >  #endif
> >
> >  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> > diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
> > index 04655faadc2d..ca8240a5dbfc 100644
> > --- a/include/linux/semaphore.h
> > +++ b/include/linux/semaphore.h
> > @@ -16,13 +16,25 @@ struct semaphore {
> >       raw_spinlock_t          lock;
> >       unsigned int            count;
> >       struct list_head        wait_list;
> > +
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +     atomic_long_t last_holder;
> > +#endif
>
> Would we need to make this atomic? I think mutex needs to use it directly
> as a pointer, but debug_show_blocker() searches the task, so we can
> use an unsigned long + WRITE_ONCE()/READ_ONCE().

Good spot! Using 'an unsigned long + WRITE_ONCE()/READ_ONCE()' is
the way to go, so let me give it a try ;)

>
> >  };
> >
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +#define __LAST_HOLDER_SEMAPHORE_INITIALIZER                          \
> > +     , .last_holder =3D ATOMIC_LONG_INIT(0)
> > +#else
> > +#define __LAST_HOLDER_SEMAPHORE_INITIALIZER
> > +#endif
> > +
> >  #define __SEMAPHORE_INITIALIZER(name, n)                             \
> >  {                                                                    \
> >       .lock           =3D __RAW_SPIN_LOCK_UNLOCKED((name).lock),       =
 \
> >       .count          =3D n,                                           =
 \
> > -     .wait_list      =3D LIST_HEAD_INIT((name).wait_list),            =
 \
> > +     .wait_list      =3D LIST_HEAD_INIT((name).wait_list)             =
 \
> > +     __LAST_HOLDER_SEMAPHORE_INITIALIZER                             \
> >  }
> >
> >  /*
> > @@ -47,5 +59,6 @@ extern int __must_check down_killable(struct semaphor=
e *sem);
> >  extern int __must_check down_trylock(struct semaphore *sem);
> >  extern int __must_check down_timeout(struct semaphore *sem, long jiffi=
es);
> >  extern void up(struct semaphore *sem);
> > +extern unsigned long sem_last_holder(struct semaphore *sem);
> >
> >  #endif /* __LINUX_SEMAPHORE_H */
> > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > index ccd7217fcec1..332f555a97a9 100644
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -98,30 +98,52 @@ static struct notifier_block panic_block =3D {
> >  static void debug_show_blocker(struct task_struct *task)
> >  {
> >       struct task_struct *g, *t;
> > -     unsigned long owner;
> > -     struct mutex *lock;
> > +     unsigned long owner, holder;
> > +     struct semaphore *sem_lock;
> > +     struct mutex *mutex_lock;
> >
> >       RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
> >
> > -     lock =3D READ_ONCE(task->blocker_mutex);
> > -     if (!lock)
> > -             return;
> > +     mutex_lock =3D READ_ONCE(task->blocker_mutex);
> > +     if (mutex_lock) {
> > +             owner =3D mutex_get_owner(mutex_lock);
> > +             if (unlikely(!owner)) {
> > +                     pr_err("INFO: task %s:%d is blocked on a mutex, b=
ut the owner is not found.\n",
> > +                            task->comm, task->pid);
> > +                     goto blocker_sem;
> > +             }
> >
> > -     owner =3D mutex_get_owner(lock);
> > -     if (unlikely(!owner)) {
> > -             pr_err("INFO: task %s:%d is blocked on a mutex, but the o=
wner is not found.\n",
> > -                     task->comm, task->pid);
> > +             /* Ensure the owner information is correct. */
> > +             for_each_process_thread(g, t) {
> > +                     if ((unsigned long)t =3D=3D owner) {
> > +                             pr_err("INFO: task %s:%d is blocked on a =
mutex likely owned by task %s:%d.\n",
> > +                                    task->comm, task->pid, t->comm, t-=
>pid);
> > +                             sched_show_task(t);
> > +                             return;
> > +                     }
> > +             }
> >               return;
> >       }
> >
> > -     /* Ensure the owner information is correct. */
> > -     for_each_process_thread(g, t) {
> > -             if ((unsigned long)t =3D=3D owner) {
> > -                     pr_err("INFO: task %s:%d is blocked on a mutex li=
kely owned by task %s:%d.\n",
> > -                             task->comm, task->pid, t->comm, t->pid);
> > -                     sched_show_task(t);
> > +blocker_sem:
> > +     sem_lock =3D READ_ONCE(task->blocker_sem);
> > +     if (sem_lock) {
> > +             holder =3D sem_last_holder(sem_lock);
> > +             if (unlikely(!holder)) {
> > +                     pr_err("INFO: task %s:%d is blocked on a semaphor=
e, but the last holder is not found.\n",
> > +                            task->comm, task->pid);
> >                       return;
> >               }
> > +
> > +             for_each_process_thread(g, t) {
> > +                     if ((unsigned long)t =3D=3D holder) {
> > +                             pr_err("INFO: task %s:%d blocked on a sem=
aphore likely last held by task %s:%d\n",
> > +                                    task->comm, task->pid, t->comm, t-=
>pid);
> > +                             sched_show_task(t);
> > +                             return;
> > +                     }
> > +             }
> > +             return;
> >       }
> >  }
> >  #else
> > diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
> > index 34bfae72f295..5a684c0a3087 100644
> > --- a/kernel/locking/semaphore.c
> > +++ b/kernel/locking/semaphore.c
> > @@ -39,6 +39,7 @@ static noinline int __down_interruptible(struct semap=
hore *sem);
> >  static noinline int __down_killable(struct semaphore *sem);
> >  static noinline int __down_timeout(struct semaphore *sem, long timeout=
);
> >  static noinline void __up(struct semaphore *sem);
> > +static inline void __sem_acquire(struct semaphore *sem);
> >
> >  /**
> >   * down - acquire the semaphore
> > @@ -58,7 +59,7 @@ void __sched down(struct semaphore *sem)
> >       might_sleep();
> >       raw_spin_lock_irqsave(&sem->lock, flags);
> >       if (likely(sem->count > 0))
> > -             sem->count--;
> > +             __sem_acquire(sem);
> >       else
> >               __down(sem);
> >       raw_spin_unlock_irqrestore(&sem->lock, flags);
> > @@ -82,7 +83,7 @@ int __sched down_interruptible(struct semaphore *sem)
> >       might_sleep();
> >       raw_spin_lock_irqsave(&sem->lock, flags);
> >       if (likely(sem->count > 0))
> > -             sem->count--;
> > +             __sem_acquire(sem);
> >       else
> >               result =3D __down_interruptible(sem);
> >       raw_spin_unlock_irqrestore(&sem->lock, flags);
> > @@ -109,7 +110,7 @@ int __sched down_killable(struct semaphore *sem)
> >       might_sleep();
> >       raw_spin_lock_irqsave(&sem->lock, flags);
> >       if (likely(sem->count > 0))
> > -             sem->count--;
> > +             __sem_acquire(sem);
> >       else
> >               result =3D __down_killable(sem);
> >       raw_spin_unlock_irqrestore(&sem->lock, flags);
> > @@ -139,7 +140,7 @@ int __sched down_trylock(struct semaphore *sem)
> >       raw_spin_lock_irqsave(&sem->lock, flags);
> >       count =3D sem->count - 1;
> >       if (likely(count >=3D 0))
> > -             sem->count =3D count;
> > +             __sem_acquire(sem);
> >       raw_spin_unlock_irqrestore(&sem->lock, flags);
> >
> >       return (count < 0);
> > @@ -164,7 +165,7 @@ int __sched down_timeout(struct semaphore *sem, lon=
g timeout)
> >       might_sleep();
> >       raw_spin_lock_irqsave(&sem->lock, flags);
> >       if (likely(sem->count > 0))
> > -             sem->count--;
> > +             __sem_acquire(sem);
> >       else
> >               result =3D __down_timeout(sem, timeout);
> >       raw_spin_unlock_irqrestore(&sem->lock, flags);
> > @@ -242,10 +243,18 @@ static inline int __sched __down_common(struct se=
maphore *sem, long state,
> >  {
> >       int ret;
> >
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +     WRITE_ONCE(current->blocker_sem, sem);
> > +#endif
> > +
> >       trace_contention_begin(sem, 0);
> >       ret =3D ___down_common(sem, state, timeout);
> >       trace_contention_end(sem, ret);
> >
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +     WRITE_ONCE(current->blocker_sem, NULL);
> > +#endif
> > +
> >       return ret;
> >  }
> >
> > @@ -274,6 +283,40 @@ static noinline void __sched __up(struct semaphore=
 *sem)
> >       struct semaphore_waiter *waiter =3D list_first_entry(&sem->wait_l=
ist,
> >                                               struct semaphore_waiter, =
list);
> >       list_del(&waiter->list);
> > +
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +     atomic_long_cmpxchg_release(&sem->last_holder, (unsigned long)cur=
rent,
> > +                                 0UL);
>
> Ah, you don't need atomic here because __up() is called with sem->lock lo=
cked.

Indeed.

> Also, if wait_list is empty, the 'up()' does only sem->count++. In this c=
ase,
> the owner is not cleared.

Good catch! I totally missed that and will fix it in the next version.

Thanks a lot again for your time!
Lance


>
> Thank you,
>
> > +#endif
> > +
> >       waiter->up =3D true;
> >       wake_up_process(waiter->task);
> >  }
> > +
> > +static inline struct task_struct *__holder_task(unsigned long holder)
> > +{
> > +     return (struct task_struct *)holder;
> > +}
> > +
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +/* Do not use the return value as a pointer directly. */
> > +unsigned long sem_last_holder(struct semaphore *sem)
> > +{
> > +     unsigned long holder =3D atomic_long_read(&sem->last_holder);
> > +
> > +     return (unsigned long)__holder_task(holder);
> > +}
> > +#else
> > +unsigned long sem_last_holder(struct semaphore *sem)
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +
> > +static inline void __sem_acquire(struct semaphore *sem)
> > +{
> > +     sem->count--;
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +     atomic_long_set(&sem->last_holder, (unsigned long)current);
> > +#endif
> > +}
> > --
> > 2.45.2
> >
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


