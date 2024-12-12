Return-Path: <linux-kernel+bounces-442765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB709EE143
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3067D2838A3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE461C460A;
	Thu, 12 Dec 2024 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VvRyHYPG"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA916259496
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992236; cv=none; b=DxCHtGAvZMJ0+mG3921rOKkofoKJzvaT9VDwnmd53XehU8dTBjR6BLepxZfh9sVj3PnHPO3fdxqWmUfMz1FXdGX6k3ovgRClL4P8zSewraJVbEz4MCcPUE0u0Bwcmv3wlCzPMzguVNzoSK1wo0RWdKED04g+vNH8juhYq50YuhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992236; c=relaxed/simple;
	bh=AGX6qi5HvFvx6+fzD5zIDuHGI8h0eLH015en6YAd4ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCz032/OYpyFNDg0HGJXa+yTDaKSkjPmyNGvRQM3H2JsDOfc1IMsyujFjGWn2NFkEG4VGN47jRIW3FuTpWU2d4E2ai/fwKd0FQk5wsImPCX3fjwERzTJUoCt7pqRiDPsTwOFvAP9XvRIb9JlpG+1mWjp7CsL2TmaP1cQzhE8874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VvRyHYPG; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1SQUA
	wjf40SnLqWEK57sKLEKKy0eFYKmxOuVnk0xUog=; b=VvRyHYPGgH+pQ9hjlLZlt
	nnfoxeMWlfy4ke2KlON/dTYw1pEvN50OX7JiphJ4dEEnXBML55BPflS3gUBS2ILs
	ysdeMFZUcMEUrs5WgjKWC6yO8/XL0tYhyliOSGDVxGdCsj4s653AHPyOL1vK7Z9D
	/3WfNgdSKNa22Xw+UimdxI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3FzrXnlpnfupOAA--.30434S4;
	Thu, 12 Dec 2024 16:29:26 +0800 (CST)
From: David Wang <00107082@163.com>
To: surenb@google.com
Cc: akpm@linux-foundation.org,
	kent.overstreet@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	yuzhao@google.com,
	David Wang <00107082@163.com>
Subject: [PATCH v2] mm/codetag: clear tags before swap
Date: Thu, 12 Dec 2024 16:29:10 +0800
Message-Id: <20241212082910.30826-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAJuCfpGJp-U3t_SHRhuSRTu7Hjkz23oqKSNbVL79O1OQhgJndw@mail.gmail.com>
References: <CAJuCfpGJp-U3t_SHRhuSRTu7Hjkz23oqKSNbVL79O1OQhgJndw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3FzrXnlpnfupOAA--.30434S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry3Zw4rJw1xWFyxGFWruFg_yoW8ur15pr
	47Wr1UGa95JryxCrWkK3W2vr13Xw45tw15GFWa9a95Zryayr47Gr1kWFW2qFnrZFWkAF4S
	yrsrWrWIk3WUA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pilfO7UUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gOzqmdalpSqGAABsE

When CONFIG_MEM_ALLOC_PROFILING_DEBUG is set, kernel WARN would be
triggered when calling __alloc_tag_ref_set() during swap:

	alloc_tag was not cleared (got tag for mm/filemap.c:1951)
	WARNING: CPU: 0 PID: 816 at ./include/linux/alloc_tag.h...

Clear code tags before swap can fix the warning. And this patch also fix
a potential invalid address dereference in alloc_tag_add_check() when
CONFIG_MEM_ALLOC_PROFILING_DEBUG is set and ref->ct is CODETAG_EMPTY,
which is defined as ((void *)1).

Signed-off-by: David Wang <00107082@163.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202412112227.df61ebb-lkp@intel.com
Suggested-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h | 2 +-
 lib/alloc_tag.c           | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 7c0786bdf9af..cba024bf2db3 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -135,7 +135,7 @@ static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
 #ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
 static inline void alloc_tag_add_check(union codetag_ref *ref, struct alloc_tag *tag)
 {
-	WARN_ONCE(ref && ref->ct,
+	WARN_ONCE(ref && ref->ct && !is_codetag_empty(ref),
 		  "alloc_tag was not cleared (got tag for %s:%u)\n",
 		  ref->ct->filename, ref->ct->lineno);
 
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 35f7560a309a..3a0413462e9f 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -209,6 +209,13 @@ void pgalloc_tag_swap(struct folio *new, struct folio *old)
 		return;
 	}
 
+	/*
+	 * Clear tag references to avoid debug warning when using
+	 * __alloc_tag_ref_set() with non-empty reference.
+	 */
+	set_codetag_empty(&ref_old);
+	set_codetag_empty(&ref_new);
+
 	/* swap tags */
 	__alloc_tag_ref_set(&ref_old, tag_new);
 	update_page_tag_ref(handle_old, &ref_old);
-- 
2.39.2


