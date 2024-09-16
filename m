Return-Path: <linux-kernel+bounces-330817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF2097A4AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF24228E5EC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA0415E5CA;
	Mon, 16 Sep 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aSW1kPl1"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27B415D5CA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498746; cv=none; b=VqD6prC6SE7pCzvq9F7cC1i4MPZcPnN3LSeKt0oyFwraNLAE/yBjieDeTrv/ilscKyB8Fq9U/61GngVoZsrYVAZIM8ntzb0e4d2UVk5LPiyxN91D8EBknxYAf5C9HqwwNUlhp3YzyV3xmKFsWfUwHBl7sI8SGB63qwaAP1P1lIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498746; c=relaxed/simple;
	bh=+JwIeJpbnxQcpqJOWKCJ3QmtYIYu8glAU1smt81y76U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAKLLPiJFQY/xtl8e3QuIf7ckI9XkdIwSZ3ulM0SQJZMTooICAcDs+DZftLgoc6JbT6SQmWeNsZ2MkkIN+rRFBY/b/N0N7jXAXPVxUzqY8KAN1kU8Xqx2s1n//TDcSk78qhkQngHzojnl8PIrTPbg8TK0naYb5ge3HSWtlTtPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aSW1kPl1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53653682246so5191510e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726498743; x=1727103543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mKFbvl3FRfknVVQd9F2VGjZGmbz4CE84EcQSXZolvo=;
        b=aSW1kPl1SyH6ATKSm9pZCmSRpO5b7m/Wuhi7S6j2A4jiUqk1Jrl5+KFPdtw4YiqFlE
         Ybd9UlmIALc83cbxQaiyHhIDNYXAaHkNSJKYoOga63xNdEpJ7nNTZkWbgFhgb1CeQCE1
         liS2HIE2e/mnfbEGAo8/Da6rNL0x6smPvhwuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726498743; x=1727103543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mKFbvl3FRfknVVQd9F2VGjZGmbz4CE84EcQSXZolvo=;
        b=I9O4/RN3j5DlH1StEq8y+ST8/YkNhvc8soZVWChnKBIJBVyFRMa6Dh59G/7eiiiSGj
         0h3k/RI0k6/ABeNO21z6879S2zQxhFZy57Se+QBGcB1FxVD5MbObR6GJiLzQc1mVUqIq
         bnLn7SScOW8eVGZdvTAObPj8wEtMtxHqugDaoGn9XV2wReRcRHlqwWkQWSLaYuFYr6Vs
         VpQ2QofJSulZhy0IJUUjQLIlGuXEj7QMvKWFbfE090sVAbs3AIgD5UZCB1BywuIA4mwu
         wNX1uAeBnxd2dgs9U9sJmbnwGeZcyHq0D9MOF0+GM7N5R7a8oibc2xssxbMH90/StEpe
         L5Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWEn/SagZNuaJlANDlEZnP4LCweD/ch1qX9h1uAKKBF9nj0+CNKzeR64aeotVoQ/dh3Nnl/lCNOHQgRqSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIYsXgWtIDtX5pqrIsDyRfthsbweksu2VMhB3WhGpe6SwscHV3
	+zvtcPQvuBDJ+6mS7fhryV+xesQC3lblI29NTmpV42ssXwe0KQ/dKdVcRKMe/yJOpQnRBCmEMFf
	jTybTwBF69bJPtFxOOBBA6eaRTQFBIH/MMhj1
X-Google-Smtp-Source: AGHT+IFzocyQXiHJ7IGC6/o9lODvUjZ8bZDDkxYaKMNeJriFadvyYRFY1CoEermaKv4PHMS4vAciuIhFJjjOmqh9esA=
X-Received: by 2002:a05:6512:3f18:b0:536:52ec:2870 with SMTP id
 2adb3069b0e04-53678fcd14cmr8312496e87.28.1726498742804; Mon, 16 Sep 2024
 07:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911072751.365361-1-wenst@chromium.org> <20240911072751.365361-10-wenst@chromium.org>
 <CAD=FV=WtVSQ5GX6H5CtxNPTdOAJVMj_xNRvG9siZB6_ePZr7CQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WtVSQ5GX6H5CtxNPTdOAJVMj_xNRvG9siZB6_ePZr7CQ@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 16 Sep 2024 16:58:51 +0200
Message-ID: <CAGXv+5HRLHV2tDZxiqFRhz1p+_bhMzMXoJMBnhy-R=8C4hBjnQ@mail.gmail.com>
Subject: Re: [PATCH v7 09/10] platform/chrome: Introduce device tree hardware prober
To: Doug Anderson <dianders@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 1:43=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, Sep 11, 2024 at 12:29=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org=
> wrote:
> >
> > @@ -8,6 +8,7 @@ obj-$(CONFIG_CHROMEOS_ACPI)             +=3D chromeos_a=
cpi.o
> >  obj-$(CONFIG_CHROMEOS_LAPTOP)          +=3D chromeos_laptop.o
> >  obj-$(CONFIG_CHROMEOS_PRIVACY_SCREEN)  +=3D chromeos_privacy_screen.o
> >  obj-$(CONFIG_CHROMEOS_PSTORE)          +=3D chromeos_pstore.o
> > +obj-$(CONFIG_CHROMEOS_OF_HW_PROBER)    +=3D chromeos_of_hw_prober.o
>
> "o" sorts before "p" so "of" should sort before "privacy"?
>
> I guess it's not exactly all sorted, but this small section is. Since
> it's arbitrary you could preserve the existing sorting. :-P

To me it seemed more like they are just sorted in the order they were
added.

> > +static const struct hw_prober_entry hw_prober_platforms[] =3D {
> > +       { .compatible =3D "google,hana", .prober =3D chromeos_i2c_compo=
nent_prober, .data =3D &chromeos_i2c_probe_dumb_touchscreen },
> > +       { .compatible =3D "google,hana", .prober =3D chromeos_i2c_compo=
nent_prober, .data =3D &chromeos_i2c_probe_dumb_trackpad },
>
> The fact that the example is only using "dumb" probers doesn't make it
> quite as a compelling proof that the code will scale up. Any chance
> you could add something that requires a bit more oomph? ;-)

I only have a hacked up thing right now.

This is the one I'm using to test things:
http://git.kernel.org/wens/c/5c2c920429167a15b990a7cf8427705eec321134

About this one, it seems we can at least merge the device trees of
each product into just one. The touchscreen or trackpad (or lack thereof)
is probed by the kernel.


This one I only started looking into:
http://git.kernel.org/wens/c/42c21929aeb3c7ca7b0ce9cacb1d0ff915d3c783

About the second one, AFAIK the device tree descriptions are incomplete.
Only one of the trackpad options has the regulator supply described.
The regulator itself is marked as always on, so things currently work.
Some work will need to be put in to research the schematics and test
whether things do work correctly.

> > +static int chromeos_of_hw_prober_driver_init(void)
> > +{
> > +       size_t i;
> > +       int ret;
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(hw_prober_platforms); i++)
> > +               if (of_machine_is_compatible(hw_prober_platforms[i].com=
patible))
> > +                       break;
> > +       if (i =3D=3D ARRAY_SIZE(hw_prober_platforms))
> > +               return -ENODEV;
> > +
> > +       ret =3D platform_driver_register(&chromeos_of_hw_prober_driver)=
;
> > +       if (ret)
> > +               return ret;
> > +
> > +       chromeos_of_hw_prober_pdev =3D
> > +                       platform_device_register_simple(DRV_NAME, PLATF=
ORM_DEVID_NONE, NULL, 0);
> > +       if (IS_ERR(chromeos_of_hw_prober_pdev))
> > +               goto err;
>
> FWIW if you didn't want to see your prober called over and over again
> if one of the devices deferred you could just register one device per
> type, right? Then each device would be able to defer separately. Dunno
> if it's worth it but figured I'd mention it...

I think that adds some unnecessary complexity, and more lingering devices
in the system. These platform devices are not removed.

> Also: as a high level comment, this all looks much nicer to me now
> that it's parameterized. :-)

Thanks!

ChenYu

