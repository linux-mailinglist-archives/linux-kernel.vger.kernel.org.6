Return-Path: <linux-kernel+bounces-184374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7F98CA63E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608E7281EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FED125D5;
	Tue, 21 May 2024 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cKAiiHkc"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B88C1A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259214; cv=none; b=pZwNfwqEQplLFKQ2mkRFvDwhmnka4RAfyxFDyUkHOektmAwpjvojNe1lHrWtYrxLEtdkwA5hxw3G/UQI0E2DP1vbZidw5+zvh16/fXKaVvwjdEJSYj4Fjf2JJaCeT8FJ740Nj5SJ/FzVBw0rjYjIJHSffAtRyM3hI5+zhW4AXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259214; c=relaxed/simple;
	bh=ytdZXGSfndD/U4M5iBaPXzxnSqmTrUbEaH33jqlqmXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=b/UbsCx222kpXDkyBz6ECD8IeQYV8wEKv4QW6p5atVRzmbA3mpZ+RR4PVSM+KYqt6idmVKm4I9SmJWvrGqI/9F9XNuQsfvF5BkbrMPOhGaBppbeo0dFZsklnvWi43V6h7KhrEhlrZhckXjDusWLCEBnbFtlp6ChA87RTccvx/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cKAiiHkc; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240521024010epoutp02df9376c809dadaf7640a7f2e51f0c2b9~RYKi2UeOM0463704637epoutp028
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240521024010epoutp02df9376c809dadaf7640a7f2e51f0c2b9~RYKi2UeOM0463704637epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716259210;
	bh=BSK9Qlu8VaXXXrgxPdkSNVuJQ8cVVtzS2NFztJ8CnqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKAiiHkcGQ94RyEZo9XB/RgCZpFSiLysOAf2Hihl96Wt0XQSOpFnzm/kLE4afI/Di
	 Ct14RIE7wrF+hdho0i8/ZsvMrzpbjIRn/XBHf5lGZNbUVOtcCco7IFU0wIE6qmBzoZ
	 v1O2WFuCRI+lmo4bZEALhdKvDHEqUHDHaqNF1+rE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240521024010epcas1p2f12c4f8f47d1a12c3d5ab40ebefa4071~RYKiX1IbC0671506715epcas1p24;
	Tue, 21 May 2024 02:40:10 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.223]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VjzDn5bj4z4x9Pp; Tue, 21 May
	2024 02:40:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	30.5F.09662.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epcas1p291bbc11c4e5cdaa922ca302d95330e6b~RYKhpOgNM0129801298epcas1p2p;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epsmtrp1a516b7dd01533488b1018c01119b6bb9~RYKhoZ7fg2362723627epsmtrp1L;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
X-AuditID: b6c32a35-2b3fa700000025be-ab-664c0989e2e9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3F.EA.09238.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epsmtip2f1862bf201bde31cc9f190cb892768e6~RYKhfMz3e1132711327epsmtip2V;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RESEND PATCH 08/10] memblock: print memsize summary information
Date: Tue, 21 May 2024 11:39:55 +0900
Message-Id: <20240521023957.2587005-9-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTQLeT0yfN4O1PNYs569ewWXRvnslo
	0fv+FZPF5V1z2CzurfnPanFk/XYmi9mNfYwO7B47Z91l99i0qpPNY9OnSeweJ2b8ZvHo27KK
	0ePMgiPsHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
	ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fL
	Sy2xMjQwMDIFKkzIzjh4ehJrwTu+iofbzrA1MO7j7mLk5JAQMJG4c3MOaxcjF4eQwA5GielH
	ZjOBJIQEPjFK3PwvAJH4xijxprOZCaaj//xsNojEXkaJ1/2rGSGcz4wSqybMB6tiE9CWeL9g
	EiuILSJgJ/Ft9gEwm1mgVOLtmxPMILawgKfEsimNYHEWAVWJJ91tjCA2r4C9xJrrlxkhtslL
	zLz0nR3E5hRwkJg/ZTE7RI2gxMmZT1ggZspLNG+dzQxR/5Vd4ufBFAjbRWLu+rksELawxKvj
	W9ghbCmJl/1tUHa+xIWLr4Bu5gCyayQWTjSECNtL7Po6gxUkzCygKbF+lz7EJj6Jd197WCGq
	eSU62oQgqtUkWp59ZYWwZST+/nsGZXtIHJrxlwkSOpMZJVr2/GafwCg/C8kDs5A8MAth2wJG
	5lWMYqkFxbnpqcWGBYbwOE3Oz93ECE6SWqY7GCe+/aB3iJGJg/EQowQHs5II76YtnmlCvCmJ
	lVWpRfnxRaU5qcWHGE2BwTuRWUo0OR+YpvNK4g1NLA1MzIxMLIwtjc2UxHnPXClLFRJITyxJ
	zU5NLUgtgulj4uCUamBqymudE7NLzoPn3qPfXKELLvzm+7sguVBJ5+2OjpM6JQeFkhSzqnYy
	/tw99xbzq47T9x89r7nxO/O0zJOZTzxtolb56twrMKpoWVD+YcIhrzdrih3FEg0cjmUFTZI3
	Onuo48glhQeLU62Ymjbvi7y/8SfzowLXxZP3V12N17blOHZhVu0Z/6SV8ULaLb+PBZY0pi//
	UbD25S/+7fkbv34x3Hzi8QW7ysA7O6ZHe6wwPiry+PaU6gN+rSntuXy7J/Hqf25OX9shwM/9
	V0+4u3fG3ooLcjwPRK6UW2kp79t4SzKliz93alC699uIv298nx02kFCPM0uV+lZ5O8As+eHi
	iY/2Ru+zttTXcLlm3fFWiaU4I9FQi7moOBEAy2V6hhsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvG4np0+awaelYhZz1q9hs+jePJPR
	ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgd2D12zrrL7rFpVSebx6ZPk9g9Tsz4zeLRt2UV
	o8eZBUfYPT5vkgtgj+KySUnNySxLLdK3S+DKOHh6EmvBO76Kh9vOsDUw7uPuYuTkkBAwkeg/
	P5uti5GLQ0hgN6PE/BsLGCESMhJvzj9l6WLkALKFJQ4fLoao+cgo8fZsOxtIDZuAtsT7BZNY
	QWwRASeJDVdWs4DYzAKVEv9u3wKLCwt4Siyb0ghmswioSjzpbgObzytgL7Hm+mWoXfISMy99
	ZwexOQUcJOZPWQxmCwHVnLl0nhWiXlDi5MwnUPPlJZq3zmaewCgwC0lqFpLUAkamVYySqQXF
	uem5yYYFhnmp5XrFibnFpXnpesn5uZsYwYGupbGD8d78f3qHGJk4GA8xSnAwK4nwbtrimSbE
	m5JYWZValB9fVJqTWnyIUZqDRUmc13DG7BQhgfTEktTs1NSC1CKYLBMHp1QDk1tBT0nVtl/F
	H3dOFVoY8uuarfbc7dOlpvnyiru75C968j2tIYL58rye7yYTN4e88HtgsubkPH6dSSEVyi1h
	h7VDFu2pCnO0/W74tfiqhartZPt0zvyQg2Zs84ojtNWrN8zquflxw+nea/e9jzx9wenz06vz
	u0yH75qC9hZz+TnMTNnnjq33CFgwseCSTN6L/8G39p5zsWZ/Kj4jMlNX/1nm3RCxVDlG5rXe
	AWcduW6+vjQ9QTEmR3fh+bXNr6XeLN/Pprr+Mfuf9tMGe349Xfev5OT+efdW9NzmWDQz19tU
	Xv+aJ6fxhzVXZvfaT+uYuL1APr7hLvvrvfXzYxa6bJzI3B/9XyPqafKzH567UpRYijMSDbWY
	i4oTAU5uzwzjAgAA
X-CMS-MailID: 20240521024009epcas1p291bbc11c4e5cdaa922ca302d95330e6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p291bbc11c4e5cdaa922ca302d95330e6b
References: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<CGME20240521024009epcas1p291bbc11c4e5cdaa922ca302d95330e6b@epcas1p2.samsung.com>

With the previous patches, now we can print summary information.

Here's an example of 4GB DRAM device.

Reserved    :  746924 KB
 .kernel    :  137027 KB
 .unusable  :  609897 KB
System      : 3447380 KB
 .common    : 3152468 KB
 .reusable  :  294912 KB
Total       : 4194304 KB (  4096.00 MB )

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/memblock.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index bb033c20ec43..0906d81f66c2 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2689,7 +2689,8 @@ static int memblock_memsize_show(struct seq_file *m, void *private)
 {
 	int i;
 	struct memsize_rgn_struct *rgn;
-	unsigned long reserved = 0, reusable = 0;
+	unsigned long reserved = 0, reusable = 0, total;
+	unsigned long system = totalram_pages() << PAGE_SHIFT;
 
 	sort(memsize_rgn, memsize_rgn_count,
 	     sizeof(memsize_rgn[0]), memsize_rgn_cmp, NULL);
@@ -2715,13 +2716,24 @@ static int memblock_memsize_show(struct seq_file *m, void *private)
 			reserved += (unsigned long)rgn->size;
 	}
 
+	total = memsize_kinit + reserved + system;
+
 	seq_puts(m, "\n");
+	seq_printf(m, "Reserved    : %7lu KB\n",
+		   DIV_ROUND_UP(memsize_kinit + reserved, SZ_1K));
 	seq_printf(m, " .kernel    : %7lu KB\n",
 		   DIV_ROUND_UP(memsize_kinit, SZ_1K));
 	seq_printf(m, " .unusable  : %7lu KB\n",
 		   DIV_ROUND_UP(reserved, SZ_1K));
+	seq_printf(m, "System      : %7lu KB\n",
+		   DIV_ROUND_UP(system, SZ_1K));
+	seq_printf(m, " .common    : %7lu KB\n",
+		   DIV_ROUND_UP(system - reusable, SZ_1K));
 	seq_printf(m, " .reusable  : %7lu KB\n",
 		   DIV_ROUND_UP(reusable, SZ_1K));
+	seq_printf(m, "Total       : %7lu KB ( %5lu.%02lu MB )\n",
+		   DIV_ROUND_UP(total, SZ_1K),
+		   total >> 20, ((total % SZ_1M) * 100) >> 20);
 	return 0;
 }
 
-- 
2.25.1


