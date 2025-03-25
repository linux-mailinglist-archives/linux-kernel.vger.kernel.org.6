Return-Path: <linux-kernel+bounces-575424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC49A70253
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFDB189E150
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78362580FF;
	Tue, 25 Mar 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kIhzMVOC"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6EE255E2E;
	Tue, 25 Mar 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909433; cv=none; b=igCW/OUJKH75TO79S9tYa5VaypSJA0Oy5RCzNSomqBDanQ2r4AABD321S+RObja14T/ZKSujV0EO/6AHQAbWFHmLQ7Rn+CsObQq6LWR7Y825D7Lib0oWjXUbWlqEOF/Jo8p42Tw2fQtaOhKO3jMan62EURv9iGshubcoymciNWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909433; c=relaxed/simple;
	bh=6tVor1+69590jipXzHDAXqYT7/TGb44mwBL8r5+/6GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErBVYCCZUApuesqiZfX2w2/6+RAOweiLl8v6hPvhjrQcQij938SNCxlrC7E7K6kN3OuG6wlqpjvrxSpBSWDv7QrN0ZpqiTlum++N3AHOjGmUxJmDv6iQWCTixrGJGbV1WKus3Cif3BfKsauTyfFbiezYXSirq4/NrElUkHMt86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kIhzMVOC; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=ImgTL
	dqMQ1HWln0/pjTdJ4Wv5Wf+bnJovoBh7j+FUq8=; b=kIhzMVOCLBFylit8p4PG3
	RQuG14+3qmmuGUjVkkouivWS3loXJ5QTbei0vILd9ta98s4X5nmKmPK6TYcAJovC
	A+q2frQ7jwaTDy5ovPPy8pINeVKq7Ip8PihXnUas8AX/kB296qxcIOZJbpRMwKAs
	6l8VMdbtxS3GHEMNV5RtFM=
Received: from ProDesk.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnc2bLr+JnWNnrAA--.35530S5;
	Tue, 25 Mar 2025 21:29:53 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	hjc@rock-chips.com,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 3/6] drm/rockchip: inno-hdmi: Simplify error handler with dev_err_probe
Date: Tue, 25 Mar 2025 21:29:37 +0800
Message-ID: <20250325132944.171111-4-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325132944.171111-1-andyshrk@163.com>
References: <20250325132944.171111-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAnc2bLr+JnWNnrAA--.35530S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryfXr47XFy5uw1kCr17Jrb_yoW8AFWUpr
	ZxJFyjva48XF18W347ua15Ar1Sya1Uta18CrZrGwn5Zw17Zr4Dtry3ZFWFqrWFyF95Za1a
	y393Xa4UZ3W7WaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jZfHUUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0hMbXmfirF9ioAAAsw

From: Andy Yan <andy.yan@rock-chips.com>

Use dev_err_probe simplify the error handle.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- First included in this series

 drivers/gpu/drm/rockchip/inno_hdmi.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 483ecfeaebb08..e891d42dd08a4 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -885,29 +885,22 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 		return PTR_ERR(hdmi->regs);
 
 	hdmi->pclk = devm_clk_get(hdmi->dev, "pclk");
-	if (IS_ERR(hdmi->pclk)) {
-		DRM_DEV_ERROR(hdmi->dev, "Unable to get HDMI pclk clk\n");
-		return PTR_ERR(hdmi->pclk);
-	}
+	if (IS_ERR(hdmi->pclk))
+		return dev_err_probe(dev, PTR_ERR(hdmi->pclk), "Unable to get HDMI pclk\n");
 
 	ret = clk_prepare_enable(hdmi->pclk);
-	if (ret) {
-		DRM_DEV_ERROR(hdmi->dev,
-			      "Cannot enable HDMI pclk clock: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot enable HDMI pclk: %d\n", ret);
 
 	hdmi->refclk = devm_clk_get_optional(hdmi->dev, "ref");
 	if (IS_ERR(hdmi->refclk)) {
-		DRM_DEV_ERROR(hdmi->dev, "Unable to get HDMI reference clock\n");
-		ret = PTR_ERR(hdmi->refclk);
+		ret = dev_err_probe(dev, PTR_ERR(hdmi->refclk), "Unable to get HDMI refclk\n");
 		goto err_disable_pclk;
 	}
 
 	ret = clk_prepare_enable(hdmi->refclk);
 	if (ret) {
-		DRM_DEV_ERROR(hdmi->dev,
-			      "Cannot enable HDMI reference clock: %d\n", ret);
+		ret = dev_err_probe(dev, ret, "Cannot enable HDMI refclk: %d\n", ret);
 		goto err_disable_pclk;
 	}
 
-- 
2.43.0


