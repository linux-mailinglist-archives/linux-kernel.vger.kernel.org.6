Return-Path: <linux-kernel+bounces-343850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237DF98A04E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565C31C21145
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7D519005D;
	Mon, 30 Sep 2024 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="EpzwlheR"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5E18EFC9;
	Mon, 30 Sep 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695305; cv=none; b=iBALxZgYtj68GU3OKAED6+hZFMgccrHYcHIWaW9SaM2i5tkY8em+Zqe+MSFdHpYOj7Qw7bIyIG0+i7vHriThXS5TJC6IFmChxIgXBPVmvgfBTChDoa6Dvc2uG4by7A3ByDq3iHjSE5VVyh03MZQtYTLuGUFw68G79PPTN0Wp+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695305; c=relaxed/simple;
	bh=6AppmJrqLqVi8MlktWMYGrwHkgWVbAll1+ThMTOvQtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e++WDEk3pZl5iI2J5txtD48KPrMA4KMFqPq5dkBSmJ9CueuHr5hv+q/aF6kVSNEa+JIGTZfEUE9mcusd6ZQ3AZ/SB3sb4GNmmBvJxuJT8XxVwGdPm+HGFjiNRQVfxKDBWrHXBZYLdKUvdAupbE/lTYxo4FpPzvMHT0XVG0Wj5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=EpzwlheR; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qnfJr2JifYt0TRzmtqO+mgXV4VxU/z0o+uWEZRVe07I=;
  b=EpzwlheRhiWecFNoyf4rVuQwUD3eFfP0tw49DBuVU7xdPKz7pM7yTpfv
   QcqFNss6kBEsv9MQ1+2JBrSruasZWFGcIZK2UD+8JZnRhw6nQ0hIkRaNE
   2Z5IxEKmLZXwvlrNJkCVxzb7lwB2wXcHwPQFHJldmcVEk2Qb7LLr583B8
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956876"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:26 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-janitors@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [PATCH 06/35] lru_cache: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:20:52 +0200
Message-Id: <20240930112121.95324-7-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 lib/lru_cache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 9e0d469c7658..40f22213c3b3 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -576,8 +576,8 @@ struct lc_element *lc_element_by_index(struct lru_cache *lc, unsigned i)
 
 /**
  * lc_seq_dump_details - Dump a complete LRU cache to seq in textual form.
- * @lc: the lru cache to operate on
  * @seq: the &struct seq_file pointer to seq_printf into
+ * @lc: the lru cache to operate on
  * @utext: user supplied additional "heading" or other info
  * @detail: function pointer the user may provide to dump further details
  * of the object the lc_element is embedded in. May be NULL.


