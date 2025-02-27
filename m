Return-Path: <linux-kernel+bounces-536721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1028AA48365
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5914D1895B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD94126D5AE;
	Thu, 27 Feb 2025 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFtNwmpS"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272B234984
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670959; cv=none; b=e7PlOmzje/HE07sR2d2fvDbyJpQWizjdHyk2Eq2OV/4QO/1Knue1CIoXpi7YMCtcSgIlF7EqLdmUI5Fn/52DggOfeNIUeBLjrLtF0O+QRZWXVazpwHiEhrruFlpPPIOy+eQ0om30aoZrjxnuvy/OSYam4bpDUCG1FctYEjzvkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670959; c=relaxed/simple;
	bh=UuoWkiqtC0aOxbaIb+t32Rqp0zelh31Ws+VURGNU74U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a1G/F42Yoa67kQ8vQYlHL3xh0WylW9gazagho1oiv55HExXszNQW09bZWRUdeRF+L2wO1wiG4XrHjCnCLMZ54vN12Q/mLnerh9DvoQdmKrNNnuV/Aha1YfCDr2JLtyo+gRyVWuj4yE2cJaNEXexeVO68/JwssRSHLv1R/RBxFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFtNwmpS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe862ea448so3529622a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740670957; x=1741275757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTxXQgz7Yxbc/eAAimpjcsGV9z/4hM21fqn8fXkikhY=;
        b=lFtNwmpSjBIDmPYLbnaBZAeaS7Bdol/QV6/Di1ZbYw9aPjQKJCDI4082rKNFm3AF08
         utqNacWRoVYbNPGHRzXlTQR5a7DAvmAxEDSyMZyF7aMj5DnkdrKQiw/9ost/Lt6XUEJe
         GwVUD0lnuLBhDWEaJMk2mEH53QhNaXAG+WUa9PpsJHAUGU4ja8WtEs05rAOYsJocXAVN
         aSytUk67DMoP1k7Un+DHG8bHmZ6tGOAYnN5LTWtbHIra662hgpeyFk/h6+A/ao8EmGLW
         J/KrNWcmtpvV3+P/sQXJIeeMQCihgNSuuVQRD5fhdt3Q6GQDMHtzp/Bd0+pr2xO5owUP
         Kuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740670957; x=1741275757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTxXQgz7Yxbc/eAAimpjcsGV9z/4hM21fqn8fXkikhY=;
        b=Wabwuyl6x3r2WJM0vlYbrO2w/6RJxgu0EWGzRN8rVkJkE04xjereM+fAMK+C5YFF3Z
         ugLwqClIvhmcZvBJl9Q3T+LERXofzchkBUnwP+7rephrrxxD1rfR/RttWS0UdGMcjoT7
         cdzS7oDKYo2GSec+KLLtIb8AQRfzE+PFKwqA3j5NCeT0w1WzqUVACiVMr/yfqGbq+gzG
         N6KxhznZc2F4Tr4hstpu/jtu/MHKQhKmWgxuceMeeeDyz/LGncMmC4klc1TO3c1fSKRN
         q758EUODsanKcqZa1GNCTAtfVNLpAZ1RnwHdypy8wPeaJf9cKUxej+T9omb7U8ZRbC7m
         aPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWepuPY72Zgk5jmAer2UJYxAA5E/McI0P+VFWyrTuGzvb+2nYlzWR84Il+HAybaUYBOJy0h03KD7Q1XMus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ncffPo8tAfpWd7gx5eIdyaIoRJGHJY/d6A2jG6EZQESI807b
	+qA+BDfTAtHR2K2+637SJEZqlGke3gBcSHUGcaR4bztjs/Z6AbnkqcHySUjvPJJPN4WpwggyaQF
	UZw==
X-Google-Smtp-Source: AGHT+IGO+W9sfErnn/5UJ2Mtcl1Knk5QkM6rEM8nO1qZYe/AqOfxoeKMz4uPwgmxxOQVDkvbyEA4XinzfOo=
X-Received: from pjz4.prod.google.com ([2002:a17:90b:56c4:b0:2fc:1158:9fe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d445:b0:2fe:a742:51a7
 with SMTP id 98e67ed59e1d1-2fea7425341mr3837296a91.23.1740670957036; Thu, 27
 Feb 2025 07:42:37 -0800 (PST)
Date: Thu, 27 Feb 2025 07:42:35 -0800
In-Reply-To: <f59991ed-e24d-4bf4-8739-b314327ca1d3@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227012541.3234589-1-seanjc@google.com> <20250227012541.3234589-6-seanjc@google.com>
 <4443bdf2-c8ea-4245-a23f-bb561c7e734e@amd.com> <Z8B3x7EPYY8j8o7F@google.com> <f59991ed-e24d-4bf4-8739-b314327ca1d3@amd.com>
Message-ID: <Z8CH6_hYMKYk0doi@google.com>
Subject: Re: [PATCH v2 05/10] KVM: SVM: Require AP's "requested" SEV_FEATURES
 to match KVM's view
From: Sean Christopherson <seanjc@google.com>
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 27, 2025, Pankaj Gupta wrote:
> 
> > > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > > index 9aad0dae3a80..bad5834ec143 100644
> > > > --- a/arch/x86/kvm/svm/sev.c
> > > > +++ b/arch/x86/kvm/svm/sev.c
> > > > @@ -3932,6 +3932,7 @@ void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
> > > >    static int sev_snp_ap_creation(struct vcpu_svm *svm)
> > > >    {
> > > > +	struct kvm_sev_info *sev = to_kvm_sev_info(svm->vcpu.kvm);
> > > >    	struct kvm_vcpu *vcpu = &svm->vcpu;
> > > >    	struct kvm_vcpu *target_vcpu;
> > > >    	struct vcpu_svm *target_svm;
> > > > @@ -3963,26 +3964,18 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
> > > >    	mutex_lock(&target_svm->sev_es.snp_vmsa_mutex);
> > > > -	/* Interrupt injection mode shouldn't change for AP creation */
> > > > -	if (request < SVM_VMGEXIT_AP_DESTROY) {
> > > > -		u64 sev_features;
> > > > -
> > > > -		sev_features = vcpu->arch.regs[VCPU_REGS_RAX];
> > > > -		sev_features ^= to_kvm_sev_info(svm->vcpu.kvm)->vmsa_features;
> > > > -
> > > > -		if (sev_features & SVM_SEV_FEAT_INT_INJ_MODES) {
> > > 
> > > 'SVM_SEV_FEAT_INT_INJ_MODES' would even be required in any future use-case,
> > > maybe?
> > 
> > Can you elaborate?  I don't quite follow what you're suggesting.
> 
> SVM_SEV_FEAT_INT_INJ_MODES macro is not used anymore? If there is no plan to
> use it, maybe we can remove that as well?

Ah, gotcha.  I didn't realize it was a compound macro.  Yeah, unless someone
objects, I'll remove it when applying.

