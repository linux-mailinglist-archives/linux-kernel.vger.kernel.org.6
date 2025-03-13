Return-Path: <linux-kernel+bounces-559687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6778FA5F816
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE2B420CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9FD2686BD;
	Thu, 13 Mar 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="P7yi17oi"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F41268680
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876042; cv=none; b=TlbDHXkWyekV5vWvuueLhL+FJge+P1hIMAOtm0hJqvG4a/zC61hQNaj5HFLGomfMQGYef2WH5pGhUp0cdXeSeUFiB3fJi8/CKiQ5DMK0hxlXYpcnPoE3olULYqu6UfgMrxpg9Tv3gTihAkGVvmikKjSm45gyYehQhnPhrX1v3lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876042; c=relaxed/simple;
	bh=oKvFJqfjCg0oe1WKlBfVLElWET9EO+f7JfuuJyGbUVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV+kBDN/2hn4Wk4cBJkh4vVA4rwaWVb8qtpLGYWNnLgd4k0ansFI3uEd0ahWG/Ov8RgsTDcecdDHojub+VqtZZWKgE3LMqnu4BVmvNvi6J2QnXOX3qTcNOFRL8DhZ8CaIGMzk0+vCRTeVjiir/hWsa1tO5GMIg9QfGPaFi45m+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=P7yi17oi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso6851825e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741876039; x=1742480839; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XLr2/Str8PUdULF1c2O3jE557wb7uOe7x8v7FUGx02s=;
        b=P7yi17oiP/kFyc7tFrJt1WkF3+jMRiMD0Icna6K78dT50QHQRWFdSHF6nvm8TDfg/h
         B2EtVmFVn9nXYvF58uA8KB1VM/QQC1FKN1B2U8BAnAeI/RVdSxN8UF2V9sEnWLhAiBXj
         /geP+giTm8aI3ss2BGq/LSi08PAt8qqwGDRUFmItaYbnbqj8azD63AXnGPcA+YCEhHEj
         161TDSSeOyu1ZHQD7uJcBNiOLnVwNVWPKNLixvjn9pUjBYIVanWtOIwnrd1TynV37EHW
         5ZFvrkUl2lWzpeMGzM+7SGSFZvUb2RNJQDvWeSkv87GO7qR65n8lXrdfyY1/OYFluqDQ
         uPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876039; x=1742480839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLr2/Str8PUdULF1c2O3jE557wb7uOe7x8v7FUGx02s=;
        b=im0dW0dksSG7kNjAK0MFTB4JlK6q2Yt2NuIUBDAoxeo+lOzC9XEUaTDQiKjC7udfST
         1u9SDkgboSd34RmTH+9Bz2hZDfjIfQQisD3I1uJqDEwiIpC3nlub35cwinY2Xo+aT4ta
         ZSzSU/ua2GuRgs6hRHZTVarTQUO3MRKB04Eg7Tm8NNynWyJ19+/6VeEFuOfXFdeWRx4L
         Lw5dFzNAIOZQ70bVa3DM3MOC3ZH4QDrIlBfaVTR872kcoiFvcqUlWZtYyUxKDElKaDlm
         EhVwaLQWeV7w6YJTi6lJ3EzAnVQIxBHoxf3mtCU8D9bWt15VzDjVQnLTNLTQlvrGr+Ug
         6T6g==
X-Forwarded-Encrypted: i=1; AJvYcCU1+uT3IX9yhR540FWeHa8QltlW6hbGhkrsCiFNM1GfuxFv749kNTMRHafyJ+/6AvjFvwZCd9IIbhPedxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWkfeCo4Hjz7HQbhTaE7WjvoJ1lywIDJsHrPS4X/KLRC/yKTN
	Y52HbgrfDlCqwoV+jmtkXnbJaW3vLKLYmGCu7M1//6rl7Dl+Gv9ytCpPd4RGrSU=
X-Gm-Gg: ASbGncsZetN8Ga5g+2uy+DrKTj37tHau8kFWz73TkCobKVNYoYXMcbB8ARudIhzVMwx
	LQMdUz6vukEvLhuegz6XlqOgEq4++6+hV/w0vWGwN6xxkCmBAFLY/u25hXhzQb2bK30tOUpeD13
	fndSEdofONVB9zeX9Dy6ZllhsGy/pGZCXFKtnE51DezOG5jxTNJbeUr1dA0rqtYvgDNzn/xIVul
	z01emsDC19rs/R4Bsd4KDEi+f3WVeraXAN32o8x6akiPizBWi0g0TL4SQ1k4qENg3t3lZKdmEAR
	xPmnKtzoTjioDZUHPUneXLo79a+pvLGRMcpD1VeCkEw=
X-Google-Smtp-Source: AGHT+IGx3Sab5SDKogjK4G9G6vPewBpr2VjhUbGJwcX+nwTAiQQruD0qs0HuNiII4DaXFL2TeXeVoQ==
X-Received: by 2002:a5d:64cb:0:b0:391:40b8:e890 with SMTP id ffacd0b85a97d-39140b8e9f4mr17833900f8f.22.1741876038933;
        Thu, 13 Mar 2025 07:27:18 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b34sm2303314f8f.55.2025.03.13.07.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:27:18 -0700 (PDT)
Date: Thu, 13 Mar 2025 15:27:17 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v3 14/17] RISC-V: KVM: add SBI extension init()/deinit()
 functions
Message-ID: <20250313-f08cee46c912f729d1829d37@orel>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-15-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310151229.2365992-15-cleger@rivosinc.com>

On Mon, Mar 10, 2025 at 04:12:21PM +0100, Clément Léger wrote:
> The FWFT SBI extension will need to dynamically allocate memory and do
> init time specific initialization. Add an init/deinit callbacks that
> allows to do so.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  9 +++++++++
>  arch/riscv/kvm/vcpu.c                 |  2 ++
>  arch/riscv/kvm/vcpu_sbi.c             | 29 +++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> index 4ed6203cdd30..bcb90757b149 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -49,6 +49,14 @@ struct kvm_vcpu_sbi_extension {
>  
>  	/* Extension specific probe function */
>  	unsigned long (*probe)(struct kvm_vcpu *vcpu);
> +
> +	/*
> +	 * Init/deinit function called once during VCPU init/destroy. These
> +	 * might be use if the SBI extensions need to allocate or do specific
> +	 * init time only configuration.
> +	 */
> +	int (*init)(struct kvm_vcpu *vcpu);
> +	void (*deinit)(struct kvm_vcpu *vcpu);
>  };
>  
>  void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
> @@ -69,6 +77,7 @@ const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
>  bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
>  int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
>  void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
> +void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
>  
>  int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
>  				   unsigned long *reg_val);
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 60d684c76c58..877bcc85c067 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -185,6 +185,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  
>  void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  {
> +	kvm_riscv_vcpu_sbi_deinit(vcpu);
> +
>  	/* Cleanup VCPU AIA context */
>  	kvm_riscv_vcpu_aia_deinit(vcpu);
>  
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index d1c83a77735e..858ddefd7e7f 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -505,8 +505,37 @@ void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu)
>  			continue;
>  		}
>  
> +		if (!ext->default_disabled && ext->init &&
> +		    ext->init(vcpu) != 0) {
> +			scontext->ext_status[idx] = KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE;
> +			continue;
> +		}

I think this new block should be below the assignment below (and it can
drop the continue) and it shouldn't check default_disabled (as I've done
below). IOW, we should always run ext->init when there is one to run here.
Otherwise, I how will it get run later?

> +
>  		scontext->ext_status[idx] = ext->default_disabled ?
>  					KVM_RISCV_SBI_EXT_STATUS_DISABLED :
>  					KVM_RISCV_SBI_EXT_STATUS_ENABLED;

                if (ext->init && ext->init(vcpu))
                    scontext->ext_status[idx] = KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE;

>  	}
>  }
> +
> +void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
> +	const struct kvm_riscv_sbi_extension_entry *entry;
> +	const struct kvm_vcpu_sbi_extension *ext;
> +	int idx, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
> +		entry = &sbi_ext[i];
> +		ext = entry->ext_ptr;
> +		idx = entry->ext_idx;
> +
> +		if (idx < 0 || idx >= ARRAY_SIZE(scontext->ext_status))
> +			continue;
> +
> +		if (scontext->ext_status[idx] == KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE ||
> +		    !ext->deinit)
> +			continue;
> +
> +		ext->deinit(vcpu);
> +	}
> +}
> -- 
> 2.47.2
>

Thanks,
drew

