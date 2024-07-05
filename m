Return-Path: <linux-kernel+bounces-241857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7934A92805C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1661C236B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49BB208A7;
	Fri,  5 Jul 2024 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+DjN0Xm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15FF3D55D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146152; cv=none; b=agoS71trnF9iWJ+zZ1KcXwG+PG3sQbEyiOxpJjwmN0Eec90tyhdYiyQhNkqK1l84FnIushNnf3AZFYi9pCivyPqZO6I+WgJMdsqZzVbrpCdb7mBfLeAxXVvF24iogvFhytoABU6x5g0zi/R39R5BEyMgy0M8nruAPxZ2jv5xkY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146152; c=relaxed/simple;
	bh=NapZZUDRrPOjOD7hmeC6ooeeQO+UVoWf3ur+giJO5Qo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dOihBXi+lGHhUXjco3W4IeLUTWWp7hfHzlxXTQI8uSVEgDJ2heTr7DtNYhm2sGaoX2lP8VdJ9lOLyHGFRAi/0MIN+XKpBkllmM3dxb1QNdERqGXpn2U/sFsciAFY8yCveevqJwcfHiiaxjB4QwfcckVIqi9jTqnvTytj0IfRvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+DjN0Xm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720146150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjyYkaA/WHaUDnxoizRMJYe279ct6UcqrvUL0yfxjPU=;
	b=E+DjN0Xmze0ma+8GIxc/RicFzD6mRF7pcYu8mKKd5T52PecQwpxd2chO7Yw2/CnmNkhvO4
	V85CP933SqJWndQqK8qeEn2nUbx7cZza5vqoy5i9jYmScofKjPetAF1JT6/jVHqQkrmy+X
	mtBPSGmUoULrZaL0K+sk9OfpmrynXg8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-pqQBdMdRPP2_mV7yGQYKgw-1; Thu, 04 Jul 2024 22:22:27 -0400
X-MC-Unique: pqQBdMdRPP2_mV7yGQYKgw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-651006802ebso17571107b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720146147; x=1720750947;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjyYkaA/WHaUDnxoizRMJYe279ct6UcqrvUL0yfxjPU=;
        b=mV5lrpKLv/WnSrenDkLsFCMExbSz9B2D8+IkqHOR+HhQod/5fghdy0FsYwOBesk2gX
         TW9zMJ/S8cmQB9OGjhd5lccVfC+PF2zBH6FhbY8WDA5r4MbVPSYSR7WBtI97bh+3kBNl
         uL2MJswc5pJM54JYRFcRG6MPefgMYSDsWt9fHwlcqgo+GowFdE91VTfkXRb9NaMiK+pl
         de7SEnjOdnlGsoYfb9zK8V9GUSyO69Qs74ve0tUnSiFfBFstK9P50yUPsC0AEfSzAr4g
         KkisiDckvaOqEedJ/+zOUfKGyLsKjOtNDbwHKERBMjMTz639V6IUapmxstUN/I7k5M6t
         z0kg==
X-Forwarded-Encrypted: i=1; AJvYcCWLN3qmf6ABg6dofDSU0o63qTdvntVU1EbIK3iGTb3vp6IXPULp2NCGkKNMIRPrg+c9fxE7DmEudKBxihTel8iQvCf1Sb0HK+ZFLhby
X-Gm-Message-State: AOJu0YxsdQTS/ZdY7vtqumNXsxSNv+W1YkaoxrYUwQIcc9Ck2AHP+1lx
	Wqh7gUFQxodFUwKYgEwdeJlu+zsVoI+0c6Uu1kSo6hHsqr7fwS1pdDQJSp7Pl4ixcUXouq2yLra
	GTlgPufcNZjVuF8ugMBZ/6LEW/0VkPosJto3BEwleeyjR8wInKIC1RA+Nntxakg==
X-Received: by 2002:a81:8388:0:b0:64b:69f0:f8ed with SMTP id 00721157ae682-652d8036fbdmr31922417b3.51.1720146147244;
        Thu, 04 Jul 2024 19:22:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLgnTKFCfkEiR+QoUwT2JIVvTCvhP6onUBXVZAlhfg+gaU00wMZsc+aVt5WRSkm7f9Rp2w7A==
X-Received: by 2002:a81:8388:0:b0:64b:69f0:f8ed with SMTP id 00721157ae682-652d8036fbdmr31922287b3.51.1720146146972;
        Thu, 04 Jul 2024 19:22:26 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69308142sm731282385a.117.2024.07.04.19.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:22:26 -0700 (PDT)
Message-ID: <f8e58280c31e7f37c36277928b48a3e4bde5d795.camel@redhat.com>
Subject: Re: [PATCH v2 42/49] KVM: x86: Drop unnecessary check that
 cpuid_entry2_find() returns right leaf
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 22:22:25 -0400
In-Reply-To: <20240517173926.965351-43-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-43-seanjc@google.com>
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
> Drop an unnecessary check that kvm_find_cpuid_entry_index(), i.e.
> cpuid_entry2_find(), returns the correct leaf when getting CPUID.0x7.0x0
> to update X86_FEATURE_OSPKE.  cpuid_entry2_find() never returns an entry
> for the wrong function.  And not that it matters, but cpuid_entry2_find()
> will always return a precise match for CPUID.0x7.0x0 since the index is
> significant.
> 
> No functional change intended.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 258c5fce87fc..8256fc657c6b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -351,7 +351,7 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
>  	}
>  
>  	best = kvm_find_cpuid_entry_index(vcpu, 7, 0);
> -	if (best && boot_cpu_has(X86_FEATURE_PKU) && best->function == 0x7)
> +	if (best && boot_cpu_has(X86_FEATURE_PKU))
>  		cpuid_entry_change(best, X86_FEATURE_OSPKE,
>  				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


