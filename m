Return-Path: <linux-kernel+bounces-417561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60749D55C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D56285D34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73E41DE2C5;
	Thu, 21 Nov 2024 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEWkXUOk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB35695;
	Thu, 21 Nov 2024 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229276; cv=none; b=bI7LkLoM3N6Sk8xpPlTPieRTDEIR5JYjuTKlIbrjHr9Iw9SGKA2pqn3ta08CF+7SA/xICMzH3f1cb6jTS8/KwAbOHANJyRYuYMxu3S8n0jPBthIgtut5vu8wwrdfBWla3Jw26lbisCrXO8n9/ceD+BV0/PrEyzjc+3YP99uhuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229276; c=relaxed/simple;
	bh=sZfhWbY/07YuAaIaGHpuRAtTvzoYYajtJ6K9ZbWXyo4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=VzGXOjI474SNgrtRbiAB6Yw/MkJtUXj6QpIZgAHiNGRYW0sWfGjAte4VqLkzT2gR+3xmRB22lqYXWoMz6T1HTJ1wKCiLc0ke4bECN9O/d6uhqueaFmT/oHDWJrZtFH888TYEkuTVx/Y3wEw32BlQWQ7TDVbp71n3ALdQ5z8OD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEWkXUOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FE5C4CECC;
	Thu, 21 Nov 2024 22:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732229275;
	bh=sZfhWbY/07YuAaIaGHpuRAtTvzoYYajtJ6K9ZbWXyo4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=HEWkXUOkbXhlVOhZwqX6bbxdxU0ousyDf2zbEgFvITAYMOdnlGsouXD+yK/Bjmrju
	 xvyUC3wLsxde8+SCQvjZSsxuWtMtrOIC/5tk8ki/SMWL1q2wT5hVdNgHqG+KDwlX0u
	 wroSuDavj4ZE+cReVkkANkL4A8SayTeIlKlyl5BXBsganDlufW+t85yGo1aXMNIe8s
	 LRa/5CYUdTQx0Ow+oLp2o2qYBbPovatvaRwIkjZ6DpPs0vvAAO+o7dInCmmMKoemS/
	 m0vBidvGh/NTbA567TXvyVwbXxGPx9O+cSGVaZWQ7TJ34o+V4kHZAcgcTU4m/c0aOQ
	 u4DWbVVJy1dYw==
Message-ID: <74ced7773354bac9d59f1835927247f6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241023-drm-vc4-2712-support-v1-33-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com> <20241023-drm-vc4-2712-support-v1-33-1cc2d5594907@raspberrypi.com>
Subject: Re: [PATCH 33/37] clk: bcm: rpi: Create helper to retrieve private data
From: Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, David Airlie <airlied@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Javier Martinez Canillas <javierm@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, =?utf-8?q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Michael Turquette <mturquette@baylibre.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Ray Jui <rjui@broadcom.com>, Rob Herring <robh@kernel.org>, Scott Branden <sbranden@broadcom.com>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>
Date: Thu, 21 Nov 2024 14:47:53 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Dave Stevenson (2024-10-23 09:50:30)
> From: Maxime Ripard <mripard@kernel.org>
>=20
> The RaspberryPi firmware clocks driver uses in several instances a
> container_of to retrieve the struct raspberrypi_clk_data from a pointer
> to struct clk_hw. Let's create a small function to avoid duplicating it
> all over the place.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

