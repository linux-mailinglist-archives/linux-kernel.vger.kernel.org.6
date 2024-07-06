Return-Path: <linux-kernel+bounces-243215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D45929321
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D1528237B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD33C161915;
	Sat,  6 Jul 2024 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="l+5qkZV3"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BED15F400
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264930; cv=none; b=gT3afTc7CzYJo4THJjTAeag7rYSo1+F7w+B06aeqOdW1PuXOG+aAFpTFOViGMZ6uSzB4PNca281qxQ70urECHrSfQmtEONl1QPSDFWV5H+j5PvckLDy+8hsKXX/B2LS1XV0e8XqkG5FS+w7Qi1/rbGm3y0rtYHcO024c0Hn9Nrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264930; c=relaxed/simple;
	bh=7dg6OjUul6CGYPKqeHT59FN/DW+jNVzMTYuArvmRep4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSP/4ZI/t4X9m5Ue5cEBKexykfyoWtq8pKWuWAPmZK9vtDtu2r/cU34XEQLUiT1iIpy0K32fKUWelqMTegcoBooBjq1LrmTNcVC0FEiA6NrezKjwWWnHaZj+JUyVFvIfEIgyvi6nBDVQWhhnViFp0gy5xZ65g2ZY4Q8tU7OnIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=l+5qkZV3; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=O+DQTIwXTC7DeV38nbA6p6oVvBJeZ5V9St2bzhvReOQ=; b=l+5qkZ
	V3hn1i5UCfgjdB/NMxnOMIKXwUsVOIau3NOx8SApuMhduvNDuw37LT0NqZ02RHl2
	vy3HMrXqH+CNR+3vIkVQNK1u4RGuP72WXcHEa2aMV1AZqybnD+KkpTCeksrtsmRj
	i8oM6udJNXh/lbhz5xzhn6ddSGlSgewcL2F31B4c6ska0kVEWJcOYP7ewKih2/Om
	cuUiW0JCEB2ZSZyXAyP0PK70A6J8PGZ0hoqdJv9PATkfWbeUioxwTpwvv9ybtMBC
	aYv4rCwDrgDpnC7z2VHVRp0p0xc2LL29FEp5sENOVjBkoFia//g53qTY5oN8xfpq
	FY56Ka29EaWThRow==
Received: (qmail 3810632 invoked from network); 6 Jul 2024 13:21:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:49 +0200
X-UD-Smtp-Session: l3s3148p1@LindYpIcMMJQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/60] i2c: powermac: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:39 +0200
Message-ID: <20240706112116.24543-40-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
specifications and replace "master/slave" with more appropriate terms.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-powermac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 8e57ebe595be..b6b03539f626 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -127,13 +127,13 @@ static s32 i2c_powermac_smbus_xfer(	struct i2c_adapter*	adap,
 }
 
 /*
- * Generic i2c master transfer entrypoint. This driver only support single
+ * Generic i2c transfer entrypoint. This driver only supports single
  * messages (for "lame i2c" transfers). Anything else should use the smbus
  * entry point
  */
-static int i2c_powermac_master_xfer(	struct i2c_adapter *adap,
-					struct i2c_msg *msgs,
-					int num)
+static int i2c_powermac_xfer(struct i2c_adapter *adap,
+			     struct i2c_msg *msgs,
+			     int num)
 {
 	struct pmac_i2c_bus	*bus = i2c_get_adapdata(adap);
 	int			rc = 0;
@@ -179,9 +179,9 @@ static u32 i2c_powermac_func(struct i2c_adapter * adapter)
 
 /* For now, we only handle smbus */
 static const struct i2c_algorithm i2c_powermac_algorithm = {
-	.smbus_xfer	= i2c_powermac_smbus_xfer,
-	.master_xfer	= i2c_powermac_master_xfer,
-	.functionality	= i2c_powermac_func,
+	.smbus_xfer = i2c_powermac_smbus_xfer,
+	.xfer = i2c_powermac_xfer,
+	.functionality = i2c_powermac_func,
 };
 
 static const struct i2c_adapter_quirks i2c_powermac_quirks = {
-- 
2.43.0


