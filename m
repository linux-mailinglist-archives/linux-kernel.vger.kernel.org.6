Return-Path: <linux-kernel+bounces-177703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377F18C4365
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5BFB20983
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2D323D0;
	Mon, 13 May 2024 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xAPw15O0"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94431865
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715611236; cv=none; b=X5lNwBuxktPRVVVdXXfpKjvXH/WsBpkWlneSJauwXDCh112jwi10Fy6IBPlpIswSdwNF0q5KbqQRJyFKXMGIfDMp7QLmKisk8a++xdo0BrUyoQq3y1pYBInqROM9ou+IC34z5qMDWMlORtdpX1h1vq3a0k1kk91V5rwOFq8NAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715611236; c=relaxed/simple;
	bh=RR+FvSe6PreSIlJJZUiEFi2zgORXY/2RQNOZhVNzURo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=k993xpnjd9FHaipWlhvnzrVEyO8Slr03CBK7VTuQyDhahQdA35ooGyreZeY7VzLpCKL6fomjllhH+e8MUQoL3X1dcqYMDlXOLhNIAWxnFeoOuBssIpvaxcrkLOYB3KpurxU3cLqHqIKK91+Fs+ahn6WMLTBIzpOdeIW1MsD1/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xAPw15O0; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52192578b95so5079395e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1715611233; x=1716216033; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJZwp0seGlB/jzhkQ5Y+HidZv7cCxncq0/tJbVWAKEo=;
        b=xAPw15O0QUSMYye2skVlocMAQB7F3uTyvqBKsV28QsvvkzO7NNOBk1dntmQOzkzW8k
         xP3v9KsUd7xR6K4uA/Q3o0k5AUDloe316IPLcknkgx6gwQ3dfrpSd659Mv3Xtredai48
         RZjZ10ZKC2C0OF+KV4YmEngIkcO4CL2uxxC/Z3SIrJ2BeIMuRaN/CfACC7h03SpGJfDG
         tZA/WsSl8fA79RnuEjlnhW+M3cWzqZZXfvS7thKlNQTnbY+rdSinKCOqMjLStDDDfu0O
         MlZACyxN6jc1FADEgOmQ/nOOZWKJ9r57q7p2XTl2pqjFXOChojktHoVk79M9lkaBNqhU
         gZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715611233; x=1716216033;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJZwp0seGlB/jzhkQ5Y+HidZv7cCxncq0/tJbVWAKEo=;
        b=GdP/X0jmnWsgB/P9B5r7qnIXzCB9/UwjpWBopG6st4mRbbezkM9e2edwgHZ5UiRkwh
         D0vIR4VdZVDgsN85pSiQnZa9R9HGLoIs30uL+CZVE9UkyaTewCc8QxrMdbcIGDwdz7lL
         hOe2ecRN7YrA+9x3qPFcUtXB8Mev+IEfHoEMl+BKLPFzAyUYwQaDOMSUxAmQNMQxGi4T
         uDhLw01DDGGPLuD3Ud1tj5BnDQcW1C6P0SKPvwqVyPIrhCP3iSZykW5ON02MVTtuJVJU
         u3ciuw/fORc+95lycxww49ZQazPj6Xp4Gxoti32Gp3hg8zmN4GSVPV9tP2a2s3CwVUGI
         NIng==
X-Forwarded-Encrypted: i=1; AJvYcCV4hfI9zQb+weP4BudJvVk0HL8GDPl15XKcDqNOjPmBFN6NfAIhWOMm5hLLNrbUptXkW0oz11aKGGK5zUD3qHWzQUiVcALqN1D3nMLv
X-Gm-Message-State: AOJu0YwnllbAHFhfeCZE+nkAZVg/kvUfIYyWmdwLsoknyBooTXzaeHyN
	3v9IANFrd1kDHNuqshJjilIfe0vr2IR1MaQJkcmmqQxwlOyQ/Jrz1ZaTCzpTEgR5ZMJBxbiD2XD
	9ehqeYNAF7k/SsgZNanLSgCydbzPBKuC2gnpf2JIUOWWdGE8LXv0=
X-Google-Smtp-Source: AGHT+IHxCuLpm4IulBnsKetvV5ifAyUozwLm3CsA9M2AGmsza/OqaDOtQw0zMpp0VpkMf9ZJlEwpkklIaKxy+ZOtm/w=
X-Received: by 2002:a2e:8949:0:b0:2e2:1a8b:e2f with SMTP id
 38308e7fff4ca-2e51fd42b4emr64871511fa.2.1715611232847; Mon, 13 May 2024
 07:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZiJkxBU3bYNWOdbK@Z926fQmE5jqhFMgp6>
In-Reply-To: <ZiJkxBU3bYNWOdbK@Z926fQmE5jqhFMgp6>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 13 May 2024 16:40:21 +0200
Message-ID: <CAMRc=Mft4MJVx9bvO6Ab=2O+WC0oG19SbYquuh2AOBNi=Mqmww@mail.gmail.com>
Subject: Re: [PATCH v2] gpio-syscon: do not report bogus error
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, etienne.buira@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 2:35=E2=80=AFPM Etienne Buira <etienne.buira@free.f=
r> wrote:
>
> Do not issue "can't read the data register offset!" when gpio,syscon-dev
> is not set albeit unneeded.  gpio-syscon is used with rk3328 chip, but
> this iomem region is documented in
> Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml and
> does not require gpio,syscon-dev setting.
>
> It has been suggested to automatically detect if node has a valid
> parent, but that would defeat the purpose of error message, for example
> arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi could then be used
> without gpio,syscon-dev, and lead to funny results without error
> message.
>
> It has been tried to mandate use of gpio,syscon-dev, but that raised
> objection.
>
> So while this patch may be kludgy, it looks the less bad to address
> the spurious dev_err call.
>
> v2:
>   - changed flag name
>
> Signed-off-by: Etienne Buira <etienne.buira@free.fr>
> ---

Linus,

Do you have any objections? If not, I'll pick it up after the merge
window. The patch does not look very clean but I cannot find anything
obviously wrong.

Bartosz

