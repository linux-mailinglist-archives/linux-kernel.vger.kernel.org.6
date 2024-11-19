Return-Path: <linux-kernel+bounces-414275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596DA9D25A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F34B286905
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EF21CC151;
	Tue, 19 Nov 2024 12:19:29 +0000 (UTC)
Received: from queue02a.mail.zen.net.uk (queue02a.mail.zen.net.uk [212.23.3.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3901CBE95
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018769; cv=none; b=pNXIULc8Ua7t9Tp/e1L9ugzH4Xh0MSZG2TiZ+d4nMvyVYobqaH6yHEWBv3qqJey5pUaCj9AlQRmUlOTSCU6K1Z/EvakySXKPTqcYg7gEiUVItk5Mi7Pyz+ljzaO+cJ0zp1BHClDbogmPJp+58DCAuehV8iCcMPLJsIFfxB9sAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018769; c=relaxed/simple;
	bh=t47a69iyouvtY3OOb1/qhWtbOC2oNNIXFj9j6JKPZ04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKOPF8F9Yya8y4Tf6hsVlCSrwK9tuiYdugkGq+750MZ9eIPf2bmHmcWy1JLfXfSAZxheNvse+RxmxRDPSSmHmjel+5b9Iv5Ql1R3wCkr5zg1W+enp5odiT8BiiRkGpBCr+WctDfQQbA0cCNEYiFCGK5e++WHBNnZJE+f2ElPGVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems; spf=fail smtp.mailfrom=starlabs.systems; arc=none smtp.client-ip=212.23.3.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=starlabs.systems
Received: from [212.23.1.21] (helo=smarthost01b.ixn.mail.zen.net.uk)
	by queue02a.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1tDNCU-003pNT-Li
	for linux-kernel@vger.kernel.org;
	Tue, 19 Nov 2024 12:19:22 +0000
Received: from [217.155.46.38] (helo=sean-Byte.localdomain)
	by smarthost01b.ixn.mail.zen.net.uk with esmtp (Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1tDNCN-00Ghb8-CF;
	Tue, 19 Nov 2024 12:19:15 +0000
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Sean Rhodes <sean@starlabs.systems>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] drivers/card_reader/rtsx_usb: Fix clock switching logic
Date: Tue, 19 Nov 2024 12:19:12 +0000
Message-ID: <20241119121912.12383-3-sean@starlabs.systems>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119121912.12383-1-sean@starlabs.systems>
References: <20241119121912.12383-1-sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-smarthost01b-IP: [217.155.46.38]
Feedback-ID: 217.155.46.38

Fix the `rtsx_usb_switch_clock` function to ensure the `card_clock`
parameter is not inadvertently modified during the function's
execution. This change:
- Introduces a `hardware_clock` variable to store the original clock
  value, preserving the integrity of the `card_clock` parameter.
- Updates the assignment of `ucr->cur_clk` to use `original_card_clock`.

This adjustment aligns the behavior with the intended logic and
prevents unintended side effects from modifying input parameters.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/misc/cardreader/rtsx_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index 285a748748d7..f5936c021777 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -406,6 +406,7 @@ int rtsx_usb_switch_clock(struct rtsx_ucr *ucr, unsigned int card_clock,
 {
 	int ret;
 	u8 n, clk_divider, mcu_cnt, div;
+	unsigned int original_card_clock = card_clock;
 
 	if (!card_clock) {
 		ucr->cur_clk = 0;
@@ -494,7 +495,7 @@ int rtsx_usb_switch_clock(struct rtsx_ucr *ucr, unsigned int card_clock,
 	if (ret < 0)
 		return ret;
 
-	ucr->cur_clk = card_clock;
+	ucr->cur_clk = original_card_clock;
 
 	return 0;
 }
-- 
2.43.0


