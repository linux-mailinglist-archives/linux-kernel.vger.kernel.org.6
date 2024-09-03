Return-Path: <linux-kernel+bounces-313532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF29096A6C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21921C2443E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318A9192589;
	Tue,  3 Sep 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xrsgXmVL"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741A315574F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389023; cv=none; b=AKoBxTBIej78uagP51kIMRCDhAUjBfYzGFeT8NIn4uW2U1CMT0smf4+ZI4fvXYUrOh9LrG1z287pF9dRM2NA+Vi32SPimOITRXy/kfBjMOIOkEGj4bykGflQW0psua0h1w4eK5BFuxegVns1bWeUlcYYWOAJxzsTaPwkwoqkC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389023; c=relaxed/simple;
	bh=cC1sXQkBjYLAnc/YMZxuskvfz6NvNprlpSRd1UINO8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lE+W5lRX9d/x43kXxBZS6RxicHIa75yfzm1b3xn2YmJJjiH4orbXT4VB0Tr5+oYbJ0g7dspvq7nznmlZHv4mAXB0fx2wIBRwiDfy7JLAhJnB5OaA8W3t6YyJh/zKRe1rBaTAj2PUzdcnkuSMzYttDG9xWZ6Y0w9Q1eyeFnlrhYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xrsgXmVL; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725389019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u0V+gHjiO+W5aR/7m1PFt/lGZTb9pucfD3ixCjjavZc=;
	b=xrsgXmVLei/Z/73DzMw7vDr4YKMRpplK7Z868CNE3MCS9Y7wL9cxwIpMdT4QH88h/tR71s
	QNZqxBRIcsD+EHWTtPu6F16RO327PkB+uxMCYB6IfTpRBwFiMbb1lUa7zsU+7fdHCOzyvx
	isP34qNmYXVpGi5+JRt5/pTdQnJOxR0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 0/3] net: xilinx: axienet: Partial checksum offload improvements
Date: Tue,  3 Sep 2024 14:43:31 -0400
Message-Id: <20240903184334.4150843-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Partial checksum offload is not always used when it could be. Enable it
in more cases.


Sean Anderson (3):
  net: xilinx: axienet: Remove unused checksum variables
  net: xilinx: axienet: Enable NETIF_F_HW_CSUM for partial tx
    checksumming
  net: xilinx: axienet: Relax partial rx checksum checks

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  5 -----
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 20 +++----------------
 2 files changed, 3 insertions(+), 22 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


