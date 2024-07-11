Return-Path: <linux-kernel+bounces-249143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AD192E796
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055A71C2374B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E4E1662F4;
	Thu, 11 Jul 2024 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qwfDhuAA"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355716089A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698755; cv=none; b=tKmpumfh8B8ZGJerPxz4fJvv3ti43eDtrZB1yieS2wB2bv6FtZmPShFC9b6AJ9AfoGANrkewwswfLi6HK/F3J29yc3ALFoAjKnKeJAmdJkY4X5Famie7+QWyIEYuLC3faGcWHyomjumhDI4KDPF+fIHhRskS2q2H8tev8epoiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698755; c=relaxed/simple;
	bh=0+MicTBHiUKzvnA3rZDDq9j85qpZ09p47HPHzZsgs38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gR9IekaAuTpW04pIrE1G9z7LglkY8dbCIEBQ6XKfcicWdtimpO6EF5Q2Ah4LbPO16VIVyuOS5WDMmSDsdOUYM1DbBo4tBiuvb3Ilym1J/0vfrY5ozEU8knaV4mOUMpsrKJg5bkqpgtRSMrhPbfQ634LNpAEwXerYryAg/dYFz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qwfDhuAA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-367963ea053so517326f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720698753; x=1721303553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZBCyPn7njPR9/TVlgXLD1ap+yXkWFzpRikQNXyqWD4=;
        b=qwfDhuAAmUgYd6kdIbcXojcJsddV+Pj/auMcM0EWiQLQ/ZApnO70JQP8qoU9y232H6
         AHsfYVHH1cnfxM8gt0scrVPMkPFzk54Ib27VCgSVM9+zaTmfmIzwRRtt2TLnn54JYg25
         bbuRyPKjNYeFZqt3vDkUr/6NykMhb3U8LgguAhXCbz8YJtBaF2rQRLycDZxXtaMJdIXm
         8xoYCjRsUJ0IbceJ9f+l50zKu32LvUbWgVXFD0oVFf2SGoNsmvIWVIs41ngDJNdpS0zo
         fYRumkgE3Hznsdpnp1P/62KOlAVybYajTlym7f+NM0mjbJRolcKYAKIBbZfABjX01sPA
         6YEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720698753; x=1721303553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZBCyPn7njPR9/TVlgXLD1ap+yXkWFzpRikQNXyqWD4=;
        b=ci3jCGf9PoQPz6Z7eYhYvVYxXfZrUf9qQj4cmP89N2HP5JHA7r0EEjqm2lSvRgLs7q
         NZZ5KaRlalpLCz3VdOsSV8TgcnMnFlhRvJfQ0j+7pqwLgPNR6hhAxRNWKimQ83ns5owP
         6erzv1RIVR01iX2cPxghcnPT8keyRQTLK5aa0eOdTgyiG5+jiC1nLAyuy4t4KjHuq0aX
         avGWEzhGTRF/EO5D48kg6wKOXEZNI75pAw2x8285zNhrmuh1VtX3h5QUi8o3+atWWxY4
         RlLBcAZWHmPt8Y6Lu7c+ZvgkZcewoCr9uEUV3qIKld5xgwCQ4WAdfjetUPruLfUCUrvd
         u8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVdMZKeLV8umnMn8vNkd3u2xUmy+zYtsLHcbAMvbnlr5ZHhcTou6ufkeiSDnG0P2rYDrmKlo8+gy58Xk3sFgMjYJdnS2fjMUpDozszW
X-Gm-Message-State: AOJu0YyYvwApQHBPXHcOdKtCkdNyOqQeBmmSCebbOfQxR359JoaGDBx6
	AEQAgD+2O/oe+VtQnTpjzSCjdYw2jGXUyi7VO/v9YEP5WScpBqBN9FHFDtN1NiM=
X-Google-Smtp-Source: AGHT+IHCT6dpGR1QFEm4/8GPvCs4Rsey07AX3T4PoUoukEJlV6fa1h+I+5OqhxWN6XoK14pz41/4tA==
X-Received: by 2002:adf:ec42:0:b0:366:ee01:30d6 with SMTP id ffacd0b85a97d-367cead183emr5919650f8f.49.1720698752834;
        Thu, 11 Jul 2024 04:52:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde891cesm7615728f8f.62.2024.07.11.04.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:52:32 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de,
	wsa+renesas@sang-engineering.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 07/11] dt-bindings: i2c: renesas,riic: Document the R9A08G045 support
Date: Thu, 11 Jul 2024 14:52:03 +0300
Message-Id: <20240711115207.2843133-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240711115207.2843133-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240711115207.2843133-1-claudiu.beznea.uj@bp.renesas.com>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags

Changes in v2:
- dropped the renesas,riic-no-fast-mode-plus
- updated commit description

 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
index 7993fe463c4c..e520f06f2c39 100644
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


