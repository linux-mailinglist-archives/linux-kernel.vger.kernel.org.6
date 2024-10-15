Return-Path: <linux-kernel+bounces-366368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C06599F46C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48487B224DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676451FAEFF;
	Tue, 15 Oct 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="puJ2g3Ox"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FD171E49
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014788; cv=none; b=D4xWeNpUdsUtVw/jlH6RmIgN2Oid2/7lwUAK5bIVAaAbhSYOqNlGm3MrjVRUF7IuSd9AaR0LZMuXP30wZ++MZKYxlvwlc8NftmlcCgiA18djtPSlWKi7862oNVyvatLBwIczyfk38vBgAOmNRO76q3s4wawO1NpzF1lzOWLb0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014788; c=relaxed/simple;
	bh=ZDV08loxaQihu2g9FFlAm3cd7K95Y97y/FM7hcUWpDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ea2ilHI06vB7Nc7f8o2fXJhxeTn8CplFf7U/dqwW/agl22G5mrvcYmu0cteOgk3WtfNNsIj8QXuMw6kT/gBxngk5XwEMtLPbvzMl1H/cJFDBtCoOwDjZqaXdUWQj2BlJHTcjaeQl/EQikPhNUxNrTyGVZia5Ra1RxTMfMEx5r3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=puJ2g3Ox; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f58c68c5so4288590e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729014785; x=1729619585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T89cnhVXpmzBLJ+gVGC1Jh39UwJsqGJsZMY4/oWn65k=;
        b=puJ2g3OxbiEBXj7A9ecnMZJTTxCHePU6t8dzvWTDywnt3xNDK7p98OQBB7FSTg7TI2
         0cQ3ga3wg9Jl8oLgiZ9IaRm3i1Ns/uOljmOmNfcVIpSeUy7s3R7pxLs4ZU+7B6r2L+go
         JH/sPW9xuBSPrrYjS9RJGJcS5fw+QCr8tshWrB056CVvLIi1qaAD7cQnA/hiJumEKLwn
         rVtvPV48xcV5Bp4WtLpbvVav9Ajy+JY8k2iMO+/Z5ob5MpBhj8eMZoEs6aTzpyYVCiNd
         4u3V9m/DLMQZgG2JgExQ121Vh/Lfz7ZNmJ9OO6exshURhUiuJFevT9Dpw70+YfJOcWt0
         X58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729014785; x=1729619585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T89cnhVXpmzBLJ+gVGC1Jh39UwJsqGJsZMY4/oWn65k=;
        b=VGMF1osF3QIxy/KMIWb2aRdBeWjk0hrDgE5GNMBa1IE+F78l5WQR3WWop7uaspkbBH
         uu/HWnIh2n9xbP0usjUz0KrTyQfMOM/YlxRkJINpBBO/RDPpWGFDzmsf5erDdF2/NXYA
         yrlinNLGue+SHipG4Xq8cNlXIKsVM71IDT4QOjPJLtbvkzdUJaQ4qs8E2dXgfFAlyU/N
         ygiT0/PwANVufdmSGIIIXh5cpNgeGpUMOP9ADQTA9nhckO0gP6Qm1meXHCfgwqXQJ9up
         ob5x3MxwbIqu3bBuGfHxJ7vPQSqw9v2xJQYFH8lG+GA8yGBsoAUReXWABrkHX4UFDO9f
         tLzw==
X-Forwarded-Encrypted: i=1; AJvYcCXuf4CX4qEP0HEGfGJHhvESiZchvlTVvLdJc8DXaO0cojYanfLgkfpEZQlQFSqjbza0zapKCsQA/SfOuD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEmcC4KAA6GI4maLmsh/E1sxjQ5qQmsrPiGtV1xg8cF0dxWgzQ
	YMLiJQNqZeUDC7opsXr0yXY7BWHgKT90q+YVBPdWd+CuvKz0zDhZAYRUsxQUdrHFoccx1fspHS3
	3yJOcGbkutCdKe8vfvbrlsUI3Ojm/K/aOV+dA8OKaioxha6kG
X-Google-Smtp-Source: AGHT+IE9R57vGa0ecL3E8nCkWuB7n77IJekoUVtIjtZX8wKqh06ttttEVBmaAHJYLybzGJ8rO4JPFG3phj94rNdbHZQ=
X-Received: by 2002:a05:6512:3083:b0:535:6951:9e1c with SMTP id
 2adb3069b0e04-539e54e7122mr8103299e87.15.1729014784773; Tue, 15 Oct 2024
 10:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-gpio-class-mountpoint-v2-0-7709301876ef@linaro.org>
 <2024101531-lazy-recollect-6cbe@gregkh> <CAMRc=Mea=W-1UoHMew3Si=baW3ayERrHjxjG0NPdmkCfp9dUHw@mail.gmail.com>
 <2024101535-wrangle-reoccupy-5ece@gregkh>
In-Reply-To: <2024101535-wrangle-reoccupy-5ece@gregkh>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 15 Oct 2024 19:52:53 +0200
Message-ID: <CAMRc=MdsXggB9TUK-Rxt1GLZ9OA+3FskD1q3BM8TGbOhqmhXjg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpio: create the /sys/class/gpio mount point with
 GPIO_SYSFS disabled
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:46=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 15, 2024 at 02:11:45PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Oct 15, 2024 at 11:30=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > >
> > > > Despite providing a number of user-space tools making using the GPI=
O
> > > > character device easier, it's become clear that some users just pre=
fer
> > > > how the sysfs interface works and want to keep using it. Unless we =
can
> > > > provide a drop-in replacement, they will protest any attempts at
> > > > removing it from the kernel. As the GPIO sysfs module is the main u=
ser
> > > > of the global GPIO numberspace, we will not be able to remove it fr=
om
> > > > the kernel either.
> > >
> > > They should protest it's removal, and you should support it for forev=
er,
> > > as that's the api that they rely on and you need to handle.  That's t=
he
> > > joy of kernel development, you can't drop support for stuff people re=
ly
> > > on, sorry.
> > >
> >
> > Yet every now and then some clearly bad decisions from the past are
> > amended by removing support for older interfaces. I'm not trying to
> > deprive people of something they rely on, I'm trying to provide a
> > drop-in replacement in user-space using an existing, better kernel
> > interface, so that we can get rid of the old one and - in the process
> > - improve the entire in-kernel GPIO support.
>
> How is emulating the existing sysfs api anything "better"?  It's still
> the same api.
>

The existence of the sysfs API in the kernel makes us stick to some
sub-optimal design decisions (like the global GPIO numberspace) that
we'll be able to entirely remove once sysfs is gone. We want people to
use the GPIO character device and if it takes a layer emulating the
old API on top of it to make them switch then it's still better than
keeping the API in the kernel.

> > > Sorry, just live with the kernel code please.  Work to get all usersp=
ace
> > > moved off of it if you feel it is so bad, and only then can you remov=
e
> > > it.
> > >
> >
> > What if we just add a Kconfig option allowing to disable the sysfs
> > attributes inside /sys/class/gpio but keep the directory? It's not
> > like it's a new one, it's already there as a baked in interface.
>
> That's up to you, but again, please do not mount a filesystem there,
> that's going to cause nothing but problems in the end (like debugfs and
> tracefs and configfs do all the time when people get confused and start
> poking around in sysfs code looking for the logic involved in other
> places.)
>

Oh, I would never do it! I hope no user-space program ever comes up
with a crazy idea like that! :)

Bart

