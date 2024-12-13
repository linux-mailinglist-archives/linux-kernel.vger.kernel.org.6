Return-Path: <linux-kernel+bounces-444643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601139F0A21
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F570169E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB34C1C3BF7;
	Fri, 13 Dec 2024 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsRap7bg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A161C3BEB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087241; cv=none; b=L4GV8Vl3adUgPmMLhd4Jq36FnxxB7nESYwNHLBdTZlFFWXYpGTeTKttjHbhL4+OP/cncQ9kY1OUi7hOa6s/9L8clxzhWVOd+33aqgO0d8Hgmq4Ur/jSJcnt4bEDDwnN9qC1c6ZRiuMgICLSO9BrKoipRT6LpXfKoV925/USeh7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087241; c=relaxed/simple;
	bh=okqpacIbcOlbR8x92errleYPqAKmSIoPXXz7pzDyyqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=etblaX05esxryPciLprhdsuSXROltkUlDsZS3vefTua1vGT86+3iFEDjTC4Wa/Be3c/YV0M4isKd1NJP2KdDUplXzRyqPTuqoZ29YpS2RLDArtPIvTjn2y19udhj81nnYM6Jd4WRkgZoVM8MpDDi7RKxv39cekysEFSOgNR8/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsRap7bg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734087238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tZP36RlbgyjCPid9qIB9xpaONyqLFu9PuB4d/BcSVyY=;
	b=LsRap7bgoSHcgHTV4oLkKdWtl2Ym8iIwWt5OOyJOBnobwgAMey7ZYnyy4am7/9W6nI1ucV
	55wsvAENP7WLm7W/IXpeedhuu6RsTWjZ0vLpFo71ZVrZ9WYCBkUaCdN+cJcRsLSJZxfpiT
	RwQBpK3pp0hK3TJ/fxV+/bvXYim3ajI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-uQUNuLloPxGG3j-MVtH8xw-1; Fri, 13 Dec 2024 05:53:57 -0500
X-MC-Unique: uQUNuLloPxGG3j-MVtH8xw-1
X-Mimecast-MFC-AGG-ID: uQUNuLloPxGG3j-MVtH8xw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa6a1595fdaso37766366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734087236; x=1734692036;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZP36RlbgyjCPid9qIB9xpaONyqLFu9PuB4d/BcSVyY=;
        b=qczxjK8WZEEvkcrr9eLFp2unogtM7XO0fTx5r+3fcIEpf60l6Vqp/Fny/+yoe1oi3P
         CzPwxZU3E41MgzvP8kwq/oJBwQ4repI/QRrMvfX7AxgdUeqDrN/UDbfR7dp0ITBgoZoG
         5Nt54wymTYnFygYjiHe+V6/ZvbzbUkouljRJla+Sc+npPQEcQfLRYGDXyIIHcibbx/dL
         trbbPGjByQFn4/XtAZK5fOvRgAnifKY26DsV3D948RZhla4EaHe3ySbSJMBnRniSIbLF
         kgIzAMr4nlkZcaZPKlAhVsVWERNu0lM8OhQQfGSbwRaT7mf0bM9B8Gx1KQW8Lek1cWP1
         eceQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS4UoCfs9Rd3Ok6pweZjT028dDaFPJCiHC1Kg40cLhSgWFPAd3xZQ2si012wrCLjlajnb9yHbKv10C/AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHhsSHrEPO/EY2muRTdQwWemChSpTOsivKE3oGOZr8i4EVbNdW
	2mJbwxqX+nip4ZvbwlzKAQWyxj+iHMY2SGTacaVWcwQyy3cGMw53Wv8+G25Q33Q0kJSeFSwf1R/
	yiDLfL+gCVYuIYX8w4HlGd/tP90BMvM2n2VrGbng9Dms1el0SD+KTScWd7qTAqA==
X-Gm-Gg: ASbGncuXFJrEmB9rBhkdVcXhV98REcgYB1mrYvhm/ePZoJ6xz5uozpdhBNCyxrpFYug
	NNERCyo8WHseJPnPdP5T+xbYhymUgLo4tPNdlvwLmy1M8o3dqVPgrQPJeILEGtIQh4VcHgbQya8
	JgqB6tKKauqCf5fifyVNT8ixWF1U5BAYcNeUJaatlBuASlyWWCoNzn+Ko8oS3ONLy8D+hejR0YK
	D9DITz9YrffdP1ijRNXP1LHaVOUoeQbIbQpOOxz7hLiQf/emxw=
X-Received: by 2002:a17:907:7853:b0:aa6:762e:8c20 with SMTP id a640c23a62f3a-aab77e96883mr225245266b.43.1734087236007;
        Fri, 13 Dec 2024 02:53:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpmtuh+bOXDCMGt5rVmLOBisZQNKYOnKYDf15tmo1bduSNwY/0Lm8b87Kpa+9sghGVqcOKLg==
X-Received: by 2002:a17:907:7853:b0:aa6:762e:8c20 with SMTP id a640c23a62f3a-aab77e96883mr225242366b.43.1734087235662;
        Fri, 13 Dec 2024 02:53:55 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa69f639f59sm513076066b.193.2024.12.13.02.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:53:55 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Jarkko
 Sakkinen <jarkko@kernel.org>
Cc: kvm@vger.kernel.org, linux-sgx@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, Hou
 Wenlong <houwenlong.hwl@antgroup.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>,
 Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang
 <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Subject: Re: [PATCH v3 01/57] KVM: x86: Use feature_bit() to clear
 CONSTANT_TSC when emulating CPUID
In-Reply-To: <20241128013424.4096668-2-seanjc@google.com>
References: <20241128013424.4096668-1-seanjc@google.com>
 <20241128013424.4096668-2-seanjc@google.com>
Date: Fri, 13 Dec 2024 11:53:54 +0100
Message-ID: <87ed2bsvjx.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> When clearing CONSTANT_TSC during CPUID emulation due to a Hyper-V quirk,
> use feature_bit() instead of SF() to ensure the bit is actually cleared.
> SF() evaluates to zero if the _host_ doesn't support the feature.  I.e.
> KVM could keep the bit set if userspace advertised CONSTANT_TSC despite
> it not being supported in hardware.

FWIW, I would strongly discourage such setups, all sorts of weird hangs
will likely be observed with Windows guests if TSC rate actually
changes.

>
> Note, translating from a scattered feature to a the hardware version is
> done by __feature_translate(), not SF().  The sole purpose of SF() is to
> check kernel support for the scattered feature, *before* translation.
>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 097bdc022d0f..776f24408fa3 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1630,7 +1630,7 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
>  				*ebx &= ~(F(RTM) | F(HLE));
>  		} else if (function == 0x80000007) {
>  			if (kvm_hv_invtsc_suppressed(vcpu))
> -				*edx &= ~SF(CONSTANT_TSC);
> +				*edx &= ~feature_bit(CONSTANT_TSC);
>  		}
>  	} else {
>  		*eax = *ebx = *ecx = *edx = 0;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


