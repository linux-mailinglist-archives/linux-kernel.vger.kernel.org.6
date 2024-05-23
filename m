Return-Path: <linux-kernel+bounces-187386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665AE8CD109
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADEC1C20F24
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB7144D27;
	Thu, 23 May 2024 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OxOyI/YH"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8E57E578
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462885; cv=none; b=q8oXaqZvj05IlxQOiX2HCn5CHeOCAo7pYeIBKPJoCMquxzP76xWoiWwEcjVTLjB7dwibYIt89PgEyqC3Lbk2FmDkJFV8ccBacWRdskOfScIJbP2tgY6Wz4k93KfsrzfKBiO4xRv15sDRx5YD8V5MGhwg3h4no+jjk/J4bvsydLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462885; c=relaxed/simple;
	bh=ELboCd9FMME91SIRzgB98XTMpPvrhI0tTcJp+/B0soo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTJCtSl3v7KVxL7unQe7lj+Lssphp9Q3AjAlu590FEDYCm2S8Bgq9dL2eRVK7N08q4xQ8uIWC9r0kciYFOp3BZvFRoF1uYBktRobn4v8JlC3ecLhiekxJ7G7U9nACmFlMyT0bcvJ/qQqLzRwE5y8MwRmiLikeN8jhWwYu9RMMgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OxOyI/YH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so3425844a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716462881; x=1717067681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KLJpqS0EFUKkRXVB1cT+nXd/u/klamMtJaCc9IVI1lI=;
        b=OxOyI/YHuT5jf2uh+oQ3/dKNCXzzHGkasr7fRms3enozvvq7BGaysaJ2dqgmZVEjlV
         lK4a6o+LWqdG6N1BNBLhQJIchLPH+tH55jWwKpHVskIUXVqYqSBwxYG/Am0TXfDPpxet
         D8TA0T3SZcbFZexvumrXmCVVbKayRKtVNz9mIJj0F8fJh29D7gDLs1Z45GNVLC8ulHTN
         aPRJMOzYvoErYB4q/LexN0z8z6G+bmpcrckDzRpNGOXiiZSYgmLuBcReVyvRm6OVC7if
         8i9nb1I2yNMzdNT2e8H1tAUJptLUmao7Z0Ceu6UotRrEoM713EEOu+WJfMQo9zcq7Yex
         /q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716462881; x=1717067681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLJpqS0EFUKkRXVB1cT+nXd/u/klamMtJaCc9IVI1lI=;
        b=ZlXB+oZ32yj3O+5fCm5OusksXMTNlL/vWFWHByfVGFuDnnzHa4VUGgRS0wqW4vlcY2
         YwggdDqjfnFcklmy3vXQKkCR/VRe87OLKpbnuDlURrV+TAGdyil9ivsALDsrJ8u4XdIW
         FoE3C4zfNuCtKNghpsUkT0hAGFZXW/hM+pqFAJGIuIMn/mC4fAd+bTqghYb4Pe3EWF9R
         /MLBtkdakUU4EKC0GzF6oXX0WYQXjmOwgXOm1VjZ4G2NgehFojHQHRG4iJuEIcORfGJM
         s3F1NuI+23zqCVx5Xc4aldHJvMM7J2kRhGvLhxWSrhRtIdoEKEKf9+QP5I3/YGCUggoY
         e4Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXF8BH15xl4XWaTdU+VfFyhMwR7oa9AW3FaDDrqYvglJgDQNaQRUHnYawPbDm4XyIdo5UCyRpBd5LbHKeSahI0kPZ6m+EfQyHwT1c1Q
X-Gm-Message-State: AOJu0YzbVHesL5URan70KbLrisILGbMir/N1z1Lod+B0p2FM2tmFI4Hs
	BJtt2fg2CbaV5NoJtmhkKBUUI+Ggt4pmYTG5+7hbQ938lTL13H1XA+/X9pwBqq0=
X-Google-Smtp-Source: AGHT+IHqN2XZTEwnKPApkGhAohBfim6j8tShT33YK8omVdaG/SeSliXh4y0qU68y1sT3JRzGAZohjQ==
X-Received: by 2002:a50:9e2e:0:b0:574:ebf4:f786 with SMTP id 4fb4d7f45d1cf-57843ef8e9dmr1459296a12.16.1716462881184;
        Thu, 23 May 2024 04:14:41 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57842fec9edsm1219709a12.43.2024.05.23.04.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 04:14:40 -0700 (PDT)
Message-ID: <9cddfb9d-0627-4f00-b027-4cb1bbdfad4f@suse.com>
Date: Thu, 23 May 2024 13:14:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] x86/pvh: Set phys_base when calling xen_prepare_pvh()
To: Jason Andryuk <jason.andryuk@amd.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20240410194850.39994-1-jason.andryuk@amd.com>
 <20240410194850.39994-4-jason.andryuk@amd.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240410194850.39994-4-jason.andryuk@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.04.24 21:48, Jason Andryuk wrote:
> phys_base needs to be set for __pa() to work in xen_pvh_init() when
> finding the hypercall page.  Set it before calling into
> xen_prepare_pvh(), which calls xen_pvh_init().  Clear it afterward to
> avoid __startup_64() adding to it and creating an incorrect value.
> 
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
> Instead of setting and clearing phys_base, a dedicated variable could be
> used just for the hypercall page.  Having phys_base set properly may
> avoid further issues if the use of phys_base or __pa() grows.
> ---
>   arch/x86/platform/pvh/head.S | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> index bb1e582e32b1..c08d08d8cc92 100644
> --- a/arch/x86/platform/pvh/head.S
> +++ b/arch/x86/platform/pvh/head.S
> @@ -125,7 +125,17 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
>   	xor %edx, %edx
>   	wrmsr
>   
> +	/* Calculate load offset from LOAD_PHYSICAL_ADDR and store in
> +	 * phys_base.  __pa() needs phys_base set to calculate the
> +	 * hypercall page in xen_pvh_init(). */

Please use the correct style for multi-line comments:

	/*
	 * comment lines
	 * comment lines
	 */

> +	movq %rbp, %rbx
> +	subq $LOAD_PHYSICAL_ADDR, %rbx
> +	movq %rbx, phys_base(%rip)
>   	call xen_prepare_pvh
> +	/* Clear phys_base.  __startup_64 will *add* to its value,
> +	 * so reset to 0. */

Comment style again.

> +	xor  %rbx, %rbx
> +	movq %rbx, phys_base(%rip)
>   
>   	/* startup_64 expects boot_params in %rsi. */
>   	lea rva(pvh_bootparams)(%ebp), %rsi

With above fixed:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

