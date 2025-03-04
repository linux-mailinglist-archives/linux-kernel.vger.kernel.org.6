Return-Path: <linux-kernel+bounces-545712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08608A4F082
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76961894BAA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8885227BF7C;
	Tue,  4 Mar 2025 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWJ50vCl"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500E27934F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741127192; cv=none; b=Bc5XedRngidURwUn4FKrSgzDJGKKklisOPahE16t+aJ5q9uUWGba5p8AMjELFsbE/m/3sGBiFIXgIeq8gwD2gscTVqGx/fvx87A4LPr7sDPWo2n2H0p6pjy/WccRC51ZKN7n80186hq+nnlwir/exKWp3V7cYs7ZPtEx//x67FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741127192; c=relaxed/simple;
	bh=J2aPQ9pJiSPkXbgCaQfmssg6cb7xKl3aycuhPq6+/1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZk+ssCNPfZUDwIyxfJ2O9jd9vF6jHd8tunJoc6Z6L8IKu3U6roANrkWjcx2MTJ22zmHHUnPAC6SJTwQen+4tjxix69diJSApuCTWdv7xxK4hgHtjqO8M3j+yn2LKdDAo9K7XY0XNGiEz3zhZVJB6yGJPJ+v8aoLAHZQPLZX/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWJ50vCl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e539ea490dso4015401a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 14:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741127189; x=1741731989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qVnMd/oqLZfPyfZDBXHTLRNY+ue0ydYsWRZpmZ6zrek=;
        b=YWJ50vClqLB2lyDTt82ryUjQpe/TFYC6a4TVaJcSvmS9XUW7s0B0flGLvvxMIjAjKB
         CHtJIssNNhR4fWA9chXvvcRYyLdhtkVqltUcvSHuOuM0ikmUfmJuL3L222KYqEUdIrdR
         JW3VslYpSAYAcggjwwEuQZ/x31HJfw+MrEQt8+rwLdo/AtIJHZJltv5oUHBqWW4h3G9S
         BawFivkCTxkpcm32871Sl7Wn0+Cevw07aHNgTvEQwP5S9Le2+cdjrD13UInc5FwONwMb
         qC30JwU4skpkZixSnGysa4U/JO4aF1h12wQp9cOoYSQLYelk2/NWawphxV9895Pb9z6m
         Enpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741127189; x=1741731989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVnMd/oqLZfPyfZDBXHTLRNY+ue0ydYsWRZpmZ6zrek=;
        b=igWheeU/ZELFmTZDvd3elr868A1M0Xtw+cDjFpILygUcwat4qSoPUxdISeMuv6QOnw
         YJrF0XJd7LaolPfvdFEvZNPqNhbwu7Fp8tSo6QqAVLKfpRkXpu/08YkjocLwyf5Ft31H
         THxrCJnjepcckXSSyizBBPmXKhgxdv5iEy3VKz4HShYKsoGbg+XH9S5Esc67OKwVARsZ
         0AO8GL6pC9liDK9zZVX/dm2obouo2vxWx/O6HkVvoAonkFo5ybrVYPTbmVYYFwm8owR9
         hHQPF6lbs75IBPIS91fnUiU/hlVFx+nd9bwf3uVbUNT56sZv+iUCPPkzEiToOjK/0ytb
         33hQ==
X-Gm-Message-State: AOJu0Yz/oBg29p899vvHmcz8DPu4dh34Vsn1PQa0IB1bVRy44AZmq3bF
	B/1lBK3oX9KrAA4+0fWV2rFDmwsYp6trSI3+16JFd2tWjU+eJYk8
X-Gm-Gg: ASbGncv4rHSydFe7FChkjpH1Ei0tY6ZSQTO4lZyhTMIPZeEaDyzqC8hNIEjc+CUT50O
	62Mptz/NZ0Mi2mVycZM466I73ig2u5JgyA4hmpCKpWgeMZ9AN1akY14dsm3ESIUBNXDqtGYgUwd
	Npf1y+7GsaOk3QOINzi2fJiDgaevfkb0ZqwLfVLesMg+Qw1hXKukC0cUTB/p0SnBHl6mOCH3JQS
	ANo2eNuefbJ7XtWUQYurnzsQO3sn1t+RK6SdvG/Pwjx7q34EkYCrVfIRft/WyLD4EIl4Gr0LLR0
	xlYaDbmmK7wanuIroXKUvW05DJmf55FFTaC/LOBfqUGTzKH10oD+KlI5Cw==
X-Google-Smtp-Source: AGHT+IHenKMGha9H+K6y3ePRTEE3Vnrd63SgVWqxmqamEkqF47x5Y4srvqOVGkHgLnpes9J04NiQfA==
X-Received: by 2002:a05:6402:1d4a:b0:5dc:796f:fc86 with SMTP id 4fb4d7f45d1cf-5e59f3efeefmr1977683a12.16.1741127188981;
        Tue, 04 Mar 2025 14:26:28 -0800 (PST)
Received: from f (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf6e9c6213sm479896466b.136.2025.03.04.14.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 14:26:28 -0800 (PST)
Date: Tue, 4 Mar 2025 23:26:20 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH v6 04/15] x86/pvh: Use fixed_percpu_data for early boot
 GSBASE
Message-ID: <tns2rrzk7vs3linnjevr24qyg4sm6hakndsgqvqsowqwwlrdcj@zus5wu6u3ju3>
References: <20250123190747.745588-1-brgerst@gmail.com>
 <20250123190747.745588-5-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123190747.745588-5-brgerst@gmail.com>

On Thu, Jan 23, 2025 at 02:07:36PM -0500, Brian Gerst wrote:
> Instead of having a private area for the stack canary, use
> fixed_percpu_data for GSBASE like the native kernel.
> 
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/platform/pvh/head.S | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> index 4733a5f467b8..fa0072e0ca43 100644
> --- a/arch/x86/platform/pvh/head.S
> +++ b/arch/x86/platform/pvh/head.S
> @@ -173,10 +173,15 @@ SYM_CODE_START(pvh_start_xen)
>  1:
>  	UNWIND_HINT_END_OF_STACK
>  
> -	/* Set base address in stack canary descriptor. */
> -	mov $MSR_GS_BASE,%ecx
> -	leal canary(%rip), %eax
> -	xor %edx, %edx
> +	/*
> +	 * Set up GSBASE.
> +	 * Note that, on SMP, the boot cpu uses init data section until
> +	 * the per cpu areas are set up.
> +	 */
> +	movl $MSR_GS_BASE,%ecx
> +	leaq INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> +	movq %edx, %eax

	movl

I'm bisecting perf breakage and landing on this commit breaks the build.

