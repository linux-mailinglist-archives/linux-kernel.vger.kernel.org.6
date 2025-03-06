Return-Path: <linux-kernel+bounces-549806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823FCA55772
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27FD1898419
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA31276047;
	Thu,  6 Mar 2025 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EG2nMqfr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEBF276038
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292977; cv=none; b=KJSwjOKg0sqjfTEU7XSnQEio6lj/cFyvEqlTl53oMlzkzNbWVbm4SU8At1zVy4O0IgmRtBvJW/1R+x/KamfGRq6vrZcq4cki18SIAtJNQprXzWcVkrDv0q0X1ssn/Uu9GWprPIvCzkEc+3hcK6p5tPrGdGeKV2HHO2v9UdQTXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292977; c=relaxed/simple;
	bh=8vyu3XmUOc6y+9UctpvXG0VUwJYWY/BqkHoBpdSAYZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hsTeFQdC9aXxE4snjpjyk3LDBrDINApjxudFal6vc0M3yicd8ZxP9Ohiq5h9a15/gtTsBvmEk3VRP2TKDdTzeyJJ6Zt5K6bGzz6oOT0l0cvlVG0tb6WLMAPr9hZyijR0kPKJ791NEzMpnBhokXDnKydM3iAh4uEsdCx1sSCaVcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EG2nMqfr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741292974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jc3bU+07/m9HQ5f3AAk7LB5X6YU1cmlau9q/eqDjROY=;
	b=EG2nMqfri01p7slaqSFq/p1uqm45mAmiGjNsVfytm3CgT58iOJNrJMDeRcpkBgYnvITjj8
	bShIjAjqO0vvdU9FyQ1P33OwtOsKD8hJF0KLgqoaRKqJXf6SUshNTz9QXQL/rYni/oetun
	P7tLx5Pm8NJ18A695sOx0WaTIr+EmrI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-CpOiqkVeMiiLKl63CXFhnA-1; Thu, 06 Mar 2025 15:29:27 -0500
X-MC-Unique: CpOiqkVeMiiLKl63CXFhnA-1
X-Mimecast-MFC-AGG-ID: CpOiqkVeMiiLKl63CXFhnA_1741292966
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso6738145e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292965; x=1741897765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jc3bU+07/m9HQ5f3AAk7LB5X6YU1cmlau9q/eqDjROY=;
        b=GmufNcpHIaPiKJSZD1J0DMDg8UCt8Psh5UEQjqXcpI6AmeivE5AYq4g805d4FptyXQ
         870rY/ujIsUgHYuzGbSY3nG3Y7hRTNqDRm7iU11sbC+mKNH+S0lG5YlZHlfiJPNMEgfO
         dNMCWgYxnT7UJ/qXOn2QXA+GrUVEKU1v6XyJ1JqlkmeFpajAja9bdnZTrtahVkJ07ThR
         zg2IOwY6ullukpBuogviCkaWmvF/rahCUqNta9BXTisORWWWTop+afewiA6x1Bb+yBOg
         H/ZSpCf+KWQFAk9BmSlEokJ2UIGv8IvZi8LN2c0rKu7po7DQX2x4moJi2QIPwB+QSGzJ
         H0sQ==
X-Gm-Message-State: AOJu0YzmVfIaOeFK3FN0ICwXkm/euvJJGNrOMBqg4XamdW22QPoHQdWA
	yN3fDxCA6BO3Migk72kigEn8QquueVX+CHahUeXvY1M05JdsKrd3hox7O3dqtrthPXGSIJcYWA0
	lkT3av6I3+cVLe1yZWXXqaL6GBiFLk2MuW73eKVhqkD79E+qz1iAplG21p/lgKPxx/I2Pc07Jp2
	6a6XwgvUGn7FWii/D5N6XNpzoJvyNhWkCcK/O0Sjc8KD+jumPN
X-Gm-Gg: ASbGncu3C0U3MmSRrpIbJx/XXRXQWuco1KJuNK9CtkGTyJj70LtAd7jTYL4tHjAVb/K
	wLap+GP7jpHkeidzmDc90GEiZfxmh34DWhlS1OPHpGPGI56hLBpdmEJpBr1sn4xN93apMXN4umx
	lVkW+iUyGqTa79AGReIzwdbcSq916iXgzfaVeIJDMDWmOeFy8+1Q0DndofvrB3KGACq5mxzFkMt
	UGaVB8V/C7VCDYKFRraNZ7ub2pfbbH6ZtZfDtcc95bSKezMLbgx66UcyMlWOMIKNMqhHnw2EjtB
	7B04ninYq1U5Z/yTUJ4=
X-Received: by 2002:a05:600c:1c92:b0:43b:c284:5bc2 with SMTP id 5b1f17b1804b1-43c54a13899mr8094665e9.0.1741292964980;
        Thu, 06 Mar 2025 12:29:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAQSfTDDfEGt7kCQUl09IKwMyDuCnJFvs3A/ftPMnIhst0AXXgvlmr3jiXxVdhzI638oXcqg==
X-Received: by 2002:a05:600c:1c92:b0:43b:c284:5bc2 with SMTP id 5b1f17b1804b1-43c54a13899mr8094515e9.0.1741292964495;
        Thu, 06 Mar 2025 12:29:24 -0800 (PST)
Received: from [192.168.10.48] ([151.95.119.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd435c836sm59321245e9.37.2025.03.06.12.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 12:29:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com
Subject: [PATCH] KVM: x86: block KVM_CAP_SYNC_REGS if guest state is protected
Date: Thu,  6 Mar 2025 21:29:22 +0100
Message-ID: <20250306202923.646075-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM_CAP_SYNC_REGS does not make sense for VMs with protected guest state,
since the register values cannot actually be written.  Return 0
when using the VM-level KVM_CHECK_EXTENSION ioctl, and accordingly
return -EINVAL from KVM_RUN if the valid/dirty fields are nonzero.

However, on exit from KVM_RUN userspace could have placed a nonzero
value into kvm_run->kvm_valid_regs, so check guest_state_protected
again and skip store_regs() in that case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index aaa067b79095..b416eec5c167 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4586,6 +4586,11 @@ static bool kvm_is_vm_type_supported(unsigned long type)
 	return type < 32 && (kvm_caps.supported_vm_types & BIT(type));
 }
 
+static inline u32 kvm_sync_valid_fields(struct kvm *kvm)
+{
+	return kvm && kvm->arch.has_protected_state ? 0 : KVM_SYNC_X86_VALID_FIELDS;
+}
+
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	int r = 0;
@@ -4694,7 +4699,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 #endif
 	case KVM_CAP_SYNC_REGS:
-		r = KVM_SYNC_X86_VALID_FIELDS;
+		r = kvm_sync_valid_fields(kvm);
 		break;
 	case KVM_CAP_ADJUST_CLOCK:
 		r = KVM_CLOCK_VALID_FLAGS;
@@ -11503,6 +11508,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 {
 	struct kvm_queued_exception *ex = &vcpu->arch.exception;
 	struct kvm_run *kvm_run = vcpu->run;
+	u32 sync_valid_fields;
 	int r;
 
 	r = kvm_mmu_post_init_vm(vcpu->kvm);
@@ -11548,8 +11554,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
-	if ((kvm_run->kvm_valid_regs & ~KVM_SYNC_X86_VALID_FIELDS) ||
-	    (kvm_run->kvm_dirty_regs & ~KVM_SYNC_X86_VALID_FIELDS)) {
+	sync_valid_fields = kvm_sync_valid_fields(vcpu->kvm);
+	if ((kvm_run->kvm_valid_regs & ~sync_valid_fields) ||
+	    (kvm_run->kvm_dirty_regs & ~sync_valid_fields)) {
 		r = -EINVAL;
 		goto out;
 	}
@@ -11607,7 +11614,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 out:
 	kvm_put_guest_fpu(vcpu);
-	if (kvm_run->kvm_valid_regs)
+	if (kvm_run->kvm_valid_regs && likely(!vcpu->arch.guest_state_protected))
 		store_regs(vcpu);
 	post_kvm_run_save(vcpu);
 	kvm_vcpu_srcu_read_unlock(vcpu);
-- 
2.48.1


