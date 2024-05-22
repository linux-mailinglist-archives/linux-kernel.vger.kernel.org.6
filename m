Return-Path: <linux-kernel+bounces-185692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CC48CB8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5EB1C22B93
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDAA78C9B;
	Wed, 22 May 2024 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDMlOaiO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432377117
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716344919; cv=none; b=uS2rcigMY3l+2hpKf/ok4ndorElH4tKLHHoHml7u6bjiD2TY7VTW/aDSl5Kv6YkgI3eZ5lAI01MzlzghZDPycAENSYBo3V9/K+BjEpgF2wE/rHTKWuaIhH/JnXjH8mszsVChmE4dsHU5o5SIglZsvXUfjdnHWQ10eodcgAmQhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716344919; c=relaxed/simple;
	bh=KseKQYsb65izy3p8V2zuq91stQnrQDY996NaeIaADEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IL9wjhHq9rMmgCIFimqmGEYpyiD9L9fs3EBYESPQYIcPJoe1jWdEvHBY3qQXIT+k+0TXJnAouzBN2uvVHVxZI3M2kJsyWGsynsCPRp0oop2rmlkb6OiLuzGYHVZHDOiwf6Zms01DB2mm3tEjvZRmoXtUtiQs7ReX+/yE1euo2Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDMlOaiO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61510f72bb3so258580527b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716344917; x=1716949717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UTESscmE2xSGNRqbvGygf0O1f1TGKn697WGvKKO3Gn4=;
        b=ZDMlOaiOr5AEy584EEzaoBwvO0dJKfmGacKAtIK7k3cdRPqHbLjajoUKGzS0ngI+Wk
         /Zo2jxdfxxnj67Dngk4azuu4ePxsxWH5iP7GaBDZq94Aia5yYFwenEsLCVCRzO1bE/Bg
         ApPNqAut0+FRd5QQhVeYtUn3+rI3SDiN6T14QJ66k5Q9VXz3r4fA11/5LPtXG35SEmPH
         962yOJsmKRk7LMAvXL/1KtF9FIjB1XVwCS6OvOu+BV4MzHqiZ5S7syKMbynJpi1spNOF
         fxxvQn+wgslriGNcDyN8yKIuhlyQ+6bcdX6I50Fn12ST4nZhhZhmMrzrPSmsZCFD8iQh
         +DOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716344917; x=1716949717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTESscmE2xSGNRqbvGygf0O1f1TGKn697WGvKKO3Gn4=;
        b=BGuEvXl0wbtrftPtrquH/P+PsrhSp4HlQ/UNvzT8b4DJCSnnO0y7+fyweJnboKrBHk
         WO/pMJR2Hs5ihyV4qWg9Xj1bfCIMsf14hGZ/UTjZi9vemHIeCOms291Mxj6b4FW2flNs
         pYcWzP92upPXcOcV+YXIUuHQmRoHjmFEwRVB3wULSamv7MwxjWxzhsDvfVcpv5bzMM1W
         wbAQlxGzEFZJ1RBgF3F4aXSxfv1sYIb0KBw+sSGduWwq4HsMhsMssUSGHG4vAmhhVWJO
         7WWRmLUAxktGwzPnvlbqk5dwbtLiVpgAQfX2rC8LvPFaa4uunWT2WzfjmJZpKtqNMh0P
         8vSw==
X-Forwarded-Encrypted: i=1; AJvYcCVHg/Zxuf0vQGnzQGHz5Y8cCa8zMxx8e0pqxcLedE4MxK0FdAF4rwTYLGAI6zMVsqYV7UTy5GWfWcNrpJySe6+wOSecU6EPqcByELUW
X-Gm-Message-State: AOJu0YwphI/1k9JkBV3wYKILt9kQm5aRytGt8Uz4ONJWqJqSiFK90t6G
	q0wmr2pYXzIDPW2K0Eq03ByJJCNboCNDLQSexMPX8wTcbNs2sRMC6DgLtH5Cq84hJwUVZdWWYLH
	6mg==
X-Google-Smtp-Source: AGHT+IFj3m2fqiWDNTeWfp9mIyuoi+I7yJ0zJE2+dXnbjZcTREYleLX/EXiF+L/nTpNHlZFB0o0jcqdFrk0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6612:b0:61b:e2e7:e127 with SMTP id
 00721157ae682-627e46855bamr2380847b3.1.1716344917175; Tue, 21 May 2024
 19:28:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 21 May 2024 19:28:25 -0700
In-Reply-To: <20240522022827.1690416-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522022827.1690416-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240522022827.1690416-5-seanjc@google.com>
Subject: [PATCH v2 4/6] KVM: Add arch hooks for enabling/disabling virtualization
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add arch hooks that are invoked when KVM enables/disable virtualization.
x86 will use the hooks to register an "emergency disable" callback, which
is essentially an x86-specific shutdown notifier that is used when the
kernel is doing an emergency reboot/shutdown/kexec.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7b57878c8c18..701b16290932 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1514,6 +1514,8 @@ static inline void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu) {}
 #endif
 
 #ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
+void kvm_arch_enable_virtualization(void);
+void kvm_arch_disable_virtualization(void);
 int kvm_arch_hardware_enable(void);
 void kvm_arch_hardware_disable(void);
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8d331ab3aef7..16adeb6b5bef 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5505,6 +5505,16 @@ static DEFINE_PER_CPU(bool, hardware_enabled);
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
 static int __kvm_enable_virtualization(void)
 {
 	if (__this_cpu_read(hardware_enabled))
@@ -5604,6 +5614,8 @@ static int kvm_enable_virtualization(void)
 	if (kvm_usage_count++)
 		return 0;
 
+	kvm_arch_enable_virtualization();
+
 	r = cpuhp_setup_state(CPUHP_AP_KVM_ONLINE, "kvm/cpu:online",
 			      kvm_online_cpu, kvm_offline_cpu);
 	if (r)
@@ -5634,6 +5646,7 @@ static int kvm_enable_virtualization(void)
 	unregister_syscore_ops(&kvm_syscore_ops);
 	cpuhp_remove_state(CPUHP_AP_KVM_ONLINE);
 err_cpuhp:
+	kvm_arch_disable_virtualization();
 	--kvm_usage_count;
 	return r;
 }
@@ -5647,6 +5660,7 @@ static void kvm_disable_virtualization(void)
 
 	unregister_syscore_ops(&kvm_syscore_ops);
 	cpuhp_remove_state(CPUHP_AP_KVM_ONLINE);
+	kvm_arch_disable_virtualization();
 }
 
 static int kvm_init_virtualization(void)
-- 
2.45.0.215.g3402c0e53f-goog


