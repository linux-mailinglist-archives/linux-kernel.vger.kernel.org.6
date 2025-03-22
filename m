Return-Path: <linux-kernel+bounces-572417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3DCA6CA25
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0AA17656F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FB11FCFF9;
	Sat, 22 Mar 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IAXC+Ym5"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6842AD21
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742646615; cv=none; b=hFdrdDsDJfx7v1AcHO16vloJUvsjfmLLKLZkuHnIgFrWOtk+FvpDYvCnVDh9L2G+cWinvJnG65YTv3wWYQlSOPQUW+ortlboXf15rlK8NmdbHLQ89/QKtw/JPGHf9dHJpKKx/lgo8WJDP0bQBFV/PDNjiKyWnNOzb4IP8njMxIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742646615; c=relaxed/simple;
	bh=QUGx4dCY8/tgal3QRY5pUyGAdjuiqwTT+LhsulM4JMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Liiydd0qfy8NEq0b4qpnr6LRS6shZH9NXkzY7exd0eeKaG4LiNswa2hRshE327CQyxuPDqMbpaWdRZy+QQrHgp98y1VcgxxJoGQ5QAdn+U+AVS7w+PHXXFHRL8GvGVSrr5S1HdMsqxibfK3O7Uo/e5y1Skc53ht/Z/LafwD3KGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IAXC+Ym5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso20173605e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 05:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742646612; x=1743251412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XK2TAqZG341EzHEinXnSfJT8xoYCNibzBDqkY726Y1s=;
        b=IAXC+Ym5dURzYvBmBTyPDwL2aHOHSMjIZUIsvnKIY5mNtSpL/n9TMz2fU+2gbkhYBp
         NpuCnt6lgR6e8OqlwnUFcwtiHCRK7mR6VabEtEMExu+d7TxLwXh6Bd97+ukfXf9V2Jl9
         kDZbr4FbOnj6ZfZOdbkdlZg8dBxn5lVTvapDw+DdzH/om+JtdqZ4HW8u/pwleXXX/3kN
         Fv4n6Il+jV5UXtneKMOk7Kw8obM1xDeZIaZie3hh734ZlQPEMqd2KoNOm4gyYjh8nbBY
         Dbrw6f6M8IcXTVUM/2upSByEqbwjT1lBWhWfbrQ0cuq9l2uk+GBQxPwzyeU7Kjs1Jtet
         4wuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742646612; x=1743251412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XK2TAqZG341EzHEinXnSfJT8xoYCNibzBDqkY726Y1s=;
        b=It5ez6CTW3vvSl5qcLTSYFh8rb8apByY3KH740c/Lw4XDkygyE/bzpXCvAbOBD9jnN
         VeJY+QxyxzJVkpu4N7NkANGNiwPYDaaqp7qJRtdJtJ8FboYl/1AsjDqDRn2B/l7wFQNp
         Pf9qMhkjNev0rrlyxGxDHHMQE1QU4HUJ5LkuwIyOf3aDM8SoDIpUgsxjWPW8RfRfDH2x
         8dWFyrQeqzA5dM15EJrYna44XEtkW9xz77pN9KMXW35/zNyfIqaNsqync6tA65s50Nzr
         1Qlpxim+cjvxAUNrjaJmiC9c7wZqHgAjknnTFfbdJCGHUvWOSUggLrq34kD/NFhWBKsC
         TUqA==
X-Forwarded-Encrypted: i=1; AJvYcCWfyVz0I5PVdhy9MYPiWNTociUVowfdgza1fQrjvHnhlbwaYULl5Op6rkI/qSRBj8pwvGeXfhKpQ/vLw2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ggI52wPLU8CcajS4qM+OGvq7FFkbqCY0L1CvSFuU9srVSr+C
	wFtiBy6RhdUUW45RI0cwWn6jRHZw/6gnaTThPiysqupx+EaLhxxIwLm0TZpUcVw=
X-Gm-Gg: ASbGncuCEvZB97UccbmC92UWuZWppkOYmsZOpGI2e7xQmDu3Njt1J5D/5ZjyxIMqWi2
	MQ90489awAnlxs8NeguYIZ1mesCXpAE/syTtUjGKpN4MLJd420+L1Zh9rMqo4ss8iIOmfOhM2c+
	H4tZJgqc5WvCzgss2wrVvfZ6mclsNO1VxU9wS4UxEpaIO2YY/NzuufyzrJx5Kurrt2Fcc5rVp55
	b0mU/d/iEBH40z1AYmqmgSe8K7orlApnhwhK+Cjg7tcwiZs1EmG3fc3GKiVlJHQ7RZhnS3pLBBn
	5NFbJZI4FxFAmBOV6p/SMmhqFMGvQIj4qJFuuV+hQWgBqQioQrmT2JyC3D9TSIic/lcABga5oA=
	=
X-Google-Smtp-Source: AGHT+IG8oeOIoiATGf2n/eErF/v1UJz5jBt3u89DGuQOGIaGoIkUZOrdT8f7P/SGIIjTK+RAQA8QjA==
X-Received: by 2002:a05:600c:83c4:b0:43c:fffc:7886 with SMTP id 5b1f17b1804b1-43d509ec52fmr59753085e9.8.1742646611632;
        Sat, 22 Mar 2025 05:30:11 -0700 (PDT)
Received: from localhost (cst2-173-28.cust.vodafone.cz. [31.30.173.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440eda26sm106789645e9.36.2025.03.22.05.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 05:30:11 -0700 (PDT)
Date: Sat, 22 Mar 2025 13:30:10 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v4 17/18] RISC-V: KVM: add support for FWFT SBI extension
Message-ID: <20250322-c4eaee71aa9c1f0b13ca8fef@orel>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
 <20250317170625.1142870-18-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317170625.1142870-18-cleger@rivosinc.com>

On Mon, Mar 17, 2025 at 06:06:23PM +0100, Clément Léger wrote:
> Add basic infrastructure to support the FWFT extension in KVM.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_host.h          |   4 +
>  arch/riscv/include/asm/kvm_vcpu_sbi.h      |   1 +
>  arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h |  29 +++
>  arch/riscv/include/uapi/asm/kvm.h          |   1 +
>  arch/riscv/kvm/Makefile                    |   1 +
>  arch/riscv/kvm/vcpu_sbi.c                  |   4 +
>  arch/riscv/kvm/vcpu_sbi_fwft.c             | 216 +++++++++++++++++++++
>  7 files changed, 256 insertions(+)
>  create mode 100644 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
>  create mode 100644 arch/riscv/kvm/vcpu_sbi_fwft.c
> 
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index bb93d2995ea2..c0db61ba691a 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -19,6 +19,7 @@
>  #include <asm/kvm_vcpu_fp.h>
>  #include <asm/kvm_vcpu_insn.h>
>  #include <asm/kvm_vcpu_sbi.h>
> +#include <asm/kvm_vcpu_sbi_fwft.h>
>  #include <asm/kvm_vcpu_timer.h>
>  #include <asm/kvm_vcpu_pmu.h>
>  
> @@ -281,6 +282,9 @@ struct kvm_vcpu_arch {
>  	/* Performance monitoring context */
>  	struct kvm_pmu pmu_context;
>  
> +	/* Firmware feature SBI extension context */
> +	struct kvm_sbi_fwft fwft_context;
> +
>  	/* 'static' configurations which are set only once */
>  	struct kvm_vcpu_config cfg;
>  
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> index cb68b3a57c8f..ffd03fed0c06 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -98,6 +98,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_susp;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta;
> +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
>  
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h b/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
> new file mode 100644
> index 000000000000..9ba841355758
> --- /dev/null
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2025 Rivos Inc.
> + *
> + * Authors:
> + *     Clément Léger <cleger@rivosinc.com>
> + */
> +
> +#ifndef __KVM_VCPU_RISCV_FWFT_H
> +#define __KVM_VCPU_RISCV_FWFT_H
> +
> +#include <asm/sbi.h>
> +
> +struct kvm_sbi_fwft_feature;
> +
> +struct kvm_sbi_fwft_config {
> +	const struct kvm_sbi_fwft_feature *feature;
> +	bool supported;
> +	unsigned long flags;
> +};
> +
> +/* FWFT data structure per vcpu */
> +struct kvm_sbi_fwft {
> +	struct kvm_sbi_fwft_config *configs;
> +};
> +
> +#define vcpu_to_fwft(vcpu) (&(vcpu)->arch.fwft_context)
> +
> +#endif /* !__KVM_VCPU_RISCV_FWFT_H */
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index f06bc5efcd79..fa6eee1caf41 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -202,6 +202,7 @@ enum KVM_RISCV_SBI_EXT_ID {
>  	KVM_RISCV_SBI_EXT_DBCN,
>  	KVM_RISCV_SBI_EXT_STA,
>  	KVM_RISCV_SBI_EXT_SUSP,
> +	KVM_RISCV_SBI_EXT_FWFT,
>  	KVM_RISCV_SBI_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
> index 4e0bba91d284..06e2d52a9b88 100644
> --- a/arch/riscv/kvm/Makefile
> +++ b/arch/riscv/kvm/Makefile
> @@ -26,6 +26,7 @@ kvm-y += vcpu_onereg.o
>  kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o
>  kvm-y += vcpu_sbi.o
>  kvm-y += vcpu_sbi_base.o
> +kvm-y += vcpu_sbi_fwft.o
>  kvm-y += vcpu_sbi_hsm.o
>  kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_sbi_pmu.o
>  kvm-y += vcpu_sbi_replace.o
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index 50be079b5528..0748810c0252 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -78,6 +78,10 @@ static const struct kvm_riscv_sbi_extension_entry sbi_ext[] = {
>  		.ext_idx = KVM_RISCV_SBI_EXT_STA,
>  		.ext_ptr = &vcpu_sbi_ext_sta,
>  	},
> +	{
> +		.ext_idx = KVM_RISCV_SBI_EXT_FWFT,
> +		.ext_ptr = &vcpu_sbi_ext_fwft,
> +	},
>  	{
>  		.ext_idx = KVM_RISCV_SBI_EXT_EXPERIMENTAL,
>  		.ext_ptr = &vcpu_sbi_ext_experimental,
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
> new file mode 100644
> index 000000000000..8a7cfe1fe7a7
> --- /dev/null
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Rivos Inc.
> + *
> + * Authors:
> + *     Clément Léger <cleger@rivosinc.com>
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/kvm_host.h>
> +#include <asm/cpufeature.h>
> +#include <asm/sbi.h>
> +#include <asm/kvm_vcpu_sbi.h>
> +#include <asm/kvm_vcpu_sbi_fwft.h>
> +
> +struct kvm_sbi_fwft_feature {
> +	/**
> +	 * @id: Feature ID
> +	 */
> +	enum sbi_fwft_feature_t id;
> +
> +	/**
> +	 * @supported: Check if the feature is supported on the vcpu
> +	 *
> +	 * This callback is optional, if not provided the feature is assumed to
> +	 * be supported
> +	 */
> +	bool (*supported)(struct kvm_vcpu *vcpu);
> +
> +	/**
> +	 * @set: Set the feature value
> +	 *
> +	 * Return SBI_SUCCESS on success or an SBI error (SBI_ERR_*)
> +	 *
> +	 * This callback is mandatory
> +	 */
> +	long (*set)(struct kvm_vcpu *vcpu, struct kvm_sbi_fwft_config *conf, unsigned long value);
> +
> +	/**
> +	 * @get: Get the feature current value
> +	 *
> +	 * Return SBI_SUCCESS on success or an SBI error (SBI_ERR_*)
> +	 *
> +	 * This callback is mandatory
> +	 */
> +	 long (*get)(struct kvm_vcpu *vcpu, struct kvm_sbi_fwft_config *conf, unsigned long *value);
        ^ 
	extra space here


Thanks,
drew

