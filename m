Return-Path: <linux-kernel+bounces-417562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D249D55C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D53285CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5CE1DE3C3;
	Thu, 21 Nov 2024 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mrp+Zopb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6F5695;
	Thu, 21 Nov 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229284; cv=none; b=phof9+/bCW9DVqryRlk4Ua3PmdqcSpwqTBROR9RCyqH1jEA7AA1BblU3rjGbSEm9a6usJ3wbWtWRslLGx4PwLZ44WOz5E4s8/PUeBGLtE+KS8uUdT37HBqPoHkQ9ECR+XGLtadgle3uCsDs5NS0Z50uLndhCRZ2HjgPKzgCaWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229284; c=relaxed/simple;
	bh=C6wHdyoxNUpRBpMmh2gL69b2b/+Ef17Hp0UH+78w4OU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=FR2x156mTGxtzUBgJuTiz/ZAeSM8eTBoJehNtvb/4iL9ouWOFUPHFGJ59wAx5uFC9fyq8saaL0fctZvAR3tJR4RAAOoG5RTEVTEOUnKkPaDjyo1SyGrZ2q373bhGpeplzSZudNxv0pvCWdSVMyGI824QKNgdFSee6g0os45d+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mrp+Zopb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48306C4CED1;
	Thu, 21 Nov 2024 22:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732229284;
	bh=C6wHdyoxNUpRBpMmh2gL69b2b/+Ef17Hp0UH+78w4OU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Mrp+ZopbIzV1tWMTzQfBqXI/6aeODAjiJxx03uR0PixV42c/T2Gdae1dC4YkYtWa4
	 q9fmXQfk3cor5CLV6P2qMPu04IPHoMUAV368u7I6mb/pj+YiWxKJsMNuQsPpgzoHBs
	 Jmf54SfKBUrFxRE0ajzePZEYMzOxQiCN0+CPdf+MPIBjD8XUq92GnQAh+duupRwNbw
	 SnB9Ngb8GvhjbNvdDAz/bfgYqEt5/5A6GZG+XlPx0xv3tqeUSltq2JC1k1WxWwkObO
	 QRgS2uZyMERL1e37gskDx1X2PJ03KtBGCWXkntcsAfykiljBcEZQAwGyXNDJ8J4Px/
	 N0vohKaaK9wBA==
Message-ID: <3c0b2c0206254bb8940bc34b3297bcbd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241023-drm-vc4-2712-support-v1-32-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com> <20241023-drm-vc4-2712-support-v1-32-1cc2d5594907@raspberrypi.com>
Subject: Re: [PATCH 32/37] clk: bcm: rpi: Enable minimize for all firmware clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>, Dom Cobley <popcornmix@gmail.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, David Airlie <airlied@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Javier Martinez Canillas <javierm@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, =?utf-8?q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Michael Turquette <mturquette@baylibre.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Ray Jui <rjui@broadcom.com>, Rob Herring <robh@kernel.org>, Scott Branden <sbranden@broadcom.com>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>
Date: Thu, 21 Nov 2024 14:48:02 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Dave Stevenson (2024-10-23 09:50:29)
> From: Dom Cobley <popcornmix@gmail.com>
>=20
> There isn't a reason not to minimise the clocks, and it saves
> some power.
>=20
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

