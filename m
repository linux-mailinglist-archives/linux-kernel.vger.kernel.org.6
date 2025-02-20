Return-Path: <linux-kernel+bounces-522926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E6A3D027
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE247A85ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410DF1C6FF0;
	Thu, 20 Feb 2025 03:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="plkFSWtX"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E635958
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023418; cv=none; b=kzST5W0Vhu7S5ANGI3VoKZ05y5fQLATGagbSNWtohTn5QNw9dQNFRy0itkjZqvha+f5fK2PuYsWcEP8ZR36INnHoLAt8+b/wXgiJ6vfaqaF8bgvjT+HBqfNDEL4Si8vf+4bwdgQHUBz852b4uMVBcovwtBKQ7Xq6jRpowjDMaAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023418; c=relaxed/simple;
	bh=PYFGeWDiJK1zJray/KRu3t7m7/XckFZzoAnOn1p68Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=F8vT/EXAxjgACIjM4ySPevKYOTOb0IydOA2Tf/VrffvC4BWBTSl2LfOoIURs6hNh9SvVA5BqyuSvTfeeLGDxZy5kRs0DMxJ5M5wkG+rClXDr5R9kBA9/OC5hZGgoJ9makO/6+o12jaAsEkaopvOxZZIfbkoNraLopIptl2TSY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=plkFSWtX; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250220034155epoutp034a5f82e32a5d70657abc3da5cc640d3f~lzZ9cHFhH0844408444epoutp036
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:41:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250220034155epoutp034a5f82e32a5d70657abc3da5cc640d3f~lzZ9cHFhH0844408444epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740022915;
	bh=H4azcLXLwKXZ7Rp0EynOTNSZHZ93h+/31V07oqrMJzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plkFSWtXZj5cGCjGL3BRt/+08UsrXpYzNJo9D3v9oGlxEuUhesuH9mBLp9UaAYS/B
	 kxUtY8DnA2ryO80PyiSlpRJ7jH/WImsMxEOqRgkkGdmqRDgoSNOVefCsc5rxLTe0wg
	 QM6L0JI5acNbrZW2vKBmb2gBbq4t+PgokbV1aIGw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20250220034154epcas2p23b341bf96d32260f088e3f3990446018~lzZ8zkyUU2078020780epcas2p2I;
	Thu, 20 Feb 2025 03:41:54 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Yyzb60hr1z4x9Pw; Thu, 20 Feb
	2025 03:41:54 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	FB.DE.23368.184A6B76; Thu, 20 Feb 2025 12:41:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f~lzZ7tCD2q2078020780epcas2p2F;
	Thu, 20 Feb 2025 03:41:53 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250220034153epsmtrp1cbab2796f3f2a97c7397666d4f981bd1~lzZ7sUnvk1425814258epsmtrp1X;
	Thu, 20 Feb 2025 03:41:53 +0000 (GMT)
X-AuditID: b6c32a45-db1ed70000005b48-49-67b6a4818df1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F3.DF.23488.184A6B76; Thu, 20 Feb 2025 12:41:53 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.95.142]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250220034153epsmtip2f87312153609b5094ae5e8f81ba45d09~lzZ7cjPLm1561715617epsmtip2G;
	Thu, 20 Feb 2025 03:41:53 +0000 (GMT)
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: 
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz, Hyesoo Yu
	<hyesoo.yu@samsung.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg
	<penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Roman
	Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mm: slub: Print the broken data before restoring
 slub.
Date: Thu, 20 Feb 2025 12:39:43 +0900
Message-ID: <20250220033953.1606820-2-hyesoo.yu@samsung.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmmW7Tkm3pBhOnM1lM7DGwmLN+DZvF
	9W9vGC3+dl5gtVjZ3cxmsXlOscXlXXPYLO6t+c9q0fb5H5BYshGofo2oxezGPkYHHo+ds+6y
	eyzYVOqxaVUnm8emT5PYPbreXmHyODHjN4vHkyvTmTwWNkxl9ujbsorR48yCI+wenzfJBXBH
	ZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2upFCW
	mFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjO
	uPH2JlvBUbWKk9PbmRoYd8h1MXJySAiYSPzo/8DYxcjFISSwg1HizZKHUM4nRomO6dvYQaqE
	BL4xSny6ZQHT0burmR2iaC+jxKudncwQzmdGidYPk9lAqtgE1CVObFnGCGKLCLBIrPz+nQWk
	iFlgBrPE9kO7mUASwgIBEp2H1jKD2CwCqhLPLh8Ca+YVsJFonD+JDWKdvMTtNSdZQGxOAVuJ
	N23L2CFqBCVOznwCFmcGqmneOhvsCgmBLRwSC5ovAC3gAHJcJHZvFoWYIyzx6vgWdghbSuJl
	fxuUXSyxbfFhJojeBkaJzR33mSESxhKznrUzgsxhFtCUWL9LH2KkssSRW1Br+SQ6Dv9lhwjz
	SnS0CUE0KkvsXzaPBcKWlHi0tp0VwvaQuHBqKyskrCYwSjw4+I59AqPCLCTfzELyzSyExQsY
	mVcxiqUWFOempxYbFRjCYzg5P3cTIzgla7nuYJz89oPeIUYmDsZDjBIczEoivG31W9KFeFMS
	K6tSi/Lji0pzUosPMZoCw3ois5Rocj4wK+SVxBuaWBqYmJkZmhuZGpgrifNW72hJFxJITyxJ
	zU5NLUgtgulj4uCUamDa+j9Qd07fnz8Tkl7f0D5Qv21i3/njR58/9dwkOHFnxM1g38tzxa4r
	vJ7DMuPbXqdFc59ZxTV3rU/ne6PG9Dgs6eDrRK3ko3MaHs1yn/B34b/4241R8051MHw97u/0
	QGmKWwCzxMvtDwqel2dqNCyY82Dq5ufLvu1T+3Rtek36hiiVu0+emxwNC9xVEe0X+bRJ1rZn
	sfDE7NnTtJUdMlVz323c/KZiIs8LjeNndmlf9+Od3XWzuCrMaV3xrs/H3ZKcswNeaxyfM0n/
	2w35v/ZlGmdXf3XXYLDMVGG6WRX140qL2tkDv5zm7En9Ou/tyYl2f7QenNp9btLVk2cjPOYt
	OHdAzU9abt5U9VmxVt/EK6qVWIozEg21mIuKEwENL4GwUgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvG7jkm3pBgs+iVpM7DGwmLN+DZvF
	9W9vGC3+dl5gtVjZ3cxmsXlOscXlXXPYLO6t+c9q0fb5H5BYspHJYuIaUYvZjX2MDjweO2fd
	ZfdYsKnUY9OqTjaPTZ8msXt0vb3C5HFixm8WjydXpjN5LGyYyuzRt2UVo8eZBUfYPT5vkgvg
	juKySUnNySxLLdK3S+DKuPH2JlvBUbWKk9PbmRoYd8h1MXJySAiYSPTuambvYuTiEBLYzSgx
	93MXG0RCUmLW55NMELawxP2WI6wQRR8ZJQ7/ms4MkmATUJc4sWUZI4gtIsAisfL7dxaQImaB
	JcwSx+ZPAysSFvCTWPj2LwuIzSKgKvHs8iGwDbwCNhKN8ydBbZOXuL3mJFgNp4CtxJu2Zewg
	thBQzbl9x5kg6gUlTs58AlbDDFTfvHU28wRGgVlIUrOQpBYwMq1ilEwtKM5Nz002LDDMSy3X
	K07MLS7NS9dLzs/dxAiOHy2NHYzvvjXpH2Jk4mA8xCjBwawkwttWvyVdiDclsbIqtSg/vqg0
	J7X4EKM0B4uSOO9Kw4h0IYH0xJLU7NTUgtQimCwTB6dUA1PAjSOffwe0lK8uvfNrz8SrSYfu
	5f2Qbvq5oWTrccU5BUEXd+1zDXmzOcHQQn1PM9vPNyFrVSy+7JsQJuR//TZn/9aCRUfz4jQ3
	dF/lluZ8dH9mVW2ZonPRApmIzetcNjWGTVM/YzQjNFNBmuWcj7iov/8U70XzenbZ5PqdkNLK
	evf1c5N2+RXLq9yWKlujShZXncu20rYQe/AyRbHXoSSd1ej2g3WK21/O2a0pHRhql85q2D/P
	RX3ywk8vxK/q7onWsWB/JvOXr/Tgk+wbM8q4DFwWbfb91f9h/dHSN00xbZ/lnqa/sUyeVLxh
	R0qV9Ial1aW1S69dXWezlyclisd3yvrwYssXjLY1dz6yuiixFGckGmoxFxUnAgBLUrd/DgMA
	AA==
X-CMS-MailID: 20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f
References: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
	<CGME20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f@epcas2p2.samsung.com>

Previously, the restore occured after printing the object in slub.
After commit 47d911b02cbe ("slab: make check_object() more consistent"),
the bytes are printed after the restore. This information about the bytes
before the restore is highly valuable for debugging purpose.
For instance, in a event of cache issue, it displays byte patterns
by breaking them down into 64-bytes units. Without this information,
we can only speculate on how it was broken. Hence the corrupted regions
should be printed prior to the restoration process. However if an object
breaks in multiple places, the same log may be output multiple times.
Therefore the slub log is reported only once to prevent redundant printing,
by sending a parameter indicating whether an error has occurred previously.

Changes in v3:
- Change the parameter type of check_bytes_and_report.

Changes in v2:
- Instead of using print_section every time on check_bytes_and_report,
just print it once for the entire slub object before the restore.

Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
Change-Id: I73cf76c110eed62506643913517c957c05a29520
---
 mm/slub.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b3969d63cc04..de62fed12236 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1192,12 +1192,13 @@ static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 
 static pad_check_attributes int
 check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
-		       u8 *object, char *what,
-		       u8 *start, unsigned int value, unsigned int bytes)
+		       u8 *object, char *what, u8 *start, unsigned int value,
+		       unsigned int bytes, bool slab_obj_print)
 {
 	u8 *fault;
 	u8 *end;
 	u8 *addr = slab_address(slab);
+	char buf[100];
 
 	metadata_access_enable();
 	fault = memchr_inv(kasan_reset_tag(start), value, bytes);
@@ -1212,11 +1213,14 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
 	if (slab_add_kunit_errors())
 		goto skip_bug_print;
 
-	slab_bug(s, "%s overwritten", what);
 	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
 					fault, end - 1, fault - addr,
 					fault[0], value);
 
+	scnprintf(buf, 100, "%s overwritten", what);
+	if (slab_obj_print)
+		object_err(s, slab, object, buf);
+
 skip_bug_print:
 	restore_bytes(s, what, value, fault, end);
 	return 0;
@@ -1279,7 +1283,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 		return 1;
 
 	return check_bytes_and_report(s, slab, p, "Object padding",
-			p + off, POISON_INUSE, size_from_object(s) - off);
+			p + off, POISON_INUSE, size_from_object(s) - off, true);
 }
 
 /* Check the pad bytes at the end of a slab page */
@@ -1329,11 +1333,11 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 
 	if (s->flags & SLAB_RED_ZONE) {
 		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
-			object - s->red_left_pad, val, s->red_left_pad))
+			object - s->red_left_pad, val, s->red_left_pad, !!ret))
 			ret = 0;
 
 		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
-			endobject, val, s->inuse - s->object_size))
+			endobject, val, s->inuse - s->object_size, !!ret))
 			ret = 0;
 
 		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
@@ -1342,7 +1346,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 			if (s->object_size > orig_size  &&
 				!check_bytes_and_report(s, slab, object,
 					"kmalloc Redzone", p + orig_size,
-					val, s->object_size - orig_size)) {
+					val, s->object_size - orig_size, !!ret)) {
 				ret = 0;
 			}
 		}
@@ -1350,7 +1354,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
 			if (!check_bytes_and_report(s, slab, p, "Alignment padding",
 				endobject, POISON_INUSE,
-				s->inuse - s->object_size))
+				s->inuse - s->object_size, !!ret))
 				ret = 0;
 		}
 	}
@@ -1366,11 +1370,11 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 			if (kasan_meta_size < s->object_size - 1 &&
 			    !check_bytes_and_report(s, slab, p, "Poison",
 					p + kasan_meta_size, POISON_FREE,
-					s->object_size - kasan_meta_size - 1))
+					s->object_size - kasan_meta_size - 1, !!ret))
 				ret = 0;
 			if (kasan_meta_size < s->object_size &&
 			    !check_bytes_and_report(s, slab, p, "End Poison",
-					p + s->object_size - 1, POISON_END, 1))
+					p + s->object_size - 1, POISON_END, 1, !!ret))
 				ret = 0;
 		}
 		/*
@@ -1396,11 +1400,6 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		ret = 0;
 	}
 
-	if (!ret && !slab_in_kunit_test()) {
-		print_trailer(s, slab, object);
-		add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
-	}
-
 	return ret;
 }
 
-- 
2.28.0


