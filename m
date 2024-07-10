Return-Path: <linux-kernel+bounces-248423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8C792DD00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446691C22408
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF7F16CD39;
	Wed, 10 Jul 2024 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yt+IaSSB"
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A683F16C42C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654974; cv=none; b=ig1fNtI8n4wZsfTNhlXFlla/IHtNj7gws4xBmnZwKCDy/x96WkgWeseQ1Jmd1c4/Oh6x3xRR+mlHBGBZmVzhXndFxuo9QdoyvXLfsq55zurkuIezuj+6Ky0jMzUATWrQFz6HgCzv9onaJh3974eaKAcEqnMeYeHvJHvAUwP2L8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654974; c=relaxed/simple;
	bh=eTv+8mtXv9pcwUVaOkiFS2pyxVlBIejV0U8K7ZFMz7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RQK1QxFQrIoOEyi6BCdkiKMP+VszuStwIQUqvkioCOSdX1yf6WKWRF7zJ3CzRdJMgjemzZA3IopGxZ8nU+5TFTHPVj8LUzs8BvmFs6Sv+9zih/bvd/RbzOlHMe+MG+oSYDzAWceR8iFIxoGnoOgdMYwwNnCeZavJjdWCO8rLJNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yt+IaSSB; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-81063552eafso225501241.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720654972; x=1721259772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKPHohqFL0IhECSvPRQXiNGrzNnrPvfhaSYPnkkePdA=;
        b=Yt+IaSSBMbGS+IafqDzS6nVUHKzASFutAlsF8viGS8g8/0qK7zNvQ5Gon20P4DJij9
         Xp3+z577g3+G8sI+wHNMJLlGWB+72IslupSJ3/KivD3jZJdlI0hW0n9omk2FDFeYNXiz
         sR6gBeUg6K0wDk4mbC9oF8Z9TaAPYd78aiq/dNDmrNkXE30o4ECHwfl3Sz9LTejMoW/Y
         xW0EyEroLdkQE2qu7ITqjEkjudpCN2oOOi+Zl9H8CKluK38kJZIb4zsARs+ByEB3y2T3
         86gK3HMyTi9byNbDVFuTjNTIfOApqyPih5qF4CAlqr7zVZ9p4JW9JnpHh012jrVpRNUg
         /Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720654972; x=1721259772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKPHohqFL0IhECSvPRQXiNGrzNnrPvfhaSYPnkkePdA=;
        b=pWeGZjmUfWxZ0LwWCxZWtXdfl7Ffx0SkA/sdZ+kM7LCQv7lTOH/eJ3YrjiBfw8EEEo
         W6GyqjOazowb7GiQZtO1twGzISZrb6w75VB91O+B5c09EiU/+0PAfr/I774xLA/3GfuQ
         v31CGw1aTEJ/szCUOeui15QSQhJ1tTWQ2abWKSDxF/QPQSafu0oiP1VjQSzrRh1UUMU3
         l+Frwswnv3e/Ntov+/lfQMPnrq8b+gjx48rP4hoAb8e386DdZmZxQ6g6Bv9dNhOAjs1z
         DQW3i03c4pUdhbisdu+nJE4FMQDSSn1307kzECikhyjyiJ1OfVv+XNiqgUA5/lssJPw4
         EP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWN0mLqwa0wc8ZTN4qBtsrQolBzHqgWlojs5F24eYidi3PpP0OHhs4GgWt7ltvZh9O/OAKtaPzlHmTNsTxC7PEHGFDzGslHpvhdUWrU
X-Gm-Message-State: AOJu0YxVRniwUczKqpVHS9qmeQ8MW/53HPYwYpbsyCqrzjlnw1u3J88a
	IgWOHSJzY1YTHFMOaG5vYoPtP/UwntV10WUIuKJyUrGkfD5eL60lmIBf8Hkh2P1G8Os808pjd2k
	zjFe7qeTszyFEbeaIOg==
X-Google-Smtp-Source: AGHT+IHgRj71HIHo+Vr3YRAiQ2me1afxQxUXle9EqleBoMEZbhkar+2O7/FONbR7df58PgwPGZmAiebsYvwdmxCn
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6130:288d:b0:80f:b1c4:fcef with
 SMTP id a1e0cc1a2514c-81185662fe2mr17887241.1.1720654971766; Wed, 10 Jul 2024
 16:42:51 -0700 (PDT)
Date: Wed, 10 Jul 2024 23:42:18 +0000
In-Reply-To: <20240710234222.2333120-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710234222.2333120-1-jthoughton@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240710234222.2333120-15-jthoughton@google.com>
Subject: [RFC PATCH 14/18] KVM: Add asynchronous userfaults, KVM_READ_USERFAULT
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Peter Xu <peterx@redhat.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

It is possible that KVM wants to access a userfault-enabled GFN in a
path where it is difficult to return out to userspace with the fault
information. For these cases, add a mechanism for KVM to wait for a GFN
to not be userfault-enabled.

The mechanism introduced in this patch uses an eventfd to signal that a
userfault is ready to be read. Userspace then reads the userfault with
KVM_READ_USERFAULT. The fault itself is stored in a list, and KVM will
busy-wait for the gfn to not be userfault-enabled.

The implementation of this mechanism is certain to change before KVM
Userfault could possibly be merged. Really the main concerns are whether
or not this kind of asynchronous userfault system is required and if the
UAPI for reading faults works.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/kvm_host.h |  7 +++
 include/uapi/linux/kvm.h |  7 +++
 virt/kvm/kvm_main.c      | 92 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index dc12d0a5498b..3b9780d85877 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -734,8 +734,15 @@ struct kvm_memslots {
 	int node_idx;
 };
 
+struct kvm_userfault_list_entry {
+	struct list_head list;
+	gfn_t gfn;
+};
+
 struct kvm_userfault_ctx {
 	struct eventfd_ctx *ev_fd;
+	spinlock_t list_lock;
+	struct list_head gfn_list;
 };
 
 struct kvm {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6aa99b4587c6..8cd8e08f11e1 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1554,4 +1554,11 @@ struct kvm_create_guest_memfd {
 #define KVM_USERFAULT_ENABLE		(1ULL << 0)
 #define KVM_USERFAULT_DISABLE		(1ULL << 1)
 
+struct kvm_fault {
+	__u64 address;
+	/* TODO: reserved fields */
+};
+
+#define KVM_READ_USERFAULT		_IOR(KVMIO, 0xd5, struct kvm_fault)
+
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4ac018cac704..d2ca16ddcaa1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2678,6 +2678,43 @@ static bool memslot_is_readonly(const struct kvm_memory_slot *slot)
 	return slot->flags & KVM_MEM_READONLY;
 }
 
+static int read_userfault(struct kvm_userfault_ctx __rcu *ctx, gfn_t *gfn)
+{
+	struct kvm_userfault_list_entry *entry;
+
+	spin_lock(&ctx->list_lock);
+
+	entry = list_first_entry_or_null(&ctx->gfn_list,
+					 struct kvm_userfault_list_entry,
+					 list);
+
+	list_del(&entry->list);
+
+	spin_unlock(&ctx->list_lock);
+
+	if (!entry)
+		return -ENOENT;
+
+	*gfn = entry->gfn;
+	return 0;
+}
+
+static void signal_userfault(struct kvm *kvm, gfn_t gfn)
+{
+	struct kvm_userfault_ctx __rcu *ctx =
+		srcu_dereference(kvm->userfault_ctx, &kvm->srcu);
+	struct kvm_userfault_list_entry entry;
+
+	entry.gfn = gfn;
+	INIT_LIST_HEAD(&entry.list);
+
+	spin_lock(&ctx->list_lock);
+	list_add(&entry.list, &ctx->gfn_list);
+	spin_unlock(&ctx->list_lock);
+
+	eventfd_signal(ctx->ev_fd);
+}
+
 static unsigned long __gfn_to_hva_many(const struct kvm_memory_slot *slot, gfn_t gfn,
 				       gfn_t *nr_pages, bool write, bool atomic)
 {
@@ -2687,8 +2724,14 @@ static unsigned long __gfn_to_hva_many(const struct kvm_memory_slot *slot, gfn_t
 	if (memslot_is_readonly(slot) && write)
 		return KVM_HVA_ERR_RO_BAD;
 
-	if (gfn_has_userfault(slot->kvm, gfn))
-		return KVM_HVA_ERR_USERFAULT;
+	if (gfn_has_userfault(slot->kvm, gfn)) {
+		if (atomic)
+			return KVM_HVA_ERR_USERFAULT;
+		signal_userfault(slot->kvm, gfn);
+		while (gfn_has_userfault(slot->kvm, gfn))
+			/* TODO: don't busy-wait */
+			cpu_relax();
+	}
 
 	if (nr_pages)
 		*nr_pages = slot->npages - (gfn - slot->base_gfn);
@@ -5009,6 +5052,10 @@ static int kvm_enable_userfault(struct kvm *kvm, int event_fd)
 	}
 
 	ret = 0;
+
+	INIT_LIST_HEAD(&userfault_ctx->gfn_list);
+	spin_lock_init(&userfault_ctx->list_lock);
+
 	userfault_ctx->ev_fd = ev_fd;
 
 	rcu_assign_pointer(kvm->userfault_ctx, userfault_ctx);
@@ -5037,6 +5084,27 @@ static int kvm_vm_ioctl_enable_userfault(struct kvm *kvm, int options,
 	else
 		return kvm_disable_userfault(kvm);
 }
+
+static int kvm_vm_ioctl_read_userfault(struct kvm *kvm, gfn_t *gfn)
+{
+	int ret;
+	int idx;
+	struct kvm_userfault_ctx __rcu *ctx;
+
+	idx = srcu_read_lock(&kvm->srcu);
+
+	ctx = srcu_dereference(kvm->userfault_ctx, &kvm->srcu);
+
+	ret = -ENOENT;
+	if (!ctx)
+		goto out;
+
+	ret = read_userfault(ctx, gfn);
+
+out:
+	srcu_read_unlock(&kvm->srcu, idx);
+	return ret;
+}
 #endif
 
 static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
@@ -5403,6 +5471,26 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_gmem_create(kvm, &guest_memfd);
 		break;
 	}
+#endif
+#ifdef CONFIG_KVM_USERFAULT
+	case KVM_READ_USERFAULT: {
+		struct kvm_fault fault;
+		gfn_t gfn;
+
+		r = kvm_vm_ioctl_read_userfault(kvm, &gfn);
+		if (r)
+			goto out;
+
+		fault.address = gfn;
+
+		/* TODO: if this fails, this gfn is lost. */
+		r = -EFAULT;
+		if (copy_to_user(&fault, argp, sizeof(fault)))
+			goto out;
+
+		r = 0;
+		break;
+	}
 #endif
 	default:
 		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
-- 
2.45.2.993.g49e7a77208-goog


