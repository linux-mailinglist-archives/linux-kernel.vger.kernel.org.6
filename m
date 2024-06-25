Return-Path: <linux-kernel+bounces-228809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7866491674B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7DE287313
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52C316C686;
	Tue, 25 Jun 2024 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="h/gHlTGI"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C1B16A935
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317678; cv=none; b=F2PfrC6Bkj4Ei6PWA9FXubtGfYjRnwW4IOzAozScdMdiMYry+J7cGpZkyn5UYGsYMU73fsbRHdWFBSTczg4hPydMqVCtKnHHDUnsvqW9NjBmkz7qw2a2G8FuYwo3NpceRFePQOdBs9fZko10/M2NP6zWfxhJkc2T3XlXIWi+b8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317678; c=relaxed/simple;
	bh=G+BtkmivEpWKO42JZ/b2nYWC06K1BWJ8enlG6hWRiGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V9H0pX7PkxPCaI1PLvDtgdNXATVgAwLVXoFCKXK3H4MffXPwqq/V2i6YdZiwM6FfkKycGeyAxVOCAIvbKxdlcl5lCDhE0hlonH9JhUCfJqgaRbR4343umgePtsuPInAA3K8dcm/RvpJmKnFJTYzQE2VJLdt1ogJSoz0eKEA+oY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=h/gHlTGI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36532d177a0so3551462f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1719317675; x=1719922475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmpNHRRU2OSWCKd+hVEeWAEb1vupeZqAg8vsnXJHwhU=;
        b=h/gHlTGIDkFVEDFq1QHC6bePIxIIx2MqnlMCnhGfqXVYAJxJHaZY1ipDS4Xt/b5tAB
         tdA87XfdbEaUwquSKwsn6B9kKR/wuiNOLDJlcVue+jsJFYd01tKBev5ly+R6u9/5wLll
         aHH06pO5E6NIKeGN6V4YVStV8PObjoY+Hqgcc4EHGcg+Wmz91ec0069F/bxzcm4vzueN
         sc7v8FIgg7OZ0BTJw1Kxh11adZVuhM4nUUWXV7E6ZYi8E2DS7xcKFak8tH6K3ETDTAcv
         hbsPa8664U3Qz3kMy4WgfTv0MQsBFJJh7N0euKqrj+buN3N7aziFf4PjhlKkweYUYnfy
         u7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719317675; x=1719922475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmpNHRRU2OSWCKd+hVEeWAEb1vupeZqAg8vsnXJHwhU=;
        b=dh64ttdIlR6BL7E49UwzOGG+U+YaUTgwbVQAPDQytIS5coN7YZSx3AaG//Z6NLLemn
         DleXbMAUWyYhaOg1yMKS1G3s/RtlgTRo3ncoEQqngcenWqVE3xQ5ms76mBOnlyTqkqAR
         AkeOqQVjVBLJSnfMudIKO89wXu79Ox51diPgfF6zao+xB4jHyjs5yj5nLGTWUdrXWlWE
         dssQiUqUrHbEBxwB62nGbuyJcEj7C9auMU64kL3zl2cjRhVQ6May6JiPLvMUAG45zURk
         b10veJ4QfrHXbRcZBo2QIR4WSR91gD8qZvi5K/sXYXHjRcVRUKkZaYptkSpkQfxtoVMr
         vLig==
X-Forwarded-Encrypted: i=1; AJvYcCUTi1CFKPCzx276O2d6vGzvpt0bndm9MO5NoO03Ox/g70jOEM6g1rhLDQ4RKzmx9Y6SLdjO6K7sFo0zmzJKykJ4yP7ZlebUbqjncPBQ
X-Gm-Message-State: AOJu0Yz0iuyNxVG38gQRnr6GmqvKGiQh2IPfuB732HeSZzzGhAqt08Xq
	W7zywUiaDoWE2Y31uyQNKOMOMkxqCGC5mLSafXxZzvsPqVBuY1WpByDoZvTK9i8=
X-Google-Smtp-Source: AGHT+IGAVzLeqxpQgHotNBmPQhFcmvugsk6GvG5kW90f7EiAkNWBop3X/RiZQeIe6Ry3+t47rKzRVg==
X-Received: by 2002:a5d:6483:0:b0:366:ea17:94de with SMTP id ffacd0b85a97d-366ea17953amr6038644f8f.5.1719317674869;
        Tue, 25 Jun 2024 05:14:34 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8b32sm12798437f8f.92.2024.06.25.05.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:14:34 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	wsa+renesas@sang-engineering.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 08/12] dt-bindings: i2c: renesas,riic: Document the R9A08G045 support
Date: Tue, 25 Jun 2024 15:13:54 +0300
Message-Id: <20240625121358.590547-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625121358.590547-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240625121358.590547-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Document the Renesas RZ/G3S (R9A08G045) RIIC IP. This is compatible with
the version available on Renesas RZ/V2H (R9A09G075).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- dropped the renesas,riic-no-fast-mode-plus
- updated commit description

 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
index 91ecf17b7a81..dde37a209b6e 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -25,6 +25,10 @@ properties:
               - renesas,riic-r9a07g054  # RZ/V2L
           - const: renesas,riic-rz      # RZ/A or RZ/G2L
 
+      - items:
+          - const: renesas,riic-r9a08g045   # RZ/G3S
+          - const: renesas,riic-r9a09g057
+
       - const: renesas,riic-r9a09g057   # RZ/V2H(P)
 
   reg:
-- 
2.39.2


