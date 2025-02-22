Return-Path: <linux-kernel+bounces-526869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9086EA404A3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094883BDBC5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A1617E00E;
	Sat, 22 Feb 2025 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VJTDsqta"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF42A1CF
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740187276; cv=none; b=nUPSe/ap7+Uq7uMeH2846hRV3sM42o2OTPMKt7eurgjAaJXBdIAmZbnm3sWAPO9R5wlmTbyybpKHkLRXRfSyltOhU09EOd5boniI3Qmtbx/t2Zf2nKtjSvEDoxyKAppOaW94wBslfI2oTQ33wvt8Je+cOjCGxTAZPvI0xmNQSrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740187276; c=relaxed/simple;
	bh=FIpYvgZKywrXjv1rJRUE8HdHcEeKGqKtoSMCeA5s6QE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZHNdhJ2Hbp0R335AZ5bogwyMm8ZVWaExn/9rFVfD2uYALXIKP7/vCuEgm0QaRF9RfzBeFn1NZVw1zweqCaWGS17PwYhoYGj6TdnYA/oBeRYLg7hB7K3vQHUVRAiU7kH7aLN+dQdb7ERsQFJcDpzpbg8YgbeltNa5CB4N61F+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VJTDsqta; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=jkg4omdLHejH2ReKVHW08BgGvZXziwWQu06sM3QIErU=; b=VJTDsqtaybaPolhk
	oaPw+zeEvkL0o5OE1dK5fW3L1I5ovV6KGeQxyU75Gt9Ml2OaVQNm47vP2JsyuKRLdAkmBAOr8NCXV
	TE9mUG95b0rwu2V0HkEURD6WuhgVKbx/lKsMyrU8d2SkR3HHd19zTn+GsG0Ynw9ViipLdj1D1IaJ+
	mKHjnufbFXSaQXte7o8A6j5key4VEpUniAXlP46ggo51wunI8wM0FauUmJ8Efg2/UzRX8KSYy03rF
	QtiZzn+wookRqms+q4KmDgwhrYMdnxGbKKruRezO/wU5s8T+qd9mumQAYkgidvVJTwy7rZQELRjp2
	HTMQELF4dWbwdtUaOg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tleCc-0001vQ-1k;
	Sat, 22 Feb 2025 01:21:10 +0000
From: linux@treblig.org
To: hubcap@omnibond.com,
	martin@omnibond.com
Cc: devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] orangefs: Bufmap deadcoding
Date: Sat, 22 Feb 2025 01:21:10 +0000
Message-ID: <20250222012110.160029-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

orangefs_bufmap_shift_query() last use was removed in 2018 by
commit 9f8fd53cd055 ("orangefs: revamp block sizes")

orangefs_bufmap_page_fill() last use was removed in 2021 by
commit 0c4b7cadd1ad ("Orangef: implement orangefs_readahead.")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/orangefs/orangefs-bufmap.c | 25 -------------------------
 fs/orangefs/orangefs-bufmap.h |  3 ---
 2 files changed, 28 deletions(-)

diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index edcca4beb765..b562d3dbc76b 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -197,18 +197,6 @@ int orangefs_bufmap_size_query(void)
 	return size;
 }
 
-int orangefs_bufmap_shift_query(void)
-{
-	struct orangefs_bufmap *bufmap;
-	int shift = 0;
-	spin_lock(&orangefs_bufmap_lock);
-	bufmap = __orangefs_bufmap;
-	if (bufmap)
-		shift = bufmap->desc_shift;
-	spin_unlock(&orangefs_bufmap_lock);
-	return shift;
-}
-
 static DECLARE_WAIT_QUEUE_HEAD(bufmap_waitq);
 static DECLARE_WAIT_QUEUE_HEAD(readdir_waitq);
 
@@ -532,16 +520,3 @@ int orangefs_bufmap_copy_to_iovec(struct iov_iter *iter,
 	}
 	return 0;
 }
-
-void orangefs_bufmap_page_fill(void *page_to,
-				int buffer_index,
-				int slot_index)
-{
-	struct orangefs_bufmap_desc *from;
-	void *page_from;
-
-	from = &__orangefs_bufmap->desc_array[buffer_index];
-	page_from = kmap_atomic(from->page_array[slot_index]);
-	memcpy(page_to, page_from, PAGE_SIZE);
-	kunmap_atomic(page_from);
-}
diff --git a/fs/orangefs/orangefs-bufmap.h b/fs/orangefs/orangefs-bufmap.h
index 75b2d2833af1..4231175ccdb2 100644
--- a/fs/orangefs/orangefs-bufmap.h
+++ b/fs/orangefs/orangefs-bufmap.h
@@ -10,8 +10,6 @@
 
 int orangefs_bufmap_size_query(void);
 
-int orangefs_bufmap_shift_query(void);
-
 int orangefs_bufmap_initialize(struct ORANGEFS_dev_map_desc *user_desc);
 
 void orangefs_bufmap_finalize(void);
@@ -34,6 +32,5 @@ int orangefs_bufmap_copy_to_iovec(struct iov_iter *iter,
 			      int buffer_index,
 			      size_t size);
 
-void orangefs_bufmap_page_fill(void *kaddr, int buffer_index, int slot_index);
 
 #endif /* __ORANGEFS_BUFMAP_H */
-- 
2.48.1


