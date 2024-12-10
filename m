Return-Path: <linux-kernel+bounces-440444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB69EBDFD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7F8284075
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69FF1F1905;
	Tue, 10 Dec 2024 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0KXdhbb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0B2451C7;
	Tue, 10 Dec 2024 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870662; cv=none; b=pveLuWutPUGe7dxukpATLIXseQwrhtUsQgWA6c9lFKzVM5KlpSesuYYMoTw9dCfJla93E8VGDyll8HtIpv00dQ0boZx+jVeQcyam4upLyTN/pgl0klJvmKhlmgVEgpfW6dRUEkOX8YP+W6Q1rTge/kmpE+tp2ilwo5B+JFANVnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870662; c=relaxed/simple;
	bh=HP4MsNw/hXG7nhPJ0xWXWHKylFCTW4+JsqUQHNFKB2k=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=AQYIT1FMThmmPkR0PdE4M1nAp2tmpe6PKRjLEPxb1nmhjfYCEVJiCqlSMPdQeYxwhadw8GCI2hstRmOOWnLrzld06cHsQdp5dJKgw0Mc9H6JV5/WGHb/9KK64migGkzXjYgLN1AgxNamn2KlQYZsKAHZ/3mJ3ojJtWmF+ni2ync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0KXdhbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCD1C4CED6;
	Tue, 10 Dec 2024 22:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733870661;
	bh=HP4MsNw/hXG7nhPJ0xWXWHKylFCTW4+JsqUQHNFKB2k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=G0KXdhbbJ5rvvoDZqYRO6wYCU/J0eN/NtedIKQgZEPd2HdA2GPfsSOitJG8EW5ruE
	 DxH6lGL9Jr28NBCy+ZXrSsNn4DVjD0FvcBq1IHIi8pNEFXKvR0PCQrZT9C7+C2x+Zt
	 cxr1ixqZFf4slma0NhtmDYZ3q3DJxoHTkAmgxWTDbL8Ev4br2lExKoFXnGeQAGzVOf
	 HzJ+oAHkfu/VaOcs5R0EREvFKR/EWDek4d7n6ZYmLXnQjDdqPaxB/vwJBhXM+eu9jo
	 EIMrcVv9FF1sRyIKhwGu/JpCsHIZIhFmBYk/dVCi+OK6hJLpBpte73ViEaZLFrwE81
	 CWJLj4Z6TEJOg==
Message-ID: <fd2b473bc7c3c70ae0e85b2a6315d9e8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241121-ge-ian-debug-imx8-clk-tree-v1-4-0f1b722588fe@bootlin.com>
References: <20241121-ge-ian-debug-imx8-clk-tree-v1-0-0f1b722588fe@bootlin.com> <20241121-ge-ian-debug-imx8-clk-tree-v1-4-0f1b722588fe@bootlin.com>
Subject: Re: [PATCH 4/5] clk: Add flag to prevent frequency changes when walking subtrees
From: Stephen Boyd <sboyd@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Abel Vesa <abel.vesa@linaro.org>, Herve Codina <herve.codina@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Ian Ray <ian.ray@ge.com>, Miquel Raynal <miquel.raynal@bootlin.com>
To: Abel Vesa <abelvesa@kernel.org>, Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>, Michael Turquette <mturquette@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Ying Liu <victor.liu@nxp.com>
Date: Tue, 10 Dec 2024 14:44:19 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Miquel Raynal (2024-11-21 09:41:14)
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index adfc5bfb93b5a65b6f58c52ca2c432d651f7dd7d..94d93470479e77769e63e9746=
2b176261103b552 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1927,7 +1927,6 @@ long clk_get_accuracy(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_get_accuracy);
> =20
> -__maybe_unused
>  static unsigned long clk_determine(struct clk_core *core, unsigned long =
rate)
>  {
>         struct clk_rate_request req =3D {};

Please add functions in the same patch that uses them. It is hard to
review this patch when half the context is in another patch.

> @@ -2272,7 +2271,13 @@ static void clk_calc_subtree(struct clk_core *core)
>  {
>         struct clk_core *child;
> =20
> -       core->new_rate =3D clk_recalc(core, core->parent->new_rate);
> +       if (core->flags & CLK_NO_RATE_CHANGE_DURING_PROPAGATION) {
> +               core->new_rate =3D clk_determine(core, core->rate);
> +               if (!core->new_rate)
> +                       core->new_rate =3D clk_recalc(core, core->parent-=
>new_rate);
> +       } else {
> +               core->new_rate =3D clk_recalc(core, core->parent->new_rat=
e);
> +       }
> =20
>         hlist_for_each_entry(child, &core->children, child_node)
>                 clk_calc_subtree(child);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 200135e0f6d00d48b10e843259333b9733c97f38..baef0b442ac1d36ee935cbcaa=
aa4e2d95fe7654c 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -38,6 +38,8 @@
>  #define CLK_OPS_PARENT_ENABLE  BIT(12)
>  /* duty cycle call may be forwarded to the parent clock */
>  #define CLK_DUTY_CYCLE_PARENT  BIT(13)
> +/* do not passively change this clock rate during subtree rate propagati=
on */
> +#define CLK_NO_RATE_CHANGE_DURING_PROPAGATION BIT(14)

Why doesn't rate locking work?

