Return-Path: <linux-kernel+bounces-379010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8239AD898
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DC42840C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46891A0BD8;
	Wed, 23 Oct 2024 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvGrkxcP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5E1158858
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727214; cv=none; b=S5ugzESofyHwwtT8KfFbgE6Zii1h56dmhb0LfBVUyiVl3Jk8bU/pLkAeQ65TRw5KtbJ3vl0oKIQKRpBdO08JQLP3RUHM19+BAoEJfwlqGczkhM0INkg1uWTddvtdgHY643h+81rADdBWV0hzosUQ10aIbNVLJJNzOiuTClhRYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727214; c=relaxed/simple;
	bh=o7GuNnLDaIYhzUgo+hMiQxLhencSDx09CfFDmsoiRG4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hx/2JeHdD5tF/fvOTwWU3y6EAOxFCFlVrhypxYRtu/XtKX1pBgfzcKxQy1NR3CQMXnLpqJCGzwMHUtN1dC/Tx0WTI8zTcM0ZvPHM/Jt1tZsP8svYszs86MHKEeNAjpiSkD+bT98plelH7cRhDTJ/1Tn+93hmHDdIE1CAtDt1Wak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvGrkxcP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729727211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK3EjcAxSDhoCGuT/4W8TwBg05MubMf2g0zbVbVc3cc=;
	b=MvGrkxcPWQux+7nXsC+ZtkjNu5RDXhJFU8e8ibltI7M4+Mtce82dJ3bWqOtvlHCW5Dncwf
	AQT24ELR4g4U+gFR3FIccSjhIxwqj68GBFdDKncEmt0UXPY/bJCxqzV8B2c29jnwAjJxCb
	+6auacjdj4F3dVO0ZjS5FhMqXmHC854=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-8kKIUoHRMgWlEoRWrWcTtg-1; Wed, 23 Oct 2024 19:46:49 -0400
X-MC-Unique: 8kKIUoHRMgWlEoRWrWcTtg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b15499a04eso82854085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727209; x=1730332009;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NK3EjcAxSDhoCGuT/4W8TwBg05MubMf2g0zbVbVc3cc=;
        b=f7Z3bBzG08XUeXPLTkSoAiofAYtVuzk3h3wBolJaGkfCpAT6wRG0Ujs/S55nJOrTxZ
         aXNC9q0pUlWi6sE7yg0nxE/0oWg3XzBNs+IwrER+GUaupQcZ5SKZxoz/qIOMzPf/4Egf
         8datK9z6v1FWH0Z4oxewr5tmZx50MQdEsyZ+465zvYD6dlOHQnnFRuM0Spl2YN5xb1v1
         Wmemu94xd+zhx6ZwxKIKRyPHe9/WHaWLN4B7bBJuv0P+YnOEzK/1g08zMZWR+a+Eb6pr
         oqYgl4O9y/w7/nGGXOzrN1YE0TiiY6ogPmeB78Kn1b79/7XqBiEhsFzmb+oEXGb8bBqP
         Nhng==
X-Forwarded-Encrypted: i=1; AJvYcCX0WWZ5E2TZp7baqRKTJ3uygmNsDnd/OpovZo5CTDuVLcMcP1UXUcxOdKHN0bi6Uzeiiog239AkD7yS/ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1uYQaOfUbAOEPDKYL8KchJMqq4MaQeGn1okTz1WyxNqYVvdHf
	54il/1RhgY//XYk+3FZqwOdqcx5FxexMWZ/0J/IjFlzpWCGWV2i4nKeUIWjcBnDeHcqBstT8Weq
	f7rQDqH9qDjsVLVz4rXKh+t4B0VeTbqyylKY4+6EU1BOVuBySCfbGnEJFC71V9g==
X-Received: by 2002:a05:620a:4454:b0:7ac:e8bf:894a with SMTP id af79cd13be357-7b18664f24cmr36561285a.20.1729727209199;
        Wed, 23 Oct 2024 16:46:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHye5X6Ls0FBjFHwIpEsnZsHKra/Q54FJ3ar+l7pDi0wLFaOjeXHQN0iVtHf2XwbsC/BkMwSQ==
X-Received: by 2002:a05:620a:4454:b0:7ac:e8bf:894a with SMTP id af79cd13be357-7b18664f24cmr36558085a.20.1729727208819;
        Wed, 23 Oct 2024 16:46:48 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1659b980dsm429090385a.2.2024.10.23.16.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 16:46:48 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <93bfdda8-b0c7-469a-9cc7-a8061913cb45@redhat.com>
Date: Wed, 23 Oct 2024 19:46:47 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] WARNING in task_work_add
To: Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: syzbot <syzbot+4abde9163a953b8a0fd0@syzkaller.appspotmail.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, anna-maria@linutronix.de,
 linux-kernel@vger.kernel.org, mingo@kernel.org,
 syzkaller-bugs@googlegroups.com, tglx@linutronix.de
References: <6717300e.050a0220.1e4b4d.006e.GAE@google.com>
 <Zxexd7nd3k8CM51w@localhost.localdomain>
 <20241022190855.GA9657@noisy.programming.kicks-ass.net>
 <d2a0e899-7fb8-40a9-a431-3ab9debf39c0@redhat.com>
Content-Language: en-US
In-Reply-To: <d2a0e899-7fb8-40a9-a431-3ab9debf39c0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/24 2:47 PM, Waiman Long wrote:
>
>
> On 10/22/24 3:08 PM, Peter Zijlstra wrote:
>> On Tue, Oct 22, 2024 at 04:06:47PM +0200, Frederic Weisbecker wrote:
>>> Adding scheduler people in Cc.
>>>
>>> Thanks.
>>>
>>> Le Mon, Oct 21, 2024 at 09:54:38PM -0700, syzbot a écrit :
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    9ec59cb3edc7 KVM: arm64: Shave a few bytes from the EL2 id..
>>>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>>>> console output:https://syzkaller.appspot.com/x/log.txt?x=17061430580000
>>>> kernel config:https://syzkaller.appspot.com/x/.config?x=c154e2d4db830898
>>>> dashboard link:https://syzkaller.appspot.com/bug?extid=4abde9163a953b8a0fd0
>>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>>> userspace arch: arm64
>>>>
>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>
>>>> Downloadable assets:
>>>> disk image:https://storage.googleapis.com/syzbot-assets/fc9a7d36d46a/disk-9ec59cb3.raw.xz
>>>> vmlinux:https://storage.googleapis.com/syzbot-assets/30547ddd681e/vmlinux-9ec59cb3.xz
>>>> kernel image:https://storage.googleapis.com/syzbot-assets/5c4e02d0f97a/Image-9ec59cb3.gz.xz
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by:syzbot+4abde9163a953b8a0fd0@syzkaller.appspotmail.com
>>>>
>>>> ------------[ cut here ]------------
>>>> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_next_frame_record_meta arch/arm64/kernel/stacktrace.c:216 [inline]
>>>> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline]
>>>> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline]
>>>> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline]
>>>> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline]
>>>> WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/stacktrace.c:223 arch_stack_walk+0x458/0x48c arch/arm64/kernel/stacktrace.c:404
>>>> Modules linked in:
>>>> CPU: 1 UID: 0 PID: 1 Comm: init Not tainted 6.12.0-rc3-syzkaller-g9ec59cb3edc7 #0
>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>>>> pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> pc : kunwind_next_frame_record_meta arch/arm64/kernel/stacktrace.c:216 [inline]
>>>> pc : kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline]
>>>> pc : kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline]
>>>> pc : do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline]
>>>> pc : kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline]
>>>> pc : arch_stack_walk+0x458/0x48c arch/arm64/kernel/stacktrace.c:404
>>>> lr : 0x0
>>>> sp : ffff8000800176a0
>>>> x29: ffff800080017750 x28: 1ffff00010002f58 x27: 00000000ffff8d68
>>>> x26: dfff800000000000 x25: ffff0000c2c588c0 x24: dfff800000000000
>>>> x23: ffff700010002ef0 x22: ffff800080017850 x21: ffff8000800176b8
>>>> x20: ffff800080462114 x19: ffff8000800177a0 x18: dfff800000000000
>>>> x17: ffff800123f21000 x16: ffff80008b490b1c x15: 0000000000000001
>>>> x14: 1fffe000366c806a x13: ffff800097807ff0 x12: ffff800097808000
>>>> x11: 0000000000000000 x10: ffff0000c1978000 x9 : ffff800097807e9f
>>>> x8 : ffff800097807fd8 x7 : 0000000000000000 x6 : 000000000000003f
>>>> x5 : 0000000000000040 x4 : fffffffffffffff0 x3 : 0000000000000000
>>>> x2 : ffff0000c1978000 x1 : ffff800080029c40 x0 : 0000000000000001
>>>> Call trace:
>>>>   kunwind_next_frame_record_meta arch/arm64/kernel/stacktrace.c:216 [inline] (P)
>>>>   kunwind_next_frame_record arch/arm64/kernel/stacktrace.c:248 [inline] (P)
>>>>   kunwind_next arch/arm64/kernel/stacktrace.c:278 [inline] (P)
>>>>   do_kunwind arch/arm64/kernel/stacktrace.c:309 [inline] (P)
>>>>   kunwind_stack_walk arch/arm64/kernel/stacktrace.c:380 [inline] (P)
>>>>   arch_stack_walk+0x458/0x48c arch/arm64/kernel/stacktrace.c:404 (P)
>>>>   0x0 (L)
>>>>   stack_trace_save+0xfc/0x1a0 kernel/stacktrace.c:122
>>>>   kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
>>>>   __kasan_record_aux_stack+0xd0/0xec mm/kasan/generic.c:541
>>>>   kasan_record_aux_stack+0x14/0x20 mm/kasan/generic.c:546
>>>>   task_work_add+0xb8/0x464 kernel/task_work.c:66
>>>>   task_tick_mm_cid kernel/sched/core.c:10468 [inline]
>>>>   sched_tick+0x2a8/0x404 kernel/sched/core.c:5605
>> I'm guessing this is very close to what 73ab05aa46b0 ("sched/core:
>> Disable page allocation in task_tick_mm_cid()") does. Initial version of
>> that patch was more aggressive and killed off the whole KASAN thing
>> instead of just the page-alloc.
>
> The stack trace is a bit suspicious. Commit 73ab05aa46b0 modifies 
> task_tick_mm_cid() and task_work_add() to make it call 
> kasan_record_aux_stack_noalloc() not kasan_record_aux_stack() in this 
> particular sequence. So I wonder if this commit is in this particular 
> instance of the git tree at all.
>
This is a 6.12.0-rc3 kernel which doesn't have commit 73ab05aa46b0 yet.

Thanks, Longman


