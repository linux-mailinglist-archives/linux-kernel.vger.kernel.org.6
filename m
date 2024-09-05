Return-Path: <linux-kernel+bounces-316641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D529F96D245
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803901F2A220
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3718194C62;
	Thu,  5 Sep 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="J0Cp1CRZ"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CFB194AD5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525392; cv=none; b=D8iH0tZe/lIdUF8epI7dyXf6arufPzDjJxpepBPjID7wotV4QNEe6F85VLmlsHJBSyxkOB8X1xobVGTS50Sy+72ui3N5MepBnA1/1qpcjSP3eU64x/Aem0huoPAy+78lZUcdYPfJSOlmzlbVfYkSuJa8wf75/T31f0kwFU6+XOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525392; c=relaxed/simple;
	bh=tEiuDdLBZu6edxbKbUF2vV90Frlf2pyMBHYkgeGZ4JM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VNYRQ4rWE6EgxPzBcQspL98cle3ebn+jPl+zvbE0pdFzFy68HAsE6Yu9N5maaBmGA9N9eOunBT5ccJk/PbTnxeA7nmloqPI1xNtryLKwo5T4Snl4amUiP65WU6MTc0Fy7gda5lxjclNE3qwCweepBEXKXGj1FGDfA2zlRY8WCvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=J0Cp1CRZ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1725524910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpYdzE01L46nA5/EJhfGrNXTWtdCl00jDOzayRDNeNg=;
	b=J0Cp1CRZG9yqPrytIFQpnCjSn8GsFFzRHLcsySbAZiW9fJqUBCwCUNFCBt0kkDZn1Vt1Xt
	F4VAImTs5Q3F2PQkIFXzBxI7iKdwwO5TZM0zsPkpiEh9dlFqwnexOM3tqMEzTcqPJglFCg
	5NUYcyghzYademVp/JQ+cSGGa4NCG6NZv+TAJjXpPFRWEjMMmT4LiFYhiSY1Yqz5IZhnCr
	vft9lk2ZDFUNO0KiwQOlfu9R/CQDNpnxtfDhZcFoXusl2T54XSSZPiot7VxcMYU7+1tzql
	UFel88WIQAPD5PiG1Sj4+6Ivg8Q9YzkAWZgPU/maurgGEsQhHN2ztQ0cDNaZ4w==
To: linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: vkoul@kernel.org,
	kishon@kernel.org,
	heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] phy: phy-rockchip-inno-usb2: Handle failed extcon allocation better
Date: Thu,  5 Sep 2024 10:28:23 +0200
Message-Id: <cc4995aa3e569be6bc23ca126b41fba82d50eeee.1725524802.git.dsimic@manjaro.org>
In-Reply-To: <cover.1725524802.git.dsimic@manjaro.org>
References: <cover.1725524802.git.dsimic@manjaro.org>
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
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 03b772200fed..cf6b67dd9f10 100644
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

