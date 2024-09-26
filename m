Return-Path: <linux-kernel+bounces-340849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B4987876
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED47B2A361
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D080015C146;
	Thu, 26 Sep 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XS7pwpsz"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2811494AC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372217; cv=none; b=ANU34PhFn22hVDXUiMR5zZD3k6OqaRzm9y2Lf5HAvFAT5u95a87akQzzge4GIuQelQ6KatO0vjH2Sof8dt2y7Eds2Qd/73JJg2WRSZNf5HOeS/o7ZctEYSXXfyfw6rBkjB+TwuWquXzC5TawU3AeJypMUZoud5Ux/tjtfZqeJfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372217; c=relaxed/simple;
	bh=gZ/DZtOFtotCg2ZJqvPPQrBo5e4ZN34v/Lvt1y7BlBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnyRTAlBoQJr5ORgZJNqa19aVZzVNyw0X2obExUkg0/WBo0N4QDArjotUTdQMiCHQNfqHhID5hB8WdT8ZNexPl9T7eHYIWdD2bKZON3SyMvWtdjU15fMflVPyte9ZZ+w+fl/KFAxoV3ePFvA/ayumZUmsSRcfjopE/ASzcbji9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XS7pwpsz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso938856a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372215; x=1727977015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIlWLLARj2D0f2/wbtG4ZzKXxUsNafh4f+v/Gl8dtfg=;
        b=XS7pwpszqYs1PHx1dq8P9fnhIb9WTbdtMAw4aaj8JsEmE3XsAnTD+WDGtp92+di6YF
         Wm9m+LFEArJOQXamwJQGYP3Mt5rMz/MtlVhWmtWstJOUOwLEWmehsg9txB6A35NUrnJo
         wFG0Rl7a503nnSyuGozJq/MKlR+ClKOsrEpvzBuP9LyyCrXlwxfDnZbQv2Y0v7jzYJCr
         cWXVwuW6SXSfUodGbBuHX5dEJs54z1pV2JwcBKba/nGvjnl+HjadTWX4KDs6Dnii0J43
         U8tGz/cTKOFRasRzB58wKmd/DPoMX3CcxyuUfwbBqHvTeEeTUMrq+Jvh6rljBuUJictA
         GsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372215; x=1727977015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIlWLLARj2D0f2/wbtG4ZzKXxUsNafh4f+v/Gl8dtfg=;
        b=VvnvsBM8HjFmwz1UMwu3ZdMZufOBapNm1YeqTXf0KpLB0zcapVJd7h5qYk4T7Xv+X2
         jOECu3wH5jLjuVGIlBuRrTWz6mH4qTggn1ytHbGL0qhR+y/zWTk5Oghh5uujfvYQrSG3
         XoKsb+gRkuu0bAlhugcHXW/sm5tgcS6vbZY7mK0lao4dTqoSZ/8FmvYQ5gAFZU6bkjSX
         qzbv+Ns+x0EC0gxD4Xmo4gHzceESSz+UsuUpLxykbboyCSj8JOMd8s14m20iG85tK26R
         Hu+PFymsiEerlILXm44NZq6iIyLJcGLBEcDkseyaLT+RcNLUVH7HT3y3tIeuluL2vfbK
         mCnA==
X-Forwarded-Encrypted: i=1; AJvYcCUfX9hjOVMyUq2LPXyXHEoiB22GBYXmFRSs7zsPouWXNooF404GqBGxy478EIb3gCnpLp+N9TmqCuiXJTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuic3YQ9IJKvgxJ5dpS6rLd1ojsRo2ZqppX5UKukNoTNJ40REw
	7/MwqBuiOsaRnB1YGfZE/9EOImeAdNkMlow0jXRRRNNTWfVPKUSC9bq+QJqHvIbGBimnnWczlWk
	MMaEyWnUTVd8665WVp2HHlgmWKK79CVkQZzed
X-Google-Smtp-Source: AGHT+IFyoM14p1xkZjGDkib3ISbqBw/ob1Vg+aQY6MCOB0meJl2EfUTPQX5rZCw3U6NYwXQhw75iHjrBgwnKb1Dc4o4=
X-Received: by 2002:a05:6a20:c6c2:b0:1cf:1251:9a47 with SMTP id
 adf61e73a8af0-1d4fa78fd0amr609270637.31.1727372214561; Thu, 26 Sep 2024
 10:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925220552.149551-1-marex@denx.de> <a9967a8c-8e03-44c2-8f79-14c6dd5d74af@app.fastmail.com>
In-Reply-To: <a9967a8c-8e03-44c2-8f79-14c6dd5d74af@app.fastmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 26 Sep 2024 10:36:16 -0700
Message-ID: <CAGETcx8opbQ=+dBkSWwfCoqGsvUBftJm7VaGULZhC5DNyuktJQ@mail.gmail.com>
Subject: Re: [PATCH v2] soc: imx8m: Probe the SoC driver as platform driver
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marek Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org, 
	kernel@dh-electronics.com, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Fabio Estevam <festevam@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:28=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Wed, Sep 25, 2024, at 22:04, Marek Vasut wrote:
> > With driver_async_probe=3D* on kernel command line, the following trace=
 is
> > produced because on i.MX8M Plus hardware because the soc-imx8m.c driver
> > calls of_clk_get_by_name() which returns -EPROBE_DEFER because the cloc=
k
> > driver is not yet probed. This was not detected during regular testing
> > without driver_async_probe.
> >
> > Convert the SoC code to platform driver and instantiate a platform devi=
ce
> > in its current device_initcall() to probe the platform driver. Rework
> > .soc_revision callback to always return valid error code and return SoC
> > revision via parameter. This way, if anything in the .soc_revision call=
back
> > return -EPROBE_DEFER, it gets propagated to .probe and the .probe will =
get
> > retried later.
>
> Thanks for the new version, that was quick!
>
> > +static struct platform_driver imx8m_soc_driver =3D {
> > +     .probe =3D imx8m_soc_probe,
> > +     .driver =3D {
> > +             .name =3D "imx8m-soc",
> > +     },
> > +};
> > +module_platform_driver(imx8m_soc_driver);
> > +
> > +static int __init imx8_soc_init(void)
> > +{
> > +     struct platform_device *pdev;
> > +
> > +     pdev =3D platform_device_register_simple("imx8m-soc", -1, NULL, 0=
);
> > +
> > +     return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
> > +}
> >  device_initcall(imx8_soc_init);
>
> Did you run into problems with the method I suggested first?
>
> I don't like the way that this version still registers both the
> device and driver regardless of the hardware it runs on, I'd
> prefer to leave the platform check in the initcall and
> only register them if we are actually on an imx8 machine.
>
> Having two initcalls also makes it impossible to build this
> as a loadable module, which is why I suggested
> platform_create_bundle().

That particular helper doesn't seem to like probe deferral because it
allows for some of the code to be in init sections. So, it gets
dropped after module load is complete. So, Marek will still have to
register the device and driver separately. But I agree that it might
be better to NOT register the device and driver if the basic
conditions aren't met.

-Saravana

> I think you can keep the
> of_device_id lookup and pass the imx8_soc_data pointer
> as the platform_data to platform_create_bundle.
>
>     Arnd

