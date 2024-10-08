Return-Path: <linux-kernel+bounces-354635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8506D993FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E72C286975
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C111DA61B;
	Tue,  8 Oct 2024 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YIfOcAwa"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58E1D2B3C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371623; cv=none; b=JWbSpK+qnnw3eYlXe+Wx4sXqZ70n7d+K/QH4v80kOAHJTfygi2IV6/3QPtxXx4d2S0lccMuz1ObTqRpEXVawqzyqOzHIOAmjGA+b9eIARNvJZ0JGvh3CUTA+RBQCYgTLjtki1PD/Pkrqqu/FpO8M0y/lpnU3PYQTPu4bVXO2z/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371623; c=relaxed/simple;
	bh=Qqnen8OlMTA+nOtnPxWjEuzheQicP9ePILel9kENRfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPWL4miKhMZwjyhTAdKUGJlI0jCSk/EqpV9Hx2CThiLZJ4t7HHpVEnr+LtdKj4PoVZGqBKuruCj5H9ueEQMN5H/0reu08kRDmOANB1qNo+sC1xwltWxL0DEs1yEdXfRQDlPfBm2FyIJ4q2IJ4yzTqMnzB1gPBsAaX6riNKakm9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YIfOcAwa; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fad0f66d49so78339061fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728371619; x=1728976419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyH4WgH6K9qfphCXNjPyqAa7TRjWzHwQ7qZITx1WeNM=;
        b=YIfOcAwa112DDOlYkOiLJ46EN+/4cnHGJgoRjGS4OPpX5D1d28yr592F27J6VKiguh
         1zbHXjcx+FZiJ+Is7ti9xwjhsN3jVg9AsOTWzmdOwEEtoTe36RHz/Ncuv8tNs3LhTSpw
         adPs4dOo1fh4/nXF/EgFvCRRm5u9+zpa7ZViu6ZgNLVDyL7UFgtyGqF6m+ZQdhyKB+zI
         1YFlVafLwaH39G8AjjMF/v0c74TmC73BCJKyZI4M73HQ/TLaBX3JVuQIBiCD6Pn6fwFy
         W0yg8CHuqi+65ZMOmdGKMQyT4z382KwQ5W9CRs7fjAO/l/bchaJRo78aJeUI+Mce+nlK
         otrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728371619; x=1728976419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyH4WgH6K9qfphCXNjPyqAa7TRjWzHwQ7qZITx1WeNM=;
        b=ZvVl8hWkxs/KC6sxvqpcC4WTcLnHZGwEX+BuJRRiC5pV7mFb514+YkftTwHHMA7BTl
         bdbm6RRbWAsekoa95ZJjtAL03lBORNCQerDGsvm1Olu1hKawNIcj4OHpdkuXgBFbYrut
         7NmCmiIq0kISCoktcSa+7rFGf4yNIYp6MLtMvYz0ULG6fFhcumq1GejWXM72n7QHVd6X
         R/LKWNkApVxvdHezyTQ8ht+Cev4aSyyPCXRIziObOoAFa2wgt62EIKMv5iL4QI8Gx1xx
         q0z1hlhYxVn7P/omgFnb/1VizA83xAs0HEP75eCB2s86qE73hbkrs8audYvV34Nbt4ZB
         9j5A==
X-Forwarded-Encrypted: i=1; AJvYcCXXnARXXT+JOJmC0wMTQ1tr7CmMsTNVq0c1n72DOYLE2dfiS4Dz5kRoSgjiCAdT/8r+9RSlP0I4gftj8aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyzTdXjJ7ebjY9XpA6puVzbU3FSBDTPXiIPoaEGRj+qAtAuX/r
	asgFUqO72rF6zW0VtS2vNVQs2dxNxfJL+q6oCjtY2w5hd3n1hdOtSiFmB4JcKxSqOCgOc0k8Qvd
	/aZ8beo4yZQYAdNAlITalI3SgXWXn8UYBLOpgJA==
X-Google-Smtp-Source: AGHT+IEGDyNNIFgz7oFW2nn+cUENIDzldCDjsaV6cMS7EfRvqGpqKJC0l9Ii005Lllt4UvuPrVI0kkNZVXpqY3u+Z/g=
X-Received: by 2002:a05:6512:33d0:b0:533:cf5a:eb32 with SMTP id
 2adb3069b0e04-539ab8741c0mr7295385e87.19.1728371618606; Tue, 08 Oct 2024
 00:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007114549.51213-1-brgl@bgdev.pl> <ab1180ff-b435-46c8-82a8-66fea41db110@wanadoo.fr>
In-Reply-To: <ab1180ff-b435-46c8-82a8-66fea41db110@wanadoo.fr>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 8 Oct 2024 09:13:27 +0200
Message-ID: <CAMRc=MfrQNc1idCD8fBbOx5bWzCU6f-Ryefu-eoxfzOaA8=_Fg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: fix snprintf() output buffer size
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 8:09=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 07/10/2024 =C3=A0 13:45, Bartosz Golaszewski a =C3=A9crit :
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > GCC 13 complains about the truncated output of snprintf():
> >
> > drivers/mmc/host/mmc_spi.c: In function =E2=80=98mmc_spi_response_get=
=E2=80=99:
> > drivers/mmc/host/mmc_spi.c:227:64: error: =E2=80=98snprintf=E2=80=99 ou=
tput may be truncated before the last format character [-Werror=3Dformat-tr=
uncation=3D]
> >    227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%=
s",
> >        |                                                               =
 ^
> > drivers/mmc/host/mmc_spi.c:227:9: note: =E2=80=98snprintf=E2=80=99 outp=
ut between 26 and 43 bytes into a destination of size 32
> >    227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%=
s",
> >        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> >    228 |                 cmd->opcode, maptype(cmd));
> >
> > Increase the size of the target buffer.
> >
> > Fixes: 15a0580ced08 ("mmc_spi host driver")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >   drivers/mmc/host/mmc_spi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> > index 8fee7052f2ef..fa1d1a1b3142 100644
> > --- a/drivers/mmc/host/mmc_spi.c
> > +++ b/drivers/mmc/host/mmc_spi.c
> > @@ -222,7 +222,7 @@ static int mmc_spi_response_get(struct mmc_spi_host=
 *host,
> >       u8      leftover =3D 0;
> >       unsigned short rotator;
> >       int     i;
> > -     char    tag[32];
> > +     char    tag[43];
> >
> >       snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
> >               cmd->opcode, maptype(cmd));
>
> 'tag' is only used in a dev_dbg() at the end of the function.
>
> Maybe "  ... CMD%d response SPI_%s" could me moved directly within the
> dev_dbg(). This would save a few bytes on the stack, save a snprintf()
> in the normal path and fix the warning without the need of magic number.
>
> just my 2c.
>
> CJ

I would be hesitant to change this logic here. The cmd struct is
manipulated pretty extensively later in the function which leads me to
believe that this snprintf() here was done on purpose.

Bart

