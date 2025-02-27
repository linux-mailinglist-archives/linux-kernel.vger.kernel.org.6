Return-Path: <linux-kernel+bounces-536597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45443A481D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B1B175432
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C382356BD;
	Thu, 27 Feb 2025 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="uX7+RApk"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1243235C1E;
	Thu, 27 Feb 2025 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667004; cv=none; b=nvxo1qcIFCLLuAHd3j26M3xVFwiEdQrWWtK+3yOuYWJBltp+w4GwesG6Lfz1X3q23wyQPFJeSLXz42A06ns9ltqMAemCtdXe6uqvFfK3RbMat4hX7BHEADOLgzDQ3pVhxb48GjHfoqclPpEHmcMnNb5siuJku7HPzcW/76y2sgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667004; c=relaxed/simple;
	bh=WmGu8UBqaNEqmafRoiJAt+i+0hSd9k9YyFoBqyDaSX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFh02OplDqa1+ZOAB2vu7JORL+X76rALYiTaWaq0+B/m+t+iBFif4O0uhr8meZsbLkipkIYQq9PDtAZXfxYc0E/Y2NvM0OGxC/MGKDLPDY5dhwoEkPyADfSNKmR/tcaM6EaHF+T134zNbpiPdEWIPM+IQNJdT0PgJoDGXCJ3qdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=uX7+RApk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wRx4iYCJbJeKN/dTXbqUdgQQYMQgt3Y3UiAiJX4U/fo=; b=uX7+RApk9Vje/TfbBDrC0dz1Ix
	j0FmoL+WbKpwyEFeZiMLsOd2l7kG52KGs71FlelByzo0bcK/nIUUXYvci9PFsSMy4A8XMH3CUDhB1
	K0Jnp5gkDMcNq8db6BZ/fgzh2St+ew7cbLB3Q9p7dEwiaxyc+h44lYakjsElDJlsMJWNUMnqCB5o8
	wm6K2+4p3pzlUlmJk3r+WOL7HEaTJ07aB5wWeipAbshaR9PUp0x5CQY4asCSyOUN5+AuynNtQrxUA
	W+bgHwvd8gFOa3KnB28aLcIoNlmEjdGHe+x+ID6LNFY7iA3JpHlYwc+9A7MiVhV5DjAXayomaqIL1
	m1NliMOQ==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnf0C-0001Y4-5r; Thu, 27 Feb 2025 15:36:40 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: mturquette@baylibre.com, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 liujianfeng1994@gmail.com, sebastian.reichel@collabora.com,
 cristian.ciocaltea@collabora.com
Subject:
 Re: [PATCH v2] clk: check for disabled clock-provider in
 of_clk_get_hw_from_clkspec
Date: Thu, 27 Feb 2025 15:36:39 +0100
Message-ID: <10619139.qUNvkh4Gvn@diego>
In-Reply-To: <24b641332461006bdedd5a4d682fb040.sboyd@kernel.org>
References:
 <20250222223733.2990179-1-heiko@sntech.de>
 <24b641332461006bdedd5a4d682fb040.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Stephen,

Am Mittwoch, 26. Februar 2025, 23:32:28 MEZ schrieb Stephen Boyd:
> Quoting Heiko Stuebner (2025-02-22 14:37:33)
> > of_clk_get_hw_from_clkspec checks all available clock-providers by
> > compairing their of-nodes to the one from the clkspec. If no matching
> > clock-provider is found, the function returns EPROBE_DEFER to cause a
> > re-check at a later date.
> > 
> > If a matching clock-provider is found, an authoritative answer can be
> > retrieved from it whether the clock exists or not.
> > 
> > This does not take into account that the clock-provider may never appear,
> > because it's node is disabled. This can happen for example when a clock
> > is optional, provided by a separate block which just never gets enabled.
> > 
> > One example of this happening is the rk3588's VOP, which has optional
> > additional display-clock-supplies coming from PLLs inside the hdmiphy
> > blocks. These can be used for better rates, but the system will also
> > work without them.
> > 
> > The problem around that is described in the followups to:
> > https://lore.kernel.org/dri-devel/20250215-vop2-hdmi1-disp-modes-v1-3-81962a7151d6@collabora.com/
> > 
> > As we already know the of-node of the presumed clock-provider, just add
> > a check via of_device_is_available whether this is a "valid" device node.
> > This prevents eternal defer-loops.
> > 
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> 
> Applied to clk-next (unless this needs to fix something urgent?)

the area where this affects something for me is slated for 6.15, so
personally I see no urge to have this in 6.14 - especially as the effect
is present for so long already and nobody complained.

Though it looks like clk-next hasn't been pushed yet :-) .


> Please write a unit test (or many).

Had to look a bit ... never noticed the kunit dtso files before.
But will look into that :-) .

> I also wonder if we should use a
> different return value so that we don't try to look up the clk by name
> (see clk_core_fill_parent_index()). We could go even further and stop
> trying to find the clk over and over again too. Maybe -ENODEV can
> indicate that and we can cache that parent entry value so we stop
> trying.

Pffff ... no clue :-)

I.e. in the case I have, we're coming from clk_get_optional() [0].
which is supposed to just return NULL if the clock is not found, so at
least for the consumer view, the internals are not fixed and we could have
different "internal" error codes.

Not sure if more direct users of the of_clk_ functions would be affected
though?


In the case above, the optional clock is just a single one coming from a
phy-block, which may probe later (needing defer) or never (if disabled).

As for caching the ENODEV, I'm not sure how often we'd experience that?

Like "normally" you have that one big clock-controller + maybe a number
of smaller ones + maybe some blocks that expose one or two clocks
to one specific user - in my case the hdmi-phy exposing its hdmi-pll
for a nicer rate to the display controller when generating a hdmi output.

Does a case exist where some never-probed clock controller would have
so many clock-consumers that caching that single of-property check
would matter?


Heiko

[0] https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c#L3742



