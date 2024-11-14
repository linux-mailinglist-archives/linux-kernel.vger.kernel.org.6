Return-Path: <linux-kernel+bounces-409324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A929C8B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E771B1F24D68
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C71FAC43;
	Thu, 14 Nov 2024 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Gvzo9N98"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8D1F76C9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589175; cv=none; b=u1w9cM6C/6WrbxVkpzNI6/5NBjZJ1cbjxTRdLgzDOwaDTBEeM1RQSWhOVVoWlAGbJGpIKCwvdHNphVFcWaop5LBZC2kBXkhdR79Qd/mijWXFMGndqURdKAuEx9MaAE6CKgCMlopljNn86ZD0Tb5wArBcAU9zyypeTOMt2c+z90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589175; c=relaxed/simple;
	bh=MGkV6k7ekIpGE7d8ywuC6KKlX8ewwJtWiBawQLrWFHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIAGts20FsufsEhukd+NRUHBmqJAKpbCWR98tTULPewSD1BuZHSvEAi5jCfteLmcCM53MAgxuQKb6WOx8YtKKSVGWjV50ZWgLd42ZMXwidwxUMtoPAV1xsbYFLqHf/o9YF0UwwH7DruGNEPB4o5uNj0jEwHcsYKZTuZD14bpgyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Gvzo9N98; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e59dadebso623014e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731589171; x=1732193971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMdSFBpU3ulyQCbsazLw9uC5LrnPYy3sgCbS7yhbe+Y=;
        b=Gvzo9N988zE0jIP7bkTslczqYdev7tCShQtZB57xvW2ceb2nfNrkSoB8kIwZlUDObr
         jYMeVeZvqF9BfHYGaPoPLTe/UH3ckVC9qrvfgwyqsC93pxlBI3I0MZMqaoZVF9XrKQC5
         McOZMtrrNJ2AEcqiNvGVg/56804Qv/vYCebvd2LlJn6EXx7WQhi2ceKTFm3S/SWelGGO
         UDxSKCZGMO3zyBABcKRSrX646cBam4vjJz3Ocm95x7gv0ZKNUcBlIljw5WHvhQXsobWU
         mrtEoYlEfVx+dtECYT2FndTjbVOzEa80dha2MxmGG/N9ozN4ssI3RoM2B8Lam6ieDeNE
         vLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731589171; x=1732193971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMdSFBpU3ulyQCbsazLw9uC5LrnPYy3sgCbS7yhbe+Y=;
        b=J6pximuIbEjg7ZJ9WGIXlSrP7dXRElrz9wkbwVhtFK5UpwFMcjKF8LIKpkZ5pGWbAv
         GnYyBNKZRUXUWLyMtKd6PxLcPWOrEGXGgQzcvp2mVfh11GTmVI5B7WQxoCX9T0ll+KSK
         DyyTmQGMPsVS24sOMO5mPl/L3haC3/o6UlknHoffvKIKkRGpXDKG0CXGzIo9gAsVNwjV
         HoHLPWNdqa2Tiyz+SXKIYnTagxnIQPLf1ZD2LsCzIW2rfIcLjX4Q9yFHFvm6HfhRV0Ab
         lESf2DT8r7zf7i3znvKmUKWNaJxtNWrxI160tjYLfHPr3H4r+9b3SnKpqaPD0U1V5UR6
         OXFA==
X-Forwarded-Encrypted: i=1; AJvYcCWsnLptD5IaAfhjeNM8JvYjXdRoMg3q102fbn4NYcsHOmXpiUTukFsHCVmJF/GPBSoFOq1uMKcdHVjLnmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6hKP2mZai1Syv+PovzA+ygVBBaWr0d35Jb91yyNbfDU/Hfjs
	CHa5s3tl19M7ZKcU7Yj6WvMvq3WkGA8jIzawkTBoALwWTzXlM4V3Z5PG/voxHEAshPafuR94zKZ
	zftY0s5q6VLNxGYIHCqmbvDNH/0EWEGb/2TqT/w==
X-Google-Smtp-Source: AGHT+IGDWKkoZLl9YnbdXfMARn0TDFveOqGcTx6vBzaoMPB7NVaZvWqSjtNwS41hkaMepCKrVfrH4D2HsiCP1mEXYxY=
X-Received: by 2002:a05:6512:230d:b0:539:e4b5:10e5 with SMTP id
 2adb3069b0e04-53d862bd4e3mr10788911e87.9.1731589171250; Thu, 14 Nov 2024
 04:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113171219.2949157-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MeaDjhxAwmTcNZ+oHniFn4EWVEmfP8MdNWitmD+Rr=scA@mail.gmail.com>
 <ZzXTbEcrLigXWpAu@smile.fi.intel.com> <CAMRc=MeEtyTXr6A4gXbbN=ZY1tzAQnbVMF0NYA2_6Xm3=jfS6Q@mail.gmail.com>
 <ZzXhf2zM9IisvZhs@smile.fi.intel.com>
In-Reply-To: <ZzXhf2zM9IisvZhs@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 14 Nov 2024 13:59:19 +0100
Message-ID: <CAMRc=Mdo2DysJRPvJRU9RwTCH8nmw_CFRYYoLfvfC8+j0K9roA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Move and sort Kconfig entries as suggested
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 12:39=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 14, 2024 at 12:15:46PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Nov 14, 2024 at 11:39=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Nov 14, 2024 at 09:54:50AM +0100, Bartosz Golaszewski wrote:
> > > > On Wed, Nov 13, 2024 at 6:12=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > The Kconfig under drivers/gpio has a specific comment
> > > > >
> > > > >   put drivers in the right section, in alphabetical order
> > > > >
> > > > > but in time some of the entries fell unordered there.
> > > > > Put an order again.
> > > > >
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com=
>
> > > > > ---
> > > > Could you elaborate on why you're moving drivers between categories=
?
> > > > For instance: you moved Intel LJCA to USB drivers and I'm sure you
> > > > have a reason for it (it's not clear if this actually is a USB driv=
er,
> > >
> > > This one is actually clear as you see that it depends on USB_LJCS whi=
ch
> > > suggests that it's USB based.
> > >
> > > > it's not registered as such
> > >
> > > Neither one of the existing ones in that category, right?
> > >
> >
> > Well if you really want to open that can of worms...
> >
> > Only gpio-mpsse is really a stand-alone USB GPIO expander. Others in
> > this section are actually MFD devices and would probably better fit in
> > there.
> >
> > I don't have a strong opinion but we should at least be consistent.
>
> So, as far as I can read the whole picture the categories are based on th=
e HW
> (and this is how it should be) and these what I moved _are_ true USB devi=
ces.
> Linux abstraction is just a Linux abstraction.

If that was true, we'd have no MFD section at all in GPIO. In there
you have I2C, SPI, platform and I don't think there's a reason to
treat USB MFD devices differently.

You know what? How about just reordering Kconfig entries
alphabetically for this merge window and next release cycle we can
decide on what to do about Kconfig consistency?

Bart

>
> If you want consistency, drop these categories for good, just have plain =
list
> of the all GPIO drivers. No room for any speculations :-)
>
> > > > ) but please expand on it in the commit message.
> > >
> > > Okay, I will do in v2.
> > >
> > > Thank you for the review!
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

