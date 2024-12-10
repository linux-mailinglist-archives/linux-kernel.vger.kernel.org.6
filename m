Return-Path: <linux-kernel+bounces-440016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE339EB808
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A902817CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B7B23496C;
	Tue, 10 Dec 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MQzjBXDp"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A771237A2F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850613; cv=none; b=bGWOK/8eHZU6oB3se0VxSIEIEOhB6EY23wR7hMWNdd0OXU+sesGY0LwjOMON3T5jjyrRVBVJLT0B9RjIa+cpBBQTAZnGvpx4TZvbNZBoSM9uGmsShla6BLUC1wuJ/tKIAMYs9l1akufED1LFrilW/m3VC3ju7qsP6VZxzzTF0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850613; c=relaxed/simple;
	bh=28M0DwDkMWfh/cCYd77FlED8MgZgXdkVNsI9ruq8oCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPVPnbQd4R09QfeftdfoHt7vWZpEGf8uV+xevi6RTzItbpmSsWeUt4LxbqFsyib8z7lvHNopkmTDKCx9hB/fM4Rjb6DdhW8dtmiJY8hUCGlrNGG0QgSe+ZL1Qq1njfO0lzowyoqma6djGpjR0OiJOuCzezVaZspmbsg4K1+loN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MQzjBXDp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so7354853a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733850609; x=1734455409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehtFOxPVmrl0HXvdtrtv9cXQJbKgItgUhCJ0+pIiLcI=;
        b=MQzjBXDpRt18BnyVhFu9LW0hpGwvvwgHbxOjUiClJRXR5FVfaLIcqTvY+AH+LG3Kym
         v6A3midGaWsqoE1p7IqYJmQlSfnloI8iql6JSIms2HdJ5zZNEm663ModvEElq7Lihl3M
         OYgG5fJ3Tm5LgkoTXe0ZwLfAJg0Qb3N8/3+eWq2pg7ZQe24Er7zOp/5n9fCv6pOfwhWX
         N90AH9dvQZem8yoXZKO9Mbsw0pqeO1fqEn4x4SjZG6fE64Btrjc6mzUPACvHIr8ojC2f
         yoLrRyr9hGVHj17l9COx+a7NKAeIFVYt3z1bb2wf6AZ1Hlo/+7TMnth9iS9asdpKEm3o
         7Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850609; x=1734455409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehtFOxPVmrl0HXvdtrtv9cXQJbKgItgUhCJ0+pIiLcI=;
        b=L/kM5WY8wkoeGxYBRKFvx4oqqyl4j/LiNnSXu5FRmCb8XNMDY3nh/BpG8BL3kZaEz9
         3h2zjGpbLvPITCgYKgdMBlot7hZB5VNF7i7ox87IkaIqHPBO/rmZDdgdledQoBKJ5xff
         CxrSikQ1n9da6hAGJYBuMGIfRKvVHBZp7gUqv8AuTm8+sbzbovHQdK6SklO7HikZ6oJv
         g5QqaHs2wqT9whmmcYXPExPJHAl+/E3k9oBqiHEfk979xlB9LvLTWLUYkqokvysj83II
         rlkYpv8WH2k4N8Kq5vLBwJwdjlDd95j1WXKXaxrhcHLaZHpHURzXF+M9/ENmbNZBHHmc
         vatA==
X-Forwarded-Encrypted: i=1; AJvYcCWOGSvi/NnxAi6AMQC6nWqLNVNVLuXy4OTn1QdsSyLKlD+S4d/4ubp7V/pOK9elFYGisF6uhUSId2ILKNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNUTZX/RUnD7d6SmfCD9umO43F67tgegoQ+rbcqZnal2ydF2ju
	ofGY17yew+1RyzOlMYjBsfX6xafPSpYbWePtcAMm+Seela416oJ1MT0VRDOLlas=
X-Gm-Gg: ASbGncu7ULAWFbq3WrxctC6O2rkrchNbrmFLInt59Oi1azENeSHfRaV0psbcEN3DTeJ
	8AcDf4sPHYDCpsfzUWG/vqMSBuxP1e6IiHDWDCmVym9Oh8uLC3awUQt40vLRSCM1F8iQkwnG80U
	kigfIIAlyo3S1QgUzT/2E8E/9kllsgTKgtC4M+1yGwankcJ6eej+GwbCw4DGAFbwNGeQZlhKPo8
	q8YdoePrIP5CSH+WNZr3Q0vWtihBrVu4+or4qP5sTOeiCV3pmxNKwMWj9T4jfjWsfyeAvUi5VXc
	UxYbPe9A
X-Google-Smtp-Source: AGHT+IFmnNKXXAN067E1UbwhBJfMpK5O10AWTX9+hlwh80SSPAEOWU+7C2pI3MGNxXbuHtb4mGyh4w==
X-Received: by 2002:a05:6402:1ed6:b0:5d1:3da:e6c with SMTP id 4fb4d7f45d1cf-5d41853e70cmr5928380a12.10.1733850609561;
        Tue, 10 Dec 2024 09:10:09 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm4853124a12.56.2024.12.10.09.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:10:09 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 02/24] dt-bindings: clock: versaclock3: Document 5L35023 Versa3 clock generator
Date: Tue, 10 Dec 2024 19:09:31 +0200
Message-Id: <20241210170953.2936724-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

There are some differences b/w 5L35023 and 5P35023 Versa3 clock
generator variants but the same driver could be used with minimal
adjustments. The identified differences are PLL2 Fvco, the clock sel
bit for SE2 clock and different default values for some registers.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- collected tags

Changes in v3:
- collected tags

Changes in v2:
- collected tags

 Documentation/devicetree/bindings/clock/renesas,5p35023.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,5p35023.yaml b/Documentation/devicetree/bindings/clock/renesas,5p35023.yaml
index 42b6f80613f3..162d38035188 100644
--- a/Documentation/devicetree/bindings/clock/renesas,5p35023.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,5p35023.yaml
@@ -31,6 +31,7 @@ description: |
 properties:
   compatible:
     enum:
+      - renesas,5l35023
       - renesas,5p35023
 
   reg:
-- 
2.39.2


