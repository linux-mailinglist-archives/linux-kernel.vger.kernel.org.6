Return-Path: <linux-kernel+bounces-235602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73E691D73D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A93F1F234F1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69A28385;
	Mon,  1 Jul 2024 04:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZzGCw53"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6C29AB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 04:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719809540; cv=none; b=l9C5X1eNG1lnKoL0SoI5GV1205AH0r7/AIUf00KbuqennY53tiCKnmAavsW2Ku6xpOIMCktX/wwTUIsRdH394Wk5YiFOiU62DT2f3D8YI2JqdDb/TQQmw63PlcmCuJ9c62Ej/yX+emmYmgU0MkYbgmUS8h1nfoXkfMMULriHtWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719809540; c=relaxed/simple;
	bh=yM1Y5DkB/7ohMR0GEwXVmnGF7Tgx668d4FOpm6Mq1yg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=jOALLPSVgfng2YPApS3DV3z5YRVhcTQvE0S0SMUJv7vjo0E4fh9LlHsa2uUCL1E0NXko/Kygo1z/EEeP1BMq0TsfZxaml+f7vv21/9t+9YycR7B6o8T5ShS+aBFaqeRRlNc16+uQcoqGSV7NzWNrhLScD8KE3IIThQqtSZTESAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZzGCw53; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7066f68e22cso1508625b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 21:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719809538; x=1720414338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+L7BI00lIFylFFLESW6ozge3fM7WKLb9kC850GFECg=;
        b=JZzGCw531pvBThfxHgCtlBUp89MOH0qKmiaHir1/grcgLukjv6p+xamwT1v8CVcxFo
         nOw6O7FiLSRqnL5JP/7D46+LcNs5cgeKqUoHgULTRsySQtCqElsMJx9YDhSRNEMxiWui
         X9j+MLAy5AVK8YVbkjXtg0Oix7fYyarbelngFv7OLGor9VJCnpmXx31hCgSnK0b9kYQO
         d9MS58gPaEFn1u3VfQTikVA/HM21g/HzuemyROHvIfQbSFTlK3tXgwkFMY5waNR436u6
         SvmM4rIl6rkT6TNe5A0wqJ9/0vILRrnFf1twiPWHQz6fMAXeZBnTX6Fxg5Ft2Syd8/64
         CRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719809538; x=1720414338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+L7BI00lIFylFFLESW6ozge3fM7WKLb9kC850GFECg=;
        b=q9GlWTryzmxnRDt90rRlQSmdVRkBj79CsHkiJFoE882k6RUAMhnFGiN/BLUgK9y1Eo
         JpzUpKzljzRc8hY7af5nxQCyhjx83+tvwqnnTJJFVbnLqnY9hHFOh5kdA27+PjiLGM2j
         vBGh6qTvk9//DP3wu6vZp8+nEsbFCop1f/DoZY/NJWMORoqPNYTXWfwS9/baClmXsOsr
         V0cxlOct8PXbqphKrTr1hX05beIPiN87L0U90GkI5Y4sOoEVv+ZbS+KNonQQK2HanQhW
         vxTHt6e3jVqtbAMkp3tSWkE20OO58uHyuUXIPwuAf3NarmXnj9zE0Kt+ctLxMjhkdCe8
         PmJA==
X-Forwarded-Encrypted: i=1; AJvYcCUNhomWKSePiVWL38gM4YG16Lx1bhEVlet9wbX0VTMRivN3JoK93CIyXq7l2bULEvno18DMrpSWH1VV6ZTVZEcu7iYcSik+mBl7ZtkO
X-Gm-Message-State: AOJu0YyqDJl5EGBpWszsif9Nl2m40PjjTRBKBx+aZGRNkCtbmoldn1eH
	XCweagLS0MgKLRIimOgKEPHD3uCfnRB2Lh/ZYAWzGAbRS0yYZRce
X-Google-Smtp-Source: AGHT+IF610b9OyUPP35WVsNJmw68/ZgQqgi5D1JVTHEUov/7kMsegjHXm8fabI2r/qp9jntWMqBdmQ==
X-Received: by 2002:a05:6a20:3948:b0:1bd:fef5:ab0b with SMTP id adf61e73a8af0-1bef611b985mr4019720637.8.1719809537499;
        Sun, 30 Jun 2024 21:52:17 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:80c9:183c::26a:88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1568dd9sm54238515ad.182.2024.06.30.21.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 21:52:17 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Qingfang Deng <qingfang.deng@siflower.com.cn>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: fix use of uninitialized variable
Date: Mon,  1 Jul 2024 12:52:05 +0800
Message-Id: <20240701045206.162103-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

When building the kernel with -Wmaybe-uninitialized, the compiler
reports this warning:

In function 'jffs2_mark_erased_block',
    inlined from 'jffs2_erase_pending_blocks' at fs/jffs2/erase.c:116:4:
fs/jffs2/erase.c:474:9: warning: 'bad_offset' may be used uninitialized [-Wmaybe-uninitialized]
  474 |         jffs2_erase_failed(c, jeb, bad_offset);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/jffs2/erase.c: In function 'jffs2_erase_pending_blocks':
fs/jffs2/erase.c:402:18: note: 'bad_offset' was declared here
  402 |         uint32_t bad_offset;
      |                  ^~~~~~~~~~

When mtd->point() is used, jffs2_erase_pending_blocks can return -EIO
without initializing bad_offset, which is later used at the filebad
label in jffs2_mark_erased_block.
Fix it by initializing this variable.

Fixes: 8a0f572397ca ("[JFFS2] Return values of jffs2_block_check_erase error paths")
Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
---
 fs/jffs2/erase.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index acd32f05b519..ef3a1e1b6cb0 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -338,10 +338,9 @@ static int jffs2_block_check_erase(struct jffs2_sb_info *c, struct jffs2_erasebl
 		} while(--retlen);
 		mtd_unpoint(c->mtd, jeb->offset, c->sector_size);
 		if (retlen) {
-			pr_warn("Newly-erased block contained word 0x%lx at offset 0x%08tx\n",
-				*wordebuf,
-				jeb->offset +
-				c->sector_size-retlen * sizeof(*wordebuf));
+			*bad_offset = jeb->offset + c->sector_size - retlen * sizeof(*wordebuf);
+			pr_warn("Newly-erased block contained word 0x%lx at offset 0x%08x\n",
+				*wordebuf, *bad_offset);
 			return -EIO;
 		}
 		return 0;
-- 
2.34.1


