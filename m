Return-Path: <linux-kernel+bounces-344906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3233998AF7A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4979282DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5AD187352;
	Mon, 30 Sep 2024 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqq4Hzh7"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF6B1865EE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733578; cv=none; b=bwjcX5+oizQLVz/LKcgHMQuGrYYxnpWo6UN+ZUUZ5yvxUf8M/o14U79JYTX7JzWXW8pTvBbRLW+xgb9ypzbT93hpb/H301/Wob7v2dfqHTAwMi4N5SjDNeHHiNH3ssxX1ZcDfBgCA8eIb7auh563kJAAQCIl3jO4a4o8lffADqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733578; c=relaxed/simple;
	bh=QjiHZyWsJoMUQvAjheYOPLQy2BEzi+DjKW9LlNMVaC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5H4IxzyJhepiaGENrztu7nH2b/bqrlz1Gc+jQPb+1vsQ69ObMjCfFUH5b+1wDvzHtjrvzbM3aM/qcX0xiUHAKHgyHPAKi1cHF9pKP69rd584fi9hzRwenGbcKETQUbTBJpj1E4tHLmShnF4jXexkmHy90/SkrN1OpeSp+6vPTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xqq4Hzh7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718d704704aso4061240b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727733577; x=1728338377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8lj0dfqyPPvWHebEmTfcImeYIRwlGH+HAdhUNWftjs=;
        b=Xqq4Hzh7mDoABP7KGuv/7nwB2Opm04iKlHUuBw0ZLLjXOK7DamFGg0Z98PEnmSNHwQ
         mM8He4JkFlYuBos9tZ7oNTMQzZ3dOPdSkYquYC2CcSsgUD34aROqkBXSQPz1lPf4qgx4
         rUbQFhsbQMrYKtG62rL3rKdaV/UdynMZRIqd1tvVj2OLDOzWn5KAVJyIfbmxtlISJmLj
         /AmoIyrVTJ/3+mI1jX0nXF2fYpO9rq5hNyWlsEmWjPllukCXxub6/LFlOs2zn5zZxDXz
         WeB37ToCuLkmeoBFKya7TFjqDuE1bDJ0CMTEdEGC0SJ8hCzjhTmMt5eTrzjM1uJVJAga
         qJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727733577; x=1728338377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8lj0dfqyPPvWHebEmTfcImeYIRwlGH+HAdhUNWftjs=;
        b=YQUwZNe6Lfc/WeQfmJY81T4yQb7vvpP8ctlZKwfbCOp1TLRMyqJuNyONLT2QvJ+mSe
         +7deC8RQtaKnWmISyrQmZ9tEKsZZp9tjZCoQ1flsHxwchEQLvYRSEqORWhS054/abZv6
         O6G9OYOS6mFFvbOFIR+55A+8oSXqxc0+Dy4OqNyc2XHxzWr3auQIaKazGNoMFWbyf8KI
         wuJTi6XbW9s/FV9LBTm4dYPV69AAXM6zbblAH+Izii7n7kMSib6qD3NAw8syeSKnpLjd
         y2sqy7g1FhtvspU69V7kDXzGvfpK8rVtmNVeS9rYkddWK+mOxNBCPiowXYdA64ghzOYe
         VUBw==
X-Forwarded-Encrypted: i=1; AJvYcCWRTZQr9PzcNi4sHev2MLqjDMKHkwUeH8z1gif3EJmQYm55TCrXH1j7Ghp4bP7ZWwsJFhSnvE2LdYwSulg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Z5bg8ctjUP4lr35WwErpFaN4wFg9UuN200FmrWPURRMfpMHO
	VR0uKg6M5Qc+54bSWbsslizejG8W6nqSAZz+wu1tK8MAkv6b/+Km
X-Google-Smtp-Source: AGHT+IGKsg4OsP+n4AvNB7ctmpO6LHFL2OlNBf/sZi+dH08XeZM9kPUPnH7R/0ZbqDt13tYgfRQ9Dg==
X-Received: by 2002:a05:6a00:3cce:b0:714:2533:1b82 with SMTP id d2e1a72fcca58-71b260776d3mr23076022b3a.23.1727733576696;
        Mon, 30 Sep 2024 14:59:36 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26529d61sm6961024b3a.171.2024.09.30.14.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:59:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arch: arm: kirkwood: support nvmem mac address
Date: Mon, 30 Sep 2024 14:59:34 -0700
Message-ID: <20240930215934.349238-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_get_ethdev_address gets called too early for nvmem. If EPROBE_DEFER
gets called, skip so that the ethernet driver can adjust the MAC address
through nvmem.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/arm/mach-mvebu/kirkwood.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 73b2a86d6489..da347f66900b 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -86,13 +86,18 @@ static void __init kirkwood_dt_eth_fixup(void)
 		void __iomem *io;
 		u8 *macaddr;
 		u32 reg;
+		int err;
 
 		if (!pnp)
 			continue;
 
-		/* skip disabled nodes or nodes with valid MAC address*/
-		if (!of_device_is_available(pnp) ||
-		    !of_get_mac_address(np, tmpmac))
+		/* skip disabled nodes */
+		if (!of_device_is_available(pnp))
+			goto eth_fixup_skip;
+
+		/* skip nodes with valid MAC address*/
+		err = of_get_mac_address(np, tmpmac);
+		if (err == -EPROBE_DEFER || !err)
 			goto eth_fixup_skip;
 
 		clk = of_clk_get(pnp, 0);
-- 
2.46.2


