Return-Path: <linux-kernel+bounces-431570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D925A9E3F0D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4277D169B3C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65342144A9;
	Wed,  4 Dec 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fiIZOhJ7"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC620FA95
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327905; cv=none; b=P1bCKNXJmUJLOXPMGAMEdhTJe43PEpD0pFu9zLmYF0q1amdQRD+hRREgq3j55nWvIcAtmkNGIvYfFxwr/0qgsf2ChQ77uAAjWfWIui45tid7mYg2ThkbjYzV5CzZym63IhYa27Gw6QuX0LP4AJcwgxvXo/S+dY5QATDu2z80ak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327905; c=relaxed/simple;
	bh=hNvsm/KT1uK/VLwkIurCBjMDay2qykQ05TtUGaANs+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pvJzsfX8krGbm4Wz/PcVtxzCIqlgj8VazMu1etk9z/oDuGsEb3kzQ36Rt3hUWG2gSTZgemA8r9clB/MFbNb1rzywnY6qe1+70HWtLx9oyVh7IMo1lxQyxr/IW4Qo8Un1SRlNznwea1jomCuINEQfvWaVT3QoyKg05Y79m8+D6Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fiIZOhJ7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so6916045e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 07:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733327901; x=1733932701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msXpgYS9tLSNaLykc7vmvtR+isPm7EdibA54ABrXSEE=;
        b=fiIZOhJ7KmDtdtTA+WeVKNQVv1bsOOBhNYD1GChO0mqb6pTVjfOaPRXxiW7Hcg8q8Q
         i+zukxqcqaX0bEMOrTZRfUW1XOzhyjOPZHzzNFVe+DAmsn9LppsHGynV6EvfDQhov4vQ
         r6dzIxFbg2gQR23phrY1Ea0GDOyg5WbbMjbVPNfaXupA3Z6XIVL4arH7rrYQch4A5JP+
         iS7LHfV0Rayz0/ef2VSIEbEc19be9OdF7+auwTz8aFjXS+sI1WNor4YM//Ya7sDwfPWM
         edfxmf15ig6gmXz70C9k1BmEqWAJ2xvWzslRgdRAR7h1ntiBWbum4InWFIk7jkx3+bhy
         TngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327901; x=1733932701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msXpgYS9tLSNaLykc7vmvtR+isPm7EdibA54ABrXSEE=;
        b=C5K/4XTWnZQ7rEWXfYn60anPTbjknew3mt9raGAHXWXatCNdvV+YFcwa22cEldjxf1
         vJciEbQftwd7U3QwShhAlgzocSVDfsdBzyM6gGiPAhOLkPZr1UG4yOVjDR4u45l/HWJh
         MFHkPr4wwPZvx6T6Q2B0l5ISWOowI5yl/lSyiwaqBi77J8N5wSszBsQs2rh6b0AUt5AU
         iY5aSgSWrsArWbC+AN6lPGbar6rH5jGeZLqdihlt4FRXT1HIMISMr6J6K498wf/xV6Ea
         P3SzRX+0BG+ZGyATnmsa2ZRq9nSt5+Rx0F5DgEprIGkUJ12ol3ePdjeP3/hCPZiwf21x
         iiKA==
X-Forwarded-Encrypted: i=1; AJvYcCU/6FCiat5Tx5T7B/YKOwXPuxYB1kD2Hkgs4Xtf8jJqy2rFC1hTgVhrKhkHhkjY4Gb6fM2FCdTTFfu8IOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwiyZclyCgBX/DJLR+Pfzvrb0YFNWd/LipzUqFoOiaIz5rfau8
	XNKtnmZ4rco5GnSRfS36OhuwjrUjBAPu8Zh/3WdxAP/Jzuszkj3ZJnP2OaX4H0U=
X-Gm-Gg: ASbGnctMWtxNnR3teWTnUtxTJfRtv/qxNc0/l3DKqvq01VbnLuXdlDpaHVtudVT8wRw
	mME9J+tkf0IDohDZcucjVHqyPFUxy7wqqfd6sXkppGNJiMZoRVS0dWL/71WibKrCEzfT53cPD9O
	oiP74AX4MmIb4gghtatNmhlQTHKhPtDKNADFXrY/f1RCyVD+e2DdYW1mEVaAeOiyPoPQxq6pL8M
	jA61q1DW1VmPiTxKyVNyzSQWegogCgsYb8oeDlhTYLHwIv5Ea990WBUvsSRNn4i6NytPVj71nSB
	i1zD
X-Google-Smtp-Source: AGHT+IFwVNe09WNHkBY2H/LBD9xqPexC52/hSNnEpjHiB9kAbrM0T8XCJhvLvde3Ex8EWBQKVsNWLw==
X-Received: by 2002:a05:600c:1989:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-434d0cb158dmr52971695e9.0.1733327900709;
        Wed, 04 Dec 2024 07:58:20 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52b5677sm29043695e9.37.2024.12.04.07.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:58:20 -0800 (PST)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH RFT 4/6] serial: sh-sci: Do not probe the serial port if its slot in sci_ports[] is in use
Date: Wed,  4 Dec 2024 17:58:04 +0200
Message-Id: <20241204155806.3781200-5-claudiu.beznea.uj@bp.renesas.com>
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

In the sh-sci driver, sci_ports[0] is used by earlycon. If the earlycon is
still active when sci_probe() is called and the new serial port is supposed
to map to sci_ports[0], return -EBUSY to prevent breaking the earlycon.

This situation should occurs in debug scenarios, and users should be
aware of the potential conflict.

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 373195995d3b..e12fbc71082a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -158,6 +158,7 @@ struct sci_port {
 	bool has_rtscts;
 	bool autorts;
 	bool tx_occurred;
+	bool earlycon;
 };
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
@@ -3443,6 +3444,7 @@ static int sci_probe_single(struct platform_device *dev,
 static int sci_probe(struct platform_device *dev)
 {
 	struct plat_sci_port *p;
+	struct resource *res;
 	struct sci_port *sp;
 	unsigned int dev_id;
 	int ret;
@@ -3472,6 +3474,26 @@ static int sci_probe(struct platform_device *dev)
 	}
 
 	sp = &sci_ports[dev_id];
+
+	/*
+	 * In case:
+	 * - the probed port alias is zero (as the one used by earlycon), and
+	 * - the earlycon is still active (e.g., "earlycon keep_bootcon" in
+	 *   bootargs)
+	 *
+	 * defer the probe of this serial. This is a debug scenario and the user
+	 * must be aware of it.
+	 *
+	 * Except when the probed port is the same as the earlycon port.
+	 */
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	if (sp->earlycon && res->start != sp->port.mapbase)
+		return dev_err_probe(&dev->dev, -EBUSY, "sci_port[0] is used by earlycon!\n");
+
 	platform_set_drvdata(dev, sp);
 
 	ret = sci_probe_single(dev, dev_id, p, sp);
@@ -3568,6 +3590,7 @@ static int __init early_console_setup(struct earlycon_device *device,
 	port_cfg.type = type;
 	sci_ports[0].cfg = &port_cfg;
 	sci_ports[0].params = sci_probe_regmap(&port_cfg);
+	sci_ports[0].earlycon = true;
 	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR);
 	sci_serial_out(&sci_ports[0].port, SCSCR,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
-- 
2.39.2


