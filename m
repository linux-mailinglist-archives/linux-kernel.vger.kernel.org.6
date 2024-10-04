Return-Path: <linux-kernel+bounces-350064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F204798FF43
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250D11C21837
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3EE13FD83;
	Fri,  4 Oct 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqRptNBu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E49781ACA
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032658; cv=none; b=it0d7I8MbK/O7DoZr18NPLql/WSDEqJq0K0D8GMPzUDUmwcsP7vJCTs5z8qUq6/lxWC4qRhlnvxxmKKuRL3aHtTjxw/EIWcLAqy3DjKukmCjcAKPDu66YZQVjAjwLTX6y6bqdCtJIdmUymvKKHmCpbTdeFldE9+zjh2A4KE6H68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032658; c=relaxed/simple;
	bh=ZnnyuXNFVICI+SzzG8WbBqu6A9lH+PhQvaNki3KNcEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HA5s/zREz4NNkW9oXvRzTz+TVlIIOAv5iOebCwbxKU7VvaKuBq5WuGoO9yjxnQfQXOJKdcz9vdjX6mvXm3AI1UOnlz+CCNcri0csfVhmqmsJr6z+vqQCYWvS+EKX4dEMd/CWsXFQAAHKSC+ywT4EH9uGKrF198rKdcQW+KEdwF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqRptNBu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728032655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pm6ndtAn1q8+idFufOTXT4a/EfTyQS3zONVFfujpzYE=;
	b=KqRptNBumVBNsBqArCqPrxYlR9v3OJoMUFu0VtJGyx+l/8wJFf2UQOqg5Z0eOTtpUhlIyJ
	g6qwhIjvwArDdsFWoTmYg6X/5c/TL5HgD1hmVhE1JaIuBWTq/gxHEzTtkjK50a2B4uZCBr
	fdtdYwT8QdHAAcxvV3FfE9lpMp+y9Xk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-ig7bL7WgMzSuGVaRVf95NQ-1; Fri, 04 Oct 2024 05:04:14 -0400
X-MC-Unique: ig7bL7WgMzSuGVaRVf95NQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37ccd40aad4so816671f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 02:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032653; x=1728637453;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm6ndtAn1q8+idFufOTXT4a/EfTyQS3zONVFfujpzYE=;
        b=B6yETS4FmMm4F1lCsgwF/VxfcgstUlYamgYWZt3DzXnl4D0xZfKmGPMo+ylwkkhOkr
         LMmjwFWZ3taAHS0wqhf8pFElDd1xOqxWQpjNm9YLxy8HqKvYAduyX087jVMkETk5RPMC
         YrPtE+b4T3TjN9vOukThgx7TBIJ2Zhc1NbwpQTIc4HT+nRz8kdZgr/fFSP72VJgsv4ZJ
         vi3Q6yeO9+DO67Ru8Sx6RZIyGR6MRjPi4ZLtuqRPJGmSXS/4DP0RNsdmA8BJaz4y8Huc
         n0cEbeqDeqIKgQ/I46bfVZvoGEoTJaZDOTLha5QxUUqhQkUGufKtnCN5+1D3TP4yD7wG
         CNvg==
X-Forwarded-Encrypted: i=1; AJvYcCWfewicwhumFfJZaaTVAp9/Cynuin8ZdbmwlGSAbrNSvFKUF4I9l6Qbu5A5UYuOWuaj2IxUqzvWmFJVHZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFk1w8PFVSwIrMBfJMTBwyFbcJOtSCaPTqHK8y1A9aN7bFdRU5
	1/SiO+Zl3Rd5ZWaeR/jn9i51svN5wxG+Vv+uw9HN0g1MD3sLW0Fft9HJpK3iJv3SAKRaym2OjZA
	N0IDa+dd8LqxIYls20HYzhNQxdsO2GucUDiVYhJd8w+F7V1uDV7i8E4+opNxZ4r73xFLAx6rEpk
	XJ+Qlye1LVtzKSlbyv05sSLrnRS3fdwrjAEdX4qHjB6JJ/HQ==
X-Received: by 2002:a5d:59a2:0:b0:374:bb1b:d8a1 with SMTP id ffacd0b85a97d-37d0e746f3cmr1415469f8f.13.1728032652951;
        Fri, 04 Oct 2024 02:04:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfG1MFeWmhwXUn9wRJSt39ET0vsHHWNvNq9ie+ynt77MAK8P20ZOwDvzMFKZTuF3rhJrk1Fw==
X-Received: by 2002:a5d:59a2:0:b0:374:bb1b:d8a1 with SMTP id ffacd0b85a97d-37d0e746f3cmr1415441f8f.13.1728032652515;
        Fri, 04 Oct 2024 02:04:12 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082e6ecbsm2829776f8f.116.2024.10.04.02.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:04:12 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] KVM: selftests: Verify XCR0 can be "downgraded"
 and "upgraded"
In-Reply-To: <20241003234337.273364-7-seanjc@google.com>
References: <20241003234337.273364-1-seanjc@google.com>
 <20241003234337.273364-7-seanjc@google.com>
Date: Fri, 04 Oct 2024 11:04:11 +0200
Message-ID: <87o740i6ic.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Now that KVM selftests enable all supported XCR0 features by default, add
> a testcase to the XCR0 vs. CPUID test to verify that the guest can disable
> everything except the legacy FPU in XCR0, and then re-enable the full
> feature set, which is kinda sorta what the test did before XCR0 was setup
> by default.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c b/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
> index a4aecdc77da5..c8a5c5e51661 100644
> --- a/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
> @@ -79,6 +79,11 @@ static void guest_code(void)
>  	ASSERT_ALL_OR_NONE_XFEATURE(supported_xcr0,
>  				    XFEATURE_MASK_XTILE);
>  
> +	vector = xsetbv_safe(0, XFEATURE_MASK_FP);
> +	__GUEST_ASSERT(!vector,
> +		       "Expected success on XSETBV(FP), got vector '0x%x'",
> +		       vector);
> +
>  	vector = xsetbv_safe(0, supported_xcr0);
>  	__GUEST_ASSERT(!vector,
>  		       "Expected success on XSETBV(0x%lx), got vector '0x%x'",

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


