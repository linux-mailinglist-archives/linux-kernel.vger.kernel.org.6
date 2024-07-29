Return-Path: <linux-kernel+bounces-265303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F0793EF4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504571C21C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D985813A258;
	Mon, 29 Jul 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RdOqW4Ok"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427EA136E21
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240078; cv=none; b=GoAYzEGscgJgCRtw5DjYLTnh0jvCsfF+txmE8kPfA4f6f0JHzKfTMLiVKtFX58Rhz9vpcZXaJO2Ybu5ZVk/2pNwToYbVup7o4QW1gt6+CMgxfT6KRHsLnxqWOhMWaPQgkZBQJYAJBFtZpR0QHHirwfPEZnZ66D3tiFOQdZfWzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240078; c=relaxed/simple;
	bh=gFUMqY8c7SLc/xlj0Il9dw1HgpJ+ErhpNp+DDoBd1a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mt528SgrqB2Hv6WbFHyEcNgy0UfFWEjCxFKaBCly7mDkacLrK/lVB1i6+K5R0rbXcCn0lUBuikEdOOxpg949u6FQc3z3BBkolfyu4lI6ANFNoCBFJ5ybEkmBylrEm9NKpBAyHnTgRS63fP0Jw+yTHdMUhdLVOqBoxKqAdMqgMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RdOqW4Ok; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3684407b2deso1135299f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722240073; x=1722844873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOjLun6texcSlkqDtHFasKp/m6UQbRYZsxtm1Omsgik=;
        b=RdOqW4Ok/s4QANATwGHdXZdEv0LmYrwTxoIivv362D/LE7AljNixCo0rjxyYj+VFgs
         dvk5WLXGMtAXgp1LFgZ3r0gEaP8fYPxNDHHn5fzywm7vPFNDyXIuG0UD90I9/yO3HQLC
         pSk075FKJdzvdS9xA30iDJjNQRoJb6NeGFGKIcK93hGknv4wHlLQQJK3AOZqUNJIbZTl
         Euk5E+P9TTZ8oQZOO+xfy8yU75jPMhMu7SEvt7nO6C7RARF153kTwWeD3FwYhkpv5dcU
         90oKcgV4N5wbbWKDBZYoovPzsB/TKXxg518w8lQr0qcOZB/RrX2hnWGiYz3Nrsvb6x7t
         A7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240073; x=1722844873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOjLun6texcSlkqDtHFasKp/m6UQbRYZsxtm1Omsgik=;
        b=OghEnavXP63UarSp5rEItiqsdmZsXWEGdknStAYsBlpeHrGHf5N9hFrk4Pv0MTZsQ+
         0ldePfwpb6nzVCIkRtFNCU09XvWMAaS6OhxFYiupqaWfZx+H1uJBF19AEFP8yqpkDQZ7
         brjp/aKfuq7HZcfyKDQ6HalsluTk5fewI86Qn6NVzcPqLY4LbzRJZ+/Te/n6Wy5PZRN8
         DnK9A/HORTtr+UvFS18RHqdyO7idShhHWZ8xLQRU96XgpgJH9N9HtOzbJLPJ/v3TPhzx
         6MHlpaMqoh/+qtEPH7s81LL6SUacI6bNNwtq4y4860+2Z9+1I0/bkIklmACmQRqlS4bU
         dIKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwjfbwsm1TR5ZjnsPjhhumtSk2sNE/MaoWSHyl21U6IHTgNrrkTYPv1cRwHqpYEGBYTZ5BACy1iBQiuibG6r2qb/fJ6XRhC0K4gT73
X-Gm-Message-State: AOJu0YwChCh0cxMPWfhiLRaTTXOI1C/f7MQFc39/tU+m1A0mf60xIuI6
	Kqhic9SQ8S1dL4uzSCvKyDcXwK3p3sUixU/8mc9hfrw1FplI5HixNJ8+UaADaAk=
X-Google-Smtp-Source: AGHT+IFMgwC69DMoi/qdpS3geBrRwusfaLDyoAizRfL/peuUo/6VpfZyOT7ZJpMKpugEbj3UCV3eBQ==
X-Received: by 2002:a05:6000:1fac:b0:368:714e:5a59 with SMTP id ffacd0b85a97d-36b5cecf2a0mr6494090f8f.11.1722240073526;
        Mon, 29 Jul 2024 01:01:13 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42819d9a007sm45452635e9.1.2024.07.29.01.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:01:13 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 1/6] dt-bindings: ti, sci: Add property for partial-io-wakeup-sources
Date: Mon, 29 Jul 2024 10:00:56 +0200
Message-ID: <20240729080101.3859701-2-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729080101.3859701-1-msp@baylibre.com>
References: <20240729080101.3859701-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Partial-IO is a very low power mode in which nearly everything is
powered off. Only pins of a few hardware units are kept sensitive and
are capable to wakeup the SoC. The device nodes are marked as
'wakeup-source' but so are a lot of other device nodes as well that are
not able to do a wakeup from Partial-IO. This creates the need to
describe the device nodes that are capable of wakeup from Partial-IO.

This patch adds a property with a list of these nodes defining which
devices can be used as wakeup sources in Partial-IO.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/arm/keystone/ti,sci.yaml    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
index 25a2b42105e5..7d6152710573 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -61,6 +61,19 @@ properties:
   mboxes:
     minItems: 2
 
+  ti,partial-io-wakeup-sources:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      Partial-IO is a low power mode in which nearly everything is powered
+      off. Only pins associated with a few hardware units are capable to
+      wakeup the system from this mode. It is a very small subset of all
+      device nodes that have the 'wakeup-source' property.
+      ti,partial-io-wakeup-sources is the list of device nodes that can
+      wakeup the system from Partial-IO.
+
+      This low power mode depends on the capabilities of the SoC and
+      the firmware.
+
   ti,host-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
-- 
2.45.2


