Return-Path: <linux-kernel+bounces-289572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2509547BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDE01C22864
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469821A01AE;
	Fri, 16 Aug 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="QP7zv1ZA"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F641991D2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806899; cv=none; b=OIYG/XGDC/h10epjL3hq0usz3BClkQT+iA8QcdHZht+FUM/vTXGqOR8pBb1+Ir++V40QKu+geRVZLszhj1ejBSOjDkFxC2F3noES/pIiXdlm41ehuIeWvPAEL1xPeumMmqe1C/F8g+4itO4NuUAQ1+iv5wHOThIVFLMGHZMtfcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806899; c=relaxed/simple;
	bh=e4kCPlY0yFWAoU4qm2MMPPfOcu0BUrsBkGnSE6+WkU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smG/71iu3Gk16u8NDBqqTMiEn7egf3vA4pxXyy9b2kHQGhB2ggLx8TZbpbJ89r9EadgAbuNJphVa+KFhy4tu7ZCBhKvf8mnxQSvK59ARsLYhMnvXhWvhXQbNbGP7X/TEGFxS8juzA8sAWHoCfMYAQFExZy5ET2XHiy58WOwmptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=QP7zv1ZA; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806868; x=1724411668; i=spasswolf@web.de;
	bh=N4bRnjjY8T58BB1QJ9rqpGkDs7lyqxXGca+v1fWnuPk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QP7zv1ZAEuhAIjBwUYNku0TL5L13CaL0eizszYyTdLpa7TJjMDv9oQR5icA0cCvr
	 FTyKxgOf+sU0gXe2sS3xIsMHFdXfLVc0V7bf5pHIcFdPU7MW5BsMbp+MjCIHZiHUm
	 BiYKJGohUJPRgukF430bogFOYxojXR4WQQjdkayk3F7Rkx2FZp+wYjauZoID5BwJ5
	 pWL0poZl59A/3CeraUguyFtviI4Zy7J8yGtgCbi4Yjoez/n/YpMhxdUxkMPGBsPV+
	 KPVUXlqCYaP51P9MxXi7mV0Zq1j5QxcX1lHvpT0aUjGutRUZy6P75exwsMR62ofVX
	 tXOZVoj/AoA0PN/5tQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N4NDQ-1sD2R82wGk-00xraG; Fri, 16 Aug 2024 13:14:28 +0200
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
Subject: [PATCH v5.1 08/19] mm/mmap: Inline munmap operation in mmap_region()
Date: Fri, 16 Aug 2024 13:13:49 +0200
Message-ID: <20240816111405.11793-9-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240816111405.11793-1-spasswolf@web.de>
References: <20240816111405.11793-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TPOfyyR3SiBeEM2qoJMPq/2uyQCzoa7BZ7yudOR9h8xakQoYQxi
 nZjrtXsjc2GHiHZ/4WD6G7wkm6Oh4Svn3lFz4TwFYAfh7WjpliuGes9rLDQsoz71PC64R2M
 45+06O85GCxZcVTrXS29Nonbl56Kw+G9lGARtCS5Zeu01GaVBWJDA06ODZVmloyClBQLqxI
 XyexqvWQjnxNzDLICGFGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TzksNjmqQ6I=;PWZMpXnb4uhMdV3IePNblIScYmc
 /C7XuJqhxpoi6EmQK6PVMxQbazUXZR5u25r2mxbhulOkCw5+thEi+k3vPqHr5ezGsbtxLyCWz
 01+wGkW2VUmaqaRZyFeq9Z/qaXYFWRrk22dLhCJwra93eFQIrzv5l82y7azuz4kwbSXY4NLo+
 CxRkjSmnSbpK8IBV6GTUfa17tplhVxSm8eWOqmLyDtjmWG/pXFfutwXPMIUsDOrWGJX5wd7LT
 +cSVpnsBFj8D5QFgrNyD3s+k16PF6zlK10h/F9vyxOV84YH6xC+270OUgNhLPO9odws+HbLrf
 Kh0jvHyOn2qh/kzGbYDn4ZAQaihRm0hA1UUZlvn4CLqJugAh5OppCTSixDEiCVq2qC+GjbUgb
 h2RX5ZSzprmwlFVtvX1kQl7iZrPR7bvos7xEJxOfk6ePjxiy+cpGbXAJGMqGC8TthBhctlBEV
 Hvx9Oi3SrRa9GunezM3cjJGlIb414bVl9lCu+LbsORasD2cVGENZjUxbrnbDu2U5KwXIN42oT
 S6/Utr5OJEQm4HaDDbCvwh8vuHDjjCOPucl7X4Nlufmh+aIZOP5pB+MIoQ56x0T1xFf7SX0vr
 eAQJeMl5e85tm+7XjbPf5blqVCP0wpD0mQBcZEeNO5YCag4AfW3NmYzUNkFHgcdMf6LJHtkZd
 N7EIRcnhjuDbuHJSW+yyMEdwPRGj1baR8WpBtQ3owW3EjPKx9dAV81ejB1iS3zCnsfnkvtRnd
 dN+t8dYWecbeuTxKC0RxnfHKQOXvKxIbMvoSai9pFNbV0rafnE45y8/yNmNM4UUVgT2u5mJuQ
 TZE4BqC1mbtHtISnghh3k3hg==

mmap_region is already passed sanitized addr and len, so change the
call to do_vmi_munmap() to do_vmi_align_munmap() and inline the other
checks.

The inlining of the function and checks is an intermediate step in the
series so future patches are easier to follow.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
=2D--
 mm/mmap.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6aed0b769cc4..6ed27cf12217 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1388,12 +1388,21 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 			return -ENOMEM;
 	}

-	/* Unmap any existing mapping in the area */
-	error =3D do_vmi_munmap(&vmi, mm, addr, len, uf, false);
-	if (error =3D=3D -EPERM)
-		return error;
-	else if (error)
-		return -ENOMEM;
+
+	if (unlikely(!can_modify_mm(mm, addr, end)))
+		return -EPERM;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, addr, end);
+
+	/* Find the first overlapping VMA */
+	vma =3D vma_find(&vmi, end);
+	if (vma) {
+		/* Unmap any existing mapping in the area */
+		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+			return -ENOMEM;
+		vma =3D NULL;
+	}

 	/*
 	 * Private writable mapping: check memory availability
=2D-
2.45.2


