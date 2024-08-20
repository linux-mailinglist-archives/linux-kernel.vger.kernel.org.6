Return-Path: <linux-kernel+bounces-294433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D44958DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC42282641
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AFB1C0DFE;
	Tue, 20 Aug 2024 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OxXx2w6L"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929294CDEC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724176445; cv=none; b=AuGF8B1jYhvKwx4pu+lJLtgtg22AeysvQSicf4hTNhUPibYXs3EPEARxjs2vFDshnJUS/y1rvCIT4LAnJeKIoHx7mayUnZpNngMXjcy6fQk6GFTC706/4dsDBOnTxooEXDmuxYBEWCEj5TvcfAHKSjS7/4g2HpsfwgZkzFyXMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724176445; c=relaxed/simple;
	bh=F2PUkTkAK7wYXWeJnYjtmAhxRi2txwJMl6OqHcY8RGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jd1Bflu4jpVXv9wVoJEwu1DjXcZoTe7LLp3R0s8/YkQJ3Rr9zn3wUIuQaI0WVYgZvLNw1rJC5bSlIOo9WWpdFqOVyQD85rcfIWT9F3fFIhPrIwM49Dgzjx9ONsFeyVG6UMPfGQmG3AXKbqrf4PVqYwPs81QqUUfhcoDRHl8eKB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OxXx2w6L; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724176441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iauch5809aYw0zcKrq/ncZUeuHwbewH9i2gZIKc7qnY=;
	b=OxXx2w6Ly9sbN1gs6iqprEn6klo8+nLRZnaJQG4zeqjNn7ZTUUnx65DH2bvaYeXFzxExak
	MwdYwdHlJiFNRrSfOIQOSXCEl+WhYyQC/5G57+jVqsQQooOR0AAEkJhcYlJOCHqGj+oAaB
	O9DKQBSNoxK/vRpaZVhZ4cKaVR5M+K4=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v4 0/2] net: xilinx: axienet: Add statistics support
Date: Tue, 20 Aug 2024 13:53:40 -0400
Message-Id: <20240820175343.760389-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add support for hardware statistics counters (if they are enabled) in
the AXI Ethernet driver. Unfortunately, the implementation is
complicated a bit since the hardware might only support 32-bit counters.

Changes in v4:
- Reduce hw_last_counter to u32 to ensure we use (wrapping) 32-bit
  arithmetic.
- Implement get_ethtool_stats for nonstandard statistics
- Rebase onto net-next/main

Changes in v3:
- Use explicit mutex_lock/unlock instead of guard() in
  __axienet_device_reset to make it clear that we need to hold
  lp->stats_lock for the whole function.

Changes in v2:
- Switch to a seqlock-based implementation to allow fresher updates
  (rather than always using stale counter values from the previous
  refresh).
- Take stats_lock unconditionally in __axienet_device_reset
- Fix documentation mismatch

Sean Anderson (2):
  net: xilinx: axienet: Report RxRject as rx_dropped
  net: xilinx: axienet: Add statistics support

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  85 +++++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 327 +++++++++++++++++-
 2 files changed, 408 insertions(+), 4 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


