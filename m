Return-Path: <linux-kernel+bounces-230779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BC59181D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85214B218D6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986471836F5;
	Wed, 26 Jun 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDK31MoI"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDED187573;
	Wed, 26 Jun 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407161; cv=none; b=i3gwt9Q1P3xoixyfX0VOhgsSuiZ0foLBPHsHHyiYwdXDk7WmSNxDnTrnz61F860Rddi5v9Zmjk8T5jiEEq9u/8JmcLe2HSDzzapTKoKtvXf423Q/zYZyE3DpRVUAm/sIJ9KvALySASe0dNxhXNDk+UbT/f9geVynJTXKvxGI0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407161; c=relaxed/simple;
	bh=piXB7++2JIrjXnQvKW/pcn5at+5a90iuVZk/mcEDlss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFjIIHZWMl/QWHLAuN5tQk6risPdLA/exJGg7GL/dY/KSYYqD9rKwOhlUmPC10QYV83C/6438bnmRtcd6XBZX0UaCm+tRsPSQRdQzVyU+4slpUaUggZJqX65Rl5Ohsny9nirXK74OfasPlw6OVgx/cMkPau3d2Wvq8cCEQ68Vp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDK31MoI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fa244db0b2so30788565ad.3;
        Wed, 26 Jun 2024 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407160; x=1720011960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFnpTkD+iTiggxR5yfNrPNsib0iELLQcb0TdrQtKxFU=;
        b=DDK31MoIsfwhHWPw0xn8sq1nvdguywAZ2P+FrWblCitLS5CWfbbOv7WLciw5Tl8YJV
         Hr/GoeuJFxQ+mTD5q8Lf653iLnJq2sETR9VyQCEymvUzPit3KS9Q0VinKL1dldUss/9M
         WZ6LtN0cgEV3pXKaehoZ7u98+BoSlZ/1kDcTiZkHSOdJxlg4tCx7Cx5oQTTERkv9FnUv
         he/aLMRBjMKrqXOKkX2LpNlDDDFiAqT7OZzs1+zBzrKtWiSMtov/Di9RX8Cwest6YOCW
         QbOzOG7sXv6cC7lb1xJODQY1GAZkelELKmPGT/DbYCbGhBiqnhhQN4K6g/Cn/+MJwsRy
         T2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407160; x=1720011960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFnpTkD+iTiggxR5yfNrPNsib0iELLQcb0TdrQtKxFU=;
        b=XL2Pxj4uAD1i/0SLv3zlhkYYLqZkUTpmfakCNLeM1k+OH+XYQAvCheEywUVUZG/CT9
         OlnRbnNceNmm3//crTP2IvHMutg+MBKiwkox2ddm/PO4+uuKBwmfVuqy/Qgs52m3g/7e
         b2NYy1/fZVh6sfke6uzcISaIfs3QVDr0A/0B/2Z2OE+RsDveAQTFIQxlvY9q5vYd0c/3
         Q/c9kc8A3dZPIgvFC1lGJZPJiTNg5VZzifNs4h1h25VaApiDnePJ81r+tOYmHG0oTjVT
         cbhlBgtS+STEco57vIGGOJjx/vPVrTESPJRs3Z4qsGW2FymYXw1xiYwOOaN9IrzQBm9B
         puaA==
X-Forwarded-Encrypted: i=1; AJvYcCV0qa5NBTENd4V3kAChQ0PT9J5XDE0PcXvrbApRt/aQvS2Pr0/g1+lq8K1m3JzInKoXV5SxCcNhIAKV69gydMjKVs0N/jMSRZzluBX8t2I+jW78MVe0RK3HlQxDhGWmrJOEbQeRWWe2+A==
X-Gm-Message-State: AOJu0YxjraKKqhyg5k5nJciWBhiMptNjI6Wwrh6Q3l1R862pCIREDD2A
	XZ2Wc3L7cwkQGEeNzdsRMT44YNNbs2r2vlvYRGGHdk0TDnYTjZUo
X-Google-Smtp-Source: AGHT+IF0MYsNOPgWi/B2q9qWKBjg8KngP+dLJdfsLdFvkLJLv7uuoSdGL6vBY/ETaxf+BTvqzMuIbA==
X-Received: by 2002:a17:902:e88a:b0:1f7:1ae1:cd7a with SMTP id d9443c01a7336-1fa15943bfemr120975575ad.62.1719407159960;
        Wed, 26 Jun 2024 06:05:59 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:05:59 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH v1 09/17] ARM: dts: aspeed: minerva: add linename of two pins
Date: Wed, 26 Jun 2024 21:03:24 +0800
Message-Id: <20240626130332.929534-10-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Chen <yang.chen@quantatw.com>

Add linename of two pins for power good/control.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 86d319d7edcd..f41dcb36243a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -557,12 +557,12 @@ &gpio0 {
 	/*N0-N7*/	"","","","","","","","",
 	/*O0-O7*/	"","","","","","","","",
 	/*P0-P7*/	"","","","","","","","",
-	/*Q0-Q7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","power-chassis-control","","",
 	/*R0-R7*/	"","","","","","","","",
 	/*S0-S7*/	"","","","","","","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
-	/*V0-V7*/	"","","","","BAT_DETECT","","","",
+	/*V0-V7*/	"","","","","BAT_DETECT","","power-chassis-good","",
 	/*W0-W7*/	"","","","","","","","",
 	/*X0-X7*/	"","","BLADE_UART_SEL3","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
-- 
2.34.1


