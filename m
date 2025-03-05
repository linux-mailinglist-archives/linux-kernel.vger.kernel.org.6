Return-Path: <linux-kernel+bounces-547864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1C9A50E7A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3727D188F02C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01B526658F;
	Wed,  5 Mar 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0jTs1xQc"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ACE202C4F;
	Wed,  5 Mar 2025 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213301; cv=none; b=nlDKbIYCJeC7GUKfcx/pwNFVQ9UygDbMRCkfj3fm/mEC4fKNkHEnrZ4zXuCJxH+nGA28o+53cVa+wZPFe9RWF6XMcxwNG8yKb2nqqKF2raRALq6kDZdavpSK4SmD6geGHki3MB9sK7BGspVe63vdHiWBGH0TKbeV9CZx0JRPhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213301; c=relaxed/simple;
	bh=Kt0JHoQRDxazbM9HAqvNWHaRPFS/Pp4uw1z28ZVUUwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZIH/oJ8yyglK4tsSlLnKfg8b8bAqDJmphYowf/rp29T1RUpgoqOcBJqjNBBmP7sNHL/J8okeq6VaMXYvg4uVQUOuurYSRiRDt2L14lGUgHR6t96Y7VP4A9b0PyQ58kEy1T4DWJEd/Z/KSBrbMbLGvl1evai8CSnbewRhPnXekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0jTs1xQc; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=06kA3D7q5+feETjZztMj3/pQCz9ZvioWeY+GXfhxs+g=; b=0jTs1xQcFwh5ox+whGadW7md9L
	WS1OfCwNfoT/R60g3n715mKlYtI9WjDijcapfP4h/inDZR9976tcNGiyoNj0+yyneWUUZ2ggYSdAe
	yTo082HyUXdH7MF4UTjHFsIIOaEanyKuNhhTjVOJGqQtmCMT0qjnUX24pLy8QLutraI3hv/b0hqYT
	NjRL5QdypTnZidKKbC9xcOtUQ/4uTdV1VVo/ryphnbf6BiucQwY7rFp0uoRRwUprlDco3Mtw4ZcWk
	t1fJObmKUI8LjICwz9D/wFRCAQHEJ0kTZTE91wGbNagju9vdMn3f0SDQJxg7PBglm6o8jBr62LP8Y
	IiygmWWQ==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpx74-00060i-4M; Wed, 05 Mar 2025 23:21:14 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sugar Zhang <sugar.zhang@rock-chips.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 2/7] clk: rockchip: add support for GRF gated clocks
Date: Wed, 05 Mar 2025 23:21:12 +0100
Message-ID: <4964374.GXAFRqVoOG@phil>
In-Reply-To: <20250305-rk3576-sai-v1-2-64e6cf863e9a@collabora.com>
References:
 <20250305-rk3576-sai-v1-0-64e6cf863e9a@collabora.com>
 <20250305-rk3576-sai-v1-2-64e6cf863e9a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hey,

Am Mittwoch, 5. M=C3=A4rz 2025, 22:24:22 MEZ schrieb Nicolas Frattaroli:
> Certain Rockchip SoCs, the RK3576 in particular, have some clocks that
> are essentially gated behind an additional GRF write. Downstream uses an
> additional entirely separate clock driver that maps over the same
> address range as ioc_grf in the DT.
>=20
> Instead, this implementation introduces a new gate type, GRF gates.
> These gates function quite like regular gates. In effect, this means
> they'll only be enabled if the clock is used, which I feel is a more
> appropriate way to describe this compared to doing it in, say, pinctrl,
> or even in the drivers of the respective clock consumers such as SAI.
>=20
> It should be noted that RK3588 has similar GRF-gated clocks, but has
> gotten away with not having to deal with any of this because the clocks
> are ungated by the hardware's register reset value by default. The
> RK3576 is not so lucky, and the hardware's reset value gates them
> instead, which means we'll have to ungate them somewhere.
>=20
> In order to facilitate the GRF gating on RK3576, we introduce the
> concept of auxiliary GRFs. The RK3576 has several defined GRF nodes, and
> so far it could get away with just using one for MUXGRF by reassigning
> the clock provider's grf member.
>=20
> However, with the IOC GRF gated clocks, we now also need access to the
> IOC GRF, so we can't get away with this anymore. Instead, we add a
> hashtable to the clock provider struct, keyed by a grf type enum. The
> clock branches can then specify through the use of a new member of that
> enum's type (with corresponding changes to relevant macros) which GRF
> range they would like to use.
>=20
> The SoC-specific clk_init can then populate the hashtable with the GRFs
> that it needs. This way, GRF-dependent clock branches don't have to be
> registered in a different step than everything else, as they would need
> to be had I extended the branch struct to instead take a pointer to a
> GRF, which isn't available at the time most of our branches are defined.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

I only did a short look through the patch and didn't see anything
glaringly wrong, but this wants to be at least 3 patches:
=2D add the handling (hash-table etc) for multiple grfs
  (including adapting the grf-mux)
=2D adding the grf-gate clock-type
=2D adding the rk3576 grf-gates


Heiko



