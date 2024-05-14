Return-Path: <linux-kernel+bounces-178440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FFD8C4DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0432B21C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0B71CABD;
	Tue, 14 May 2024 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="DD+1X918"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417FF14A96
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715675954; cv=none; b=hI5nl1kyiHwhlJZxl1n3SFqECv1rLuIQC4V3r4VcHse4basiNHtAvnvN/BgIGNFM1mu28pWjzD6+0g9zzlPorVHvkUBySmcIaKCJ/P/6/GMtqVaF2yzYrawQBLkPVkGmAFdPuX8G/RoFSJ2Q+hzqJd2xbDF9q2W/lL87SJ2X0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715675954; c=relaxed/simple;
	bh=PpIsu2YQ8LKdplBvqSkaGF3UZwOWDSw318bSDid1J80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THgQRLmhiQT9AV9fHJTEIMeC+XtR+OpFd0a5lfUWby3eod4jc02YmHGbFXXgHfBtmUi5egO59zmdtACvTDr5IoPPi+rVdEZZ05bFfXqurgoTLeo0YCkaWZgjXyq8KY01lKmgT0VFnKl/I7wBRNWFLiyytKh5fIUp+idSFCbbrbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=DD+1X918; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61bee45d035so54634407b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1715675952; x=1716280752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8OfBUMWw4vRfdJG5yIvPigGCabXSzHeeUlvg2+VyM8=;
        b=DD+1X918NuP42LRHIK1ScvzkFyD26YyCHDwahJgRIRo4BTZeOuadliEZKoaRJmq6tT
         4w6lloaJh+kE8GNXXrUItYqsIbEoEXLL++hRBGgLZmQRIuyxg5FEAvNFxc74O3tl13rZ
         iODKCkY9MQC2vo0oDpAEilVnYL9DV1qkK36coNSW4ibBTrVULH5a0yg4U+uUI8BwNEoP
         xwyXGUD85DJ6RvcgO7aihNJBXkAeWS1xPjQA98crvLb0jc9MxpJqC1xYHw6NScgOafff
         Obg+c4Z/J8niUTB2o95IganJUwILzler4iYeS3EmWh5eLdrJtnDa78J7Bh5O4XWX4FbZ
         h/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715675952; x=1716280752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8OfBUMWw4vRfdJG5yIvPigGCabXSzHeeUlvg2+VyM8=;
        b=tUTfRyqpAQY2xVj6+vE3Q1fuICO0xXQh2jsLIlOpRL1KKEiLL17as2mg7HhBxvGkm2
         pJUu6/GYp/Nxe02gZvO6VjNjLpNLJYhJSaaNY6JK/y6R6YLILC6+GcgeLHcM89ZSD+nw
         1vswKP9rHQWErQ9FkPMbhLjB67pTkKSyeIBU8ooV4DyBAk54eCp1IKhaoETaZXenHCFK
         tQoyW8zpUvJpHCRVo6HUnENURwuXUd+GmbkkdeeZsLvhayj58tT4P4j7nCk81oyXnqXu
         tH4lLmQUQ9PSv8If2NzQ7CigJGE1A2cUw/YsR/3GH5cUMZdm0Yf/F7kBwk8O9NJStQkT
         yuFg==
X-Forwarded-Encrypted: i=1; AJvYcCW/uqH4PgekZGfeJsKBYvNE4sModAeCrOtKzAVR1Sw8LkRP1bRgkgtW+tIG20qaNCGQKv26o3nTCdGeO4X8H///nGJ10T5XtqS4tzQ6
X-Gm-Message-State: AOJu0YwaJqWAk+xbOBbRtk4EPMTvkzMFyDadtErhkj03Ky4mBRKbMA7+
	D7WiYkZNz3V1LgBg0b0hJKxDEXXIwTO+9zthq4PdncpSiPgSA1xVTNnzhj2ys/QRB+3Wsi0LHHH
	MMasg5QjG+DLHmEC7rI+wZAJkbtiLFVdF6R/1gQ==
X-Google-Smtp-Source: AGHT+IE+i8Kx49jNAKC7DYTOj53slCNQaVb4nzqYGYIRKTSSy6zLL/hu+hHyIeZlCKLoskbdnjTAh/+WvCzLiGlNKFg=
X-Received: by 2002:a25:8b82:0:b0:deb:7eb7:c9ce with SMTP id
 3f1490d57ef6-dee4f182a92mr9653925276.1.1715675952187; Tue, 14 May 2024
 01:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219125350.4031370-1-patrick.rudolph@9elements.com>
 <ZkL2Sdf0NcqaZRZ4@surfacebook.localdomain> <CACRpkdbUye6RhbRNGn6sapARwVUyi5hKS-5VEVBr6ZR6W_KdQw@mail.gmail.com>
In-Reply-To: <CACRpkdbUye6RhbRNGn6sapARwVUyi5hKS-5VEVBr6ZR6W_KdQw@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Tue, 14 May 2024 10:39:00 +0200
Message-ID: <CALNFmy33wMHBcoU9ei0vVsn0gUM7-0jdkDDq_Loa3=mMWXiWcw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: cy8c95x0: Cache muxed registers
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, naresh.solanki@9elements.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
sure can do that.
Do you have an example where muxed registers are used in a regmap?
Is there some documentation available explaining the existing
mechanism? I'm not aware of anything.

Regards,
Patrick

Patrick Rudolph
B.Sc. Electrical Engineering
System Firmware Developer

9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
Email: patrick.rudolph@9elements.com
Phone:  +49 234 68 94 188

Sitz der Gesellschaft: Bochum
Handelsregister: Amtsgericht Bochum, HRB 17519
Gesch=C3=A4ftsf=C3=BChrung: Sebastian Deutsch, Eray Basar

Datenschutzhinweise nach Art. 13 DSGVO


On Tue, May 14, 2024 at 9:49=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
org> wrote:
>
> On Tue, May 14, 2024 at 7:27=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > Tue, Dec 19, 2023 at 01:53:49PM +0100, Patrick Rudolph kirjoitti:
> > > Currently the port specific registers behind the PORTSEL mux aren't
> > > cached in the regmap and thus the typical setup time for a single pin
> > > on cy8c9560 is about 200msec on our system. The hotspot is the IRQ
> > > (un)masking, which causes lots of R/W operations.
> > >
> > > Introduce a separate regmap for muxed registers and helper functions
> > > to use the newly introduced regmap for muxed register access under
> > > the i2c lock.
> > >
> > > With the new cache in place the typical pin setup time is reduced to
> > > 20msec, making it about 10 times faster. As a side effect the system
> > > boot time is also reduced by 50%.
> >
> > Interestingly that you have not Cc'ed me on your patches.
> > This, btw, a good reinvetion of a wheel which regmap supports already.
>
> Also sloppy reviewing from my side :(
>
> Patrick can you look into making a patch on top of this
> that switches the code to use the built-in caching in regmap
> insted of rolling your own?
>
> Yours,
> Linus Walleij

