Return-Path: <linux-kernel+bounces-405867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1F9C584C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F182840CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653997082E;
	Tue, 12 Nov 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qn9Z+O8g"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57627080F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415841; cv=none; b=VOfZ7GIAzy2BaMg1YH78+rAYDsC2RraH7qC7vehYeZnTtRg3+vHrfrLRuKOKD1hG5vfE8PR4McGn3JMk9osjQ6ZeehARp9GeWJ41pkCu3q4IE6wgpyjcqqb1is56dwst3HafjcPqUU7zzUium6lbtMojqY3meilMdlVO2m4Ctvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415841; c=relaxed/simple;
	bh=GeBVO2GdRfYXq00Svo2kHoFq/10dwtalChSI8IIjQwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOc0UPKLk+Dcn5mLyb0FkGSvKEIhsTcXYUYs+ngo3AG+00IpSckQu3l9WUAhifsvtvcudg18Xt9DXhy1UEYD2v2SXNIXF0XIcEHz0uFxNiQWt+zfnBc/GPMhbxZL9p5ti+Ix3f9TYvbQ9m7eb/ovfXqAtC3GtHNTounHe8fLD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qn9Z+O8g; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso6155664e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731415838; x=1732020638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeBVO2GdRfYXq00Svo2kHoFq/10dwtalChSI8IIjQwk=;
        b=qn9Z+O8gIjogLFV6vYK8dzmjtdvbEY6SOthap/weA5YfzvIYoWIAt8W8zO2gZpU0iJ
         cktCUDTKiVPVGyDxiRUhEeGUVGOOwxKPpcsgkMM1YaPnMMQsFzg6cFbvXqsIodI9FC6B
         R74Fmw0PVsqVVOzw+4j8iiJEZ8Q9g4ts1WXk/pLLL7bFrSGopNkCvnlwmJd8QyofEzxC
         MaHC94M3bvfIHI59l4sTcTYlLUknu4AhAd9qj9Juy3VS8NYE3WYCYPQUyy+wNwGW4VAl
         7BuA+1J2JB0UK+5OvlGDnetxxEeT8PBZ0pQVF/ooKW3wpAeWY1tKQxNgP4k86dTH4oJy
         invg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731415838; x=1732020638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeBVO2GdRfYXq00Svo2kHoFq/10dwtalChSI8IIjQwk=;
        b=AnwJX+gP9RfkebVtjWGWhqzhfJPCkTpk8qjKm/BDL+3RAJ8Jxi7YgMEek6Nxq4aFW8
         UZ8Az1mGkwvLN8c48ztzbSR1lRTXTifAj4featkQiW32VroBVq4kwo6r1xNn0/akRA8G
         uyy+awByExu1EZsfEwE2UnKPkw/BkBjC5U++zKhSvHU7peWhexFS6y/3LkWo7nWSwVI+
         nZ79vU/XVOXosE7ItnDFKd8BZ/LU0asplTPFGVKeoJt33NL06G5vVfFo0SY+7J7pBhYv
         zbk2xmTF8FrGZcAwx17/xtstZDHbCaily5Ypp9mzWZGMHEarcph34yFS8+Ddd7AaZ5sG
         gh0A==
X-Forwarded-Encrypted: i=1; AJvYcCWDwnPhl4iDpHALJNQzSqxiaUUdWhKg7eOYuxaOVs1FXaSkrDOcbW0FW7vZA+1gSJhGMHzrpW12dokTA5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCN4yZ1h7nJb7Hdwlb9IrF85wgLJ92/5BgiTawthNypiL6tWsF
	xydXClv7CUcG4OLmHGfIjRQBJKE/TpVyrbcdcHX+eSgvuh6UsDRgq/Me33iVRxtINA5dc/1aYz3
	bW5Pv9X/76KLAGcO4uOmGSXF3AKQ7LR1aMukUsQ==
X-Google-Smtp-Source: AGHT+IHO77pCoCjWkW3UGcaVkG+6FA9QyXrg8cZvhES5N7tCaKkkDgEAed2uIgWOEd1zU7CLBorSuTYdULgmPsy61b0=
X-Received: by 2002:a05:651c:2109:b0:2fb:6110:c5cb with SMTP id
 38308e7fff4ca-2ff202ac51cmr71186881fa.34.1731415837857; Tue, 12 Nov 2024
 04:50:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112015408.3139996-1-ye.zhang@rock-chips.com>
 <20241112015408.3139996-5-ye.zhang@rock-chips.com> <CAMRc=MfTmpLSEUVTXSu8jf9tyTfQc=iG9NpovFem-qSDOCnagQ@mail.gmail.com>
 <ZzMwh2GMP-bE7aLO@smile.fi.intel.com>
In-Reply-To: <ZzMwh2GMP-bE7aLO@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Nov 2024 13:50:26 +0100
Message-ID: <CAMRc=MePqsQatxNy7p5c3sE4z8RepjjLeFgpppKgEctCU3jAUw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] gpio: rockchip: Set input direction when request irq
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ye Zhang <ye.zhang@rock-chips.com>, linus.walleij@linaro.org, heiko@sntech.de, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mika.westerberg@linux.intel.com, tao.huang@rock-chips.com, 
	finley.xiao@rock-chips.com, tim.chen@rock-chips.com, 
	elaine.zhang@rock-chips.com, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 11:40=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 12, 2024 at 09:48:06AM +0100, Bartosz Golaszewski wrote:
> > On Tue, Nov 12, 2024 at 2:54=E2=80=AFAM Ye Zhang <ye.zhang@rock-chips.c=
om> wrote:
> > >
> > > Since the GPIO can only generate interrupts when its direction is set=
 to
> > > input, it is set to input before requesting the interrupt resources.
>
> ...
>
> > This looks like a fix to me, do you want it sent for stable? If so,
> > please add the Fixes tag and put it first in the series.
>
> Independently on the resolution on this, can the first three be applied t=
o
> for-next? I think they are valuable from the documentation perspective as
> it adds the explanation of the version register bit fields.
>
> The last one seems to me independent (code wise, meaning no potential
> conflicts) to the rest and may be applied to for-current later on.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

There's another issue I see with this patch. It effectively changes
the pin's direction behind the back of the GPIOLIB. If a GPIO is
requested, its direction set to output and another orthogonal user
requests the same pin as input, we'll never update the FLAG_IS_OUT
value and I don't think any subsequent behavior can be considered
defined.

I applied the first 3 patches as they look alright.

Bart

