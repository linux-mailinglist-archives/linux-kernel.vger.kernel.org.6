Return-Path: <linux-kernel+bounces-290523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D595553B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 05:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB45FB226D7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 03:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1CE62A02;
	Sat, 17 Aug 2024 03:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lScIDgoR"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6111433C1;
	Sat, 17 Aug 2024 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723865391; cv=none; b=pel9OcpTHuHhjeHjnrrAC8W5DLswOw6xvkJG4lU3xbr0hETWKJFTYYLj1UlJIRQsJi/j5CebXWXTOsUoIAeL8i91DZOLIWtPm1Z77fkHvENCJqlsXKlbHA+DPl0x3ttVXA/O9Dam+QahnwO9uL+aXtgAHUOFc8q/ufDSxtXvMcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723865391; c=relaxed/simple;
	bh=YM1nETZeUDVOTFYq4eUKmA+a8rDFjWUQsCnGQDKH9HU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U460XBYXwIbTCsSQb1LT6rKg1VnJzcvdsyLlcsFXT4GGoICsSVmF8lMa2om6RpvFNP8SFMViJFguAqPaAeeOWvM2KPn84Ph7DPmgCRx2GiEMcfTxbcCTFGrDGVu4pvY45J0GJYCRPoClhPzX7qZuCcLHCC///SCFfDW/F9wcZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lScIDgoR; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5daa93677e1so299909eaf.3;
        Fri, 16 Aug 2024 20:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723865389; x=1724470189; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTyY/x86OeA5fpS9gzyMRtV3l6VUfvYcD6M+6PxGGRI=;
        b=lScIDgoRR+JOvZNSMBAvwdPe8A0NrNfHdImfdgbbHkThCJ9ypzhBndSvXQYw0dfzTO
         csFjq5M/IPb/aBaC1JvFQg3jMqzmC/nGMY59txOR+rjhK4uoYUR9iFboDTCFzjKjoTs1
         Xrnz9yXmR21bX75ziqSbtKF+8Ut/d4zNI8DNfzHqo2wxho5B3OiPPvl4YnTs7r96NEb+
         +8vfhXgxG3xTovPQ5W5ammOi16rQCubRewM1/tNpDiKuyuS2TSdZa+E+apK/ujZihHTX
         6bFU5oO69VmrM72imewgGrVTLuliKvaq6Adclnbaq30IjSXQqatmH/UUPwkLocqnCux7
         hizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723865389; x=1724470189;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTyY/x86OeA5fpS9gzyMRtV3l6VUfvYcD6M+6PxGGRI=;
        b=LPKNFw5J2nNytgI2pwFdRCGileXhlvvNsxbyefvVQEQIOLGVTFpbSrSlLLWTPL7C6h
         B44NGKH5WUfzbmu4Wy3qWN/7OTVMjXy2+fkh+kdePAcaiRQkLYxg/vjJrP4UzvgpdPT3
         g3oUv43Q/+4/UvuX5p2EQLSulOJ52/b2JK3Rowz5qMs+v9hYUAx8JlxnE1z54sT5+PLL
         e3Mp2JvW/+C9xTif7NOn63UkhIwWAGcpY4nIC/JexOGkU73sS0NCjQzuWH8qivp3e4Is
         dYZrnbX8pUyR60sbBdfPX1yvXUR6lLFanmDhDWSeQD0Wi2qYCOsYbDmyMT3TzACsMlh4
         39WQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4mGSt6Zr9nl5Hn7MPlP5VM4bYXdvNBZR2yfitnxrvmIruz14uO5JrlYb108IHkVsq0/Lgmv1Nn8kNn0bh@vger.kernel.org, AJvYcCXqfYjefPqb3CHgXiqFgK+iW8yGhOT3c6ts8bvIEfcPcOd8+jmZKvc4Ex9UN3sRLvtXdjuKpw3OWE6i@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9QpTxd4MUGGtRqvT4XkkIjO1t5nEPsyBWxGOu2Ca5/wkymJC+
	f2Z7xvVi3ZpgxjBZ6B76T+SC1GOfBOvk06sloFNSxeYE0u0LSX+6wGmUFJ+3
X-Google-Smtp-Source: AGHT+IFbQqY6/TbfsHuYrRYQAbOuk75Xx6EmcoYD90bPnzfw1nlcCRAyX/OfCL4jlkdAGR7fWttDwA==
X-Received: by 2002:a05:6358:7202:b0:1b1:a961:7977 with SMTP id e5c5f4694b2df-1b3932d79f7mr605156955d.29.1723865388634;
        Fri, 16 Aug 2024 20:29:48 -0700 (PDT)
Received: from localhost ([115.96.207.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac842f83sm6472300a91.37.2024.08.16.20.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 20:29:48 -0700 (PDT)
Date: Sat, 17 Aug 2024 08:56:29 +0530
From: Aryabhatta Dey <aryabhattadey35@gmail.com>
To: vgupta@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] dt-bindings: arc: convert archs-pct.txt to yaml
Message-ID: <emosjjbdwimwevrf2ew2dpn5sdx254el5fanhhquouu4bz6nbe@zqyp5ra7bmhh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert dt-binding archs-pct from txt to yaml format.

Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
---
 .../devicetree/bindings/arc/archs-pct.txt     | 17 ----------
 .../bindings/arc/snps,archs-pct.yaml          | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arc/archs-pct.txt
 create mode 100644 Documentation/devicetree/bindings/arc/snps,archs-pct.yaml

diff --git a/Documentation/devicetree/bindings/arc/archs-pct.txt b/Documentation/devicetree/bindings/arc/archs-pct.txt
deleted file mode 100644
index e4b9dcee6d41..000000000000
--- a/Documentation/devicetree/bindings/arc/archs-pct.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* ARC HS Performance Counters
-
-The ARC HS can be configured with a pipeline performance monitor for counting
-CPU and cache events like cache misses and hits. Like conventional PCT there
-are 100+ hardware conditions dynamically mapped to up to 32 counters.
-It also supports overflow interrupts.
-
-Required properties:
-
-- compatible : should contain
-	"snps,archs-pct"
-
-Example:
-
-pmu {
-        compatible = "snps,archs-pct";
-};
diff --git a/Documentation/devicetree/bindings/arc/snps,archs-pct.yaml b/Documentation/devicetree/bindings/arc/snps,archs-pct.yaml
new file mode 100644
index 000000000000..532f7584f59f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arc/snps,archs-pct.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arc/snps,archs-pct.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARC HS Performance Counters
+
+maintainers:
+  - Aryabhatta Dey <aryabhattadey35@gmail.com>
+
+description:
+  The ARC HS can be configured with a pipeline performance monitor for counting
+  CPU and cache events like cache misses and hits. Like conventional PCT there
+  are 100+ hardware conditions dynamically mapped to up to 32 counters.
+  It also supports overflow interrupts.
+
+properties:
+  compatible:
+    const: snps,archs-pct
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
-- 
2.46.0


