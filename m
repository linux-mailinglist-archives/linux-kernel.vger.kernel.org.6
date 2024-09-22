Return-Path: <linux-kernel+bounces-335102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEE997E111
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376391F212A2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9B4193075;
	Sun, 22 Sep 2024 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BClXpnjR"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C368A3B7AC;
	Sun, 22 Sep 2024 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727003823; cv=none; b=L8Mc2vVZaLeCS2Zqz1emVWWpK/6SWo/lomloqQT/SV03lzNmjk43W60E6jit5YVn8qQKevhZugEZ3vojckj9/nb4QWFnN7brHfM2P7b/7fL1BKQpKZYvViaeJ1fdiQSyDAr6kxnJnlUYEOVUIoZ8GJnzLr3FBDWDziIHuifnZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727003823; c=relaxed/simple;
	bh=Gajp+mpCYHLHu8sQHo0hFq1kYS6p5TLQebfwa9R/IG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tz5Y4rpBCDU8LNtPEJizNZ2pKx7wIaiLQnmyhkDtaQO7kFYcL//6DCg1QQBJMjtKqeTxyvFz5cxvgGh/3CGFAwAXw44bB2yo8nDwW+B75+1vdkf0BMwqX2k30uupM0RWcESgPfM2/wkLfQdD7Wx2qHwvFO1pNO4MWRO8/8fo2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BClXpnjR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso591021666b.0;
        Sun, 22 Sep 2024 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727003820; x=1727608620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xplsKOdeSs4IX/8B8Bo8H4/l3jhusQaBjOqWGwO3bho=;
        b=BClXpnjRgWiGruNgtCpfkFCwNHgwJEtbOe5oHKxd369mWUNBpi8CO475oIsGtBy1gt
         gtzodN+MvXHk9TeOk89+TdZlaCvGca29guNjCSZiBKeIAVcdSw3wF9WYlbZi8FJxRFpE
         rk5kC4B2F12ungB3UScWchJ15Sy+afl+98UWeGHQjwfkF8pC1X/OuFNT2EY7AJ5L4q4S
         SbdXHfDZWMA1UtSq4URiInvc/A2p8GDPpM3V9w+3ZKN455BTV0dp0BLObU16OlA1ZUwQ
         Db7x8Oj0RZGoVL2E71D2txNSMdXyUQlyUnqxu2ERT4rQbuU55oV9QnvVo8/sgyOy9tzB
         HIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727003820; x=1727608620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xplsKOdeSs4IX/8B8Bo8H4/l3jhusQaBjOqWGwO3bho=;
        b=ssOo3cIYyFmaLdX9GYpdTAOZkFpwXX2R7lsKlIkHtAPSg1J/c03B0SeXG3J3tyvvjy
         0Tn++759kYiBImZ4f9/qnH80+e+YmOxMZWZNfHZLR+sNwehlI+HgB3MvrxXmCXoT1gtw
         hiX+ajnvQj96RELlQY5Mz6Mu+P323uZreaUDMIszaaqj6s9xegjx/fLILlCs6kTBc9p7
         IOh9izb8QsO5bplAindojDdAvPFB4E5Pg6ztGEAysWwuAGYJ3/EH826J8KOaowjujLjR
         Z9n2T1XNTPATprU4+CvcZn2V4cK6uUWPlYGosLLbMuZibZGLmQJakV7faUn2dK+jhO8h
         dxEw==
X-Forwarded-Encrypted: i=1; AJvYcCUfWUiNb5omw/Zje+cPUN3aOZxihX95ILpfeKkCQlH3EyiSDBATL3QffWM8d/zIQSv6mbJwU1F5Op3LC2U=@vger.kernel.org, AJvYcCVIuy2OkBtyeXsQY3ep0+/sbXte5V6SGKmUnx1BlJSX3Jn4GpFni6cU26bpt1ScWyfwCuZl4UZ9tj+C@vger.kernel.org
X-Gm-Message-State: AOJu0YxwlIW3D8x0HiPawQnw5+7Wh6CjZHidXCErme6zR4EGHpopyPdz
	kiAGIu4xTzxBsLgzwUFdhfDhlgof+2Wc0/2antbjlwS/i3bxrD7T
X-Google-Smtp-Source: AGHT+IEeideO1lYcQEPhYIxgWzPS53oFskjpQ4idvyDpBJkUc7RuQp5CTp3TWFSmmZF5rU92T3RYSw==
X-Received: by 2002:a17:907:3ea2:b0:a8b:58e3:ac1f with SMTP id a640c23a62f3a-a90d3510a4amr850650266b.12.1727003819649;
        Sun, 22 Sep 2024 04:16:59 -0700 (PDT)
Received: from samiama.sinacomsys.local ([178.252.129.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061331bc8sm1067474566b.221.2024.09.22.04.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 04:16:58 -0700 (PDT)
From: amin-amani <didi1364@gmail.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"A.Amani" <didi1364@gmail.com>
Subject: [PATCH] usb: serial: digi_acceleport: Improve readability and enhance error handling
Date: Sun, 22 Sep 2024 14:47:01 +0330
Message-Id: <20240922111701.85965-1-didi1364@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "A.Amani" <didi1364@gmail.com>

- Improved coding style to adhere to kernel standards as suggested by
  checkpatch.pl.
- Indented case statements for baud rate and word size to improve code
  readability.
- Separated null checks for port, serial, and private data for clearer
  error handling.
- Improved error messages to better indicate which specific data (port,
  serial, or private) is null.
- No functional changes, only structural improvements and clearer
  debugging output.

Signed-off-by: A.Amani <didi1364@gmail.com>
---
 drivers/usb/serial/digi_acceleport.c | 105 +++++++++++++++++++--------
 1 file changed, 73 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index d1dea3850576..da707967a0c4 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -685,25 +685,44 @@ static void digi_set_termios(struct tty_struct *tty,
 		}
 		switch (baud) {
 		/* drop DTR and RTS on transition to B0 */
-		case 0: digi_set_modem_signals(port, 0, 1); break;
-		case 50: arg = DIGI_BAUD_50; break;
-		case 75: arg = DIGI_BAUD_75; break;
-		case 110: arg = DIGI_BAUD_110; break;
-		case 150: arg = DIGI_BAUD_150; break;
-		case 200: arg = DIGI_BAUD_200; break;
-		case 300: arg = DIGI_BAUD_300; break;
-		case 600: arg = DIGI_BAUD_600; break;
-		case 1200: arg = DIGI_BAUD_1200; break;
-		case 1800: arg = DIGI_BAUD_1800; break;
-		case 2400: arg = DIGI_BAUD_2400; break;
-		case 4800: arg = DIGI_BAUD_4800; break;
-		case 9600: arg = DIGI_BAUD_9600; break;
-		case 19200: arg = DIGI_BAUD_19200; break;
-		case 38400: arg = DIGI_BAUD_38400; break;
-		case 57600: arg = DIGI_BAUD_57600; break;
-		case 115200: arg = DIGI_BAUD_115200; break;
-		case 230400: arg = DIGI_BAUD_230400; break;
-		case 460800: arg = DIGI_BAUD_460800; break;
+		case 0:
+			digi_set_modem_signals(port, 0, 1); break;
+		case 50:
+			arg = DIGI_BAUD_50; break;
+		case 75:
+			arg = DIGI_BAUD_75; break;
+		case 110:
+			arg = DIGI_BAUD_110; break;
+		case 150:
+			arg = DIGI_BAUD_150; break;
+		case 200:
+			arg = DIGI_BAUD_200; break;
+		case 300:
+			arg = DIGI_BAUD_300; break;
+		case 600:
+			arg = DIGI_BAUD_600; break;
+		case 1200:
+			arg = DIGI_BAUD_1200; break;
+		case 1800:
+			arg = DIGI_BAUD_1800; break;
+		case 2400:
+			arg = DIGI_BAUD_2400; break;
+		case 4800:
+			arg = DIGI_BAUD_4800; break;
+		case 9600:
+			arg = DIGI_BAUD_9600; break;
+		case 19200:
+			arg = DIGI_BAUD_19200; break;
+		case 38400:
+			arg = DIGI_BAUD_38400; break;
+		case 57600:
+			arg = DIGI_BAUD_57600; break;
+		case 115200:
+			arg = DIGI_BAUD_115200; break;
+		case 230400:
+			arg = DIGI_BAUD_230400; break;
+		case 460800:
+			arg = DIGI_BAUD_460800; break;
 		default:
 			arg = DIGI_BAUD_9600;
 			baud = 9600;
@@ -737,10 +756,14 @@ static void digi_set_termios(struct tty_struct *tty,
 	if ((cflag & CSIZE) != (old_cflag & CSIZE)) {
 		arg = -1;
 		switch (cflag & CSIZE) {
-		case CS5: arg = DIGI_WORD_SIZE_5; break;
-		case CS6: arg = DIGI_WORD_SIZE_6; break;
-		case CS7: arg = DIGI_WORD_SIZE_7; break;
-		case CS8: arg = DIGI_WORD_SIZE_8; break;
+		case CS5:
+			arg = DIGI_WORD_SIZE_5; break;
+		case CS6:
+			arg = DIGI_WORD_SIZE_6; break;
+		case CS7:
+			arg = DIGI_WORD_SIZE_7; break;
+		case CS8:
+			arg = DIGI_WORD_SIZE_8; break;
 		default:
 			dev_dbg(dev,
 				"digi_set_termios: can't handle word size %d\n",
@@ -967,16 +990,30 @@ static void digi_write_bulk_callback(struct urb *urb)
 	int status = urb->status;
 	bool wakeup;
 
-	/* port and serial sanity check */
-	if (port == NULL || (priv = usb_get_serial_port_data(port)) == NULL) {
-		pr_err("%s: port or port->private is NULL, status=%d\n",
+	/* port sanity check */
+	if (port == NULL) {
+		pr_err("%s: port is NULL, status=%d\n",
+			__func__, status);
+		return;
+	}
+	/* serial sanity check */
+	priv = usb_get_serial_port_data(port);
+	if (priv == NULL) {
+		pr_err("%s: port->private is NULL, status=%d\n",
 			__func__, status);
 		return;
 	}
 	serial = port->serial;
-	if (serial == NULL || (serial_priv = usb_get_serial_data(serial)) == NULL) {
+	if (serial == NULL) {
 		dev_err(&port->dev,
-			"%s: serial or serial->private is NULL, status=%d\n",
+			"%s: serial  is NULL, status=%d\n",
+			__func__, status);
+		return;
+	}
+	serial_priv = usb_get_serial_data(serial);
+	if (serial_priv == NULL) {
+		dev_err(&port->dev,
+			"%s: serial->private is NULL, status=%d\n",
 			__func__, status);
 		return;
 	}
@@ -1309,13 +1346,17 @@ static void digi_read_bulk_callback(struct urb *urb)
 			__func__, status);
 		return;
 	}
-	if (port->serial == NULL ||
-		(serial_priv = usb_get_serial_data(port->serial)) == NULL) {
-		dev_err(&port->dev, "%s: serial is bad or serial->private "
+	if (port->serial == NULL) {
+		dev_err(&port->dev, "%s: serial is bad,"
+			" status=%d\n", __func__, status);
+		return;
+	}
+	serial_priv = usb_get_serial_data(port->serial);
+	if (serial_priv == NULL) {
+		dev_err(&port->dev, "%s:serial->private "
 			"is NULL, status=%d\n", __func__, status);
 		return;
 	}
-
 	/* do not resubmit urb if it has any status error */
 	if (status) {
 		dev_err(&port->dev,
-- 
2.34.1


