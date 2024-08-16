Return-Path: <linux-kernel+bounces-290021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F08954E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F8E2878B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826601C0DD4;
	Fri, 16 Aug 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Hm/VZ4nV"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84601BF333
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824659; cv=none; b=GZwxRVq9REqfsD5CAPFcvmNk3xgoyW1CxwpFCNzfX27J895cnTxDVl7fbAjI+K7Xthueqh5RNY/+Aps6bMUexEDD158fkPCiil+XGDVrIXwKDKdaLw6j8uELG0idWO8pTJ4Cx9poG8TjnKYnRRxfZOQFr1BBgCFcoYUWertmTQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824659; c=relaxed/simple;
	bh=9yY1/BIxl7LoaOkOv2t6qPSu6oiKJ6lC8GdgdrN1Qlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8R3xKA54brZ9iWlSd6sEYzbbvL90coyEkGwDNU1n7Lu0suhRr5qTqaSjIi7OfU1QLfA27ZpKf96iNIfNn+kIxjF7ATxL+ouDkthBO3rUGWOn+xlSZi0KfmsoNNm3g7zHgu7nR+L3E8KyYNaQYSLUhX19RTw5IzwT/CmlGUTwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Hm/VZ4nV; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723824634; x=1724429434; i=spasswolf@web.de;
	bh=tY1u/l18ICxFndL+rMYHYdlbuL5/Ji75gvQvXubIHqs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Hm/VZ4nVyBdr5dDUQNibfqMELTiimJ+x3CK5jWY5wydb/FCVtPBhUdDFKjewTK0L
	 utd1GQ4xBY9YI1hBOuxPV74EEEsS0qfuZg8sZsO8ZpYYtWBPBlSsL4rMxZDzPZSYr
	 R6NZSV55IFL9bNNRUETyp+csYo/R+DUgmuPLp+4XAakp0CRvpA0WvWSZ15soIkBow
	 7IWy2epJ6itNjOOAI8l9d7dpPsX0fh32xjHfUwitePRCqDJOXLe47Pvym9OJN2r+Y
	 AUBC4yyBw6kx3VLT1vVvoEGqCCNOndOf76c3N4hTWGy46fFrDfvYrGdwzANuNhoRu
	 xeTHQuWvh9Y7fSx0jw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MjgX3-1ru43N0hrf-00dbwl; Fri, 16 Aug 2024 18:10:34 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	sidhartha.kumar@oracle.com,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5.1 19/19] mm/mmap: Move may_expand_vm() check in mmap_region()
Date: Fri, 16 Aug 2024 18:10:27 +0200
Message-ID: <20240816161029.2865-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CpBP6kSbrB8sL8flKl+ECNfHj/Uc35TmetZAHX0QnWtel46XMNb
 ZiZBIbboeJJ6tVLYcRzceYO1MDLzuDd23AZvXklcX1N5/dSjrmMN5hc8CUFPzWDqomsO6Zj
 efZvSyAq2qKR3ajjesfQhlBS1V7I1Zo2tl3gcC0mMHjTj4rdN+sSq+wKGpyMPyFIomNU2X5
 SkFEdwpRClee9hPkap6sQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TD/RjrwwdTk=;IQOlooLy+sbkfuRILnJuuPi8E05
 eTOFKmGrhsyKxUGmTKfbVqPOTXKxrVCFgKtxI9Ge35vs1fZaRTnG2vkZqgesytNioXiXSeaE0
 QYgatLk2+Y1P18xgsrv6jvAWBcxTIogQn/00Tu4bXu3m+E39ZSE7jnp/UEmARv/W26cfn/5FP
 BKWdOQr8bNvp85EcYFMpEAtYyfbPsQmkFqrnV4UNWg5tK1TTxyVMx2LeKleR9oNk011/34Hc2
 jW3UOFZiXz97xpsHUoA09NrJPiK+cvSHbRPFOjLq2wnVM8rysqI4AFlkEA8JlaE4C94quRVlZ
 ERLXkAGDDBwZx2CY0Tnczw57wBX9eOb2qneQGjhUcQkzsUO2abmTwcqiUBvJluIShOCN98rEb
 qD1q0EGDRWCciyL7HNr/Vaptu7hTsopiXiSHMqxW4pf+LxqDYgFfri+mVltiQsCkdDw4QB4jz
 C8jSXFeFsYhBR8HKHaaFBfNQlZApxM+x01QXwvPQWafgZc67ePXg4JsiD3TR0spEkmIHZ2dAe
 IgLhtupZJXjT3EHG9UsbJ6f73QYd9/46PMukJXTgzPkYKZc2JnEMChXZJnrhAYsxq26p+Fwsi
 txnXkeneShJYs+QayAhRAhdgfOCfJXqLqw18w368jRPdrtOvIpKtDNyz0m46RRC6m5nJlEwR8
 794pRsOvVEYGW+PAcQxu0sEHjdN0hNbQmZ+OrMSp4eUaUFEtCWh/KzEK4iIcJVTwfXZHPUzyj
 TZm9s7eQbXgP1E8bpkmddo0KD4NN8BUkq+/HB5Vqev6YuwJb36knkUDhAuNxveFacQo5YT/Zd
 eWjaBNunMLJMmts+0dSNhg3Q==

The may_expand_vm() check requires the count of the pages within the
munmap range.  Since this is needed for accounting and obtained later,
the reodering of may_expand_vm() to later in the call stack, after the
vma munmap struct (vms) is initialised and the gather stage is
potentially run, will allow for a single loop over the vmas.  The gather
sage does not commit any work and so everything can be undone in the
case of a failure.

The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
call, so use it instead of looping over the vmas twice.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
=2D--
 mm/mmap.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d2f47cd66650..e0c321b7c642 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1376,17 +1376,6 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 	pgoff_t vm_pgoff;
 	int error =3D -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
-	unsigned long nr_pages, nr_accounted;
-
-	nr_pages =3D count_vma_pages_range(mm, addr, end, &nr_accounted);
-
-	/*
-	 * Check against address space limit.
-	 * MAP_FIXED may remove pages of mappings that intersects with requested
-	 * mapping. Account for the pages it would unmap.
-	 */
-	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
-		return -ENOMEM;


 	/* Find the first overlapping VMA */
@@ -1414,6 +1403,10 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 			vma_iter_next_range(&vmi);
 	}

+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
+		goto abort_munmap;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
=2D-
2.45.2


