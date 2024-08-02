Return-Path: <linux-kernel+bounces-272124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1244A945756
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB149286314
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CDA2D047;
	Fri,  2 Aug 2024 05:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arXIXZQg"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7693715E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 05:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722575837; cv=none; b=l3PhLpknCgOLZkeo6jP0Vr+30gyYMdr+BYIqHi/k2bxe/HeMKxJ0DqcQpi7V3OxSQ1yOdHX3BqKKYLIbrqvLjoIIOpPwD/dyPIwS1JqgyTeLf3bmKaF3LftbwFeqRSZ8Y3ErW7sj9AIKzCePV1glPAEUITzBXMGtWJIwD+FOzQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722575837; c=relaxed/simple;
	bh=7weaNblhrUf3WaTiJvD5rkb3XNRUNYqSgiAyidNZJ/0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=eE1kvAbPR6KMgJ+cbafxr0fi9aS6jwF5oTtszEBwqA8z5wPr+EHaMKvgSwxzw1DnqHM3vqA1I/bYS+T6d2671CxrjoMApTuSBzdjjJ8ThQFYeEblsY2LVogGa7JhGQno+lIfrCSSDJ6p6Rwy54SrZBsMM/iLp4bb9BahE2/5+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arXIXZQg; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a1be7b5d70so2121801a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 22:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722575835; x=1723180635; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzQPgYXXMRWw+msy5ZgzdvZDXWhdSZVTosMfme1JQME=;
        b=arXIXZQgAFpxUQ2JnLRaTWgLq6w4L2OD363lnu9HpwPcvZIGxdX0u1lHykfDkp4yMK
         CK4iES9h0ZhsRfODzBK+SDe/3o4b2RI6DRoBfgINhpGL1FIN8WAFV9WwbaSM2HDGL7ER
         g+YDOXxBiNRixsgMKPqod18NhxrYUN4HUqnKf7Zw6maFUQG5AhD7jYO+i4dQP4JO4IRJ
         ciJydV2VxTewFf18qy1Ujtm13dOHtzfEPzsMXhizWP2tBar/ayKkU3QW9Zq4KobBm8QR
         w9jwTA8YgofDu/EHh+XEA3K1Slb2SnA1bwOgj27rsKQWR8NwVPljvDlhO08ze1Htz2bq
         rK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722575835; x=1723180635;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzQPgYXXMRWw+msy5ZgzdvZDXWhdSZVTosMfme1JQME=;
        b=CWJ1XzBLBbzjH/EOgwVNvmjuM5a/6vDoHJBgLcgXXnxZ1Eg01SQnDuiviDnMRX08/f
         r6ypsztLSlZmHX9OH3FxGXoGiDhscB1kGeTGc8bGgx50Y2jSX/EIVyqHIFR/vDQWFHb3
         E43kHgXMgiECFM4nspA+vy+qpu/uUVS7KqRvFDRa1AJOsR/KCGZu/oe/6bb8CjhO1UQ8
         xhVCLnHBuGnPiM39WOblAB4kBFHtlspHff9gPGFtTw375s7nYC86Yum152Uv8QUHQsqv
         1iLyz/2Hk6Ha66DVM6TvNhmPE4OuR9YWpjThY8RrfSC9gRKaGOqNzEfQCgcBPm+AFo2H
         yeiA==
X-Forwarded-Encrypted: i=1; AJvYcCUK4kDexEA/+COyt834VicF9ic5G29x6nh2lp4gkz7/X3LtsBTCNiqujLFpcfYOCPKf9InEexnW8UQh5pU8LIl+N5w83L0K4Zhl5O7R
X-Gm-Message-State: AOJu0YzgvBSAGX6fbLmETzxpkdXKzal20ju8GNUIFFYewNQcvaXu6xPU
	Hdm4gtegaWnvzAxELu+/Nw9CwpposivPQhW+ZweciRGRRyzECAwk
X-Google-Smtp-Source: AGHT+IGmSneQzIx8fc2d042dCc2cdpSWM3j7hQV2KJJwF4AwLAZ6KFQaFmXW2t5txQbHjXXIcT1QHg==
X-Received: by 2002:a17:903:247:b0:1fd:74ac:e6b8 with SMTP id d9443c01a7336-1ff57b60fffmr40602005ad.7.1722575834590;
        Thu, 01 Aug 2024 22:17:14 -0700 (PDT)
Received: from localhost.localdomain ([180.69.210.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ff5929404dsm7919805ad.245.2024.08.01.22.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 22:17:13 -0700 (PDT)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <levinsasha928@gmail.com>,
	Michel Lespinasse <walken@google.com>,
	"Liam R . Howlett " <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maple-tree@lists.infradead.org
Subject: [PATCH v1 2/2] lib/htree: Modified lib/Makefile and lib/Kconfig to build htree
Date: Fri,  2 Aug 2024 14:17:00 +0900
Message-Id: <20240802051700.8234-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

add lhtree.o, htree-test.o in the lib/Makfile and Kconfig.debug

add Documentation/Documentation/core-api/htree.rst

Full files can be download at the link below:

source files:
	https://github.com/kernel-bz/htree.git
documents(PDF):
	https://github.com/kernel-bz/htree/tree/main/docs/htree=20240802.pdf

I have described this in more detail with pictures in the PDF file.

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 Documentation/core-api/htree.rst | 111 +++++++++++++++++++++++++++++++
 lib/Kconfig.debug                |   6 ++
 lib/Makefile                     |   4 +-
 3 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/core-api/htree.rst

diff --git a/Documentation/core-api/htree.rst b/Documentation/core-api/htree.rst
new file mode 100644
index 000000000000..78073b413779
--- /dev/null
+++ b/Documentation/core-api/htree.rst
@@ -0,0 +1,111 @@
+======================================
+Hash Trees (lib/htree) in Linux Kernel
+======================================
+
+:Date: August 2, 2024
+:Author: JaeJoon Jung <rgbi3307@gmail.com>
+
+
+Implementation of new Hash Tree
+-----------------------------------------------------------------
+new Hash Tree Features
+-----------------------------------------------------------------
+* Very small hash tree structure. [16 Bytes]
+* Dynamic memory allocation and free.
+* Both 32-bit and 64-bit indexes are possible
+* Generate hash keys uniformly based on the index.
+* Hash trees are balanced by hash keys, and have no rotation costs.
+* Standard deviation of hash key is 4 or less.
+* Algorithm O(n) is depth(d) x nodes(c)
+* Finding walks is (d x c), min:4, avg:12, max:20
+* First hash table has smallest, largest index, algorithm O(1).
+* The codes implementing of the algorithm is simple.
+* Adjust hash tree depth according to system memory and index nr.
+* Hash list nodes use include/linux/list.h, hlist as their base.
+-----------------------------------------------------------------
+
+Hash Tree Summary (include/linux/htree.h)
+-----------------------------------------------------------------
+
+ size of one hash tree struct: [16]Bytes
+ size of one data struct: (40)Bytes
+ size of middle: 32Bytes
+
+ if system has 16GB memory, number of index(nr) is 256M(middle)
+ if system has  4GB memory, number of index(nr) is  64M(middle)
+ ...
+ index max: 1 << 50: 2^50:   1P (  1P x 32:  32P) --> depth:6 (64bits index)
+ index max: 1 << 40: 2^40:   1T (  1T x 32:  32T) --> depth:6 (64bits index)
+ ...
+ index max: 1 << 32: 2^32:   4G (  4G x 32: 128G) --> depth:5
+ index max: 1 << 28: 2^29: 512M (512M x 32:  16G) --> depth:4 (32bits index)
+ index max: 1 << 28: 2^28: 256M (256M x 32:   8G) --> depth:4
+ index max: 1 << 26: 2^26:  64M ( 64M x 32:   2G) --> depth:3 (32bits index)
+ index max: 1 << 25: 2^25:  32M ( 32M x 32:   1G) --> depth:2
+
+ if number of index(nr) is between 32M and 64M, hash tree depth is [2,3)
+
+ hash array size(anum): 1 << (sbit - depth)
+ dnum: [d0:anum x d1:anum x d2:anum x d3:anum x d4:anum x d5:anum ...)
+
+ if starting hash bit(sbit) is 9:
+ dnum: [d0:512  x d1:256  x d2:128  x d3:64   x d4:32   x d5:16   ...)
+
+ dcnt(max index): (d:dnum * HTREE_NODE_CNT): (dnum * 4)
+     : d0:2K, d1:512K, d2:64M, d3:4G, d4:128G, d5:2T, ...
+
+ asum(mid index): (d:dnum * HTREE_NODE_MIN): (dnum * 2)
+     : d0:1K, d1:256K, d2:32M, d3:2G, d4: 64G, d5:1T, ...
+
+ htree depth avg(d): (3)
+ hlist node cnt(c) : [4)
+ algorithm O(n)    : (d) x c == 3 x 4 == 12 (finding walks)
+ memory efficiency : (dcnt / asum) == 85%(/100 == 0.85) (usage eff)
+
+ htree depth(d):   0 ---->   1 ---->   2 ---->  3 ---->  4 ---->  5
+ hash bits(b)  :   9 ---->   8 ---->   7 ---->  6 ---->  5 ---->  4
+ table size(t) : 512 ----> 256 ----> 128 ----> 64 ----> 32 ----> 16
+
+ d0:b9:t512
+    +-----[4)--> d1:b8:t256
+                    +-------> d2:b7:t128
+                                 +-------> d3:b6:t64
+                                              +------> d4:b5:t32
+                                                          +------> d5:b4:t16
+
+ if sort flag is HTREE_FLAG_ASCD, first htree depth(d0) has smallest index.
+ if sort flag is HTREE_FLAG_DECD, first htree depth(d0) has largest index.
+ hts->most has the hash key position, algorithm O(1).
+
+ If there is the same index:
+ if req is htf_ins, the new udata is inserted next to each other.
+ if req is htf_erase, the new udata is inserted, and old udata is erased.
+
+-----------------------------------------------------------------------------
+Hash Tree API flow (lib/htree.c, lib/htree-test.c)
+-----------------------------------------------------------------------------
+
+*hts = ht_hts_alloc()           /* alloc hts */
+ht_hts_clear_init(hts, ...)	/* max nr, type(32/64bits), sort(ASC, DES) */
+*htree = ht_table_alloc(hts)    /* alloc first(depth:0) htree */
+
+run_loop() {
+	*udata = _data_alloc(index)             /* alloc udata */
+	ht_insert(hts, htree, udata->hdata, ..)	/* working data with index */
+	ht_erase(hts, htree, index)
+	hdata = ht_find(hts, htree, index)
+	hdata = ht_most_index(hts, htree)	/* smallest, largest index */
+	ht_statis(hts, htree, ...)		/* statistic */
+}
+
+htree_erase_all(hts, htree)     /* remove all udata */
+ht_destroy(hts, htree)          /* remove all htree */
+kfree(hts)                      /* remove hts */
+
+-----------------------------------------------------------------------------
+Please refer to the attached PDF for more detailed information.
+-----------------------------------------------------------------------------
+documents(PDF):
+	https://github.com/kernel-bz/htree/tree/main/docs/htree=20240802.pdf
+
+Thanks.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..0a0844710e05 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2349,6 +2349,12 @@ config RBTREE_TEST
 	  A benchmark measuring the performance of the rbtree library.
 	  Also includes rbtree invariant checks.
 
+config HTREE_TEST
+	tristate "Hash Tree test"
+	depends on DEBUG_KERNEL
+	help
+	  A performance testing of the hash tree library.
+
 config REED_SOLOMON_TEST
 	tristate "Reed-Solomon library test"
 	depends on DEBUG_KERNEL || m
diff --git a/lib/Makefile b/lib/Makefile
index 322bb127b4dc..a2ac59e9d731 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o objpool.o
+	 buildid.o objpool.o htree.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
@@ -295,6 +295,8 @@ $(obj)/default.bconf: $(CONFIG_BOOT_CONFIG_EMBED_FILE) FORCE
 obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
 obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
 
+obj-$(CONFIG_HTREE_TEST) += htree-test.o
+
 obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
 
 obj-$(CONFIG_ASN1) += asn1_decoder.o
-- 
2.17.1


