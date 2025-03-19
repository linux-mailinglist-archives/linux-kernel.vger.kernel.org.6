Return-Path: <linux-kernel+bounces-568414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652BAA69511
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7CE3AFF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA311DE881;
	Wed, 19 Mar 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZFvpNqT1"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B8EEB1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402111; cv=none; b=tvTRFHeNrFvKVr1BBxUqKOXnVJZWx6KlyE7onIP8/NjbqB9UhSsAo8R8Jma44q449Y35zEWZoqlW+SjmD43gM1TsI8caeNKdOD+RodNVxG89SA1mVhAmvS2XcAOsrKKDKmjC+bhCPPqFeG2pcZHdx/0mE+MrcliFKGZPv803ebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402111; c=relaxed/simple;
	bh=SAVLBSqJtyua3yCvljJMbNzEypKvdyuUMoQnSz2V33E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnyFfbfyZqMiubiP2h8RZVsdAHDI0nLiZmpjaIkWH2JPPk0J+OE1bDcgNPqrM4FqzHnU0T6DMUkhi0VuX8mq7xn3sWiKgYBNL2IDHnPDj227F7kBNKqNtYMagxX+sXahKVNsvQzaXFUFTYE+KMj7gFCLfiJ26qGgI4ZuRvgFJQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZFvpNqT1; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742402105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=URqaufT66twiiGNNIQ5E76uOK/k0KS4Bhton5eN/u28=;
	b=ZFvpNqT1qbCYk1KXjnBr5yE90kum3xC/uUhkyeYEwzYVog/5JYLcw0ASxrPVpEEA6DkU2z
	Q9Cy7OuZzBn0+4GMiDbCefuj1vlSjp7UjL8/2JBRzBsgQs238/4x+0Z13PO2GDSs6lESlu
	h9D5cHSz1g/eTh0adD5p/UbSrPwUdMY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: Remove optional size arguments from strscpy() calls
Date: Wed, 19 Mar 2025 17:33:39 +0100
Message-ID: <20250319163341.2123-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If the destination buffer has a fixed length, strscpy() automatically
determines the size of the destination buffer using sizeof() if the
argument is omitted. This makes the explicit sizeof() unnecessary.

Furthermore, CMD_BUFLEN is equal to sizeof(kdb_prompt_str) and can also
be removed. Remove them to shorten and simplify the code.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/debug/kdb/kdb_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6a77f1c779c4..9b11b10b120c 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -334,7 +334,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 		*cp = '\0';
 		p_tmp = strrchr(buffer, ' ');
 		p_tmp = (p_tmp ? p_tmp + 1 : buffer);
-		strscpy(tmpbuffer, p_tmp, sizeof(tmpbuffer));
+		strscpy(tmpbuffer, p_tmp);
 		*cp = tmp;
 
 		len = strlen(tmpbuffer);
@@ -452,7 +452,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
 {
 	if (prompt && kdb_prompt_str != prompt)
-		strscpy(kdb_prompt_str, prompt, CMD_BUFLEN);
+		strscpy(kdb_prompt_str, prompt);
 	kdb_printf("%s", kdb_prompt_str);
 	kdb_nextline = 1;	/* Prompt and input resets line number */
 	return kdb_read(buffer, bufsize);

