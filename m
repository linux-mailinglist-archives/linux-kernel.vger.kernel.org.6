Return-Path: <linux-kernel+bounces-295070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7A195964B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB34F1C224BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1791A4B6B;
	Wed, 21 Aug 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MTU/bCDa"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13CB1A4B60
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226255; cv=none; b=X9qrOdbEyG0TG6bsmXz0OOqr1v2NgWPoHoBDHJuyn0ZJLuA17ChxMPsokdtuhTjMCzKSJM7UT+nHvFVl+oFwbdSHM2+X/NSUv6/gD+6Zh0mreA5+sbDctpOlp0yYUgYHR2mVKW+ULnVnKsPSFIaxPRJrSjSKYTrHExnVWOYjKAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226255; c=relaxed/simple;
	bh=8QF6q/NGS0VKzzfTif4uf3VxYdjfxKy3ssihu70qbEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=opMTQnEteIxbETw99Pgw3HtOV5fY21mRUeq2wWTq09mmWkO22Ej5pyvIXTFPGYRe1yYgHsSOxxj2fyUNHaPkh7mzKI0QLB8GjbG+IS+uTrpGq3g6Bdiy3UpyQIu1KcE75KzSiyd9zjBlQupwRHsJvveRoDjGxnjA96zytK+pG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MTU/bCDa; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724225883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=if9diTT6JYwENr+1sloMXQnDz1UcYLmsRE38kgYhmSI=;
	b=MTU/bCDaX3eIb5UE16lyGI6Md+9RwHmHaLnnA2RCQ5wEnQJOBuF6SUe+Cx/ScOenksCtGj
	SAeOJhftHM72vvoad1dr9PqALtaIBR26OFC/hO8M31c01usSEbumaYF4mag8XY2FRUmpJC
	8hcuKRB4zp+hfjVsrwwgz+8kU7tFl4X3mFlmpT9/Y82e9oAznQeLkvywrfCJICqFEzoV0M
	sl/zdDOw+vcGqWIHjwUZs2cT5nlIFdjg3lM+ReTexELq0clsI5/GJ/HNAZ2jkiCs5zb+fT
	6WJAARLzuo5dkTYVtZxCWizOPw1y7W/VOiP039Ou334RBK8TppvXPKxR+PI3xA==
To: linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: vkoul@kernel.org,
	kishon@kernel.org,
	heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] phy: phy-rockchip-inno-usb2: Handle failed extcon allocation better
Date: Wed, 21 Aug 2024 09:37:54 +0200
Message-Id: <96200baf794a0c451f3bbc3f5530b8cf0e359dfc.1724225528.git.dsimic@manjaro.org>
In-Reply-To: <cover.1724225528.git.dsimic@manjaro.org>
References: <cover.1724225528.git.dsimic@manjaro.org>
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
of hardcoding -ENOMEM.  Use dev_err_probe() to also log appropriate messages,
which is fine because the containing function is used in the probe path.

Helped-by: Heiko Stubner <heiko@sntech.de>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 113bfc717ff0..05af46dda11d 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -435,7 +435,8 @@ static int rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
 						rockchip_usb2phy_extcon_cable);
 
 		if (IS_ERR(edev))
-			return -ENOMEM;
+			return dev_err_probe(rphy->dev, PTR_ERR(edev),
+					     "failed to allocate extcon device\n");
 
 		ret = devm_extcon_dev_register(rphy->dev, edev);
 		if (ret) {

