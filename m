Return-Path: <linux-kernel+bounces-250811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC33292FD1C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882E0284B97
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB71172BCE;
	Fri, 12 Jul 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HwubMhZ5"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABB16FF2A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796561; cv=none; b=acnO/R9zX+F/9A2PgGPNCyyKVr3703QTwf20JMh0ETMnzCWb5DUzcDRbjD5sA/6JuQBPUpKmARdB2Mqz2YhsFV3agLr23Mqgj3b4G+isk6SnAD+lROQS9qTy1GbOUsaBRW7QVHwMlqBhMfp/N1EAHHhIaX6BGxeMH6S0NtodCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796561; c=relaxed/simple;
	bh=JxUhY6aFnfTqV4EnVHeh0A0eZrdMPKNwHIpwp2b3p7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ug8LUqqRP8sZ3nWppB6n2FhvcckC6s1yxkH8OLwf7n8CFc016u7oMQTEPAw/5LrqqnZMR9WItE/GKs11/P/9HGwZwRNT3VZDaacBl6wHFSgc0eGEFwWBJBd6+hqhfapsiAEEF6NMnnq8/3OZUsJdMNVlVBQwTUuK2/MLSSUoFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HwubMhZ5; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eebc76119aso23744941fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720796557; x=1721401357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zybHRsg6ttQvQpwhImIIj4EmqKlECjv/dWEeEmt2KaY=;
        b=HwubMhZ5k+bXCYgRI93yPHFmuCbJPgSfsEG5w1CkBWrouYqjBdEFfArrRwPdnV8RPd
         4c2ehPK8u0tIOHYKPBNa7Do2HDARPknxqYkhay5lby/DubIlSSFoPaOaYxe/y7DY07hI
         3rfbvo/uox4kANXfv4fbPshYRU70qBzhD2WCSGmUmYnORRJzb9RT41UtsSJ7360/7BmY
         D/MOqTI4Udnozkih2ke341GeDOcOFB3iSJr9aGr9EwS2VtL3ow4rH3lRr76f6U+O1tw+
         L0VwAYDntHGT8iG9jUTppDuJ1fOqWR0ePqKklyxPpSYYFpm55ATDsXBTvZK+qQMppPwf
         h/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720796557; x=1721401357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zybHRsg6ttQvQpwhImIIj4EmqKlECjv/dWEeEmt2KaY=;
        b=JMhinWjYeBfvR9MaJKN1gGUnshlGT194M96+4RKjWwiWypXklA1Pdp44z+KZ0Cj/4/
         iNoGO0ljrGbbZkL42ddIuaZ1QL5K5tES6VA8y8xuXpZoJlfUumhrZ5o+hbfDi0uKEWu6
         q5Xvdkd3CWw9aD89iW43iR5yLtovvIyUa7+CEuwWySpB3fb9eO9UCdrhvqobLC/AxmQ3
         jorLr4u1txi7+gDdCkbbMPAzvePw2TzavqccavyR37zY5LVrI+qbykNO5J7NLs+uLyGl
         iEP8hE89C5NyuyzqxMRH+9OsyUB+mhyiP692fH+EAuyBJkYh6SMCj0lEpbXo1UdAcB8I
         HlFA==
X-Forwarded-Encrypted: i=1; AJvYcCWphkYJ5qQrKVDwB3ArlUGwc+QP2sgxlZItHspBDarZo6g2SsQ97I9ZYaf+8FObevu3Anzu1qBfH7oXiqBoLfIxaOeIkT7vBd53wrx4
X-Gm-Message-State: AOJu0YwRFTm8EZg3/tzVLPJ52U5Xb4oMR5G/7lMe+MLHFnMblPQJLRjR
	BUVg3S5vkZd/V2J6tYAAiYocq7h/JGJE3LiGl9nycr23cINmg/SwRUvuy1GyRcH4oQ+9SGh3oUC
	ldHjpbHVL0JoN7yMLT+OXbUyzVTRgEQbbNOlwIg==
X-Google-Smtp-Source: AGHT+IFJuyUV+IvISOZ1rScSYaRd98TacloWXfDBCLgGa7gjmHDHtTgIot9syj+L/LjsalpUbC9fXQ/4vt/muOQDla8=
X-Received: by 2002:a2e:834b:0:b0:2ec:f68:51de with SMTP id
 38308e7fff4ca-2eeb318aaffmr73599931fa.47.1720796557119; Fri, 12 Jul 2024
 08:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712144546.222119-1-brgl@bgdev.pl> <7d7dcc46-2042-439b-a744-49ae4b507839@suswa.mountain>
In-Reply-To: <7d7dcc46-2042-439b-a744-49ae4b507839@suswa.mountain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 12 Jul 2024 17:02:25 +0200
Message-ID: <CAMRc=MdqZZLJLrAb10amgZSz40k1qAVMohVeUvHqobEHR5qaZw@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: fix NULL-pointer dereference in error path
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 4:59=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Fri, Jul 12, 2024 at 04:45:46PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We may call pwrseq_target_free() on a target without the final unit
> > assigned yet. In this case pwrseq_unit_put() will dereference
> > a NULL-pointer. Add a check to the latter function.
> >
> > Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/linux-pm/62a3531e-9927-40f8-b587-254a2d=
fa47ef@stanley.mountain/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/power/sequencing/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing=
/core.c
> > index 9c32b07a55e7..fe07100e4b33 100644
> > --- a/drivers/power/sequencing/core.c
> > +++ b/drivers/power/sequencing/core.c
> > @@ -119,7 +119,8 @@ static void pwrseq_unit_release(struct kref *ref);
> >
> >  static void pwrseq_unit_put(struct pwrseq_unit *unit)
> >  {
> > -     kref_put(&unit->ref, pwrseq_unit_release);
> > +     if (unit)
>
> I was wondering where you would put the check.  But it needs to be:
>
>         if (!IS_ERR_OR_NULL(unit))
>
> regards,
> dan carpenter
>

Am I missing something? pwrseq_unit_new() can only return NULL on error.

Bart

> > +             kref_put(&unit->ref, pwrseq_unit_release);
> >  }
> >
> >  /**
> > --
> > 2.43.0

