Return-Path: <linux-kernel+bounces-220286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DB890DF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 00:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42442281B77
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC2C17B41B;
	Tue, 18 Jun 2024 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJvw3BmQ"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3F55E58
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718749171; cv=none; b=SlEGi4DkL8Y0nmYFXWKMPZYNX6bNbXaheAA2nEDB4Xtweif7ebRN0ZGRX2R8sllBKFVjep8PNwlxvt0L+TblK9l/X2Ejhax3OjyBjyFsSAJghAR8mbeFLa6Oq8c7sNSbgOW9WRWYTOXLu15tFBdm/U0xTI+5xVTTTd/J1iXANHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718749171; c=relaxed/simple;
	bh=hAdBO/yivWTDHBOWCVPozJU4CsUEzoyFjQPBlAOUVNI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O7SlvfTPUim8HtsKmPOm/neic0L01VZK14VFusNhetgiF0AAH1cFd5tRC27zBmXQU1VYmU2IAAFJkcsGYdb1Q4sfM+oyHxZCyocEyTbJVBZ88Q4D3iks7XyxPJtY3hcs64jqqDNG59xUvUths5IyjJx8O2bg0mhtBj0jWGw7u70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJvw3BmQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7043a7741cfso5851745b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718749169; x=1719353969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kcjq+ykdAqJfPjykbJOTmi99xVf3mt3DhgPiBGFYMPE=;
        b=TJvw3BmQ15NK90lpw2NBpXNGB8ZaczqfqIwYDXZeS7zsTR6BaUJw6yJwpzCTVl0oCV
         mC80SiN+nPLB4JT/ZUxRmPkmmRxV9y2DBKxf2mBPk7TFn03m/aH+x1N2fyqygjJVnAoj
         NxBcGy8CljCWfIkqkL6djW0aMN3jpauLMqysbAgpf2xjpwD7q0rXLaFmCjpoRFZq2URr
         OcsKcIVkgew32JuAu221GD/k0nmXM7mWtRcEwQSXJH+yYRGOaG/d+EqNYXXJOFGJQP/S
         aIjGDV3AV8CH2o+KtcYe3p35pho+q2dA1kmyee+VlbDhiE9mdyMV9IK0EflmC4bzfSdg
         ifZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718749169; x=1719353969;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kcjq+ykdAqJfPjykbJOTmi99xVf3mt3DhgPiBGFYMPE=;
        b=ialQmvVMyVfy0zG/bEv7TIvOaRpd7q0DTCecMENOvZafwj2zlY8xWtGfNxB6i4D0cZ
         gSfYBMy+8woXaAFIPgZ8KqMRt/EvNZ3Ae11656beR4nyRA/NbxL3SPg0u39LARGF5T+n
         vw/mKi19wbjPY0vdkM0K2+nL2kh8oI4ZPzpzU2OZi27WIDfN7nvxeMFdmm1eVGBJauOq
         c21jK5V7ADCY/MdkPkV5JVbIX1fqKkNdSm0U904gQ/tyWO1Pe7dz6/PKWPD9gTEsbUBz
         hRsyKO0sMhBVzOTA+s6adKn/9E4AKN8cfmCyB2qgfDjKMcbRfzf4qDwXma16x+iL9TLS
         moFg==
X-Forwarded-Encrypted: i=1; AJvYcCUq7dCLMnajpdp3pT9csG3Cl2pxmlmsarpvv5Ag+gRb4g2R0bID18XgS4TLguHhFnS2cQi98fUmJdUNI6A9NhG/USbeq6sXoV2tbpwY
X-Gm-Message-State: AOJu0Yx8s28Qe8EgLPk7LQLmTO5oXUwhlXl8lmXABQn7snS8IXVQGezu
	yFrCU9EnufUAorewi3+wBp+w2baSf6fd9msxLJZzErrtAGDxSovK0fNntA/DZ51iaahgH4kDZiM
	lQ5YJssHPT1C7+/ntOSxgqg==
X-Google-Smtp-Source: AGHT+IEb2zhbEXVqZ3P1JYJE6Fo9diwBNUvdIA2/ywTeuyC1gOvzRYHoUH/Nh8dnn8oZVoMuwzef2s1QbqysG/7VtA==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a05:6a00:6c81:b0:705:dbf5:190a with
 SMTP id d2e1a72fcca58-70629d42c52mr20977b3a.6.1718749168549; Tue, 18 Jun 2024
 15:19:28 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:19:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618221925.108173-1-yutingtseng@google.com>
Subject: [PATCH v1] binder: frozen notification
From: Yu-Ting Tseng <yutingtseng@google.com>
To: cmllamas@google.com, tkjos@google.com
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
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
For a given binder_ref, the staet of frozen notification can be one of
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

Signed-off-by: Yu-Ting Tseng <yutingtseng@google.com>
---
 drivers/android/binder.c            | 321 +++++++++++++++++++++++++++-
 drivers/android/binder_internal.h   |  21 +-
 include/uapi/linux/android/binder.h |  34 +++
 3 files changed, 372 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b21a7b246a0d..f237ff51b42f 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3763,6 +3763,202 @@ static void binder_transaction(struct binder_proc *proc,
 	}
 }
 
+static int
+binder_handle_bc_request_freeze_notification(struct binder_proc *proc,
+					     struct binder_thread *thread,
+					     void __user **ptr)
+{
+	struct binder_handle_cookie handle_cookie;
+	struct binder_ref_freeze *freeze = NULL;
+	struct binder_ref *ref;
+
+	if (copy_from_user(&handle_cookie, *ptr, sizeof(handle_cookie)))
+		return -EFAULT;
+	*ptr += sizeof(handle_cookie);
+
+	/*
+	 * Allocate memory for freeze notification
+	 * before taking lock
+	 */
+	freeze = kzalloc(sizeof(*freeze), GFP_KERNEL);
+	if (!freeze) {
+		WARN_ON(thread->return_error.cmd !=
+			BR_OK);
+		thread->return_error.cmd = BR_ERROR;
+		binder_enqueue_thread_work(thread, &thread->return_error.work);
+		binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
+			     "%d:%d BC_REQUEST_FREEZE_NOTIFICATION failed\n",
+			     proc->pid, thread->pid);
+		return 0;
+	}
+	freeze->sent = false;
+	freeze->resend = false;
+
+	binder_proc_lock(proc);
+	ref = binder_get_ref_olocked(proc, handle_cookie.handle, false);
+	if (!ref) {
+		binder_user_error("%d:%d %s invalid ref %d\n",
+				  proc->pid, thread->pid,
+				  "BC_REQUEST_FREEZE_NOTIFICATION",
+				  handle_cookie.handle);
+		binder_proc_unlock(proc);
+		kfree(freeze);
+		return 0;
+	}
+
+	binder_node_lock(ref->node);
+
+	if (ref->freeze) {
+		binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATION freeze notification already set\n",
+				  proc->pid, thread->pid);
+		binder_node_unlock(ref->node);
+		binder_proc_unlock(proc);
+		kfree(freeze);
+		return 0;
+	}
+	binder_stats_created(BINDER_STAT_FREEZE);
+	INIT_LIST_HEAD(&freeze->work.entry);
+	freeze->cookie = handle_cookie.cookie;
+	ref->freeze = freeze;
+	if (ref->node->proc) {
+		ref->freeze->work.type = ref->node->proc->is_frozen
+		    ? BINDER_WORK_FROZEN_BINDER
+		    : BINDER_WORK_UNFROZEN_BINDER;
+		binder_inner_proc_lock(proc);
+		binder_enqueue_work_ilocked(&ref->freeze->work, &proc->todo);
+		binder_wakeup_proc_ilocked(proc);
+		binder_inner_proc_unlock(proc);
+	}
+	binder_node_unlock(ref->node);
+	binder_proc_unlock(proc);
+	return 0;
+}
+
+static int
+binder_handle_bc_clear_freeze_notification(struct binder_proc *proc,
+					   struct binder_thread *thread,
+					   void __user **ptr)
+{
+	struct binder_handle_cookie handle_cookie;
+	struct binder_ref_freeze *freeze = NULL;
+	struct binder_ref *ref;
+
+	if (copy_from_user(&handle_cookie, *ptr, sizeof(handle_cookie)))
+		return -EFAULT;
+	*ptr += sizeof(handle_cookie);
+
+	binder_proc_lock(proc);
+	ref = binder_get_ref_olocked(proc, handle_cookie.handle, false);
+	if (!ref) {
+		binder_user_error("%d:%d %s invalid ref %d\n",
+				  proc->pid, thread->pid,
+				  "BC_CLEAR_FREEZE_NOTIFICATION",
+				  handle_cookie.handle);
+		binder_proc_unlock(proc);
+		kfree(freeze);
+		return 0;
+	}
+
+	binder_node_lock(ref->node);
+
+	if (!ref->freeze) {
+		binder_user_error("%d:%d BC_CLEAR_FREEZE_NOTIFICATION freeze notification not active\n",
+				  proc->pid, thread->pid);
+		binder_node_unlock(ref->node);
+		binder_proc_unlock(proc);
+		return 0;
+	}
+	freeze = ref->freeze;
+	if (freeze->cookie != handle_cookie.cookie) {
+		binder_user_error("%d:%d BC_CLEAR_FREEZE_NOTIFICATION freeze notification cookie mismatch %016llx != %016llx\n",
+				  proc->pid, thread->pid,
+				  (u64)freeze->cookie,
+				  (u64)handle_cookie.cookie);
+		binder_node_unlock(ref->node);
+		binder_proc_unlock(proc);
+		return 0;
+	}
+	ref->freeze = NULL;
+	binder_inner_proc_lock(proc);
+	if (list_empty(&freeze->work.entry)) {
+		freeze->work.type = BINDER_WORK_CLEAR_FREEZE_NOTIFICATION;
+		if (thread->looper &
+		    (BINDER_LOOPER_STATE_REGISTERED |
+		     BINDER_LOOPER_STATE_ENTERED)) {
+			binder_enqueue_thread_work_ilocked(thread,
+							   &freeze->work);
+		} else {
+			binder_enqueue_work_ilocked(&freeze->work,
+						    &proc->todo);
+			binder_wakeup_proc_ilocked(proc);
+		}
+	} else {
+		// There is already a freeze notification. Take it over and rewrite
+		// the work type. If it was already sent, flag it for re-sending;
+		// Otherwise it's pending and will be sent soon.
+		WARN_ON_ONCE(freeze->work.type != BINDER_WORK_FROZEN_BINDER &&
+			     freeze->work.type != BINDER_WORK_UNFROZEN_BINDER);
+		freeze->work.type = BINDER_WORK_CLEAR_DEATH_NOTIFICATION;
+		if (freeze->sent)
+			freeze->resend = true;
+	}
+	binder_inner_proc_unlock(proc);
+	binder_node_unlock(ref->node);
+	binder_proc_unlock(proc);
+	return 0;
+}
+
+static int
+binder_handle_bc_freeze_notification_done(struct binder_proc *proc,
+					  struct binder_thread *thread,
+					  void __user **ptr)
+{
+	struct binder_work *w;
+	binder_uintptr_t cookie;
+	struct binder_ref_freeze *freeze = NULL;
+
+	if (get_user(cookie, (binder_uintptr_t __user *)*ptr))
+		return -EFAULT;
+
+	*ptr += sizeof(cookie);
+	binder_inner_proc_lock(proc);
+	list_for_each_entry(w, &proc->delivered_freeze,
+			    entry) {
+		struct binder_ref_freeze *tmp_freeze =
+			container_of(w,
+				     struct binder_ref_freeze,
+				     work);
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
+		return 0;
+	}
+	binder_dequeue_work_ilocked(&freeze->work);
+	freeze->sent = false;
+	if (freeze->resend) {
+		freeze->resend = false;
+		if (thread->looper &
+			(BINDER_LOOPER_STATE_REGISTERED |
+			 BINDER_LOOPER_STATE_ENTERED)) {
+			binder_enqueue_thread_work_ilocked(thread,
+							   &freeze->work);
+		} else {
+			binder_enqueue_work_ilocked(&freeze->work,
+						    &proc->todo);
+			binder_wakeup_proc_ilocked(proc);
+		}
+	}
+	binder_inner_proc_unlock(proc);
+	return 0;
+}
+
 /**
  * binder_free_buf() - free the specified buffer
  * @proc:	binder proc that owns buffer
@@ -4246,6 +4442,28 @@ static int binder_thread_write(struct binder_proc *proc,
 			binder_inner_proc_unlock(proc);
 		} break;
 
+		case BC_REQUEST_FREEZE_NOTIFICATION: {
+			int error = binder_handle_bc_request_freeze_notification(proc, thread,
+										 &ptr);
+
+			if (error)
+				return error;
+		} break;
+
+		case BC_CLEAR_FREEZE_NOTIFICATION: {
+			int error = binder_handle_bc_clear_freeze_notification(proc, thread, &ptr);
+
+			if (error)
+				return error;
+		} break;
+
+		case BC_FREEZE_NOTIFICATION_DONE: {
+			int error = binder_handle_bc_freeze_notification_done(proc, thread, &ptr);
+
+			if (error)
+				return error;
+		} break;
+
 		default:
 			pr_err("%d:%d unknown command %u\n",
 			       proc->pid, thread->pid, cmd);
@@ -4635,6 +4853,50 @@ static int binder_thread_read(struct binder_proc *proc,
 			if (cmd == BR_DEAD_BINDER)
 				goto done; /* DEAD_BINDER notifications can cause transactions */
 		} break;
+
+		case BINDER_WORK_FROZEN_BINDER:
+		case BINDER_WORK_UNFROZEN_BINDER: {
+			struct binder_ref_freeze *freeze;
+			struct binder_frozen_state_info info;
+
+			freeze = container_of(w, struct binder_ref_freeze, work);
+			info.is_frozen = w->type == BINDER_WORK_FROZEN_BINDER;
+			info.cookie = freeze->cookie;
+			freeze->sent = true;
+			binder_enqueue_work_ilocked(w, &proc->delivered_freeze);
+			binder_inner_proc_unlock(proc);
+
+			if (put_user(BR_FROZEN_BINDER, (uint32_t __user *)ptr))
+				return -EFAULT;
+			ptr += sizeof(uint32_t);
+			if (put_user(info.cookie,
+				     (binder_uintptr_t __user *)ptr))
+				return -EFAULT;
+			ptr += sizeof(binder_uintptr_t);
+			if (put_user(info.is_frozen, (uint32_t __user *)ptr))
+				return -EFAULT;
+			ptr += sizeof(uint32_t);
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
@@ -5242,6 +5504,52 @@ static bool binder_txns_pending_ilocked(struct binder_proc *proc)
 	return false;
 }
 
+static void binder_add_freeze_work(struct binder_proc *proc, bool is_frozen)
+{
+	binder_inner_proc_lock(proc);
+	struct rb_node *n;
+	struct binder_ref *ref;
+	enum binder_work_type wtype;
+
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
+			wtype = is_frozen ? BINDER_WORK_FROZEN_BINDER : BINDER_WORK_UNFROZEN_BINDER;
+			if (list_empty(&ref->freeze->work.entry)) {
+				ref->freeze->work.type = wtype;
+				binder_enqueue_work_ilocked(&ref->freeze->work,
+							    &ref->proc->todo);
+				binder_wakeup_proc_ilocked(ref->proc);
+			} else {
+				WARN_ON_ONCE(ref->freeze->work.type ==
+					     BINDER_WORK_CLEAR_FREEZE_NOTIFICATION);
+				if (ref->freeze->sent && ref->freeze->work.type != wtype)
+					ref->freeze->resend = true;
+				ref->freeze->work.type = wtype;
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
@@ -5253,6 +5561,7 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
 		target_proc->async_recv = false;
 		target_proc->is_frozen = false;
 		binder_inner_proc_unlock(target_proc);
+		binder_add_freeze_work(target_proc, false);
 		return 0;
 	}
 
@@ -5266,6 +5575,7 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
 	target_proc->async_recv = false;
 	target_proc->is_frozen = true;
 	binder_inner_proc_unlock(target_proc);
+	binder_add_freeze_work(target_proc, true);
 
 	if (info->timeout_ms > 0)
 		ret = wait_event_interruptible_timeout(
@@ -5658,6 +5968,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	binder_stats_created(BINDER_STAT_PROC);
 	proc->pid = current->group_leader->pid;
 	INIT_LIST_HEAD(&proc->delivered_death);
+	INIT_LIST_HEAD(&proc->delivered_freeze);
 	INIT_LIST_HEAD(&proc->waiting_threads);
 	filp->private_data = proc;
 
@@ -6209,7 +6520,9 @@ static const char * const binder_return_strings[] = {
 	"BR_FAILED_REPLY",
 	"BR_FROZEN_REPLY",
 	"BR_ONEWAY_SPAM_SUSPECT",
-	"BR_TRANSACTION_PENDING_FROZEN"
+	"BR_TRANSACTION_PENDING_FROZEN",
+	"BR_FROZEN_BINDER",
+	"BR_CLEAR_FREEZE_NOTIFICATION_DONE",
 };
 
 static const char * const binder_command_strings[] = {
@@ -6232,6 +6545,9 @@ static const char * const binder_command_strings[] = {
 	"BC_DEAD_BINDER_DONE",
 	"BC_TRANSACTION_SG",
 	"BC_REPLY_SG",
+	"BC_REQUEST_FREEZE_NOTIFICATION",
+	"BC_CLEAR_FREEZE_NOTIFICATION",
+	"BC_FREEZE_NOTIFICATION_DONE",
 };
 
 static const char * const binder_objstat_strings[] = {
@@ -6241,7 +6557,8 @@ static const char * const binder_objstat_strings[] = {
 	"ref",
 	"death",
 	"transaction",
-	"transaction_complete"
+	"transaction_complete",
+	"freeze",
 };
 
 static void print_binder_stats(struct seq_file *m, const char *prefix,
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 5b7c80b99ae8..02f9c8d9cebc 100644
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
@@ -159,6 +160,9 @@ struct binder_work {
 		BINDER_WORK_DEAD_BINDER,
 		BINDER_WORK_DEAD_BINDER_AND_CLEAR,
 		BINDER_WORK_CLEAR_DEATH_NOTIFICATION,
+		BINDER_WORK_FROZEN_BINDER,
+		BINDER_WORK_UNFROZEN_BINDER,
+		BINDER_WORK_CLEAR_FREEZE_NOTIFICATION,
 	} type;
 };
 
@@ -275,6 +279,13 @@ struct binder_ref_death {
 	binder_uintptr_t cookie;
 };
 
+struct binder_ref_freeze {
+	struct binder_work work;
+	binder_uintptr_t cookie;
+	bool sent;
+	bool resend;
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
index d44a8118b2ed..140c39fb209d 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -236,6 +236,11 @@ struct binder_frozen_status_info {
 	__u32            async_recv;
 };
 
+struct binder_frozen_state_info {
+	binder_uintptr_t cookie;
+	__u32            is_frozen;
+};
+
 /* struct binder_extened_error - extended error information
  * @id:		identifier for the failed operation
  * @command:	command as defined by binder_driver_return_protocol
@@ -467,6 +472,16 @@ enum binder_driver_return_protocol {
 	/*
 	 * The target of the last async transaction is frozen.  No parameters.
 	 */
+
+	BR_FROZEN_BINDER = _IOR('r', 21, struct binder_frozen_state_info),
+	/*
+	 * void *: cookie
+	 */
+
+	BR_CLEAR_FREEZE_NOTIFICATION_DONE = _IOR('r', 22, binder_uintptr_t),
+	/*
+	 * void *: cookie
+	 */
 };
 
 enum binder_driver_command_protocol {
@@ -550,6 +565,25 @@ enum binder_driver_command_protocol {
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
2.45.2.627.g7a2c4fd464-goog


