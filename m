Return-Path: <linux-kernel+bounces-431337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6170B9E3CED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9297FB3A980
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4741F75A9;
	Wed,  4 Dec 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0f3sqk4"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5DB1F7084
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321110; cv=none; b=fgq2oJf31yaxzvzY1d6/uhnPCtJHBABtuyZ/St6IRB2fESrIZcozgjgI9cE4g/3GiYVrosXiMsNKuHZpVNRxINYDrvfAUW5G8eOfo0GAqcD1CDMtVSGHG7Ta88Y8zXZ48ftZzKqa4ywilxYqq9RpjlBtTP3Z2Cfrz8fojGk3B5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321110; c=relaxed/simple;
	bh=EEUqUVDAtEDFpVNs6Rzg1P2gfpOhXD7qkRTRxtajZNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETPkWUoTmlLpOuCn18xdNTa++qgQPEbq+Nfgjx/OhKeQELL/yGHnCwwCT2youCPKuB5g7sOX9nxDM73xrNr+jl72Yb9zkeccv8cBg8Ygzg4UlayTIQVznu95RFuGaGZDvOauo0z0xlcHl4a+Y/2R78oQfKgYAMLfYfJadHAk9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i0f3sqk4; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ef0ef11aafso65215627b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733321108; x=1733925908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEUqUVDAtEDFpVNs6Rzg1P2gfpOhXD7qkRTRxtajZNo=;
        b=i0f3sqk4YSy4SIjpbHB4Ipq+JuPgCqx9BKjm0NuVXbTZuhJZeIvWDz8ARVZEBeou73
         yc0AVZ8BVUsZDgNyknOfy3yttqIGyKCTRUPjv1ExW/rYHXbJm7MoruUAPN6zsX3rtfGo
         rW5SVpGnFd44wF2+93BpVQj/Pn+w7LY8WVlM+HDJw/EH8fmoQEjjVUGJo4Y0aQX2vdZx
         bBALE7UySB1rVHmRY3Fn8sEya8xOd1+0PW25ZJiydvMw6oKiJad99uPye4xkKi6snZqQ
         8PfF+giuGNDrIOYMaopZO87SM6mMa52acyUtYDNorGs0JxSk3OlWtcj8NvwcjB0E8m3u
         sTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321108; x=1733925908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEUqUVDAtEDFpVNs6Rzg1P2gfpOhXD7qkRTRxtajZNo=;
        b=G/XjmkAtXbmb6rH2LXhg3ajhDLobduHz6mZRNSO029OYhih70wpKM8i8Dq9LB0KOwK
         drIqJJmuwXORm65dcAlMzYGBPUFXXOd/GwBArBZ8KaU+IHUOfiOcCZYnB+ElQjM2rhAu
         I+MsTU2OYNCUtPkQEmgIcV+2MZyOpqko71cP1HrEY4SfQ7UXzX52yO/BXa1GBBeTX65o
         9/ZrtkMtC8l0WX0OlMDIL/sQqfQ8ZaohMTityo4IAjMx6OChWGNl3+vzw+IZZiujQ/t0
         b0oqm31sXy61XBFwCtLK0g9W1uCvZT1uwdUR+XKK8Ra9kqdri1n3CIVaPLNZzH9PhZWi
         KKnw==
X-Gm-Message-State: AOJu0YztMhPrMdEjn5OaQ+SQrW83MXr6CoieZtCNovzqky2OXNmOFAeC
	9ylPDF6GLfzpq7enG45ivyZaiJRe+keqGREl/aRkR5m6qRoRNIgI7FSUvT/DBa1bdrP1ScAV1mj
	bMcO5Ups4S+k9yaCzlfBxgGkTDx/0D8QkMuaOkw==
X-Gm-Gg: ASbGncuamw4qFN/hoI+soLdkwQpMHBACixgQmIRSX3b1lPznlYQDQZrbJKz/5PsImKN
	q6CvsE5wxqUR+1m6JWdx0Bm/wHwAxQQ==
X-Google-Smtp-Source: AGHT+IHZLIY9WYZ9kTv9UNMITDDjd1m2vqhMpDylIYJF+rqjdSTk4X356+sJeqPxxX+hM6evy+9rhDmuqAcjgSFS+PQ=
X-Received: by 2002:a05:690c:370a:b0:6ef:6536:bb8c with SMTP id
 00721157ae682-6efad1c77d0mr70490967b3.21.1733321107797; Wed, 04 Dec 2024
 06:05:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204102904.1863796-1-arnd@kernel.org> <20241204102904.1863796-7-arnd@kernel.org>
In-Reply-To: <20241204102904.1863796-7-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Dec 2024 15:04:53 +0100
Message-ID: <CACRpkda2JoofOaep-TG90qi_Nik72a6ovuVCp-MRKQ6_U_NSbQ@mail.gmail.com>
Subject: Re: [PATCH 06/15] ARM: update DEPRECATED_PARAM_STRUCT removal timeline
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>, 
	Ard Biesheuvel <ardb@kernel.org>, Daniel Mack <daniel@zonque.org>, 
	Gregory Clement <gregory.clement@bootlin.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	"Jeremy J. Peper" <jeremy@jeremypeper.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Ralph Siemsen <ralph.siemsen@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Russell King <linux@armlinux.org.uk>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:29=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This configuration option is for the older boot method that preceeded
> ATAGS. This was scheduled for removal back in 2001, but the removal
> never happened, presumably because nobody cared enough to actually do it,
> not because there are any users left.
>
> Add "(DEPRECATED)' to the Kconfig line and update the timeline so we can
> remove it next year along with the other options that are not scheduled
> for that timeframe.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

