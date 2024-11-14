Return-Path: <linux-kernel+bounces-409981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9559C94FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB5B1F24370
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950611AF0C9;
	Thu, 14 Nov 2024 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TbnDu8Oi"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DFB19CC02
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622133; cv=none; b=cUByCxM7X5IY2Y/bakoARbtcGzU9m2DL6SS8RNbIkZt0PFb/smhUKd7oiqEbBNIQ0V/JfmcpXFgR+G2zDPunEFU7u1b47oA1bG5ZU2AZB2rArNPM4O7dWP1ZU5MHqD6mU4bZJES8tskQsG5JKPIPH1UK5taXapkO1PATuTgDWY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622133; c=relaxed/simple;
	bh=vVZ58YuCZtPn8RYOhRdV/xwFYmV3BU+6axehBcNN07o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUdbVAUSRr7j29vq25MgnM+gTAg93V6ueF2sIqSxKG4lId1C0HUTPbjVmsu6KvKudxKDAgEEaT8imTLouuV2WiU6JEnpt11fNAU6Dp/DGRABywjsfVK+62Zni1LpJtncMlrWueKLhIlfNyaSi/CRBMjKT0cdNAmXRh7QkWXFGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TbnDu8Oi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso965693b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731622131; x=1732226931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUDNvzxgF3VndexH2nVKPNcxZzxJAzZDJlThFbFobgE=;
        b=TbnDu8OiyMks5sFVHvgaNsA+qArMAQE5N8ndIrBlrr1Gh45ObBhBcwTOp0dnF/s1yi
         x+S8L+vQPxsNkwLt0EdZ7GKjtbGVdHPwdEpc4pxWX7CEofZVUNfqtAQJ0up3Wfhl0z+Q
         ruWAMHvAkn3EEJNhVkSecukMGS9elssnn3xTeG+i1p444K8cX2FyXWcD/BWBhPPlqc80
         musAeXTELNEktIHP+eSB8NVBuqgRd8RYyvEXcqGK3iPfA3nSRqp3791N/TaLJBZ6KsmG
         RgQo2j0+x2BuhRCyQ52sDi6lczWKYCUH5xTmEmIoCTbaGPXLtwibL5Uhj9IgwHC1gJoY
         d+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622131; x=1732226931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUDNvzxgF3VndexH2nVKPNcxZzxJAzZDJlThFbFobgE=;
        b=GfdwTSvjLTcFSNr5/5/W+8kO2DoQWaslqaZT01aJjaSogkHjcbcQkK2GYRK/Vjrag/
         /cNp77YjUaGhjzwJXbdSvIneqD7+K2NY2HiANB4ddzV2ArgZwebZsyiS6ihup8uip+8m
         23gqUnUa8WYB0lVgkvmZJgGvJfQaYzcAotwmPdaZP+Ak5zZR1/UIrLAi83LqxthQAaC0
         VLlxyQGX52v/E6v3rT56YUUHoxHQOTsVv1vfz5UiG9inbuEFpOtFEYAbAvixud1gToIf
         fVlqxBp9lA4NnaXPztCT7I/6ycXPhHVgvUMCRVIXUN4H2M3FESILBvzlX4ExFWMsRkzA
         creg==
X-Forwarded-Encrypted: i=1; AJvYcCXR9Q3yxklrWx3y7WI4bWBcEyENZtMPHwjdSW1Uh41j+RUkuLPA5LQ+fSpCBVfEXx8cDbkp18Qkp4T0LwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3U4mH5w+QdCxVhVJBVnImy6VqqB9tWNrifiQ2JUsesafFA1VR
	FxTY6IH2DXe6BzjIdzm9qVp/rkOSRh6/y1TKSo6NgFiygy8W6TB3NLXzkQYFJdY=
X-Google-Smtp-Source: AGHT+IFYyHyPSValRNfz1mg6pjq8qNxWBVPCofM9xYXccK+5syKbhxhGgqPtxHsSDUH+ph5ZigbeKg==
X-Received: by 2002:a05:6a00:3905:b0:71e:5a1d:ecdc with SMTP id d2e1a72fcca58-72476d17636mr525035b3a.17.1731622130787;
        Thu, 14 Nov 2024 14:08:50 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:8011:b5fc:6663:cd73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711cdfbsm132024b3a.58.2024.11.14.14.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 14:08:50 -0800 (PST)
Date: Thu, 14 Nov 2024 14:08:47 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Chin Yik Ming <yikming2222@gmail.com>
Cc: palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com, samuel.holland@sifive.com,
	parri.andrea@gmail.com, atishp@rivosinc.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix a comment typo in set_mm_asid()
Message-ID: <ZzZ072CMku0fsW2x@ghost>
References: <20241114212725.4172401-1-yikming2222@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114212725.4172401-1-yikming2222@gmail.com>

On Fri, Nov 15, 2024 at 05:27:25AM +0800, Chin Yik Ming wrote:
> s/verion/version
> 
> Signed-off-by: Chin Yik Ming <yikming2222@gmail.com>
> ---
>  arch/riscv/mm/context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 4abe3de23225..55c20ad1f744 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -158,7 +158,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
>  	 *
>  	 * - We get a zero back from the cmpxchg and end up waiting on the
>  	 *   lock. Taking the lock synchronises with the rollover and so
> -	 *   we are forced to see the updated verion.
> +	 *   we are forced to see the updated version.
>  	 *
>  	 * - We get a valid context back from the cmpxchg then we continue
>  	 *   using old ASID because __flush_context() would have marked ASID
> -- 
> 2.34.1
> 

Thanks,

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


