Return-Path: <linux-kernel+bounces-386027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D399B3E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36C41F2313D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6DD1E883F;
	Mon, 28 Oct 2024 23:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ycjjJILE"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF5F18F2EF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156880; cv=none; b=MzKL8uKMRV6G/8dv8tIT+rV8RgdViTLTav+48XT1/aJoPoCkGGjwCrryfrargqP6HEJlgqfk4Uxg4Y10UPF9A4vKvktvc/lwIdfxBxM+Y6/Lz8prsKBBnc+VCu61Bx9U7j15zwCXT+FDElywraIg1daE2gRzkEDgIDS62sUH438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156880; c=relaxed/simple;
	bh=r8m29dut7CLv0z4M6Eneeh9RovMTQuy+Mm0z00mqUhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5I0D0VUptP1WjYyqOFAM02uBNTWtXO/m1vXYSGSSp//QMt9LDQOhR1dOlxSN+2JflMidQutfY+67Z077cLQLq1omLtzoLQ/aF/zQr6huIgzHK8k7qx750fppqDmQ/5HYurNgkk/bhoYbDkIkOJph7cFbDMsDVU3G04dviFJjP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ycjjJILE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so3157376f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730156876; x=1730761676; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VP/iVVZlPSA4JgGDAYpI3asuv9cK2lkgkGe5iKIY9fU=;
        b=ycjjJILEAxL19Kn6R2JJI/dUAWzuwFpcihs3wIbp+kkkIrqCgckculcnmvX43VK1iN
         OuTp/qmrqY9jOkRpUze8wXRksFRv3BJt4WWnMNd5HYAcJOSvUsTpO0ihd5B2agb4eKM/
         TRdPuA0+yVuh/dBrdm7hi3uxLLS52oqedqU62dxenDkbLx5G/ZwjN6cvuzSZ/OX6bkOh
         TdLq+qZT0E6/6mRC5h7gsR+Sjx0ZiC17GMRwB11AR6pCoj64cSTQjWGNpTpKkSB++kBp
         y8gLl+JPaqeoW1pOyJ7QoQB4/TLyYLCxB/RPKzNY3pN1njlB8mVYKknCuDuOnwqVy3wW
         iMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730156876; x=1730761676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VP/iVVZlPSA4JgGDAYpI3asuv9cK2lkgkGe5iKIY9fU=;
        b=iji+cs6uhhKrc4lwgP6SNiMKlnEnpNWaNQqnxiYJbINOy8GO/t9/2NEEQ0ZDevBlsr
         j10NxfBopH3FWPVgcQoSlZYqQY6SIpYsCt6BXeafAsDgZDnLq+4qoXn7sNQCguqxzw1k
         I4XUA6CCC6wqlXnzbK3RDyqI3luevujUDIMww4fNne4FpCw4RKASc79NVCvQfi6CzuNP
         ZMpMOzB4ykrqfOXVKyGAMAKioJ0oUKmosD+rx7iz5j6BqWU1SghSP0ZaYdj29Mymn9vw
         FvHnqV5beLTpelwEH3U796nX1p6YPVINIdGoDh5VE4ZLkV6sEnTcMg6z9fhTRh/3E3k+
         EHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX027/YcTBlhOIADXFrlIDogOtIVuzIhT8eOAh42u+RDSXItpWm/KDihP6VZ4A4Y18pg/JJRNfsufbSUQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQPOAHD3MiDKGReKA/bpSd8t5HN0D5Km/LneVyul0n/l7ZlOtV
	AiHcmECps8C1UM/TtbWfJwL9cc4+zVUzCgmFiN9t3xiTfv+gS+GiM5/MU2aMqh+rjaPbXoBQrgq
	I5amp+L3Fu9NCdX4Yf6QHLTc9WIXiNVj7r7aeVA==
X-Google-Smtp-Source: AGHT+IH3IRGqEzsZIcZx1mMWA2ayFdlukEiYHLiKh3l+Pmq6hwsflbOGf2Z3lYNjBwlhvWUulskbv2DJzBbGuREWywA=
X-Received: by 2002:a05:6000:cc7:b0:37d:4e03:ff86 with SMTP id
 ffacd0b85a97d-380611fe549mr6247995f8f.49.1730156875731; Mon, 28 Oct 2024
 16:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028071118.699951-1-ahaslam@baylibre.com> <20241028071118.699951-3-ahaslam@baylibre.com>
 <oy25ajhj7hgg2lk6i2xpkceisoveloc6i6z5sank44jc7i4f6k@xpqgqjpcgn34>
In-Reply-To: <oy25ajhj7hgg2lk6i2xpkceisoveloc6i6z5sank44jc7i4f6k@xpqgqjpcgn34>
From: Axel Haslam <ahaslam@baylibre.com>
Date: Tue, 29 Oct 2024 00:07:19 +0100
Message-ID: <CAKXjFTPwN2TYW6sq1kj3miZ0f5OqKX0aTk8eGf1sj9TBk1_e=A@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: iio: dac: ad5791: Add required voltage supplies
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 09:06, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Oct 28, 2024 at 08:11:14AM +0100, ahaslam@baylibre.com wrote:
> > From: Axel Haslam <ahaslam@baylibre.com>
> >
> > Vcc, iovcc, vrefp, and vrefn are needed for the DAC to work.
> > Add them as required bindings for ad5791.
> >
> > Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> > ---
> >  .../bindings/iio/dac/adi,ad5791.yaml          | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> > index fe664378c966..79cb4b78a88a 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> > @@ -26,6 +26,22 @@ properties:
> >    vdd-supply: true
> >    vss-supply: true
> >
> > +  vcc-supply:
> > +    description:
> > +      Supply that powers the chip.
> > +
> > +  iovcc-supply:
> > +    description:
> > +      Supply for the digital interface.
> > +
> > +  vrefp-supply:
> > +    description:
> > +      Positive referance input voltage range. From 5v to (vdd - 2.5)
> > +
> > +  vrefn-supply:
> > +    description:
> > +      Negative referance input voltage range. From (vss + 2.5) to 0.
> > +
> >    adi,rbuf-gain2-en:
> >      description: Specify to allow an external amplifier to be connected in a
> >        gain of two configuration.
> > @@ -47,6 +63,10 @@ required:
> >    - reg
> >    - vdd-supply
> >    - vss-supply
> > +  - vcc-supply
> > +  - iovcc-supply
> > +  - vrefp-supply
> > +  - vrefn-supply
>
> So you have six required supplies?
>
> Datasheet says "A voltage range of 2.7 V to 5.5 V *can* be connected",
> so doesn't it mean this is optional? Although similar wording is for
> other supplies, so maybe it's just imprecise language?

looks like unfortunate wording. Like you said, Vdd, Vss are already required
and have the same *can* word in their description like all other supplies
which i think its meant for the voltage level options of the power supply.

Vcc:  is mentioned as need to "power on" in the startup sequence
section of the datasheet,
iovcc: we can't interface the chip without this supply.
vrefp: minimum input of 5v.
vrefn: from vss up to 0 volts max.

so vcc, iovcc, and vrefp to me, look required for the hw to work.
but i have a small doubt about vrefn since it could potentially be 0V.
Does this mean it should be an optional binding where we assume its 0
if not present?
or is it ok to leave it as required?

Regards
Axel.


>
> Best regards,
> Krzysztof
>

