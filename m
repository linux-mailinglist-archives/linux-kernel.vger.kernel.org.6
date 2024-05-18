Return-Path: <linux-kernel+bounces-182718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9358C8ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333901C20BDD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2D2383BD;
	Sat, 18 May 2024 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKW/Z5a/"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5861754B
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 00:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990695; cv=none; b=tTSvF05VPO7s4Yzd0mLzcsN+TE+Eor6t8cTLzd3LsAodRlOkU7Nge5cV0OymJ0yo0hB/Q0uEIs5/VRRGBDhUiZze4fba6u7Y72eV/fRzFQFPeKF3G8lcZH1gXr4ids7ZbdrxtROBWVkNxafm92NU/8maRrgoLKGM23zqYy+lUzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990695; c=relaxed/simple;
	bh=7aTw1q5fF2jfF8qaFVxCQ7vKf0J6QUU/de4LqX2pZiU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mVtLzleFI+fQsCcc3XW8dvzTKH4ievLmX8MM4PIz/nqSKbHmYW3/WyPioHdllYI4zw+pVzxlpy812QXh/wYHMbgJHwHqBcqSZH7fSeCRrR6DbPIqj3bb5InNwXf+Q4Uf/HDVonzfx3u1zLJlFo3lPz5XVy4oe6BC5/qn0PLlFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKW/Z5a/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ba04ab5e2cso2794293a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715990694; x=1716595494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KaG30rbQSApl1hJFQFNfcRVacF/4y69sxTalkt/kPiY=;
        b=uKW/Z5a/2ekjqeq56LcRExA4lIDRl6EKXz4E97VoDd5NdAEjVOQ3/5YbV1PKzGcL92
         onkw/aTfPFMtU8BO+aU3mk+OSZmodXEdQVZJ6xhtwxC1ON7zw6LDyHBsAdHkpJSB9lOt
         yx8ftTszYtYEb0mKu8M19vIU5px/i8l5Her8A/neOc5Pi9kRN4kXqAgdKxSGolNybTMP
         0WQa8DXIqFO75uaz4vjcSQ61PPQIppBiV0ML2RtdZdlERw/MbCSUgVy+ZnOwB8XMuy/f
         /+EQKbCWL2hlsOskb0dj73gC126eCEWS3JcQOGXgv192j6gCpys2LfZs1JEk5tk7jw7U
         t65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715990694; x=1716595494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KaG30rbQSApl1hJFQFNfcRVacF/4y69sxTalkt/kPiY=;
        b=e7LlYAFedHmWE/9u8GyUfT7dRYNEs6XWv++CMYSZZmYqB+aAIWfPOyaThlU7c1K0Kp
         kIA2xlBZC9kObVCQJBtqwqgFwbvenloiy1QFMXesUwl9DuqiW7oaEH8e85s0sCIYkRrw
         awvLKIYvSgKy03uPnKIh9eriHskD68+dZrHRSZbTBiIZLFHBOt7gh1114VBm5okY0Wmq
         fbJ1Z6kK0MFXbq+wOnXIToEGW3ohBLE7q9OCbwKK9koTEj6tL1G4EMQM6bAXIlhB3xnQ
         WBCd9iJEzVtcyWDyRdgIlloVe3MJgpdR/8iAkkPyj5GpGhPrWfYYRPrp3VGmXkX3TG7z
         KJBw==
X-Forwarded-Encrypted: i=1; AJvYcCVg4el69FZWaqDxt/9LU/iY9cWnvhdoU3Fzxn433zRIzlF05nCO8X8ONXp29z1Bk4mZuo+HscGXQw9Mo32arV6auo6IWXDfTGpT+/qL
X-Gm-Message-State: AOJu0YwHAPCaL41d2Kg3gSAeIKQoWhlD3HU+ZmPVdkxCplhODPXG3qR7
	J6+fZA4flOpxdgzSH6+6IRLZUZnymz/Nt4FGurSoJS293shanvPJ/XYZQ4n5w6e7+tUoYQLG53o
	0NA==
X-Google-Smtp-Source: AGHT+IEbccThIlHdBUKBF+9ohVSG5QaFMw6xK62nY9XRpFOKV92TLuuJQe5NE/0y95hCq2GrvpgsmmwHd5k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d80b:b0:2a7:4bb8:b24e with SMTP id
 98e67ed59e1d1-2b6cc453033mr63941a91.1.1715990693657; Fri, 17 May 2024
 17:04:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 17:04:30 -0700
In-Reply-To: <20240518000430.1118488-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240518000430.1118488-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240518000430.1118488-10-seanjc@google.com>
Subject: [PATCH 9/9] KVM: x86: Disable KVM_INTEL_PROVE_VE by default
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Disable KVM's "prove #VE" support by default, as it provides no functional
value, and even its sanity checking benefits are relatively limited.  I.e.
it should be fully opt-in even on debug kernels, especially since EPT
Violation #VE suppression appears to be buggy on some CPUs.

Opportunistically add a line in the help text to make it abundantly clear
that KVM_INTEL_PROVE_VE should never be enabled in a production
environment.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 2a7f69abcac3..3468efc4be55 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -97,15 +97,15 @@ config KVM_INTEL
 
 config KVM_INTEL_PROVE_VE
         bool "Check that guests do not receive #VE exceptions"
-        default KVM_PROVE_MMU || DEBUG_KERNEL
-        depends on KVM_INTEL
+        depends on KVM_INTEL && DEBUG_KERNEL && EXPERT
         help
-
           Checks that KVM's page table management code will not incorrectly
           let guests receive a virtualization exception.  Virtualization
           exceptions will be trapped by the hypervisor rather than injected
           in the guest.
 
+          This should never be enabled in a production environment.
+
           If unsure, say N.
 
 config X86_SGX_KVM
-- 
2.45.0.215.g3402c0e53f-goog


