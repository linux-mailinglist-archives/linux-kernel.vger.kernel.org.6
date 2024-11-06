Return-Path: <linux-kernel+bounces-398163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132C09BE6A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6486281137
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5431E1A28;
	Wed,  6 Nov 2024 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="i6EBt7lA"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A351E0DA1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894506; cv=none; b=SaXakpNeEPqUFxEnph+mW5Qp/VeQkpcM1Jb6R5W9qNXrgIFCJtZ03ulXJ7Mx64AEmmJhkk1acoOBdZqVuQU/Uy73y5C/D0ryyh01RDi3HfBYNbfkTSHKMChHxpZjIb1hZslgEr2UENNY6cPtMnd/UVWsy0uj9sOSXTlzqFwY/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894506; c=relaxed/simple;
	bh=gkZYPsH/vb3WY/1lIzQ8Dj4FgRmceTUwrzbmFMLCPH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFy571EnZi8LVzORypj+A7u+z8VbI0X8D7cw0YzgTl8RdEXSCp1Cnk1uymjF/Cl4c6mMJufOqg/TCan4lVLlrYuw32kwZtQNpfKAIgxRcgmZtYMkJMLUgQkiXtx8ICEITXXEOvnzBgxy76raB2iJWum/ugcYDGa57l1SvQZgMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=i6EBt7lA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so1433749a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 04:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730894502; x=1731499302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTk49kg3sxHgDomjJGsue14cSnQ2z3PLgvI6znyFaQc=;
        b=i6EBt7lACXMMBbi5Okt4M1bwae2aWgrwLVTy06xOgSmOUy9IPLmAnBayrwEkDz7ti+
         m6Fn8OOb3z+s/WlLSscFh7J+MTBG/WMmKA6DfzbxLJWXEO0l/wz9WgYTPEMt/WKvLkAp
         FTQGlkI5czhRl1iOb79WgJOkfxBifDQrpou8T9A6ZzSP/BXEz+iDrUxW9kwfdl2CV9Pt
         z5bRSYOAmfW65k55uRi1E69Ynv7lTyNioLIEkV8qq2IW4l8alEwuJ6a9dKRi566NwcB5
         pvgFikqFs81bbqezshEylIXnbDOkJotcTCSyaIuhZ8EMMRheyhxYLdA08Bo15wA5v7BD
         axbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894502; x=1731499302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTk49kg3sxHgDomjJGsue14cSnQ2z3PLgvI6znyFaQc=;
        b=i1YCi0kTiRqBFcQW7sjnStK9lNZecCKjLJs2L0FbUTrKPKbuPl9ZEceBW92FY2cf9i
         ogPtrPXCY6ieq+7Qw2HWOMv63jDLcIld3uzxNw5cP7F2tIiYQ346ez7IhWNlnP9+OF5p
         RSktW4ETQHeDJkuMZ679YOPGvlhhskZ7Li1GBXePR+S4DO3o42zIiGqA78pjAuT6F/Rr
         6yeUQDVJ8zPZBdYue8RtxNa4Lyp/6ajmk4ag679pTuxqQ9V+oboR2paEGMHi/6z9xbOq
         Q7EH+sSR5h6X8BScRk0KXN8Uf9lTJrxs92ZQzbVu/vFMG37FBEzt0n9K0Wd3aFxxbUP1
         spiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI6b7sFY3xzMN+2WDJPrc8f3ZkW1hONlUOFoWJnJRpxX1qeOgmUTlInhzWET8htMB/kMFDL4iXL5zcaV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymgxthGfdrLjFB7Q/QcXyTs/bhEBY0ui0x3D5tUOR+CrL9CbiY
	SzAjV8UK/Yw5TrS+Xmx3SORFK3z/xb9Z5v0ua9gOWbZ9IMmIxeA9CANtgqd+Xvk=
X-Google-Smtp-Source: AGHT+IGsGf47lgcF/WyQLx8YrH90sARYpGTUy3Y4l7vmameX6vDncBFwbLkpZsYyaEeHNlLQDhUJbQ==
X-Received: by 2002:a05:6402:5383:b0:5ce:c940:5182 with SMTP id 4fb4d7f45d1cf-5cef54d1a82mr2310638a12.11.1730894501685;
        Wed, 06 Nov 2024 04:01:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6afe528sm2697984a12.55.2024.11.06.04.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:01:41 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de,
	ysato@users.sourceforge.jp,
	ulrich.hecht+renesas@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6/9] arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
Date: Wed,  6 Nov 2024 14:01:15 +0200
Message-Id: <20241106120118.1719888-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The debug serial of the RZ/G3S is SCIF0 which is routed on the Renesas
RZ SMARC Carrier II board on the SER3_UART. Use serial3 alias for it for
better hardware description. Along with it, the chosen properties were
moved to the device tree corresponding to the RZ SMARC Carrier II board.

Fixes: adb4f0c5699c ("arm64: dts: renesas: Add initial support for RZ/G3S SMARC SoM")
Fixes: d1ae4200bb26 ("arm64: dts: renesas: Add initial device tree for RZ SMARC Carrier-II Board")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 -----
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi     | 7 ++++++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 2ed01d391554..55c72c8a0735 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -43,11 +43,6 @@ aliases {
 #endif
 	};
 
-	chosen {
-		bootargs = "ignore_loglevel";
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory@48000000 {
 		device_type = "memory";
 		/* First 128MB is reserved for secure area. */
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 4509151344c4..33b9873b225a 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -12,10 +12,15 @@
 / {
 	aliases {
 		i2c0 = &i2c0;
-		serial0 = &scif0;
+		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
 
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial3:115200n8";
+	};
+
 	keys {
 		compatible = "gpio-keys";
 
-- 
2.39.2


