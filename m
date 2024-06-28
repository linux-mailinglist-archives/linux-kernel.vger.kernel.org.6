Return-Path: <linux-kernel+bounces-234526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 713AA91C79F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02040289CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9587BB0A;
	Fri, 28 Jun 2024 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FVOUjV7C"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DCB79B9D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608164; cv=none; b=kIePf2m/Lnse2DrlvbcFib5SpQ1KilrJu4rnSG5Fu7McRcK1dE++s142mvVE/FiJz2e5JqdTXqAIHrtCw2vJpXj8ROkpqE5d1RSHWLXR/Rsz4dKJvBuTiudP0qCJVBCxUSLvc2YYzhMwI32Cmq8h6HS1UInBcl8HqT7ZWWNEsxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608164; c=relaxed/simple;
	bh=fszmrC5gWNDzmXZWbedzgo1lFABDJWOe/+LQ3OHYHQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ON4zEDUw7kiv860cCR0IWjm8w3Wb9CbjiAMHOcqCK4LKpJvoPGyqLEIESuMHtvGp2/J87aB7H7UA4o9oQBcBuR2YRbMBv0G8tu0Jv7bJDE89vT7ZKV5Efx1k4XayVe/UtUFH/IIZ3qZWDjy4MMsR8X637Q0mX4DVPD9bIcs+FAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FVOUjV7C; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: radhey.shyam.pandey@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=51DtrpHQayl7ulUlBsixd6UFM0ekNQlu75nZ9eI5mu8=;
	b=FVOUjV7Csnqr/7SpPyJafEPGIwIv7VRjGq0z3R9mywjnZNpOoUJLiAGqMPWiMdrLl5uH65
	kRbsJVyUFba/TZKNRZObhdb6ycRj0hzRdLgiMNF7xUopX2Z+pDTjZhG/H8gibYeVE4jIA7
	EuFM0FEXbIqG8Tai0m/vlB1uKNw4t+o=
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: linux-phy@lists.infradead.org
X-Envelope-To: vkoul@kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: kishon@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3 0/5] phy: zynqmp: Fixes and debugfs support
Date: Fri, 28 Jun 2024 16:55:35 -0400
Message-Id: <20240628205540.3098010-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This has a few fixes and cleanups. Additionally, the last patch adds
useful debugfs info.

Changes in v3:
- Remove inapplicable comments
- Take the phy mutex in xlate
- Use "none" to represent ICM_PROTOCOL_PD, since the lane may not
  actually be powered-down.

Changes in v2:
- Enable reference clock correctly
- Expand the icm_matrix comment
- Move the logic for waiting on PLL lock to xpsgtr_wait_pll_lock
- Use debugfs_create_devm_seqfile

Sean Anderson (5):
  phy: zynqmp: Enable reference clock correctly
  phy: zynqmp: Store instance instead of type
  phy: zynqmp: Only wait for PLL lock "primary" instances
  phy: zynqmp: Take the phy mutex in xlate
  phy: zynqmp: Add debugfs support

 drivers/phy/xilinx/phy-zynqmp.c | 198 ++++++++++++++++----------------
 1 file changed, 100 insertions(+), 98 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


