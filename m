Return-Path: <linux-kernel+bounces-200008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5D18FA922
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37009289E3F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E6113F45B;
	Tue,  4 Jun 2024 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrDK39h9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6313F442
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474904; cv=none; b=Itsvackrgdmd5GbNF2T5uUBwTZBtVYmAERK8N/yZHMQEnpeGHMJeHfdEak0Hb2CplCbDcum4Aar5kuN+nTm2MMf1hN3TZjCu/lYQUpqn8o90jUVpRPjbLh3UP3G69YWRM4Hv3HZRXxd8ILO+szuqM10CA50uuogsQB/QSi1m/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474904; c=relaxed/simple;
	bh=8rn+89eKdjpnGRg9SATPm/FCPUFDqEev/EjdjwcPsX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/veBnqDBCVrx39cayeXaNwOQRdom211T1cG3QXr9cdMQ7B7uAKxqtYmRLoFSVJLsrT2v9xAiw3lNtET6VSihDcnhJEzYDrLkASW7vxSxTG/8vmY14Vl4srnqzugsDOimxffl68FMayswuC24XHRpWl0DI67FfCn4RPy9Z+pv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrDK39h9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CC0C32786;
	Tue,  4 Jun 2024 04:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717474903;
	bh=8rn+89eKdjpnGRg9SATPm/FCPUFDqEev/EjdjwcPsX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BrDK39h9fOI8f7AxXV5VEsT+hcMTOXnlEQKMg/6aZTTxZNso2DZQD1OtJONwRjRkG
	 GTotLiw6R+JnHOjQ+F4Z2QdlRSZJW/+/D2lxocg2C9GOt0+eA01KBD7PK6qZKDn93v
	 oJmb0/AUR5k1JJjqlHrm2uenG78NcxWZ2ZRyhPdoGDBTxMnKmqVIcSzL2j5jAAFEig
	 HQbh7x3JlQMRQX9xktOcMM1uYVXNp75jz/PFQLKdr4hYqEj/e+x0sMkhIMH8YDhZfw
	 1Lu1MRZv5GG3zPR5gLx+97v8YSf9U4PF/EC2hDxnpJ5FSUVfzwXiBharDCB7Osnutq
	 bkpUX1xY27wMg==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	izik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	chrisw@sous-sol.org,
	hughd@google.com,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH 04/10] mm/ksm: add identical_folio func
Date: Tue,  4 Jun 2024 12:24:46 +0800
Message-ID: <20240604042454.2012091-5-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604042454.2012091-1-alexs@kernel.org>
References: <20240604042454.2012091-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

To replace pages_identical() func and further reduce the 'page' using in
try_to_merge_one_page function.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 include/linux/mm.h | 17 +++++++++++++++++
 mm/ksm.c           |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..2d1f16ffc6ac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4164,6 +4164,23 @@ static inline void setup_nr_node_ids(void) {}
 
 extern int memcmp_pages(struct page *page1, struct page *page2);
 
+static inline int identical_folio(struct folio *folio1, struct folio *folio2)
+{
+	int i, nr1, nr2, ret = 0;
+
+	nr1 = folio_nr_pages(folio1);
+	nr2 = folio_nr_pages(folio2);
+	if (nr1 != nr2)
+		return 0;
+
+	for (i = 0; i < nr1; i++) {
+		ret = memcmp_pages(folio_page(folio1, i), folio_page(folio2, i));
+		if (ret)
+			break;
+	}
+
+	return !ret;
+}
 static inline int pages_identical(struct page *page1, struct page *page2)
 {
 	return !memcmp_pages(page1, page2);
diff --git a/mm/ksm.c b/mm/ksm.c
index 21bfa9bfb210..2e4790842515 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1527,7 +1527,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma, struct folio *folio
 			if (!folio_test_dirty(folio))
 				folio_set_dirty(folio);
 			err = 0;
-		} else if (pages_identical(page, kpage))
+		} else if (identical_folio(folio, kfolio))
 			err = replace_page(vma, page, kpage, orig_pte);
 	}
 
-- 
2.43.0


