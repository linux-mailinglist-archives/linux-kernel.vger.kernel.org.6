Return-Path: <linux-kernel+bounces-360369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580FB999A20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC131F2206F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741AC1F8F09;
	Fri, 11 Oct 2024 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WB7M3S/m"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F81EABAF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612671; cv=none; b=isNRS3QPFUt/0/Fu1ElNrB2YzOc8NqoUlVeGkUzE63p8cRpfcGmz5odylEazGhOT43uk26wlcFuTxlxOtfKpRvzdC0EaSko+XXEKz8ajtP52LLv0Safnv0fMC78P1mZwOmNswT1SEGxRYqSh34yCfJiiQSYpQ2i2ZjCSSiaMU1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612671; c=relaxed/simple;
	bh=Oaro4dCEU4jcQGzk11Dklpup6VCv/ez4gfRevJ+nC8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e9P2RtbWOcwKnRvhLAX1jfX/ccT7bK37sSiDxpjBOtQa8bxdTK3nKP3aaqjcTTroamRlip1jf9UJsMD8DU+AmBbWRvpkczhtZzoa22RAFuTBrYObx4rgXbxO2pJ9M+nPreHYMwj+4Dab8/wrajfpMrPO3qmIxK0eQKmpyAYfah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WB7M3S/m; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71def7a1a8aso1937035b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728612669; x=1729217469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/d560U3Z5EC8iutMB38TtGLr0WB17Rh2gPoL7ugF38Q=;
        b=WB7M3S/mFw5YlZ2Um1eaaGC1gfdCVmza8EOZtjW4VsDALD2c331x53GopaQkASzX5z
         ZKyUU9JcIDKLKQv/9YbjENe3F/9JQ/E/10cFwupxy+mKCb5VbgW4Su2fwpRXzvv91dRn
         xwtCnZAaAZOR/AgUtFmbobvQA7IF9yD3DtNOijOGIHDagKv2ZizEco31Pirsl7xfKdcB
         OQBvzxGxLOUTuKlMki5Cd5cgNjt8r5uy4qhRygl18QUxg30mwqoSF9JYTjfCYRSXE/yL
         540SCxS0rgPBpMw8C58lPCJxaWTqAJEqzWGDvGy8sqDAvmrWOJeXtQzjYCvjIXK4LP4P
         Q6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612669; x=1729217469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/d560U3Z5EC8iutMB38TtGLr0WB17Rh2gPoL7ugF38Q=;
        b=o0bdYdWo5KpDhOtIPMT/Aa02VWbJ4rqirk6F9DrbrH8Ar079Y86NehTpxHx0FllwMU
         lry4Gu88scaJy5lnDPZTP0RT1VAKOUauOtEWVqq4aiagbUl3b7AepBW43dzMFXqwhMvj
         oRrKVDQCAqIYmYiRDRpnbxNoSP9wBei96UFP/o8nV5abb4mOVTLW8n/nj1bAD+hTVXod
         vDpOtaWuYXfwDG1pxbSHA4/cJxI8uoo2vezC0hDSQHy8jVPBhEYyTGy9SMJAYQQx5AIF
         DBj9hOPWzlNz38vM4QKwl4CIezrtgzYWtLZCV/K6NPMZwqUrFAKRLR90xnaUsEhe+kiU
         YjhA==
X-Forwarded-Encrypted: i=1; AJvYcCXr1iwIoxw5Xk73AKtOepuuOrqgaqsti4lsflPpMEZqFDv2qjIpTSLqjD3ewMyE/l2u2Wf8p7sEUBwc2Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkSJBlfTmMEY7RWyUY2dLvvDGYKRZZS8O/t4+epSaAnzOCgz4
	w3qZfrV+/kfajqjeVay30ECZjs2Z9zC0+rw7e25cfuOd4FXLF2XfsYm0q96UEsieYXRFHrWym03
	6Uw==
X-Google-Smtp-Source: AGHT+IEDwgWqwtaUpKGOtPV1SFkzcT7nOjDPYXAUgFqKAshQBSQwxTCbIPRBqsJGwoI5XT9ksv8whQ+VyDY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9161:b0:71e:1efb:3239 with SMTP id
 d2e1a72fcca58-71e380f82a9mr11932b3a.5.1728612668662; Thu, 10 Oct 2024
 19:11:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 19:10:40 -0700
In-Reply-To: <20241011021051.1557902-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011021051.1557902-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011021051.1557902-9-seanjc@google.com>
Subject: [PATCH 08/18] KVM: x86/mmu: WARN and flush if resolving a TDP MMU
 fault clears MMU-writable
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Do a remote TLB flush if installing a leaf SPTE overwrites an existing
leaf SPTE (with the same target pfn, which is enforced by a BUG() in
handle_changed_spte()) and clears the MMU-Writable bit.  Since the TDP MMU
passes ACC_ALL to make_spte(), i.e. always requests a Writable SPTE, the
only scenario in which make_spte() should create a !MMU-Writable SPTE is
if the gfn is write-tracked or if KVM is prefetching a SPTE.

When write-protecting for write-tracking, KVM must hold mmu_lock for write,
i.e. can't race with a vCPU faulting in the SPTE.  And when prefetching a
SPTE, the TDP MMU takes care to avoid clobbering a shadow-present SPTE,
i.e. it should be impossible to replace a MMU-writable SPTE with a
!MMU-writable SPTE when handling a TDP MMU fault.

Cc: David Matlack <dmatlack@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 9c66be7fb002..bc9e2f50dc80 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1033,7 +1033,9 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 	else if (tdp_mmu_set_spte_atomic(vcpu->kvm, iter, new_spte))
 		return RET_PF_RETRY;
 	else if (is_shadow_present_pte(iter->old_spte) &&
-		 !is_last_spte(iter->old_spte, iter->level))
+		 (!is_last_spte(iter->old_spte, iter->level) ||
+		  WARN_ON_ONCE(is_mmu_writable_spte(iter->old_spte) &&
+			       !is_mmu_writable_spte(new_spte))))
 		kvm_flush_remote_tlbs_gfn(vcpu->kvm, iter->gfn, iter->level);
 
 	/*
-- 
2.47.0.rc1.288.g06298d1525-goog


