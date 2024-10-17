Return-Path: <linux-kernel+bounces-370305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB1F9A2AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C161F219D2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3E51DFD82;
	Thu, 17 Oct 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY0DpdJ7"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C731DE2BB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185827; cv=none; b=X5PEpUUTW0p7HYNNAL1lPKU8a8zoEz3XHdLRNVI+3FppQtc7KZgV3Bx7UK80yt4c8ToNMJaYLRmkj5XUDY/z7iIVNi76BJ1ActegwFFGY8+8HEbHtJq4yVlEFJYw8g1Zr4l3pXbJPjXMeYgJgN5l9eGs4neeO8aa84PYydRWmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185827; c=relaxed/simple;
	bh=zED/b4McdpSz43gtC+HCpza2Djmr4lESmMQXJbCA/Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k45RQljLn3PwN5RSbms48VboeDsiUbBPMfyAn9RW8Hec3TJ12oUhdc78bs2MUd5BcUFzYwiEDxTeeEZ7F5x61CMpmAK3vmXa8LZjI6jM6ioEJmLBPIKzcTLm656eoU2C+OXIqhoLRMq+yGuo9geVw2TXofMmH0+mGzZcIpnMq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY0DpdJ7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so1621000a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729185820; x=1729790620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g1k/XG1Lvb4g/ajEdhRNSXz8EKC7ci3gdhjl5GgeThA=;
        b=jY0DpdJ7rH5b35zmnPoyFroxrt2mNW+88R3SQcl20yb47GVZBNJ9oViYsaBMh1FfVK
         IWXQNZYy+Cf0ORQM1z3inmZDuv9c+oAEiE/1tpY1z6h+XUKaKRckNRbZgSCnGsHwKk/K
         UYdEbVug8Oy5Q6Plr56FHmxvWuEPDyQIjRqCBv2OTNl/nt3Rc3i0P5T+PKAd5P4Fa708
         lknEL/P8n+sKuaY+rCnPATE0hIzU1BGD9Xng5w7egO1VNygDXoyHeopToWFyY8Y/cUzV
         vMRdz0p2pld7Ba5SLKwIbz0kdqi0YOWO/C4M4xAp5skRIAO/mseJGhYQbEKFd8X7CFKb
         4QHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729185820; x=1729790620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1k/XG1Lvb4g/ajEdhRNSXz8EKC7ci3gdhjl5GgeThA=;
        b=eQzNkrMtS0bj8B94N7GGTjJgqG4g153P1Jz5prO3RnwcdjC0Hw5Pw0GcHbSpbDvLE1
         ZVrHthwdjL+nU8QFYhazvmaG4Q6EjsL0O7EjLpj8Wby/KW/duHiudoaRjnpizOxB3eii
         aAI1sxOwWBhFZH+IcWYaIEIumAmcgYy+5SMaU1hxWB+jAeWvIhPUSW2Qmo8rUW7XyVXb
         C0Dcf3M3ewgoX1/TWjSBRKU5+NrPRcyEqI4Qq7FdaBGG3eUtVhIKjjLrayZTI8Wi1ppQ
         mwIMbkbIZfjkKV7XoUAU2Qzie9FYX3CMc4raw92RE5w2rJ9uwL0zYQa8SbvVBlMwl5GP
         3KDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpptTkytZszrhYeYVk909YeW6cLG7Sxge6MnZhvAS/MqVlJCF4hV9XRtEt1+8BaFKtHQuITz4rYOiczaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dui6hglgdrKnlSuw4DBMD3ClPHxkTbYIErnn7jLSrn47DP+P
	wYCODfcQx5bq15UY43f0tYwySQJ22m+t6cOHpWNw3vejA6Vp7e1dwWbOJ9k2C3c6TaTkRYHu21N
	zflZK9WhDl4yNk/ysJ4MIQhQlE3I=
X-Google-Smtp-Source: AGHT+IHwnT85QfPV7bWVNJaXIeJUZNim73/ejLbAPqm/4IpHi7VRvXETJOcws9Uro7uWa5HL6NgyaUGpH783wHWb9p0=
X-Received: by 2002:a05:6402:51cb:b0:5c9:27de:6e73 with SMTP id
 4fb4d7f45d1cf-5c95abf2e6cmr16148909a12.5.1729185820311; Thu, 17 Oct 2024
 10:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014183918.30123-1-quic_pintu@quicinc.com> <ZxDbgS98-_VNkGXJ@arm.com>
In-Reply-To: <ZxDbgS98-_VNkGXJ@arm.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Thu, 17 Oct 2024 22:53:28 +0530
Message-ID: <CAOuPNLhvD9ya45RdSjoBA6bVkp2UpMqO_QvVOOeafd3ZUtHdTQ@mail.gmail.com>
Subject: Re: [PATCH] mm/kmemleak: fix errors/warnings for coding style
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Pintu Kumar <quic_pintu@quicinc.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hi Catalin,

On Thu, 17 Oct 2024 at 15:10, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Oct 15, 2024 at 12:09:18AM +0530, Pintu Kumar wrote:
> > There are several errors/warnings reported by checkpatch.
> > Fix all of the positive once as below:
> > - Use #include <linux/processor.h> instead of <asm/processor.h>
> > - Missing a blank lines after declarations
> > - Prefer 'unsigned int' to bare use of 'unsigned'
> > - else should follow close brace '}'
>
> I wouldn't bother fixing up the style in existing code, it just makes
> backporting fixes harder.
>
Thank you so much for your review.
Yes, I agree but I see that this keeps growing.
In 5.15 kernel there were 10 warnings:
total: 0 errors, 10 warnings, 2010 lines checked

But now in the 6.12 kernel it becomes 20.
total: 1 errors, 20 warnings, 2253 lines checked

This means new warnings were introduced while the old ones still remain.
Thus I thought it's better to reduce it.

> > @@ -2179,8 +2180,7 @@ static int __init kmemleak_boot_config(char *str)
> >       else if (strcmp(str, "on") == 0) {
> >               kmemleak_skip_disable = 1;
> >               stack_depot_request_early_init();
> > -     }
> > -     else
> > +     } else
> >               return -EINVAL;
> >       return 0;
>
> According to the coding style doc, the 'else' branch also needs braces
> here.
Oh yes, thanks for pointing this out.
Unfortunately checkpatch does not report this.
But I tried adding braces and no issues either.
I will push the new patchset with this change.

Thanks,
Pintu

