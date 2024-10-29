Return-Path: <linux-kernel+bounces-386916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B779B49AB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E508A1C20C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12D205E3F;
	Tue, 29 Oct 2024 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMFX4OlH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7D18C939
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204911; cv=none; b=cpIPDB6EEtUYTLnK2ujXlkI3UjpBAZ5A54IRbrwVWfgsHN1KMMDsZms4xhnzPWr2CBvqGWoxheosenM5snTJrE6qjMG6oACW0MKn0EN/ImENDxgJ8egs5S+uVFDm0A592fQnlNk4AXiHp5cG5fNNXrFy+7HxmT7ScChaz6EAk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204911; c=relaxed/simple;
	bh=qeIQTaQD+DeGbX8uVEsNttO4ZtpK/BOfkldEqvcYYOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WB2lCqZIsollpldRfcCKp/x54hUAW2hzKH1KZyA4rNJtjwMIz62lNPyfCFhuNoiUwkey/NBqG3rYfo+kQncohmlcYk7bt04fYqCRuCuSo6C5lTBf8eRkjjq+nQoVawQktjesQ2oiyZhMIhQJqM35Z3oQxQsPociDVt1Kmhq2+eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMFX4OlH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730204909; x=1761740909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qeIQTaQD+DeGbX8uVEsNttO4ZtpK/BOfkldEqvcYYOY=;
  b=RMFX4OlHSf6z2dKywfBOt9Xooj2Jwi14XifVNouC9uEsiMegfp/SIuFV
   Pkx7l0Pjq8y4szLA1SNXiq28EinW78zXTXS+1KiZk0+VS0KSMFj+s/dfK
   14HWGdM1pOo3tJJyhKUTP1oAlULl5QOOKADNeEam374w3fOyKnwqPVLOt
   6GW0PTjgvGlrZvrlnrB2kszsCR9zXEjKE8ExhVcZ/x5fr9ypGlX2o/r46
   5B1xojIzLcwonr6a2JASUHlN8KGqm4CDNKbRYPN99b9VgUzFggcUagwCh
   LqBcVf+Aa2JmLUC6Cw7fnVjfO4BkXdKFHNErxilVp2Nw6cOVwZ6ooPt5B
   w==;
X-CSE-ConnectionGUID: TwoJD35/TcmfxDdcFL6LoQ==
X-CSE-MsgGUID: 1uEoSMYbQXu0oBeydwIfZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29297183"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29297183"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:28:27 -0700
X-CSE-ConnectionGUID: lq6Ai53iTAqaPsgmbEbZdg==
X-CSE-MsgGUID: f9466FP/SUCGsGYxn8021g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="105284653"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.245.242.192])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:28:23 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH -V2] resource: Avoid unnecessary resource tree walking in __region_intersects()
Date: Tue, 29 Oct 2024 20:27:35 +0800
Message-Id: <20241029122735.79164-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if __region_intersects() finds any overlapped but unmatched
resource, it walks the descendant resource tree to check for
overlapped and matched descendant resources using for_each_resource().
However, in current kernel, for_each_resource() iterates not only the
descendant tree, but also subsequent sibling trees in certain
scenarios.  While this doesn't introduce bugs, it makes code hard to
be understood and potentially inefficient.

So, the patch revises next_resource() and for_each_resource() and
makes for_each_resource() traverse the subtree under the specified
subtree root only.  Test shows that this avoids unnecessary resource
tree walking in __region_intersects().

For the example resource tree as follows,

  X
  |
  A----D----E
  |
  B--C

if 'A' is the overlapped but unmatched resource, original kernel
iterates 'B', 'C', 'D', 'E' when it walks the descendant tree.  While
the patched kernel iterates only 'B', 'C'.

Thanks David Hildenbrand for providing a good resource tree example.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
---
Changes:

v2:

- Revise for_each_resource() to traverse only descendant resource tree.  Thanks Dan and Andy.

- Collected Acked-by.

- Link to v1: https://lore.kernel.org/linux-mm/20241022053835.217703-1-ying.huang@intel.com/

RFC->v1:

- Revised patch description and comments, Thanks David and Andy!

- Link to RFC: https://lore.kernel.org/linux-mm/20241010065558.1347018-1-ying.huang@intel.com/

---
 kernel/resource.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b730bd28b422..b6a890c78507 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -50,17 +50,35 @@ EXPORT_SYMBOL(iomem_resource);
 
 static DEFINE_RWLOCK(resource_lock);
 
-static struct resource *next_resource(struct resource *p, bool skip_children)
+/*
+ * Return the next node of @p in pre-order tree traversal.  If
+ * @skip_children is true, skip the descendant nodes of @p in
+ * traversal.  If @p is a descendant of @subtree_root, only traverse
+ * the subtree under @subtree_root.
+ */
+static struct resource *next_resource(struct resource *p, bool skip_children,
+				      struct resource *subtree_root)
 {
 	if (!skip_children && p->child)
 		return p->child;
-	while (!p->sibling && p->parent)
+	while (!p->sibling && p->parent) {
 		p = p->parent;
+		if (p == subtree_root)
+			return NULL;
+	}
 	return p->sibling;
 }
 
+/*
+ * Traverse the resource subtree under @_root in pre-order, excluding
+ * @_root itself.
+ *
+ * NOTE: '__p' is introduced to avoid shadowing '_p' outside of loop.
+ * And it is referenced to avoid unused variable warning.
+ */
 #define for_each_resource(_root, _p, _skip_children) \
-	for ((_p) = (_root)->child; (_p); (_p) = next_resource(_p, _skip_children))
+	for (typeof(_root) __root = (_root), __p = _p = __root->child;	\
+	     __p && _p; _p = next_resource(_p, _skip_children, __root))
 
 #ifdef CONFIG_PROC_FS
 
@@ -88,7 +106,7 @@ static void *r_next(struct seq_file *m, void *v, loff_t *pos)
 
 	(*pos)++;
 
-	return (void *)next_resource(p, false);
+	return (void *)next_resource(p, false, NULL);
 }
 
 static void r_stop(struct seq_file *m, void *v)
-- 
2.39.2


