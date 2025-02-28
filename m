Return-Path: <linux-kernel+bounces-538025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 441ABA493B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4001887D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4842512C3;
	Fri, 28 Feb 2025 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRieokzY"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A88F6B;
	Fri, 28 Feb 2025 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731830; cv=none; b=g9kSwfOPf971uoj7ocGwG1Ll/p7nTlJxUkWkpVo/+Bcs3mJ+Ub326XNYfAJ+adL1Tfbr+e0b4/Snb5O0dQvG7fnrWTkJjzgst02qe6wxwOBnqXvzEUcGDk9bY9RwhwX++BZ5CjMk16GYSRbE1zLnEcf32kef8mGq7CtKacFpVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731830; c=relaxed/simple;
	bh=iHiRNdH+KFNaZqiPcYsSwcL8n4jnbuJvjPdyjBAQp+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CUp18qG7Y/9Z8kFgTABm+6ejh5Pos7LMHGvVmFMxTm66b7sQi9qigQMdqyMBKsOrblIkzoRBKm72Yhq7BEX9/cvUoRbOeggaCfrKBx9uqVeKmE+Zi9kxOBIryf1MAiOb1ertzOLkrIYAuKSmT5CCnH/NJVFncqQ6RooC0ujTEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRieokzY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so11930465e9.2;
        Fri, 28 Feb 2025 00:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740731827; x=1741336627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PX9T+rP9CC7EvLoe0Jx75LYBu203Hhbldl2vmfUt5nQ=;
        b=nRieokzY2nUkpnL6CsU/tslULZb8mDFMokngozG4zGnZzvQ6IggtVPj/2D9L5FQAub
         liudCqSM+sTbWPUZXCq5/Ymmpz/z0C0ooPoDqW2uF4NG4eH5LBxVOslWjc5hsZAqU6Oi
         TWTXxYiwcrjc4o1xRUkr6zM5gmyDQLQjO4inT6ufTFwLmj+kz5t3JQxO2jxYlXwb6sfg
         yvpmjArVBFkWRAFPsx2yCPo9Xff1puQvvVvGdBw+pyk8LsoSyKoUQLD/OIdV/DKouVmw
         /QgrsE3Fy/GiZvOIaLZ7SHZBMXYbbkBiIemRAbOjbSsJZ4f7I7fxqFFsy3lFosDMdrJv
         EDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731827; x=1741336627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PX9T+rP9CC7EvLoe0Jx75LYBu203Hhbldl2vmfUt5nQ=;
        b=Q7LE7/miljwoi7XQUls4CF16GCWpg+T+poPV2do9dqh13HTdfzAylpFBXMKMt7U5al
         1dKuhYPJDHGAJD19y22KN5NqoPKXwmdrVW6pUE207VpyVqF/HgjNUy3c0w/CPESK5bbz
         pPafbNZCe8uV1FQ/uBBr9VRLFaPH8o5WNBt7VRmjOnUUWHQyYZybeYiIAmHzmpsE4DtY
         z5bQ6gI8DR12KGHWeyieF2Q3cOw8ffAfsFqlKfy2EeUq+pOnZ872kxlCaWC7fvNf6eAB
         hO4XfaiXAc/LubBMlh7P2Y+5t3JhSjOhMIzzJBuYHHQpaH83IAqj8dE+tdQyFv+ohbfr
         A8uw==
X-Forwarded-Encrypted: i=1; AJvYcCWmk/NoBkqPEzuGJK7qu9hgWPpZHxxAKeoUGp9sHo+B0c/oezOz0Er95o4/y8ZPdeAmG0s6zPhzPZY1Y2E=@vger.kernel.org, AJvYcCXYHKraDvOxwJXDoRqfNoJIJxrtwdlPsc6ud4e6STrdxa99BSFIxVLDB7WoCYpJYTRGerCJNlJXyq37dKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBnn5T9zrrSHR1/jX52bi8s6nuw8Rcjh2bf5a4JRo1F/2U5sOu
	GNQ7IXxYC+r2UfWiAobuf2+XfOrKYl4pFJsjrURCw5Wp0qsQvHpg
X-Gm-Gg: ASbGnct7Zuzxa36MMzkXkk/2G1YHz/jaR5CdXOrFv4xL77tH8aXnfZSQjl3Y/j+BZtb
	zin7K4UZeAaz9vj9/NTtEYZ6C3txsZiP7qPSTx9/tCp69WyGVQQ8mfT/wmcp56Dm5jP7wwodFYI
	S9AwsTPvEdgA9NlGDEqQB9NLr9nvIhc4TgzaOesrxBHbrdI9B1HIJoHc7qSX/fNnAN4XCWgwBr5
	kvyZfVC4K+sGjCC3+cx7gFscp0M9xVxl/32xqF5/rJy/cKUUJQEPflh6QOiMJX6aLYAwdCW14Kl
	Wd9Xsn/0aI9DIHYd/Vk0BnVJjGI=
X-Google-Smtp-Source: AGHT+IGKtBXnAxwKr6WSIpLjGkowwxL79Uai/VAiCI3qG0ApVeeVhNw9AiVdWLtob5QmA69nC2ljIw==
X-Received: by 2002:a05:600c:4ed0:b0:439:8ec2:a9dc with SMTP id 5b1f17b1804b1-43ba6771538mr18212775e9.31.1740731826920;
        Fri, 28 Feb 2025 00:37:06 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43ab39ed2a6sm65936305e9.3.2025.02.28.00.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:37:06 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: es18xx: Fix spelling mistake "grap" -> "grab"
Date: Fri, 28 Feb 2025 08:36:31 +0000
Message-ID: <20250228083631.676877-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in dev_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/isa/es18xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 59c784a70ac1..e35c727a52fa 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1735,27 +1735,27 @@ static int snd_es18xx_new_device(struct snd_card *card,
 	chip->active = 0;
 
 	if (!devm_request_region(card->dev, port, 16, "ES18xx")) {
-		dev_err(card->dev, "unable to grap ports 0x%lx-0x%lx\n", port, port + 16 - 1);
+		dev_err(card->dev, "unable to grab ports 0x%lx-0x%lx\n", port, port + 16 - 1);
 		return -EBUSY;
 	}
 
 	if (devm_request_irq(card->dev, irq, snd_es18xx_interrupt, 0, "ES18xx",
 			     (void *) card)) {
-		dev_err(card->dev, "unable to grap IRQ %d\n", irq);
+		dev_err(card->dev, "unable to grab IRQ %d\n", irq);
 		return -EBUSY;
 	}
 	chip->irq = irq;
 	card->sync_irq = chip->irq;
 
 	if (snd_devm_request_dma(card->dev, dma1, "ES18xx DMA 1")) {
-		dev_err(card->dev, "unable to grap DMA1 %d\n", dma1);
+		dev_err(card->dev, "unable to grab DMA1 %d\n", dma1);
 		return -EBUSY;
 	}
 	chip->dma1 = dma1;
 
 	if (dma2 != dma1 &&
 	    snd_devm_request_dma(card->dev, dma2, "ES18xx DMA 2")) {
-		dev_err(card->dev, "unable to grap DMA2 %d\n", dma2);
+		dev_err(card->dev, "unable to grab DMA2 %d\n", dma2);
 		return -EBUSY;
 	}
 	chip->dma2 = dma2;
-- 
2.47.2


