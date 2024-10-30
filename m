Return-Path: <linux-kernel+bounces-389260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152319B6AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89EE2825AE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E090C215028;
	Wed, 30 Oct 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWq3jTvR"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA91E32C9;
	Wed, 30 Oct 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308132; cv=none; b=ADUgFAZq5R3mmO8mXmivcZAQB8e74rDEXGJxRDNlJWpKuua1FFANGWgRyceZMyC2zf5Nn+CnC5aExI7jSBwxzp+4rHEKiF8eQ19gfjfmANLHOkbPMjB2ndCLNLMXAF0a6OVPIMj5KSskbqE8TVJF4SqDA2RrN5jUPcay70VkSDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308132; c=relaxed/simple;
	bh=zLzWsdqdkLdo5yQoNKWpUaGcI3MxjgSYvusBwRn8BaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kgIRNb0dKRcuJNDsIzt7BprRtsU5xEn91VgKN0GadGXlEanOBvx83LbhYy+rtXxGiNpsr9gXz2fVx+wNKeDly3e45XyAhmu/rUrxotyY/1lhdcwqHtMGt52EkZVERzEsogZUbWm9etLSHQJxr7tdp7PctUp6GJdUsJAFQ9Q+cak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWq3jTvR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cf3e36a76so832615ad.0;
        Wed, 30 Oct 2024 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730308130; x=1730912930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZtsE52QkN9iFiKaGSL0zIc6WpdAz1ZQ1OR9aOWTY/g=;
        b=NWq3jTvRttLJ4M0ZdfXUxwLRsih6BV7TM8e5xeY3uMyPlcyqrIiw2ypTyBxCDjpw18
         NJ1v6WOHYVns7uEFQnuSIDcUzF73mCVe8lrb3kK32WVNygD7XoOGdwtylq3zawCF3BfX
         0m4PqI6XOiJSkvxhjUBZdPa4gfDWPp4qdq44C2uq28E9EtXH7CgPvnOqyh/OMWHcSH+3
         uW09ODT/IwYccRtA++FBx/PfokRIKEqaHladlXP4slfAYeOjlqfXMsgyzKxZWHmon4hf
         lCq9Bofjnpq9k2qFT8l+8UAhmgD54hb7TEn+gnzlLsYC4rcR224aDgf6eDPZ3fJyPsPq
         T7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308130; x=1730912930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZtsE52QkN9iFiKaGSL0zIc6WpdAz1ZQ1OR9aOWTY/g=;
        b=bTaHey92Q8FMDVcQUF096LXOuTVABWbAxlLicSNMG8ZAAs31zuNV8UKszpaWUqMwaD
         1RQQ6ut2fQn97PASL6DoeJ6t/G+Mb1UcoNrMyEWthbG3O4CKyW5e2h5BGxU47edRdqCN
         ijcTvPg0rXVryEx6uqPpU7ID8M4sGlOGapVjG+pD3Jw3/Fu9iZSiZbZtorVbXG6ihGqt
         F4u5f4OTIACSbSjutvL4S+7f2gb5loSBIAxarCtbLdh+5ENG0ESeP0X3avlxDnqua+4u
         ndA1Fy1TloWz9A2YM/LcjD62bO9suU7ZXEsGoHbH9gZJzE3xVZI7/h7k9d5J5dxQ+Ei2
         jVWw==
X-Forwarded-Encrypted: i=1; AJvYcCUIVBHv3KTG1O0ObNMuvl4uvlqMcqz8N1Vu2w7KE0SHGtFObPGilISK7Dbq/oJRzgv6odHrwfeDPzVRS50=@vger.kernel.org, AJvYcCVvwSk7n61p7ByF+lmOWbyBQ2qZ3bBHZFrxOMHSybg40bmocHrhsH1Pcexx1l2luYo9EOpMVfE4OSBmkEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzngAxG9SLZJ7/+p2ycHb0L6mdFIpA4DjxqSxCY31sLJfHijlq
	6NAVqzszhbrH8vfUlWZJgWdQa/rsNlbtFLjXubQC2osVpeX9kjYY
X-Google-Smtp-Source: AGHT+IGE5cJy+TKfk1C9J0HtLczSUIJb6WS87avDkG+MgkalMLNZnSQF+iNlT8S56Gl1cpzBqBeidQ==
X-Received: by 2002:a17:902:f54b:b0:20b:5439:f194 with SMTP id d9443c01a7336-21103acdc27mr1700765ad.16.1730308129335;
        Wed, 30 Oct 2024 10:08:49 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40f2:e:4b75:7d7f:c4fc:66c0:77e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc063e7esm82339525ad.276.2024.10.30.10.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 10:08:48 -0700 (PDT)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>
Subject: [PATCH] sound: fix uninit-value in i2s_dma_isr
Date: Wed, 30 Oct 2024 22:38:29 +0530
Message-Id: <20241030170829.36161-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue detected by the Smatch tool:

sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
error: uninitialized symbol 'val_1'.
sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
error: uninitialized symbol 'val_2'.

These errors occurred because the variables 'val_1' and 'val_2' are
declared but may not be assigned a value before they are used.
Specifically, if the loop that assigns values to 'val_1' and 'val_2'
does not execute (for example, when 'offlevel' is zero), these
variables remain uninitialized, leading to potential undefined
behavior.

To resolve this issue, initialize 'val_1' and 'val_2' to 0 at the
point of declaration. This ensures that 'val_1' and 'val_2' have
defined values before they are used in subsequent calculations,
preventing any warnings or undefined behavior in cases where the
loop does not run.

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 sound/soc/bcm/bcm63xx-pcm-whistler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/bcm63xx-pcm-whistler.c b/sound/soc/bcm/bcm63xx-pcm-whistler.c
index 018f2372e..5c23c228e 100644
--- a/sound/soc/bcm/bcm63xx-pcm-whistler.c
+++ b/sound/soc/bcm/bcm63xx-pcm-whistler.c
@@ -232,7 +232,7 @@ static int bcm63xx_pcm_close(struct snd_soc_component *component,
 
 static irqreturn_t i2s_dma_isr(int irq, void *bcm_i2s_priv)
 {
-	unsigned int availdepth, ifflevel, offlevel, int_status, val_1, val_2;
+	unsigned int availdepth, ifflevel, offlevel, int_status, val_1 = 0, val_2 = 0;
 	struct bcm63xx_runtime_data *prtd;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_runtime *runtime;
-- 
2.34.1


