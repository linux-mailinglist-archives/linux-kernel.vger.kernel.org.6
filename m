Return-Path: <linux-kernel+bounces-299218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 112C095D1A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A742C1F25F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E909318A951;
	Fri, 23 Aug 2024 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkUU8JFI"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73795189515
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427426; cv=none; b=JYhlOCIsuzIz2DmDvvqj4RYP2eykzS0DKZy37VTEG4AjrSR6vFaPDs9nms8E2btkDKjTgDAqKf8DAb+FjHOVFgDWQPAfcGLunhlucNCwaWv4d4BL/4gFunoHTg4Qa7Fh6q6IPnH4jPT9jIfdJ66h/sLsHsx/IgeIoyHiODrD+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427426; c=relaxed/simple;
	bh=73iNhJySyV/878GcSe/34b4oJkyS4cupUF3ZXq3s/hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmrML52OVb0h3JvcSXp+pddJWhCbHEzbjGlXEoQTG+Dw1NMrIkgYwH+7A5F1JKIYcz/3ZEgnz348wWsrOQmIOZTfLxc3sGI+mo+4z3F61PdEtRn/3ATfhjV5kE7dp+hejkgxij/5B1t89BQimoFbAdTVW39nKiJpL8riQwQ6tVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VkUU8JFI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53436e04447so1248210e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724427422; x=1725032222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73iNhJySyV/878GcSe/34b4oJkyS4cupUF3ZXq3s/hY=;
        b=VkUU8JFIB4NLRoD2Yz6+4VGz4VI1xWsErnL/zaKpTLZCt0/AZlD0NHlAEd/cQl+Dh9
         NQQK4W3PFIU+lp2uhEiKTmgs4/FB1S7jTKCpbrt8fy0f0wf8zbrv+y7QkDJiDVmlCztp
         myflJLNOgGRubrFJAaTs2nJUkZjTX0wwdTEaa9UoQ6bcpCcr3VZtsucBNfq40gTeJTK8
         zn3YgKBOlA683jpNQf4RrY5kWAwFNBpTCFMDAh9tsM4b7jdMpZlOwTe4YFVPvPciNTVM
         GUtesrBU9MXyYjrVTifFqQpuRIODLFK6je4FepIH1EZYCOORymowVj//AMmVy1lWclNh
         gtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427422; x=1725032222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73iNhJySyV/878GcSe/34b4oJkyS4cupUF3ZXq3s/hY=;
        b=YQQQqlwwpYoF9lQNRdxX3FTHRnWWOi0Hih61GxLm6GAy9PYcotNg5ELGQIWau7QbZf
         1u/0nRA0iE/9pwYuLoie9igbktseiBJ7JDMdGhNzlf+u6tj0AwSIbo05o6whNjq/G4nJ
         0fbZHvMrGtX+2c3AC/ZD1Bqs2s1ox6cOHDjISaZKFVJIjMkDYIRzu5JXXU/Rg51bKjwS
         Wl+ELx+luKCCjSDl9YK8wPgqT5GXtrebfdb7qMOmvhGwV4ORds2r6HkFOt4IJFHON+46
         bc5o+kqptuVJuUzA1gEygmko8bo55F/BmoBaEOJPBg0/+OwpQg6xM3oKCfUYENFO+NYu
         yqBg==
X-Forwarded-Encrypted: i=1; AJvYcCWwSX1pBQ8DxEUZGd2zo/w6E4MWBa8i3sArdPfcedvkmZ+yz69bIr+/MHdGE1PUlWT5CI6mi3S0WE3Z+FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJt630M7M6r2r3x5qOKZ7kl0Rbcqbr86KLaSwDJeusGVveeQEk
	WzGh+6sKHNhPEBBrPgKkq54wkqe+p0tvKysw3DetXgiC3773/dJ9osURodTieALzMDaNUlV4naf
	OZ/8Tg0QVfNjroJqV8G3r0jUdhvppHT+pJwFZaw==
X-Google-Smtp-Source: AGHT+IG5tT2beJGPYNT3OMoJNCXPZxMLz8fmQwBsDmXfGJ2O0nQ3v/qJon/hw7B+S2laj0ajPq94396RkosR3+eC9Qw=
X-Received: by 2002:a05:6512:3e1a:b0:533:4322:d03e with SMTP id
 2adb3069b0e04-5334cbaf0c2mr2472030e87.25.1724427421932; Fri, 23 Aug 2024
 08:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731113905.3326586-1-mail2hgg@gmail.com>
In-Reply-To: <20240731113905.3326586-1-mail2hgg@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 17:36:49 +0200
Message-ID: <CACRpkdZBWDf2t=xY83JePUR34K4qS1QnVivLELp6W779rLZf=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: mm: Fix kernel memory mapping for xip kernels
To: Harith George <mail2hgg@gmail.com>
Cc: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, harith.g@alifsemi.com, 
	akpm@linux-foundation.org, rppt@kernel.org, rmk+kernel@armlinux.org.uk, 
	m.szyprowski@samsung.com, vishal.moola@gmail.com, david@redhat.com, 
	willy@infradead.org, nico@fluxnic.net, ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 1:39=E2=80=AFPM Harith George <mail2hgg@gmail.com> =
wrote:

> From: Harith George <harith.g@alifsemi.com>
>
> The patchset introducing kernel_sec_start/end variables to separate the
> kernel/lowmem memory mappings, broke the mapping of the kernel memory
> for xipkernels.
>
> kernel_sec_start/end variables are in RO area before the MMU is switched
> on for xipkernels.
> So these cannot be set early in boot in head.S. Fix this by setting these
> after MMU is switched on.
> xipkernels need two different mappings for kernel text (starting at
> CONFIG_XIP_PHYS_ADDR) and data (starting at CONFIG_PHYS_OFFSET).
> Also, move the kernel code mapping from devicemaps_init() to map_kernel()=
.
>
> Fixes: a91da5457085 ("ARM: 9089/1: Define kernel physical section start a=
nd end")
> Signed-off-by: Harith George <harith.g@alifsemi.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
(also for patch 2/2)

Sorry for breaking XIP :(

Can you put these patches into Russell's patch tracker so he
can track it?
https://www.armlinux.org.uk/developer/patches/

Yours,
Linus Walleij

