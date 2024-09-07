Return-Path: <linux-kernel+bounces-319635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3D4970011
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267A71C221FC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C832443AA8;
	Sat,  7 Sep 2024 05:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kc1p0YEM"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843E4D8C1
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685330; cv=none; b=WzGihO+/9a14k9CvChd9euJeVZr/VNtrPBltIAYnT2Fs5F8nowJ+sKMy+rV+Lr7EVWOhxi7XgQG474ay9LdMUHijogSDBXcBL4/ho5gfphvwM1mHXxsVReLuM6QSPHvW7mi7m0QaUBiQkmn8hQ4xEBEYrray9Wq3Fyb5KkuVm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685330; c=relaxed/simple;
	bh=D1aq/RQocG348OD7UVm0XytzAgvWjbKs0e4befvJOIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuBGssxWVdUeP1yvmDI9m3SYM/y9sA+RV1xCePlWY1MIoSSgY49lfsaNFkTK8fVzleS+lF5wolJaCKKw/xpkwaRRf+9KLGei9oDJPxUDsuu9pQtaigtOAHUeg1Y9DguOGrkB+DKeRCh9HM+woeNp/mkxnTOAHDXjxR8GSO/ruS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kc1p0YEM; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-846ca2626cbso739275241.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 22:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725685327; x=1726290127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQAqhIMKypqklZhoaptNP1nf1GTYRvwTcnfCJhLc3Jc=;
        b=kc1p0YEMKkjlGutYj2dcc89w5lYo0gE/1tJ5BQ7bw8DbFWw3GXXZj/YDhXI2+N9pGP
         0RR8gZcstDqPTvEMLbBK8RiozSFOhC/2cnNHNkPo+hBB5gGK6IwarnvBOBUDCgEZI6po
         KbSaqSwPJmj/A+ZUnxD+fYYEM+h1zjdHQ789q+xrdMelbH2WhDJvKo2uvblraxbhML9L
         FJabFAZewjloY0Pda9lLxgCZXRS/zr9anQ8FXrUY89dgNqpGlKANfrjwzTzVixFurBWf
         IZOeINixqiqYVVADA/76C+h2CKFTLBZZ3ja/wVvGaKL4QNRAhsIvTe8R27MysODWe6K7
         MghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685327; x=1726290127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQAqhIMKypqklZhoaptNP1nf1GTYRvwTcnfCJhLc3Jc=;
        b=c2Xth7wPaYRlgZbPaWpTzzT8eB+oMpEQ5OsBFj1QaXtPI9trmExxf7oN2DUuiA9euF
         TGkMX3VxiAJUoIbbVuXUGdQItjiydDA9/oWkbpYfgvBlT+HVD90tgxYihsXT4gKP+ViB
         o9RHBFYxXm47TodVRj3vMvV5rUT7rWyXkvnxf+ooLCng9U/Mu7GQ0mUn29/O3L2fAdvL
         cpaPbdkdxN8eJagSep/B7rpm7uGkwnRHSA/jz/6qW8OKSTCiE/hpeAU7Zhr7lqdA6e8k
         NxWzSt0RwY3lr50l2gzriqNVBKXzFt0THrRFXxO82pEN9Xy1hy7LO0HehCM5hYrVU0fQ
         MiKw==
X-Forwarded-Encrypted: i=1; AJvYcCXRXIulJN22TTvcINThcDDgeKDNYnePplVOseGP4tcri7yT9NdhHp0nMPL/XeMVf3WxBqS8Hl1icRNq7yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMfbbkCyIPTWFyG2NLs+6RKwUGd+7IOQhg2qmHo0Q3BtT3zq7Q
	Seyw87aCVAKmOMOXBopVUfKpVGEtdv94qGJBIr9/2EWTnwND7IEMrw2PmC7Upqr8TQLa1ibhjwm
	fDwAIwzD0XqyAPNXJGWzlcuQII8Fc37UnBwUvSQ==
X-Google-Smtp-Source: AGHT+IGYLP069UXYJAM+qennzi+blh9eqsxz/QeTRHI14ojthq+7+jDAogYcEQOImmmSjIIAahoo0p97CCF716qI7es=
X-Received: by 2002:a05:6122:a1e:b0:500:daf0:8909 with SMTP id
 71dfb90a1353d-502143d4260mr5220112e0c.13.1725685327108; Fri, 06 Sep 2024
 22:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905082404.119022-1-aardelean@baylibre.com>
 <20240905082404.119022-8-aardelean@baylibre.com> <0a7f796a-7762-4c25-85ba-27240a3cd59c@baylibre.com>
In-Reply-To: <0a7f796a-7762-4c25-85ba-27240a3cd59c@baylibre.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Sat, 7 Sep 2024 08:01:55 +0300
Message-ID: <CA+GgBR9AMR8jvU+bTMA=PZWMo7NdZfZwAZBLHeYEd1H-RvcTWg@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: adc: add docs for
 AD7606C-{16,18} parts
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 1:02=E2=80=AFAM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On 9/5/24 3:24 AM, Alexandru Ardelean wrote:
> > The driver will support the AD7606C-16 and AD7606C-18.
> > This change adds the compatible strings for these devices.
> >
> > The AD7606C-16,18 channels also support these (individually configurabl=
e)
> > types of channels:
> >  - bipolar single-ended
> >  - unipolar single-ended
> >  - bipolar differential
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> > ---
>
> ...
>
> > @@ -170,6 +220,17 @@ allOf:
> >          adi,conversion-start-gpios:
> >            maxItems: 1
> >
> > +  - if:
> > +      not:
> > +        properties:
> > +          compatible:
> > +            enum:
> > +              - adi,ad7606c-16
> > +              - adi,ad7606c-18
> > +    then:
> > +      patternProperties:
> > +        "^channel@[1-8]$": false
> > +
>
> Technically, we should also have "^channel@[1-8]$": false
> if adi,sw-mode is not set (not: required: [adi,sw-mode]).

Yes.
That's true.
Maybe I'll add another condition here for that.

