Return-Path: <linux-kernel+bounces-230360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C673917BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B60ADB232F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A528416A92E;
	Wed, 26 Jun 2024 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MdI6eein"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9CD16849C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392868; cv=none; b=VQQpOCKxEj4Uvc1UKPgQKRXgkITRbq/KEOQxyxSV2wQ9f1ZUMky/raishIpbI68aWEqYzcGnVQTtC2bsDqEEv6I073N9ub5EXlqUAaFUwJskgwWAcAcxNlN8x1AywIeYqxqlDPin0YFh5qCkYXPay0tIGE/gyNdOLV96g+Kwub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392868; c=relaxed/simple;
	bh=ssH+6iURMN7zx64iT61gWIWA5rPqCh8kGeC+MevKIHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpVDtXl6d74AyS05M7FlcpHJZD8blgUVsURxdhmG8Kbbl3qyDVNyTWrS95gUuXjgHsJGXdDypTGygl47lp4KVJh+oFmVHJ3fpOoZ1VxTzGf90jmZ+6gkuAbrt/m6mfDj2I/9GrnF/3el+piI/mVl93D0TQqCYzE0744gBtYv3uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=MdI6eein; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d07f07a27so7441608a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1719392865; x=1719997665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lxJDkVp4n9+n100SOtMCWceyFBnjbdm10d/AO3Twck=;
        b=MdI6eeinTKb5wFX6TVzWmfAtKWgiJC6nutanQfCgFhYFzKwnKkL7v/3pJLsznjKfBJ
         iacqiS+EBV+oCwu8ShFQwZfNmgwB60BWrwndZfzDKYFY5o4b6vpMN73x9DHEzxH5rZpK
         2XZFmeEribEfd9fSqP7EcxjL5WLNYI/Xe55F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719392865; x=1719997665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lxJDkVp4n9+n100SOtMCWceyFBnjbdm10d/AO3Twck=;
        b=wUITvfIo1tobb7e3iHEHe5i4qbCmvHp4rJAUxlvRXBFcucA3xr54wL8cP83d5W+S4V
         Z+YWaWhNbu9zEPPPJFi6SE53wTENi7pJhGL6rxFHw+vRCJp4uRQAVJB6XTXocL3P8OdD
         6m2yA4OODP+PVOI1tiGE2M/JfNUBZJD9tstXueNsKoPN1M7Vrpu4xwonYebVFekxyMcd
         Cpj5Xts79HP1k5fzF/U8ZTbhVQIV9a9BSCjO0+JXTV7W9EI62zLvQuEV/9L3p+ecJMVp
         DtAdpxV//6fyx7qzKrr/WCRk8MhEXJYpm9b4R7Bj8r1qQlr316QfD8eu8wlC4ljGYbQY
         AzCg==
X-Forwarded-Encrypted: i=1; AJvYcCXpPuPegbuLPT0ry7aBhd8PZbs1MEncN3kg0oOH25kQA7hJl8gi/9+x8jj6YLBl2i08JlmGTb97Q4Db712itflVh4B66qjfUOiyZ1HY
X-Gm-Message-State: AOJu0YxZ+SdSm4sgBDGwh7ExtijjNfc3w68Mzu5Ln2BHGn0PSARvdKSR
	XcQaz04KXdvuXvvdeDjYgdp7Cewqyx0ImY0BYUm8Qt4Kso85iZwaMKJnLuSsxqhMLaRj4yX8pQI
	eLsVe3X7wKdE7ngHKMhU5cjTgwyUpHxobkbVBEA==
X-Google-Smtp-Source: AGHT+IHykAPt//reChktNIqv1b8u1tQWErhzQtFS2JSTQpUaKUXwg3goKPI4W/qQKafT4xUP3B30jIrlQPXEK6H9lgE=
X-Received: by 2002:a50:9350:0:b0:57d:24ce:cbc8 with SMTP id
 4fb4d7f45d1cf-57d4bdcedebmr6248778a12.31.1719392865433; Wed, 26 Jun 2024
 02:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626084515.2829595-1-make24@iscas.ac.cn> <AM6PR04MB594141B66F1DEB2354ADDF7B88D62@AM6PR04MB5941.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB594141B66F1DEB2354ADDF7B88D62@AM6PR04MB5941.eurprd04.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 26 Jun 2024 11:07:33 +0200
Message-ID: <CAOf5uwkrGGPrfAcHO_hDQEZMvBHZ5JR9B=7=COSJLGjQV307SQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: mxs-dma: Add check for dma_set_max_seg_size in mxs_dma_probe()
To: Peng Fan <peng.fan@nxp.com>
Cc: Ma Ke <make24@iscas.ac.cn>, "vkoul@kernel.org" <vkoul@kernel.org>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 26, 2024 at 11:02=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH] dmaengine: mxs-dma: Add check for
> > dma_set_max_seg_size in mxs_dma_probe()
>
> Please read
> https://lore.kernel.org/all/ZiocjS6tbeTt2mPD@matsya/
>
> Regards,
> Peng.
>
> >
> > As the possible failure of the dma_set_max_seg_size(), we should
> > better check the return value of the dma_set_max_seg_size().
> >
> > Fixes: a580b8c5429a ("dmaengine: mxs-dma: add dma support for
> > i.MX23/28")
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> > ---
> >  drivers/dma/mxs-dma.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c index
> > cfb9962417ef..90cbb9b04b02 100644
> > --- a/drivers/dma/mxs-dma.c
> > +++ b/drivers/dma/mxs-dma.c
> > @@ -798,7 +798,9 @@ static int mxs_dma_probe(struct
> > platform_device *pdev)
> >       mxs_dma->dma_device.dev =3D &pdev->dev;
> >
> >       /* mxs_dma gets 65535 bytes maximum sg size */
> > -     dma_set_max_seg_size(mxs_dma->dma_device.dev,
> > MAX_XFER_BYTES);
> > +     ret =3D dma_set_max_seg_size(mxs_dma->dma_device.dev,
> > MAX_XFER_BYTES);
> > +     if (ret)
> > +             return ret;
> >

If the function returns an error then you should check for it. If it's
not logical to have it, then you could
make void the function that is called and WARN_ON on an illogical situation

Michael

> >       mxs_dma->dma_device.device_alloc_chan_resources =3D
> > mxs_dma_alloc_chan_resources;
> >       mxs_dma->dma_device.device_free_chan_resources =3D
> > mxs_dma_free_chan_resources;
> > --
> > 2.25.1
> >
>
>

