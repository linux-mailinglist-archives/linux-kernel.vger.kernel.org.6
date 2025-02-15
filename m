Return-Path: <linux-kernel+bounces-515914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64843A36A72
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0576316E8E7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6A61A23B8;
	Sat, 15 Feb 2025 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QWYreGa/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C856582D98;
	Sat, 15 Feb 2025 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580957; cv=none; b=f2Eqa46InYsaPuvacpCpDjhxNaoUzYvSCnXuYLQ4XfjEFXVIeqAHbJK55YbSsBSFkQecYI3291iHq6VBqEIqc5OnRG3RW7Wlys/Qs2ndYOMewMVF2BJSOQ0gKfngvINgeQKC4tT9S7ovRMCaPyrtGXjOrBPoX382DV3xIgp/xH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580957; c=relaxed/simple;
	bh=nIXcpxIUSKHDj4yKjrFu8Z6Y37bAcj6b8+fVzwIrLgY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a3rMHvgEPUFLecTpXw710Gugoa/R4tMHe6hybeSzv8UMyVUZCybPXJCuzRaO2oSjJx2kzzzmfbz9GgPcIACcJxValgJ3tOiGHduA6NwvBNLroEzeq+gP68Ihu99p2VUbO1JhqEr9EUDF6rZ/oACE0K8SlZcQtpNRcjOU8oNEdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QWYreGa/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739580953;
	bh=nIXcpxIUSKHDj4yKjrFu8Z6Y37bAcj6b8+fVzwIrLgY=;
	h=From:Subject:Date:To:Cc:From;
	b=QWYreGa/6yH2TXVLCawRPa35+LxXk1hZym5F2VlQ/OyTS+GV8svkU/rjrS39UK8Mk
	 4Sq7DqMdekxG1Cthb89kmnzRgRt3PJ6CHaVPKm3sQ1+gI/0/svXob35j6BFjADRuEx
	 1B5+KfOda3u2ens8t/F5O7sxoeq/ZPrmGk7cCLon8fhAOjx9jHqgse+d9EWZWs6kuw
	 GYymbHStNxvxdHakffxSE3+dSlIkI4iyEaks1mH6x7GBI7BcFopC/Qx4oRXZuCtDKa
	 Hbj8/d+5Q2XxFvx7kMX9sRLCN9B+9J46DlleRinvN1d7u5/DEUUXi+KcqGhkmnSUWk
	 PlqX7CTWZxZ/g==
Received: from localhost (144.232.221.87.dynamic.jazztel.es [87.221.232.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 613E817E0239;
	Sat, 15 Feb 2025 01:55:53 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/4] Improve Rockchip VOP2 display modes handling on RK3588
 HDMI1
Date: Sat, 15 Feb 2025 02:55:36 +0200
Message-Id: <20250215-vop2-hdmi1-disp-modes-v1-0-81962a7151d6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAjmr2cC/x3MMQqAMAxA0atIZgM2KBSvIg7VRM2gLQ2IIL27x
 fEN/79gklUMxuaFLLeaxqvCtQ2sR7h2QeVqoI6GjtyAd0yEB5/qkNUSnpHFUILn0JNfVi9Q25R
 l0+f/TnMpH1L0CLVnAAAA
X-Change-ID: 20250215-vop2-hdmi1-disp-modes-ea8da428bc8e
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

As a followup to getting basic HDMI1 output support [1] merged upstream,
make use of the HDMI1 PHY PLL to provide better VOP2 display modes
handling for the second HDMI output port on RK3588 SoC, similarly to
what has been achieved recently for HDMI0 [2].

Additionally, enable HDMI1 output on Rockchip RK3588 EVB1.

[1] https://lore.kernel.org/lkml/20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com/
[2] https://lore.kernel.org/lkml/20250204-vop2-hdmi0-disp-modes-v3-0-d71c6a196e58@collabora.com/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (4):
      drm/rockchip: vop2: Improve display modes handling on RK3588 HDMI1
      arm64: dts: rockchip: Enable HDMI1 PHY clk provider on RK3588
      arm64: dts: rockchip: Add HDMI1 PHY PLL clock source to VOP2 on RK3588
      arm64: dts: rockchip: Enable HDMI1 on rk3588-evb1

 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 42 ++++++++++++++++++++++--
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi   | 22 +++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c     | 26 ++++++++++++++-
 3 files changed, 87 insertions(+), 3 deletions(-)
---
base-commit: 0ae0fa3bf0b44c8611d114a9f69985bf451010c3
change-id: 20250215-vop2-hdmi1-disp-modes-ea8da428bc8e


