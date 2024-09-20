Return-Path: <linux-kernel+bounces-334516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D1797D840
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3306B1F22DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1366B17E012;
	Fri, 20 Sep 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="PjiVn5j7"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854CD17E006
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849258; cv=none; b=eidsAMxlLS9nUjnZx8/uaO2vbvoIDca9HB5Vub9slFhg9zrx3Lb0ql8hteIrzp3J5Z5uB3xwOzhcIszyvBYqiV4T1Izhg1hKzTL3hWqHukERBK6O3oJSd/BewpLgUCwdPpIqrGgTRaaEfHmdLRJhqBd5CqjM4v1Il0dcSX/po08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849258; c=relaxed/simple;
	bh=0tDGVmc5LkiIZ27A80qfOMS2GVRW5d1c8Fd+x+nxbS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LxyyrWGU4/TArxkHvZOkMeiI8t72JRmG6yZaNPH8oga77qTWp6Ak91wTVEDZGPFqjSu903jxk75Gf6IbJJMgbd7j95IER9BMRaUI1LjyZihPXSDpsl134vCrnjIlXgr3EbVSGjEK31dRWRsAQf5BEVQ0Pu9cPT5EooiueQ4bxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=PjiVn5j7; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1726849254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73ef//P4vu89x1xVYHtl3j3jH3oS5Ie6yyqqeyDl+44=;
	b=PjiVn5j7PYjiTHTa2GQEe+uPBi6pxDXfLd/31PnKw7b191NL2ePpR9E8ZNLY+WZRAEdAPY
	P4R7P3reQ1YsKwmmdRKqc186UKPU13qYt1jvZEF1D3QgzQxeCssXlw24VghwdKq3/P1eQz
	BgI3BcZ5UcZwJgHZ0JhPxlrac5n7hgxfSAbYEJEJ6Mblbn8ZMaNmxVDlxTRZNYDy5wbHuD
	u0SKSlMn1FmWwdekFADB8gB0NDzdhtODxn9VM7zqH0Vspw0t74oRkISFhW6pjxdJcAkuT2
	CoAW5rhQzRTWV89uf0gD5OuFBPjHTaOCLrAfsWabKxIwjCs1RMKeSecfZ2c2aA==
From: Xingquan Liu <b1n@b1n.io>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Xingquan Liu <b1n@b1n.io>
Subject: [PATCH 3/7] staging: vt6655: Rename function CARDvSafeResetRx
Date: Sat, 21 Sep 2024 00:20:21 +0800
Message-Id: <20240920162025.31465-3-b1n@b1n.io>
In-Reply-To: <20240920162025.31465-1-b1n@b1n.io>
References: <20240920162025.31465-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename function CARDvSafeResetRx to card_v_safe_reset_rx to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
 drivers/staging/vt6655/card.c        | 2 +-
 drivers/staging/vt6655/card.h        | 2 +-
 drivers/staging/vt6655/device_main.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index cda8ad4b3513..e25073e013cf 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -429,7 +429,7 @@ void card_safe_reset_tx(struct vnt_private *priv)
  *
  * Return Value: none
  */
-void CARDvSafeResetRx(struct vnt_private *priv)
+void card_v_safe_reset_rx(struct vnt_private *priv)
 {
 	unsigned int uu;
 	struct vnt_rx_desc *pDesc;
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index f6b462ebca51..8c1f81840972 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -51,7 +51,7 @@ u64 card_get_next_tbtt(u64 qwTSF, unsigned short beacon_interval);
 u64 card_get_tsf_offset(unsigned char rx_rate, u64 qwTSF1, u64 qwTSF2);
 unsigned char card_get_pkt_type(struct vnt_private *priv);
 void card_safe_reset_tx(struct vnt_private *priv);
-void CARDvSafeResetRx(struct vnt_private *priv);
+void card_v_safe_reset_rx(struct vnt_private *priv);
 void card_radio_power_off(struct vnt_private *priv);
 bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type);
 bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 53e3aae29a59..08e99f9b802f 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -461,7 +461,7 @@ static void device_init_registers(struct vnt_private *priv)
 	pr_debug("Network address = %pM\n", priv->abyCurrentNetAddr);
 
 	/* reset Tx pointer */
-	CARDvSafeResetRx(priv);
+	card_v_safe_reset_rx(priv);
 	/* reset Rx pointer */
 	card_safe_reset_tx(priv);
 
-- 
Xingquan Liu


