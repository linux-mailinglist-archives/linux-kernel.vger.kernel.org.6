Return-Path: <linux-kernel+bounces-229179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D86916C81
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D35D281526
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670D16F902;
	Tue, 25 Jun 2024 15:07:46 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E96A1684AC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328066; cv=none; b=p59q+4pzCBHUB/Qc6OY1TCKrYpBbtDfcZqRli8021oeA3lRfBviKQwePh7U31FYFAri+6iSfPPLQb2KoncIa9bYQ3POVyiuSZtTTZbLRT3R6mJiu+bXHmlHoe/d4bQBV/NpGQeFANDNtHZxw6PHnRUvugvC0qsrW17W3XTc55XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328066; c=relaxed/simple;
	bh=FJJb1ND/Hw5n8Lg55dkxnTRE+HdfB3T4SIUDinzkTMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5CB4r8d6JHO4D3QAhYmZOQ1knxYQujUTtXNnjLDmyXzjZsGdPhk93nVcE94R8LGS++0H/LPYnezioI8LVYSGYdXN+23iP+9pgS2XDxNqngXiPboc7dPOZhd3a2Z0PjPEdKqO6Xhv/49VUYtyrLrJRzRkq+LYPNOaemq1OELuhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45PF7etM062223;
	Wed, 26 Jun 2024 00:07:40 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Wed, 26 Jun 2024 00:07:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45PF7bBq062214
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Jun 2024 00:07:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
Date: Wed, 26 Jun 2024 00:07:37 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
To: John Ogness <john.ogness@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
 <87ed8lxg1c.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87ed8lxg1c.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/25 23:17, John Ogness wrote:
> On 2024-06-25, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>> syzbot is reporting circular locking dependency inside __bpf_prog_run(),
>> for fault injection calls printk() despite rq lock is already held.
>>
>> Guard __bpf_prog_run() using printk_deferred_{enter,exit}() (and
>> preempt_{disable,enable}() if CONFIG_PREEMPT_RT=n) in order to defer any
>> printk() messages.
> 
> Why is the reason for disabling preemption?

Because since kernel/printk/printk_safe.c uses a percpu counter for deferring
printk(), printk_safe_enter() and printk_safe_exit() have to be called from
the same CPU. preempt_disable() before printk_safe_enter() and preempt_enable()
after printk_safe_exit() guarantees that printk_safe_enter() and
printk_safe_exit() are called from the same CPU.


