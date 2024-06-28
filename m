Return-Path: <linux-kernel+bounces-234383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF0D91C5F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2D11C20E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB421CD5CE;
	Fri, 28 Jun 2024 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUOHrTN6"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A629F25634
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600186; cv=none; b=IMFf4OjTo6nSWnxGfETmGxS+DZUq3HjydwwaTV7xd2OxuZNRP8TsIyrtwQV7gXSiz6ya83tXOSZ71hJyg3z7vzbQVWg1rLqRdw71cly+YrWmKzIujbWzAkSJbyvoy4CRk+x7AdmHZVmq/HXKOPRary0Uz1cKrE+m5BsfLIfwOuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600186; c=relaxed/simple;
	bh=7uSbG5YHon321aVBaLYyhBALXhCOPczk0GtWi2XUp7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BecjiAY9bbU8vuAg27Lpf5GpTxtvwuBNul2C94mEJrMHwy9z4SypPnR53iaUOulYtAg46UGF6A1yyIozR9fs0N3cPiJ+pLrtFyyYAxHs/eOE+4H/dau6HA2p9xTUM2Kd7nosrFHZGQtT90tXMtc3ALDQjpTnl8lYhRJZ5ATd0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUOHrTN6; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c92d00059eso621602a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719600184; x=1720204984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASYpezIFV+QZ88OIi1PVCP5tyk7nJ+jigbQ79edHVoI=;
        b=dUOHrTN6dwYG6FhplgxsXcnvYe+cRtIWuTGRpkXCtab9cpyGW42PW2UvfnssFsQ6qV
         OCBvMZ8TO6i5tW2VvrjYJWEeVzCxG4AX9ZHF3WwNnbmjDosJNP60aynrspg9glLMQzSb
         UwgCHZpCPxHPBjndDsB7ZaOT5ggXhkyOCjZSw7WMM+ZLCR2iFdUOnWwErtLIgnKseyrk
         K4X5UUm76YwtmcrmdO+1r50w65RUxmC/QlKLCk6wyrxyqfWMsW5MFlrKmXNjucjTmu0b
         B0oZx2q42/iJRcsl222YzytK0QQUFv07U5+Nz5rX+ptIbYbIbhmXLQ1JfIz6pLaYmIT4
         qKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719600184; x=1720204984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASYpezIFV+QZ88OIi1PVCP5tyk7nJ+jigbQ79edHVoI=;
        b=Wuj2GXCp4i8dtZtMtXdpxyv9UqCGfNcWqyHTESwjCxn952L/D8c01Xt4gzNBCShRbn
         Es4WMsX4Oke7Y/HmtoAovoX+IOnta4Wl3+LO59/i0Qe8NoMeM0Dtv+L2K/N06RrM8QrJ
         u0MF6JzTceB/IGRl1RQ0DorBBy7sWhkSjY3/Oy5sc+4//xo1eo8isvTZV+N3rq4SJ8xN
         ovypFhyhgg2Ck2uuGjQS6infl65TwKW7vgazh4ADVYvI0RkGWKec4VfXMSa+WqBOLAPJ
         FlAWIcfSfQtawMn7sqjs+lHBPQeMRnbsGvav+BHdup3BMdP9bi6V2d6JhiZ3M93rQsjb
         Yjog==
X-Forwarded-Encrypted: i=1; AJvYcCUpX/yRTTuaroDmzSfvufXlvsETBYk6QQN5WbGY/UBEtw0+QVfUp4rBu6TcqDcMQszDGQ41fMrYYZXZ8EOQwDqS3KJF5y1jxXxvZvQv
X-Gm-Message-State: AOJu0YxM3r76qfuQawFq1UqYB3Xui9nQvO2cva/+zJsETywUlHzv1RTs
	lznCXfo8mjQDotm5B9CS71pM1GaDyd1rQuwowrIcWyUtgb2R0Fr+j+Tkvs8jJw==
X-Google-Smtp-Source: AGHT+IGBBRI+uYKoHmDi7Yzck+AuEnasPivqcgxbxFA3OapikezlYhO69j+b0UcCoujDoKKzS6xHsg==
X-Received: by 2002:a17:90b:19c1:b0:2c2:cda5:717c with SMTP id 98e67ed59e1d1-2c86146c87fmr15335019a91.31.1719600183400;
        Fri, 28 Jun 2024 11:43:03 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce4526esm1969793a91.20.2024.06.28.11.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:43:02 -0700 (PDT)
Date: Fri, 28 Jun 2024 18:42:59 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Yu-Ting Tseng <yutingtseng@google.com>
Cc: tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, aliceryhl@google.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] binder: frozen notification
Message-ID: <Zn8EMy2Q4KUVc7dC@google.com>
References: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
 <20240624172031.407921-5-yutingtseng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624172031.407921-5-yutingtseng@google.com>

On Mon, Jun 24, 2024 at 10:20:34AM -0700, Yu-Ting Tseng wrote:
> Frozen processes present a significant challenge in binder transactions.
> When a process is frozen, it cannot, by design, accept and/or respond to
> binder transactions. As a result, the sender needs to adjust its
> behavior, such as postponing transactions until the peer process
> unfreezes. However, there is currently no way to subscribe to these
> state change events, making it impossible to implement frozen-aware
> behaviors efficiently.
> 
> Introduce a binder API for subscribing to frozen state change events.
> This allows programs to react to changes in peer process state,
> mitigating issues related to binder transactions sent to frozen
> processes.
> 
> Implementation details:
> For a given binder_ref, the state of frozen notification can be one of
> the followings:
> 1. Userspace doesn't want a notification. binder_ref->freeze is null.
> 2. Userspace wants a notification but none is in flight.
>    list_empty(&binder_ref->freeze->work.entry) = true
> 3. A notification is in flight and waiting to be read by userspace.
>    binder_ref_freeze.sent is false.
> 4. A notification was read by userspace and kernel is waiting for an ack.
>    binder_ref_freeze.sent is true.
> 
> When a notification is in flight, new state change events are coalesced into
> the existing binder_ref_freeze struct. If userspace hasn't picked up the
> notification yet, the driver simply rewrites the state. Otherwise, the
> notification is flagged as requiring a resend, which will be performed
> once userspace acks the original notification that's inflight.
> 
> See https://android-review.googlesource.com/c/platform/frameworks/native/+/3070045

I believe the external link would be https://r.android.com/3070045

> for how userspace is going to use this feature.
> 
> Signed-off-by: Yu-Ting Tseng <yutingtseng@google.com>
> ---
>  drivers/android/binder.c            | 300 +++++++++++++++++++++++++++-
>  drivers/android/binder_internal.h   |  23 ++-
>  include/uapi/linux/android/binder.h |  35 ++++
>  3 files changed, 354 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index b21a7b246a0d..d3dacfe0926d 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3763,6 +3763,174 @@ static void binder_transaction(struct binder_proc *proc,
>  	}
>  }
>  
> +static int
> +binder_request_freeze_notification(struct binder_proc *proc,
> +				   struct binder_thread *thread,
> +				   struct binder_handle_cookie *handle_cookie)
> +{
> +	struct binder_ref_freeze *freeze;
> +	struct binder_ref *ref;
> +
> +	/*
> +	 * Allocate memory for freeze notification before taking lock.
> +	 */
> +	freeze = kzalloc(sizeof(*freeze), GFP_KERNEL);
> +	if (!freeze) {
> +		thread->return_error.cmd = BR_ERROR;
> +		binder_enqueue_thread_work(thread, &thread->return_error.work);
> +		binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
> +			     "%d:%d BC_REQUEST_FREEZE_NOTIFICATION failed\n",
> +			     proc->pid, thread->pid);
> +		return -ENOMEM;
> +	}

A couple notes on this allocation:
(1) drop the BR_ERROR, at least until we define a global policy for
propagating errors. For now the "-ENOMEM" will be enough.
(2) typically OOM error logs are discouraged, the infra already dumps
necessary info. Please remove the debug log.
(3) I don't think the comment is necessary.

This should all just be:

	freeze = kzalloc(sizeof(*freeze), GFP_KERNEL);
	if (!freeze)
		return -ENOMEM;

> +
> +	binder_proc_lock(proc);
> +	ref = binder_get_ref_olocked(proc, handle_cookie->handle, false);
> +	if (!ref) {
> +		binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATION invalid ref %d\n",
> +				  proc->pid, thread->pid, handle_cookie->handle);
> +		binder_proc_unlock(proc);
> +		kfree(freeze);
> +		return -EINVAL;
> +	}
> +
> +	binder_node_lock(ref->node);
> +
> +	if (ref->freeze || !ref->node->proc) {
> +		if (ref->freeze) {
> +			binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATION freeze notification already set\n",
> +					  proc->pid, thread->pid);
> +		} else {
> +			binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATION process is already dead\n",
> +					  proc->pid, thread->pid);
> +		}
> +		binder_node_unlock(ref->node);
> +		binder_proc_unlock(proc);
> +		kfree(freeze);
> +		return -EINVAL;
> +	}
> +	binder_stats_created(BINDER_STAT_FREEZE);
> +	INIT_LIST_HEAD(&freeze->work.entry);
> +	freeze->cookie = handle_cookie->cookie;
> +	ref->freeze = freeze;
> +	ref->freeze->work.type = BINDER_WORK_FROZEN_BINDER;

Are we ok modifying the ref->freeze->* space here without the
inner_lock? I believe this is OK as we can't race with the other
operations?

> +
> +	binder_inner_proc_lock(ref->node->proc);
> +	ref->freeze->is_frozen = ref->node->proc->is_frozen;
> +	binder_inner_proc_unlock(ref->node->proc);
> +
> +	binder_inner_proc_lock(proc);
> +	binder_enqueue_work_ilocked(&ref->freeze->work, &proc->todo);
> +	binder_wakeup_proc_ilocked(proc);
> +	binder_inner_proc_unlock(proc);
> +
> +	binder_node_unlock(ref->node);
> +	binder_proc_unlock(proc);
> +	return 0;
> +}
> +
> +static int
> +binder_clear_freeze_notification(struct binder_proc *proc,
> +				 struct binder_thread *thread,
> +				 struct binder_handle_cookie *handle_cookie)
> +{
> +	struct binder_ref_freeze *freeze;
> +	struct binder_ref *ref;
> +
> +	binder_proc_lock(proc);
> +	ref = binder_get_ref_olocked(proc, handle_cookie->handle, false);
> +	if (!ref) {
> +		binder_user_error("%d:%d BC_CLEAR_FREEZE_NOTIFICATION invalid ref %d\n",
> +				  proc->pid, thread->pid, handle_cookie->handle);
> +		binder_proc_unlock(proc);
> +		return -EINVAL;
> +	}
> +
> +	binder_node_lock(ref->node);
> +
> +	if (!ref->freeze) {
> +		binder_user_error("%d:%d BC_CLEAR_FREEZE_NOTIFICATION freeze notification not active\n",
> +				  proc->pid, thread->pid);
> +		binder_node_unlock(ref->node);
> +		binder_proc_unlock(proc);
> +		return -EINVAL;
> +	}
> +	freeze = ref->freeze;
> +	if (freeze->cookie != handle_cookie->cookie) {
> +		binder_user_error("%d:%d BC_CLEAR_FREEZE_NOTIFICATION freeze notification cookie mismatch %016llx != %016llx\n",
> +				  proc->pid, thread->pid, (u64)freeze->cookie,
> +				  (u64)handle_cookie->cookie);
> +		binder_node_unlock(ref->node);
> +		binder_proc_unlock(proc);
> +		return -EINVAL;
> +	}
> +	ref->freeze = NULL;
> +	binder_inner_proc_lock(proc);
> +	if (list_empty(&freeze->work.entry)) {
> +		freeze->work.type = BINDER_WORK_CLEAR_FREEZE_NOTIFICATION;
> +		if (thread->looper &
> +			(BINDER_LOOPER_STATE_REGISTERED | BINDER_LOOPER_STATE_ENTERED)) {
> +			binder_enqueue_thread_work_ilocked(thread, &freeze->work);

I'm not entirely sure why we attempt to queue this as thread work. It
seems more complicated that it needs to be. Do you know why not handle
this as proc work every time instead?

> +		} else {
> +			binder_enqueue_work_ilocked(&freeze->work, &proc->todo);
> +			binder_wakeup_proc_ilocked(proc);
> +		}
> +	} else {
> +		/*
> +		 * There is already a freeze notification. Take it over and rewrite
> +		 * the work type. If it was already sent, flag it for re-sending;
> +		 * Otherwise it's pending and will be sent soon.
> +		 */
> +		freeze->work.type = BINDER_WORK_CLEAR_FREEZE_NOTIFICATION;

We set the work type to CLEAR regardless, might as well factor it out.

> +		if (freeze->sent)
> +			freeze->resend = true;
> +	}
> +	binder_inner_proc_unlock(proc);
> +	binder_node_unlock(ref->node);
> +	binder_proc_unlock(proc);
> +	return 0;
> +}
> +
> +static int
> +binder_freeze_notification_done(struct binder_proc *proc,
> +				struct binder_thread *thread,
> +				binder_uintptr_t cookie)
> +{
> +	struct binder_ref_freeze *freeze = NULL;
> +	struct binder_work *w;
> +
> +	binder_inner_proc_lock(proc);
> +	list_for_each_entry(w, &proc->delivered_freeze, entry) {
> +		struct binder_ref_freeze *tmp_freeze =
> +			container_of(w, struct binder_ref_freeze, work);
> +
> +		if (tmp_freeze->cookie == cookie) {
> +			freeze = tmp_freeze;
> +			break;
> +		}
> +	}
> +	if (!freeze) {
> +		binder_user_error("%d:%d BC_FREEZE_NOTIFICATION_DONE %016llx not found\n",
> +				  proc->pid, thread->pid, (u64)cookie);
> +		binder_inner_proc_unlock(proc);
> +		return -EINVAL;
> +	}
> +	binder_dequeue_work_ilocked(&freeze->work);
> +	freeze->sent = false;
> +	if (freeze->resend) {
> +		freeze->resend = false;
> +		if (thread->looper &
> +			(BINDER_LOOPER_STATE_REGISTERED | BINDER_LOOPER_STATE_ENTERED)) {
> +			binder_enqueue_thread_work_ilocked(thread, &freeze->work);
> +		} else {
> +			binder_enqueue_work_ilocked(&freeze->work, &proc->todo);
> +			binder_wakeup_proc_ilocked(proc);
> +		}

Yeah I don't know why we go through the trouble of trying to handle this
as thread work.

> +	}
> +	binder_inner_proc_unlock(proc);
> +	return 0;
> +}
> +
>  /**
>   * binder_free_buf() - free the specified buffer
>   * @proc:	binder proc that owns buffer
> @@ -4246,6 +4414,44 @@ static int binder_thread_write(struct binder_proc *proc,
>  			binder_inner_proc_unlock(proc);
>  		} break;
>  
> +		case BC_REQUEST_FREEZE_NOTIFICATION: {
> +			struct binder_handle_cookie handle_cookie;
> +			int error;
> +
> +			if (copy_from_user(&handle_cookie, ptr, sizeof(handle_cookie)))
> +				return -EFAULT;
> +			ptr += sizeof(handle_cookie);
> +			error = binder_request_freeze_notification(proc, thread,
> +								   &handle_cookie);
> +			if (error)
> +				return error;
> +		} break;
> +
> +		case BC_CLEAR_FREEZE_NOTIFICATION: {
> +			struct binder_handle_cookie handle_cookie;
> +			int error;
> +
> +			if (copy_from_user(&handle_cookie, ptr, sizeof(handle_cookie)))
> +				return -EFAULT;
> +			ptr += sizeof(handle_cookie);
> +			error = binder_clear_freeze_notification(proc, thread, &handle_cookie);
> +			if (error)
> +				return error;
> +		} break;
> +
> +		case BC_FREEZE_NOTIFICATION_DONE: {
> +			binder_uintptr_t cookie;
> +			int error;
> +
> +			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
> +				return -EFAULT;
> +
> +			ptr += sizeof(cookie);
> +			error = binder_freeze_notification_done(proc, thread, cookie);
> +			if (error)
> +				return error;
> +		} break;
> +
>  		default:
>  			pr_err("%d:%d unknown command %u\n",
>  			       proc->pid, thread->pid, cmd);
> @@ -4635,6 +4841,45 @@ static int binder_thread_read(struct binder_proc *proc,
>  			if (cmd == BR_DEAD_BINDER)
>  				goto done; /* DEAD_BINDER notifications can cause transactions */
>  		} break;
> +
> +		case BINDER_WORK_FROZEN_BINDER: {
> +			struct binder_ref_freeze *freeze;
> +			struct binder_frozen_state_info info;
> +
> +			freeze = container_of(w, struct binder_ref_freeze, work);
> +			info.is_frozen = freeze->is_frozen;
> +			info.cookie = freeze->cookie;
> +			freeze->sent = true;

It's a bit confusing to me the locking here. It seems the freeze->*
space is protected by the proc->inner_lock right? We read/write several
elements here with only that lock held.

> +			binder_enqueue_work_ilocked(w, &proc->delivered_freeze);
> +			binder_inner_proc_unlock(proc);
> +
> +			if (put_user(BR_FROZEN_BINDER, (uint32_t __user *)ptr))
> +				return -EFAULT;
> +			ptr += sizeof(uint32_t);
> +			if (copy_to_user(ptr, &info, sizeof(info)))
> +				return -EFAULT;

I believe you should zero the 'info' before copy_to_user(). This might
leak kernel's stack memory to userspace if there is any padding.

> +			ptr += sizeof(info);
> +			binder_stat_br(proc, thread, BR_FROZEN_BINDER);
> +			goto done; /* BR_FROZEN_BINDER notifications can cause transactions */
> +		} break;
> +
> +		case BINDER_WORK_CLEAR_FREEZE_NOTIFICATION: {
> +			struct binder_ref_freeze *freeze =
> +			    container_of(w, struct binder_ref_freeze, work);
> +			binder_uintptr_t cookie = freeze->cookie;
> +
> +			binder_inner_proc_unlock(proc);
> +			kfree(freeze);
> +			binder_stats_deleted(BINDER_STAT_FREEZE);
> +			if (put_user(BR_CLEAR_FREEZE_NOTIFICATION_DONE, (uint32_t __user *)ptr))
> +				return -EFAULT;
> +			ptr += sizeof(uint32_t);
> +			if (put_user(cookie, (binder_uintptr_t __user *)ptr))
> +				return -EFAULT;
> +			ptr += sizeof(binder_uintptr_t);
> +			binder_stat_br(proc, thread, BR_CLEAR_FREEZE_NOTIFICATION_DONE);
> +		} break;
> +
>  		default:
>  			binder_inner_proc_unlock(proc);
>  			pr_err("%d:%d: bad work type %d\n",
> @@ -5242,6 +5487,48 @@ static bool binder_txns_pending_ilocked(struct binder_proc *proc)
>  	return false;
>  }
>  
> +static void binder_add_freeze_work(struct binder_proc *proc, bool is_frozen)
> +{
> +	struct rb_node *n;
> +	struct binder_ref *ref;
> +
> +	binder_inner_proc_lock(proc);
> +	for (n = rb_first(&proc->nodes); n; n = rb_next(n)) {
> +		struct binder_node *node;
> +
> +		node = rb_entry(n, struct binder_node, rb_node);
> +		binder_inner_proc_unlock(proc);
> +		binder_node_lock(node);
> +		hlist_for_each_entry(ref, &node->refs, node_entry) {

So we traverse every single reference of every single node in this proc
looking for references subscribed to freeze, correct? I guess we don't
have the structures to provide something faster. Speed isn't critical
either here.

> +			/*
> +			 * Need the node lock to synchronize
> +			 * with new notification requests and the
> +			 * inner lock to synchronize with queued
> +			 * freeze notifications.
> +			 */
> +			binder_inner_proc_lock(ref->proc);
> +			if (!ref->freeze) {
> +				binder_inner_proc_unlock(ref->proc);
> +				continue;
> +			}
> +			ref->freeze->work.type = BINDER_WORK_FROZEN_BINDER;
> +			if (list_empty(&ref->freeze->work.entry)) {
> +				ref->freeze->is_frozen = is_frozen;
> +				binder_enqueue_work_ilocked(&ref->freeze->work, &ref->proc->todo);
> +				binder_wakeup_proc_ilocked(ref->proc);
> +			} else {
> +				if (ref->freeze->sent && ref->freeze->is_frozen != is_frozen)
> +					ref->freeze->resend = true;
> +				ref->freeze->is_frozen = is_frozen;
> +			}
> +			binder_inner_proc_unlock(ref->proc);
> +		}
> +		binder_node_unlock(node);
> +		binder_inner_proc_lock(proc);
> +	}
> +	binder_inner_proc_unlock(proc);
> +}
> +
>  static int binder_ioctl_freeze(struct binder_freeze_info *info,
>  			       struct binder_proc *target_proc)
>  {
> @@ -5253,6 +5540,7 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
>  		target_proc->async_recv = false;
>  		target_proc->is_frozen = false;
>  		binder_inner_proc_unlock(target_proc);
> +		binder_add_freeze_work(target_proc, false);
>  		return 0;
>  	}
>  
> @@ -5266,6 +5554,7 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
>  	target_proc->async_recv = false;
>  	target_proc->is_frozen = true;
>  	binder_inner_proc_unlock(target_proc);
> +	binder_add_freeze_work(target_proc, true);

What if there a EAGAIN error following this below? I think you want to
update the freeze work about the 'proc->is_frozen = false' change.

>  
>  	if (info->timeout_ms > 0)
>  		ret = wait_event_interruptible_timeout(
> @@ -5658,6 +5947,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
>  	binder_stats_created(BINDER_STAT_PROC);
>  	proc->pid = current->group_leader->pid;
>  	INIT_LIST_HEAD(&proc->delivered_death);
> +	INIT_LIST_HEAD(&proc->delivered_freeze);
>  	INIT_LIST_HEAD(&proc->waiting_threads);
>  	filp->private_data = proc;
>  
> @@ -6209,7 +6499,9 @@ static const char * const binder_return_strings[] = {
>  	"BR_FAILED_REPLY",
>  	"BR_FROZEN_REPLY",
>  	"BR_ONEWAY_SPAM_SUSPECT",
> -	"BR_TRANSACTION_PENDING_FROZEN"
> +	"BR_TRANSACTION_PENDING_FROZEN",
> +	"BR_FROZEN_BINDER",
> +	"BR_CLEAR_FREEZE_NOTIFICATION_DONE",
>  };
>  
>  static const char * const binder_command_strings[] = {
> @@ -6232,6 +6524,9 @@ static const char * const binder_command_strings[] = {
>  	"BC_DEAD_BINDER_DONE",
>  	"BC_TRANSACTION_SG",
>  	"BC_REPLY_SG",
> +	"BC_REQUEST_FREEZE_NOTIFICATION",
> +	"BC_CLEAR_FREEZE_NOTIFICATION",
> +	"BC_FREEZE_NOTIFICATION_DONE",
>  };
>  
>  static const char * const binder_objstat_strings[] = {
> @@ -6241,7 +6536,8 @@ static const char * const binder_objstat_strings[] = {
>  	"ref",
>  	"death",
>  	"transaction",
> -	"transaction_complete"
> +	"transaction_complete",
> +	"freeze",
>  };
>  
>  static void print_binder_stats(struct seq_file *m, const char *prefix,
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index 5b7c80b99ae8..2415fe53b3e9 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -129,12 +129,13 @@ enum binder_stat_types {
>  	BINDER_STAT_DEATH,
>  	BINDER_STAT_TRANSACTION,
>  	BINDER_STAT_TRANSACTION_COMPLETE,
> +	BINDER_STAT_FREEZE,
>  	BINDER_STAT_COUNT
>  };
>  
>  struct binder_stats {
> -	atomic_t br[_IOC_NR(BR_TRANSACTION_PENDING_FROZEN) + 1];
> -	atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
> +	atomic_t br[_IOC_NR(BR_CLEAR_FREEZE_NOTIFICATION_DONE) + 1];
> +	atomic_t bc[_IOC_NR(BC_FREEZE_NOTIFICATION_DONE) + 1];
>  	atomic_t obj_created[BINDER_STAT_COUNT];
>  	atomic_t obj_deleted[BINDER_STAT_COUNT];
>  };
> @@ -159,6 +160,8 @@ struct binder_work {
>  		BINDER_WORK_DEAD_BINDER,
>  		BINDER_WORK_DEAD_BINDER_AND_CLEAR,
>  		BINDER_WORK_CLEAR_DEATH_NOTIFICATION,
> +		BINDER_WORK_FROZEN_BINDER,
> +		BINDER_WORK_CLEAR_FREEZE_NOTIFICATION,
>  	} type;
>  };
>  
> @@ -275,6 +278,16 @@ struct binder_ref_death {
>  	binder_uintptr_t cookie;
>  };
>  
> +struct binder_ref_freeze {
> +	struct binder_work work;
> +	binder_uintptr_t cookie;
> +	bool is_frozen;

any reason why is_frozen didn't make it to the bitfields?

> +	struct {

No need for a struct

> +		u8 sent:1;
> +		u8 resend:1;

You could still keep the original bool for bitfields too if you want.

> +	};
> +};
> +
>  /**
>   * struct binder_ref_data - binder_ref counts and id
>   * @debug_id:        unique ID for the ref
> @@ -307,6 +320,8 @@ struct binder_ref_data {
>   *               @node indicates the node must be freed
>   * @death:       pointer to death notification (ref_death) if requested
>   *               (protected by @node->lock)
> + * @freeze:      pointer to freeze notification (ref_freeze) if requested
> + *               (protected by @node->lock)
>   *
>   * Structure to track references from procA to target node (on procB). This
>   * structure is unsafe to access without holding @proc->outer_lock.
> @@ -323,6 +338,7 @@ struct binder_ref {
>  	struct binder_proc *proc;
>  	struct binder_node *node;
>  	struct binder_ref_death *death;
> +	struct binder_ref_freeze *freeze;
>  };
>  
>  /**
> @@ -374,6 +390,8 @@ struct binder_ref {
>   *                        (atomics, no lock needed)
>   * @delivered_death:      list of delivered death notification
>   *                        (protected by @inner_lock)
> + * @delivered_freeze:     list of delivered freeze notification
> + *                        (protected by @inner_lock)
>   * @max_threads:          cap on number of binder threads
>   *                        (protected by @inner_lock)
>   * @requested_threads:    number of binder threads requested but not
> @@ -421,6 +439,7 @@ struct binder_proc {
>  	struct list_head todo;
>  	struct binder_stats stats;
>  	struct list_head delivered_death;
> +	struct list_head delivered_freeze;
>  	u32 max_threads;
>  	int requested_threads;
>  	int requested_threads_started;
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> index d44a8118b2ed..a358cde61ee4 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -236,6 +236,11 @@ struct binder_frozen_status_info {
>  	__u32            async_recv;
>  };
>  
> +struct binder_frozen_state_info {
> +	binder_uintptr_t cookie;
> +	__u32            is_frozen;
> +};
> +
>  /* struct binder_extened_error - extended error information
>   * @id:		identifier for the failed operation
>   * @command:	command as defined by binder_driver_return_protocol
> @@ -467,6 +472,17 @@ enum binder_driver_return_protocol {
>  	/*
>  	 * The target of the last async transaction is frozen.  No parameters.
>  	 */
> +
> +	BR_FROZEN_BINDER = _IOR('r', 21, struct binder_frozen_state_info),
> +	/*
> +	 * The cookie and a boolean (is_frozen) that indicates whether the process
> +	 * transitioned into a frozen or an unfrozen state.
> +	 */
> +
> +	BR_CLEAR_FREEZE_NOTIFICATION_DONE = _IOR('r', 22, binder_uintptr_t),
> +	/*
> +	 * void *: cookie
> +	 */
>  };
>  
>  enum binder_driver_command_protocol {
> @@ -550,6 +566,25 @@ enum binder_driver_command_protocol {
>  	/*
>  	 * binder_transaction_data_sg: the sent command.
>  	 */
> +
> +	BC_REQUEST_FREEZE_NOTIFICATION =
> +			_IOW('c', 19, struct binder_handle_cookie),
> +	/*
> +	 * int: handle
> +	 * void *: cookie
> +	 */
> +
> +	BC_CLEAR_FREEZE_NOTIFICATION = _IOW('c', 20,
> +					    struct binder_handle_cookie),
> +	/*
> +	 * int: handle
> +	 * void *: cookie
> +	 */
> +
> +	BC_FREEZE_NOTIFICATION_DONE = _IOW('c', 21, binder_uintptr_t),
> +	/*
> +	 * void *: cookie
> +	 */
>  };
>  
>  #endif /* _UAPI_LINUX_BINDER_H */
> -- 
> 2.45.2.741.gdbec12cfda-goog
> 

