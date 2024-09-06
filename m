Return-Path: <linux-kernel+bounces-318263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6769A96EAD0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238DA282176
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6469F12EBDB;
	Fri,  6 Sep 2024 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="SKC29Hq5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="CiC6itrb"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F438DD1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725604753; cv=none; b=vC44WqPLwIdr7io5Zeiu8CM6Dt3YoSlS4soqXvyi2frdf1s7ayLHv85qckm9lyKShwnNvXYVEq0BYez8zNlG95PWYuaSpxa4NkWc5Sr0IxpB04NYNa3I+hp/YHC/Ao5EDJxiHN7tLibQSDUjD/1yHf0VPeLr+NyPwwvJqKJB1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725604753; c=relaxed/simple;
	bh=6vXIq99GQlRDetMoVUgmyQWx9Ak+P9LIIxDKXth4am4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nk0DLJ/Zxtilm8LLn4RRfCo/OqREPmGDzs+1PbRCdEHD2q3tBTsW9WEern/f2fpOir1Y5WqAnMH5NhgVFh/Tv6CT833zcALsEI1ZosyeQDLXD8yxyKein3EJe4aDY0zttMnmlvBq/IARH2nQeLOwWMNs0evCGQGQTzW5hjfmq6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=SKC29Hq5; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=CiC6itrb reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1725604750; x=1757140750;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dg5SF6JXmaXxF0NLRP6GCKnQQLT8CWaXwLRzR4UmnOs=;
  b=SKC29Hq5SLNOUuTdPJNVTZVo7sNQPfgOa8dg1SgPeXzcnt9f5G1js0n+
   0Dmeru3Y0jrdbXT4mHGRJhTBcVQf3p3CyB4lQRtOjm5JJ2gnpn4E23qoi
   WshystuQ2dWXZWU1ulEwcPD7lyNJ51gwF9Cc3pqtE11stlaLEUKSqjarp
   VCDwT29EOoeKgKRH3d2Kc+wztz7hCmMmeFd6vm4EM+MfAYVrbmcXNofsT
   cnXF2MAcbj0IyVMCW26WVyI/qe0fJbVJs1drqKfhhyYxTnni5WsxDJHLQ
   KoGS1kjIoGW3WtoyM3e37sES57A76072zyFzsNy9ne2ZxLBlLuDP6rms0
   w==;
X-CSE-ConnectionGUID: DjVR2wjrShqRlWD7KLf6wg==
X-CSE-MsgGUID: 0LO+PlrWTIiSpA4VuyZAyA==
X-IronPort-AV: E=Sophos;i="6.10,207,1719871200"; 
   d="scan'208";a="38800714"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 06 Sep 2024 08:39:07 +0200
X-CheckPoint: {66DAA38B-1F-22BB8E18-F5F6D0B4}
X-MAIL-CPID: 492BF267EFA1B926E3FE21B06D48DD7E_5
X-Control-Analysis: str=0001.0A782F18.66DAA38B.011E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4DA84162421;
	Fri,  6 Sep 2024 08:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1725604743; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Dg5SF6JXmaXxF0NLRP6GCKnQQLT8CWaXwLRzR4UmnOs=;
	b=CiC6itrbelTRi6ewhMP9FNHhuWFQHP6QFd2pZykZYifC5qDOEtEzZ0uZbARHpGUk/O8zX+
	/Wx/DcrShWriDkaJXsGSmW8GcSHt/XWBV+aJ6V5T21hg/ldTo/gbqqyLnFamC+XEKVQbRZ
	NYVarCfDsY6S2cOkuAXsE3PgnGsdNCr17GE82ZIaaL5bj9K5FYcJO/7/o4sI9AhlWlsrz7
	x70qZRwg2TU/9SVbAiW++JIrm/Q++r4s4XxSIsyKVg5k/hsew+9WVcmhNcxcwJ24xkypn3
	gSW+gO3gNjL9dZyhYkfCvmDepk3EK4PFF0CZpq6cNkxkkktJeoXh5okMnmjGzA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency
Date: Fri,  6 Sep 2024 08:38:56 +0200
Message-Id: <20240906063857.2223442-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When drm/bridge-connector was moved to DRM_DISPLAY_HELPER not all
users were updated. Add missing Kconfig selections.

Fixes: 9da7ec9b19d8 ("drm/bridge-connector: move to DRM_DISPLAY_HELPER module")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/imx/ipuv3/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/imx/ipuv3/Kconfig b/drivers/gpu/drm/imx/ipuv3/Kconfig
index 5a40c878ebb05..990e216c51cc8 100644
--- a/drivers/gpu/drm/imx/ipuv3/Kconfig
+++ b/drivers/gpu/drm/imx/ipuv3/Kconfig
@@ -13,6 +13,7 @@ config DRM_IMX_PARALLEL_DISPLAY
 	tristate "Support for parallel displays"
 	depends on DRM_IMX
 	select DRM_BRIDGE
+	select DRM_BRIDGE_CONNECTOR
 	select DRM_PANEL_BRIDGE
 	select VIDEOMODE_HELPERS
 
@@ -31,6 +32,7 @@ config DRM_IMX_LDB
 	depends on COMMON_CLK
 	select MFD_SYSCON
 	select DRM_BRIDGE
+	select DRM_BRIDGE_CONNECTOR
 	select DRM_PANEL_BRIDGE
 	select DRM_IMX_LEGACY_BRIDGE
 	help
-- 
2.34.1


