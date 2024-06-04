Return-Path: <linux-kernel+bounces-200336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246088FAE89
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DCC1F24E23
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A74143C52;
	Tue,  4 Jun 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4B8tM6Z"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6E14374E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492574; cv=none; b=Xg6FHNDxT9yxTV+LKeC4HAe0I3QWV76wRwiZ8QQDL5dnl09uE2LhGS9w62x6MKZxOuSKvxKVRk5hTWnKLrQ8nj44GleMcrdUFFz4OBk5LZ3h+xFN7pLIS3qgSE9ChiARtG6vOvnYLam9w9eJ+R8ISY75jHpTsuJXuAOyszKy7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492574; c=relaxed/simple;
	bh=b4BkQJr9zqa33/Ise3vdTeOwjy+zddMPkvLiqQ/OEvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9fOceW0AT+XYuigyPU0rlKNEfSfhLVYVG06iPQAcvkr1fXJ3PRyIIU8RGUIuFrkXqr+YxmGngFWKpbcnOUSfcuXKUEBBJqADJ44tYwWZ3OOIlLoHexV/VqaxF6KJ6KKD4+1YA/+RtihaxcYQtTz4t3C1QNx0oHIUTM2FDRysAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4B8tM6Z; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a526c6a2cso3023029a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717492571; x=1718097371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50hDekaz82sJymj7fyrqiF3qhFMExcj59YbjLfONsC8=;
        b=K4B8tM6ZCK8VrXyVXCwJDaqLQUHC8RzrA951SgP//3LLXDsOT049Ogvk6zGnXq5MiY
         DSiMbf7tm0F/ToXkKUHU4Wbje2KrZVSn+kviOFkZGivCnbhkXsaHqGSK+R1LiQkpwEuX
         wC0MQHU4OqkcTRiZm1abNwHM1XPeKA9rq4eQVtQ/JVDiEOaXlesKX6b03/sg0z562bbK
         EPvJr983a+IrxCJXuvfr+e3XfRZNU+5ghPYnsL70MRpPmHDldn1gjFTdV8ZCg4wOsDRQ
         YJB09MUkS3KUA8pQseJKMtgW9oIE0hYKx/d3Y7SuBTmLKbUM+L/YoZ4rvie2a0u5aXFi
         LENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492571; x=1718097371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50hDekaz82sJymj7fyrqiF3qhFMExcj59YbjLfONsC8=;
        b=qt4p0zDkupOhAW5I1u9iG1epd+mCzjwV90SUZaRer04TS/7HFKYvGo80EDbaSdiQcv
         AkNJryWDYnlV0LzWkdmiWAyCtR5GJgqdAtYN3va3QMk/TEmSuDtrIrSv5hvp6QfrNpHt
         WmxsXxqQrhXykTV8nWdVcB732aqbobWYACAdlWSF0q8RYdvWUBXdWYybVdPwVwFzlK4B
         lKxDshBefYGE3AXwTotU/Rd5MwbW+HfP5b+DpyD9FO0D5HzOXSw+vyXEGtE9ymQbiYHR
         q+K35uetnvfxKan/7ovldn/zmPh8YUk9sxnR1cAS75DxiGZ8bTWTRGfTDAHEnu3PNVBp
         kXgg==
X-Forwarded-Encrypted: i=1; AJvYcCXLEATOwVkKg4mF2/IAGt2pXnwom767U9lIKuoPg1uMma/2bu+zfTyM67eCGXv4TFlfkvltZtphKMd8p2xpHB7ukOXYiBgWgg25YZ1X
X-Gm-Message-State: AOJu0YxuR/lC4D8fRGbyhdWznb1xZjg6hZBhkTpURcDratVX130CW/2A
	1Bt/Alffh+9BZA6J0Kjpln2rhPZiNr7hXnCyA4SyiuK4TZmlHUN4BhYfdSpW9kiE2MZaTTGqlUA
	CUGrAAO3ly3EHA2/FuknBltJX+J5dzAy3HHA=
X-Google-Smtp-Source: AGHT+IHkvBdA3Td7lCQbI7cnVHmFNcr7+ODgAN0ELhpUaW9M6kw3ibo6BjExWQT2oqahBU9FECD25BzUy0a5i3BATbo=
X-Received: by 2002:a17:906:2b0e:b0:a68:f5fe:ac8a with SMTP id
 a640c23a62f3a-a68f5feacc4mr404643666b.64.1717492570557; Tue, 04 Jun 2024
 02:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523211437.2839942-1-jwylder@google.com> <ZlwfQ3ERbo5snLcK@surfacebook.localdomain>
 <37abbb4e-cac4-4278-98fb-0af75e5b3ef4@sirena.org.uk>
In-Reply-To: <37abbb4e-cac4-4278-98fb-0af75e5b3ef4@sirena.org.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Jun 2024 12:15:33 +0300
Message-ID: <CAHp75Vfgu0eXXJ_FTgMC-VUzTRSo7zoA4C9j3WsevPzhajpDSA@mail.gmail.com>
Subject: Re: [PATCH v2] regmap-i2c: Subtract reg size from max_write
To: Mark Brown <broonie@kernel.org>
Cc: Jim Wylder <jwylder@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 3:08=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Sun, Jun 02, 2024 at 10:29:07AM +0300, Andy Shevchenko wrote:
>
> > >                 (bus->max_raw_write =3D=3D 0 || bus->max_raw_write > =
quirks->max_write_len))
> > > -                   max_write =3D quirks->max_write_len;
> > > +                   max_write =3D quirks->max_write_len -
> > > +                           (config->reg_bits + config->pad_bits) / B=
ITS_PER_BYTE;
>
> > Interesting. regmap-spi does this slightly differently, i.e. reg/8 + pa=
d/8.
> > I'm wondering which one is more correct (potential off-by-one I suppose=
).
>
> The above seems more correct if we have less than a full byte of padding.

Hmm... So, if we have

bits    pad  x/8+y/8 (x+y)/8
4..7    0..3    0      0  // x + y from 4 up to 7
4..7    4..7    0      1  // x + y from 8 up to 11
4..7   8..11    1      1 // x + y from 12 up to 15
8..15   0..7    1      1 // x + y from 8 up to 15
8..15  8..15    2      2 // x + y from 16 up to 23

The only difference AFAICS is the case 2.
Do we need to patch regmap SPI for that?

I think SPI just works since we don't really have devices that use
less than 8 bits per register, and hence we never enter into such a
case (while I2C is naturally using 7-bit addresses).

--=20
With Best Regards,
Andy Shevchenko

