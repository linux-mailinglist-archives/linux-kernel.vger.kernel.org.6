Return-Path: <linux-kernel+bounces-250829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7305792FD50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0B5284BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9415F175560;
	Fri, 12 Jul 2024 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAaIEFTp"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39A1741FD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797223; cv=none; b=fg6ySMxQsBESNO1HXJSAOGX6ymkZojjaWUA7StmaJ+EjDZJRejR1KufT2DxT1VEhiNFYoEGQgDJ0zpdf4xEOMmIkI0LvhQIAnUZUzak7eoXEjegEMidzBmF5587eJb32z8uotaM+T/ZgpwOAQl63xUh0MG+MJqHdwWok4WgrlPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797223; c=relaxed/simple;
	bh=BUzUp5RWHqaySVY5+BeOJD2jf/JigFe4Y+aXQC4Sk6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M+ZvFKryl4pIlnCSiS1YWy++RET0J7ospyi15IAjmBX+HneorNfmBafgYdhRvFBhAOJc5+RjIqtuGcFWH935yytclyqb7uPPfgpkrUwdN3y0TUt12bD6YtOsnesXEDWVd7oY78FC8uO8Qm5aTT2/n8KjjB2aEzTSHCiFC64i2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VAaIEFTp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6507e2f0615so1487802a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720797222; x=1721402022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xhil9fMKdOmNNY/hw6eHjeaj/nT3knlY7TdVcvRm4IE=;
        b=VAaIEFTp18j1yt0awEGjyi3hVxwnrmekeh8nwZ33E41yTegnnGTu5Is9jw3CT3TkEy
         hhiZSqog1H4YvrNTFi95rXfxmkgPOvMS+urUpMd4/DUOFh6NGMORvO2ZpBlsdkdc7hDQ
         xsdAzng7vU5ON1R1APCiraC2kcf2JKc/vF/0NO+UwIGtnRMEghjy7s06zD81J84qva9F
         6+8SSl93aa2TIMQR4Lic9S69I/uP+upeyTWmVfPHc0iGNATNdd/yys5PyfoOoNAMHp2n
         2y1lIDd8ILA8OGh9HaSEBibPmL176bHlG4Q4waBr8YZsHsXB4HmjjBO1wjZaF+kBA+C4
         0JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720797222; x=1721402022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhil9fMKdOmNNY/hw6eHjeaj/nT3knlY7TdVcvRm4IE=;
        b=pjJKJneMVg87EKWkxk5lAn1FNTxNHKYDK/XsnFZ+xLOP55aXT81woCiElayj4WABie
         oNKIzOcUw94v2mOvsKHoVLn+qknYOMhOB/xgSobNwI7IPKtJfWLibV/Lgms4wDt1XCG1
         eGReBGQGrYSFWZ9xpx4E2ifC7kC7/S7c7JhaYHbpaycpQdG00b1ssptuTmxde5ARUOD3
         xQ/xt7XLgtFgElra4PAb5KhrupaFgQM7LOpvGa0abQBNRbC7K0dbehzX4gJJ6uH3uq6g
         F8BI1bGEHS7aDjuwJSxFFy2J2kevX04feImsXmxYjNF/wCyyKHVFlcJjfOb31Jm5ymdr
         hPPw==
X-Forwarded-Encrypted: i=1; AJvYcCXw5Jd8uR6AtG/WTGr8u7Jc2YI4BNRCxyKCc7tDpMBwFMDl0CsmApeljVfXIleSPxAFx5iMzjiD713XtMBP6WE+5OhXyR6zCKYvaMRu
X-Gm-Message-State: AOJu0YyD/eWMR95yTNSm40knoAmGngcMLm8ltQHD7KypDsyrCArVkPNl
	diI6H4dzTham2is4LvufUQA0WdQYStD+Df+QgYNHEusaJk3xjYloC400SPLhh+mgu6jXQxVHyf2
	tYQ==
X-Google-Smtp-Source: AGHT+IHuT8K9rOPRCiT1msZ0/9yu35XkKU/imCLWZDOybsPwvXfpkO4uEj7EHjAiqcRPow2eblVNuQyIq1c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3759:0:b0:6e7:95d3:b35c with SMTP id
 41be03b00d2f7-77db673944fmr23291a12.5.1720797221803; Fri, 12 Jul 2024
 08:13:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jul 2024 08:13:35 -0700
In-Reply-To: <20240712151335.1242633-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712151335.1242633-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712151335.1242633-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: x86/mmu: Clean up make_huge_page_split_spte()
 definition and intro
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Tweak the definition of make_huge_page_split_spte() to eliminate an
unnecessarily long line, and opportunistically initialize child_spte to
make it more obvious that the child is directly derived from the huge
parent.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/spte.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index bc55e3b26045..10390eecd85d 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -291,15 +291,13 @@ static u64 make_spte_executable(u64 spte)
  * This is used during huge page splitting to build the SPTEs that make up the
  * new page table.
  */
-u64 make_huge_page_split_spte(struct kvm *kvm, u64 huge_spte, union kvm_mmu_page_role role,
-			      int index)
+u64 make_huge_page_split_spte(struct kvm *kvm, u64 huge_spte,
+			      union kvm_mmu_page_role role, int index)
 {
-	u64 child_spte;
+	u64 child_spte = huge_spte;
 
 	KVM_BUG_ON(!is_shadow_present_pte(huge_spte) || !is_large_pte(huge_spte), kvm);
 
-	child_spte = huge_spte;
-
 	/*
 	 * The child_spte already has the base address of the huge page being
 	 * split. So we just have to OR in the offset to the page at the next
-- 
2.45.2.993.g49e7a77208-goog


