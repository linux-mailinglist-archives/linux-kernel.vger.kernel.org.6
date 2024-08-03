Return-Path: <linux-kernel+bounces-273374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448DB94688A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 09:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B89CEB21847
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C014D708;
	Sat,  3 Aug 2024 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="AZD89qyq"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567E213959D
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722669774; cv=none; b=EhjY/t12guRsX5t+mlJ66NmyEXZbCUrbPrz0tUVDqs9HqCLvqhFkZAVXUWjSUlpi6roGHcSz69FSMlb2cHN54H3rn11a5B4/3YZajHU2IUpYEGc3iQzWIyzH67+PsxK4MRcdpJLuLg/cTlEQR9U8pNDY4m+W8ssIDOlOBuXsT88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722669774; c=relaxed/simple;
	bh=jUmfbzzcP0ZsExSKht7Ae1zzOEoGcNQ0sCLK5bsnQWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l7d9JYU6wZcMTTTE9Hfw77xvsPrzVsMLvQOLPRdfQAIcfZtKgHcwQY4kG8s+R2PXznA3eaoA6dpu+lYp4DXJ7W06cJrLVy9kpeGx+YFaXXKUPfCHKZx2GMngZGhJTLzSvgNzAPR3ClAyGjlH09QD/rJGbVOKso4aOwK4s8U/qVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=AZD89qyq; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4WbZ0l05VszDqBP;
	Sat,  3 Aug 2024 07:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1722669767; bh=jUmfbzzcP0ZsExSKht7Ae1zzOEoGcNQ0sCLK5bsnQWw=;
	h=From:To:Cc:Subject:Date:From;
	b=AZD89qyq2yqBN2RLDgtudLTXaNs3lG9f1XTqpC7a4WfAV3xIptgQ1qX8cE25xvcku
	 yyUxyLEpd920gy0OCjfUyfznoGAnITQbxUmRnpMpQ6cdDBH7LL9bdIsGX5XoWDZp+w
	 637hvmGN4nPWDbeWXgrwOXFA8vI7opu6l7LoPUcg=
X-Riseup-User-ID: 141302B49154B1764CEAA4EA4310943641D6856302F7CBF382AB8A5167C32E79
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4WbZ0h2w75zJnBL;
	Sat,  3 Aug 2024 07:22:43 +0000 (UTC)
From: Thais-ra <thais_ra@riseup.net>
To: linux-staging@lists.linux.dev
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	gregkh@linuxfoundation.org,
	elder@kernel.org,
	johan@kernel.org
Subject: [PATCH] greybus: camera-gb: Fix a alignment bug on gb_camera_ops()
Date: Sat,  3 Aug 2024 07:22:36 +0000
Message-Id: <20240803072236.368-1-thais_ra@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch message "CHECK: Alignment should match open parenthesis".

Signed-off-by: Thais-ra <thais_ra@riseup.net>
---
Hi, this is my first patch.
---
 drivers/staging/greybus/gb-camera.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/gb-camera.h b/drivers/staging/greybus/gb-camera.h
index 5fc469101..3e0914743 100644
--- a/drivers/staging/greybus/gb-camera.h
+++ b/drivers/staging/greybus/gb-camera.h
@@ -92,8 +92,8 @@ struct gb_camera_ops {
 			unsigned int *flags, struct gb_camera_stream *streams,
 			struct gb_camera_csi_params *csi_params);
 	int (*capture)(void *priv, u32 request_id,
-			unsigned int streams, unsigned int num_frames,
-			size_t settings_size, const void *settings);
+		       unsigned int streams, unsigned int num_frames,
+		       size_t settings_size, const void *settings);
 	int (*flush)(void *priv, u32 *request_id);
 };
 
-- 
2.20.1


