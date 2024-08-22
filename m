Return-Path: <linux-kernel+bounces-296312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D8D95A8F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50671F23C16
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E39E6FC5;
	Thu, 22 Aug 2024 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjnKmf6r"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8699A1D12E0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286960; cv=none; b=GW2XzShQRc0cHOhKSZWZq5L9I2kHaqmTyWSuA7p70yHrnqwD8+Gkg1b5IU79gt27BAN4Nr02bdIADZt2UY2yKmkxcmtAe4OLqCiVTXfRiEojTyR7L51WV6pehGC4w+rVuID6Ytl+JETIcCws6tMYFxqPhNCWB81A8cueJ2CIJtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286960; c=relaxed/simple;
	bh=5MhG4H5fiBM7tHVKwlGcSJFdOHF6L+Ner2aE272rbRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcBVtcSSyAdZ+VzuuKffTc+6BXySshTmS5+r7Gp23oKLFLlMUfUukNPmWIMm3RRULc5RiPgRUU6tMpp4H2izSZMCZG5nQjnbDtTLN56c4OR4S5XKBEtYL/sHg9vhL/r9j5uUICjDlFRlVYxdyV7VaIzMu08Oa5amGFKE2qe7dm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjnKmf6r; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf9ddfc2dcso903226d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286956; x=1724891756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22zWPOj1TpYR/jHva6dX8P4bxYu0jWvouDXLuCxJapI=;
        b=SjnKmf6rloqR3uqIwF3C5Z+yeRM8Goj/TSSCCtBS34ucwfzIvxvKgNoSrFqcqypb16
         hsQr+lKtyN2fWKTdQ4pgwjXxqJflEptFIPe1EATbfB8oGgIzOS8wiF3xac9VXW7cCo6r
         QgKYSzizf/asALm6ttDpC39hgJUzVhR6zRc4ugpuScURpqdtq9Oya4eDgeC6tfuejmPc
         mXy1A1Wcfd04eSYA/DWEDzixpRALxEiMDgmFvRjfc9UpDMiWLlls+QRcX7lmZf4rP/3y
         Pg6QAxJXTkFIxMKPscvenSIsCEfolFJdyAeL6kSNS1tozVy3pYOlDjInpT79PaQI04zU
         nn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286956; x=1724891756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22zWPOj1TpYR/jHva6dX8P4bxYu0jWvouDXLuCxJapI=;
        b=wSHL6r0qHoA02nz9a8L5wUQcw6zYnu37KCo8NR7unu5vkBfkEeQ5EWPmlFV7fFkOPx
         YXs52ffdFzQqy2u5apsVDB6Zugjhh/QATD5lgllwYSysyAsOQgSSTgqm3kiCH1dWBU+F
         lTnrsZVqD8kCCyucqP7dUXeW+kuR1NkxGH9acFrPA73hrHv6wSlHJuAtibkgmd6W488s
         7+CbR7m3QylggJtW87pIMTVZU1SKoUazTDhXQaO7hVlcp8ta8ZvcE40d1SnfT6WLfHU4
         xfgY1aiMj0pupoyY8H97E7ReOD85rzAief64gVNXE+cCOU7k9n9MQSR0TNlvAEC2CgyW
         kJcA==
X-Forwarded-Encrypted: i=1; AJvYcCUWk5FX0yJFgg2ggQWZj1THLwCIml5aMiu9nYwCV5Q/RNPSNB9vtyzCG8zRUKS7v5Clr+rB8so5w6/I9N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqlCeLgF+NsPAyCLWWP06Fr+f9NFteBrAu6mLtdGM/Xqf1rLsY
	O8kM6Z1ZSOCqrTzmTpP1keZ1MmD3PM5EsgAngTq4rXOsWczPLz9kuBDZOIME+dyzzuM+4yocf6p
	+RxLrQc4jGfEjHv8hKY/jHNWe4ng=
X-Google-Smtp-Source: AGHT+IFA7v3PE7COTekEBnadVG/BYIOlP9BEhcpwuRDzMHbYs2DiX9GTE7X59ozXJ7MpVRg4cwF21rX4O6OpKBulwMg=
X-Received: by 2002:a05:6214:4520:b0:6b7:ae86:e33e with SMTP id
 6a1803df08f44-6c155e09dfdmr34354096d6.37.1724286956259; Wed, 21 Aug 2024
 17:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820125840.9032-1-rongqianfeng@vivo.com>
In-Reply-To: <20240820125840.9032-1-rongqianfeng@vivo.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 22 Aug 2024 10:35:45 +1000
Message-ID: <CAGRGNgXn94ZPROLN4JButpnc+ffFFr1SwtTFM=bvcPH95DFQgQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: Use devm_clk_get_enabled() helpers
To: Rong Qianfeng <rongqianfeng@vivo.com>
Cc: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rong,

On Tue, Aug 20, 2024 at 10:59=E2=80=AFPM Rong Qianfeng <rongqianfeng@vivo.c=
om> wrote:
>
> Replace devm_clk_get() and clk_prepare_enable() with
> devm_clk_get_enabled() that also disables and unprepares it on
> driver detach.
>
> Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
> ---
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 13 +++----------
>  drivers/gpu/drm/sun4i/sun6i_drc.c         | 15 ++++-----------
>  drivers/gpu/drm/sun4i/sun8i_mixer.c       | 13 +++----------
>  3 files changed, 10 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_drc.c b/drivers/gpu/drm/sun4i/su=
n6i_drc.c
> index 0d342f43fa93..f263ad282828 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_drc.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_drc.c
> @@ -42,33 +42,28 @@ static int sun6i_drc_bind(struct device *dev, struct =
device *master,
>                 return ret;
>         }
>
> -       drc->bus_clk =3D devm_clk_get(dev, "ahb");
> +       drc->bus_clk =3D devm_clk_get_enabled(dev, "ahb");
>         if (IS_ERR(drc->bus_clk)) {
>                 dev_err(dev, "Couldn't get our bus clock\n");
>                 ret =3D PTR_ERR(drc->bus_clk);
>                 goto err_assert_reset;
>         }
> -       clk_prepare_enable(drc->bus_clk);
>
> -       drc->mod_clk =3D devm_clk_get(dev, "mod");
> +       drc->mod_clk =3D devm_clk_get_enabled(dev, "mod");
>         if (IS_ERR(drc->mod_clk)) {
>                 dev_err(dev, "Couldn't get our mod clock\n");
>                 ret =3D PTR_ERR(drc->mod_clk);
> -               goto err_disable_bus_clk;
> +               goto err_assert_reset;
>         }
>
>         ret =3D clk_set_rate_exclusive(drc->mod_clk, 300000000);
>         if (ret) {
>                 dev_err(dev, "Couldn't set the module clock frequency\n")=
;
> -               goto err_disable_bus_clk;
> +               goto err_assert_reset;
>         }
>
> -       clk_prepare_enable(drc->mod_clk);

Am I reading this right: is this changing the init sequence so that
the clock is enabled before setting a rate?

This is the sort of thing that might cause glitches and issues in some
hardware, so it'd be polite to test such a change on the actual
hardware before posting it.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

