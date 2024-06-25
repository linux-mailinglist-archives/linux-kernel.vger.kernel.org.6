Return-Path: <linux-kernel+bounces-228568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2429161B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438D8285006
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3801B148FF7;
	Tue, 25 Jun 2024 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUSH+T+Y"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B87146A92
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305731; cv=none; b=c/PZdsp1kgJdjx2UW9drvVeq+lWwL3JAyMl1+rWtXuXDIryPusVzHXDsXiGUFTVcm19ivAqtX3OxxRtymOLN6C/6eViwTmpFXZmOhntUTMl8Mtfb4xbKk0qHdLMNnJ4TDMJ41mdMaUyAJQrWvUm6nqstec74B/kDS5Kwfn0eL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305731; c=relaxed/simple;
	bh=SH4aPTnlaAYgonWlc8AMhuTyD0/8JxTo055Gu9yTdMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeFW95GiJHJk+qFsG6U76g/JttjcL7vKen+hA05boa86UD89GfmrhW5GcJma4PO0oi5UnohsSQpakW5MatT8+iNMoFrg+PM/gEgGJKTqSmhlmah2vwQ5kzb8vU0cL8RgVPYoI85+tx4Ji6Xn310sGL/u8HaoxLghOUtdhZi+Wmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hUSH+T+Y; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dfdb6122992so4732317276.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719305729; x=1719910529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH4aPTnlaAYgonWlc8AMhuTyD0/8JxTo055Gu9yTdMg=;
        b=hUSH+T+Y58BtGoJQhTkdjeyXSND42CJKfsR1j7DPc8E68yv+496v2eb4un7xUMPjzc
         tWKTwnxlTHkOHuHKcSqgPVaqeYyM/GGk7Xv9LrlZ8ustDr84BeDU64Y/0UnN5wwEnaib
         j980+sksfDzpqbey2uQzzkI7cPf1RGFU9x6Ud9qiXqy4yVVHb9weR+Z29niRxZxAsM9n
         rHK83Fn18tgIOSvVuUUe7VegIG+7/sddNAdbqkFpF5WaNxMF29frcNhz1DtmQnZJHPHo
         AkCP7d69dI4Tv3H8OUnHt2ZiZL1p3F5g+96LdO1k906e5EkbkWK+9MFqI9qT1M72Lsda
         IffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719305729; x=1719910529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH4aPTnlaAYgonWlc8AMhuTyD0/8JxTo055Gu9yTdMg=;
        b=JFxJLuUbH9cg4cZya9/Iz7d7adYW8co30PNPMe6CvnnMuqJT5k5tPfJNnJDRvmbaFb
         1BzL4rsG+pHpARyASJlGIW9swg4qb8FLwy8GF9D08YkUpQR/KHd4AxBjW3Ac4AbR0bY6
         /DnzEYprXxLTvc8o0vcz/+9zpNshhW9PdH2w/26waNzmLECe0Nv74vuF3RWTGYwOVfLk
         2ki0lYYRhaTSkW88HjHwLimZhDY5j3dHCpILEiOVcd5gqrFTSSFpnF0NZacO9DFQklYo
         RWQEFusS7SBU6VtPL6avf7yc6yQvxPB5YCvYrlkAN8B+eg0VF4p71HYtIC4DdIyUndI2
         VQHA==
X-Forwarded-Encrypted: i=1; AJvYcCXok3Eoyih1QubIOwHI5NiqeDlgUXmWEqwk1ebU3b10sjVmQ6M2/fAOXvWAPSjuQFcX9k7RGd5TZM/JNYCRQzI5wriMSq6YfX0uWCy6
X-Gm-Message-State: AOJu0YzCIXU1f36Ws99ZaKKHnLGmxOX7xota1meRs01V4ZG4eY7rIT03
	iajXHhNhvW2nqvvvGbtknXB0lWTv75CpJQ+nijYF7f5o2hddssLCnXcd8ZK11GJ3biekXX2U27T
	CQQ6130yWdKIGXCBcU1K+zFQNMecnR5LNrMV8lg==
X-Google-Smtp-Source: AGHT+IE2fiY7Br3ex/7BAQtI2a+Y/rx5p/TZN7J3haCZToE3U9rlFaeHmgWC3DsztqmV+KnD1SaNV3qAYy3Vk3TOMmw=
X-Received: by 2002:a05:6902:243:b0:de4:828:b73c with SMTP id
 3f1490d57ef6-e03010eea58mr6447948276.54.1719305728939; Tue, 25 Jun 2024
 01:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
 <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
 <CAMRc=McZ+hrXyNESmf4pFX9+uDnc4AKsuO9X8AJsVgCfQVLd9Q@mail.gmail.com>
 <CAA8EJpo2_3zSYEfyQ0VwSs9AkeXUpcVRGB+LaRAhA=_SWjrhtQ@mail.gmail.com> <CAMRc=McPZKYoxWYJ3U35CXYbBdwYBuemBwBC-qA5hhpqqTYBjg@mail.gmail.com>
In-Reply-To: <CAMRc=McPZKYoxWYJ3U35CXYbBdwYBuemBwBC-qA5hhpqqTYBjg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 11:55:17 +0300
Message-ID: <CAA8EJpoEUyBmi5_Zb0m0TVYi1BAMuqNfdDL7rdsTK6rxjsGpVQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jun 2024 at 11:50, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Tue, Jun 25, 2024 at 9:47=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, 25 Jun 2024 at 10:46, Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> > >
> > > On Mon, Jun 24, 2024 at 11:20=E2=80=AFPM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > >
> > > > > Neither of these has clocks that need to be driven by linux. The =
only
> > > > > user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exi=
st
> > > > > before so no commitment was ever made.
> > > >
> > > > This might make some laptop users unhappy.
> > >
> > > Like I said: without upstreamed DT bindings, we have never made any
> > > commitment about the device properties. I doubt anyone will complain
> > > though, I haven't seen any DT with QCA6390 with clock properties yet.
> > > I wouldn't stress it for now.
> >
> > I was thinking about x86 laptops / M.2 cards. I'll see if I can locate =
one.
> >
>
> I don't get it, how could they ever get the clocks property without it
> being defined in firmware?

The clock and bt_en are optional.

--=20
With best wishes
Dmitry

