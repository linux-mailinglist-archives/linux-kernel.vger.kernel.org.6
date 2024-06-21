Return-Path: <linux-kernel+bounces-223859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C70F911973
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDD99B2337A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E2B12DDAE;
	Fri, 21 Jun 2024 04:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nRuQQoaY"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4F12D752
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718944134; cv=none; b=J8/0+jBEPTaRpnkclCc8A9nqf97vkCLH4fQ48kNbR2M03+plaOxPQuAOXImj3o8eglrqKAnWwG1RxFUUEFB4rVe8UmhJiJ/itdKtkg7ny2iThAE7fK5sr64NeOYeOwHwAxq7oUMjixl3F3qzUXqYGV7BLvwxgNh77++GMXMz6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718944134; c=relaxed/simple;
	bh=r24Mof+yDkcvpkTRAhB62yPXxPblkb1zcabB4O7cMgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qk6mQjMr+ieg+8j6Io7JBA5eb4fp45oI6L+zjByhxXVXk4Y2OYGDfJCi9SK5vDjvmJlppaZqKdod2mdrpMXf2VbEWTqE4XKVZIGpwVCViEjh4hUXL6Z7b2LvIvHHWorZ0uFiYXQ2IQ9U7kCWTmmUZyYe/mVehfyrwoy5TPx3j6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nRuQQoaY; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe3bac6c6so18985681fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718944131; x=1719548931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0N5ODF55WzW9N7tClV+NF8WnSJ/yPUFLrnRCDn0qcY=;
        b=nRuQQoaYihEaFh5o9FjImqn9hh9wqrgB9lIMAI+KpdM3Qj5Wiq8cKmBkhmBe/nvsew
         PfbwrT4GjdR7PnPkoN8ibyJXES13ALH7u5Z2qzW6pLPkoBgKwcam0WNPP5CykBpXPh//
         FrS0sK1rimhkssGEOQ4ZZl81IIAQr+n6+r9rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718944131; x=1719548931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0N5ODF55WzW9N7tClV+NF8WnSJ/yPUFLrnRCDn0qcY=;
        b=gtaKDO0+nw59WbATns2EkvcspQ2eIkt404RsoP8fx3G4Af417q6XZAfiAy+4kOfK8t
         EjAhaCDL8dHvVwwZwh6B+EBkCc/d38qp0wkwzFUcgTxl2TUwDf7hvOYzHiYVOqj/O0/l
         Huu/OBo9zdHXPWGPG5gUium9hF701o+YVKDpDSRWEhT2hdNBuIXK6apLxB0NXknxFNSe
         Y3r7t+tUDMagwGedipAEa9lknAhXfyg9XOOuGNCYdboYHlyt59Nj8AjEKSPbhrfVd4P5
         rJlpjdlST+VB+yzhS51hlZ8oZ9NV7Rr5VFO5japygWDdik68kHOnEfUsj7WYrzaZ/LGy
         /vSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfgoJbhgmAp7I68Ktx0V3pQcFLpR5XWhYKMbpWzj7/vLyJdAjip4JxxKYzFw1U6j4/OMCj0I7poKRs1ILZ/x9A0IK/szZi9SK24nQd
X-Gm-Message-State: AOJu0Yw2m3d1nlBLsGKnzKJja7/uxzLcLtJsjY5HoLebPO0XXAPnEm1n
	bO1gUZ90QCNkUz1d1GwzeQsdsg1IMsZzEJBJfSqWmcscArlcgf4WZPPNBhaUdK+wEejJRcrQdto
	D1W795pXRzf71AqAO+48b+Uwsvujq707/1ssu
X-Google-Smtp-Source: AGHT+IEf221TRxxyD3Vt2YLv8hui8dqvwFIA+f2DRplnWv7/sZLD6TNo+ipCUSe/K76y0e7FExk9GfCSbD6ljigHWP0=
X-Received: by 2002:a2e:980e:0:b0:2ec:4f41:514 with SMTP id
 38308e7fff4ca-2ec4f410623mr3647731fa.23.1718944130818; Thu, 20 Jun 2024
 21:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620092526.2353537-1-wenst@chromium.org> <35047932-65d0-44ae-98e1-b4c771be0e6b@collabora.com>
In-Reply-To: <35047932-65d0-44ae-98e1-b4c771be0e6b@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 21 Jun 2024 12:28:38 +0800
Message-ID: <CAGXv+5EGqGB=Bb-YxY1eCPg216FyVHT7Xs_Zoe2EBMKuRmZMow@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: Re-add codec entry for
 ETDM1_OUT_BE dai link
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 6:27=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 20/06/24 11:25, Chen-Yu Tsai ha scritto:
> > This partially reverts commit e70b8dd26711704b1ff1f1b4eb3d048ba69e29da.
> >
> > Said commit removes the codec entry for the ETDM1_OUT_BE dai link for
> > some reason. This does not have the intended effect, as the remaining
> > DAILINK_COMP_ARRAY(COMP_EMPTY()) platform entry becomes the codec
> > entry, and the platform entry is completely gone.
> >
> > This causes in a KASAN out-of-bounds warning in mtk_soundcard_common_pr=
obe()
> > in sound/soc/mediatek/common/mtk-soundcard-driver.c:
> >
> >       for_each_card_prelinks(card, i, dai_link) {
> >               if (adsp_node && !strncmp(dai_link->name, "AFE_SOF", strl=
en("AFE_SOF")))
> >                       dai_link->platforms->of_node =3D adsp_node;
> >               else if (!dai_link->platforms->name && !dai_link->platfor=
ms->of_node)
> >                       dai_link->platforms->of_node =3D platform_node;
> >       }
> >
> > where the code expects the platforms array to have space for at least o=
ne entry.
> >
> > Re-add the entry so that dai_link->platforms has space.
> >
>
> Ok, but wait a minute... the commit that you're pointing at in the Fixes =
tag is
> a commit that fixes a problem identified in commit
>
> 13f58267cda3 ("ASoC: soc.h: don't create dummy Component via COMP_DUMMY()=
")
>
> to keep it short, after that one, without removing the COMP_DUMMY(), the =
audio
> was broken in .. some way, I don't currently remember specifically what w=
as
> happening, but I had no sound at all.

Right. But this adds back "COMP_EMPTY()", not COMP_DUMMY().

I guess I shouldn't say this is a partial revert.

After painstakingly messing with the mixer controls, I tested all three
audio paths (speaker, headphone, DP) and they all work correctly.

I'll send a v2 updating the commit message.

ChenYu

> If the problem is not showing up anymore, backporting this commit to the =
kernels
> kernels affected by the issue that I solved... will break sound!
>
> So... well.. that's the "some reason".... :-)
>
> Cheers,
> Angelo
>
> > Fixes: e70b8dd26711 ("ASoC: mediatek: mt8195: Remove afe-dai component =
and rework codec link")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   sound/soc/mediatek/mt8195/mt8195-mt6359.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/medi=
atek/mt8195/mt8195-mt6359.c
> > index ca8751190520..2832ef78eaed 100644
> > --- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> > +++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> > @@ -827,6 +827,7 @@ SND_SOC_DAILINK_DEFS(ETDM2_IN_BE,
> >
> >   SND_SOC_DAILINK_DEFS(ETDM1_OUT_BE,
> >                    DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_OUT")),
> > +                  DAILINK_COMP_ARRAY(COMP_EMPTY()),
> >                    DAILINK_COMP_ARRAY(COMP_EMPTY()));
> >
> >   SND_SOC_DAILINK_DEFS(ETDM2_OUT_BE,
>

