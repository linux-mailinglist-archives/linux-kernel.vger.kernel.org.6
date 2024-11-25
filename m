Return-Path: <linux-kernel+bounces-420980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A5E9D8513
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05365166825
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF831A08A6;
	Mon, 25 Nov 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FHIHd9ku"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CFC1A01C3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732536532; cv=none; b=tH2pLkgDMkqeC0T/MfGA9AF3D5sFolEMqEIkhOeMoD7+9EPnyzC96F9TObCcELQy+SutQ0QjP58Ht4SHf/AavTYhLXak6vyYbQR9KBGHy4BMqDSXRByi8BvhasF0qcWj8AgTzc38I25XH4hUN/hj8bhvP1lifLKcdnVRXsYjwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732536532; c=relaxed/simple;
	bh=MLOsvRZ/ecr2Y/Jx8is/W8Kgryf9gi/kqVRqbk12X34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn30qBiW7VussiS+t9d3T4LoAEzOkDjO1bP+NmI7mM8zMMq/ximArl/XCW8tLOgrpwKDGqKI262gqi99ckRRnoTUP+S3ZlflUMyCebYseXzWrmcEagmmc2/ez3Sn+e2nhBPmS4yRbE49PNffa6DTxwqld74GvphMpyy3bC5G1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FHIHd9ku; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4349cc45219so12075755e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1732536528; x=1733141328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtGYra4ZiucyLvI8CA3+YqcIlZT99r5pBwc2AIGV96M=;
        b=FHIHd9kuk+HOH6mEcaJc8ZBuVcZkTiPS7KGTghK16k06LigipTuauIY/tb+NGiLsDC
         j/cOOwzEF8wz3+GlL5666TTnuAaoPQuxVUeCzCu6dUwn85OEd2vMGwo2cmCwx5oKXP/J
         5ywXdSZvXQ++0tKYPbMsP2Sy1K/PjnVYr9W2oro58nUhFxEf8RaqkymvXuuRtIwfJS33
         0+0IT5NdFvh+j+gTHmGm46woE7fRCStKAqeDwXpVGVwd5BdXukf1n2SJ7tptc8V2dwn6
         F0pIEJNXLhS8Ct3pzS8g0yDYdOdNdPqX3Mb1aeuV5stBoEVjXAk+tmZXhbvvRI0ZeGFv
         qJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732536528; x=1733141328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtGYra4ZiucyLvI8CA3+YqcIlZT99r5pBwc2AIGV96M=;
        b=sSGn17LeUCJ5HDnswABffPvigygwKZCIVd/Yo43WgoSa5v9zSuFOqcE7i0OagSrwkE
         fqp/vXhT0/wPKSpZHxhD3/zDIdidjQULoFM8yo2V9+z/DWfcWn+No4An/0NmYvkpZVpk
         ZifUpBVhSNotTLbleqTRqAJ6/3RH1Jp0vM6qXdnIL2bJORDClJxAmxphrYSdGDRZguXb
         rFzRHyb1+JRph1+MR3sw8tMQ5AUCriT2JZxX+AuOrID1sXLy4ke5eRE4nsxIPP+yJqAp
         vCcrmEXP98GcSNoMe7LWppuLGWDgzTYnQzrgTAGHWtm5PWTTbi73kjNyUPEq67yV4Vog
         I08A==
X-Forwarded-Encrypted: i=1; AJvYcCUNstiSslcP0cLsCDGPYxyo4NuyjBzQihOBI5H6tSLcyNPBX9Vo1Jx/Cw7amYWE2UprRoKMc95OTEa11lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTlCiVlM1r1058tS449HBPjjrh5yCGkxeGbq9j48yDnmG9k22v
	hlaFEuySC8bCunZ/V3Ci6/RdK2ENRikjviIubHoN3n6B4HpMAnb+5w2L6WdtIXQ=
X-Gm-Gg: ASbGncub7G1f4lwTKfxoW8s8EvVzP2fnhdgNiqoFi73Ke40BAzL71t68vq3Qtdvxt4b
	9GCxy1x3ucKt9W2dKwoEKEktReYEc21UjYd5wwq3BSN8TklcBVAZmQLaPxgkWEL1HqtZ+odJt4k
	TuJKtF7vwpjykril2kXsidl7SpJErDnbnIkGouMTQ7M6GoIZuSHrRPYSLNMmXzhDEzbXS5BSA0n
	7hHEVQ540KVjNtYz9sst3IAZ2xgKbmAqjTuYaqiTh6suVWNUB0VF46+VfpLkpAMGScteVaM3HdX
	aZIDtnPI8Ou8+ljD1PqegB77K+PmJq+GNTo=
X-Google-Smtp-Source: AGHT+IEcHSdgJj5nANfMThAU2OGxyIx79hhPO8lC6bsUu2hPonUhJGs8xsqe5h4w4zgbyjw1N3+XCw==
X-Received: by 2002:a7b:ce91:0:b0:434:9de2:b101 with SMTP id 5b1f17b1804b1-4349de2b333mr40945755e9.2.1732536528430;
        Mon, 25 Nov 2024 04:08:48 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a02f2ea1sm29588115e9.34.2024.11.25.04.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 04:08:48 -0800 (PST)
Date: Mon, 25 Nov 2024 13:08:47 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Max Hsu <max.hsu@sifive.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH RFC v3 3/3] riscv: KVM: Add Svukte extension support for
 Guest/VM
Message-ID: <20241125-7cfad4185ec1a66fa08ff0f0@orel>
References: <20241120-dev-maxh-svukte-v3-v3-0-1e533d41ae15@sifive.com>
 <20241120-dev-maxh-svukte-v3-v3-3-1e533d41ae15@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120-dev-maxh-svukte-v3-v3-3-1e533d41ae15@sifive.com>

On Wed, Nov 20, 2024 at 10:09:34PM +0800, Max Hsu wrote:
> Add KVM_RISCV_ISA_EXT_SVUKTE for VMM to detect the enablement
> or disablement the Svukte extension for Guest/VM
> 
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Max Hsu <max.hsu@sifive.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu_onereg.c      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index 4f24201376b17215315cf1fb8888d0a562dc76ac..158f9253658c4c28a533b2bda179fb48bf41e1fc 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -177,6 +177,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_ZAWRS,
>  	KVM_RISCV_ISA_EXT_SMNPM,
>  	KVM_RISCV_ISA_EXT_SSNPM,
> +	KVM_RISCV_ISA_EXT_SVUKTE,
>  	KVM_RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 5b68490ad9b75fef6a18289d8c5cf9291594e01e..4c3a77cdeed0956e21e53d1ab4e948a170ac5c5c 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -43,6 +43,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(SVINVAL),
>  	KVM_ISA_EXT_ARR(SVNAPOT),
>  	KVM_ISA_EXT_ARR(SVPBMT),
> +	KVM_ISA_EXT_ARR(SVUKTE),
>  	KVM_ISA_EXT_ARR(ZACAS),
>  	KVM_ISA_EXT_ARR(ZAWRS),
>  	KVM_ISA_EXT_ARR(ZBA),
> 
> -- 
> 2.43.2

Anup raised the missing entry in kvm_riscv_vcpu_isa_disable_allowed() in
the last review. An additional paragraph was added to the cover letter for
this review, but I think there's still a misunderstanding. If the guest
can always use the extension (whether it's advertised in its ISA string
or not), then that means it cannot be disabled from the perspective of
the VMM. The only ISA extensions which may be disabled are the ones that
trap on their use, allowing KVM to emulate responses which a physical hart
without the extension would produce.

Thanks,
drew

