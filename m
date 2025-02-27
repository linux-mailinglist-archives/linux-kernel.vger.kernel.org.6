Return-Path: <linux-kernel+bounces-537372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8DEA48B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542A3188DA89
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C0270EB5;
	Thu, 27 Feb 2025 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEBEkmxt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81418FC84;
	Thu, 27 Feb 2025 22:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693775; cv=none; b=MuKPhCIxBJCmbBcndOBoId4xh3o+7gb/ZVdSuDTLDj1vwu4KqE5sJDAmCq4LwXbtR0WGNf00noyhBdLPFykeaLI3IOI5ENEjtNUgA9pXE4nqdvZOMjsYGNugVKWJabo4gvrB/PzUizi+rMW9P0NAOvVWsdqeg0ujNUBWO5OZXx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693775; c=relaxed/simple;
	bh=OswNnsMfOKWkoaJbZvU9dOeCrviQMmESpfO0Ycypb6I=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=eOa2ehM7YF+1H6MFNQ3ymp2TwW74lnaPUlVsMiSVt/2cxNdwTsROm80IViggiRd+vAlhleDAqmpSpVJSZbW/Gs+zS7tZJmss/mXl+RBMerBBZK9/VxZryLUpoFvKgR4o6izfdZQxEeqkIaKAlDihWOaZthErHcNoW5uazv3SNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEBEkmxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AE0C4CEDD;
	Thu, 27 Feb 2025 22:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740693774;
	bh=OswNnsMfOKWkoaJbZvU9dOeCrviQMmESpfO0Ycypb6I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=vEBEkmxtIIbLr3bx/XEBcHTv4PPFVnuFdSa6IZAIHmneCkhG3vG+jFoPOdGa2U6HO
	 HKuvCnpKJxBcr5G/40mgdwz+rRKWqFvXS/jzeWEhsxI8ZVfJrNroE0MF8wkEDKAv+b
	 CRG7hknV6XMIJcy7GCDspGkrUbdRmR4xdi3TYJim+LttYCXqGvAMqsgDjk4Gb+h2Lt
	 i1ZCUpcpLlwQQiwYie0FOGnNY7iyEjzeRVEWXp2ulsSAvsk2ni2WbhLRzBxU44oEsH
	 caigvdyG/ZQGPJfG0Zw+n+3e0ZENLvRqbZKaEZoA3Yk1J1EGgFoFZ9kekIjBPuW4O9
	 kqUVU94a03xvA==
Message-ID: <ff0b63b3822c058c110ab45b7554d52b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <10619139.qUNvkh4Gvn@diego>
References: <20250222223733.2990179-1-heiko@sntech.de> <24b641332461006bdedd5a4d682fb040.sboyd@kernel.org> <10619139.qUNvkh4Gvn@diego>
Subject: Re:  Re: [PATCH v2] clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, liujianfeng1994@gmail.com, sebastian.reichel@collabora.com, cristian.ciocaltea@collabora.com
To: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>, mturquette@baylibre.com
Date: Thu, 27 Feb 2025 14:02:52 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Heiko St=C3=BCbner (2025-02-27 06:36:39)
> Hi Stephen,
>=20
> Am Mittwoch, 26. Februar 2025, 23:32:28 MEZ schrieb Stephen Boyd:
> >=20
> > Applied to clk-next (unless this needs to fix something urgent?)
>=20
> the area where this affects something for me is slated for 6.15, so
> personally I see no urge to have this in 6.14 - especially as the effect
> is present for so long already and nobody complained.
>=20

Ok cool.

>=20
> > I also wonder if we should use a
> > different return value so that we don't try to look up the clk by name
> > (see clk_core_fill_parent_index()). We could go even further and stop
> > trying to find the clk over and over again too. Maybe -ENODEV can
> > indicate that and we can cache that parent entry value so we stop
> > trying.
>=20
> Pffff ... no clue :-)
>=20
> I.e. in the case I have, we're coming from clk_get_optional() [0].
> which is supposed to just return NULL if the clock is not found, so at
> least for the consumer view, the internals are not fixed and we could have
> different "internal" error codes.
>=20
> Not sure if more direct users of the of_clk_ functions would be affected
> though?
>=20
>=20
> In the case above, the optional clock is just a single one coming from a
> phy-block, which may probe later (needing defer) or never (if disabled).
>=20
> As for caching the ENODEV, I'm not sure how often we'd experience that?
>=20
> Like "normally" you have that one big clock-controller + maybe a number
> of smaller ones + maybe some blocks that expose one or two clocks
> to one specific user - in my case the hdmi-phy exposing its hdmi-pll
> for a nicer rate to the display controller when generating a hdmi output.
>=20
> Does a case exist where some never-probed clock controller would have
> so many clock-consumers that caching that single of-property check
> would matter?

I don't know, nobody has measured it likely because this almost never
happens. I'm happy to not worry about the caching part until it's shown
to be a problem worth fixing.

Is there any point in searching by name in clk_core_fill_parent_index()
though? We've already found the reference in DT, and it isn't available,
so we know that the search by name is wrong. It may actually be harmful
if some parent can be found by name via the fallback path for a disabled
node. I'm thinking of this patch. I also noticed that we could have just
returned NULL from of_clk_get_hw_from_clkspec() and it would work the
same, but this is probably better so that we can build EPROBE_DEFER
logic on top.

----8<----
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 50faafbf5dda..17aa6e0a8ff7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -475,11 +475,14 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *cl=
kspec)
  *              #clock-cells =3D <1>;
  *      };
  *
- * Returns: -ENOENT when the provider can't be found or the clk doesn't
- * exist in the provider or the name can't be found in the DT node or
- * in a clkdev lookup. NULL when the provider knows about the clk but it
- * isn't provided on this system.
- * A valid clk_core pointer when the clk can be found in the provider.
+ * Return:
+ * * %-ENOENT  - The provider can't be found or the clk doesn't
+ *               exist in the provider or the name can't be found in the D=
T node or
+ *               in a clkdev lookup.
+ * * %-ENODEV  - The provider is disabled or in the failed state.
+ * * %NULL     - The provider knows about the clk but it isn't provided on=
 this
+ *               system.
+ * * A valid clk_core pointer when the clk can be found in the provider.
  */
 static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 {
@@ -493,7 +496,14 @@ static struct clk_core *clk_core_get(struct clk_core *=
core, u8 p_index)
=20
 	if (np && (name || index >=3D 0) &&
 	    !of_parse_clkspec(np, index, name, &clkspec)) {
-		hw =3D of_clk_get_hw_from_clkspec(&clkspec);
+		/*
+		 * Skip lookup by name in clk_core_fill_parent_index() if the
+		 * device node is unavailable.
+		 */
+		if (!of_device_is_available(clkspec.np))
+			hw =3D ERR_PTR(-ENODEV);
+		else
+			hw =3D of_clk_get_hw_from_clkspec(&clkspec);
 		of_node_put(clkspec.np);
 	} else if (name) {
 		/*

