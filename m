Return-Path: <linux-kernel+bounces-196681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB9A8D5FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA161F25427
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F39415624D;
	Fri, 31 May 2024 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="glcQAAKI"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9113D63E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152151; cv=none; b=jfIHO8q19u53oYVu06ClALrCI7OS3GnSYgMQn1YrC8a78mUpC0oOhg26VKWqUcg7iNUxx8OAwcWFhr0tM1HkiQ5pa2mgvB9fMxIA3aSo/APXUaOxz7gFkkc9ch9j4ol1is2G4d1Cjemn1V727Hn86t5glR/TvGCkwjGzQ/XOLEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152151; c=relaxed/simple;
	bh=n1UFMEc2a+ip6lozAo9tSQX9hcHUWAUFc4VcwZzCngA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSJhX36oKpqRQUQhxxXN3rXKm6RCjG832kXjBXhDTyJXKbi7gunAQ6HmncPoDJmrusSl0jAKyXADiY7HxMdM1XwQNela00VcDCwbZ8NEKQYGQIf5Sp3N23DrTX+xvhAq66gpECiiCln9t7Mjfe0GTHU1kvjgQ7/2cKdPSGkVNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=glcQAAKI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a626919d19dso356188466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717152148; x=1717756948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISXVPcsrr94mEq5TpN2s7NC6skzoD4RhjRGS9Vh3EGg=;
        b=glcQAAKIPtevmkols0ptwp4vXUnTq3ggGXUGqJGp4nmRWxebORGuR83u5oXlEoDxZa
         NizX4UyS/K2CE+lFON78HZCBlJTCph2h+bYARnf7hae7dGyw0NW4X/5TReS0Ot+aqmq9
         0JFSl+js4NVKl2jETpdzswaxnJq9cSVsM1QQVzajWYHhZp9y4lkNLYEhOZpPssUJ5qVI
         SuqKvY9ociPSHEtT9kSW2tLV2Df5I/ephmISdUXSGrg06DKNS3jShkisJHt1yP1OpfCv
         4ouZEyXYNNF3NYhtRqUzDqdWSAPWR/bz84/Y3zBhtOzmMZG6esYkw+vFLdxlqS+IvIe4
         XdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717152148; x=1717756948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISXVPcsrr94mEq5TpN2s7NC6skzoD4RhjRGS9Vh3EGg=;
        b=MvEu5NvzIL4xyy0RUErJ1mTZcnbWQ4c7TyERbEoqejeYDqWUGlxf24TTVOQ4ep1KzJ
         KlWVeJBJ89lT0rp6MR0AUWKQXZ0l/ZUBhED+Ijc5wojjOa5aerengwMKGflp+OE8EvU5
         g49ULKQA0cvGErGsNefyGTYJx4gWPhc7QFecVN7Gk3cCx3IGNt6bh8ddkjZeqNSaf08G
         W3NSKX6e6/3b6zlSLTqt+cxdAxFs2RQUEL1lt6DllrXSn2vuNkxTL9cToM4n+5gxh7X1
         uXEGtzo9qqI9qL3zrKQoiaYPMelb3ySeyaFvG7GYatT56uzMXVI45/5uUSTd0i2a1CR/
         VbCg==
X-Forwarded-Encrypted: i=1; AJvYcCVZfGRsCykgXmiGljxwQpPFTX481Ec8pYMd07Bwr0DxukwxFEIOD5teFvJMME1pFLoU7QmqkRfguUTlak1V9RqLIvw2FXDiIL8NSxlW
X-Gm-Message-State: AOJu0YwmlxPcSjLDw2pddocD666CynmTJZlfS+I5T5RvuVqRE52BfApU
	seyG3EuDijCnzUTWt+E18br7CS8dbOyUoNKN/R8Jg4/w3sgiHEH1+OrcvB20hEQ=
X-Google-Smtp-Source: AGHT+IGzX4FmK/DHUc3XXLdjOJ6iZO10jtCcTWxg7hbg8WBqNvQwsHc++hdIf+MCsZ/hgXwzq8um4w==
X-Received: by 2002:a17:907:bb84:b0:a62:5094:817 with SMTP id a640c23a62f3a-a65f093f6admr348929266b.11.1717152148161;
        Fri, 31 May 2024 03:42:28 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-160.dynamic.mnet-online.de. [82.135.80.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c9bc0asm866578a12.79.2024.05.31.03.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 03:42:27 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] jbd2: Use str_plural() to fix Coccinelle warning
Date: Fri, 31 May 2024 12:42:00 +0200
Message-ID: <20240531104159.564605-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use str_plural() to fix the following Coccinelle/coccicheck warning
reported by string_choices.cocci:

	opportunity for str_plural(dropped)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/jbd2/recovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 1f7664984d6e..af930c3d0d97 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/crc32.h>
 #include <linux/blkdev.h>
+#include <linux/string_choices.h>
 #endif
 
 /*
@@ -374,7 +375,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 			be32_to_cpu(journal->j_superblock->s_sequence);
 		jbd2_debug(1,
 			  "JBD2: ignoring %d transaction%s from the journal.\n",
-			  dropped, (dropped == 1) ? "" : "s");
+			  dropped, str_plural(dropped));
 #endif
 		journal->j_transaction_sequence = ++info.end_transaction;
 		journal->j_head = info.head_block;
-- 
2.45.1


