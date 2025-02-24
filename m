Return-Path: <linux-kernel+bounces-528429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1571BA4179E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674FA173BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF8020C031;
	Mon, 24 Feb 2025 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt7ARhXm"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2720AF88;
	Mon, 24 Feb 2025 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386398; cv=none; b=N4b+m5RL4XDAP9SLf7jqY/IMDzf7wFj8gN/77+wJKxNt/ALmtftLONw2RmwnUZp7A+aAbfsszlJLaVkUfcTKSsyKgzhJ+bP0SkKSjIxPrwvNkUG3QVY191meCdsgUDLv+Jx5WcXg/qDHwMgmZMKUXrvc1TeGXRe2rEsVfkE3nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386398; c=relaxed/simple;
	bh=FNxmf5D7GN2aG4QMrxR+UXFyed8yl/FXkhCgriBGHag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRU5DgWcP4w6ZzaHSHUQf/YVfQdwPVBwn79hitTScvhofs7yzEIxuv9UTSmneQ+OvQvgKmhVrgW7EoNEhvYLDr64Q4pNXyrdVxxkBKC2e/7lrVaG3hR+YoYJOoOK5eb3m66OP1AQzk2WffL+w8Rc6kqcQ1sLIUlMAgcv3LSwn6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt7ARhXm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220e989edb6so110241005ad.1;
        Mon, 24 Feb 2025 00:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740386396; x=1740991196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLJZ0UdIyJvoaYBSKuZ/YiS+j0w/Er7zxoHnMzji8nw=;
        b=Kt7ARhXmGhq9Y9x+ZWlv7cj5nzHw5cFgBe2UXC40neQbdlLTyu44aJWprjYBsKD66Y
         03fXVnbm+gYTdxU0XiZEoq2BmcX04uF22/lupd4LjDafjZVGoNZ8dKI2825u6cl+WTxS
         bblsf9UfAPcBW9Uf6B5UlovdH5TDUrWlD15P40dT3IH4zDwQYk0AGQn5p4qR8EzXZkEb
         vPRnZ+NcN/tuzX7/6mnwwBQ9Fd+ikHDa1jxIzUHzYWfEcWL2l9GCI/rE5UEtslxJV9Cy
         fR36dEOW2S5MKK5il7aDJzFcq06qSBpznOP64STr/ZL/1SvDIDBWZb2EpsFfmG4kHjoE
         FxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740386396; x=1740991196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLJZ0UdIyJvoaYBSKuZ/YiS+j0w/Er7zxoHnMzji8nw=;
        b=ebdD1Y2i0IGZX6jEBOjKEIGgu/tXhNXBjst2VDMjkbmEq49r9vaNL0krL8NydFi1Iq
         p8mTgYgqsdSPEB/AJGjABsvn3RBZu0LysE6cImF+dqlYOktON/eiCen31OLopONa23jc
         mGnGp+GFdZk/90jOntMbOQd7fhaXvauTX4s8Za7eDhSouOQRwtzb5pK/ZmJCHCyhQGwc
         QB7kBDGI1Uytk4ZnPh1R/AnMi2cDf1kBOpPNrgLcvlkuM63tZm3M/0yZwSzXJ/MupnBo
         CMJ7Xv6ol7d180GNoB6yASvp0c/IVG26SjDJXzoP0fwkLkcLhRmWPOCVVszMCOb/e4Bi
         lcVg==
X-Forwarded-Encrypted: i=1; AJvYcCUPIg8gPJqlvo73UcqBbmz/eSnfj45KB8NotpSrhHsjfzV1SsZczJGlpThBo2mORx931uZfiGQtER4a@vger.kernel.org
X-Gm-Message-State: AOJu0YynoRb65v0IkgtxO5n/bOqlTJLPBwKOEPwIMOIpxhubOs9yz+Dk
	v83KHw+dKSFLIkZ6O6xOCi070wQ4WP9cK2fTj4ZjD/lDjTGf49XftW+wqQ==
X-Gm-Gg: ASbGncviTVcz6ojJhuJTB9RidOnggFlUGlJjgmAQgpml/XZ5lYQEUETi/6DrhTyWuN0
	zoKb+y+3zq83bvIBhczwny3iKRiXkgbVhBhcf9LYAJ+YizCzYcKHrOv1HalSkM2ER/pBdZlVVqH
	0dt/p80AzF+aSC6AoiAnzjo7ni/LpmE1drvufDaY3oHjqxoo9GXDHT/RgjjrDuiML5t+ohIKw4l
	Iqz7Wyp/msu6buJV4oCLVhE4foI4dl5hzPcu5jxkY6Qmitg8An9PBbWJYXaWAZJrRkI5nQlixuW
	n9gFXsg1bv07UBGm0HXovUnkTvCXQHcBAk6r
X-Google-Smtp-Source: AGHT+IHmzcYOYpmi88RS8NVpMCYxjPv8F2R9zaGHSVBGMM+f8o94gQg8TxLc4zMuEg1JgPNRviBc3w==
X-Received: by 2002:a05:6a20:a107:b0:1ee:e641:ca8 with SMTP id adf61e73a8af0-1eef3cd44cdmr22835172637.20.1740386395705;
        Mon, 24 Feb 2025 00:39:55 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:cd02:bc36:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327590ff12sm14634793b3a.115.2025.02.24.00.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:39:55 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 4/5] i3c: master: svc: Fix npcm845 invalid slvstart event
Date: Mon, 24 Feb 2025 16:39:07 +0800
Message-Id: <20250224083908.1880383-5-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224083908.1880383-1-yschu@nuvoton.com>
References: <20250224083908.1880383-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

I3C HW may generate an invalid SlvStart event when emitting a STOP.
If it is a true SlvStart, the MSTATUS state is SLVREQ. Check the
MSTATUS state to ignore the false event.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 07506ae0f914..4eb4b8888725 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -59,6 +59,7 @@
 #define SVC_I3C_MSTATUS      0x088
 #define   SVC_I3C_MSTATUS_STATE(x) FIELD_GET(GENMASK(2, 0), (x))
 #define   SVC_I3C_MSTATUS_STATE_DAA(x) (SVC_I3C_MSTATUS_STATE(x) == 5)
+#define   SVC_I3C_MSTATUS_STATE_SLVREQ(x) (SVC_I3C_MSTATUS_STATE(x) == 1)
 #define   SVC_I3C_MSTATUS_STATE_IDLE(x) (SVC_I3C_MSTATUS_STATE(x) == 0)
 #define   SVC_I3C_MSTATUS_BETWEEN(x) FIELD_GET(BIT(4), (x))
 #define   SVC_I3C_MSTATUS_NACKED(x) FIELD_GET(BIT(5), (x))
@@ -618,6 +619,11 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 	/* Clear the interrupt status */
 	writel(SVC_I3C_MINT_SLVSTART, master->regs + SVC_I3C_MSTATUS);
 
+	/* Ignore the false event */
+	if (svc_has_quirk(master, SVC_I3C_QUIRK_FALSE_SLVSTART) &&
+	    !SVC_I3C_MSTATUS_STATE_SLVREQ(active))
+		return IRQ_HANDLED;
+
 	svc_i3c_master_disable_interrupts(master);
 
 	/* Handle the interrupt in a non atomic context */
-- 
2.34.1


