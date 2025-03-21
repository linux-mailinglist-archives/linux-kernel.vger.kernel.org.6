Return-Path: <linux-kernel+bounces-571315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E05A6BB9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DB71889A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBE722B595;
	Fri, 21 Mar 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6XEfBcl"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124821D018
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742563101; cv=none; b=hGAlGqFe22ZKLwK+jdtrY3aKgpUJOjqWUS14KH/JL1/H3K/wtXtwu7dUvE9i+jhx0mvKxjG8wBuk3ngfHhSWvI9CMam6mHLx8NwP4Y78oVf7fMlZ2s5WimKhYJ2crovS1ddYOsv+oOFv/t+I7ALJf5p6Z+ztO7nLP/2u0bvALRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742563101; c=relaxed/simple;
	bh=qhn+xjMFqkpgVXd/gGKXrLJA+on3nH269BUFV63qNX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbFPkihHyorY8H557Zg2YXxfX7ELZYW6f2dWqojlyHMOZ/t7Q/5XT2g+GnSkugINDcU8+oJiX5Yn3jzTU/5h1Hx+zoW41+s9IMlvDrG1GM9BbuI73K/dTFV+X5Z+Zjl9PEuN0jUECrr4z93Vf1XjxdLLFyoQMN9Bh4wqJ09YZ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6XEfBcl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3914a5def6bso1197258f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742563098; x=1743167898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+rQ/uLtoCWpxjTuAN+2Y3qiqUz2qFf5Mzl6INCePog=;
        b=c6XEfBcl0LZGlC6I9nJ0cJ4UMQwDWz1am6g38sd11nNZZfLC95LT88U+/D/F+F4otX
         w0bwro4/x7NLFW3y37EhQVefkcVR3b4d8uZDUzPpi4+J6JOHkDOg1zSrK1B/lvXMg4SO
         yQNG6ZW64+fLKdcAJtUNPjcTds+Cajdm1QJb6W/wYYNryfH5DFhxNl2q76Ke4ubFIJHE
         9SHulghVS5bllsGFTGezzAxuSWALfYgKbl/WsGmEMubp2629lnAeVhDJaltDQULXT1h8
         BfwfE8J9LIa+bjzszL0O9GKzEZEwobNs2I6R+sB1TixsFxV4picsZiHqFX+hp84Rj8Ic
         9g9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742563098; x=1743167898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+rQ/uLtoCWpxjTuAN+2Y3qiqUz2qFf5Mzl6INCePog=;
        b=Q0wRPlxx/2MrpQqqKsEZgOd9dUGsPF8HvFlbj3mPcpTVMcKphxU9d41G5ofYiusO1l
         bQHn5Xvehf4K4lg2AzNbI/z/p1uefmyQKKbA/lhyg42HNAvnvSk7I1i5/ESOn18Kb5C9
         bLUCZjrCIvxk9cDf+bw09o7B/2PNXAW8iiCy2sOn59wXKI2Uwm6qGHa8WM758Lf16I8K
         J/ZmtBenMSXwawZfwBbt97rdIpdI7NELynHN4orWG419K7Dy58armm865qgiugWrzutW
         YZGTHcK5TyUsL3Ah4/sXdZ9mDRNTaX5OaJrp1feEfb+scxliMwUoL6m5C4Z6kBUa79nP
         PiDA==
X-Forwarded-Encrypted: i=1; AJvYcCXQhKuFYeOq36e1FNDLSuUoxCVa8xvhL4kPiJZbzgI6A7NjCiUtEnrgmkVfuFTw+3/RQVSMjP2nid9yMkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUrSXFupU6dfGa1iLF+1LvBph6XZHWFYL3ej0feziWNe2WUjAi
	EsldHFf8Umz+xekinRAqg8dxlHKsxBGYYejAmjJ9Vygofk/dRRB9SP9fTw==
X-Gm-Gg: ASbGncsQ4TsxXouffYFdq16BGOXreB7VaLcfSv7L6gi2aiNEK7hQsSVbcexpKtqBG93
	DG6M8ME4ttW/YTtvxGAYkYsN51D49tiGRpUiCKvwNLU6bVAHT94hfiOXCysneriZb5UY64rlnnn
	GEv1NZhOeli0+zQ+KG7e1t7uvrFlDpQG52E24qiag5fInLdxIYzPCvv7O4y5z01/gp0HDo9wlII
	3VHgqYqlf1vutwr0k0uMesZJmSrZL2fYXdspeUawh0VXmZDXDV87my/83zhH6F5BfH468XpNYNV
	036bOe64PnLFiyzQIwswtL0bqByxhEoa4vTEqmFiv9gldgNZelwzjNB+HwHqyK53RoL7e/N9lyU
	721twQ+g=
X-Google-Smtp-Source: AGHT+IHDYrW/+lg4Mpx155LtUc0CnTofZLJpcq7SarSWKJhUy7tG1wqAMobal99ODVbM7IjLt2E6vw==
X-Received: by 2002:a05:6000:1445:b0:390:e655:f998 with SMTP id ffacd0b85a97d-3997f909fa6mr2720244f8f.26.1742563097833;
        Fri, 21 Mar 2025 06:18:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b5193sm2406841f8f.55.2025.03.21.06.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:18:17 -0700 (PDT)
Date: Fri, 21 Mar 2025 13:18:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre
 <npitre@baylibre.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] math64: Provide an uprounding variant of
 mul_u64_u64_div_u64()
Message-ID: <20250321131813.6a332944@pumpkin>
In-Reply-To: <20250319171426.175460-2-u.kleine-koenig@baylibre.com>
References: <20250319171426.175460-2-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Mar 2025 18:14:25 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> This is needed (at least) in the pwm-stm32 driver. Currently the
> pwm-stm32 driver implements this function itself. This private
> implementation can be dropped as a followup of this patch.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  include/linux/math64.h |  1 +
>  lib/math/div64.c       | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/include/linux/math64.h b/include/linux/math64.h
> index 6aaccc1626ab..0c545b3ddaa5 100644
> --- a/include/linux/math64.h
> +++ b/include/linux/math64.h
> @@ -283,6 +283,7 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32=
 divisor)
>  #endif /* mul_u64_u32_div */
> =20
>  u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
> +u64 mul_u64_u64_div_u64_roundup(u64 a, u64 mul, u64 div);
> =20
>  /**
>   * DIV64_U64_ROUND_UP - unsigned 64bit divide with 64bit divisor rounded=
 up
> diff --git a/lib/math/div64.c b/lib/math/div64.c
> index 5faa29208bdb..66beb669992d 100644
> --- a/lib/math/div64.c
> +++ b/lib/math/div64.c
> @@ -267,3 +267,18 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
>  }
>  EXPORT_SYMBOL(mul_u64_u64_div_u64);
>  #endif
> +
> +#ifndef mul_u64_u64_div_u64_roundup
> +u64 mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c)
> +{
> +	u64 res =3D mul_u64_u64_div_u64(a, b, c);
> +	/* Those multiplications might overflow but it doesn't matter */
> +	u64 rem =3D a * b - c * res;
> +
> +	if (rem)
> +		res +=3D 1;

Ugg...
	return (((unsigned __int128_t)a * b) + (c - 1)) / c;
nearly works (on 64bit) but needs a u64 div_128_64()

	David


> +
> +	return res;
> +}
> +EXPORT_SYMBOL(mul_u64_u64_div_u64_roundup);
> +#endif
>=20
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b


