Return-Path: <linux-kernel+bounces-305130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AC29629E7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56519281658
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342221898F1;
	Wed, 28 Aug 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3HPIpIJ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B88189510
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854289; cv=none; b=OgFPjaRjHoshO7b1uq2lBmTHAmTBJpfQBeQGF+l0PRARsg2Qs5EzhpFY3XBcC5A6LNnrukILCSHWz+KYqlyvXsOpvYYTEdTM/dUcQ6WbZN2aeQTBeaPt1XOfH8ubFT/sbPXvW7zhm/kaNtWnzLPmKtImLZ73dc1C3HoOS0IPgkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854289; c=relaxed/simple;
	bh=8UEAJf5udl/HAoxBKOq05jj2eo/xcTlau7hm3mHqi5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlNBS1+GLNrpksNPv9fQFez8/ekCl5yxkoVNQyw3BL66iJj0ETTT/jrpUxcjEDFEv/6KNQC9zGN3HfcKUQ5kcNrY/IlYY/hOy5EOBQxiugR0rf2+Kr6tNzdqRn3YMQi+DzpnmJrfPQ8ET7ERA7pPnXpgjLqEU6Kr0/6k+AcHNhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3HPIpIJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-202376301e6so53430125ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724854287; x=1725459087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaF6W7lu2QVgwA/GjYxh6X4B7gmKcHBYm8H+RZZze/c=;
        b=T3HPIpIJw0AzO7uO7R7lR0tqpytMWu4bjOK9H7oCkb0UAppFY6F51Pw8D0bUG+Jnc3
         ZDC1+Of7CoJgLWz10KmYXIAkHD0MHvSr2QXDIzjndX7AbHBOXBBgbP66bPHUGNzqrpA4
         e8mLSfn7XsWHtcwvqs0YUnv0ANNDsYiWWtCp6i1Pqfb1dscSJkZti9CjYwgxLoY+ZgUr
         acX2hJdQUh3IehGHzfbsM6k5PSYD1koNo61LekHH3TdEi9Y0xipcin4tjg2/ltzj17CT
         r/F83MoCKTJEgzrlXVnG6oOuvi3/XI9G3230yMWVZsZPYoz4Q+zQMxhP3Fb2oL/kPyUH
         a3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854287; x=1725459087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaF6W7lu2QVgwA/GjYxh6X4B7gmKcHBYm8H+RZZze/c=;
        b=L3gtIynOWnQognTr6iiNeJXS6zi37fBELs6IYEjQt1Jc5L48pzfAodnVvIzphKmYHG
         AddWFTKY5IhRWzNctec6ENWfGtPbcNd+UFhY+Tf3O5J1jbDdGEXQiReuSbTrD/2LIQRS
         zyJPUApUYrRYQ7qVMTObgLY9Wi9944vndyvcBVnEbru0G4Wkjn1CbuGwL4r01TDUeFzo
         jvn3eENoUs+QzC43XCDdzL0RlcWBexGfbd0ZBM5ktAqq47/zGT4lwYz5eOhN0s9BWOYp
         uQAN0IhjwGNnIBq+wrLB4AUnvYswBYoXvcIOE9axKUSAahP+3J4E6XK+Q8ALVfMPp72P
         dhMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsQtKjdzqE58FLYPn/MYldaTPRt81bpM54DqoS+vEMDgC1EXjdkZEP2Djf/euiA9JOM/WnmEjGkKGVQao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTsNI+XbgnNoiI7JwgvptEhc1h7ee8hNWBXNkViONi1HjIAtQ0
	eubjbFIGskum9h2PjXM3EAhwdO0zTUSbP2pY5bF4MxGHrkMsIkmJhBIaKsvEtPFsp+Ap+Zz0kiC
	L7KGHAroZZGIudjpSWDKjXuhC3Es=
X-Google-Smtp-Source: AGHT+IF8mMovITDlzNzeIznFSgzkSkncRGxB+afLX3C7vxnmqR9qXfni98H9Hf6uoLmdbjieRP7fC5udoY1GhEgyvx0=
X-Received: by 2002:a17:90a:514c:b0:2d3:b970:e4d4 with SMTP id
 98e67ed59e1d1-2d646d55712mr16814723a91.38.1724854287227; Wed, 28 Aug 2024
 07:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828024813.1353572-1-aford173@gmail.com> <20240828024813.1353572-2-aford173@gmail.com>
 <Zs7kJ6vCDbxVvxU1@atmark-techno.com>
In-Reply-To: <Zs7kJ6vCDbxVvxU1@atmark-techno.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 28 Aug 2024 09:11:16 -0500
Message-ID: <CAHCN7xLX1FPQFFBsgfd4Msa+y=KNay9M9q1fu=P1uuKZLacS4g@mail.gmail.com>
Subject: Re: [RFC 2/2] phy: freescale: fsl-samsung-hdmi: Support dynamic
 integer divider
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com, 
	frieder.schrempf@kontron.de, aford@beaconembedded.com, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Marco Felsch <m.felsch@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>, 
	linux-kernel@vger.kernel.org, Makoto Sato <makoto.sato@atmark-techno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:47=E2=80=AFAM Dominique Martinet
<dominique.martinet@atmark-techno.com> wrote:
>
> Adam Ford wrote on Tue, Aug 27, 2024 at 09:48:02PM -0500:
> > There is currently a look-up table for a variety of resolutions.
> > Since the phy has the ability to dynamically calculate the values
> > necessary to use the intger divider which should allow more
> > resolutions without having to update the look-up-table.  If the
> > integer calculator cannot get an exact frequency, it falls back
> > to the look-up-table.  Because the LUT algorithm does some
> > rounding, I did not remove integer entries from the LUT.
>
> Thank you!
>
> We're still running 5.10 so I backported the driver as of it's current
> state first (that part works), unfortunately our 51.2MHz display does
> not work with this.
>
> After phy_clk_round_rate() not round the pixel clock to the table values
> (otherwise we'd only get rounded values), and making phy_clk_set_rate()
> pass the requested `rate` instead of using the next smaller cfg->pixclk,
> the display no longer comes up.

Do you want me to create a table entry for 51.2MHz?  I am pretty sure
the integer engine can handle it.  I'll investigate what's calling
phy_clk_round_rate to see if we can use the PMS calcualtor to avoid
the look-up table.


>
> It comes up with the values obtained for 50.4MHz (next closest value),
> which also has an exact match so uses the integer divider this patch
> computes instead of the table values, but not with the 51.2MHz it
> requests...
> I'm afraid at this point I don't know how to debug that further without
> getting a scope out (I don't know if the soc isn't generating something
> correct or if the display actually doesn't like the frequency it
> requests?! the later could be checked by plugging it in to another PC
> that might support that frequency...), and that is going to take quite a
> while...
>
> Hopefully Frieder will have more success with his displays?
> It could also be very well due to some of the differences with our 5.10
> tree, sorry about that.
>
> >  static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy =
*phy,
> >                                         const struct phy_config *cfg)
> >  {
> > +     u32 desired_clock =3D cfg->pixclk * 5;
>
> (I don't really understand where that `* 5` comes from, but I guess it's
> expected? works for other display and neighbor frequency anyway...)

When I looked at the LUT entries for the clock rates that don't need
the fractional divider, I noted the clock rate was 5x the pix clock.
This was consistent for each entry.  Even when the fractional divider
was used, it appeared that the clock rate was 5x the pix clk.  Because
the PMS calculator I wrote is expecting a clock rate, I just
multiplied by 5 here instead of inside the PMS calculator.

adam
>
> Thanks,
> --
> Dominique
>
>

