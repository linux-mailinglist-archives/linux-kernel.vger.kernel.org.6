Return-Path: <linux-kernel+bounces-548753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9786BA548EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B77A7C17
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019620B1E6;
	Thu,  6 Mar 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d0VGyZD/"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A866620A5C6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259763; cv=none; b=qXquffilSKsABkxGGJzZegSWjjsAVkpAedjEedP+L/gx3xGjV8D/rB4LdyRvJ9UbBVpIpzqvYiHFVBB4zVNHFEVr1ydF9GP/hAkSOZC64fc6kUF1divOw+5Ecv5LgsFa+qobQQnhOUuArlawJt0VVctfecGMBdMngbHXZN8aIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259763; c=relaxed/simple;
	bh=MfFZLvNgPjqf41DYixOzP+LujWeubVPB6G1Uw3Qe6a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GjmKkwuWDXEDkubVjjzeDGCF6VdnVnaHoMbDLvy0x4AcIx9E75j0+veGP8JTd0qlx4VNDE1rOTIylDFsYNhUdku0Nd8NuDwQ+UcA6PzhGVDdvUJtntcxsH9ml51JUMGd0Pj/F9ZgPMTEwzhNL7t5pg4flLtdmIiTrDNca4+mtmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d0VGyZD/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so213325f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259760; x=1741864560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuN0/pwTHZ9vhnZKyENKczH8fXv0gjKVeEKQIoqI9qs=;
        b=d0VGyZD/057WUi6gaRce86qcybsT27VRbrOowak8eNrEB/IZczycDZ3xfBPGD+58gL
         n8H/NAvRQRSgRpzIkPUEU4p8E7Hd8jhlnsmbthgDkIh8IOC8bToavm/gZdGoCXNRRdYD
         7jDvsoceBs70N2w44HAjPbbND/EEZWSQ5mmCZf2dRTYiRaCdesH0DgxjVGoax6VB8XZN
         BI3Hiae4TGAQe7/FxzjeA5CWQl0yjaKZGTu7CmOsoNzhowf2FA0vuTw++Cz29jRYMyX8
         jAJlQpcjTxTRrgZTU9mRmCVqlQBFb7lE5fXFgDfdmk9IIZAcwYMluKFT0YLTP6ZRasFd
         U6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259760; x=1741864560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuN0/pwTHZ9vhnZKyENKczH8fXv0gjKVeEKQIoqI9qs=;
        b=HX6sECwTLCuLS7d8cv/vXmkgRifoRU6N+kFNt0BdKiM3jit43PWPDzanFWH9YexAJR
         zrXdldPVmTmVDNRyK+SVJQieJgmAT+ut/ka/ZPMM+FaEpefmOBzSlRX409JdOPL6svK8
         P61tj9zArenvBJeMf3yDVXTGC38sxh3h3d1X91ljFEMcENVig+b4HMKW5kAIJjxeEN8G
         CRtVEILm7AgDaGhJkodtxGIKuOW+O4MjWZyGgNGW08qLFv+Q80Gj0rUENgnEGDwJRIkB
         doxPyx19kU/gjPOEu7tnEFSgX1T5J+R6vhfsy66nVzB6WuIqKnpDwRc0T5W0d/GoxcKN
         piQg==
X-Forwarded-Encrypted: i=1; AJvYcCXWaqOWIVHWKleSoA0n6JqnFGYiaZIkd+c6PgFod33w2WaXFB6q6llV4+5JTp56jaL3gYux+jAEQlRPH1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRp9ZvNviqgsBUnm9pDhpPT+XB4JCxRIzpxatOEVxGgjeVvjlv
	ffsPQbcU/l0HfOfOKOQaLnmvQMJx0FJY1VORd7gAxNLsfiHKNE0hfkrQE39icqI=
X-Gm-Gg: ASbGncu1iq0EAroZCbMkSpzmt2P0q4rXRhEk40H/bZ1PaZc9qYph4P7KrK2zUIwzt0S
	9LicscFQqj1KSNlpx3H9jgZVBCF9G5iBvnYpZdOmxkgjlZJ5de4YXna0nmGrUipyyNCE+CaRsaz
	mpTyXLwPAAFeXV5a4ulyc9gHJt4XY3mw9JQP/Izxv813PfUekIQT3BVwGAdpiaqKZdfB5u1VopV
	19Hevgjcng7W/k4/0Y1CYJQWpYa6FFfegUkewPGHAYTczRqZ+akXzLF5XJdBwAmrM0ffPounw9A
	RVZY2f38shjp/MOxjvgGGgbQBHRmb2wnofSQxYq9Uw==
X-Google-Smtp-Source: AGHT+IEfL0NWZoLLWRUTFCp+4DpyOhfP6ZpCXD8lXd7n6hvyRmuTOarjAISZof3JEfKOs/w46sjnwA==
X-Received: by 2002:a5d:6c6f:0:b0:391:2e7:6811 with SMTP id ffacd0b85a97d-3911f7404b0mr5947283f8f.14.1741259759759;
        Thu, 06 Mar 2025 03:15:59 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e5c768f213sm784211a12.74.2025.03.06.03.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:15:59 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:41 +0100
Subject: [PATCH v5 03/13] dt-bindings: can: m_can: Add wakeup properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-3-f9323d3744a2@baylibre.com>
References: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
In-Reply-To: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Kendall Willis <k-willis@ti.com>, 
 linux-can@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=msp@baylibre.com;
 h=from:subject:message-id; bh=MfFZLvNgPjqf41DYixOzP+LujWeubVPB6G1Uw3Qe6a8=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNm9X+56w2K1+/c7Ce/Gfi6IMU0XDit/e/J73zXtzp
 W5s6zTmjlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAi1SWMDJ/1uafnP3n+07y1
 66coo+WxvoOrREtrviwpnH+vqGLmqkZGhhNuT4pTtrVatqdxV/z9eJT7rnO1YN/Tkwsd4/VS7u/
 U4gYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The pins associated with m_can have to have a special configuration to
be able to wakeup the SoC from some system states. This configuration is
described in the wakeup pinctrl state while the default state describes
the default configuration.

Also m_can can be a wakeup-source if capable of wakeup.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/net/can/bosch,m_can.yaml       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..0c1f9fa7371897d45539ead49c9d290fb4966f30 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -106,6 +106,22 @@ properties:
         maximum: 32
     minItems: 1
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Wakeup pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. The second state called "wakeup" describes the pins in their
+      wakeup configuration required to exit sleep states.
+    minItems: 1
+    items:
+      - const: default
+      - const: wakeup
+
   power-domains:
     description:
       Power domain provider node and an args specifier containing
@@ -122,6 +138,8 @@ properties:
     minItems: 1
     maxItems: 2
 
+  wakeup-source: true
+
 required:
   - compatible
   - reg

-- 
2.47.2


