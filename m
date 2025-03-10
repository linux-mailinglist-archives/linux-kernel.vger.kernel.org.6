Return-Path: <linux-kernel+bounces-554580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5857DA59A26
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0325F188F9C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E122DF87;
	Mon, 10 Mar 2025 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J9yDaS7c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+3aFRTCN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6D22618F;
	Mon, 10 Mar 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621110; cv=none; b=PcO4HqDbUfjxq9e9qvUcup+kua00q2VSNxHTyKBnjc6Rlpq+SPnFXcYPGCJKSxHgk1s6lhugbtRJdJ27/tbzd2KJjouInleeuf70+QUzLMl7+779vODRvK1H4+nfZMKgPRe3HDhjEv1MOlWd/QWYT5kh6LrYJqfe7ugNKp6ofeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621110; c=relaxed/simple;
	bh=kwv6YXzRLSKnph4Bl6KQltrd4tKRcYjiSMLedmuP9Ag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RQR4qAKNWA41oiJCZR/wMhe9j1DE2MKs+YXf4SfZ/wKGp4J47g7wIQFbogwQTvUps5W3WMJrL1DuaXH0uGHxaYbXtidmSOzZmsKWD7jcHmmhVIP16GtxZfnS9pemUE1FshEBTUpv8HWonUnDjgYZS0Rjh56c1xlj+i6JBt1IbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J9yDaS7c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+3aFRTCN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741621106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=onKZ358iPe3ysbYLBfjepet0iilG2tjfvE5V6cV3SMA=;
	b=J9yDaS7cOedY3dvMZxxw9U+nvuLx6vzA6UZcfdSiYtLqYuYkqXQvg1KOn1WT7cDIsqrR5J
	TClfFX7H1kmxDqZ5cbAAwxvDxhgrpbAd5/JhU5eG8H1LvCkReQU+AnllGWQ/xFLFvycqPL
	qL87gMnsPmLgW7/ms6avfTgC1T0dc1uS6WUwyBL4FU/S8pSbYLFDpf9x4cHHbzrwg98O3f
	Sy2mPHgcFw03X1zXpiMq84jOXuC831iRxekwKQK/rXD+G/geTdold4XkwjXX/obtIFB2pp
	2g5GIfVWGpTvd23WQqam4dj1ULjcKvQw8cYK+yylSvaeaSmBm/8w2afb4LCnPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741621106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=onKZ358iPe3ysbYLBfjepet0iilG2tjfvE5V6cV3SMA=;
	b=+3aFRTCNY/Sy0ctAsngH1dSFQqizVCDY+PjB6AjJVetoV+vINiaBDbWhi7R94zs+X+4MTa
	MkLcBnV/CTvbqxAw==
Subject: [PATCH v2 0/2] usb: Don't use %pK through printk
Date: Mon, 10 Mar 2025 16:38:22 +0100
Message-Id: <20250310-restricted-pointers-usb-v2-0-a7598e2d47d1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG4Hz2cC/4WNQQ6CMBBFr0K6dgytVgor72FYAB1lEtOSmUIwh
 LtbuYDL95L//qYEmVBUU2yKcSGhGDKYU6GGsQsvBPKZlSmNLY2ugFES05DQwxQpJGSBWXpwQ6V
 13+Gtrq8qryfGJ61H+dFmHklS5M9xtOif/d9cNJRQOd9Zq61zF3N/U5gTx0Dr2aNq933/At4Ft
 zDCAAAA
X-Change-ID: 20250217-restricted-pointers-usb-8c711bae6994
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741621105; l=1065;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kwv6YXzRLSKnph4Bl6KQltrd4tKRcYjiSMLedmuP9Ag=;
 b=GwvblWNPSZ+SxzDwVWvmpIZtyOCKLyP5mBcCcmR1GoW75IDYGZAo031r+hH7oj2r53yQ/aCpD
 UrC+v5DR9g8Aj1PR/vJCAMbQqUEN+e4ejnI/o95UWI00TchQxistgos
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Restricted pointers ("%pK") are not meant to be used through printk().
It can unintentionally expose security sensitive, raw pointer values.

Use regular pointer formatting instead.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Refer to original %p->%pK changes in commit messages
- Link to v1: https://lore.kernel.org/r/20250217-restricted-pointers-usb-v1-0-78da55158832@linutronix.de

---
Thomas Weißschuh (2):
      usb: core: Don't use %pK through printk
      usb: dwc3: Don't use %pK through printk

 drivers/usb/core/hcd.c     | 4 ++--
 drivers/usb/core/urb.c     | 2 +-
 drivers/usb/dwc3/dwc3-st.c | 2 +-
 drivers/usb/dwc3/gadget.c  | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250217-restricted-pointers-usb-8c711bae6994

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


