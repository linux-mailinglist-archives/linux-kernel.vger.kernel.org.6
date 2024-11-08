Return-Path: <linux-kernel+bounces-401406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF69C19DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA311F238FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497901E32BE;
	Fri,  8 Nov 2024 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bbXM2JCt"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC21E32A9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060335; cv=none; b=Wfx9XuDTlrU44smqrqYnIUSp6F+OuS5+eCMGIQ9lOOA0BejWc+xiohjDwliK+fWnQjSrBAWbmlCyfRdtMs/nc6U3ee5JFDC9cZwQal99a9DY/OkywSSS2anwn6SE/6CAbrLTzXmHejmwo4Jj8KGz3qGmhkxiGvYGoUKD7zlZyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060335; c=relaxed/simple;
	bh=lcygwh3550pPn64SykAxI6BIRpZfeGHnBRvuudqjPH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3oguUIeehpFJdCVu6WtAPde3GRuev4Aq2alqjrTa5R28DcqtAX/6rm3xXGT8UpQE6wRahpzKQTHyKZOB1KW4gnA55lwbc3iKnDup5GmkfSoCcMxWiJVy2eEyu+J73mRdU5JKC/Pd79BzUNBR4fh9RV3uZEU8SanQaydu8CunJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bbXM2JCt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso2822541a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 02:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731060331; x=1731665131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UgVcphiVOuFJ6tnSyNPwX0ATDeT+8R4Pfh6Dj6lnCM=;
        b=bbXM2JCtwbNQeHMcEo2yj5RrYl5nbaXaahDvhPzHGfyHt+HpgeEZirksMR75assJd0
         x54lLQwfNJQ2aq3SCN+Hd9Xt1U+skR9OZCOxT4MpEgcEEogI2IGGM1FM3Zv9cad2hCq+
         x7GT2qjLZ1wRTLGMdgaWPc3tCu1xyo+yS6GMcezn7FdiUMwAqLziIsJumb1sQNIngOmP
         VIQOZRjniledbUU46NyzO5+of7MUe7sHzvSbRV+4V3PxIybs1V1qDoyisMlAe/74UuNl
         z69gnhNiMTKO4l7aYwqFbchCZe4TU40LXDxoCVGDr0CgPelESgUVxDyT1h/7BC3PbMsJ
         ZmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060331; x=1731665131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UgVcphiVOuFJ6tnSyNPwX0ATDeT+8R4Pfh6Dj6lnCM=;
        b=OsfBEQwFGE50jwaOxOJUv37GAVvMeEBm4ashkOzexhoXXx44tp7mZhO9NAncfCPV3B
         lVTggy/hojsDkf2l/LS6C6b5P7Kt9+YIQ8IxwiIRMm/SPqGcgVNqTPjjhjra/kAtR+fH
         cJH7hEWBis3ene4UAoFYRu1KiFC4GOfikN+XhkvBmEyrXtn5Ns9QhKBb3Kd4ZNum0VEV
         fz61geTC/ZR2fuy7EGrz1gzJeVQb/6r+9ldsvthsDDatlt+UU9LKlHYzqzJfertotGPP
         KG57nAtNnzkTVyq5v3A3IWqNycaXz9c7tnmRAtU60Vf1ZFBmUWIPbMFrp68yJtbd+xRM
         fNHg==
X-Forwarded-Encrypted: i=1; AJvYcCWfzvKoxN0EHqnPDL9UOmWXMy+i+LgAaAzRcLXN5sxBYADvKMdE2lo7Nyl4CWsW8U85ACmIkd2koUA+upc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgXhrQyRUD1Et3zMpjVLDrd7fTLITSSOyUIjIWDuPj7fCM9LrN
	UcxYjqig0AeDwErhVmitYb9WrVezMYTpdrG6kNvp3b1M5sNiXbuJNlfWTWNoZME=
X-Google-Smtp-Source: AGHT+IEIbaNJ/2qJlKbRq2+UYAJQotJwd3ym5vPjWrZ7SU0hZA/MKtPGKhh1Q+c1ptQ9q0UD3XH4mA==
X-Received: by 2002:a05:6402:4416:b0:5c8:9615:3e32 with SMTP id 4fb4d7f45d1cf-5cf0a325cf9mr1507654a12.18.1731060331122;
        Fri, 08 Nov 2024 02:05:31 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4f0bdsm1775959a12.56.2024.11.08.02.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:05:30 -0800 (PST)
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
	g.liakhovetski@gmx.de,
	lethal@linux-sh.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 3/8] serial: sh-sci: Update the suspend/resume support
Date: Fri,  8 Nov 2024 12:05:08 +0200
Message-Id: <20241108100513.2814957-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241108100513.2814957-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241108100513.2814957-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S supports a power saving mode where power to most of the
SoC components is turned off. When returning from this power saving mode,
SoC components need to be re-configured.

The SCIFs on the Renesas RZ/G3S need to be re-configured as well when
returning from this power saving mode. The sh-sci code already configures
the SCIF clocks, power domain and registers by calling uart_resume_port()
in sci_resume(). On suspend path the SCIF UART ports are suspended
accordingly (by calling uart_suspend_port() in sci_suspend()). The only
missing setting is the reset signal. For this assert/de-assert the reset
signal on driver suspend/resume.

In case the no_console_suspend is specified by the user, the registers need
to be saved on suspend path and restore on resume path. To do this the
sci_console_setup() function was added. There is no need to cache/restore
the status or FIFO registers. Only the control registers. To differentiate
b/w these, the struct sci_port_params::regs was updated with a new member
that specifies if the register needs to be chached on suspend. Only the
RZ_SCIFA instances were updated with this new support as the hardware for
the rest of variants was missing for testing.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- rebased on top of the update version of patch 2/8 from
  this series

 drivers/tty/serial/sh-sci.c | 53 ++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 65514d37bfe2..efac65bb8809 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -101,7 +101,7 @@ enum SCI_CLKS {
 		if ((_port)->sampling_rate_mask & SCI_SR((_sr)))
 
 struct plat_sci_reg {
-	u8 offset, size;
+	u8 offset, size, suspend_cacheable;
 };
 
 struct sci_port_params {
@@ -134,6 +134,8 @@ struct sci_port {
 	struct dma_chan			*chan_tx;
 	struct dma_chan			*chan_rx;
 
+	struct reset_control		*rstc;
+
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	struct dma_chan			*chan_tx_saved;
 	struct dma_chan			*chan_rx_saved;
@@ -153,6 +155,7 @@ struct sci_port {
 	int				rx_trigger;
 	struct timer_list		rx_fifo_timer;
 	int				rx_fifo_timeout;
+	unsigned int			console_cached_regs[SCIx_NR_REGS];
 	u16				hscif_tot;
 
 	bool has_rtscts;
@@ -298,17 +301,17 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 	 */
 	[SCIx_RZ_SCIFA_REGTYPE] = {
 		.regs = {
-			[SCSMR]		= { 0x00, 16 },
-			[SCBRR]		= { 0x02,  8 },
-			[SCSCR]		= { 0x04, 16 },
+			[SCSMR]		= { 0x00, 16, 1 },
+			[SCBRR]		= { 0x02,  8, 1 },
+			[SCSCR]		= { 0x04, 16, 1 },
 			[SCxTDR]	= { 0x06,  8 },
 			[SCxSR]		= { 0x08, 16 },
 			[SCxRDR]	= { 0x0A,  8 },
-			[SCFCR]		= { 0x0C, 16 },
+			[SCFCR]		= { 0x0C, 16, 1 },
 			[SCFDR]		= { 0x0E, 16 },
-			[SCSPTR]	= { 0x10, 16 },
+			[SCSPTR]	= { 0x10, 16, 1 },
 			[SCLSR]		= { 0x12, 16 },
-			[SEMR]		= { 0x14, 8 },
+			[SEMR]		= { 0x14, 8, 1 },
 		},
 		.fifosize = 16,
 		.overrun_reg = SCLSR,
@@ -3365,6 +3368,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	}
 
 	sp = &sci_ports[id];
+	sp->rstc = rstc;
 	*dev_id = id;
 
 	p->type = SCI_OF_TYPE(data);
@@ -3492,13 +3496,34 @@ static int sci_probe(struct platform_device *dev)
 	return 0;
 }
 
+static void sci_console_setup(struct sci_port *s, bool save)
+{
+	for (u16 i = 0; i < SCIx_NR_REGS; i++) {
+		struct uart_port *port = &s->port;
+
+		if (!s->params->regs[i].suspend_cacheable)
+			continue;
+
+		if (save)
+			s->console_cached_regs[i] = sci_serial_in(port, i);
+		else
+			sci_serial_out(port, i, s->console_cached_regs[i]);
+	}
+}
+
 static __maybe_unused int sci_suspend(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
 		uart_suspend_port(&sci_uart_driver, &sport->port);
 
+		if (!console_suspend_enabled && uart_console(&sport->port))
+			sci_console_setup(sport, true);
+		else
+			return reset_control_assert(sport->rstc);
+	}
+
 	return 0;
 }
 
@@ -3506,8 +3531,18 @@ static __maybe_unused int sci_resume(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
+		if (!console_suspend_enabled && uart_console(&sport->port)) {
+			sci_console_setup(sport, false);
+		} else {
+			int ret = reset_control_deassert(sport->rstc);
+
+			if (ret)
+				return ret;
+		}
+
 		uart_resume_port(&sci_uart_driver, &sport->port);
+	}
 
 	return 0;
 }
-- 
2.39.2


