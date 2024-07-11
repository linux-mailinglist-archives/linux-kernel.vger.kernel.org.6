Return-Path: <linux-kernel+bounces-248847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C292E2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D730B26411
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C1C15218A;
	Thu, 11 Jul 2024 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ILQLNCf9"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A17D1514C8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687489; cv=none; b=j7YM4A0cMiMs1DtqhjizvqbcYYE1h/NNdvldisbGmvWnZlkd/dfFxU9LM0xLrMPQFqeNubscUk20UpYi+Btxn+PU8Ak7sLWFFQmubzJJ3qukjgoibJ7Rm0hqNxMdi9syBQKFD9TBVSs6GdNRKrBdGhhQlDcsPhNmvKtyl5OXPNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687489; c=relaxed/simple;
	bh=f7TRHfNvwagNjQn0+Bm9Bf2LxyKqZlmh+fsFQb0vzrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=poxCyYO45jM1siNBYBTy1M0R7yr2JdREFBMqm8FlNoyAZcXYQ3WOyMAO6rQZ55pp0TRcM50N21a9hY3+9F4eHPp2ILnOivQM8CxSILvyw7JxG/yiUnwo8v+Ehei//Pp+VcVifqVTGgk9Ony2ZSnlQYlOaaC9qr/VFImOzZlOWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ILQLNCf9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36799fb93baso347796f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720687485; x=1721292285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w84xl8Y3F0+wt7yk4xgIfVPoRjH+R3/bz+ZyGkK2r0A=;
        b=ILQLNCf9/6nea/52t0SJ29HeWQwCUluCsqKd/Frrb5mTjpmay2MMGuK+uJUhSZixHe
         rjyQ7TYiL5jyITV81dkFja2pY97dDvHg4N2hY9Xi3B4fiXTuv+0be/dyJG2+ivqB2KwY
         2rKChyh6lUwHW4E98/x2ZnwxW4PDz4A8ndbGof8XKYzXHYjmdvIivZq+/qV6F8qbyO1p
         T76CIOixUjLaMksq01BrZGdT4nB9SwjL0b42/VyCNAbLeVV+YPFKZVH9G17Z8XM73Qrx
         HwkTpDTeWuYFDQLfI7r+lhPuapeqnXvPrLJhAbyzZzyhHTyMHdL06aNLH7zld/OIOKQp
         iIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720687485; x=1721292285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w84xl8Y3F0+wt7yk4xgIfVPoRjH+R3/bz+ZyGkK2r0A=;
        b=gOnsyU0vS29FsS05lYKRV1XMK9PdEcmTVO2Ui7VqZ6X/6WXHzDAk1tsWwtnb2UddEH
         SMls1qDisuzsAyXr9XuLI+VFkL67WAwgeABgEUdQovarQ9pwIsGbyHmufIPDVFfYWgNB
         eHH/j3FMjXwk+7v4c6OexYkqh7Dr3VNtXOkaTba043T8eIiXQRCfcxIEbSUsYdgyTWfM
         Vg4Cqm8Ag1F9npyhByjkdeFv13ehq/Wf2Po9bfXIypWjoZ/dSjyPIx6g/ZIzm8SyhkAb
         TGWRgMil128ggFTq80pLptMr52BIw862I4SzLxYaPH0NIreRe/CK0ksT0ysPwvT2EuS6
         wGcA==
X-Gm-Message-State: AOJu0YzkHhiwH1D1Pojkijh38kmSMTXUiQl6uEmlJ9kbcLAADde3X0aW
	bmCPfExbafxY8BtLiT5LFmE41VP+AlDL9iPs3XQCh81KYMdXdMX8Y81hmXED0udHRObKbz+TMAi
	V3pc=
X-Google-Smtp-Source: AGHT+IHcsX/3ApNweLCTUuqlWjawC95PiiJXDRaEgg1sHRt80HO87mQkMY3yMCRJPOsQAy/2J/uo2Q==
X-Received: by 2002:a5d:58fb:0:b0:367:8875:dd4c with SMTP id ffacd0b85a97d-367cea7368dmr4449606f8f.23.1720687484600;
        Thu, 11 Jul 2024 01:44:44 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa06desm7221511f8f.76.2024.07.11.01.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:44:44 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: akpm@linux-foundation.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] bootconfig: Remove duplicate included header file linux/bootconfig.h
Date: Thu, 11 Jul 2024 10:43:16 +0200
Message-Id: <20240711084315.1507-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header file linux/bootconfig.h is included whether __KERNEL__ is
defined or not.

Include it only once before the #ifdef/#else/#endif preprocessor
directives and remove the following make includecheck warning:

  linux/bootconfig.h is included more than once

Move the comment to the top and delete the now empty #else block.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Move comment and delete #else as suggested by Masami Hiramatsu
- Link to v1: https://lore.kernel.org/linux-kernel/20240711002152.800028-2-thorsten.blum@toblux.com/
---
 lib/bootconfig.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 97f8911ea339..81f29c29f47b 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -4,8 +4,16 @@
  * Masami Hiramatsu <mhiramat@kernel.org>
  */
 
-#ifdef __KERNEL__
+/*
+ * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
+ * run the parser sanity test.
+ * This does NOT mean lib/bootconfig.c is available in the user space.
+ * However, if you change this file, please make sure the tools/bootconfig
+ * has no issue on building and running.
+ */
 #include <linux/bootconfig.h>
+
+#ifdef __KERNEL__
 #include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
@@ -24,16 +32,6 @@ const char * __init xbc_get_embedded_bootconfig(size_t *size)
 	return (*size) ? embedded_bootconfig_data : NULL;
 }
 #endif
-
-#else /* !__KERNEL__ */
-/*
- * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
- * run the parser sanity test.
- * This does NOT mean lib/bootconfig.c is available in the user space.
- * However, if you change this file, please make sure the tools/bootconfig
- * has no issue on building and running.
- */
-#include <linux/bootconfig.h>
 #endif
 
 /*
-- 
2.39.2


