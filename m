Return-Path: <linux-kernel+bounces-281423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233FC94D6D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26E9282F47
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52016B75C;
	Fri,  9 Aug 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JLyNomoJ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100D16A935
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230218; cv=none; b=s6kBV6tjLGLkOLmKB2gulgjK5W7NuTp2lnKfXb9eQFWHYKo8pSsybjyTXgyt7BJdg6ak9QDS8O70ryxcL63rwVf7WifhupiUBKbYMaPZvijvW5zktDrXgqNsinbYSfsUELQ7WWWwUlFskJqO29jc23j1wtCGkXuN5M/BdLrsm68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230218; c=relaxed/simple;
	bh=BWJKmkxdJpIr0WZAUrQe0T0TZqNNa6fnGorGum5Bq48=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KTTgC27mKESND3PXl9qk9igVq91ANHm2YFTyuRqm0V/lWDc59HRCOw3ryQb48iQcyJMqCpKjai25VciRaVk7P8yXE+8l9nomUS039q/TAb6DniYc7H7kveyki30bTfr7PucJ05q1XC71tvXFp38rEGpZoRFAWL2cCRPhK+HmSGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JLyNomoJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2cb81c562edso2687836a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723230216; x=1723835016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mzGayWAqBVAh7SBo8RHpGvCYGXHGAMMHoDF3FfeyQIE=;
        b=JLyNomoJzKMOk3xBSQvgz5RN0lcS5ZE4ln6rsJ/dcwYClcq8fNVVlpJflw8+JRP7B5
         2viuYYgkhZTuw4VhhVEOy0vLLq45uev/DyRhY/r41xqIGcJunyDWgCFh91ko6QEl8Yii
         SJegWlQKrBgXNydtEyVzHs+FxIIi3o2siyDzOTMjDK+goGpGp8UN06cTzakjkHsP76xl
         e/NHeHk+MUhBS4LoNLgpH5sd4NSLlQkwajjwZxFZeHnodH1w1DL/hkidvri8xvzXkmVi
         ZgqTTuj5SYSn5kD42u1EQgdimk25+IBoXR6MAqev2AlI4yVBHU2R08p66rJWrxblUATb
         WYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230216; x=1723835016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzGayWAqBVAh7SBo8RHpGvCYGXHGAMMHoDF3FfeyQIE=;
        b=l6japEJOJJbv7WkBeynjFn61PD+2SiSgzo2IhlhkOmlJ1xn4B48e+V8oyyqDQRoEnJ
         Og6RhEBCBm8X85Nyr3Ivb/MmVmGrZMoMAZME8/vXNsifJQ6282VDeO85lLMAQi6JQeln
         0wuMXxcfbJy5fb8CubR2nsK0n0VxfAhGVA8LXEFJSxaGByQDa4KoKn2muPQX4P4rQP1m
         GbFnIYoltyH6e4k7pEFHo7kGMTer9nJnZWcxyxvi4gNw+xUha1Ibf/FmT0sX/tCrasYE
         ETa17N8Nh0+OTQGHvLxjQY8udo4S1QtcwoCNTgs7Ayti/JJi8oMxD4rLmtBDNeJP42sk
         eAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlX6mc11+wWcvO4mTmeq0TaYvWdRLQ+NKxkwtCu4mWln4VUFkMDxV/G8rrI5MlDkUn+7OsJDfSAwi0N5R2c/drZuP7cymWGHHBiaIm
X-Gm-Message-State: AOJu0Yx3WQg7b9vGK+w99Bs3IO3osZQ9dZvWVoJU3knQbqsGFLs3x5w7
	RAL303NkAW78HK3SDxE2pwKF8rJcIl/4ZOJzgxpVLQx57s9XHbSFaC4WfyP+gcs29bMbL1Bhe4X
	11Q==
X-Google-Smtp-Source: AGHT+IFwoW6NpOd0vaQoEiZzjXJyMSsJDryKzJdxexhUyUmPk7TNdNT4VJMc4BZ52dupRQWvikDJT0Z/Pa8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:749:b0:2c9:6504:6787 with SMTP id
 98e67ed59e1d1-2d1e8044b48mr5297a91.3.1723230215949; Fri, 09 Aug 2024 12:03:35
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:03:02 -0700
In-Reply-To: <20240809190319.1710470-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809190319.1710470-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809190319.1710470-6-seanjc@google.com>
Subject: [PATCH 05/22] KVM: x86: Retry to-be-emulated insn in "slow" unprotect
 path iff sp is zapped
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Resume the guest and thus skip emulation of a non-PTE-writing instruction
if and only if unprotecting the gfn actually zapped at least one shadow
page.  If the gfn is write-protected for some reason other than shadow
paging, attempting to unprotect the gfn will effectively fail, and thus
retrying the instruction is all but guaranteed to be pointless.  This bug
has existed for a long time, but was effectively fudged around by the
retry RIP+address anti-loop detection.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index af6c8cf6a37a..2072cceac68f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8967,14 +8967,14 @@ static bool retry_instruction(struct x86_emulate_ctxt *ctxt,
 	if (ctxt->eip == last_retry_eip && last_retry_addr == cr2_or_gpa)
 		return false;
 
+	if (!vcpu->arch.mmu->root_role.direct)
+		gpa = kvm_mmu_gva_to_gpa_write(vcpu, cr2_or_gpa, NULL);
+
+	if (!kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(gpa)))
+		return false;
+
 	vcpu->arch.last_retry_eip = ctxt->eip;
 	vcpu->arch.last_retry_addr = cr2_or_gpa;
-
-	if (!vcpu->arch.mmu->root_role.direct)
-		gpa = kvm_mmu_gva_to_gpa_write(vcpu, cr2_or_gpa, NULL);
-
-	kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(gpa));
-
 	return true;
 }
 
-- 
2.46.0.76.ge559c4bf1a-goog


