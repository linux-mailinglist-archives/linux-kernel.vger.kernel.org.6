Return-Path: <linux-kernel+bounces-293938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E969E9586BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83153B253C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A93118FC91;
	Tue, 20 Aug 2024 12:17:06 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81DE18B48D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156225; cv=none; b=WlJvyt0HSvNC+Bkvn2pF2LE6u0cV9HKbT6KvvDkh2JgB7vI4DIpx616UY+O00t3ZCoJYCFbBjx7vQjLPGUHreRwAy2oNemryliaZZnGVvYlU1hFckE3HgOR4+8Qh3tqy1P7EYsR0WvNMW2H6EaDzfUML9Y4L7DnVfE+rqDkOjA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156225; c=relaxed/simple;
	bh=RS+EHn26H9QizywcTT08//7IEUQd34ChaZrvzRgEcr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RgHmKHs7T+J/U06hUHKc2GhDiliup2N2IPG6+7UHBevecZOepOwjd/rEUAbisLDJGDCuZBfIz/QYxCSzPdVa0xoQ7hClVPm0MdtzVZ7KKZmIa1QQnpd/Hf/X3G92KzgAwPVm4XBM/+RGOSkZmDoNFzU0Js4lhLKyOK8bJZlS8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:a2e4:464c:5828:2da3])
	by baptiste.telenet-ops.be with bizsmtp
	id 2CGv2D00P2WQTnu01CGvLN; Tue, 20 Aug 2024 14:16:55 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sgNnC-000NrD-Hf;
	Tue, 20 Aug 2024 14:16:55 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sgNnC-001nqn-WF;
	Tue, 20 Aug 2024 14:16:55 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Stefan Wiehler <stefan.wiehler@nokia.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of/irq: Refer to actual buffer size in of_irq_parse_one()
Date: Tue, 20 Aug 2024 14:16:53 +0200
Message-Id: <817c0b9626fd30790fc488c472a3398324cfcc0c.1724156125.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace two open-coded calculations of the buffer size by invocations of
sizeof() on the buffer itself, to make sure the code will always use the
actual buffer size.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
If you think this warrants a Fixes-tag:

    Fixes: b739dffa5d570b41 ("of/irq: Prevent device address out-of-bounds read in interrupt map walk")
---
 drivers/of/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index cc30b471e446045a..36351ad6115eb10e 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -357,8 +357,8 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	addr = of_get_property(device, "reg", &addr_len);
 
 	/* Prevent out-of-bounds read in case of longer interrupt parent address size */
-	if (addr_len > (3 * sizeof(__be32)))
-		addr_len = 3 * sizeof(__be32);
+	if (addr_len > sizeof(addr_buf))
+		addr_len = sizeof(addr_buf);
 	if (addr)
 		memcpy(addr_buf, addr, addr_len);
 
-- 
2.34.1


