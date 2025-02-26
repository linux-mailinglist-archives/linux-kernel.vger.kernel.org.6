Return-Path: <linux-kernel+bounces-533290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D338FA457E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FEB1888D80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744081E1DF3;
	Wed, 26 Feb 2025 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JSqww87L"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759AC258CC6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557643; cv=none; b=dWSrH2MdWOli6AKNX5jNX0tJwLz/AJt5tth8wRNRDg5rC/t1EYHGWyZ8Z1wDy0YX2WEK3xx1FMqoxPMPtIAf/PcpCcw37RFVgL1BQ8cgIduzaQIYUWPE6CPFfX2GT7r7XJsIfHXQ7KwEPetM7O4Tu+1tnqVQjvlz+yGmCG4n3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557643; c=relaxed/simple;
	bh=AsDWX0P+cPKpjYdz6I5TnRFWDOkDoz3A30wuz/i9bgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=nZEKJFnrbCDqCIvy3YopCVZkHaf++brtCiYdP1zaOCfU8cEl+OLZDdamOebkb8xOs48AwM1Ex1xu33FWGdnu5p2++A96h3HEzTdZeesftfZtM9GT/xg3LTBegAr2EIkC5Z9N3l7hzeLdyPcST8P4Z2fESq3w1ACwYcNqM0pj6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JSqww87L; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250226081359epoutp04a068d747d9224f1badae33a40f9ace2f~ns-N506ec1618716187epoutp04t
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:13:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250226081359epoutp04a068d747d9224f1badae33a40f9ace2f~ns-N506ec1618716187epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740557639;
	bh=y/oMSuvRKepLmXTKGntS/Q0V/kBVdNCAFR/MpTdZ1o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JSqww87LJh6TvIL0vN6mUf9sczbXExDkG4pPXBXqMnVxj2d8ZMF3GkDMoXAaWNrFv
	 Qng2wJMNYQvzhVenHFseQcxAL05OJ5M8y3tz+YqD+AMO4JQYCJSnVU+OMaz1uXNXRp
	 oZBvvD6Y/u6x+zkKebZhSbMBD+XfXrjXLd+kFRJQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20250226081358epcas2p4e8cce881bccda9714b1e8ed47cc7a9a4~ns-NYqr812188621886epcas2p4l;
	Wed, 26 Feb 2025 08:13:58 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.68]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z2nLG15ctz4x9QC; Wed, 26 Feb
	2025 08:13:58 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.7C.22938.64DCEB76; Wed, 26 Feb 2025 17:13:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20250226081357epcas2p2f4c462b215b75291a9aeeec23aa1eaca~ns-MYMWbM2578225782epcas2p2V;
	Wed, 26 Feb 2025 08:13:57 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250226081357epsmtrp16d2e4ae7b529aa45a4a725ea784d30d4~ns-MXYt4l0588005880epsmtrp1j;
	Wed, 26 Feb 2025 08:13:57 +0000 (GMT)
X-AuditID: b6c32a43-99d9b2400000599a-34-67becd467a02
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.A9.23488.54DCEB76; Wed, 26 Feb 2025 17:13:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.95.142]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250226081357epsmtip20c43f30dedbf8fdfe160e8d4337488e8~ns-MFlIWK2001620016epsmtip2S;
	Wed, 26 Feb 2025 08:13:57 +0000 (GMT)
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: 
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz, harry.yoo@oracle.com, Hyesoo
	Yu <hyesoo.yu@samsung.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg
	<penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Roman
	Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] mm: slub: Print the broken data before restoring
 slub.
Date: Wed, 26 Feb 2025 17:12:00 +0900
Message-ID: <20250226081206.680495-2-hyesoo.yu@samsung.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250226081206.680495-1-hyesoo.yu@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmqa7b2X3pBhcPsFpM7DGwmLN+DZvF
	9W9vGC3uL3vGYvG38wKrxcruZjaLzXOKLS7vmsNmcW/Nf1aLts//gMSSjUwWE9eIWsxu7GN0
	4PXYOesuu8eCTaUem1Z1snls+jSJ3aPr7RUmjxMzfrN4PLkyncljYcNUZo+PT2+xePRtWcXo
	cWbBEXaPz5vkAniism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVc
	fAJ03TJzgH5QUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+Wl
	llgZGhgYmQIVJmRn7Dv9j61ghVrFkRWtrA2M0+S6GDk5JARMJC7MnsTexcjFISSwg1Fi5eab
	rBDOJ0aJOecXsUE43xgltn36BlTGAdby6nAeRHwvo8STVWuZIJzPjBK7bt5kA5nLJqAucWLL
	MkYQW0SARWLl9+8sIEXMAuuYJVbOnwyWEBYIkPh1/hcziM0ioCox6dp5JhCbV8BaYvOFc0wQ
	B8pL3F5zkgXE5hSwkXiz+Q4LRI2gxMmZT8BsZqCa5q2zmUEWSAgc4ZBYf/gMG0Szi8TtTU9Y
	IWxhiVfHt7BD2FISL/vboOxiiW2LDzNBNDcwSmzuuM8MkTCWmPWsnRHkZ2YBTYn1u/Qh3leW
	OHILai+fRMfhv9BQ4ZXoaBOCaFSW2L9sHguELSnxaG071AUeEvMWLocGbz+jxMZT05gmMCrM
	QvLOLCTvzEJYvICReRWjWGpBcW56arJRgSE8ipPzczcxghO1lvMOxivz/+kdYmTiYDzEKMHB
	rCTCy5m5J12INyWxsiq1KD++qDQntfgQoykwsCcyS4km5wNzRV5JvKGJpYGJmZmhuZGpgbmS
	OG/1jpZ0IYH0xJLU7NTUgtQimD4mDk6pBqYGhwuWKQpXVxzXjnu29bNwEc/ZhbkeJ1ZXdVQu
	9mgVubr9Vud2lgPGXSfXtF2eyaelmhZk6SC7Jny+LadcTfEi36dr74vs4lo7r/Z20VObh/zr
	8+f2vIvwLHr0rebBEUG9ojfnNmiWXgvo+hHZMCXjS/NUrxN78y+ounvNmHyqqcrLvcN0Hgev
	zmadhWvijrw/WPf35PTNWZELtpvMlz98Syy34aVsxGaNuzkxNT3yYRnrHX/mJM775mxnHP2H
	xSA8via2qXX3wlk/ElJcpq19J8nxm2F+5OllX2frihjV/f33f2Ow9ueqR1NTI9eWL/NqnOJ3
	6OvtSMb7Zz3zuRfzaxqkv/qktUPh17eTUr5KLMUZiYZazEXFiQDQBIrZXQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXtf17L50gzc75C0m9hhYzFm/hs3i
	+rc3jBb3lz1jsfjbeYHVYmV3M5vF5jnFFpd3zWGzuLfmP6tF2+d/QGLJRiaLiWtELWY39jE6
	8HrsnHWX3WPBplKPTas62Tw2fZrE7tH19gqTx4kZv1k8nlyZzuSxsGEqs8fHp7dYPPq2rGL0
	OLPgCLvH501yATxRXDYpqTmZZalF+nYJXBn7Tv9jK1ihVnFkRStrA+M0uS5GDg4JAROJV4fz
	uhi5OIQEdjNKLJt0jbWLkRMoLikx6/NJJghbWOJ+yxFWiKKPjBK3n89lAUmwCahLnNiyjBHE
	FhFgkVj5/TsLSBGzwB5miTfN28EmCQv4SSzcsResiEVAVWLStfNgU3kFrCU2XzgHtUFe4vaa
	k2BDOQVsJN5svsMCcp0QUM3RpTIQ5YISJ2c+ASthBipv3jqbeQKjwCwkqVlIUgsYmVYxSqYW
	FOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgTHk5bGDsZ335r0DzEycTAeYpTgYFYS4eXM3JMu
	xJuSWFmVWpQfX1Sak1p8iFGag0VJnHelYUS6kEB6YklqdmpqQWoRTJaJg1OqgUkzaF3avzX8
	zqfbou72OjZ9Sd4x55PA2TPGx9kDnX+KnFrS1p6Y/vHg+TTVhhcvVvG9FP5U387eMSOfc3Vn
	wlfWmawFpvHt3x9w/HuZOXk2/+3gk2/u/bFgPHhyyUVbPcnlZk8OsF06b/RzYi3n0ov/Na9E
	PT1Zbnc/61bS4cfq/RnhE/qNcx7ksYkUPI/hyn65bpXhgsboC7XSlv2yqoXBGw+ncx9TN4/W
	m7JK+VzD1eCwGtNKU++A9MC0sLOzwzcc+RrNGdcnq/T+oFz2sb/b2z0OcVvsvxSdvdJm5+yk
	DVMcLn66aM4q/+O8X57Vq183szpvLVh6c/6cwr9/X7Y9/3HnoV4Re2tO22a7biElluKMREMt
	5qLiRAD25iFRFgMAAA==
X-CMS-MailID: 20250226081357epcas2p2f4c462b215b75291a9aeeec23aa1eaca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250226081357epcas2p2f4c462b215b75291a9aeeec23aa1eaca
References: <20250226081206.680495-1-hyesoo.yu@samsung.com>
	<CGME20250226081357epcas2p2f4c462b215b75291a9aeeec23aa1eaca@epcas2p2.samsung.com>

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

Changes in v4:
- Change the print format to include specific error names.

Changes in v3:
- Change the parameter type of check_bytes_and_report.

Changes in v2:
- Instead of using print_section every time on check_bytes_and_report,
just print it once for the entire slub object before the restore.

Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
---
 mm/slub.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b3969d63cc04..8c13cd43c0fd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1192,8 +1192,8 @@ static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 
 static pad_check_attributes int
 check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
-		       u8 *object, char *what,
-		       u8 *start, unsigned int value, unsigned int bytes)
+		       u8 *object, char *what, u8 *start, unsigned int value,
+		       unsigned int bytes, bool slab_obj_print)
 {
 	u8 *fault;
 	u8 *end;
@@ -1212,10 +1212,11 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
 	if (slab_add_kunit_errors())
 		goto skip_bug_print;
 
-	slab_bug(s, "%s overwritten", what);
-	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
-					fault, end - 1, fault - addr,
-					fault[0], value);
+	pr_err("[%s overwritten] 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
+	       what, fault, end - 1, fault - addr, fault[0], value);
+
+	if (slab_obj_print)
+		object_err(s, slab, object, "Object corrupt");
 
 skip_bug_print:
 	restore_bytes(s, what, value, fault, end);
@@ -1279,7 +1280,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 		return 1;
 
 	return check_bytes_and_report(s, slab, p, "Object padding",
-			p + off, POISON_INUSE, size_from_object(s) - off);
+			p + off, POISON_INUSE, size_from_object(s) - off, true);
 }
 
 /* Check the pad bytes at the end of a slab page */
@@ -1329,11 +1330,11 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 
 	if (s->flags & SLAB_RED_ZONE) {
 		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
-			object - s->red_left_pad, val, s->red_left_pad))
+			object - s->red_left_pad, val, s->red_left_pad, ret))
 			ret = 0;
 
 		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
-			endobject, val, s->inuse - s->object_size))
+			endobject, val, s->inuse - s->object_size, ret))
 			ret = 0;
 
 		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
@@ -1342,7 +1343,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 			if (s->object_size > orig_size  &&
 				!check_bytes_and_report(s, slab, object,
 					"kmalloc Redzone", p + orig_size,
-					val, s->object_size - orig_size)) {
+					val, s->object_size - orig_size, ret)) {
 				ret = 0;
 			}
 		}
@@ -1350,7 +1351,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
 			if (!check_bytes_and_report(s, slab, p, "Alignment padding",
 				endobject, POISON_INUSE,
-				s->inuse - s->object_size))
+				s->inuse - s->object_size, ret))
 				ret = 0;
 		}
 	}
@@ -1366,11 +1367,11 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 			if (kasan_meta_size < s->object_size - 1 &&
 			    !check_bytes_and_report(s, slab, p, "Poison",
 					p + kasan_meta_size, POISON_FREE,
-					s->object_size - kasan_meta_size - 1))
+					s->object_size - kasan_meta_size - 1, ret))
 				ret = 0;
 			if (kasan_meta_size < s->object_size &&
 			    !check_bytes_and_report(s, slab, p, "End Poison",
-					p + s->object_size - 1, POISON_END, 1))
+					p + s->object_size - 1, POISON_END, 1, ret))
 				ret = 0;
 		}
 		/*
@@ -1396,11 +1397,6 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
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


