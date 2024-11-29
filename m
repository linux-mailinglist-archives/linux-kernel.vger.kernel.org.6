Return-Path: <linux-kernel+bounces-416940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303479D4C98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1231F21E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205D21D5CE0;
	Thu, 21 Nov 2024 12:12:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7D1D47DC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732191148; cv=none; b=JcABtooI4n/pcuranlWwR/TvQMQ9Loc++dodhnvsTEFKri92T330dpHsvJg8aFviHLF2OvHyIz4a8UQxqbQ/EJs/RD67MvZ3RUlO7S267IdkD8svKze6Guj6QK/LJeNpxlw5NnRb+RiJrVFAbdtqVcsDzWJYw7ro8nLhobT4bw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732191148; c=relaxed/simple;
	bh=N41w2X+8pE+ZSJ1A6dLwZKSsnwg06n0TPP7261slhTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Uml5eoBHEJBisxdUcoGri2nlgeTp8+Lmr8DUyUjaowazkkJxhOiaEwN6P6BYduPq5QcdpTTjdEafSfA5A3Vcun0TQZusikf3s4eReeGMtLxbV3MqfvLDacrx6zyOkIRmqjq54x5valeT96hW6BxMKIDsvybl/FEcAnre9Wj3acU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tE62j-0003Al-4y
	for linux-kernel@vger.kernel.org; Thu, 21 Nov 2024 13:12:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tE62i-001ty4-31
	for linux-kernel@vger.kernel.org;
	Thu, 21 Nov 2024 13:12:16 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 9B8CB3788C4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:12:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 58AC33788BF;
	Thu, 21 Nov 2024 12:12:15 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ca082c11;
	Thu, 21 Nov 2024 12:12:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 21 Nov 2024 13:12:12 +0100
Subject: [PATCH can] can: dev: can_set_termination(): allow sleeping GPIOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241121-dev-fix-can_set_termination-v1-1-41fa6e29216d@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAJsjP2cC/x2M0QpAQBAAf0X7bMtulPyKpHMW++Do7pKSf7d5n
 JqZB5JElQRd8UCUS5MewYDKAvzmwiqoszFwxTURE85y4aI3ehfGJHnMEncNLluHC7m2Jp6YfQN
 2OKOY+t97sACG9/0AmXidgXIAAAA=
X-Change-ID: 20241121-dev-fix-can_set_termination-f1a8412b22c5
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=N41w2X+8pE+ZSJ1A6dLwZKSsnwg06n0TPP7261slhTs=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnPyOcVCx49fS2p7p2xIYffu1mLTYmamC/zYeni
 3+GDml5RvWJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZz8jnAAKCRAoOKI+ei28
 b71UB/wPWq6PY/Ug4OdcsZa5Ap7ejPPR/wcO1X5Umk7hZ3EV9a0EwmcKBEcpFKIIpp6x6tHRSCF
 hL1MctqjN6Y6CFhstKfufDXh4uwyJyc41L8CdMcUbKLrU50F7NbOwA2ETtDb4gJfDqmp0HxemH3
 5Th9G/TiDKXinZ7ckgVkPuoXLJFqx36PP4aYzqVAKeZFQ/aUJNJpWr/o2/sr6VNHHOUR0SxhvxG
 jk/D1wBE6GMBMApLLujRlokVOotiDm9b4S7GyGCi7WnuqqOwU7lPHyNQBr3AiRw891JuXyfnybO
 NUA1J0eSnZzAboDD3TgF+DAdVDC6EEaJNMXMC5JPGTXQnSuN
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In commit 6e86a1543c37 ("can: dev: provide optional GPIO based
termination support") GPIO based termination support was added.

For no particular reason that patch uses gpiod_set_value() to set the
GPIO. This leads to the following warning, if the systems uses a
sleeping GPIO, i.e. behind an I2C port expander:

| WARNING: CPU: 0 PID: 379 at /drivers/gpio/gpiolib.c:3496 gpiod_set_value+0x50/0x6c
| CPU: 0 UID: 0 PID: 379 Comm: ip Not tainted 6.11.0-20241016-1 #1 823affae360cc91126e4d316d7a614a8bf86236c

Replace gpiod_set_value() by gpiod_set_value_cansleep() to allow
sleeping GPIO.

Reported-by: Leonard Göhrs <l.goehrs@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 6792c14fd7eb009d551ac22bab1f0ee2cd0f0398..681643ab37804e9904cc4a899d44c55cefab7b6e 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -468,7 +468,7 @@ static int can_set_termination(struct net_device *ndev, u16 term)
 	else
 		set = 0;
 
-	gpiod_set_value(priv->termination_gpio, set);
+	gpiod_set_value_cansleep(priv->termination_gpio, set);
 
 	return 0;
 }

---
base-commit: 66418447d27b7f4c027587582a133dd0bc0a663b
change-id: 20241121-dev-fix-can_set_termination-f1a8412b22c5

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



