Return-Path: <linux-kernel+bounces-404817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8F99C489C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C7D28AE9A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D051BC068;
	Mon, 11 Nov 2024 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="T27Mpgjh"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC638F83
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362184; cv=none; b=d6KvakbRX/1dPGZZKAJWSOfFgP8Xp4IW4TMqzTaB1mI3GdV7zzDe+QuQMt//6z39A+YvFm1zty7tH7AJcZZsgTFhRXXMBNVw3kYuFnFH5h8l1sIDOD0VtZcN9u453HnhSh/J3RUQVeQlzE595sHYvprxrwBGzbykcVe6v9+RDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362184; c=relaxed/simple;
	bh=n5nq53/25po50KjWQKvkUVIZjFl1pAnTdVPozxpn+bc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J6oMA6rBhD+Y7GKZioZA4ZleIGfQlIxpzedby2eDJXD7wBIyUMVgGZ1fl/vKSdVb7GaLeCFiNf38kqr44GP+/ehU+bh01rptaPAf58PChS1su6gtTUhfQSXuBnHUHRkHFo1frRZVBGHW0oIoM7N61eDq39/SnRkuUcznYrQLbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=T27Mpgjh; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 4825D1770FF; Mon, 11 Nov 2024 21:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731362182; bh=n5nq53/25po50KjWQKvkUVIZjFl1pAnTdVPozxpn+bc=;
	h=Date:From:To:Subject:From;
	b=T27Mpgjh48AY5qTflxj89VqgoxaGwUziZcv1Y4tlgZZX/aK6Oxr0LWvvyPVh/tmvc
	 01r6Tdm5EVTUEcPTlo9EFpST9XPeIeNpqbFdp7RGLpdaNM3E9n2HDmdNAI9dRT+UVL
	 ESy8/bDoSvivwqLRDoVFHAunYDCnbb0RBUoS1Eeh7/XifsngCQyUUelQKptULREGXX
	 4oL7wnH348AeyaTtEHwcepO4Vtp9sIFp5+93odDjDbQ3BEDejt0pG7LAMxV/HnmWxS
	 HUGny6+Kq1z/tMLe/xz+Jj3Tnqdhol6okYMtnJ5l1v9kXFC5dzGaIEpEl99TMpTNGg
	 JSFdaYc5xrZkA==
Date: Mon, 11 Nov 2024 21:56:22 +0000
From: Nir Lichtman <nir@lichtman.org>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] kdb: fix ctrl+e/a/f/b/d/p/n broken in keyboard mode
Message-ID: <20241111215622.GA161253@lichtman.org>
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
v3: Safely wrap the usage of the macro args and fix switch ident

 kernel/debug/kdb/kdb_keyboard.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keyboard.c
index 3c2987f46f6e..3a74604fdb8a 100644
--- a/kernel/debug/kdb/kdb_keyboard.c
+++ b/kernel/debug/kdb/kdb_keyboard.c
@@ -25,6 +25,8 @@
 #define KBD_STAT_OBF 		0x01	/* Keyboard output buffer full */
 #define KBD_STAT_MOUSE_OBF	0x20	/* Mouse output buffer full */
 
+#define CTRL(c) ((c) - 64)
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
+		/* non-printable supported control characters */
+		case CTRL('A'): /* Home */
+		case CTRL('B'): /* Left */
+		case CTRL('D'): /* Del */
+		case CTRL('E'): /* End */
+		case CTRL('F'): /* Right */
+		case CTRL('I'): /* Tab */
+		case CTRL('N'): /* Down */
+		case CTRL('P'): /* Up */
+			return keychar;
+		}
+
 		if (isprint(keychar))
 			break;		/* printable characters */
 		fallthrough;
-- 
2.39.2

