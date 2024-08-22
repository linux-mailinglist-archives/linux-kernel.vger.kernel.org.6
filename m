Return-Path: <linux-kernel+bounces-297004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C6D95B1C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433D82855FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29527175D39;
	Thu, 22 Aug 2024 09:34:57 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19C7E0E8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319296; cv=none; b=MNxzPUbloB6/YhIkk8lh4PKDYkIE+jyx8BWJKkM3JBwg5Tb0xlx3kyYi4jm9ElyHuWeW3Q1IrriAFsKwl4RxocKHdq7qXdYxlsY7P2gakrsGS7AebYxo4o5ra22SoTfUqKVNvES57X8mZaQ7f3VzDVvkY6mJyeW4tJ2f2obDf64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319296; c=relaxed/simple;
	bh=U766fscoEpNT0ZM5kLC9qGWXXREuyevL/Dmktcn0SZA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JhmGGPZ2KIPpnqT+20QqvEseKKeVctkUd+Olokq2KBFFnDVLaJUvYPUuOgvYVt75/D6MwghUt/JRNM8E2KSoJo50P1Me5lG7FjGygbpM9mZFNM7iUL6SSiao/XWi0NJcCynQbWgFVQu3V0aaAGvdsnjXn+9xA0Pn5L2EXzV7sIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id TJF00141;
        Thu, 22 Aug 2024 17:34:41 +0800
Received: from localhost.localdomain (10.94.14.234) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.39; Thu, 22 Aug 2024 17:34:45 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <neil.armstrong@linaro.org>, <yangcong5@huaqin.corp-partner.google.com>,
	<quic_jesszhan@quicinc.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<liuyanming@ieisystem.com>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] drm/panel: fix null pointer dereference in hx83102_get_modes
Date: Thu, 22 Aug 2024 17:34:42 +0800
Message-ID: <20240822093442.4262-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20248221734417e5e694b74a2a687bc378a1d255a3ffa
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

In hx83102_get_modes(), the return value of drm_mode_duplicate()
is assigned to mode, which will lead to a possible NULL
pointer dereference on failure of drm_mode_duplicate(). Add a
check to avoid npd.

Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as separate driver")

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/gpu/drm/panel/panel-himax-hx83102.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 6e4b7e4644ce..7c2a5e9b7fb3 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -565,6 +565,10 @@ static int hx83102_get_modes(struct drm_panel *panel,
 	struct drm_display_mode *mode;
 
 	mode = drm_mode_duplicate(connector->dev, m);
+	if (!mode) {
+		dev_err(&ctx->dsi->dev, "bad mode or failed to add mode\n");
+		return -EINVAL;
+	}
 
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 	drm_mode_set_name(mode);
-- 
2.31.1


