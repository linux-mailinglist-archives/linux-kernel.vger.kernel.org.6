Return-Path: <linux-kernel+bounces-248039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE6592D79D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBD41F24B15
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA17197A86;
	Wed, 10 Jul 2024 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZd1fQ2J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC7195985
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633243; cv=none; b=gZeIQo1/6YZbj8h3mMPRl7bPKYaMLZRP/VgBBYeCZGUxwDirD+GXyPLOoH8oNfvneylPkd92STRalkGMmkKr5bkSLiSnuecsN2KmlyQR4O+4gn5z8sOb5TIa+SROxmpx8Fg7tgyhZRBz/sajVgFw3gO8grh3T9qD1N9/BaU+vKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633243; c=relaxed/simple;
	bh=Kivn7Ihq+AIG1yys7yhApKnsrw87mpUJ9p5a+e4Y/BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqQMUciUqrHw/wIwRsMKQctlwDyHQ9nIVpOflHAimj8FiYa9BcIOlY9G2sJNfdqiWbUGCkVdYpfSmlPzd99CpJmgEbG1cb9Cd2ZjSNiBQS0W6fQdeD2mBbp98cu31Si/XviFf7CHjtbURxvtYSeJX38NZ8hzF13c7vdj33xJ8v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZd1fQ2J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720633241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uP9qv5eqsWEFcD9qsRXZiyIS2WfjW8I9G78g6HpsEms=;
	b=iZd1fQ2JNkUDYolV/zXTxGpsUjHSDw5JCm0dnCNUPV02oBLqAPsFKISK3ZHvRMiaNblNVs
	8fmDliypv6XecaIQB8R9pca8oykB4YJhn8u6kCRiAGL9Aq2bjRY1iPwi1Z0rm7rGBJ3MVv
	1CKZhin1WsVYOrWvgsmfeIqDwQFHXcw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-M34SeZd2PomBYGZtyrecHA-1; Wed,
 10 Jul 2024 13:40:36 -0400
X-MC-Unique: M34SeZd2PomBYGZtyrecHA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F416F1955F3D;
	Wed, 10 Jul 2024 17:40:34 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F33991955E85;
	Wed, 10 Jul 2024 17:40:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	seanjc@google.com,
	binbin.wu@linux.intel.com,
	xiaoyao.li@intel.com,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v5 2/7] KVM: Add KVM_PRE_FAULT_MEMORY vcpu ioctl to pre-populate guest memory
Date: Wed, 10 Jul 2024 13:40:26 -0400
Message-ID: <20240710174031.312055-3-pbonzini@redhat.com>
In-Reply-To: <20240710174031.312055-1-pbonzini@redhat.com>
References: <20240710174031.312055-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Isaku Yamahata <isaku.yamahata@intel.com>

Add a new ioctl KVM_PRE_FAULT_MEMORY in the KVM common code. It iterates on the
memory range and calls the arch-specific function.  The implementation is
optional and enabled by a Kconfig symbol.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Message-ID: <819322b8f25971f2b9933bfa4506e618508ad782.1712785629.git.isaku.yamahata@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_host.h |  5 ++++
 include/uapi/linux/kvm.h | 10 +++++++
 virt/kvm/Kconfig         |  3 ++
 virt/kvm/kvm_main.c      | 60 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7b57878c8c18..c3c922bf077f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2477,4 +2477,9 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages
 void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
 #endif
 
+#ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
+				    struct kvm_pre_fault_memory *range);
+#endif
+
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index d03842abae57..e5af8c692dc0 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -917,6 +917,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_MEMORY_ATTRIBUTES 233
 #define KVM_CAP_GUEST_MEMFD 234
 #define KVM_CAP_VM_TYPES 235
+#define KVM_CAP_PRE_FAULT_MEMORY 236
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1548,4 +1549,13 @@ struct kvm_create_guest_memfd {
 	__u64 reserved[6];
 };
 
+#define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)
+
+struct kvm_pre_fault_memory {
+	__u64 gpa;
+	__u64 size;
+	__u64 flags;
+	__u64 padding[5];
+};
+
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 754c6c923427..b14e14cdbfb9 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -67,6 +67,9 @@ config HAVE_KVM_INVALID_WAKEUPS
 config KVM_GENERIC_DIRTYLOG_READ_PROTECT
        bool
 
+config KVM_GENERIC_PRE_FAULT_MEMORY
+       bool
+
 config KVM_COMPAT
        def_bool y
        depends on KVM && COMPAT && !(S390 || ARM64 || RISCV)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8e422c2c9450..f817ec66c85f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4373,6 +4373,52 @@ static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 	return fd;
 }
 
+#ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
+static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
+				     struct kvm_pre_fault_memory *range)
+{
+	int idx;
+	long r;
+	u64 full_size;
+
+	if (range->flags)
+		return -EINVAL;
+
+	if (!PAGE_ALIGNED(range->gpa) ||
+	    !PAGE_ALIGNED(range->size) ||
+	    range->gpa + range->size <= range->gpa)
+		return -EINVAL;
+
+	vcpu_load(vcpu);
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+
+	full_size = range->size;
+	do {
+		if (signal_pending(current)) {
+			r = -EINTR;
+			break;
+		}
+
+		r = kvm_arch_vcpu_pre_fault_memory(vcpu, range);
+		if (WARN_ON_ONCE(r == 0 || r == -EIO))
+			break;
+
+		if (r < 0)
+			break;
+
+		range->size -= r;
+		range->gpa += r;
+		cond_resched();
+	} while (range->size);
+
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	vcpu_put(vcpu);
+
+	/* Return success if at least one page was mapped successfully.  */
+	return full_size == range->size ? r : 0;
+}
+#endif
+
 static long kvm_vcpu_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -4573,6 +4619,20 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = kvm_vcpu_ioctl_get_stats_fd(vcpu);
 		break;
 	}
+#ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
+	case KVM_PRE_FAULT_MEMORY: {
+		struct kvm_pre_fault_memory range;
+
+		r = -EFAULT;
+		if (copy_from_user(&range, argp, sizeof(range)))
+			break;
+		r = kvm_vcpu_pre_fault_memory(vcpu, &range);
+		/* Pass back leftover range. */
+		if (copy_to_user(argp, &range, sizeof(range)))
+			r = -EFAULT;
+		break;
+	}
+#endif
 	default:
 		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
 	}
-- 
2.43.0



