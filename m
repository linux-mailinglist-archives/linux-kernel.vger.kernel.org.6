Return-Path: <linux-kernel+bounces-276090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F3948E42
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B491E287E61
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB0E1C4611;
	Tue,  6 Aug 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Prp9mtiM"
Received: from msa.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D11C3F28;
	Tue,  6 Aug 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945580; cv=none; b=hoirQWMRPwKOczk4ls+0Bdhh7AUYf0sOJrJT+bpi4G+o+qfrjMlvckWxzTaITJPraLQXTdNiYpo12oO7AeorzKs7YaskLksyVA0NnU0wuU8Y2gwoCT1TtgxVG4d5ahQrGNr6IryAVMOXEIbyKMsZ4mYP3nsIaveMwcyWIEQhX7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945580; c=relaxed/simple;
	bh=rj4oYa/N7G8V8nrMOqBiD5XK8NbtM9oE/cMF9GVPuvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wpcid/Wyii7bmMebltcPbL3XvNjOKfqrNZXdslPmoK7onuVEg+3u80gpav+bCw79AvLp2AiziSfuMb2Hxns6XzyR6hWI3+YmmDv9Iarbszv+n/YkZB5OU3FL+3Fh6G+92/X/n3KXru9cmMSmzNqSBvwziyrjctbQA2QV4G21v4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Prp9mtiM; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bIqZs62idOGeabIqfs47Hs; Tue, 06 Aug 2024 13:59:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722945569;
	bh=U1wmPO7Z7uDvQZNVQuE2oZwHbLILE0+Mf/ztBlL3Y7M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Prp9mtiM5plHfJXL5GVci2DPl1AvTEDkTqYeDOstFlrA3VlvCb9SroTXIu6PaLSkm
	 7uibvH2B2qW7S2f4M6stGaBR8RXIusTmY5636yqJp/mJQK1NSMuEZDQc0s3Ylxompr
	 wr0dvdIUAll59EQWcD1sEYjQCi0yhb9Wz4Rq58rq8N5iSeJm17dz5So156nWGdVyxG
	 I421MuslIUnoh7hZeYOdDjfqyE3P+o0eISFQzCsYJSE7iEHTXmy15yhAIsCYCvaPx8
	 kuxSbiJrkxlXr8jZwTl71EZiUQ3ZvmZE6lSq4r4ohTSoiB6zG00g/LchjSaxeglj9I
	 Yp4JbXYyFf0Yg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 06 Aug 2024 13:59:29 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/dp_mst: Slightly optimize drm_dp_mst_i2c_write()    (2/2)
Date: Tue,  6 Aug 2024 13:59:11 +0200
Message-ID: <123bc9f79f60de14aad6f46e1c2268cf6f1c27a5.1722945487.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2705cf4c0df41f335cbe91bfd9984fcd95208788.1722945487.git.christophe.jaillet@wanadoo.fr>
References: <2705cf4c0df41f335cbe91bfd9984fcd95208788.1722945487.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'msg' is only used with drm_dp_encode_sideband_req() which takes a
"const struct drm_dp_sideband_msg_req_body *".

So some initializations can be done only once outside of the for loop.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
In case of interest, on x86_64, with allmodconfig, sizeof(*msg) is 420
bytes.
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 7bf6157eb3a3..a149ff3f70ad 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -5891,10 +5891,16 @@ static int drm_dp_mst_i2c_write(struct drm_dp_mst_branch *mstb,
 		ret = -ENOMEM;
 		goto out;
 	}
+
+	/*
+	 * 'msg' is not modified by drm_dp_encode_sideband_req(). So
+	 * some initializations can be done only once.
+	 */
+	memset(&msg, 0, sizeof(msg));
+	msg.req_type = DP_REMOTE_I2C_WRITE;
+	msg.u.i2c_write.port_number = port->port_num;
+
 	for (i = 0; i < num; i++) {
-		memset(&msg, 0, sizeof(msg));
-		msg.req_type = DP_REMOTE_I2C_WRITE;
-		msg.u.i2c_write.port_number = port->port_num;
 		msg.u.i2c_write.write_i2c_device_id = msgs[i].addr;
 		msg.u.i2c_write.num_bytes = msgs[i].len;
 		msg.u.i2c_write.bytes = msgs[i].buf;
-- 
2.45.2


