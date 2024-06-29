Return-Path: <linux-kernel+bounces-235077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD8E91CFB6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 01:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369131C211FA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 23:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B643613B7AF;
	Sat, 29 Jun 2024 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="3HrvFnjb"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82BD3B1AC
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719704247; cv=none; b=r0G1Chrc67i0bpyuAXUbjJNAAzehtFEVACXU5ox6oxDkTwZ7iywadz4DASKhi72RFbFDUqd+PQil3LM8M8giKuMfJ49w7aa8F74VlegEdz9EVhwD3wJxdkBUPDgzHMapsa1/mzhYalLZekI/PsBIdSuNSrUhhHl9rZjFBogI80E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719704247; c=relaxed/simple;
	bh=IBEoI0bvSqitYJRqzPDoW8or7zGkJuOYQ/JpQeLhubU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cb0PzCqUZUl09GwUxetM7czAqAqRNz0LeD8ukTgiWg76XpAbZnqdUxxCIFBl/sSEfqitOsI44+rdB0xJ2Z0EN3QyELiwu/gcRwsnAxgrvn1+Jh+r+LnQ0LyEzOVicHVSchazBtpoUNDdQRUcHRNQ8k9xK71mP+/Rg5Ty1+vID4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=3HrvFnjb; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c9cc66c649so1090901b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 16:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719704245; x=1720309045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3puRN6mg4Kad0heP72+x0UdDRAPxRVJ0rwKkzRspK0=;
        b=3HrvFnjbv8R42DQH8RBAMyz+cUhlrHdxoFIuKcmVTUIV4TFIvGSUUPCsO1XrlN3Man
         Hek+sQOp0wUfhZBdrJp4AbfS+2tP4yACs7vF4CcXKjVPHrEiZKoyCpS4jyS+ypoPJaLw
         76BjNHfVtBazwh2cq4eolmPW2kZ9QunW070n8yL90vmY/skXDIaluZnBaDs6vPqP7NI5
         RMKVeRoVG8uxXy78ikuKBSfzeMN6gxrfODfIyRvXj6Galsausj10b0i2DPRnRFMVWLpY
         TJCGj0+8SCyAP6/qp94rs4tCKv78q9tuytzg82nNYr//bNra92DTvXNBI6O2HrVnjeFJ
         cLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719704245; x=1720309045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3puRN6mg4Kad0heP72+x0UdDRAPxRVJ0rwKkzRspK0=;
        b=YIhdN3iN1ExJqwGM06oH2heHQfJtyp+3N/LTC+CX0pXYnHeqvs5jS5Lil3muL3TDg9
         3fK44W3egdpgb0B9UnjnOXCvQLG7PwN8y9zUEM6OT2r4aaQjfobhqPqFGwuyXXt9C9/Y
         +pgEzUbzfKC1OOPQygSK1WPWO886uXdpPtt1L1MegLyyfPciKM+O38fBi0vS3E6AFi/y
         HwR6Q+5Zoe3XG8tx8ajhDx3gHrC3NCI4iIqoouslIh2bg6QXGskebxszH5LtCB8XQ+Kc
         a4RSV3vGSuU0mag+tUl0eJm09zjLfenWr/H3SEgmiM/QMzylx6t2GQEuopl2vOx9WnTJ
         Y4NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg6C0j8T2GNSeaqP1QlLBd6e8B8keDcKRpF5/nez4B4yZjxWqpD2U/4asQLknOMR4vjNmpCsuh2zCml9xHFbxm/7eSl8ur1wRaWkNB
X-Gm-Message-State: AOJu0Yy3X31Mtsjjz6XNI6qRMy4hXEy7W/sFSC15fj3gf8olLoYtiUR2
	cOQWAWOcd6WJNCwQgF5DmmTAx/qZ12InU/gpvMW+lKKmi1PQ3x0K//v4gYHdp8w=
X-Google-Smtp-Source: AGHT+IG8P+5igDk4ExwABkE2XwoDTVpTr+1Rh0xMCSl5Q2BnEcJHHpU8Ukw7tYI1CUy+tLNvveX6pg==
X-Received: by 2002:a05:6808:199c:b0:3d6:2d6d:e0e3 with SMTP id 5614622812f47-3d6b55908demr2183569b6e.52.1719704244748;
        Sat, 29 Jun 2024 16:37:24 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246ee80sm3791646b3a.69.2024.06.29.16.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 16:37:24 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kees@kernel.org
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] gcc-plugins: Remove duplicate included header file stringpool.h
Date: Sun, 30 Jun 2024 01:36:09 +0200
Message-ID: <20240629233608.278028-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header file stringpool.h is included for GCC version >= 8 and then
again for all versions.

Since the header file stringpool.h was added in GCC 4.9 and the kernel
currently requires GCC 5.1 as a minimum, remove the conditional include.

Including the header file only once removes the following warning
reported by make includecheck:

  stringpool.h is included more than once

However, it's important to include stringpool.h before attribs.h
because attribs.h uses some of its functions.

Compile-tested with GCC 14.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 scripts/gcc-plugins/gcc-common.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 1ae39b9f4a95..3222c1070444 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -62,11 +62,7 @@
 #include "pass_manager.h"
 #include "predict.h"
 #include "ipa-utils.h"
-
-#if BUILDING_GCC_VERSION >= 8000
 #include "stringpool.h"
-#endif
-
 #include "attribs.h"
 #include "varasm.h"
 #include "stor-layout.h"
@@ -78,7 +74,6 @@
 #include "context.h"
 #include "tree-ssa-alias.h"
 #include "tree-ssa.h"
-#include "stringpool.h"
 #if BUILDING_GCC_VERSION >= 7000
 #include "tree-vrp.h"
 #endif
-- 
2.45.2


