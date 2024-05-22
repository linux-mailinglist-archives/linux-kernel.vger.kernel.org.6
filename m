Return-Path: <linux-kernel+bounces-185961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01398CBD68
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66491282B35
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C433980055;
	Wed, 22 May 2024 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="O8RWc39r"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666F174418
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368417; cv=none; b=quNQD5EHNKwmwmGKqzjlNDLOgtFTj4spTpGW73YyV8K8EwqiGB9xp2VgvwqY8CfIAyEAs1kcBdFaznZimKcYO7cH8uSbI6ElWICTbXa56y1ZcZ8rCu2QIB2yM37hRCnSeRCPXyqJgf3fyKC0IbVqdxKp3kMQMO2nXTzu0iawz2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368417; c=relaxed/simple;
	bh=kYOLY5Islms/P476NwRX1v9ZHFevROb1qpQI5RNmacU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR63r8jFB+44PaXbgMorLkUCVB1FqMRFwy5J2tNSVn6aILYiL7P54qWCSiyqHSgmPMplxRGPTGVirCWfwrjxTnvMJR+dsTZBg4QDlqjaO6Uyv5HBra/wvScfWSzBQTE/M4atdsMSKjyxVoQllpyHZMi6ma2z6y0Xp3BimzG3h+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=O8RWc39r; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a387fbc9so985203466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716368414; x=1716973214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ5Hr3rLuHhBVJcgCy9JEFxvkpMRBY5L1Hcin1IIURI=;
        b=O8RWc39rYkidxSXfT+BAilTg+tr0ZTGI+iiOn1ppQnOANVsGYhBjgv/MkXA3CAIOVS
         qDH1LnU+P85U6meYx7pO298+VK1s/sO+EWAv7G5B96FGSo4PFPbvEjKuMuL8urxH8nSo
         kUkeh1DO4ZQbxQ+hxT2TnQ4JJRKqhbKbVW0o2J2vW48FyB3HiW28QX5PuzJvCuHdi76x
         GAF69w4ZNOnNaRhiPIrIz8YfCfRH4S//zPyoPhzG1s2isDaX1WNjPszzHzpCQbTMxzWf
         pGSxKFfXG59bTtyrO2Rktvtgv+xiiluRlQPkcVECqA9E0KTYxO8A9z17/u/ivgo9n1pk
         v80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368414; x=1716973214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ5Hr3rLuHhBVJcgCy9JEFxvkpMRBY5L1Hcin1IIURI=;
        b=HmVAQYwKpFxMc8qGpP7qUq/+qLDWqBMVk99QEQ7WTnQlOKly+1oTwUGLjQdL7w1LGl
         nb7r6ejvgtMF33WiAy0Wjp27ZkRaGy3X7ZozK2TQ2c+8fqGdt/EeCEn1lxD4wpmXg7la
         2FrlnuBFjjtnnBFV+ytZLB5ZnZHgBGJXOREh+n33o6rmOuXcS9kRlvNc/5+UjTkJMExi
         4uqEV2cEGPmfjbiWiE+0p96j9DPEP0tZls4+Vqz/JNQYiD5umnWh8Vuzq1q2KTiRDUun
         GpSV1ysz1T0SuuH9B1+NpVWL68HEdinttjzm8GWQcZdzV64iPK2H5Zqem3nCnFl7exws
         K90Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkFwuEQQ5Pc7FRkZFr/IYYapESpI50gvl+jY/7zqWMCamM1GYt3oaTy9j7+xYhkb+pLs78mt+OCTbFFySNkXe0poYEL8x63HLJC0pi
X-Gm-Message-State: AOJu0Yx7PY0ygHBa/7TExNPj0fOP6D5vqUJ9YP9Dnyc8Z+4AAcuCjtcK
	ikv+ur0drCCr0kuuKeB2aWM6d8uzvEBIUXKyYYAT6IpCN7fJ15+yi7coOa7/ab8=
X-Google-Smtp-Source: AGHT+IEwdep8vQZ/ua7S5w4rCp0YCSyEUG5g9WHDPfQAhOr3vrC9k0evxDu/P938ceZsPJNhCgo6Ww==
X-Received: by 2002:a17:906:4c56:b0:a59:ca33:683f with SMTP id a640c23a62f3a-a622807c04dmr84271866b.28.1716368413766;
        Wed, 22 May 2024 02:00:13 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1789247csm1741002666b.82.2024.05.22.02.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:00:13 -0700 (PDT)
Date: Wed, 22 May 2024 11:00:12 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org, 
	greentime.hu@sifive.com, vincent.chen@sifive.com, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] RISC-V: KVM: No need to use mask when hart-index-bit
 is 0
Message-ID: <20240522-74009df58fb51008bae6cbaf@orel>
References: <20240415064905.25184-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415064905.25184-1-yongxuan.wang@sifive.com>

On Mon, Apr 15, 2024 at 02:49:04PM GMT, Yong-Xuan Wang wrote:
> When the maximum hart number within groups is 1, hart-index-bit is set to
> 0. Consequently, there is no need to restore the hart ID from IMSIC
> addresses and hart-index-bit settings. Currently, QEMU and kvmtool do not
> pass correct hart-index-bit values when the maximum hart number is a
> power of 2, thereby avoiding this issue. Corresponding patches for QEMU
> and kvmtool will also be dispatched.
> 
> Fixes: 89d01306e34d ("RISC-V: KVM: Implement device interface for AIA irqchip")
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  arch/riscv/kvm/aia_device.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> index 0eb689351b7d..5cd407c6a8e4 100644
> --- a/arch/riscv/kvm/aia_device.c
> +++ b/arch/riscv/kvm/aia_device.c
> @@ -237,10 +237,11 @@ static gpa_t aia_imsic_ppn(struct kvm_aia *aia, gpa_t addr)
>  
>  static u32 aia_imsic_hart_index(struct kvm_aia *aia, gpa_t addr)
>  {
> -	u32 hart, group = 0;
> +	u32 hart = 0, group = 0;
>  
> -	hart = (addr >> (aia->nr_guest_bits + IMSIC_MMIO_PAGE_SHIFT)) &
> -		GENMASK_ULL(aia->nr_hart_bits - 1, 0);
> +	if (aia->nr_hart_bits)
> +		hart = (addr >> (aia->nr_guest_bits + IMSIC_MMIO_PAGE_SHIFT)) &
> +		       GENMASK_ULL(aia->nr_hart_bits - 1, 0);
>  	if (aia->nr_group_bits)
>  		group = (addr >> aia->nr_group_shift) &
>  			GENMASK_ULL(aia->nr_group_bits - 1, 0);
> -- 
> 2.17.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

