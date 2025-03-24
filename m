Return-Path: <linux-kernel+bounces-573395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BDCA6D6B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D777A3BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94AB25D8FA;
	Mon, 24 Mar 2025 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnlb5L+c"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93CD25D91D;
	Mon, 24 Mar 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806556; cv=none; b=RrFHVZWmDrqr0NANiL89BMlruR4H1bq7d06B5bEh+RpQJdxVfXGLcfauyqerQD3lUFvM8Z4muaHNWnK6NuxmKWx+tThmGj+QVuASeq1N9yLNV8EdIlWLsnYRl7dLJwvXx5ppiqsAYyqOnpCn0aTkeimWikFeE1CdPzh40fkab9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806556; c=relaxed/simple;
	bh=DB/X0LU8gQIlCc5gVIBK4u76r4kLg9J3TBbKIHqEQUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMmN2AUpFIbzT5RfuZVRs/ibL0NOgz3LTPkZt6T+Db1+ZW9/Z3UMd046NEjq9FZ5NwYXwayov5phqE4vN3tsUfjXA3toPfHMQxM0ClBaN5pj6pBiixpPrhvMrvWP8L1kaloCRxcNAfNElppbT04JZUD+IqKEwcLfe6XRwz21CZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hnlb5L+c; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-549b159c84cso4591499e87.3;
        Mon, 24 Mar 2025 01:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806553; x=1743411353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4SsB8XbK8W+HMDquewFyyKWC1S7pOJh0hm/wPXerbKQ=;
        b=Hnlb5L+c+L2HSxMlyeCwL5jiHHONdvvHH6dkYwAXaXdEr/LZGfYRNK8b4KO/OVMLys
         CHk7uvLsikuRNulxso2XGkm9SclVsUl2LfAi2njhwgHd+rMtvCiGVjnQDpYhk4g1rtA5
         kkquwkN/PXIQHq9NOiY1wok8CFiQCZEZ0d66OugZ41iA4oZH6JRKRsBpkNf4yNfHZcyg
         WgkLRh+pUL8LMXEwR8c2K4uWw+KMoMFoGrMY+ru3oLGs2NxdHhs7SDTpnC9dxZWob8VN
         o/7p2nS25mjvxIkmvFRP32H9ul7+mmvyN5sO9XCbBS62jhSK939YFUbDz4/PLgmrs1Em
         zODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806553; x=1743411353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SsB8XbK8W+HMDquewFyyKWC1S7pOJh0hm/wPXerbKQ=;
        b=lEI+2YKT0SklmY6RVibxHPXWC31uiauxKFCjQ3b/Ewf2wdYXSTLkitgPPkEzYRhc6o
         1fD4R4g7C/tsWAgSwvAnX8HsqovFt2I7HLSbGv+7R80pc1B3MjKVXM6lcdyJQWbu1yDl
         zGaYASP0AESV2WOZ3BX2+ucdbMHvHkhwBvVVUNu7XtEQOPGXUivu4ENni6eDCiamC+He
         eOKEifLUc31xYQMjJBkt7+OTColB0bxkLY4VhgyF32gz8PR4ddqu995kWGukr2Ndj3V0
         DZxQcxjzgafdHgS95dvjdWZLtbEgjKRldmp+mvOIA9kdyS1WiC98XRcCIBD7PBxjob5v
         P2fw==
X-Forwarded-Encrypted: i=1; AJvYcCUmAVkfMkMMgr5Zp/zIYTM1Xd+zp0Wgsep6Z47eBjEbL+JjBw2t/jIPywyII/2afcBA5znnevq5kroO310l@vger.kernel.org, AJvYcCVmKesJcdplcdAcreDTMF1kueEUIvCg3nZZ6CxyXrlWYbtKxm+/L+3vxnKP6GqbD6bqmlPyX3OvKY+U@vger.kernel.org
X-Gm-Message-State: AOJu0YyOzWbAYXkqRnvLRKAuz6phwQkEsL5qeMBw3hgcQkH8WpZakw4w
	e+XdxrRAmqSG2dCletko3znTRIBe82DfYYNiBGdvc7aJusdqbdVC
X-Gm-Gg: ASbGncvuclt9TBUSzaWD7u/iWRQcGY/W8Bb4CMOCJvaQYrfccHnSwm7gyJBG6H19Ie/
	AWWndul0IT6NVhPEzazqWMH5c2aHlLqDmHPQ/shFwD3uDE4VDvM1/b5RAlnIrtux9qKU9TDRe3G
	WlBuESsXKnXekNtUsjUmamTUPVXbXDrOFbByc6aCMwzvOS9np/XX1rBjtpAZ6PmkocN0dkTOkPj
	z5IeP0JeKB9O7avEOfXrSiEtBbWjj9ZjGl4E/Hr5f2TjxURHFaUiG9ByOqp6wf+bTVE+U8WyNeT
	9nuVdbPC3ib34NSgMSBRf46VcebkOT/rBGfRGfrJe+XBjj0Y8vM=
X-Google-Smtp-Source: AGHT+IHW44nAO6YaRFjs6LRWAzk3QzteoRWXUot99Z4qhMXv2r7JTR7AnwyEwhJL3xWPEkuZOOSAsg==
X-Received: by 2002:a05:6512:3b23:b0:549:4e7b:dcf7 with SMTP id 2adb3069b0e04-54ad6479ab3mr5265317e87.3.1742806552477;
        Mon, 24 Mar 2025 01:55:52 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64688f9sm1049113e87.15.2025.03.24.01.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:55:51 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:55:47 +0200
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
Subject: [PATCH v2 06/14] mfd: bd96801: Drop IC name from the regulator IRQ
 resources
Message-ID: <368a819143ab397306e81175242d55c3c8d97365.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jrpnN+PiNM5rzE+q"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--jrpnN+PiNM5rzE+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The resources generated in the BD96801 MFD driver are only visible to
the sub-drivers whose resource fields they are added. This makes
abbreviating the resource name with the IC name pointless. It just adds
confusion in those sub-drivers which do not really care the exact model
that generates the IRQ but just want to know the purpose IRQ was
generated for. This is a preparatory fix to simplify adding support for
ROHM BD96802 PMIC.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> :
  - No changes

NOTE: This commit shall break the bd96801-regulator driver unless a
follow-up regulator commit is also included. Compilation should not be
broken though so squashing should not be mandatory as long as both this
MFD commit and the regulator commit will end up in same release.
---
 drivers/mfd/rohm-bd96801.c | 187 +++++++++++++++++++------------------
 1 file changed, 94 insertions(+), 93 deletions(-)

diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
index 52e25d7ca888..d1d2a4cea605 100644
--- a/drivers/mfd/rohm-bd96801.c
+++ b/drivers/mfd/rohm-bd96801.c
@@ -55,105 +55,106 @@ struct bd968xx {
 };
=20
 static const struct resource bd96801_reg_errb_irqs[] =3D {
-	DEFINE_RES_IRQ_NAMED(BD96801_OTP_ERR_STAT, "bd96801-otp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_DBIST_ERR_STAT, "bd96801-dbist-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_EEP_ERR_STAT, "bd96801-eep-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_ABIST_ERR_STAT, "bd96801-abist-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_PRSTB_ERR_STAT, "bd96801-prstb-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_DRMOS1_ERR_STAT, "bd96801-drmoserr1"),
-	DEFINE_RES_IRQ_NAMED(BD96801_DRMOS2_ERR_STAT, "bd96801-drmoserr2"),
-	DEFINE_RES_IRQ_NAMED(BD96801_SLAVE_ERR_STAT, "bd96801-slave-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_VREF_ERR_STAT, "bd96801-vref-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_TSD_ERR_STAT, "bd96801-tsd"),
-	DEFINE_RES_IRQ_NAMED(BD96801_UVLO_ERR_STAT, "bd96801-uvlo-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_OVLO_ERR_STAT, "bd96801-ovlo-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_OSC_ERR_STAT, "bd96801-osc-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_PON_ERR_STAT, "bd96801-pon-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_POFF_ERR_STAT, "bd96801-poff-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_CMD_SHDN_ERR_STAT, "bd96801-cmd-shdn-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_OTP_ERR_STAT, "otp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_DBIST_ERR_STAT, "dbist-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_EEP_ERR_STAT, "eep-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_ABIST_ERR_STAT, "abist-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_PRSTB_ERR_STAT, "prstb-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_DRMOS1_ERR_STAT, "drmoserr1"),
+	DEFINE_RES_IRQ_NAMED(BD96801_DRMOS2_ERR_STAT, "drmoserr2"),
+	DEFINE_RES_IRQ_NAMED(BD96801_SLAVE_ERR_STAT, "slave-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_VREF_ERR_STAT, "vref-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_TSD_ERR_STAT, "tsd"),
+	DEFINE_RES_IRQ_NAMED(BD96801_UVLO_ERR_STAT, "uvlo-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_OVLO_ERR_STAT, "ovlo-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_OSC_ERR_STAT, "osc-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_PON_ERR_STAT, "pon-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_POFF_ERR_STAT, "poff-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_CMD_SHDN_ERR_STAT, "cmd-shdn-err"),
=20
 	DEFINE_RES_IRQ_NAMED(BD96801_INT_PRSTB_WDT_ERR, "bd96801-prstb-wdt-err"),
 	DEFINE_RES_IRQ_NAMED(BD96801_INT_CHIP_IF_ERR, "bd96801-chip-if-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_INT_SHDN_ERR_STAT, "bd96801-int-shdn-err"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_PVIN_ERR_STAT, "bd96801-buck1-pvin-err=
"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OVP_ERR_STAT, "bd96801-buck1-ovp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_UVP_ERR_STAT, "bd96801-buck1-uvp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_SHDN_ERR_STAT, "bd96801-buck1-shdn-err=
"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_PVIN_ERR_STAT, "bd96801-buck2-pvin-err=
"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OVP_ERR_STAT, "bd96801-buck2-ovp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_UVP_ERR_STAT, "bd96801-buck2-uvp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_SHDN_ERR_STAT, "bd96801-buck2-shdn-err=
"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_PVIN_ERR_STAT, "bd96801-buck3-pvin-err=
"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OVP_ERR_STAT, "bd96801-buck3-ovp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_UVP_ERR_STAT, "bd96801-buck3-uvp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_SHDN_ERR_STAT, "bd96801-buck3-shdn-err=
"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_PVIN_ERR_STAT, "bd96801-buck4-pvin-err=
"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OVP_ERR_STAT, "bd96801-buck4-ovp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_UVP_ERR_STAT, "bd96801-buck4-uvp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_SHDN_ERR_STAT, "bd96801-buck4-shdn-err=
"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_PVIN_ERR_STAT, "bd96801-ldo5-pvin-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_OVP_ERR_STAT, "bd96801-ldo5-ovp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_UVP_ERR_STAT, "bd96801-ldo5-uvp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_SHDN_ERR_STAT, "bd96801-ldo5-shdn-err"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_PVIN_ERR_STAT, "bd96801-ldo6-pvin-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_OVP_ERR_STAT, "bd96801-ldo6-ovp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_UVP_ERR_STAT, "bd96801-ldo6-uvp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_SHDN_ERR_STAT, "bd96801-ldo6-shdn-err"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_PVIN_ERR_STAT, "bd96801-ldo7-pvin-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_OVP_ERR_STAT, "bd96801-ldo7-ovp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_UVP_ERR_STAT, "bd96801-ldo7-uvp-err"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_SHDN_ERR_STAT, "bd96801-ldo7-shdn-err"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_INT_SHDN_ERR_STAT, "int-shdn-err"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_PVIN_ERR_STAT, "buck1-pvin-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OVP_ERR_STAT, "buck1-ovp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_UVP_ERR_STAT, "buck1-uvp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_SHDN_ERR_STAT, "buck1-shdn-err"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_PVIN_ERR_STAT, "buck2-pvin-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OVP_ERR_STAT, "buck2-ovp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_UVP_ERR_STAT, "buck2-uvp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_SHDN_ERR_STAT, "buck2-shdn-err"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_PVIN_ERR_STAT, "buck3-pvin-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OVP_ERR_STAT, "buck3-ovp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_UVP_ERR_STAT, "buck3-uvp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_SHDN_ERR_STAT, "buck3-shdn-err"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_PVIN_ERR_STAT, "buck4-pvin-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OVP_ERR_STAT, "buck4-ovp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_UVP_ERR_STAT, "buck4-uvp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_SHDN_ERR_STAT, "buck4-shdn-err"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_PVIN_ERR_STAT, "ldo5-pvin-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_OVP_ERR_STAT, "ldo5-ovp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_UVP_ERR_STAT, "ldo5-uvp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_SHDN_ERR_STAT, "ldo5-shdn-err"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_PVIN_ERR_STAT, "ldo6-pvin-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_OVP_ERR_STAT, "ldo6-ovp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_UVP_ERR_STAT, "ldo6-uvp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_SHDN_ERR_STAT, "ldo6-shdn-err"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_PVIN_ERR_STAT, "ldo7-pvin-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_OVP_ERR_STAT, "ldo7-ovp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_UVP_ERR_STAT, "ldo7-uvp-err"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_SHDN_ERR_STAT, "ldo7-shdn-err"),
 };
=20
 static const struct resource bd96801_reg_intb_irqs[] =3D {
-	DEFINE_RES_IRQ_NAMED(BD96801_TW_STAT, "bd96801-core-thermal"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OCPH_STAT, "bd96801-buck1-overcurr-h"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OCPL_STAT, "bd96801-buck1-overcurr-l"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OCPN_STAT, "bd96801-buck1-overcurr-n"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OVD_STAT, "bd96801-buck1-overvolt"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_UVD_STAT, "bd96801-buck1-undervolt"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_TW_CH_STAT, "bd96801-buck1-thermal"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OCPH_STAT, "bd96801-buck2-overcurr-h"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OCPL_STAT, "bd96801-buck2-overcurr-l"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OCPN_STAT, "bd96801-buck2-overcurr-n"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OVD_STAT, "bd96801-buck2-overvolt"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_UVD_STAT, "bd96801-buck2-undervolt"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_TW_CH_STAT, "bd96801-buck2-thermal"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OCPH_STAT, "bd96801-buck3-overcurr-h"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OCPL_STAT, "bd96801-buck3-overcurr-l"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OCPN_STAT, "bd96801-buck3-overcurr-n"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OVD_STAT, "bd96801-buck3-overvolt"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_UVD_STAT, "bd96801-buck3-undervolt"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_TW_CH_STAT, "bd96801-buck3-thermal"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OCPH_STAT, "bd96801-buck4-overcurr-h"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OCPL_STAT, "bd96801-buck4-overcurr-l"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OCPN_STAT, "bd96801-buck4-overcurr-n"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OVD_STAT, "bd96801-buck4-overvolt"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_UVD_STAT, "bd96801-buck4-undervolt"),
-	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_TW_CH_STAT, "bd96801-buck4-thermal"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_OCPH_STAT, "bd96801-ldo5-overcurr"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_OVD_STAT, "bd96801-ldo5-overvolt"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_UVD_STAT, "bd96801-ldo5-undervolt"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_OCPH_STAT, "bd96801-ldo6-overcurr"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_OVD_STAT, "bd96801-ldo6-overvolt"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_UVD_STAT, "bd96801-ldo6-undervolt"),
-
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_OCPH_STAT, "bd96801-ldo7-overcurr"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_OVD_STAT, "bd96801-ldo7-overvolt"),
-	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_UVD_STAT, "bd96801-ldo7-undervolt"),
+	DEFINE_RES_IRQ_NAMED(BD96801_TW_STAT, "core-thermal"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OCPH_STAT, "buck1-overcurr-h"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OCPL_STAT, "buck1-overcurr-l"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OCPN_STAT, "buck1-overcurr-n"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OVD_STAT, "buck1-overvolt"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_UVD_STAT, "buck1-undervolt"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_TW_CH_STAT, "buck1-thermal"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OCPH_STAT, "buck2-overcurr-h"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OCPL_STAT, "buck2-overcurr-l"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OCPN_STAT, "buck2-overcurr-n"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OVD_STAT, "buck2-overvolt"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_UVD_STAT, "buck2-undervolt"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_TW_CH_STAT, "buck2-thermal"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OCPH_STAT, "buck3-overcurr-h"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OCPL_STAT, "buck3-overcurr-l"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OCPN_STAT, "buck3-overcurr-n"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OVD_STAT, "buck3-overvolt"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_UVD_STAT, "buck3-undervolt"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_TW_CH_STAT, "buck3-thermal"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OCPH_STAT, "buck4-overcurr-h"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OCPL_STAT, "buck4-overcurr-l"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OCPN_STAT, "buck4-overcurr-n"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OVD_STAT, "buck4-overvolt"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_UVD_STAT, "buck4-undervolt"),
+	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_TW_CH_STAT, "buck4-thermal"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_OCPH_STAT, "ldo5-overcurr"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_OVD_STAT, "ldo5-overvolt"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_UVD_STAT, "ldo5-undervolt"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_OCPH_STAT, "ldo6-overcurr"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_OVD_STAT, "ldo6-overvolt"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_UVD_STAT, "ldo6-undervolt"),
+
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_OCPH_STAT, "ldo7-overcurr"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_OVD_STAT, "ldo7-overvolt"),
+	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_UVD_STAT, "ldo7-undervolt"),
 };
=20
 enum {
--=20
2.49.0


--jrpnN+PiNM5rzE+q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHhMACgkQeFA3/03a
ocU9uwf+Jc5w9WY9hICd0o410IJmN4CgXgZ0PB47xKtAi0q0fios/m6nlFzMKQEx
qofCfeW7lvwHUXyVPkQWhGEm8zrwKkR79Fmn/4qEhWVNtcZnWaAdHBM4oy0CzkSV
oTUniwH4v9RfHEOhUING/6nuhhV2j+r08XK+ISxFlKE476Kh1Puk3S1CCA32EIQj
OzZOu5CZ+A8lnUkeMdxW0N9/WVCyabt8Sozpq4scAeb1L4iVgdXXtE5hrORvN50J
cbXuTN1DjyA9/mhVTLEeCSUwVmImMihyRs7bhevaPyqKmoC2jU2unjyO9g2439ED
DeAW5MVWjQr2xJzNsSdCU4DbrgPbww==
=FxFp
-----END PGP SIGNATURE-----

--jrpnN+PiNM5rzE+q--

