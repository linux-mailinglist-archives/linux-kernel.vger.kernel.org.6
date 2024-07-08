Return-Path: <linux-kernel+bounces-244821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A262C92A9EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14919B21E9A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B605E14B97B;
	Mon,  8 Jul 2024 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUOg49ro"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93501CF8A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467572; cv=none; b=F/Y+4XLpWyjwbcrmRddT5MS+WeUk+QHYW9gwcWtZAXUlEr7ZRkEyds7vxlrnCeUtv9Xr25ZZMZN8Urqx59U5ohVJ5Ac7IhBvU6Zo/isqbQXazcpCRdXNd5GOsi2qngFwLkIenOFoT1FngbQI3H1QJJ9bHtKoIN6EzwwE1ys60j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467572; c=relaxed/simple;
	bh=cxpipDCot5CodKWnbdDOqEFP+CdadDnmsWzB2vBNKro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=onKJt2X5QvMXGll9QzEwkAJhQqEcfeWgWEJi5bWjkTnbuQhnLcXsgc6bDnUlwmBf4shDj9cFkRJaC9ocC8RPZH8OUqA+RElPfEwyOug7eK8UN/I7m47RgyZeJxXjN4qmGyVMup0fOeTbUyUexPqIvFZhSeB6k/7hpoS7GeqT3PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUOg49ro; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70af548db1eso3179912b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720467570; x=1721072370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ6CfDaikAMxahVxSARsyKtBQOzwazQX2aRjXkmicSQ=;
        b=mUOg49ro1nhb8kdKTVlDoUmzexJoot02gLNdDQZR7ENm170IPa44LOscF62dzsgPhW
         eaIc7zUxtjfPx6QFa1k6C1SZDNEPBzbayYIRWozN92sLw8XWOKWbnVsUggbO+ejKsJDM
         rl6femweZ3jDGlFSo2M07fa2xzXPXitjSnzAa+wJtbwve3ruEOUWwc7F9iMM3vnNuWtM
         7HkJVN1nB0idELu4DtX97Jpp7XMQxsjyHzXgprTJ3s/En6FngbdUUhZI72hyArZ7FDRH
         x8pAonG9HGvGi3Th+l+YO0PQlHdVeCKU+eqeZ1V3tMf4lQa51sY0uAQw6Qbfb9lcGI1k
         2EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720467570; x=1721072370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ6CfDaikAMxahVxSARsyKtBQOzwazQX2aRjXkmicSQ=;
        b=fHvYj4tYw18OBSC4Bj9PVrFXCYIafxvEe4BDaxpKlqVTIupUTHB1/wh+Yq3z+3Yq/z
         GvZLQG3sYUkBFpVRRRXroni5VWs7GuOb3Dp21IQaUqwNEdl5FOnO8uBZweAqjfyX49WM
         cLCwaLoDSFiOPNqL8bmF72Quf7X6TBrvyHMB27eVwquZvVLPTEi47cd4yR1v4Yg6lfVX
         Mg+tBgIz3TlwSKkvVQFQQBDZtbq9cmBidlqx+SkTCsRqud47sAoeEYzweemfNEw7zukn
         MiQ/FbNY5d3sPtqdP2JkjpAeTQ0STPH0rT1vrAOc6vXSZGkyQ7TB0xWY+BdVpgN/s3Xw
         osGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXid/ue5tHzWogDQsLso1njbNfJvUFclFxag1kYEo1OsqQLyW2st95J68uatSFAn4Edt6+J2pBwx/KPu1Qn90reUF4YNhLWW7nD6lNv
X-Gm-Message-State: AOJu0Yw20NuUVV1VfcVwptdqYrMYT+1V+IOVBgg/2x79A4wl8jzgk2Y3
	2HIYhU9a22BizoprprRobUrt0135MWLfKfm1nzmE7PqifxRRSPD2cyRNZjJYgAx2sW+xnkGrVSO
	igA==
X-Google-Smtp-Source: AGHT+IGlwAWjUeVVgf9eQ8gqL/6OnWSsJrxgloyvowuT/xANarRlzc6X2EXeOzRPkXsCcqffmwX898/lqbg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9a51:0:b0:6ec:f400:95a7 with SMTP id
 d2e1a72fcca58-70b44d8f2f1mr1635b3a.3.1720467569828; Mon, 08 Jul 2024 12:39:29
 -0700 (PDT)
Date: Mon, 8 Jul 2024 19:39:28 +0000
In-Reply-To: <480aa33ffa8f4fcc1e85d36206447b19719e9e3f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-8-seanjc@google.com>
 <480aa33ffa8f4fcc1e85d36206447b19719e9e3f.camel@redhat.com>
Message-ID: <ZoxAcAOVZ6I6Sidc@google.com>
Subject: Re: [PATCH v2 07/49] KVM: selftests: Verify KVM stuffs runtime CPUID
 OS bits on CR4 writes
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> > Extend x86's set sregs test to verify that KVM sets/clears OSXSAVE and
> > OSKPKE according to CR4.XSAVE and CR4.PKE respectively.  For performance
> > reasons, KVM is responsible for emulating the architectural behavior of
> > the OS CPUID bits tracking CR4.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  tools/testing/selftests/kvm/x86_64/set_sregs_test.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
> > index 96fd690d479a..f4095a3d1278 100644
> > --- a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
> > @@ -85,6 +85,16 @@ static void test_cr_bits(struct kvm_vcpu *vcpu, uint64_t cr4)
> >  	rc = _vcpu_sregs_set(vcpu, &sregs);
> >  	TEST_ASSERT(!rc, "Failed to set supported CR4 bits (0x%lx)", cr4);
> >  
> > +	TEST_ASSERT(!!(sregs.cr4 & X86_CR4_OSXSAVE) ==
> > +		    (vcpu->cpuid && vcpu_cpuid_has(vcpu, X86_FEATURE_OSXSAVE)),
> > +		    "KVM didn't %s OSXSAVE in CPUID as expected",
> > +		    (sregs.cr4 & X86_CR4_OSXSAVE) ? "set" : "clear");
> > +
> > +	TEST_ASSERT(!!(sregs.cr4 & X86_CR4_PKE) ==
> > +		    (vcpu->cpuid && vcpu_cpuid_has(vcpu, X86_FEATURE_OSPKE)),
> > +		    "KVM didn't %s OSPKE in CPUID as expected",
> > +		    (sregs.cr4 & X86_CR4_PKE) ? "set" : "clear");
> > +
> 
> Hi,
> 
> Just for fun, why not to have a test function that toggles a CR4 bit and then
> checks the corresponding CPUID bit toggles as well? This is both better
> coverage wise and will remove the above code duplication.

Huh, I don't know.  I distinctly remember trying and failing to dedup this code,
but I don't think I ever tried actively toggling each bit.  I'll give that a shot.

