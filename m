Return-Path: <linux-kernel+bounces-281435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7494994D6EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A395B1C222DF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4376119CCED;
	Fri,  9 Aug 2024 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m4oatGom"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFFD19B3D8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230240; cv=none; b=nEwolwbDfeYbj6rAlord0rcTP1a1hkaB1weeqMexcBDn3JXyGfj9DuMZUkpzPBxD8os0V7IJ1ttoyu9/oxGpjmUKQnzmN2vtggnf31DRVtL9b3xW9yq+4S9jNixdYRQkuNHpCns3sAupvhopQXk+Yi3uslRGN1JNcwsWuIigMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230240; c=relaxed/simple;
	bh=RDqWoEaDDp768Fdnd/8fsk9c8H7F3taR/Wk1mJd5iLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TxHkl5oZRwup3KfKtyINBLgtF1nycuhCuOgpNuXI1RIQtpqzkNTzZEZhJJ4lnAD86jZkQUvNcwKvXFk4JwyCTISWJcvnVnl+0xsosemaSNf7KVobak5mMJVcyVKen9bghNlQLNpa3JwRF/eugeME9dyeHg274TL5R3ozB/DPsdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m4oatGom; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70d24aead3eso2414932b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723230238; x=1723835038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=G217uULw1eanng9SZ8z6eqUs2KV3XibdbxN7GEMWgng=;
        b=m4oatGomofSnTHFgxzLERGs3IYhaO5r0zr5H93xI77SWuquHadY+bRuFo6EYdh3LJt
         12qTstYk/lz8m/6PyHnt5HwKgZ7TklVrawmwQiMKMOg8P/O2SV6oYntWlrEzP5zzKvzy
         pI8xk5bbebSh5/D8XSaeoxdD0ImHPmNNyyumviS3dxGmFTtaXwzdsP3La6cDNBEtZut4
         B6TiWsC94P4ULrUYt3VOAzdumVajeRrhgLRJ772nL31FebFbJUcc/4pv0mukuXNoAKX5
         vSaf4oN9+DMIWgpjlkueM0ln72lV3pmORW2Ow7MPH7eidDmd8sdewnX+UM5+7Io963gW
         4AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230238; x=1723835038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G217uULw1eanng9SZ8z6eqUs2KV3XibdbxN7GEMWgng=;
        b=cP/kbmBIIz2crhRv1P+/dXnR+Z+ENCXO+YtiLatO12duadaILCUVzMdZQojIV9ZywJ
         3+JennaVyd1DyxSrGLpfJbr5KKIABhQ0iPI96/dU6kKYj+3C50Qzvf/inQxxn2QDTSKV
         TD2EWuk+jPfBxJgbUeTKOwoD2Ara+2bajf0r+p47cEWVWP9Z2uCnA8bOgu7EY4DPrJk9
         xcAxlbbkBWf39GB+T0Bl8okdwL6BjJESLo0P2RMHN7obyzQFrcn/i1K7eVcoYhkpCgJS
         a5J5tus3Sl+FyG8kBdnSnwyGfsp8M8WyBZBDTOKX5G/m1JdC5N1FCQ7vEtcU7+Tj3tMo
         p5+A==
X-Forwarded-Encrypted: i=1; AJvYcCWSK2LXYtz4eCy9aiZL41Vc/pd0Z3tE5Udietnaz466tJkg//siVc7WVG/3C0KrWKm+VUJxb70Hkjk/9woyqJ1znDe1jrmpCymtzwIn
X-Gm-Message-State: AOJu0Yx5KNrQUXrs6CBgc0En3VjGkjeiSX4pa5bNClrrnSnxSwwd4A1s
	IEMn3zCWJQBQR1LpujPvZZJll+PEqGQKPgy/hECA5/ykNgBoTD+5fTk/GqN0ovab5NizIJadFWM
	nCQ==
X-Google-Smtp-Source: AGHT+IFukHzCdY9uMRpg3fMRlm0qASRZ4Id9jFsAUf7dR9BX89bxw65n083WMS3QuIOPqFtD/0LNn1B1Ttk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:840b:b0:710:4d3a:6bc9 with SMTP id
 d2e1a72fcca58-710dcb3c6b4mr54928b3a.3.1723230238188; Fri, 09 Aug 2024
 12:03:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:03:14 -0700
In-Reply-To: <20240809190319.1710470-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809190319.1710470-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809190319.1710470-18-seanjc@google.com>
Subject: [PATCH 17/22] KVM: x86: Check EMULTYPE_WRITE_PF_TO_SP before
 unprotecting gfn
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't bother unprotecting the target gfn if EMULTYPE_WRITE_PF_TO_SP is
set, as KVM will simply report the emulation failure to userspace.  This
will allow converting reexecute_instruction() to use
kvm_mmu_unprotect_gfn_instead_retry() instead of kvm_mmu_unprotect_page().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 67f9871990fb..bbb63cf9fe2c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8871,6 +8871,19 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	if (!(emulation_type & EMULTYPE_ALLOW_RETRY_PF))
 		return false;
 
+	/*
+	 * If the failed instruction faulted on an access to page tables that
+	 * are used to translate any part of the instruction, KVM can't resolve
+	 * the issue by unprotecting the gfn, as zapping the shadow page will
+	 * result in the instruction taking a !PRESENT page fault and thus put
+	 * the vCPU into an infinite loop of page faults.  E.g. KVM will create
+	 * a SPTE and write-protect the gfn to resolve the !PRESENT fault, and
+	 * then zap the SPTE to unprotect the gfn, and then do it all over
+	 * again.  Report the error to userspace.
+	 */
+	if (emulation_type & EMULTYPE_WRITE_PF_TO_SP)
+		return false;
+
 	if (!vcpu->arch.mmu->root_role.direct) {
 		/*
 		 * Write permission should be allowed since only
@@ -8896,16 +8909,13 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(gpa));
 
 	/*
-	 * If the failed instruction faulted on an access to page tables that
-	 * are used to translate any part of the instruction, KVM can't resolve
-	 * the issue by unprotecting the gfn, as zapping the shadow page will
-	 * result in the instruction taking a !PRESENT page fault and thus put
-	 * the vCPU into an infinite loop of page faults.  E.g. KVM will create
-	 * a SPTE and write-protect the gfn to resolve the !PRESENT fault, and
-	 * then zap the SPTE to unprotect the gfn, and then do it all over
-	 * again.  Report the error to userspace.
+	 * Retry even if _this_ vCPU didn't unprotect the gfn, as it's possible
+	 * all SPTEs were already zapped by a different task.  The alternative
+	 * is to report the error to userspace and likely terminate the guest,
+	 * and the infinite loop detection logic will prevent retrying the page
+	 * fault indefinitely, i.e. there's nothing to lose by retrying.
 	 */
-	return !(emulation_type & EMULTYPE_WRITE_PF_TO_SP);
+	return true;
 }
 
 static int complete_emulated_mmio(struct kvm_vcpu *vcpu);
-- 
2.46.0.76.ge559c4bf1a-goog


