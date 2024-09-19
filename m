Return-Path: <linux-kernel+bounces-333394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8A97C7E5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785EE288D65
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE16199FC2;
	Thu, 19 Sep 2024 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJBEZZbL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63816168BD;
	Thu, 19 Sep 2024 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726741457; cv=none; b=DMUQDK4NGep3rVpG5W8Scg+QXSN39hmhT84mbEjxfElqvJQKf3SCdvzrx9clvG3KST2TlBS9moZqLLkXakjtVo1t17cENcTRXx9cfTYkoRFFagjmVVypo6W+zpiDUq+ZIdbqPtKVeXvjVanGrzsCGXkb+u30X0hXLJBVjmy529I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726741457; c=relaxed/simple;
	bh=GfU6BSfobe/pnJnguAQFwBRmWzOKDn8vaRJUwo6cZhY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=bQsxmBY5+gVs4PrOnuSnYl61xDgoaj5PMO2qelXNW13zoRlcWdvQpL5j+N+A2aIbUxVJyXP3sSgEimCeQoDO2xdDjHNUtxidz2adHAitYcAyC8hQpXeGOIa1FeFZlPgBoHbZGEfeeiAQIFLv8boVRAQxHkzMzd4aeG/bgQ6RxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJBEZZbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326D7C4CEC4;
	Thu, 19 Sep 2024 10:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726741457;
	bh=GfU6BSfobe/pnJnguAQFwBRmWzOKDn8vaRJUwo6cZhY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UJBEZZbLcbb66fSRC47dgcPslISfqkDKAGzTyk03h3J5E/+WdQ32EBgOen+MSjrdK
	 TzakDFI0MZSvcp7F0uTm5K8I+MdRBmyYWB1DVQDY5FRzCmBjCrzyTsT0R+zRnK3PlZ
	 b/ToY+qYz2ZdrbYv9kGqb7aIaTOJz0bdJClheFgD5nFBqmZHcyWOfth0AxOBi+eC0c
	 fvugpFNiTo/+JJsXApEzVH2wyDAR65VOlLuuAlFUz0m2Y69fz1AUHdB+8fh8w2DAKX
	 ptLsGU2MwOPqIUEUSDSfKvDhfL83+50xPh8nskc+3n3wSwS4j0XnmgsYbx1wTWQT4n
	 dqloVROYjUBOQ==
Message-ID: <af7dc028ced22413210701a5e2e05990.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240917132201.17513-1-adiupina@astralinux.ru>
References: <20240917132201.17513-1-adiupina@astralinux.ru>
Subject: Re: [PATCH v3] clk: mvebu: Prevent division by zero in clk_double_div_recalc_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Alexandra Diupina <adiupina@astralinux.ru>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Michael Turquette <mturquette@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
To: Alexandra Diupina <adiupina@astralinux.ru>, Andrew Lunn <andrew@lunn.ch>
Date: Thu, 19 Sep 2024 03:24:15 -0700
User-Agent: alot/0.10

Quoting Alexandra Diupina (2024-09-17 06:22:01)
> get_div() may return zero, so it is necessary to check
> before calling DIV_ROUND_UP_ULL().
>=20
> Return value of get_div() depends on reg1, reg2, shift1, shift2
> fields of clk_double_div structure which are filled using the
> PERIPH_DOUBLEDIV macro. This macro is called from the
> PERIPH_CLK_FULL_DD and PERIPH_CLK_MUX_DD macros (the last 4 arguments).
>=20
> It is not known exactly what values can be contained in the registers
> at the addresses DIV_SEL0, DIV_SEL1, DIV_SEL2, so the final value of
> div can be zero. Print an error message and return 0 in this case.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 8ca4746a78ab ("clk: mvebu: Add the peripheral clock driver for Arm=
ada 3700")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
> v3: fix indentation
> v2: added explanations to the commit message and printing=20
> of an error message when div=3D=3D0

Please stop sending as replies to previous patches.

>  drivers/clk/mvebu/armada-37xx-periph.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/a=
rmada-37xx-periph.c
> index 8701a58a5804..b32c6d4d7ee5 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -343,7 +343,12 @@ static unsigned long clk_double_div_recalc_rate(stru=
ct clk_hw *hw,
>         div =3D get_div(double_div->reg1, double_div->shift1);
>         div *=3D get_div(double_div->reg2, double_div->shift2);
> =20
> -       return DIV_ROUND_UP_ULL((u64)parent_rate, div);
> +       if (!div) {
> +               pr_err("Can't recalculate the rate of clock %s\n", hw->in=
it->name);

hw->init is set to NULL after registration (see clk_register() code). If
div is 0 what does the hardware do?

> +               return 0;
> +       } else {
> +               return DIV_ROUND_UP_ULL((u64)parent_rate, div);
> +       }
>  }
>

