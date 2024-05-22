Return-Path: <linux-kernel+bounces-185690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E5F8CB8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3B31F26728
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F63977F2D;
	Wed, 22 May 2024 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBtaFWYS"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFF27580D
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716344917; cv=none; b=NZXjsqclToD7jorLWunq6/Yvf4dBhoY910JFhbet96rkTdWFGADakPPyc+03dNe8hPL2I3toVEoy8nucC+dDzCImKbarYF9f104oYAZzo2y1a1AiOBtk5CR7UveVTW4lUtBJlv+VPJaESiWTrMpXPLZz/9uLMgZ5ZHrED7q03Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716344917; c=relaxed/simple;
	bh=UxQT87o44GpQPdmmQ9RElOqqQyGOJ8CmTiYc4Jwt3vQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L/wvtheGkXMIE3iKPrZP63qop/Ov0Ac1z0wX77BF49mUnENnQDXHcobLaTmkEAdvRbccVuF5FMVv0VfYWmIVvKXZ+q++I6w4Pnl+w+4fYH+3ma2M/T1ZH6WtKtFBp1OZ+ZcEqdG18hIQQSK+FPzBuzs2uDGSdRigjlPonzAjz+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBtaFWYS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ba0fd5142dso348946a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716344915; x=1716949715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=l54COnjdm6bBuuKu60Lhz71aEXp/tIUjbNfI6k631P8=;
        b=kBtaFWYS8RucusTik4JurLeY8XShRomSc8eoNC1fD840mH+Xhv8eIuI0QeZdd4OIfv
         ClPAvFrITdUlVMunJxDd75SgZkHfGHJjyHXQcs5zSyyvsbCbMn678xU0mCkG+ze1j/yB
         DwvftSUOOhvRBKXapWb0UKG2Ol0VfT1xabVKnd/GjJFff5mOjnoTntOJPe/oauS6JM5f
         sD1mUZp7vaUoVJfNdAf2RXCQPe4r9aUkUQdunjZZnVTwa9uJ+WavuZpBHAh/MsiV7kce
         R/vDi2d3wrbJMXocxYe6k6KkWif5FyZl9kByrXrrDS4GCCCV7MAnM/JfW2PMMaFHA1tF
         0k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716344915; x=1716949715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l54COnjdm6bBuuKu60Lhz71aEXp/tIUjbNfI6k631P8=;
        b=cYp+rh9zLHrvtJ6XnMCgXMv89kWve5y3k+VZmzH/wvKoiwtsk7vMOJPc5/QAblS8GE
         wUyLiAvLQ5LrAGkBH6gKNn5rMyH5T+NLCT5cEMD3hcBa5zCFJKie3iELoks2iUiL2FTn
         dT9EydsHKoUw+9opsghRjGeCC1tG/6jXKy8rf1axdmIDiFsipvg006CJm73SF2lsH+9g
         FyS929ckVOk7G/eox4zMWVYEcpiNkNTn3banGq7Gx8q9SbEL3ED825H1F6rkcifrBrSr
         0U2kcD0J1uzQ8HJx5mqqKxjSBUeMhSbBeMPe2eoUJ+Nv+8Z98Kn3CL9f1sSZ02Tkxb5r
         Umlw==
X-Forwarded-Encrypted: i=1; AJvYcCVpEgmxJWejVkLaZubM7z/ImQXaSU2AIdOMJJ5uiTqa/kUp858tZ9PSN9Cijt3eibTXXdI4eqKiDq+PfxWhI1RGgfkuC2KEjn0cdfFD
X-Gm-Message-State: AOJu0YxtmMW5PagrHswbDaXT7VedPNkDZHPtckGHoctsRK1vd9gKwKo3
	pe++gLASP0ruygCiEGslYYsjIMr4YRoUVuOwHK7XOX5si7tW3FjGEtZy8A358Vh9dwgtuQr+A05
	t+g==
X-Google-Smtp-Source: AGHT+IEggpUCE1TXWoxuVSp1D45sXZttcemhdyFN0WeD/tg/jKWqCjQCD1n159cl7D3wuZPwQTJigyvwb+s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1903:b0:2b6:4220:159d with SMTP id
 98e67ed59e1d1-2bd9f5db1a2mr11666a91.3.1716344915357; Tue, 21 May 2024
 19:28:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 21 May 2024 19:28:24 -0700
In-Reply-To: <20240522022827.1690416-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522022827.1690416-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240522022827.1690416-4-seanjc@google.com>
Subject: [PATCH v2 3/6] KVM: Add a module param to allow enabling
 virtualization when KVM is loaded
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add an off-by-default module param, enable_virt_at_load, to let userspace
force virtualization to be enabled in hardware when KVM is initialized,
i.e. just before /dev/kvm is exposed to userspace.  Enabling virtualization
during KVM initialization allows userspace to avoid the additional latency
when creating/destroying the first/last VM.  Now that KVM uses the cpuhp
framework to do per-CPU enabling, the latency could be non-trivial as the
cpuhup bringup/teardown is serialized across CPUs, e.g. the latency could
be problematic for use case that need to spin up VMs quickly.

Enabling virtualizaton during initialization will also allow KVM to setup
the Intel TDX Module, which requires VMX to be fully enabled, without
needing additional APIs to temporarily enable virtualization.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8ba2861e7788..8d331ab3aef7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5495,6 +5495,9 @@ static struct miscdevice kvm_dev = {
 };
 
 #ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
+static bool enable_virt_at_load;
+module_param(enable_virt_at_load, bool, 0444);
+
 __visible bool kvm_rebooting;
 EXPORT_SYMBOL_GPL(kvm_rebooting);
 
@@ -5645,15 +5648,41 @@ static void kvm_disable_virtualization(void)
 	unregister_syscore_ops(&kvm_syscore_ops);
 	cpuhp_remove_state(CPUHP_AP_KVM_ONLINE);
 }
+
+static int kvm_init_virtualization(void)
+{
+	if (enable_virt_at_load)
+		return kvm_enable_virtualization();
+
+	return 0;
+}
+
+static void kvm_uninit_virtualization(void)
+{
+	if (enable_virt_at_load)
+		kvm_disable_virtualization();
+
+	WARN_ON(kvm_usage_count);
+}
 #else /* CONFIG_KVM_GENERIC_HARDWARE_ENABLING */
 static int kvm_enable_virtualization(void)
 {
 	return 0;
 }
 
+static int kvm_init_virtualization(void)
+{
+	return 0;
+}
+
 static void kvm_disable_virtualization(void)
 {
 
+}
+
+static void kvm_uninit_virtualization(void)
+{
+
 }
 #endif /* CONFIG_KVM_GENERIC_HARDWARE_ENABLING */
 
@@ -6395,6 +6424,10 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 
 	kvm_gmem_init(module);
 
+	r = kvm_init_virtualization();
+	if (r)
+		goto err_virt;
+
 	/*
 	 * Registration _must_ be the very last thing done, as this exposes
 	 * /dev/kvm to userspace, i.e. all infrastructure must be setup!
@@ -6408,6 +6441,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	return 0;
 
 err_register:
+	kvm_uninit_virtualization();
+err_virt:
 	kvm_vfio_ops_exit();
 err_vfio:
 	kvm_async_pf_deinit();
@@ -6433,6 +6468,8 @@ void kvm_exit(void)
 	 */
 	misc_deregister(&kvm_dev);
 
+	kvm_uninit_virtualization();
+
 	debugfs_remove_recursive(kvm_debugfs_dir);
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
-- 
2.45.0.215.g3402c0e53f-goog


