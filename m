Return-Path: <linux-kernel+bounces-563879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C078CA649D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107AB1614EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549F231CB1;
	Mon, 17 Mar 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SqekagC7"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE59230BF2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207319; cv=none; b=C/bHut/nC7IUwlgCT+EKzTj2bOjrIpGpkFP9VjFK9C9Eh3KqOblFzWiIkbq5tFQBgihiTDKGmYfbkZ1Q3SH2kxm5p1nyD/NQd4V1H5j8hNc5yfvmfriaCCS3nSOzgDskBGJHecrfFO1ISuD5E4B2PfemOOPmXYVODZGedR1nDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207319; c=relaxed/simple;
	bh=ReMwh/o18Yh18qE5xbGn6VTcyYQt9CJChadEXgAXGUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aA+hR9EpQSko9/o7Mp5OJzZGMmnvmqYE8xvGqwupNDlkMoBAf2MNJ6A0UQnZpOPa2b5TZ2H2RRPIMdGdaY594/c/uALKCDFKHQdllndsinS1E0rDCRzl8tPk6IjFoCBgaMH1NBqtEf1vFn9BjZT5sn0UZqb5f7aDJ6vJOfZTPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SqekagC7; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=fmWIS
	0wLHvOfDdrgbj8ORSE1eJQwOVhMX/zX7anGKW4=; b=SqekagC72tCKT25KHSmS4
	/+b/w+C575D1N98h4BDUoxjOxnTCMxhJz4/JPOgO//WZqLyL2LezzhFK4lhH9+ng
	XzK09N4vXHxDZpHOogN3tAa/TN2/mpv3caiedJldEyp/q8pNoY4wuUXTccxfdjKu
	Ci4hDKUATluwrmqbDmq0dk=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBnuTwy+ddnhLtwTQ--.47861S2;
	Mon, 17 Mar 2025 18:28:06 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: cristian.ciocaltea@collabora.com,
	hjc@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2] drm/rockchip: dw_hdmi_qp: Fix io init for dw_hdmi_qp_rockchip_resume
Date: Mon, 17 Mar 2025 18:27:53 +0800
Message-ID: <20250317102757.565679-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnuTwy+ddnhLtwTQ--.47861S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWfXFWrGr45XFWxGrWUtwb_yoW8Kw45pw
	4UAa4jkrWkGr47Xrn8ZFnrArW2k3W7Jw4SqFWxKa4vv3W0qrn3KF93Wa1rXr43ZF9xuF4a
	krWvy34fJF4UXFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7uc_UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0h4TXmfX95EooAAAsf

From: Andy Yan <andy.yan@rock-chips.com>

Use cfg->ctrl_ops->io_init callback make it work for all platform.
And it's also gets rid of code duplication

Fixes: 3f60dbd40d3f ("drm/rockchip: dw_hdmi_qp: Add platform ctrl callback")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---

Changes in v2:
- Store the ctrl_ops in struct rockchip_hdmi_qp

 .../gpu/drm/rockchip/dw_hdmi_qp-rockchip.c    | 23 +++----------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 3d1dddb34603..7d531b6f4c09 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -94,6 +94,7 @@ struct rockchip_hdmi_qp {
 	struct gpio_desc *enable_gpio;
 	struct delayed_work hpd_work;
 	int port_id;
+	const struct rockchip_hdmi_qp_ctrl_ops *ctrl_ops;
 };
 
 struct rockchip_hdmi_qp_ctrl_ops {
@@ -461,6 +462,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		return -ENODEV;
 	}
 
+	hdmi->ctrl_ops = cfg->ctrl_ops;
 	hdmi->dev = &pdev->dev;
 	hdmi->port_id = -ENODEV;
 
@@ -600,27 +602,8 @@ static void dw_hdmi_qp_rockchip_remove(struct platform_device *pdev)
 static int __maybe_unused dw_hdmi_qp_rockchip_resume(struct device *dev)
 {
 	struct rockchip_hdmi_qp *hdmi = dev_get_drvdata(dev);
-	u32 val;
 
-	val = HIWORD_UPDATE(RK3588_SCLIN_MASK, RK3588_SCLIN_MASK) |
-	      HIWORD_UPDATE(RK3588_SDAIN_MASK, RK3588_SDAIN_MASK) |
-	      HIWORD_UPDATE(RK3588_MODE_MASK, RK3588_MODE_MASK) |
-	      HIWORD_UPDATE(RK3588_I2S_SEL_MASK, RK3588_I2S_SEL_MASK);
-	regmap_write(hdmi->vo_regmap,
-		     hdmi->port_id ? RK3588_GRF_VO1_CON6 : RK3588_GRF_VO1_CON3,
-		     val);
-
-	val = HIWORD_UPDATE(RK3588_SET_HPD_PATH_MASK,
-			    RK3588_SET_HPD_PATH_MASK);
-	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON7, val);
-
-	if (hdmi->port_id)
-		val = HIWORD_UPDATE(RK3588_HDMI1_GRANT_SEL,
-				    RK3588_HDMI1_GRANT_SEL);
-	else
-		val = HIWORD_UPDATE(RK3588_HDMI0_GRANT_SEL,
-				    RK3588_HDMI0_GRANT_SEL);
-	regmap_write(hdmi->vo_regmap, RK3588_GRF_VO1_CON9, val);
+	hdmi->ctrl_ops->io_init(hdmi);
 
 	dw_hdmi_qp_resume(dev, hdmi->hdmi);
 
-- 
2.43.0


