Return-Path: <linux-kernel+bounces-417560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A2B9D55BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F02C1F22652
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7741DDC26;
	Thu, 21 Nov 2024 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr6Sfjel"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E15695;
	Thu, 21 Nov 2024 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229267; cv=none; b=pC60zInUooYJU+83oU2v3ykctBr3j5qEKuTsRbYaym/0YlYgAE1SYrXJoyZRFk/o0CJrG0XsZ31w5E4J5i6TlqSwrLuI/EXqpKIp5wkRNKkv0CABXsmvCdP0jLB4eVv2ahxraxL4e+t1ElmlC2JmcqZDECVdtJF747IIuaxtd3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229267; c=relaxed/simple;
	bh=7Rh3LO8bqPl+/ohAPK4jPsOy54AsIdEjBGcFAnaoX30=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=TWFa1P15Bimts8R0U8A2/JMe+G9CdT1LSqxxaBw/PZugCpQ0MxeA4p1wgae2E3kNG7qO9sOQWABxOEFb2zbwHgndkMfXfauj06cUvK4v8TpUfNayqYChvYcwJCJhzOQ4fUQEblENlgFa+8/m1AU7X17EBoH05vQzmP1hvFAWj9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr6Sfjel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7F0C4CED1;
	Thu, 21 Nov 2024 22:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732229267;
	bh=7Rh3LO8bqPl+/ohAPK4jPsOy54AsIdEjBGcFAnaoX30=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kr6SfjelJOok2BAk5NttJJeRSCSP9LIRA2nnQ6AIHRy40vBdokk4vG6cYfgaqxbm1
	 /MvRM9u5364nRdRVDJQaBD11YvDTsQYU/Pyyk2+EeFByqxKGKVDSMoykEKD231zHBM
	 fo7tjbm//Zc7Gu9o2EJQ8qiCath8hV9t3mwFKxWqSuKL2GvK+U/dt/A1wtfEZ9dZH8
	 WQTSNdC/6Uq9wXdPju688Tf/uYkojnK8xHJpEkrht9O42ZfzO0ij/BkfytoGXDUmHK
	 86a2Mc/cDMw2tnH7MDV2wflzWpm41FYJZnjN+RiJj1TiNZI60IteAjvPPw86k7CgSp
	 MyiJ1i/fYzykg==
Message-ID: <1cbb46bd59a85c0eb0b2e8319bb7ec63.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241023-drm-vc4-2712-support-v1-34-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com> <20241023-drm-vc4-2712-support-v1-34-1cc2d5594907@raspberrypi.com>
Subject: Re: [PATCH 34/37] clk: bcm: rpi: Add disp clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, David Airlie <airlied@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Javier Martinez Canillas <javierm@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, =?utf-8?q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Michael Turquette <mturquette@baylibre.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Ray Jui <rjui@broadcom.com>, Rob Herring <robh@kernel.org>, Scott Branden <sbranden@broadcom.com>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>
Date: Thu, 21 Nov 2024 14:47:45 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Dave Stevenson (2024-10-23 09:50:31)
> From: Maxime Ripard <mripard@kernel.org>
>=20
> BCM2712 has an extra clock exposed by the firmware called DISP, and used
> by (at least) the HVS. Let's add it to the list of clocks to register in
> Linux.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

