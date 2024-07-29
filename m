Return-Path: <linux-kernel+bounces-265276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B287793EECF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10727B224DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682613D2A9;
	Mon, 29 Jul 2024 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OQ87rEX5"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44534136E21
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238929; cv=none; b=AA4+9CSpfsZkRyeqXivrKzJap121t2Rpvu3midph6SxRdYsxEzuXbEP3jxg3hMXGcosH5aBDC9Nywp0DTcvHbryaqoiDNorcD++hz1+hoiLy5JPL8fgSdPYjxT0KvOwbQAwW5SXCRvL12wBUg7b5CRruZXtkSA/7Ye2+lRan4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238929; c=relaxed/simple;
	bh=RC9+oAb1G3FrEzAPShpCOonJZhBTxvWXVZW+5cFMqSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHL/cnjUGsGRuSsA+FeLUK30yYCPtf8WajJ2QrLyNDGTqMVNyAJBjXlXBNMLWDM413lVFwQeiB0wLV6k0XiEN/FDmvy0j0V43QmmjdKG/S8Ji3RBX8xUCQbmkxmBf5b6KrcxGUkSW3AjGL/ofKtVZN/S7+wsLsU73wKqFBmKTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OQ87rEX5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368584f9e36so1079568f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722238926; x=1722843726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbaHllSBP44xGl3C1E+M24vLcFnhJW8T63/SQdZs/pw=;
        b=OQ87rEX5y/RemIV973dqDThyV7ow20reOPrqZ1OaQIzNmO4Dl5j30ulD6/FuHV9rrV
         iEscUfnQd9vc9JaDDeUbnIDWsGVaOcfZ0oQxBx5/YuAQHHlKs+K5V8h8hJT+JUZd1XVA
         ggVQUG2gpuvlMK+XGSAYc5EJoAv2naCgLIVEJ7P1n6v3KLo9+dnzWYb5FKp4GVgHl8pt
         /VEK00nNTyM1O9ZQoiRwhvnIKnIM0RCeaGqSkB+jwiJ2evNJY2JTqP6NgAiktJ6GTGjO
         eDZwk8964PQFsIOu92OwHVxkni2wwPGQW/qAY5iq4PQDi4mgGIpRAFWx7DIfqPPf/PeG
         LL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722238926; x=1722843726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbaHllSBP44xGl3C1E+M24vLcFnhJW8T63/SQdZs/pw=;
        b=gA6XeVY+BK0rBHdyxPRxUxzUZJ8+p0elRbqOIw10jxgH2BvQraSnIRpGkEd4NB+oB/
         hggJ3T0FcClQ/WV3ljgZmJ0Ilj/r36P0Lho6Q0F42XzgPyRoEzUydCirexLRyQ+AW4XK
         zfdCg+p9xmrSUJpYVtJFShQyBpH4Sn9Z5qtya578imnIbSvOe612ovrp38N8qtfTxPS+
         a/7FUXeYuZxq4driLJa+xSk1aBC8b8diGsvThJHYWf6jXs0rKU1btDKx0jIsprKTgY+B
         Ksp7954f210SSStzccb3BV4HqgC3RScMWF+DyuOztZrLJBLgKkQQLvc6zMkyDgMuOM1H
         K/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU3qw8pOGgleo4KiHCHcOLmhyOEqwTIvfStOH/F0erm6qFS4lMzZe3nfV6awK5A2Zd8/R7gT7CHPQh78zpjmUcHFtv2R/I1MH8uYCds
X-Gm-Message-State: AOJu0YwtWKkCeamoK7fbRJbjmVS4vYD3QdXZzzNRNUgbCCYHZQGUIAo8
	dJ7bxeTOlTWODEX8R8P58Zvk67/2MzXs3nQhSZr5GUpmP7L9xXGsb9IvdM3u7uI=
X-Google-Smtp-Source: AGHT+IFE1SgIJAautjVauLTqd9nxU/X7KWKBTgVQV4TWBqBwOoYebOAUmEVbfA6ZOnR9sLeiqeX4uQ==
X-Received: by 2002:a5d:5751:0:b0:368:4910:8f49 with SMTP id ffacd0b85a97d-36b5cecef87mr4342658f8f.12.1722238925793;
        Mon, 29 Jul 2024 00:42:05 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm11460879f8f.109.2024.07.29.00.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 00:42:05 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michal Kubiak <michal.kubiak@intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	Conor Dooley <conor@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 7/7] arm64: dts: ti: k3-am62p-mcu: Mark mcu_mcan0/1 as wakeup-source
Date: Mon, 29 Jul 2024 09:41:35 +0200
Message-ID: <20240729074135.3850634-8-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729074135.3850634-1-msp@baylibre.com>
References: <20240729074135.3850634-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vibhore Vardhan <vibhore@ti.com>

mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
accordingly in the devicetree. Based on the patch for AM62a.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index e65db6ce02bf..d6eccaea7a46 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -171,6 +171,7 @@ mcu_mcan0: can@4e08000 {
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
+		wakeup-source;
 		status = "disabled";
 	};
 
@@ -186,6 +187,7 @@ mcu_mcan1: can@4e18000 {
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
+		wakeup-source;
 		status = "disabled";
 	};
 
-- 
2.45.2


