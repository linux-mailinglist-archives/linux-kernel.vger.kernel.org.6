Return-Path: <linux-kernel+bounces-309610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9E966D65
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212051C22226
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1300916F0E8;
	Sat, 31 Aug 2024 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ksu3PKTO"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C516DC01
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063388; cv=none; b=hlRf0DBYOx5NkJsqzPUQBnSBKQvwfoaqpvOWS3KfgSdwl/7sUL/1WYvksUzIArWvH8GgX9PzEYqEDcAfdEVsSE1i4FIulDgYdCRlGbbnsvrx+JSyHvuPWW1qvpfaz1SooJeK0GmMDswLZjWc5LqOsMhGdiokUvN/vENJuCgPUjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063388; c=relaxed/simple;
	bh=wP2W7KNm4uaZDYWeNWlAdBMglkxhSfv/7EU+XUEuEpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q4fX4kwjUd3aKFefiivmao3t2/qYHahk9s7aKT1qwGx2MdbelPpoKtnct96mz4xDRjQgE6lJo8zDDKXNZqCLGWXvJ2LNxIA0XJeDs5d+rCnVuwsufjd4c30yr44UCNFRUX4SegxyCPkqgG54wKP3P6bPJuyk0znoAy2lVeP9Tn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ksu3PKTO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-205428e6facso5173465ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063386; x=1725668186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gP7K1Sev7aMPsK1RhVpHEhmgUKxxDPKWFSHlKDQHYWk=;
        b=Ksu3PKTOOO4mxuAo6jd9hV464GRAdKdPpv/NZVShb8FV+EIBJH7n4cduy6DLOAtgyc
         Je3KWlcDmVEHo2gI7bj/zw96UV0EDNiXNh+foPKA54kr07ZVkC/fy672Jqp0vLbqNnXh
         UgFZk4Zvu5IG5kq2AoHGtO/4gUCO0/3/c5IwzB7lUw/taTvqBjVPurLsSYai+P2E3D+k
         lKA9ubIk7QKIper7UQJdo5dUvaYoTPFUSLZPssWgF8xLESR96XQOSjNUyRawOAEc7AJu
         NCpVVklH0zp5OPCwf9VqqyybNFfgND5eJIXFgpZm6t/bKQMef8DSHCI6d3R1CizKvoth
         zt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063386; x=1725668186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gP7K1Sev7aMPsK1RhVpHEhmgUKxxDPKWFSHlKDQHYWk=;
        b=ZO070hTfGNhJn2Oi/OvPfgskQnNgocnkmEtBSb/EyDLwlOy5F3FQLGmsDH41ZISIyJ
         hHNCy25LPRGXEWHkp61uZXznlrSYdLcRje7X2axtRIBYmN9sS6xQyk4igS5ouZ2fCW5F
         6SCXs9ZGMiU9xmnT6nev/vgsGcHrcfQ4zQeOtRZXM4zvTTwuKnXV/5liuBwJUaQHHO52
         f+aYmHoJMuMa4YctP6q8UXs1fz0oiQHeRz1RKCm0K898Xpk3943aZkN2kk1r+82au5Eu
         OjHOATiBa2nk7eyuwZH8HfDeKK1VcstC9t/jkKamVnc9KBC6q60ut55g6Ab3GM1eUujx
         1+ow==
X-Forwarded-Encrypted: i=1; AJvYcCU2M69GOskMLCLa1qvKQFwnVeU96tU9CBYskeEGqbA1TDs6zm8DKxbrAK7t+VvJl2AZLvsZocYyAIxATXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxH+ewshNg+weOkLv/WXKgDrNYnxHuiVTGwSH3uuTBUziFbckC
	zCuFhUoj/4TyjEzonNQ9IyC+7mSCBGCfqdDfXao57VX+0b51J9ZfjDfXZW8lWgrCuXGD6v72JF8
	dTw==
X-Google-Smtp-Source: AGHT+IETKE6MP4mUQ/pQIHpSlTqVQLzv82JDtckTBZhGegQc2MolI+RlmMC71D58MpTAuF2igBH8CH7kJwU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:fb0e:b0:1fb:7f2c:5642 with SMTP id
 d9443c01a7336-2052764073dmr769545ad.4.1725063386022; Fri, 30 Aug 2024
 17:16:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Aug 2024 17:15:37 -0700
In-Reply-To: <20240831001538.336683-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831001538.336683-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240831001538.336683-23-seanjc@google.com>
Subject: [PATCH v2 22/22] KVM: x86/mmu: WARN on MMIO cache hit when emulating
 write-protected gfn
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuan Yao <yuan.yao@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

WARN if KVM gets an MMIO cache hit on a RET_PF_WRITE_PROTECTED fault, as
KVM should return RET_PF_WRITE_PROTECTED if and only if there is a memslot,
and creating a memslot is supposed to invalidate the MMIO cache by virtue
of changing the memslot generation.

Keep the code around mainly to provide a convenient location to document
why emulated MMIO should be impossible.

Suggested-by: Yuan Yao <yuan.yao@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index be5c2c33b530..c9cea020aad6 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5990,6 +5990,18 @@ static int kvm_mmu_write_protect_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	vcpu->arch.last_retry_eip = 0;
 	vcpu->arch.last_retry_addr = 0;
 
+	/*
+	 * It should be impossible to reach this point with an MMIO cache hit,
+	 * as RET_PF_WRITE_PROTECTED is returned if and only if there's a valid,
+	 * writable memslot, and creating a memslot should invalidate the MMIO
+	 * cache by way of changing the memslot generation.  WARN and disallow
+	 * retry if MMIO is detected, as retrying MMIO emulation is pointless
+	 * and could put the vCPU into an infinite loop because the processor
+	 * will keep faulting on the non-existent MMIO address.
+	 */
+	if (WARN_ON_ONCE(mmio_info_in_cache(vcpu, cr2_or_gpa, direct)))
+		return RET_PF_EMULATE;
+
 	/*
 	 * Before emulating the instruction, check to see if the access was due
 	 * to a read-only violation while the CPU was walking non-nested NPT
@@ -6031,17 +6043,15 @@ static int kvm_mmu_write_protect_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		return RET_PF_RETRY;
 
 	/*
-	 * The gfn is write-protected, but if emulation fails we can still
-	 * optimistically try to just unprotect the page and let the processor
+	 * The gfn is write-protected, but if KVM detects its emulating an
+	 * instruction that is unlikely to be used to modify page tables, or if
+	 * emulation fails, KVM can try to unprotect the gfn and let the CPU
 	 * re-execute the instruction that caused the page fault.  Do not allow
-	 * retrying MMIO emulation, as it's not only pointless but could also
-	 * cause us to enter an infinite loop because the processor will keep
-	 * faulting on the non-existent MMIO address.  Retrying an instruction
-	 * from a nested guest is also pointless and dangerous as we are only
-	 * explicitly shadowing L1's page tables, i.e. unprotecting something
-	 * for L1 isn't going to magically fix whatever issue cause L2 to fail.
+	 * retrying an instruction from a nested guest as KVM is only explicitly
+	 * shadowing L1's page tables, i.e. unprotecting something for L1 isn't
+	 * going to magically fix whatever issue caused L2 to fail.
 	 */
-	if (!mmio_info_in_cache(vcpu, cr2_or_gpa, direct) && !is_guest_mode(vcpu))
+	if (!is_guest_mode(vcpu))
 		*emulation_type |= EMULTYPE_ALLOW_RETRY_PF;
 
 	return RET_PF_EMULATE;
-- 
2.46.0.469.g59c65b2a67-goog


