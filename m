Return-Path: <linux-kernel+bounces-346123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A18798BFE6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB5D281ED7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2511C6F57;
	Tue,  1 Oct 2024 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dt1kxe2N"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E61C6F71
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792952; cv=none; b=ou8mKxQNKV3hZN3DWH/IcP5jDndGpjbjELyNu6tdC6H0qxhL7zLvJ5ic8Fo35uciXYvaV3JhcW8rtff6N+x9G2/ZE3UVgrPdfFzOu4uauKVHZjdPsqamAxY7kTZuNpE4i1cBCHKvnw5/2nLXhubyLlpvx3LI0TBlf+7/5rkEZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792952; c=relaxed/simple;
	bh=ZTLAPL4/a9ZeqzSRMsFNfRjn33WA5sSh1xdLRSoZZl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqCFO/ZcPpPgF49+X2HcIVBWLRp+U58f/KkWjTmpfy8Q1OxKtScYVOfgrM/IhQCP8SJpeuY003l0JbTByNF1OHgV2lIHD94NctE2sQqhgFZPxztHb0kPsQXnjYQP9Jig/nOdjOjfmgJMGLHmheD/FhtYnPaGgFa3h5T6V9cSE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dt1kxe2N; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53991d05416so3170117e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727792949; x=1728397749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTLAPL4/a9ZeqzSRMsFNfRjn33WA5sSh1xdLRSoZZl8=;
        b=dt1kxe2NiiL5bUMbL+DiT7/KclXey+k14z52e3aIrTEb06FUnzYo4vz0Tp1/ZG4pQi
         B4lQgnSAKCdWZAx/vqLGYmSf0ULx+axAJTgwi3VG1F2PH2SYsRKF7erpLqjb7cQSNGKC
         4+pyuXqMy+rDoIgFE5NGzU5Jbk6IFHwLhVOuieJ6lXdsnjVUI4cXOXFOr9nub6mfwOs3
         /WK6+6/uy6S8iVkGEy9zhHB0i+bHsgyfKT1iTg68hG5tHreRXgTRhKjaaUmjRMllfdkK
         1LKUwrWlTBp9lkQoN3vcgMFl/FOLsmNn+oL0pEUlc48zQwUsrko/40vlPDYsTUCGcgbv
         fOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792949; x=1728397749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTLAPL4/a9ZeqzSRMsFNfRjn33WA5sSh1xdLRSoZZl8=;
        b=PpTt7vWZIf8SUzoJmlGTcKZUlRPoxhg+fmfohgtO0w35hW8sWgKpiF/ilj5m787YqR
         pQIH97bG9tPl8N9mSXxS9UZjStzOMsiIo3OqzLCi/Q+Iio5DVZm1RlmCJnryI38K5mDi
         eCe4HjAqXNYZqkCNpVPiiA4Utrtmz/+TZyyzXDMlFzmqUmOUeT2dXSPYo6Z4XYFqIJ/s
         eo9m5EVUf+ULa6rijaWgIT4cPf7AKow8E0daIIyvArEkfc3zKlnOrc1kH4E85krMHOtp
         IfmAL5gPEOqTMw2lzGd36bUN0/AwwEE/dzNQg7eqEruIlGPamZqtVaWmctkuUYgcIDUS
         G4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcAE3Cwp/crft5knb2VeF9nxq6UOSHy6CEEVuBWCk+9TGKIV5UC80aTPCvWWa5j+wXeoxC5+Q3vlt/TGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTajR9/ur4kQVy2ygjirycw0nPN+BFf49KYr6cryi7/imE0lbM
	1k+ULW3Jk3199mu+4l6Quo6qa/Oj27X/0Gyhl/WmZ5eFIZ4/akKONYXOOkao6ZkQzK6RtBB9iOH
	xJAaREQ/jH6X/mUJ5Y5IDOu47OB7GndgZJirAug==
X-Google-Smtp-Source: AGHT+IFE+BbJrrISlBUyPgv+/xZL7TxeBTUPX5ZjbaQ1CFA81WRoxPOYTAY1J9iq5dPpbRGDpAq5fqHmiNZTcfKL22Y=
X-Received: by 2002:a05:6512:6618:b0:539:89a8:600f with SMTP id
 2adb3069b0e04-53989a86942mr9620037e87.23.1727792948844; Tue, 01 Oct 2024
 07:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826095723.1421065-1-andriy.shevchenko@linux.intel.com>
 <ZtmqdP6Q92vRWh_I@smile.fi.intel.com> <CACRpkdYSPGsQt_FQDurtwmyaLtB3=gaay-hLN2QdOj25e3sK8A@mail.gmail.com>
 <ZvFGctwe1vu9lQmd@smile.fi.intel.com>
In-Reply-To: <ZvFGctwe1vu9lQmd@smile.fi.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 16:28:57 +0200
Message-ID: <CACRpkdY398EUQE=OxBD+saCzSeYK2-2oQM2Bq2rjqRu55b7nNw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: nomadik: Use string_choices API instead
 of ternary operator
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 12:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Sep 23, 2024 at 11:11:12AM +0200, Linus Walleij wrote:
> > On Thu, Sep 5, 2024 at 2:56=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Aug 26, 2024 at 12:57:23PM +0300, Andy Shevchenko wrote:
> >
> > > > Use modern string_choices API instead of manually determining the
> > > > output using ternary operator.
> > >
> > > Linus, do you have any comment on this?
> > >
> > > I had sent two patches of similar changes (different drivers, thoug),
> > > one got applied and this is not. Anything should I do about it?
> >
> > Sorry for late reply :(
> >
> > I thought it looks weird to replace just one string choice
> > in the middle of everything and it will be confusing for readers?
> > They will be "but what is this now, this looks weird".
>
> Do you mean it's incomplete? So, i.o.w., if we have str_output_input()
> it will go?

Yeps it looks half-way otherwise.

I wasn't a big fan of the choices but no strong feelings about it
either so as long as it's consistent I will be OK with it.

Yours,
Linus Walleij

