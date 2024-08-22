Return-Path: <linux-kernel+bounces-297551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F5095BAB0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D139F2838E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224741CCB2C;
	Thu, 22 Aug 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ONInmjly"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114EE1C693
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341286; cv=none; b=gCjcairZ3Az2UNNvTtwyf6U+AF1lA3IA+1AiZNaAOAW+JM93x6PlYRL66+wqkIKiMKrNvgUGJUGuI4RxCT9AixSz++s7bY9taruIzj0Yc5/CS9MxacaTn7pVSRHpIExv/ATAwMWS1yYGnt4/Xv1aYJLq2HBf0+uZDaPG8zdEkOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341286; c=relaxed/simple;
	bh=s47hheMDdwOxzTSJfcw+UbWuyV8yMB3T4K2cbxKeTxE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b9iYiBGh7p5qlCGmvG/z0xyUN0KWMk6qEdamS8vUkjZV0tFXwmCgr8jw1BLAWJu+AIDEkW+EjP9zDhA7ZbdonwxXVjh5rsgynvvriL9tPyPFEDP12bJohJ17AfuVpDisLUYOMXmuiMFyU2J7qlnTfHnh4doj3RHj2nSbm2fA3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ONInmjly; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724341279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XI4XnHT5RMcYeA48dmo9vsAxVDbAfZYCg3p2vNi9cpc=;
	b=ONInmjlyZsHrB/eQ9bGTisiwVlZSTsn2mFrvq/KoG/H86lHV0Yy+0NtFH+lPtCbneZ/Kur
	Tf6BHjmYJAnYiv2SjiYoalajvlXdHYJ/E103XxU/sA/CKV0FQ4tdzGmD4UOPRZZ8i11niu
	IHQzCiB3SWOvXJIIPcq1kgKMO1eRO3U=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v3 0/5] net: xilinx: axienet: Multicast fixes and improvements
Date: Thu, 22 Aug 2024 11:40:54 -0400
Message-Id: <20240822154059.1066595-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series has a few small patches improving the handling of multicast
addresses. In particular, it makes the driver a whole lot less spammy,
and adjusts things so we aren't in promiscuous mode when we have more
than four multicast addresses (a common occurance on modern systems).

As the hardware has a 4-entry CAM, the ideal method would be to "pack"
multiple addresses into one CAM entry. Something like:

entry.address = address[0] | address[1];
entry.mask = ~(address[0] ^ address[1]);

Which would make the entry match both addresses (along with some others
that would need to be filtered in software).

Mapping addresses to entries in an efficient way is a bit tricky. If
anyone knows of an in-tree example of something like this, I'd be glad
to hear about it.

Changes in v3:
- Rebase onto net-next/main

Changes in v2:
- Split off IFF_PROMISC change from printing changes

Sean Anderson (5):
  net: xilinx: axienet: Always disable promiscuous mode
  net: xilinx: axienet: Fix dangling multicast addresses
  net: xilinx: axienet: Don't print if we go into promiscuous mode
  net: xilinx: axienet: Don't set IFF_PROMISC in ndev->flags
  net: xilinx: axienet: Support IFF_ALLMULTI

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  3 ++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 52 +++++++++----------
 2 files changed, 29 insertions(+), 26 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


