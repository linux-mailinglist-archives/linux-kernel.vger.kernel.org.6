Return-Path: <linux-kernel+bounces-537263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647DAA489CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B3A3AE274
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC6F26FA73;
	Thu, 27 Feb 2025 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sXa9rgGI"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF526A1AD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687843; cv=none; b=aeSpVcoZY1mNXb2T4LwOqUCA2eFCu0p9royjSkHME6/ykDgCinoU97Qy/wj1dpcrkNf9UEaOPvk5vUPYG6xL8KF5j1WydtxqmvPoGmP8igNj8rqraX2deEI/5e39sue8RHpeAA0Vy9jy+kTAch56A/k5ycBRm9LsPDGfrbu2r6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687843; c=relaxed/simple;
	bh=xzuDAtDLsMklMIj9X/3E5DszvjVGsPUE/6ktORRqvH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJYlfoFnaH1KCWtSE5WPql0bpLEGQJR18H1zcHwji5vjl6MSOaw8KqdjfpaMNl39zbPhoygxa7LfNGkzUht+eiJ0ENTEzgx9PF4QlcV0gzWPhbrUNKhW3JrXNn55+pwVIBvAzDNeqfcUM+HizDaj5BdqrKiRY4CmrDLXOqwSRH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sXa9rgGI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-307c13298eeso17116781fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740687839; x=1741292639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyq7rCZAildVjmFezfKBEpeheeeS0M9w2vanP83edP4=;
        b=sXa9rgGIe72AnWm0kXhbz3sA5TE/JUAwI6iiCqmenS/s2pEofei0vZHc6nvjWCSyNQ
         XDpD77aRHuidyuC+OXRs7wtDaQs1v9jELmLnKwSR8HxERM5eNJVkLvoLBGNiuKMijhFl
         p11C2I9WVuxd6mJ1HpR+ABEBKdm/1c2w0WURWljxCJjwZrFekIXGu6NOIUXqXqw4aB+s
         7BoP3r5y2F4KRaiohrYJfptuXZ6nlxs3cGTb/NDyB508SzRTJWMERZWL3EkesLpyAFZH
         VGbcQuQc0/VqMCicmazGTA74QJCYlxVO78OowOVCzL8AjU5ZePoJ0ejjBLZYuLG5soxZ
         NArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740687839; x=1741292639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyq7rCZAildVjmFezfKBEpeheeeS0M9w2vanP83edP4=;
        b=QoAA0BCtiVzQIxBGVnzWPwxPAmHyn+sqO2tZqjp/WnCfrprySMsrH1FoDG/o0Q+Zwv
         oPmshu6msLf8Q1lv+uyHMucKdrYK72p+N4+gY83vdk5JScKmhyH+3755b/h7x8loFHDJ
         f07x5Vr48nun1VHPwK1gjCUeXnjbIUyKwZD2bpoior3BdrN39Zw8asYpZpQ/ufYb9xqr
         By0+RebLdQ6nYsc+UEK+e8/bffKp4L+HOXTmvVcj3gF2etTkDuonUbDpFay7iLwDXKtR
         aCh+CSp3J0ZBQ8y3dV6GslBZOb6GlAkjVPe+Nkq8NDMK21j4tRzquu55EVzJhuvsSXP7
         n1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWRgENXVfc/xoo9rXtd4LET19IMSvtPGRgjQZhrPyG+YfSpIbjBDasXe23ovjdBlK3v2CrDSBXM6c+w9iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxasNXFmQedi4zA1vTpoq7paRcrnRLINMFHulaQTa0xEYEyt9jn
	OIVwcmTVw4hs5xEH/NSafES2dNqO30X6GUnnjv5xWLgR0tmWiohH9W0G11ZOYpCeUmR1shXQ7pQ
	DnP2WVSkxhhtsP9YJohYnVpR1oYGBdrZq7nVDxQ==
X-Gm-Gg: ASbGnct6/WnQmgOLn8Icg3CpeOo2ujNmk02/JkKl0HmMbOzQEkal8FjRuvM8rPSUyGX
	8FhbLB4hoGiLTB7Rv1CN8cfT71ndKxxA1M/EozOn8vQERSdMdzVG71haIp1ErF4+fg5LyJSXygq
	6qy2pLzxE=
X-Google-Smtp-Source: AGHT+IF8jr1RPuup3BcxHI4jeLlB8xSlyodMY3QSAvlSz4clUiZCsM6vxrH9ix6FZsUN5FoNEP8fAezlutGEF+kORI0=
X-Received: by 2002:a2e:b8d1:0:b0:309:1f1a:276b with SMTP id
 38308e7fff4ca-30b90a0d479mr2534371fa.10.1740687838584; Thu, 27 Feb 2025
 12:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220085001.860-1-vulab@iscas.ac.cn>
In-Reply-To: <20250220085001.860-1-vulab@iscas.ac.cn>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Feb 2025 21:23:47 +0100
X-Gm-Features: AQ5f1JrSbsBZYhsgrUajyxaLegYWak-pVEINzJX3bUZh51BhE0XwC_gtDg2DUjQ
Message-ID: <CACRpkdZShkMhO9vTvdbyEzkGLL2+mfnLmADGukNZ-Xw=NNxksQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik: Add error handling for find_nmk_gpio_from_pin
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wentao,

thanks for your patch!

On Thu, Feb 20, 2025 at 9:51=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:

> When find_nmk_gpio_from_pin fails to find a valid GPIO chip
> for the given pin, the bit variable remains uninitialized. This
> uninitialized value is then passed to __nmk_gpio_set_mode,
> leading to undefined behavior and undesired address access.
>
> To fix this, add error handling to check the return value of
> find_nmk_gpio_from_pin. Log an error message indicating an
> invalid pin offset and return -EINVAL immediately  If the function
> fails.
>
> Fixes: 75d270fda64d ("gpio: nomadik: request dynamic ID allocation")
> Cc: stable@vger.kernel.org # 6.9+

Unnecessary to tag for stable. It is not causing regressions.
Skip this and apply for nonurgent fixes.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

