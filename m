Return-Path: <linux-kernel+bounces-390984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 781499B80D9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13205B2235C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0681BE87E;
	Thu, 31 Oct 2024 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zOEMREqJ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E241BF311
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394405; cv=none; b=Li2txz02tZGkcWTmhJRij9V1A3kJPFOriOB9eA/tFn55ILcjGwnxqz88PaiwDXAWSFQZ45ywDh7JvBERqbGHLp3BLBSeG0dQ7pDVqy7WIM8zTCsoev0U3ogtLJ4/EQ7irdQodE6SulPUWhYXxS54J/yQDLyHwzXqnMwNb9Z8eXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394405; c=relaxed/simple;
	bh=CF9GNWAqKmVnELilmfxXohKaud+5EZ3rcAojpZDvqys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kNcOFZiopfd/OBMQwin01T2jezqmNgyLBXJqgGqooehII5jvo1UfW//fNdpxnAFaMm3UjLTzhw77P0cBsfou+xEPuFYVxI7sheLAJG+oilBSSficvoxF6eOkAoTaKK+Cq/7X+6Qbssxpo7rEvnt/GdLmSichcKIMTL7cfKD0FBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zOEMREqJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29205f6063so1837218276.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730394401; x=1730999201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5mvSMrPyn0juvdY997mNRNyl5E1lyo12cgDG/LNUV4Q=;
        b=zOEMREqJhazgdbctpKNuHwfeHX1dIFH3dJ4GnBizcvRQGVHDCRndraNI2gwPd+L45W
         Tln524wSE3k9arg2/exxsSt+ETYzyCWXacidpTbBd2TkFlFFGLi/CrgYhJQzRnRq/ZtV
         lufNsckN92lOHIpSJbGoAXUd1poKo6583ldlxI+xKxsG9aLDyekEB0tB8k9Z98ConHlU
         H/1avGvS0ocL7ygv1VVMWPE98dVKZDcGQJxA/229PFv2ybe7IQbMfLUzH14d/vpf3iL1
         DONs280DRVWLIPuYBmW3RYOD9BWEWUFH69dO82C/LXtjEjag32+Aed08jDodZKO1Ujdf
         kGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730394401; x=1730999201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mvSMrPyn0juvdY997mNRNyl5E1lyo12cgDG/LNUV4Q=;
        b=RL4SQWx9sLRoiftQO9PjyXM50PWYqG+IMPx3qinJ/NPjPdzIBWOBPUeNAXaDE2aHpL
         Ybfa+BufV+JSydMoiPpGHrI+ZztclNm4/itYSHbTKaxnxgABumBytR7AbWK+Ev/TQ6Xc
         3jFsAEPMUpK6ITS6Wm7QDl0nroy24UBmEqE8o/csoyQFlw6tgeDEvFuq8Mon20lpF7JX
         BCMReLI+ltZmcD8J5YP0TYwK8J9UinHJo+d+nuWB/6GXOt0UJSVDlGwKUuLlEiGNJMN4
         y9brJT8NqLXGpMYyizMYTYN9duaq9FImdkHqfQj0yTI/WFERZtIUnG4N6Grg3y4kr1i7
         cLjA==
X-Forwarded-Encrypted: i=1; AJvYcCUDhvRSt3msE9PAC0ToaL2VJwg92NS65QrICeCBv+hG+f/6W+ubwvWMn+GSUt0cFtBdLDMTSoT8QzAOjho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXrkSHbiC2IyTti1eG3SzKvRXSJon5/mXsgb9ywJwnh15MgqVz
	Spznc3IJXoWlbX+pxFxNyrdcHEQmUl7g+4qTKtgCjeHXtk/x80AV1EmgKrkLnmrJRM0sIICv6jg
	cNQ==
X-Google-Smtp-Source: AGHT+IHaNKkAsPzvMlrC7DsQB+BKEBKT51iYS8Lpz9uTMWn9JUZ5fiG1CamoxG8hwdIvdxbOzXOPUscKPTA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:b10e:0:b0:e30:d9d3:b87 with SMTP id
 3f1490d57ef6-e33026aa6c5mr845276.8.1730394400585; Thu, 31 Oct 2024 10:06:40
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 31 Oct 2024 10:06:33 -0700
In-Reply-To: <20241031170633.1502783-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031170633.1502783-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031170633.1502783-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: x86/mmu: Demote the WARN on yielded in
 xxx_cond_resched() to KVM_MMU_WARN_ON
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Convert the WARN in tdp_mmu_iter_cond_resched() that the iterator hasn't
already yielded to a KVM_MMU_WARN_ON() so the code is compiled out for
production kernels (assuming production kernels disable KVM_PROVE_MMU).

Checking for a needed reschedule is a hot path, and KVM sanity checks
iter->yielded in several other less-hot paths, i.e. the odds of KVM not
flagging that something went sideways are quite low.  Furthermore, the
odds of KVM not noticing *and* the WARN detecting something worth
investigating are even lower.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index a06f3d5cb651..c158ef8c1a36 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -698,7 +698,7 @@ static inline bool __must_check tdp_mmu_iter_cond_resched(struct kvm *kvm,
 							  struct tdp_iter *iter,
 							  bool flush, bool shared)
 {
-	WARN_ON_ONCE(iter->yielded);
+	KVM_MMU_WARN_ON(iter->yielded);
 
 	if (!need_resched() && !rwlock_needbreak(&kvm->mmu_lock))
 		return false;
-- 
2.47.0.163.g1226f6d8fa-goog


