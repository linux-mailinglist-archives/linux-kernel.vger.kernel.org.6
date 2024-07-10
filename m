Return-Path: <linux-kernel+bounces-248422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E944A92DCF7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E771F23740
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A17158DAE;
	Wed, 10 Jul 2024 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NraxoE88"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9216848B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654973; cv=none; b=F5QhGiEj5a8wUeGSXJjyoMRgEsMY8NjDjX5HeiU/nUnNsOItPhkiiurKq2jLbshxs9bjG9aFWRgOIMlocH0JEEkxGTTJDQiSRvVBPtMRrCUuuuiYwecW3/a6M+tfnT4pdHUUsZU0zsfLV40SoVuHn8OHV3SSHM+D18G8iDOWnNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654973; c=relaxed/simple;
	bh=bFngUTjVBtg5CbyG25RDmTc6wZ0g8Z4dE05PWolnMuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EKfs7g6hLl2Up9nBkLd8UDOBmS6itvzmDOfpcmE+2K47e4ruvqDiOwEj4Lkkmxy1IcYBgzveYX1UEjk1s4kfHCsKWtJSDX///PINh7q5EYoClEHtvnanRXyfls29qE8VAFh/CP9UnKklekz70HvblFtTYHndBkmqHpnhZchR4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NraxoE88; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e032d4cf26aso518666276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720654970; x=1721259770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wAPg+uoGyE7jrnqbrfnqp+qBfKQe/ElheERXpCs/y30=;
        b=NraxoE884i5UGeFLgyX6LV7967m3VShM5RJlHCzHa1BM3Ym/+8c83CzC7IvyEpbJez
         7udLHgCXg3ao8cBo31uGB2qPMrJE1WjFX7XI5FibKYcJ61K8Sa9qMuDgouX0kvZnFQmD
         qMCdCCLZciixrn7zTiTTNIfSjaKVjL8imwQEF0h1iJPrjxkJybpE+Q7yzSWS5ixF9UmG
         MZtuaM8JLBvfieo1nWP5Wzf2eVf9dWGUAtDEIQQSbHOUUOurd5cuj84uR2FPDCzOVo1Q
         nuwy7CbjpJhIkMuTCUo0jTlUUFiDE6gAcJRoM4GftShi3884dKF9Jz1RC63GHwKVSfaM
         9dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720654970; x=1721259770;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAPg+uoGyE7jrnqbrfnqp+qBfKQe/ElheERXpCs/y30=;
        b=R7Ggbf2KcezbkufUvDfYjeLfWjoJakCkf40fQSPHwuhtzo/PbwcaY/5eYXSpEZ0RKM
         G+0P6izchbGN9e3aAdB3vwiQw8otFeZQLoyygvKX1XFeJm4EXdThnyw1bAkC5pM0CktF
         x5svFwbtmOpmLWxReRVYOeY3MKNz94bynNx0jutEyH6dlCXWuceWo/sKBa3w5NA5rE6z
         492wUSUHabTCl5aetYOFsY3pX4BU6kymL5n85sZKrOu0KWE6LuAAFtFZglzoaaH5YL35
         oMZbJQ9oZQQz2L1/KRBZz7XIUEY0CIJ/6C08t7u8bMa24cOORfKrJ2yMjIHDXW1xfY9a
         mycg==
X-Forwarded-Encrypted: i=1; AJvYcCUrIUuMJ32AIMhqd3wViIEzaE686GU1Fw5Zw1kDZIjKG8wyyXIJEDD+85JPOl7ykHypJ7Q6+qx9L+M9FTlGOVYD/T0T926LGYVuWftv
X-Gm-Message-State: AOJu0YzCHa9hrXW/ZqH3uShNbSdgU+C6c5MOxYZAZ+YqIYWz4Bh6u7wU
	ZgzpanZoIJKUt6iP/hOVnUOJXLwl0mlZz+HJhkeYU1eqX+6Tmpp57X7Uz464uGyQTIlvAvmsKMW
	pO/5rfBnUummy0asjhA==
X-Google-Smtp-Source: AGHT+IEUTEcOd07Ngb0BqkggJw4ozgt7Za8itkm1dvA0VYqtERMoRdOJmQ0AmWvr6/7REaf9c4XX0hx8Il26mfc6
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:2101:b0:e03:31ec:8a24 with
 SMTP id 3f1490d57ef6-e041b17dfb5mr382800276.8.1720654969766; Wed, 10 Jul 2024
 16:42:49 -0700 (PDT)
Date: Wed, 10 Jul 2024 23:42:16 +0000
In-Reply-To: <20240710234222.2333120-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710234222.2333120-1-jthoughton@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240710234222.2333120-13-jthoughton@google.com>
Subject: [RFC PATCH 12/18] KVM: arm64: Add userfault support for steal-time
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

As part of KVM_RUN, we may need to write steal-time information to guest
memory. In the case that the gfn we are writing to is userfault-enabled,
we should return to userspace with fault information.

With asynchronous userfaults, this change is not necessary and merely
acts as an optimization.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/kvm/arm.c              |  8 ++++++--
 arch/arm64/kvm/pvtime.c           | 11 +++++++++--
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 36b8e97bf49e..4c7bd72ba9e8 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1166,7 +1166,7 @@ static inline bool kvm_arch_pmi_in_guest(struct kvm_vcpu *vcpu)
 
 long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu);
 gpa_t kvm_init_stolen_time(struct kvm_vcpu *vcpu);
-void kvm_update_stolen_time(struct kvm_vcpu *vcpu);
+int kvm_update_stolen_time(struct kvm_vcpu *vcpu);
 
 bool kvm_arm_pvtime_supported(void);
 int kvm_arm_pvtime_set_attr(struct kvm_vcpu *vcpu,
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 59716789fe0f..4c7994e44217 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -974,8 +974,12 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
 		 */
 		kvm_check_request(KVM_REQ_IRQ_PENDING, vcpu);
 
-		if (kvm_check_request(KVM_REQ_RECORD_STEAL, vcpu))
-			kvm_update_stolen_time(vcpu);
+		if (kvm_check_request(KVM_REQ_RECORD_STEAL, vcpu)) {
+			int ret = kvm_update_stolen_time(vcpu);
+
+			if (ret <= 0)
+				return ret;
+		}
 
 		if (kvm_check_request(KVM_REQ_RELOAD_GICv4, vcpu)) {
 			/* The distributor enable bits were changed */
diff --git a/arch/arm64/kvm/pvtime.c b/arch/arm64/kvm/pvtime.c
index 4ceabaa4c30b..ba0164726310 100644
--- a/arch/arm64/kvm/pvtime.c
+++ b/arch/arm64/kvm/pvtime.c
@@ -10,7 +10,7 @@
 
 #include <kvm/arm_hypercalls.h>
 
-void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
+int kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
 	u64 base = vcpu->arch.steal.base;
@@ -20,9 +20,14 @@ void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 	int idx;
 
 	if (base == INVALID_GPA)
-		return;
+		return 1;
 
 	idx = srcu_read_lock(&kvm->srcu);
+	if (gfn_to_hva(kvm, base + offset) == KVM_HVA_ERR_USERFAULT) {
+		kvm_prepare_memory_fault_exit(vcpu, base + offset, PAGE_SIZE,
+					      true, false, false, true);
+		return -EFAULT;
+	}
 	if (!kvm_get_guest(kvm, base + offset, steal)) {
 		steal = le64_to_cpu(steal);
 		vcpu->arch.steal.last_steal = READ_ONCE(current->sched_info.run_delay);
@@ -30,6 +35,8 @@ void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 		kvm_put_guest(kvm, base + offset, cpu_to_le64(steal));
 	}
 	srcu_read_unlock(&kvm->srcu, idx);
+
+	return 1;
 }
 
 long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu)
-- 
2.45.2.993.g49e7a77208-goog


