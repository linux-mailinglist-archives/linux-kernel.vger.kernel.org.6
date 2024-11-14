Return-Path: <linux-kernel+bounces-409197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E39C889D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02AB1F21BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B6F1F9406;
	Thu, 14 Nov 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wMFQ/bce"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C21F8186
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582961; cv=none; b=Z01zQAN2SLvT4D7uuEdaJoGMy6uHxs15GJ2ApY1iPbse40YAgH3OxcTCnWNsbwaoWZ3vMiqaRK4h9JgICOgKmJAQm+i2ChJNvlnud+HmSb0B7L+flhQ7eAKfbUsgvxq9JZsm6ktBrGdZQScH35bpHkJjqETfncIl4as1l9WS6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582961; c=relaxed/simple;
	bh=xqMGBkWAVRLAU6vznmDe0cD+NYfC6g8uZE14Hb+bp4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzUxNFYWVACCMeqREgU4k8i1OTSktQS9tpmJC6FgAwOYgFV+jn0zAOwKTtDC/qfV05Si8+N5lfIdq8JrADK9g1GwuMKohH60xS9FQa3fVYdy3A25ki/SRDp0bm10lGx9lt502bw9cPju4zcMH7a48fGR4pvKPMrk47bZ4GEuCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wMFQ/bce; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53da353eb2eso846491e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731582957; x=1732187757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqYGxV4/tMVzMvBRs0QqY04a1yQuNRbsqSYXced2Jk0=;
        b=wMFQ/bceQyDG3bXM5VKOT6KOPJ9h6foR1YwishIl74W+nFyW6BG+6vzLzlvwNgCeXz
         OOtRw8f+F61GCnxZwWtDEKFLzzr+B4DVvhXrlEYZBvbiSBBiXdeNgYzMblioZXp03TCM
         NgM/eMCMN9RXNcUYYMbekaghYuGyS1hJUVpr/5S/T51biPIpguz0XnmJwEqznJtS0nRH
         L1IoYQpNyMeFyQnpz13FAzruX8xgpUpnItBPWtnASKdd+FxLuRgEuAFnMJom791o2svU
         4xh5aa3feg9oIxfUBfyLcGoeiwhBcrrgQC+kPtykTR6EVPrUDzdQB6vIdEEm62ypUNOm
         SR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582957; x=1732187757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqYGxV4/tMVzMvBRs0QqY04a1yQuNRbsqSYXced2Jk0=;
        b=LP8fS/QnRW6ht9tngSrf9I4Du8EROSXVhUT7jzhaLBwK0Mr21q75DxsygpmBV9Oca/
         VpmJfwQ9QG5f+WmAcRhF1Ptro6Pn1Ez0QyBN/n21rSFv0ySwk0/NHjHxqeKf/FdfrlAs
         j7SgUCuA3ZpddFxwz29305gBMPlm5k3Hlz72jywmOwIa2l8AQ8r2dTzRR8yA6l5LMyYO
         JXCIwVyXoZi9RwDdyAheNS1sxdFKfMiLuPGYQFxFZ7uv/mOrg09vYHiOCF8qKnI3Vcbg
         PJ+gfiIT/QykrTC0++7dxKi3wHt25tSBNw1TnYYxAIZAwpet0PM5ed6tm26mgLhS8Egq
         TDKw==
X-Forwarded-Encrypted: i=1; AJvYcCVlYJsTh1BMaN0rVi4XaWZ0hlK+qDefdovBEpyybnJlSaSV+nDuxbOaxJdMGDjruX+djtrcMgaOMol7nUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuhxkhgZ1EmtU1vZCC2gvdzp9vTEgs85gu+Q9IMJfKhz+w/k93
	yz8s2z+SGiJy3kFipDkwPC3xh6ZgI6ZqkDNPpJFpUGlje/lTvLc1pDl01kRhD30vKGrkuLQlmYj
	RBdBf1DOmPyY3kwWDsITe9mZCKJotHZ+w0akzpobAcc2pmaxZ
X-Google-Smtp-Source: AGHT+IEXRitsLak2rnNKjeR0boQJ8Gt3ETQE+CMoQr5P58FAb6T2My0bQLCF0629d5Q7JW90/KZ7qZ4e3xm0k/fBfY8=
X-Received: by 2002:a05:6512:2812:b0:53d:a927:822d with SMTP id
 2adb3069b0e04-53da92782e3mr392250e87.0.1731582957320; Thu, 14 Nov 2024
 03:15:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113171219.2949157-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MeaDjhxAwmTcNZ+oHniFn4EWVEmfP8MdNWitmD+Rr=scA@mail.gmail.com> <ZzXTbEcrLigXWpAu@smile.fi.intel.com>
In-Reply-To: <ZzXTbEcrLigXWpAu@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 14 Nov 2024 12:15:46 +0100
Message-ID: <CAMRc=MeEtyTXr6A4gXbbN=ZY1tzAQnbVMF0NYA2_6Xm3=jfS6Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Move and sort Kconfig entries as suggested
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 11:39=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 14, 2024 at 09:54:50AM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 13, 2024 at 6:12=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > The Kconfig under drivers/gpio has a specific comment
> > >
> > >   put drivers in the right section, in alphabetical order
> > >
> > > but in time some of the entries fell unordered there.
> > > Put an order again.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > Could you elaborate on why you're moving drivers between categories?
> > For instance: you moved Intel LJCA to USB drivers and I'm sure you
> > have a reason for it (it's not clear if this actually is a USB driver,
>
> This one is actually clear as you see that it depends on USB_LJCS which
> suggests that it's USB based.
>
> > it's not registered as such
>
> Neither one of the existing ones in that category, right?
>

Well if you really want to open that can of worms...

Only gpio-mpsse is really a stand-alone USB GPIO expander. Others in
this section are actually MFD devices and would probably better fit in
there.

I don't have a strong opinion but we should at least be consistent.

Bart

> > ) but please expand on it in the commit message.
>
> Okay, I will do in v2.
>
> Thank you for the review!
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

