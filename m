Return-Path: <linux-kernel+bounces-559983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C926BA5FBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6783AA96A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC080260A4B;
	Thu, 13 Mar 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f4tyIOTU"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AABB7FBAC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883902; cv=none; b=HOkDcWMf+Z1EcamWHfATee/He+H+r+KOP7E1uff7acjZV1xswy9aFRgIRCGoqoZPOBug6kf04pJMjq08WyK7sbodBQQ8ILO4mWCzF9waa2D5VaWolrv1LS4Nxjhml31zHruWCj5tAQ9jFUeJj/Ng7of6qJqAaItnPTw01aOkxkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883902; c=relaxed/simple;
	bh=MsZndZJN945H+TSEHXQR2TQ34k73L3UdembMvA0OQMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ajPSOJxRsUAVZlPhWnQDpmVNdlMit0Isg5X/2R4mgPpKVDIUfszoK+c/k5yWHaBCa0bVcpJE0vC48FIrzsICl1ZWcwDvpF4aMcM7dA0HAwCxyuAtx2NhE2/FRP/md99HTMVFEQoWisJuMyQGFoihWNzpomxu7M8nMwG0KE3E3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f4tyIOTU; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741883897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+2yrB8FeinZE7HGJ8WItVD3R+avGQQIvePt2DTngpGE=;
	b=f4tyIOTUJwBuq2R3EnuTnbHRFts1BGoP2TUAGl7zsZbtY1lUP7WFE5mQzWI8U5ggpSw8SR
	fU011MTGtaSJ+kQcDUzkfaMtIC1p24vQqmt7YaoivN8ytpprMnNqKnoBDS2RyMN3qT/blL
	RBZ1NCotT2UNW7fU2UEWu1AhvFWZcJw=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: get_random_u64_below()
Date: Thu, 13 Mar 2025 12:38:10 -0400
Message-ID: <20250313163810.60564-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bcachefs needs this, for sampling devices to read from based on squared
device latencies.

this uses the same algorithm as get_random_u32_below: since the multiply
uses the top and bottom halves separately, it works out fairly well.

Cc: "Theodore Ts'o" <tytso@mit.edu> (maintainer:RANDOM NUMBER DRIVER)
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com> (maintainer:RANDOM NUMBER DRIVER)
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 drivers/char/random.c  | 22 ++++++++++++++++++++++
 include/linux/random.h | 22 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2581186fa61b..84808300044c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -588,6 +588,28 @@ u32 __get_random_u32_below(u32 ceil)
 }
 EXPORT_SYMBOL(__get_random_u32_below);
 
+u64 __get_random_u64_below(u64 ceil)
+{
+	if (unlikely(!ceil))
+		return get_random_u64();
+	if (ceil <= U32_MAX)
+		return __get_random_u32_below(ceil);
+
+	u64 rand = get_random_u64();
+	u64 mult = ceil * rand;
+
+	if (unlikely(mult < ceil)) {
+		u64 bound = -ceil % ceil;
+		while (unlikely(mult < bound)) {
+			rand = get_random_u64();
+			mult = ceil * rand;
+		}
+	}
+
+	return mul_u64_u64_shr(ceil, rand, 64);
+}
+EXPORT_SYMBOL(__get_random_u64_below);
+
 #ifdef CONFIG_SMP
 /*
  * This function is called when the CPU is coming up, with entry
diff --git a/include/linux/random.h b/include/linux/random.h
index 333cecfca93f..b025bf3d8f27 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -6,6 +6,7 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/math64.h>
 
 #include <uapi/linux/random.h>
 
@@ -90,6 +91,27 @@ static inline u32 get_random_u32_below(u32 ceil)
 	}
 }
 
+u64 __get_random_u64_below(u64 ceil);
+
+static inline u64 get_random_u64_below(u32 ceil)
+{
+	if (!__builtin_constant_p(ceil))
+		return __get_random_u64_below(ceil);
+
+	BUILD_BUG_ON_MSG(!ceil, "get_random_u64_below() must take ceil > 0");
+	if (ceil <= 1)
+		return 0;
+	if (ceil <= U32_MAX)
+		return get_random_u32_below(ceil);
+
+	for (;;) {
+		u64 rand = get_random_u64();
+		u64 mult = ceil * rand;
+		if (likely(mult >= -ceil % ceil))
+			return mul_u64_u64_shr(ceil, rand, 64);
+	}
+}
+
 /*
  * Returns a random integer in the interval (floor, U32_MAX], with uniform
  * distribution, suitable for all uses. Fastest when floor is a constant, but
-- 
2.47.2


