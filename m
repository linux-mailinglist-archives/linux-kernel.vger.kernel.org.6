Return-Path: <linux-kernel+bounces-261365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A96993B667
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0CA6B243C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6325816A955;
	Wed, 24 Jul 2024 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAdzt7Na"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAAE167D8C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721844162; cv=none; b=gwHXAQdf5f4k7v9iaPAsoHl0enBEJsU66J2MMGjEgEi1O0I6SOlA3rPCARZwObsLVTeOt8q4HuTt2QL+urNv+Sw27CstAZDADnmpyu8p7NWVxBTpHcrZr2w/t6wBqmTX+bGEx9T83KT8VW50kdtft8JoTIS5TST4e78aChMHVo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721844162; c=relaxed/simple;
	bh=AYIYTumRgWLmfehVipaKKNpdHBH2wrIJFfmiUrFHqOU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lKhURbdR2H05+ZIalvpRhQRfnSWtPcq6q91klcKtRYQkxYGt8LUFoyCpy5C13qD++sFX/h1maapKHDu/OtE6G0NlrEM+hj3fA+lrT9ERUVdRYIc5aZEc6NRKfXtcwPPxwKgHM03pkwL2koBdXevyi9l0vLSWeskPqtKFYqRsTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAdzt7Na; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721844160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4xHXpZqg+KRUI+QCOaM8qkzmkaxjhHYo1elyOFQ6Dw=;
	b=SAdzt7Na62T7JjWcEx4kFmIPKrnsN5dMaAwnSP0ma75KVTRYmN65g5wma0+bvr5W6+f4vt
	PYEFvDTY8lnkv0MrMw7+pKnSmh7ep0Xl86dre0jeRu9ZwJEZR9I1yosyKFw6ofL7UC3skN
	U8BFctuLWSMGpcxvQJB6+8qQn781pbE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-AvLdF1ShNgasGxfIvk1RwA-1; Wed, 24 Jul 2024 14:02:39 -0400
X-MC-Unique: AvLdF1ShNgasGxfIvk1RwA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-447f1c91e40so301791cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721844157; x=1722448957;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E4xHXpZqg+KRUI+QCOaM8qkzmkaxjhHYo1elyOFQ6Dw=;
        b=XRyX0w6K1K8ondsNzQ40aEnle7+qSXWPsaye+Vjf4OP31hDG2PeXGZjbWtfw7OFXD7
         n/XmhW5qIlbdb13ABp7SnU+sFU4qiInPsPmWiaXyqU8lpawuoLBy6DpByzE0KhA675Xk
         oWMqx0rqQRc+1FbL4E8wBYDxtuL51ZOfkIRX3PoM4jgdMAn9rzklfo/gN3iJMrIWF4b0
         jn16cz8rWQ++mLra5V4y2F3ohceq5UhjA1Ab3GTCMdL73OTi9qVuZfzAeSYMyDMo1256
         63MhpiE2mZzI2FFmk82u/uI9KqAsFfv2h7axU3ACy1gI9ZpoUrSzDnwM4WBdnKY/kzO/
         lqMA==
X-Forwarded-Encrypted: i=1; AJvYcCVwugnzac9q+wGCW8b0+YC0RTnucVlFo4/ekL78fiFqRvqXRy5NXLm3tXYNxgav0eKUcrnwSWwa3pBpckiGuRtsR8IarudrE4QpM34h
X-Gm-Message-State: AOJu0Yx3Giy9oZSd/+mu9JtXAk1g9UObD/gtK9Bk1yGdHh9dqAYrlLv5
	FgXrYOJcMSIwAaunX54TwrpwoAHNs2wlqDRivJZfBTovsmIegHTLS8utniR+OXBkcmw/z4DMZBX
	xVQJPPaoZ9XtrpzjMyqObjwSGmcFLuAAWhvHiF/4i2bZoAvh5h0lenxuUV1PQ7Xl2wkI3Dw==
X-Received: by 2002:ac8:5dd2:0:b0:446:5cb4:aee5 with SMTP id d75a77b69052e-44fe49a127fmr4496991cf.57.1721844156914;
        Wed, 24 Jul 2024 11:02:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKRx780BtkMoyyEhwyfSEZ1W7uSWCxxpMjm9sbfka5uYrMs7cLZnvUpd1z16M1yZtjJUWpGA==
X-Received: by 2002:ac8:5dd2:0:b0:446:5cb4:aee5 with SMTP id d75a77b69052e-44fe49a127fmr4496531cf.57.1721844156307;
        Wed, 24 Jul 2024 11:02:36 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fdd2a9390sm4086761cf.23.2024.07.24.11.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 11:02:35 -0700 (PDT)
Message-ID: <13e34c1654b47ba5ee5e1de8fa09aabd45dbe159.camel@redhat.com>
Subject: Re: [PATCH v2 47/49] KVM: x86: Drop superfluous host XSAVE check
 when adjusting guest XSAVES caps
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Wed, 24 Jul 2024 14:02:34 -0400
In-Reply-To: <Zo2MPSccg3AEz4qM@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-48-seanjc@google.com>
	 <46361f0c834a25ad0a45ca2f1813ade603d29201.camel@redhat.com>
	 <Zo2MPSccg3AEz4qM@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-07-09 at 12:15 -0700, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > > Drop the manual boot_cpu_has() checks on XSAVE when adjusting the guest's
> > > XSAVES capabilities now that guest cpu_caps incorporates KVM's support.
> > > The guest's cpu_caps are initialized from kvm_cpu_caps, which are in turn
> > > initialized from boot_cpu_data, i.e. checking guest_cpu_cap_has() also
> > > checks host/KVM capabilities (which is the entire point of cpu_caps).
> > > 
> > > Cc: Maxim Levitsky <mlevitsk@redhat.com>
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/svm/svm.c | 1 -
> > >  arch/x86/kvm/vmx/vmx.c | 3 +--
> > >  2 files changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index 06770b60c0ba..4aaffbf22531 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -4340,7 +4340,6 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> > >  	 * the guest read/write access to the host's XSS.
> > >  	 */
> > >  	guest_cpu_cap_change(vcpu, X86_FEATURE_XSAVES,
> > > -			     boot_cpu_has(X86_FEATURE_XSAVE) &&
> > >  			     boot_cpu_has(X86_FEATURE_XSAVES) &&
> > >  			     guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE));
> > >  
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index 741961a1edcc..6fbdf520c58b 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -7833,8 +7833,7 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> > >  	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
> > >  	 * set if and only if XSAVE is supported.
> > >  	 */
> > > -	if (!boot_cpu_has(X86_FEATURE_XSAVE) ||
> > > -	    !guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE))
> > > +	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE))
> > >  		guest_cpu_cap_clear(vcpu, X86_FEATURE_XSAVES);
> > 
> > Hi,
> > 
> > I have a question about this code, even before the patch was applied:
> > 
> > While it is obviously correct to disable XSAVES when XSAVE not supported, I
> > wonder: There are a lot more cases like that and KVM explicitly doesn't
> > bother checking them, e.g all of the AVX family also depends on XSAVE due to
> > XCR0.
> > 
> > What makes XSAVES/XSAVE dependency special here? Maybe we can remove this
> > code to be consistent?
> 
> Because that would result in VMX and SVM behavior diverging with respect to
> whether guest_cpu_cap_has(X86_FEATURE_XSAVES).  E.g. for AMD it would be 100%
> accurate, but for Intel it would be accurate if and only if XSAVE is supported.
This is a good justification, and IMHO it is worth a comment in the VMX code,
so that this question I had won't be raised again.


> In practice that isn't truly problematic, because checks on XSAVES from common
> code are gated on guest CR4.OSXSAVE=1, i.e. implicitly check XSAVE support.  But
> the potential danger of sublty divergent behavior between VMX and SVM isn't worth
> making AVX vs. XSAVES consistent within VMX, especially since VMX vs. SVM would
> still be inconsistent.
> 
> > AMD portion of this patch, on the other hand does makes sense, due to a lack
> > of a separate XSAVES intercept.
> 
> FWIW, AMD also needs precise tracking in order to passthrough XSS for SEV-ES.
Makes sense too.

> 

Best regards,
	Maxim Levitsky




