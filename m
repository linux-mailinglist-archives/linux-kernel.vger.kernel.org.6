Return-Path: <linux-kernel+bounces-295288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DE7959955
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53201F230BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3D119ABA9;
	Wed, 21 Aug 2024 09:52:00 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462B1CE700
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233920; cv=none; b=cWSEtSkh0bCWQGRoiDjx9sKt7Q0nMV8Of72QkPcYgGkRJb30m35s3Bvxzu2i1uL1bg6Y1eYAIxUlNrWKMKM7Kxemj8obay9GvXI5uBB3WbfKsImuin5fMHwzr8vjnrhHeJV3ZOXAHM6hMPOYDxYrSflpNzPbORyR41gzKUz+4/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233920; c=relaxed/simple;
	bh=FFP0azH5ROXzT8uDhBZ3ERK7nxHvkCxMs92XEeT8YDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OdZ6N9VxZ3FfEkzh+FSaD/9gwLOo0L4Jbso0aU0wcPSkxE3LjUO5SBJ9J2yoQluiqqmM5IAB/Kg7yWBc34F1kEJwMi5A4ALzCmkC30j3MSJUhcutUEFdcj1SnR+4VBGVoypOkN+NqmV2e6mpVqMcrUYtq6QPtmPbQlHIT8Yy3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id SJU00140;
        Wed, 21 Aug 2024 17:50:40 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 17:50:42 +0800
Received: from localhost.localdomain (10.94.15.22) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 17:50:42 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <neil.armstrong@linaro.org>, <quic_jesszhan@quicinc.com>,
	<mripard@kernel.org>, <security@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <liuyanming@ieisystem.com>, hanchunchao
	<hanchunchao@inspur.com>
Subject: [PATCH] drm/panel/hx83102: fix null pointer dereference in hx83102_get_modes
Date: Wed, 21 Aug 2024 17:50:39 +0800
Message-ID: <20240821095039.15282-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201616.home.langchao.com (10.100.2.16) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 202482117504061d4902c6895ca4058dbfd273868ae15
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

From: hanchunchao <hanchunchao@inspur.com>

In hx83102_get_modes(), the return value of drm_mode_duplicate() is
assigned to mode, which will lead to a possible NULL pointer dereference
on failure of drm_mode_duplicate(). Add a check to avoid npd.

Signed-off-by: hanchunchao <hanchunchao@inspur.com>
---
 drivers/gpu/drm/panel/panel-himax-hx83102.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 6e4b7e4644ce..048c2c5897ae 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -565,6 +565,10 @@ static int hx83102_get_modes(struct drm_panel *panel,
 	struct drm_display_mode *mode;
 
 	mode = drm_mode_duplicate(connector->dev, m);
+	if (!mode) {
+		dev_err(connector->dev, "bad mode or failed to add mode\n");
+		return -EINVAL;
+	}
 
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 	drm_mode_set_name(mode);
-- 
2.39.3


