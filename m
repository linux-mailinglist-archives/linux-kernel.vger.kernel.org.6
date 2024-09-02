Return-Path: <linux-kernel+bounces-311033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 094B7968429
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EEADB21E42
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456FF13CF8E;
	Mon,  2 Sep 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jvvVg13/"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE1513C820
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271801; cv=none; b=NbR3dPdxOwbL0hnh9c5MXCDwmuCg+fGnJiloOWWz7qiCMgknrRTww6widOnANlFga1EWOlE5+vDsJG4tCSZbtpS0OA+/SycoIH2fE17hTGkgqgDA23QTaRvWVTkVpWXQj+AjO/ZcIHQKsSC6bnOQ1/3463B+n1tJm6eqDzzAaAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271801; c=relaxed/simple;
	bh=Ja4YtugzMB9ogEIkX3BJKEenkvJ6wDGuFRn5ZUDxiGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYwQU948hYvtx+dtaULMQMb5qyRbKPoJxIzgGEk9bA1IY9vL4d4v7ypYc5ll7HnWIxVXFqjFvx4Ev7BX4woSFVVCDSX1G3zRfTQArHv4HI+tNJVF5xVXJUogs6nWH/RAf0r8aFp9uAGu1ji8koA3km0uR6c6vwp/BphvPdYOgPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jvvVg13/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3f0a31ab2so45546571fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725271798; x=1725876598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXTfoHlWfPNF1IIbquXqm5QjiVKu7PwRvegy7632kfQ=;
        b=jvvVg13/nsVIDwZCkPBTSISswQCk9lNP6mKZXEs7cHitbdGU611TNDCELPz9WMTlbo
         3bBbtQVh5eBc2E4Yr2UDp2TYUmjNKMoVT6t7Z4DsuZfdfgHhAGdpTEeSYScyEEo+Jmoo
         uhc/1DPNX/s9foS7Md5YmrY53hli48wPRUoEshU/mY0GSuV4LSNPFPEsqa5ULngZZn4m
         fadFyxuj4s5oM2tnjK7p3bQ299RQCkr/QXPU6fjAakMdiqGoSXtPO5Z7abIXryQPhhWU
         k25enYKcqgFcon/J6HJPI2qqw+WBgRIAL6xSXW3Fh2kcGjtUJiTeM0b/13THIiSX1cM7
         KBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271798; x=1725876598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXTfoHlWfPNF1IIbquXqm5QjiVKu7PwRvegy7632kfQ=;
        b=ZyBG8lAUOwo7KKDV+SkeAxR1a1cwKAvwCZBOXZwxmmLX+fINN7zzy4nJ4+ROTWZjgR
         za+AGxwdFL/hgjkHZzzAH7enGNQhFbkNafsEU0p1SenVgP+U9cdds2GWKZDO15tajL4w
         iHSWyxQ4XpLF1qPSKkoJkFr6+zhSRat9B32uuIxzZ2GF9QSsx2yt+nQbNTsfoEgo7ee/
         cx6PfLaL+PkwQZ09xuuiBPbnlg2haE0oMUDPg9fcI0kYmol2T+eFIinGQtdtvwjuuNKX
         mD2fGOurvc5P+7vgUHboFJqjVHG3juyK7HR5lBe3GJwzbD87yOppixbU5Dq5q4QDXrdB
         XgHw==
X-Forwarded-Encrypted: i=1; AJvYcCUwgQ4C6hYB3YumIz849/4izczyObWhStottErRe+dBmFdw3gnVuH2KHwJ0osrpb7MRr+WU6NGmERoX7dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIpi2Zef1IDQKdicCnqp6s+4zRRk98/e9fVKErJPlSp4JaWQpu
	WmvrRbUeUwAvZQAMyxPxAIv1rxV2GkzQH2Ta3kmfPaYWJuSWFy5D5EMnjXK1G/xWUgoBmHd08nH
	i/p+/RQtbuZfqPeamddP5ncg99Q2eyjx69IET7A==
X-Google-Smtp-Source: AGHT+IEfsxozqEMUgmXhMyMPUf5NwF4vKKwxsvyswqI6GCtgLgU7BgY9T+H3dEqh6ncqSHBxoWIZwevlso/C7nKtjeY=
X-Received: by 2002:a05:6512:31cf:b0:52c:df8c:72cc with SMTP id
 2adb3069b0e04-53546b692d9mr5654696e87.43.1725271797696; Mon, 02 Sep 2024
 03:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826161850.74447-1-krzysztof.kozlowski@linaro.org>
 <Zsy6pZ9LYDk0LOHs@smile.fi.intel.com> <0187710f-73c1-4ee1-87f9-384101f0c32c@linaro.org>
 <CAHp75Vfq0kEN-VDd=aTycHH+oEkUHt260nH533UWnkoEnGRhjA@mail.gmail.com>
In-Reply-To: <CAHp75Vfq0kEN-VDd=aTycHH+oEkUHt260nH533UWnkoEnGRhjA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 12:09:45 +0200
Message-ID: <CAMRc=MdGUYQFJ6GnryL51AKPpXOW5FuV+SZxAtqt+moJpvLQ7w@mail.gmail.com>
Subject: Re: [PATCH] gpio: kerneldoc fixes for excess members
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:02=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Aug 27, 2024 at 4:55=E2=80=AFPM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 26/08/2024 19:25, Andy Shevchenko wrote:
> > > On Mon, Aug 26, 2024 at 06:18:50PM +0200, Krzysztof Kozlowski wrote:
>
> > >> Drop kerneldoc descriptions of struct members which do not exist to =
fix
> > >> W=3D1 warnings:
> > >>
> > >>   drivers/gpio/gpio-pch.c:101: warning: Excess struct member 'lock' =
description in 'pch_gpio'
> > >>   drivers/gpio/gpio-syscon.c:46: warning: Excess struct member 'comp=
atible' description in 'syscon_gpio_data'
> > >
> > > I prefer on per-driver basis, but since it's simple and I have nothin=
g
> > > in my queue,
> >
> > These are so trivial without impact on the code, even if W=3D1 reports
> > them, that it would be quite a churn to handle multiple patches.
>
> Even trivial changes may lead to Git conflicts if managed separately.
> But as I said, there is nothing in my queue (at all) so there are no
> chances for conflicts.
>

Is this an Ack for me to take these or do you want them to go through your =
tree?

Bart

