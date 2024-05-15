Return-Path: <linux-kernel+bounces-179547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 249D88C6137
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1651F23EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3852E42ABD;
	Wed, 15 May 2024 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="fotcWryP"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DD52EAF7
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757246; cv=none; b=V8hH7upf3idhBkzGhNW591dkRQrRpz/sjEnYsC0mkHCEQlTKZ3YGthPKGfDxr6nK8B51keooY5zQ9bTXGWm2/aGpdps5u6sepkBCSV6Fh70Xjc5tsasKnh2gZt02C8w0ca7zIK7z8UL2yTsFw3WPWiN5owHbuYFWLYb9ILAe/eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757246; c=relaxed/simple;
	bh=rs+cCu7FGv218rbM0FagCL1EvTBNiFY6mnPjzvJWqJA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MPU48+o5qvwhHwLPKHt62j67oarrxUaX6uTTLUIp/hITBIcenR8WQCV8n92irwfClnlcbKbVuANTxvo6GWB+WnRNvTJDI820RzEliKKRtv8N43riSxpiWUUn7PMEOmAv1uI39vqhCY3BTD41mt5J167UKPdv5jRZW7c7o/SVonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=fotcWryP reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IIoHEBypBuUFVSchJJMBHvhvDg18qPviVNpAw4yV414=;
  b=fotcWryPYXAiRMMzAgON0/KnphtNA2Bo/uekT9uU/LNbm2LyvlfGuIED
   aSzy26n4dpCKOsELBR6QzGe/ByAtDJWsp84ySsziEUnFqjVK+oZiTM5D5
   hn7leqoSyUXNGR35V1PS6PF8mShfXZv33bl3PkJgeZXdmbCcGjfW0BFuK
   y+kJGkc22edmo4KoQKk2Z/Q9cNTPAl3tfSWdNgIAUrgg6IDWs38M9zXwY
   WlYtIFz92rwMEZ6++I8Iv+AbsVP2i6JQEbpVsaTRMyc19xd5CQ65ROr6n
   IE84JUDse6b2qMNtYuJXvjrwgZ68ePr6rf8KqUJdfS6+estBYU7VnHDjM
   A==;
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 15 May 2024 15:12:46 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 44F7Chec099689;
	Wed, 15 May 2024 15:12:43 +0800 (GMT-8)
	(envelope-from kuro.chung@ite.com.tw)
Received: from ite-XPS-13-9360.internal.ite.com.tw (192.168.72.42) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 15:12:42 +0800
From: kuro <kuro.chung@ite.com.tw>
To:
CC: Allen Chen <allen.chen@ite.com.tw>, Pin-yen Lin <treapking@chromium.org>,
        Kuro Chung <kuro.chung@ite.com.tw>,
        Kenneth Haung <kenneth.hung@ite.com.tw>,
        Kuro <kuro.chung@ite.corp-partner.google.com>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/1] drm/bridge: it6505: fix hibernate to resume no display issue
Date: Wed, 15 May 2024 15:23:27 +0800
Message-ID: <20240515072328.1010920-1-kuro.chung@ite.com.tw>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP:
	A11021EA28A7D463AE6B142DA2BD4517620255AADFE51846BCE361304E44381F2002:8
X-MAIL:mse.ite.com.tw 44F7Chec099689

From: Kuro <kuro.chung@ite.corp-partner.google.com>

New patch description for v8 patch 

	resolve merge conflict

New patch description for v7 patch

        modify code from
        it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, 0x02); to
        it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, TX_FIFO_RESET); for macro define

New patch description for v6 patch

        remove the unrelated patch change (split into anoter patch)
        remove extra line

New patch description for v5 patch

        after customer feedback and test finished, update again, kernel build pass.

New patch description for v4 patch

        update by reviewer Pin-yen Lin comment, remove function it6505_irq_video_fifo_error/it6505_irq_io_latch_fifo_overflow
        update by reviewer Pin-yen Lin comment, update Signed-off-by column

New patch description for v3 patch

        update upstream MAINTAINERS mail list

New patch description for v2 patch

        Missing declaration for i variable in function it6505_irq_video_error_handler
        , add it by this patch

Origianl description for v1 patch

        drm/bridge: it6505: fix hibernate to resume no display issue

        ITE added a FIFO reset bit for input video. When system power resume,
        the TTL input of it6505 may get some noise before video signal stable
        and the hardware function reset is required.
        But the input FIFO reset will also trigger error interrupts of output module rising.
        Thus, it6505 have to wait a period can clear those expected error interrupts
        caused by manual hardware reset in one interrupt handler calling to avoid interrupt looping.


Kuro Chung (1):
  drm/bridge: it6505: fix hibernate to resume no display issue

 drivers/gpu/drm/bridge/ite-it6505.c | 73 +++++++++++++++++++----------
 1 file changed, 49 insertions(+), 24 deletions(-)

-- 
2.25.1


