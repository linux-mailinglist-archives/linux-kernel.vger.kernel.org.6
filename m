Return-Path: <linux-kernel+bounces-374196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEC89A66A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E25B227E6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B861E7C1E;
	Mon, 21 Oct 2024 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NoYE9PuG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mt0AKEgy"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0321E1A14
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510502; cv=none; b=XHeMksL5Xy3b0ggMfOhKZBNPm3sDGVl+TBix8KfDyv1O8OVezn2ZHm67PisVrr+l5VWjlDCm5fZw029uGhaLvjo5E+EBQAaRvvWDqetqDRNi3LPCnzIdo6S+lOtJlV4UtuUmxPPwPwdR6W5levYyHtnV1CzOpg7f+BtuBDV7ZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510502; c=relaxed/simple;
	bh=1MOtHteYWLgSnE+BGZjFr2i4gBJ6Z8DTY4EVbhQyBFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGDn47KuvmIV12siwAA98GyN3XgIFqk9mx43H5Ya744+c10y8I7eHgixpisYYU+7tcsPSZ8sfdnN+1z6mENl0orwFZinQ/nswJaeG56WKSwrcp0/nrYyr9zjxX9k5Sw8g2CmSSIjiDX2S1TZH1LZM016VcDhvQ3sCVO1nMFrb+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=NoYE9PuG; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=mt0AKEgy reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729510500; x=1761046500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kIeUNChnfvhiBSBAYrYCxmsV3Uo5EQOsZuqb2GqwFAc=;
  b=NoYE9PuGQyHXZhhT1wChvKjfi9IGAyELNx0SMi9QuF/25KHDRYxAQ1rp
   0x8FXntQ8nzq1BfUE4LRDJpyJ6N4ObsblrdhBxBVYUXgWF6cnxycIKQER
   Nc9eQP59vdROY35n4lTPhSY+1z9QyEvHfc/9SMNl4BbkgLe6pDpS+E3rd
   JP5kZI7ugIN8XRXniu7bgjNQxPJoLWB+L70z9qvFheFqA+me7O6aPRqdb
   Ukne9CTRkuE5YtKnMr/RScyj+1MjazYiS2T3krcX6lSqWmvVMV3CroRbw
   gNYS7rw12G9Q1RGrIwbrl3yp66Ge1SdahncZW6Wk4eMT08y7Chh/v2dkl
   A==;
X-CSE-ConnectionGUID: R9w9UCN4S5Omybbv1wvikw==
X-CSE-MsgGUID: ttIQnVJ6TDG7UtaPIHUqdw==
X-IronPort-AV: E=Sophos;i="6.11,220,1725314400"; 
   d="scan'208";a="39572170"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 Oct 2024 13:34:53 +0200
X-CheckPoint: {67163C5D-7-69FF9A8E-EE9CEDAF}
X-MAIL-CPID: 858BF63EA041801573E13CE6D54F75A0_0
X-Control-Analysis: str=0001.0A682F18.67163C5D.006B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3402161191;
	Mon, 21 Oct 2024 13:34:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729510488;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kIeUNChnfvhiBSBAYrYCxmsV3Uo5EQOsZuqb2GqwFAc=;
	b=mt0AKEgyHeh7MrB17IY1hEQyXRjhUU+iSz9USD/mgv3dhL9MsXyr13OdAwCfegW2Yfc0X5
	axOxTxNwSUcmQUT4DRcQz2+R1Wm1QdA6fjZE69gcG0zu70UMG+SjaGty5EO6jEcZ8g4XGB
	F/9uiV6djWkkRz4yp5nNiWJSKFn2fcpAYBit3ykjtIrKyK+8hh1pedPCv1So0sezQhcgQu
	m42pkw5FUVT1I50a5iY9/TF55HyGNdElxj4pwCTPYZmj0m/BZ3wZS+yREH4yo1cBmAl3Qj
	oU5NALCpyPaLsWlQEy8cn7lGEpt+K0s7+tIqJRlQsu9geRlHS+6Rm5AdpMdcuQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v5 1/5] mfd: tqmx86: add board definitions for TQMx120UC, TQMx130UC and TQMxE41S
Date: Mon, 21 Oct 2024 13:34:23 +0200
Message-ID: <6c74f7b138507382e3c4db0a05c21d3f1f442109.1729509613.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729509613.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1729509613.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This adds support for 3 new TQMx86 COMs:

- TQMx120UC/TQMx130UC: COM Express Compact Type 6 modules with 12th and
  13th Generation Intel Core CPUs ([1, 2])
- TQMxE41S: SMARC 2.1 module with Intel Atom x7000E and compatible CPUs [3]

[1] https://www.tq-group.com/en/products/tq-embedded/x86-architecture/tqmx120uc/
[2] https://www.tq-group.com/en/products/tq-embedded/x86-architecture/tqmx130uc/
[3] https://www.tq-group.com/en/products/tq-embedded/x86-architecture/tqmxe41s/

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes
v3: no changes
v4: no changes
v5: no changes

 drivers/mfd/tqmx86.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index fac02875fe7d9..e15b9be98c2db 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -35,11 +35,14 @@
 #define TQMX86_REG_BOARD_ID_E39C2	7
 #define TQMX86_REG_BOARD_ID_70EB	8
 #define TQMX86_REG_BOARD_ID_80UC	9
+#define TQMX86_REG_BOARD_ID_120UC	10
 #define TQMX86_REG_BOARD_ID_110EB	11
 #define TQMX86_REG_BOARD_ID_E40M	12
 #define TQMX86_REG_BOARD_ID_E40S	13
 #define TQMX86_REG_BOARD_ID_E40C1	14
 #define TQMX86_REG_BOARD_ID_E40C2	15
+#define TQMX86_REG_BOARD_ID_130UC	16
+#define TQMX86_REG_BOARD_ID_E41S	19
 #define TQMX86_REG_BOARD_REV	0x01
 #define TQMX86_REG_IO_EXT_INT	0x06
 #define TQMX86_REG_IO_EXT_INT_NONE		0
@@ -132,6 +135,8 @@ static const char *tqmx86_board_id_to_name(u8 board_id, u8 sauc)
 		return "TQMx70EB";
 	case TQMX86_REG_BOARD_ID_80UC:
 		return "TQMx80UC";
+	case TQMX86_REG_BOARD_ID_120UC:
+		return "TQMx120UC";
 	case TQMX86_REG_BOARD_ID_110EB:
 		return "TQMx110EB";
 	case TQMX86_REG_BOARD_ID_E40M:
@@ -142,6 +147,10 @@ static const char *tqmx86_board_id_to_name(u8 board_id, u8 sauc)
 		return "TQMxE40C1";
 	case TQMX86_REG_BOARD_ID_E40C2:
 		return "TQMxE40C2";
+	case TQMX86_REG_BOARD_ID_130UC:
+		return "TQMx130UC";
+	case TQMX86_REG_BOARD_ID_E41S:
+		return "TQMxE41S";
 	default:
 		return "Unknown";
 	}
@@ -154,11 +163,14 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 	case TQMX86_REG_BOARD_ID_60EB:
 	case TQMX86_REG_BOARD_ID_70EB:
 	case TQMX86_REG_BOARD_ID_80UC:
+	case TQMX86_REG_BOARD_ID_120UC:
 	case TQMX86_REG_BOARD_ID_110EB:
 	case TQMX86_REG_BOARD_ID_E40M:
 	case TQMX86_REG_BOARD_ID_E40S:
 	case TQMX86_REG_BOARD_ID_E40C1:
 	case TQMX86_REG_BOARD_ID_E40C2:
+	case TQMX86_REG_BOARD_ID_130UC:
+	case TQMX86_REG_BOARD_ID_E41S:
 		return 24000;
 	case TQMX86_REG_BOARD_ID_E39MS:
 	case TQMX86_REG_BOARD_ID_E39C1:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

