Return-Path: <linux-kernel+bounces-189302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B198CEE28
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 09:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996921C20BD1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 07:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5058BFBED;
	Sat, 25 May 2024 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YcUDsL6D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HDbMBRb+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D2DDC4
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716622357; cv=none; b=nHo4iIVUxNMMHcEFCHhZs6U/JCI1TeAQudnPvOXT1V+a/J52Q+r9VkV2C4h0LC4uIZm+6knWiaP6ay/hbq5jSX3YHEq7NkvIkBISHmwNyLqlxDh+0BjrYynsZ/yv9psKrlMxZW8Lje8DCjEwYvaOnCGj5KICC2lWJjXWEBv5ykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716622357; c=relaxed/simple;
	bh=7/qtvsoEYPm/gp5Dn4A9Wd7Ix2aEqp7UV1ynS6s6QVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HO3CH4REf2Z0T31jArR055maHzq3CtXKlIjrPKOZhwgmpkfAN54vjlSF6NJfF2jjtDbawPLlvo2YzwFtdprKU2Q+HjMjDsk0uk0jUxLBhqWjulsOST4iI/i6jTsBIOXh4pdT6Pyah3VDW3BWsWHvr8lPNGVkjk0lUpt6wAYWx4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YcUDsL6D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HDbMBRb+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716622353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wi+/J+ptePQGvzXQ0v1rtPKu00m6VIgRcYRhLkIVOyY=;
	b=YcUDsL6DOKRV1Su0hk7BeA3Umye3dohePC6fFISxBMs9/b/VWwCI6EN8n93rcMvsjw5Mz4
	SurM6A2oipPlgllcdUWCQ3bkCsapnX2nvA5Jp/Wa80pNASPt4xRUy7rxPpsvSinl6fQcJ7
	Ih3uKtg3W6HCdFgsxmNuCD+2rgCpwMvnI9CgqMjnoU2mTjB4gLKkJ0rSvSDzJfX4jQ4yRu
	6QBSQDf/SU7ISC7GAUCRdQuIIe35Rr7f+/cIOF8ovWDJf6CSJf1WYInIt5tc3aQ0Tel8Vd
	oHHk5XFiAhCP3OiORvHNfE5DfAEQKqbHSTqSFaKpyLSyPDPyKubIJxyHpjzH6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716622353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wi+/J+ptePQGvzXQ0v1rtPKu00m6VIgRcYRhLkIVOyY=;
	b=HDbMBRb+gwwDSymD2ZGCQydsOKGCm/du827Due4IKaY5lYB04uZwONAawKs+PPdhghdJz5
	eA+t0v+xyKtonjCw==
To: Larry Finger <Larry.Finger@lwfinger.net>,
	Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Nam Cao <namcao@linutronix.de>,
	syzbot+83763e624cfec6b462cb@syzkaller.appspotmail.com
Subject: [PATCH] staging: rtl8712: remove unnecessary alignment of pxmitpriv->pxmitbuf
Date: Sat, 25 May 2024 09:32:29 +0200
Message-Id: <20240525073229.4144612-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver wants pxmitpriv->pxmitbuf to be 4-byte aligned. This is ensured
by allocating 4 more bytes than required with kmalloc(), then do the
p = p + 4 - (p & 3) trick to make sure the pointer is 4-byte aligned.

This is unnecessary. Pointers from kmalloc() are already at least
8-byte-aligned.

Remove this alignment trick to simplify the code, and also to stop wasting
4 extra bytes of dynamic memory allocator.

This also gets rid of a (false) warning from kmemleak. This 4-byte-aligned
buffer is used to store pointers from kmalloc(). For 64-bit platforms,
pointer size is 8 bytes and kmemleak only scans for pointers in 8-byte
blocks, thus it misses the pointers stored in this 4-byte-aligned buffer
and thinks that these pointers have been leaked. This is just a false
warning, not a real problem. But still, it would be nice to get rid of
these warnings.

Reported-and-tested-by: syzbot+83763e624cfec6b462cb@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-staging/000000000000809328060a8a4c1c@google.com
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Patch sent using this driver with this patch applied.

 drivers/staging/rtl8712/rtl871x_xmit.c | 13 +++++--------
 drivers/staging/rtl8712/rtl871x_xmit.h |  1 -
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 6353dbe554d3..408616e9afcf 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -117,12 +117,9 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	/*init xmit_buf*/
 	_init_queue(&pxmitpriv->free_xmitbuf_queue);
 	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
-	pxmitpriv->pallocated_xmitbuf =
-		kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4, GFP_ATOMIC);
-	if (!pxmitpriv->pallocated_xmitbuf)
+	pxmitpriv->pxmitbuf = kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf), GFP_ATOMIC);
+	if (!pxmitpriv->pxmitbuf)
 		goto clean_up_frame_buf;
-	pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 -
-			      ((addr_t)(pxmitpriv->pallocated_xmitbuf) & 3);
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
 	for (i = 0; i < NR_XMITBUFF; i++) {
 		INIT_LIST_HEAD(&pxmitbuf->list);
@@ -165,8 +162,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 		for (k = 0; k < 8; k++)		/* delete xmit urb's */
 			usb_free_urb(pxmitbuf->pxmit_urb[k]);
 	}
-	kfree(pxmitpriv->pallocated_xmitbuf);
-	pxmitpriv->pallocated_xmitbuf = NULL;
+	kfree(pxmitpriv->pxmitbuf);
+	pxmitpriv->pxmitbuf = NULL;
 clean_up_frame_buf:
 	kfree(pxmitpriv->pallocated_frame_buf);
 	pxmitpriv->pallocated_frame_buf = NULL;
@@ -193,7 +190,7 @@ void _free_xmit_priv(struct xmit_priv *pxmitpriv)
 		pxmitbuf++;
 	}
 	kfree(pxmitpriv->pallocated_frame_buf);
-	kfree(pxmitpriv->pallocated_xmitbuf);
+	kfree(pxmitpriv->pxmitbuf);
 	free_hwxmits(padapter);
 }
 
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
index cdcbc87a3cad..784172c385e3 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -244,7 +244,6 @@ struct	xmit_priv {
 	int cmdseq;
 	struct  __queue free_xmitbuf_queue;
 	struct  __queue pending_xmitbuf_queue;
-	u8 *pallocated_xmitbuf;
 	u8 *pxmitbuf;
 	uint free_xmitbuf_cnt;
 };
-- 
2.39.2


