Return-Path: <linux-kernel+bounces-343867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2D598A07F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD4DBB26A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EF419922D;
	Mon, 30 Sep 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="PAA80FOo"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A49A1957E9;
	Mon, 30 Sep 2024 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695316; cv=none; b=pLCv88hR3QrxPvO5gorDq4MWL1yApiCfprPpsHZv4AK6d5m42fObyVmuybbJLdLVLrc/icGDctAyOiGTWf/AJ1oiV0P3w9l4bIbdHeB0Brty0XqvygVAP5bZuJVMKA+BQQ35khJf1IisGagPEo3Or5YEJa1cPpXHbNWlLwu7yew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695316; c=relaxed/simple;
	bh=9wazOdKs594OGIFT5N4cQ+YPpTzuvoLDGSptvLk5VLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+MyH5+1NReifyE54s29eXYuCaJlZUbw8Z/XJ8a1sT1N141Nfh0T6K+mmbFM7qQxmBqTfbCqq2JaHfTkU47DDTM+UTH9eNR47M4V1hJEJs0RdiRn0qP7tQOf5Ed9xduGEqYcpAmhnYy0C3ho+I5nzkoeNZe6F8X/bDfnD9CwEBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=PAA80FOo; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DCwLONkEbR0xPXHT3eB5whDcOasFFMralMKDZkTIBGU=;
  b=PAA80FOoS5mya7bjQIahocaVMwdVHFBLs4n6EpvQxzH9JvSmuiy8c5V5
   KnVqWbQOSBE3CzUsjW+aZ+HShKSTXLjsfQ/nNNCUdIiu/g9onQ/uZTt7Z
   JEqv1/BLn5I5P8ionr70AqtNzPTIb14CgTH9wnOt7xcnrSzdSeBY6+xeB
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956902"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:27 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Harry Wentland <harry.wentland@amd.com>
Cc: kernel-janitors@vger.kernel.org,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 25/35] drm/amd/display: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:11 +0200
Message-Id: <20240930112121.95324-26-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/gpu/drm/amd/display/dc/core/dc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5c39390ecbd5..417fe508c57f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -621,8 +621,8 @@ dc_stream_forward_crc_window(struct dc_stream_state *stream,
  * dc_stream_configure_crc() - Configure CRC capture for the given stream.
  * @dc: DC Object
  * @stream: The stream to configure CRC on.
- * @enable: Enable CRC if true, disable otherwise.
  * @crc_window: CRC window (x/y start/end) information
+ * @enable: Enable CRC if true, disable otherwise.
  * @continuous: Capture CRC on every frame if true. Otherwise, only capture
  *              once.
  *


