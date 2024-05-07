Return-Path: <linux-kernel+bounces-171863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C88BE99E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E851C21668
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1716180A6F;
	Tue,  7 May 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JzHD20mv"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F84A1802AD
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100172; cv=none; b=cQqGPasY+iax226gyho1eII85M7GjsBRcwdLLO7NuvsCrAJONKsg8LB4qXpwJRlvlaZv+UujumiK3+PnqNPAa0INnbzXT+aaOvrgZ3MMv0raMo1g0IIh2ump4wQa3znoiYkTWUZv/LXw0NcX7iBYfvSQZrFyImbHwvuPWpau+58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100172; c=relaxed/simple;
	bh=wcF/docFjr+wD8+ZhWWu9ng6Q2+gklOMYNBpSAuz2g0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RlIZLZnVyoLO+9MV+snMarlrd1Ek9M6SIC1VMAwDsLUbqDAFPpnFhg0ri+iJZA9AF7w4RNoN7H4At7lQo0qRLsAssMPfM2UZPTT0w9MIyiTLvHGJxHovsE304csDlylOkCtw2yIJcbBB8+UKB17d2h03MDC0AMm85G5KLUTzUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JzHD20mv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41ebcf01013so15228895e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715100166; x=1715704966; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eDuw6XMtyXZKzrVG8KLN93/CpRj1Z6EUoNzW3VbxI34=;
        b=JzHD20mvT+5jIsQESGbkfGhTezCrBEXu35oxNz6+HE+SMl59j4DdZyjxvl38X0XO3Z
         YFZeR28U8NhogiIeH753Wcf/+oCd+BVaVgMzZ6fp/j5SJE1QwCs5G7zxWYyfCpAwdHk3
         HLuHqEj1Z92YNGjGLRvjoI+8FA9/Zsu2laXjPMBMHfJRK01uECJjVKPd5aX+sV56SQHr
         MImTq4iACwt8TG7jNhh40KW0ppHwTs45hEUIsxC6U+M3FiaAjQk9ggltvCtBYHcDErgA
         I9dxuD4XlrukFwVFx0n7ffanyI93fGmNK65W9IBto2OEGjrz/da9b+rApXhN++ew7PU6
         YQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715100166; x=1715704966;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDuw6XMtyXZKzrVG8KLN93/CpRj1Z6EUoNzW3VbxI34=;
        b=R02AtC4EHMuUg3+V01lY5BxNg5fblsz/17/bOCTOUwvPeZz9tzEkfiFcpue5qlf0/5
         lRTmAUCrOpWwtKUhSdkID/Ym7IDU2Y2QPm6vUEnkfoKUnk0loRsTsnxmpg6nLhAPxJVz
         dpXluqJldGqHKxCHRItevCORcf7NIwqTAz+sJvMZUtIRue9sSlz0siuMyOMU5E0yPFUb
         scPsqYVxINxjLO7xjdt4y+RD99gVkQvcv2pbz1nc9KuXybyDl9hP7zTDm8WGJMTInLIS
         aqNQ6mJAi0CbPV/2QlY2N/9N3zRTpMLCRYqWeaPIwiNmFMZoHUb76Ypr6WyINUdn07TX
         lPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX96gnxdQME8V/GTzCdW8Nug7EDgFbAzlJUe93sYAL6vydqCWbL8uyCsrtgOdAylsaoIoX7VUL9TIW5rTxpgK11G7uYXbGbg+1MVFUv
X-Gm-Message-State: AOJu0YyTK30DnH6TWPbMn/hroazaZ1R6F72diqOiZwJaCJ9ym1gp46VP
	3tDmPninR9wLoLT3mYYk2/7a/9gxieJIc3LBChas0mWpUWFga/1OD/v4uaa3ehG/6uAooXxnfek
	zUfaJ0Q==
X-Google-Smtp-Source: AGHT+IGz5ROh6hpvDY8BxgOFSwQqKYtWyJh/WIFaY8FC/3aEG7SaPSARBMjJ9g4keP9TpUCNAHeWGg==
X-Received: by 2002:a05:600c:314c:b0:41c:2334:fffd with SMTP id 5b1f17b1804b1-41f71cc19bcmr3656375e9.9.1715100166177;
        Tue, 07 May 2024 09:42:46 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c4e9400b0041b5500e438sm20245506wmq.23.2024.05.07.09.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:42:45 -0700 (PDT)
Message-ID: <e4ad92b88556f0de05b6b7ae03da1e581d688ce5.camel@linaro.org>
Subject: Re: [PATCH] clkdev: fix potential NULL pointer dereference
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Michael Turquette
	 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Tue, 07 May 2024 17:42:45 +0100
In-Reply-To: <20240507064434.3213933-1-m.szyprowski@samsung.com>
References: 
	<CGME20240507064445eucas1p1bfc17da4f824ef46567774634482f12f@eucas1p1.samsung.com>
	 <20240507064434.3213933-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Marek,

On Tue, 2024-05-07 at 08:44 +0200, Marek Szyprowski wrote:
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index ddacab7863d0..d2801ae70e34 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -194,10 +194,12 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id=
, const char *dev_fmt,
> =C2=A0	return &cla->cl;
> =C2=A0
> =C2=A0fail:
> -	fmt.fmt =3D dev_fmt;
> -	fmt.va =3D &ap_copy;
> -	pr_err("%pV:%s: %s ID is greater than %zu\n",
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &fmt, con_id, failure, max_size);
> +	if (dev_fmt) {
> +		fmt.fmt =3D dev_fmt;
> +		fmt.va =3D &ap_copy;
> +		pr_err("%pV:%s: %s ID is greater than %zu\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &fmt, con_id, failure, max_size);
> +	}

It might be nice to still print the rest of the error, so it's easier to se=
e which
clock is causing trouble.

Cheers,
Andre'


