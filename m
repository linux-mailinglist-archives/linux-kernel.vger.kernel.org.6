Return-Path: <linux-kernel+bounces-560888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E92A60A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E2717E6E6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E4318CBF2;
	Fri, 14 Mar 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DmXchrkj"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C98632B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939121; cv=none; b=U6hABcGRIgpM9nkV8xs90vZgP6IgnWCX99UY1AZC194PMSOv0S5clZPYkVFK2xhGpmk8OU2S541dauTIBC5pa52RHqjTYDC2M36pxHGCl1Icx7f13mB4mOiDN4XX6l3y7oMu7q1tFcGpQmEZYbYN1S4TVkRIdhdcMRqylTrVqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939121; c=relaxed/simple;
	bh=M1raz8GClNJ6r0N2UzClAROcId7VV6pmaZnOr+JW+UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7SBLF021XYJKnHZuSB4UIWDmobk99xb5ej/aucLvu6bo7WjShCBYzk0VzP8ksZEwlN711FBjefHHuXnE7bWCmaCJpk4kdCnYmWLo5F4douogsaQZVusev/VFtvaxv8xxp9HM7P7W3Ou/t5Ffa1Vx31f6hvZNCBy1Lcw+Y/McfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DmXchrkj; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=helvO
	iEZEla5qyx3wM/5yytYahGTNScL6SHolKzTrVI=; b=DmXchrkj/ETvBx4bovvS5
	cysMMNJYY2ZALNPFsSTodncG7JPY0nY3my69xnnyzCDcm/zpzKf1VrNJgBKOutzt
	zlxyveV7jFLAhqRVltpiixaHU6cjsMIoAJAva7I7F63Iw++wOk8Dh6bPH4ixisEq
	KJbHIJDX8LK11+vv+eN4i8=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCnEAuD4dNnAqebSg--.11559S2;
	Fri, 14 Mar 2025 15:57:59 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: lumag@kernel.org
Cc: cristian.ciocaltea@collabora.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] drm/bridge: dw-hdmi: Avoid including uapi headers
Date: Fri, 14 Mar 2025 15:57:47 +0800
Message-ID: <20250314075754.539221-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnEAuD4dNnAqebSg--.11559S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW7Kw48uw15GFyrWrWrGrg_yoWfGrc_C3
	WxZr4DGrWjkr1qvF13ArsxZ34q9w4UuFWxWFn5Kr9xAF4kZr4agw17ZFyUJwn8uF15KF9r
	Wa45WFWIyrnxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0hL0UUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gwQXmfT3XZ7-QAAsJ

From: Andy Yan <andy.yan@rock-chips.com>

It is not recommended for drivers to include UAPI header
directly.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 0890add5f707..306e09a24a1c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -22,8 +22,8 @@
 
 #include <media/cec-notifier.h>
 
-#include <uapi/linux/media-bus-format.h>
-#include <uapi/linux/videodev2.h>
+#include <linux/media-bus-format.h>
+#include <linux/videodev2.h>
 
 #include <drm/bridge/dw_hdmi.h>
 #include <drm/display/drm_hdmi_helper.h>
-- 
2.34.1


