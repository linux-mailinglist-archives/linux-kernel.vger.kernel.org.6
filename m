Return-Path: <linux-kernel+bounces-293533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F6958100
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE29287124
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5933E18A938;
	Tue, 20 Aug 2024 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="NNje7Jmi"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E2818A6B6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724142618; cv=none; b=Ig9YnvGMupJpIQAQnurYQwgHuokS+CPSPaQ7JiftU4xjspgwQr6CBaS63qZ5LwMEyaVv2Cf8DoaSdrEaK3DrZbSWE1VuCa6O26Yc2wXUCr6Ag867rY5mX/J4WWxmf+MSWirqEbcFGEzBL1cXGUe3nkAcghiRE/TJmnpoDuDdg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724142618; c=relaxed/simple;
	bh=TRU83+gdLy9W4YUZl8iWPzvI2LOP1Kh2BEShyjf0IqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0NI5aeiqf4nV02Wta4HeRggHeeYP/We4sAX8093PElXThJbImvjuyxri9pF3supgY2deNuziYdRDmnKz1cQt1TxTbynNHx5LTUXnXw/NDwkCfem+/fPsSLJHZrEkCpAwKr2+NLfhVtJmAz2O4AtFeEzvceqKlC+YyPWrJbxnRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=NNje7Jmi; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e162df8bab4so1867381276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1724142616; x=1724747416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZqeWsMIa4G+/Jffk4q0DpUs0TIfN5gPXqtsEPQIEU4=;
        b=NNje7JmioAy08T7lf7tHdSLPMj0Pr3Hamzj2j7aQ4dezc4+MmxFKuUvhqrc3imEhpt
         VzNhPkrTMqWrYWfS4/lf9CJwvQamwhFYel9pBcGsmxvmN4JgP7iQUA4fNKw3+u5HFkHV
         72DzSd/KJn4nCw4hmT4siwUHsYUS2G/sbPAPDhrqoOlRfLtt35DyZLyhTQtSc3TRitUJ
         cc68cYkV3ylzda87ECfsX3FubqYCj3UPOSHy3Sw9ExpIS15mXKdForlGkpN+UFHrzY/j
         J2U10opIApOfrS1oKVxAvYhyEt44+U9E2oWiA/EsxL2QW25H6h1s5F+0Tv3CE+J2+amf
         t0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724142616; x=1724747416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZqeWsMIa4G+/Jffk4q0DpUs0TIfN5gPXqtsEPQIEU4=;
        b=F+B5lUaneppNpZyimae99LYcMBOLLvcLJ80v0RUxauGKifDelsRliyYI8rIplp9tmd
         pYuY8K/Af69kPWrjBG6AR7BQ2fue+oXnfj5YB+itOUifqfgSzQuoU/tgg83tkXAMQRZP
         6gx+qtlt2tHZwtvQgn8YOMETgykiRRn65MbDHFKdd7zLxxXGkBUzFlvV446GgKTWujaH
         cEeTaMuYt612bOUQwS6UfgFJjH6DXJ0OC9OHwNTG7YzLfUtdnAkRVaZ/g1vTAl1vqdHF
         RFIQzpQj0AK06/Zh3rp9aKP+SVSXARsJhP52SCpZmbu5nIJmdkbI38sD6sgtL9WrG5GE
         9nwA==
X-Forwarded-Encrypted: i=1; AJvYcCW1+apU8DqOmAgfwChHuVQqsiaIZS6AKvFTYSYEnOkS4D7CWiHqpz50GPwFTfoZwzY6LU5Yy8jEuDMal1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+C6pAvsqs/eTR1GJD94ENbD7nueDUHjy0wJtQH5mzMuiiR6jG
	34K3MmvyAoV3l7j+t+BFHDo9AEIUBZid2zIcC41fYVWL2SOJq/nlaPSi820gz2nyf8RNYdwxBwB
	HEHVgFCXiGQm9elp7bLbouaXgf13G9/W1EtrTGA==
X-Google-Smtp-Source: AGHT+IG57A46tSVSlUwBGa65sWLT3dWQaLzZIDDHTtIjcr1bc6ll69vw3ONJvZa7AKDIafyzi3kD1Osy0aRv1CnPdGc=
X-Received: by 2002:a05:6902:988:b0:e16:3d01:3fc6 with SMTP id
 3f1490d57ef6-e163d0148b9mr5405653276.21.1724142615533; Tue, 20 Aug 2024
 01:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521152602.1097764-1-patrick.rudolph@9elements.com>
 <20240521152602.1097764-2-patrick.rudolph@9elements.com> <ZrYH8QlXH5Gfvnz_@black.fi.intel.com>
In-Reply-To: <ZrYH8QlXH5Gfvnz_@black.fi.intel.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Tue, 20 Aug 2024 10:30:04 +0200
Message-ID: <CALNFmy38aq915Oj7x4q27OWbiympDU=Vjo=7anTYx7w3E=F2UA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: cy8c95x0: Use regmap ranges
To: Andy Shevchenko <andy@black.fi.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, naresh.solanki@9elements.com, 
	andy.shevchenko@gmail.com, broonie@kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 2:13=E2=80=AFPM Andy Shevchenko <andy@black.fi.intel=
.com> wrote:
>
> On Tue, May 21, 2024 at 05:25:58PM +0200, Patrick Rudolph wrote:
> > Instead of implementing a custom register paging mechanism in
> > the driver use the existing regmap ranges feature.
>
> ...
>
> > +#define MUXED_STRIDE         (CY8C95X0_DRV_HIZ - CY8C95X0_INTMASK)
>
> > +#define CY8C95X0_MUX_REGMAP_TO_OFFSET(x, p) \
> > +     (CY8C95X0_VIRTUAL + (x) - CY8C95X0_INTMASK + (p) * MUXED_STRIDE)
>
> > +static const struct regmap_range_cfg cy8c95x0_ranges[] =3D {
> > +     {
> > +             .range_min =3D CY8C95X0_VIRTUAL,
> > +             .range_max =3D 0,         /* Updated at runtime */
> > +             .selector_reg =3D CY8C95X0_PORTSEL,
> > +             .selector_mask =3D 0x07,
> > +             .selector_shift =3D 0x0,
> > +             .window_start =3D CY8C95X0_INTMASK,
> > +             .window_len =3D MUXED_STRIDE,
>
> Looking at this again, are you sure you have no off-by-one error in
> MUXED_STRIDE value?
You are right. I tried to save some memory here. Will send out a fix.

>
> Also a comment in the regmap core suggests that we may include selector
> in each of the window.
>
> With this, we probably should simply use PORTSEL as window start with a
> fixed window len of 16, having a few more (reserved) registers in the
> dump seems not a big deal to me, but it will be much easier to decipher
> a port number based on (virtual) offset.
>
That's true.

> Besides above, why virtual start is not well aligned? I would expect not
> 0x31, but 0x40 or alike. It might explain some bugs with cache you have
> seen.
>
I didn't find any rules on this, so I used the next free index.

> P.S. It might still be bugs in regmap core, if it is the case, they
> need to be addressed.
>
> > +     }
> >  };
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

