Return-Path: <linux-kernel+bounces-341527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA27988139
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EDDB209D9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766F81BA888;
	Fri, 27 Sep 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apfziwkn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6631A189B84
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428962; cv=none; b=eq+QcUDHjePBGwlXEHPgWMbs76gwsdJqGFbWZD1rm+9KIs8VWFD3PTdjtCUQSiYOAwDze/IfXo+JEjNqfmRjUelfxTNPYluEROuxnhAIARZxuaS6KiMohNFZWMLM6prxybxTAiRbArQkcs4PJjn32Xx9kZP7Robet9n9GLu2xh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428962; c=relaxed/simple;
	bh=nUpUWNBamg84qW5iTRwtodgh/0RU7dlLqiD9L8w4Y9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=isLO0dJIq5SALZgfYqx9fJ8AK4r96tJORX9p3ZuwiXeBORZYpxzdiKFMl1xJFG6AixUZVoQgQWHflSppND3RDuFuUAvNBTdHrZUo3FM6IsLl2BGgW+SN1ybWVoA94PoyrE0h8mImaSMjpLK/XwNOkO6tX5swZ9VWlq9PkiiNnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apfziwkn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727428960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DqW1Z6ilDYncO6WIxfWW4lU0O53b+hjUNpAszcdmBJA=;
	b=apfziwknBtr+WIYItHgLf3ZQzODAaXw5/VED5GLVg9mQaPj1ikmr6a5I6CrMy74VUtZjTZ
	jKbwvReYECYU3WOSk683RDsv2Sv+Bn1kP2XQ2z/7qiq6YKZ8NR46NLpdwsK+4ORp2PaZsl
	TOa7rGTuXxk33D1VMh3flhQWGtS+hmk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-v8R9ESJnOxuYtkf_AtrBwA-1; Fri, 27 Sep 2024 05:22:38 -0400
X-MC-Unique: v8R9ESJnOxuYtkf_AtrBwA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb080ab53so14199765e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727428957; x=1728033757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqW1Z6ilDYncO6WIxfWW4lU0O53b+hjUNpAszcdmBJA=;
        b=YAj6KzDaWMG+rggO7hi9o623SUWkTeT8RkMYKaq/Kth4bNRTkTupcyOF2YaxkoioL7
         v8fhV45JmvBDmdTPW9i6R/APgret5BacUwLKzSOo174ifoZCH9tInzHtwOOlyCpFbLnZ
         tkMmRu6/VvotjHbQh8wbbQVhSxmcAOe78pcqGgcXnSVUtAkeWDT15GyUCj8Wd5EKyXBF
         YMieHEhHn1uEgzSubKeojXEIQUY6cRn5B0a1xgJX4WOxH0Tqt5ibstxS5I6lIshWzDT6
         yxJF8A9QlMwwTpYkEsOZ1K5kU9AI68LV2cGf8B1bU0RTVokinr3403KMDkaS4rOzxkAw
         NFAw==
X-Forwarded-Encrypted: i=1; AJvYcCX1/XR6o1vT+wz0JRCJgIwGYJizQByY3dcwo0GIlRcxpJUaZkFDljgl4hPwe9xLbGRLlbGRYb6CoAzjMps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+xCj19SuvJW/aalhldxjcUu7TRurFhxCQjfTQwreeO60s1hV
	45XBwEu/vasVfRGtHipAmAcEmvDzKg5nXKS+wdSkSqZSv8nHNt78xCLnZPoz+PZ0e9nCvCIBsrv
	g+60Hb7QZc3Oq+GBW0+xVzo7YYCPJlyyEvZ1l1PrePg7pRrcI4aWr4Txf9+59NA==
X-Received: by 2002:a05:600c:3b93:b0:42c:b995:20d3 with SMTP id 5b1f17b1804b1-42f58484b34mr16809095e9.26.1727428957283;
        Fri, 27 Sep 2024 02:22:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJWCF/p5auGwFMcVVPbMUAZcGcxwmZH59KUVxG01mmgdWdNTVcOZrU3cbtQVowAR5ZCeffkg==
X-Received: by 2002:a05:600c:3b93:b0:42c:b995:20d3 with SMTP id 5b1f17b1804b1-42f58484b34mr16808955e9.26.1727428956917;
        Fri, 27 Sep 2024 02:22:36 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddadcsm68540605e9.7.2024.09.27.02.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:22:36 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] clk: mediatek: drop two dead config options
Date: Fri, 27 Sep 2024 11:22:32 +0200
Message-ID: <20240927092232.386511-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 0f471d31e5e8 ("clk: mediatek: Split MT8195 clock drivers and allow
module build") adds a number of new COMMON_CLK_MT8195_* config options.
Among those, the config options COMMON_CLK_MT8195_AUDSYS and
COMMON_CLK_MT8195_MSDC have no reference in the source tree and are not
used in the Makefile to include a specific file.

Drop the dead config options COMMON_CLK_MT8195_AUDSYS and
COMMON_CLK_MT8195_MSDC.

Fixes: 0f471d31e5e8 ("clk: mediatek: Split MT8195 clock drivers and allow module build")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 drivers/clk/mediatek/Kconfig | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 70a005e7e1b1..486401e1f2f1 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -887,13 +887,6 @@ config COMMON_CLK_MT8195_APUSYS
 	help
 	  This driver supports MediaTek MT8195 AI Processor Unit System clocks.
 
-config COMMON_CLK_MT8195_AUDSYS
-	tristate "Clock driver for MediaTek MT8195 audsys"
-	depends on COMMON_CLK_MT8195
-	default COMMON_CLK_MT8195
-	help
-	  This driver supports MediaTek MT8195 audsys clocks.
-
 config COMMON_CLK_MT8195_IMP_IIC_WRAP
 	tristate "Clock driver for MediaTek MT8195 imp_iic_wrap"
 	depends on COMMON_CLK_MT8195
@@ -908,14 +901,6 @@ config COMMON_CLK_MT8195_MFGCFG
 	help
 	  This driver supports MediaTek MT8195 mfgcfg clocks.
 
-config COMMON_CLK_MT8195_MSDC
-	tristate "Clock driver for MediaTek MT8195 msdc"
-	depends on COMMON_CLK_MT8195
-	default COMMON_CLK_MT8195
-	help
-	  This driver supports MediaTek MT8195 MMC and SD Controller's
-	  msdc and msdc_top clocks.
-
 config COMMON_CLK_MT8195_SCP_ADSP
 	tristate "Clock driver for MediaTek MT8195 scp_adsp"
 	depends on COMMON_CLK_MT8195
-- 
2.46.1


