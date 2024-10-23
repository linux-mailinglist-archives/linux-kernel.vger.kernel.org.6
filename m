Return-Path: <linux-kernel+bounces-378310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529B59ACE54
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB62B23E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D761CFECA;
	Wed, 23 Oct 2024 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdpZ3INe"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB01CF286
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695905; cv=none; b=B2mHInX0do82LqaQU82AwDMl8N5bnNCenoQicp26Ar/fCJf+nbYEIjHFGALaDmCF3jbX66Y0OPYwEJuBUSDqCS633rpG6ZsdryrJ83cbG4v2xYzWU6sf5WM8gTvB+WzF1PZkMYxn6d3s1ZP7evhiNH1tTnnTf5QvIl+JSBpJ+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695905; c=relaxed/simple;
	bh=TZmP8TWVpFq/RwracRcNWfJZXqBhESMwz75bOYrNJYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHvSVVqEJvrGDsBMbdDSd6bMFDnwwZwrmuyQBY0xlGwL6qvmdEVNd1oyQu60Nm1i5+aGDNp5I/7JqJQqaGGbAmGpVjuSIVXzCdUcYFir4DBrTvd84CWyLbvZzkiuqbhk0oFzu4w5vwQf5JCounfa63PqUGvv4uuKcYmCaTJrNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdpZ3INe; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e29327636f3so6989367276.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729695903; x=1730300703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuy/pIpGl6mn3xPw/OH7BSEVrrvkLmg7ErfqDPz7cEo=;
        b=KdpZ3INeDasTrZUTub8RMCoBLRlmSHXAu7IgPfWq/FbmUbKkTF0N6kCZT4lqIxDs8u
         rmdVQjpsiH4QcEZaPUivSn2yN5fvNxLIN4ShPdjnG6orcUaDpIFIyacwkVxVS75ZoH7T
         0XyRyeaO/uz1g1oE32zOqCf7QejMZErvv62zloL3msSyYI1ZBf5Vgx1O+7C8QNQ62S0M
         9/ZR6GwF09KQAZWfPWyvQV+Jzu0qU/hrdAJyLJ0rza/oqJa2rQOjTdhsWvglUCnun5FS
         /1ESmVHrUwWAOS+TXIAsmnLp4qanDTrVPHzmw1k0E6OnMIPSpzmoDI0/5UcdP9kdjlrd
         yysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729695903; x=1730300703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuy/pIpGl6mn3xPw/OH7BSEVrrvkLmg7ErfqDPz7cEo=;
        b=CCZyXoyMNr8rsmEygPfW/pJquuSPjIViwaj12hoER1J8bnmWgp+koFdo8jP5S80y3J
         e6DrwyBCTBcZfYePOnhrb+IfEhHYMxBVKuRFC9Epri8eskXqzo61ARIZYoaGMNFFyA7q
         uJpUTYPJ5yBGqzdiwvI4dPHDPPfsDFSP8u0GTmAu8RtCB6/hcMBf42Pw0EumI0Bc58JC
         TxyryVBzKu7vp78motB14/oO3QevAmJE8Wp1IPQWaP8Gx1TQOaswC3fuBXoal2zIDXXf
         lxFHRmooeoa3DQIkYAJ11iz5OdkZderHJIcLf0SMbKEXKFBxR1u8WUab4tSswVwyH6le
         6mDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJiCXyvI+sT/mMLbdcKPMAhjyYX3B7Hx4fro3F4AFpQI23+UczslwNv+z5ZT/o1iTdqqhYc2XD/fwfPPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKfKeKRDR85TlQFA357ppEitJxNtmD3+chloOXJgweoXyRfKfp
	p93cMvh+C7po7jZZnu960IrnayXPlREGOIwMDoTdgk2bypYXOQ+dlDTg1g8cWDdu9o7D/pyykIk
	LwJjQexM2ynSI7z1oZxMCR+ilQUw=
X-Google-Smtp-Source: AGHT+IE1Y01TpxnOIBcjtswNmEO/BbAvNPhtff4tFTfaBbeGDMf2QwNzGN8XWoriLkVPx1KQ0QiXg4NauA8R8LRwhVo=
X-Received: by 2002:a05:690c:dc7:b0:6e3:3019:6aad with SMTP id
 00721157ae682-6e7f0e71d8fmr30977617b3.20.1729695902914; Wed, 23 Oct 2024
 08:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020165102.340838-1-aford173@gmail.com> <4539cdd4-db5c-40ac-9c99-c15d4df49b70@kontron.de>
In-Reply-To: <4539cdd4-db5c-40ac-9c99-c15d4df49b70@kontron.de>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 23 Oct 2024 10:04:49 -0500
Message-ID: <CAHCN7xK70xJspeyQVHHZRpyGXp91gX+3=US7P3_mXBzLVZtH6Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] phy: freescale: fsl-samsung-hdmi: Expand Integer
 divider range
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: linux-phy@lists.infradead.org, aford@beaconembedded.com, sandor.yu@nxp.com, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, 
	Marco Felsch <m.felsch@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 2:04=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> On 20.10.24 6:50 PM, Adam Ford wrote:
> > The Integer divder uses values of P,M, and S to determine the PLL
> > rate.  Currently, the range of M was set based on a series of
> > table entries where the range was limited.  Since the ref manual
> > shows it is 8-bit wide, expand the range to be up to 255.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> With the typo below fixed:
>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Thanks for the review.  I'll post V2 in the next few days.
>
> > ---
> >  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy=
/freescale/phy-fsl-samsung-hdmi.c
> > index 2c8038864357..3f9578f3f0ac 100644
> > --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > @@ -406,16 +406,15 @@ static unsigned long fsl_samsung_hdmi_phy_find_pm=
s(unsigned long fout, u8 *p, u1
> >                               continue;
> >
> >                       /*
> > -                      * TODO: Ref Manual doesn't state the range of _m
> > -                      * so this should be further refined if possible.
> > -                      * This range was set based on the original value=
s
> > -                      * in the lookup table
> > +                      * The Ref manual doesn't explicitly state the ra=
nge of M,
> > +                      * bit it does show it as an 8-bit value, so we'l=
l reject
>
>                            ^ but

whoops!  Good catch.

adam
>
> > +                      * any value above 255.
> >                        */
> >                       tmp =3D (u64)fout * (_p * _s);
> >                       do_div(tmp, 24 * MHZ);
> > -                     _m =3D tmp;
> > -                     if (_m < 0x30 || _m > 0x7b)
> > +                     if (tmp > 255)
> >                               continue;
> > +                     _m =3D tmp;
> >
> >                       /*
> >                        * Rev 2 of the Ref Manual states the
>

