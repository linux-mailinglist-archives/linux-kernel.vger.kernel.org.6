Return-Path: <linux-kernel+bounces-266584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19F494020C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B750C1C219B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B596917FD;
	Tue, 30 Jul 2024 00:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8xotLFD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0830440C;
	Tue, 30 Jul 2024 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722298982; cv=none; b=TDwXyoHyzfgW/FzkQSvKdk5AM+LXAIDj/OoloN3sLNYJORYYkWlfDLITsrxk58FbS+Rvy7ABA/2WHiAvntezHrjo0xp4BdAxjO2Jiem0WcbqBWB7HtF0xx5gCRQf9oLJ26aDTKrMDomydZowLk6wOAS3c9DiXnFYLRVr/c6kJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722298982; c=relaxed/simple;
	bh=RqW7Gv3HX472c7JtWTo/CRCWHv8x8NgzUTyCiGmaYog=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=rh0BWjRBIjoEVGFQI22y7d2ZNFXbyuKIKVN6wQBJP8riaNlNqYUO/hbWv3IJguYiQ+EylUOcx39cur1i/lXxFbklrTgtODZvumTG4sonb6QPnY9LYXG3KcaNcxBdpuRdWtTQS1Fk+wyia4AOwzcQ067PMvhGX4qz5x3lccRFrbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8xotLFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC054C32786;
	Tue, 30 Jul 2024 00:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722298981;
	bh=RqW7Gv3HX472c7JtWTo/CRCWHv8x8NgzUTyCiGmaYog=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=k8xotLFDjXuqpyVT+nJd3yOI7pdlA52RkEFK+1GkxAekasEX14sJ7o5A/cDi0ozMx
	 unhvxnCrJY3PRu169lxnZP09HX5ZDwUalyUMFR5xlPevAtq6HWUznFVNT+zPnoe4Qt
	 m9Wa3mYmyUyiMVyDjjV2L+NXGIDXkiL/etG/njhONtcpZBN5O4+AgGjDR+Y9RvtiJ0
	 e+lH3ls2+vSOEZ/hpKGlaQhlV3hrS0nOox+C+pxnF5/W8f39cmAsyyCFpX2xB0BYvY
	 vB7iMAYw/CtPNHi6S0pHbCL3kk4UtfdQAvHkfqGWJyp1d7DhCHbBPRx3pqYZms06/4
	 YYrkB7aCU4kZQ==
Message-ID: <4bab63206ed25311b70bf5a0c98bc54e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240729-clk-u64-v2-2-ffa62ee437e6@nxp.com>
References: <20240729-clk-u64-v2-0-ffa62ee437e6@nxp.com> <20240729-clk-u64-v2-2-ffa62ee437e6@nxp.com>
Subject: Re: [PATCH v2 2/2] clk: clk-conf: support assigned-clock-rates-u64
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, Peng Fan (OSS) <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Date: Mon, 29 Jul 2024 17:22:59 -0700
User-Agent: alot/0.10

Quoting Peng Fan (OSS) (2024-07-28 19:30:53)
> diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
> index 058420562020..37b72600b296 100644
> --- a/drivers/clk/clk-conf.c
> +++ b/drivers/clk/clk-conf.c
> @@ -78,47 +78,89 @@ static int __set_clk_parents(struct device_node *node=
, bool clk_supplier)
[...]
> +static int __set_clk_rates(struct device_node *node, bool clk_supplier)
> +{
> +       int rc, index =3D 0;
> +       u64 rate;
> +       u32 rate_32;
> +       bool is_rate_32 =3D false;
> +
> +       if (!of_find_property(node, "assigned-clock-rates-u64", NULL))
> +               is_rate_32 =3D true;
> +
> +       if (is_rate_32) {
> +               of_property_for_each_u32(node, "assigned-clock-rates", ra=
te_32) {
> +                       if (rate_32) {
> +                               rc =3D __set_clk_rate(node, clk_supplier,=
 index, rate_32);
> +
> +                               if (rc =3D=3D 1 && !clk_supplier)
> +                                       return 0;
> +
> +                               if (rc < 0) {
> +                                       /* skip empty (null) phandles */
> +                                       if (rc =3D=3D -ENOENT)
> +                                               continue;
> +                                       else
> +                                               return rc;
> +                               }
>                         }
> +                       index++;
> +               }
> +       } else {
> +               of_property_for_each_u64(node, "assigned-clock-rates-u64"=
, rate) {
> +                       if (rate) {
> +                               rc =3D __set_clk_rate(node, clk_supplier,=
 index, rate);
> =20
> -                       rc =3D clk_set_rate(clk, rate);
> -                       if (rc < 0)
> -                               pr_err("clk: couldn't set %s clk rate to =
%u (%d), current rate: %lu\n",
> -                                      __clk_get_name(clk), rate, rc,
> -                                      clk_get_rate(clk));
> -                       clk_put(clk);
> +                               if (rc =3D=3D 1 && !clk_supplier)
> +                                       return 0;
> +
> +                               if (rc < 0) {
> +                                       /* skip empty (null) phandles */
> +                                       if (rc =3D=3D -ENOENT)
> +                                               continue;
> +                                       else
> +                                               return rc;
> +                               }
> +                       }
> +                       index++;

This patch is hard to read. I suspect that's because this code to skip
empty phandles is repeated. Can you expand
of_property_for_each_u{32,64}() and combine the loops? Doing that should
allow us to avoid repeating the same logic twice.

