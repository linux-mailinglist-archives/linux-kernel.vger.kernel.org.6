Return-Path: <linux-kernel+bounces-533291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5CFA457EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5E47AAC68
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797321E1E0F;
	Wed, 26 Feb 2025 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jLUSjX0J"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B819D8A8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557645; cv=none; b=OaEuLn/fS57UeIgNzDrByoJ08p5IZ+WHHTfu8axexDf3FbkEXHemuSvm/wtRQUQPFIk+T78ufuIREg438isu8ewJOkJViToMwfJPMYsz4VjN8rL57Zv2sl6Zs+FgiYKpB3iBwOV1IIo/RpydJ0pzckp91ksoulw+Mixe6I0reZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557645; c=relaxed/simple;
	bh=etSVKesB0NKmvk+Vm5CRAxiL5qFVwRFr7hTLjRMVO00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=SBgSXMgeM7DKDa1+/tXLSKqf8wGmaKv54qkQh1ytWlHAj/Df/hkB3R1T/IyzyObrgjdXz6AXPszmUvoOsQmxES3fLnsCwQW6aVEY5e50mY2SpuH4I8g7M63kOESbZMmIiIdvBnYBFEpDOXcdij1wG/zJnSeA9jNg1GXhca18m70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jLUSjX0J; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250226081401epoutp030b73ea411b39188e746f6abb2de9f426~ns-Pn9NYn1730317303epoutp03E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:14:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250226081401epoutp030b73ea411b39188e746f6abb2de9f426~ns-Pn9NYn1730317303epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740557641;
	bh=ouCvGVz+UyYcyRbwwR2KSi8SaQSHfPFVtpF7i2zb2iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLUSjX0JBP7lZQ38wMAZiMgP0QnSeiP/go9OW/Vk8ySptu+l0DhYhne/1Iner+TNM
	 p0ZVXRe8vQP0Gs1vf8Jvy3/evEsBMb2uB+4mFvnvDrxCSPAUAiyNXky9+s+4yWnvh1
	 9IbDjlvakAxMem1UrhM9XIUID6xo2nLepJtuq314=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20250226081400epcas2p2032d6f1d8b4a712260f3cead3d481b54~ns-PETAAF3273832738epcas2p20;
	Wed, 26 Feb 2025 08:14:00 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.68]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Z2nLJ1Gdkz4x9Q8; Wed, 26 Feb
	2025 08:14:00 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.93.32010.84DCEB76; Wed, 26 Feb 2025 17:14:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20250226081359epcas2p2a6a1f3f92540660129164734fa6eaa64~ns-OFgA-w3273432734epcas2p2w;
	Wed, 26 Feb 2025 08:13:59 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250226081359epsmtrp2621ee7ab8e35576876ef62cf52962a88~ns-ODvo2U2522125221epsmtrp2l;
	Wed, 26 Feb 2025 08:13:59 +0000 (GMT)
X-AuditID: b6c32a4d-abdff70000007d0a-a4-67becd48fff5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	C5.91.33707.74DCEB76; Wed, 26 Feb 2025 17:13:59 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.95.142]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250226081359epsmtip29538791f5635c35baf910182ef65310a~ns-N1dgNy2366323663epsmtip2J;
	Wed, 26 Feb 2025 08:13:59 +0000 (GMT)
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: 
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz, harry.yoo@oracle.com, Hyesoo
	Yu <hyesoo.yu@samsung.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg
	<penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Roman
	Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mm: slub: call WARN() when the slab detect an error
Date: Wed, 26 Feb 2025 17:12:01 +0900
Message-ID: <20250226081206.680495-3-hyesoo.yu@samsung.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250226081206.680495-1-hyesoo.yu@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmha7H2X3pBj+nsFlM7DGwmLN+DZvF
	9W9vGC3uL3vGYvG38wKrxcruZjaLzXOKLS7vmsNmcW/Nf1aLts//gMSSjUwWE9eIWsxu7GN0
	4PXYOesuu8eCTaUem1Z1snls+jSJ3aPr7RUmjxMzfrN4PLkyncljYcNUZo+PT2+xePRtWcXo
	cWbBEXaPz5vkAniism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVc
	fAJ03TJzgH5QUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+Wl
	llgZGhgYmQIVJmRnPL8rX3BWpWJT41aWBsYbsl2MnBwSAiYSm/c/ZOxi5OIQEtjDKHHpww82
	kISQwCdGiVe7hCASQPbkkxtZYTpe3z/LCpHYyShxc+lDNgjnM6PElqetYFVsAuoSJ7YsYwSx
	RQRYJFZ+/84CUsQssI5ZYuX8yWAJYQFviVmND1lAbBYBVYnGicvBdvMKWEvcuLkXap28xO01
	J8FqOAVsJN5svsMCUSMocXLmEzCbGaimeetsZpAFEgI7OCTOf93NDtHsItE6ew2ULSzx6vgW
	KFtK4vO7vWwQdrHEtsWHmSCaGxglNnfcZ4ZIGEvMetYOdCkH0AZNifW79EFMCQFliSO3oPby
	SXQc/ssOEeaV6GgTgmhUlti/bB4LhC0p8WhtO9QrHhLv3j9lhwRvPzCwHkVMYFSYheSbWUi+
	mYWwdwEj8ypGqdSC4tz01GSjAkPdvNRyeCQn5+duYgQnay3fHYyv1//VO8TIxMF4iFGCg1lJ
	hJczc0+6EG9KYmVValF+fFFpTmrxIUZTYHhPZJYSTc4H5ou8knhDE0sDEzMzQ3MjUwNzJXHe
	6h0t6UIC6YklqdmpqQWpRTB9TBycUg1M80U4zl//FPDPJP2Gb4fdrUdWPEfOKS6YzMT05Nyt
	PxMYLTatqD0cp3tE+fdNnvJ6Ntb+g9/E+YJnfnsltsGwYk2Y5c3Onrvz1vOeqk95OHXtgphV
	TyTO9mXbNml9neRuxb5HhmtaBtvv324Fm05NDjzZ2/+rMkuXdVaxU40zs99pGbPVxkxeH0U9
	/z7ee6mw0dNju80kfslCD881rItWvatu3MhebT25vF9x24Wjb/7sv9q5sdh/08GdPDlM10Kk
	FvAGfdtSI9B49Jdi9dbyuF+7T4dKzipJCp999LxPxSSG5RXTUvcddegwvdu2qIX5YCmf3++n
	Nv38yyXNrfaq8KkrFlsUyS6v7lses/+lEktxRqKhFnNRcSIApxLoJl8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSvK772X3pBt2rxCwm9hhYzFm/hs3i
	+rc3jBb3lz1jsfjbeYHVYmV3M5vF5jnFFpd3zWGzuLfmP6tF2+d/QGLJRiaLiWtELWY39jE6
	8HrsnHWX3WPBplKPTas62Tw2fZrE7tH19gqTx4kZv1k8nlyZzuSxsGEqs8fHp7dYPPq2rGL0
	OLPgCLvH501yATxRXDYpqTmZZalF+nYJXBnP78oXnFWp2NS4laWB8YZsFyMnh4SAicTr+2dZ
	uxi5OIQEtjNKtMw9xQiRkJSY9fkkE4QtLHG/5QhU0UdGibXLfrOAJNgE1CVObFkG1iAiwCKx
	8vt3FpAiZoE9zBJvmrezgiSEBbwlZjU+BGtgEVCVaJy4nA3E5hWwlrhxcy8rxAZ5idtrToLV
	cArYSLzZfAfI5gDaZi1xdKkMRLmgxMmZT8BKmIHKm7fOZp7AKDALSWoWktQCRqZVjKKpBcW5
	6bnJBYZ6xYm5xaV56XrJ+bmbGMFxpBW0g3HZ+r96hxiZOBgPMUpwMCuJ8HJm7kkX4k1JrKxK
	LcqPLyrNSS0+xCjNwaIkzquc05kiJJCeWJKanZpakFoEk2Xi4JRqYAoxqo6WW/wz2V1r6Wwd
	5VBr+YvPs0X4UqdF8x08vNrL1MfLzWrZq8jTN3pVuOXVnXue8Sw4sGB/rfPPxsWXvpQLvrkk
	z52k3X7o5nuX5/NtfRx+K85Yb6OwuuzUA9HNf3rfm2xZsMG4jVlLXP6LkMcldv/HeVvYORU0
	NLo/ZkV7ReZqF3jJNcmJvp6RW5Ky9GL66yiedTxLa3Y+ucHSbShkInSez37CtoKTnFu8F617
	U7Qzz/tDM7vwnBjbo5I+/a7sHo5cxmZVsllh5ziMHWP0XRwOaPKYvthYeu4Si9g07+91L71W
	ie9RvnqiTo6pNGOjePpTb6FtEUffKyoI8pw//YE9Q3D/2frpES+UWIozEg21mIuKEwFDz40I
	EgMAAA==
X-CMS-MailID: 20250226081359epcas2p2a6a1f3f92540660129164734fa6eaa64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250226081359epcas2p2a6a1f3f92540660129164734fa6eaa64
References: <20250226081206.680495-1-hyesoo.yu@samsung.com>
	<CGME20250226081359epcas2p2a6a1f3f92540660129164734fa6eaa64@epcas2p2.samsung.com>

If a slab object is corrupted or an error occurs in its internal
value, continuing after restoration may cause other side effects.
At this point, it is difficult to debug because the problem occurred
in the past. It is useful to use WARN() to catch errors at the point
of issue because WARN() could trigger panic for system debugging when
panic_on_warn is enabled. WARN() is added where to detect the error
on slab_err and object_err.

It makes sense to only do the WARN() after printing the logs. slab_err
is splited to __slab_err that calls the WARN() and it is called after
printing logs.

Changes in v4:
- Remove WARN() in kmem_cache_destroy to remove redundant warning.

Changes in v3:
- move the WARN from slab_fix to slab_err, object_err and check_obj to
use WARN on all error reporting paths.

Changes in v2:
- Replace direct calling with BUG_ON with the use of WARN in slab_fix.

Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
---
 mm/slab_common.c |  3 ---
 mm/slub.c        | 31 +++++++++++++++++++------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 477fa471da18..d13f4ffe252b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -517,9 +517,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	kasan_cache_shutdown(s);
 
 	err = __kmem_cache_shutdown(s);
-	if (!slab_in_kunit_test())
-		WARN(err, "%s %s: Slab cache still has objects when called from %pS",
-		     __func__, s->name, (void *)_RET_IP_);
 
 	list_del(&s->list);
 
diff --git a/mm/slub.c b/mm/slub.c
index 8c13cd43c0fd..4961eeccf3ad 100644
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
@@ -1313,9 +1319,10 @@ slab_pad_check(struct kmem_cache *s, struct slab *slab)
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
@@ -5428,14 +5435,13 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
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
@@ -5450,6 +5456,8 @@ static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
 		}
 	}
 	spin_unlock(&object_map_lock);
+
+	__slab_err(slab);
 #endif
 }
 
@@ -5470,8 +5478,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
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


