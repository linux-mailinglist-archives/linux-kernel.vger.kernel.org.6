Return-Path: <linux-kernel+bounces-420171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4A9D7650
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888EF28473F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0941C42AA0;
	Sun, 24 Nov 2024 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZLwfTd3k"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016DA2500D9;
	Sun, 24 Nov 2024 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732467846; cv=none; b=BKc7L7JiyhJOP9tL+pJI8RnqczjyKvXUYKniYTx5xJSdDfR/6sYek9rfR4rCFkOORzSz1Nm063xh3FT1hX99V603ij0vvM+EXwhdbFGnWqkWLmg6CFfYqEe7VaPE89F8wKnKd++NiMoga3BFYkxSfnL4g2cjx6B6EDwwWzeBtyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732467846; c=relaxed/simple;
	bh=0nUyTFgN93JxdXis2A1wjb0ApbtOrSZY//1Dp6Ir21Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoNWR5JP+4+8GJ9Apw+l/RNTO9w/g8+yu2Nj5drZ0aGTuc5dGAxe1FSZ24zvvfQ5yzre/yw/Cjf137Y2pjV5x1YVJvXh73iKOGzLSCjXH7Lrall/09fYzkD5htWcj6VYBCSSVSrnS8Ayg4FhWNZs9szYRwXd/cjpW7Y1gZHFKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZLwfTd3k; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 50157C0005D4;
	Sun, 24 Nov 2024 09:03:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 50157C0005D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1732467838;
	bh=0nUyTFgN93JxdXis2A1wjb0ApbtOrSZY//1Dp6Ir21Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLwfTd3k1VZLYnirJBPxFlwYvo4yvosVee3xExCJ75wy5e8Xqkk/KWSaSC23RdlgK
	 zVjxm/q/fXcmBO7C2sbvxPxjKZ/8i+vyURWadI+I3h/3ZqcVOcAV0NCA5yI8oe8kqa
	 YabO1eWeQSjeRAFU8e1gkvvJnWHpdDgLLxBtVlnM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id BFF0418041CAC6;
	Sun, 24 Nov 2024 09:03:57 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?b?TWHtcmE=?= Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 34/36] arm64: dts: broadcom: Add firmware clocks and power nodes to Pi5 DT
Date: Sun, 24 Nov 2024 09:03:57 -0800
Message-ID: <20241124170357.710628-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025-drm-vc4-2712-support-v2-34-35efa83c8fc0@raspberrypi.com>
References: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com> <20241025-drm-vc4-2712-support-v2-34-35efa83c8fc0@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Fri, 25 Oct 2024 18:16:05 +0100, Dave Stevenson <dave.stevenson@raspberrypi.com> wrote:
> BCM2712 still uses the firmware clocks and power drivers, so add
> them to the base device tree.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

