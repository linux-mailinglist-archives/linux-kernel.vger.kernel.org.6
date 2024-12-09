Return-Path: <linux-kernel+bounces-437866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50B19E99D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2464C1888D60
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE881BEF8E;
	Mon,  9 Dec 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="01D2GAKw"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA571B0420
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756377; cv=none; b=BdV3VJtXNxDcIxSvRNTyXkpHRfcHaKEvYcdBVMF2UJDZol4+2JPkPIxNVoqq7YqfClYq5Xs0HCVRZFiVVJqyWbxFASbzF5Tsmc+NjB/fZ+h6dz+aFBIGa5ge7TArtXW97HCk8D1O7EoGNRe/h/jBRN/r5p0nmUtesGxaTJEghfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756377; c=relaxed/simple;
	bh=rYOFWrfVUQTN8/4FwS3/505lkR5EUzR4fqzcqOg80j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l2pcxHMR+kh//GrE9BLHofTTaP2kisN+mjeRmKhw5vQ1ouQA+Ij03Wqxoqgu34EelT60phP3lq6B3ofxN87TeIcnBSqYu9EBS/waiht8wm8mPSFnVySQNgQMNckSNtdC1TJsfoTNmmwkKc9H+beXQIFMElPAfAUk2m6PbfEI49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=01D2GAKw; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71ddc7325beso95122a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733756372; x=1734361172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p9VsEyze9R+3sj6eCL+mDcpy5BazmAvcI6ia+EAKp88=;
        b=01D2GAKweyO+PFb2cXzK8UpFRTP+fJdlbnixXM9zXZmUMJ4V/fmFu9h2OQDp4iGnoh
         c4QyC1o5XlVZsfdOuc2826bABe8fcXBmPvHma0qk1u7Cpvsp8Hl+/hVrGJJZzTM26CYS
         NofAz//GwDPnWKACmVv0JyjXSLw73NiCQtGoP5FwQLZpV7dlVDnGPGXYzHUxO6IscdSe
         h/mz9cKSvuznHTheDcXuwslfRJ5KnXLtB7cKOHzlfkyLa2bmXdl3QkzPq2oLbpf/qS1k
         csnFZK8G2Ih3HQM+QoYx41tGAfEBwyTpZE7PyEkn3B3uEFPizQ4MWMZZzG7tHWkLf2B1
         BwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756372; x=1734361172;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9VsEyze9R+3sj6eCL+mDcpy5BazmAvcI6ia+EAKp88=;
        b=IlGC5KSYkLPV6HK43eCtnqAZ5j78fXzpKC617lKvjbPh0mOVdMdXY/N2CFLfIk5vvr
         wDRVZKzktKst4MMddt70y0Ey5TEKQxerHbJvectOYFoj4nuUTUkXeMmv1PYa4ykLSJdn
         IZhnE4Egw3kRBnKPjnJAzJsxvUpWwI5h95YnBo+BgBI4kLZV88YOt6lX+wwpmXrZh1m1
         QosbMzgy7L3wcOrflJUFVIUqIjv957OhRqB+rCJRAtbKOxIpPnlXFvaKcNVY8AMzF5A7
         d+EC8OXdi3JffYEsyL2oNprDYjEuwykt72TK6vJ+wPg0XKNMHuZoCFmLteq5+CSqxZ2t
         lFiw==
X-Forwarded-Encrypted: i=1; AJvYcCVJnR7lTA/27AndmqvPrwBveVAyBnS4eAvtSa2bncHsofSCIcfrflQ1uTEdziavOolaffqISbZpoSl4hnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEjqABs9Tye+JaNSbSlOCPnqYOV7VMSUmTCzMI0tGcJcJZCJ9/
	ert98ORvMei+ftotPXUuCgVeyKj0DpIXVfH6ZNW94W60EmyNvQQHxg2h1SmFWHg=
X-Gm-Gg: ASbGncuBX6pfJgXEvJkoP44KWtDL+3F0Lx+05gEZLcHYGOP3hxlF4+rTtvfLDHTxXEW
	8mRpe53AIGnQscIWn7Qvv7BiydDJOTvR1O1Y1mVeoLnGSupWskt6aDRSUOt0HVGzFRoBK02S8eV
	xjQIJPtsbX9rYf1o7TduwAEqZsk14fA1xf8IN+YicESgS3CiDJpN0jPh8NyeTr6S666Gp0YA0Gv
	zHr8MK+UiQNLzpIxqLQM8/bxfmiH8hFnUzfQKZEx2+h1A==
X-Google-Smtp-Source: AGHT+IFePRQsi6wZhtlXqLC99WNSl9mHjo4bWNZNboomAG5uegyJwmrtlNIk2qdRi6mVVRqjTlCgkA==
X-Received: by 2002:a05:6830:378c:b0:71a:6845:7d7a with SMTP id 46e09a7af769-71e0219363amr567328a34.5.1733756372133;
        Mon, 09 Dec 2024 06:59:32 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f2792464a6sm2027479eaf.21.2024.12.09.06.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:59:31 -0800 (PST)
Message-ID: <1a779207-4fa8-4b8e-95d7-e0568791e6ac@kernel.dk>
Date: Mon, 9 Dec 2024 07:59:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible deadlock in __wake_up_common_lock
To: chase xd <sl1589472800@gmail.com>, Pavel Begunkov
 <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CADZouDRFJ9jtXHqkX-PTKeT=GxSwdMC42zEsAKR34psuG9tUMQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <CADZouDRFJ9jtXHqkX-PTKeT=GxSwdMC42zEsAKR34psuG9tUMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 5:03 AM, chase xd wrote:
> ============================================
> WARNING: possible recursive locking detected
> 6.1.119-dirty #3 Not tainted
> --------------------------------------------
> syz-executor199/6820 is trying to acquire lock:
> ffff88807c386378 (&ctx->cq_wait){....}-{2:2}, at:
> __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137
> 
> but task is already holding lock:
> ffff88807c386378 (&ctx->cq_wait){....}-{2:2}, at:
> __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&ctx->cq_wait);
>   lock(&ctx->cq_wait);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 2 locks held by syz-executor199/6820:
>  #0: ffff88807c3860a8 (&ctx->uring_lock){+.+.}-{3:3}, at:
> __do_sys_io_uring_enter+0x8fc/0x2130 io_uring/io_uring.c:3313
>  #1: ffff88807c386378 (&ctx->cq_wait){....}-{2:2}, at:
> __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137
> 
> stack backtrace:
> CPU: 7 PID: 6820 Comm: syz-executor199 Not tainted 6.1.119-dirty #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x5b/0x85 lib/dump_stack.c:106
>  print_deadlock_bug kernel/locking/lockdep.c:2983 [inline]
>  check_deadlock kernel/locking/lockdep.c:3026 [inline]
>  validate_chain kernel/locking/lockdep.c:3812 [inline]
>  __lock_acquire.cold+0x219/0x3bd kernel/locking/lockdep.c:5049
>  lock_acquire kernel/locking/lockdep.c:5662 [inline]
>  lock_acquire+0x1e3/0x5e0 kernel/locking/lockdep.c:5627
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
>  __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137
>  __io_cqring_wake io_uring/io_uring.h:224 [inline]
>  __io_cqring_wake io_uring/io_uring.h:211 [inline]
>  io_req_local_work_add io_uring/io_uring.c:1135 [inline]
>  __io_req_task_work_add+0x4a4/0xd60 io_uring/io_uring.c:1146
>  io_poll_wake+0x3cb/0x550 io_uring/poll.c:465
>  __wake_up_common+0x14c/0x650 kernel/sched/wait.c:107
>  __wake_up_common_lock+0xd4/0x140 kernel/sched/wait.c:138
>  __io_cqring_wake io_uring/io_uring.h:224 [inline]
>  __io_cqring_wake io_uring/io_uring.h:211 [inline]
>  io_cqring_wake io_uring/io_uring.h:231 [inline]
>  io_cqring_ev_posted io_uring/io_uring.c:578 [inline]
>  __io_cq_unlock_post io_uring/io_uring.c:586 [inline]
>  __io_submit_flush_completions+0x778/0xba0 io_uring/io_uring.c:1346
>  io_submit_flush_completions io_uring/io_uring.c:159 [inline]
>  io_submit_state_end io_uring/io_uring.c:2203 [inline]
>  io_submit_sqes+0xa78/0x1ce0 io_uring/io_uring.c:2317
>  __do_sys_io_uring_enter+0x907/0x2130 io_uring/io_uring.c:3314
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> RIP: 0033:0x7fa54e70640d
> Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd0ad80be8 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
> RAX: ffffffffffffffda RBX: 00007ffd0ad80df8 RCX: 00007fa54e70640d
> RDX: 0000000000000000 RSI: 000000000000331b RDI: 0000000000000003
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffd0ad80de8 R14: 00007fa54e783530 R15: 0000000000000001
>  </TASK>

I think this backport of:

3181e22fb799 ("io_uring: wake up optimisations")

should fix that. Can you try?


diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 4f0ae938b146..0b1361663267 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -582,6 +582,16 @@ static inline void __io_cq_unlock_post(struct io_ring_ctx *ctx)
 	io_cqring_ev_posted(ctx);
 }
 
+static inline void __io_cq_unlock_post_flush(struct io_ring_ctx *ctx)
+	__releases(ctx->completion_lock)
+{
+	io_commit_cqring(ctx);
+	spin_unlock(&ctx->completion_lock);
+	io_commit_cqring_flush(ctx);
+	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
+		__io_cqring_wake(ctx);
+}
+
 void io_cq_unlock_post(struct io_ring_ctx *ctx)
 {
 	__io_cq_unlock_post(ctx);
@@ -1339,7 +1349,7 @@ static void __io_submit_flush_completions(struct io_ring_ctx *ctx)
 		if (!(req->flags & REQ_F_CQE_SKIP))
 			__io_fill_cqe_req(ctx, req);
 	}
-	__io_cq_unlock_post(ctx);
+	__io_cq_unlock_post_flush(ctx);
 
 	io_free_batch_list(ctx, state->compl_reqs.first);
 	INIT_WQ_LIST(&state->compl_reqs);

-- 
Jens Axboe

