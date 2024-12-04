Return-Path: <linux-kernel+bounces-431167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3519A9E39E1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104051649CC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652121C3F2C;
	Wed,  4 Dec 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K68BP3xO"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51531C07D1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315232; cv=none; b=dPiuGWLtsSa2JJ+/2K7NwWGhk7J+qZPjncOKdJv0DtnIBJYLVQD5Kh/MVEIRjYKYlFU6PttmgGuB+YAsfK95oSbfemeVAqXuzgnt8sZCct9azDeQRpaBtWA+AUd8xSV/1h4rIKm5SMLIv1MXNHi2a02g+wJngsatN3+/sfwa5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315232; c=relaxed/simple;
	bh=ISd1N3reKr9C5znu5zuH8VbMHtktuN0EiMWdeaKRUTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xnx81qVRyezNhINkZnaTetlx1MD8BXvIkTIlunEekpAHBbw7xhRiLzDdZck7voGITdKNnVq0Cr1zf2PvjnzzziMvgwaXtze/pYTcciqaXfR2hvNbVC7FZXsLxl7sUHSm5Ca67oZVtOdDk1b6pOuRNBvScOnm9jHXHbD+bWQQM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K68BP3xO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 971851BF203;
	Wed,  4 Dec 2024 12:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733315228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UHwgj0vhrUjlsuigmL9kqonbebIU/oL+ZA3YxafoFYU=;
	b=K68BP3xOnpF8PMImreJ+hhAXDMRzNKQftrXRuvOhNsTRAJPkKTnbsTBXhZEhGxfKhpfBJF
	MdudFWakEsdxLbY1FKooSyGE/aqkUWQgMUFL9NOLKWdlrAKAE8/RaBq6rLdjQuYpm08MEq
	gAWfBjQIvCafe2nHUkV9lZ81BsBihLFP75eOo0fR6BSStdT7TWTD1H30tCZfD8mEATf83q
	TQBNqJlDWzcTDtgVvMpf/sziL/1f+4SFK3nIK/nvITJUJ8pOwsKkiCs0TuIaR6kkuOjwEA
	6Oi2GKJc8YhrXRET1z4lfyUfPW/efh8OUcTJOJl3QcGMHcMzsGvwrLLEo/yleg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH RESEND v3 1/1] pps: clients: gpio: Bypass edge's direction check when not needed
Date: Wed,  4 Dec 2024 13:27:00 +0100
Message-ID: <20241204122700.1203310-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

In the IRQ handler, the GPIO's state is read to verify the direction of
the edge that triggered the interruption before generating the PPS event.
If a pulse is too short, the GPIO line can reach back its original state
before this verification and the PPS event is lost.

This check is needed when info->capture_clear is set because it needs
interruptions on both rising and falling edges. When info->capture_clear
is not set, interruption is triggered by one edge only so this check can
be omitted.

Add a warning if irq_handler is left without triggering any PPS event.
Bypass the edge's direction verification when info->capture_clear is not
set.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
---
Changes in v3:
 - Add a warning in irq_handler
Changes in v2:
 - Modifiy the way the bypass is done to avoid code duplication

v1: https://lore.kernel.org/all/20240410113502.73038-1-bastien.curutchet@bootlin.com/
v2: https://lore.kernel.org/all/20240411061329.7262-1-bastien.curutchet@bootlin.com/

 drivers/pps/clients/pps-gpio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 2f4b11b4dfcd..af62d944d051 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -52,7 +52,9 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
 
 	info = data;
 
-	rising_edge = gpiod_get_value(info->gpio_pin);
+	/* Small trick to bypass the check on edge's direction when capture_clear is unset */
+	rising_edge = info->capture_clear ?
+		      gpiod_get_value(info->gpio_pin) : !info->assert_falling_edge;
 	if ((rising_edge && !info->assert_falling_edge) ||
 			(!rising_edge && info->assert_falling_edge))
 		pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
@@ -60,6 +62,8 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
 			((rising_edge && info->assert_falling_edge) ||
 			(!rising_edge && !info->assert_falling_edge)))
 		pps_event(info->pps, &ts, PPS_CAPTURECLEAR, data);
+	else
+		dev_warn_ratelimited(info->pps->dev, "IRQ did not trigger any PPS event\n");
 
 	return IRQ_HANDLED;
 }
-- 
2.44.0


