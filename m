Return-Path: <linux-kernel+bounces-540492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B59A4B14B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CA23B2EB4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE341DC074;
	Sun,  2 Mar 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F2p21+Gy"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147C23F362
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740916420; cv=none; b=jGb/x7998D9fJn5+0BI4I+5JsOJ4q/IFZB7Tn25nZpbluvoF1yiDe1aIArRnTq4pnG0KdtOlpi484R8qrjRG6fyh2eViry91M5yAaCXvbPDKvpIwv0lwL+UkQvVZh7HpXBxSXa2lq1ZJSyVIJ4izJZQgKzfvI/fOifb5pmMS348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740916420; c=relaxed/simple;
	bh=fmvaLsuBwr+BAoLruHx0KTD2FPYZm2of1y8wtO2v/TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qcZP4bDuHsN0okWC1rXOcy5/m8Sa9FS2M7EDHP9I+UyxggyVTKNrhs+MdD2YX8eZaEpnNSszgLfs81LSPrBNhcco0v3UFWp43P2a29Ye3vGUqrnn510Vg44yLhXuKqtWI5NAs+8/We2Suji2olFvLOiMgooGlxTcoAGAk4wTPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F2p21+Gy; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=SmPQB
	lqXrmfR9VtbjijOcKCFBcU1W7mI69iXxUDsho0=; b=F2p21+GyzvJe09w2IK7a4
	NedXS8U/++ZwCduRtm40dyKiUWLzZprG0uQyIS7ZWKqEI8J9hyjienBBlBYnPKwq
	vhgErnrTOaNE2+eRy35l91ButR7mFEhQ6/LyXGMtqheWwvB4BpfWLI0TdFBaO96Z
	U5EIETt8YFyhkgEWRvnxjs=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCXDkqaRsRnKLAUPA--.50095S2;
	Sun, 02 Mar 2025 19:53:02 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: vkoul@kernel.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	frank.wang@rock-chips.com,
	sebastian.reichel@collabora.com,
	yubing.zhang@rock-chips.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] phy: rockchip: usbdp: Avoid call hpd_event_trigger in dp_phy_init
Date: Sun,  2 Mar 2025 19:52:25 +0800
Message-ID: <20250302115257.188774-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXDkqaRsRnKLAUPA--.50095S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrykXw1kGryUGFW7GrW8Xrb_yoWDXwcE93
	WkZa4xJF4kJFsYy34DGa4fA34jyw4v93W8Wa10ya9Iy3Z2qan2vF93Xa17JFWUXF47Cr93
	Cas8ZryxKFy5KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbsjjPUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gwEXmfENlbwhQAAsy

From: Andy Yan <andy.yan@rock-chips.com>

Function rk_udphy_dp_hpd_event_trigger will set vogrf let it
trigger HPD interrupt to DP by Type-C. This configuration is only
required when the DP work in Alternate Mode, and called by
typec_mux_set. In standard DP mode, such settings will prevent
the DP from receiving HPD interrupts.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/phy/rockchip/phy-rockchip-usbdp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 5b1e8a3806ed..c04cf64f8a35 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -1045,7 +1045,6 @@ static int rk_udphy_dp_phy_init(struct phy *phy)
 	mutex_lock(&udphy->mutex);
 
 	udphy->dp_in_use = true;
-	rk_udphy_dp_hpd_event_trigger(udphy, udphy->dp_sink_hpd_cfg);
 
 	mutex_unlock(&udphy->mutex);
 
-- 
2.34.1


