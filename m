Return-Path: <linux-kernel+bounces-348349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985BA98E67C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3FB28730B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1919919D065;
	Wed,  2 Oct 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dEidZ7pS"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B819CD12
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909749; cv=none; b=aIUESNinWcH7bGju6jjeJkMk08kPBBsi5djX9xmKSgqGrowX4hq9qjThxjYYzSr5Pe6NyVaHoQYc3bH57CsAAoC+D8VuPSNKeDhKDrnytqkdinxUznd9aG6Whxr9nk+iNOO4Hj6ju6Ehx296cjUYNAkPNtbaEtLXbaJicSu2jIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909749; c=relaxed/simple;
	bh=UQ+nm3zhGqece2G7sFJJXj3yNM1FsjfcjBexhfJo8dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsVj1+0LIvKFq/Xv+75Tue8VNsDmP9hmep3ZUlvdTBkL98J7rZKfDXHOLffmQVA77Rz0ZsxF9Dzdzl3xctnlxf+a2sfEn9JLWpedriBYkmWT4buTax8fg8DN5/bujf0Nz8eOX/FfNwXhsOpF7Yj9aWHRd8PjX1Ei/EHBChp/yYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dEidZ7pS; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cb2dffcdbbso2955196d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 15:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727909746; x=1728514546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=elAAJiYmie6/BeJbW+ckCrB5BHiSIaWnrLSNZgAtbrk=;
        b=dEidZ7pSDXKIr6U3WCWGyLJHikX0x68NODhFGzAoON8wwviiNkcBfPKYU44RpoQClR
         WyEE6sRH9uDz2GFZAh15ZfhA/V+iaslYxIC8HI+0+pSXXNU/WjEeiD0MVq7Het2LMFiw
         8xtouGVzXrrlW6oiBKmdhV1HmHR0eUf3NU1CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727909746; x=1728514546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elAAJiYmie6/BeJbW+ckCrB5BHiSIaWnrLSNZgAtbrk=;
        b=ouOjqnZVWev7YPF7HBrMsfb20u31HAJ+U5z3HN1DNPR6KMyBiSCjf7/pgvNQOFySrw
         1V+damWyKohsi7YqBmq8XCTSvMysdc6qYXhXRzgwDXzZQYa2deVjoruiM8vTyURcxZC8
         /2+zLf59v8bAWX4JU7RwGbj+JsHuljuigLz0bnLxA2Cn5p+j9vcVSedxuDmrfKSNTgtQ
         gwbaFlc78Y8+09r4JZqrWPMHoJT7p8T6wvpsDljQpL2+hg6bIihgHakFS2kURDx3RaA1
         8KRLGVSj82WE8aM+c6/5sKuSXxHbiVuL9IVCqBKbuaw4s1g6gAHPfvGgwvYp4bu9uLxJ
         2eqw==
X-Forwarded-Encrypted: i=1; AJvYcCWyb20o+n5r91E0Vi2ccIiXCmkknK9p8j0mhEVppYJnjUXMxJpE0noEa9foCs26pkyPS3b6/V7KboOHXQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI53w+7fo0iN+xiK6CEoY0VD6cP2vtlJ4PLvyHmMtFPlf02KrK
	0tqk92e93ME20+djzCY+EpWJywic8/67ZPssIMsikffuDDnRXznUCL4A3JqKc6Wc3JDyxWlDb3N
	UgQM2IVJDOChd1rfIFOpaPY3XeuDFDpBmRUMM
X-Google-Smtp-Source: AGHT+IEEJKpMfJpjmIckkp4xQAz9YPjo2ohwRYhPYmYwt/EbiGHWaNgmqtcvsR0cG27XSP6Z8rWlcRHJP48RUWFgNPY=
X-Received: by 2002:a05:6214:440a:b0:6c1:6bf9:8fea with SMTP id
 6a1803df08f44-6cb81ccfc82mr56392816d6.50.1727909746706; Wed, 02 Oct 2024
 15:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com> <20241002094832.24933-33-patrick.rudolph@9elements.com>
In-Reply-To: <20241002094832.24933-33-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Oct 2024 16:55:36 -0600
Message-ID: <CAFLszTitpXdNWSDaL9SkBCDg4SeVPuh0_cHdBSLJFPNdjahOWQ@mail.gmail.com>
Subject: Re: [PATCH v6 32/37] arm: Implement read_mpidr on armv7
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 03:57, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Implement read_mpidr() on armv7 to make use of it in generic
> code that compiles on both armv7 and armv8.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  arch/arm/include/asm/system.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 7e30cac32a..94c6f8f134 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -384,6 +384,15 @@ void switch_to_hypervisor_ret(void);
>  #define wfi()
>  #endif
>
> +static inline unsigned long read_mpidr(void)
> +{
> +       unsigned long val;
> +
> +       asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
> +
> +       return val;
> +}
> +
>  static inline unsigned long get_cpsr(void)
>  {
>         unsigned long cpsr;
> --
> 2.46.2
>

