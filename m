Return-Path: <linux-kernel+bounces-218353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C8690BD16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F822851BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D3A1991CA;
	Mon, 17 Jun 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ulk5lNO+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B519047C;
	Mon, 17 Jun 2024 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661387; cv=none; b=qEpPIYUyqNTIZerdmGgjK4bm/GkwKrBA/EU3VKgHvGRLfbbqocqRlpwArUcfeiAtPnGCZI7IhxWGIjMHYyhjLWRT7KkqGH8O58vP+v84vgJU/xVRBA7u1IK1jzqlIopG+R5typNYoy8NqIgzqTRkc3DH45yY92R5IyEFHrVG83A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661387; c=relaxed/simple;
	bh=h9GZ/qG3QPBcnFqXga6bKtFiBGaWDKmKZeDAnSF4EKQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D/QUDaJPsUyfgdakUDvS28BLYQzls25vfzz+d2ULNQHOg8bAaVEx2+svVvZrx/v+M1eXiuJaw4EtHhd1SvLbNrmAOtVva5pUnV2CLx/KUEG2MaWvVch6BYb8qx+YEING2u6EotklChbUYmJv+UqdQfeStXhom2vXeBmIFN/2QYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ulk5lNO+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718661383;
	bh=h9GZ/qG3QPBcnFqXga6bKtFiBGaWDKmKZeDAnSF4EKQ=;
	h=From:Subject:Date:To:Cc:From;
	b=Ulk5lNO+pvY7yTBe3kUU9+eg6wh7xxfwkR5lRHIEHUqZgFe/FjTuLG4DhxMj4XOM7
	 79KpRGGe33qEdVHiUlDMm0y9Yc9UvERD7EL569Yb7TuIpomYZNzjSeh4/85FZOFgbP
	 FgFZkGuhgysz3i0XYm7HQXNMMsmWyv2DhpNeii/RrpiQLMqa7q59jg4xUYI18eMlqt
	 Z6GxquoQkNL9bPUol4KKCSjWKnVRTdHsdM2FYARWy1CbEhcOpUCBI2CoIXurdurIg+
	 S/jqDeIEnIk5PG/5pSq27z3F7+3TuNoyu6rVf9xQ88+Xb8mJ3GXfL8mtzYHTEOfyQU
	 hJn3LNAbQnJcw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7CFBD37804B2;
	Mon, 17 Jun 2024 21:56:23 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/4] Add clock provider support to Rockchip RK3588 HDMI TX
 PHY
Date: Tue, 18 Jun 2024 00:48:08 +0300
Message-Id: <20240618-rk3588-hdmiphy-clkprov-v1-0-80e4aa12177e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABivcGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Nz3aJsY1MLC92MlNzMgoxK3eSc7IKi/DLdNAPTNEMz08RkAyNLJaD
 mgqLUtMwKsMHRsbW1ANtf0uhoAAAA
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14-dev-f7c49

The HDMI PHY PLL can be used as an alternative clock source to RK3588
SoC CRU. Since it provides more accurate clock rates, it can be used by
VOP2 to improve display modes handling, such as supporting non-integer
refresh rates.

The first two patches in the series provide a couple of fixes and
improvements to the existing HDPTX PHY driver, while the next two add
the necessary changes to support the clock provider functionality.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (4):
      phy: phy-rockchip-samsung-hdptx: Explicitly include pm_runtime.h
      phy: phy-rockchip-samsung-hdptx: Enable runtime PM at PHY core level
      dt-bindings: phy: rockchip,rk3588-hdptx-phy: Add #clock-cells
      phy: phy-rockchip-samsung-hdptx: Add clock provider support

 .../bindings/phy/rockchip,rk3588-hdptx-phy.yaml    |   3 +
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c  | 208 +++++++++++++++++----
 2 files changed, 174 insertions(+), 37 deletions(-)
---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240617-rk3588-hdmiphy-clkprov-f05f165ac029


