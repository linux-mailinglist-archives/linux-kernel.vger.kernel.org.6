Return-Path: <linux-kernel+bounces-311774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6D5968D6B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50F12838E5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340D19CC18;
	Mon,  2 Sep 2024 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UY9Z1Chi"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C45680
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301742; cv=none; b=WytB74jo8gaCIMLP+OSHJKUzJGKdnVnvPwBc2M8N7zrlCDAjFh15KLwBvt0RhEzQ1ylvPcFHEGJ9c5Oa7h1yZ0VWUeIuY3p3ligg25i+U5Z1OUTA1rlT5OWdjPE0Jev8sMzMubX8TMZ+XaVWlPmQ6fGxwwlIkvYV2CaMNyAl0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301742; c=relaxed/simple;
	bh=t0E67JOygrLpMEMGSs25nFjDBPpRV6ypA1lR9ObqNU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FE3CPk8sWgJWgb/beVML7OJ+nzJCkb6VinXTf7ElolVnytmIJ1aM8oiTOxvshGLscxV08/1gzeFBJZmcg6gsaUynb5czvLrEs/xrcExIbnii6FTZd3XbcyoPt1o+8AJGFHUDpeIZKzPrbp80ppUVTvbluYgj4KIR3e5B9XHK3S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UY9Z1Chi; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-846c59979efso468478241.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725301739; x=1725906539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIf5ftqS5rRzhHiAEScVat73BFgeVAnuYHMec3uMxpc=;
        b=UY9Z1ChintIBXZvS7iiHgdT1/6nZXbyqjO9TaJVljF0kMo+pnDiPQY5CmefkoJIaOE
         PbStIQw3m0cegOqufJPOzULEZzqlbYLnnkpDaA8ZBS7g+q3nKGo4bWXv4n5GkF5Vr6LF
         MQS7Rs1d66z2el+GUIXw9032xRxGvzv6+NmZKi1ARIqEFhlP6fF+sKjowuqJJ4F0DDrY
         Z8AzhIBdoMdvxInahapjX6VcQnuIgE5Lhc513CQUNMfoS4+yofQzzQv4h6PpCMZcYMnF
         zA1fsKg8tfuLQIxnI0xkF4+0eMyA4iQ1ubqgmgGmIfEbYjRTPOssxttLz956wxXGkak+
         zIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725301739; x=1725906539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIf5ftqS5rRzhHiAEScVat73BFgeVAnuYHMec3uMxpc=;
        b=uhJLwozcc/qEkZjj4wlXbZYbWkn9PWIduXxyk3f5PU8I1Kzrt/wNx5WSNiNcrCdMxR
         MnLF2fdUQNY91sLx9ZDdHbcb6MecjPrfkUn2Hy/LnCVqxqO+AVYYl4NYJLJNy58WhX5W
         wV3gpuIg+7wsUvurzXUt7H7pCCtOnsS+VQDVf89P2PYKlEuBjgoTerpjQYcr5xDc1+Hk
         4/6VSb3aUx1I48XzqlbcjlX8eivFmCdOg3Ar+NwNcQZcHfuEhXLb+udCrluYCKXf4CJD
         ILboJdOvtJUi+EIddQXkneNk9XaKKOFhD7jVuYUXGDK1LubQbTqhqQEWEne8UhU5vrya
         bmiA==
X-Forwarded-Encrypted: i=1; AJvYcCVCEMDbMQB0XzCe+Y48iLpJz/I/kf027eXLb/wfsxPcF8cxY0SvB4zm+DaSwRkalDP/zpYV8nU+Xh6ue2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YymDHW3tJy6+Aa5Gu2bJUSI0fg8gcRxs5L02pxXNwjzH+i3HS++
	NRUGwIPOWN135tcoiIwYhpzbLS29UDWVA8eqyWbuPrEzf41FeE4ta/treXGVvcUk04HkxTAtOMk
	NqSxllbunoEfFhjza4AeCPJAx0lLaHnswQxcBuw==
X-Google-Smtp-Source: AGHT+IFNN2YsGI4d9NkyVLuaCOIeDwnWgM8L40kWHQUqrjU70AVxBuLatdXI26wVgPjb7BnwfErs7+wo7zLY8grbChg=
X-Received: by 2002:a05:6122:2225:b0:4fc:e5c6:be51 with SMTP id
 71dfb90a1353d-4ffe4a5d540mr17617641e0c.3.1725301739139; Mon, 02 Sep 2024
 11:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902103638.686039-1-aardelean@baylibre.com>
 <20240902103638.686039-7-aardelean@baylibre.com> <pu536g76q5xanhwnvhpr52mttonb4gkmxfwwof4fyo4sww2g3l@6s7x3joiuzfa>
In-Reply-To: <pu536g76q5xanhwnvhpr52mttonb4gkmxfwwof4fyo4sww2g3l@6s7x3joiuzfa>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Mon, 2 Sep 2024 21:28:48 +0300
Message-ID: <CA+GgBR_uO-qOP8mRCmWdhEFMJRz4KvVvpx2tVVsZy2iZCvPD-w@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] dt-bindings: iio: adc: document diff-channels
 corner case for some ADCs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 2:54=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Mon, Sep 02, 2024 at 01:36:29PM +0300, Alexandru Ardelean wrote:
> > Some ADCs have channels with negative and positive inputs, which can be
> > used to measure differential voltage levels. These inputs/pins are
> > dedicated (to the given channel) and cannot be muxed as with other ADCs=
.
> >
> > For those types of setups, the 'diff-channels' property can be specifie=
d to
> > be used with the channel number (or reg property) for both negative and
> > positive inputs/pins.
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adc.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Docum=
entation/devicetree/bindings/iio/adc/adc.yaml
> > index 8e7835cf36fd..9b7a8e149639 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > @@ -37,6 +37,10 @@ properties:
> >        to both the positive and negative inputs of a differential ADC.
> >        The first value specifies the positive input pin, the second
> >        specifies the negative input pin.
> > +      There are also some ADCs, where the differential channel has ded=
icated
> > +      positive and negative inputs which can be used to measure differ=
ential
> > +      voltage levels. For those setups, this property can be configure=
d with
> > +      the the 'reg' property (i.e. diff-channels =3D <reg reg>).
>
> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run  and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.

Right.
Will fix.
Seems checkpatch.pl is able to catch my stutter.

>
> Best regards,
> Krzysztof
>

