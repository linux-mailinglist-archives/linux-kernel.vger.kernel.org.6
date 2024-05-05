Return-Path: <linux-kernel+bounces-168868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7C98BBF10
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 03:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130BC1C20948
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 01:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361AF3D8E;
	Sun,  5 May 2024 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="daErANad"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2083.outbound.protection.outlook.com [40.92.42.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C48187F;
	Sun,  5 May 2024 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714873911; cv=fail; b=dPDNcoJdFbQEpT6mzXbjjdHplp0GmBJDxN2OjXAm8jQwflrnYBqfFhsNL+cXrdMmVDnE0hdhoJIRusibdCIHA0bc+0sBK/nC3R00N1DgExhulR8JLojX3ulUSQF9eGuihl5RQaewPVOcBjliIELSEoFdbZBCAG+z9TWhCgQALRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714873911; c=relaxed/simple;
	bh=8ZVxFCWbbM1qZFh2wpBQoL5l34P4/043K0K4XfWHiI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LNF1blUjawa7J49J7j0GY3JGOsgrh1Wk+3h2uu4hmNxxdzRiReDpkxLGCCfDr4nhWC8Wy5TCtKrdVsrctRQ7Q3BGMJBdiNjo3KAxpB7HSSMWvNCGCp0j7wIwBFDany9PDfq8GRfC3Q+zeAQAb8+78UuhmhWIg14SYOg3+tokJDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=daErANad; arc=fail smtp.client-ip=40.92.42.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ylmv5CXnm98JjGnOhTgXr5UYQ8Bkd5GBhox2J+UZxrSY1Wi7rmznZOe+V6fN9bHV5wyzWGVI0PbDRp18ZuufrNlXAsc91auoWTrQrhCQDh1NdgkXpf2bESivHSX4WZHYb2JJn4Hnee1DwNKPaJyY9s6KeUzvXEZ44pQ4LjAPIgSzqAI556Z/ddM2pUPUPVdrL3cnBefy3Et8X4M81hzu1oKiEYnrmW4U6413DkQLCH2b6rOi2fToSQzSAKb+pM/FwwagSK8mj9ErN6gjD2rG+8CfqORMnQp4c5r16eQAnU8FStJrUaW+/Y55c9g3U6z767Cir5pGYb2zu9AgHr2iCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0sQF2yediK5Doldlq6rtH+5QwrytBvqNDlig8hL2fQ=;
 b=eLgMq2UbIcdNGeSOqHw4jGcpcaOOi+rNfb7nGGVa+euWq5RdbCrFmOW77WlFOHGa1Ij1fLmt0lkQoixBujcrb2MccSFcQscrBbvx9WxRytFejMyrzrC/8lc7s41MXKtYSRfyonbK4zjJEXSeo3FbTyanIc3oguBas9eQeh4f7+66GaOQMUl/Y1LAmONGFypg2EWoo9pdghKy/psD4GoOF+ImXV/rteYglOA7z6CvMfxFzo/Mid1djYn28VJ6XZLfHYBnr3LhwMT4JgKp8eVAnxvaRS8rGVEloc6gwGJczI1Fy5+NUkorr1S6+GgKHPtdOm7zqjbbokevlGyW2N/Yrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0sQF2yediK5Doldlq6rtH+5QwrytBvqNDlig8hL2fQ=;
 b=daErANadHBvSxE513dKXA8fHTvwveQQ6/XtpoxtWk8hm4AKrtlbdjsgMjeTLTgvegRioaLCgJEpYYH7sOAJd3ptzvdy2JHKn4rwv/tzQN0++b2nov3ohuwxHo08YR80vNuWXEymhG5IzB0003hxAGTRWnrK2aGsLvvPTlkltw43yH5xWw7EPrmCdyUERdAvDQfTNK+1r8zlRqkITFg9S9xDr3sz1vjFGh7IMRKpEytko2gl6RPaLAPTiKz3VT8E/Ckv6EA6AWES1qzT/8VfXvSkRcqiZ/i7YkFsXXVTn2iOi2ssF2Z/Jyt9Xq+IEpi4BlnEQpJoM0oxcFUwp9gE74A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB4304.namprd20.prod.outlook.com (2603:10b6:510:12a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 01:51:47 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7544.036; Sun, 5 May 2024
 01:51:47 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 2/2] phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X
Date: Sun,  5 May 2024 09:52:16 +0800
Message-ID:
 <IA1PR20MB4953A1328FE458C4DE45DDDABB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <IA1PR20MB4953C1876484E149AA390DD5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C1876484E149AA390DD5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [O1kJS4wNSTHu8ntRvHdBbAcJGs0EHCwBeGoxaLeFwN0=]
X-ClientProxiedBy: TYAPR01CA0206.jpnprd01.prod.outlook.com
 (2603:1096:404:29::26) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240505015219.754500-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c6b742-1378-494a-7ea4-08dc6ca5ec2e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	88XgWPdCT4JjwV17I0Ne8SJSB1XGDHod5gAg0f1k3kTnYRuKXF7FXatomzYldFUDNMS8LO1P2iwT7fhNGy1C+I0RXS8eChE5WVb30qsHn3AyE37UlFpPpTZb4pXJqPtSX31LvXmmqxz24w8M9QHtZP6PgGvu0NN8Dyyabo/C+1d6Wo+z1ZBZhHUi54gccYKZ+SI8BXp7fMVQfZHaU7avx7Dufsa4Iqq6qn1FAkXr/Q2/vKZ2hwdLkYNGU/JOt1XBxQdi8S4URrj0g1FnQqHXivVeJBe29Rd6akX5FMAh58Eb/8CAy0ies86WCbw6J7Hna3lXR4CzyD+I6kFHmGSdqdBV+M5t9kTsXon5q5R8/moddVkzLyjVv1J6HKEfGVZVQshpM+jwXq0uEXNJYc8TPdAuH3dIe1ruJUPJns+jumfr655ug9+RfY5eJT0v+4W7DWyNCeBVjSwcDpNzALXjb7IYYeZ9Q9yl/r+rHkCdHOsVj6fW8geWg1zAwanGiKIXjPwO0eVQzhViw+ucr57uFGQlHZvyKBgBCxwEEtAa5bW/YXiSIie95Ol+RUzVqqcIuyJnW7UmorYBODEOitDc7vpYLogm704VW+xN8GgePQuJUem4jPfm6wOHHzzoLc0V
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A4u2kR+OYuUAVG7pqB2FH7YRlBYhqpIWyqQ81Kzptw/cWnXPLADYo+q71wCp?=
 =?us-ascii?Q?WTd+Dx8MIaiua/CQYAEuWsi2NMjs1VSqYqQTdrDXXW6rh6AfCeCvIk3Cl9Ev?=
 =?us-ascii?Q?SYUcRgNdquuGjZTmM3iDljitziD9/Fftugb88Lkie5MjeZZY2jt7G55+9fhK?=
 =?us-ascii?Q?Yqs7ROp3IBbqQn7Va4sRfV8EJ9GW1ETZNAfOwhW8qwdyWceKN1wYrOIqHzw5?=
 =?us-ascii?Q?s4vqskDamPHQ1I9I/xd1U98B6eC6zDpXCgNzOKXoUpuks0ebBb686a/W4l1L?=
 =?us-ascii?Q?7LHGnAblTbSSIB/x/Fh3vBtE3SFixRdnnOaZlV7OvC9nFczcsMeWZFsx+hGx?=
 =?us-ascii?Q?cKbyhsQZIDM5NrdvFEBZ4pYWlsauDp92A8rb9isERFdEdCo/URmb0ZnETxGg?=
 =?us-ascii?Q?wcQ88rTQVW++2S24fPaOIxaS/uJtvKpJBaM5ToCiqIEpWtjFmaUuTHpC+XYv?=
 =?us-ascii?Q?f1Nd4zb87aCd1pUxHFv/NxJpOzzqEmy3HpF53qsEozwLALxdi2Vdyth6GJ7Y?=
 =?us-ascii?Q?s/vvbh0ss2d0d9MSLCDl5NAKS+y/Q7/DiVilGcEqiBhO0yr7+WGBtrthLjs3?=
 =?us-ascii?Q?Dgdr8hDz0ZpDewI02VVL/4TMEaVSyyUd/8ZpYqql4jjNhzUreabvWOf+NOsc?=
 =?us-ascii?Q?kaSxIqAXOTMSGUfph8a4Nr+OHmlf9WVSKxalpWoCUjAxH7DOyHh4NuVDSN0s?=
 =?us-ascii?Q?exWZ4MUZMdKZyduvZj2VPfr3nJFvBamEJInbM6f7H7vKaykKu1T5xkVQjRHP?=
 =?us-ascii?Q?KMF5eeZOuP9OKC78lieBoK1zleu+k6ho35zOLJOxQTe9rwPMPbPYRU9JbzHP?=
 =?us-ascii?Q?dwA8VQMVSUCp2WE5w8lmyQXaP2fmy9BmVJbc+kIyMTaTcJFqe4/qwvNbWFU3?=
 =?us-ascii?Q?YuozIu1MnVbEWC5xSwST4obRTelcZ39Nt2lmPGBJfQHD9t6deHvIF3vt2Fth?=
 =?us-ascii?Q?luv7weAUcuG3kVmSWkslhILCf0BYMpxOvc2Dpe3F9aXH/Oi3mb+mUMUenkSh?=
 =?us-ascii?Q?kWbvQGJUEo1wyZw1FuytEoyIJORbOV3z5rXMM8Qhh2T4rf4LkpOWaTdKlyJF?=
 =?us-ascii?Q?+JppIbjQAijxQTuajuV6H6N9yGxLVEwtAni/1D7Ub3X+QsDdn3oJm8tDzuXA?=
 =?us-ascii?Q?zXCwGIL5GyajePS5/1AXU0LMcQ7AnU7nMeF6770gntROTmKlQ3Uh+Y56NPnb?=
 =?us-ascii?Q?/I1/RyDnt7kDB9KCzqCukzvcsOcIBEWozCkoqH5WLKieW5F4Y3CRSmzP3npA?=
 =?us-ascii?Q?RdpOZbwlaBqDaF5TwI9e?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c6b742-1378-494a-7ea4-08dc6ca5ec2e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 01:51:46.9759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4304

Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/phy/Kconfig                 |   1 +
 drivers/phy/Makefile                |   1 +
 drivers/phy/sophgo/Kconfig          |  19 ++
 drivers/phy/sophgo/Makefile         |   2 +
 drivers/phy/sophgo/phy-cv1800-usb.c | 378 ++++++++++++++++++++++++++++
 5 files changed, 401 insertions(+)
 create mode 100644 drivers/phy/sophgo/Kconfig
 create mode 100644 drivers/phy/sophgo/Makefile
 create mode 100644 drivers/phy/sophgo/phy-cv1800-usb.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 787354b849c7..596b37ab3191 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -92,6 +92,7 @@ source "drivers/phy/renesas/Kconfig"
 source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/samsung/Kconfig"
 source "drivers/phy/socionext/Kconfig"
+source "drivers/phy/sophgo/Kconfig"
 source "drivers/phy/st/Kconfig"
 source "drivers/phy/starfive/Kconfig"
 source "drivers/phy/sunplus/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 868a220ed0f6..7ff32f0ae08a 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -31,6 +31,7 @@ obj-y					+= allwinner/	\
 					   rockchip/	\
 					   samsung/	\
 					   socionext/	\
+					   sophgo/	\
 					   st/		\
 					   starfive/	\
 					   sunplus/	\
diff --git a/drivers/phy/sophgo/Kconfig b/drivers/phy/sophgo/Kconfig
new file mode 100644
index 000000000000..b1c558de6616
--- /dev/null
+++ b/drivers/phy/sophgo/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Phy drivers for Sophgo platforms
+#
+
+if ARCH_SOPHGO || COMPILE_TEST
+
+config PHY_SOPHGO_CV1800_USB
+	tristate "Sophgo CV18XX/SG200X USB 2.0 PHY support"
+	depends on MFD_SYSCON
+	depends on USB_SUPPORT
+	select GENERIC_PHY
+	help
+	  Enable this to support the USB 2.0 PHY used with
+	  the DWC2 USB controller in Sophgo CV18XX/SG200X
+	  series SoC.
+	  If unsure, say N.
+
+endif # ARCH_SOPHGO || COMPILE_TEST
diff --git a/drivers/phy/sophgo/Makefile b/drivers/phy/sophgo/Makefile
new file mode 100644
index 000000000000..659537054cd4
--- /dev/null
+++ b/drivers/phy/sophgo/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_SOPHGO_CV1800_USB)	+= phy-cv1800-usb.o
diff --git a/drivers/phy/sophgo/phy-cv1800-usb.c b/drivers/phy/sophgo/phy-cv1800-usb.c
new file mode 100644
index 000000000000..bf1b86f7aa1a
--- /dev/null
+++ b/drivers/phy/sophgo/phy-cv1800-usb.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/debugfs.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+#include <soc/sophgo/cv1800-sysctl.h>
+
+#define PHY_IDPAD_C_OW			BIT(6)
+#define PHY_IDPAD_C_SW			BIT(7)
+
+#define PHY_BASE_CLK_RATE		300000000
+#define PHY_APP_CLK_RATE		125000000
+#define PHY_LPM_CLK_RATE		12000000
+#define PHY_STB_CLK_RATE		333334
+
+#define PHY_VBUS_DET_DEBOUNCE_TIME	usecs_to_jiffies(100)
+
+struct cv1800_usb_phy {
+	struct phy *phy;
+	struct regmap *syscon;
+	spinlock_t lock;
+	struct clk *usb_phy_clk;
+	struct clk *usb_app_clk;
+	struct clk *usb_lpm_clk;
+	struct clk *usb_stb_clk;
+	struct gpio_descs *switch_gpios;
+	struct gpio_desc *vbus_det_gpio;
+	int vbus_det_irq;
+	struct delayed_work vbus_work;
+	bool enable_otg;
+};
+
+static int cv1800_usb_phy_set_idpad(struct cv1800_usb_phy *phy,
+				    bool is_host)
+{
+	unsigned long flags;
+	unsigned int regval = 0;
+	int ret;
+
+	if (is_host)
+		regval = PHY_IDPAD_C_OW;
+	else
+		regval = PHY_IDPAD_C_OW | PHY_IDPAD_C_SW;
+
+	spin_lock_irqsave(&phy->lock, flags);
+	ret = regmap_update_bits(phy->syscon, CV1800_USB_PHY_CTRL_REG,
+				 PHY_IDPAD_C_OW | PHY_IDPAD_C_SW,
+				 regval);
+	spin_unlock_irqrestore(&phy->lock, flags);
+
+	return ret;
+}
+
+static void cv1800_usb_phy_set_gpio(struct cv1800_usb_phy *phy,
+				    bool is_host)
+{
+	unsigned int i, ndescs;
+	struct gpio_desc **gpios;
+
+	if (!phy->switch_gpios)
+		return;
+
+	ndescs = phy->switch_gpios->ndescs;
+	gpios = phy->switch_gpios->desc;
+
+	if (is_host) {
+		for (i = 0; i < ndescs; i++)
+			gpiod_set_value_cansleep(gpios[i], 0);
+	} else {
+		for (i = 0; i < ndescs; i++)
+			gpiod_set_value_cansleep(gpios[ndescs - 1 - i], 1);
+	}
+}
+
+static int cv1800_usb_phy_set_mode_internal(struct cv1800_usb_phy *phy,
+					    bool is_host)
+{
+	int ret = cv1800_usb_phy_set_idpad(phy, is_host);
+
+	if (ret < 0)
+		return ret;
+
+	cv1800_usb_phy_set_gpio(phy, is_host);
+
+	return 0;
+}
+
+static ssize_t dr_mode_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t len)
+{
+	struct cv1800_usb_phy *phy = dev_get_drvdata(dev);
+	bool is_host;
+
+	if (sysfs_streq(buf, "host")) {
+		phy->enable_otg = false;
+		is_host = true;
+	} else if (sysfs_streq(buf, "peripheral")) {
+		phy->enable_otg = false;
+		is_host = false;
+	} else if (sysfs_streq(buf, "otg") && phy->vbus_det_irq > 0) {
+		phy->enable_otg = true;
+	} else {
+		return -EINVAL;
+	}
+
+	if (phy->enable_otg)
+		queue_delayed_work(system_wq, &phy->vbus_work,
+				   PHY_VBUS_DET_DEBOUNCE_TIME);
+	else
+		cv1800_usb_phy_set_mode_internal(phy, is_host);
+
+	return len;
+}
+
+static ssize_t dr_mode_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct cv1800_usb_phy *phy = dev_get_drvdata(dev);
+	unsigned long flags;
+	unsigned int regval;
+	bool is_host = true;
+	int ret;
+
+	spin_lock_irqsave(&phy->lock, flags);
+	ret = regmap_read(phy->syscon, CV1800_USB_PHY_CTRL_REG, &regval);
+	spin_unlock_irqrestore(&phy->lock, flags);
+
+	if (ret)
+		return ret;
+
+	if (regval & PHY_IDPAD_C_SW)
+		is_host = false;
+
+	return sprintf(buf, "%s%s\n",
+		       phy->enable_otg ? "otg: " : "",
+		       is_host ? "host" : "peripheral");
+}
+
+static DEVICE_ATTR_RW(dr_mode);
+
+static struct attribute *cv1800_usb_phy_attrs[] = {
+	&dev_attr_dr_mode.attr,
+	NULL
+};
+
+static const struct attribute_group cv1800_usb_phy_group = {
+	.attrs = cv1800_usb_phy_attrs,
+};
+
+static int cv1800_usb_phy_set_clock(struct cv1800_usb_phy *phy)
+{
+	int ret;
+
+	ret = clk_set_rate(phy->usb_phy_clk, PHY_BASE_CLK_RATE);
+	if (ret)
+		return ret;
+
+	ret = clk_set_rate(phy->usb_app_clk, PHY_APP_CLK_RATE);
+	if (ret)
+		return ret;
+
+	ret = clk_set_rate(phy->usb_lpm_clk, PHY_LPM_CLK_RATE);
+	if (ret)
+		return ret;
+
+	ret = clk_set_rate(phy->usb_stb_clk, PHY_STB_CLK_RATE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int cv1800_usb_phy_set_mode(struct phy *_phy,
+				   enum phy_mode mode, int submode)
+{
+	struct cv1800_usb_phy *phy = phy_get_drvdata(_phy);
+	bool is_host;
+
+	switch (mode) {
+	case PHY_MODE_USB_DEVICE:
+		is_host = false;
+		phy->enable_otg = false;
+		break;
+	case PHY_MODE_USB_HOST:
+		is_host = true;
+		phy->enable_otg = false;
+		break;
+	case PHY_MODE_USB_OTG:
+		/* phy only supports soft OTG when VBUS_DET pin is connected. */
+		if (phy->vbus_det_irq > 0) {
+			phy->enable_otg = true;
+			queue_delayed_work(system_wq, &phy->vbus_work,
+					   PHY_VBUS_DET_DEBOUNCE_TIME);
+		}
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	return cv1800_usb_phy_set_mode_internal(phy, is_host);
+}
+
+static const struct phy_ops cv1800_usb_phy_ops = {
+	.set_mode	= cv1800_usb_phy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static void cv1800_usb_phy_vbus_switch(struct work_struct *work)
+{
+	struct cv1800_usb_phy *phy =
+		container_of(work, struct cv1800_usb_phy, vbus_work.work);
+	int state = gpiod_get_value_cansleep(phy->vbus_det_gpio);
+
+	cv1800_usb_phy_set_mode_internal(phy, state == 0);
+}
+
+static irqreturn_t cv1800_usb_phy_vbus_det_irq(int irq, void *dev_id)
+{
+	struct cv1800_usb_phy *phy = dev_id;
+
+	if (phy->enable_otg)
+		queue_delayed_work(system_wq, &phy->vbus_work,
+				   PHY_VBUS_DET_DEBOUNCE_TIME);
+	return IRQ_HANDLED;
+}
+
+static void cv1800_usb_phy_init_mode(struct device *dev,
+				     struct cv1800_usb_phy *phy)
+{
+	phy->enable_otg = false;
+
+	if (phy->vbus_det_irq > 0)
+		phy->enable_otg = true;
+
+	if (phy->enable_otg)
+		queue_delayed_work(system_wq, &phy->vbus_work, 0);
+	else
+		cv1800_usb_phy_set_mode_internal(phy, true);
+}
+
+static int cv1800_usb_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device *parent = dev->parent;
+	struct cv1800_usb_phy *phy;
+	struct phy_provider *phy_provider;
+	int ret;
+
+	if (!parent)
+		return -ENODEV;
+
+	phy = devm_kmalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->syscon = syscon_node_to_regmap(parent->of_node);
+	if (IS_ERR_OR_NULL(phy->syscon))
+		return -ENODEV;
+
+	spin_lock_init(&phy->lock);
+
+	phy->usb_phy_clk = devm_clk_get_enabled(dev, "phy");
+	if (IS_ERR(phy->usb_phy_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->usb_phy_clk),
+			"Failed to get phy clock\n");
+
+	phy->usb_app_clk = devm_clk_get_enabled(dev, "app");
+	if (IS_ERR(phy->usb_app_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->usb_app_clk),
+			"Failed to get app clock\n");
+
+	phy->usb_lpm_clk = devm_clk_get_enabled(dev, "lpm");
+	if (IS_ERR(phy->usb_lpm_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->usb_lpm_clk),
+			"Failed to get lpm clock\n");
+
+	phy->usb_stb_clk = devm_clk_get_enabled(dev, "stb");
+	if (IS_ERR(phy->usb_stb_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->usb_stb_clk),
+			"Failed to get stb clock\n");
+
+	phy->phy = devm_phy_create(dev, NULL, &cv1800_usb_phy_ops);
+	if (IS_ERR(phy->phy))
+		return dev_err_probe(dev, PTR_ERR(phy->phy),
+			"Failed to create phy\n");
+
+	ret = cv1800_usb_phy_set_clock(phy);
+	if (ret)
+		return ret;
+
+	phy->switch_gpios = devm_gpiod_get_array_optional(dev, "sophgo,switch",
+							  GPIOD_OUT_LOW);
+	if (IS_ERR(phy->switch_gpios))
+		return dev_err_probe(dev, PTR_ERR(phy->switch_gpios),
+			"Failed to get switch pin\n");
+
+	phy->vbus_det_gpio = devm_gpiod_get_optional(dev, "vbus_det", GPIOD_IN);
+	if (IS_ERR(phy->vbus_det_gpio))
+		return dev_err_probe(dev, PTR_ERR(phy->vbus_det_gpio),
+			"Failed to process vbus pin\n");
+
+	phy->vbus_det_irq = gpiod_to_irq(phy->vbus_det_gpio);
+	if (phy->vbus_det_irq > 0) {
+		ret = devm_request_irq(dev, phy->vbus_det_irq,
+				       cv1800_usb_phy_vbus_det_irq,
+				       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				       "usb-vbus-det", phy);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				"Failed to request vbus irq\n");
+	}
+
+	INIT_DELAYED_WORK(&phy->vbus_work, cv1800_usb_phy_vbus_switch);
+
+	ret = sysfs_create_group(&dev->kobj, &cv1800_usb_phy_group);
+	if (ret)
+		dev_warn(dev, "failed to create sysfs attributes\n");
+
+	phy_set_drvdata(phy->phy, phy);
+	platform_set_drvdata(pdev, phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	/*
+	 * phy needs to change mode twice after initialization,
+	 * otherwise the controller can not found devices attached
+	 * to the phy.
+	 */
+	cv1800_usb_phy_set_idpad(phy, false);
+	cv1800_usb_phy_set_idpad(phy, true);
+	cv1800_usb_phy_init_mode(dev, phy);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static void cv1800_usb_phy_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cv1800_usb_phy *phy = platform_get_drvdata(pdev);
+
+	if (phy->vbus_det_irq > 0)
+		devm_free_irq(dev, phy->vbus_det_irq, phy);
+
+	cancel_delayed_work_sync(&phy->vbus_work);
+}
+
+static const struct of_device_id cv1800_usb_phy_ids[] = {
+	{ .compatible = "sophgo,cv1800-usb-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, cv1800_usb_phy_ids);
+
+static struct platform_driver cv1800_usb_phy_driver = {
+	.probe = cv1800_usb_phy_probe,
+	.remove_new = cv1800_usb_phy_remove,
+	.driver = {
+		.name = "cv1800-usb-phy",
+		.of_match_table = cv1800_usb_phy_ids,
+	 },
+};
+module_platform_driver(cv1800_usb_phy_driver);
+MODULE_DESCRIPTION("CV1800/SG2000 SoC USB 2.0 PHY driver");
+MODULE_LICENSE("GPL");
--
2.45.0


