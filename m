Return-Path: <linux-kernel+bounces-393401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE539BA011
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 13:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD7E1F21C22
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DF3189F54;
	Sat,  2 Nov 2024 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENWhMp5U"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7E23CB;
	Sat,  2 Nov 2024 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730551025; cv=none; b=id9cCn5alTMdDQ42XKzJuougIzqD+oab9+RcXp5GdaMdqwVlSWC9HjxjHWt0IvC+Dlj9LVdylRsqR46Xiz+Mc02zlVSBIys5aHIyM2WqVOLCtKdq0oC+deZf6b4pUWeQv6dAw5GC7W3okzq1iZZwoMzuen/qVkxECOrDR7gpmec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730551025; c=relaxed/simple;
	bh=o3cGczIHKQnfbWSbfSDf/t+UcIvRs6Lh/GNmK9JIVOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqq/s0lGOx2l4K4T7cF8FlQazQ7hZmCXqlpdYTbplzH2el8lOGjrjJBfUJkaM6k+yS1kAsgk/HeQc4bY7ZIcaEK3WbHjBcZcPXmRAR3KyYPaWO7LS+4EizM4NRUl0Bejl6iYIsva9Foqm9Gx6BFeDWknBDAIaiX25nSFXpSvNKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENWhMp5U; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c693b68f5so30248965ad.1;
        Sat, 02 Nov 2024 05:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730551024; x=1731155824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRKKkSWjDmCvzB6g72QbakGkMRj4v/y3yjNWuNa5zLU=;
        b=ENWhMp5UWR908pFi30aeieYdPlwyiASWima3oDgpvJw+mAcEPRn6XNO7bOK4hbnucw
         Km2+vB416StDyG9PV6bp7alBmQbd0GG0pHxzNUvXCjFazMTlfe00xTz2Ipq6j+Zod2/4
         gwAEi2DxCwtKHCpa2ji55m1/o1HazTPFZ9j7DxsWZYsLMHGQj7FDxwyO55d4dg9aKfBl
         Nqdl5lvpcJG5x/iBsXKuT4NRJB52jmk7N3DaEuS5YeS2vo8lYtiwqGHUePXkb8Gh9mYA
         RlRWgtKzVeg+82XNwOkQN0lkj/olgg+SrpfwPO3qsRUtHogZhZ5UBdWeHgi64tdSPnc5
         YB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730551024; x=1731155824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRKKkSWjDmCvzB6g72QbakGkMRj4v/y3yjNWuNa5zLU=;
        b=TjKmmRF+v8BNMDGY4F0zF/+J98QcBsyJkWTV40wEQw7/nZ/7Z63vcMER48EQL77++R
         tDwlWOSwhpDTn1xZva6zBYeDCEH0pGzh6GUQobmmQzazNu/GV0kySbUL3/tPd+qreMkG
         8wuoTxOmzGqSHxcCxwaDm0Y/dgyU6C9AURuUQUP92cRvzT/6IDpOIW9xBu0t4Noizfxj
         PZ5NusONCdHGByfxspBo9PyMtMh7zthvijaH7ddi3GRohhq9cq1oXjIk/Xa/bEA+CDNo
         5CbzKgUXCUESNYwSLuM6t5ugG995ZajzSrdmfj8XThREFlX2E8aspTlZ7umITloXDhCM
         RE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+F5U3pRY1pFFHJF3fm9Y16OmjZL8BdqOBwSTQwDPtuB+cucVtjTW9YR64dtJ78pQr6GicpU52RfYc8GM=@vger.kernel.org, AJvYcCWV7uqSaF5Uaz9FWQTyCPcQnpbRtbmNOdUS2UZQXjWkxK7AiFoCwfenasA0z18+m/dF0TCmHYBOmdbCpDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxijV0xzoKJqN8d82e3lIW5tNYlZ1VuIri5RVf624R3giYM5KWB
	QebMg0gZGKRuHY7Upxg9obgtnvUzkumlLWIw/Hv7t+sziz2gim/m
X-Google-Smtp-Source: AGHT+IEoDB/7/LJwK88imGh+HQg9IgyIlKZvv2O4c/vMoy/QqfT7MZwQpcPQH90WCb3oFIF3v+9ixA==
X-Received: by 2002:a17:902:daca:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-21103b1c3acmr156262685ad.32.1730551023681;
        Sat, 02 Nov 2024 05:37:03 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40f2:1024:7af1:4d34:94b:fadb:48e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d9743sm33051685ad.287.2024.11.02.05.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 05:37:03 -0700 (PDT)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: surajsonawane0215@gmail.com
Cc: broonie@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH v2] sound: fix uninit-value in i2s_dma_isr
Date: Sat,  2 Nov 2024 18:06:30 +0530
Message-Id: <20241102123630.25446-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030170829.36161-1-surajsonawane0215@gmail.com>
References: <20241030170829.36161-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix an issue detected by the Smatch tool:

sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
error: uninitialized symbol 'val_1'.
sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
error: uninitialized symbol 'val_2'.

These errors were triggered because the variables 'val_1' and 'val_2'
could remain uninitialized if 'offlevel' is zero, meaning the loop
that assigns values to them does not execute. In this case,
'dma_addr_next' would use uninitialized data, potentially leading
to undefined behavior.

To resolve this, a conditional update for 'dma_addr_next' is added,
ensuring it is assigned only when 'val_1' and 'val_2' are read.
A new boolean variable 'val_read' flags when the values have been
retrieved, setting 'dma_addr_next' only if valid data is available.

This solution prevents the use of uninitialized data, maintaining
defined behavior for 'dma_addr_next' in all cases, and aligns with
expected usage of I2S RX descriptor data.

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
V1: Initialize 'val_1' and 'val_2' to 0.
V2: Add conditional update for 'dma_addr_next' based on read status to
skip the update when values haven’t been read.

 sound/soc/bcm/bcm63xx-pcm-whistler.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/bcm/bcm63xx-pcm-whistler.c b/sound/soc/bcm/bcm63xx-pcm-whistler.c
index 018f2372e..e3a4fcc63 100644
--- a/sound/soc/bcm/bcm63xx-pcm-whistler.c
+++ b/sound/soc/bcm/bcm63xx-pcm-whistler.c
@@ -256,12 +256,16 @@ static irqreturn_t i2s_dma_isr(int irq, void *bcm_i2s_priv)
 
 		offlevel = (int_status & I2S_RX_DESC_OFF_LEVEL_MASK) >>
 			   I2S_RX_DESC_OFF_LEVEL_SHIFT;
+		bool val_read = false;
 		while (offlevel) {
 			regmap_read(regmap_i2s, I2S_RX_DESC_OFF_ADDR, &val_1);
 			regmap_read(regmap_i2s, I2S_RX_DESC_OFF_LEN, &val_2);
+			val_read = true;
 			offlevel--;
 		}
-		prtd->dma_addr_next = val_1 + val_2;
+		if (val_read)
+			prtd->dma_addr_next = val_1 + val_2;
+
 		ifflevel = (int_status & I2S_RX_DESC_IFF_LEVEL_MASK) >>
 			   I2S_RX_DESC_IFF_LEVEL_SHIFT;
 
-- 
2.34.1


