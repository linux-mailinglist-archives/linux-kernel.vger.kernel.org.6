Return-Path: <linux-kernel+bounces-226668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3359141EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E21F1F24305
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65317C60;
	Mon, 24 Jun 2024 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKghoiXp"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78E18C38
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719206954; cv=none; b=dPmszk66Toqv/JV0M9u8UoavTxOWEiwe6L8+/pvVINfIaaQrTPSzWWI2aBy1sin9ikmtPvAiY+RoCBx8Hp5vLL1Gxf9BtZIAnkeo5zhm5bGW2YssuWedFIFfGjCUcofdRCUpFMP7MOk5VHsqwhhgmccPZyri468B1JuVy4ZU3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719206954; c=relaxed/simple;
	bh=CfPZiFmfp0Qs9eggBxskJJLc/pbaINcjbBZ7ulzGj0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pb41t0X/Zc0djXePLs5dG6TkDcoj8Pv6YVcVZxbzwRYNcl8u7gIJ1QgDHXafM8HjA6QxtorIXh47kYSqTMtxqXFtORpeTPFEe2pxzXdIFtoAJifOLh9DI+mOZFzskg9nyf7pomdZ6+HiSKFgKONmJgraFM4rBw7SWp8AppdIH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKghoiXp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfdff0a9f26so7306156276.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719206952; x=1719811752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xRFts49NKsibYysZG1mN4zOHSnI8JrcU21XVbqexR8c=;
        b=wKghoiXpi08EVp1V0jFehKzn5khACAp0ZlqZEoyhaLFuUKRSDcEo6BuJ0nUf4QwBUk
         atWdDw0ZVoFkaqu60HBarPcaN1AJ+AJmFRZp6K9pQ3ihzQLAnscjuMf5IlXulYZkiPTf
         SvMp1BgZWJ6AGCvnUovk5igM6s+HI413qF+FxTWAzrzxEZ8ZJvAGTCpZ+KG59X++QxEz
         EJZAU1soRSglgNFNh+fn0lK9ttEH7nzI+jf7WjLxdjQ7szU9U22XeTzF3PrmKwjNNIc1
         JAQgdF05g9U/Hf0oKv6/gsQWb0Qqz8N7H19SLgSETQ9Q2NpvrSFQ+CTAi83/0WPwml3I
         xwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719206952; x=1719811752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRFts49NKsibYysZG1mN4zOHSnI8JrcU21XVbqexR8c=;
        b=GQGflZaLDjFyM4xPDQK7X6jJZdGBm5Gyb/Bl5mAd4g5TANlJmMAO+WywNtNteIR/vf
         9g5DHCdW9rcsMWSwB5lPKkxXs9/KPvfL0Ayu2YAnf7kkjpXB9U1+Sx6omwfHYLeg3Yrv
         FQDgXbwvJVkWrTqzjIypYBb+sUSB3c0KI9pL6uZ702z3wq7R04+QuPo7+iNxukhekOL8
         hkoweUFg6uyJDA+zRWSrxJ5wmsR5cik0gun7cjDcwpfxh9PJSB9i/ahFaXFPHUK7YP+3
         L3gyq30AhFir7P0D5cl3/Nl9piJHTsgXYukIA8YHHRfeobUQnA+j9oc5n8Fa6JFQz2rW
         agqw==
X-Forwarded-Encrypted: i=1; AJvYcCXLdt1trHoZLoJJnkT4XcH4Xf1C2ZHeL7DFuv+/pM+xnez7UQC/CNNY8jctmDXm+KLhSiCV6EwHJ0O1PYiJPdqI/GfgmErmCz3aaU9/
X-Gm-Message-State: AOJu0YzR/p5asv07IcR7DklcFAbGYJec4r/rGh8ZUTCZABWGAYGvIdXE
	G6xgWCSxotzB7zVoJuSlMNrTeangTfpi5eYS9a+Mt2PIcgguys93nFgHj6HlsNm/ZDU3Ticxa3n
	yXdEIrZhGbhgb+fpr79qvmbIlxw==
X-Google-Smtp-Source: AGHT+IEPFtuLDU7qM5B+Hh1VvGYKz7iFDuXzYucZ4EYIl/bThe8hJCvlk8EEUhg4hesztK7Po0cAT9oQQFYv0eq6Ez0=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a05:6902:1006:b0:dfa:59bc:8858 with
 SMTP id 3f1490d57ef6-e0300f01d20mr12307276.1.1719206952193; Sun, 23 Jun 2024
 22:29:12 -0700 (PDT)
Date: Mon, 24 Jun 2024 05:28:49 +0000
In-Reply-To: <20240624052851.1030799-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611171600.1105124-1-aniketmaurya@google.com> <20240624052851.1030799-1-aniketmaurya@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624052851.1030799-2-aniketmaurya@google.com>
Subject: [PATCH v2 1/3] dt-bindings: i3c: dw: Add apb clock binding
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

Add dt binding for optional apb clock. Core clock is mandatory.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 .../devicetree/bindings/i3c/snps,dw-i3c-master.yaml   | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
index c0e805e531be..4fc13e3c0f75 100644
--- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
@@ -20,7 +20,16 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Core clock
+      - description: APB clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core
+      - const: apb
 
   interrupts:
     maxItems: 1
-- 
2.45.2.741.gdbec12cfda-goog


