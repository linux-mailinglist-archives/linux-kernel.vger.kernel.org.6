Return-Path: <linux-kernel+bounces-335681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00AB97E90A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25E7283634
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34094194A70;
	Mon, 23 Sep 2024 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="mAX5y2UK"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF438479
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084944; cv=none; b=SZBlLpKUwnsYxm9D+AoN8ezXEeo3GV4LVxxtz8k4rsEHYHaFGdlnOKyC1jArPkUkpDmanx1SBAisV7zuIiresMN+yBdW1PUTNFbxCEten2fdDU+gLWLUTA0zCD8Vp+BA22xxto4sya1ghulVE1oVxDgOZbmXdCf7AcEJ5DYEB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084944; c=relaxed/simple;
	bh=zzqmcZrAqwxtNKb2fbx5tedCVzc7oxf8V8/YK9/nAys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abB6W32j/p0j3O0l7J6imY4YrikahcGQuW2Gx+101KFGiT1Wt1eYdaYkmbNxUpY5Vu69z1kLQjs6KGWe7R0gRp4cf4iB/wmMXG/jChRcj+7eY+r2a+o34uF9y1nzC+pRq4hhEF3xUb2Dv63eB6SpohrKeidVA38Yal6KTLN2RSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=mAX5y2UK reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=frtGvz3cE/Zu60QvqPC121ABD9QJ1izKaHMhIg5KpHE=;
  b=mAX5y2UKqzC3qtJnKGNztIST+iD6d4waIwi+pCqlPp6TmaR/Bv+OYI4D
   XW/7piNPEr+xwszSNEIuRAePsiqZ+s09Y54428JsR3oxZxHz5wBzz63/g
   E7lej/X3xA5buPXIp9RUjTBRRYOHJNIohrMi1XS3YayI7Cm8af6mrBQzA
   9z0E3EWHewj/gW/aEJRD0A0T+16aGfpJ3gohqV+p/RxelymWB1kfjKzKR
   omet7YQXqA2C46fy/Tq3mjE02HUh2ZiDiBD+0lVjW7Mm8WPA9rSMLlVv5
   CFVwi5QCXKBFmEO4UZkc7VATnz9nLW0zRMzS5HHinzMA0M3j/6nRqwEjD
   A==;
X-CSE-ConnectionGUID: W/HX3Zl6QCunZwJp1FwmaQ==
X-CSE-MsgGUID: 2Pw3udIpRYOHKCQWBrVoAA==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 23 Sep 2024 17:49:00 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48N9mv71009793;
	Mon, 23 Sep 2024 17:48:57 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 17:48:57 +0800
From: Hermes Wu <Hermes.Wu@ite.com.tw>
To: Pin-yen Lin <treapking@chromium.org>
CC: Kenneth Hung <Kenneth.hung@ite.com.tw>, Hermes Wu <Hermes.wu@ite.com.tw>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec
	<jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] drm/bridge: it6505: update dp aux funxtion
Date: Mon, 23 Sep 2024 17:48:24 +0800
Message-ID: <20240923094826.13471-1-Hermes.Wu@ite.com.tw>
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
	3FF1979B2A64C846F3A1DBB708D4B8FC126E95E7C40430440C7CB331A4D395732002:8
X-MAIL:mse.ite.com.tw 48N9mv71009793

From: Hermes Wu <Hermes.wu@ite.com.tw>

Changes in v3
 -Seperate AUX fifo access to a commit
 -Add discriptions about HDCP CTS
 -remove non used aux i2c reply definitions

Hermes Wu (3):
  drm/bridge: it6505: fix AUX read use aux fifo
  drm/bridge: it6505: HDCP CTS fail on repeater items
  drm/bridge: it6505: Add MCCS support

 drivers/gpu/drm/bridge/ite-it6505.c | 311 +++++++++++++++++++++++-----
 1 file changed, 263 insertions(+), 48 deletions(-)

-- 
2.34.1


