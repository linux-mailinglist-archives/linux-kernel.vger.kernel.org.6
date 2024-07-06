Return-Path: <linux-kernel+bounces-243024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C791A9290AC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 06:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26167283D3F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A00134AC;
	Sat,  6 Jul 2024 04:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="vkpyxfoZ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C84BFC19
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720239548; cv=none; b=rNeDNLnT8nSeY0FSrLGo6Su5i/HEgUzwWjyIZEpGYOnebJSveI5OXAd/UjxJfOHY4DfaQVn27EAepiNWtV6yWNAufnF1A3JItdXOAMy47ZF03MQG/TGc3kc3J5OyvL/5OlIPK0BSlGU0qeGzkg3QrmwBwLOy9oXiWDzIOAGgSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720239548; c=relaxed/simple;
	bh=8cZ7LKFs7mJeGc+v4+iPls/B4S37umLa96hNuJxowA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sjcQXUm4WiTbsedrDP7BNx+OtySCa8CR0cCoMHaRcnok+bs+ZeaukhJ7Yl1XTCNE/Soc2PrLPFo/MUVbG5v9/Gy3e3FoSBL/XFbmvxPcY9QLqyrk1IzI42cZEzTs8qQ1aqZ2l9ILKYC7SGx+PZR9TjPT9MykIqiYFWEZvsJb76M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=vkpyxfoZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb3cf78ff3so15343485ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720239547; x=1720844347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RoJJmKmlb6pOf2w0Io+9nkBW5fd81cjrd3TmeWughbw=;
        b=vkpyxfoZm7Ofl7wwSP9uweCZt/4bWi6U1j/er2nPO1ViPWKYOiANcntE43znhFhm8M
         UoShvSQF0muzXsWDdUjm4qmy06f2FV1SvuwqOGs+UQStS3ipZCY9dMZkOP3bbhTOgnND
         lrpWEK1zB4sYK5kMtZ1bh0VpfsL539WeHYA/4B4D2crWzkByAnYF5Wt2oJIm51GuoCQm
         U7TZ4oKaa4EUKeeJvGFWXUxFBIHaHVnWZ1CFY+Kob4iK+CfqyV8bZna76/PnOD33XM2/
         NSWU8R/FUkMrMcWz2sAtd2s1y9wNgTL1sZzcuOkQZdjkvG0HsOa+FCBTIfW9JEDnShBg
         1+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720239547; x=1720844347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoJJmKmlb6pOf2w0Io+9nkBW5fd81cjrd3TmeWughbw=;
        b=vCLJGFQ7mJ1NdIKjuderUvsWc4X3jSrhmuZoOtFWpY5Xp7BR1mJLMtdaJVqqUFtNkj
         g+aWjXH54ttZ4meSQ29DUuK8QVZ0bVEM7mGrLrVKczyykq1rOsfQBVsO6beIlks9tgKn
         AIfvt07CU8S+3INmMI6uxUcSOtW6RYIw7tupNLoihjgBu2GIw10hME3lFRUepr0KDyQx
         FOCkeeDSnpUfc3JhWFNFYyYVWaY7aVzjnb8lRs2H8O+42Is04VB+TknrjIQ4XT/LQYOU
         fhCbZx0GhkIB1ViJz3p/UdTMOQ0RPInwJTQqxjSkNxqR4DVNDs/vbivq2Log+KYellPB
         +ENA==
X-Forwarded-Encrypted: i=1; AJvYcCWtvGin20WS65XM3gKeIMwI04/9OAhO9vEZluK55FIGCAL+9N7LmnOteaKsO5nABU3ZmCj7/3m6rgZx3cwPmxovPEC1d3LQaT0ZW1Q/
X-Gm-Message-State: AOJu0YycfimGjLmlwRrxjR+51JLNR8rzKT3SAun+DdveM7s4aICueD4x
	06xjILzDgrI6fwmIoWRKMceUm+KZG7mrWYgfgFAVWRkDPnVAlmFr4RtYMphg6U0=
X-Google-Smtp-Source: AGHT+IE44+7GX7sh/xGn5Azq1d+Bjhmd9/HHersHY4KzZwGcPBPowkX8B39dDOE78ShxSSXfkGbiyA==
X-Received: by 2002:a17:902:c403:b0:1fb:d7d:73f1 with SMTP id d9443c01a7336-1fb33f34288mr43166355ad.65.1720239546639;
        Fri, 05 Jul 2024 21:19:06 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb3dbd7dcdsm33404705ad.157.2024.07.05.21.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:19:06 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] fs/ntfs3: Use swap() to improve code
Date: Sat,  6 Jul 2024 06:18:09 +0200
Message-ID: <20240706041808.181638-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the swap() macro to simplify the code and improve its readability.

Fixes the following Coccinelle/coccicheck warning reported by
swap.cocci:

  WARNING opportunity for swap()

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/ntfs3/lib/lzx_decompress.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ntfs3/lib/lzx_decompress.c b/fs/ntfs3/lib/lzx_decompress.c
index 6b16f07073c1..d9adb290acba 100644
--- a/fs/ntfs3/lib/lzx_decompress.c
+++ b/fs/ntfs3/lib/lzx_decompress.c
@@ -511,9 +511,7 @@ static int lzx_decompress_block(const struct lzx_decompressor *d,
 			 * quirk allows all 3 recent offsets to be handled by
 			 * the same code.  (For R0, the swap is a no-op.)
 			 */
-			match_offset = recent_offsets[offset_slot];
-			recent_offsets[offset_slot] = recent_offsets[0];
-			recent_offsets[0] = match_offset;
+			swap(recent_offsets[offset_slot], recent_offsets[0]);
 		} else {
 			/* Explicit offset  */
 
-- 
2.45.2


