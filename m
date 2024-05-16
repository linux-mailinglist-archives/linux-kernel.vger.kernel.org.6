Return-Path: <linux-kernel+bounces-181580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509CB8C7DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 23:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8214E1C215A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2261215820C;
	Thu, 16 May 2024 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9xpuRdU"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC1157E88
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715893561; cv=none; b=DGbdy8hUY9+CpWqiM7IuH6aVoJLRkd9YqgQhtKMD7ddel9EuET+0UEuBH372r/2CUPh4tkBOoSORmOnNQ2M4WBiNyjqq2wRAUKfpkH2n6FyOSh1c7v8+dwIRrp1P6dBhWwDacGImdxCIAmQDtdiFq79eXZdH5KTtqRkJw//Ip+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715893561; c=relaxed/simple;
	bh=kB38o85pn/GJarPAddnJlZVHN6WB91yX6h3Qc6dHZsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFjVolCHUm2dM6GZyNq7xa5l0+/HoMhNCYhA+w1C5Ot2HqIBM07ras6aMGlHcwfYWxXqyNskknckHYIrbU2tDrtjhSzHgk7TLlWh9rBAeOgkxlKD/LDKKyVYW6plb9vTxh/U/G9oZKKzSIEJVwgKsuvrXMfEo2ygyUgw3fZTZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9xpuRdU; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc236729a2bso8466532276.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715893559; x=1716498359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdQVJALIhd9J+5MaB3JGG80Txdx/1fS6o6hU1+crkwk=;
        b=O9xpuRdUUDqcRavlYV2GvPe9of4mRVouJb/lhck5tnxRggTC3cvzQYa2AIiiwt7jfl
         YrzTdIgdxy9DMN0d82cSpxjgRP14Kbs6S4fluFLs4Xue1ptB4O2ndn8c79HNmdyk1jmK
         nDS/FVDal2+jQtG1Onh9SRwKt0L8zm4fPVJ6Z1oGVpaEdw6qDIYo4KjQcfdgLT/Zz0iG
         fkH9fHaKUNexxDCGwFbvKK4zPikzh4C+y6XVuwBLxOTZb0jaxlD5AjDKpi4DxsSGz0Cj
         ZdCTpYMOjmju6Us4Av7NInpuyOYtofgEyDDkfzZYb0wY+56Ru4ONQJKgCV3YXoomRwEW
         MDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715893559; x=1716498359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdQVJALIhd9J+5MaB3JGG80Txdx/1fS6o6hU1+crkwk=;
        b=X/hN0OMOrP9kABNMI6roLf+qnN0JQbW6LQ1HCmPfwqGFmt8RLoF5xb5cOTC8J8/Rd3
         0Tjn9yshnvER8hZ0EdrYH42yvy2cadaAjCGC6O636H5mPn4ZjaHzy07jBl4iUAx7FL+B
         8WVHuK2H7C9iGUpdvjwd4AOu1zBC0BvvG1PfkQXRG0mqE2+NkcdFOE4fZijV6p4o2C3c
         M7zy4jIMufwXUMjBlqNd5pbkbyvsKgxefhtw0zktEmrRwlbT1X4U/CxeWhmG6tjM6+fl
         ybk0g1Wrp79iQCifJ4aWXpX7fAkHlKveccOGSB/9tIyKQoovMsb9+tngEjvNiqbNGSa6
         e0LA==
X-Forwarded-Encrypted: i=1; AJvYcCWGxauRc6iNBDMkRfvNrLNZq/fRPzimbBP1VfVRQ2X4WakS8sfAB8PfryeagV1rmN5p1XjoOEwvG53oFTmykVAKAYX7whcis2uUZSlL
X-Gm-Message-State: AOJu0YzkmyvJ7W/dYQPrqaOOen8g46DZuMQ1OiQdYz2V8T/Odx8ile4C
	YKrpHSaRmdxEaTgARXYu4ybJJUo74sA661GF2ZNBbMU/I5Xq4ZZQctkMtXMjRQ6vSju4B6veWZV
	scj4YhK5pWwjrUlwWG+gMF8tLEvjKrgjRSJbFVg==
X-Google-Smtp-Source: AGHT+IGPVI7xUKR6WSZ8Rlc31e14V3f37LgbLOEi82rBg1xrqYEaOrRWPX+MwjIkDuFNMNGbSL5VXpr3n/oPxM83b3s=
X-Received: by 2002:a25:8e81:0:b0:dc6:b820:bb45 with SMTP id
 3f1490d57ef6-dee4f2fe16amr18028910276.27.1715893558734; Thu, 16 May 2024
 14:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427-realtek-led-v2-0-5abaddc32cf6@gmail.com>
 <20240427-realtek-led-v2-3-5abaddc32cf6@gmail.com> <20240429063923.648c927f@kernel.org>
 <CAJq09z6kBRXKG6QVyfUO6qzKaOZL6sbRnNXu8aT+siywjX7xLg@mail.gmail.com>
In-Reply-To: <CAJq09z6kBRXKG6QVyfUO6qzKaOZL6sbRnNXu8aT+siywjX7xLg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 May 2024 23:05:47 +0200
Message-ID: <CACRpkda9W7SjX+saGY9U5ct6MdD_f-B6C0PTF0OffCRPEsEnrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: add LED drivers for rtl8366rb
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 7:30=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:
> > On Sat, 27 Apr 2024 02:11:30 -0300 Luiz Angelo Daros de Luca wrote:
> > > +static int rtl8366rb_setup_leds(struct realtek_priv *priv)
> > > +{
> > > +     struct device_node *leds_np, *led_np;
> > > +     struct dsa_switch *ds =3D &priv->ds;
> > > +     struct dsa_port *dp;
> > > +     int ret =3D 0;
> > > +
> > > +     dsa_switch_for_each_port(dp, ds) {
> > > +             if (!dp->dn)
> > > +                     continue;
> > > +
> > > +             leds_np =3D of_get_child_by_name(dp->dn, "leds");
> > > +             if (!leds_np) {
> > > +                     dev_dbg(priv->dev, "No leds defined for port %d=
",
> > > +                             dp->index);
> > > +                     continue;
> > > +             }
> > > +
> > > +             for_each_child_of_node(leds_np, led_np) {
> > > +                     ret =3D rtl8366rb_setup_led(priv, dp,
> > > +                                               of_fwnode_handle(led_=
np));
> > > +                     if (ret) {
> > > +                             of_node_put(led_np);
> > > +                             break;
> > > +                     }
> > > +             }
> > > +
> > > +             of_node_put(leds_np);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +     return 0;
> > > +}
> >
> > coccicheck generates this warning:
> >
> > drivers/net/dsa/realtek/rtl8366rb.c:1032:4-15: ERROR: probable double p=
ut.
> >
> > I think it's a false positive.
>
> Me too. I don't think it is a double put. The put for led_np is called
> in the increment code inside the for_each_child_of_node macro. With a
> break, we skip that part and we need to put it before leaving. I don't
> know coccicheck but maybe it got confused by the double for.

Maybe I can use for_each_child_of_node_scoped() and
get the handling for free? The checkers should learn about
*_scoped now.

(I'm still working on the patch, I'm just slow.)

Yours,
Linus Walleij

