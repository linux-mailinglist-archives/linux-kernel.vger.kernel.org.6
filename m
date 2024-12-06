Return-Path: <linux-kernel+bounces-435747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C72C99E7BBE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B99E18879EF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ABD1EF0B3;
	Fri,  6 Dec 2024 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Db06uJAk"
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288AE213E63
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523969; cv=none; b=J8ZDYOcUaE5VDy5CaE/Gfund39n9eeq/vWY1NI+Gf1MY6cJgajP68MXSPnp0Ovl2bHMmFaT4s39YMUd0BfYJEPBB7V+q1mqpKjoAs38L+1troTFFf+shWIN3wb721YmL0CrdEw/XszOJq5pxTcdDNh2WkHQnDTUaQ+dpPRCICyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523969; c=relaxed/simple;
	bh=Lnuw42Mv5iHPBLo/2AByl5VlBgqQFDUrAunAYV1GFec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBI4qd+CmX6uzn0Wr3nCb2+kz4cum7H8dbAE2YM/lRF8nVCJLeL+Uo8Q/7yDQpyvMvp2rR0JQuMmDPrTkjkpSB5M+TCLydAUciSlVOqqJ0M4Q2JfvEu0HfxxBIZpvLI+jd+mmL+nnrBiq95AZWK/gZz1b+90/LPVL7OTMbwOdME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Db06uJAk; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id JglqtTW6qgyqpJglztoJXr; Fri, 06 Dec 2024 23:26:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733523968;
	bh=g1WxuViRwGa1+bDp1AsTQe31lF4KfiLv3FxP9yuHr6w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Db06uJAkQEDTFLQLzcpIu2x/Dqn+GTenRvjIJBeu0OU/NkxEMORiJW+XxtwycrgZZ
	 cNRffc7eeA6P5XqdjMe0O4kf6uOnqqUYt9DvotIj9ajk98fQxw19YNmKKt2DYumh4/
	 c3MxCwX4GtJhsUsG+2f85lOirQeEH3sB51VUUqMEnT7ocpEx0nrnH/MEBSjSSymge7
	 OSxWS/V7nBtOGm5GyW7Wokzqon8P8+3czkJtYaCf8FX9zFlN7XVKN2+dLsmlBV8W+Z
	 VANKnINwtsgjUQQJcWIS30xxi6XfZbAm63vhIi3XYJnnb7/X1vxVkfV1aBaAaIwoyj
	 HOUWSoTkagc4g==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 06 Dec 2024 23:26:08 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Paul Burton <paulburton@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] auxdisplay: img-ascii-lcd: Constify struct img_ascii_lcd_config
Date: Fri,  6 Dec 2024 23:25:42 +0100
Message-ID: <f205c8ab886a4e12b2ceda6f89c873a9d921625d.1733523925.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <35fab997bcac76cd4135797a4968c2c72511dcb9.1733523925.git.christophe.jaillet@wanadoo.fr>
References: <35fab997bcac76cd4135797a4968c2c72511dcb9.1733523925.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct img_ascii_lcd_config' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   6110	    728	      0	   6838	   1ab6	drivers/auxdisplay/img-ascii-lcd.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   6198	    632	      0	   6830	   1aae	drivers/auxdisplay/img-ascii-lcd.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/auxdisplay/img-ascii-lcd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index 693339ba89d0..32e1863ef4b2 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -69,7 +69,7 @@ static void boston_update(struct linedisp *linedisp)
 #endif
 }
 
-static struct img_ascii_lcd_config boston_config = {
+static const struct img_ascii_lcd_config boston_config = {
 	.num_chars = 8,
 	.ops = {
 		.update = boston_update,
@@ -98,7 +98,7 @@ static void malta_update(struct linedisp *linedisp)
 		pr_err_ratelimited("Failed to update LCD display: %d\n", err);
 }
 
-static struct img_ascii_lcd_config malta_config = {
+static const struct img_ascii_lcd_config malta_config = {
 	.num_chars = 8,
 	.external_regmap = true,
 	.ops = {
@@ -200,7 +200,7 @@ static void sead3_update(struct linedisp *linedisp)
 		pr_err_ratelimited("Failed to update LCD display: %d\n", err);
 }
 
-static struct img_ascii_lcd_config sead3_config = {
+static const struct img_ascii_lcd_config sead3_config = {
 	.num_chars = 16,
 	.external_regmap = true,
 	.ops = {
-- 
2.47.1


