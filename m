Return-Path: <linux-kernel+bounces-535333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8C4A47156
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E3FB7AEBE4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EE122FF47;
	Thu, 27 Feb 2025 01:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNWPJcos"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4674C22F176
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619562; cv=none; b=ANOPeD8ib/snpCarZIaCk4Fn2slOp4790+xKwye4lNxvOnIo1QocmKAjtfYMzE97dZL63LMPBmnlBWmB9T32fvcrN88HM1DXDw9PIg2NRoQLv1PNMs8BZ0WmJOiEJ7U28Eh7NrzX+AJ5JkbPbumOe4TI1R/Yc+W7o6/Mm9ElZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619562; c=relaxed/simple;
	bh=k1zCPxyx7QffMCA40qqfLOdgRpM8zvCQvs8fM/N6VGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IErKIGOzQT2UGMqdtkImZhGXQYn+QmML/5bElyt5J2NAA9xIpXIqFEGTOiGSqeD7oc6FSJ0u7NVHASi/ZkWIkT/3Zv7lyMkQR2L+ZTQYGq0wFpkKo7nU/TNhnpjOVsXEcTDL4o7q/7u0v3+4EcYwhZVaJ6GNPsyRTiUBnFihHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JNWPJcos; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe86c01f5cso943397a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740619560; x=1741224360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hRttPNtyo2FhaDhgSxaXYjlTdMIPvE2NOxByRas6vdI=;
        b=JNWPJcosQmjHrS3bwJUXhl9nRHazhDBSpnB/J8iNdn7Tb80tGrhBQ4X/d99AEQ11PU
         +I2XVTZNBeBhvAz9Cbg3HADPlNNcsdkMbnlNJ0/WgpROQxS/AA7tlzGfeNNxocv/xWXG
         O3mZKCKES8qsqPrS6WniO8PzJ1tAabqE9/2ps4aM5Nm/6TBOrV8mNG1kD9emkk/lN0bz
         zRtEoV+Aj+5ulOZlMs7lZG5TtHNTeX3qd8/YbiFmiL0nGV7CNEbMo4aalDJQseAVGQ38
         9ut+f8kQUrVLO4WdRwPpwC0vjtS8+uwL/CHQKOlcMl8j467WBNKwOVJ4qTesBGFHmR34
         TELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619560; x=1741224360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRttPNtyo2FhaDhgSxaXYjlTdMIPvE2NOxByRas6vdI=;
        b=gcKvIzI5YmZSraFcSUbs/WAOlm/5rroHswQvydjgvIa87RkG7/JWsFrgG90PXnXQAf
         +w0d1Z9WtFjjblyQeEmq/LTdH0nRNB0CdNIzridme+F6dAPsed+xMWBBhazHMKLLsFub
         R71xYZgDNX3D4gr4p3vwxYGKBBJT7EA88CqNolZ5aMdA/zx6GEPiVs884hPKcGTH4X28
         UkUrLrP6VRPa5+OOr4SHM8BOJBghu3G3sr8Ta1icM8UXgTwy64htKimm7Uy1LSFLBJg0
         v8dGsoCZifhZT6wkmGIxqp/seymMOMfNXzQh/d76dXkY8tN4yftB9i6h4BgPBeFfTZTx
         Y/zA==
X-Forwarded-Encrypted: i=1; AJvYcCWrd/jVx0RZIVa45RJkxsEyEjAH4KExS1l/C8/PAyhn81hkY1fERQ94J0jfWLb43CGUsO1n6qpNYWb1M7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZzjgYYjrx60vkh189O2wVnc7gu1USEdkM2s2hIKW7kqjbTS1V
	qbKYfx0MlITgeFsPcD1YhIKPDyBAM2lqbYJyXfqDibTStuUabDnJhoItDef56yYTErVwylRUmWh
	A7A==
X-Google-Smtp-Source: AGHT+IG8HbiE4dqqw9uPDJvINPCaXcP21RIIbdqv90GTh7egSO6SkFb9wzrb+echyxtbBa5rvPfSgawyvUM=
X-Received: from pfbfa11.prod.google.com ([2002:a05:6a00:2d0b:b0:730:7e2d:df66])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4310:b0:1ee:d92d:f6f3
 with SMTP id adf61e73a8af0-1f0fc998e0fmr15792313637.37.1740619560644; Wed, 26
 Feb 2025 17:26:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 17:25:41 -0800
In-Reply-To: <20250227012541.3234589-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227012541.3234589-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227012541.3234589-11-seanjc@google.com>
Subject: [PATCH v2 10/10] KVM: SVM: Invalidate "next" SNP VMSA GPA even on failure
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>
Content-Type: text/plain; charset="UTF-8"

When processing an SNP AP Creation event, invalidate the "next" VMSA GPA
even if acquiring the page/pfn for the new VMSA fails.  In practice, the
next GPA will never be used regardless of whether or not its invalidated,
as the entire flow is guarded by snp_ap_waiting_for_reset, and said guard
and snp_vmsa_gpa are always written as a pair.  But that's really hard to
see in the code.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3f85bd1cac37..de153a19fa6c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3875,6 +3875,7 @@ void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 		return;
 
 	gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
+	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
 
 	slot = gfn_to_memslot(vcpu->kvm, gfn);
 	if (!slot)
@@ -3904,8 +3905,6 @@ void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	/* Mark the vCPU as runnable */
 	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 
-	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
-
 	/*
 	 * gmem pages aren't currently migratable, but if this ever changes
 	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
-- 
2.48.1.711.g2feabab25a-goog


