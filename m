Return-Path: <linux-kernel+bounces-246884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C592C86E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5133FB22268
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA852A8D0;
	Wed, 10 Jul 2024 02:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAqzLw4n"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DC9224DC;
	Wed, 10 Jul 2024 02:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720578175; cv=none; b=AoJJuemnGFQx/Mqhs5uCNTzdFdm8q5MI/RASCaajLjgKiwgMlUS1+A+zm5QhfEGONjiiWQyNtc2dlLAomniqHFDJCe/2jW1X/9VZHKGMGRwg/FA5oj0K1F9162Q8jJgSCH+z6fz+5XpIl4BDhNOZ5zG5Mg6IswybeE1koWHEo5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720578175; c=relaxed/simple;
	bh=esG2baiJdE6vahPg8I9WxWcxxqWDN/1eo3gGA0Kxg4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HWSSG1o/eSoBxkBvfGjx1KhRO7E6cMB0nWqpPUdwwjvSeyp5jwB32QjC61BFZDf5daNkUG7w46tZngLOt2jZR7ZCdbxtQ/L0EHXcFoXpKOsuFVH+XKb6jk+/Q64JuMTqZHfxbHSyaZF5BcY05RoeceF35859QPO7PmskZ9pc8K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAqzLw4n; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-767506e1136so252497a12.0;
        Tue, 09 Jul 2024 19:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720578173; x=1721182973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+ZDbVG/Y99+yBdm+TuUFC2L8LW4XjvaG/3/t0EYbiw=;
        b=bAqzLw4nO7BI+7PBHlXggIscMzh8GSZRU5MqpVl7Ar/Hx3usZgW+12fBnn8flIhS5t
         BLDnvaRbEZYQshFCym6TtnWBsgGS76+liUR9ykWlb6TU3b9dy8cP9WYszwbLSD8nArth
         tiN/ZxcAJmORpZCidquHTHyDbHs+a+/r9SQnBEXyUCWeUbUVUIz3KbIHGCXZSbiF7iud
         75zWqG+tT/LBSmTCGbBTKAzqQCG4bjD04L/QPO78AMhuZ+mPzZhPrGZt/LLTRcBHumKC
         uf4FmL6nj9PF2OaDxkJhm2ltbuYbHsPBVWHcF5kCvGwsXM7mP8Cfk5jpe3X+qTI6sGze
         eJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720578173; x=1721182973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+ZDbVG/Y99+yBdm+TuUFC2L8LW4XjvaG/3/t0EYbiw=;
        b=HLL3643bH10INl/30mqOvBp5ZrdnrloXBduO7C4wOQhyWd8M7QuEthAcPjQLVHVowj
         EqAOKyFf8hiLAxpzGEzh+Tv8pZWrX0zuP94xV4197H9rFLrbkTy3EDGdEmavjc5/mAfj
         m+N8L9DUQbRGhN9ioLEyjmv0MGjzY0kipGfst0c0puNpNjF7I37JHAETb6dKmjPG6ML1
         XDMqI8rahNGyyEinnJL03jC7k/sXk7SlQzKXvNhOHwN5pD6ud51I2r0b3MWSUDu3hxRC
         qFIcwOwl4qiCj1IRj/OsEByt9ps5zTG8pMrU1zfvPW/3yfL4OX7BqKssVVFJxdl5OK5M
         q91g==
X-Forwarded-Encrypted: i=1; AJvYcCV/dxjYWMFS1aBcBvrjLzgDbOLVwhNUA1TtjXBzfqGIwKp42uQhNHxsRSEMCSzN5ZwAAMLTAxLyMDd5s/+Or7MAERfvZEtq2oVstw3o
X-Gm-Message-State: AOJu0Ywv59pelsmWJu+Wnlnn860oWE+wDeEa4HvduXvVwzQ9R9yE3nfO
	rjhi9EAgFpmads5bN4Lp9H0pSm+YvcAnC6FPwVQoWbXbF9UFCqiE
X-Google-Smtp-Source: AGHT+IHD9dgbyjWPV3/KHG/FDuQ2ePIegEDkKiEL+FqpDRfaDvYtCr6tfTfiokeMU1yy66lxZcBokw==
X-Received: by 2002:a05:6a20:8423:b0:1c2:a29b:efb4 with SMTP id adf61e73a8af0-1c2a29bf269mr3912393637.24.1720578172878;
        Tue, 09 Jul 2024 19:22:52 -0700 (PDT)
Received: from localhost (66.112.216.249.16clouds.com. [66.112.216.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439678e9sm2539162b3a.137.2024.07.09.19.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 19:22:52 -0700 (PDT)
From: George Liu <liuxiwei1013@gmail.com>
X-Google-Original-From: George Liu <liuxiwei@ieisystem.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	George Liu <liuxiwei1013@gmail.com>
Subject: [PATCH v4] dt-bindings: vendor-prefixes: Add prefix for ieisystem
Date: Wed, 10 Jul 2024 10:22:49 +0800
Message-Id: <20240710022249.72234-1-liuxiwei@ieisystem.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a vendor prefix entry for ieisystem

Link: https://en.ieisystem.com/

Signed-off-by: George Liu <liuxiwei1013@gmail.com>
---
v2 -> v3
 - match Signed-off-by email
v3 -> v4
 - add link
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..a559ac5789ae 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -609,6 +609,8 @@ patternProperties:
     description: IC Plus Corp.
   "^idt,.*":
     description: Integrated Device Technologies, Inc.
+  "^ieisystem,.*":
+    description: IEIT SYSTEMS Co.,Ltd.
   "^ifi,.*":
     description: Ingenieurburo Fur Ic-Technologie (I/F/I)
   "^ilitek,.*":
-- 
2.34.1


