Return-Path: <linux-kernel+bounces-315415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4582296C26E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784911C2284F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF4D1DFE18;
	Wed,  4 Sep 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bxjr7KK5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6991DA620
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463826; cv=none; b=TXRkJFzPYiPTVtUGNlcdcF6eUEsL18f3NKRxlt9dlv+EzxcwFPUBZqEL9nursbPIB8ELxLWzCjMn9LaBzc2EVu+UtoF9NE7ju4XlDfA81XdGjMjaj5DZJZ2Hh/i8MGgojGcob4bI+kuCa9smWOwR3M+UJzorpwuPKZnpACgIQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463826; c=relaxed/simple;
	bh=hYaWWjCbBdPzNDTcDVf9VFIGXGj5qsEngCOOZRyISl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGK6NZZDl5xEdF+qJ/MqpO+vOjzwJfWrYqTd3KX6URB/iHYkUSoKoO/f0CiX978uGbUPdJ0dot3ts6WTxnazwqRBNimC1w8I95dWBnbt84SDPMJ5nQMUggYpOqAnkZ1Y6OIfGu/1tmloLcossWAGK/TDvoQTGwTyeoS81kZ3ScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bxjr7KK5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 14C2840E0285;
	Wed,  4 Sep 2024 15:30:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nPZImp3XytnN; Wed,  4 Sep 2024 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725463818; bh=gYLN/m8pOwQPLC/iisToYlgfPIgVTqRwVhPZ0AIV++A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxjr7KK5ciBgjyPEFCFIE4wxEukVJsrgpE+TyaXZc/8AWKXu6RfnMaJK/gaC9Ig9l
	 2C/X0xwM7jAEfJ/gaLdEuuLDZtjiPZJf2JP2k0lLFDzvJnAOzeTsZ6NNAd0xJH/9b0
	 2nZ04yzwjcw//TIRAPdczuhLb3XP0pQedIFymB8GvHFhE7uzsNuj1mfiBICuGhFrqY
	 91PFfAIHHpli0dlhRiO9ohqlPqc0vVRcSOCnjof7oZDjgBHzZkzs3/hMZpsLk4izVa
	 8tl/KENHq0wcGtWOEoZ4IUkj3gLd1AkjMbkZttixV+ORBZebmjHhVtL9G8QGvnQV8g
	 r5KUrnAAxZYqTFKgC10lKssegHkG6q84839/OQqOZHOl7NUNTopfeqi8zJJu32iaPr
	 a8PpIUeHFFvqJm0SuCFoi8IbMCTRAzLy8UTSXDLiPMnklw0k6JAHZtUyax7FtdaaGC
	 EK3a6uNIMUDjl6EqAxWj58syPPB0lt6S6MlTf12bUqwiSRM6DYifeUcQAG+FGmrLlu
	 OwDMcd0ysRcSjFxpyoTibvTbR2kr7z2QJGiuscbhdO8WFuKZ+GpLocfnrtYK6Ry/Ap
	 +j9RKas7CCn3PYXNjiCnDYgphbFg07V20H+VQa59PdJw2YYPO2APiDyEjZ2iWqOEeD
	 XOaBIO0LujNVxjy8kRghzc5k=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F227640E0191;
	Wed,  4 Sep 2024 15:30:04 +0000 (UTC)
Date: Wed, 4 Sep 2024 17:30:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Kai Huang <kai.huang@intel.com>
Cc: dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
	tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com,
	x86@kernel.org, hpa@zytor.com, luto@kernel.org,
	linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
	pbonzini@redhat.com, seanjc@google.com
Subject: Re: [PATCH v5 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Message-ID: <20240904153004.GAZth8_Jz_aJh_C_ur@fat_crate.local>
References: <cover.1723723470.git.kai.huang@intel.com>
 <47d9f1150a6852c9a403b9e25858f5658c50a51d.1723723470.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47d9f1150a6852c9a403b9e25858f5658c50a51d.1723723470.git.kai.huang@intel.com>

On Fri, Aug 16, 2024 at 12:29:18AM +1200, Kai Huang wrote:
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 9c9ac606893e..07ca9d3361a3 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -392,7 +392,7 @@ void machine_kexec(struct kimage *image)
>  				       (unsigned long)page_list,
>  				       image->start,
>  				       image->preserve_context,
> -				       host_mem_enc_active);
> +				       !boot_cpu_has(X86_FEATURE_HYPERVISOR));

Everytime you feel the need to check a X86_FEATURE_ flag, make sure you use
cpu_feature_enabled().

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

