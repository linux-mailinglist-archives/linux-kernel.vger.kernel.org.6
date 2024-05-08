Return-Path: <linux-kernel+bounces-173618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857048C0301
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73861C21A40
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C88624A;
	Wed,  8 May 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tNopM4RS"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198204BA94
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188885; cv=none; b=L90HflqVaq+oLxI1V/qr8k4IGX6lQxEusjRzHUVyYqORlk1tqhmHGXmGl++684FJjIHmCk6sgyDbDT7Q4Ltyen+s7zKmcBd7nPUKkfkBQhrKzFZhomiH2aADYIq6OWcyaGDhy4S0rcPcUJz7wbIlLFDiH2oqQoqYDZScC8Uwqy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188885; c=relaxed/simple;
	bh=m7e9FA+/CGUD8recWszU9j2hn0vK1y2+HNyRsRo6tkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5rD0DiFX6izspzMHmmrAobilypdCdYFWgvFa2Ydl7NlBIGlMGLZViGjbqFeOm4Vqn66NJMwE6zHDZ8B2yrv3eYxSl3slMG5VrDxRRw813cPvgbqO61t9TB5jtFbxtqIv36NERcwtbJr6DbW6IpRVrbKKInxKQXvrYbAZH82ss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tNopM4RS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e0a34b2899so65659741fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715188881; x=1715793681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GndLXxg7LjkXPI0lTWLQipONPUywXcP78DbfL7UFwMA=;
        b=tNopM4RSEclATbqFfhVeOfD60dGsq4TpWdW/GkfDtnb/v113C8d3CbCGmWtiPgMoSl
         yhmp4fqSZXMva/7+Fmsr0vz+UjPxoiNsXlnSsn1LV36134yige56zIxzkk5TL4GOxmXB
         UENhFOQ9K1WIUdoVupz768N+3VSzqcRw8cy/AZctN8QWjPyb5FczXj7drRSkv+tEIkOX
         TgLUjNYF8ErlJS0JZMd3CvddAuFw5SJZ4CLu99KC4zMRiPTgdJnunQ+VGc9bzGhw33rO
         ixgY67ZuLidRjnAIzXRlBVhBDtiZROAYb/kFjn0YqT6XhGT4VfGITGgHnZ0MchcHFayC
         ToMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715188881; x=1715793681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GndLXxg7LjkXPI0lTWLQipONPUywXcP78DbfL7UFwMA=;
        b=rFGwRaS9Ut/hL+YJm7t93CAfvVTvDLuKAvbw6SNBTZRqT3QbjIMaAZdjBHeQGAxzbq
         05N569+X5xKO8azvUTUChN7agosSpSuVQM/jOAWHC7pEgyp56Fz3X0/nnGZFy06oqFCq
         v56SqT9INTEcQWnfC5o7irCFpvMo2HqjVxH+yOKrHaeNbxEJRIaW8UDNL28yfjbWlRgQ
         eUvLgC/m3e0IsRzJC+fs0bF6Yct2JlMIpVvaMsFOh3iV8nBdQEo2SB3ruJVBxzO4EvPj
         Mcg/4CfmkM9dU23Jz6ChYkM9jwTqtZ+iVmfWsTogYyL9exYRXNdUDSLmeHiqsjoFZ3UV
         6d9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZVRfOxq+nelwjSbprkHSv0UIlIxOm9OOS/Fzh9KNQxsaebTtU0jTZC3jzDGlvTkOzGmSdYqx56JHBk3bRSkjXcC/EONlQy3NBbscB
X-Gm-Message-State: AOJu0YyyDqpaoiVplhT6vxWwvE6pdCL28IuDytuRYfdAQbYDqInZemH/
	TFPGzffetb9FsunDIjiMil/+IaTOxwUDBnv3kVlEEZX8z/tPO8OH0NBpBQ3tWOua62y3Vzbd794
	FaWg1KUI8w6s/2g1GMRXYXFFLwXnEGJiRsOdbe7bLlFUa3HeFBxw=
X-Google-Smtp-Source: AGHT+IGEEt/X1HBcZ8GvMPKSAZtaw9oCyg6e6/g625a7K7p6uRZUOzQGv0zldt06N0j06M/4XRIHFuOjDvwph/sOmg4=
X-Received: by 2002:a2e:91c9:0:b0:2e1:f05f:6424 with SMTP id
 38308e7fff4ca-2e446e81666mr25956051fa.15.1715188881132; Wed, 08 May 2024
 10:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
 <20240507-iio-add-support-for-multiple-scan-types-v1-4-95ac33ee51e9@baylibre.com>
 <20240508124049.00001661@Huawei.com>
In-Reply-To: <20240508124049.00001661@Huawei.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 8 May 2024 12:21:09 -0500
Message-ID: <CAMknhBFob4Wd8Gm8W8NKSuL9UbBCY8+fAN_voGPhb4Fy1tAT-w@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] iio: adc: ad7380: add support for multiple scan type
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Julien Stephan <jstephan@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 6:40=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue,  7 May 2024 14:02:08 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > The AD783x chips have a resolution boost feature that allows for 2
> > extra bits of resolution. Previously, we had to choose a scan type to
> > fit the largest resolution and manipulate the raw data to fit when the
> > resolution was lower. This patch adds support for multiple scan types
> > for the voltage input channels so that we can support both resolutions
> > without having to manipulate the raw data.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> I'm wondering about the control mechanism.  I was thinking we'd poke
> the scan type directly but this may well make more sense.
>
> This is relying on _scale change to trigger the change in the scan type.
> That may well be sufficient and I've been over thinking this for far too =
many
> years :)
>
> It will get messy though in some cases as the device might have a PGA on =
the
> front end so we will have a trade off between actual scaling control and
> resolution related scale changes. We've had a few device where the scale
> calculation is already complex and involves various different hardware
> controls, but none have affected the storage format like this.
>
> I'll think some more.
>

Here is some more food for thought. The AD4630 family of chips we are
working on is similar to this one in that it also has oversampling
with increased resolution. Except in that case, they are strictly tied
together. With oversampling disabled, we must only read 24-bits (or 16
depending on the exact model) and when oversampling is enabled, we
must read 32-bits (30 real bits with 2-bit shift). So in that case,
the scan_type would depend only on oversampling ratio > 0. (Writing
the oversampling ratio attribute would affect scale, but scale
wouldn't be writable like on ad7380.)

It seems more intuitive to me that to enable oversampling, we would
just write to the oversampling ratio attribute rather than having to
write to a buffer _type attribute to enable oversampling in the first
place. And other than requiring reading the documentation it would be
pretty hard to guess that writing le:s30/32>>2 is what you need to do
to enable oversampling.

