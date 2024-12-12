Return-Path: <linux-kernel+bounces-443863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5909EFCED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948EA188DC63
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8A61AB6EA;
	Thu, 12 Dec 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eJAOipmT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9918A6AD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033844; cv=none; b=tVzdbD/SjMXKwqGylOQ8g6OHBx76/0Wrr44/P7u/ujsXVrNIAtUpSQdpg5AmFaXa6V5zHOyws8XdVBUItMEUkYkQDcrBWTIoQfzGzNExd15r3cwDLprIen0TjSiN05uuR69JdVSwgCpXhKR5LmdtpTKXMPw1+3eUv/onU+tlW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033844; c=relaxed/simple;
	bh=We3n0PcQgQ/L53EcqqJ1cCr0rCKgBkm9F+OgNX+wSb0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S2HVljicafcV01CXHJNU8yz9NMNw4MQ0dZGg2yDCE203+EfxZLSIFtuNMCgWZA5MEjr1rkWZkvRVRLtbFuaC5MXeYeF98r/Apy5DK5bWwDHvPUvOj/PqeH3plVv3DT1GBOiXQmqrt3UJr5Aq27cb3bvbDl/+ec88R/hGpKRMM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eJAOipmT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734033834;
	bh=We3n0PcQgQ/L53EcqqJ1cCr0rCKgBkm9F+OgNX+wSb0=;
	h=From:Subject:Date:To:Cc:From;
	b=eJAOipmTuuhK/VV+SEIjQsi0iv9Gz8FsK8EXAAMg+QgIAp+3g+MX2emb5U1sluCUe
	 EN/fhKwvQlCQF55uIpdGou8H08B8z4vpNZVgXcgWKxwwYM3YMrM+I1fY/OvLBykyiN
	 z9gjoGjUONcDNHFWKT7b9NtSpsoT7jPOsBkgaPQAYvoFU6pPLZDI3cormnBrwlJbgj
	 /MpMpJ/WBQNDEu5EQWpIWnYxWvw8JPc3gWxVaJvT5SYRUNGJCfzQYhnPO81Iz3634k
	 YYMr+KSu5ANMfTAVGY6NHTAFnsJqNRjiXSAVEw4rR6mWL5UTkiRnSI/9SFMRSJ9D+9
	 8iv8pCySoW+6w==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7A85117E37F6;
	Thu, 12 Dec 2024 21:03:54 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 0/8] phy: rockchip: samsung-hdptx: Support high color
 depth management
Date: Thu, 12 Dec 2024 22:03:31 +0200
Message-Id: <20241212-phy-sam-hdptx-bpc-v2-0-57e672c7c7c4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJNBW2cC/22NywqDMBQFf0XuurfEaBPaVf+juMjLJqAmJBIUy
 b83FbrrcgbOnAOSic4keDQHRJNdcn6pQC8NKCuWt0GnKwMltG8pYRjsjknMaHVYN5RBYSfJTTH
 K2ag51F2IZnTb2XwNla1Lq4/7eZHbr/3V+J9abpEg6RQ1vWaa3/lT+WkS0kdxVX6GoZTyAbJEm
 Uq2AAAA
X-Change-ID: 20241206-phy-sam-hdptx-bpc-3b05c6276fd7
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

This series relies on the new HDMI PHY configuration options [1] (patch
included here for convenience) to provide high color depth management
for rockchip-samsung-hdptx, and to introduce a proper solution to setup
the TMDS character rate on this PHY.

[1] https://lore.kernel.org/all/43757beec6cd418fc17252283de38009d531c7c7.1732627815.git.Sandor.yu@nxp.com/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
- Added new patches providing a bug fix and several driver cleanups and
  improvements
- Link to v1: https://lore.kernel.org/r/20241207-phy-sam-hdptx-bpc-v1-0-03c2e4d6d797@collabora.com

---
Cristian Ciocaltea (7):
      phy: hdmi: Add color depth configuration
      phy: rockchip: samsung-hdptx: Fix clock ratio setup
      phy: rockchip: samsung-hdptx: Drop unused lcpll_config
      phy: rockchip: samsung-hdptx: Setup TMDS char rate via phy_configure_opts_hdmi
      phy: rockchip: samsung-hdptx: Add high color depth management
      phy: rockchip: samsung-hdptx: Cleanup internal rate handling
      phy: rockchip: samsung-hdptx: Avoid Hz-hHz unit conversion overhead

Sandor Yu (1):
      phy: Add HDMI configuration options

 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 169 ++++++++++++----------
 include/linux/phy/phy-hdmi.h                      |  21 +++
 include/linux/phy/phy.h                           |   7 +-
 3 files changed, 118 insertions(+), 79 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241206-phy-sam-hdptx-bpc-3b05c6276fd7


