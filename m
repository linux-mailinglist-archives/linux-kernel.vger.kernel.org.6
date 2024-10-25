Return-Path: <linux-kernel+bounces-382145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AAA9B0A09
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E921C2130B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379D81865ED;
	Fri, 25 Oct 2024 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c1zRz6mA"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7D21A4D0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874144; cv=none; b=g6F6cd9he8LG2+7ismZjz3xmrnPdW/6KM6I/K8SDtMzMF6viVBn3EKQMrSdMn8iBnYgqHRaQc3M3BNqmk9DC8UZnD5LJBHRsdjK4yhf6s8J62+pkaMgcXV9g60uSqM/GrO8sEtUwjpjej2xqt2wNQQsUTVKkTkl2+bakYfC7wgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874144; c=relaxed/simple;
	bh=Oa66g0D/K8NQo8ZdHJStJsOpOeB/CdCkRH2Mn/ZHRgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uwgbla3vrBQZHduRjSwk7DZvKHusEswYn4CkROnaBP0DNXDUat7OiYK31Sxw6winOf8rl9NT84sLZQePxnA2jzRtQeAc1PIYaP+mbRvmtBmAA9L3+UL1pTCjcc2kyBbkuO5hhLkHT30YgJ9pr7oPL1B0gDGiTdybwLdsuVoYraE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c1zRz6mA; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53a007743e7so2793152e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729874139; x=1730478939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eq3fXe6qq3ix8jve6B/lCKB6fSeKNV8aFXZ8E3BzHv4=;
        b=c1zRz6mA2nsKnEGWv9kpze/tGPVjliDzjJAMWw6VAtkotl7eMod/eSffrwEPlnChal
         ieb64ltQzrr9q3MlbE5HeJEW6WHwcodmC7jwWa9EdAN1UKaK3nArVYWLFxG16kax6P0r
         d3eouSU73pBVC6jf+nngUZRX/KFaoXdfJcWP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729874139; x=1730478939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eq3fXe6qq3ix8jve6B/lCKB6fSeKNV8aFXZ8E3BzHv4=;
        b=qofVIxFzvwtDFqkA7QyUN+/6ljartm80tGPJQz0lUIdlEWzNSvaLvyJZOxlXiebihp
         LeIxtClj+UZpujux+53nIqDfiomeorVV7T22VBZog7IuvbkckKzgt8Z1f7WrLpTNP+lE
         EWUUJqbZEGzhyrqF8EBeuQ6vVGvfe2XmnZUlOK1BAGLT6VYn+UbZs9WwgeKzZLwxt1ka
         5kE5KnazpjmGiKvAYhpfytoyEcYr6BIuyMZIItq3224CR6JOgojTvDu2AQ+GI9JdvJjW
         eIkfglZs2D3nwT3rsJaoS3AJ/0pBP7mt7kpdkEbNtvTizkol2vhQv2myr2YrG5/HviKy
         +QSA==
X-Forwarded-Encrypted: i=1; AJvYcCXzCY4S9uH6xgS+XQ6i6O2AEb3LVm2kJzkoJdyig/Z3Keim2wqNd/ERq5XtnnndKbAeFSYDkOhI41L70Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcI/8z1X/sNMPfNcv7AXYpUg5l8YcvQ4RRJJUhhAWflLXvji0w
	k7OuQYB9pfwtnEU4heLN+uI8wW5jf4P+IzbQ44f73m54xnNVYPSyEgSuGrdvVdEP/W4IG20w5rc
	2bNNz
X-Google-Smtp-Source: AGHT+IEmbM4TFB/uC6ASuun7jMyBimv5VLMAZjLYZ5s53n4NOXjzSMSKotcJV2aYwBhN13ghyaRl4A==
X-Received: by 2002:a05:6512:3e25:b0:539:f06c:6f1d with SMTP id 2adb3069b0e04-53b1a3a786amr6701060e87.55.1729874138937;
        Fri, 25 Oct 2024 09:35:38 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a670sm231985e87.20.2024.10.25.09.35.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 09:35:37 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb3debdc09so19199751fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:35:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUI3D9w3V/3DPsEcb2sJdWBVxzt7bmm1yKAeUoUjtL69/cFaueOvPhSW2VttUJRLuUVpfY4P7h2t5Nn8II=@vger.kernel.org
X-Received: by 2002:a05:651c:2210:b0:2fa:beb5:11cc with SMTP id
 38308e7fff4ca-2fc9d582d71mr53240501fa.40.1729874137392; Fri, 25 Oct 2024
 09:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com> <20240620-igt-v3-8-a9d62d2e2c7e@mediatek.com>
 <CAD=FV=XTsPBQ7Qp_oQmBXkNY==KQWZdN7VYbuVPoBTHhMvzjUQ@mail.gmail.com> <b75276ff8dc2f73818ccd132530c0d3825e17888.camel@mediatek.com>
In-Reply-To: <b75276ff8dc2f73818ccd132530c0d3825e17888.camel@mediatek.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Oct 2024 09:35:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WSD9p61ePKXVOcUBGktRJkUx+KbiJXF-9QUtWE8zDt0A@mail.gmail.com>
Message-ID: <CAD=FV=WSD9p61ePKXVOcUBGktRJkUx+KbiJXF-9QUtWE8zDt0A@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation property
To: =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>, 
	=?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "djkurtz@chromium.org" <djkurtz@chromium.org>, 
	=?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>, 
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
	=?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>, 
	=?UTF-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen@mediatek.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "littlecvr@chromium.org" <littlecvr@chromium.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, "zwisler@chromium.org" <zwisler@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Thu, Oct 24, 2024 at 6:32=E2=80=AFPM Shawn Sung (=E5=AE=8B=E5=AD=9D=E8=
=AC=99)
<Shawn.Sung@mediatek.com> wrote:
>
> Hi Doug,
>
> On Thu, 2024-10-24 at 13:47 -0700, Doug Anderson wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  Hi,
> >
> > On Wed, Jun 19, 2024 at 9:39=E2=80=AFAM Hsiao Chien Sung via B4 Relay
> > <devnull+shawn.sung.mediatek.com@kernel.org> wrote:
> > >
> > > From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> > >
> > > Always add DRM_MODE_ROTATE_0 to rotation property to meet
> > > IGT's (Intel GPU Tools) requirement.
> > >
> > > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > > Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC
> > MT8173.")
> > > Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_ddp_comp.h |  6 +++++-
> > >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 17 +++++------------
> > >  drivers/gpu/drm/mediatek/mtk_plane.c    |  2 +-
> > >  3 files changed, 11 insertions(+), 14 deletions(-)
> >
> > FWIW, this patch got into ChromeOS's 5.15 branch via stable merge and
> > apparently broke things. As a short term fix we've reverted it there:
> >
> > https://crrev.com/c/5960799
>
> Thank you for reporting this issue. We are currently investigating the
> bug.
>
> Since I am unable to access the Google issue tracker [1], could you
> please provide more details about this bug? The message in the revert
> commit mentions "hana/sycamore360" (MT8173) and it appears that there
> is a rotation issue in tablet mode.

Thanks for the followup. I've only been peripherally involved in the
problem, but I can at least copy the relevant bits over.

It looks as if the problem is somehow only showing up when running
Android apps on those devices, so whatever the problem is it's subtle.
The report says that the apps work OK when the device is in tablet
mode and in one rotation but the problem shows up when rotated 90
degrees. The report says that "Screen content appears inverted". To me
it also sounds _possible_ that the problem is somewhere in our
userspace.

I think Hsin-Yi and Ross are continuing to dig a bit more. Maybe once
they've dug they can add any details they find or can loop in others
as it makes sense?


> > ...apparently the patch is fine on newer kernels so maybe there is a
> > missing dependency? Hopefully someone on this list can dig into this
> > and either post the revert to stable 5.15 kernels or suggest
> > additional backports.
> >
>
> There are known issues [2] regarding forward compatibility. Could you
> confirm whether this patch is unable to resolve the mentioned problem?
> Thanks.
>
> [1] https://issuetracker.google.com/issues/369688659
> [2]
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D896964

The patches in [2] look related to alpha blending but I think they are
seeing issues related to rotation. ...so I'm going to assume it's
different? I don't have this hardware in front of me, so I'm just
going by the report.

-Doug

