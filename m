Return-Path: <linux-kernel+bounces-308042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DFA965676
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374C01C20DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F21114D6F6;
	Fri, 30 Aug 2024 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MaWDI5qs"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00A3161936
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724992583; cv=none; b=GAz8ipKLh3igq+brmLDbykP60/WmPYZsxy+jAuvz3SS20d10tKEQm19zcXm1sbVGAnUk8MtlTKhtc1/q0aVSvlfVNFfepwi1leIbqtXFF00x0yEa7pIy1FtXsavVbFWRpdjSGOaJteY1hRNv5SAwOt5kIEIICi8mQOXRy7zsUn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724992583; c=relaxed/simple;
	bh=dkoydZWsfrh+v9zcazAPXepH7bmtcVEdXIe2ya2h+0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SzjsKL0uleYRDUvs9s+0o0z/6JqR/EVmD9f1muXaJO13UvU/7tt725OqhwYNqCXxgemuTQVtOss8HjiVrCcpH3HQwvtbJ1lhui3VL4Kvwm/pKlHPxO/SDxSwBwuojD58/sM7sOtEPhJ6Sw1jKB3JiQkilu/ZQcgcn9iCfY4BbG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MaWDI5qs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ad97b9a0fbso29502047b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724992581; x=1725597381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=k204YuuBNkPIQSpU0QhI7EvnHBfhBz5F6jzs/OiMdls=;
        b=MaWDI5qszdAgTgkdpCd1+MjTEHhat+qyoS3ZD/8w4ESKewWVDC34WlSD5vkekGgEH4
         qbWobXAm1XYCJZuvUx6yBfGaNnfe9uiqZorqadIfVxRmKjtlPzNlrDixT5fPoLdaFA/Q
         Dgtev2ZsIzv30bOiehSD4L0kVrFn9u8+MRlQzmi5hYw7hIra3HeI1VeLFNVbxUXeCpeE
         QAn/y8ZnQoheSLzx3o7Dr04vo1akL9+4mBFVdjUrTouEYw55NurvviJH2ns4aIfsB7K1
         PJBGq9LvdtCYYeItKhVa9NT+1ewYepDDHrqYKDugbtbYGH7l0aQNi4yF/i1J3q8fpCso
         4OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724992581; x=1725597381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k204YuuBNkPIQSpU0QhI7EvnHBfhBz5F6jzs/OiMdls=;
        b=wJN96RPiTX3g08aEQoA96xImVf0LwedHP6utDU8ItgNLEoHhdIRRPILO6xVEkL4vMP
         zDkeyDuEeB6jg+uloDeNkWBmt7X4XqgfAWhDsaeBkJak/+GfsI/x4hkor8ATiDt+5gCb
         +IsHNkKlqM1798rTWEydpNkmXDKjuqztE2Kiy46CgK4noR6JYIxV9mPAhPXnD2gEBgS1
         AAjzgdfoji0VLpDzHanQnXt4SlC+6mir06RDXdnQWp7UhAAhFB8BvjA8ZErrzhQ7T3N6
         Ff2pzWOdbcSuSA/V+Xfc188QnKX7WtABu38wvmRmWiov/RvH71gtFm1+hlUQtixhQcAY
         CnPg==
X-Forwarded-Encrypted: i=1; AJvYcCUmVCeisHvYRw1xe8yJBr7mkl7evwCnl4QmcvehakN1T5V6W1i125j7KkV1A010Az5UAtxZ/fcj7ZioiwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPZO5hWvUZBOzIv0yOrmO+nMKSglSlpPy5BPUkA9G2L1d/a91m
	orZyqtj298yga3W56LCCTb6/ZV+P4/t1RSIgH/ctFUiag0F8ZrigoPEXKlGPaLPtMYvp26Z1lOD
	Bhg==
X-Google-Smtp-Source: AGHT+IH7doeLworevO5q5a0Cpx/I2Hf/rkCrWJ1Q/dDQPDqM64XFN6CvEdH2toTw5kd6ygYMiJVKDoge7UM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:e1f:b0:650:93e3:fe73 with SMTP id
 00721157ae682-6d41000b45bmr405537b3.5.1724992580739; Thu, 29 Aug 2024
 21:36:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 Aug 2024 21:35:58 -0700
In-Reply-To: <20240830043600.127750-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240830043600.127750-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240830043600.127750-9-seanjc@google.com>
Subject: [PATCH v4 08/10] KVM: Add arch hooks for enabling/disabling virtualization
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Chao Gao <chao.gao@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Farrah Chen <farrah.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add arch hooks that are invoked when KVM enables/disable virtualization.
x86 will use the hooks to register an "emergency disable" callback, which
is essentially an x86-specific shutdown notifier that is used when the
kernel is doing an emergency reboot/shutdown/kexec.

Add comments for the declarations to help arch code understand exactly
when the callbacks are invoked.  Alternatively, the APIs themselves could
communicate most of the same info, but kvm_arch_pre_enable_virtualization()
and kvm_arch_post_disable_virtualization() are a bit cumbersome, and make
it a bit less obvious that they are intended to be implemented as a pair.

Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 14 ++++++++++++++
 virt/kvm/kvm_main.c      | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 63e46a5f3812..50ace701d468 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1514,6 +1514,20 @@ static inline void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu) {}
 #endif
 
 #ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
+/*
+ * kvm_arch_{enable,disable}_virtualization() are called on one CPU, under
+ * kvm_usage_lock, immediately after/before 0=>1 and 1=>0 transitions of
+ * kvm_usage_count, i.e. at the beginning of the generic hardware enabling
+ * sequence, and at the end of the generic hardware disabling sequence.
+ */
+void kvm_arch_enable_virtualization(void);
+void kvm_arch_disable_virtualization(void);
+/*
+ * kvm_arch_{enable,disable}_virtualization_cpu() are called on "every" CPU to
+ * do the actual twiddling of hardware bits.  The hooks are called on all
+ * online CPUs when KVM enables/disabled virtualization, and on a single CPU
+ * when that CPU is onlined/offlined (including for Resume/Suspend).
+ */
 int kvm_arch_enable_virtualization_cpu(void);
 void kvm_arch_disable_virtualization_cpu(void);
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 55779fbb37ec..9ae4bd8a3712 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5582,6 +5582,16 @@ static DEFINE_PER_CPU(bool, virtualization_enabled);
 static DEFINE_MUTEX(kvm_usage_lock);
 static int kvm_usage_count;
 
+__weak void kvm_arch_enable_virtualization(void)
+{
+
+}
+
+__weak void kvm_arch_disable_virtualization(void)
+{
+
+}
+
 static int kvm_enable_virtualization_cpu(void)
 {
 	if (__this_cpu_read(virtualization_enabled))
@@ -5681,6 +5691,8 @@ static int kvm_enable_virtualization(void)
 	if (kvm_usage_count++)
 		return 0;
 
+	kvm_arch_enable_virtualization();
+
 	r = cpuhp_setup_state(CPUHP_AP_KVM_ONLINE, "kvm/cpu:online",
 			      kvm_online_cpu, kvm_offline_cpu);
 	if (r)
@@ -5711,6 +5723,7 @@ static int kvm_enable_virtualization(void)
 	unregister_syscore_ops(&kvm_syscore_ops);
 	cpuhp_remove_state(CPUHP_AP_KVM_ONLINE);
 err_cpuhp:
+	kvm_arch_disable_virtualization();
 	--kvm_usage_count;
 	return r;
 }
@@ -5724,6 +5737,7 @@ static void kvm_disable_virtualization(void)
 
 	unregister_syscore_ops(&kvm_syscore_ops);
 	cpuhp_remove_state(CPUHP_AP_KVM_ONLINE);
+	kvm_arch_disable_virtualization();
 }
 
 static int kvm_init_virtualization(void)
-- 
2.46.0.469.g59c65b2a67-goog


