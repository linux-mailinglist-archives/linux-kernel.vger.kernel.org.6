Return-Path: <linux-kernel+bounces-239979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A781926783
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D279CB21038
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFA01850AE;
	Wed,  3 Jul 2024 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axgjzbk4"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F918308A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029543; cv=none; b=PuEC2FyTutSzp49a7JuBxABX/yL1epEahoiz4bARsnHOPkzc27R66Ofgn5PDzP+XqDPwojjAglj89gPiBRRqxHr8dLHBz7cMLv7qCjrxuzuk5lKGs/Ca1TJkYnP4XLdMBbtbqy2pxHRjhcFH8UF5O7IETpI+JB9m/V4IQb+zpVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029543; c=relaxed/simple;
	bh=HHAG2qOcPL+JHeuyCqYtU5QkLZv3Ywq4WWJJhjqkqNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QW20qMnWgCz521Cm5Eo/+amWEurylIBeCgdXgnFahFwq+4F+9PuDoNY36MFKIa4EJI+jelMn8wI4GDC3tNdpXxxbl2v3pMHLAuIG8FMJo3YnpkzmOgrJYvrGKI6XIi0Iy5nPjWoSJMa10nt/ju4Kt9cmgOVJR/EVokli5UJiViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=axgjzbk4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7276c2399daso791496a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720029541; x=1720634341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ju3si/L5Uja2tjGsaYE5VFt4AaJmgIoYfcZmmXtJt94=;
        b=axgjzbk4diwnGqCIr2vCae8SaedNLKi4vDT5FUbnDRqDNT5TfkEGDRUWcBlGyTiHTp
         AlxcCVna/bXQFLO+TN2CIFYWwabqX7UxGtJ9nvVpoC3JxXtwggkjGvpA56iQ7lhnpTTG
         CfP5e70123L2p/k1mX7LFOXKEzKiF266L53GhkQ1VxZMbVq334MpZg+bN2BHYFi7KarK
         Aq1O62s2BcYoNHkTeQ9sRC+4fQ4xvcXKovGf4geAsJdoVmL3ZHZcuH4b5ZNsqlwGc0DS
         pLXYvO/0hURd/oPVQkI+VIPLf/y2+knrELmoKM9mPNERzZCX+XbHwD84VxFc3o6+b6Eq
         aOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029541; x=1720634341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ju3si/L5Uja2tjGsaYE5VFt4AaJmgIoYfcZmmXtJt94=;
        b=MF54Ez4BK4dUerHfWNLcOf/CP0NrzmSaRo5Qt9GgFa9WIZHrOvkIAc61im16D3ribs
         Fvuna9EWhoVnrewA7p82bPX3ZfAgnPVhyqhzn+B4fVCqjH6wNirse2o/aBBpBPvEwrD9
         P4npeIqmmFQNzAiUjGVhqxAS5cWQR98j376G3dDIVZBFkMNTTPn/FpQn8IZF9HSMcUHi
         yYTMB/apSNOq4yhLc3GCh1HXSc7Wwr11JogKCsREk3ofvjTxK4wVyc4mQCofKVk5MFWa
         VQNhgtcH8IpZtS+A8irWGbRkXFZRKWBxHDNAa4fcUuWA4jMemk40tBZ2dBI/gSfarl4C
         4riw==
X-Forwarded-Encrypted: i=1; AJvYcCWRL+GiGYxyC18uh9VBPq64NK0BzKCjF3l9ReRNoYMsuQT6YsdBHFdAX5PgiTSX2t00i6bnSw5RsqKk/sxo8RM6KGwGHnu+d5fsaesC
X-Gm-Message-State: AOJu0Yw/BaiZi/hLp+YeG2+ReiTPn+RfE/xGrkH69CzXXOAH9d033bE2
	7tJcmnaBy/MZiJUJPNzp7HadqmdshbMqerEPO8j7f9JaQtMnzoV+6dJBPlAz4xwHpeze+grbkhW
	6DjrL08V9sD6tjypICZQpVw==
X-Google-Smtp-Source: AGHT+IGjUugkVEeQMGkvM3hRZWY4v+Y4HnMsJODm5zzhMlgZEueD85Li/d+xUFy28jwl+5eX8f0h/FuY5/yCky4NAw==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a17:90a:d998:b0:2c8:e0c3:88c7 with
 SMTP id 98e67ed59e1d1-2c97ad8ce2amr11926a91.3.1720029540760; Wed, 03 Jul 2024
 10:59:00 -0700 (PDT)
Date: Wed,  3 Jul 2024 10:58:44 -0700
In-Reply-To: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703175843.3639568-4-yutingtseng@google.com>
Subject: [PATCH v6 1/2] binder: frozen notification
From: Yu-Ting Tseng <yutingtseng@google.com>
To: cmllamas@google.com, tkjos@google.com, gregkh@linuxfoundation.org
Cc: arve@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, aliceryhl@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Yu-Ting Tseng <yutingtseng@google.com>
Content-Type: text/plain; charset="UTF-8"

Frozen processes present a significant challenge in binder transactions.
When a process is frozen, it cannot, by design, accept and/or respond to
binder transactions. As a result, the sender needs to adjust its
behavior, such as postponing transactions until the peer process
unfreezes. However, there is currently no way to subscribe to these
state change events, making it impossible to implement frozen-aware
behaviors efficiently.

Introduce a binder API for subscribing to frozen state change events.
This allows programs to react to changes in peer process state,
mitigating issues related to binder transactions sent to frozen
processes.

Implementation details:
For a given binder_ref, the state of frozen notification can be one of
the followings:
1. Userspace doesn't want a notification. binder_ref->freeze is null.
2. Userspace wants a notification but none is in flight.
   list_empty(&binder_ref->freeze->work.entry) = true
3. A notification is in flight and waiting to be read by userspace.
   binder_ref_freeze.sent is false.
4. A notification was read by userspace and kernel is waiting for an ack.
   binder_ref_freeze.sent is true.

When a notification is in flight, new state change events are coalesced into
the existing binder_ref_freeze struct. If userspace hasn't picked up the
notification yet, the driver simply rewrites the state. Otherwise, the
notification is flagged as requiring a resend, which will be performed
once userspace acks the original notification that's inflight.

See https://r.android.com/3070045 for how userspace is going to use this
feature.

Signed-off-by: Yu-Ting Tseng <yutingtseng@google.com>
---
 drivers/android/binder.c            | 284 +++++++++++++++++++++++++++-
 drivers/android/binder_internal.h   |  21 +-
 include/uapi/linux/android/binder.h |  36 ++++
 3 files changed, 337 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b21a7b246a0d..77f318127a6e 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1295,6 +1295,7 @@ static void binder_free_ref(struct binder_ref *ref)
 	if (ref->node)
 		binder_free_node(ref->node);
 	kfree(ref->death);
+	kfree(ref->freeze);
 	kfree(ref);
 }
 
@@ -3763,6 +3764,155 @@ static void binder_transaction(struct binder_proc *proc,
 	}
 }
 
+static int
+binder_request_freeze_notification(struct binder_proc *proc,
+				   struct binder_thread *thread,
+				   struct binder_handle_cookie *handle_cookie)
+{
+	struct binder_ref_freeze *freeze;
+	struct binder_ref *ref;
+	bool is_frozen;
+
+	freeze = kzalloc(sizeof(*freeze), GFP_KERNEL);
+	if (!freeze)
+		return -ENOMEM;
+	binder_proc_lock(proc);
+	ref = binder_get_ref_olocked(proc, handle_cookie->handle, false);
+	if (!ref) {
+		binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATION invalid ref %d\n",
+				  proc->pid, thread->pid, handle_cookie->handle);
+		binder_proc_unlock(proc);
+		kfree(freeze);
+		return -EINVAL;
+	}
+
+	binder_node_lock(ref->node);
+
+	if (ref->freeze || !ref->node->proc) {
+		binder_user_error("%d:%d invalid BC_REQUEST_FREEZE_NOTIFICATION %s\n",
+				  proc->pid, thread->pid,
+				  ref->freeze ? "already set" : "dead node");
+		binder_node_unlock(ref->node);
+		binder_proc_unlock(proc);
+		kfree(freeze);
+		return -EINVAL;
+	}
+	binder_inner_proc_lock(ref->node->proc);
+	is_frozen = ref->node->proc->is_frozen;
+	binder_inner_proc_unlock(ref->node->proc);
+
+	binder_stats_created(BINDER_STAT_FREEZE);
+	INIT_LIST_HEAD(&freeze->work.entry);
+	freeze->cookie = handle_cookie->cookie;
+	freeze->work.type = BINDER_WORK_FROZEN_BINDER;
+	freeze->is_frozen = is_frozen;
+
+	ref->freeze = freeze;
+
+	binder_inner_proc_lock(proc);
+	binder_enqueue_work_ilocked(&ref->freeze->work, &proc->todo);
+	binder_wakeup_proc_ilocked(proc);
+	binder_inner_proc_unlock(proc);
+
+	binder_node_unlock(ref->node);
+	binder_proc_unlock(proc);
+	return 0;
+}
+
+static int
+binder_clear_freeze_notification(struct binder_proc *proc,
+				 struct binder_thread *thread,
+				 struct binder_handle_cookie *handle_cookie)
+{
+	struct binder_ref_freeze *freeze;
+	struct binder_ref *ref;
+
+	binder_proc_lock(proc);
+	ref = binder_get_ref_olocked(proc, handle_cookie->handle, false);
+	if (!ref) {
+		binder_user_error("%d:%d BC_CLEAR_FREEZE_NOTIFICATION invalid ref %d\n",
+				  proc->pid, thread->pid, handle_cookie->handle);
+		binder_proc_unlock(proc);
+		return -EINVAL;
+	}
+
+	binder_node_lock(ref->node);
+
+	if (!ref->freeze) {
+		binder_user_error("%d:%d BC_CLEAR_FREEZE_NOTIFICATION freeze notification not active\n",
+				  proc->pid, thread->pid);
+		binder_node_unlock(ref->node);
+		binder_proc_unlock(proc);
+		return -EINVAL;
+	}
+	freeze = ref->freeze;
+	binder_inner_proc_lock(proc);
+	if (freeze->cookie != handle_cookie->cookie) {
+		binder_user_error("%d:%d BC_CLEAR_FREEZE_NOTIFICATION freeze notification cookie mismatch %016llx != %016llx\n",
+				  proc->pid, thread->pid, (u64)freeze->cookie,
+				  (u64)handle_cookie->cookie);
+		binder_inner_proc_unlock(proc);
+		binder_node_unlock(ref->node);
+		binder_proc_unlock(proc);
+		return -EINVAL;
+	}
+	ref->freeze = NULL;
+	/*
+	 * Take the existing freeze object and overwrite its work type. There are three cases here:
+	 * 1. No pending notification. In this case just add the work to the queue.
+	 * 2. A notification was sent and is pending an ack from userspace. Once an ack arrives, we
+	 *    should resend with the new work type.
+	 * 3. A notification is pending to be sent. Since the work is already in the queue, nothing
+	 *    needs to be done here.
+	 */
+	freeze->work.type = BINDER_WORK_CLEAR_FREEZE_NOTIFICATION;
+	if (list_empty(&freeze->work.entry)) {
+		binder_enqueue_work_ilocked(&freeze->work, &proc->todo);
+		binder_wakeup_proc_ilocked(proc);
+	} else if (freeze->sent) {
+		freeze->resend = true;
+	}
+	binder_inner_proc_unlock(proc);
+	binder_node_unlock(ref->node);
+	binder_proc_unlock(proc);
+	return 0;
+}
+
+static int
+binder_freeze_notification_done(struct binder_proc *proc,
+				struct binder_thread *thread,
+				binder_uintptr_t cookie)
+{
+	struct binder_ref_freeze *freeze = NULL;
+	struct binder_work *w;
+
+	binder_inner_proc_lock(proc);
+	list_for_each_entry(w, &proc->delivered_freeze, entry) {
+		struct binder_ref_freeze *tmp_freeze =
+			container_of(w, struct binder_ref_freeze, work);
+
+		if (tmp_freeze->cookie == cookie) {
+			freeze = tmp_freeze;
+			break;
+		}
+	}
+	if (!freeze) {
+		binder_user_error("%d:%d BC_FREEZE_NOTIFICATION_DONE %016llx not found\n",
+				  proc->pid, thread->pid, (u64)cookie);
+		binder_inner_proc_unlock(proc);
+		return -EINVAL;
+	}
+	binder_dequeue_work_ilocked(&freeze->work);
+	freeze->sent = false;
+	if (freeze->resend) {
+		freeze->resend = false;
+		binder_enqueue_work_ilocked(&freeze->work, &proc->todo);
+		binder_wakeup_proc_ilocked(proc);
+	}
+	binder_inner_proc_unlock(proc);
+	return 0;
+}
+
 /**
  * binder_free_buf() - free the specified buffer
  * @proc:	binder proc that owns buffer
@@ -4246,6 +4396,44 @@ static int binder_thread_write(struct binder_proc *proc,
 			binder_inner_proc_unlock(proc);
 		} break;
 
+		case BC_REQUEST_FREEZE_NOTIFICATION: {
+			struct binder_handle_cookie handle_cookie;
+			int error;
+
+			if (copy_from_user(&handle_cookie, ptr, sizeof(handle_cookie)))
+				return -EFAULT;
+			ptr += sizeof(handle_cookie);
+			error = binder_request_freeze_notification(proc, thread,
+								   &handle_cookie);
+			if (error)
+				return error;
+		} break;
+
+		case BC_CLEAR_FREEZE_NOTIFICATION: {
+			struct binder_handle_cookie handle_cookie;
+			int error;
+
+			if (copy_from_user(&handle_cookie, ptr, sizeof(handle_cookie)))
+				return -EFAULT;
+			ptr += sizeof(handle_cookie);
+			error = binder_clear_freeze_notification(proc, thread, &handle_cookie);
+			if (error)
+				return error;
+		} break;
+
+		case BC_FREEZE_NOTIFICATION_DONE: {
+			binder_uintptr_t cookie;
+			int error;
+
+			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
+				return -EFAULT;
+
+			ptr += sizeof(cookie);
+			error = binder_freeze_notification_done(proc, thread, cookie);
+			if (error)
+				return error;
+		} break;
+
 		default:
 			pr_err("%d:%d unknown command %u\n",
 			       proc->pid, thread->pid, cmd);
@@ -4635,6 +4823,46 @@ static int binder_thread_read(struct binder_proc *proc,
 			if (cmd == BR_DEAD_BINDER)
 				goto done; /* DEAD_BINDER notifications can cause transactions */
 		} break;
+
+		case BINDER_WORK_FROZEN_BINDER: {
+			struct binder_ref_freeze *freeze;
+			struct binder_frozen_state_info info;
+
+			memset(&info, 0, sizeof(info));
+			freeze = container_of(w, struct binder_ref_freeze, work);
+			info.is_frozen = freeze->is_frozen;
+			info.cookie = freeze->cookie;
+			freeze->sent = true;
+			binder_enqueue_work_ilocked(w, &proc->delivered_freeze);
+			binder_inner_proc_unlock(proc);
+
+			if (put_user(BR_FROZEN_BINDER, (uint32_t __user *)ptr))
+				return -EFAULT;
+			ptr += sizeof(uint32_t);
+			if (copy_to_user(ptr, &info, sizeof(info)))
+				return -EFAULT;
+			ptr += sizeof(info);
+			binder_stat_br(proc, thread, BR_FROZEN_BINDER);
+			goto done; /* BR_FROZEN_BINDER notifications can cause transactions */
+		} break;
+
+		case BINDER_WORK_CLEAR_FREEZE_NOTIFICATION: {
+			struct binder_ref_freeze *freeze =
+			    container_of(w, struct binder_ref_freeze, work);
+			binder_uintptr_t cookie = freeze->cookie;
+
+			binder_inner_proc_unlock(proc);
+			kfree(freeze);
+			binder_stats_deleted(BINDER_STAT_FREEZE);
+			if (put_user(BR_CLEAR_FREEZE_NOTIFICATION_DONE, (uint32_t __user *)ptr))
+				return -EFAULT;
+			ptr += sizeof(uint32_t);
+			if (put_user(cookie, (binder_uintptr_t __user *)ptr))
+				return -EFAULT;
+			ptr += sizeof(binder_uintptr_t);
+			binder_stat_br(proc, thread, BR_CLEAR_FREEZE_NOTIFICATION_DONE);
+		} break;
+
 		default:
 			binder_inner_proc_unlock(proc);
 			pr_err("%d:%d: bad work type %d\n",
@@ -5242,6 +5470,48 @@ static bool binder_txns_pending_ilocked(struct binder_proc *proc)
 	return false;
 }
 
+static void binder_add_freeze_work(struct binder_proc *proc, bool is_frozen)
+{
+	struct rb_node *n;
+	struct binder_ref *ref;
+
+	binder_inner_proc_lock(proc);
+	for (n = rb_first(&proc->nodes); n; n = rb_next(n)) {
+		struct binder_node *node;
+
+		node = rb_entry(n, struct binder_node, rb_node);
+		binder_inner_proc_unlock(proc);
+		binder_node_lock(node);
+		hlist_for_each_entry(ref, &node->refs, node_entry) {
+			/*
+			 * Need the node lock to synchronize
+			 * with new notification requests and the
+			 * inner lock to synchronize with queued
+			 * freeze notifications.
+			 */
+			binder_inner_proc_lock(ref->proc);
+			if (!ref->freeze) {
+				binder_inner_proc_unlock(ref->proc);
+				continue;
+			}
+			ref->freeze->work.type = BINDER_WORK_FROZEN_BINDER;
+			if (list_empty(&ref->freeze->work.entry)) {
+				ref->freeze->is_frozen = is_frozen;
+				binder_enqueue_work_ilocked(&ref->freeze->work, &ref->proc->todo);
+				binder_wakeup_proc_ilocked(ref->proc);
+			} else {
+				if (ref->freeze->sent && ref->freeze->is_frozen != is_frozen)
+					ref->freeze->resend = true;
+				ref->freeze->is_frozen = is_frozen;
+			}
+			binder_inner_proc_unlock(ref->proc);
+		}
+		binder_node_unlock(node);
+		binder_inner_proc_lock(proc);
+	}
+	binder_inner_proc_unlock(proc);
+}
+
 static int binder_ioctl_freeze(struct binder_freeze_info *info,
 			       struct binder_proc *target_proc)
 {
@@ -5253,6 +5523,7 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
 		target_proc->async_recv = false;
 		target_proc->is_frozen = false;
 		binder_inner_proc_unlock(target_proc);
+		binder_add_freeze_work(target_proc, false);
 		return 0;
 	}
 
@@ -5285,6 +5556,8 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
 		binder_inner_proc_lock(target_proc);
 		target_proc->is_frozen = false;
 		binder_inner_proc_unlock(target_proc);
+	} else {
+		binder_add_freeze_work(target_proc, true);
 	}
 
 	return ret;
@@ -5658,6 +5931,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	binder_stats_created(BINDER_STAT_PROC);
 	proc->pid = current->group_leader->pid;
 	INIT_LIST_HEAD(&proc->delivered_death);
+	INIT_LIST_HEAD(&proc->delivered_freeze);
 	INIT_LIST_HEAD(&proc->waiting_threads);
 	filp->private_data = proc;
 
@@ -6209,7 +6483,9 @@ static const char * const binder_return_strings[] = {
 	"BR_FAILED_REPLY",
 	"BR_FROZEN_REPLY",
 	"BR_ONEWAY_SPAM_SUSPECT",
-	"BR_TRANSACTION_PENDING_FROZEN"
+	"BR_TRANSACTION_PENDING_FROZEN",
+	"BR_FROZEN_BINDER",
+	"BR_CLEAR_FREEZE_NOTIFICATION_DONE",
 };
 
 static const char * const binder_command_strings[] = {
@@ -6232,6 +6508,9 @@ static const char * const binder_command_strings[] = {
 	"BC_DEAD_BINDER_DONE",
 	"BC_TRANSACTION_SG",
 	"BC_REPLY_SG",
+	"BC_REQUEST_FREEZE_NOTIFICATION",
+	"BC_CLEAR_FREEZE_NOTIFICATION",
+	"BC_FREEZE_NOTIFICATION_DONE",
 };
 
 static const char * const binder_objstat_strings[] = {
@@ -6241,7 +6520,8 @@ static const char * const binder_objstat_strings[] = {
 	"ref",
 	"death",
 	"transaction",
-	"transaction_complete"
+	"transaction_complete",
+	"freeze",
 };
 
 static void print_binder_stats(struct seq_file *m, const char *prefix,
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 5b7c80b99ae8..3e4b35873c64 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -129,12 +129,13 @@ enum binder_stat_types {
 	BINDER_STAT_DEATH,
 	BINDER_STAT_TRANSACTION,
 	BINDER_STAT_TRANSACTION_COMPLETE,
+	BINDER_STAT_FREEZE,
 	BINDER_STAT_COUNT
 };
 
 struct binder_stats {
-	atomic_t br[_IOC_NR(BR_TRANSACTION_PENDING_FROZEN) + 1];
-	atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
+	atomic_t br[_IOC_NR(BR_CLEAR_FREEZE_NOTIFICATION_DONE) + 1];
+	atomic_t bc[_IOC_NR(BC_FREEZE_NOTIFICATION_DONE) + 1];
 	atomic_t obj_created[BINDER_STAT_COUNT];
 	atomic_t obj_deleted[BINDER_STAT_COUNT];
 };
@@ -159,6 +160,8 @@ struct binder_work {
 		BINDER_WORK_DEAD_BINDER,
 		BINDER_WORK_DEAD_BINDER_AND_CLEAR,
 		BINDER_WORK_CLEAR_DEATH_NOTIFICATION,
+		BINDER_WORK_FROZEN_BINDER,
+		BINDER_WORK_CLEAR_FREEZE_NOTIFICATION,
 	} type;
 };
 
@@ -275,6 +278,14 @@ struct binder_ref_death {
 	binder_uintptr_t cookie;
 };
 
+struct binder_ref_freeze {
+	struct binder_work work;
+	binder_uintptr_t cookie;
+	bool is_frozen:1;
+	bool sent:1;
+	bool resend:1;
+};
+
 /**
  * struct binder_ref_data - binder_ref counts and id
  * @debug_id:        unique ID for the ref
@@ -307,6 +318,8 @@ struct binder_ref_data {
  *               @node indicates the node must be freed
  * @death:       pointer to death notification (ref_death) if requested
  *               (protected by @node->lock)
+ * @freeze:      pointer to freeze notification (ref_freeze) if requested
+ *               (protected by @node->lock)
  *
  * Structure to track references from procA to target node (on procB). This
  * structure is unsafe to access without holding @proc->outer_lock.
@@ -323,6 +336,7 @@ struct binder_ref {
 	struct binder_proc *proc;
 	struct binder_node *node;
 	struct binder_ref_death *death;
+	struct binder_ref_freeze *freeze;
 };
 
 /**
@@ -374,6 +388,8 @@ struct binder_ref {
  *                        (atomics, no lock needed)
  * @delivered_death:      list of delivered death notification
  *                        (protected by @inner_lock)
+ * @delivered_freeze:     list of delivered freeze notification
+ *                        (protected by @inner_lock)
  * @max_threads:          cap on number of binder threads
  *                        (protected by @inner_lock)
  * @requested_threads:    number of binder threads requested but not
@@ -421,6 +437,7 @@ struct binder_proc {
 	struct list_head todo;
 	struct binder_stats stats;
 	struct list_head delivered_death;
+	struct list_head delivered_freeze;
 	u32 max_threads;
 	int requested_threads;
 	int requested_threads_started;
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index d44a8118b2ed..1fd92021a573 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -236,6 +236,12 @@ struct binder_frozen_status_info {
 	__u32            async_recv;
 };
 
+struct binder_frozen_state_info {
+	binder_uintptr_t cookie;
+	__u32            is_frozen;
+	__u32            reserved;
+};
+
 /* struct binder_extened_error - extended error information
  * @id:		identifier for the failed operation
  * @command:	command as defined by binder_driver_return_protocol
@@ -467,6 +473,17 @@ enum binder_driver_return_protocol {
 	/*
 	 * The target of the last async transaction is frozen.  No parameters.
 	 */
+
+	BR_FROZEN_BINDER = _IOR('r', 21, struct binder_frozen_state_info),
+	/*
+	 * The cookie and a boolean (is_frozen) that indicates whether the process
+	 * transitioned into a frozen or an unfrozen state.
+	 */
+
+	BR_CLEAR_FREEZE_NOTIFICATION_DONE = _IOR('r', 22, binder_uintptr_t),
+	/*
+	 * void *: cookie
+	 */
 };
 
 enum binder_driver_command_protocol {
@@ -550,6 +567,25 @@ enum binder_driver_command_protocol {
 	/*
 	 * binder_transaction_data_sg: the sent command.
 	 */
+
+	BC_REQUEST_FREEZE_NOTIFICATION =
+			_IOW('c', 19, struct binder_handle_cookie),
+	/*
+	 * int: handle
+	 * void *: cookie
+	 */
+
+	BC_CLEAR_FREEZE_NOTIFICATION = _IOW('c', 20,
+					    struct binder_handle_cookie),
+	/*
+	 * int: handle
+	 * void *: cookie
+	 */
+
+	BC_FREEZE_NOTIFICATION_DONE = _IOW('c', 21, binder_uintptr_t),
+	/*
+	 * void *: cookie
+	 */
 };
 
 #endif /* _UAPI_LINUX_BINDER_H */
-- 
2.45.2.803.g4e1b14247a-goog


