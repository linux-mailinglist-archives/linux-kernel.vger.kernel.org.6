Return-Path: <linux-kernel+bounces-354240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9229C993A98
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F7EB23295
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD70A18F2FA;
	Mon,  7 Oct 2024 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUA6Isu5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1D18BC19;
	Mon,  7 Oct 2024 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728341792; cv=none; b=di9Ej303Eq1lQkO6FyD934ngqUGANPMQH7IXfpU8QdICqiObrIVJxqEpXwJaov58EKdgnYWcyKG4jR+dG5oGKOtzDfewe04jkOmn2Iq3gSEXalPgrvTEMc6lQiaZDzVyBSMrRanMYNKubjb1OPa6/NP+v+AOx4WtH5MBRu/jh28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728341792; c=relaxed/simple;
	bh=dKKV1EM0s4QgYvbpKmp0EseNPd4WeO/Tfh2tbg7FeGw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=tgCth+MMgYefybs89FN3wBCnzZWBtYdRCSg9s1vf+pPIghDD9TmUwcsVbLeFw9LPtkw6CWoYVpv3uEaNCu3zP0krigotUAz7H7OvMouCcm1m36d+ZQQp7sqCY/I7PXgdrsHl4o7391HyV95DNxIQ5XueOcmZliq9yaVE3RA8M0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUA6Isu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D9DC4CEC6;
	Mon,  7 Oct 2024 22:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728341791;
	bh=dKKV1EM0s4QgYvbpKmp0EseNPd4WeO/Tfh2tbg7FeGw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tUA6Isu5M+NsZH06dRE55DWXOfj8wFYag1NkXGKdvv9d/tSoKdGwwvjmNjFxtW03q
	 yDf8gxvdhUOOXUb/RzSJYPSpHXU+31OsNHtGDpu8XuinkD5AQVJKlGNWp8chtuJpnB
	 KZMTBmF+O9xTn7e5nV00YkSEzZrVpEn6jIjsOhcbJ48YUN4XZwOOSBtOqZboJ5xMs0
	 sJv1YjpZ2FFVssVbXwtcJ1t2LaA1qTA8iBPZdSaH6eLrezOzG0/9l6B5WiRF+IjCbC
	 qulqa6W7A71HbGIz3QoVQAL6XGN39OQR/RnVkdozjAf8MhAuNsvGi5JCDvaNufwwh3
	 t0v4RDvjmOlyA==
Message-ID: <c2250a7cd0e2af5077ade91279567c3b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d05d9ebd-f954-482b-878b-9dcb422821a8@astralinux.ru>
References: <20240917132201.17513-1-adiupina@astralinux.ru> <af7dc028ced22413210701a5e2e05990.sboyd@kernel.org> <d05d9ebd-f954-482b-878b-9dcb422821a8@astralinux.ru>
Subject: Re: [PATCH v3] clk: mvebu: Prevent division by zero in clk_double_div_recalc_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Michael Turquette <mturquette@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
To: Alexandra Diupina <adiupina@astralinux.ru>, Andrew Lunn <andrew@lunn.ch>
Date: Mon, 07 Oct 2024 15:56:29 -0700
User-Agent: alot/0.10

Quoting Alexandra Diupina (2024-09-24 06:14:44)
> >> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mveb=
u/armada-37xx-periph.c
> >> index 8701a58a5804..b32c6d4d7ee5 100644
> >> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> >> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> >> @@ -343,7 +343,12 @@ static unsigned long clk_double_div_recalc_rate(s=
truct clk_hw *hw,
> >>          div =3D get_div(double_div->reg1, double_div->shift1);
> >>          div *=3D get_div(double_div->reg2, double_div->shift2);
> >>  =20
> >> -       return DIV_ROUND_UP_ULL((u64)parent_rate, div);
> >> +       if (!div) {
> >> +               pr_err("Can't recalculate the rate of clock %s\n", hw-=
>init->name);
> > hw->init is set to NULL after registration (see clk_register() code). If
> > div is 0 what does the hardware do?
>=20
> Thanks for noticing the error. Yes, hw->init is set to zero,
> I will replace that code with clk_hw_get_name(hw).
> If the value of div is 0, should I return 0 as stated in the
> comment for .recalc_rate (in struct clk_ops) or should I
> return parent_rate as in some other similar rate recalculation
> functions (in some other drivers)?

It depends on what the hardware does. Does the hardware pass on the
parent rate if the divider is zero? If so, then return parent_rate. Or
does it turn off completely? If so, return zero.

