Return-Path: <linux-kernel+bounces-407091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B139C68A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F5F282264
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57001714D7;
	Wed, 13 Nov 2024 05:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9HW6KHc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1837081F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731475456; cv=none; b=IzonIZs8byKvMtmdFBpdYExYJkJUcIb8ukQVt/3CvGf1HMn0TdvJdUNG6WX19p7gyaMTkYZgVuVs70MUrriCWMVPuiiKI54TFlt0zNehG1yqtKcXxMH/G7chCqDpbnHzWdQK41fravi/IHB3dDMBfp2K3t4EqMGAfSdPbwXhj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731475456; c=relaxed/simple;
	bh=HmJm6AvXmIawUg1nmasfuVL0GJH2LxZ0AqcVw8E27Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MuPvKac7WY7uGjyV+Dqf4tsjjSN3oAgOTPJK1pSGlzGJTfnO/ut+DZoLB6+ubSCNhlAPXYycBA0floRjNdsS967u2zFJ2bxNPYgOn5McTNfLCYvLfnWH0ZVrNclXYErbNzYe/UltHtPLxep9i0u4dV+GmgVYiNcpfWLYC3AT7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9HW6KHc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731475454; x=1763011454;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HmJm6AvXmIawUg1nmasfuVL0GJH2LxZ0AqcVw8E27Xk=;
  b=n9HW6KHc+VE4ZVSiP+XBraR2Dc9R6Vh/eqPOwZU8ny5pv9qWSSg6zV14
   kT4a+quZloUdYf3h1/CMW1o6fByZtTujaRRCDwTL8pxCZBdxskw3U85kR
   hPXyc65Jar2ti1nv+uO36J347UXT+g9IImsjILERuNI4gHcrckox8ahyz
   uJ1J2bvxl2zV7551YqVaFCMj8ZYOwsqHCVwuFZU0cQwcsusZZqyjXKFGp
   8OM8N4b/+mm6sOSdWaWdTkFzZkps73AUB46Dr9eXRRgGIVtmHUBFSyOg4
   g7I3tj+F1UqrZo8EBFYC4DlsPT0K3eewGQ8Uv+5N304FxIsxOL/Yecn2Y
   w==;
X-CSE-ConnectionGUID: LiLEE3JFSBmq8Ek4qZ+vpw==
X-CSE-MsgGUID: mWLJ5VvuQeGZfQlHZ6dd0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31436614"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="31436614"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 21:24:13 -0800
X-CSE-ConnectionGUID: NJv4XNh/RC67hkv2ZqFUfQ==
X-CSE-MsgGUID: Iwx2b4HYTRW0xNEwAz26Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="88149831"
Received: from unknown (HELO JF5300-B11A338T.jf.intel.com) ([10.242.51.115])
  by orviesa007.jf.intel.com with ESMTP; 12 Nov 2024 21:24:14 -0800
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v1] mm: zswap: Fix a potential memory leak in zswap_decompress().
Date: Tue, 12 Nov 2024 21:24:13 -0800
Message-Id: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a hotfix for a potential zpool memory leak that could result in
the existing zswap_decompress():

        mutex_unlock(&acomp_ctx->mutex);

        if (src != acomp_ctx->buffer)
                zpool_unmap_handle(zpool, entry->handle);

Releasing the lock before the conditional does not protect the integrity of
"src", which is set earlier under the acomp_ctx mutex lock. This poses a
risk for the conditional behaving as intended, and consequently not
unmapping the zpool handle, which could cause a zswap zpool memory leak.

This patch moves the mutex_unlock() to occur after the conditional and
subsequent zpool_unmap_handle(). This ensures that the value of "src"
obtained earlier, with the mutex locked, does not change.

Even though an actual memory leak was not observed, this fix seems like a
cleaner implementation.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Fixes: 9c500835f279 ("mm: zswap: fix kernel BUG in sg_init_one")
---
 mm/zswap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb23..58810fa8ff23 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -986,10 +986,11 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
 	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
-	mutex_unlock(&acomp_ctx->mutex);
 
 	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
+
+	mutex_unlock(&acomp_ctx->mutex);
 }
 
 /*********************************

base-commit: 0e5bdedb39ded767bff4c6184225578595cee98c
-- 
2.27.0


