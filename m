Return-Path: <linux-kernel+bounces-233009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA091B103
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276421C24D92
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B568B1A01AB;
	Thu, 27 Jun 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0BQOwDH"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6C192B9E;
	Thu, 27 Jun 2024 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521595; cv=none; b=IedlNesm8vBtLIFersqc7dcTNqdoIvF3lusDlXveoEybBYoyXptsR+gsKktGEa9WIiSCU82ZTnSBNf8zAVT5eDANCuDtmNvZmbONYF+1l4c2InyVeneSFURIZpPfSz9l4pw6LupDTEXWodWrufgLSFdEOiJUhTgB/d25N57Ii9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521595; c=relaxed/simple;
	bh=W4qU4oeYH8KReh4HFuS89zwmi3lZBe4STxOdeUihYWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRVhOlxCjSO1+Sz+uUjdGe5hJUUvg/zQ0zTFPsF98TDM8LqUpnf+HR/F4IQM3at+OKBFYgdZiebbPMOVTeLJmb/WYdoBeyXqhT4jwV4+M10xgtQi70l+mRzt59tPB+KsJSYafrSHZG/HsG6Qyaf7gTcP0Nzh7NrgLCU6EkZrAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0BQOwDH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4256742f67fso7549685e9.3;
        Thu, 27 Jun 2024 13:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719521592; x=1720126392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orywsiSsHFizGWPRMJO9II17AovA2NvzyC8C3hh8ugk=;
        b=X0BQOwDHHG39k6a77m68Edx6agg4DCiyndiPoRMrsyBCdsipCA6bibX+Qq6et0dRVy
         T8o7PeLql5wcT0BZKZcnSzHfAFLQfxnGcpq+XeEE/LkPsHsRVggrkFMW73yKMHKiYS1k
         lQV2+FVGcnwKrgThmPBEe9UtsDCO8Vg+O9q1F/94RHR75xRA46F4rKtWkM+HHv4U/KYX
         qBiOB3IHotxsmKRm9GcrpriIzeoPEe2CFVMzHZKkdH16iVmq1G1htAgbQYPIGFWnd48e
         ga29v5c1b1xn190JewuVlD8CMVqlqqb+uDve+WYanqlv5ilg/0GdLyc7sV9WkpmyCMVF
         wTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719521592; x=1720126392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orywsiSsHFizGWPRMJO9II17AovA2NvzyC8C3hh8ugk=;
        b=Jn1q2EBcQ1c00xu65+fqzECCw5EZy1eKPqRpsCM2bNzUX5z4OL6R4mwol2XieFjWF2
         cuJ9Ggn8byeidlt11Sr9A+jTqpuUVqJpU8WTh8habdYc+EbKScCsmjFmGid5WAMRZGoe
         +k4yWqor1n94FoOh/yiNgKtjHnrDLK8TAH7puMlxVW3Fj1iZ0/ofmqRthIwayAv5QWqu
         CQqjSJtU7PNBVJlF7HR0szBaHz5NYuDI+Sv125WdU/6NPcwqaybfx3Llw7CWakIl4zG1
         b/EcxL+c/X6/f8w56r+iogk/bGQatX4YK8Gk+rbaPnSQnrxFih3QlMCEHvQLlnZM2OoO
         qnaA==
X-Forwarded-Encrypted: i=1; AJvYcCXnr1sQyFyN8Bqf55TWfkhzPzx4j3o28Z5BqgyyuUUwzzi9WHP66O6DIbYX0w8xIh+eiDz+LLbgXHChsQcoBCTZTpRtiPmxlHbHBiBpsipQ2RApTNJLJGMmsPR+3Yc/6zuhWkLkrNlftzJWFdprJCe+QmZm/Cl5BmcKCDDFMyc1+RopDg==
X-Gm-Message-State: AOJu0YzmKOmRXX42ycCN23IKN+3qv1VWSIZUGm0L4QHhH3S6M+zbDolH
	whab3weCgNYvv3w6PKafziFzvf/7x3B8qzwXnpRoZYmA9tJtnubkI0Zc3Q==
X-Google-Smtp-Source: AGHT+IFFefpf9EmSQzF2ndA0UUf4D0il0rbi4xGB2yByQtpidlfBs2BCPDHayZyQ7ccf43Ee8xQRGQ==
X-Received: by 2002:a05:600c:42d1:b0:424:ad6d:c2ea with SMTP id 5b1f17b1804b1-424ad6dc5dfmr35864035e9.41.1719521591852;
        Thu, 27 Jun 2024 13:53:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256b068e93sm7216935e9.24.2024.06.27.13.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:53:11 -0700 (PDT)
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
Subject: [PATCH 2/2] dt-bindings: clock: mediatek: add syscon compatible for mt7622 pciesys
Date: Thu, 27 Jun 2024 22:52:57 +0200
Message-ID: <20240627205309.28742-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240627205309.28742-1-ansuelsmth@gmail.com>
References: <20240627205309.28742-1-ansuelsmth@gmail.com>
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
 .../bindings/clock/mediatek,mt7622-pciesys.yaml           | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
index c77111d10f90..17f0d960c314 100644
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
-- 
2.45.1


