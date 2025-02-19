Return-Path: <linux-kernel+bounces-520769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61654A3AEF4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5202B16E91F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC93B1B86CC;
	Wed, 19 Feb 2025 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5D1tx5s"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6E1B4245
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928447; cv=none; b=GIpwYJwYTo1g1b0rWhgdw75r+CBUBv/Z/3o6go2n4VlKqX5Pnpln6XYG0A5R+EQZf3+1ol/ZKowxI15sTMqVZySCujVLY1FVpx3YHb59k2SRwgGpfmrwGG+RwZtPdQKla+AJ8ydyEQcQiMy+zmcWZRC95+9Gm6DQlPqaLNEdqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928447; c=relaxed/simple;
	bh=8HNmILbOSwalR8zIxIIl3FnGV1i2PFV3f6IC6S2LJd0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XQYYRz0/OVS03B9qWT/bcPkbG9RDWer3aTTlerbH1E4e05qNY1/W9dmIb+VXWUICVJ1h+2xGjwqCFwiku9IKXMTBMOBJilpeyPRqy4cz6s2NQBk//5IWBPH7gp7nqSScexxI/dw/xE4pdlmscrKAJFt/2nqnnbJkOzph/M9/ra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5D1tx5s; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22119b07d52so46797635ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739928445; x=1740533245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=B2fI7t6EYAl/h+pggEYQL1iQEGSfxTQzaS+eT4QW64Y=;
        b=n5D1tx5s4LyrpmeIBuF6EoQcIisvIdOywDWaTyOeJn/di3wsacPlBIafIsNnT5l1ev
         AN9UDwMwVzsKX21lTUwp+4KuNfe5N/tW+4haM1UdU9NFv4Zhy74LW+BSgnG3s8XtB0bG
         BwUgD3hueQbqVv4Mxj7IHzalNKA3RrN7s8z5MNKqf8sa9TcDzDtIfDgbQK1LfAVZsTol
         dVRlzHU8UndRqQhDL6h9NAh0/z+O9FD6JWWwwmF3K2/nB4eUSbJOksFxFuYlz3arFh9Z
         iGjKPRs+moW0Kq945PVvNK1VSzm3QZO+ydkXq/XBUhPzTefEOEVYh6dAYOqrQ5ZINn5M
         HnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739928445; x=1740533245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2fI7t6EYAl/h+pggEYQL1iQEGSfxTQzaS+eT4QW64Y=;
        b=XQuphfGjwhbRs4CB1pnQDVj5u1uQFzWYzFaQnMkcoJ92eSj6B6L4ssuI5iBn7dfo5j
         8gEQFzlJimtEup2dCU7N+kV8TR+pZIA386DMwbohEgZ20BwG/CVu1YGfdOB86dMh1BQf
         bc1QHOu9jXNQon2b+TIMelfS3nT3VnnRG9m/ZdKZLihiPXLa2kfe6fMO8UbYatw2ulyw
         7D08jzSTpf8nXYeK/y9KQB4kN1zqg0Fl5c23g9onJMV/vTAjJNFG4M8X7tefBBO3MGNZ
         voJbkYidquc8eEhqB/1vM4GBUUzcDxgn/cc9p2BIXHljMUI+d6fg5Ug6oqbuEfX3Au/v
         Z3nw==
X-Forwarded-Encrypted: i=1; AJvYcCVgr4Ha6QmvJJ/QjUTOEqjDJuWAnTiq8OJT/kvTqjgoLoyIXLG6VraMezXM2vrIzFWV0DuzFqYcBaw4UdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgaNmBpO6fCCzZCg8Q+JP9r1vz8XvqzziFm+3glTHfZM3a/TFI
	7BcfFsQKvwPmsvAF4KJimt21jRjP8WgM7yS8abSj7GVz/iRBc+J89FMXwvlHRqllyDJU2J0KC9S
	g/w==
X-Google-Smtp-Source: AGHT+IGQDxe+HD8d0dlDg/Exw7kmkBeU3b0w8uvLuKNdfY8ETtEedCLbMAFDAagya2O0dqtA5uEXA76atec=
X-Received: from pjbrs15.prod.google.com ([2002:a17:90b:2b8f:b0:2f2:e97a:e77f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0c:b0:21f:7964:e989
 with SMTP id d9443c01a7336-221040d84ccmr247065355ad.52.1739928445031; Tue, 18
 Feb 2025 17:27:25 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 18 Feb 2025 17:27:05 -0800
In-Reply-To: <20250219012705.1495231-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219012705.1495231-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219012705.1495231-11-seanjc@google.com>
Subject: [PATCH 10/10] KVM: SVM: Invalidate "next" SNP VMSA GPA even on failure
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="UTF-8"

When processing an SNP AP Creation event, invalidate the "next" VMSA GPA
even if acquiring the page/pfn for the new VMSA fails.  In practice, the
next GPA will never be used regardless of whether or not its invalidated,
as the entire flow is guarded by snp_ap_waiting_for_reset, and said guard
and snp_vmsa_gpa are always written as a pair.  But that's really hard to
see in the code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 15c324b61b24..7345cac6f93a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3877,6 +3877,7 @@ void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 		return;
 
 	gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
+	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
 
 	slot = gfn_to_memslot(vcpu->kvm, gfn);
 	if (!slot)
@@ -3906,8 +3907,6 @@ void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	/* Mark the vCPU as runnable */
 	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 
-	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
-
 	/*
 	 * gmem pages aren't currently migratable, but if this ever changes
 	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
-- 
2.48.1.601.g30ceb7b040-goog


