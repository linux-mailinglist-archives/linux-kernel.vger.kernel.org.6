Return-Path: <linux-kernel+bounces-307370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B4964C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAF228464A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543881B86C6;
	Thu, 29 Aug 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzadcxgS"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387ED1AAE1A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950947; cv=none; b=MXw3otond4rLYeB2bA/lWQ5OJoNGx/A762dTvVIIsyBj53j0nHFn1zD2/eG5lCOr2uZE2awAAb0VTb9LW9pia7OCT+8vwXL+RhFxMjqsL4TVMbpU5ZZcJIGc1e6VI/DRw1sp9Fa6ICDDcqUD+FChbsaDfZUR57g4zliOvGwlKxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950947; c=relaxed/simple;
	bh=gcYF+NoDeDfdXu+gm6nCLu2I8jfzlGanW/cJzKzTLAs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D3pwAeuq1mTanwpddP1XRZKdISiS3kcIFK/5qr/uxEHaayuAQ0rJU4ETXe2P6GSfOgQv/w+fi82Pjv2iC9Uj3AfBzjJNMD8v1813YdZy+FsoVoN/x5ZzQA772az46M32bXi3ZZ9mmxQMrwaxb+EOuVD9yDYFR8auzxRDQqIHQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FzadcxgS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b351a76beeso20067417b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724950945; x=1725555745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu2+jcmHfLGqxfEB8BtcD+CyPwLkbrwiJSDJROL1kOs=;
        b=FzadcxgSkpAty6fko9XWwzXCD8uBJGFJCTviCSyso03FR8HXzCYqXTlYJClJXHsXF3
         CzVtMqu81WAy2apLJ9egaSBvbsRdQFvBvnPzIos99MEFHuhFhYeFy1TtTvB1mjoADtLC
         A2KtS0UjgXQvCvx5gQbRDgE6lQAT6GQhYqgY2HzAeEuNWFxb0ndhvIKQ0o5LPfTRoCBo
         poaVUaIqE5IsRMAjN91dhtlS0cf5nizJbnlWWiv2iGl3K07hhCFjpkACwwITV74bcYyX
         eJGuRa5BIElfSmsJuwzY04pFNDHJ492teUv3tQEvfMgAhTKu6OvbMKvrb71a88YYLwrC
         Nnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724950945; x=1725555745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu2+jcmHfLGqxfEB8BtcD+CyPwLkbrwiJSDJROL1kOs=;
        b=mvFsf8EHIdUuxYpxMNnOHVbBBKOqPqc+267hXgcn90y1KxlJYShlcNc+XTTSx8vcev
         x8lMX+DY4uBmFhuYsRPhLJRJFT4aWyff+PQfTngFtwtINxv18ydTKuy84S32FAv0FS/e
         A7BI0d42/nwbtqkIqruZ1TneRNHq1SMqJJofL1eHlwRgqXqq2xsd2cO+OTXzAPSM4OHB
         twbp1MC9EB+wwVy943+05yCF8NA25W30mdn4IyyBqo0UHXrUzMmM9+pH566N2QflxXTy
         tGT7GNt3RaitWWrUq3IC9tKqEBvpNNhcxZ38oLLG6WGlRFkJH4DWrwQPZ6CKcxCYBaW2
         Vpjw==
X-Forwarded-Encrypted: i=1; AJvYcCVbAgxVcnNj0FT8i5pDFamiI/Mb0JXac00SsGzlyBK+sXtE8HQeHRRcReS+ykO0mx3I++DMX5k+RlpA+3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRaN1rMc2rCyBlmZ5uJrZpC3viBpeWiNVc25xU08PsbdDgAj8C
	/K9KO3XYWLV9hExfFmcbhzeU9cByJDrRtqHtZ57m5tYqlMeQfOqDQfBQJN+wFr/kLYmW3lS8joP
	IAQ==
X-Google-Smtp-Source: AGHT+IHxVo+t1+38CXIDKhdHW3yDunUOvAqFmBszn+ZSbkI5s68ZT87xtZi5NP9rD/d8sCIPORwXjlD2yqo=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:fce8:d4a4:aa70:51a5])
 (user=nogikh job=sendgmr) by 2002:a25:9011:0:b0:e13:e11c:507 with SMTP id
 3f1490d57ef6-e1a5ab46f56mr5928276.3.1724950945152; Thu, 29 Aug 2024 10:02:25
 -0700 (PDT)
Date: Thu, 29 Aug 2024 19:02:22 +0200
In-Reply-To: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240727102732.960974693@infradead.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240829170222.3680522-1-nogikh@google.com>
Subject: Re: [PATCH 00/24] Complete EEVDF
From: Aleksandr Nogikh <nogikh@google.com>
To: peterz@infradead.org
Cc: bsegall@google.com, dietmar.eggemann@arm.com, efault@gmx.de, 
	juri.lelli@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org, tglx@linutronix.de, 
	vincent.guittot@linaro.org, vschneid@redhat.com, wuyun.abel@bytedance.com, 
	youssefesmat@chromium.org, syzkaller-bugs@googlegroups.com, 
	dvyukov@google.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

This series has caused an explosion of different kernel crashes on our
syzbot instance that fuzzes linux-next. I guess, such kernel behavior
indicates some massive underlying memory corruption (?)

Some of the crash titles we've seen (we didn't release them -- there
were too many, 70+):

KASAN: stack-out-of-bounds Write in insn_decode 
kernel panic: stack is corrupted in vprintk_store
kernel panic: stack is corrupted in _printk
BUG: spinlock recursion in __schedule
WARNING in __put_task_struct
BUG: unable to handle kernel NULL pointer dereference in asm_exc_page_fault
WARNING in rng_dev_read
BUG: scheduling while atomic in prb_final_commit
kernel BUG in dequeue_rt_stack
BUG: scheduling while atomic in rcu_is_watching
BUG: spinlock recursion in copy_process
KASAN: slab-use-after-free Read in sched_core_enqueue
kernel panic: stack is corrupted in refill_stock
kernel panic: stack is corrupted in prb_reserve
WARNING: bad unlock balance in timekeeping_get_ns
KASAN: slab-use-after-free Read in set_next_task_fair

I wonder if the actual problem is already known and possibly there are
even some fix patches?

If not and if it may be of any help, we can try to come up with some
contained instruction to reproduce these issues with syzkaller.

--
Aleksandr

