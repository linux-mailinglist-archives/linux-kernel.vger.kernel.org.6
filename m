Return-Path: <linux-kernel+bounces-224248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE466911F60
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21570B21284
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E940816E886;
	Fri, 21 Jun 2024 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oxdPZVSR"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FA016E87B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959941; cv=none; b=aeOV8/p/qLaednlqJOFwKVeYqRHXUI058Y+ohHD8E6RvEysMgNtUvZZUMEvZEVx+1AmStdIuX8IgVOGYyCP2i5LwM/Lvvl94Zue7AJxJr/nVjEFn0bhUdl74MsGAGt+QgsqvoPOrHnfXlDB72Zi0gLrooqkO06hiRUf7Bax8cpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959941; c=relaxed/simple;
	bh=oyd6tqzCssv79HaS77mTO3luXMR8x4PmFt1/HZ/Luno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geKKIjWPpSWdLRq0enH7/uRFCHcIqhAODK8M9NDcTJK9cnjgi4i/bHtk+qjUuXsq0YQm51kda9neH4EeRRg0iSu9J1XRssAwhTBf3in42k8EAZ95UbKQFvBkTwXhv1eptaHsMtKEuulHJ3Oj3LaL9oIbzrux/41WIR01IhgGdSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oxdPZVSR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee83so1808791a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1718959938; x=1719564738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ukPXaU0glvKU/7I3AqPS9+256PDmrqJDsAc1cKI4X+E=;
        b=oxdPZVSR6YwNifwjMH1+ZayCkGPHsAM3dSZ6SQjJoUA73/OhIa52xdSoTrmJfu/Njk
         UUF6wSR4PsQCPe2uO4nWfP8yLbcpY9eaJK9bfWyViXR1KvRHIVfDOJXdFZLJqCaKBG15
         2NAqSmw0t2XpvdfMiexD9OfehGT+gSAZdqCC8nA9Dtpi5x0HTPdqf/6cobX7dEa28eW+
         mOV450hVDnGw1w15fk/VMiHZMKWTBa1VKy0hZFaqh6IoQdc25sKpiRWFRrYy4WF4xcGZ
         X9i6DB556qklqfLgmhjrhiw6J4Dhbr1SBnc3dDwG7SPxKvDD9PPnM3Q8EbWd1yHIkACZ
         W21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718959938; x=1719564738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukPXaU0glvKU/7I3AqPS9+256PDmrqJDsAc1cKI4X+E=;
        b=fdtcTjtWCDl3+eWG7GMBFlzXrh+b374ZlpMqipscucBoHEW0KS4fHOtM48J1J5KPKu
         dSXT2PTYTpG1//S1GTsjOVMknIA/GZq8kCHV1HUYugyzl/8Y2Bo+b4Tjs6zw+QDScKgi
         zJOne82gfk7drbf4sZdXXBO0zlRJ0gA5kxlj7IqEVNGi5LyDMpLmTP4Jn8OQ2Kgo6cg1
         wNtVRI1GlaM/tx/kZk1LaxPnIe2qqWaCNKg0FAyKyeJo/x1tVSlokDm4KkySS/ElwOVL
         WTM3WoX1Pvc7wm0toqmQb2/SigwJBjuzFNm1Rfus3iGRVp0fehUkNagGbQIF/dBxcMOi
         DgyQ==
X-Gm-Message-State: AOJu0YyKIcMmX24k5qAeJPEfPTDhiTuZFs3SbyVivRe+STeIcKvXvr8S
	vMnEWeJJO42zA8J3iq3hxIj/HE8DM5zQaSXQWwYeLHtbANxUVZ/Z6Usbt9TEDyc=
X-Google-Smtp-Source: AGHT+IEOv3FuOP7yCRAQOMLITeYFGmCeSmvpsPwwBR+OGalAkovKxddKBE/uIo2uXeSYC7CiBt7kXA==
X-Received: by 2002:a50:ed07:0:b0:57c:bf3b:76f5 with SMTP id 4fb4d7f45d1cf-57d07edce7amr5090452a12.35.1718959937580;
        Fri, 21 Jun 2024 01:52:17 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30535010sm630961a12.59.2024.06.21.01.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 01:52:17 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:52:16 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, apatel@ventanamicro.com, alex@ghiti.fr, 
	greentime.hu@sifive.com, vincent.chen@sifive.com, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v5 3/4] RISC-V: KVM: Add Svade and Svadu Extensions
 Support for Guest/VM
Message-ID: <20240621-2c3ffd345cba1317bc0f5f9d@orel>
References: <20240605121512.32083-1-yongxuan.wang@sifive.com>
 <20240605121512.32083-4-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605121512.32083-4-yongxuan.wang@sifive.com>

On Wed, Jun 05, 2024 at 08:15:09PM GMT, Yong-Xuan Wang wrote:
> We extend the KVM ISA extension ONE_REG interface to allow VMM tools to
> detect and enable Svade and Svadu extensions for Guest/VM. Since the
> henvcfg.ADUE is read-only zero if the menvcfg.ADUE is zero, the Svadu
> extension is available for Guest/VM only when arch_has_hw_pte_young()
> is true.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 2 ++
>  arch/riscv/kvm/vcpu.c             | 6 ++++++
>  arch/riscv/kvm/vcpu_onereg.c      | 6 ++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index e878e7cc3978..a5e0c35d7e9a 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -168,6 +168,8 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_ZTSO,
>  	KVM_RISCV_ISA_EXT_ZACAS,
>  	KVM_RISCV_ISA_EXT_SSCOFPMF,
> +	KVM_RISCV_ISA_EXT_SVADE,
> +	KVM_RISCV_ISA_EXT_SVADU,
>  	KVM_RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 17e21df36cc1..21edd60c4756 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -540,6 +540,12 @@ static void kvm_riscv_vcpu_setup_config(struct kvm_vcpu *vcpu)
>  	if (riscv_isa_extension_available(isa, ZICBOZ))
>  		cfg->henvcfg |= ENVCFG_CBZE;
>  
> +	if (riscv_isa_extension_available(isa, SVADU))
> +		cfg->henvcfg |= ENVCFG_ADUE;
> +
> +	if (riscv_isa_extension_available(isa, SVADE))
> +		cfg->henvcfg &= ~ENVCFG_ADUE;

nit: I'd write this as

	if (!riscv_isa_extension_available(isa, SVADE) &&
	    riscv_isa_extension_available(isa, SVADU))
		cfg->henvcfg |= ENVCFG_ADUE;

> +
>  	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
>  		cfg->hstateen0 |= SMSTATEEN0_HSENVCFG;
>  		if (riscv_isa_extension_available(isa, SSAIA))
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index c676275ea0a0..06e930f1e206 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -15,6 +15,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/kvm_vcpu_vector.h>
> +#include <asm/pgtable.h>
>  #include <asm/vector.h>
>  
>  #define KVM_RISCV_BASE_ISA_MASK		GENMASK(25, 0)
> @@ -38,6 +39,8 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(SSAIA),
>  	KVM_ISA_EXT_ARR(SSCOFPMF),
>  	KVM_ISA_EXT_ARR(SSTC),
> +	KVM_ISA_EXT_ARR(SVADE),
> +	KVM_ISA_EXT_ARR(SVADU),
>  	KVM_ISA_EXT_ARR(SVINVAL),
>  	KVM_ISA_EXT_ARR(SVNAPOT),
>  	KVM_ISA_EXT_ARR(SVPBMT),
> @@ -105,6 +108,9 @@ static bool kvm_riscv_vcpu_isa_enable_allowed(unsigned long ext)
>  		return __riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSAIA);
>  	case KVM_RISCV_ISA_EXT_V:
>  		return riscv_v_vstate_ctrl_user_allowed();
> +	case KVM_RISCV_ISA_EXT_SVADU:
> +		/* The henvcfg.ADUE is read-only zero if menvcfg.ADUE is zero. */
> +		return arch_has_hw_pte_young();
>  	default:
>  		break;
>  	}
> -- 
> 2.17.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


