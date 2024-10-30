Return-Path: <linux-kernel+bounces-388401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2AE9B5F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390A2B21B70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B0F1E2313;
	Wed, 30 Oct 2024 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uYkfxmvE"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FAE1E22FF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281750; cv=none; b=ktu6IvsxAh1cl4P4rfgB03FyptszeETAQlONMzA3McFCRariFU7MssBJ9CcMuasd/dHwtpooN4iBqd0ZZ1lOLGamv73CdKlUjCse+EbK8kvQRI2I3O+N0FZ8o0U5UxtNi/uN2jOimUY9Dt4m5uzyM50t6BeMJa040PGa1Ix9+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281750; c=relaxed/simple;
	bh=8EXfK793ZLefNzwp6pzA38h547RH694mwEtv1gJlZdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwKCbZR4PAA32RVXpkg1yw0oGm9DMrLanGSGKzymX5rxAs0V2tRwZiWfp298K9WgqYU6t/J/LNJubAmzL9MMu5HbwYNaCEIPpNl6RLKdScXcS17BCmSke5uNc5QhsOB+ht3p9AtoDULgoLUKLGWIjjxxeLZUK5ZPw55lC3df85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uYkfxmvE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cbb1cf324so54446625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730281747; x=1730886547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lSwaSXBIpjqVkyV12CEixJTdRNCxUGANMEGYJ3Ap4Vg=;
        b=uYkfxmvEite+cTjrEJjeKemaYNBz42YwMnGUkR7Xe1BIhB/ulPj80z9umIgEiBgZfi
         H8fpRYPtUf/8xr2EQEYmq29zJONbchcmcnetG9f3tkaF/LcaoLrgdKZOPYmy2Q6YNrXf
         pNT+vRkT51lXaI6g+eDp2/XYPUa8qvGYJ7AloYZd/newcaj6lAZyJGxd9UM7F1UfTYkS
         WN9zjFX7X07cOSA3wknrKFdmLzj+AL1don01++a0hyi9J315A2RlZ8E/SOt783Q20OCm
         x9RBQQcPsPeeriqx1mxFl7RCbm4rIfaWEobMhTQeTZMrFrc034H6PrjowRImT5/vrtMl
         tUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730281747; x=1730886547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSwaSXBIpjqVkyV12CEixJTdRNCxUGANMEGYJ3Ap4Vg=;
        b=ProGIokdrNi2omS4CdoKKtf68ncpO3UwwWfZYkNdSj8BMuWPX8+0OgM7z/0aBcmEJj
         uhTdVMpvhdW/GuHxsQg6ima6ozN/L1xHecXBy5sqqL2EDWkmfcRsuKE+vJVX4+lwniGv
         /eW+yNcIKPbKOETI9OYXpsScy2HqS1hTIA6yOcZbU/w6h5EQI8ReylJZVGoLFHpWmBRm
         ZXMZnqbBCTo8XUFsWNGFjIV06IqEBHmyS/IPNaiE8EO4SbhgZiWmBBhInzE84kP10Y+P
         Pfe0O0I5ai62VBFuq66KIOwz7ydc1yB/38BUNj2mx3TriAUw66EspDi27A3eYjgO/PL/
         1EJg==
X-Forwarded-Encrypted: i=1; AJvYcCWsLbXknUATfideeAiRW34C9hIhILAlZ/DGOHMUC1MlKNcKPVf1bappuxkD9GOjXEqJrust2utG5wL7rG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXR9bW/ZJixj/Wpb7bTant461G3Pc7geKCxeAC32xOzOWvL9x
	6fkRKwehBBKeOWsbnush2mb4gQWXjdrk7R6rh/ME0ZM7ei4XfaC6kCy4tyy6j3Q=
X-Google-Smtp-Source: AGHT+IF5owZ613IN08gSTF1W4NumSlPE9N+GNRcutDlRWZGvuBkpKbCkuSRP83keNi1c5BU43LWC/Q==
X-Received: by 2002:a17:903:124d:b0:20c:5cb1:ddf0 with SMTP id d9443c01a7336-210c68a9c2bmr199322865ad.10.1730281746621;
        Wed, 30 Oct 2024 02:49:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0864d7sm78342745ad.303.2024.10.30.02.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 02:49:06 -0700 (PDT)
Message-ID: <ca1cb4b8-e206-4bc3-adf3-3801fd05f8e8@rivosinc.com>
Date: Wed, 30 Oct 2024 10:48:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] riscv: hwprobe: export bfloat16 ISA extension
To: Inochi Amaoto <inochiama@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Evan Green <evan@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Andy Chiu <andybnac@gmail.com>,
 Xiao Wang <xiao.w.wang@intel.com>, Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241028071746.869740-1-inochiama@gmail.com>
 <20241028071746.869740-4-inochiama@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20241028071746.869740-4-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/10/2024 08:17, Inochi Amaoto wrote:
> Export Zfbmin, Zvfbfmin, Zvfbfwma ISA extension through hwprobe.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 12 ++++++++++++
>  arch/riscv/include/uapi/asm/hwprobe.h |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index 85b709257918..8c30dd06f3c0 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -239,6 +239,18 @@ The following keys are defined:
>         ratified in commit 98918c844281 ("Merge pull request #1217 from
>         riscv/zawrs") of riscv-isa-manual.
>  
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZFBFMIN`: The Zfbfmin extension is supported as
> +       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
> +       ("Added Chapter title to BF16").
> +
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFMIN`: The Zvfbfmin extension is supported as
> +       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
> +       ("Added Chapter title to BF16").
> +
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFWMA`: The Zvfbfwma extension is supported as
> +       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
> +       ("Added Chapter title to BF16").
> +
>  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
>       :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
>       mistakenly classified as a bitmask rather than a value.
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 1e153cda57db..95d00a065b4e 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -72,6 +72,9 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
>  #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
>  #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
> +#define		RISCV_HWPROBE_EXT_ZFBFMIN	(1ULL << 49)
> +#define		RISCV_HWPROBE_EXT_ZVFBFMIN	(1ULL << 50)
> +#define		RISCV_HWPROBE_EXT_ZVFBFWMA	(1ULL << 51)

Hi Inochi,

These should be added as well in sys_hwprobe.c (see hwprobe_isa_ext0()).

Thanks,

Clément

>  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)


