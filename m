Return-Path: <linux-kernel+bounces-517156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD78A37CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6043AB5F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C119D8BC;
	Mon, 17 Feb 2025 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PJDHHeob"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C718DB28
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779942; cv=none; b=QHLHQOCjMvXFC7I6qicTbcu4kSn5G5BE+AtKUikcvsPvLarCmcHhOxJjIuzLXzHVH46y/2r6n70puXgekH164vwvt8aCUpR6ceoTXQ96O/CDvQ8prdaMYzV4x32r5LfqZ85cRpD1e5dGHkuEHyy8BlDzkGM4h63vbfZf9qjEPHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779942; c=relaxed/simple;
	bh=uPKvXVzPWF+ThRLBxFwXSOKl+47IxC0i5CQD13TwCU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6u6yzVE+M5/9qKD8KiXIrJen0f8tYxK51zHa1PrPNVNOWacaZ7qHs9zCnu7oy2nfSqYVOWjZ5hMkKQaSFURidVMMBH7pczyv+Vufx2XJj+lNQkeUtL+ToO3PSajRePIJEijidcA6p9ml8wn2uhdXiUy1I5bCMNpgEdSX0kYoUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PJDHHeob; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-543cc81ddebso4402896e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739779938; x=1740384738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMOtdB8uF/f/6s8OjVAdSppDXj08pjjoPjNXDTrhA9A=;
        b=PJDHHeob2xz/21PJ7K+qXBZ1L30Hj/7jTK3r4zCxf3qNbcDN5AAulsAHrrVbmoaNvf
         yB9UxVCqYwh2coA6lFVCYI6PFx9/uClaNHbDEu9dJdhsHz6hjedRxVXt1nYo69+9FuN6
         uB7tNNqRAlP/In2qmADdt+O7PoEHCHbdsEIw2n79JEE6xqfeZWPMUORHJIvYOjnpHg9W
         LDquafrcg8371XkXblue2tthHwMpDvWVUQh34683rI9/WfZvbF7h1pAs4rfl/rK9aBUM
         QrUqu5JHvoJjUp8ohSv/l72q2IpRjagOnfYvyrGvkd/7rMMKqfj1HgpZhIOOtBBpIoa1
         axKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739779938; x=1740384738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMOtdB8uF/f/6s8OjVAdSppDXj08pjjoPjNXDTrhA9A=;
        b=wpfq+y4E+JlmKMX0An+WZRo39+NajuIKXMezc/lsIPaeKOJiyojBl+kUbYyycIL4LI
         azkcMQFE/TssqIIMziGLyXXuCAUZGYZWPmQv3UtdXbE1RMlIEvh7vHP97KtIdNW+gGWS
         scSwFFXD+7zjjqCwAzM+AsMv+ySh6mUGjmxk9Z6oLJ/uFw8JsFAe+d93M+3fD1JvdRiU
         g6Va/6YMGMvSSGKpvze1E9xEdSyoAX5s0Q1rpSG39BwxojP/gCcxYYJuY1nZbD71+OLX
         dBrEYj4uwEkFrOKyrbIkMfUPT/rM39lTcjESJ/jiG/z/UPZbBUUPZ4HZ+xRXYl4ei1Td
         Rtxw==
X-Forwarded-Encrypted: i=1; AJvYcCXl6rV9CEiu04mLSUlmpHz1KnNaCQf+W99HPKd2DakeM+epmp+n+HHLCj1Y78bP9v2cVlxOTs5TPA3uVWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPTnZ5MLbAT8xkjCV94hhJsyQoGeBoYD1j2ouoN92zRx1ZkHRt
	ehjNQv64DSL+kpuc8K248K1eJwIhZMzc4A88yHeRYBqRrd87SU2hXqKe72YzTNfb8ljyJYA4KNX
	NPQbULbtiYpgiTjvsGvibdfpLs/Pa7vAB/1NrbQ==
X-Gm-Gg: ASbGncswR/4mssDkvPKAUua8R+qRpfERJZYUuBXiCiF04GnB2ZMYA3/WjnikJtGFYi3
	EBGCQq7Olqvdl1BVrtqMKFD6WgVCKkOhNAJkS3Tq361WkrMwJGFlpS50LBOoiOPRRNfIsvHiacf
	wKAYT5qPbpOUZNV27xA3er39jWJQ==
X-Google-Smtp-Source: AGHT+IGKMXGeAm9gSpXmxD0qlZa8GXly9zzx3z6gIfOpxbl3uTwVkFQRM6Ow0fBUV/AKD4yXnQ7rEPyzlGWnqbEGlpo=
X-Received: by 2002:a05:6512:2354:b0:545:5d:a5d8 with SMTP id
 2adb3069b0e04-5452fe2cf29mr2787159e87.7.1739779938150; Mon, 17 Feb 2025
 00:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216125816.14430-1-koichiro.den@canonical.com>
 <CAMRc=Mef-cg_xt_+mEAyxY_9RfK4=qWEbt_GebeT2mu_8GWVxw@mail.gmail.com>
 <qw5epzoexlteotpuulafg4fyjatlsjjko3ldnzjezoumhodgko@a72wjsaw6fgz> <dc2w6gxdp3rhlhy6hvwocp76zdjh4jhdljhoijbub5q76f4xgw@ulfvg2s3rvub>
In-Reply-To: <dc2w6gxdp3rhlhy6hvwocp76zdjh4jhdljhoijbub5q76f4xgw@ulfvg2s3rvub>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 17 Feb 2025 09:12:07 +0100
X-Gm-Features: AWEUYZlrO0DzSDa7Lr8zQsrCfCYGmrfQqWkR1Svx3o2vh5dXwwRAiP5bcweiEI4
Message-ID: <CAMRc=McL7XJfbb3h3XO+UUhL77sq0TZodS=rjaQ19uvKJj+NWg@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Introduce configfs-based interface for gpio-aggregator
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 2:18=E2=80=AFAM Koichiro Den <koichiro.den@canonica=
l.com> wrote:
>
> On Mon, Feb 17, 2025 at 10:07:03AM GMT, Koichiro Den wrote:
> > On Sun, Feb 16, 2025 at 04:56:59PM GMT, Bartosz Golaszewski wrote:
> > > On Sun, Feb 16, 2025 at 1:58=E2=80=AFPM Koichiro Den <koichiro.den@ca=
nonical.com> wrote:
> > > >
> > > > This patch series introduces a configfs-based interface to gpio-agg=
regator
> > > > to address limitations in the existing 'new_device' interface.
> > > >
> > > > The existing 'new_device' interface has several limitations:
> > > >
> > > >   Issue#1. No way to determine when GPIO aggregator creation is com=
plete.
> > > >   Issue#2. No way to retrieve errors when creating a GPIO aggregato=
r.
> > > >   Issue#3. No way to trace a GPIO line of an aggregator back to its
> > > >            corresponding physical device.
> > > >   Issue#4. The 'new_device' echo does not indicate which virtual
> > > >            gpiochip<N> was created.
> > > >   Issue#5. No way to assign names to GPIO lines exported through an
> > > >            aggregator.
> > > >
> > > > Although Issue#1 to #3 could technically be resolved easily without
> > > > configfs, using configfs offers a streamlined, modern, and extensib=
le
> > > > approach, especially since gpio-sim and gpio-virtuser already utili=
ze
> > > > configfs.
> > > >
> > > > This v3 patch series includes 13 patches:
> > > >
> > > >   Patch#1-7: Prepare for Patch#8
> > > >              * #1: Prepare for the following patches.
> > > >              * #2: Fix an issue that was spotted during v3 preparat=
ion.
> > > >              * #3: Add gpio-pseudo.[ch] to reduce code duplications=
.
> > > >              * #4: Update gpio-sim to use gpio-pseudo.[ch].
> > > >              * #5: Update gpio-virtuser to use gpio-pseudo.[ch].
> > > >              * #6: Update gpio-aggregator to use gpio-pseudo.[ch].
> > > >              * #7: Add aggr_alloc() to reduce code duplication.
> > >
> > > Please don't ram this new functionality into an unrelated series.
> > > Split it into the gpio-pseudo code, factoring out common parts and
> > > converting existing drivers, then send the aggregator series saying i=
t
> > > depends on the former. Otherwise it gets way too complex to review.
> >
> > Ok, I'll do so.
> > Thanks,
>
> Should Patch#2 also be split off into another submission?
>

I'd fold it into the aggregator rework but make it come first in the
series so that I can pick it up into fixes easily and send it for
stable.

Bart

