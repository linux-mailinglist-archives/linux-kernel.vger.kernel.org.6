Return-Path: <linux-kernel+bounces-394223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE1D9BAC1A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2644281844
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 05:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C40189916;
	Mon,  4 Nov 2024 05:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIi0ubwE"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4564501A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730698744; cv=none; b=Kh8LbGfc9CYrTCLtRaDWfzCJZWnIP46gTcf2EWOjrG+LsEMu7xYoH3HrxPuxr+6ND8CwtWUgf4LSCUnFWKxxlu+qupr1GiORFqIn3ZA6iIKdI103VsLCB9+SOY2Ru3JZ1znG3PM2fJpmA0/7oCIam/jrkxofhGCLFrDWWQ+o8L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730698744; c=relaxed/simple;
	bh=N2F0Z+pezwp5AWD+0LxHqGuCFdbPTJShRAaWJR/1MhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gMxmdup57Qx7RUBx/kvnFo9gD1WeBgH9LKl7VLmQTRJe+b49iHIKksZbYvgq3efggOXR9DlA69/9gOL4s0zqWvHsioKitB2QgE54hP7pVg6aBt/Vc82vzIIAW+wW5GsAbYzwffhlk51Cv1GnKiowaKQmcMAslWsQH3VuvZtOkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIi0ubwE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-207115e3056so34797955ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 21:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730698743; x=1731303543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtdowl6ashFE99iWon9UNhidq4cexD1HxOX3fIyG2pg=;
        b=YIi0ubwE0CLuKtgaRLCSQionqTx1I8/NrloBrtEVm7iGtZrrUClgLdNyMzfbDkYLtW
         CCSujZrcVSnTP48nFcN0dWgPyMoQUm3oFC15oFFBXjSzl4xqApzJ6VSN4rJChndWCHyf
         yddPJ56q/ATl5AkSmGwaoxnLRWtxIRMmNyTwm50tLv64sTBrOOTff+AHKNS8sgkFhAwD
         GkzUqezQ5zgcG+KctyHbwASYya9iaVog6pfUDuxbv42vHK52/j5SMEwsRFDGaXVRTboi
         jsxhcm1xqhqfgGQLzr5+228D+RdIJ9WsIf52lDXpxKioAN+Flrd6X9OHAkGOzTWs/c4Z
         xicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730698743; x=1731303543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtdowl6ashFE99iWon9UNhidq4cexD1HxOX3fIyG2pg=;
        b=PU+/l114kJvXp8kr4lw5K4kUp4n1bXGUGX+6NtcQKSGmUxjKogBdBPtR3VniE65Z4s
         mX5C9XyIH+cWfXEnxa6C+gywuDy4AzI0oMrHwVh0BNLAIko8LNXvMaSp534Gsu+PK4vD
         3gu6/EOWJXXel5zWbI6ZHeVKgx996F2UDkNHhrUwlDVsjuYxm+s+YKmuCE2PZuH/RXVM
         AvqtTODjFm02aJXFkgxA/6q3mltpDZ0rBU4cUGxXk/J0HYsyQokQm6MKf0OoI4rbN8yn
         rmsbOBgGCEdMqyidBXzwqOFqeeKlP3T2mmdJFjC0RIVRdLk18Til9B+mvmaHvTfR9Ak/
         styw==
X-Gm-Message-State: AOJu0YxUAEO84xrXH40LMqIGCuopEPnisNKGllLnsw4u8tgkZ9r8ji/E
	BV3ia2TPRAQ3PgOemEyOQuFiRWpdWzSEhCr+jn2KjSmQBh8n1jig
X-Google-Smtp-Source: AGHT+IGRRIhA3wvMiuvTn5Zjq6jUrOXBBpoJmscqnp/9RTU200Yq/bT9XZAXOlIeXV+sk1byX2harA==
X-Received: by 2002:a17:902:ce90:b0:20c:9bf9:1d97 with SMTP id d9443c01a7336-210c6ce5cd5mr340650925ad.60.1730698742539;
        Sun, 03 Nov 2024 21:39:02 -0800 (PST)
Received: from advait-kdeneon.lan ([2409:40d0:1223:a5a8:190e:4c3e:ea3b:84a3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056eda5fsm54357355ad.7.2024.11.03.21.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 21:39:02 -0800 (PST)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Advait Dhamorikar <advaitdhamorikar@gmail.com>
Subject: [PATCH RESEND] scripts/checkpatch: Fix multiple Reported-by: false positive warning
Date: Mon,  4 Nov 2024 11:08:24 +0530
Message-Id: <20241104053824.36672-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If multiple Reported-by: tags are used, the
checkpatch script throws a false positive warning
even when there is a Closes tag following the two
tags. This fix checks if the closes tag is present
after multiple Reported-by tags.

Here is an example of the same:
> WARNING: Reported-by: should be immediately followed by Closes: with a
> URL to the report
> #10:
> Reported-by: Kernel test bot <ppppqqqq@ymail.com>
> Reported-by: Some Person <xxxyyy@gmail.com>

> total: 0 errors, 1 warnings, 0 checks, 8 lines checked

Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
 scripts/checkpatch.pl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..c74519f02180 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3188,10 +3188,13 @@ sub process {
 			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
-				} elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
+						"Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
+				} elsif ($lines[$linenr] =~ /^reported(?:|-and-tested)-by:/i && $lines[$linenr + 1] =~ /^reported(?:|-and-tested)-by:/i) {
+       				 # Do nothing if the next line is another Reported-by:
+                }
+				elsif ($lines[$linenr]  =~ /^reported(?:|-and-tested)-by:/i && $lines[$linenr + 1] !~ /^closes:\s*/i) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
+						"Reported-by: should be immediately followed by Closes: with a URL to the report\n" . "#" . ($linenr + 1) . ":" . "\n" . $rawlines[$linenr] . "\n");
 				}
 			}
 		}
-- 
2.34.1


