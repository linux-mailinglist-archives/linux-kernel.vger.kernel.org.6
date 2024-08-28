Return-Path: <linux-kernel+bounces-304574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC5F9621FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFADB1C217EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B8B15AD83;
	Wed, 28 Aug 2024 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U8Oh6Zzd"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C579A156967
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724832127; cv=none; b=P+U8V9R+L9pSmpon3DbeLeTBSVj3/wCxfBMUdAdvruJZVR0zm+kXltM3jGtdUoKXGzCbbY7eyNWh/ZZi4SCHt69SFCyOwZWFWJbNY9w1AXdgoZuPK7S3Aj+6Ljd5hQEI2ne89DSVgynydOPPYmOkeKRTVplDNJb6DvvHjyHokWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724832127; c=relaxed/simple;
	bh=1mz8bqNTIm1qXkLbbeebBoTk5tfRQUd2hgoZE269ImA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzaLvT2s2qcAo9yQz2y+AQdn1el541Wxt8sDFpsObHrAZv6iI6dPGZDnmpEx7p8tcmlu/gYQNi0ZHtx4KlYXjWcza+ypMUpzZdseMy4eRHkY4hQxMQ31uSC/FevrmXYbFdP8oAgI148X6pq+vwfQNEkw7uJRp/T07EPO14xdWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U8Oh6Zzd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-533488ffaebso7773952e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724832124; x=1725436924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01bm2P6+731mngCRCF/JfvHoUKzqZt9p7MdIfKaUmJs=;
        b=U8Oh6ZzdsasWZMNARrQ3cN61p3pOqMS791LwrNzdSKDAPzTXJwg9RUU9rXzDHcoKNB
         TsJDu2q1rJtGoTim9vZ12EFyyju9CmrY7nWezvnJ34sUu61CK5p2+kyCIn2r4muBKhX8
         Mtp4BCbeSNHZ57q0RDM4/9/jkhMKQXxUPfD4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724832124; x=1725436924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01bm2P6+731mngCRCF/JfvHoUKzqZt9p7MdIfKaUmJs=;
        b=PlVW6RSvrLsNC9CZv0rcAwFPzDgR+80gxwrsg+m+JlULTFA16NKum2CFHKRJLOj0Wk
         ngZni3WVoV+AaO/nrpgiS9PvPO8SjjFa8H5iv+sfSMOrGrXqJk1yrkeg/k4uQiAAsf86
         uopGiMAXFpTUMSbJ/9LJCOoLIrjYeo8RYTNcSfSOsqb9lbHndt27HYgwX9pFgy14MGTl
         48zkENk7bGBIB4FB4JH7CeRA69aB9A8sNYb6PPjy9+FAXiAETE9GFoBscjSWl7oZV/PV
         hhTF3HWJKc4r/hUvySQUiKySeY16UMKiqEtA7I5yX4j0Wh5Gh+mKjAUL0xRiZDF+0WwE
         WPIg==
X-Forwarded-Encrypted: i=1; AJvYcCUBbboLHj6qDzPRdLq+KJlSs8mrBL+bXK+/FkyHBSNAysMKTuyx1/lVRcj15uCJIk6pKisyODBC3hQLbOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYWX+FsQUZlmhAVJl54hlSqMLust/XBKPPT9uS8ZI6l9E4f59
	3rXHf51d0GUruGUi/RUn+FUsOGgm/5Ap2kQ4sdsO5G7VHt6d63sKJ8igZb6GYLjETO7ycSRm89s
	GACQobQSuz9NHFOT3WnyN7JSl/MVBrRiqQOlo
X-Google-Smtp-Source: AGHT+IFXo0zOkBdn+kFinlSkacR8vXUIGdTl4USmJWWiFSCdUMUpYjFIi2ec/HByzYW8zJIm/fjNOD+8GLpw13/FrEQ=
X-Received: by 2002:a05:6512:3a8a:b0:52c:e00c:d3a9 with SMTP id
 2adb3069b0e04-5343875578fmr9346605e87.1.1724832123413; Wed, 28 Aug 2024
 01:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827095550.675018-1-wenst@chromium.org> <20240827095550.675018-4-wenst@chromium.org>
 <Zs3lt_0GGXAbsRPn@smile.fi.intel.com>
In-Reply-To: <Zs3lt_0GGXAbsRPn@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 28 Aug 2024 16:01:52 +0800
Message-ID: <CAGXv+5Gv9Hkwdb9G65HHFfOkX=_LGm1xVTkQpiDDw64LkevVnw@mail.gmail.com>
Subject: Re: [PATCH 3/8] regulator: core: Fix incorrectly formatted kerneldoc
 "Return" sections
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 27, 2024 at 05:55:43PM +0800, Chen-Yu Tsai wrote:
> > kernel-doc complains about missing "Return" section for many documented
> > functions in the regulator core. Many of them actually have description=
s
> > about the return values, just not in the format kernel-doc wants.
> >
> > Convert these to use the proper "Return:" section header. The existing
> > descriptions have been reworded and moved around to fit the grammar and
> > formatting.
> >
> > In a few cases where the functions don't call even more functions
> > and the error numbers are known, those are documented in detail.
>
> ...
>
> > + * Return: pointer the &struct device_node corresponding to the regula=
tor if found,
>
> "pointer to the"
> Same elsewhere.

Ack.

> > + *      or %NULL if not found.
>
> ...
>
> > + * Return: pointer to a &struct regulator corresponding to the regulat=
or
> > + *      producer, or ERR_PTR() encoded negative error number.
>
> (I'm not sure of definite vs. indefinite article, though. Perhaps you nee=
d to
> consult with native speaker.)

I think "a" makes more sense, because in the case of _regulator_get(),
the |struct regulator| consumer instances are allocated separately on
the fly for each call.

> ...
>
> > + *      producer, or ERR_PTR() encoded negative error number.
>
> Okay, maybe "negative error number" to be used everywhere (see previous e=
mail),
> the main point is a) to make it clear that it's negative, and b) be consi=
stent
> with a term across the subsystem.

Ack.


Thanks
ChenYu

