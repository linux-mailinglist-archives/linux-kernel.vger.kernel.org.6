Return-Path: <linux-kernel+bounces-369942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2784D9A24AC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434AB1C2341C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1645E1DE4D0;
	Thu, 17 Oct 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ry8SfnEC"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608B1DDC3C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174413; cv=none; b=XOzWTCZEQXwbWUZopdZ/fjB8ScvOxDJkBs7xM+sv05beULybeC17KgtxCSNwtT5M8ihyLbtyzzSw8XtzFjRmwqKenX6CfNl0LLcVGcl5oWnx5Ep84bUBCzXum+Vd71Y0KxJCq7HDpyfr+qxgZ+HkZ55EnRlRhZNs5l1oQdwbGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174413; c=relaxed/simple;
	bh=MYY3u3m0sN8eT40Xyy56cy89iT3Em1o4v5OIylPyLAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZSJ4H51PMYAxn+VlVY5N9JjA6eb+toqvNMsxtVdzMwPG61uewqeBavXnXcBq7GmpU8XKN7gWtrLIDnE3QF8dPrV2HwiHQKu57k+nrwsff+WCx1HHmBqGtpjt2QU64PCVFXoHChF9dIOfcq/EKsvUlF8kgmm+brweSlw7UCSWZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ry8SfnEC; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso10971201fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729174406; x=1729779206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6QmPAb0BP9OyVfiaktWLNoUa/mBBCtoitGiIVZn3pg=;
        b=ry8SfnECCYY3BqOSSEQIludksINHZXh/ELUAPEWc5I52mZ9+w/ab15j9JIO6x8dxQM
         XvrWSNh2Hd9gVDE95JZEoQXx/GiPIHcq+NsBLkt7yQ8jmEG0DJfbAAjh/DRQ/3833+35
         5Ceuo8Fj0QCY7weOURMsZLHA3wm9RhtJTG8aBT/ss5XyVphIOmPQX5uslm5azgUEPkls
         h4E1jyUO1O167/iFXSQO8qf3z+KYUbQHy3V+z8O06+zE13Vf4hI3TS5Z8wfQMTMkLKnz
         bPTjfW7gibiqWJxw3qFoAOFdnHRPy4TSO4FCsgALMyW82MoRFTsH5cwuGMWDxxIUUvqk
         M5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729174406; x=1729779206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6QmPAb0BP9OyVfiaktWLNoUa/mBBCtoitGiIVZn3pg=;
        b=Lq9QqkQYsyRpGbJCppk2z8aP0kPz+MOAx/UgJ+SdosPEozvcb86RXEJR83fK5CAJ5V
         zwVaMVeyt/jzossFNoneoa3n5vBx3zEkGak65E5z+8Xmb3WLkItKpnJtuCT0Vgh6bLdL
         KseS77kdyJ3pfq0SlUx8EIwlLdcPo6UpkqgyP7vEhIRfZI8t67twPY8sY84UeU86R2pW
         WDowcpGdd35p9+HPvYNnsNv+er/2Z9LQBuTloU4eBlb7LtY9uhCeLAjoFlmpgi6NYf8Z
         zliPq82gx2S1bqgF5irZxLDDf1qiPvNi8S/1qNouPDu94gGbEZcluZTTsopgCvBGdO6o
         Hmuw==
X-Forwarded-Encrypted: i=1; AJvYcCWW7ZmYd2L1s0HALkjJMObFvHV5fWhxAjQie+0SmOM/vZR7zgpW1zKkBtEyVUiMUR2rGzLue5Kp5OFcKFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgcXyGQhwcLwj6b4tw3BH9a/W4Lg0JMe5MiFA/FqxEphU6wK+
	+jhIJhBqB5ILiMb17US7PPeG2BnpH0sSi9macslhyHOhq0o4g0I6CjUgQa9NwwtkK+Q9LU7ejY2
	tSq3THV17BYMNoCNVW8gQ6T7JOphIZ35n97WfGg==
X-Google-Smtp-Source: AGHT+IGasRlVWjg0DCU29pOCQDPpJv3KcR3BzhWJdTreoQf1bl0s7y4P6K2Scm5i1P1Syk2YxvoA5cnplesvFBL3WF4=
X-Received: by 2002:a2e:be21:0:b0:2fb:50e9:34b4 with SMTP id
 38308e7fff4ca-2fb50e93dfamr75902601fa.8.1729174406069; Thu, 17 Oct 2024
 07:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-gpio-notify-in-kernel-events-v4-0-64bc05f3be0c@linaro.org>
 <20241017-gpio-notify-in-kernel-events-v4-3-64bc05f3be0c@linaro.org> <20241017124418.GA221864@rigel>
In-Reply-To: <20241017124418.GA221864@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Oct 2024 16:13:14 +0200
Message-ID: <CAMRc=Md=6WkwJRt7-7K0fTqOUMz3EzzOGLPbiq2SEw1+1Acc4A@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] gpio: cdev: go back to storing debounce period in
 the GPIO descriptor
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 2:44=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Oct 17, 2024 at 10:14:11AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > @@ -1047,7 +925,7 @@ static int debounce_setup(struct line *line, unsig=
ned int debounce_period_us)
> >       /* try hardware */
> >       ret =3D gpiod_set_debounce(line->desc, debounce_period_us);
> >       if (!ret) {
> > -             line_set_debounce_period(line, debounce_period_us);
> > +             WRITE_ONCE(line->desc->debounce_period_us, debounce_perio=
d_us);
> >               return ret;
> >       }
>
> Not related to this change, but this check looks redundant to me - the sa=
me
> is performed where debounce_setup() is called.
>
> Want a patch to remove it?
>
> Cheers,
> Kent.

Sure! Can you rebase it on top of my series?

Bart

