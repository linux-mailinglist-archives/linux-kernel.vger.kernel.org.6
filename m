Return-Path: <linux-kernel+bounces-326285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 936619765E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDBD28558A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764F6195962;
	Thu, 12 Sep 2024 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DsDWue+6"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C8192B68
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134077; cv=none; b=t0d7QpSRGvsq4f6w+ZhtmMKDvXebmM6LIB9DzXPhageBFyPUJBQC5xzViLvcPWjZuILnIPdYf/poy0Ro8UXZke5QfWNj4YuHrVVyFxbTlNtHq1FYN2Xx98GKc8b/tJdNE/vO6t7XnwGsQB51ep9kHalCgRWiETHAOghnde8CK9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134077; c=relaxed/simple;
	bh=j4p7rekU9XpaxoYQxOygTZbro1GDTOZAkbJ5AtXBJiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWKynibO/w81XXFk3BOs7PJD1ipucwPxHqyyZcFktKhJz6ivxo/W240qOsKkg+L6EKroBCe/vsgCAYGaeGerHVvLzHnChiG07JVdlOxbhYAK7TtzfXOHQL7hjlAa7MxxGLLVFWPP7bLCdEffJjGgJ16aVmPhIVEYgTyXbzPsZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DsDWue+6; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365aa568ceso972698e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1726134073; x=1726738873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aiemgFzmdlVArSRtl/VBHqqgaU54TtFT6LBWQAz3Kr8=;
        b=DsDWue+6/1tXAablIqROh0kHi9x4kA/MclEZq4ced9AkzHcxKHnJe5d1iYSLylJSeO
         NcH4R6wgh1qDYMQP1WWsDjJ9MmFWCghXq9hpMc/8QlTq+WrmDiu3XQI5QXSJRBoo+UYs
         csel8rdu9bcE1suO+371l9kWHOMAYWeSj3XmIIl9oxaJUnaUQbFojxeREJ88AnYNdJVr
         f+ZgXFhiZaX1Dd09kOp8OTMH8QmJk5svpAsd4ofZt7KyQ4iaMAPS5S8Vhgpd+CX0jk8s
         jS2amX2vUzezPH2Pep2wP0gsbWiDXBqS7Ckw9vAlm+6V5KlEP3D6/o9RqN7J5HymQN9c
         An1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726134073; x=1726738873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiemgFzmdlVArSRtl/VBHqqgaU54TtFT6LBWQAz3Kr8=;
        b=g3JE0H3DupuuZByLQfriilK3DRKAw30zlbph2M/wEL1pW8lmIK8gneF7d13hiUKfMr
         6UrhpBe37kOQtMQAU5RzsTIiq7Oaz/yZF8qPXM/T5vcjtzMDPM7IVxJc8cjja5Alzsp2
         WRO4bO/DfeI0jqFFOPuVaBiMdr+qOhcffY4id7kxWzX5Q3Br27BFRxAU4XDgeLBvCjtO
         W3Rv82rrwX9Rv309TeTWdR7yjhrkMKb6UqbJTGt6tOPvilkGpFXH3gCxQOssJphTQTwO
         yJ2vkcZxQTNEKln7XYGcn5fSKR+ulWflbZWTeFMKIM+siqtF1b7LWvK2o5Rcm4ouapzj
         9Sjw==
X-Forwarded-Encrypted: i=1; AJvYcCU5GJlt3i5FxLCCSau7c6I0Rm31g0jSkVRi0SVHmGLET/zfSU6udjqODTpNWkF5oKQ1x6VhprH8peJd6pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYAHa8RxbIsIz4PSq5imIsjjksHApkueve4ygOlJasKbUglKhC
	RRpLDHSCjnDH9zWh5p8mRxUwm/0aabt8RoKFF8FSHoODICtYOFlQnRAFvEzFw8c=
X-Google-Smtp-Source: AGHT+IE8hrIDE8jMWqmlxIeW/6mf22/C3WP/B4LyK9EfIJcAxDLa0UZEL1XXRZvbqP4WfQWiTVCnKg==
X-Received: by 2002:a05:6512:31d3:b0:536:5509:8857 with SMTP id 2adb3069b0e04-53678fb7196mr1697881e87.21.1726134072038;
        Thu, 12 Sep 2024 02:41:12 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72757sm721848266b.103.2024.09.12.02.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 02:41:11 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:41:10 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Subject: Re: [PATCH v2 04/13] KVM: selftests: Assert that vcpu_{g,s}et_reg()
 won't truncate
Message-ID: <20240912-75f992936cd9878d0e507498@orel>
References: <20240911204158.2034295-1-seanjc@google.com>
 <20240911204158.2034295-5-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911204158.2034295-5-seanjc@google.com>

On Wed, Sep 11, 2024 at 01:41:49PM GMT, Sean Christopherson wrote:
> Assert that the the register being read/written by vcpu_{g,s}et_reg() is
> no larger than a uint64_t, i.e. that a selftest isn't unintentionally
> truncating the value being read/written.
> 
> Ideally, the assert would be done at compile-time, but that would limit
> the checks to hardcoded accesses and/or require fancier compile-time
> assertion infrastructure to filter out dynamic usage.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 429a7f003fe3..80230e49e35f 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -683,6 +683,8 @@ static inline uint64_t vcpu_get_reg(struct kvm_vcpu *vcpu, uint64_t id)
>  	uint64_t val;
>  	struct kvm_one_reg reg = { .id = id, .addr = (uint64_t)&val };
>  
> +	TEST_ASSERT(KVM_REG_SIZE(id) <= sizeof(val), "Reg %lx too big", id);
> +
>  	vcpu_ioctl(vcpu, KVM_GET_ONE_REG, &reg);
>  	return val;
>  }
> @@ -690,6 +692,8 @@ static inline void vcpu_set_reg(struct kvm_vcpu *vcpu, uint64_t id, uint64_t val
>  {
>  	struct kvm_one_reg reg = { .id = id, .addr = (uint64_t)&val };
>  
> +	TEST_ASSERT(KVM_REG_SIZE(id) <= sizeof(val), "Reg %lx too big", id);
> +
>  	vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
>  }
>  
> -- 
> 2.46.0.598.g6f2099f65c-goog
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Shouldn't patches 3 and 4 come before patch 2 in this series?

Thanks,
drew

