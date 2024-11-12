Return-Path: <linux-kernel+bounces-405798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA09D9C5715
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7AA2833D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E841F7788;
	Tue, 12 Nov 2024 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ynT2T03u"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA491AFB35;
	Tue, 12 Nov 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412638; cv=none; b=g9+NQgsgoE8NzY/m7aVCRybv3+R2AmQH8BMqHWU4ZMs8EQ1xsCLP9pLSdqbyQKEjXDnY29BJPKo1IiydIWeSsvMqYp9XH/cWqFaNAvOAYbSt+nLSLdm2tR0uDoIK1Pc6P8AW3FKcG7LFKt0hpE9LJ7MPZIV2uJBoFjn/OqQDRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412638; c=relaxed/simple;
	bh=6KGIZGeA9wR9Ha5B1SjqBB9T6tq2ppC8yXOrDxiGeIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1/wQXgQrD819aViLU3luY5TjTwKlCgIYmC9n0n+6WJ3s01TBiPkGpnpq5Is+TD/AaF9TGfqHRFVRewYvFLDxriaIA2E8i+Mk1sPgKL7xj1JEtJNqsdqY6LuITfY8L7LLsDFhb2LSAUKWvHyADZweQLQDfpzXhymFl3Nhs98h74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ynT2T03u; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ACBuw2P086224;
	Tue, 12 Nov 2024 05:56:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731412618;
	bh=MhrF5q17iPIrKTocFx4yjtOjZq/C/a3HcB4B/nHzJ7g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ynT2T03uOE1m02rLGHaRylAn+vw+wHcQpLQuEFfZeNR2NPdNVVTXRkIP0qPxLzAQe
	 g+q+jDDWBJEMVeQeA49h/+P0STO6IbGAc0dFKfH7hpeXROPAsyV78Lzwgu6ub/XKMC
	 /ZKcYK6KHtZst1F5uiCw2qCsnRIf6MOPInanFIYU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ACBuwOr016236
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Nov 2024 05:56:58 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Nov 2024 05:56:58 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Nov 2024 05:56:58 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ACBuo5T116685;
	Tue, 12 Nov 2024 05:56:55 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-pinctrl: Introduce deep sleep macros
Date: Tue, 12 Nov 2024 17:26:49 +0530
Message-ID: <20241112115650.988943-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241112115650.988943-1-s-vadapalli@ti.com>
References: <20241112115650.988943-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The behavior of pins in deep sleep mode can be configured by programming
the corresponding bits in the respective Pad Configuration register. Add
macros to support this.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-pinctrl.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index 22b8d73cfd32..cac7cccc1112 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -12,6 +12,12 @@
 #define PULLTYPESEL_SHIFT	(17)
 #define RXACTIVE_SHIFT		(18)
 #define DEBOUNCE_SHIFT		(11)
+#define FORCE_DS_EN_SHIFT	(15)
+#define DS_EN_SHIFT		(24)
+#define DS_OUT_DIS_SHIFT	(25)
+#define DS_OUT_VAL_SHIFT	(26)
+#define DS_PULLUD_EN_SHIFT	(27)
+#define DS_PULLTYPE_SEL_SHIFT	(28)
 
 #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
 #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
@@ -38,6 +44,19 @@
 #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
 #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
 
+#define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
+#define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
+#define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
+#define PIN_DS_IO_OVERRIDE_ENABLE	(1 << DS_IO_OVERRIDE_EN_SHIFT)
+#define PIN_DS_OUT_ENABLE		(0 << DS_OUT_DIS_SHIFT)
+#define PIN_DS_OUT_DISABLE		(1 << DS_OUT_DIS_SHIFT)
+#define PIN_DS_OUT_VALUE_ZERO		(0 << DS_OUT_VAL_SHIFT)
+#define PIN_DS_OUT_VALUE_ONE		(1 << DS_OUT_VAL_SHIFT)
+#define PIN_DS_PULLUD_ENABLE		(0 << DS_PULLUD_EN_SHIFT)
+#define PIN_DS_PULLUD_DISABLE		(1 << DS_PULLUD_EN_SHIFT)
+#define PIN_DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT)
+#define PIN_DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT)
+
 /* Default mux configuration for gpio-ranges to use with pinctrl */
 #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)
 
-- 
2.40.1


