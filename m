Return-Path: <linux-kernel+bounces-360372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D65999A26
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC73B28390A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22431F9AA1;
	Fri, 11 Oct 2024 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAmLNtWs"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2B1F9432
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612677; cv=none; b=ZfdQp6CQ/2sF3E0OHcBCkO7C89J9XGFGte9nVNBZ/+5/TKVN3y/ZkpkKjjPXgZg8sv0sXvkV8FevhE6kCxnJBeI7UfpSLD8uQKFgq9s4nh9ivhi3Hcdl11FT5arVOEThy2o60lxaZq5v+/a+rPihQYDe2LZ1JjuYpigFexE3lFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612677; c=relaxed/simple;
	bh=LZMcdQvJWnJLB3/UIdM5EZpK8QPNNstC6KLm9lhBrbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CFRxwfH3+NfpRWvTsSmWBgOBMjgjUViYkvLAj8OruPHajbj+GvuT8nF5SKXdydCdHez0kpXTuGZT0Oc/AuWyssuVBAAtfIcyzcoxvjRkWTa5xzwZ1zbUJLhh21bafSYEVyZLJiUH7VSUqz07Pw+YZGgQv44tzPaXaccZ0QbEcDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAmLNtWs; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7c6a9c1a9b8so1191701a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728612675; x=1729217475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Hvv35DHJVsIcR1KuBMr5pv5pWI9cGFmfEf+HtUf4zac=;
        b=eAmLNtWsx3FWhdjImXvs4TMA5TAEasf25LSl8DYN/dKIRhoqvyBoIvwZ0LSEywVbob
         sxuXcXD8zoScKKUYERGypKucLm1SCHtUe+vXznvzC8hxh3LYi5+VRUIn+c1ERyiA0PS4
         AyUCYWd9GbygTc1S7g6PmOxfNziPRHJtLa8HLvseMW/K2DHQkNCAq3JNnMLXD3ktkqH+
         hyllqUUHfTPYSMpCDNI968l0K6qi8/4xu5OuBqzcdDxNu2jI57Lo/QyeKk8YZJxsijpP
         iD61TYRrSTy9mqPDqWSEOCCJ0fpTUJwSlJ/nvegfJXUkX00QEaz3W4U6OeSfHE77w+Es
         IP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612675; x=1729217475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hvv35DHJVsIcR1KuBMr5pv5pWI9cGFmfEf+HtUf4zac=;
        b=JeIePgWj/WFYqu3jZDzqFw1eD/EoGdWK2vm2tiX1u0BqltqFljaPqOrf0OWJ07Pg+L
         2UZG0O4wVxiMxMOt3u1C49mxdL+B/T6yUSAL1VcCXCuY+O0M3icyKGRzy+PKeAVt+UPQ
         qbxlXk774JXqraL7zhzVA2k5yC/E7w39Dpt/x7MG/XXGxdfH4g0+YivbhVreCcf+ewXH
         sicGWIrKmPPaUN/oZLJ5rg8tf8kA05ByBEkx0hI5a1Hg7wA182WfWTPVytnBb2993Det
         WxILYZ3Ruc9dBpH7OfbnnpK4RE69/nlHPpTsrHWhFawIyDBDf6EavLpwqTIMdl+JtFz3
         31oA==
X-Forwarded-Encrypted: i=1; AJvYcCV36IaoOWA73sDbmpgP4dFMufRljRpdMxuH6VP/Ys6Ke3p3QNFnbP9C1db9BH/RbG1Dk4iRb75QTMUnCvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0svPO0alAgx+TAeO6++6YAXOtsR7/o1a7xxd8wcMOyQVbFE0T
	+wRmJ6si0lsnzGPIdFjHmQA3UsdlZFQTLclGfVR7fAPsiWQfK2hw2MQpUZuNT/Z4FXStdCk50tt
	zpw==
X-Google-Smtp-Source: AGHT+IHnF6owo+1pNhj2RLKasExwUgPBpKQO4fPjKU+UOrHlJ7dmNwwiU5RcRn0ke9/PSMdjRWsWWieNTx8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:7d57:0:b0:7d5:e48:4286 with SMTP id
 41be03b00d2f7-7ea535a6447mr696a12.7.1728612674757; Thu, 10 Oct 2024 19:11:14
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 19:10:43 -0700
In-Reply-To: <20241011021051.1557902-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011021051.1557902-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011021051.1557902-12-seanjc@google.com>
Subject: [PATCH 11/18] KVM: x86/mmu: Set shadow_dirty_mask for EPT even if A/D
 bits disabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Set shadow_dirty_mask to the architectural EPT Dirty bit value even if
A/D bits are disabled at the module level, i.e. even if KVM will never
enable A/D bits in hardware.  Doing so provides consistent behavior for
Accessed and Dirty bits, i.e. doesn't leave KVM in a state where it sets
shadow_accessed_mask but not shadow_dirty_mask.

Functionally, this should be one big nop, as consumption of
shadow_dirty_mask is always guarded by a check that hardware A/D bits are
enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/spte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index e352d1821319..54d8c9b76050 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -420,7 +420,7 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only)
 
 	shadow_user_mask	= VMX_EPT_READABLE_MASK;
 	shadow_accessed_mask	= VMX_EPT_ACCESS_BIT;
-	shadow_dirty_mask	= has_ad_bits ? VMX_EPT_DIRTY_BIT : 0ull;
+	shadow_dirty_mask	= VMX_EPT_DIRTY_BIT;
 	shadow_nx_mask		= 0ull;
 	shadow_x_mask		= VMX_EPT_EXECUTABLE_MASK;
 	/* VMX_EPT_SUPPRESS_VE_BIT is needed for W or X violation. */
-- 
2.47.0.rc1.288.g06298d1525-goog


