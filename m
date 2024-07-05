Return-Path: <linux-kernel+bounces-241869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2869928077
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412BAB21B6D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD401C693;
	Fri,  5 Jul 2024 02:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qf2wVQTc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3284171A4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147016; cv=none; b=M3XjnxwQyJEyGP0lCTMsfFyjS/c9SbDz4XXV/1x0Ir1svBJZiKv/zlyTW7PHWxQSqR/VSIfilKcHvjxRQpRZHMB4lB6ueCPYI2E2XMFLY4Wiax2kYyvSgGeFDgBiI6BGGmwMkmfBqsf6k2w5otS/z+7GKUl3EZvc3ItT3/NDChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147016; c=relaxed/simple;
	bh=v9OmgWrcgi2iMRVQV/aQiA5Cbw0Rs6Pnul1PFLcxJ4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F0EyvAgdnt+CQQfX7PTbJ/qm8XiyeKSN12hrRfJPsOdErrjDp6RsQzWjYrUXtS5iqr45wp6ZMVH7gZw+50jKdNY+0bNA2fDDL4Lend+x2o3oD8EW5LV3dDVld/fBAKDengBQ32+0UOBQtA4V1IctZm39/y48XGYwUM7Lgjs7ypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qf2wVQTc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720147013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CY2pdHWwgzF9spn4goYpidxcOqHNB7VNnMsNX5GrPs=;
	b=Qf2wVQTcSr99VaC8+LltiOngjGapRSbm7axGbMh8v1gGslaUIKrh24ZDFxwZbRChBS4QTB
	bSe9pB2wcS+t2xVspGow7iGc5D00z87GQBsO3n9j6rXvyb3qXMX2gl1mOzWw63LbTNnDO9
	lIx4QK4k4KLPhpw8llyaT+rsyRNSwco=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-gD04av_UNwSBBO81OS6J6w-1; Thu, 04 Jul 2024 22:36:52 -0400
X-MC-Unique: gD04av_UNwSBBO81OS6J6w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b5ebf8a8f3so15033546d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720147011; x=1720751811;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CY2pdHWwgzF9spn4goYpidxcOqHNB7VNnMsNX5GrPs=;
        b=vmaBp/pJ7fXe+qAY7vgYwVwYYnZrbcA/KDQsetGXOnyGlKjzxZReOPfVR12BFHcGt2
         r5Mp77Kot7euo3NQ6wBJQdik6V4yId8VGlV/dQu8Z/7pigbrcNbmJSey1PdxB5crdi7a
         BYXyz0zT9zjRsU6D/g2AE50KJmgDBEwBUU6LsJZamPCY1/Cfa9XFW+VLKeCwxkLyNEU0
         giUKT3PdSY0TVfzNFrflTIJ1HdzIL6u7L9A1xPXe5S/+iH8iVef8+2b4Y/vOrn4yfD8A
         ReTK4uFQV3KgjAnzrJn3Yp5KJ8deVX/5NsE/eMp/LwtqMirwKe/DrUcCQWQCLYabSfKN
         FTRg==
X-Forwarded-Encrypted: i=1; AJvYcCWr2EJ4K7cxk/DDY3/gHwSymoSMfClRfPAaT44lZfvFjAmrV4Q9UnF0uoeajBe0lH3eEtPIV//xJMUzxErVId9u2mRyEmnbqSZEKex/
X-Gm-Message-State: AOJu0YwJJobsGapGakg13ucxK/sQ/zsRuFD1/pifRjmw3AiODJ0bn8EJ
	f+udXnMJABGzTzSQseBKqMXRSMFNhFpnHGIWqys8q8FX8rmK+KO9QZWDzceacGiFl9DNYyEO8qq
	4Qu5jqlk1VO9w0F+aoMEpGG4yTXgnbosdo3g9ahTB1hc5KHDO4tfUcx1nkvrS3MlF/kH1jA==
X-Received: by 2002:a05:620a:b1c:b0:79d:53b5:9e94 with SMTP id af79cd13be357-79eee2bc295mr375704485a.63.1720147011659;
        Thu, 04 Jul 2024 19:36:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1Xq4eF9vAd6slC3xosMDSsAaFQIhx2y5lmUGdqmIWHFHBw4AiAqs7wKb4WhdI9Ufy6W3k/Q==
X-Received: by 2002:a05:620a:b1c:b0:79d:53b5:9e94 with SMTP id af79cd13be357-79eee2bc295mr375702785a.63.1720147011323;
        Thu, 04 Jul 2024 19:36:51 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d6927aa57sm732020085a.39.2024.07.04.19.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:36:51 -0700 (PDT)
Message-ID: <46361f0c834a25ad0a45ca2f1813ade603d29201.camel@redhat.com>
Subject: Re: [PATCH v2 47/49] KVM: x86: Drop superfluous host XSAVE check
 when adjusting guest XSAVES caps
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 22:36:50 -0400
In-Reply-To: <20240517173926.965351-48-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-48-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> Drop the manual boot_cpu_has() checks on XSAVE when adjusting the guest's
> XSAVES capabilities now that guest cpu_caps incorporates KVM's support.
> The guest's cpu_caps are initialized from kvm_cpu_caps, which are in turn
> initialized from boot_cpu_data, i.e. checking guest_cpu_cap_has() also
> checks host/KVM capabilities (which is the entire point of cpu_caps).
> 
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/svm.c | 1 -
>  arch/x86/kvm/vmx/vmx.c | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 06770b60c0ba..4aaffbf22531 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4340,7 +4340,6 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	 * the guest read/write access to the host's XSS.
>  	 */
>  	guest_cpu_cap_change(vcpu, X86_FEATURE_XSAVES,
> -			     boot_cpu_has(X86_FEATURE_XSAVE) &&
>  			     boot_cpu_has(X86_FEATURE_XSAVES) &&
>  			     guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE));

>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 741961a1edcc..6fbdf520c58b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7833,8 +7833,7 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
>  	 * set if and only if XSAVE is supported.
>  	 */


> -	if (!boot_cpu_has(X86_FEATURE_XSAVE) ||
> -	    !guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE))
> +	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE))
>  		guest_cpu_cap_clear(vcpu, X86_FEATURE_XSAVES);

Hi,

I have a question about this code, even before the patch was applied:

While it is obviously correct to disable XSAVES when XSAVE not supported, I wonder:
There are a lot more cases like that and KVM explicitly doesn't bother checking them,
e.g all of the AVX family also depends on XSAVE due to XCR0.

What makes XSAVES/XSAVE dependency special here? Maybe we can remove this code to be consistent?

AMD portion of this patch, on the other hand does makes sense, 
due to a lack of a separate XSAVES intercept.

Best regards,
	Maxim Levitsky

>  

>  	vmx_setup_uret_msrs(vmx);





