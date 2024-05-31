Return-Path: <linux-kernel+bounces-196541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505738D5DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2279B28303
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4871586CC;
	Fri, 31 May 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d22hFSf2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2931F15688F
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146310; cv=none; b=IhytyJuRWMGwXx6ns5NJ3kpyl4OF6SSt4vo311Th7lNkq7GyBS3IsIPnBNsLyHVvjLKYwVr1UILsz4dtwm4YKYV6XFvFAxUP57hOcWHAKqx4rJhs54SzgRpBOPDTl9+A4AnZ8n0qKpt3s3RjPCZMNzHEqZJljzrIXoS0Pk33Q9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146310; c=relaxed/simple;
	bh=HC/iebU12r4tuo/bQ21zBgXZmHDhLCixcZMw3ZfNxMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+zl1rkDvuh6osmouKY6Ak8GB9uho5j53JUAdlT6f+3pDHT80y+oTYgxZaJ5Vj0JZdalNs/kCaOd+HNrhfphXujuio5wttffiQkSWTTZJn6xrHfKPkuu2tSLc7HclSm81IKjPYSeYjr7bi7iG8KS/rIhM0ZPDE74tDxpi+6/eW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d22hFSf2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717146309; x=1748682309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HC/iebU12r4tuo/bQ21zBgXZmHDhLCixcZMw3ZfNxMQ=;
  b=d22hFSf2iS5fBGIGn47z3rCR8Um2WnPfY9nQhkwf17jzo7zaySgkvsZM
   gmcwI45sNioMlWaixXk3Im7JrbZIKhILaD0ifLTSpXT6c/asZUj9QVvGV
   KNoPU3T3vAuUSRMq7a56CjaBxlDe0pdyqsalA/CnQgh8XV8xFF47zRlri
   OGROJooiKxxiz4qCKWrnEP6T6hkeUG5Uyysmme2Y5pL2m4BN9Fx75eyxh
   AdGovE9jJ3Qbud2hdtx18brtMBlVu930Jlsjeh9l/VStVU+SnOppBmrg1
   4yAjXt7xXe3RyChWKuGGp36QqMmvIeTcyJt0m+lHatABZ9hhUhv9sNo/u
   w==;
X-CSE-ConnectionGUID: X5+ftijOQCKGsg+ZWGK2mw==
X-CSE-MsgGUID: qE+2nOELRl68D3as+2gMcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="39074066"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="39074066"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:05:09 -0700
X-CSE-ConnectionGUID: m9Gq5WLzSc2KPusanhgQ+g==
X-CSE-MsgGUID: sbEKQx1WTJCQaLM+lOXRqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40543234"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:05:07 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 1/4] kernel/panic: return early from print_tainted() when not tainted
Date: Fri, 31 May 2024 12:04:54 +0300
Message-Id: <01d6c03de1c9d1b52b59c652a3704a0a9886ed63.1717146197.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1717146197.git.jani.nikula@intel.com>
References: <cover.1717146197.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Reduce indent to make follow-up changes slightly easier on the eyes.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 kernel/panic.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 6df2ba08d5ae..5c9396418e1c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -508,22 +508,23 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 const char *print_tainted(void)
 {
 	static char buf[TAINT_FLAGS_COUNT + sizeof("Tainted: ")];
+	char *s;
+	int i;
 
 	BUILD_BUG_ON(ARRAY_SIZE(taint_flags) != TAINT_FLAGS_COUNT);
 
-	if (tainted_mask) {
-		char *s;
-		int i;
-
-		s = buf + sprintf(buf, "Tainted: ");
-		for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
-			const struct taint_flag *t = &taint_flags[i];
-			*s++ = test_bit(i, &tainted_mask) ?
-					t->c_true : t->c_false;
-		}
-		*s = 0;
-	} else
+	if (!tainted_mask) {
 		snprintf(buf, sizeof(buf), "Not tainted");
+		return buf;
+	}
+
+	s = buf + sprintf(buf, "Tainted: ");
+	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
+		const struct taint_flag *t = &taint_flags[i];
+		*s++ = test_bit(i, &tainted_mask) ?
+			t->c_true : t->c_false;
+	}
+	*s = 0;
 
 	return buf;
 }
-- 
2.39.2


