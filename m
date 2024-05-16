Return-Path: <linux-kernel+bounces-181249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F108C7987
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C6F1C20AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112D14D2B7;
	Thu, 16 May 2024 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJeXHAGa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCA1459F3
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873510; cv=none; b=DuBp3W+JrbRp5iGcww3E7RFla1lICE9KZDRAFk4wjVq2KClGAfO6j5ouulSpEV/qjBXvBsqxdxh8mXAaNfJihVEkUxm1zKDtnOuOSGshkGP5w26O67S4O4gQwEUJHAUYOl2mKeIFU7TvwD9R1dHTzZum3mTjNtvNiK9lwAwM1bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873510; c=relaxed/simple;
	bh=CSxlFZa4UXxr66D229r3M88rP93BccsItmm2lqbdGDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CSmft/lEoSwirPjPaVZygWtLQ9ZdGDwsoNmAxxqdaR+j0vDoM3MrvnQYAsALgiYuVv+uiIxCUmumRlXfWpXHKo4a3Zg7n2upGy9iRAQyGrhgYRv7nialA+zs0MQqnKQcDBj7VZ8Q60kC0A85Xiy0a60/EFkBMR4tfE7M7NnHFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJeXHAGa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715873507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8vCmwzfIi1WsXVSAkQT/J8aQjrqLjeYZ5L4roMvwBQ=;
	b=EJeXHAGa+W+bQgd3dGUqHtfbvmgWCQKJvXNjsovLzcdehU+FJIPph8AIrBh+mGp00UCmjA
	zpsIeKZPxHm8YEaUXM8FrTLluwhx3SB0FBtWwNjGiXtshefs4IMSR5BpmxmcwXMJxLywew
	zWaVRD8nOemENtFWq3+OqLi7S7O2/eU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-yTgodCIcOXO-zHKwzpLHJw-1; Thu, 16 May 2024 11:31:46 -0400
X-MC-Unique: yTgodCIcOXO-zHKwzpLHJw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5b273efe12aso9428012eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715873505; x=1716478305;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8vCmwzfIi1WsXVSAkQT/J8aQjrqLjeYZ5L4roMvwBQ=;
        b=ax+fFyOjc+AzQdgO3jtJj7Oc+RxlAYbmTM1xJpCjIXuEGjBRxKiO1K7TV0IvW1F2cu
         W6qM6QtFBaiRR8qYAFWAycZ+Lbx0+DPKjyP1ltBRfHYR3KZxp4Hph4LrW8SPNUhVk1xS
         f7/AKh6Omj/61ZGhgAwKWOmrCyl10eGluKpN7CRfml+pfESI5GucAHpdVJJJPPs9cipw
         lhLWR44EBHPko2KklxX9xzW3S/UsmZ/2ycGv2P4hx6T4BVUEXjLPn1kIp/uwnnlvi6Rn
         sClwBzYEuXkM791wa7pS3l/R1pHVrhdMdEaCS0R+q150CpPGg0wmIqLAC+9QmQqpJaW3
         1NrA==
X-Forwarded-Encrypted: i=1; AJvYcCXyicJSBpu1BrlEz3yiBm8iyAZtmPiIbh/gSckB+N9boItpR5SlwVDAib4c+/rSrHgF88uZ1VBA90c58JR+qkxHyYgZ93czR1d3Nm7l
X-Gm-Message-State: AOJu0YxnOIgc7Pv8/y595qsD2f7cf3ROVBF/VqdbIMYDeX65Hn8qAB53
	mZxcayXeWRcLCwaOKhYqYtp8d+xhvlVq2EYvjkilo3F2xWoWUHqwhvwSCS9snch6LNJiI6+hZwI
	db7vz+d+rtyEN+/RFJNrIUOGJuAfCbHWrUOi3fT5uD/s7+o1sIrd7eJnqGuEb3A==
X-Received: by 2002:a05:6358:70c1:b0:17e:8ea3:83cc with SMTP id e5c5f4694b2df-193bcfd421amr1959872755d.24.1715873504692;
        Thu, 16 May 2024 08:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE41GJnq+HtznMWb6X6izWXUDrLVmkKJuJMyuZB7TKWKACkFsrJ0Hf+ACdaFGTSA2DKuBzpA==
X-Received: by 2002:a05:6358:70c1:b0:17e:8ea3:83cc with SMTP id e5c5f4694b2df-193bcfd421amr1959869255d.24.1715873504128;
        Thu, 16 May 2024 08:31:44 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f185787sm77010226d6.45.2024.05.16.08.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:31:43 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/6] rcu: Remove superfluous full memory barrier upon
 first EQS snapshot
In-Reply-To: <20240515125332.9306-3-frederic@kernel.org>
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-3-frederic@kernel.org>
Date: Thu, 16 May 2024 17:31:40 +0200
Message-ID: <xhsmhfruhhixv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/05/24 14:53, Frederic Weisbecker wrote:
> When the grace period kthread checks the extended quiescent state
> counter of a CPU, full ordering is necessary to ensure that either:
>
> * If the GP kthread observes the remote target in an extended quiescent
>   state, then that target must observe all accesses prior to the current
>   grace period, including the current grace period sequence number, once
>   it exits that extended quiescent state.
>
> or:
>
> * If the GP kthread observes the remote target NOT in an extended
>   quiescent state, then the target further entering in an extended
>   quiescent state must observe all accesses prior to the current
>   grace period, including the current grace period sequence number, once
>   it enters that extended quiescent state.
>
> This ordering is enforced through a full memory barrier placed right
> before taking the first EQS snapshot. However this is superfluous
> because the snapshot is taken while holding the target's rnp lock which
> provides the necessary ordering through its chain of
> smp_mb__after_unlock_lock().
>
> Remove the needless explicit barrier before the snapshot and put a
> comment about the implicit barrier newly relied upon here.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  .../Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst    | 6 +++---
>  kernel/rcu/tree.c                                          | 7 ++++++-
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> index 5750f125361b..728b1e690c64 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> @@ -149,9 +149,9 @@ This case is handled by calls to the strongly ordered
>  ``atomic_add_return()`` read-modify-write atomic operation that
>  is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
>  time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
> -The grace-period kthread invokes ``rcu_dynticks_snap()`` and
> -``rcu_dynticks_in_eqs_since()`` (both of which invoke
> -an ``atomic_add_return()`` of zero) to detect idle CPUs.
> +The grace-period kthread invokes first ``ct_dynticks_cpu_acquire()``
> +(preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_since()``
> +(both of which rely on acquire semantics) to detect idle CPUs.
>
>  +-----------------------------------------------------------------------+
>  | **Quick Quiz**:                                                       |
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 58415cdc54f8..f5354de5644b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -773,7 +773,12 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
>   */
>  static int dyntick_save_progress_counter(struct rcu_data *rdp)
>  {
> -	rdp->dynticks_snap = rcu_dynticks_snap(rdp->cpu);

So for PPC, which gets the smp_mb() at the lock acquisition, this is an
"obvious" redundant smp_mb().

For the other archs, per the definition of smp_mb__after_unlock_lock() it
seems implied that UNLOCK+LOCK is a full memory barrier, but I wanted to
see it explicitly stated somewhere. From a bit of spelunking below I still
think it's the case, but is there a "better" source of truth?

  01352fb81658 ("locking: Add an smp_mb__after_unlock_lock() for UNLOCK+BLOCK barrier")
  """
  The Linux kernel has traditionally required that an UNLOCK+LOCK pair act as a
  full memory barrier when either (1) that UNLOCK+LOCK pair was executed by the
  same CPU or task, or (2) the same lock variable was used for the UNLOCK and
  LOCK.
  """

and

  https://lore.kernel.org/all/1436789704-10086-1-git-send-email-will.deacon@arm.com/
  """
  This ordering guarantee is already provided without the barrier on
  all architectures apart from PowerPC
  """

> +	/*
> +	 * Full ordering against accesses prior current GP and also against
                                          ^^^^^
                                          prior to

> +	 * current GP sequence number is enforced by current rnp locking
> +	 * with chained smp_mb__after_unlock_lock().
> +	 */
> +	rdp->dynticks_snap = ct_dynticks_cpu_acquire(rdp->cpu);
>       if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
>               trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
>               rcu_gpnum_ovf(rdp->mynode, rdp);
> --
> 2.44.0


