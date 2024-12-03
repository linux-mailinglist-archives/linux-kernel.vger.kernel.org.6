Return-Path: <linux-kernel+bounces-429711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 600579E20F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266D32840F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7381F756E;
	Tue,  3 Dec 2024 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qcgRW6FX"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFF31F7557
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238336; cv=none; b=f0DUlRGWpOwBpLXS/upLjeWmaOv94tCUOltIR1TQHyF0VDHdP/gNm/PvuNV+4CMC/vNB335kGYyPWKO7YpSNhg8FCvDXI9tm1x0HizCM385W/VTzdXtdO7wUX33j4kJmkxzuCAOkdKNquGM11+5+he5exNwnmL46dGH8HJIZjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238336; c=relaxed/simple;
	bh=+uMifMZiAcMA3nATNagPBAOmW0eThPHsSBWPDm8brnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBWSKi+giQ5kZApSnfIYxLUVqfv6iLqhxcxbpxosTub7D69bjZ9WI0atykmyjlw1jVqeXeAn7Hv7f01bdpRPO8yZYqo80iRtF5ovgwZUFSTS2v3oa6Q9HRoZOKfZRlgKDm0UDPuQiJzkbj+Q3oZ7x1qM2uQn0oEhtPdaI9UznZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qcgRW6FX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53dde4f0f23so5644823e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733238331; x=1733843131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtbEhhKoiTh0qiQnRaAPey6dwf1k7ZRMkRrGbgxGB18=;
        b=qcgRW6FXOmVZqr/7ItfiiT4o+GpW9CiMQGqeLHaYy5YYDiPs3QPRDA70zm1++WBCA6
         3n9M9QdGjwcDsvL76n9/3+Atcz4d8pOltWtz5KD1tS37jJBAnnPAn/y7lPePup+TUgj8
         zF8X7lIVE6tjEsyRbn5vLvq993MELPmScUvGpwcLtmjE96jrOnDF9heHTg26BBGxmVEu
         buyF1DiadpMX7BnYI208GatUBSzHWTDR1Ser8GUrhDrm5sVeRxBTYpiKcJuAh+BmeUWB
         yWl8dVGbpipppX/1YBo1Geluupu86ofHQiJI0z0sbDYPZidH9CUAc39HGh84BgClzFsP
         8gUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733238331; x=1733843131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtbEhhKoiTh0qiQnRaAPey6dwf1k7ZRMkRrGbgxGB18=;
        b=m8t/2FwRjrMWAqNQjqqdu5qeglNQprErBsJYOMOHkgavbw9MDGLfCtjwShVPnoKPKO
         sqyCuhnhDeXiMyLOXdXbPmpkm2RUrFtVbrM/pCwKwIDk06ea1smIU0sUyIMtreXN0JNQ
         eJeSF05cqmke68vRvk9BBWzO1ISE+a06wqHFQbpGK+kBshpxMu4iFOhkqe54cHtC03fF
         YemSV1JfMr/AY53grsD202yIjKFPzID+ZZR+ByzvGoro7yxWlKC6u4Ogu4DFV8YDD5jO
         x2zzCpGGmOiTjs6aegv5tpiQXIOvjf6ESCqJeRI58ol8znNUuNc3QM/FapcBjKywjWTT
         yZMw==
X-Forwarded-Encrypted: i=1; AJvYcCVkmE9XKxPBwIzyXo5Pixf/Ab9x6YEsY4ooiIYYCWB/A+XWFwkrHHcP2f6DgY0qEp+TvnB3uT9OUEJsorM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1bWBDeHS77WqNdv7rRs817SCx8adYo7/tvOPPSOmFD+yHDKw2
	Kjwh/+Dr5k26vEWSbcpwK5tObZ2hhBiL7R+d3c6GJ1hyIr6nG7E4VZ0papY4SDU2Oj8gcBPmk8Z
	aTsRjh/Be8mVOTQfZide2PA+pZ4n5d9R+QQ1Htw==
X-Gm-Gg: ASbGncteMGTRR5cbYCSKRzbWzCAwwT2OPZ8/ULlhdzqNtj/6VnPwvSStbFt8yY5EeqV
	nfjK8LSGPlGusI9W0pBYoWmvY/kPs8LA=
X-Google-Smtp-Source: AGHT+IFXcMRum6Fgpn/fpkHjlbTye37au8KaG1skCplnVjgk7auCVG9uYkhWXukENlDICE2p3O83N7kw41MOt8qO7js=
X-Received: by 2002:a05:6512:2804:b0:53e:1b6a:60f5 with SMTP id
 2adb3069b0e04-53e1b6a61d3mr623994e87.29.1733238329662; Tue, 03 Dec 2024
 07:05:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
 <20241203-crypto-qce-refactor-v1-2-c5901d2dd45c@linaro.org> <b3e5184d-19bc-45ed-92e3-a751842839b3@linaro.org>
In-Reply-To: <b3e5184d-19bc-45ed-92e3-a751842839b3@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 3 Dec 2024 16:05:18 +0100
Message-ID: <CAMRc=Mc+hKeAwyvm_aaWe_r07iXuBMy0hRQrXSQjpy0irKzvMw@mail.gmail.com>
Subject: Re: [PATCH 2/9] crypto: qce - unregister previously registered algos
 in error path
To: neil.armstrong@linaro.org
Cc: Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Stanimir Varbanov <svarbanov@mm-sol.com>, linux-crypto@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 2:55=E2=80=AFPM <neil.armstrong@linaro.org> wrote:
>
> On 03/12/2024 10:19, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > If we encounter an error when registering alorithms with the crypto
> > framework, we just bail out and don't unregister the ones we
> > successfully registered in prior iterations of the loop.
> >
> > Add code that goes back over the algos and unregisters them before
> > returning an error from qce_register_algs().
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >   drivers/crypto/qce/core.c | 11 +++++++----
> >   1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> > index 58ea93220f015..848e5e802b92b 100644
> > --- a/drivers/crypto/qce/core.c
> > +++ b/drivers/crypto/qce/core.c
> > @@ -51,16 +51,19 @@ static void qce_unregister_algs(struct qce_device *=
qce)
> >   static int qce_register_algs(struct qce_device *qce)
> >   {
> >       const struct qce_algo_ops *ops;
> > -     int i, ret =3D -ENODEV;
> > +     int i, j, ret =3D -ENODEV;
> >
> >       for (i =3D 0; i < ARRAY_SIZE(qce_ops); i++) {
> >               ops =3D qce_ops[i];
> >               ret =3D ops->register_algs(qce);
> > -             if (ret)
> > -                     break;
> > +             if (ret) {
> > +                     for (j =3D i - 1; j >=3D 0; j--)
> > +                             ops->unregister_algs(qce);
> > +                     return ret;
> > +             }
> >       }
> >
> > -     return ret;
> > +     return 0;
> >   }
> >
> >   static int qce_handle_request(struct crypto_async_request *async_req)
> >
>
> Perhaps you can also use the devm trick here aswell ?
>

I wanted to keep this one brief for backporting but I also think that
scheduling a separate action here for every algo would be a bit
overkill. This is quite concise so I'd keep it this way.

Bart

