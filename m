Return-Path: <linux-kernel+bounces-529726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95195A42A41
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCED13AA9F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD68D266B67;
	Mon, 24 Feb 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P7AGe+dT"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE58266597
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419127; cv=none; b=YyE94Ah28BM7LiI5Y4ZjTiHDQj2RfhyFOW/Rli9rKEnf1/1E/5hhL67TcscJnF346YX8MTJfoqK6TY6lsSFxay3uE4gMAq9ABR0BmlXQtUk+zllHKbRRrWKQ8PUVIKsmh7+Ke6KQMH5xk/1WV/RUCozmVVu++NgZhEFYoQaXsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419127; c=relaxed/simple;
	bh=l5ZgNCYskiqkSoA/TUMNtF9JvJdQrEdFRT/eNswpPGQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M2qMSuxBVZgtDOW0P4e5wm7frx8g8y/NTQusug6y1ayidV619Adk+COugQDWrnjoQXYZ8Q/sFwYrPrwdZJ4ox7SgQ7LUDjbrDs+od8WTJxQrd7tywaQLcHJ6HV3qMnveSt6OGMaQ2MN0ctMUrQrGaPYcWIdHMTpQ1SoxbJWYWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P7AGe+dT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1c7c8396so9664303a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740419125; x=1741023925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWA+FxxVK+hkRyqbtAFCYtZ9HKJOeSYLUKlQGx7IIeQ=;
        b=P7AGe+dTHSHzj/9XHZuQHEd45MkDhBFBfB7Kl/4TLJSf4s/l8k3nxS2h+1CxRjRn2H
         NL4iLV+4d8gbhg+VNGdsS6UDiRBgDAPBV1dN5yyb3OmyhmhrSH5AzmAYsGBpeE/TZCea
         hgkHfPwE4Ne/uYl82eYx3Xa2SedS8x3JG+p9UtP3RBIkbI8JH09CCUSGU9DEKfiO/PWk
         30TVvNX0RjUbUkAqiHiRKIduL3BKOX8eR8c/VsrxJRU2pPMFB9nao8sv9I9N21ytznu5
         PWecxle8UxDoR2MpWBA5Y6Iuezl3NF/Ef2MN3VX0EGqk7775TriHAhQPPfaHTH8CcZs2
         9Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419125; x=1741023925;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWA+FxxVK+hkRyqbtAFCYtZ9HKJOeSYLUKlQGx7IIeQ=;
        b=TNGf4Dn4gzt975CTt0HgRQyDCCILYhI/HatYlVc8CalIkS9KBjZX3Fqs7Juoy8aRpB
         VzHekAVNys/mIAaoH1+KXffgdz1RNoY2p0ZrDbwzakegcJJszZVcCahsUzR4IpGs6xqj
         BM2MIPIf3m9Co6tj4QmbbhHj2XAh7DP6CBVwUQ+gkzLpVgH8qzVkiBnyEaWGhtqMzVJH
         aIU9Is1G/nWyIfwEVLEiDk7qFZLcjER7JmkfXajZw0D7myQNYiw5JeKeKKmSou5g0pLf
         V2kgG70/Xed8c6yy9JGy/9rg7ZztUMQyePDfdJWBZI4D4EBvTV/VO01SXSUHGt6U4AhN
         fmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJM/Ch66Nl4NiVj3GjuN9E5loeYcul5qsIYFvVFhefwgN8yT9AQ9mFmDIiq4F8R9UXlHf43mlfzADvh6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqTQN0N7C5g07qcqPGTWCvFSJZk1+GJ/9UPgkjLXbUNUgLGaW+
	mOqg2HwkL21mkLDyY+XqnRZ2PCcz5+aaeS8Y5p7guFS7pBqzsum/izgTwgVwqfIA5KgbldBFBzv
	OyA==
X-Google-Smtp-Source: AGHT+IFA/iTKhpk1su7Z2GppPGgcs4f0AD+MLglFgL17N3OCminF65QjQemKGEfNHudWQOxGA3dEOxpzkcI=
X-Received: from pjyp8.prod.google.com ([2002:a17:90a:e708:b0:2fc:d2ac:1724])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5148:b0:2ee:c9b6:4c42
 with SMTP id 98e67ed59e1d1-2fce86cf0ebmr25680660a91.16.1740419125015; Mon, 24
 Feb 2025 09:45:25 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 24 Feb 2025 09:45:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250224174522.2363400-1-seanjc@google.com>
Subject: [PATCH] KVM: SVM: Inject #GP if memory operand for INVPCID is non-canonical
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Babu Moger <babu.moger@amd.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Inject a #GP if the memory operand received by INVCPID is non-canonical.
The APM clearly states that the intercept takes priority over all #GP
checks except the CPL0 restriction.

Of course, that begs the question of how the CPU generates a linear
address in the first place.  Tracing confirms that EXITINFO1 does hold a
linear address, at least for 64-bit mode guests (hooray GS prefix).
Unfortunately, the APM says absolutely nothing about the EXITINFO fields
for INVPCID intercepts, so it's not at all clear what's supposed to
happen.

Add a FIXME to call out that KVM still does the wrong thing for 32-bit
guests, and if the stack segment is used for the memory operand.

Cc: Babu Moger <babu.moger@amd.com>
Cc: Jim Mattson <jmattson@google.com>
Fixes: 4407a797e941 ("KVM: SVM: Enable INVPCID feature on AMD")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b8aa0f36850f..63268d940ce1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3272,6 +3272,17 @@ static int invpcid_interception(struct kvm_vcpu *vcpu)
 	type = svm->vmcb->control.exit_info_2;
 	gva = svm->vmcb->control.exit_info_1;
 
+	/*
+	 * FIXME: Perform segment checks for 32-bit mode, and inject #SS if the
+	 *        stack segment is used.  The intercept takes priority over all
+	 *        #GP checks except CPL>0, but somehow still generates a linear
+	 *        address?  The APM is sorely lacking.
+	 */
+	if (is_noncanonical_address(gva, vcpu, 0)) {
+		kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
+		return 1;
+	}
+
 	return kvm_handle_invpcid(vcpu, type, gva);
 }
 

base-commit: fed48e2967f402f561d80075a20c5c9e16866e53
-- 
2.48.1.658.g4767266eb4-goog


