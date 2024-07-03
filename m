Return-Path: <linux-kernel+bounces-239459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1235D92604D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924B6B26605
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4453A175555;
	Wed,  3 Jul 2024 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="dDEhMoQq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hSE1Xdbm"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7E85298
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009655; cv=none; b=CEXKpsIHbq4mZHEduDZyfYHiK8SN4jn1Kk5eOHL5qHpHdfmScllAoPn7JNdHfUak38RgZRG1q0d0LCCINO0FtDc+rN698h65ZXxdO1uAjIOnxHtCHqkicEJk+srj6PQPW9luni7CzUZpRxnXLybXgsk3DH8ye7oDvP2midMKI/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009655; c=relaxed/simple;
	bh=MIdVA2MuNr7Kjwugehxlbk5pPoNQtJ6M8cJeWem3X6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KtKKi438DDBMZnt7Mr9DZA9AvjYpTluYprbkGYyttpWAVKb183klDVFERbK9BPp+N/UMjSvnk83KuLuvl1ycG7Sfil95GJuAKsVTWpyrlN3VEs1yscYt7Hr+aRtFH1aMKXbWvl3qzwrN5LfuU3PlsLAqnBm8Lodh8vEYyAOlfAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=dDEhMoQq; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hSE1Xdbm reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1720009652; x=1751545652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8jq6y7aA7RK3dKCehG+wrp8fblOjHLald6MD0wxTNHc=;
  b=dDEhMoQqNLYrdlVUnun8ykYZczMS5I6JN2tcUChZCUrRFAFUPjMdpMbt
   i7Hnc5C9syAtSGSUxzd8nKDAAkw8iDRSrSA8GgsuS7fSpH/lzfa4TuUpl
   VyReAgbIsKYNfO5cFVAFaJXSfUaOXymdWtF5WksDv90pDbWsbVsPUTS64
   WiS23ZKcR1AbTQyh7nLobTOnqkBFsoFYtVJIFVb7q2rjx9SmiD3GqheV9
   a+W/MM/i4B4tInWsTH3COXBjntgs4EdjbIpEf1dPDHiY3rM21XAb9d1l6
   JNdtm27Z1N+fKKwxxw6v36C2gtPE4T2THhmgC3LmqTNkmQ6rM8LTEsl4X
   w==;
X-CSE-ConnectionGUID: dggba+NXRHGpeBGX8BmCdw==
X-CSE-MsgGUID: 4YDp7SzqSiiu6+kXLImTLg==
X-IronPort-AV: E=Sophos;i="6.09,182,1716242400"; 
   d="scan'208";a="37726416"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 03 Jul 2024 14:27:24 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CFEB165C89;
	Wed,  3 Jul 2024 14:27:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1720009640; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=8jq6y7aA7RK3dKCehG+wrp8fblOjHLald6MD0wxTNHc=;
	b=hSE1XdbmneKXrssEo+FANb1s0MTPKTkv5oqLVPlNZInBXXbawo4s4SqNnJzA+yJvypaQ19
	Vb+jHRREaLBRFfid6YbAapkxKwAS8L5dJr9laEbWmj/n4t7zX6Ongda1Gga0NuCVFsjVhz
	mGFcR88QfJIWnBcp3EILNfnUsabJAUjDZT8L3H4ZD5SlppkoZScNj64Bd6sIQJjYT3dW+N
	Pxlq1LJE5y5REEp3r4M6CS2OhT5cZnI5befFk4xEXzM6rvzzENX2yNjHpuKUOST29kn2er
	d1ySPaHSvL0g7XJiCURqIY3ewKXd0xlpXNd8Db4PtO55Dn+ciS+r84RSRN1hQg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/1] drm/bridge: Silence error messages upon probe deferral
Date: Wed,  3 Jul 2024 14:27:15 +0200
Message-Id: <20240703122715.4004765-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When -EPROBE_DEFER is returned do not raise an error, but silently return
this error instead. Fixes error like this:
[drm:drm_bridge_attach] *ERROR* failed to attach bridge
  /soc@0/bus@30800000/mipi-dsi@30a00000 to encoder None-34: -517
[drm:drm_bridge_attach] *ERROR* failed to attach bridge
  /soc@0/bus@30800000/mipi-dsi@30a00000 to encoder None-34: -517

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
---
Changes in v5:
* Added dev_err_probe() call if probe deferral occurs

 drivers/gpu/drm/drm_bridge.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index d44f055dbe3e7..c6af46dd02bfa 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -353,8 +353,13 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	bridge->encoder = NULL;
 	list_del(&bridge->chain_node);
 
-	DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
-		  bridge->of_node, encoder->name, ret);
+	if (ret != -EPROBE_DEFER)
+		DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
+			  bridge->of_node, encoder->name, ret);
+	else
+		dev_err_probe(encoder->dev->dev, -EPROBE_DEFER,
+			      "failed to attach bridge %pOF to encoder %s\n",
+			      bridge->of_node, encoder->name);
 
 	return ret;
 }
-- 
2.34.1


