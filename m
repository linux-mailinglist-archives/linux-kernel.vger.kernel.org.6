Return-Path: <linux-kernel+bounces-291156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D7955E15
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98AAF1F213B4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C69E154C0D;
	Sun, 18 Aug 2024 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfeksvOZ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7984E15444E
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002171; cv=none; b=ltzJ5/lV+lgdmgtH5/XMnuRBii+2C0dM0bxFmF1p+AmCjIN+QHqA1q9R7s71rTaqJGh3YV93+p86hgdDPBZqHzIijlRkkbSaGa8rd4YYj72/Q+D1Q40aqQGIKAQ5s9XecgMvNL+rzTndHP/HctonNgdqFyChYbStmPEoSDeZOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002171; c=relaxed/simple;
	bh=IzXNmmwt+Tl+gyDcsho6rwUZ4oeczOxFCQboMpLHreM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9h78YZLcp4zpjIujrFD4zHNzXjVrhFFXu8buStWnTeXQOYG5Hjh9HsQJPgsTdmuOIpfdNxrjNPeI999S4Fki5jLIEBCO0Pg6ms8Ocs9xLLgtL4VsYrs4sOGBIi9iZSk6byqlxT2/5fE2qIrd12lNl8Gue5fAhhpRz6NXe+3tRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IfeksvOZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so26893085e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002168; x=1724606968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/9tQ897SoJoKRxcHTwzo+1/+UNdl3vt4A49QU5zusg=;
        b=IfeksvOZtwNT5btuATgDA0tsYSBomnilgSzmwbH5CDJaiGO3Wb3HEg2MZ0f+sbRsqF
         Q+teI2WvW1dR7UWue4phvCZIolR+dzqL/pp3W3L9+fRGgUfQ7VmDFSYVEKX8ExwNwc1I
         cTlP9BnKCV9ltLoo3mLmmCWitfyhexsTkV1jlkOKZNd8t9e/4lUyDpeylU3gFmxjZsOE
         nmDhOP/SxJXl8IqZbGOpOSwFVlQ0q3kXP3CbGS+/Z6uAf1fdpmzjAeiGPEaWSSDmVNs4
         nqq/VNEtdCzyM4ibdL9xix/r8Hi9DxZQ6vF0FhZzYEvUwQOpVW4JRmV1t2onUtBIZCTL
         QGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002168; x=1724606968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/9tQ897SoJoKRxcHTwzo+1/+UNdl3vt4A49QU5zusg=;
        b=TDARfdTIelcT8i+1r2QFRzGR1YV3Usj12VFWQiXOqmkAXTDFtn+25sNaVObI4pwEx6
         uYKLWioEWejLJZseo5MlEyT4Y1H9xtIFL4+RDJ/Z03sfDmb4cQPYvmv3GQ5fc6g/BLND
         MceUs1nGVaHNqSOXcBjKjtMIarxuQ7DK+tGHvyhVKByBoFRSnQlFp68UeGB0ip8oMqvC
         pqwfvpd3hAF5+qZT5/0zyte4WGvPWpVlxkiYjmK15D6j7k0WVsxfWZFJl158RZsGsF5s
         GqTA5u1nvBEMsX1BUc4axGt3GrNqGoOuy2pK/4nugz5tJAUx4yCzezSaZe0Ozlk0lXRQ
         CUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnTBRWyRZ7K/tvNMeVnZE3BxbQwt3XZvJjReXcXyg7JYQ1RuZwLvzSK2C+6sLmp7p30mHy7BpWpwhyKA1bIoTiWgk/0XJzyLTbBy2Y
X-Gm-Message-State: AOJu0Yw2RrYdT15WukJ/mCLTr0/FTVvOX6DfIK+zy9xugOH6DC/Wa0Rx
	l00Tls7jXxvcWJvaJJik7xCvz7kSAV46DSUcHKGmPXjQ9xv3ahO4uVsvNFfdWIs=
X-Google-Smtp-Source: AGHT+IGiYgeRZDRiz4IGj84gIL7b9E6DsEXj2RlYhiQqBRKLtHy9lgTwn3H/JttaoyXN0G/AZU5nFw==
X-Received: by 2002:a5d:69cc:0:b0:371:8711:4b23 with SMTP id ffacd0b85a97d-3719464c461mr6360403f8f.26.1724002167672;
        Sun, 18 Aug 2024 10:29:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed785708sm81742005e9.37.2024.08.18.10.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:29:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mmc: renesas,sdhi: add top-level constraints
Date: Sun, 18 Aug 2024 19:29:23 +0200
Message-ID: <20240818172923.121867-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properties with variable number of items per each device are expected to
have widest constraints in top-level "properties:" block and further
customized (narrowed) in "if:then:".  Add missing top-level constraints
for clocks.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 1155b1d79df5..6d4a1faa1c4b 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -77,9 +77,13 @@ properties:
     minItems: 1
     maxItems: 3
 
-  clocks: true
+  clocks:
+    minItems: 1
+    maxItems: 4
 
-  clock-names: true
+  clock-names:
+    minItems: 1
+    maxItems: 4
 
   dmas:
     minItems: 4
-- 
2.43.0


