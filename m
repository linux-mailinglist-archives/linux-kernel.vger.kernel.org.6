Return-Path: <linux-kernel+bounces-291841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D65149567DB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2ED283748
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DE215EFA4;
	Mon, 19 Aug 2024 10:10:33 +0000 (UTC)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2E15EFB6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062233; cv=none; b=nO/tm3jtx6pMbvKITt5dea+NvmsVjtNH1biBWPj/ZsWOlQAZPp94u4dcf0bbsi20mqEqQ4Wx09KBZDXZYuVZnlRlAlUJHZ/ZLdaFV89hsqE2B4ho7GtXv7ncwTYLOG1WDARcvbb+zW7T2lOJ4VVb74MRDjs996m7YbIX1/B4Q6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062233; c=relaxed/simple;
	bh=JpAk+cZjaavxiaR1SKrjblVYBLwRq6JBcso3ZuElw8Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HlvdZmdx7+dTeXvh23+8x0w52IDsXabKBEIqnUgZPVhfjpptCFJgc7bxN7G3+aah0fNJnLi+HiY1dPfwXNqB8hehmDHjt5LMQ/uXAahrSycEC8AZjd+3CzcWm+pxDU61bUdAq4B9m7KeVnG5sXimKJZUhCIKSW6voNUeNBrYPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1724061254-086e23761062170001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id 1mUfFjGZI3vDJADx (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 19 Aug 2024 17:54:14 +0800 (CST)
X-Barracuda-Envelope-From: JonasZhou-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 Aug
 2024 17:54:13 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e]) by
 ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e%7]) with mapi id
 15.01.2507.039; Mon, 19 Aug 2024 17:54:13 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zjh-VirtualBox.zhaoxin.com (10.28.66.66) by
 ZXBJMBX02.zhaoxin.com (10.29.252.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 17:52:48 +0800
From: JonasZhou-oc <JonasZhou-oc@zhaoxin.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <JonasZhou@zhaoxin.com>
Subject: [PATCH] mm/hugetlb_cgroup: use folio in hugetlb_cgroup_move_parent()
Date: Mon, 19 Aug 2024 17:52:47 +0800
X-ASG-Orig-Subj: [PATCH] mm/hugetlb_cgroup: use folio in hugetlb_cgroup_move_parent()
Message-ID: <20240819095247.6403-1-JonasZhou-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Moderation-Data: 8/19/2024 5:54:03 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1724061254
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1810
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.129250
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

Since we are dealing with HugeTLB, we should use folio instead of page.

Signed-off-by: JonasZhou-oc <JonasZhou-oc@zhaoxin.com>
---
 mm/hugetlb_cgroup.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 4ff238ba1250..1433a3e57c17 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -195,13 +195,12 @@ static void hugetlb_cgroup_css_free(struct cgroup_sub=
sys_state *css)
  * cannot fail.
  */
 static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_c=
g,
-				       struct page *page)
+				       struct folio *folio)
 {
 	unsigned int nr_pages;
 	struct page_counter *counter;
 	struct hugetlb_cgroup *page_hcg;
 	struct hugetlb_cgroup *parent =3D parent_hugetlb_cgroup(h_cg);
-	struct folio *folio =3D page_folio(page);
=20
 	page_hcg =3D hugetlb_cgroup_from_folio(folio);
 	/*
@@ -212,7 +211,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct =
hugetlb_cgroup *h_cg,
 	if (!page_hcg || page_hcg !=3D h_cg)
 		goto out;
=20
-	nr_pages =3D compound_nr(page);
+	nr_pages =3D folio_nr_pages(folio);
 	if (!parent) {
 		parent =3D root_h_cgroup;
 		/* root has no limit */
@@ -235,13 +234,13 @@ static void hugetlb_cgroup_css_offline(struct cgroup_=
subsys_state *css)
 {
 	struct hugetlb_cgroup *h_cg =3D hugetlb_cgroup_from_css(css);
 	struct hstate *h;
-	struct page *page;
+	struct folio *folio;
=20
 	do {
 		for_each_hstate(h) {
 			spin_lock_irq(&hugetlb_lock);
-			list_for_each_entry(page, &h->hugepage_activelist, lru)
-				hugetlb_cgroup_move_parent(hstate_index(h), h_cg, page);
+			list_for_each_entry(folio, &h->hugepage_activelist, lru)
+				hugetlb_cgroup_move_parent(hstate_index(h), h_cg, folio);
=20
 			spin_unlock_irq(&hugetlb_lock);
 		}
--=20
2.25.1


