Return-Path: <linux-kernel+bounces-217290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C8490ADDF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A61F1F2175F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B2D19599E;
	Mon, 17 Jun 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="g3HvrRNd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hOvUdusV"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9719581C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627051; cv=none; b=W4dUywbqI9f7601qYF2lBIev+JSN4fNKf9991bPxhcaw2KwzJof93niXIel48t/rgYRUcW+ik7agXBWLPWCN4JxfyLmK0w6qsDL/VIpd0+ZgV+FfK/WehAQ4hFCnX6rsdGKXe5F28qaYrYCuKFq+SURwXLGX0H+8QXK4QG+lb64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627051; c=relaxed/simple;
	bh=bGyfMBRWHIMuYpLEVA4rP7LUnv0E80+EIAhqX2dEOS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpX//b3fQTykb7GJLIEVZCSm2H/mKMeggwFhfZsM2jFOszIEcShtPNpe2MWvEQL0ApHu4v6bgJtcnj2dmLFl3DopDpIZrsN1TCz2LZolfF0VqGXc+QxrMKA7fV93hXPvYLuF0SBfbK8+Y/hjdk0+Hbga4+RCP6ZmwJSSqTLPjkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=g3HvrRNd; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hOvUdusV reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718627049; x=1750163049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NeMmzD8p32EauX3z8zpfDQahrWuR3SyZ6Ku1PrYCcxo=;
  b=g3HvrRNdqAwx+3m2M5cAVjJqRcXYM9APzccoszg3u+kVFhD8XU37SQe2
   UpXNc2az4YxWk9zsdvRfv9waLmupIjHaoup7DeBNCJIYLFLf07cp4g4ZD
   jB0TrVktqH9Bz99oj6BkH1IhhbS6WZubAQeqIGGC3ST4GZRwoSXGo0OWI
   um0a8nDe7uIQiMvpe+6Na1aI6WeWeHZL+/h88UJWPp4e6RL8J6uTChp5T
   ZxlJ+LpTS5El0Q6jtoxvKoKlUjCQs7OxAENzF8tBstQZMpMOrIN+nf+kJ
   D1hKNjOfqy37CTMkQUSt+WMt4sV/GTBtgkg3vpMTygoyRBiQLBwAYv8Pl
   A==;
X-CSE-ConnectionGUID: WgmGXJWQQX2Rfr7LMo4qLg==
X-CSE-MsgGUID: LORBgubMSYWtfRMUo4kj1w==
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208";a="37427049"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Jun 2024 14:24:06 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD24616595E;
	Mon, 17 Jun 2024 14:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718627042;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NeMmzD8p32EauX3z8zpfDQahrWuR3SyZ6Ku1PrYCcxo=;
	b=hOvUdusVLKevXAkT5xHibBT1QGHDyzpE2Re84r5lv84rY62+rdUilcGsw3qIKKKq9TmSYs
	PkfcfPUf12BoAwGj2Y9AGaLj4NT0er/oUBgcF3R4NhKoUtF9NvkRvUB23IrGWORBX9iosZ
	daYLQyco+zAGnwAIjghrSb45oyQX5q8p3yAUqK7JwZnlM77/F9GnaEZIp8nvZhzmIESqrT
	xcpXaSVpCW+c83r6xFN4Btmobkvdiavj5J6dT6QE20C3rNamWTYL1+mM4CsX/w7HkBrvu3
	bYpJe9valnAbJT82zDUGeRo5aNi98u4X14IqC0gisOf+aTPtbvh0eCMLFZFr1A==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 1/5] mfd: tqmx86: add board definitions for TQMx120UC, TQMx130UC and TQMxE41S
Date: Mon, 17 Jun 2024 14:22:58 +0200
Message-ID: <d07b38efc0a2920c05a0fe2b91478b58ceb6a230.1718626665.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
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


