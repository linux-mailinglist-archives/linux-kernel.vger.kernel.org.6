Return-Path: <linux-kernel+bounces-281434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A9594D6EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AF4CB226AE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF0519B3F3;
	Fri,  9 Aug 2024 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrDxC+nv"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC919ADA4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230238; cv=none; b=p5b5X3ivFCPAjWp/rLbYsdWJz/gXowJANsGgiLYPwq3ZJp2wWQ1mo+YyKA7ut1Ef+k3YowKEixNShQ4mhG1I+A+IqiWF5NxzfkuapOpVYMAJYoWvtpKp8i9tO/b/7W7rQaSE3w6O9i/UZyjvCKng2rCb8Zepi488/W/LNSKiiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230238; c=relaxed/simple;
	bh=uGTn00vVoZxHd5+Z0XK3NYo3MeaA+VVaXsCWEnk+RDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HGt8j1iIZfojMSkbQpaGneIIBT6kQ8HLrPtIUXpwNzCY/98CDhd60d7Ftr/uy1tOrxYF4pdE4QUryHLD618SAG8Fg50zxZCNatVrVV3qZIhsk6XjHA1rfIC0Br85vwO8IdnGo4mm4DlaQb7EsCRPRc6M4ySvDZGVoP6OVRjKkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vrDxC+nv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-692aa9db2d5so50366837b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723230236; x=1723835036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kvnI0Btlm0LRVdXYEsn4iCu6mP1I2mMf1I/or9DffZY=;
        b=vrDxC+nvwwNWBAP6KBMGI3+W3qqwHxOQKD5R8KmNLfKsx5oFAPABaRk7N0o+2HxFCK
         LiSwg1vDxzRTonMsioCJKOw/u7UoFr4Ol2Fr/Hkdvsiq/TmqPVRAvt6Yd01F/S1/A0xi
         LzoGGQdovshJIy3EtRg/UiHaIJ+KEt6PrxQtmMoVS9dQ0Vk1nSQ6YkjvMSW3BmDGwoyU
         RDA9tce7YCwSA12wCdWqGB3bgIgfbDqIw/UXvoqTH6a7BxOBNd7/HHCiFSOIIrj9YjzS
         aG612LIm3Yi4enaMHGWLicq1wpGbTlCguSh8fglTQKzPyoerxGM97oygofBhhZiHFGsH
         FlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230236; x=1723835036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvnI0Btlm0LRVdXYEsn4iCu6mP1I2mMf1I/or9DffZY=;
        b=vptB4tzeYIV2wK4y5K0NFj+I8rlLgqTdHv8tTRJD+9eakcmKu9fJQrpn27OowlEOLc
         FxMdak6AifOezseV3DnZLRjeAQs6rc7ALe6NADD5pRbrjyxFaGOdA8d+fZrAFJ6YnqdR
         5mxG6hfbgjy2zuRECaZzlL/yqiMLqHFQZfjhczo+deonOnutydnZZGQd7ysBDT/b2Ozq
         18o2VfCSndce2mpiOVYCPZCh4stwnIqcG1oQglfWlPldHThKAysLiLLPS8WVZotKcQFJ
         G4BkVbU5ILrkpmGMRudGOeZ397s2IZN0WJ0JAdLbRf/Z/udBqtNobTt5D2yMCZK3xWye
         flVg==
X-Forwarded-Encrypted: i=1; AJvYcCWY0X9uInqvKgFHDiQpqoG8VNsJdjBFCwDwA58vMVMc7EIhhY7ygr9qPihI9kfSKeL33ftkzvkuI+On4Bj/lFsKH8xa4lV1kr0+Rv76
X-Gm-Message-State: AOJu0YyevPVpnBkf+XIqrVCVk8hL5lEnmFgjBmJURhZVBZwB1sBBBayw
	yn88A1mKCGPhjCK74Mt4HdJz1jZzS9QapxlKywAb25Af1enQFYLQ9hnleMTbFvPkGGMHSXBeCnZ
	9oQ==
X-Google-Smtp-Source: AGHT+IFL6bQgCxnimbHP4f5bmsF/aP/gxKIR0RtUrr1Bhzg5SSWFxmFRUrGcU3KsKu+jzdwgfD+rPT571b4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:288f:b0:680:cd2b:90ed with SMTP id
 00721157ae682-69ec4fda24dmr98747b3.3.1723230236426; Fri, 09 Aug 2024 12:03:56
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:03:13 -0700
In-Reply-To: <20240809190319.1710470-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809190319.1710470-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809190319.1710470-17-seanjc@google.com>
Subject: [PATCH 16/22] KVM: x86: Remove manual pfn lookup when retrying #PF
 after failed emulation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop the manual pfn look when retrying an instruction that KVM failed to
emulation in response to a #PF due to a write-protected gfn.  Now that KVM
sets EMULTYPE_PF if and only if the page fault it a write-protected gfn,
i.e. if and only if there's a writable memslot, there's no need to redo
the lookup to avoid retrying an instruction that failed on emulated MMIO
(no slot, or a write to a read-only slot).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 771e67381fce..67f9871990fb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8867,7 +8867,6 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				  int emulation_type)
 {
 	gpa_t gpa = cr2_or_gpa;
-	kvm_pfn_t pfn;
 
 	if (!(emulation_type & EMULTYPE_ALLOW_RETRY_PF))
 		return false;
@@ -8887,23 +8886,6 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			return true;
 	}
 
-	/*
-	 * Do not retry the unhandleable instruction if it faults on the
-	 * readonly host memory, otherwise it will goto a infinite loop:
-	 * retry instruction -> write #PF -> emulation fail -> retry
-	 * instruction -> ...
-	 */
-	pfn = gfn_to_pfn(vcpu->kvm, gpa_to_gfn(gpa));
-
-	/*
-	 * If the instruction failed on the error pfn, it can not be fixed,
-	 * report the error to userspace.
-	 */
-	if (is_error_noslot_pfn(pfn))
-		return false;
-
-	kvm_release_pfn_clean(pfn);
-
 	/*
 	 * If emulation may have been triggered by a write to a shadowed page
 	 * table, unprotect the gfn (zap any relevant SPTEs) and re-enter the
-- 
2.46.0.76.ge559c4bf1a-goog


