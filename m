Return-Path: <linux-kernel+bounces-192432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44858D1D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E681F22513
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83A216E86E;
	Tue, 28 May 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="P8H42N6w"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298E17C7F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903342; cv=none; b=XvhB8Dsue/9g9SMgB8twIg0vyhazT1nddtDSwuYj3xGGOBGQwZScIy1bmPksRE4f4H+YXz+Oz3SAmokxlxC2pvYhxPuHJQSRnrMRMr7nFxKtZJCmSuoTB+DroUtzYssPWsGTld096H/Q/fX1cdmFhFHHAf+UlRB/XfpFA9o5kgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903342; c=relaxed/simple;
	bh=Uygo9Me2+2ccVPrlTpw7gYq/1QDyRkrPpHp3J46wjpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GderHIuOCYK+h079qSCzPhT3mo0e045wV4VcyitdI84e++YE+X+8ItbikIGjoDVe0H1juJ4sH3aYWmA97zYgDBVqZA2dfhxPw+pDiSfK7uMIzgC/UAgt//KLOTIycV/HjJxKwEyz2pfxjI8mQLN/WNGMbq4zcwcgyco/argeyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=P8H42N6w; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35a264cb831so614848f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716903340; x=1717508140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjGXaowzOpIF3QbPazGFsBGPsl4FgWIVG9cNH5OZlLw=;
        b=P8H42N6wNFQhy9Wroo3WW3SQFc6HOa2yqv/gFIoff1lVyxwWk2wozx73UKhW/16mpg
         r2dETrbVjtkX2qb5hKRauUqm9P03wUEarTXYB10zdR0mnUabAiGwCwml18dzc1VMNj7m
         T2LbBBSXP6KRfu2QKm4TiSuZFBaHBFNX3GQpF6/G929DZyeJ/eAiGomtyVudAPasgtFB
         QfXKube1mzgdYF0KVoyEUKjnSdwBN6IBFyl4JMEdGiKf8YP0m7Xhm0vsONtIanizj+b/
         +SPFXXqiJZ/4sqfVaaO2o8McRp/AYvdFG20+3sHgkpmnSiMeXKsmY3dApkaAj6GH/Jkk
         kIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716903340; x=1717508140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjGXaowzOpIF3QbPazGFsBGPsl4FgWIVG9cNH5OZlLw=;
        b=TZptwDpIhOqP54FFoGfW81TWL7PfN8auPqoZRfdQ9TMaBODToE+86dd7ByilcS+zL6
         8Koqbc7SV7u+l5uto+5eZDU2Qo2fRbcnrTpLVUj5Zh1iT1JIiA0dw5EZNAVetMtp+dwg
         igtoVbDoM1CLL3Df2t7HI4ZoBTTvGOun7W3QEJM5Rm7kf5slVgKd3yiIlOQTyGKJE6EO
         4AlHJBJaatGzmHJuwSwgIpHvLAdjagh+o7pdqx10l77jYQ57g28FODLwdLIr7shHC9vt
         2ctLdVIV1c2D9gBkcTxgFrXABpuN4xPhdoX32FEquK8K8XlQNfBeGjIvqwMO6bgEOyoC
         p5fg==
X-Forwarded-Encrypted: i=1; AJvYcCVWl5ugnCzGDP2yiv6+SwKHjkZOEfL2BYzzgJ5kN0fcvbxUmTrQRtNA9m1PnsaHIFo3bJGKSmJuSF+dnq4oofktmmlj3NkI2E1TlCB9
X-Gm-Message-State: AOJu0Yy/GEV5BcnM06CyfLB1F1aHN74Jd/ZuOmqDm2qkf6lqZcBpnXN5
	GGAKX0Uds8Rhdlnuo+tHeTqNBLWx5vsU6X58Qq37grSGXApUPYLULaH7xGKTk/k=
X-Google-Smtp-Source: AGHT+IFbOwoRSz6/nVrWGNSVmDQHjWUjIuJdCuhVXgFdFXelciHbbbL1yL6O7el2JjJ+1u9RO6CYZA==
X-Received: by 2002:adf:f08e:0:b0:354:dd23:7607 with SMTP id ffacd0b85a97d-3552fdfd438mr8792336f8f.57.1716903339771;
        Tue, 28 May 2024 06:35:39 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3582917b222sm7268083f8f.93.2024.05.28.06.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:35:39 -0700 (PDT)
Date: Tue, 28 May 2024 15:35:38 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, xiao.w.wang@intel.com, pulehui@huawei.com, 
	Charlie Jenkins <charlie@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Pu Lehui <pulehui@huaweicloud.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v3 2/2] RISC-V: separate Zbb optimisations requiring and
 not requiring toolchain support
Message-ID: <20240528-4a498a28af8d912561d1a103@orel>
References: <20240528-applaud-violin-facef8d9d846@spud>
 <20240528-opossum-flavorful-3411811b87e2@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-opossum-flavorful-3411811b87e2@spud>

On Tue, May 28, 2024 at 12:11:12PM GMT, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> It seems a bit ridiculous to require toolchain support for BPF to
> assemble Zbb instructions, so move the dependency on toolchain support
> for Zbb optimisations out of the Kconfig option and to the callsites.
> 
> Zbb support has always depended on alternatives, so while adjusting the
> config options guarding optimisations, remove any checks for
> whether or not alternatives are enabled.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v2/v3:
> - Per Drew's suggestion, drop the stub Kconfig option and instead push
>   out the toolchain dependency to the relevant callsites.
> - Delete a bunch of comments about only attempting Zbb if alternatives
>   are available, since they always are.
> ---
>  arch/riscv/Kconfig                    |  4 ++--
>  arch/riscv/include/asm/arch_hweight.h |  6 +++---
>  arch/riscv/include/asm/bitops.h       |  4 ++--
>  arch/riscv/include/asm/checksum.h     |  3 +--
>  arch/riscv/lib/csum.c                 | 21 +++------------------
>  arch/riscv/lib/strcmp.S               |  5 +++--
>  arch/riscv/lib/strlen.S               |  5 +++--
>  arch/riscv/lib/strncmp.S              |  5 +++--
>  8 files changed, 20 insertions(+), 33 deletions(-)


Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

