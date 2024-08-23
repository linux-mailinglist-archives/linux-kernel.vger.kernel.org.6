Return-Path: <linux-kernel+bounces-298331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F74D95C5DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F28B0B233D8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40861311AC;
	Fri, 23 Aug 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l5eBf03t"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA3B7D401
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396079; cv=none; b=MbCVDjmDG/m+Jz8RaMdoZKOwwoEsb58AGmGlQ/UAOQigI3mpmdcFo98wi9UAL5GS59STOQYw4YZsCJMKqv5ZKMlvYd8YzzNtOGbj0JALs4172wOjKXTe/4n4atfhB/Pd41TZxcqWUXcgQRYJA3WJ80AnJWSDxNpJvqWghcZT76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396079; c=relaxed/simple;
	bh=b7cBKZ3aiovvpcnd82a//jTwAitemyJStikYa58pHQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUojXmqsXutpbQGFSDgjHuEj1OoxHFliSGP52ROJtW0ZfJr/f40i+veNd4bEnH/+TuL0H+a1pxZrhxxk/ZQHs+z/kbUT0aRKjfANUf/z+aL7VoST2cp28IIUOOSmvx9A1bqyFI5ZUoSb7O5SIi18+DDSXUOMaSYgrWsLuzzLPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l5eBf03t; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53343bf5eddso2144550e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 23:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724396075; x=1725000875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYlhEmPtRTYor0AL9cAnJrQT3p974t5Lzi77Eaz87M4=;
        b=l5eBf03t+B4cTIRsh4zABzzWRLDgy3hvAaTLEIP21MEzxih/MD35FQo9jgF50fyTxk
         NvQ6/9qIQ7gyiKo6gISOSe00cTslOpOzhxwnt2FUzpRIuhZRNAl/AresT6e4vF/ZZuvR
         UC4ecLuUDRqIcPfkTlrU3Zjx9UGLBs69lk8x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724396075; x=1725000875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYlhEmPtRTYor0AL9cAnJrQT3p974t5Lzi77Eaz87M4=;
        b=rGpTKGsPRWMT7275va0QWcI2s/gBYxyCZa+N/O870lICTVBEpRVmziDEiPi1HN9vhA
         a5BY5+7MicWSrWtBZ61qz/OzqDk6yc5shQtbFg4ZWzKJJsyU3j37PhE+XQQbmDkQJ+Dg
         yTaoJVVjq7T8jaNUztexVJ/7cHsrHGrZhipv3XyLNqmqcFm2N/co2SO/dbSWBmyucsyd
         3ZsSmyVCRjEymzK1j/Gw2H/R2ky9V6NE2cNfAdyozhczLm+l01ygUw9zKGmocBziG4Cl
         Jyql4AEPbKfk+FC1tyoqmQfujiSZZ8ErgMl2/ikC184LaJQoBUDYHes50TT4Ifc9Aq+Y
         rRjg==
X-Forwarded-Encrypted: i=1; AJvYcCU35qoIJMqanQHwDxJEy91Lo5o56hzBQoUWW0cwebr71MlHroNQqbvJxnsUBfHRGWQKsLVuhnZkxaQwO8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIToNsaWOZ+xMQeS3CqleWtIvSmUhiDge8io4Bi4YpauBTWHS
	zbEGptrbGHLd5JTOtJlErn5AWHUEkD3u68zbfk/rwXSh29EgWUKoBtrjTozxHXLHcgXDYZXYCSy
	m9v4ABBxH8m+MhvRLR87EQWuZG18roUmS0PYj
X-Google-Smtp-Source: AGHT+IGDC0WWTfFgI9QnQzvX49/NewGmGwj3Cz1KMtz32yMSQX3nF9dwL9fql5Pr3fEZyw3lnpJjTa3uuZm7Vkpw1m4=
X-Received: by 2002:a05:6512:3b82:b0:52f:154:661b with SMTP id
 2adb3069b0e04-534387681c5mr853124e87.11.1724396075319; Thu, 22 Aug 2024
 23:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822092006.3134096-1-wenst@chromium.org> <20240822092006.3134096-4-wenst@chromium.org>
 <ZsdB1vsEe0atW88_@smile.fi.intel.com>
In-Reply-To: <ZsdB1vsEe0atW88_@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 23 Aug 2024 14:54:24 +0800
Message-ID: <CAGXv+5Ew1tQKmuKckovfHCgH-ja0qSmqJWOk2qowQC4k_1tvYQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] regulator: Split up _regulator_get()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 9:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 22, 2024 at 05:19:56PM +0800, Chen-Yu Tsai wrote:
> > _regulator_get() contains a lot of common code doing checks prior to th=
e
> > regulator lookup and housekeeping work after the lookup. Almost all the
> > code could be shared with a OF-specific variant of _regulator_get().
> >
> > Split out the common parts so that they can be reused. The OF-specific
> > version of _regulator_get() will be added in a subsequent patch.
> > No functional changes were made.
>
> > +/**
> > + * _regulator_get_common - Common code for regulator requests
> > + * @rdev: regulator device pointer as returned by *regulator_dev_looku=
p()
> > + *       Its reference count is expected to have been incremented.
> > + * @dev: device used for dev_printk messages
> > + * @id: Supply name or regulator ID
> > + * @get_type: enum regulator_get_type value corresponding to type of r=
equest
> > + *
> > + * Returns a struct regulator corresponding to @rdev,
> > + * or IS_ERR() condition containing errno.
> > + *
> > + * This function should be chained with *regulator_dev_lookup() functi=
ons.
>
> kernel-doc will warn here: No "Return" section.

Will fix.

ChenYu

> > + */
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

