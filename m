Return-Path: <linux-kernel+bounces-206545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B17A900B38
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADEC1B234EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926619E7D3;
	Fri,  7 Jun 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVhJSPCi"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF519ADAE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781185; cv=none; b=DHe5ZG0AP725GkQmS0FKgFpHmMc5VDwT/PQWdhDwxORC43gAzVxP1gZUFkQMhPGJkgtwb3/YxVNsNXIIoS0OKEQv2da4ar+eW/5simUOg8SUXaMoFniSkUFxr3DrLkxogl/pAlMLB2+WYKFWLx9aYhcMKlLhZKa3cU9NmxGrXDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781185; c=relaxed/simple;
	bh=k3uT5XlI3ypHnkmLELkYUkwKaO/W0Vb6n7fa+JWmkAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HcvbHMDXGmS5jmpllb49BOXq0nvB0Jf9MHpN0G+SrlY0gtfblXMCXSGY4OuV6phlcLfsNb9p6IYWNkXuZ1pOfunC1cPZUS/5kIbtWaVk08S+dyfplpV3xQMf77Z8EbALULhvg2SL4aMlv/SrSpqLzpp7fASiw0CdMT3xOxCS/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVhJSPCi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c1a9e8d3b0so1829738a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717781184; x=1718385984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=imi/dSYgg4r8Xm2pV7Tc7IPLLCcd51djYuqB8UoSynw=;
        b=gVhJSPCiy/xmMy+io9LvM3vlstRFcRXZ818xvTziOsyK6QYvglbT0rDny7t3DrIyEA
         A6QL7eAA2FLpDiUyOV4XSoyljaTYSQLi6VRrWmMzLFO7LZjHhky4w5rJbRdGA9EQn/XC
         Omb29/5HVAUEQbIA4b+fIRErJ8avBy+vJaJfh5G6t/cHJqhUchwVWvOzqTzl/E3MNLhD
         70RGYEW8w0HQoNGver9ikXbephNn0SWmvIwiCzqNXsEgtoVPc+zh38w0ykLfmrUMwrrT
         zdzs7JtRSqEy8+h+ykSu97LEmLTaO+TBh+/Xs2TjKL2FbUBk7BsOpnKt2+c/5O2CjtT2
         Cnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717781184; x=1718385984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imi/dSYgg4r8Xm2pV7Tc7IPLLCcd51djYuqB8UoSynw=;
        b=ZFlkr6yPP3d3Lhr7QLQ/jlqvJXmoON7C04ww2l66bTJYEqNlgmknqGzycKS7bSo/4U
         kd6V/wOPqJQ95Uft25tNEOnfvrOu2Gl21jVIXOnp8rxQBEEwsQCMoD1DP+VKaUPq4Vp2
         U9TO4HwHxh2gwJDM+psSBctB2k5ZALK2+cUsyHYhDs4Qfjee2RISootN3zeEfhFD+rT0
         g/8yqnhRxAK0pEHyajEeKEJoR/t62gVVNCHqmIXmgV4Q7n3FWDwFfekFZTmJ1szn4GB7
         qTaND6c7v85jaIQa6cJQnONDhBQ9NKxi3x4jGg6eaXRVSEd85sy0eOLsY4aavnLWpG+p
         RvOw==
X-Forwarded-Encrypted: i=1; AJvYcCVIBw/29Z2wZk6UBBT9f6ckQyNbxMdFhqIF70Ex63GSTh1Q4CoEY3hK/ZnNe+Fey7DKeP2yfQAkq16tRFgf+07wqH7UDAOEjqlRFgrS
X-Gm-Message-State: AOJu0YyHAqccSRJiEqOVT/YCKtnXCW9+4/Up7CGywAKsuzelESPf07YS
	rdngo770T1GkMPGmJm7BrXU/caDHxFPU2aydqL/BKOVur6VPaqXN4hDKsb5/lcGMijOoXj8nTdx
	+zQ==
X-Google-Smtp-Source: AGHT+IG6nFvgtkoQJtWh/SJojCthYFNtSi07s94PAk8NWpUcvQDU80zrybcyumoWHUKops6ND1JkBsWVY/Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2752:b0:2bd:f679:24ac with SMTP id
 98e67ed59e1d1-2c2bc790091mr8377a91.0.1717781183524; Fri, 07 Jun 2024 10:26:23
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  7 Jun 2024 10:26:09 -0700
In-Reply-To: <20240607172609.3205077-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240607172609.3205077-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607172609.3205077-7-seanjc@google.com>
Subject: [PATCH 6/6] KVM: x86: WARN if a vCPU gets a valid wakeup that KVM
 can't yet inject
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if a blocking vCPU is awaked by a valid wake event that KVM can't
inject, e.g. because KVM needs to completed a nested VM-enter, or needs to
re-inject an exception.  For the nested VM-Enter case, KVM is supposed to
clear "nested_run_pending" if L1 puts L2 into HLT, i.e. entering HLT
"completes" the nested VM-Enter.  And for already-injected exceptions, it
should be impossible for the vCPU to be in a blocking state if a VM-Exit
occurred while an exception was being vectored.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 82442960b499..f6ace2bd7124 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11233,7 +11233,10 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 	 * causes a spurious wakeup from HLT).
 	 */
 	if (is_guest_mode(vcpu)) {
-		if (kvm_check_nested_events(vcpu) < 0)
+		int r = kvm_check_nested_events(vcpu);
+
+		WARN_ON_ONCE(r == -EBUSY);
+		if (r < 0)
 			return 0;
 	}
 
-- 
2.45.2.505.gda0bf45e8d-goog


