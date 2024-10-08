Return-Path: <linux-kernel+bounces-355367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED30995141
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AF81F221B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3E91DF985;
	Tue,  8 Oct 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="es1Z/ANU"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF014EC59
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397023; cv=none; b=ippjFqZQqSBscXOXaiIBKmtBQ+7T7//1etcvcFOMOwFOvu6x6dy6UISYa3oNhGBQ2IqYwf5KSyGvaEyp8Zr5c8uy1HpE7VPr3jOZslFEfpCXHwoqlN/rpmpjgJJig1ajO+tgPykycMg6lOi2flbK5v4sIBrsb5gFq6EctYDNpBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397023; c=relaxed/simple;
	bh=UkTNdZ4bOXW8oYPKMVJ6hvZIHf+eC5vYvqnPjPO6TUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JK+n4r+yNjZQPCrgK/XNRnnVSDufoQIlgQN390PfGFmbDaGWY2CaXIYJLTd5RcULrESiqkVRQ1riS9yKcqEiyf6EeTK8aqNdKn2okpEmEkEKKH4/O2XfKA6rT6aXB13BnVawflfED8j5AHfoWOPM8QBo5yowjm3jSAMEhYswoJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=es1Z/ANU; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e262e36df27so5532637276.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728397021; x=1729001821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP9h4DJsAwsrhGSa7N8S+hvtyECH+0TD7DFBPSUfj1g=;
        b=es1Z/ANUt/2PuzCddIESCvJWQXyWBIpTa+DcAiz1Qu3zScHDzYLORUfKAM+owpaDuD
         4YmePfhLxY7rUl++J7OpQDpH7TE9Q1t6X9Qrxq+qYxi1awLPh2cNVmiQWU2ZZBEzP97i
         eO7boOf7GKDTzfqZ58T11iAxRhdd4WTclbv5Ylmf1YyMhGG+s1ACfS01mEq9/6pLI5+B
         EX4qEJmA3OnqXba1vU6mPdoqSO35llznnYU9ChBgGaDyP72sRZCPe4imnynfS7lqNXF1
         zTaZwujmMywxv4zZCxvaDGgqnqDMp1HH6OUhvhIzo/f6vz+8Tirjgblgwok+O7nPh8Pn
         7a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397021; x=1729001821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zP9h4DJsAwsrhGSa7N8S+hvtyECH+0TD7DFBPSUfj1g=;
        b=Va2OO27eN/g8PWXgVUexXmpawD/fuUj8DADO208hV2Ai3qdwfclfiPl7HpyY85s7sM
         +/pQZDx+1DBv4OtugFquBip5YcWbf01Q5TXeDEJsSZp8uExmZAz/Hv4ynKETFoq/9e8o
         Ca0KQHZmpDGFhxRFuqpa8yR5JhC43/m2mXM0urxAuuls4QSkixouFFwknPLH4TDlgdZa
         GYXp/EFkOfDH7B87V9YNAa86cVqAMCuybiH+WgqZYusIsyZmbYlzEH6lrOVfjVZRAOzP
         T5CA4WgSulpgQI8zMXq+jTJPOUNJJwFoyrHc5OglPnm1WSa7fnG8v48Bzw3C6Fh1zNV/
         8Kyw==
X-Forwarded-Encrypted: i=1; AJvYcCUfngQhYSJr5DYq6xSaH43hLIzAqHb1OG8GUYfUM0e8X5tQQSOHvtqQmjqGxTenolMXL5/zAF4TWX828bM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2QvtqCGHnmwg1RCk/TaDxmgemJRQ6jy6UdAWTk+RnnnNc8uBz
	LYhFKPo+UvfNjKCBzd58pehVAZSy65rjgRBUIxSAoRZvHaHIOM9WIJbuX8HXKcmemKMck6WpT0h
	kvtgCA5U0i1krEVw6GMQkZ1zYderrK9KSAhL/0w==
X-Google-Smtp-Source: AGHT+IFurydxnrI+CHeh0ogyuTUXiIwB25WFmX9OYU9Dg8GrojDvKYyR0qSp+PNVc4F3L05RqX7iOmnnS3SL4rXngFc=
X-Received: by 2002:a25:b34d:0:b0:e26:acc:4088 with SMTP id
 3f1490d57ef6-e28f9bad98dmr276784276.27.1728397020952; Tue, 08 Oct 2024
 07:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007114549.51213-1-brgl@bgdev.pl> <ab1180ff-b435-46c8-82a8-66fea41db110@wanadoo.fr>
 <CAMRc=MfrQNc1idCD8fBbOx5bWzCU6f-Ryefu-eoxfzOaA8=_Fg@mail.gmail.com>
In-Reply-To: <CAMRc=MfrQNc1idCD8fBbOx5bWzCU6f-Ryefu-eoxfzOaA8=_Fg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:16:24 +0200
Message-ID: <CAPDyKFpNuKMQhqiWhOz2j+9Ubj_FaBb54x-GincD6m2n6UbH0Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: fix snprintf() output buffer size
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2024 at 09:13, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Oct 7, 2024 at 8:09=E2=80=AFPM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > Le 07/10/2024 =C3=A0 13:45, Bartosz Golaszewski a =C3=A9crit :
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > GCC 13 complains about the truncated output of snprintf():
> > >
> > > drivers/mmc/host/mmc_spi.c: In function =E2=80=98mmc_spi_response_get=
=E2=80=99:
> > > drivers/mmc/host/mmc_spi.c:227:64: error: =E2=80=98snprintf=E2=80=99 =
output may be truncated before the last format character [-Werror=3Dformat-=
truncation=3D]
> > >    227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI=
_%s",
> > >        |                                                             =
   ^
> > > drivers/mmc/host/mmc_spi.c:227:9: note: =E2=80=98snprintf=E2=80=99 ou=
tput between 26 and 43 bytes into a destination of size 32
> > >    227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI=
_%s",
> > >        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> > >    228 |                 cmd->opcode, maptype(cmd));
> > >
> > > Increase the size of the target buffer.
> > >
> > > Fixes: 15a0580ced08 ("mmc_spi host driver")
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >   drivers/mmc/host/mmc_spi.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> > > index 8fee7052f2ef..fa1d1a1b3142 100644
> > > --- a/drivers/mmc/host/mmc_spi.c
> > > +++ b/drivers/mmc/host/mmc_spi.c
> > > @@ -222,7 +222,7 @@ static int mmc_spi_response_get(struct mmc_spi_ho=
st *host,
> > >       u8      leftover =3D 0;
> > >       unsigned short rotator;
> > >       int     i;
> > > -     char    tag[32];
> > > +     char    tag[43];
> > >
> > >       snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
> > >               cmd->opcode, maptype(cmd));
> >
> > 'tag' is only used in a dev_dbg() at the end of the function.
> >
> > Maybe "  ... CMD%d response SPI_%s" could me moved directly within the
> > dev_dbg(). This would save a few bytes on the stack, save a snprintf()
> > in the normal path and fix the warning without the need of magic number=
.
> >
> > just my 2c.
> >
> > CJ
>
> I would be hesitant to change this logic here. The cmd struct is
> manipulated pretty extensively later in the function which leads me to
> believe that this snprintf() here was done on purpose.

The cmd->opcode and cmd->flags aren't really something a host driver
should need to change. It's the core that sets them to inform the host
driver about the command.

I looked closer and it seems to be correct in this case too.

Kind regards
Uffe

