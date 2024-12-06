Return-Path: <linux-kernel+bounces-435717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 789B29E7B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224992815A6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC571AAE02;
	Fri,  6 Dec 2024 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZLXrpiIh"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892F81F4727
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522640; cv=none; b=CtqIKX1oNzIXYL+YZz3CiPAi30hrUvDzhbMbOWmmg91BnQbjPIbjhgMI0LhQ+mCefrLEU2wqwQoMv1EGlc+9XB2G5QhgO7EsXlj5LT98CUHNumJIe5WoS9jPsOFAz3sj7KHyC4MFugR4s0g5zumpvOdu2e/lyeEBbsozQJ8weuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522640; c=relaxed/simple;
	bh=s2tNhONfJvsToFPtlcQMRNzdtAz7bW3fSRxtreTVedo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s5ZB3rm2rUfdbAHISYsSWiRnvYlkNm7X9Kglasxc6aomosnmYsJFViKyIvSLRjpb8aBNt5HWkYBw8R+A7xYuCWBv7j7caAzvdPazHa3gAb1VwamyoedfTOHCwf7gTMrRxr9kyqu2Anu93s+iWth7QOpGHsBk9X30fnUtLrlXNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZLXrpiIh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733522636;
	bh=s2tNhONfJvsToFPtlcQMRNzdtAz7bW3fSRxtreTVedo=;
	h=From:Subject:Date:To:Cc:From;
	b=ZLXrpiIhMLNJ1b5bxOOjBF59nD8hOd3/GHloog4/fGIe5q+fNSBnKN40/+zzYjcOS
	 6OWgLea08YCaioDX4rRalWK19tRA/v1+ckCp01MQGiMRwyenF5WxpkncfEf2S5tgbf
	 t7HwqfP9iL75hyvqTcZ7eHGc/T/phYH/JePuno2lFZ2wFZ+t2EOPJh0ELbYrAVCbzE
	 S+auEEYdPs7f5n4e2Q6xIospcA29YLAifIcIu23xPzrWns8D5TXeQT6VISyrAB/7UV
	 3RKgTzeKd9ATRQkaMe/iCUawS3fq9XPM4YQu4j+5UqQwrwlTtSJGHrxw3s3eE22mR7
	 7TfNDoxio4xaA==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FA8517E3805;
	Fri,  6 Dec 2024 23:03:56 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/4] phy: rockchip: samsung-hdptx: Support high color depth
 management
Date: Sat, 07 Dec 2024 00:03:40 +0200
Message-Id: <20241207-phy-sam-hdptx-bpc-v1-0-03c2e4d6d797@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALx0U2cC/x3MQQqAIBBA0avErBswK4OuEi1Kx5xFJRphhHdPW
 r7F/y9ECkwRxuqFQDdHPo+Cpq5Au+XYCNkUgxSya6RQ6N2DcdnRGX8lXL3GdhW9VnJQ1gxQOh/
 Icvqf05zzB4GIvOJjAAAA
X-Change-ID: 20241206-phy-sam-hdptx-bpc-3b05c6276fd7
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Sandor Yu <Sandor.yu@nxp.com>, 
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
Cristian Ciocaltea (3):
      phy: hdmi: Add color depth configuration
      phy: rockchip: samsung-hdptx: Setup TMDS char rate via phy_configure_opts_hdmi
      phy: rockchip: samsung-hdptx: Add high color depth management

Sandor Yu (1):
      phy: Add HDMI configuration options

 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 59 +++++++++++++++++++----
 include/linux/phy/phy-hdmi.h                      | 21 ++++++++
 include/linux/phy/phy.h                           |  7 ++-
 3 files changed, 77 insertions(+), 10 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241206-phy-sam-hdptx-bpc-3b05c6276fd7


