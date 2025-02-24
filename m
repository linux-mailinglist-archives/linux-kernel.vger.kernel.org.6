Return-Path: <linux-kernel+bounces-529977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDB0A42D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA270178E46
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B797204F8B;
	Mon, 24 Feb 2025 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ni8RGp/h"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6779322E017
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427044; cv=none; b=gV3/AwqOjCEok1yZnTHc5FFFnyz2POQ+NwoN5Nyj8i9XL0RykeRoKYntMVRTXlToGeUwdwUosHSil3dyK9IM1UOmXDsrYHl88pH/AMQxV3br0eEbSi6nz9oMHB80UlhnrlJCOOckKIZSRrJiVViB/8MEvR7j4it8yyzcpxrO7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427044; c=relaxed/simple;
	bh=CDuJLlzBuj/3fmoBDS8v5Wx3cO3oqtn/G5iAqHz7QEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BF0oDJD9HyRuvyW+dBk+5C5serCKHmTgxmbIduz9jifZ9tTl8U9Jm9Y9dry3lknQr8ESNvusPHxI+vzkPRxsJu6BmqcE4yUV6/xjhswA/yR65ystKMmsw7u3ckCERYYYViM8k2Vqb65G7ZwmKcJFURzFQTw1lOgamglniNE45L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ni8RGp/h; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fbaf4cf2b5so34741537b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740427041; x=1741031841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qJE0/sfBAYyFpeapvbHG+qTDD6Fu2nTNP3MAIEqRYyI=;
        b=Ni8RGp/hvPVh3Q+9+B1Dq0U5m+Ru1iLzppdooTNL7LGkz3WSnMgvXohMPGb1MAFzp4
         vW8EJCpb3r2KmFzEQsMPheW8QcjMPBIXJKvZ1+ath2LnTYeBDSmZjsf+DQx8oChnQZ4O
         VOs5OIxyce2UuPB1NF1Nqq6vSmmgSzsk4o2tmJOONYVgUhHnfJ4WC7dYIXazXphR4Cr3
         W+C9zuF2jlGY8eq2VtjJIW+zu/MfL9lZecnK+c/+iJk5xEpDsgCDPQr0b7s1ebu8gqCU
         z/FBIKnAfgHl2NnNsSnJtk7YWU8WtIQ0RQSmoS0/kqG/s7gMZurQa83Xk9qhgSOtME6k
         5D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740427041; x=1741031841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJE0/sfBAYyFpeapvbHG+qTDD6Fu2nTNP3MAIEqRYyI=;
        b=TRn+A+d3CmwJNCsguEqlIc4Pl9ybTarzLlJhHrIckpotHZTluSAt6PngDpOH18Ryeq
         xep5yDT5KMfvk+a3EhXfghwSNFNU0USG9zSbYywckmeV91J8KMKvQfaa8OVVJjCEzztS
         byPvo0jpKNXNd2PTdrTT3uS8GWSKZCYAM2ZN6oohrfde5Rt4c7MfZBaP9czjv4Bi50WG
         oe+pbeWOOUlmuwb8HtIU8pSQ0/8vfIwYqHs4WVlEjPF4axa/Vd5iiiYj5E26/zP6iGhf
         wcCGnpt60l27Bi/nx+i+91CrmOrFleI8Rc7QpZUjtMB2pq5pFlEox09hbKd404py+7Z4
         0LpA==
X-Forwarded-Encrypted: i=1; AJvYcCWgILHyZaqJSpyBcz6Wan9JuZ+AdVbXzQsGi0MTzlXnRnm+yitrar4u4CPFCsx1nioTl/Q8s/GhDDyLX2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGlUT5E7Us1sG5Jdmh5ufEz214h5x/922ZgU1pXUQcHK5rwhH
	a6lgoynNL3zNtTmS5XD93Er6HmN0f04wXXejNdMc8EvXaegXjOlsGgM3rn8LFaGOAbiaNqE7xn8
	7qrm7SmdTRH2sJcwHyvv0q+9A//8OAVpVOKPw8w==
X-Gm-Gg: ASbGnct+FjvcE8cJ8kUEhLj80tHNjctp7F5Si3LqVhN4nCb0MFwbeUONkSwpAAkfbWq
	NF1S+rw6ms0UeqRVe4LeuRn6Zx2vSEWd8TY2WCm32Bmnf/gosu6O6LGsshWlreb9VfUjHTnJZUC
	RBTsgqI0wUGAG0UOiaaKiQtFsdo5N2QTd1G7qVGA==
X-Google-Smtp-Source: AGHT+IGELIDMwjIBCztxs5836xqFuRiiPvU5KI02gA1b7TYU46jeylRaYFpxIGIqNf/544TC+dFaH1RhudEr9sGkaEc=
X-Received: by 2002:a05:690c:6306:b0:6f9:3e3d:3f2e with SMTP id
 00721157ae682-6fbcc39206bmr131218317b3.33.1740427041314; Mon, 24 Feb 2025
 11:57:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224142604.442289573@linuxfoundation.org> <9a18b229-f8b7-4ce2-8fe0-4fabd7aa6bd2@sirena.org.uk>
In-Reply-To: <9a18b229-f8b7-4ce2-8fe0-4fabd7aa6bd2@sirena.org.uk>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 24 Feb 2025 20:57:10 +0100
X-Gm-Features: AWEUYZlQ4PohouoGz9euT-b3auLmwSPp2vyoSdlob91LHpZWlNyBUXX55Rfeoeg
Message-ID: <CACMJSeuQkzvi5j975bbb6gF=+NMz0Aw-X5xLXR=8rMUjeQUoZg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/138] 6.13.5-rc1 review
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 20:52, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Feb 24, 2025 at 03:33:50PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.13.5 release.
> > There are 138 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> This and 6.12 are broken on several platforms by "gpiolib: check the
> return value of gpio_chip::get_direction()", as reported upstream
> several drivers break the expectations that this commit has.
> 96fa9ec477ff60bed87e1441fd43e003179f3253 "gpiolib: don't bail out if
> get_direction() fails in gpiochip_add_data()" was merged upstream which
> makes this non-fatal, but it's probably as well to just not backport
> this to stable at all.

Agreed, this can be dropped. It never worked before so it's not a
regression fix.

Bartosz

