Return-Path: <linux-kernel+bounces-446752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F199F28C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AE61884DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC7193427;
	Mon, 16 Dec 2024 03:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="d5nXERDZ"
Received: from mail-m8235.xmail.ntesmail.com (mail-m8235.xmail.ntesmail.com [156.224.82.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1A617DE36;
	Mon, 16 Dec 2024 03:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.82.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734319094; cv=none; b=LxtpjZVWvCZI9aeEkohWCNH+/OEx1IrF3tH3Ps5CVFbpzQNXym3chMklbqUlo2SqWieKcmer986sQZ6PmgQjAerN4WbCKPU67Oe+W1B8HB2U5MQinGsFa5uYoHFJD6q7dbhZpl/yHTZadL2UuVwmxMe9XsLbPA/MS4ewLEbHKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734319094; c=relaxed/simple;
	bh=xipV9pI0cZVvGEMYonPUjQBAwN++/1NR9kOrXmgrhdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sG1kB1YlQZnH2PGL7a7Xh+/F8vkA+YIislJZRKk7PTznoeQswQ01uKQHX8OjYkZjzyhzIP3kggsD6Lu1tf6AHajeFedFsHD00QYoLOi1gaP61yxhu7JPm4RjjuYXDtFXNxgr9SyHzge37/CyPe5elKcPKrLNGx+BPyM7U53pBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=d5nXERDZ; arc=none smtp.client-ip=156.224.82.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5cf7990d;
	Mon, 16 Dec 2024 11:12:58 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rfoss@kernel.org,
	vkoul@kernel.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	l.stach@pengutronix.de,
	andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	algea.cao@rock-chips.com,
	kever.yang@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v2 05/11] drm/bridge: analogix_dp: add support for RK3588
Date: Mon, 16 Dec 2024 11:12:19 +0800
Message-Id: <20241216031225.3746-6-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216031225.3746-1-damon.ding@rock-chips.com>
References: <20241216031225.3746-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ09NTVZIQk5DGk5CT0tDSUJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93cd7467c403a3kunm5cf7990d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6Fjo6NDIJCCEhSUgUQhAx
	FzdPCQlVSlVKTEhPSEpDTExCQk1LVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTEw3Bg++
DKIM-Signature:a=rsa-sha256;
	b=d5nXERDZa0rP2ifjTABNTWBGjZecv/mHnpmkvY7yHC9Bla2jc9AlvvuXMkkZpgzK6udDTSRA7Vl72HDpadzaMUzd/NFM0WlHGZu/QhykKPc4NYjyufJ+TEcS5WhyECOai0D+K/Ske7ZdLJA4IWIV1CXg3elyOK1iKfH3hN0xquI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=E81q0mlHKARsxeEjOtAQLSuYK/wvdEx4XVvmaBJNUbs=;
	h=date:mime-version:subject:message-id:from;

Add max_link_rate and max_lane_count configs for RK3588.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index bfa88409a7ff..6f10d88a34c5 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1513,6 +1513,10 @@ static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
 		video_info->max_link_rate = 0x0A;
 		video_info->max_lane_count = 0x04;
 		break;
+	case RK3588_EDP:
+		video_info->max_link_rate = 0x14;
+		video_info->max_lane_count = 0x04;
+		break;
 	case EXYNOS_DP:
 		/*
 		 * NOTE: those property parseing code is used for
-- 
2.34.1


