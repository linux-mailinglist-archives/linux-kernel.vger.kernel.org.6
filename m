Return-Path: <linux-kernel+bounces-551363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACD5A56B77
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FF7174A53
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ACF22156B;
	Fri,  7 Mar 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uWjUvTN6"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFB221556
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360248; cv=none; b=dX1j055ctBnsR2x5WK0hfavVsoprmNSmQ6kPth+bsvTz5wsbGw24PSJ8NvVeanaGMfgUq9htd2xGhXJAuD+MMxuJCOcdeVgz8p8eYPwRXVkna7Mx5fFU5VwErFE1LTwIofe6w0ucbL0O+ibvdZdTzqwjqXUXsC/I9pkgXXFTG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360248; c=relaxed/simple;
	bh=7vPM66wrqA8ItOal1m7QS909J6dZMJbGOzOQwE8gVyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjJ4gHwFEY8uQYEDv5h0tLGzKLl2oXsZ6C0JjMlnQpZHFTpKBjRCixf3X+SE/3695zC+0BbH+0CFwOAcK+1NQTm8Fbrj0o5AA90HbJI5CCD5wQW8hM9KLMw1jzZDbMO9bcKWSC88Ef+t3TlK74HiiAZgkKVG2KXq1+VdviiFqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uWjUvTN6; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fe8759153dso739018eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741360246; x=1741965046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GaMH1NOSXXEyX+4I+PnYIXnBgRaLQ5ST8GTB4hff2uQ=;
        b=uWjUvTN6EX4c+P6aUMdpQ43KsDrmqLeNu4sCncwPyem00Z1g+HI/xWEBkr4dFJdHpK
         TNH0hXx0f3UoH43rXHSDalHKIXhUHAC3ENvuawUDmEus0ME5Xub6k9ZGTHGYrCIXPhrX
         89wAD6qQsx0sS9L3mwOHeQg0PE0ZPNktI0SWmt9BZek3zMTGVFdUDs9V5PPKsPDP8Lt5
         0Q3CtQlbPPa7a9N2dFgnArlZ/85+krAiwR6eFfidcqh8KJScz3g9hkivLPdwGkye3LTE
         lYYnUm45dF+wNyEBujgUNWIXn8AjDMak/HwScGunaYFpyrOsRWcJN/VPoYycb2cZ2MlD
         x27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360246; x=1741965046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaMH1NOSXXEyX+4I+PnYIXnBgRaLQ5ST8GTB4hff2uQ=;
        b=KnDmuuQU+sZf5vm11VNaqXMZQAdt7Z2Vg706zVK9rjPFVpLo7lqXO2LWNJvDKa1paT
         ROc6B2EEvRbDzKMFeByD1TWt4/oq/8OVypHHRzO7r4PweI+q8QiYN4P6dkFxuvAA11Xz
         J2hjrX7g+9iyA/cuOl3EhapmvESU2uKZ1AjjdJifXXhHJD91rM2syPszR6cXcjStYreC
         XyKzBVM03IHZ20kwHIKhbV+wHTCr6RbWGrA10Bc/L5hLvxTM8athvZO8QQZahvHBilIH
         eT2G6byUTgbTjewUV2QwMld0Pu1yr6d+diajeiuCorpxcPCL4IgckWbYmHY/RcOqDOd9
         7Ndg==
X-Forwarded-Encrypted: i=1; AJvYcCXJvpS9aSH2O18XcYnWIedBg9bzkrrk8fl8N0n19DkYftH3BPN2ko6BO5KiT1P5iPWkihC6ZJl0rZnbZ30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZ/FDmxEBbYJViMWQhdzkFH6gMtK1p4yAteYE1LhTEFi6jwdQ
	voEXOTKeQvEfxX2nZG0AZXkba5adKXBus4Vfwbo2hagWZucnp9FEgrrzAdwbKek4Qjr79KXrD+L
	zVeZkG+GemD0lwITefPf2gN9S4hi7h1IGZ6dnUA==
X-Gm-Gg: ASbGncsdOis3aozCZezaSDtSy/0c4b4TSyi5nQy9ek6Ig7VoAhoMXtl89IWcKGENEvS
	vqwc20Xh+07kgQWb9TIwCjZy0y6bXEQ2/ClGfGvNxh8SGH5zrn69InsiJ/5/R73qlCPp29bQkqj
	Dniby7+OYEymAvzaYjwvh0wukKFw0=
X-Google-Smtp-Source: AGHT+IGmSI6uKhyqp0Lz6umulak1/qdCrknOZ1BwGtVXVr7Hw1ALnj7JKNyxJ8z0WKOu5JKZrR6BgmZGuCc1usZ1pxU=
X-Received: by 2002:a4a:ec46:0:b0:5fc:f3b8:78c2 with SMTP id
 006d021491bc7-6004aaf90aemr2063696eaf.3.1741360244995; Fri, 07 Mar 2025
 07:10:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226220414.343659-1-peter.griffin@linaro.org>
 <20250226220414.343659-5-peter.griffin@linaro.org> <20250305024020.GC20133@sol.localdomain>
In-Reply-To: <20250305024020.GC20133@sol.localdomain>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 7 Mar 2025 15:10:33 +0000
X-Gm-Features: AQ5f1JrG484DP9qv6Qb4pGd14bkBMzxvaPSxEwh5c_p71wnvCQXfRvFkoiXZo_U
Message-ID: <CADrjBPpju3MmZbNy1uaPzAWTWrmNHx0nT+03DmkM3p5qFEUHdA@mail.gmail.com>
Subject: Re: [PATCH 4/6] scsi: ufs: exynos: Enable PRDT pre-fetching with UFSHCD_CAP_CRYPTO
To: Eric Biggers <ebiggers@kernel.org>
Cc: alim.akhtar@samsung.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, krzk@kernel.org, linux-scsi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, willmcvicker@google.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, bvanassche@acm.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Eric,

Thanks for your review feedback.

On Wed, 5 Mar 2025 at 02:40, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Feb 26, 2025 at 10:04:12PM +0000, Peter Griffin wrote:
> > PRDT_PREFETCH_ENABLE[31] bit should be set when desctype field of
> > fmpsecurity0 register is type2 (double file encryption) or type3
> > (file and disk excryption). Setting this bit enables PRDT
> > pre-fetching on both TXPRDT and RXPRDT.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>
> I assume you mean that desctype 3 provides "support for file and disk
> encryption"?

Yes, the PRDT_PREFETCH_ENABLE description in the commit message I
copied from the datasheet. But I can re-word it like you suggest if
you think that it's clearer? I notice now there is also a typo with
the word 'encryption' which I can also fix.

This patch came about whilst comparing UFS SFR register dumps of
upstream and downstream drivers. I noticed that PRDT_PREFETCH_ENABLE
is enabled downstream but not upstream, and after checking the
datasheet description it seemed like we should set this if
exynos_ufs_fmp_init() completed and set CFG_DESCTYPE_3.

> The driver does use desctype 3, but it only uses the "file
> encryption".  So this confused me a bit.  (BTW, in FMP terminology, "file
> encryption" seems to mean "use the key provided in the I/O request", and "disk
> encryption" seems to mean "use some key the firmware provided somehow".  They
> can be cascaded, and the intended use cases are clearly file and disk encryption
> respectively, but they don't necessarily have to be used that way.)

Thanks for the additional context :)

Peter

