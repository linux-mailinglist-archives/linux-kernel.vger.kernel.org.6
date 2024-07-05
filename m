Return-Path: <linux-kernel+bounces-241826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6FF928004
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BD61F23329
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE881B963;
	Fri,  5 Jul 2024 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRf05Co9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C941B950
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720145075; cv=none; b=ZzYZZirMMZWh/cCnYQvK98n0kKPm2V4vA3ZLzfFVhe/uVhcW3f1x2omz0DzdZPdsmgmNCl6Nxu8b3V9dElERRkhUNwZQU5PdaeBjtR+LifLzndIk7GW21fwCAo4Dmrn75shzrGhQPWr4c/KzHZ/LFQHyDeIlGDMMWAjqDxOLwc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720145075; c=relaxed/simple;
	bh=WTmA+XgWzRdUkRAteZOvT4+kv9CoJ3bbmb+9WOsOj8Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZHXcsHeccZAcSGFw85Hxz6Uvq1vFLVcda8HcownwmFirYfRuZ+yQrZ/7w98McnNzHG+va1kiLHfoxTlsYxgcbRn1ZCbUMnfvCSOtOYdjArlqUFZCA6E+08THBTihZmHlMPStUrHGJdqQ/KTUcb0t6jUNjt5etNHcTUguMw6d+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRf05Co9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720145072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7sipDhsIgWKuCcOQ9yCWrWbG6HZRi2UbYDjeBYr3i0=;
	b=HRf05Co9neU1MXpXk/OopCltQrKvI/K1mpbceoeI/FmkiiuzeDOkr1cS1fM8Q0tSJ/U7C/
	NJEWjIio5InDRmtjSJECzOFh0uV2fINlnFEqWwWqnWfzau/SqMtX5ecQaEIXGST2jdzwKk
	1PW1Pxb8EadNzN/ru4fn/3ooarZo0ks=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-NC_hwUIfOaOxsBQwT7B_Ng-1; Thu, 04 Jul 2024 22:04:30 -0400
X-MC-Unique: NC_hwUIfOaOxsBQwT7B_Ng-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4464a6a2f23so15710791cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720145070; x=1720749870;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7sipDhsIgWKuCcOQ9yCWrWbG6HZRi2UbYDjeBYr3i0=;
        b=OTFzVyBR7Z8SzVoF4/juNe0bbgeNnw+e2JtBfAVzblPK14T1td9sWmvzzd7evT4lK7
         dnOM07LHZOmdhtmlVqXu6yio+j1bZwy/IDBhOWLC+JaWz1d0OXhBgtSOUF/Imj0Scz/u
         wBhML1FI4wtY1HEJwBHmKCL6guKC44n/8JLbsA8hJ3WIrXGqZWcQCjQ0wmtIe6cz+MD6
         1wzCYVVElC+8HQsqQJRkloIbW+BeG7AOgBQu5pqN/lBWw0d01MNCN/st8Jj0H5bGYzVP
         zdRO9KTNhSrgfHMR9miKukNcnzpqwIlnevVGomeLR6xvVMmMhcLrD2WilolVhK+iETA+
         bd7g==
X-Forwarded-Encrypted: i=1; AJvYcCVnkAFaTCHy5dgJ2xo0vGLtgD9QDCkTg41/VSZJsYGJKSnLshxztUb3+04JfU4g0X5OAUGmeYNvIL7LZNSeop+G+7NwnySQFnC9Dd8i
X-Gm-Message-State: AOJu0YwIErTmm3/tdFuLG5ruKI1NxJv1c67slgZdk1mRhiwOnW5/14Dn
	Wk/9C4ZjdvDVG986pxWIl6GXaT16R66/5QTAjcVsHXk36FrPzSSEE/Q9ufasNgjunJ1EG/n6t3f
	itvkexgHqfV4U+NpSX0RptWlSDjNxh1Wbpq8krEauGY+pkydZ4y1eneUcdwquXQ==
X-Received: by 2002:a05:622a:586:b0:445:624:22ed with SMTP id d75a77b69052e-447cbec70e2mr48614261cf.9.1720145070160;
        Thu, 04 Jul 2024 19:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG39LIe8kAoYIDbOQNf9DgLvUvhbcD9nDFSlJCJmAlaf/1jbCEPU6kYB7PDh5wrylOpXHT4ew==
X-Received: by 2002:a05:622a:586:b0:445:624:22ed with SMTP id d75a77b69052e-447cbec70e2mr48614081cf.9.1720145069864;
        Thu, 04 Jul 2024 19:04:29 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465149bad4sm64915461cf.65.2024.07.04.19.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:04:29 -0700 (PDT)
Message-ID: <6f17f9620409dbfaa153332b934563405f5fab00.camel@redhat.com>
Subject: Re: [PATCH v2 34/49] KVM: x86: Advertise HYPERVISOR in
 KVM_GET_SUPPORTED_CPUID
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 22:04:28 -0400
In-Reply-To: <20240517173926.965351-35-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-35-seanjc@google.com>
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
> Unconditionally advertise "support" for the HYPERVISOR feature in CPUID,
> as the flag simply communicates to the guest that's it's running under a
> hypervisor.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index d1f427284ccc..de898d571faa 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -681,7 +681,8 @@ void kvm_set_cpu_caps(void)
>  		F(PCID) | 0 /* Reserved, DCA */ | F(XMM4_1) |
>  		F(XMM4_2) | EMUL_F(X2APIC) | F(MOVBE) | F(POPCNT) |
>  		EMUL_F(TSC_DEADLINE_TIMER) | F(AES) | F(XSAVE) |
> -		0 /* OSXSAVE */ | F(AVX) | F(F16C) | F(RDRAND)
> +		0 /* OSXSAVE */ | F(AVX) | F(F16C) | F(RDRAND) |
> +		EMUL_F(HYPERVISOR)
>  	);
>  
>  	kvm_cpu_cap_init(CPUID_1_EDX,

This makes sense.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



