Return-Path: <linux-kernel+bounces-345324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D738A98B4C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8986C1F245E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2160B1BC06B;
	Tue,  1 Oct 2024 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="lXbgNz5+"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0DA1BC072
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765032; cv=none; b=WBwwoqXNows0kqjI6jQ4Lf0vwJmUiapXmaMMAuTvHblnG7c1vFUwmFaQr1M5O7mgAIPe+h5P8zj2bhsEJqY/nL3lwKODHuXNA/11OuZTr5a5Hs0etrNP951ekwfFvK38vTNai033lbUjH0Je9BpUM0jxM0H0oCBROIm+n1osmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765032; c=relaxed/simple;
	bh=QsyfgTQaLv7x1i0pUbu6WTKkthWCES5zNH+ez7F1AhY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FIsf2tvbFQUDpLCUTzcqFVOqeR/C8+Lfy+xrAuiqD5oG+k2uzaNo6wfP/haaGUAiz45ee5KsYoz60HQ2qCbWDiCx5wzYPEdtbvIrWE3OaOgcTqTwq7eaV/M+X6ETxSkQbN65oBHjSilYwrLQhMHgfO51aVs8pL6d5/jr9L9CAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=lXbgNz5+ reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yId9hUjXMvIgIK6EfcFuOboUd7/oDFwEzCFgGZmvOZs=;
  b=lXbgNz5+ZHEg03rJXnxpTB8uza0OgIZakcoogsLRkwesleiBlzRbQDRM
   L4ZMpsHJK7w58SZEq3iX+UPH6ZEHSg6QiRzIH2vAXnmvUqSt35pRlJ6Lh
   kTOELNdGnUcbSkjuqk7AiqbF5vtPOdZ6+6uxnqZ2qiHQ2NP2g5vOAZLa/
   Ak3suGPCJOGAjpbbRZUAz8ACda2/rJw+tMW3ratM+vkpubL18aCzUwXNv
   lRVGuL9Uqy+lxRv09K5tVrRNcDPQVai4HVCFSGf+hyuoiIlQKtu1kEjlt
   24eWKllLQCxYnXLd6W5/7wxSBS/pel1NIGged0B108rBzRhj4So3ELCOH
   Q==;
X-CSE-ConnectionGUID: 19ILxpjeTqiKkqOJYEVW6Q==
X-CSE-MsgGUID: EnfVdjXZQhawdG3M6Ix2UA==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 01 Oct 2024 14:43:42 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 4916hcY2044673;
	Tue, 1 Oct 2024 14:43:38 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 14:43:38 +0800
From: Hermes Wu <Hermes.Wu@ite.com.tw>
To: Pin-yen Lin <treapking@chromium.org>
CC: Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>,
        Hermes Wu <Hermes.wu@ite.com.tw>, Allen Chen <allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "open
 list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Hermes Wu
	<hermes.wu@ite.com.tw>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas
 Karlman <jonas@kwiboo.se>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        open list
	<linux-kernel@vger.kernel.org>,
        Robert Foss <rfoss@kernel.org>
Subject: [PATCH v5 00/10]drm/bridge: it6505: fix HDCP CTS fail items and add MCCS support
Date: Tue, 1 Oct 2024 14:42:59 +0800
Message-ID: <20241001064305.32180-1-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPEMAIL1.internal.ite.com.tw (192.168.15.58) To
 TPEMAIL1.internal.ite.com.tw (192.168.15.58)
X-TM-SNTS-SMTP:
	5BEC668B2C8AAEBEF419837CB032D160902223DAA3B18AA826522A2476B3CE132002:8
X-MAIL:mse.ite.com.tw 4916hcY2044673

From: Hermes Wu <Hermes.wu@ite.com.tw>

This is a v5 patch-set.

There are lots of failure items while running HDCP CTS using UNIGRAF DPR-100.
In Order to fix those failures, HDCP flow needs to be changed.

The DisplayPort AUX protocol supports I2C transport.
In Order to support MCCS via the aux channel, the aux-i2c operation is added.

v4 ->v5:
	-add more messages for changes.
	-[2/10] modified AUX transfer data size judgment.
		change for-loop to do-while.
	-[7/10] change for-loop to do-while.
	-[9/10] change wait timer with timer_after()

	links:
	https://lore.kernel.org/all/20240926074755.22176-4-Hermes.Wu@ite.com.tw/
	https://lore.kernel.org/all/20240926075134.22394-1-Hermes.Wu@ite.com.tw/

v3 ->v4:
	-split changes  into patches.

v2- > v3:
	-split aux read  KSV function to a patch.
	-[1/3] new in v3
	-[2/3] add description of patch

v1 -> v2 :
	- ignored.



Hermes Wu (10):
  drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE
  drm/bridge: it6505: improve AUX operation for edid read
  drm/bridge: it6505: add AUX operation for HDCP KSV list read
  drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
  drm/bridge: it6505: fix HDCP Bstatus check
  drm/bridge: it6505: fix HDCP encryption when R0 ready
  drm/bridge: it6505: fix HDCP CTS KSV list read with UNIGRAF DPR-100.
  drm/bridge: it6505: fix HDCP CTS compare V matching
  drm/bridge: it6505: fix HDCP CTS KSV list wait timer
  drm/bridge: it6505: add I2C functionality on AUX

 drivers/gpu/drm/bridge/ite-it6505.c | 334 +++++++++++++++++++++++-----
 1 file changed, 277 insertions(+), 57 deletions(-)

-- 
2.34.1


