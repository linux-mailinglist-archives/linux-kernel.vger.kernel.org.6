Return-Path: <linux-kernel+bounces-370541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C99A2E40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D671B215F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2127A227B80;
	Thu, 17 Oct 2024 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsyaddJM"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477F33997
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195752; cv=none; b=a1ZIIiQMUHXR/QHehPGV1K8kPERDGbuxJ0AaKg1d9XF/F4HIdiDp1YxzvNTp/LMugaUKihLJF63pKlJlaWhVeTnL69EqI6WFd6hZxPehBqMN/bMaJJK6V7pozipuUEkAoj9hFqHiGrrL4i7BGFmOGtclg9Y/J0wXeH1ht7EaxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195752; c=relaxed/simple;
	bh=fd6yCNin2atz6ZVXf36qOeud6PVRQ6P04pKpCvUivqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Du3YgtcIHdrTU2GUpA7cG9uY22PsqPjhZ82pjcUpsRhknNx1fFbX8gQwBLny5xfpbiNbXOUHHP0oDYH9IG58ZlUTBAVGFlbDOJBPxJkyVcQAZKge5DfgChJizWPW/7O0+8q5EvnLQgciF28SPCWRNTp7tZrWERSZTARjbQ0lsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dsyaddJM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca7fc4484so9891225ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729195750; x=1729800550; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jM0SPbPw32VElBgdBJL/efOxl6iXgyTctdZtgaIfjmM=;
        b=dsyaddJMncs1R7hEEDQs+vCTUHktAaiCuV/0izzzLGqCKinEcSlJVG8cgfgByL8vOm
         84Yf8av7R6d8c9M/+PHUzJLuqIvWAY2WBf075wYB0z0nwRfyzU03nvw7cl4t2aDeU1Su
         /3uc34h1MGHb8TcKqOYpcccbP+0aq7fEhYWMKG88PfiVMoqbm+FIf5+JUhlw1S3rqMoW
         EJo73JZMnwkstqLfqTGAQdgR4bTLwMbQsE/oDAoiTYYwdHrEgDFkGwT6fOcOFi2Xl5i5
         KGmS3EiiyrAIFj09ZLN7F3VGjeZTUGo8hTW2ompkfVu3bGMG4cFV88Y2UBju7AqwsnlP
         B8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729195750; x=1729800550;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM0SPbPw32VElBgdBJL/efOxl6iXgyTctdZtgaIfjmM=;
        b=IrU8EyWyruVHVVvo85juD2Q4VDYPfXgaXPxwecOi0NHdnt30C60NwjuDgNYROI/Ug3
         h9LSfBSORxU9vq/oEkFuc4w9vPF0YkFYpEE/sFyrdSwaXW0y9Uur6i1qWYRD6Nc0Yd3H
         JEfeQXl75K2IeejY88cPN4TTtITOTKo+lDrF1XvuQiW6Z5FA55Vxy9fR9wsLml4Vn6UY
         7hgv57ABpx1GdlsbZj3TDBPHafqKZejTqn04ShiS+YHrTn+lACE98lWpD194QDg4HYps
         NAVAOeiWpffob0/k/2QEa1UeNNVOjWLb8h83LJ4HLOOKWgRdgIVOvU1ZSuej8yVxoGgn
         KUIg==
X-Gm-Message-State: AOJu0YyeisMqeQPCuPb/p7eURahkNhm33PRtkWf2uAFGt9RnFr2Dbg4n
	R/ughQUQYKq8TKYFb7jwL2J0GNYKjKDSQDuiwJ7VUthuitrSzzftrzzxnno9hQ==
X-Google-Smtp-Source: AGHT+IGq4mX8I/hQEzKUHHkgbj7Hmm1WdliVFtpy+DrqRgkw5vSAjwD5naVTHIU6MmKSBfLJeLaMhQ==
X-Received: by 2002:a17:902:e807:b0:20c:a8cf:fa19 with SMTP id d9443c01a7336-20e5a8bc07bmr1412975ad.22.1729195750039;
        Thu, 17 Oct 2024 13:09:10 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a752005sm318005ad.104.2024.10.17.13.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 13:09:09 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,  Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Chris Metcalf <cmetcalf@ezchip.com>,  Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] posix-cpu-timers: clear TICK_DEP_BIT_POSIX_TIMER on clone
In-Reply-To: <ZxDTFmOi0waQFGEX@lothringen> (Frederic Weisbecker's message of
	"Thu, 17 Oct 2024 11:04:22 +0200")
References: <xm264j5bd2gj.fsf@google.com> <ZxDTFmOi0waQFGEX@lothringen>
Date: Thu, 17 Oct 2024 13:09:08 -0700
Message-ID: <xm26zfn2bifv.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Frederic Weisbecker <frederic@kernel.org> writes:

> On Wed, Oct 16, 2024 at 04:59:08PM -0700, Benjamin Segall wrote:
>> When we clone a new thread, we do not inherit its posix_cputimers, and
>> clear them with posix_cputimers_init. However, this does not clear the
>> tick dependency it creates in tsk->tick_dep_mask, and the handler does
>> not reach the code to clear the dependency if there were no timers to
>> begin with.
>> 
>> Thus if a thread has a cputimer running before cloneing/forking, that
>> hierarchy will prevent nohz_full unless they create a cputimer of their
>> own.
>> 
>> Process-wide timers do not have this problem because fork does not copy
>> signal_struct as a baseline, it creates one from scratch.
>> 
>> Fixes: b78783000d5c ("posix-cpu-timers: Migrate to use new tick dependency mask model")
>> Signed-off-by: Ben Segall <bsegall@google.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  kernel/fork.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index df8e4575ff01..b57cd63cfcd1 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -2290,10 +2290,11 @@ __latent_entropy struct task_struct *copy_process(
>>  
>>  	task_io_accounting_init(&p->ioac);
>>  	acct_clear_integrals(p);
>>  
>>  	posix_cputimers_init(&p->posix_cputimers);
>> +	tick_dep_clear_task(p, TICK_DEP_BIT_POSIX_TIMER);
>
> Yes but we don't need the expensive atomic_fetch_andnot(). Also more
> generally the task tick dependency should be 0 upon creation.
>
> So something like this?

Yeah, the only other uses are contained in rcu_do_batch and rcutorture
tests, which won't end up here anyways.

Up to you if you want to send this or I can send out a v2.

>
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index 72744638c5b0..99c9c5a7252a 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -251,12 +251,19 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
>  	if (tick_nohz_full_enabled())
>  		tick_nohz_dep_set_task(tsk, bit);
>  }
> +
>  static inline void tick_dep_clear_task(struct task_struct *tsk,
>  				       enum tick_dep_bits bit)
>  {
>  	if (tick_nohz_full_enabled())
>  		tick_nohz_dep_clear_task(tsk, bit);
>  }
> +
> +static inline void tick_dep_init_task(struct task_struct *tsk)
> +{
> +	atomic_set(&tsk->tick_dep_mask, 0);
> +}
> +
>  static inline void tick_dep_set_signal(struct task_struct *tsk,
>  				       enum tick_dep_bits bit)
>  {
> @@ -290,6 +297,7 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
>  				     enum tick_dep_bits bit) { }
>  static inline void tick_dep_clear_task(struct task_struct *tsk,
>  				       enum tick_dep_bits bit) { }
> +static inline void tick_dep_init_task(struct task_struct *tsk) { }
>  static inline void tick_dep_set_signal(struct task_struct *tsk,
>  				       enum tick_dep_bits bit) { }
>  static inline void tick_dep_clear_signal(struct signal_struct *signal,
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 89ceb4a68af2..6fa9fe62e01e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -105,6 +105,7 @@
>  #include <linux/rseq.h>
>  #include <uapi/linux/pidfd.h>
>  #include <linux/pidfs.h>
> +#include <linux/tick.h>
>  
>  #include <asm/pgalloc.h>
>  #include <linux/uaccess.h>
> @@ -2292,6 +2293,7 @@ __latent_entropy struct task_struct *copy_process(
>  	acct_clear_integrals(p);
>  
>  	posix_cputimers_init(&p->posix_cputimers);
> +	tick_dep_init_task(p);
>  
>  	p->io_context = NULL;
>  	audit_set_context(p, NULL);

