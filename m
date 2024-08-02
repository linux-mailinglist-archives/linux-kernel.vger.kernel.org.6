Return-Path: <linux-kernel+bounces-272053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DC5945647
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AEA1C2194E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E56199A2;
	Fri,  2 Aug 2024 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DeNvzjqG"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9118EA8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722565478; cv=none; b=FPDS1kHFhX69tJivr8assttfhkIgyWH6pJ3rrw1P/ND+NX/omFxbbE6FSxi1HLvaEFm0TDbMjRXCwhwzf/uoiphLlvb2v0kH2Qi7zAYCsUlgL0yoscDav2ozQ68hqZNnOfqVdKjxeck1Pdb1CknsAC39wx+mzkwPzs3AYXJJyRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722565478; c=relaxed/simple;
	bh=1pUgx4kLA5On0aRPcA0zyVwM4kr2EKTTlb7JRVxeoQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us0LKDecCfG8NdmSVkM88PYyw/TP74LIxxYNB0QUEv0Rac8Wj9wWO9cUOzEzOmCWvORJ27qAc8KxewYgUFP5io4cjrWkK1ldQqoEswaBYYxrgwHFet6g2se24gimatsEoiga4l4CS19QGO4WrJphOB7nrEmXi1z/96gFskzXQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DeNvzjqG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d1c655141so5869174b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 19:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722565475; x=1723170275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbaxQcsGfxUIgeMy81+1yUQqnxTxpWNLrxDGUmYtREY=;
        b=DeNvzjqG4SJazkPKxQw+xL40JUQLgyYqQJy7dORbfWS0PeMBvZsChBpc9nLURCYJrN
         CMJXBIc+qZ3M87Gn54oOXLDdzOixvRCZXCu6IOIPt/J7RkMF08MUlbUCtst0YyggHMGp
         CeQCABcD/e0Q60BraJaGODxJaVMhC0HRs+9oPK8hkEIqRTHKsxGyXGl2HJ1GLLWEwiMP
         xRcu/mTBV2SgdZl2j6S6YtyCa0ajSX6O4YONLXz75tKobL7zQFNBNOBL8FTkBP6JipG0
         mLiKpu3KNyTwwTPQI8IimuMz7WbDsUoZ1U22RkGiseCWHUfzbCE9Y16WYP/AJHg6q5FA
         pdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722565475; x=1723170275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbaxQcsGfxUIgeMy81+1yUQqnxTxpWNLrxDGUmYtREY=;
        b=VjJ3Lsv9FRdONvVlG9U4YkOq+/A17x2KjvHh0CVUPwYQEeB+Vb6z8S9F5lqZTHt22a
         L4d8kUqO/KyTgIHaU0MZoPF5CosCWzTm2ilPMz7q+xB2OFZEgJ51rbVqy8Qmo8itCfI9
         nKvszBeL2gIQsgKu9zn2R0Ybjlg0tchH+iAuHSzWYd1EgI5aTU5ABnkYw5eYmey8wZFP
         QiSIGOdRRND5qEfFxZhkQ5najFWJmnlX/+0taSwjErQLaNKBjcox503QcCRR4PM33QgL
         RexZntTsyIOQh02LW1ZQYbKdK7dn4KXYwcX+sbaU/tESXs9qvhVZyWbVoU/T5jBPDORA
         F5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWiaF10C4QeykDsjw00Z+Jp+1tNhoVlxKf5XnrKD6ljbAA+bijVXW9GQ0OgszTcvl1LTKDlx48RViUb2p+dwp8i7k4bN8jJUoPuh7V
X-Gm-Message-State: AOJu0Yxx9VGfvkLJsaY/TPMq0bueKyN6/s1M0to5ZjV6N/7YGJjHju9k
	RZZzXi6NmX0ie7H+iSsHMmkdqw3ZZTdew4/lPysSRDJLxFN+SmDVBKUVMsXPaAA=
X-Google-Smtp-Source: AGHT+IHszQBF9XaIlkRyUDtOVaKjBsyd9ElItCsAR7bTXrfBCzQtRSicoMdohqzkHhw4ctg47eXRzA==
X-Received: by 2002:a05:6a21:32a0:b0:1c2:9643:2921 with SMTP id adf61e73a8af0-1c6995504d0mr3392945637.10.1722565474979;
        Thu, 01 Aug 2024 19:24:34 -0700 (PDT)
Received: from ghost ([2601:647:6700:2d90:16b8:ec8e:e4be:b399])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53c4csm5947405ad.72.2024.08.01.19.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 19:24:34 -0700 (PDT)
Date: Thu, 1 Aug 2024 19:24:32 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH -fixes v2] riscv: Re-introduce global icache flush in
 patch_text_XXX()
Message-ID: <ZqxDYF1OyIf40ZJA@ghost>
References: <20240801191404.55181-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801191404.55181-1-alexghiti@rivosinc.com>

On Thu, Aug 01, 2024 at 09:14:04PM +0200, Alexandre Ghiti wrote:
> commit edf2d546bfd6 ("riscv: patch: Flush the icache right after
> patching to avoid illegal insns") mistakenly removed the global icache
> flush in patch_text_nosync() and patch_text_set_nosync() functions, so
> reintroduce them.
> 
> Fixes: edf2d546bfd6 ("riscv: patch: Flush the icache right after patching to avoid illegal insns")
> Reported-by: Samuel Holland <samuel.holland@sifive.com>
> Closes: https://lore.kernel.org/linux-riscv/a28ddc26-d77a-470a-a33f-88144f717e86@sifive.com/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
>  arch/riscv/kernel/patch.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 69e5796fc51f..34ef522f07a8 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -205,6 +205,8 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
>  	int ret;
>  
>  	ret = patch_insn_set(addr, c, len);
> +	if (!ret)
> +		flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len);
>  
>  	return ret;
>  }
> @@ -239,6 +241,8 @@ int patch_text_nosync(void *addr, const void *insns, size_t len)
>  	int ret;
>  
>  	ret = patch_insn_write(addr, insns, len);
> +	if (!ret)
> +		flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len);
>  
>  	return ret;
>  }
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

