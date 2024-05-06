Return-Path: <linux-kernel+bounces-169577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EBC8BCAC1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B3B1F233F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75539142635;
	Mon,  6 May 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="iC9UhoEb"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B033A6CDCE
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988164; cv=none; b=cj1guAZwYNhNjzwya85Ix9E5OtGb2rexzeUTQjVvgraDKrleh7Ch4waYVlm6IdA0ft0WObT5zOQEVDDeCzSlwfzCbFJaANmLEeu4pBM0FTWu69g2vC49+6zYzty/pkYxirOk6oiX7vD5VcXL7JY5ll6doG1OSlVVtnDPo38ROnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988164; c=relaxed/simple;
	bh=vSuK5iXH4OTihAgSFb7ysIk2M7lQ6VsXeofRsuYcqCw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tJw1Az78xnD/doH76eecxz+A2gHec9zZhQ9YOiWj55li53MNHZfUAQGhgpd3eJz0x5qKfw3dOJ91Qa1Fo80ANmoDEo2Zy1l1wYpfXiz96HdjaqvpfhsFE6PqNFlXCJMw/2vxaOANUq7dfPqWP4FXV5nsGvpIn6Ymcnz7Lx77X/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=iC9UhoEb reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8SFYDKm8OC4xUxF8bgpqvbQooZqRTrwAdouVI63ou1w=;
  b=iC9UhoEbTuhXCmmCiRgAepBQ3ZN7B2oq0/n70XRDhRKpnYokrzq1zIa7
   5M1y2I6qkIh5kbS8SWbruDnyP15cdw0sRf59RtP9ALdvw+hm9AnzevdGw
   S8QFFXQM7WS8xyPsFhP6i0+tAOA499aTsIKIzhslyy1Si8g5H/BiXuOll
   8MUSPNWnqwrFZH52AdjfEF5P5zD3v5RZ6arTNytmRw54VVBtWvNsmtRX6
   M6xhRc4wCYNeHWYvFTcU6L7XhV4V3RpVBa+VUxYQcRJm/JEZ/uHdX+Azm
   FQ+1UnOKFIUNCJCC9lPvEEg8Dursf+WoGWpvkgmFsI2UVIWPWt1Zc9uPZ
   A==;
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 06 May 2024 17:35:59 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 4469Ztbv076496;
	Mon, 6 May 2024 17:35:55 +0800 (GMT-8)
	(envelope-from kuro.chung@ite.com.tw)
Received: from ite-XPS-13-9360.internal.ite.com.tw (192.168.72.42) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 17:35:54 +0800
From: kuro <kuro.chung@ite.com.tw>
To:
CC: Allen Chen <allen.chen@ite.com.tw>, Pin-yen Lin <treapking@chromium.org>,
        Kuro Chung <kuro.chung@ite.com.tw>,
        Kenneth Haung <kenneth.hung@ite.com.tw>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec
	<jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/1] drm/bridge: it6505: fix hibernate to resume no display issue
Date: Mon, 6 May 2024 17:46:43 +0800
Message-ID: <20240506094644.887842-1-kuro.chung@ite.com.tw>
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
	A46FF6935D4B88CF96C74D974E4941A1CFE1E4F05EA5BB26EA581C7F586BC3C22002:8
X-MAIL:mse.ite.com.tw 4469Ztbv076496

From: Kuro <kuro.chung@ite.com.tw>

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


allen (1):
  UPSTREAM: drm/bridge: it6505: fix hibernate to resume no display issue

 drivers/gpu/drm/bridge/ite-it6505.c | 73 +++++++++++++++++++----------
 1 file changed, 49 insertions(+), 24 deletions(-)

-- 
2.25.1


