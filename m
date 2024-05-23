Return-Path: <linux-kernel+bounces-187128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1F78CCD90
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E81F1C2130B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F08013D53B;
	Thu, 23 May 2024 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TK/gv9Ba"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1B313D2B1
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451117; cv=none; b=b0xv9Lwn/h9M3FPkW4I23TZnBLjvaio6achyT74WYVxKKdQnAwstXkgfx70Y8c/TyH4sE6iZdJ/uwbolzj/q9SBQBoEQTCAD5DnBXHIvIFYL/kENdM8Q4eAI4xgKp8OH2TxKTLcw2D72FfoHAWOszgvWCi+Oqx4H33Rs0Ad89Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451117; c=relaxed/simple;
	bh=oY9pJCCB+gMDQTAUOCI57KbOI5M/HreuFbqNaMW9YWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhVbapbuPKFp0CfQ1vdz+q8fR2GQbaiT1rt02MxZ7Wx0QMJpy5egAOgSg7eHDeLTf3fOv2+kriy49z+zCJ9TcfFYtqejUXFCULrx6hqaI1rP1MjQErcU28Bu0hQJaecVYgUwwcLVscTymxwSMhAh5wnRqDlQGnMbPe1P8u+gAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TK/gv9Ba; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-420180b58c5so16504825e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451114; x=1717055914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8GG0qSUKW/QwiEfb1pXJnlM6Z5iknMteP/DubTFmCA=;
        b=TK/gv9Ba/1znMN70+vHAhjN6RiQjNI7tSNplK/LWY6Q8hlaJoVjf2pzbRI8YW9NTgB
         YbQGTguSFarzIZoVVCiGHAJtm1F4bHxtBqgYK6xjx1THBrMCzLDxhReKLU0uQQJjQoRR
         urz0zaeqdkhvOLi+w5TZ/P67U+DqEIadDPw2z70YWmAJvHg6s7xQyuuhuxgZv9N1rZoz
         Ms4C5vjpWQesLQJq8k0TMNU/29ziYuXW/4F5fmkV3fLmY3bekLVb5TYKC3MZoP4eotE6
         2wlVkqOxXT+tpsVbd0IHrNflWqbd1t3NXAxnLGrUIuwu6uvn1y9vR29ssYzAGINDcGte
         +9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451114; x=1717055914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8GG0qSUKW/QwiEfb1pXJnlM6Z5iknMteP/DubTFmCA=;
        b=MOX8XPT65L61cytg8jEZwD35qeOK/L47N9CsfPGJ7kW2MnQw/DfAcTWEE5oNkw50QP
         7yfgJGX0FEiAnkoclo8dTYl5wjpoC/6IT03RHH3ZSTsl8akA0H1HKmrKjIaOxHnXiH4B
         N9hEXsRoyGh4NjftVar2HdoWL+dbOSGPcL0WPAqNlur65k8fah6M7SLCk8p/lPwFrpbS
         YkrfNke86cQ2Zfxm9B9lFQidOBSfdJTS73GYytyXuJ90CsE+mZN467kWRO+6pbkoxD8z
         p43J4K9P0vgYD+bkhl36QQ3fHt08wVMx1dG5m4nFi02Qa7raSjcC4wONHtov2F7N9CiN
         0OVw==
X-Forwarded-Encrypted: i=1; AJvYcCURjdgUglIt7m4PJFvLgYJ2ak5rORN8+UspDxnaP0ZkpfxWcHAPx+WBEGY6SnChFMAB8yyhKpVE0jHCVIF5yPsXn6ejbLN9EfwerJja
X-Gm-Message-State: AOJu0Yz2ZvncJsPr76VboUjaOxdPdUN6vTtJ8F0JDISeYkJnoUWkw8Ds
	+yy9AHGGD6ql++H4ua7PvzbzmWb7IyqjG+wPsjif5EwshRJcFLsZx7xiuPnrOi4=
X-Google-Smtp-Source: AGHT+IHY1QA7e7M81Uch6zrTpW4SzcO290mENs1Q7433I/NCsVyGWKJ/Rr+g3fYyAhO+lvsDLKDNDA==
X-Received: by 2002:a05:600c:56c1:b0:41f:e56c:ef81 with SMTP id 5b1f17b1804b1-420fd2dcc03mr34490425e9.1.1716451113999;
        Thu, 23 May 2024 00:58:33 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f01d7fsm17359125e9.1.2024.05.23.00.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:58:33 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 5/5] serial: 8250: omap: Set wakeup pinctrl on suspend
Date: Thu, 23 May 2024 09:58:19 +0200
Message-ID: <20240523075819.1285554-6-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523075819.1285554-1-msp@baylibre.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To enable the serial driver and it's pin to be a wakeup source in
suspend to ram states, select the wakeup pinctrl state on suspend and
restore the default pinctrl state on resume.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/tty/serial/8250/8250_omap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 617a421a1396..61f056c4e78e 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1663,6 +1663,13 @@ static int omap8250_suspend(struct device *dev)
 	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
 	int err = 0;
 
+	err = omap8250_select_wakeup_pinctrl(dev, priv);
+	if (err) {
+		dev_err(dev, "Failed to select wakeup pinctrl, aborting suspend %pe\n",
+			ERR_PTR(err));
+		return err;
+	}
+
 	serial8250_suspend_port(priv->line);
 
 	err = pm_runtime_resume_and_get(dev);
@@ -1696,6 +1703,13 @@ static int omap8250_resume(struct device *dev)
 	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
 	int err;
 
+	err = pinctrl_select_default_state(dev);
+	if (err) {
+		dev_err(dev, "Failed to select default pinctrl state on resume: %pe\n",
+			ERR_PTR(err));
+		return err;
+	}
+
 	if (uart_console(&up->port) && console_suspend_enabled) {
 		if (console_suspend_enabled) {
 			err = pm_runtime_force_resume(dev);
-- 
2.43.0


