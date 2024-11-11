Return-Path: <linux-kernel+bounces-404774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B759C47F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFE61F21870
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58091AC423;
	Mon, 11 Nov 2024 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="tZXu665B"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9841EB36
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360183; cv=none; b=f/y/PSTiFTRQajjJCvW4ar+kEHtej6LLHIaoA2Li/ZsnTaoATv0Q2UQB7J/v4CbWvxFy2xsNlozljWwUzaqJvMw85hm/d9rfFW5UY1ShTg/hDCK3/0OJiULqJmkVVdPh+D94VkmN1DoPjyq9EHROANA5rUXOpeF+eHxh0myEU8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360183; c=relaxed/simple;
	bh=XK/ElYCdI62mAAT1lSY2EoNqVW7PNLO3gyefzHxVesI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pk2C3n/SWDX+3MhqerdYP9NdGiYZQr1EcdRZtB+eX3K/Kt4svDjTdv3MLN1jYFAz4HskB9d5hvXsJ88Xxc6EDHCVGxgVZnUd5NPaplhtw4S1nLuWK7IaZTocVJxvcOcxrmgUsQZLbRNpc/KIlVyemgBw0ZP1TkLc76Ext3bz/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=tZXu665B; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id A9BE41770FF; Mon, 11 Nov 2024 21:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731360174; bh=XK/ElYCdI62mAAT1lSY2EoNqVW7PNLO3gyefzHxVesI=;
	h=Date:From:To:Subject:From;
	b=tZXu665Bx7dbSP+U6t0cnVWLtOyaijqFS/WtqQ7aVNVSedHhISU2uYdlI/YHrBjyZ
	 bqxlDzPbqoM2uIi8nlDX5zKcBVQAwsUTwIAC8HvM7Uf7d+eWqjbav4RGAlM9m3bxhu
	 P3BUhNGGTr01uzbQ0ICpoW57OFS43+axpVoeKJMoMLBHPxhPne4hDVunsvlSTPYRu3
	 GQhXt6AFH7L6yZ685Q/3bFFj1BSG60hiyL889qwAYF1Zazg4P+MvLGVFe0P1ZmO/ZE
	 SrRrlPFkn4I3i0g5/z70Fi8s8RMQ+uh2f5zdm2srp9nfztulpEs7zXGyZX43ssS863
	 MYKGl4Pp3Lpsw==
Date: Mon, 11 Nov 2024 21:22:54 +0000
From: Nir Lichtman <nir@lichtman.org>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] kdb: fix ctrl+e/a/f/b/d/p/n broken in keyboard mode
Message-ID: <20241111212254.GA160555@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Problem: When using kdb via keyboard it does not react to control
characters which are supported in serial mode.

Example: Chords such as ctrl+a/e/d/p do not work in keyboard mode

Solution: Before disregarding non-printable key characters, check if they
are one of the supported control characters, I have took the control
characters from the switch case upwards in this function that translates
scan codes of arrow keys/backspace/home/.. to the control characters.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Nir Lichtman <nir@lichtman.org>
---

v2: Add CTRL macro following Douglas's suggestion in the CR of v1

 kernel/debug/kdb/kdb_keyboard.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keyboard.c
index 3c2987f46f6e..9b8b172f48c3 100644
--- a/kernel/debug/kdb/kdb_keyboard.c
+++ b/kernel/debug/kdb/kdb_keyboard.c
@@ -25,6 +25,8 @@
 #define KBD_STAT_OBF 		0x01	/* Keyboard output buffer full */
 #define KBD_STAT_MOUSE_OBF	0x20	/* Mouse output buffer full */
 
+#define CTRL(c) (c - 64)
+
 static int kbd_exists;
 static int kbd_last_ret;
 
@@ -123,24 +125,24 @@ int kdb_get_kbd_char(void)
 		return 8;
 	}
 
-	/* Special Key */
+	/* Translate special keys to equivalent CTRL control characters */
 	switch (scancode) {
 	case 0xF: /* Tab */
-		return 9;
+		return CTRL('I');
 	case 0x53: /* Del */
-		return 4;
+		return CTRL('D');
 	case 0x47: /* Home */
-		return 1;
+		return CTRL('A');
 	case 0x4F: /* End */
-		return 5;
+		return CTRL('E');
 	case 0x4B: /* Left */
-		return 2;
+		return CTRL('B');
 	case 0x48: /* Up */
-		return 16;
+		return CTRL('P');
 	case 0x50: /* Down */
-		return 14;
+		return CTRL('N');
 	case 0x4D: /* Right */
-		return 6;
+		return CTRL('F');
 	}
 
 	if (scancode == 0xe0)
@@ -172,6 +174,19 @@ int kdb_get_kbd_char(void)
 	switch (KTYP(keychar)) {
 	case KT_LETTER:
 	case KT_LATIN:
+		switch (keychar) {
+			/* non-printable supported control characters */
+			case CTRL('A'): /* Home */
+			case CTRL('B'): /* Left */
+			case CTRL('D'): /* Del */
+			case CTRL('E'): /* End */
+			case CTRL('F'): /* Right */
+			case CTRL('I'): /* Tab */
+			case CTRL('N'): /* Down */
+			case CTRL('P'): /* Up */
+				return keychar;
+		}
+
 		if (isprint(keychar))
 			break;		/* printable characters */
 		fallthrough;
-- 
2.39.2

