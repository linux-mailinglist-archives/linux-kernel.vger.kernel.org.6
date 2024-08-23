Return-Path: <linux-kernel+bounces-298506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB4795C830
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94F728211A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B76144D0A;
	Fri, 23 Aug 2024 08:38:24 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF0832C85
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402304; cv=none; b=DCb+UeAjFP7tKHQHO/Qur/G9ueD9XCihJd36L2Unzb11aQNR+bLwUX/GWRPX1Gr76BxWHQG61eGxT5o8PBPdvn8ifGFLFnQMEVLsO0AIYwLngsP1PXHHuuNQaZI106rbdCSGzS98mZWQTg3u6/Mc48LjXVwU7/TdDjS1zNVn2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402304; c=relaxed/simple;
	bh=/5LRf8Wk037URiawKlF0QV103hJS7mQs2O6t7loWvZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Am6juUZ6gMrdOEXe5oMnv7dkZvr3w2go5m0+b446epjMWHFW2eRyKpfpOVkEB2cLj8rxS4unENP08rf9c322up5KB044i3zOegM13TbXc8XtHcjqqKYZJakpuzJsD/Sd5oDRQ1HJI6FI+cCHtMK2fGpEltxCPNbsahrFEJg5KyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id UII00158;
        Fri, 23 Aug 2024 16:36:58 +0800
Received: from localhost.localdomain (10.94.15.114) by
 jtjnmail201606.home.langchao.com (10.100.2.6) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 23 Aug 2024 16:36:59 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <neil.armstrong@linaro.org>, <yangcong5@huaqin.corp-partner.google.com>,
	<quic_jesszhan@quicinc.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<liuyanming@ieisystem.com>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH v2 1/1] drm/panel: fix null pointer dereference in hx83102_get_modes
Date: Fri, 23 Aug 2024 16:36:57 +0800
Message-ID: <20240823083657.7100-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20248231636584b1a172ea4605ee91cd932edc96aea4b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

In hx83102_get_modes(), the return value of drm_mode_duplicate() is
assigned to mode, which will lead to a possible NULL pointer
dereference on failure of drm_mode_duplicate(). Add a check to avoid
npd.

Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as  separate driver")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/gpu/drm/panel/panel-himax-hx83102.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 7c2a5e9b7fb3..e61ed7d02729 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -566,7 +566,6 @@ static int hx83102_get_modes(struct drm_panel *panel,
 
 	mode = drm_mode_duplicate(connector->dev, m);
 	if (!mode) {
-		dev_err(&ctx->dsi->dev, "bad mode or failed to add mode\n");
 		return -EINVAL;
 	}
 
-- 
2.31.1


