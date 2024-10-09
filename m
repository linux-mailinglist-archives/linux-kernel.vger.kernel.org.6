Return-Path: <linux-kernel+bounces-357766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35B19975AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608311F21716
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D188D17B500;
	Wed,  9 Oct 2024 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e6VTFTLV"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9B92629D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728501987; cv=none; b=dBAY5xsenKhunFHqOPlSDXRQNsR5Kp68qMcSoVAumXHB48LMiQiRANlA/HqO3qBa0Px892zcyyj4UaIiBukAwqC0X4vygZKpzCl+O8F5y/FsTu8qwMOMIkEU9oFS1fb2O5VJsUEJaTrfw8JtrSqiqrcY8FbXB+UGcdwPJXO85kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728501987; c=relaxed/simple;
	bh=WxM0u1hWHtkX8ID15NMMg+fj6ssSR73d3rVkb8KBW3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzPmAuuAtjvtdNdSrL4w7dU+HxqIKSjvYxGdoxDZJz1mU7J5fxic+VKRczxSzXJQitGyssv+XArzU2kShyOzkEgyhCJ+bl9oitHXh84on0odheAeITE/b8r4v+eUvd8TcpRStZQme2uhLqL579ilZG88t64o4LgezM2UHHQgiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e6VTFTLV; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fada911953so10986171fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728501981; x=1729106781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjIpdl/AkSCnHF7e7wPpjQ8L0ujomC2Snr7f1Hg2VCc=;
        b=e6VTFTLVIhNuuvph0xpFuMXo5XoqKWwZynEYiAXDER+Vobp9DCx65TorIcSGd7T/Oo
         Q87LZQ0aQrOoZIMRDMHTkRwdmMDB5VYC4WGlwvBoc6lVnTDOrobeUY7hcVUuFXyiV7mo
         xWje7NAI4buF4CCQry0KZ+NVfPuuPvdxDfDGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728501981; x=1729106781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjIpdl/AkSCnHF7e7wPpjQ8L0ujomC2Snr7f1Hg2VCc=;
        b=OyuAnxKk0eYs2G3zChFfDrDFeN0Uf8nbSjoCIzrUriBysK7gOqLPsprrc0KlxsdLgp
         IIYGeAM5Uy0FyqWSPuKHP+mWKO9hP0xOImmFamFvqC6SpimPsx3rlS/R/KTxQfXoLFx/
         RIsCXsYZevlbOmNrs6S75pOBhGDY0e1BZEPwiW14UFtQai3QxoSUQFM9yFFqfoNzOzBo
         aHZFTPCIWcOeWf3Qc/9ONQvcTpxrfUAZcdizgvE+ikZ26v07Yk4YyMZFsot9xqDCagg8
         ltIGR+O9yNKW2zVgbHuiaKTUUED5p0S3GW2Y0Gmfc+Li4cc2wLua8u0bluGDN2x3AYHN
         4O4g==
X-Forwarded-Encrypted: i=1; AJvYcCX/g3q9t4jvrI2yDjWitSfqcZaN4nc1hsx5rxyax4rQUGoQX58SWJG4HxRSrx37wQtlk3DROz9ymjhIuHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUGh7qnEp+XIo6khFB0SuqreuODGVgeSKsQRTSJjQT04ywaqeX
	Zj7OdIBCFbIVxynR6qX788PpnL301uU0QsgfaGDnRG6lQM96Ow5YQL7XxCxnoFyfaFD0tiQTkE5
	Gfg==
X-Google-Smtp-Source: AGHT+IEbCOKpXDKyPdXvnCTwHRjcsxxoyj0PYMhOaTsPxkaCOnVEjUNzQ86rVHj7g+2zc3Vi/ozHRQ==
X-Received: by 2002:a05:6512:39ca:b0:536:7a79:b4df with SMTP id 2adb3069b0e04-539c9882f60mr246847e87.14.1728501980969;
        Wed, 09 Oct 2024 12:26:20 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d28dsm1573884e87.154.2024.10.09.12.26.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 12:26:20 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5389fbb28f3so150304e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 12:26:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVambCNeJofoQbLQKcyikKVZYc/+CIr0W2i7GX+JCLUcn/yR4cKARmN/58CqEHfj2ZbZWYYT3Afij33byo=@vger.kernel.org
X-Received: by 2002:a05:6512:b9b:b0:52e:fa08:f0f5 with SMTP id
 2adb3069b0e04-539c9882c02mr270875e87.13.1728501978929; Wed, 09 Oct 2024
 12:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073014.16411-1-alex.vinarskis@gmail.com>
In-Reply-To: <20241008073014.16411-1-alex.vinarskis@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 9 Oct 2024 12:26:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wu3vaY4Rtw4OZwgAf_b44JpDsKJhUa-EXiuu1hn3aJoQ@mail.gmail.com>
Message-ID: <CAD=FV=Wu3vaY4Rtw4OZwgAf_b44JpDsKJhUa-EXiuu1hn3aJoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm/edp-panel: Add panels used by Dell XPS 13 9345
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bryan.Kemp@dell.com, tudor.laurentiu.oss@gmail.com, peterdekraker@umito.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 8, 2024 at 12:30=E2=80=AFAM Aleksandrs Vinarskis
<alex.vinarskis@gmail.com> wrote:
>
> Introduce low-res IPS and OLED panels for mentioned device.
>
> SHP panel's timings were picked experimentally, without this patch or wit=
h
> `delay_200_500_e50` panel sometimes fails to boot/stays black on startup.
>
> LGD panel's timings were copied from other LGD panels and tested to be
> working.
>
> Particular laptop also comes in high-res IPS variant, which unfortunately
> I do not have access to verify.
>
> The raw edid for SHP panel is:
>
> 00 ff ff ff ff ff ff 00 4d 10 93 15 00 00 00 00
> 2c 21 01 04 a5 1d 12 78 07 ee 95 a3 54 4c 99 26
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 f0 7b 80 90 70 b0 52 45 30 20
> 36 00 20 b4 10 00 00 18 00 00 00 fd 00 1e 78 9a
> 9a 20 01 0a 20 20 20 20 20 20 00 00 00 fe 00 4b
> 4a 46 47 52 80 4c 51 31 33 34 4e 31 00 00 00 00
> 00 02 41 0c 32 00 01 00 00 0b 41 0a 20 20 01 ef
>
> 70 20 79 02 00 20 00 13 8c 52 19 93 15 00 00 00
> 00 2c 17 07 4c 51 31 33 34 4e 31 21 00 1d 40 0b
> 08 07 80 07 b0 04 88 3d 8a 54 cd a4 99 66 62 0f
> 02 45 54 d0 5f d0 5f 00 34 12 78 26 00 09 02 00
> 00 00 00 00 01 00 00 22 00 14 5e d7 04 05 7f 07
> 8f 00 2f 00 1f 00 af 04 50 00 02 00 05 00 25 01
> 09 5e d7 04 5e d7 04 1e 78 80 81 00 0b e3 05 80
> 00 e6 06 01 01 6a 6a 39 00 00 00 00 00 00 ce 90
>
> The raw edid for LGD panel is:
>
> 00 ff ff ff ff ff ff 00 30 e4 78 07 00 00 00 00
> 00 22 01 04 b5 1d 12 78 06 96 65 b0 4f 3c b9 23
> 0b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ef 83 40 a0 b0 08 34 70 30 20
> 36 00 20 b4 10 00 00 1a 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 fe 00 44
> 48 39 50 57 80 31 33 34 57 54 31 0a 00 00 00 00
> 00 04 04 03 28 00 01 00 00 2b 01 0a 20 20 01 d4
>
> 70 20 79 02 00 20 00 13 3c e6 24 78 07 00 00 00
> 00 00 18 07 31 33 34 57 54 31 0a 21 00 1d 41 0b
> 08 07 40 0b 08 07 88 06 6b 4f c3 a3 b9 35 82 0b
> 02 45 54 40 5e 1a 60 18 10 23 78 26 00 09 04 00
> 00 00 00 00 41 00 00 22 00 14 55 27 05 85 3f 0b
> 9f 00 2f 80 1f 00 07 07 33 00 02 00 05 00 25 01
> 09 55 27 05 55 27 05 3c 3c 00 81 00 0b e3 05 80
> 00 e6 06 05 01 6d 60 02 00 00 00 00 00 00 31 90
>
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)

Pushed to drm-misc-next:

[1/1] drm/edp-panel: Add panels used by Dell XPS 13 9345
      commit: 6b3815c6815f07acc7eeffa8ae734d1a1c0ee817

-Doug

