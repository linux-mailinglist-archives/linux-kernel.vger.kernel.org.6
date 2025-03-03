Return-Path: <linux-kernel+bounces-541162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E3AA4B968
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E1E1887C9A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4551B0406;
	Mon,  3 Mar 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijEMHlay"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A461D9A5F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990818; cv=none; b=Cbe40tanUPbVifQ7TsKZ/5uSIIzwhqDLHkquQK3tvYzpd/VhPdfXD3fanoCFOlFUSEwavRndUIfK9CNGU/ipFpzFzNYm/Epf8NLOTqnqj0J09jyzCTANV7lRGhrMNp6ANnDWBn4boaDhjTxMcyj7BzA9G/KztkBO+bptKQN6LUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990818; c=relaxed/simple;
	bh=XqgYTASZdBx3dZT6GACGqxIac1H6OFQPjap01jrQ3Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecGOl3EL8VV0molKNssovEvu9wQ1rmyXnGu1OqIy1sH492S9vz6vIFd6qEsWz/AbaSbPD3Y3EykcsUS2wqaY9qYOh4fTq0r+P8fH46uqw2sgvZLJ+J8WIR67F5csojKON1egwT20OH4e9/uFqTJMcBy8QU1qB2MIqx7YLEYopNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ijEMHlay; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ef7c9e9592so31381237b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740990815; x=1741595615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wRH5h3jTo2TqZdNdrwv2V8lANzprbc02HuVK7lPEI4Y=;
        b=ijEMHlaylh9ufY//YE2QixzWX2oNQ/s5TQpOLDKNPu27/ykB14HaVlCcHLhbbCLmu6
         Elaeq3kJjD1F4imrFnHvZ1UJT066IsHa7j4K0m3X98aeQ0RPe2Ey5wkLRwF6trQnIEi6
         tEIRyD1AuaOLT9Jh6WfZZ6GLH6psUcu6sMw/IHizL4+O7dvStVXRFtkSBYhwIzxniCAk
         TS+WtcqnMxWReKMnBKYp8BEiDsx/fVRQxz0usHTvcqvOTjAtP6yA2LqN5SsocjbPjSkW
         zYOEP/X+CQ/qHkwtxqMTjri+OxRFueuCFgsaMOlT7/lSpXv7h/HWC/W2sV92UBk2eWeJ
         jLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990815; x=1741595615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRH5h3jTo2TqZdNdrwv2V8lANzprbc02HuVK7lPEI4Y=;
        b=K7CIyKfBvSn5W7CLmJVddJRgUTSC4QYVeJ8j+7mxl5AJysY0quY0cle5qnUeuEikml
         4NmbhCXqe08IbtOICeOJwshotJn4WkLfgLXyyGKEQexbeRWGvCZ2vrYs0xstj8RYRLEA
         pddzB5oLFf9TP04uxgdNF5B8vkqAqqGkAfHgR9Ig+7vDpWOFpigin3zMVToEXXm2JPrr
         27sWhgPkPN2nABplQ6TN+KEP2JrJSfDhhRTkrd5SBFmbzkhQGyxSWY/peVGovCxXWRF+
         ng5v7P6UgYmD856Z2fyp3/KOPYUBi0U6qCmLl7x+ZsxOJsA3/Q3dCScjdN+mXdYw5DJ2
         cAJw==
X-Forwarded-Encrypted: i=1; AJvYcCW6RKAXB8vLQo7wQ1r53ps8B2FWY5rIxo1paEBLuk+qj2GGdSW/s2gSB2wb2bSqO00HxB4qx+IsX0TS6MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6A1Ry160B0n6ztCVsqRmuzkLajFln61SOuaX/mpGG8RjFSi1
	5nfqPazLf7fbJZtUWqbh3nUbypvcvYzV+iqSpI8C1zTBSLR6PYKYitPJQOVN1YFuBv4RVUgCr9T
	wP8mi2PRe1xw8TKFP4JEvD4sc/qll56cuXenmOw==
X-Gm-Gg: ASbGncuYKoRXscXKr9ZmUFJ9FgkCccCgIa6vacjA+mEakBNwlWfEyt5KRYLsHFnE+wP
	ZRRiAnbBuTmdfpiPkuekcfq1tJ6Om2Edwjcxk1VKgW+qb3Qi7YWtGCdRAXt65De0ndHPeDx1OVf
	V9EGYoOJE3jQBcyHLG2gPS7gs/IwYqcKauRy8MOPP1b0DYXjFbPlNQDiCkag==
X-Google-Smtp-Source: AGHT+IFhPa98pn2QSRV9xraHD57hSB0tHBrG1WLyodlq/Zyqez6QyfJ7io6YPk6jd+qrCZBolOvX6WV57bvRbWW8SOA=
X-Received: by 2002:a05:690c:618a:b0:6f9:7d7d:a725 with SMTP id
 00721157ae682-6fd4a0fbb9emr155711297b3.33.1740990815366; Mon, 03 Mar 2025
 00:33:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303165722.53c98069@canb.auug.org.au>
In-Reply-To: <20250303165722.53c98069@canb.auug.org.au>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 3 Mar 2025 09:33:24 +0100
X-Gm-Features: AQ5f1Jrmi46iuNkJxouNj07VOlPBAuSo8t2GayjfEqGDs0ABzz4K6g8LYoX6T_k
Message-ID: <CACMJSesVtZqZeodT5Fd5kmugxGYJn4KjnAzHpcvyGx8Rz53DbA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the
 gpio-brgl-fixes tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 06:57, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the gpio-brgl tree got a conflict in:
>
>   drivers/gpio/gpiolib.c
>
> between commit:
>
>   64407f4b5807 ("gpiolib: Fix Oops in gpiod_direction_input_nonotify()")
>
> from the gpio-brgl-fixes tree and commit:
>
>   e623c4303ed1 ("gpiolib: sanitize the return value of gpio_chip::get_direction()")
>
> from the gpio-brgl tree.
>
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>

Hi Stephen!

Thanks, I pulled in v6.14-rc5 into my for-next branch and fixed the
conflicts there, next should be fine tomorrow.

Bartosz

