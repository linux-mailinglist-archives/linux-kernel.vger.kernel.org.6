Return-Path: <linux-kernel+bounces-552152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB855A57644
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D0A3AE6C9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1123C20C024;
	Fri,  7 Mar 2025 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWLTMjg+"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0020208990
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390717; cv=none; b=uQRsmpYtJuVrxOHowr0KhwApCDxpqfg6R8ffkPCaoIzLzH72Qut1CkxmGfffyFFTzGSk5hxWgkpliZ0XfhZFOJ55siLik2d95hbQs633IKflcBePe2ZvSqf3i/gbvNHk/BVb5pemWw8csPtxG5jT5jyD/xIiRQ/23T910n+nICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390717; c=relaxed/simple;
	bh=FvTrwsvRrqcU8r3STXAD/abJZn6ARPfm75ImG2CAES0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TegopwRgAg7RfCG7UAMLi9/OARcGsk7K4vijdxxW4gtFhur+luuDvoQ7mf42LQxnFj3iHpbSIlIkJcNzMjabA3S+APGHLh1KJ27nWWd+cPlRynqFaCbZQ8rzu9/JbHaLz9xL4JoaGSop7qqmDO4LE5pHrcvaScnJFE5wY0Je9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bWLTMjg+; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e53a91756e5so1957316276.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 15:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741390713; x=1741995513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VWjXUhpo2fKrXU1j0gY5Xr67XtHa6Daou9ianeTAqY8=;
        b=bWLTMjg+w9EYiB9xWAKPqZC3lc/fuwKyPrzbCpnhXhByH3eAmJXmX2r1Qgo+CC3aNW
         EUpQ4UJRnKYR/FzUqKUlPA+k/DUbryKyU24xx48mEdt23u0D/+YEwkUsUkGKLiTnVMyP
         OLcwY1LPrU3/67Jx0dRXn/FFzybVkvb31z+y2wnTzYQP+VT4l7Ya/OD0dtyHwZnTlV1A
         R4Q9TQ9NBO2PaaeHRDK4tg4ADtNSBl+kL/gUG9zGWviGfIzPsoYlU/zDPZaRHHCkjEam
         KCIhOURk86iReVpSdi+rTmPdZxVoHMmf6uZcOXy7X0BVXn9dP1mWwyUCj5Bs99zQqLME
         vUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390713; x=1741995513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWjXUhpo2fKrXU1j0gY5Xr67XtHa6Daou9ianeTAqY8=;
        b=Gd34Oc0oyKzcLFqIJmWxybzrkurBqswVyH87b/diX3qvPsdWIUNgVakSCRL/goniQN
         a9pTFUSo8mKAQSwqP6J1Gp0GPWqnGB9YNS7dDuVwIKWEpBfIuhCO09GegU44Pu2kY38p
         Hnsej8hoiVtEtvUerEZgwKTKkbOTkEmrB7oKLOVbYyVDhsX/f9e8qWBUruDZ/amkd7aY
         Vt15oMkGFsAeK2yMI2taGgFu4x6wnitfVGXhfeuyeH+oqkjxJ5r63ZpPyDOk0/kD1ZAx
         JfVdfxcTT0Qd/6Y95qNP9SP3K9HxWHEffpp7Eop5jfx4Zc+07ig0INsIciMhDkoomKGl
         c27w==
X-Forwarded-Encrypted: i=1; AJvYcCWSRo9/n0WvLmbo9YPdle5Mw7Ex73TgG9F1RAJ0NL7SX5et4pgEV3+LBgPCV2KfeBKt2Lu3dxQxgDynI9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHwXRnOLqdF6dm+OuHxukEvOhJ+kq4i4irlBZwJGV6sktFPhE
	Sx+PpHYzcoHv8+H515y2jV5rqVLJiybGBKevObUN4O4hSP/jShweELYi+EO+o0133Uv22nWKoNn
	+ztovxFFoP2cDXEauz2ZkvpldzYYSj94u9RhibPwoAZNE2onZwDQ=
X-Gm-Gg: ASbGnctIdYO+wyva2z3+W/lZSO0w+9x6wI5prFA22gcKwmv3DsV7CPNnxrAK6TC1fr6
	3koqTSVamCDvVf9DdyLBAKLyTQqeTtzBDk5e9KsWFhH7ZsewZDft5Cgfaj9n9HrYKFF0qo0vwt4
	Tc+HVOqC2T0Fbi8Vd4a8lygob7
X-Google-Smtp-Source: AGHT+IH7YGl7HNKB8Okz8jZeL1FHEiS1Q1w9EOtWnahWll8xohjVD4FnIQlNwfvzCh1K3mKRlv103YdKVoGu9WyWWyk=
X-Received: by 2002:a05:6902:cc7:b0:e20:25bb:7893 with SMTP id
 3f1490d57ef6-e635c1dccfcmr6795032276.46.1741390713262; Fri, 07 Mar 2025
 15:38:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org> <20250307175724.15068-13-srinivas.kandagatla@linaro.org>
In-Reply-To: <20250307175724.15068-13-srinivas.kandagatla@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 8 Mar 2025 00:38:21 +0100
X-Gm-Features: AQ5f1JqJKThblUEswZ3lN2Qkaev9eo1SwByk6PqJy3hET9Fq3mSSJOOUuYqdG8w
Message-ID: <CAA8EJppTfafU_RMjG2V9FbrpAviTcGhDZ9F2ZJJtNR08Ap5h7Q@mail.gmail.com>
Subject: Re: [PATCH 12/14] nvmem: make the misaligned raw_len non-fatal
To: srinivas.kandagatla@linaro.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 18:58, <srinivas.kandagatla@linaro.org> wrote:
>
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> The commit 11ccaa312111 ("nvmem: core: verify cell's raw_len") enforced
> the raw read len being aligned to the NVMEM's word_size. However this
> change broke some of the platforms, because those used misaligned
> reads. Make this error non-fatal for the drivers that didn't specify
> raw_len directly and just increase the raw_len making it aligned.
>
> Fixes: 11ccaa312111 ("nvmem: core: verify cell's raw_len")

This patch does only make sense together with your tree, because it
references a commit from that tree.
As you are reposting them for Greg, commit IDs will change. It might
be easier to fold this patch into the offending commit.

> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/Z7Xv9lNc6ckJVtKc@finisterre.sirena.org.uk/
> Tested-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index b6f8544fd966..e206efc29a00 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -612,7 +612,11 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
>                         "cell %s raw len %zd unaligned to nvmem word size %d\n",
>                         cell->name ?: "<unknown>", cell->raw_len,
>                         nvmem->word_size);
> -               return -EINVAL;
> +
> +               if (info->raw_len)
> +                       return -EINVAL;
> +
> +               cell->raw_len = ALIGN(cell->raw_len, nvmem->word_size);
>         }
>
>         return 0;
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

