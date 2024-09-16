Return-Path: <linux-kernel+bounces-330683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE7497A2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837031F22DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2088D14E2C2;
	Mon, 16 Sep 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l4Ey8fL5"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748435258
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491794; cv=none; b=AcTxyUT3gYvs0YCPLfrajQyhF18fM4AMMkdidgabX0Oenr8vKspOHfmKMvwcS4nS/5mblZxr8Cj86vtlEG6p1grKo1Sg6JjaxJ8XhaOR+6i74gIvsrKqwTSs5xdpeVMTmEgrSUrDPSLw8w3n1r82nz26qLKN27D4s0Yyz30hh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491794; c=relaxed/simple;
	bh=m35dDssCabVJuMRlGOZTc6qI+dzsKKWYeM0JmQhFPcg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kJ0aSAdVVscnmBbSB7hovcdQtgvyCe9m2E8r0oC1/+OL7hnMIX2ntge+ofEbEGSc8jzf7cURFYmaFd0MzkqBRk+N75BoBRh4xsmm0ag2cibZ5HWH1fdkIvREYC/wnY4Gy31L7QUtrF2HFEnD9P9YIKKy4BiRXYdi9tj0jQK/O2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l4Ey8fL5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so34208775e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726491791; x=1727096591; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZskt6RQWwBKvf8VCH4bF9IdkeZRhcjl5ETFLty+q4k=;
        b=l4Ey8fL5OhzB2JmN8LwLNK2VZocHDAOYBBudBRQ+9c58kRH34mOoyTbm0csm8BQ78X
         33nGWf/MnJpsDzPHnluoiNfqwIRqeKITIXB81rdyvkl5Sv0kpGbzjFRk5f1ULTg+wrwk
         2J/Gm2Zsw2BamcCNlazeMFFeutz+uB2ikroh5cG/HOVZMfAMYH5hdf7R0PG60d4OZ7JB
         fDhWSoL1wy6n3e+9vRrBsJRhpwT2gafRo0ESECGE+3tVwYNlzgftx/8fqyKvK3ChpmKh
         I8X/wftNYTWFzLoUMC7UChQMHfJ4O8SF7LwNSAYbshfPGkm9fNnBfz5kBl/qFgTlBZq2
         ErNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726491791; x=1727096591;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fZskt6RQWwBKvf8VCH4bF9IdkeZRhcjl5ETFLty+q4k=;
        b=X4UicJ91vHyGiAFv/XLxKHDhqI1dPgIO9sKFWHsqqE8WFnu/zr+L1WWlAnp8AZPaN/
         iJqlzspsPbjyNwOeUm+WzySLkLDZFCrL4l89FkdCK1R7+kdiEyoTwQ63q1ro4DPWDfQ6
         HFd+RVNn7kM+yGyas6ZlMqwHQbSgauwqMgz8/aUH9Xj4ncPpG2ZH9D6hjiwRxrVkLsXa
         4qiSThPQWg3jy6JxqU2gjgop3hga5BUYZNDSyHiqDkN/BQQ6CDOBUSdauWcB9ZyRA2Jv
         7A9aGOlc1FVDgNe1yhXMpNp+iLWnzTEzwtorTXYAiao6K/+jtIM1NUiID5zBnKaQUHjY
         oqMA==
X-Forwarded-Encrypted: i=1; AJvYcCX5jA0ny/K5S4/dowU5s5ha58ztImC3VaCJUXfgxEs441WBcWIVAvMXKfDcGpTx2xWBsbOdQW9IQ1OpBhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1zFSZ1z7kiW5ORax2IgEctWerEom9w6uyJtKY8X1Fxr2d+5hE
	UWuMAcTIb5eSpreI++RrKHbxIN7GU0qqp/wXsJVD6+hngDiBwUc1Ov9oezQ7hdo=
X-Google-Smtp-Source: AGHT+IG2nrplOfj3/5iWG04x2nhwLzDmV7EDuTH5ottx1vDxjUFR2VnB7SicdyNXc/hTI5mX9cPsJg==
X-Received: by 2002:a05:6000:459f:b0:374:c0c5:3c05 with SMTP id ffacd0b85a97d-378c2d4d802mr7925015f8f.42.1726491790471;
        Mon, 16 Sep 2024 06:03:10 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b87a9sm78564735e9.6.2024.09.16.06.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 06:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Sep 2024 13:03:08 +0000
Message-Id: <D47Q9E5EW08V.2JP0X6EFQMFBT@baylibre.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nuno Sa" <nuno.sa@analog.com>, "Jonathan Corbet" <corbet@lwn.net>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 4/6] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
From: "Esteban Blanc" <eblanc@baylibre.com>
To: "Esteban Blanc" <eblanc@baylibre.com>, "Jonathan Cameron"
 <jic23@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
 <20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
 <20240826102748.4be0b642@jic23-huawei>
 <D452E2M75XCM.13OQGAPJ7JJ4A@baylibre.com>
In-Reply-To: <D452E2M75XCM.13OQGAPJ7JJ4A@baylibre.com>

On Fri Sep 13, 2024 at 9:55 AM UTC, Esteban Blanc wrote:
> On Mon Aug 26, 2024 at 9:27 AM UTC, Jonathan Cameron wrote:
> > On Thu, 22 Aug 2024 14:45:20 +0200
> > Esteban Blanc <eblanc@baylibre.com> wrote:
> > > @@ -460,12 +517,21 @@ static int ad4030_conversion(struct ad4030_stat=
e *st,
> > >  	if (ret)
> > >  		return ret;
> > > =20
> > > -	if (st->mode !=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM)
> > > +	if (st->chip->num_channels =3D=3D 2)
> > > +		ad4030_extract_interleaved(st->rx_data.raw,
> > > +					   &st->rx_data.diff[0],
> > > +					   &st->rx_data.diff[1]);
> > > +
> > > +	if (st->mode !=3D AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
> > > +	    st->mode !=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM)
> > >  		return 0;
> > > =20
> > >  	byte_index =3D BITS_TO_BYTES(chan->scan_type.realbits);
> > > -	for (i =3D 0; i < st->chip->num_channels; i++)
> > > -		st->rx_data.buffered[i].common =3D ((u8 *)&st->rx_data.buffered[i]=
.val)[byte_index];
> > > +	/* Doing it backward to avoid overlap when reordering */
> > > +	for (i =3D st->chip->num_channels - 1; i > 0; i--) {
> > > +		st->rx_data.buffered_common[i].diff =3D st->rx_data.diff[i];
> > > +		st->rx_data.buffered_common[i].common =3D ((u8 *)&st->rx_data.diff=
[i])[byte_index];
> > > +	}
> >
> > I wonder if doing it in place is actually worthwhile.  Maybe unpack int=
o a second
> > array? That is still fairly small and may make code easier to read.
>
> Okay sure

Actually I can't consolidate the differential only mode and the common
byte mode without having to create a bunch of if/else or having a
memcpy. The best I can do is this, but I don't like it:

```
static int ad4030_conversion(struct ad4030_state *st,
			     const struct iio_chan_spec *chan)
{
	...
	u32 tmp[AD4030_MAX_HARDWARE_CHANNEL_NB];
	u32 *diff;

	...

	if (st->mode !=3D AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
	    st->mode !=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM) {
		if (st->chip->num_voltage_inputs =3D=3D 2)
			ad4030_extract_interleaved(st->rx_data.raw,
						   &st->rx_data.diff[0],
						   &st->rx_data.diff[1]);
		return 0;
	}

	if (st->chip->num_voltage_inputs =3D=3D 2) {
		ad4030_extract_interleaved(st->rx_data.raw,
					   &tmp[0],
					   &tmp[1]);
		diff =3D tmp;
	} else {
		diff =3D st->rx_data.diff;
	}

	common_byte_mask =3D BITS_TO_BYTES(chan->scan_type.realbits);
	for (i =3D 0; i < st->chip->num_voltage_inputs; i++) {
		st->rx_data.buffered[i].val =3D diff[i];
		st->rx_data.buffered[i].common =3D
			((u8 *)(diff + i))[common_byte_mask];
	}

	return 0;
```

The root cause is that when we are in a differential only mode we are
leaving before the for loop and we want the data to be in the rx_data.

It fells clunky and brain consuming IMAO, I prefer a reversed loop with
a good comment (the one we have now is not explicit enough, I will
update it).

