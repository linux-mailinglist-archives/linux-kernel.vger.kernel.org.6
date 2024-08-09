Return-Path: <linux-kernel+bounces-281114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DA994D33F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A1C1C20E9B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB631990AB;
	Fri,  9 Aug 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0s2K0Y6"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E633198E70
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216701; cv=none; b=SHP0tCNsOmm/lscmjbkkgsZ5Actk5MSmdnGOFVeD+c+x9KJeApv4E0/LC99mUvQYewmY+T/gI+X90cvWKt+vmyVzO17KRRZJvrHD/CzXfLgaTxkcru/A8ZuNv0IxWnsKI2mqLFkSoLMX+jM/FS/FHniqu88LAIo0Wf21UW2s7PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216701; c=relaxed/simple;
	bh=/EM3q5IlSCIFwsDkAPs+OHdl+L/TU8svrKcRrbqMQTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJtKMCDzunSKg3m9/ToCpTEtfYy6Fg+5fIA/j4OjXrSyFCMeHCvYxlp915MbTD0d06RlZYbJpjPCDPuyFWF6jbj/zM00xz1l4WObjfJv03w1SqG/hizhmTBRZveB0aiRAErgtiuf3qxkI7djN9KgfbRFpefRvGJvGg5ij5YFUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d0s2K0Y6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so1969327a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723216697; x=1723821497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SkAuA0TQuIJubT/gzLo1Ew+hKYWcgbM1/4Xh7Rdb5UY=;
        b=d0s2K0Y6uIqM9P6nqLFJuRuy0OUbu1ExNw0/yrPW2670lWk0xYE94V/NQhq7QF5uLS
         /k/+AtdWfIMbWXDVszAFSRayB4inp1K2Ow7yfHOKQhEAWavHUrMo6kW3Wa56GoRehwmj
         Ujui2BgbGmfESX3tN3JNkPxS3Ee38TvPKNZ+Ks7jI/5y6ENHDlUeCuf8XW2cM5vlXmm3
         OZKgSpWZpH712A65quA0a6lwMS5llhvrD4oiTAUmJvhAeJv6fnTw5R0rxsZzHBJW5qHa
         PnuY8RvJCsb04a+FVFUdempeVXmXhzY9cw8Tg4BHtVbdVqQ+9FPvPL9gSluRUtN2kQWI
         w/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723216697; x=1723821497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SkAuA0TQuIJubT/gzLo1Ew+hKYWcgbM1/4Xh7Rdb5UY=;
        b=srLfSOUtFJnzIwRw3HvJyVpklMIpawEfj21lZbmOsxNPLtvkPEOR1aZdpR3wd8DxFk
         eiBcJEkK9NQjTBPeWCkf6MUSVeslWxSLXySvGskBslAvEAE2pOKyPV0x6OKQSHA1ckjH
         T0bFJcY7ZjLpjNouiUSs4McZj850RLA4U24GmLRlmTghSXNmQAKT88MaYimGH7xtHX/a
         bdxVGQPnN9F9235LkObZ/0A76/y0nByBGbjaFCiK1Be86BjKOylCoJN37/7y3xaScGXQ
         /p9BZkDPhdXeb2iPwzBJKud5bEygJ7VR9iVEWVlAf2nj/Vf92Cx9vu44pmnb8zqO23gf
         oBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCULunZzHpaQNxH9JmsKj0gS1/Of0zDGfOn4fVyGDqpc27gOFr7lfbzdPcZ6r1sWONAlnFaGoWfItedSSZiZmK05hPHjmbnJ+N/xlVZE
X-Gm-Message-State: AOJu0YxjhuAqtU5jnuytMrhPfYVh06w4P9kCj277IRxoYQvRu94iilmK
	hRYx+LTt+u0bmvISUESlFF5fu4GAt8geEcF4MnN2+kvg5pw9EIEdm0oyCF5Rft0=
X-Google-Smtp-Source: AGHT+IE3BF3RiUwYRs8zj48//qSl3fhqZ7h+NxAGnToZ43JzPUYNcvOhzjSvbMJ6Al5z5IWbyrhHjg==
X-Received: by 2002:a17:907:e663:b0:a7a:a7b8:ada3 with SMTP id a640c23a62f3a-a80aa5568b0mr149264366b.3.1723216696813;
        Fri, 09 Aug 2024 08:18:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4392bsm850371766b.108.2024.08.09.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 08:18:16 -0700 (PDT)
Date: Fri, 9 Aug 2024 18:18:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, jic23@kernel.org,
	kernel-janitors@vger.kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: pac1921: add missing error return in probe()
Message-ID: <9a98aab5-bb68-4206-9ecf-32fbf6c9c7ef@stanley.mountain>
References: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
 <36b1a47a-7af2-4baf-8188-72f6eed78529@wanadoo.fr>
 <66b5c5df76766_133d37031@njaxe.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66b5c5df76766_133d37031@njaxe.notmuch>

On Fri, Aug 09, 2024 at 09:31:43AM +0200, Matteo Martelli wrote:
> Christophe JAILLET wrote:
> > Le 08/08/2024 à 21:28, Dan Carpenter a écrit :
> > > This error path was intended to return, and not just print an error.  The
> > > current code will lead to an error pointer dereference.
> > > 
> > > Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> > > Signed-off-by: Dan Carpenter <dan.carpenter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > ---
> > >   drivers/iio/adc/pac1921.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> > > index d04c6685d780..8200a47bdf21 100644
> > > --- a/drivers/iio/adc/pac1921.c
> > > +++ b/drivers/iio/adc/pac1921.c
> > > @@ -1168,8 +1168,8 @@ static int pac1921_probe(struct i2c_client *client)
> > >   
> > >   	priv->regmap = devm_regmap_init_i2c(client, &pac1921_regmap_config);
> > >   	if (IS_ERR(priv->regmap))
> > > -		dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> > > -			      "Cannot initialize register map\n");
> > > +		return dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> > 
> > The (int) is unusual.
> >
> The (int) explicit cast is to address Wconversion warnings since dev_err_probe
> takes an int as argument.

I don't want to remove the int because it's unrelated, but Christophe is right
that the int is unusual.  We really would want to discourage that.

regards,
dan carpenter


