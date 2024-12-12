Return-Path: <linux-kernel+bounces-442549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93419EDE16
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 05:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35261886C53
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6597154430;
	Thu, 12 Dec 2024 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kmq6t/PY"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C225257D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 04:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733976278; cv=none; b=c3ZObuK5ip+Fs8ko+JajLbUjDndzqtXCvDvmMB309b23cR2EoUU7cLpijODM57AFUS67tgZ7GPJ7+ecxLAQioFt8Ajr/Dr6yGE58bhlHJUmBk8ZJ/+wtSroaRxXkhXeE2SuPWA+jYwAnYB1TtB+CjgCdQsDwHgso+xulZoi9W3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733976278; c=relaxed/simple;
	bh=9qrj+5UBBMO1AYeXDcm4vjAebLLX3t6+QsLL3o428rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqTD3Ehta7rh2ioHMe3B/BPPfVbG5/uRnRMto/5W1Tu4iZCiwQfal4vZBG7VijsOmZKCZwurs83jQjpJqI8Jk8dQ77e0bH2YMo8rNAdqPWboQCu7zHTPC/b3pmGpJYLK2zpG0GAXOcTwvQAs8wtLqpXz3NIhaJPVPkWYmIkKQdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kmq6t/PY; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NISGI
	FQ99jxLIPdLWNb92see1Jj4Nxu/t+MRtsryHa8=; b=kmq6t/PYPITh7s39rMDDY
	SU5sxVMP4JTbAtorTdPT63bba1XjfQbsF00WyEjWvAGFlO1tMgYQJzeCC/KyzDoG
	Dm9WxTuhw+mRi/7aTrR+rKIloNipcJCw/llhopAlvVNbp9SMvJxUSo/Wtcm64C22
	uDqYk8v5t9GpDOrcMZ+sgM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3HzQCYFpnKtQfAA--.12556S4;
	Thu, 12 Dec 2024 12:01:28 +0800 (CST)
From: David Wang <00107082@163.com>
To: surenb@google.com,
	kent.overstreet@linux.dev
Cc: yuzhao@google.com,
	oliver.sang@intel.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	David Wang <00107082@163.com>
Subject: [PATCH] mm/codetag: clear tags before swap
Date: Thu, 12 Dec 2024 12:01:04 +0800
Message-Id: <20241212040104.507310-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <202412112227.df61ebb-lkp@intel.com>
References: <202412112227.df61ebb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3HzQCYFpnKtQfAA--.12556S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry3Zw4rJw1xWFyxGFWruFg_yoW8CFW7pr
	4UWr1UGa95Jry7CrWvgw12vr15Xw45t3W5GFWY9as5ZryYyr47Gr4kWFy2qFnrZFWkGF4I
	yrnFgrWIk3WUJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGjg7UUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0hizqmdaUlMGXgABs2

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
---
 include/linux/alloc_tag.h | 2 +-
 lib/alloc_tag.c           | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

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
index 35f7560a309a..cc5fda9901c2 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -209,6 +209,10 @@ void pgalloc_tag_swap(struct folio *new, struct folio *old)
 		return;
 	}
 
+	/* clear tags before swap */
+	set_codetag_empty(&ref_old);
+	set_codetag_empty(&ref_new);
+
 	/* swap tags */
 	__alloc_tag_ref_set(&ref_old, tag_new);
 	update_page_tag_ref(handle_old, &ref_old);
-- 
2.39.2


