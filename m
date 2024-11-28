Return-Path: <linux-kernel+bounces-425056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2649F9DBCEB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477BDB21856
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082491C2DA2;
	Thu, 28 Nov 2024 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="GKzkVsxz"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C245812C7FD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732826145; cv=none; b=KdvtntlU37rlAr7PL7hrlyMun6LW1rbkAQL5bepzofbnrkyGZE5z15HXw9SPhpJSdmLLZw47yJHwwsD/GA5t0Ua/I0Lh9hnRLgetZaawV+HpidlDs2hXZGFvf8Lpjrxowxf6bR3Nekzvow4MLidFEFj+YpdHfmzCJuNnbJSP0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732826145; c=relaxed/simple;
	bh=gSIx+pCpI5ZEUmzZQreRDyEk1tyWKE0ReEOQOlA3/h8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fZXlS0KUljIWMgX+mpNADU7/AWEwj4MDrp8kdKNYO8bllQy9U/m1eM5z2cDYhmVx1G7s80VOV4zpwqrL1WU9jPuHjigTiQoOq5KFt3Dhr70BThO4s0ArwWsZf5BZBve/slzT1jGuv0q3kqhsD9sIWVcYKprvI8r+lC8p9SwUMss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=GKzkVsxz; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id E59861770BE; Thu, 28 Nov 2024 20:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1732826142; bh=gSIx+pCpI5ZEUmzZQreRDyEk1tyWKE0ReEOQOlA3/h8=;
	h=Date:From:To:Subject:From;
	b=GKzkVsxzuGsGtyPSYSqeY6QR7xzo/mPMBrL3UA4Z7E4THLh0RVDStKoNPnwn8QfbQ
	 meKtJqOSlEsTOo6gmHlCyXF2fRXOo/WkpuxBVPiXjNvLaVEllc4JbWB1c2AJUs7hnH
	 QFAK2hXbuyCibwDqN/copc+iRRY9xCG2t5f2TZWiSIERrHgXQ4cHRCrAtjzoX1WvEF
	 Dun32kRItywsGQYowdAc22rej6ZcIW42eHYjnohr4U9on5Dc5e2q1yhyjMhw0AuXDY
	 7zyXfbcD+YtmZMaF7VYA00Tfkl7vUwVRixF9ugLLs6ZovN1gj82r1dYRgRmI2/39CA
	 +UdGn10AR336g==
Date: Thu, 28 Nov 2024 20:35:42 +0000
From: Nir Lichtman <nir@lichtman.org>
To: dianders@chromium.org, jason.wessel@windriver.com, danielt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kdb: utilize more readable control characters macro in
 kdb io
Message-ID: <20241128203542.GA370417@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Continuing the previous refactor in kdb_keyboard.c of adding the CTRL
macro, this patch moves the macro to a common header and utilizes this
pattern in kdb_io.c as well, resulting in more readable code.

I have added the _KEY suffix to make the macro more clear, considering
it is now common.

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---

v2: Refactor another line CTRL+I line I missed in v1 and remove CTRL+K/U
I accidentaly included in v1.

 kernel/debug/kdb/kdb_io.c       | 38 ++++++++++++++++-----------------
 kernel/debug/kdb/kdb_keyboard.c | 34 ++++++++++++++---------------
 kernel/debug/kdb/kdb_private.h  |  2 ++
 3 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6a77f1c779c4..5d69aa93652c 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -76,13 +76,13 @@ static int kdb_handle_escape(char *buf, size_t sz)
 	case 3:
 		switch (*lastkey) {
 		case 'A': /* \e[A, up arrow */
-			return 16;
+			return CTRL_KEY('P');
 		case 'B': /* \e[B, down arrow */
-			return 14;
+			return CTRL_KEY('N');
 		case 'C': /* \e[C, right arrow */
-			return 6;
+			return CTRL_KEY('F');
 		case 'D': /* \e[D, left arrow */
-			return 2;
+			return CTRL_KEY('B');
 		case '1': /* \e[<1,3,4>], may be home, del, end */
 		case '3':
 		case '4':
@@ -94,11 +94,11 @@ static int kdb_handle_escape(char *buf, size_t sz)
 		if (*lastkey == '~') {
 			switch (buf[2]) {
 			case '1': /* \e[1~, home */
-				return 1;
+				return CTRL_KEY('A');
 			case '3': /* \e[3~, del */
-				return 4;
+				return CTRL_KEY('D');
 			case '4': /* \e[4~, end */
-				return 5;
+				return CTRL_KEY('E');
 			}
 		}
 		break;
@@ -264,10 +264,10 @@ static char *kdb_read(char *buffer, size_t bufsize)
 	kdb_printf("%s", buffer);
 poll_again:
 	key = kdb_getchar();
-	if (key != 9)
+	if (key != CTRL_KEY('I'))
 		tab = 0;
 	switch (key) {
-	case 8: /* backspace */
+	case CTRL_KEY('H'): /* backspace */
 		if (cp > buffer) {
 			memmove(cp-1, cp, lastchar - cp + 1);
 			lastchar--;
@@ -276,8 +276,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
-	case 10: /* linefeed */
-	case 13: /* carriage return */
+	case CTRL_KEY('J'): /* linefeed */
+	case CTRL_KEY('M'): /* carriage return */
 		*lastchar++ = '\n';
 		*lastchar++ = '\0';
 		if (!KDB_STATE(KGDB_TRANS)) {
@@ -286,7 +286,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 		}
 		kdb_printf("\n");
 		return buffer;
-	case 4: /* Del */
+	case CTRL_KEY('D'): /* Del */
 		if (cp < lastchar) {
 			memmove(cp, cp+1, lastchar - cp);
 			lastchar--;
@@ -294,39 +294,39 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
-	case 1: /* Home */
+	case CTRL_KEY('A'): /* Home */
 		if (cp > buffer) {
 			cp = buffer;
 			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
-	case 5: /* End */
+	case CTRL_KEY('E'): /* End */
 		if (cp < lastchar) {
 			kdb_printf("%s", cp);
 			cp = lastchar;
 		}
 		break;
-	case 2: /* Left */
+	case CTRL_KEY('B'): /* Left */
 		if (cp > buffer) {
 			kdb_printf("\b");
 			--cp;
 		}
 		break;
-	case 14: /* Down */
-	case 16: /* Up */
+	case CTRL_KEY('N'): /* Down */
+	case CTRL_KEY('P'): /* Up */
 		kdb_printf("\r%*c\r",
 			   (int)(strlen(kdb_prompt_str) + (lastchar - buffer)),
 			   ' ');
 		*lastchar = (char)key;
 		*(lastchar+1) = '\0';
 		return lastchar;
-	case 6: /* Right */
+	case CTRL_KEY('F'): /* Right */
 		if (cp < lastchar) {
 			kdb_printf("%c", *cp);
 			++cp;
 		}
 		break;
-	case 9: /* Tab */
+	case CTRL_KEY('I'): /* Tab */
 		if (tab < 2)
 			++tab;
 
diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keyboard.c
index 3a74604fdb8a..d6a55d1e0ef9 100644
--- a/kernel/debug/kdb/kdb_keyboard.c
+++ b/kernel/debug/kdb/kdb_keyboard.c
@@ -25,8 +25,6 @@
 #define KBD_STAT_OBF 		0x01	/* Keyboard output buffer full */
 #define KBD_STAT_MOUSE_OBF	0x20	/* Mouse output buffer full */
 
-#define CTRL(c) ((c) - 64)
-
 static int kbd_exists;
 static int kbd_last_ret;
 
@@ -128,21 +126,21 @@ int kdb_get_kbd_char(void)
 	/* Translate special keys to equivalent CTRL control characters */
 	switch (scancode) {
 	case 0xF: /* Tab */
-		return CTRL('I');
+		return CTRL_KEY('I');
 	case 0x53: /* Del */
-		return CTRL('D');
+		return CTRL_KEY('D');
 	case 0x47: /* Home */
-		return CTRL('A');
+		return CTRL_KEY('A');
 	case 0x4F: /* End */
-		return CTRL('E');
+		return CTRL_KEY('E');
 	case 0x4B: /* Left */
-		return CTRL('B');
+		return CTRL_KEY('B');
 	case 0x48: /* Up */
-		return CTRL('P');
+		return CTRL_KEY('P');
 	case 0x50: /* Down */
-		return CTRL('N');
+		return CTRL_KEY('N');
 	case 0x4D: /* Right */
-		return CTRL('F');
+		return CTRL_KEY('F');
 	}
 
 	if (scancode == 0xe0)
@@ -176,14 +174,14 @@ int kdb_get_kbd_char(void)
 	case KT_LATIN:
 		switch (keychar) {
 		/* non-printable supported control characters */
-		case CTRL('A'): /* Home */
-		case CTRL('B'): /* Left */
-		case CTRL('D'): /* Del */
-		case CTRL('E'): /* End */
-		case CTRL('F'): /* Right */
-		case CTRL('I'): /* Tab */
-		case CTRL('N'): /* Down */
-		case CTRL('P'): /* Up */
+		case CTRL_KEY('A'): /* Home */
+		case CTRL_KEY('B'): /* Left */
+		case CTRL_KEY('D'): /* Del */
+		case CTRL_KEY('E'): /* End */
+		case CTRL_KEY('F'): /* Right */
+		case CTRL_KEY('I'): /* Tab */
+		case CTRL_KEY('N'): /* Down */
+		case CTRL_KEY('P'): /* Up */
 			return keychar;
 		}
 
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index d2520d72b1f5..1f29df5d89b8 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -227,6 +227,8 @@ extern char kdb_prompt_str[];
 
 #define	KDB_WORD_SIZE	((int)sizeof(unsigned long))
 
+#define CTRL_KEY(c) ((c) - 64)
+
 #endif /* CONFIG_KGDB_KDB */
 
 #define kdb_func_printf(format, args...) \
-- 
2.39.2


