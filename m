Return-Path: <linux-kernel+bounces-239917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2036D9266CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D97B25A26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4524E18754C;
	Wed,  3 Jul 2024 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIW+SqGn"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F7170836
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026516; cv=none; b=DdkmFO9vo6LwnV/l1NODGaGR+pSy7lk1RtvQeA9LurWchqxca0N7wi+JIcpfdWZbT0FDr5Rrs2dVpJbOdIvvHYkvtCN7ABvTUejhRK+olqLPV+OOIu2DHexg+ezZzwVpbonmDFF0ep675MoMPrbRH1ozzq3ToLRwnqcuk/B9O1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026516; c=relaxed/simple;
	bh=ddrZHFpe6w7+XBhJmDcimx45ckfB7OQ2jX57czK6xS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=knF4Kf1qPYL7EX7QlmcAOiHhCKtnMLn0O8lq5sbgXiQoUQKmiuMQVZoVOxf7RavA9wX/ijCd6+7hU+4MAF6R3/SsULSbQLZKRj0aJ2veg6sae+D1TPDAvxk38Do3hGdz63Kj2jcgUOcZBhOMVD1xRDH4JzRXSMCp+Pm5jtX+8Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIW+SqGn; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7066502da3fso3998427b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720026514; x=1720631314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZuksJItsDs3OGtTgHqNrYs9b/QdnKX7IBQNDcjCK/Y=;
        b=LIW+SqGnlw0FiXBHNUrG5zNEt1Kn8n6kFRStOAJH2DfpqKV9gVQIChHJOvi41SQMnD
         D6CNMX8e8lCwVqS30s+z1PvxSH2FSUq4To2hUEEt4ICkZ4hWn4brAHSpMQUsmkyUAyTO
         8YjsPWHS1cXZKsAxooNlZmhefJxeBoG63EJtrMETWt748Wd0DYfF7krK5zdo+cUwshA0
         j9xbtV7fIArV1rEm9RBFOREfB3yvQQuSY+x1o39sTtp5m/ke6W12ikA1cAu/OJ+MOPuR
         oMx9ujI02stCbmC5jFfUB+5i5qyS80CC+6q6ZOke91IiNpiSweF3U0tBfxnGoLRHB+m5
         6mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026514; x=1720631314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZuksJItsDs3OGtTgHqNrYs9b/QdnKX7IBQNDcjCK/Y=;
        b=VKmrdtAafd0GUDvZxA+tZFn0I/DtWpylCWjB/RXQQntg+UQnO7sy3D+S5Hz188GFdC
         qNh//tlG8OfsE+Gi0VrUDV95BEGoavAWuJoFtGQdaEiVfyAqsg3pPydiTgKj/7UDeRz3
         SCrxhCagIg2k0G2AHik1ZKpqEaD6dPVpGLMgbOQ0vutMyICzpFKO7Fcx/p+6tB6Ynv7Z
         lBtd14qaAiOTv4p2PvuEsmEVmt2r7Y7Awll8zmQIaEuawNshd+BJPl678u0Q6Bhr3yxI
         kCWYxbuucIFeqfFDLSoDJx3ZhNKlX1Ln1z3zAdocqWsgGWTY6RkvkOS8kB+N8/ez6+s1
         eLSw==
X-Forwarded-Encrypted: i=1; AJvYcCVSaJZYM6Mzz+6dOYAwc8XzhcfbCN3kEyJvo+Vh84w01cBu1+PTqF4sydDtTXaNdLyQC+ThnT718IjmD3gm7riDszKhUxnLjPNPWNK+
X-Gm-Message-State: AOJu0YxbKkh2XTTpIbyimioE/H8A9CxLDfgal9wZmzGcZjP2flOd/sxM
	pbxn4MUawQ2qu0ZLK0XAu6SLPIfV3a8FnIL/9Q1DWWT4vMSID1EmU5yYE+cu2fAIskeR9KYIFSy
	gt4NkkuMQvZ42JW5PCMFj2g==
X-Google-Smtp-Source: AGHT+IGsf+JZa7aNww8N8DTh1psSrjKE/LVhqV5fDbS//K3JreVbPEpVydJqh0lj6kGbGfJ6gMgwIhjsoKEYmYEk9A==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a05:6a00:2d8b:b0:70a:f547:382 with
 SMTP id d2e1a72fcca58-70af547060amr61867b3a.5.1720026513979; Wed, 03 Jul 2024
 10:08:33 -0700 (PDT)
Date: Wed,  3 Jul 2024 10:08:06 -0700
In-Reply-To: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703170804.3621083-4-yutingtseng@google.com>
Subject: [PATCH v5] binder: frozen notification
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
 drivers/android/binder.c                      | 284 +++++++++++++++++-
 drivers/android/binder_internal.h             |  21 +-
 drivers/android/binderfs.c                    |   8 +
 include/uapi/linux/android/binder.h           |  36 +++
 .../filesystems/binderfs/binderfs_test.c      |   1 +
 5 files changed, 346 insertions(+), 4 deletions(-)

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
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 3001d754ac36..ad1fa7abc323 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -58,6 +58,7 @@ enum binderfs_stats_mode {
 struct binder_features {
 	bool oneway_spam_detection;
 	bool extended_error;
+	bool freeze_notification;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -74,6 +75,7 @@ static const struct fs_parameter_spec binderfs_fs_parameters[] = {
 static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
 	.extended_error = true,
+	.freeze_notification = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -608,6 +610,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = binderfs_create_file(dir, "freeze_notification",
+				      &binder_features_fops,
+				      &binder_features.freeze_notification);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 
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
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 5f362c0fd890..319567f0fae1 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -65,6 +65,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 	static const char * const binder_features[] = {
 		"oneway_spam_detection",
 		"extended_error",
+		"freeze_notification",
 	};
 
 	change_mountns(_metadata);
-- 
2.45.2.803.g4e1b14247a-goog


