Return-Path: <linux-kernel+bounces-334090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B50797D280
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4451D1F24C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481C0136982;
	Fri, 20 Sep 2024 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ms/OpU2x"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D24770FE;
	Fri, 20 Sep 2024 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820473; cv=none; b=LePs8DGLBCSPTiNkkQPZa3HzWmFnMwxeSuYcmqzFLof18Em5C5GfQjFjmLGWjtcphnNv3ejsgbXqZiZYTxQx77wCUGf4WTipBpPNkoK68bWMYw2QkMT7uUYHVbhSreqYJg0FWZU6IpHBK3/BY23HmPX6GefLGDM5FCSVpA90h/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820473; c=relaxed/simple;
	bh=ryHQMHCPPZJodfqNIYsZ85GCvifO/TIN92/nFcCWRvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIeWxkfgTF2XIR63L9c46uC1ZFFYr3Zv01itmqy7lqxUommXwI3DWp2n1kABgoL6JGPsZPMlOSreK7ZYH437eZtUTjAEenlrgHYYIIm0GHANznyBsvudH5hJb/S/S05/gZGBR4miUlzySsRwtMqXXY8fM0KhSlSnpqdHrNU0mwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ms/OpU2x; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=GBq4X
	3SvjcKdAw76+LCZ96Aeae4FkXSnYqiBRPXZuM4=; b=Ms/OpU2xi0lF+5s6ABh2o
	yW/zFVMA64LbYDTSwaf8EpKAuzQzwpnTPAZF2sZv/aDKCbf4B0mbFz80m0BJLE0a
	Pd6MftUJWeiep/YPfLfiEDyVnfBX6AX6tdjSa4ZXqTm5D6znQLto6ceTurcepa0T
	iARi+8b9tBdYiKKv6gjbx0=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wCnL3ZVMO1mBh1QBg--.6466S2;
	Fri, 20 Sep 2024 16:20:40 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	minhuadotchen@gmail.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v3 02/15] drm/rockchip: Set dma mask to 64 bit
Date: Fri, 20 Sep 2024 16:20:23 +0800
Message-ID: <20240920082036.6623-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081626.6433-1-andyshrk@163.com>
References: <20240920081626.6433-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnL3ZVMO1mBh1QBg--.6466S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1xur1rJr1fWF13GFWUtwb_yoW8WFWfp3
	s0kFZrKrW8GayDXFWjkFsxAF45Kw1vya17G343JwnxJw17Krn8A3ZI9FyDt3y3Jr1xC3Wa
	yrsxKrWI9Fs2vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFT5dUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0h5gXmWX0hsr2QAAs7

From: Andy Yan <andy.yan@rock-chips.com>

The vop mmu support translate physical address upper 4 GB to iova
below 4 GB. So set dma mask to 64 bit to indicate we support address
> 4GB.

This can avoid warnging message like this on some boards with DDR
> 4 GB:

rockchip-drm display-subsystem: swiotlb buffer is full (sz: 266240 bytes), total 32768 (slots), used 130 (slots)
rockchip-drm display-subsystem: swiotlb buffer is full (sz: 266240 bytes), total 32768 (slots), used 0 (slots)
rockchip-drm display-subsystem: swiotlb buffer is full (sz: 266240 bytes), total 32768 (slots), used 130 (slots)
rockchip-drm display-subsystem: swiotlb buffer is full (sz: 266240 bytes), total 32768 (slots), used 130 (slots)
rockchip-drm display-subsystem: swiotlb buffer is full (sz: 266240 bytes), total 32768 (slots), used 0 (slots)

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Derek Foreman <derek.foreman@collabora.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 04ef7a2c3833..8bc2ff3b04bb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -445,7 +445,9 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return 0;
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
+	return ret;
 }
 
 static void rockchip_drm_platform_remove(struct platform_device *pdev)
-- 
2.34.1


