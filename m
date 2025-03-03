Return-Path: <linux-kernel+bounces-544408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2756AA4E0E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27E3189FC88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF2F207A0D;
	Tue,  4 Mar 2025 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSgkgmWe"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB323207677
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098295; cv=fail; b=c8GcmK7B2UBCvJVEboSJ/tMoHQt49/yq05fS9ZsFO8Fqdt653WfGaGMctECKo0bRjWjiYsDDXw1MomdPpvJItBM9GNyXjXxPbjN2hk68yMgVjb5rc4JMMvx+1A9mGuRgsLBHBe4D+qfYSsajJ+y+7eMM78LHbK5ghBlJppZHLd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098295; c=relaxed/simple;
	bh=aoCR8tiq/NtSt/pOLDp3fi2JgXQn7PXwlUI61DX3Bl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGFAc9U4BqNLi7Inb/Cj4tTcKuZV73KpIQyoDiAQMO2M5sFHxXMKs9VwAcpmLvEuutKPQsi4Xbd+GuXBHl8F0jsvtK1C9mHAJVB+3HoHlZChxGAVRM5BcCBukfLqHh5ZZ1V+BbHLbfGj5UuicjOgP+/3OgCTHbo6d7gYlqq2EdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSgkgmWe reason="signature verification failed"; arc=none smtp.client-ip=192.198.163.14; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id E605140F1CDF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:24:51 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TSgkgmWe
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dFh0pjMzFw3K
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:23:20 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 7A80342759; Tue,  4 Mar 2025 17:23:02 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSgkgmWe
X-Envelope-From: <linux-kernel+bounces-541190-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSgkgmWe
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 0C835426A0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:50:01 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id B038A2DCE3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:50:01 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CCC16CB7A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F44C1F2B8E;
	Mon,  3 Mar 2025 08:47:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EDD1F0E28;
	Mon,  3 Mar 2025 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991657; cv=none; b=kWX/JysIMJKFXZsoRdADBKOseC5SpfMTCIkGSsBSMAXW5DRVtQAqOldoXCrD6vFbZToXHxd+UvfZWsozJFvuKHWGZ+uTROkrA7DCJvAT1ds5Eq23w85ggsueJpp5JG2Rm65cCWJaoX3IpV50Mvf1UxqU6JwMKuFIzd5yyfo3xL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991657; c=relaxed/simple;
	bh=yHP5Zb8+z92UaMlcfYAxfjtnW5rOspDIJ08VjR15a3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C5SpCPtSN3y89nMvoYzA4wp+XCjgP26jGUKXhtqBIpfH/0/0W+j9iqhyDYx8kvG7bvn6os343WEq+X/MaUzyJXdGP9OcEpdp5kDDCpCMWkhXJSzHInFJbbqDt5Dvju6inlsNOzrFRksJ0izkbhKClA7FEAB1lYV+0eI5ya+zsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSgkgmWe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740991656; x=1772527656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHP5Zb8+z92UaMlcfYAxfjtnW5rOspDIJ08VjR15a3A=;
  b=TSgkgmWeb6sbRSbU8EkxWy4L6daq7oA0pCvPYnsI8Sfe0P5yPl4zRwpG
   cVmdVU5Y/qEcC5i9IIna6VGJf5IqlARewHqekc3VXdRFWhgxoTCdFS4pg
   QUZ0dpRXz9ebWVM0ELu6ZA4cOhZIA6txRAh07rB2sqb9pYFO25Fm44Lvj
   2y4hD/KoSkFoFptyx4p8VcCJQP3sFTMuK7u//KS9sk8iI/vQG6A9Nt/1z
   M/oOh5uL5pdAdQR95tpTZ1NcU5KXBTdrIED+S2CmzcXitDwFlzAuTbfJc
   3lWWNVKslsoLP8K4bUocRd7NsxHJ1EWz9m3JQKykKXSdwl+IwSoixCut2
   A==;
X-CSE-ConnectionGUID: f6xs1iZNSmGfl0+JBC6vsw==
X-CSE-MsgGUID: imyCbgmkSFqONg6pkW42aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="42111923"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="42111923"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 00:47:32 -0800
X-CSE-ConnectionGUID: lYP0XnrKQSqHh0j88W47jQ==
X-CSE-MsgGUID: rCTevcFxQLi+bA7Gz5gqig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118426798"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa010.fm.intel.com with ESMTP; 03 Mar 2025 00:47:31 -0800
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v8 06/14] crypto: iaa - Disable iaa_verify_compress by default.
Date: Mon,  3 Mar 2025 00:47:16 -0800
Message-Id: <20250303084724.6490-7-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250303084724.6490-1-kanchana.p.sridhar@intel.com>
References: <20250303084724.6490-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dFh0pjMzFw3K
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703034.88186@cavymNpOXIo2rx0C//wl6g
X-ITU-MailScanner-SpamCheck: not spam

This patch makes it easier for IAA hardware acceleration in the iaa_crypt=
o
driver to be loaded by default with "iaa_verify_compress" disabled, to
facilitate performance comparisons with software compressors (which also
do not run compress verification by default). Earlier, iaa_crypto compres=
s
verification used to be enabled by default.

With this patch, if users want to enable compress verification, they can =
do
so with these steps:

  1) disable all the IAA device/wq bindings that happen at boot time
  2) rmmod iaa_crypto
  3) modprobe iaa_crypto
  4) echo 1 > /sys/bus/dsa/drivers/crypto/verify_compress
  5) re-run initialization of the IAA devices and wqs

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/=
intel/iaa/iaa_crypto_main.c
index 4dac4852c113..5038fd7ced02 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -94,7 +94,7 @@ static bool iaa_crypto_enabled;
 static bool iaa_crypto_registered;
=20
 /* Verify results of IAA compress or not */
-static bool iaa_verify_compress =3D true;
+static bool iaa_verify_compress =3D false;
=20
 static ssize_t verify_compress_show(struct device_driver *driver, char *=
buf)
 {
--=20
2.27.0



