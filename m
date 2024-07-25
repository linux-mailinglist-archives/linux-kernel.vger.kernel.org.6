Return-Path: <linux-kernel+bounces-262210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C114693C282
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCD91C216FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFD019AD85;
	Thu, 25 Jul 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsTpK7T9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F54219AD6E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912113; cv=none; b=H8I362eVuLkZOKYHqWd6nMErwJN3x1mUIQbPqpdQR1bVwzFvj/x1HIJ7O+NDP+M6K9JQbbW2YsKWHAEu/tFtfiQzFr2ArQGZXjooTc/CnG+Za5yUwHKgu027SaJDoQQeI/+rBFILdPHFd9DaAGB8L2z1DMUwOj91gkLI8XA9qxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912113; c=relaxed/simple;
	bh=cICetE0oPku5oCZLNjMdluepkJysG2PwPkTft1lrcKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifysnevxBXhV3UpcxiC5+mh4MwktPvy0SXfdb0Gn+y+dU6L8dNt67SUJDBm/P6tIsBQ2UU9VqLvdpleO9t0vN5mFq7dP3k0q/7h83aMyJLndDYcNLajVq5fDbZ+2h6kSIZnTpGTIZunP8FWXQqLwHWMMOaNZ5FJYq9q83YWpavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsTpK7T9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C68C116B1;
	Thu, 25 Jul 2024 12:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721912113;
	bh=cICetE0oPku5oCZLNjMdluepkJysG2PwPkTft1lrcKc=;
	h=From:To:Cc:Subject:Date:From;
	b=YsTpK7T92PASjft75fgiCu9RC/lk0nEItX2TxjrgHlkHQJxVwWOxJmKPF9SAEI12k
	 ydpkFs1QZpjqdah5kaDbSa7uZJEAPiHw0cTyFuyxqtVb+i0JdZzAf9QRYN2mG/1QGX
	 vN7adkU4UWWiFkMc1lfyKCaDpVLC/Bbs8tY7xF1LsSW29OCLl9zHNAuMiw0kYiDbK0
	 asuxuatQ056gTMnvUcP3fwlgXsGyVSdXCROAYQC/5j9UZRPq9TMxriqlQKMfIyjXtK
	 eNNEZyCOJ6ylrg04OXg4XsQ5THEt2S+brlZ544CaiJhvkJaPh8cmxhE5ik8Lcc0Uyp
	 sY0bGgHttQqkw==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] mm: (k)vrealloc: document concurrency restrictions
Date: Thu, 25 Jul 2024 14:54:37 +0200
Message-ID: <20240725125442.4957-1-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that concurrent calls to vrealloc() with itself or vfree() for
the same memory allocation are not permitted, since it leads to undefined
behavior.

Consequently, the same applies for kvrealloc(), hence also document it
for kvrealloc().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 mm/util.c    | 3 +++
 mm/vmalloc.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/mm/util.c b/mm/util.c
index 0ff5898cc6de..29ae93f6344f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -732,6 +732,9 @@ EXPORT_SYMBOL(kvfree_sensitive);
  * If @p is %NULL, kvrealloc() behaves exactly like kvmalloc(). If @size is 0
  * and @p is not a %NULL pointer, the object pointed to is freed.
  *
+ * This function must not be called concurrently with itself or kvfree() for the
+ * same memory allocation.
+ *
  * Return: pointer to the allocated memory or %NULL in case of error
  */
 void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index caf032f0bd69..2a6d4ce57b73 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4049,6 +4049,9 @@ EXPORT_SYMBOL(vzalloc_node_noprof);
  * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
  * @p is not a %NULL pointer, the object pointed to is freed.
  *
+ * This function must not be called concurrently with itself or vfree() for the
+ * same memory allocation.
+ *
  * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
  *         failure
  */

base-commit: d270beaca6818349b2aed7e6034b800a777087cc
-- 
2.45.2


