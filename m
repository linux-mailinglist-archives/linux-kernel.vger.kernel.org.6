Return-Path: <linux-kernel+bounces-396176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F0C9BC8F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBBE2820C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206CF1D0E26;
	Tue,  5 Nov 2024 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pg1tl8xo"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B411CF28B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798364; cv=none; b=N44VG5ECG0lvI/MDgQdgwhm5oxsU9Lrx+azZKUyLFZ7vsn75yRcHxkX8IgENZEO+Lm/TKYpMdthPjldmBrwcdzqFxBj80R6JFjUxVqvI85CPkAmWJ2Ck1sGBbcyJro4EJDv6s/teiQjarEI/KXfN6OfckquXEgc1j7+qQ6C7Nu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798364; c=relaxed/simple;
	bh=T4lfPA8S9ixb3LEM2QOxvR7XTTqcM7Y8IyvOeRDKLNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dcBl5yBTY0BvarWcHO6G5NTm7g581UDwYWmTs0ViE7Uz4nvObUt8G3/1005tqR74Q/6StyVvS1Me3IYD7lQ8UORren3y60qWjJENSeFeHWBAFzCIWE9Wr+jJBaeGBTrgnhucj0z+Fv6w8+AfZRS744WevDSx5u1BUhyiulkvDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pg1tl8xo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720c2db824eso4769108b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730798362; x=1731403162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LW99LC0Kexi86oGAcb2ljvk1jhRq1I2JS+rEVFAlaw8=;
        b=Pg1tl8xo9t2aKiuSC/Iv0U8IZ+eCGe01RiKmydINKypkzVA/TXhfg8TbTUWSojNsWA
         rPqEgpuJw9afTkiE6QC90FEB1cQ5BhyKdYnXa7hezPo9Z8SLomvSUosRzk+ang4SgzAY
         aVYEiHiSNzZ+eOu+DGf6DeljFxnV3P9MJnTZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798362; x=1731403162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LW99LC0Kexi86oGAcb2ljvk1jhRq1I2JS+rEVFAlaw8=;
        b=gx07njGd66pUeOlK060DIu90joTkY20st28sX8BkWD0i8e+Z9GMFQ/ZjXv+POMX6ZU
         vlfnrFnQBn+NJJugZ91tJDqU3LuDXp+pSGiJK/Vxf7LKUcjpBPGSjTtn+HQ7VOr1vmch
         KNgGIliZT0jxuLGnTU/r57PBr5V/uKHyd2Uah3uXsS/kjgsFdNag/i/2ApFKa+KOfeIM
         +0G4Jm8K15nzkMVjf6aG4fhUhELQ58wOEyLxcaAvF8HYu4vPv0NDS2Y8k30drxk6edqI
         q8EL0MYj2CF4yaj2Dr8tzOmL1nfiaAwmefEBXXvUlgxRVjrOKoWTeF/0B5r7Jf1A6bay
         0Ong==
X-Forwarded-Encrypted: i=1; AJvYcCWGB/6WAn/Eg6H/9HfvUClafenIjYF/lACe4HzCIBudfqFq2UTScrOO3Wlp5hqm/u6jZsn6xk5lqeQHviQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhIdBBRpERH+n3ogy3IZfqm0g7gBOhIPWTHl4ri/3x1HwA4KcB
	sQVN0CkEO9yDxwy4xgdGIz7dpnOro2OOJFjrKX7KpUv7JWypr60xOxbO0AfQug==
X-Google-Smtp-Source: AGHT+IE+RQFeVzw8zbEzlCI6PqWB5TBlBgH4MxGi/9juWqisHT1+H2kFPqs8VV8Xihz0bbOqadeYvw==
X-Received: by 2002:a05:6a00:8cf:b0:71e:587d:f276 with SMTP id d2e1a72fcca58-72063093364mr47257026b3a.25.1730798362339;
        Tue, 05 Nov 2024 01:19:22 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:20ee:3712:ce0b:1ed7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c58f7sm9337566b3a.140.2024.11.05.01.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:19:22 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Yang <yangxiaohua@everest-semi.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: everest,es8326: Document interrupt property
Date: Tue,  5 Nov 2024 17:18:11 +0800
Message-ID: <20241105091910.3984381-1-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ES8326 audio codec has one interrupt pin for headset detection
according to the datasheet. Document that in the binding.

This fixes dtbs_check error:
  'interrupts-extended' does not match any of the regexes:
  'pinctrl-[0-9]+'

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 Documentation/devicetree/bindings/sound/everest,es8326.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/everest,es8326.yaml b/Documentation/devicetree/bindings/sound/everest,es8326.yaml
index d51431df7acf..b5594a9d508e 100644
--- a/Documentation/devicetree/bindings/sound/everest,es8326.yaml
+++ b/Documentation/devicetree/bindings/sound/everest,es8326.yaml
@@ -24,6 +24,10 @@ properties:
     items:
       - const: mclk
 
+  interrupts:
+    maxItems: 1
+    description: interrupt output for headset detection
+
   "#sound-dai-cells":
     const: 0
 
-- 
2.47.0.277.g8800431eea-goog


