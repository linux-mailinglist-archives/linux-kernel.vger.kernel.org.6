Return-Path: <linux-kernel+bounces-424431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 340BA9DB44B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08401672C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEED91531EF;
	Thu, 28 Nov 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="g3Y1U8D7"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC5114BF92
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783932; cv=none; b=ZyttvhAMBA1c3S9m7OBxtpDtB1o6x5uwhNS1lMN/3zns/m/Ju9bvAgN+tyIdPo9eG9O3pQWMavLyIwICaB6Ex28tbowt47Qo+lIwmkUSWPvmS35zcMsHHKVnb34RZw5DOW/IWBlrIYLBzyGucX/7U0R6wCFKdDqO+Sk/AN/zkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783932; c=relaxed/simple;
	bh=+LxI207fMZyRamK0oRS6I4x/Y6ZteYi0UVGdWJl3k/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTPsiN8u2Ub/PI5KkcJbsKJzfrA7UoUWaenMqhEa1OHhZBYURpLJC9jCgT/rAPML42V/lI5nOSQD7ii79iAgNpCSgGGjRJtABV1GfBpTLvPNAQ4jg1tn1prRypr3eZqsM6u5QqKYcihMxhh+QSGPXbv0xjFj/3Nf/xZk3PxQSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=g3Y1U8D7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so4995295e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1732783929; x=1733388729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2iPe56MayituZcdhfXf2NviKcI0B6w7DTgpAVLjkFQ=;
        b=g3Y1U8D7PqfrC8XafvHXGCReHX/C4qcG7O6UhOZPOuF+3Gw99UGag8lDqKLQ4d8yFW
         XHXz5fSIuqetnzPuAi1J0oET+Q9H3pRCp99Jlr0MEoK7m/TrIy5KZSWzp0MJJEhtvJKR
         EhBmrc5pcHC564HtGuoOEyLcn+hzpbjdRVw2PGW2UBlcq3UMN2IihkfLGCzRijZSfqJl
         FGBZ7kQOvBPogfellxlU+nVGat0ag/Yxrhk9pOIAkNwgTCPoXdGDb2rcL6KxVEv9E/dC
         Dl0Aw5EYgSnR4OkWkoIiDzEFfccgmXKW/ABMUq8h+DbtVMD2RPyq9HuPjHIwu1XkOFzr
         bVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783929; x=1733388729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2iPe56MayituZcdhfXf2NviKcI0B6w7DTgpAVLjkFQ=;
        b=txyjtnK7nKw9OC54+xooOK98xQhWwrvT2DghxHfUO/jCUmZCRfzn0IB4M5dV+lKQQM
         S4U8t1bjqczCDnR5LVmW12F2vKdE/I7Miyxo1kDwYzTe6V2vnSUNjlBNU06Y9FP82qD0
         amOQxY+RshwYjDNQgxmv7PQb2MdwZOM+Le7TJJZOdvlW6iH2805L5l4BRktgGryin6gU
         gDXMXBmRFKuX8u96fgcQe+gzu58VOqSlsrEhBQQCeo/jFECdmA4MQXNvP/vibcsOhdCI
         0EHc/VF3Hn9kB/6BdKMvipgncdS9nKhfJzeG/utgisg4LrQnadVeeDZ4r+9FXm8jYIvB
         R1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCX/htnqcB8hOvH6r38EcL84YFrjhvrLrm/QdX/dBXvw8Y1QH2zYZzX0QXDshD993QMh7+hfXObQ+mO2E5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YypYi9koBPdXKl9FGsgZcHomCi2uSGJGhlba7qS4KtAl4A4yIkC
	CCypIBOktmG6/teghAoDDp9bef+pWmbnlK/Jd5Qm2gwW7prUfG0JTghmKen0rNA=
X-Gm-Gg: ASbGncu3HTnhXm/z3COey+DaCD0x0315RyDKJ2irrdviY/6atuwjrTXfRzMLKWxzjj5
	p7/5LuPbxMLJzV/X4bNdqSlBajvvosfXBXHZO+sfBq+WcYeI2X54fpC1SiCz0WhO0XrHArQH4LE
	VLiREbxbbsCRVEpnmAOPaZku+c6uLWL1ltEx32Td/rlFjsVhuOwI942AsQwL0wkigyPBpvZeE9r
	KXuvOhB9U+/CUuHVOBn5wQ5D3avCqhqCafFmnNpPUCBtJE+kzJiLgGfQYn8Zj4OR+uOnVVcCL1B
	zp01z66Fe1uBViB15HY8XiRsjOXKTgxLE40=
X-Google-Smtp-Source: AGHT+IEQ7usI6WzT1Sy/dDzpS2PmYGgrjtEHrwwaKksPUcfWEtHLCN5lr8kos91EccHetXt6QvrFmA==
X-Received: by 2002:a05:600c:3b16:b0:434:a4fe:cd6d with SMTP id 5b1f17b1804b1-434a9dc02c5mr57820965e9.12.1732783928908;
        Thu, 28 Nov 2024 00:52:08 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f7dd78sm14832355e9.44.2024.11.28.00.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:52:07 -0800 (PST)
Date: Thu, 28 Nov 2024 09:52:06 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: zhouquan@iscas.ac.cn
Cc: anup@brainfault.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH 2/4] RISC-V: KVM: Allow Zabha extension for Guest/VM
Message-ID: <20241128-4d652d29ba99a3e8ffa8121a@orel>
References: <cover.1732762121.git.zhouquan@iscas.ac.cn>
 <ea2918b299348aca0f5a45630b7b7c9889f47fa6.1732762121.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea2918b299348aca0f5a45630b7b7c9889f47fa6.1732762121.git.zhouquan@iscas.ac.cn>

On Thu, Nov 28, 2024 at 11:21:26AM +0800, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> Extend the KVM ISA extension ONE_REG interface to allow KVM user space
> to detect and enable Zabha extension for Guest/VM.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu_onereg.c      | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index 9db33f52f56e..340618131249 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -178,6 +178,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_SMNPM,
>  	KVM_RISCV_ISA_EXT_SSNPM,
>  	KVM_RISCV_ISA_EXT_SVVPTC,
> +	KVM_RISCV_ISA_EXT_ZABHA,
>  	KVM_RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 67965feb5b74..9a30a98f30bc 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -44,6 +44,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(SVVPTC),
>  	KVM_ISA_EXT_ARR(SVNAPOT),
>  	KVM_ISA_EXT_ARR(SVPBMT),
> +	KVM_ISA_EXT_ARR(ZABHA),
>  	KVM_ISA_EXT_ARR(ZACAS),
>  	KVM_ISA_EXT_ARR(ZAWRS),
>  	KVM_ISA_EXT_ARR(ZBA),
> @@ -138,6 +139,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
>  	case KVM_RISCV_ISA_EXT_SVINVAL:
>  	case KVM_RISCV_ISA_EXT_SVVPTC:
>  	case KVM_RISCV_ISA_EXT_SVNAPOT:
> +	case KVM_RISCV_ISA_EXT_ZABHA:
>  	case KVM_RISCV_ISA_EXT_ZACAS:
>  	case KVM_RISCV_ISA_EXT_ZAWRS:
>  	case KVM_RISCV_ISA_EXT_ZBA:
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

