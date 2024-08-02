Return-Path: <linux-kernel+bounces-272977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7541C9462FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C62B22603
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798F8210187;
	Fri,  2 Aug 2024 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aiktiySH"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576EF1E2890
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622798; cv=none; b=oyxMBbeSsMxKInNbACalYznmMyDi4cN9tzBhLPCdUPjAyDgEowgNiP9ZygHLsrtK9xAa4Lx6Ov4uEa9LTSyXN6Fzacqnb3Wat+fbGP2sy1oH+r+/hrokj3R3My2FyURTs1Og0SgJge4ySmyLetHQs0ApSSKI2xK9XOAJfeFltqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622798; c=relaxed/simple;
	bh=rYuZCOjGMFPneIQjfxXqOf7YCDCQKu6SjCyEN3k5vXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Aj07MjgOXfGSqee7F4+/EJJXeueyFrr2m25lSszoj2zYyjxjRgzZoG40Fdy1gZjqPD7QhSHrfjaJKLU18mya6KD+T9UuIcRYFs+jVRXo9WGYhDtx93/2uMZurc9KAd8dFqEkm5A334Nttrh7vDO5Z7+mgTl5QeGIvMlTcgCaAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aiktiySH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7a28217cfecso8640361a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722622797; x=1723227597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CzKIWMXNED7YqdWmugHRSOYLOXqjST8NDDRIyv28VSU=;
        b=aiktiySHFoEDzPOg27MtovAQ4X8AahXudvKAUmjTVyv87q50fBLr7R2xofGI9o4Eg5
         ISJss3h6N506Nr9IHZ4/3btTUeXOb5YWgUXsmwPtdlORaP6gEEJagRz1ZvZ/G7hPc2jE
         7EDZSLHjQ2paPW4GqHFLbO+Tgo+/g3Wi+4CrV7O1uCR7SL3K0N0DwadRIcYTlukq3fdM
         YsBEYFFyKi80dUehxns1kgNwu0JVSFWyCeLUMmnOylwp4irzEj3yhSSl3iSB9tDep/dS
         mp+CoJK8HttpiKDhEchEQKjGnHqH4l8nAtXw6EglxmSj7azaFTwxjnE9SMAU2mifC75P
         Ui4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722622797; x=1723227597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzKIWMXNED7YqdWmugHRSOYLOXqjST8NDDRIyv28VSU=;
        b=fuigFs0wLFrHhTrZnclkybpKEuXxWw7/9v+3O2cFbl2ZryNubFy+cYdzUstJ7mCGHJ
         k6JS4ZSynqY6moptvvQQ8Y/E05/ZYelOX26eMf5iZcIrI/uORfaAbhvJYBt9XzZgqYi5
         /hVUCkXL+6/Pg9spf1tdvXc7gtstkukKyxzcYMmrolRrAHv+UAhVHkZ89RTKGdPn2fED
         DR2ABQQrOUmt5+agG+RByWxb977BSanwIPwi6ix2OWX7NqMJqDFIk4EgY+HGT2XIkS3I
         FZp7twa4vxnT1Md3TWQWw6/kkTzQbziPcQNiMGxtN1QCU7yquM/5iN0v9jO0fKsijoyf
         IWwA==
X-Forwarded-Encrypted: i=1; AJvYcCXt4PYnN9byjfuExKQnLXVUgmmFccVrG5Vv7QkxVxwwsnRtgNUiXQCnhn1gsNW7qbsDc9wdEHJT5u2DN/yl9AM44kiRLIyoMAsNpqtJ
X-Gm-Message-State: AOJu0YyLHY8fTHdA/mnK4xhasiLo8j50t6zDJdKRHS8zr0DetbkaeOAS
	Yh38E1MiKFJfy/l5ywag7OYxX+guDJ2a1+Y1NruhdEBRiljnGT9FWHYUpWva9QG9tBXlSudsEuc
	HHg==
X-Google-Smtp-Source: AGHT+IHaTH0VV/o7nv6hvNhv1G6g/M7xIvJ9fXVkDGcK7UJIWkjBFbkhLXSsPvm4plxllUnnKT/PyhujMGc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:619:b0:694:4311:6eb4 with SMTP id
 41be03b00d2f7-7b748c46a32mr8850a12.8.1722622796501; Fri, 02 Aug 2024 11:19:56
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:19:35 -0700
In-Reply-To: <20240802181935.292540-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802181935.292540-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802181935.292540-11-seanjc@google.com>
Subject: [PATCH v2 10/10] KVM: x86: Suppress userspace access failures on
 unsupported, "emulated" MSRs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Extend KVM's suppression of userspace MSR access failures to MSRs that KVM
reports as emulated, but are ultimately unsupported, e.g. if the VMX MSRs
are emulated by KVM, but are unsupported given the vCPU model.

Suggested-by: Weijiang Yang <weijiang.yang@intel.com>
Reviewed-by: Weijiang Yang <weijiang.yang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ad28f0acc4fa..08c3480f1606 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -476,7 +476,7 @@ static bool kvm_is_immutable_feature_msr(u32 msr)
 	return false;
 }
 
-static bool kvm_is_msr_to_save(u32 msr_index)
+static bool kvm_is_advertised_msr(u32 msr_index)
 {
 	unsigned int i;
 
@@ -485,6 +485,11 @@ static bool kvm_is_msr_to_save(u32 msr_index)
 			return true;
 	}
 
+	for (i = 0; i < num_emulated_msrs; i++) {
+		if (emulated_msrs[i] == msr_index)
+			return true;
+	}
+
 	return false;
 }
 
@@ -514,11 +519,11 @@ static __always_inline int kvm_do_msr_access(struct kvm_vcpu *vcpu, u32 msr,
 
 	/*
 	 * Userspace is allowed to read MSRs, and write '0' to MSRs, that KVM
-	 * reports as to-be-saved, even if an MSR isn't fully supported.
+	 * advertises to userspace, even if an MSR isn't fully supported.
 	 * Simply check that @data is '0', which covers both the write '0' case
 	 * and all reads (in which case @data is zeroed on failure; see above).
 	 */
-	if (host_initiated && !*data && kvm_is_msr_to_save(msr))
+	if (host_initiated && !*data && kvm_is_advertised_msr(msr))
 		return 0;
 
 	if (!ignore_msrs) {
-- 
2.46.0.rc2.264.g509ed76dc8-goog


