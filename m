Return-Path: <linux-kernel+bounces-522921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 176B1A3D01E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E43927A7390
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0271E0487;
	Thu, 20 Feb 2025 03:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jwrcLfBR"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869E1DED72
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740022922; cv=none; b=m4G1i8T2hHMRsiLJ0K+YdSIFUxsvjVMpRuabVAJq9MPL0KUaxVrWVkGCCYRZcRauUuR93gsp7t1V2wvJ0GzDf43+hgqw0CFkvSz8oU6R914chRDiuT/cJizJy8FLFLiwTGKBFLen8sIgbKikF7aEcNmRFFKEnjDBHVjE6X/LItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740022922; c=relaxed/simple;
	bh=OScdaKDtr8T06yXiVcDLxJw3B/t1G8+PUsSdSGgJfT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=UYv0zwhH4wP5aqd4lNCLI6MB8FdbsRFLqImkRDGA9GtoJMQqlPNwvp296fSinJhzwvUOsa3w/LaKlekc+4d+psizSo7vMLqhX6xVaNlTahZBaL4cZf4SChfdI0o7GNZ9FQn7VJdOPNpV4n60/2PGrVP6FS4XU451KKH4bULPkao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jwrcLfBR; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250220034157epoutp028498394d83d7eaebd3a1e7bd8ef9cba9~lzZ-Y4eWB1229612296epoutp02Z
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:41:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250220034157epoutp028498394d83d7eaebd3a1e7bd8ef9cba9~lzZ-Y4eWB1229612296epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740022917;
	bh=vjT+FDRV2/jMUKEGLa+CBlGRc7uvf1OYkjsKrrMpdZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwrcLfBR7DyGy7+8VT9UdXxTpVs0Tk/u+3krIfwfTiMpvfHgABMIZ2OgmmyZgYSjP
	 1mW7TfkltEWjQV3kt+UJ9RFi20zsLNVuqUF2FUoiEbkHYQBkrS2nljyYpcEjuKj9al
	 g1YqLnwGrh8vaic/6OueIU130WuqaXDCa09srofM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20250220034156epcas2p3baa2889f044da38ee9248a81386468cd~lzZ_8thZ42335023350epcas2p3N;
	Thu, 20 Feb 2025 03:41:56 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.89]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Yyzb84lm8z4x9Q2; Thu, 20 Feb
	2025 03:41:56 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C4.3D.32010.484A6B76; Thu, 20 Feb 2025 12:41:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250220034155epcas2p156b90cfb655a03cce4bfac9683f0bfe1~lzZ99UehS0484304843epcas2p1Y;
	Thu, 20 Feb 2025 03:41:55 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250220034155epsmtrp228b8489697316fce430374a5077087a8~lzZ98qRJW0154001540epsmtrp2g;
	Thu, 20 Feb 2025 03:41:55 +0000 (GMT)
X-AuditID: b6c32a4d-acffa70000007d0a-4b-67b6a484f61d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.C7.33707.384A6B76; Thu, 20 Feb 2025 12:41:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.95.142]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250220034155epsmtip2387cdf1b25b38d44199bd5ae42908dcf~lzZ9s6xmK1425514255epsmtip2i;
	Thu, 20 Feb 2025 03:41:55 +0000 (GMT)
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: 
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz, Hyesoo Yu
	<hyesoo.yu@samsung.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg
	<penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Roman
	Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mm: slub: call WARN() when the slab detect an error
Date: Thu, 20 Feb 2025 12:39:44 +0900
Message-ID: <20250220033953.1606820-3-hyesoo.yu@samsung.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmmW7Lkm3pBkfvqFhM7DGwmLN+DZvF
	9W9vGC3+dl5gtVjZ3cxmsXlOscXlXXPYLO6t+c9q0fb5H5BYspHJYuIaUYvZjX2MDjweO2fd
	ZfdYsKnUY9OqTjaPTZ8msXt0vb3C5HFixm8WjydXpjN5LGyYyuzRt2UVo8eZBUfYPT5vkgvg
	jsq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6XEmh
	LDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQ
	nXF3tVbBacWKfz37WRsYV0h3MXJySAiYSNzc9Yqti5GLQ0hgD6PEqhUnmSGcT4wSm+fcR3De
	TVjECNOy/PszVojETkaJ08d/MEE4nxkl3qzYywpSxSagLnFiyzKwDhEBFomV37+zgBQxC8xg
	lth+aDcTSEJYwFuif+ZMdhCbRUBVYtraZ2BxXgEbiWs3NkCtk5e4veYkC4jNKWAr8aZtGTtE
	jaDEyZlPwOLMQDXNW2czQ9Qv5ZA4fMQdwnaRmHj4KTuELSzx6vgWKFtK4vO7vWwQdrHEtsWH
	wT6QEGgAerrjPtQgY4lZz9qBjuAAWqApsX6XPogpIaAsceQW1Fo+iY7Df9khwrwSHW1CEI3K
	EvuXzWOBsCUlHq1tZ4WwPSQeL1wNDasJwBB9vIlxAqPCLCTfzELyzSyExQsYmVcxSqUWFOem
	pyYbFRjq5qWWw2M5OT93EyM4NWv57mB8vf6v3iFGJg7GQ4wSHMxKIrxt9VvShXhTEiurUovy
	44tKc1KLDzGaAsN7IrOUaHI+MDvklcQbmlgamJiZGZobmRqYK4nzVu9oSRcSSE8sSc1OTS1I
	LYLpY+LglGpgat0VfDbof/G803bB54s5JCy4LT7xuz774JV9cGp885aru2ViDkVsqz1uPCfW
	2vG8p6benckf1Vp6i0y/rGy6o8v+W3mqeLDVrl1z83772V0WP9C/ILZP+PBR0e/MD283q4pf
	bk7Ne35g/W7vM24rEicWOIpEr+bME/icUXqDN73lj558nLN1yvICRifTs3td54fJJDCK1uYt
	cZ+dzSBxS1bCtapkTyL/gttFxfVbNu5Mnzwrg1eqNffbzFqfGNEftjzMyZwzu3V898flO59t
	T6+8ELX/U+65hwpupRdW+4eq2R1fs11mB+9p4w1hDof3PV9h86LIdv2p1dtEe+7IXH//iz8q
	Lj4jnfdT/H4lluKMREMt5qLiRADaHBzGVgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSvG7zkm3pBv9u6FtM7DGwmLN+DZvF
	9W9vGC3+dl5gtVjZ3cxmsXlOscXlXXPYLO6t+c9q0fb5H5BYspHJYuIaUYvZjX2MDjweO2fd
	ZfdYsKnUY9OqTjaPTZ8msXt0vb3C5HFixm8WjydXpjN5LGyYyuzRt2UVo8eZBUfYPT5vkgvg
	juKySUnNySxLLdK3S+DKuLtaq+C0YsW/nv2sDYwrpLsYOTkkBEwkln9/xtrFyMUhJLCdUWLu
	svWMEAlJiVmfTzJB2MIS91uOQBV9ZJT4c3o1C0iCTUBd4sSWZWANIgIsEiu/f2cBKWIWWMIs
	cWz+NGaQhLCAt0T/zJnsIDaLgKrEtLXPwKbyCthIXLuxAWqbvMTtNSfBhnIK2Eq8aVsGVi8E
	VHNu33GoekGJkzOfgNUwA9U3b53NPIFRYBaS1CwkqQWMTKsYRVMLinPTc5MLDPWKE3OLS/PS
	9ZLzczcxgqNGK2gH47L1f/UOMTJxMB5ilOBgVhLhbavfki7Em5JYWZValB9fVJqTWnyIUZqD
	RUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXANJX1fMDCZSpLTcI4Op73WM89uNjyafbWazWT
	+Zz2Zu+/dKz0ZuQKg1ev/s5lCIo7eS7L0mmRQf7h+779MV9O9fEu+jDr5dGAsqfab0sZnPv/
	t73tUm635F5+9NeLmh0V1lwd8qv+qYhb3r5h87ahO9lc3fi524nWWm375b8PlmyysV7ub5YX
	HcrzY/+qskXTGVWXue9eJzD5hNnZqLdzdhnM5RTL8jR8Y+14n1fuhllLqaLGD5l9vMF9a9du
	ONOzxenNtiW78+Rv/ureLhpot6pe7F/+bu72oNigkq0K66dfXFx8W3Q9c3xc03uhXb4tCz0O
	b3ia4zWfIy691aTFR1+0NbbvBY/JwkKPUoG7SizFGYmGWsxFxYkA097L5QkDAAA=
X-CMS-MailID: 20250220034155epcas2p156b90cfb655a03cce4bfac9683f0bfe1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220034155epcas2p156b90cfb655a03cce4bfac9683f0bfe1
References: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
	<CGME20250220034155epcas2p156b90cfb655a03cce4bfac9683f0bfe1@epcas2p1.samsung.com>

If a slab object is corrupted or an error occurs in its internal
value, continuing after restoration may cause other side effects.
At this point, it is difficult to debug because the problem occurred
in the past. It is useful to use WARN() to catch errors at the point
of issue because WARN() could trigger panic for system debugging when
panic_on_warn is enabled. WARN() is added where to detect the error
on slab_err and object_err.

There are cases where slab_err is called before meaningful logs are
printed. If the WARN() in slab_err cause a panic, these logs will not
be printed. WARN() should called after these logs are printed. Thus
slab_err() is splited to __slab_err that calls the WARN() and it is
called after printing logs.

Changes in v3:
- move the WARN from slab_fix to slab_err, object_err to use WARN on
all error reporting paths.

Changes in v2:
- Replace direct calling with BUG_ON with the use of WARN in slab_fix.

Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
Change-Id: I90b2ea9ffc58e3826f7ae9f1a774bb48c2d43bf4
---
 mm/slub.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index de62fed12236..7f0583a71cda 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1096,8 +1096,6 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 		/* Beginning of the filler is the free pointer */
 		print_section(KERN_ERR, "Padding  ", p + off,
 			      size_from_object(s) - off);
-
-	dump_stack();
 }
 
 static void object_err(struct kmem_cache *s, struct slab *slab,
@@ -1109,6 +1107,8 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
 	slab_bug(s, "%s", reason);
 	print_trailer(s, slab, object);
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
+
+	WARN_ON(1);
 }
 
 static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
@@ -1125,6 +1125,14 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 	return false;
 }
 
+static void __slab_err(struct slab *slab)
+{
+	print_slab_info(slab);
+	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
+
+	WARN_ON(1);
+}
+
 static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
 			const char *fmt, ...)
 {
@@ -1138,9 +1146,7 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
 	vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 	slab_bug(s, "%s", buf);
-	print_slab_info(slab);
-	dump_stack();
-	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
+	__slab_err(slab);
 }
 
 static void init_object(struct kmem_cache *s, void *object, u8 val)
@@ -1316,9 +1322,10 @@ slab_pad_check(struct kmem_cache *s, struct slab *slab)
 	while (end > fault && end[-1] == POISON_INUSE)
 		end--;
 
-	slab_err(s, slab, "Padding overwritten. 0x%p-0x%p @offset=%tu",
-			fault, end - 1, fault - start);
+	slab_bug(s, "Padding overwritten. 0x%p-0x%p @offset=%tu",
+		 fault, end - 1, fault - start);
 	print_section(KERN_ERR, "Padding ", pad, remainder);
+	__slab_err(slab);
 
 	restore_bytes(s, "slab padding", POISON_INUSE, fault, end);
 }
@@ -5431,14 +5438,13 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	return !!oo_objects(s->oo);
 }
 
-static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
-			      const char *text)
+static void list_slab_objects(struct kmem_cache *s, struct slab *slab)
 {
 #ifdef CONFIG_SLUB_DEBUG
 	void *addr = slab_address(slab);
 	void *p;
 
-	slab_err(s, slab, text, s->name);
+	slab_bug(s, "Objects remaining on __kmem_cache_shutdown()");
 
 	spin_lock(&object_map_lock);
 	__fill_map(object_map, s, slab);
@@ -5453,6 +5459,8 @@ static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
 		}
 	}
 	spin_unlock(&object_map_lock);
+
+	__slab_err(slab);
 #endif
 }
 
@@ -5473,8 +5481,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 			remove_partial(n, slab);
 			list_add(&slab->slab_list, &discard);
 		} else {
-			list_slab_objects(s, slab,
-			  "Objects remaining in %s on __kmem_cache_shutdown()");
+			list_slab_objects(s, slab);
 		}
 	}
 	spin_unlock_irq(&n->list_lock);
-- 
2.28.0


