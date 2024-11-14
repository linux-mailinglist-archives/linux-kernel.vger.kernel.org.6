Return-Path: <linux-kernel+bounces-409923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39019C936E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0D41F218A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8731AD9F9;
	Thu, 14 Nov 2024 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDPyY+eh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5A1AA785;
	Thu, 14 Nov 2024 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617405; cv=none; b=KrrqkR+id/kRKExLLMZ6Oy8D6/2/Y4NvP/hfprVxr1dbw+b5wAiWcTOYllWovLWvpDJlMRxOoxnH64Xd0pYf9+LUXgx/QaIf8VgDCzzHKcQSTq+H8uXFhHJCGho2x1KN+52TGLr8st9CpIOeehdebKIPGDSR+LbfryJoWMJNYTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617405; c=relaxed/simple;
	bh=tBT8ineTKjg4Yt2AW/nnriabGseZrz4R8cF7mCmhPJc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=MTZvaWAhOlYBVH2QCw4q9cgBOYdbfM8XS+WlHFoYZtsxp7CzPTMz/1eNDKZ4tTeM2BqZiK38/UkGjNluzkmODnGX+/27tSGudOzwWi1OF4AVpafz4uPDxHXOE6fSXLqw47h3UhuOk6JajmWmCNNHKjyrwkGqBZ2/tQ3sblgaUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDPyY+eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE14DC4CECD;
	Thu, 14 Nov 2024 20:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731617405;
	bh=tBT8ineTKjg4Yt2AW/nnriabGseZrz4R8cF7mCmhPJc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=dDPyY+ehyk/4WI/BajEOYyluBktF6D2SOBc8m0ihlz73SrfEAimi8nwghQU9Ftuqf
	 H61OLu9mxt+W2aZrogFZx6O9muBYVYkn5N132uS2DYIes4wpNGPUmbvGFvt5Y5YHis
	 T2JTTTGYKiQU+aOSbnCPpm4kMK3pzSadwna/NlIuczFmdsCmVV187NqyVImlLIlhu4
	 wUm0WZIJ4s4rx2UsXapB/ZXhsPvosojMdsxvqrDN/l+ppn3kf0kUQWZMislvEby5Vt
	 FKhMfwx/4EMqO+PXl3MgoXWppxT/+yRBoONJmytOMXyHyFUMFfdm1zPbFzFLXOpc6c
	 1GQL0zhNVld7w==
Message-ID: <410a98684ff9f782a53035e512d9a52d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240910044024.120009-3-sergio.paracuellos@gmail.com>
References: <20240910044024.120009-1-sergio.paracuellos@gmail.com> <20240910044024.120009-3-sergio.paracuellos@gmail.com>
Subject: Re: [PATCH 2/3]  clk: ralink: mtmips: fix clocks probe order in oldest ralink SoCs
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, tsbogend@alpha.franken.de, yangshiji66@outlook.com, linux-kernel@vger.kernel.org
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>, linux-clk@vger.kernel.org
Date: Thu, 14 Nov 2024 12:50:03 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Sergio Paracuellos (2024-09-09 21:40:23)
> Base clocks are the first in being probed and are real dependencies of the
> rest of fixed, factor and peripheral clocks. For old ralink SoCs RT2880,
> RT305x and RT3883 'xtal' must be defined first since in any other case,
> when fixed clocks are probed they are delayed until 'xtal' is probed so t=
he
> following warning appears:
>=20
>  WARNING: CPU: 0 PID: 0 at drivers/clk/ralink/clk-mtmips.c:499 rt3883_bus=
_recalc_rate+0x98/0x138
>  Modules linked in:
>  CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.43 #0
>  Stack : 805e58d0 00000000 00000004 8004f950 00000000 00000004 00000000 0=
0000000
>  80669c54 80830000 80700000 805ae570 80670068 00000001 80669bf8 00000000
>  00000000 00000000 805ae570 80669b38 00000020 804db7dc 00000000 00000000
>  203a6d6d 80669b78 80669e48 70617773 00000000 805ae570 00000000 00000009
>  00000000 00000001 00000004 00000001 00000000 00000000 83fe43b0 00000000
>  ...
>  Call Trace:
>  [<800065d0>] show_stack+0x64/0xf4
>  [<804bca14>] dump_stack_lvl+0x38/0x60
>  [<800218ac>] __warn+0x94/0xe4
>  [<8002195c>] warn_slowpath_fmt+0x60/0x94
>  [<80259ff8>] rt3883_bus_recalc_rate+0x98/0x138
>  [<80254530>] __clk_register+0x568/0x688
>  [<80254838>] of_clk_hw_register+0x18/0x2c
>  [<8070b910>] rt2880_clk_of_clk_init_driver+0x18c/0x594
>  [<8070b628>] of_clk_init+0x1c0/0x23c
>  [<806fc448>] plat_time_init+0x58/0x18c
>  [<806fdaf0>] time_init+0x10/0x6c
>  [<806f9bc4>] start_kernel+0x458/0x67c
>=20
>  ---[ end trace 0000000000000000 ]---

Applied to clk-next

