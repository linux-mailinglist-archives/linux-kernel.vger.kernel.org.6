Return-Path: <linux-kernel+bounces-201395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD1A8FBDFD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2585AB24690
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12FC14D296;
	Tue,  4 Jun 2024 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TcP+bXez"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847ED84E1C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536179; cv=none; b=J2uGVQ7s9nnWL6E8JR5m7IpOtjGNvsTnIM5nXS1pU+p2pJiHU7vNj0D753sCQX4gbo+jm7gCWTq8Ky22MIeALMnYSv/Cem3Qs8DbIgZ/XYQ8UyK3+iaza3DxgjiqwwfSiryHN3V2q0SYVZlptfHWLhE5PbqdIu1oSZ4RHAjb/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536179; c=relaxed/simple;
	bh=fmVvY+JNZpsEx1YEUwXw+sagzKkVZJYhIwWRBRO3PPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b97TDRnhVE3ln0HhbLi3EP6+EwRv0776EROrvk7bGPoHWwWOfcWAViCAj3OjxsHN4vVwqkEapnHOfQSEgRlICqU1ky9P3kS/WOA8yiCfza1XEvPPbLkbG8LDILWV525OVipHRpRds4/VcR6kwRx7oQVh7h7yQ2qChNwr6F4l+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TcP+bXez; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=ipB+dIDL7p2Y85aj9rGKHn6fFGIdgaCRl3bJhyD9eCA=; b=TcP+bX
	ez/Q27NRvYItnMWHJ64kQB3dT7Kil81i4X3R82XMbuQl+4obYVBWUqNYbqZ+LW1V
	KV8G6LRRSIEQiv6iX+PUsxlzeY/DrqTRDKyVvrdPDhp9jSHm7Wtxq7X5hPek74B7
	ClUqB2P69JBFpAfgMd5Qq5XsIGo+ErZkCBmWSa9a6tmH3tpA8nm1rqc+UNw/EpQr
	/U35lm4ivT27EjDdy6tVa1bgKat9bi/6sxDNbmNPLn586m3kKLbX4yw7G2MPwgG7
	vl/zM1SZWi3NicDVp2htNvegPpqX1K2evo7+ZrDztgTyqgfPcGB+xC+h6Rcd7vji
	e2KSqyBDGVOCaHaA==
Received: (qmail 2449471 invoked from network); 4 Jun 2024 23:22:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2024 23:22:52 +0200
X-UD-Smtp-Session: l3s3148p1@ILFzDRcaNN1ehhtB
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alex Dubov <oakad@yahoo.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/4] misc: tifm: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue,  4 Jun 2024 23:22:38 +0200
Message-ID: <20240604212240.4529-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604212240.4529-1-wsa+renesas@sang-engineering.com>
References: <20240604212240.4529-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/misc/tifm_7xx1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
index 7dd86a9858ab..1d54680d6ed2 100644
--- a/drivers/misc/tifm_7xx1.c
+++ b/drivers/misc/tifm_7xx1.c
@@ -229,7 +229,7 @@ static int __maybe_unused tifm_7xx1_resume(struct device *dev_d)
 	struct pci_dev *dev = to_pci_dev(dev_d);
 	struct tifm_adapter *fm = pci_get_drvdata(dev);
 	int rc;
-	unsigned long timeout;
+	unsigned long time_left;
 	unsigned int good_sockets = 0, bad_sockets = 0;
 	unsigned long flags;
 	/* Maximum number of entries is 4 */
@@ -265,8 +265,8 @@ static int __maybe_unused tifm_7xx1_resume(struct device *dev_d)
 	if (good_sockets) {
 		fm->finish_me = &finish_resume;
 		spin_unlock_irqrestore(&fm->lock, flags);
-		timeout = wait_for_completion_timeout(&finish_resume, HZ);
-		dev_dbg(&dev->dev, "wait returned %lu\n", timeout);
+		time_left = wait_for_completion_timeout(&finish_resume, HZ);
+		dev_dbg(&dev->dev, "wait returned %lu\n", time_left);
 		writel(TIFM_IRQ_FIFOMASK(good_sockets)
 		       | TIFM_IRQ_CARDMASK(good_sockets),
 		       fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
-- 
2.43.0


