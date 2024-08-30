Return-Path: <linux-kernel+bounces-307996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8755965602
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE77C1C21A03
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B058113C672;
	Fri, 30 Aug 2024 03:54:33 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3213049E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990073; cv=none; b=hdWMkvqEi/WnpXeVbTSScAJVCqV9biUIqGqgEFEVtGXbkZwaA5sOGCxd7vuX4GH7P5hZuoi4mJc3xFrKK+k0drJxEn0GVWtyRYNXruAy60qaRi2tO2gHFfA8ss2NORxRuez8lCVp3njugVZqwOkEZROkEO2ADj/KHe5oE6eMSRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990073; c=relaxed/simple;
	bh=OfDTFjf/h2wvTgjbGH6TLB03gGgubM6ndEfZYh9agqY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=psFx/9tKMOgn8rjgdpKqY5VZLS+C+dcxIfjWHoPECMHPbZjU+zCLKnnh4BIv65bhl/LevDU1MzORmm78qrks2veYmBQnRNs+Pp0S2Uq+qTyEMTdN1YJ8IFFhzPaFMFj2CNjGPgI5r90TfpBzmVFnX23QPzukUh3rhuPwlOu8lDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ww45d4QKPz1j7gj;
	Fri, 30 Aug 2024 11:54:13 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id EC8E01A0188;
	Fri, 30 Aug 2024 11:54:26 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 30 Aug
 2024 11:54:25 +0800
From: Wang Wensheng <wangwensheng4@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>,
	<christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <wayne.lin@amd.com>, <alex.hung@amd.com>,
	<roman.li@amd.com>, <mwen@igalia.com>, <alvin.lee2@amd.com>,
	<danny.wang@amd.com>, <dillon.varone@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
CC: <xuqiang36@huawei.com>
Subject: [PATCH -next] drm/amd/display: Delete redundant null check for 'steam' and 'plane'
Date: Fri, 30 Aug 2024 11:41:03 +0800
Message-ID: <20240830034103.121722-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Since commit 15c2990e0f01 ("drm/amd/display: Add null checks for
'stream' and 'plane' before dereferencing"), the
dcn30_apply_idle_power_optimizations() function would return
if these veriables would be null. So no need to check again before
using them.

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index eaeeade31ed7..ffc35a5653fd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -925,11 +925,9 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 			if (!stream || !plane)
 				return false;
 
-			if (stream && plane) {
-				cursor_cache_enable = stream->cursor_position.enable &&
-						plane->address.grph.cursor_cache_addr.quad_part;
-				cursor_attr = stream->cursor_attributes;
-			}
+			cursor_cache_enable = stream->cursor_position.enable &&
+					plane->address.grph.cursor_cache_addr.quad_part;
+			cursor_attr = stream->cursor_attributes;
 
 			/*
 			 * Second, check MALL eligibility
-- 
2.17.1


