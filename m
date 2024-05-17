Return-Path: <linux-kernel+bounces-182207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52908C8816
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE63285FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178F579F0;
	Fri, 17 May 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VOEjG4cK"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04774384
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956319; cv=none; b=VhMJ7UIWiZU/e2wPlmMvNelTKAO2DyX8ljnT/ihhbLL+m3oNUtNCo+kBP6VY0KsvanyORK/bg7Xh4NFDA7XWXMtX3JGMVebAKQGLcetcISN7NPsIaqB3T2jW1uJexvFHhxHhNmQ1D+GPYuvX6Tk0rllN0PjN3ynEfjqDrI5BbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956319; c=relaxed/simple;
	bh=lPwyFvnA8RFfjSZrTOFb1sNPxW2YnANTbVeCPsbbj5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NLcup1YvT2mu9qJMYJXw18oK/qoVt0gi21FCrQMZdR2hFoypl+5njN4FjZ6GY2Yst9o90E6+bEsjm7SRb5OaGsIvjh10hqwbrt2NjXMs/mgeom2uJkQ8pefZTBjGPQaXw7kVHlu9Dvazc2l3mfJ+UJH7TuuWAUR0102d6lDHMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VOEjG4cK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de615257412so16087879276.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715956317; x=1716561117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cCwbxCdw0tA0OWIMCvHgG1A0QngcvUL1VDqvLH7GRrk=;
        b=VOEjG4cKlb0wom//cRurdkUwqhCis7G0cX8JcGSlercKnyXmquTVfiI/iM2UPX9NxV
         7IQuyZHNnYnxLoJtpOajnqjrYyCzrCVlh9VCgcpnFIC6gDH+3nRhaLZM5kFlqSSNPloT
         DrgxiG1LJUgBAfSA6pHIcVIezuW68V1L8fWvbl/TRMNdqdL+wAwSX5hCk0M8aNufut81
         MnNmuQvRrZ8Cy1t/47z5a2vS4r9B9Y0OkYjX8QKhb0tLE1opXICy1h0qhR2GXDsJVOSh
         0l5bFbVL1c1A2LhxD7ckozH5SFD4Hd8z3syTudwlLoEczQ5nu8mTuBYNpjU0SEqEWEQX
         aTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715956317; x=1716561117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCwbxCdw0tA0OWIMCvHgG1A0QngcvUL1VDqvLH7GRrk=;
        b=lfnRFe0/65mxsmUdbhluGdDTq96WiJaBOBKYn8SWBw5/OCmbb3saYh/XWws3Wdyyzz
         HcSf+ovamYLBVzcwzHJb0oLVUZugsz4rGeB8xIx4mso/tlqlcd2sMtgAWNDGzSzPDoKI
         Ww9+dU0pz/l6sM/x/Tk1XG2h0ITDUXYJ8k1ehKn9oUO5qPDTRESKRlB0EwfS6e+s0yiO
         3Q7luZ7dkT+ew4xKBXtpuM/wgbkipGGdA8mG2Vh05faRNJneLKjnjIofbIM2XX0WLCzV
         IbY0Or4abZdM+LPXPLoECoxqDDJa0fMgPLlh5vP1QsDNi6zC9nWaDydP4LdNxJa0f+cb
         XWpg==
X-Forwarded-Encrypted: i=1; AJvYcCUxyB+6ZCiWvWcLzDI2GxzhbE28T9ka8LJyY/OGs6SrFyNwRVFbAQH0EIGuC5Ufvye03NJuKtpuEOqDWiUNHFjKk4dkJ3K0yhw0GPCi
X-Gm-Message-State: AOJu0Yx9jATTyaY1Kpcgu+dLgsXsyYDC6oRX2S1UHN9IYqVBDGAgw9Q7
	ln0lu5pN5Ur2YdKlmdS4+66RayrS2Ye+6H6DmUH4KlMjR5PQdQGKeCfRqfOEqnHP8p6dF1rSkbf
	ALA==
X-Google-Smtp-Source: AGHT+IHLjidjnVKCRgVsbOQRuGq6YCBv6kcYe9eKuoEpWWaMygWWv1uxvhLDxQB6N0CQU0egpLT9mXsaZpQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b88:b0:dc6:d233:ffdd with SMTP id
 3f1490d57ef6-dee4f0d9077mr5954597276.0.1715956317088; Fri, 17 May 2024
 07:31:57 -0700 (PDT)
Date: Fri, 17 May 2024 07:31:55 -0700
In-Reply-To: <305b84aa-3897-40f4-873b-dc512a2da61f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416050338.517-1-ravi.bangoria@amd.com> <ZjQnFO9Pf4OLZdLU@google.com>
 <9252b68e-2b6a-6173-2e13-20154903097d@amd.com> <Zjp8AIorXJ-TEZP0@google.com> <305b84aa-3897-40f4-873b-dc512a2da61f@amd.com>
Message-ID: <ZkdqW8JGCrUUO3RA@google.com>
Subject: Re: [PATCH v2] KVM: SEV-ES: Don't intercept MSR_IA32_DEBUGCTLMSR for
 SEV-ES guests
From: Sean Christopherson <seanjc@google.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, michael.roth@amd.com, nikunj.dadhania@amd.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, May 17, 2024, Ravi Bangoria wrote:
> On 08-May-24 12:37 AM, Sean Christopherson wrote:
> > So unless I'm missing something, the only reason to ever disable LBRV would be
> > for performance reasons.  Indeed the original commits more or less says as much:
> > 
> >   commit 24e09cbf480a72f9c952af4ca77b159503dca44b
> >   Author:     Joerg Roedel <joerg.roedel@amd.com>
> >   AuthorDate: Wed Feb 13 18:58:47 2008 +0100
> > 
> >     KVM: SVM: enable LBR virtualization
> >     
> >     This patch implements the Last Branch Record Virtualization (LBRV) feature of
> >     the AMD Barcelona and Phenom processors into the kvm-amd module. It will only
> >     be enabled if the guest enables last branch recording in the DEBUG_CTL MSR. So
> >     there is no increased world switch overhead when the guest doesn't use these
> >     MSRs.
> > 
> > but what it _doesn't_ say is what the world switch overhead is when LBRV is
> > enabled.  If the overhead is small, e.g. 20 cycles?, then I see no reason to
> > keep the dynamically toggling.
> > 
> > And if we ditch the dynamic toggling, then this patch is unnecessary to fix the
> > LBRV issue.  It _is_ necessary to actually let the guest use the LBRs, but that's
> > a wildly different changelog and justification.
> 
> The overhead might be less for legacy LBR. But upcoming hw also supports
> LBR Stack Virtualization[1]. LBR Stack has total 34 MSRs (two control and
> 16*2 stack). Also, Legacy and Stack LBR virtualization both are controlled
> through the same VMCB bit. So I think I still need to keep the dynamic
> toggling for LBR Stack virtualization.

Please get performance number so that we can make an informed decision.  I don't
want to carry complexity because we _think_ the overhead would be too high.

