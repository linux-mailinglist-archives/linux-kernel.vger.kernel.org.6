Return-Path: <linux-kernel+bounces-340049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FD6986E14
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D997E1C20F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A523718E37F;
	Thu, 26 Sep 2024 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="jaZUDkiI"
Received: from ironport.ite.com.tw (HC210-202-87-179.vdslpro.static.apol.com.tw [210.202.87.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78C414F10E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336908; cv=none; b=ROOYqvjoNlwrYcVYRz5t+jIQih/zHD81o9PVEOCIq45qG4w2RmR2ATvcgHl/wO1vZoEo7AyjJtH63dbO02O8Qn2nHV39e9BIYsZRWFG6JXQgh1roR+SwpI5R3yVrjAkEqgW+sHeju8sHbzRcEPt75xOTFdpSbKgtHCgQJ4NLoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336908; c=relaxed/simple;
	bh=k40XQEVA5ttnw+WN5wQkyinMmYWshBCc96fEC14r39c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZufIl/f8taoW1IMe+dzL53EgVYb6uwjeHGTbExKGlQw0ugszLTt48/iLWWNnhJICyWVj2erCTvikPSo+e9e7Ci05LUh3/OPNbEMwQoQmz4F5wP7NXDqQlwkfbnjBIJks4/pKdkU/+VtJQL4VvCic1DOM5MuDDeSjV8yjAn5sKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=jaZUDkiI reason="key not found in DNS"; arc=none smtp.client-ip=210.202.87.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qn2e91U5L9ArAt10Dz9K7b2XtrVbPYlrhxZjNwk91Q8=;
  b=jaZUDkiImfxAzsI4Cotex/yRlyaZV+g/V+TC6Ndr6NsUz1aTCDqNXZrB
   xcBEzQ0H2pUed6Dw5I1ewma8nvFe2+PjLieCUsnCX0r2OfEZmJGo3ZlZD
   tRYUjB741N6aDOtPjilBFUurW5xmQ8I6kwpDLdrl0R2AvlFEeGhr/nKyV
   zyQf2I85TvJXU6wwQ17macw64siOO3DftnPiX7pwdxYXHJ6UC4nIsXEEr
   uW17X/W3Jrn4Le0Ar2872fF+kXpd+xKLML6mqVsS9SqncGw7PceClHvPm
   lCnNnGp3AHnK7yjICwye+g+JY0b3x2rMzqXP7JNhlHlzkVxbEP7qdUcTQ
   A==;
X-CSE-ConnectionGUID: y6cvHJLeT3GMSkQ4G9dt1Q==
X-CSE-MsgGUID: /X5EexboTiaTRYh2NW4szQ==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 26 Sep 2024 15:48:16 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48Q7mCPD042909;
	Thu, 26 Sep 2024 15:48:12 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 15:48:11 +0800
From: Hermes Wu <Hermes.Wu@ite.com.tw>
To: hermes wu <Hermes.wu@ite.com.tw>
CC: Kenneth Hung <Kenneth.hung@ite.com.tw>,
        Allen Chen
	<allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>,
        open list
	<linux-kernel@vger.kernel.org>,
        Robert Foss <rfoss@kernel.org>
Subject: [PATCH v4 00/11] fix HDCP CTS fail items and add MCCS support
Date: Thu, 26 Sep 2024 15:47:50 +0800
Message-ID: <20240926074755.22176-1-Hermes.Wu@ite.com.tw>
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
	55296E61051678383A5EF0D02B3D425FF7C28377B5C4CA101971D598E0A691A72002:8
X-MAIL:mse.ite.com.tw 48Q7mCPD042909

From: Hermes Wu <Hermes.wu@ite.com.tw>

This is a v4 patch-set.

There are lots of failure items while running HDCP CTS using UNIGRAF
DPR-100.
In Order to fix those failures, HDCP flow needs to be changed.

The DisplayPort AUX protocol supports I2C transport.
In Order to support MCCS via the aux channel, the aux-i2c operation is
added.

v3 ->v4:
	-split changes into patches.

v2- > v3:
	-split aux read  KSV function to a patch.
	-[1/3] new in v3
	-[2/3] add description of patch

v1 -> v2 :
	- ignored.

Link: https://lore.kernel.org/all/20240923094826.13471-2-Hermes.Wu@ite.com.tw/
Link: https://lore.kernel.org/all/20240923094826.13471-3-Hermes.Wu@ite.com.tw/
Link: https://lore.kernel.org/all/20240923094826.13471-4-Hermes.Wu@ite.com.tw/


Hermes Wu (11):
  drm/bridge: it6505: change aux max fifo size
  drm/bridge: it6505: improve aux operation for edid read
  drm/bridge: it6505: add aux operation for HDCP ksv list read
  drm/bridge: it6505: fix aux command write to aux operaction register
  drm/bridge: it6505: increase supports of HDCP repeater ksv devices
  drm/bridge: it6505: fix HDCP Bstatus check.
  drm/bridge: it6505: fix HDCP encription not enable when R0 ready
  drm/bridge: it6505: fix HDCP KSV list did not read correctly.
  drm/bridge: it6505: fix HDCP CTS compare V matching without retry
  drm/bridge: it6505: fix HDCP CTS ksv wait timer
  drm/bridge: it6505: Add aux i2c functionality

 drivers/gpu/drm/bridge/ite-it6505.c | 313 +++++++++++++++++++++++-----
 1 file changed, 266 insertions(+), 47 deletions(-)

-- 
2.34.1


