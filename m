Return-Path: <linux-kernel+bounces-285351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1176950C63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07081F2214A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA8E1A38FB;
	Tue, 13 Aug 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="J6OCBHPk"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9FC282E5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574315; cv=none; b=gioUUHU8vaMgnr1MDwuvWXg3YtGHyf9kSva+8JoI0UVloIKgpgj1QQpgm5CMkLXXr5YhJNvBviY0sna9kaf9JR/GK1wX6wqBm0noDZBTzFhDnGkgCKylRoNtVVVS3+xvT8kpZYY1ddBGTa+Zmd1YtLQ9jns5VMmWUJq6rev7ES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574315; c=relaxed/simple;
	bh=gDQtY2At4Q9hvjsdxHXtLuplUcvB+sGFEWqsw+JNE0w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tZjikWLB1wHyHAyDQoYmLl6nN0TnfkzkY9wPyv5FGcPQD4rL8yOj3e1fXLwQCu/BY9MJLHTZYVyTzP82g8xKvpAuGsDBFtLVpayiU0fYWCXSiNUrmG9puXDjewRrS/U50fqD/jCQK7pb0BMVJMjyPKSEDJEqjycK/jY1NzINFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=J6OCBHPk; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723574302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7tQ93cgqrUy0u5sLZ5yVNDqAWLqDmP1U/QuWLwU3voM=;
	b=J6OCBHPkxjj6TQoSl2vI2PEvgmB6s3QS2FtHT9thCxz9X08Faf8tG7kDlcefLEEtCh7C8w
	Wh7ZHDGfIS69UiVcaULAc/MEGGsVIwBGbdf1RYYXbWvHq9dJ2JRW23wy3+TOq0jncT/L1+
	g+QWXZgbchv+4/qnra3E3+5bZpWZPic7ICGbZejBJOb8vXXZRuJn6vOnJh5vCk1fYgi7Lb
	rNuJUCPoTQPRrf6IqP+mhUVtug97Dx9LsTCuxYYhNIsThBlqU0EBwjpMrzfv8ZHYF1LTCl
	oRZ+lSHmsv3EGFnAW5pIKeEe2RBlRFkEF3binWK5OnxU9tpD07BWjd0B8kVA6w==
To: linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: vkoul@kernel.org,
	kishon@kernel.org,
	heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: phy-rockchip-inno-usb2: Handle failed extcon allocation better
Date: Tue, 13 Aug 2024 20:38:17 +0200
Message-Id: <5fa7796d71e2f46344e972bc98a54539f55b6109.1723551599.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Return the actual error code upon failure to allocate extcon device, instead
of hardcoding -ENOMEM.  While there, produce an appropriate error message.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 4f71373ae6e1..d33418a1e7a8 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -434,8 +434,10 @@ static int rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
 		edev = devm_extcon_dev_allocate(rphy->dev,
 						rockchip_usb2phy_extcon_cable);
 
-		if (IS_ERR(edev))
-			return -ENOMEM;
+		if (IS_ERR(edev)) {
+			dev_err(rphy->dev, "failed to allocate extcon device\n");
+			return PTR_ERR(edev);
+		}
 
 		ret = devm_extcon_dev_register(rphy->dev, edev);
 		if (ret) {

