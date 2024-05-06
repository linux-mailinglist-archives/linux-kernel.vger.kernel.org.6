Return-Path: <linux-kernel+bounces-170212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11D98BD388
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4FA28344F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75092156F54;
	Mon,  6 May 2024 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sw0rwZS8"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23FD156F4C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014879; cv=none; b=EtZSiXRt/seJGChv1V4JZBuHkIWd/CsYp6Qd32mylSxg7U9hTYKDnaEsRFmsUybw1frNIHghrJoKvTorSNgCAH/yji/bGQ/m3XhGDb9gBkdRfmJskIFd3gf7vdLUL0MnNGc7ne7aCbLR5hs+pmP/WSFGlCxSFyl9OAUblIGpvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014879; c=relaxed/simple;
	bh=875Pw760E+0v/PI5WhiXOO+miRdeGTK1PCQ9Pwrq2PU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=muaYFKJLmKXw7bC1piCDZuY0fmaYdUV6xWezSXkNJmZryBQm+crLWtvAhyypZ5dzrKpjsNCvTB+yQcEB7Jiknl0NVxoxHp68ZPYiDRWniwdRsjvahsw1TYlOiux50elOqVlmhOGPyUbCAKWw7zf6PAtYpoK1WKjW8PMDbcT8Ogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sw0rwZS8; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715014875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B4HAr5WNqIN+2BMtIDkk4eWOethRMvYJIjKQInTq8Q4=;
	b=sw0rwZS8FPh4DawpviRrrEv/R8LHR54VYj1duj396TVqGjaaBniJOh35oj5fpVVRsAVd0v
	X0e4VVZYKNY/RAlXSdigQ4j9Emeso90X+8l5j2XWwktBnnA0sie9LXgQx+x5NHPY1XSmdC
	VtfZHtg8rZWlCiks5qvqjdPW7ituZFI=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 0/4] phy: zynqmp: Fixes and debugfs support
Date: Mon,  6 May 2024 13:01:06 -0400
Message-Id: <20240506170110.2874724-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This has a few fixes and cleanups cleaning up the driver. Additionally,
the last patch adds useful debugfs info.

Changes in v2:
- Enable reference clock correctly
- Expand the icm_matrix comment
- Move the logic for waiting on PLL lock to xpsgtr_wait_pll_lock
- Use debugfs_create_devm_seqfile

Sean Anderson (4):
  phy: zynqmp: Enable reference clock correctly
  phy: zynqmp: Store instance instead of type
  phy: zynqmp: Only wait for PLL lock "primary" instances
  phy: zynqmp: Add debugfs support

 drivers/phy/xilinx/phy-zynqmp.c | 197 ++++++++++++++++----------------
 1 file changed, 100 insertions(+), 97 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


