Return-Path: <linux-kernel+bounces-535325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FB3A47165
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCC51883AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533031632CA;
	Thu, 27 Feb 2025 01:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D92oqqMI"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228281537C6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619549; cv=none; b=sHat8UQ2OVXl2oKRfsGi/Yw2DODRq+Y0GrKTYzj7Q1Bcm2syVFuZCOPD0EqCQkhznxFmX9zPjfFfZ9V+M/8M7Kgm6QL5LdxgfoowjjyzoVDKfITZyL9CAra/g8DPiBWRKoKQtmBqOOGwzx5g9g7CIgcJxBEFVa+5/gNGanJrytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619549; c=relaxed/simple;
	bh=o7YIiPy0L+iXjiHb8AA0Ly3jDIFWOKKVvokPylQxXQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pu01s77A4S8g4gVzf8eVhk6gNrKuse2ctNHruE9c8hqsVJetE71GZC+e2qZz1fSqkXqznDnDaq0DqajMbC/D+vs18tDdB9S7otKmp2lYHdLn5J9JAYdV3yo77MSegmQrSiuqLAgNYB2ffenkf2GqgK7MSRR+hFCyYge2ZEry7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D92oqqMI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe98fad333so964587a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740619547; x=1741224347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=I3z60PyMclA7mj8jFqKxMTzcWzViARYic6y8atlWZws=;
        b=D92oqqMIOjvjUd1mjlw2/j5gXRKo5E3FR0dHWT8wLnlZiXt69oHzJJha9yUkJ+efCA
         9Wp3H4ty3lXx60YYGo283UjmHQYowWaGOd9cvu56WHczy2wzLnJ4MIherDlrGCpGWbVd
         rZovOCEmVfdHJnEQ6iX5fWwzraO5a5IXcGR6VKFhbLhsrc9IPuHrAdgWL/2Osh5HwFeA
         cpppusL3QZ6NA/Qi0uDQw4pELsbT9o5pOQJ8vItFnI3rp6wp06EgKj0N9ruDg2ov9MAt
         fGg9+wnet6sF7ah+3LM6QhV8MYD/LlbOiqnBpspZ4s+thPU3J4UNgvD4hxPDu7H/7mYZ
         owuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619547; x=1741224347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3z60PyMclA7mj8jFqKxMTzcWzViARYic6y8atlWZws=;
        b=lxJTI2W8XLiXSY7ybRL+n3Y/CZMRLL6EHY1FxUwh1IuvRv0BI+CMBqCzOCZdXZGSIL
         IL2GjoScNLMF+74M5eu/Qd6WAGV/MwhJTWY0y0GmJSVwY+AC2PhUbiAD+Vox8vNQBAld
         H1GtKoWQUfY+8G0oCrYflupt4/PqkAyKFjFu0583R8uS7Hf8Z3g/qIblDfG7DJDKiUzk
         ORksEkZn1ikWWL4YnVbAvSoLCQRonHW29TYhhx3N6hvJ2Ryr+HAolipuOtpx5bjTZ5Au
         ejMUqzCGfYn7wn0A/4pX2AveabDGLYWGSDz+kT/3dc/HTuAXKv7dvAmUDZzpbERGqVAF
         03/A==
X-Forwarded-Encrypted: i=1; AJvYcCUTgFtAExX3XIaSbdOcjre1roiElSmd6QVrv6cFg4Bl/n4goAOatPOdy9mPFE+/K97BMBQ728el1qHJmmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3GSlz/gNXiR3tKUUgv04slaM2xu5Nt++TUMWxxe+B2AIbF4a
	Bxu1PZVklHV7dUUr+nYZkhtDWUupN3khjnpQkRlo2VDWXjSeVb9aiORc7AFhKRVaFoKI4czQmba
	Myg==
X-Google-Smtp-Source: AGHT+IHge2PUPDhQVHWderK3qNVut5fMR2npsRs1k9qIMwEd1T0TG6+5b5xVL5Lj7czmJ3HyOQZWBoz5m3s=
X-Received: from pjbst5.prod.google.com ([2002:a17:90b:1fc5:b0:2fa:210c:d068])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17cd:b0:2f9:c139:b61f
 with SMTP id 98e67ed59e1d1-2fce78a3812mr43989600a91.14.1740619547337; Wed, 26
 Feb 2025 17:25:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 17:25:33 -0800
In-Reply-To: <20250227012541.3234589-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227012541.3234589-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227012541.3234589-3-seanjc@google.com>
Subject: [PATCH v2 02/10] KVM: SVM: Don't rely on DebugSwap to restore host DR0..DR3
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>
Content-Type: text/plain; charset="UTF-8"

Never rely on the CPU to restore/load host DR0..DR3 values, even if the
CPU supports DebugSwap, as there are no guarantees that SNP guests will
actually enable DebugSwap on APs.  E.g. if KVM were to rely on the CPU to
load DR0..DR3 and skipped them during hw_breakpoint_restore(), KVM would
run with clobbered-to-zero DRs if an SNP guest created APs without
DebugSwap enabled.

Update the comment to explain the dangers, and hopefully prevent breaking
KVM in the future.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5c3d8618b722..719cd48330f1 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4594,18 +4594,21 @@ void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_are
 	/*
 	 * If DebugSwap is enabled, debug registers are loaded but NOT saved by
 	 * the CPU (Type-B). If DebugSwap is disabled/unsupported, the CPU does
-	 * not save or load debug registers.  Sadly, on CPUs without
-	 * ALLOWED_SEV_FEATURES, KVM can't prevent SNP guests from enabling
-	 * DebugSwap on secondary vCPUs without KVM's knowledge via "AP Create".
-	 * Save all registers if DebugSwap is supported to prevent host state
-	 * from being clobbered by a misbehaving guest.
+	 * not save or load debug registers.  Sadly, KVM can't prevent SNP
+	 * guests from lying about DebugSwap on secondary vCPUs, i.e. the
+	 * SEV_FEATURES provided at "AP Create" isn't guaranteed to match what
+	 * the guest has actually enabled (or not!) in the VMSA.
+	 *
+	 * If DebugSwap is *possible*, save the masks so that they're restored
+	 * if the guest enables DebugSwap.  But for the DRs themselves, do NOT
+	 * rely on the CPU to restore the host values; KVM will restore them as
+	 * needed in common code, via hw_breakpoint_restore().  Note, KVM does
+	 * NOT support virtualizing Breakpoint Extensions, i.e. the mask MSRs
+	 * don't need to be restored per se, KVM just needs to ensure they are
+	 * loaded with the correct values *if* the CPU writes the MSRs.
 	 */
 	if (sev_vcpu_has_debug_swap(svm) ||
 	    (sev_snp_guest(kvm) && cpu_feature_enabled(X86_FEATURE_DEBUG_SWAP))) {
-		hostsa->dr0 = native_get_debugreg(0);
-		hostsa->dr1 = native_get_debugreg(1);
-		hostsa->dr2 = native_get_debugreg(2);
-		hostsa->dr3 = native_get_debugreg(3);
 		hostsa->dr0_addr_mask = amd_get_dr_addr_mask(0);
 		hostsa->dr1_addr_mask = amd_get_dr_addr_mask(1);
 		hostsa->dr2_addr_mask = amd_get_dr_addr_mask(2);
-- 
2.48.1.711.g2feabab25a-goog


