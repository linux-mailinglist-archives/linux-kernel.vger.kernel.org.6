Return-Path: <linux-kernel+bounces-238853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA0C925248
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF750B2C597
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B8345025;
	Wed,  3 Jul 2024 04:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQZ/Hld0"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A23BBEA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980303; cv=none; b=k5UeAY6bRC6rub1dOKFImZqbdUiBoSGXjDyAiSW14UIbqN49tN0P9pz4HLM8ZPSBf+Pno5srvZ4vZVc8IecNJ1SVdCqyt9F7QNLyi+KQQv1HJHVD8VJjpIBmboglgQEGf5g8AIjeEiW0kP+41SpYZF6lpksUNVsaa9OPzzSuIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980303; c=relaxed/simple;
	bh=oUlIOQMkF33vgNmKQnp6J7ZvT9tZEtKDUm0TixzE3xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1VTWjrjm+vWIl6UTqRia2/sLCWWlBnXa4GrOMMnSvstLL8OY1XJCKsc9VAQ90ODtrDFq3CaPYZf5Q913bqNW++poLWYFnT8vWfKlRPk+18k3kIp/8g0BmOd+dzYcEDTncgzJW9SmQI7f1ugr48zJW0yPdXo2kp0XcXkxGUzXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQZ/Hld0; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c9b94951cfso2873655b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 21:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719980290; x=1720585090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28M9ThWSCL3YxnCK1P21FDGnMSWsih4l72U00UK/3uA=;
        b=XQZ/Hld0FaNSTrZ/yQbXLzfTYp1Yx7pQpsQXY+T65jgqscV1gKw8IGGhGQDf2n3J5q
         dBSVcRWIUmpJwjumwujDqJ58PNoLVaqqAGrWdcQ5qHe5mh8gODfzbFyVPBY+Ez8ozdaK
         UABdAnv95XQNJCKpMBDwWaL2MHvCctq7bcXJC75sK48QTx36f9iSxsmaiS4Kw8bB80T/
         09Gm7EM8kWm6tWg4xMERxcRMZysxrgsA8xSTOYpbsAXcmn79s1OWOBPBjAE+6rsG7V07
         vbo+ok0Xi2PQ+8uozxic7+jux9BKkIDew0xqNaAsAkq++4ktlE0fb4npZ5owd+crO/uk
         /RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719980290; x=1720585090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28M9ThWSCL3YxnCK1P21FDGnMSWsih4l72U00UK/3uA=;
        b=o+hnFh3H9ySIaOhjpkHRby/6x/G2ZSF4Fzkeooix/sqFwkRQ8HVMmsARl7QjPJtP3W
         gzk+EkHoK+3rG4xeovlzaB9BrCtC2tE+u/ssAQjLZ87HSpo6Jtv73d1J2EHLBEZ9V2r+
         feYeJKYEpjSxIZ55hUef4s/unB+TGWSofHYbTI/JyYjDAOws/+j7kKDscjLQwM13X3+q
         KgVO6nhutN4fhhVTzASydBoPd7y+YqVeDEBZ7eIpbdv1ZFKGMxPXPlbbGsbKur0TQl+x
         s1hBN/E6Ub+yWXFx2WIgfH6zSsY11h/4P+LKnax2rbU5megFe8SBc0O7XLNGd5tzUxw6
         qNAg==
X-Forwarded-Encrypted: i=1; AJvYcCX5JsUZdzRYHn2AYWInieJolcjcPoebYyiYJBcSIJhYAA12zRkjN5+T2/hEdR4osgm6sB1lSuOoJlVW/34I2wTTk70HQmi9sIXcqs1W
X-Gm-Message-State: AOJu0YzBBtOFOVd1KgLxiA04QbAUG4s+zkUm6RX5D9cvYCcWZRVBx65+
	SsQR+hYsae46+0F9YETb96PowkPItgjRxUUsf8BXAP9wteDwXDcIGGDrdMY1fA==
X-Google-Smtp-Source: AGHT+IFu+LMtIyMModmUw4d7bvpPvkGgS1O8NReoRxrXGWufCIqW8GknwZOfWwhJLAN8Wpag7nlzdg==
X-Received: by 2002:a05:6808:2383:b0:3d6:2b12:7dc0 with SMTP id 5614622812f47-3d6b30f5275mr13331340b6e.20.1719980290144;
        Tue, 02 Jul 2024 21:18:10 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e53acfsm9369034b3a.30.2024.07.02.21.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 21:18:09 -0700 (PDT)
Date: Wed, 3 Jul 2024 04:18:04 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Yu-Ting Tseng <yutingtseng@google.com>
Cc: tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, aliceryhl@google.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] binder: frozen notification
Message-ID: <ZoTQ_AbeboWGalZY@google.com>
References: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
 <20240701182731.1003031-3-yutingtseng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701182731.1003031-3-yutingtseng@google.com>

On Mon, Jul 01, 2024 at 11:27:33AM -0700, Yu-Ting Tseng wrote:
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
> See https://r.android.com/3070045 for how userspace is going to use this
> feature.
> 
> Signed-off-by: Yu-Ting Tseng <yutingtseng@google.com>
> ---
>  drivers/android/binder.c            | 287 +++++++++++++++++++++++++++-
>  drivers/android/binder_internal.h   |  21 +-
>  include/uapi/linux/android/binder.h |  36 ++++
>  3 files changed, 340 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index b21a7b246a0d..e1bd9810c2af 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3763,6 +3763,159 @@ static void binder_transaction(struct binder_proc *proc,
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
> +	bool is_frozen;
> +
> +	freeze = kzalloc(sizeof(*freeze), GFP_KERNEL);
> +	if (!freeze)
> +		return -ENOMEM;
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
> +			binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATION process is already dead\n",
> +					  proc->pid, thread->pid);
> +		}

nit: can you merge the branches into a single printk? maybe something
like the following:

	binder_user_error("%d:%d invalid BC_REQUEST_FREEZE_NOTIFICATION %s\n",
			  proc->pid, thread->pid,
			  ref->freeze ? "already set" : "dead node");


> +		binder_node_unlock(ref->node);
> +		binder_proc_unlock(proc);
> +		kfree(freeze);
> +		return -EINVAL;
> +	}
> +	binder_inner_proc_lock(ref->node->proc);
> +	is_frozen = ref->node->proc->is_frozen;
> +	binder_inner_proc_unlock(ref->node->proc);
> +
> +	binder_stats_created(BINDER_STAT_FREEZE);
> +	INIT_LIST_HEAD(&freeze->work.entry);
> +	freeze->cookie = handle_cookie->cookie;
> +	freeze->work.type = BINDER_WORK_FROZEN_BINDER;
> +	freeze->is_frozen = ref->node->proc->is_frozen;

I believe you meant to use the 'is_frozen' here. Otherwise it doesn't
seem to be used after assignment.

> +
> +	ref->freeze = freeze;
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
> +	binder_inner_proc_lock(proc);
> +	if (freeze->cookie != handle_cookie->cookie) {
> +		binder_user_error("%d:%d BC_CLEAR_FREEZE_NOTIFICATION freeze notification cookie mismatch %016llx != %016llx\n",
> +				  proc->pid, thread->pid, (u64)freeze->cookie,
> +				  (u64)handle_cookie->cookie);
> +		binder_inner_proc_unlock(proc);
> +		binder_node_unlock(ref->node);
> +		binder_proc_unlock(proc);
> +		return -EINVAL;
> +	}
> +	ref->freeze = NULL;

You detach ref->freeze here and handle the kfree(freeze) later which
seems good. However, what happens when a reference is released with an
active ref->freeze? It seems to me this is a memory leak. This could
accumulate significantly as more references get dropped in thit way.

I think you want to add a kfree(ref->freeze) to binder_free_ref().


> +	/*
> +	 * Take the existing freeze object and overwrite its work type. There are three cases here:
> +	 * 1. No pending notification. In this case just add the work to the queue.
> +	 * 2. An notification was sent and is pending an ack from userspace. Once an ack arrives, we

Typo s/An/A/

> +	 *    should resend with the new work type.
> +	 * 3. A notification is pending to be sent. Since the work is already in the queue, nothing
> +	 *    needs to be done here.
> +	 */
> +	freeze->work.type = BINDER_WORK_CLEAR_FREEZE_NOTIFICATION;
> +	if (list_empty(&freeze->work.entry)) {
> +		binder_enqueue_work_ilocked(&freeze->work, &proc->todo);
> +		binder_wakeup_proc_ilocked(proc);
> +	} else if (freeze->sent) {
> +		freeze->resend = true;
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
> +		binder_enqueue_work_ilocked(&freeze->work, &proc->todo);
> +		binder_wakeup_proc_ilocked(proc);
> +	}
> +	binder_inner_proc_unlock(proc);
> +	return 0;
> +}
> +
>  /**
>   * binder_free_buf() - free the specified buffer
>   * @proc:	binder proc that owns buffer
> @@ -4246,6 +4399,44 @@ static int binder_thread_write(struct binder_proc *proc,
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
> @@ -4635,6 +4826,46 @@ static int binder_thread_read(struct binder_proc *proc,
>  			if (cmd == BR_DEAD_BINDER)
>  				goto done; /* DEAD_BINDER notifications can cause transactions */
>  		} break;
> +
> +		case BINDER_WORK_FROZEN_BINDER: {
> +			struct binder_ref_freeze *freeze;
> +			struct binder_frozen_state_info info;
> +			memset(&info, 0, sizeof(info));

The memset should have a blank line after the declarations. This should
trigger a checkpatch issue I think.

> +
> +			freeze = container_of(w, struct binder_ref_freeze, work);
> +			info.is_frozen = freeze->is_frozen;
> +			info.cookie = freeze->cookie;
> +			freeze->sent = true;
> +			binder_enqueue_work_ilocked(w, &proc->delivered_freeze);
> +			binder_inner_proc_unlock(proc);
> +
> +			if (put_user(BR_FROZEN_BINDER, (uint32_t __user *)ptr))
> +				return -EFAULT;
> +			ptr += sizeof(uint32_t);
> +			if (copy_to_user(ptr, &info, sizeof(info)))
> +				return -EFAULT;
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
> @@ -5242,6 +5473,48 @@ static bool binder_txns_pending_ilocked(struct binder_proc *proc)
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
> @@ -5253,6 +5526,7 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
>  		target_proc->async_recv = false;
>  		target_proc->is_frozen = false;
>  		binder_inner_proc_unlock(target_proc);
> +		binder_add_freeze_work(target_proc, false);
>  		return 0;
>  	}
>  
> @@ -5285,6 +5559,8 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
>  		binder_inner_proc_lock(target_proc);
>  		target_proc->is_frozen = false;
>  		binder_inner_proc_unlock(target_proc);
> +	} else {
> +		binder_add_freeze_work(target_proc, true);
>  	}
>  
>  	return ret;
> @@ -5658,6 +5934,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
>  	binder_stats_created(BINDER_STAT_PROC);
>  	proc->pid = current->group_leader->pid;
>  	INIT_LIST_HEAD(&proc->delivered_death);
> +	INIT_LIST_HEAD(&proc->delivered_freeze);
>  	INIT_LIST_HEAD(&proc->waiting_threads);
>  	filp->private_data = proc;
>  
> @@ -6209,7 +6486,9 @@ static const char * const binder_return_strings[] = {
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
> @@ -6232,6 +6511,9 @@ static const char * const binder_command_strings[] = {
>  	"BC_DEAD_BINDER_DONE",
>  	"BC_TRANSACTION_SG",
>  	"BC_REPLY_SG",
> +	"BC_REQUEST_FREEZE_NOTIFICATION",
> +	"BC_CLEAR_FREEZE_NOTIFICATION",
> +	"BC_FREEZE_NOTIFICATION_DONE",
>  };
>  
>  static const char * const binder_objstat_strings[] = {
> @@ -6241,7 +6523,8 @@ static const char * const binder_objstat_strings[] = {
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
> index 5b7c80b99ae8..3e4b35873c64 100644
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
> @@ -275,6 +278,14 @@ struct binder_ref_death {
>  	binder_uintptr_t cookie;
>  };
>  
> +struct binder_ref_freeze {
> +	struct binder_work work;
> +	binder_uintptr_t cookie;
> +	bool is_frozen:1;
> +	bool sent:1;
> +	bool resend:1;
> +};
> +
>  /**
>   * struct binder_ref_data - binder_ref counts and id
>   * @debug_id:        unique ID for the ref
> @@ -307,6 +318,8 @@ struct binder_ref_data {
>   *               @node indicates the node must be freed
>   * @death:       pointer to death notification (ref_death) if requested
>   *               (protected by @node->lock)
> + * @freeze:      pointer to freeze notification (ref_freeze) if requested
> + *               (protected by @node->lock)
>   *
>   * Structure to track references from procA to target node (on procB). This
>   * structure is unsafe to access without holding @proc->outer_lock.
> @@ -323,6 +336,7 @@ struct binder_ref {
>  	struct binder_proc *proc;
>  	struct binder_node *node;
>  	struct binder_ref_death *death;
> +	struct binder_ref_freeze *freeze;
>  };
>  
>  /**
> @@ -374,6 +388,8 @@ struct binder_ref {
>   *                        (atomics, no lock needed)
>   * @delivered_death:      list of delivered death notification
>   *                        (protected by @inner_lock)
> + * @delivered_freeze:     list of delivered freeze notification
> + *                        (protected by @inner_lock)
>   * @max_threads:          cap on number of binder threads
>   *                        (protected by @inner_lock)
>   * @requested_threads:    number of binder threads requested but not
> @@ -421,6 +437,7 @@ struct binder_proc {
>  	struct list_head todo;
>  	struct binder_stats stats;
>  	struct list_head delivered_death;
> +	struct list_head delivered_freeze;
>  	u32 max_threads;
>  	int requested_threads;
>  	int requested_threads_started;
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> index d44a8118b2ed..1fd92021a573 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -236,6 +236,12 @@ struct binder_frozen_status_info {
>  	__u32            async_recv;
>  };
>  
> +struct binder_frozen_state_info {
> +	binder_uintptr_t cookie;
> +	__u32            is_frozen;
> +	__u32            reserved;
> +};
> +
>  /* struct binder_extened_error - extended error information
>   * @id:		identifier for the failed operation
>   * @command:	command as defined by binder_driver_return_protocol
> @@ -467,6 +473,17 @@ enum binder_driver_return_protocol {
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
> @@ -550,6 +567,25 @@ enum binder_driver_command_protocol {
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
> 2.45.2.803.g4e1b14247a-goog
> 

