Return-Path: <linux-kernel+bounces-181264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6638C8C79B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939471C20BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2ED14D6FB;
	Thu, 16 May 2024 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py/wJti1"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F276143895;
	Thu, 16 May 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874561; cv=none; b=AUZhVI25hM4Lp9HOLAogXXgeu/SyZSZj0agXVvi5/53SHuhS5ECz9COE7j8qPMEZEXaEt5bqZ5YVbdsyrT3Xx1LoKhAyLMRXeuNFlmRiwqmDMf5Mj8HEhpCCtWjiU6GRWbZhsQ/JJPqhT+QYmqO0+RBfSbyuukHTTB4TG4g9pd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874561; c=relaxed/simple;
	bh=wfc9VQJK5Afzwtxb9r3z+/jPpNeZSRtEpwlC9GhpOcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKn8pjr6qPsfXtomm8LUU7Br7mH5C2Fg17TC1iEnigb6UosR0uPjqjsQ+8zfekiY8DoOeSuhuSO6oY8HbMt5ihQIiqV4RyPaDxjkpdYj/jG5BLNikSVyq5iOp5xW9vs3+50C/MIXmgOWThrGPkxGm/UdxLezJYgrqIYuY0nwckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py/wJti1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so268851266b.0;
        Thu, 16 May 2024 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874558; x=1716479358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN0HWELzWPP6jJjK5+LZsOG8u3erO+3FSJ+XwrEDANI=;
        b=Py/wJti1G1GCvO/vU7jytgNj71cbwYFPZ7GKOIBm+0g2/PRxuxLBbDOhTHc9Qxuv8/
         dhqsgXcS3AeRPo8QSL85FcpbXYBFqJUb0fZ5/E01O3iz/7E9EW/NdngOyYB6ooCqjJ2j
         UQQ5vPooyv2NRAEdB1Qjls/e8SynD0GyH+QydFJmfAlfCQXDCzuO5KxfDwF3YZe5oi43
         nghzsevV6zBqBdTCmraEfgL6GDROnluJg2G57D6a9MHdWDUcfeu/K142eXlJ8Md9HNBO
         SN4B1uZ11JR7CTJSYDlBowwtUPM+cI/rwkEySvgXFuhuABZm22iE26mRFmBaPQP6UFYx
         nPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874558; x=1716479358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN0HWELzWPP6jJjK5+LZsOG8u3erO+3FSJ+XwrEDANI=;
        b=pMR9glBru33gSLwAMWsqgDaQMEdKip+E85pBxbOxyvlu0u0xLki5OTv4Idu0azvcvL
         7xBGgQo6Bk+xKaaQVepyVpHToXsoGAUU3iSFfNbvzpJCOpyWakqY7Zt8IJv07/lIR6i1
         Fu1RuvfGHm5rPTn8YSCs2EomiIbHDNHGQsKMW3nHc9eQhQO/ZZiJyNUVaBzpe+T9j/ft
         mAbBYsDe7KFef/rYTGkR/PMbACd/2VyVyiRoX6b0uXteYrRRMZJ8vFVMpqkyquWChVHG
         O/G+jQyMlqBBRs7UTYNBar+B9eqvAaFNhfkzep0MY7EMC3HNbi90PnEz3W57S7UJ3AcC
         l20A==
X-Forwarded-Encrypted: i=1; AJvYcCX1ofcFQVWzWgtS0J9CQ2hgOO4mnl94r4fCHphyeGd9AtG4PKAXmeP3X6CNEMOVdKkrTAv/yyO3Dpl/xGzhvvYJsYDdpNqiZWHwPTORFw6x/6ms58SAfp0MLCbZxU+PB8LBoCbNPnFuwQ==
X-Gm-Message-State: AOJu0Yy9Z83KC0OOgPll9HxznKvC9N8Xg0iv8gSHk1truAJ2fWTLgcCE
	0OmdOowFe0mBTyOw/0Emr30PXoyPDJ9NZ3o6PR9Yjeyi83cnzqCH
X-Google-Smtp-Source: AGHT+IERYx92Rlwx7iwIKLFWJU1Ps4oBdoBXeUTwYjOFi/cb0RLbPXfM/kqnvLGpNRDppH+Y+2YxUA==
X-Received: by 2002:a17:906:3e4d:b0:a59:edbc:193d with SMTP id a640c23a62f3a-a5a2d65f29fmr1736318466b.55.1715874557589;
        Thu, 16 May 2024 08:49:17 -0700 (PDT)
Received: from localhost (host-95-246-50-43.retail.telecomitalia.it. [95.246.50.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d787sm1007125766b.11.2024.05.16.08.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:49:17 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH v2 1/2] ASoC: es8311: dt-bindings: add everest es8311 codec
Date: Thu, 16 May 2024 17:43:30 +0200
Message-ID: <20240516154800.125284-2-matteomartelli3@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516154800.125284-1-matteomartelli3@gmail.com>
References: <20240516154800.125284-1-matteomartelli3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings documentation for the Everest-semi ES8311 codec.

Everest-semi ES8311 codec is a low-power mono audio codec with I2S audio
interface and I2C control.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 .../devicetree/bindings/sound/everest,es8316.yaml          | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.yaml b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
index b6079b3c440d..214f135b7777 100644
--- a/Documentation/devicetree/bindings/sound/everest,es8316.yaml
+++ b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
@@ -4,18 +4,21 @@
 $id: http://devicetree.org/schemas/sound/everest,es8316.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Everest ES8316 audio CODEC
+title: Everest ES8311 and ES8316 audio CODECs
 
 maintainers:
   - Daniel Drake <drake@endlessm.com>
   - Katsuhiro Suzuki <katsuhiro@katsuster.net>
+  - Matteo Martelli <matteomartelli3@gmail.com>
 
 allOf:
   - $ref: dai-common.yaml#
 
 properties:
   compatible:
-    const: everest,es8316
+    enum:
+      - everest,es8311
+      - everest,es8316
 
   reg:
     maxItems: 1
-- 
2.45.0


