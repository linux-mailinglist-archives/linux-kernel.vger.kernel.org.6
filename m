Return-Path: <linux-kernel+bounces-220867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F48890E862
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E351C22054
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7728112EBE8;
	Wed, 19 Jun 2024 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UOUoSeBB"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758585285
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793320; cv=none; b=hfAHMzLdL11jXoldStMhO/IIZxlq2QSScwHMXUICBWdhN+/6kfnhLD3qaOznSaEt0cjXwcYv/G+22cnVxSFuxB4WdXRmn4o7QrdHscnsZUONA14aiC1Ev49xgcfqwmvX19MQofKt/Z+JhESxhmHSmNoNx5wj7541xaNhybAB+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793320; c=relaxed/simple;
	bh=0GKpp7Tj8rmrANzPpFFyYQDQk5Nc6/mSbfS5ot7teh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhNQ3VqdVEacTif6Cz8sFWZyRyTyLNGbPQeloxbqd5Dewx0d7PCP6fNmUPKRbKO9Tmnd6ER4xQHwV2nCSgrUAodjz6zRTcrS+bWT8YUlE9u8lTHisRQ4b1IjatHZG3yu+TDo5cAxoDoHWUJqTXwKxVbAbKF6VUZXF4F7shjO2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UOUoSeBB; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48d75899a88so2060398137.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718793318; x=1719398118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQeGra2iBmmyFMexo3SqyeNsqV++ufvz/AJLf19SFYk=;
        b=UOUoSeBBkgBEqKJIEChXJ6Qnd2NBxfhw2uJecO4kBuWd7QPvH/chpP8HxLYXOeuVid
         VEYPcMKCCxufwPspiBV+gqiJA5l1CyHdjvPWZIly4BUaZ6UG9lR0MpOvsPtwGyZnB1r5
         jxHXWqo+CBTScDjwV8PBFyKXCZbIoxYxRg3go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718793318; x=1719398118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQeGra2iBmmyFMexo3SqyeNsqV++ufvz/AJLf19SFYk=;
        b=uDysyvXDq0eK+3u0BNaIXBbxCiD9yDH9Iu8xxQke2OwcIDcP9H6hGhz9Tjy+3515Zx
         6RyLDbGnFHrCMCBiOipE/A26mY1UYvB9WedUQxXa2JvSJJauNlZLDZ2UZjtTazG7xm4O
         pYCLRc8BlPcwvLBn5xmBgyTzdGdEjTM7tk34MjSpcrnIaou72gtD4W9Z/jTuAKimTmxg
         aIxIQsO98eQq8R48k0LthauCG3ZNKBb3Od7pAE9h5P/xlFNi/DOQY+KQ5v7BA65yHoc7
         sr3bhmiZwouYcwGgH3TNMRMBhpQKnD/CWjf8Ij1AjFarTG23C96CUY1l4ACjLrRG+ao0
         nmJg==
X-Forwarded-Encrypted: i=1; AJvYcCXeLZnGh1d1IvNrbUcYrOdVLAwY5Msxb6OPpLizt5ovB7XqvvHP0SO98GjG1EtJisvjEXKvZTyaEM4YLCjHnGKVZkF/gbVs/Y+uLEvT
X-Gm-Message-State: AOJu0Yw/EjIZqaSJ10/QZwEVTVynzEcYH1ndbuP7ijp7gRdDRyztuGZ8
	6lgpF9Y1bD1XFYi6TeXMZ70xm2TU6bCmlTnglGJhFMehPkwngf997Z9exS1czIT9aLqEek1cpZM
	=
X-Google-Smtp-Source: AGHT+IEZqJXfAyxxRpWG7q0ZHdry1TiKm+aMMN4yAio20QinMhBC2rf/vxZEDnlT6jamfzYrisuBGg==
X-Received: by 2002:a05:6102:1887:b0:48d:89e2:8ff6 with SMTP id ada2fe7eead31-48f130ade13mr2294093137.23.1718793318038;
        Wed, 19 Jun 2024 03:35:18 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48da4483626sm2621080137.21.2024.06.19.03.35.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 03:35:17 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48d75899a88so2060389137.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:35:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcnx6hqTqTUkNfd2pxrSjnEf65YSziYAd9w+4iEp+SC2YSK1rJQtS/Dm/nu/8Ny1YqGnSsvCQ30+cBZEdBVjIlz7s6bqo25HyY8Spg
X-Received: by 2002:a05:6102:2926:b0:48f:19b5:2685 with SMTP id
 ada2fe7eead31-48f19b52895mr915741137.26.1718793317187; Wed, 19 Jun 2024
 03:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619103034.110377-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240619103034.110377-1-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 19 Jun 2024 18:34:41 +0800
X-Gmail-Original-Message-ID: <CAC=S1nikgOVAqwHDEv5yQAQAKT4pBDwcC3zCduwf64nwtATY7Q@mail.gmail.com>
Message-ID: <CAC=S1nikgOVAqwHDEv5yQAQAKT4pBDwcC3zCduwf64nwtATY7Q@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: mtk-mutex: Add MDP_TCC0 mod to MT8188
 mutex table
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 6:30=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> MT8188's MDP3 is able to use MDP_TCC0, this mutex_mod bit does
> actually exist and it's the same as MT8195: add it to the table.
>
> Fixes: 26bb17dae6fa ("soc: mediatek: mtk-mutex: Add support for MT8188 VP=
PSYS")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  drivers/soc/mediatek/mtk-mutex.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-=
mutex.c
> index b5af1fb5847e..01b129caf1eb 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -524,6 +524,7 @@ static const unsigned int mt8188_mdp_mutex_table_mod[=
MUTEX_MOD_IDX_MAX] =3D {
>         [MUTEX_MOD_IDX_MDP_PAD0] =3D MT8195_MUTEX_MOD_MDP_PAD0,
>         [MUTEX_MOD_IDX_MDP_PAD2] =3D MT8195_MUTEX_MOD_MDP_PAD2,
>         [MUTEX_MOD_IDX_MDP_PAD3] =3D MT8195_MUTEX_MOD_MDP_PAD3,
> +       [MUTEX_MOD_IDX_MDP_TCC0] =3D MT8195_MUTEX_MOD_MDP_TCC0,
>         [MUTEX_MOD_IDX_MDP_WROT0] =3D MT8195_MUTEX_MOD_MDP_WROT0,
>         [MUTEX_MOD_IDX_MDP_WROT2] =3D MT8195_MUTEX_MOD_MDP_WROT2,
>         [MUTEX_MOD_IDX_MDP_WROT3] =3D MT8195_MUTEX_MOD_MDP_WROT3,
> --
> 2.45.2
>

