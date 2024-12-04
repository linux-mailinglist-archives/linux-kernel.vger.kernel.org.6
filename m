Return-Path: <linux-kernel+bounces-431569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D089E3F9D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93774B26440
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A699C215F5C;
	Wed,  4 Dec 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jsPFp6Cw"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B152144C6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327902; cv=none; b=e2fuD34YdGm5jyGEqzU3ux2QqqLkpiff0dI5VQgSRFduesfw6XX4yJWnJDdqxqAEo5hWrwG2/hqyUWoGo7IKMhAl2JlWSJIDusDmXnkdVPiCHjC9yWA/oQahKkx7+tjcl5qdEqbTLoWn7oQEsYHEh6hFczAd1kw3KFCxZNHrBTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327902; c=relaxed/simple;
	bh=ZT/xdjFLeWNNlsrj3Ue+9kz2Tfvcw+jWnO0VG76SBPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BP+jIvP5UKOuxp6JR5lZ9E5NqFj6Pfk+vu6Fc+z5dC9q2I3thO+eiTpR46wktJvx5lJYUaM6/cFjAlhYCNTGkYJy48S9kvOFk6iFLOjr9ImcI8ed8mkFoN4iecVw4JBJPMJLMsPrCuxaKHiwV4D+8iR2tBmDUJjERZoklec55Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jsPFp6Cw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a044dce2so85314225e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 07:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733327899; x=1733932699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iw97V1HkeTfD3TObMHDloJkcKAuf8zzJLrBo8Fp9hAs=;
        b=jsPFp6CwqnKs6uCZj8RfZB4mh0xEeb//7c9XjOdsA1BDzN9VodpgLMN2ZosSzFum0/
         Zh/lGILkVfTCf8WCcNyqAlTQRsUJjQVbkCcpVhQCfNwudGaX3SE+7ux+3iICm8I6YkyD
         60U9RE/5CsWtjqsN0xQH+vevlKffzMMRlww0M47K0rdI4CVaT/erh/imD7V7XhqjqZci
         XKXSPM995v3aVclBenxpH88qx9REPXjU3UI5o/WKYMDQBMWl2uL+l5nRQKoO8IeCYocl
         bOUGPLtPDr5KC8pF2TPZXcK8VLeOzczMMfpO5AwuIvPzr49Y5tOVuVx2smAp99f4vKIG
         lEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327899; x=1733932699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iw97V1HkeTfD3TObMHDloJkcKAuf8zzJLrBo8Fp9hAs=;
        b=dJxINtPSAOCjFEqvrElr83cPveV9nP/jtQVHGmSboMQM1D5sNM1PTifmKvXSkq1RFS
         X+kzs4LvXkpIzCGm08Uti+P6daICViHopqEtvaO0ZURoAQSDn1xC8ZCIM0JxrygL4xtX
         iH2+a1+mTpFpboqKfOAM1GTvF1kCCSkPxgTsaWOAaG95aotXeCl8p7XKha02ND5wy+Uw
         f0K0sYQ31J9Q/lpHNM0EPJ+RuB557n4ig1GjMiq46B38Ar34F6vya6vIBqcKrt2gcebl
         Dl8FMBSxgFgCSgUGYn8aPzPBsMyw0J/ExqdvKv7hTKCLAclMf5p4X+qfg7sXx7ES1pBB
         fHkg==
X-Forwarded-Encrypted: i=1; AJvYcCX8gDiUlT5pG9ZR2Ky7foH/EPuMfMR3+7VwGpFDMP2UBGbx1I9g6ednUw/DS0p/OwUvRasKOHzHLs455fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw74Cz4AysRcVO1a8J5jiE57seJ9YIWAue/kw5sJDRTxq6/tdzt
	a+X4ZzUxrt1uEcbIrZweUXm3kwlhl5W5v7k2jpyS/BomvdfOY4pMg3euasaIRG8=
X-Gm-Gg: ASbGncs6mGR++YfJmYanBfXTmfD3p1fcuQ7eGD19itn5fJRq5QDfCB87aKAzWt5UI/1
	y1aTRHEl7nBrKnYSswR9e9q0XsCszG9RNOkn3bcUSYOmsV7jUAtyqUuSNmpFTvrowtWxJXXPirK
	jGhjTEZjX5QW3OIyHoPVjZ23ef3AUM+BheSXocVIeDZm5iHs7ET+DfUPVaLg1zhGN2U/gKUMIvC
	xxfxsbSqVF2nrkUGdkNQKlm328cvehbPxii8x9sQnEgsKYszSaHFG3FSJxsiSyAsvNLwLvi9fm7
	oi4O
X-Google-Smtp-Source: AGHT+IEdO01rXNTKKymFk0tOKPPstS1yxCCBYj396aNVH1MZSrtaciEZJPkmPj7/r7/fpuguB+UslA==
X-Received: by 2002:a05:600c:4593:b0:434:9ec0:9e4e with SMTP id 5b1f17b1804b1-434d0a28531mr77312675e9.30.1733327899104;
        Wed, 04 Dec 2024 07:58:19 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52b5677sm29043695e9.37.2024.12.04.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:58:18 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	wsa+renesas@sang-engineering.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de,
	groeck@chromium.org,
	mka@chromium.org,
	ulrich.hecht+renesas@gmail.com,
	ysato@users.sourceforge.jp
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH RFT 3/6] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Wed,  4 Dec 2024 17:58:03 +0200
Message-Id: <20241204155806.3781200-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Relocate the runtime PM enable operation to sci_probe_single(). This change
prepares the codebase for upcoming fixes.

While at it, replace the existing logic with a direct call to
devm_pm_runtime_enable() and remove sci_cleanup_single(). The
devm_pm_runtime_enable() function automatically handles disabling runtime
PM during driver removal.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4f5da3254420..373195995d3b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3056,10 +3056,6 @@ static int sci_init_single(struct platform_device *dev,
 		ret = sci_init_clocks(sci_port, &dev->dev);
 		if (ret < 0)
 			return ret;
-
-		port->dev = &dev->dev;
-
-		pm_runtime_enable(&dev->dev);
 	}
 
 	port->type		= p->type;
@@ -3086,11 +3082,6 @@ static int sci_init_single(struct platform_device *dev,
 	return 0;
 }
 
-static void sci_cleanup_single(struct sci_port *port)
-{
-	pm_runtime_disable(port->port.dev);
-}
-
 #if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
     defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
 static void serial_console_putchar(struct uart_port *port, unsigned char ch)
@@ -3260,8 +3251,6 @@ static void sci_remove(struct platform_device *dev)
 	sci_ports_in_use &= ~BIT(port->port.line);
 	uart_remove_one_port(&sci_uart_driver, &port->port);
 
-	sci_cleanup_single(port);
-
 	if (port->port.fifosize > 1)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
@@ -3425,6 +3414,11 @@ static int sci_probe_single(struct platform_device *dev,
 	if (ret)
 		return ret;
 
+	sciport->port.dev = &dev->dev;
+	ret = devm_pm_runtime_enable(&dev->dev);
+	if (ret)
+		return ret;
+
 	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
 	if (IS_ERR(sciport->gpios))
 		return PTR_ERR(sciport->gpios);
@@ -3440,7 +3434,6 @@ static int sci_probe_single(struct platform_device *dev,
 
 	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
 	if (ret) {
-		sci_cleanup_single(sciport);
 		return ret;
 	}
 
-- 
2.39.2


