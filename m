Return-Path: <linux-kernel+bounces-281422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC7894D6D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BD61C21AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475F216A955;
	Fri,  9 Aug 2024 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLU9QVMy"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092B91684AB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230216; cv=none; b=hL6bRo1iATtQ5l8LBJMlAKZGBFde3EeJGi/v2Zj9EqgRGDiN7XOIyIc7ypNPmkHiN+P0kKfoI+TM5ZrQaJb41NOi4bylyyDORhdvuxYnvS0Gfj26a52mRuTFoAnzjuHfekepZ6aG7/mRgmkM8yypm1noBENe5zSUIf/jhnz0ZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230216; c=relaxed/simple;
	bh=z+MxKCE9NuIwIw+7Qzhm3RReleKGu2hQZGUj5H5VOPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nkfv//9dsZaVv90oeopetfiliGThSGU2+DxEe4UuQMoWNiArqFqXApf3PggeoicshqcEU9ZllP70ZQqiehmTDtvsIWuk/ulSRRPL1oCeNm0mU3LOTmliKwdKSIv1Ri6ZwAWA3Cz/IkcMeIdA81uILX6ia8e+3RfTu9ECm034Bc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLU9QVMy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7a28f78c67aso2435020a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723230214; x=1723835014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OPGLZbFKP8CWiTTck6ADt4ijjePzDJ7PBKgxWrucHOI=;
        b=qLU9QVMyrGlfx9zlGzdJJRiuoYpyh0h/2JIr3QeGWq9NuGsphvy/yoBEfVBi9nlADP
         VGJLNNyIu1Y79ARtSZ+rPOgwZccUGubROkNFqYmKvfGFlLq7z0X6q7PE3R7FomXynYtF
         p/nYqPDv2oVUNjF5qLixp+p5ftX4UeWtgnNbEYenjyLC7s3Qii/RhEVVrpwTCpkSNhO9
         aWQcokWuY+TT7QkOrWKNYHQIBXOc2bdZAuN1UTs/mLmlgvJOZSeyA54EE4KslecthvYV
         +x25wqtPfKE6x4fGbA1pM/44H2EaSEs63VOnPbNsLJroA25Fn4w/NwOM4iG+Lkz3zuEv
         gJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230214; x=1723835014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPGLZbFKP8CWiTTck6ADt4ijjePzDJ7PBKgxWrucHOI=;
        b=JzZH+klpczTZ0BkF6PT2ftHT2qVP94tLtpDHujw6DmA/dKGcpFf5NH+/LZjaW+1zSy
         JJuremTgVWKMzQewwCAtM3arAI1CRyDDrrNwCuQMAxKbpJk79F8LZ2xyhvvsNm2nzILY
         hs/tS77nnXAkc3FSlkHekaym+3kOaLgxmuiyCJKSBM5F70SVZ5jgmTefTcReL6XGEzwX
         7JxzKmOzyzdsq4xlVnGkUDNAB0rLG5hbLGHKMFYzm/Z50eDQ8IxAoM7/bppisUDqCKq5
         Nh+tFeA07LOV/7gLsoQtPlrgYbrOggjk1I7noGEvzbtOYOkojs1tTu5OYQuLJyRMJxZf
         bV0w==
X-Forwarded-Encrypted: i=1; AJvYcCXWvnvJ3WvjsC4h+D6PT1PAd00MOZbtfmoZCf2zBblzlWT31RfgjkGhXgJxizksvR36taBzr7nwMPg7Xqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIhsfIMtL3HY38tFOtC2+43JHbLIeLqGf6oZPTv1QslgpleNV8
	2YZsEn3JevLHlIMHwagw0A9rfjL2P2lQCUEZSGpd9ycV5sKpCSLuhYrv9VR8AHoYXgZcN9qNd7M
	q5g==
X-Google-Smtp-Source: AGHT+IGhq7PH0PBhBiiGOey+3zlw6D8WzCjhgNtCKlfYkonI7WV9WfpMY5Brvwz4Erhp7Q90FZZ+mmQPmnQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:189:b0:200:98ed:3622 with SMTP id
 d9443c01a7336-200ae4e10damr1799675ad.6.1723230213995; Fri, 09 Aug 2024
 12:03:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:03:01 -0700
In-Reply-To: <20240809190319.1710470-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809190319.1710470-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809190319.1710470-5-seanjc@google.com>
Subject: [PATCH 04/22] KVM: x86/mmu: Skip emulation on page fault iff 1+ SPs
 were unprotected
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

When doing "fast unprotection" of nested TDP page tables, skip emulation
if and only if at least one gfn was unprotected, i.e. continue with
emulation if simply resuming is likely to hit the same fault and risk
putting the vCPU into an infinite loop.

Note, it's entirely possible to get a false negative, e.g. if a different
vCPU faults on the same gfn and unprotects the gfn first, but that's a
relatively rare edge case, and emulating is still functionally ok, i.e.
the risk of putting the vCPU isn't an infinite loop isn't justified.

Fixes: 147277540bbc ("kvm: svm: Add support for additional SVM NPF error codes")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e3aa04c498ea..95058ac4b78c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5967,17 +5967,29 @@ static int kvm_mmu_write_protect_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	bool direct = vcpu->arch.mmu->root_role.direct;
 
 	/*
-	 * Before emulating the instruction, check if the error code
-	 * was due to a RO violation while translating the guest page.
-	 * This can occur when using nested virtualization with nested
-	 * paging in both guests. If true, we simply unprotect the page
-	 * and resume the guest.
+	 * Before emulating the instruction, check to see if the access may be
+	 * due to L1 accessing nested NPT/EPT entries used for L2, i.e. if the
+	 * gfn being written is for gPTEs that KVM is shadowing and has write-
+	 * protected.  Because AMD CPUs walk nested page table using a write
+	 * operation, walking NPT entries in L1 can trigger write faults even
+	 * when L1 isn't modifying PTEs, and thus result in KVM emulating an
+	 * excessive number of L1 instructions without triggering KVM's write-
+	 * flooding detection, i.e. without unprotecting the gfn.
+	 *
+	 * If the error code was due to a RO violation while translating the
+	 * guest page, the current MMU is direct (L1 is active), and KVM has
+	 * shadow pages, then the above scenario is likely being hit.  Try to
+	 * unprotect the gfn, i.e. zap any shadow pages, so that L1 can walk
+	 * its NPT entries without triggering emulation.  If one or more shadow
+	 * pages was zapped, skip emulation and resume L1 to let it natively
+	 * execute the instruction.  If no shadow pages were zapped, then the
+	 * write-fault is due to something else entirely, i.e. KVM needs to
+	 * emulate, as resuming the guest will put it into an infinite loop.
 	 */
 	if (direct &&
-	    (error_code & PFERR_NESTED_GUEST_PAGE) == PFERR_NESTED_GUEST_PAGE) {
-		kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(cr2_or_gpa));
+	    (error_code & PFERR_NESTED_GUEST_PAGE) == PFERR_NESTED_GUEST_PAGE &&
+	    kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(cr2_or_gpa)))
 		return RET_PF_FIXED;
-	}
 
 	/*
 	 * The gfn is write-protected, but if emulation fails we can still
-- 
2.46.0.76.ge559c4bf1a-goog


