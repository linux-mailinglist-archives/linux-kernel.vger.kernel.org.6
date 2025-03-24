Return-Path: <linux-kernel+bounces-573397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4724CA6D6BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C857A4D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B9425DAF8;
	Mon, 24 Mar 2025 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amxfGo3Z"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F025DAFC;
	Mon, 24 Mar 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806583; cv=none; b=GwNREjM5rwoKK4SzKOgYq8tifE1HiOcUm8EYptCRTzDsvFe4EbgYokKgJYzgCaMyDB2Uysh/SeECf/ZqHPs05yVZ4uK4NzAlCnc0dXVFK8+Q7YFkNhqbgU0ReqXAXy3W6TCYxJ5909Hs/vKk/qpHmc7eyhGojbjWC+Dt/4NtBTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806583; c=relaxed/simple;
	bh=9Jti7g9qqboQzb/NdDnfZobBQP4LsyPeIueT7lyprPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3pjZZB5qk21dJaw836kH9xEOW+Ji+ZQ7vbJfJtyotENAj0Aoo0EL7bAS9GvAG+x6MGtNncVYjfUoWxhTvdOh80epcxbPG/jrm8EtFV5S6AgSXZY+n+OqOQqXWBeTvMzIvwJhGdGLeNC3YEkOI/EwMpykt78W/CzcDy9gnR1mv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amxfGo3Z; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30762598511so46248391fa.0;
        Mon, 24 Mar 2025 01:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806578; x=1743411378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uS1lgo2Oz3ImoaNwI9lKZ792UxRuZgiVEZtposhWMgo=;
        b=amxfGo3ZMSXtCNe+81kzi+5zTyDKQLIp5eDd3xT33iE6ma3hxmk6LxoscFgVEVekjL
         PjkzCgQVKwCrtXlbpn0Z3ro/6b6cb/mgXC5Ez/slBJL0SR9dENx0DzK1IXwulO7heQFi
         Q/F79joM9ozLC/NdaYTMM417MKRfqGP93STzTANw210MDtqHi5w1svhVNc+8gUFqZ3KW
         WIBVRxr3AkzWn5RbZmiu1B5CadoAaRZ53kwu4ZT4A+OCQMp6cYthkitbzwj0mLJ6JeFw
         XYixVf7vbaY7XaCM/m1403gCxpYWLgo1qJ7xgMgnoBPWJbBa7CwYvf6rrjECZ5E5LOOz
         NeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806578; x=1743411378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS1lgo2Oz3ImoaNwI9lKZ792UxRuZgiVEZtposhWMgo=;
        b=PSmF14EubFfkPdFGL4IeXyw48QdJK0m2KHIM5ivHxtoohZfhFMqFrlbBaa/3EE/1n+
         2XdVyZQU/XApjORJ16lLtCQ3HX/IhT1g8rzyt19OUi6aOFoBToWXpdx59UJ22FxCXfU/
         nhKu+xjaMGSwW8hpVfN+Qx8qGjbseLenm++kDMPdu5nKjIuJ1lVJGdPCgf2+YKMbURoc
         ivDdVwf4MdcGS1pB5mg01MOKQ5CxzBSQTOSBfUxx50TL9MQjbk898WVUyJV4/0PpM9B9
         Yg6PKfjT2anxzYQdGkh2OKSwZbekzGwy2761JjidCOXjf0A7tfu+uHxBZmGAz/QWai1R
         /j7A==
X-Forwarded-Encrypted: i=1; AJvYcCV2WHCSIbHHSZppikK65RfHYIN9uXRiLeX0OrigTWn0fEajjZ8goSCrK/EHPIhI/NZ5mc1ojCXzAdtA@vger.kernel.org, AJvYcCWl/UjsD0pluWzgzwefLKG6QtvkksY9Iq6cbhxIAXcNwiJ8cpCGqZy+sjc5QQsKa50b7mKznLqByJXvCrBW@vger.kernel.org
X-Gm-Message-State: AOJu0YxI9ufMuYU2wDSTuYVuvr525u8ZdNDGD1f3UMJfpIuE14sV3i7R
	xJc8nMn7r3+6sc/HmpjxzP/muWf7M/flDrJlmBtJy0J/nmFV2yCi
X-Gm-Gg: ASbGncu86TI6JQ5mbVtcQcYjQ88eSTm/ZvLG7X7yGVCyS+cTwNLDYowG+hqRxgE1zq/
	yrBbe5a6Xpu+7oCmsnDxEHBRq+vtWHCluwCgfSxBxR9DIaGzfmDzWctf0r1r0R2fxdEOqZs/fiZ
	AwLoIXLH/H2PpNR87/W2Hy4DY7bfmwA+V/9Y0QFJI1dN6/S4J0TFPuaQZnt+YrhZMlzv4jUvDBI
	mpw5ayUsXVAKVGOTbJpScF/7iRt9mJ0Hc1C3isTVeqEcTSq9VwtnKad8vBH6zFyC2FynZFOxw6/
	yrjZxlaS6v1CdmdikO49bg1ccPzTNqrHveGR29DsbkfwqI7J/nM=
X-Google-Smtp-Source: AGHT+IEOi8b3Avu7qUF/B9H0/8kWmTQJP+WIi1rL265QRQtUf2segUgjCcBpbAUwxrSk5kx0hYxnZQ==
X-Received: by 2002:a2e:9ec6:0:b0:30b:f2d6:8aab with SMTP id 38308e7fff4ca-30d7e31b7efmr40096771fa.32.1742806578189;
        Mon, 24 Mar 2025 01:56:18 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d895a34b5sm10254311fa.22.2025.03.24.01.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:56:17 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:56:12 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/14] mfd: rohm-bd96801: Support ROHM BD96802
Message-ID: <d5efecf07ded4f46f271581082fd5c542a302b51.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xFOCis4T9NcAgnNn"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--xFOCis4T9NcAgnNn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96802 PMIC looks from software point of view a lot like ROHM
BD96801 PMIC. Just with reduced number of voltage rails. Both PMICs
provide two physical IRQ lines referred as INTB and ERRB and contain
blocks implementing regulator controls and a weatchdog. Hence it makes
sense to use same MFD core for both PMICs.

Add support for ROHM BD96802 scalable companion PMIC to the BD96801
core driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - Use chip_type enum
---
 drivers/mfd/rohm-bd96801.c       | 239 ++++++++++++++++++++++++++++++-
 include/linux/mfd/rohm-bd96801.h |   2 +
 include/linux/mfd/rohm-bd96802.h |  74 ++++++++++
 include/linux/mfd/rohm-generic.h |   1 +
 4 files changed, 311 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/mfd/rohm-bd96802.h

diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
index d1d2a4cea605..e5ee5f556a55 100644
--- a/drivers/mfd/rohm-bd96801.c
+++ b/drivers/mfd/rohm-bd96801.c
@@ -38,6 +38,7 @@
 #include <linux/types.h>
=20
 #include <linux/mfd/rohm-bd96801.h>
+#include <linux/mfd/rohm-bd96802.h>
 #include <linux/mfd/rohm-generic.h>
=20
 struct bd968xx {
@@ -113,6 +114,36 @@ static const struct resource bd96801_reg_errb_irqs[] =
=3D {
 	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_SHDN_ERR_STAT, "ldo7-shdn-err"),
 };
=20
+static const struct resource bd96802_reg_errb_irqs[] =3D {
+	DEFINE_RES_IRQ_NAMED(BD96802_OTP_ERR_STAT, "otp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_DBIST_ERR_STAT, "dbist-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_EEP_ERR_STAT, "eep-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_ABIST_ERR_STAT, "abist-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_PRSTB_ERR_STAT, "prstb-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_DRMOS1_ERR_STAT, "drmoserr1"),
+	DEFINE_RES_IRQ_NAMED(BD96802_DRMOS1_ERR_STAT, "drmoserr2"),
+	DEFINE_RES_IRQ_NAMED(BD96802_SLAVE_ERR_STAT, "slave-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_VREF_ERR_STAT, "vref-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_TSD_ERR_STAT, "tsd"),
+	DEFINE_RES_IRQ_NAMED(BD96802_UVLO_ERR_STAT, "uvlo-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_OVLO_ERR_STAT, "ovlo-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_OSC_ERR_STAT, "osc-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_PON_ERR_STAT, "pon-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_POFF_ERR_STAT, "poff-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_CMD_SHDN_ERR_STAT, "cmd-shdn-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_INT_SHDN_ERR_STAT, "int-shdn-err"),
+
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK1_PVIN_ERR_STAT, "buck1-pvin-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK1_OVP_ERR_STAT, "buck1-ovp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK1_UVP_ERR_STAT, "buck1-uvp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK1_SHDN_ERR_STAT, "buck1-shdn-err"),
+
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK2_PVIN_ERR_STAT, "buck2-pvin-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK2_OVP_ERR_STAT, "buck2-ovp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK2_UVP_ERR_STAT, "buck2-uvp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK2_SHDN_ERR_STAT, "buck2-shdn-err"),
+};
+
 static const struct resource bd96801_reg_intb_irqs[] =3D {
 	DEFINE_RES_IRQ_NAMED(BD96801_TW_STAT, "core-thermal"),
=20
@@ -157,6 +188,24 @@ static const struct resource bd96801_reg_intb_irqs[] =
=3D {
 	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_UVD_STAT, "ldo7-undervolt"),
 };
=20
+static const struct resource bd96802_reg_intb_irqs[] =3D {
+	DEFINE_RES_IRQ_NAMED(BD96802_TW_STAT, "core-thermal"),
+
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK1_OCPH_STAT, "buck1-overcurr-h"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK1_OCPL_STAT, "buck1-overcurr-l"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK1_OCPN_STAT, "buck1-overcurr-n"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK1_OVD_STAT, "buck1-overvolt"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK1_UVD_STAT, "buck1-undervolt"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK1_TW_CH_STAT, "buck1-thermal"),
+
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK2_OCPH_STAT, "buck2-overcurr-h"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK2_OCPL_STAT, "buck2-overcurr-l"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK2_OCPN_STAT, "buck2-overcurr-n"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK2_OVD_STAT, "buck2-overvolt"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK2_UVD_STAT, "buck2-undervolt"),
+	DEFINE_RES_IRQ_NAMED(BD96802_BUCK2_TW_CH_STAT, "buck2-thermal"),
+};
+
 enum {
 	WDG_CELL =3D 0,
 	REGULATOR_CELL,
@@ -167,6 +216,11 @@ static struct mfd_cell bd96801_cells[] =3D {
 	[REGULATOR_CELL] =3D { .name =3D "bd96801-regulator", },
 };
=20
+static struct mfd_cell bd96802_cells[] =3D {
+	[WDG_CELL] =3D { .name =3D "bd96801-wdt", },
+	[REGULATOR_CELL] =3D { .name =3D "bd96802-regulator", },
+};
+
 static const struct regmap_range bd96801_volatile_ranges[] =3D {
 	/* Status registers */
 	regmap_reg_range(BD96801_REG_WD_FEED, BD96801_REG_WD_FAILCOUNT),
@@ -184,11 +238,28 @@ static const struct regmap_range bd96801_volatile_ran=
ges[] =3D {
 	regmap_reg_range(BD96801_LDO5_VOL_LVL_REG, BD96801_LDO7_VOL_LVL_REG),
 };
=20
-static const struct regmap_access_table volatile_regs =3D {
+static const struct regmap_range bd96802_volatile_ranges[] =3D {
+	/* Status regs */
+	regmap_reg_range(BD96801_REG_WD_FEED, BD96801_REG_WD_FAILCOUNT),
+	regmap_reg_range(BD96801_REG_WD_ASK, BD96801_REG_WD_ASK),
+	regmap_reg_range(BD96801_REG_WD_STATUS, BD96801_REG_WD_STATUS),
+	regmap_reg_range(BD96801_REG_PMIC_STATE, BD96801_REG_INT_BUCK2_ERRB),
+	regmap_reg_range(BD96801_REG_INT_SYS_INTB, BD96801_REG_INT_BUCK2_INTB),
+	/* Registers which do not update value unless PMIC is in STBY */
+	regmap_reg_range(BD96801_REG_SSCG_CTRL, BD96801_REG_SHD_INTB),
+	regmap_reg_range(BD96801_REG_BUCK_OVP, BD96801_REG_BOOT_OVERTIME),
+};
+
+static const struct regmap_access_table bd96801_volatile_regs =3D {
 	.yes_ranges =3D bd96801_volatile_ranges,
 	.n_yes_ranges =3D ARRAY_SIZE(bd96801_volatile_ranges),
 };
=20
+static const struct regmap_access_table bd96802_volatile_regs =3D {
+	.yes_ranges =3D bd96802_volatile_ranges,
+	.n_yes_ranges =3D ARRAY_SIZE(bd96802_volatile_ranges),
+};
+
 /*
  * For ERRB we need main register bit mapping as bit(0) indicates active I=
RQ
  * in one of the first 3 sub IRQ registers, For INTB we can use default 1 =
to 1
@@ -203,7 +274,7 @@ static unsigned int bit5_offsets[] =3D {7};	/* LDO 5 st=
at */
 static unsigned int bit6_offsets[] =3D {8};	/* LDO 6 stat */
 static unsigned int bit7_offsets[] =3D {9};	/* LDO 7 stat */
=20
-static const struct regmap_irq_sub_irq_map errb_sub_irq_offsets[] =3D {
+static const struct regmap_irq_sub_irq_map bd96801_errb_sub_irq_offsets[] =
=3D {
 	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),
 	REGMAP_IRQ_MAIN_REG_OFFSET(bit1_offsets),
 	REGMAP_IRQ_MAIN_REG_OFFSET(bit2_offsets),
@@ -214,6 +285,12 @@ static const struct regmap_irq_sub_irq_map errb_sub_ir=
q_offsets[] =3D {
 	REGMAP_IRQ_MAIN_REG_OFFSET(bit7_offsets),
 };
=20
+static const struct regmap_irq_sub_irq_map bd96802_errb_sub_irq_offsets[] =
=3D {
+	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bit1_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bit2_offsets),
+};
+
 static const struct regmap_irq bd96801_errb_irqs[] =3D {
 	/* Reg 0x52 Fatal ERRB1 */
 	REGMAP_IRQ_REG(BD96801_OTP_ERR_STAT, 0, BD96801_OTP_ERR_MASK),
@@ -274,6 +351,39 @@ static const struct regmap_irq bd96801_errb_irqs[] =3D=
 {
 	REGMAP_IRQ_REG(BD96801_LDO7_SHDN_ERR_STAT, 9, BD96801_OUT_SHDN_ERR_MASK),
 };
=20
+static const struct regmap_irq bd96802_errb_irqs[] =3D {
+	/* Reg 0x52 Fatal ERRB1 */
+	REGMAP_IRQ_REG(BD96802_OTP_ERR_STAT, 0, BD96801_OTP_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_DBIST_ERR_STAT, 0, BD96801_DBIST_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_EEP_ERR_STAT, 0, BD96801_EEP_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_ABIST_ERR_STAT, 0, BD96801_ABIST_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_PRSTB_ERR_STAT, 0, BD96801_PRSTB_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_DRMOS1_ERR_STAT, 0, BD96801_DRMOS1_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_DRMOS2_ERR_STAT, 0, BD96801_DRMOS2_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_SLAVE_ERR_STAT, 0, BD96801_SLAVE_ERR_MASK),
+	/* 0x53 Fatal ERRB2 */
+	REGMAP_IRQ_REG(BD96802_VREF_ERR_STAT, 1, BD96801_VREF_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_TSD_ERR_STAT, 1, BD96801_TSD_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_UVLO_ERR_STAT, 1, BD96801_UVLO_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_OVLO_ERR_STAT, 1, BD96801_OVLO_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_OSC_ERR_STAT, 1, BD96801_OSC_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_PON_ERR_STAT, 1, BD96801_PON_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_POFF_ERR_STAT, 1, BD96801_POFF_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_CMD_SHDN_ERR_STAT, 1, BD96801_CMD_SHDN_ERR_MASK),
+	/* 0x54 Fatal INTB shadowed to ERRB */
+	REGMAP_IRQ_REG(BD96802_INT_SHDN_ERR_STAT, 2, BD96801_INT_SHDN_ERR_MASK),
+	/* Reg 0x55 BUCK1 ERR IRQs */
+	REGMAP_IRQ_REG(BD96802_BUCK1_PVIN_ERR_STAT, 3, BD96801_OUT_PVIN_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK1_OVP_ERR_STAT, 3, BD96801_OUT_OVP_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK1_UVP_ERR_STAT, 3, BD96801_OUT_UVP_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK1_SHDN_ERR_STAT, 3, BD96801_OUT_SHDN_ERR_MASK),
+	/* Reg 0x56 BUCK2 ERR IRQs */
+	REGMAP_IRQ_REG(BD96802_BUCK2_PVIN_ERR_STAT, 4, BD96801_OUT_PVIN_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK2_OVP_ERR_STAT, 4, BD96801_OUT_OVP_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK2_UVP_ERR_STAT, 4, BD96801_OUT_UVP_ERR_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK2_SHDN_ERR_STAT, 4, BD96801_OUT_SHDN_ERR_MASK),
+};
+
 static const struct regmap_irq bd96801_intb_irqs[] =3D {
 	/* STATUS SYSTEM INTB */
 	REGMAP_IRQ_REG(BD96801_TW_STAT, 0, BD96801_TW_STAT_MASK),
@@ -322,6 +432,69 @@ static const struct regmap_irq bd96801_intb_irqs[] =3D=
 {
 	REGMAP_IRQ_REG(BD96801_LDO7_UVD_STAT, 7, BD96801_LDO_UVD_STAT_MASK),
 };
=20
+static const struct regmap_irq bd96802_intb_irqs[] =3D {
+	/* STATUS SYSTEM INTB */
+	REGMAP_IRQ_REG(BD96802_TW_STAT, 0, BD96801_TW_STAT_MASK),
+	REGMAP_IRQ_REG(BD96802_WDT_ERR_STAT, 0, BD96801_WDT_ERR_STAT_MASK),
+	REGMAP_IRQ_REG(BD96802_I2C_ERR_STAT, 0, BD96801_I2C_ERR_STAT_MASK),
+	REGMAP_IRQ_REG(BD96802_CHIP_IF_ERR_STAT, 0, BD96801_CHIP_IF_ERR_STAT_MASK=
),
+	/* STATUS BUCK1 INTB */
+	REGMAP_IRQ_REG(BD96802_BUCK1_OCPH_STAT, 1, BD96801_BUCK_OCPH_STAT_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK1_OCPL_STAT, 1, BD96801_BUCK_OCPL_STAT_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK1_OCPN_STAT, 1, BD96801_BUCK_OCPN_STAT_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK1_OVD_STAT, 1, BD96801_BUCK_OVD_STAT_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK1_UVD_STAT, 1, BD96801_BUCK_UVD_STAT_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK1_TW_CH_STAT, 1, BD96801_BUCK_TW_CH_STAT_MASK),
+	/* BUCK 2 INTB */
+	REGMAP_IRQ_REG(BD96802_BUCK2_OCPH_STAT, 2, BD96801_BUCK_OCPH_STAT_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK2_OCPL_STAT, 2, BD96801_BUCK_OCPL_STAT_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK2_OCPN_STAT, 2, BD96801_BUCK_OCPN_STAT_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK2_OVD_STAT, 2, BD96801_BUCK_OVD_STAT_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK2_UVD_STAT, 2, BD96801_BUCK_UVD_STAT_MASK),
+	REGMAP_IRQ_REG(BD96802_BUCK2_TW_CH_STAT, 2, BD96801_BUCK_TW_CH_STAT_MASK),
+};
+
+/*
+ * The IRQ stuff is a bit hairy. The BD96801 / BD96802 provide two physical
+ * IRQ lines called INTB and ERRB. They share the same main status registe=
r.
+ *
+ * For ERRB, mapping from main status to sub-status is such that the
+ * 'global' faults are mapped to first 3 sub-status registers - and indica=
ted
+ * by the first bit[0] in main status reg.
+ *
+ * Rest of the status registers are for indicating stuff for individual
+ * regulators, 1 sub register / regulator and 1 main status register bit /
+ * regulator, starting from bit[1].
+ *
+ * Eg, regulator specific stuff has 1 to 1 mapping from main-status to sub
+ * registers but 'global' ERRB IRQs require mapping from main status bit[0=
] to
+ * 3 status registers.
+ *
+ * Furthermore, the BD96801 has 7 regulators where the BD96802 has only 2.
+ *
+ * INTB has only 1 sub status register for 'global' events and then own sub
+ * status register for each of the regulators. So, for INTB we have direct
+ * 1 to 1 mapping - BD96801 just having 5 register and 5 main status bits
+ * more than the BD96802.
+ *
+ * Sharing the main status bits could be a problem if we had both INTB and
+ * ERRB IRQs asserted but for different sub-status offsets. This might lead
+ * IRQ controller code to go read a sub status register which indicates no
+ * active IRQs. I assume this occurring repeteadly might lead the IRQ to be
+ * disabled by core as a result of repeteadly returned IRQ_NONEs.
+ *
+ * I don't consider this as a fatal problem for now because:
+ *	a) Having ERRB asserted leads to PMIC fault state which will kill
+ *	   the SoC powered by the PMIC. (So, relevant only for potential
+ *	   case of not powering the processor with this PMIC).
+ *	b) Having ERRB set without having respective INTB is unlikely
+ *	   (haven't actually verified this).
+ *
+ * So, let's proceed with main status enabled for both INTB and ERRB. We c=
an
+ * later disable main-status usage on systems where this ever proves to be
+ * a problem.
+ */
+
 static const struct regmap_irq_chip bd96801_irq_chip_errb =3D {
 	.name =3D "bd96801-irq-errb",
 	.domain_suffix =3D "errb",
@@ -335,7 +508,23 @@ static const struct regmap_irq_chip bd96801_irq_chip_e=
rrb =3D {
 	.init_ack_masked =3D true,
 	.num_regs =3D 10,
 	.irq_reg_stride =3D 1,
-	.sub_reg_offsets =3D &errb_sub_irq_offsets[0],
+	.sub_reg_offsets =3D &bd96801_errb_sub_irq_offsets[0],
+};
+
+static const struct regmap_irq_chip bd96802_irq_chip_errb =3D {
+	.name =3D "bd96802-irq-errb",
+	.domain_suffix =3D "errb",
+	.main_status =3D BD96801_REG_INT_MAIN,
+	.num_main_regs =3D 1,
+	.irqs =3D &bd96802_errb_irqs[0],
+	.num_irqs =3D ARRAY_SIZE(bd96802_errb_irqs),
+	.status_base =3D BD96801_REG_INT_SYS_ERRB1,
+	.mask_base =3D BD96801_REG_MASK_SYS_ERRB,
+	.ack_base =3D BD96801_REG_INT_SYS_ERRB1,
+	.init_ack_masked =3D true,
+	.num_regs =3D 5,
+	.irq_reg_stride =3D 1,
+	.sub_reg_offsets =3D &bd96802_errb_sub_irq_offsets[0],
 };
=20
 static const struct regmap_irq_chip bd96801_irq_chip_intb =3D {
@@ -353,10 +542,32 @@ static const struct regmap_irq_chip bd96801_irq_chip_=
intb =3D {
 	.irq_reg_stride =3D 1,
 };
=20
+static const struct regmap_irq_chip bd96802_irq_chip_intb =3D {
+	.name =3D "bd96802-irq-intb",
+	.domain_suffix =3D "intb",
+	.main_status =3D BD96801_REG_INT_MAIN,
+	.num_main_regs =3D 1,
+	.irqs =3D &bd96802_intb_irqs[0],
+	.num_irqs =3D ARRAY_SIZE(bd96802_intb_irqs),
+	.status_base =3D BD96801_REG_INT_SYS_INTB,
+	.mask_base =3D BD96801_REG_MASK_SYS_INTB,
+	.ack_base =3D BD96801_REG_INT_SYS_INTB,
+	.init_ack_masked =3D true,
+	.num_regs =3D 3,
+	.irq_reg_stride =3D 1,
+};
+
 static const struct regmap_config bd96801_regmap_config =3D {
 	.reg_bits =3D 8,
 	.val_bits =3D 8,
-	.volatile_table =3D &volatile_regs,
+	.volatile_table =3D &bd96801_volatile_regs,
+	.cache_type =3D REGCACHE_MAPLE,
+};
+
+static const struct regmap_config bd96802_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.volatile_table =3D &bd96802_volatile_regs,
 	.cache_type =3D REGCACHE_MAPLE,
 };
=20
@@ -374,6 +585,20 @@ static const struct bd968xx bd96801_data =3D {
 	.unlock_val =3D BD96801_UNLOCK,
 };
=20
+static const struct bd968xx bd96802_data =3D {
+	.errb_irqs =3D bd96802_reg_errb_irqs,
+	.intb_irqs =3D bd96802_reg_intb_irqs,
+	.num_errb_irqs =3D ARRAY_SIZE(bd96802_reg_errb_irqs),
+	.num_intb_irqs =3D ARRAY_SIZE(bd96802_reg_intb_irqs),
+	.errb_irq_chip =3D &bd96802_irq_chip_errb,
+	.intb_irq_chip =3D &bd96802_irq_chip_intb,
+	.regmap_config =3D &bd96802_regmap_config,
+	.cells =3D bd96802_cells,
+	.num_cells =3D ARRAY_SIZE(bd96802_cells),
+	.unlock_reg =3D BD96801_LOCK_REG,
+	.unlock_val =3D BD96801_UNLOCK,
+};
+
 static int bd96801_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_irq_chip_data *intb_irq_data, *errb_irq_data;
@@ -393,6 +618,9 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
 	case ROHM_CHIP_TYPE_BD96801:
 		ddata =3D &bd96801_data;
 		break;
+	case ROHM_CHIP_TYPE_BD96802:
+		ddata =3D &bd96802_data;
+		break;
 	default:
 		dev_err(&i2c->dev, "Unknown IC\n");
 		return -EINVAL;
@@ -488,6 +716,7 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
=20
 static const struct of_device_id bd96801_of_match[] =3D {
 	{ .compatible =3D "rohm,bd96801", .data =3D (void *)ROHM_CHIP_TYPE_BD9680=
1 },
+	{ .compatible =3D "rohm,bd96802", .data =3D (void *)ROHM_CHIP_TYPE_BD9680=
2 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bd96801_of_match);
@@ -515,5 +744,5 @@ static void __exit bd96801_i2c_exit(void)
 module_exit(bd96801_i2c_exit);
=20
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("ROHM BD96801 Power Management IC driver");
+MODULE_DESCRIPTION("ROHM BD9680X Power Management IC driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/rohm-bd96801.h b/include/linux/mfd/rohm-bd96=
801.h
index e2d9e10b6364..68c8ac8ad409 100644
--- a/include/linux/mfd/rohm-bd96801.h
+++ b/include/linux/mfd/rohm-bd96801.h
@@ -40,7 +40,9 @@
  * INTB status registers are at range 0x5c ... 0x63
  */
 #define BD96801_REG_INT_SYS_ERRB1	0x52
+#define BD96801_REG_INT_BUCK2_ERRB	0x56
 #define BD96801_REG_INT_SYS_INTB	0x5c
+#define BD96801_REG_INT_BUCK2_INTB	0x5e
 #define BD96801_REG_INT_LDO7_INTB	0x63
=20
 /* MASK registers */
diff --git a/include/linux/mfd/rohm-bd96802.h b/include/linux/mfd/rohm-bd96=
802.h
new file mode 100644
index 000000000000..bf4b77944edf
--- /dev/null
+++ b/include/linux/mfd/rohm-bd96802.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025 ROHM Semiconductors
+ *
+ * The digital interface of trhe BD96802 PMIC is a reduced version of the
+ * BD96801. Hence the BD96801 definitions are used for registers and masks
+ * while this header only holds the IRQ definitions - mainly to avoid gaps=
 in
+ * IRQ numbers caused by the lack of some BUCKs / LDOs and their respective
+ * IRQs.
+ */
+
+#ifndef __LINUX_MFD_BD96802_H__
+#define __LINUX_MFD_BD96802_H__
+
+/* ERRB IRQs */
+enum {
+	/* Reg 0x52, 0x53, 0x54 - ERRB system IRQs */
+	BD96802_OTP_ERR_STAT,
+	BD96802_DBIST_ERR_STAT,
+	BD96802_EEP_ERR_STAT,
+	BD96802_ABIST_ERR_STAT,
+	BD96802_PRSTB_ERR_STAT,
+	BD96802_DRMOS1_ERR_STAT,
+	BD96802_DRMOS2_ERR_STAT,
+	BD96802_SLAVE_ERR_STAT,
+	BD96802_VREF_ERR_STAT,
+	BD96802_TSD_ERR_STAT,
+	BD96802_UVLO_ERR_STAT,
+	BD96802_OVLO_ERR_STAT,
+	BD96802_OSC_ERR_STAT,
+	BD96802_PON_ERR_STAT,
+	BD96802_POFF_ERR_STAT,
+	BD96802_CMD_SHDN_ERR_STAT,
+	BD96802_INT_SHDN_ERR_STAT,
+
+	/* Reg 0x55 BUCK1 ERR IRQs */
+	BD96802_BUCK1_PVIN_ERR_STAT,
+	BD96802_BUCK1_OVP_ERR_STAT,
+	BD96802_BUCK1_UVP_ERR_STAT,
+	BD96802_BUCK1_SHDN_ERR_STAT,
+
+	/* Reg 0x56 BUCK2 ERR IRQs */
+	BD96802_BUCK2_PVIN_ERR_STAT,
+	BD96802_BUCK2_OVP_ERR_STAT,
+	BD96802_BUCK2_UVP_ERR_STAT,
+	BD96802_BUCK2_SHDN_ERR_STAT,
+};
+
+/* INTB IRQs */
+enum {
+	/* Reg 0x5c (System INTB) */
+	BD96802_TW_STAT,
+	BD96802_WDT_ERR_STAT,
+	BD96802_I2C_ERR_STAT,
+	BD96802_CHIP_IF_ERR_STAT,
+
+	/* Reg 0x5d (BUCK1 INTB) */
+	BD96802_BUCK1_OCPH_STAT,
+	BD96802_BUCK1_OCPL_STAT,
+	BD96802_BUCK1_OCPN_STAT,
+	BD96802_BUCK1_OVD_STAT,
+	BD96802_BUCK1_UVD_STAT,
+	BD96802_BUCK1_TW_CH_STAT,
+
+	/* Reg 0x5e (BUCK2 INTB) */
+	BD96802_BUCK2_OCPH_STAT,
+	BD96802_BUCK2_OCPL_STAT,
+	BD96802_BUCK2_OCPN_STAT,
+	BD96802_BUCK2_OVD_STAT,
+	BD96802_BUCK2_UVD_STAT,
+	BD96802_BUCK2_TW_CH_STAT,
+};
+
+#endif
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-gene=
ric.h
index e7d4e6afe388..11b86f9129e3 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -17,6 +17,7 @@ enum rohm_chip_type {
 	ROHM_CHIP_TYPE_BD71837,
 	ROHM_CHIP_TYPE_BD71847,
 	ROHM_CHIP_TYPE_BD96801,
+	ROHM_CHIP_TYPE_BD96802,
 	ROHM_CHIP_TYPE_AMOUNT
 };
=20
--=20
2.49.0


--xFOCis4T9NcAgnNn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHiwACgkQeFA3/03a
ocUFvwf7BySZ6IOMQXi0lClwTyHoznPGEV2WE4WldQ/yBhusthJ3+4vhWcGT8+yK
I/lcw2RC/mjiG/y7ncOePWJ4ohRolggSYFyH6dTqAn4rdU0P1hbbgNMGIM29ZlLb
FDMYOIWn/SstAAWgjNC7jjor+Mq6FjQEllueWxhKHNfDRR4wxVDXTlPt0NTIx1pa
iBAeDxhQu0Tmh70fNNHxl3WVF/gPK2L0VeDw63FxWAOcQzUdJ+4nOfMgQaU/ymfW
X/1SDngyRdqEwDoE0v5YzS6epoPwAXpORVkJi8rcsFDS1iv6ZhtodQ8HCB5XMfoE
40YJLVYk9KjF6Y7XetbePtWJJiK+Hg==
=WKCT
-----END PGP SIGNATURE-----

--xFOCis4T9NcAgnNn--

