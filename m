Return-Path: <linux-kernel+bounces-256217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01048934AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808D61F21471
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A4281737;
	Thu, 18 Jul 2024 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="banip5eg"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF628172A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294894; cv=none; b=AzG+GD3VbibKAZWRa5J9vbahBYyaAx+J5amAXEFI1sVc4Xy/jDkjWsd0c0ssplnNiL+ICiJc+btLAByuTGGp0CLBhbA+6aPLYHD+pJaTZPZte/LWhostAUoO3F16wKcC7k5xryTDpOEKbuj8uc6Fht/7xULDoqvupXJiJkzvlWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294894; c=relaxed/simple;
	bh=SHjvs2OcUJuk5DCQOHH5lk9zzR3fbK6RRXo4DL3QsKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xtestbig7bHtACDw1BrLBe2/XSVAWgDmOca/saOBO5LRv86Ww+xv79yp3UDRuXUUFHyn1Y9yJpGq8I0feGrih5E8FvGjmrNPgoTvD5xFRH0RVMxnJ5ENNgSKxbzqNcX8Yz0GFTQeDau8dSa0ktShAl6LWoX+XRJt7GAvr2CiIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=banip5eg; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8100ff1cec5so240023241.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721294892; x=1721899692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIVo0OQ1EsBJVsYCtM25PmcXBbJ96Ax/6H8Xf2sBrfU=;
        b=banip5eguaO6LOyw/ILjt9swIKu5BIAlCh3WH/jmDlQxZLCoBm+HrhAjI44blWk59l
         a2jKtYPvIvIu8RHG2vJIrbHftOMm9JvVfV0lz4KemBkGdIuQyzcXWMc/ifTgKdAA4EbQ
         WAITxCnAnP05w2FWZmI4OKeXVUFYGcTY0P/ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721294892; x=1721899692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIVo0OQ1EsBJVsYCtM25PmcXBbJ96Ax/6H8Xf2sBrfU=;
        b=VtlPx8wjIarB+R00X7Ef9EhUyF/AGlLuLYYfRWFYqt224DZT5cO5qod80llTeAliqa
         4TFOp0v4fGiwL1DsYCFpAcxQhId2MaiYYc2a9EYrlNOD79/gHerZ+crqHGayDPO/qJuY
         6qhvM3IcKY3oKfXXdfsIBuUNM1Iwr3qzeMObE8jfp3dqk50V37+KoQR4ydeGzdN3xdBa
         4a/s2hpGYvhjNhCQPm+QBzjUNtmb5zvODDlGdXOk+SEg2uWmmVkEkrpaU+u3Ccxk2aC2
         gSeSpZPNe43THbVVjtHnP7P5mCUDJBudL+UVw504kmzUi/E01p+SPEp9YLwygk2Wntxs
         eVgA==
X-Forwarded-Encrypted: i=1; AJvYcCVNtWO4Vwj4TLyIqN5IpvNQzF5z/UR/sVdHRPlQlFtG687Q04rOd5FxWmXaq7HrPpq4MLNEfckIfwWrujnx1Yp7Yh6Y020UBcjk6yPU
X-Gm-Message-State: AOJu0YyCv/j0mV+CVkWp0co2MJY1x60MhKVaSKBKJAAU7jLjAuxnLPej
	Wy/PkqdvkCNFuscPEOqSrltSr29IxjYzbKHUfwyaOgeZh4Hyi4/q41XMeMENczcVFGTS10aOkuh
	sMA==
X-Google-Smtp-Source: AGHT+IEOZOvY4ejawMs1l2l3efW4vssF7+G9PwV1DG6xM3jsjwZEG/2AOQDguOwVIMFe6ZABeNoNig==
X-Received: by 2002:a05:6102:3312:b0:48f:a7a6:bacb with SMTP id ada2fe7eead31-491597aa5b1mr5690301137.12.1721294891939;
        Thu, 18 Jul 2024 02:28:11 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-822c8ac43b9sm128696241.25.2024.07.18.02.28.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 02:28:11 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4f2f24f6470so244322e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:28:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRovVjGlQZK7ShINg0NQq1JHNHxG+8IJtru3QYvt6PyabSVmsrYDm8UgiR6tE6Vi2g/yBzHRp+yUBqs1ukB0vAFUkr/wUHJHd7gRgU
X-Received: by 2002:a05:6122:3684:b0:4ec:fc9b:a0bc with SMTP id
 71dfb90a1353d-4f4df688191mr5774468e0c.4.1721294891079; Thu, 18 Jul 2024
 02:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718082410.204459-1-angelogioacchino.delregno@collabora.com> <CAGXv+5GBg73kWuiDt=9s7M4oJeHhWOF3bPY7Ju+qn1kJgNNaGw@mail.gmail.com>
In-Reply-To: <CAGXv+5GBg73kWuiDt=9s7M4oJeHhWOF3bPY7Ju+qn1kJgNNaGw@mail.gmail.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 18 Jul 2024 17:27:33 +0800
X-Gmail-Original-Message-ID: <CAC=S1nigoJWAECBrm-Q=Co1-qd_yUhx3R4D9=dYeUV=gr5UYfQ@mail.gmail.com>
Message-ID: <CAC=S1nigoJWAECBrm-Q=Co1-qd_yUhx3R4D9=dYeUV=gr5UYfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Set sensible cursor width/height values to
 fix crash
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org, 
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch, 
	matthias.bgg@gmail.com, shawn.sung@mediatek.com, ck.hu@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 4:49=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> (CC-ed Fei Shao)
>
> On Thu, Jul 18, 2024 at 4:24=E2=80=AFPM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Hardware-speaking, there is no feature-reduced cursor specific
> > plane, so this driver reserves the last all Overlay plane as a
> > Cursor plane, but sets the maximum cursor width/height to the
> > maximum value that the full overlay plane can use.
> >
> > While this could be ok, it raises issues with common userspace
> > using libdrm (especially Mutter, but other compositors too) which
> > will crash upon performing allocations and/or using said cursor
> > plane.
> >
> > Reduce the maximum width/height for the cursor to 512x512 pixels,
> > value taken from IGT's maximum cursor size test, which succeeds.
> >
> > Fixes: a4c9410b31ca ("drm/mediatek: Set DRM mode configs accordingly")
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_drv.c
> > index 6f0b415a978d..b96763664c4f 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -540,8 +540,8 @@ static int mtk_drm_kms_init(struct drm_device *drm)
> >         }
> >
> >         /* IGT will check if the cursor size is configured */
> > -       drm->mode_config.cursor_width =3D drm->mode_config.max_width;
> > -       drm->mode_config.cursor_height =3D drm->mode_config.max_height;
> > +       drm->mode_config.cursor_width =3D 512;
> > +       drm->mode_config.cursor_height =3D 512;
>
> Fei already did the same (?) workaround downstream just recently.

Well, so another userspace gets confused...
I actually sent a separate userspace (i.e. Chrome) fix where I
encountered the issue, so I didn't proceed with upstreaming it in the
end.

This matches my preference in [1], so of course I'd like to see it
merged... if maintainers are okay with it.
Given I've tested the exact same change before:
Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>

[1]: https://lore.kernel.org/all/CAC=3DS1nhKPo5BUYJ_cHGz3OoPrWNh5eO8rhdyikL=
imsqSOrZ5Xg@mail.gmail.com/

Regards,
Fei
>
> OOTH, Intel recently added a feature for enumerating "suggested"
> cursor sizes. See https://patchwork.freedesktop.org/patch/583299/
>
> Not sure if other compositors will end up using it or not.
>
> ChenYu
>
> >         /* Use OVL device for all DMA memory allocations */
> >         crtc =3D drm_crtc_from_index(drm, 0);
> > --
> > 2.45.2
> >

