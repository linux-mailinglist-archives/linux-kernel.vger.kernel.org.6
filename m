Return-Path: <linux-kernel+bounces-233786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3A291BD40
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3011C2131F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8283D156967;
	Fri, 28 Jun 2024 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYoK0saa"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389444374;
	Fri, 28 Jun 2024 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719573497; cv=none; b=JZ2A0rnPdekn0PFnN8coPea8hwK2IDUSwGfjI2xHutzcmPRTzsKauaCuOfmcv/SzGTUe+YfkGuiRMawY8LNCQ25J55wVRwr3WjLi3m+3/QxuqS8A/MomIc7jHT7P22tQxnIudAXU+QDNp+tgMDhR4NYWrA62qAGeDDN0o06peb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719573497; c=relaxed/simple;
	bh=jjoqqDqblGrGqFau/qCZ/+dyhF/oGX1o7bJOsP/hCcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdVoaYtuSmi1Ul2k7VdxdRx5SzzVy0jO53TcLWJPNWoYFN+SqFLRPgb49cF7wN4s/XQgeSR52wsMqzh2djIUM6YdkPK48Y55KXV2sN3jkPhezRyvr+e1K3EC70CgGBmaOQK/pJRVpluswpW6TptvfbV+qptXNiMCBclCYXXgksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYoK0saa; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367339bd00aso412358f8f.3;
        Fri, 28 Jun 2024 04:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719573494; x=1720178294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGjvAzjDwlAq0rCpEO+mGer2SS+9hXiF0BPt0Wfq6d0=;
        b=BYoK0saakmAwJf6/GJhrxpqg7vlHdCromvqMhm0jGTQsD1Dxhaut9rC93kKZ1x5qcI
         3S8KJythO6h2wdZLZ60I3I49h0qE1/J1GWxyULP1M3usN/MbdznDuw5B/lAa5KwqVnj9
         FE4+MXT6SQ29cvhTfxTQgY3oQJHgbQ70pqSWnNuEnbl88nioE348bvIzVrWVPHwsuA8T
         8XUVyKrmMnH6Pewk12S7DeEuKlxrTJG+tF5sWdJxJB7Xv+7JpvJUoxmrh95bgSU950Iu
         LX+nRw21hO5z8xNKQJKb4QRVDmexq/LKu+Lg2cYC86Wqn7YfKbUSIpCbClPOKgk5mF7p
         ieJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719573494; x=1720178294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGjvAzjDwlAq0rCpEO+mGer2SS+9hXiF0BPt0Wfq6d0=;
        b=X+oVe0OuTLL0vwTV80jVtvN1dUPMN8yxjBB6iBHjbqUqmTqNhY4ONmw1XMdfedCM0G
         UORPbFArvxO3zcvqpVkIAN3dUwzObm65YLdFvk4mmp7hBpgXbp0bdrY183ZiRXCwkNZI
         Fj4tKcqb40HfOq2F4Us7aqbkQB0qRhaYCacnPOblMBA9osHYmRaPzBEnnNKwh2c5iGQl
         t5hgohQn6ERKyHqyjYJyE35C27QN8/fCxUY9BeL2ctsWzOP4pzqx4IBkWUiix47YzJbe
         9eZ3aMem3b+sesBxjQXz9SJZ5RIn4fkcifUjh0fzBom7mGIfdW3eIAvU/5YlojkX7Z3i
         AoBA==
X-Forwarded-Encrypted: i=1; AJvYcCUzeHNi/AqjynFKqNTjqdrFtRn0JMcp/j3sV6Z+urRcb2rfwv6S7It9mGO6ohwjHAFglwiZEmiVKI7gfFv0ccHWld3lcTVGX+cLZc/bpm3GNxfKTDCUTi9/w61z3CeZn2SJzYSOP0NUVnmJVUZVusg3NvNIl2Bkh2kQ213/hCNUQ9KbhQ==
X-Gm-Message-State: AOJu0YxxqXmdkIr8n6o7FKUgh/iquGE7adcyHZmhS16AyZ+4JiNJZBqy
	/x3LSxpTdfYkdVNw/DFUEnzF9tCbNDWUuN+KSxBg636/4hn9L5UO2U5Viw==
X-Google-Smtp-Source: AGHT+IGpmgVVWhDU6L0Eg9bKaM5Un6mfYJKGEM6lzS/aXInSUCuH83Z2b5aWXKfw/hIZ/mcUBgHX5w==
X-Received: by 2002:adf:e507:0:b0:367:4165:ad4 with SMTP id ffacd0b85a97d-36741650be0mr3754348f8f.16.1719573494282;
        Fri, 28 Jun 2024 04:18:14 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3675a1055b9sm1979495f8f.95.2024.06.28.04.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:18:13 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: clock: mediatek: add syscon compatible for mt7622 pciesys
Date: Fri, 28 Jun 2024 12:55:41 +0200
Message-ID: <20240628105542.5456-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240628105542.5456-1-ansuelsmth@gmail.com>
References: <20240628105542.5456-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add required syscon compatible for mt7622 pciesys. This is required for
SATA interface as the regs are shared.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Fix broken schema example

 .../bindings/clock/mediatek,mt7622-pciesys.yaml        | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
index c77111d10f90..9c3913f9092c 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
@@ -14,9 +14,11 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt7622-pciesys
-      - mediatek,mt7629-pciesys
+    oneOf:
+      - items:
+          - const: mediatek,mt7622-pciesys
+          - const: syscon
+      - const: mediatek,mt7629-pciesys
 
   reg:
     maxItems: 1
@@ -38,7 +40,7 @@ additionalProperties: false
 examples:
   - |
     clock-controller@1a100800 {
-        compatible = "mediatek,mt7622-pciesys";
+        compatible = "mediatek,mt7622-pciesys", "syscon";
         reg = <0x1a100800 0x1000>;
         #clock-cells = <1>;
         #reset-cells = <1>;
-- 
2.45.1


