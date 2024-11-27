Return-Path: <linux-kernel+bounces-424048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB859DAFEE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8FD7B217EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 23:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF6119882F;
	Wed, 27 Nov 2024 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQyitDF/"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE815E5CA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732751223; cv=none; b=lNlAusTSmFj9Ja25BFIcprI/GDjblhjW9FguPMNWpHyzkdrapXCsJInFtE7RHUhQswF4g2G55oVrKowAvs8GJ/8JKVlLZzCNeK4CrdrEjBB88HvQzKWjI+ud4YIJCEV7jRm8lj9kc9nsb26GyE4meVmrfjAfVKPNLdPx893fHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732751223; c=relaxed/simple;
	bh=nd3J865/YZ+2VEz7ghltJB+9oC6ZlC3mBxeZJDrtEh0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Vy1m1tIbSf5IwtH3hg5afDsANejuJcfq9iM08BchKzlwFmXSWNvALNq9vVhwBJiPgm4t1+XutRv5hKXPHcTxUDNP+axdtvvZq+KN6oefIdSjiidwIXb3rLZWW6L6HyodH+Dre6GeBBaZjy2N1vdZiUYyw7sgxHb6LsjJnyCpPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQyitDF/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea8baba60dso247771a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732751222; x=1733356022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIulGb3qmhZUHKLGlDgu3ych7aY/kTKi7wptAAkUHH4=;
        b=sQyitDF/OkqWa7Zjai6v2DSN9JI1ZMP+c9yRQ28QWL09S8a5PqdHkkS0hvr4oKC+Bh
         AmUJJPdIcp873jRhDqO5cSxNEYPSf1X4ndIHMdJTLPlwJ2GkrqzYyr1q++4ANQj8Zopo
         /XFJ6q6a0jQSJGXfOYZfSY+RMfV52jl7A2NR+H/6yt2W3KliydRF702cBp0DmmhFcfEQ
         TrH4dfz+tRvMu7trINdeDTDLw8oMMCAxkFF24H0dALTNuLMXJyXvWqpqi9emgDsmiPJ1
         vCWxFrfNu0jcNVSX5UQI/WVmEhC3yT6Qb4u0LleMJTbdRMQpybGy0AAs5RVVtq8ptkTZ
         5bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732751222; x=1733356022;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIulGb3qmhZUHKLGlDgu3ych7aY/kTKi7wptAAkUHH4=;
        b=BlMwxSscS4nCob9iK6x2uTLT9nxDpasFd/3I4voLnSsZsIHSAutjyhVFS0cqtYYA2R
         BpDGOIzzLxmI6Vdun3PWi4JqPLCJGCWbEDykqrOV5mGq+KEa9Ct7XCqh+26jdNKj2I/R
         nHX0Ucq1fV8Nb7/oj/5gXaoUWkIDVuxF1qj5whubNZzRZqEwHdPQtiuJ29fLuxq1SjTi
         nsxb/B29r7Eob+NjRs1UeQQo0JsExHLsYk2t6O202+Mg+BLXg7NiNW/KF5W/YX9uaIcS
         hpIetX8sL4aElUuPPL20EsDR+1vDaBfIRsBq4RXJARqM0nzwy21xl/kLXqqTLitEb7An
         T2rA==
X-Forwarded-Encrypted: i=1; AJvYcCWsGeA5OGsk5nJAa68/adCje6DjAmpTuGDBkAUSNNrMJS51txdWGadcgOuigD5One1LR2NEgqaHjACLeCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/9zKgM9/vLwYBO8To1VwYOLxxxA4IMHqmghza/ol0dThdM2A
	iSJK+yNYFLZnvH2gub33Q1tLbKDy92+vyvqpzeRYfTG+1VwqkUuGbdPxz3kK7pntpSKHrUmZhsz
	h5w==
X-Google-Smtp-Source: AGHT+IEBfEA3SFEJ/e7q4DLhCeeHP2mhmWlaClqCNg6lR6N/PIHK+FBp/M05m9sAjCkl7gaROt6CrfMX15c=
X-Received: from pgbcw5.prod.google.com ([2002:a05:6a02:4285:b0:7fc:1f6a:c14a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2583:b0:1e0:d380:fe71
 with SMTP id adf61e73a8af0-1e0e09e2467mr8155703637.0.1732751221766; Wed, 27
 Nov 2024 15:47:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 15:46:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127234659.4046347-1-seanjc@google.com>
Subject: [PATCH] KVM: SVM: Macrofy SEV=n versions of sev_xxx_guest()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Define sev_{,es_,snp_}guest() as "false" when SEV is disabled via Kconfig,
i.e. when CONFIG_KVM_AMD_SEV=n.  Despite the helpers being __always_inline,
gcc-12 is somehow incapable of realizing that the return value is a
compile-time constant and generates sub-optimal code.

Opportunistically clump the paths together to reduce the amount of
ifdeffery.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.h | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 43fa6a16eb19..2f5d8b105eb0 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -358,39 +358,32 @@ static __always_inline struct kvm_sev_info *to_kvm_sev_info(struct kvm *kvm)
 	return &to_kvm_svm(kvm)->sev_info;
 }
 
+#ifdef CONFIG_KVM_AMD_SEV
 static __always_inline bool sev_guest(struct kvm *kvm)
 {
-#ifdef CONFIG_KVM_AMD_SEV
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 
 	return sev->active;
-#else
-	return false;
-#endif
 }
-
 static __always_inline bool sev_es_guest(struct kvm *kvm)
 {
-#ifdef CONFIG_KVM_AMD_SEV
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 
 	return sev->es_active && !WARN_ON_ONCE(!sev->active);
-#else
-	return false;
-#endif
 }
 
 static __always_inline bool sev_snp_guest(struct kvm *kvm)
 {
-#ifdef CONFIG_KVM_AMD_SEV
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 
 	return (sev->vmsa_features & SVM_SEV_FEAT_SNP_ACTIVE) &&
 	       !WARN_ON_ONCE(!sev_es_guest(kvm));
+}
 #else
-	return false;
+#define sev_guest(kvm) false
+#define sev_es_guest(kvm) false
+#define sev_snp_guest(kvm) false
 #endif
-}
 
 static inline bool ghcb_gpa_is_registered(struct vcpu_svm *svm, u64 val)
 {

base-commit: 4d911c7abee56771b0219a9fbf0120d06bdc9c14
-- 
2.47.0.338.g60cca15819-goog


