Return-Path: <linux-kernel+bounces-535081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E21A46E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECF516D9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635D92571A9;
	Wed, 26 Feb 2025 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM+dCu3z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9B25D8EA;
	Wed, 26 Feb 2025 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740609150; cv=none; b=ikvMw1qBWsfuTva49Cfsq1VM2Dnac6vAg9zQocOEON8wB+QO6egaJ9a8m0Nw0ACA5Gk4At63I2WXVjHFByGFi1r2F1N5YoOeVYG0qrGqffkZs9URvUIsU8NJMGSZDVVHiVxRuFhhGv5WBthrhvJRzoB9oHJAu9MPrvCwvSnFITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740609150; c=relaxed/simple;
	bh=ewq2iYDIma3Eaia/CK0Ze+cDY2qH5IAhMtulKZu9f7E=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=eCZYehdiF3Dj+PrLIEH9wglqYn6xXs8T7u9AdFqUWG12AfYbzSFQxq2fVKCIFYKXOp8Prrj4y5ly/YqojsWt3Xd6CRXQhdyemLw1RPdeWrdTY9xUOp3OkpohkTuocFZfDUOcl/NQMmkXURlmp4Eh9O0wJ2MV8aPmoKevr7Eso00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM+dCu3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84961C4CED6;
	Wed, 26 Feb 2025 22:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740609150;
	bh=ewq2iYDIma3Eaia/CK0Ze+cDY2qH5IAhMtulKZu9f7E=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gM+dCu3zSXgP0vfv1zk0gj6h3oNPNl0PElzsk0x1f5eWDzXJHX0EoC2V2fPRrEESY
	 VD4Z4dtx7XA2be0lAzeSsoxrlcP/ZQd/mYvrfoIDG3XkMx0f+X1/lgXO+T9a5OHaTZ
	 Pewm8zsLi5m+VieImStVD7ghKyVVfS3BXy242hwYNuKd5kxXASWiUbJmE/NzQ8VRX5
	 47OvCoDdb/t1kXw6TpZ/vaztlZgUrjEckmJx+TVl+fJbNjtyHFVYZi3NXzwBXb6wTg
	 pDeXkuIJfIaQuDMUFB6YxzY4QHULpMhfnk+huq+RSdr4yNEiK/K2aGDcMG34wVa/hu
	 gynIpQkJSNG+g==
Message-ID: <24b641332461006bdedd5a4d682fb040.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250222223733.2990179-1-heiko@sntech.de>
References: <20250222223733.2990179-1-heiko@sntech.de>
Subject: Re: [PATCH v2] clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, liujianfeng1994@gmail.com, sebastian.reichel@collabora.com, cristian.ciocaltea@collabora.com, heiko@sntech.de
To: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com
Date: Wed, 26 Feb 2025 14:32:28 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Heiko Stuebner (2025-02-22 14:37:33)
> of_clk_get_hw_from_clkspec checks all available clock-providers by
> compairing their of-nodes to the one from the clkspec. If no matching
> clock-provider is found, the function returns EPROBE_DEFER to cause a
> re-check at a later date.
>=20
> If a matching clock-provider is found, an authoritative answer can be
> retrieved from it whether the clock exists or not.
>=20
> This does not take into account that the clock-provider may never appear,
> because it's node is disabled. This can happen for example when a clock
> is optional, provided by a separate block which just never gets enabled.
>=20
> One example of this happening is the rk3588's VOP, which has optional
> additional display-clock-supplies coming from PLLs inside the hdmiphy
> blocks. These can be used for better rates, but the system will also
> work without them.
>=20
> The problem around that is described in the followups to:
> https://lore.kernel.org/dri-devel/20250215-vop2-hdmi1-disp-modes-v1-3-819=
62a7151d6@collabora.com/
>=20
> As we already know the of-node of the presumed clock-provider, just add
> a check via of_device_is_available whether this is a "valid" device node.
> This prevents eternal defer-loops.
>=20
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-next (unless this needs to fix something urgent?)

Please write a unit test (or many). I also wonder if we should use a
different return value so that we don't try to look up the clk by name
(see clk_core_fill_parent_index()). We could go even further and stop
trying to find the clk over and over again too. Maybe -ENODEV can
indicate that and we can cache that parent entry value so we stop
trying.

