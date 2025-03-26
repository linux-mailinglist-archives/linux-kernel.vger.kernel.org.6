Return-Path: <linux-kernel+bounces-576789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EF2A71479
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEAB16E07A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9990A1B3940;
	Wed, 26 Mar 2025 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="eqUuyep5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dbgKxfsT"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC81A1B0F0B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983899; cv=none; b=MD6B4JASJy2IowPwECysuMdOPIlo60h5vXCnhwxh1oh0Oe4jrDaZYbTillkaKj/EKm4jgbxrIf1a1pH8QVGy2m1iMVR1f8YTcb5U4oj65l6bezsLvqa/n/DdnWg5ufOf1Cu+6DpJNq8FyBqZGpRY1zAQWLA2ncsKBShMUZuJ2y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983899; c=relaxed/simple;
	bh=4Nnyi+PoxYAN4XPNcDNy27jX047zMPSBm9/kG0KA1OI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZI/SLhUpgZsiLEDvsLAIm3SOi/69CkfP8bfiTOl5P66BT7EF3gxlwfGJ3wB6mRmGM6Erd+yQm+qCTvxQr6Nq+3mJidgFLMD/4kbAN95TcWxYFWJJoIt/P+IPRcqUM9dfaqeYkhXPoH7uV0ATKtq4DPbK2fr2m+zab9bwnbhsjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=eqUuyep5; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=dbgKxfsT reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1742983896; x=1774519896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gcPX+MhjshuhvQyvdiQ0n7EixqOoTHSCclQvp5UsEFA=;
  b=eqUuyep5Nc6C4WHGPQvsHeZSr1tABn1EntbusM8a/Gap8SawNJjr9itt
   TwSkVyRpw/f8wTgahW4PnirD6Fu3OqQiMqJdyJhdlw5Wn2g0ey57uJ45B
   dTa7xudtpo8Gd/bhIosx4DbQ4jo1VnRaW5kY5WBEyo9XuHo5dBZiOkdK9
   hpWh8O53FjitngT1wZ5arxzqK4nO7JQOxk/bsGx8tjGtCK097jqTN9h+p
   G1WgATahRvXpPMUPz+7j3Oo5tbys+flHmDCWAMZSdJyb1Yz199S6T8HoQ
   Oi+pH4RF8Zt9qHF5qLpFuIKSYgnk9zITXghNAuZNhaTK90DpE9w8ISDwN
   Q==;
X-CSE-ConnectionGUID: vhz97e2HTFquRzcrZIGHDw==
X-CSE-MsgGUID: peAVOKBtQWmqrIvCUMu0ZQ==
X-IronPort-AV: E=Sophos;i="6.14,277,1736809200"; 
   d="scan'208";a="43167020"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Mar 2025 11:11:33 +0100
X-CheckPoint: {67E3D2D4-3A-2417938-F0170C2B}
X-MAIL-CPID: 6A3CDC2D590C636681E70A4B03ACA4A3_2
X-Control-Analysis: str=0001.0A006396.67E3D2CC.0093,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAD48166EFA;
	Wed, 26 Mar 2025 11:11:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1742983888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gcPX+MhjshuhvQyvdiQ0n7EixqOoTHSCclQvp5UsEFA=;
	b=dbgKxfsTjezsKLfDY5Gzv+v2w5Q0ipknSkPV7sC5ZDaz0s6BxuAIhLb3smJVHAwM6thDPw
	ApQVdxLPk2fttq26zUP4KY8+dCrzz1FB7tsoL94nXklcD335CeO9HWcrMbZRhCX8JTapVY
	qTn2LKM/+E0uQrpqWxxr0zbUmlAWjyycq7LecR9PWradZhgRJAVzzlZIhq5Wac7EVYkFY4
	wMICdbFJNFPqNi+UAroGqxf6rZgT7tGhCMymGicVHd5fKOAlrqQih0ikEQoC+JFP1jWUgf
	HR2gJ8GvN4cap47f2nHmDHWuoZMSlhdzgnVPPRt67bG0VkEVHabXuHCL9jobJw==
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
	Simona Vetter <simona@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm/bridge: sii902x: Set bridge type
Date: Wed, 26 Mar 2025 11:11:23 +0100
Message-ID: <20250326101124.4031874-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This is a RGB to HDMI bridge, so set the bridge type accordingly.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 914a2609a685f..ab70df3b60eb8 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -1138,6 +1138,7 @@ static int sii902x_init(struct sii902x *sii902x)
 	sii902x->bridge.of_node = dev->of_node;
 	sii902x->bridge.timings = &default_sii902x_timings;
 	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+	sii902x->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 
 	if (sii902x->i2c->irq > 0)
 		sii902x->bridge.ops |= DRM_BRIDGE_OP_HPD;
-- 
2.43.0


