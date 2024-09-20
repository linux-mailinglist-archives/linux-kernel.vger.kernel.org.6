Return-Path: <linux-kernel+bounces-334110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A8D97D2B2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B9A1C2074B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F26A1386D8;
	Fri, 20 Sep 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="nrZmw5wq"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E630E13B58A
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820717; cv=none; b=knFLiiOuovlN866jaL5EMJSF3iZMA5BTB8HkvrNkvTxrkOGI8oECpqc06PXBoiUR5v1VkPhexaD0s1Lq8Cp/aXaGMYPRk9Wjc/JqVfPu0ZxfAblzO2iGgK0EDH5strUG6ZJg05r7ymZW5oUY65VajWx2DR1YS1IUd+T8r1KJtTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820717; c=relaxed/simple;
	bh=5wMDB4OPz3COGTuM93h1ILfXitqkNNaHdStkIY1/6/Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DjcuEN4rruzAQUeYq/DPXB+zN+MNTOO2eqyBxlYzVXjHieA1VSr7Tb/l/kuCw2ff2eaX7Zm0FP1vE2aBDHXYlhae1tfMFspexg5U1tvoKM14MdsfuEOkELgwxPE2hBsTiRyctyXN1LrpUVOzQ9Wlw4hThqgXkszkz+c6+NR3pGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=nrZmw5wq reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vPt+To74DmgnbmEWmfloIsf609b19hv6wfExzjJ4nZ4=;
  b=nrZmw5wqvh/kInQBrKFAABA3BC/kv7/WM9DKKkOZfwumW5AAwJIZ4InB
   p10uX0ZZtY+/bj5H+r8OCqwqTgKGzYJZa33PK2HRpZvbeBvgdcjQDHR0L
   ha/B5ABvEBJu1WdRiyNvcZ77rIjne/nputz8WoEQyocWPv/WZgTWAv6fM
   D5fiuOTuL57IIj5MpkEWN7Jc82FqwygWYJrs0fFQ8yGGOggieZlnJYC3c
   xy9y/ycT4nc/2iJCxTuDhK3PyWDT4H/h+88aLFv22iOlnZT9eOeZTkII+
   qp9rBLbutFM5oA6GBJ/2U8hhwAwqZO4uZTwOwZGgA4J9j+if6BvrMY5bv
   w==;
X-CSE-ConnectionGUID: 7a2v0iOaTyeh1zJTI4lsBA==
X-CSE-MsgGUID: pGPLbbXZR9KWHO5AZoTlSg==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 20 Sep 2024 16:25:06 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48K8P21a024254;
	Fri, 20 Sep 2024 16:25:02 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 16:25:03 +0800
From: Hermes Wu <Hermes.Wu@ite.com.tw>
To: Pin-yen Lin <treapking@chromium.org>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        open list <linux-kernel@vger.kernel.org>
CC: Kenneth Hung <Kenneth.hung@ite.com.tw>, "Hermes.Wu" <Hermes.wu@ite.com.tw>
Subject: [PATCH v1 0/2] drm/bridge: it6505: update dp aux function
Date: Fri, 20 Sep 2024 16:24:45 +0800
Message-ID: <20240920082451.9240-1-Hermes.Wu@ite.com.tw>
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
	27455162FD9A048BF7D4AC22E9177FDD40D1EF491B961C59BC06B61A7CFCE0422002:8
X-MAIL:mse.ite.com.tw 48K8P21a024254

From: "Hermes.Wu" <Hermes.wu@ite.com.tw>

This series change aux function to support MCCS and fix HDCP CTS

Hermes.Wu (1):
  drm/bridge: it6505:  Add MSSC suport

allen chen (1):
  drm/bridge:  it6505: HDCP CTS fail on repeater items

 drivers/gpu/drm/bridge/ite-it6505.c | 343 +++++++++++++++++++++++-----
 1 file changed, 292 insertions(+), 51 deletions(-)

-- 
2.34.1


