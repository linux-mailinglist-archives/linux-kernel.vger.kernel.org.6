Return-Path: <linux-kernel+bounces-246176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AADB92BE8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B061F24658
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447C19CCF2;
	Tue,  9 Jul 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="qcKflvWK"
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6517B425;
	Tue,  9 Jul 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539448; cv=none; b=QnuYR1rRYNXk+IuOVou6k4Jn/cGP/l/4XIX54mRJ21RHGGZbSPkPGaSAWP2+p0rtPeM0tt8JPx5hhDP5iTiBLj+2SnIDIMqEG9ezshQI4FHkWwUkFqPW4o6cY9qFEgAMXwqACWRl5Q6pofNJu4zJWTioA20gyKQcGIXZMXf53nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539448; c=relaxed/simple;
	bh=Xk2dWsAOYkiRMa800QNsMJz1vPrBP/xB8HCyGAHzAO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GKQ1D+H6cOK5aCtkruqFD7zKdi0XIWM35P9Z5A3Sk9rlq0HAbovuEvV0QNE8Pl057friFKjMRAmyw99ysmtY46BVmlWSHIQAxcl8wna5ch5YcLAebkpJznFNePjlsI+REFO5fANPbMTz/gPv+GQ3uW5Oa/VwIZmP7R1WGGWtwso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=qcKflvWK; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2146:0:640:e7:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id BAD485F040;
	Tue,  9 Jul 2024 18:30:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id iUf9TIBfvKo0-lQjVki5X;
	Tue, 09 Jul 2024 18:30:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1720539045; bh=Eu+Rbc6iPL4yDSVzK47roezPd1zllNytDY/2RCNIz64=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=qcKflvWKybTRl0Qt8dh+yLjzCPlXn9BxpnA/EE2mYP8thaE2ufVjvdX5+4UQm0aIh
	 n28zE/ShiZIrUY0Ljuv44eWR9BJ0UlVs2pTqoelvwT6ck8t0kK7pJBPrJi1T8qIyp7
	 nBoPMs3TYDYN+NmHNS1c13M3131VRemfop2zq2Rc=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <e935d937241f9bcbaeaad5100114b50dc0f97fbd.camel@maquefel.me>
Subject: Re: [PATCH v10 03/38] clk: ep93xx: add DT support for Cirrus EP93xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>,  Nikita Shubin via B4 Relay
 <devnull+nikita.shubin.maquefel.me@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Arnd Bergmann
	 <arnd@arndb.de>
Date: Tue, 09 Jul 2024 18:30:44 +0300
In-Reply-To: <6c5d6c0730698969ef613ec9ec4aa14a.sboyd@kernel.org>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
	 <20240617-ep93xx-v10-3-662e640ed811@maquefel.me>
	 <6c5d6c0730698969ef613ec9ec4aa14a.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Stephen,=20

Thank you for looking into this.

On Mon, 2024-07-08 at 15:18 -0700, Stephen Boyd wrote:
> Quoting Nikita Shubin via B4 Relay (2024-06-17 02:36:37)
> > diff --git a/drivers/clk/clk-ep93xx.c b/drivers/clk/clk-ep93xx.c
> > new file mode 100644
> > index 000000000000..a0430a5ae4da
> > --- /dev/null
> > +++ b/drivers/clk/clk-ep93xx.c
> > @@ -0,0 +1,834 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> [...]
>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_spi_div =3D id->driver_data;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw =3D devm_clk_hw_register_fixed=
_factor(dev, "ep93xx-spi.0",
> > "xtali",
>=20
> Are these clk names trying to match device names?

Yes, ep93xx is still a pure platform SoC, so spi for example still uses
devm_clk_get:

	espi->clk =3D devm_clk_get(&pdev->dev, NULL);
	[...]
	.driver		=3D {
		.name	=3D "ep93xx-spi",
	},

This, of course, is no longer necessary in these series (since we
convert to DT).

The clock names are from CLK conversion of arch/arm/mach-ep93xx/clock.c
i made earlier:

9645ccc7bd7a16cd73c3be9dee70cd702b03be37 ep93xx: clock: convert in-
place to COMMON_CLK

Where i kept the original names which were used before conversion.


