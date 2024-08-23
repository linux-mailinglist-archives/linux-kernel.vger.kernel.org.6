Return-Path: <linux-kernel+bounces-299361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A037595D39C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02E6B22905
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5618BBBE;
	Fri, 23 Aug 2024 16:36:47 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23393185928
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724431007; cv=none; b=kANsq6DvKyCiOl7iiujc67nmY6XusCsgZiF/IlBPhH80yUhogNbwqK9p3r48nRz/Kv5Ssc4N8+LKx075AsRlYPGB20EiCIopbiuCx7V15cJDKOMzRJey1V7eXVMd2rnzJUEPBkg/rrCzit2PB/pvuxPirdzcP8SMv2rsSrO0o54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724431007; c=relaxed/simple;
	bh=DXOGXSdyxFP1ehT5KQ5xokHpS48Yu0Uofb2h7DqoRKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aoAeOn8kX0ZxfwgYyHnNe336lfvLJK8WRCbR033rmrK4vRgKjjORQebUE3lQtsC5bdbWV1tmjKya7oi+2cl1FBWgGg0K0yNn13z6Cq/tB8WFGxCd2S2x0YszdLOC+7HwontIY8UQN4dYY2CFEzktW8NAMztm+sB4TxgrCmF39pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id UQH00116;
        Sat, 24 Aug 2024 00:35:16 +0800
Received: from localhost.localdomain (10.94.3.154) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.39; Sat, 24 Aug 2024 00:35:15 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <neil.armstrong@linaro.org>, <yangcong5@huaqin.corp-partner.google.com>,
	<quic_jesszhan@quicinc.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<liuyanming@ieisystem.com>, <dianders@chromium.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] drm/panel: himax-hx83102: Add NULL pointer check in hx83102_get_modes
Date: Sat, 24 Aug 2024 00:35:13 +0800
Message-ID: <20240823163513.4344-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2024824003516f678cc21c48e66bce0d88eb08600ddb2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

In hx83102_get_modes(), the return value of drm_mode_duplicate()
is assigned to mode, which will lead to a possible NULL pointer
dereference on failure of drm_mode_duplicate(). Even though a
small allocation failing is basically impossible, kernel policy
is still to check for NULL so add the check.

Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as separate driver")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/gpu/drm/panel/panel-himax-hx83102.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 6e4b7e4644ce..e67555323d3b 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -565,6 +565,8 @@ static int hx83102_get_modes(struct drm_panel *panel,
 	struct drm_display_mode *mode;
 
 	mode = drm_mode_duplicate(connector->dev, m);
+	if (!mode)
+		return -EINVAL;
 
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 	drm_mode_set_name(mode);
-- 
2.31.1


