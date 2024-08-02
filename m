Return-Path: <linux-kernel+bounces-273022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4A9946376
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346091F23304
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BF91A34C8;
	Fri,  2 Aug 2024 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RChvzNbP"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F8175D5F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624932; cv=none; b=Epd7NznKR+HuR9ljGHdtHBAc9Z/2CRoUWCggvbGyEsMqaziQN9aYjJ2Umexih56SRGbLWV5PExJJ0j8qREoxCYAom+mJ60R5Nfy6mM7e2Box1zgKTUnnM98dUGPlmPS9UV2TDsqvjF3h0GEXHHZg9PPmp8aYefUSz4nXfYtxAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624932; c=relaxed/simple;
	bh=eldBfQsKlvf6Q8sBz99QXD7HgSq5xAkX0So1tJInRi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T/YeU9mfztgtlGUY4n8g5+K14xXrvinZBnS8EmyuvXDrkyQdbfWtsJQGPDxU+FXazAhp8AsGl5CS4sD4zMDrdmKKwRJE+Eh1u4K+YIsgkOZmoDR7X/MBSRv8KIrf9BzMhcMbywVm9VGq0g4oomwn0K5iTyoObFuHNSOanbDE2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RChvzNbP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b9d33cc94so7515987276.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722624929; x=1723229729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ms2G/N43YcnOQEtV252HZgnjvxOb+bhJxEe42LzAOQ=;
        b=RChvzNbPxO5wqCRDS5GNGJPvsZWis9vVM7aYGxOSDDsBU2fTjUfCmHjDBwvXqpuWS7
         x5Auyd5RScbOUHu7IzdBfcHr4vtci5kBxko5zJUknTcJ/jDnVQtKVnkIkRN3KvOzrGF1
         uN5PHd3oVxG5/iwdLUWnQBJQz7Q2UsgNbFWrTdzdDXVPnFfv68hmPlSb+n7wWMO/Zq+J
         fp2jx/n3NMcHhs2SlR33FQN/XNutHAIvgcYeCYXJI9wn722MQeczlZtrceMp+ZFBrmuT
         9lmD2G2hp0dm/3Godk7gaGHhLHFw7vEvVCVC7t3VoWLIXN9rKYLLhFSTURC99Ok2rrM7
         9NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624929; x=1723229729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ms2G/N43YcnOQEtV252HZgnjvxOb+bhJxEe42LzAOQ=;
        b=mOIrgSKMvibFrcml+NYkE6CinAGM0jPEoqguqb8EesVZEbvqRMKB6IzciMNDEz1Oqu
         Pn4B8tMahAR064bnTcz43KvtfE+9MRWIM667tJp3XyykzNLx06AVSMnZVvCouMPGHLrJ
         Qvl2dzd3Ncq5WjFEsbCpdnxLULgO2YHlcl7W8vrewUkzZljrUZCK8TGAzLqFkOgTiZP0
         4S5Es9un4YJzr3vWaOU1+UgPNGV1SYR9K/fR8kKLbDM+fGcn1e8vr4jwpPbcWUi7Lf9r
         szJaxYCH9ZfK8UQ6goPhe5+Eg+rAb4p7nNd6LSfMyb5rqbTRV6i8yR4MlTFy5Fexj7nm
         Xu8w==
X-Forwarded-Encrypted: i=1; AJvYcCVFkSh/L96sl6q4qp+ncg8fJ1gMTuTTZJsju1j1ijt819g//M6+Gw+yO9hrMFO7NqFyofo3Kx7xKbf4jvsqO7F/x4T3z9bwSXIcrLiS
X-Gm-Message-State: AOJu0YyT5aVlxI4uy+fZwOj3d147gdu9k2dj94Nop9GA6Yn8diKSfRT4
	7voH4s0covP41PVbfSf/DEqQNbNQcnT/Z5XbVT5HskpDvMANKIQyDQEwXmDizNPVmnDqvgetvEU
	bkw==
X-Google-Smtp-Source: AGHT+IE5ZituWgyzRKqfrwI9WzmKAGDShHhzJZxZ/psL0bnmPJfQgggduhQLEwCQFk9i2qOOViKCepO0JC0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:154e:b0:e0b:bcd2:b2ee with SMTP id
 3f1490d57ef6-e0bde290b7bmr7689276.6.1722624929082; Fri, 02 Aug 2024 11:55:29
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:55:09 -0700
In-Reply-To: <20240802185511.305849-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802185511.305849-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802185511.305849-8-seanjc@google.com>
Subject: [PATCH 7/9] KVM: x86: Remove ordering check b/w MSR_PLATFORM_INFO and MISC_FEATURES_ENABLES
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drop KVM's odd restriction that disallows clearing CPUID_FAULT in
MSR_PLATFORM_INFO if CPL>0 CPUID faulting is enabled in
MSR_MISC_FEATURES_ENABLES.  KVM generally doesn't require specific
ordering when userspace sets MSRs, and the completely arbitrary order of
MSRs in emulated_msrs_all means that a userspace that uses KVM's list
verbatim could run afoul of the check.

Dropping the restriction obviously means that userspace could stuff a
nonsensical vCPU model, but that's the case all over KVM.  KVM typically
restricts userspace MSR writes only when it makes things easier for KVM
and/or userspace.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8bce40c649b4..32483cc16d6a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4119,9 +4119,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		vcpu->arch.osvw.status = data;
 		break;
 	case MSR_PLATFORM_INFO:
-		if (!msr_info->host_initiated ||
-		    (!(data & MSR_PLATFORM_INFO_CPUID_FAULT) &&
-		     cpuid_fault_enabled(vcpu)))
+		if (!msr_info->host_initiated)
 			return 1;
 		vcpu->arch.msr_platform_info = data;
 		break;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


