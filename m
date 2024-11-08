Return-Path: <linux-kernel+bounces-401745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C8F9C1E9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A7F281AC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861D31F131E;
	Fri,  8 Nov 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="E1NppOfd"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5972D1E47A2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074046; cv=none; b=X3IQnbCoqtAb0omQ++4tn4pFOedkKF/B1Z7NIKBffWnaL34vmFvOoFy3fU13h2t0rwUPNBfkML2pH8VCjlxicNDAnxU05zOqwmzXMkWQvfl69nsqOQdt+ILcWXV/Qm3rKIVsBeOCJ2CshV8Rzc/lte3tTCeKASCVyewLTytFzUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074046; c=relaxed/simple;
	bh=wbrNowvecrdH+H0kiYDvkixseJWEiy3cPyjHE+pUWSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h3b49N6K++cNGL+RA7OcNMbfW9QFe50cgmk+6qiPyF3hHRdC4lfLdDOFeAjGxIfRxmtTGFza3ISybqA4ZqXweYus5QLHK+5BuaioV8pyeD7MF7NxHbJ/DzVtq8vsNnmGeuZNiLnKzB8u4BDlEsOsIRfUDLwz4hPPvBNVknLVN3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=E1NppOfd; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731074043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LuPtIml5wHuWo9YnYzUt6yEz+G9J8XSUCMyiea4JHFQ=;
	b=E1NppOfdtjNHmWn3BSZdNiwXNrn2ZORyh+K6PJpNwqt1Q1g2OsvBkXF3mmqg03vq0I663L
	pfRy9AzYmuKLIYmGcWMtYGAhS/onSQsEwoozQYaUs+lGce7JHPQ+XGEMrki1xfyJTa8sD9
	Adb4jHONBc3/aa8IOpS+ky15AHiuoZF/dWkInNEyPZp3XwX458lFyutgWgub/0faxCciiF
	Gebwlh+rJA6pdFCcStUGeBFNLnixRDiizHD+G0zAKqte0GMppPjKFlLQ445RARS5wOcm5p
	CqLJYZKB9JjOD783nKdZupfeVATRNROze6YWBml2LOCfCbsuNZrsSprS6iZDqQ==
To: linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Cc: heiko@sntech.de,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH 2/2] drm/rockchip: dsi: Don't log errors on deferred dphy
Date: Fri,  8 Nov 2024 14:53:58 +0100
Message-Id: <559094275c3e41cae7c89e904341f89a1240a51a.1731073565.git.dsimic@manjaro.org>
In-Reply-To: <cover.1731073565.git.dsimic@manjaro.org>
References: <cover.1731073565.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Deferred driver probing shouldn't result in errors or warnings being logged,
because their presence in the kernel log provides no value and may actually
cause false impression that some issues exist.  Thus, let's no longer produce
error messages when getting the dphy results in deferred probing.

This prevents misleading error messages like the following one, which was
observed on a Pine64 PineTab2, from appearing in the kernel log.  To make
matters worse, the following error message was observed appearing multiple
times in the kernel log of a single PineTab2 boot:

  dw-mipi-dsi-rockchip fe060000.dsi: [drm:dw_mipi_dsi_rockchip_probe \
  [rockchipdrm]] *ERROR* failed to get mipi dphy: -517

At the same time, make the adjusted logged message a bit more consistent with
the other logged messages by capitalizing its first word.

Reported-by: Diederik de Haas <didi.debian@cknow.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index f451e70efbdd..ffa7f2bc640d 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -1387,7 +1387,8 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 	dsi->phy = devm_phy_optional_get(dev, "dphy");
 	if (IS_ERR(dsi->phy)) {
 		ret = PTR_ERR(dsi->phy);
-		DRM_DEV_ERROR(dev, "failed to get mipi dphy: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			DRM_DEV_ERROR(dev, "Failed to get mipi dphy: %d\n", ret);
 		return ret;
 	}
 

