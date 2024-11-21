Return-Path: <linux-kernel+bounces-417563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9859D55CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B11E1F229D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C38D1DE2B7;
	Thu, 21 Nov 2024 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbtcTKIu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2201DE2B8;
	Thu, 21 Nov 2024 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229302; cv=none; b=MkwxZj/NHNqihXvcJDLsCRZq+XQEDQfSLHL/vXj7yWnlSikvY2RlRImBwYIU9uEiTVxJXzTmzG/ftjt1yzPk72d8S4fOXPUBWIkjXhr+JLp2CKSP7f+XnLoCTg06oxAj+tqAMWGoiNT3NDGGz4beFfTCOqEY+jrBWZ2OgCXHkGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229302; c=relaxed/simple;
	bh=T1fLa13P8mDRrOP8+gS00AgdX2GjJzhR8vsIwPskW5o=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=gYFax+MmQN5SlsCvlYfq4/j0MSlyRbkprqw6II12ONsrk1rXI1wjGY+586vZtjfyFUmQlG8ZB/EOPU28xandc2j2eb6BaBGEbs8Ch1qkJ+IX9cv4dHp7IPex8h0gT0KYXWFLVtgONVBr6c3xbLd+V/F3lVeH1I8p+kOendwbPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbtcTKIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652FCC4CECC;
	Thu, 21 Nov 2024 22:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732229301;
	bh=T1fLa13P8mDRrOP8+gS00AgdX2GjJzhR8vsIwPskW5o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=KbtcTKIuHq2k3j4iGWdl9hio2PzCgQZ2jAGMlIZrsvhB+x9GnstYr/Mjh7a4lbZyK
	 yfSfwfcBgP+goaruiHsFw6eZFKnbmDMB3P/qxK/QoYeEN2OH06trSzSIL8y0KH4hcN
	 WBYgvjeEGhJ2TxmV2wqGmws0kjEeQ/OBRRLOaK/yrnPUrzxktAK8da62qu0Bb3OCHz
	 1RDGnT1Q0fBb23ioUIRBAiE8/UkqcKxJGOAHB1h+vHZGa5XFq6xasIuytqIiTB5DJg
	 HJKT7K2RXFaSxnWDZ3vBmEoG5fiwUB9GdARnt12qMy4kFZWfHQoQXYwiBcUafMMXFP
	 wZTwIzdvOwu4Q==
Message-ID: <9c072de477d913acffa50696c426d8ff.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241023-drm-vc4-2712-support-v1-31-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com> <20241023-drm-vc4-2712-support-v1-31-1cc2d5594907@raspberrypi.com>
Subject: Re: [PATCH 31/37] clk: bcm: rpi: Allow cpufreq driver to also adjust gpu clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>, Dom Cobley <popcornmix@gmail.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, David Airlie <airlied@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Javier Martinez Canillas <javierm@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, =?utf-8?q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Michael Turquette <mturquette@baylibre.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Ray Jui <rjui@broadcom.com>, Rob Herring <robh@kernel.org>, Scott Branden <sbranden@broadcom.com>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>
Date: Thu, 21 Nov 2024 14:48:19 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Dave Stevenson (2024-10-23 09:50:28)
> From: Dom Cobley <popcornmix@gmail.com>
>=20
> For performance/power it is beneficial to adjust gpu clocks with arm cloc=
k.
> This is how the downstream cpufreq driver works
>=20
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---

With Maxime's suggestion:

Acked-by: Stephen Boyd <sboyd@kernel.org>

