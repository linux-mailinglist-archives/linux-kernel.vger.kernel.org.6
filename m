Return-Path: <linux-kernel+bounces-413468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EBA9D196E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72BE1F22439
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D5B1E47CE;
	Mon, 18 Nov 2024 20:07:25 +0000 (UTC)
Received: from queue02a.mail.zen.net.uk (queue02a.mail.zen.net.uk [212.23.3.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4614D2B7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960445; cv=none; b=TYqXHG6lF7cqkOS4X3fCpwCy+75xgh+y4DFWavPtfoCc38Wsyx2qpXWAD+T0G9fZpD8hLy73yAIXxQyoJiJUAWcleApyPDfv8ahtmaZ6YTsOxSm2HEpeLsESuMVvRUyXVlgvy/AAE6miWu5fcGtePlxdQKcUFHDL6RmqofR2inU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960445; c=relaxed/simple;
	bh=KenxdGQEny/YIQRdbNyD7Xxc8KpOohIjSt9y55xCdaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3vGbJLd9gqza2rz7XwvC+TjspK71b9QlPnZo8EtoYjUMSmnYIaH02p7MqIgkO3WtUoG4xp0r4SUyk1B5SW+sasNLJ6S8/DKziHKDwm8wKG8d92rCujlDhJfqK+ss0aZdvYuI96j1zXB09JV1VJu+/O/avwvzRExecHIzgvIwJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems; spf=fail smtp.mailfrom=starlabs.systems; arc=none smtp.client-ip=212.23.3.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=starlabs.systems
Received: from [212.23.1.1] (helo=smarthost01a.sbp.mail.zen.net.uk)
	by queue02a.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1tD7n9-003SLx-Ch
	for linux-kernel@vger.kernel.org;
	Mon, 18 Nov 2024 19:52:11 +0000
Received: from [217.155.46.38] (helo=starbook.localdomain)
	by smarthost01a.sbp.mail.zen.net.uk with esmtp (Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1tD7n2-0021zs-BA;
	Mon, 18 Nov 2024 19:52:04 +0000
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Sean Rhodes <sean@starlabs.systems>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] drivers/card_reader/rtsx_usb: Restore interrupt based detection
Date: Mon, 18 Nov 2024 19:52:01 +0000
Message-ID: <20241118195201.39007-1-sean@starlabs.systems>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-smarthost01a-IP: [217.155.46.38]
Feedback-ID: 217.155.46.38

This commit reintroduces interrupt-based card detection previously
used in the rts5139 driver. This functionality was removed in commit
00d8521dcd23 ("staging: remove rts5139 driver code").

Reintroducing this mechanism fixes presence detection for certain card
readers, which with the current driver, will taken approximately 20
seconds to enter S3 as `mmc_rescan` has to be frozen.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/misc/cardreader/rtsx_usb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index f150d8769f19..285a748748d7 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -286,6 +286,7 @@ static int rtsx_usb_get_status_with_bulk(struct rtsx_ucr *ucr, u16 *status)
 int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 {
 	int ret;
+	u8 interrupt_val = 0;
 	u16 *buf;
 
 	if (!status)
@@ -308,6 +309,20 @@ int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 		ret = rtsx_usb_get_status_with_bulk(ucr, status);
 	}
 
+	rtsx_usb_read_register(ucr, CARD_INT_PEND, &interrupt_val);
+	/* Cross check presence with interrupts */
+	if (*status & XD_CD)
+		if (!(interrupt_val & XD_INT))
+			*status &= ~XD_CD;
+
+	if (*status & SD_CD)
+		if (!(interrupt_val & SD_INT))
+			*status &= ~SD_CD;
+
+	if (*status & MS_CD)
+		if (!(interrupt_val & MS_INT))
+			*status &= ~MS_CD;
+
 	/* usb_control_msg may return positive when success */
 	if (ret < 0)
 		return ret;
-- 
2.45.2


