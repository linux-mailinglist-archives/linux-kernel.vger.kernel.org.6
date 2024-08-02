Return-Path: <linux-kernel+bounces-272123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AAD945755
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF251C23B87
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D66B2E3F7;
	Fri,  2 Aug 2024 05:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvMDgAtA"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704F20323
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722575814; cv=none; b=uu75gt1a8SmYWQbqT0YWImR0j0yqt4AznbvTcrOAwwX5eku5j1NUthL5eF875TOBWOx+ISInyeYn2dML06qQc5EIDJqiAuUD1cmkm6PBAZylELJKlHA7wtl/C0QJkRwKdTwkgX17YZq2c7Kho+K4PNtfMXszCWo8bcUDXCI1GFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722575814; c=relaxed/simple;
	bh=Utfpf4F1qNdAGJ+gx3BMhlmJqBKQXKDF99W7ed+dhZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TEkR3Gyu4emnOxoSA8eniC2iSCG1JUcEXT0m73akLjKrIfOJs+LS0YpbSF/cjt+F+lob5qVSkQaaoiZKw3UGSQoTp+yUg+WvOLQhvzfNrP8KU3ARZQJZ09el/dJvFD49PlzABZ2cb3tAd98mYhRE5DNpQPcTEMdKVk2BFVrhsdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvMDgAtA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7a1be7b5d70so2121615a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 22:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722575811; x=1723180611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6AV2RSG77qPhghw7GhPlerdPy9PAUnZvPAu1UbDThA=;
        b=VvMDgAtA/mK6QJabJXlN/7/1Si84XctqynaX3S2wRQzzsbWRtP5PBTthUASSYOKW+k
         Gd6r6O0g3W0ncOxyGG98pPQPNcfZl2xELC3lzq8Ay7eHhP2r6CMRgcoLXuOS8RTQIt1H
         fCC5kR7N7pwlsR+FqQzixRDWM63ZR1EaD/Fpbgf57ozgYmw0T9KlA0IpAaq6LxqVs9w3
         upem4gOU2IF+naZ0Mq8SMQ3qLAoRO1BAl2+I7Du72KNyRUG6jwg9eUfbaOU2MbC06nQI
         5uBXJCwAoc3bA+NawkNlfBEFdBkXhPq7EYzRDd1YTqPJy5swINsI2UX23eFbOlbjqWcM
         8Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722575811; x=1723180611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6AV2RSG77qPhghw7GhPlerdPy9PAUnZvPAu1UbDThA=;
        b=Nb3J0Nblcsevc6rk0RkWsc9WnXKRFdJPxhSroSzOoi7HntTgq4bkIunsT2pZ+oq82C
         mZ4s3bEb73Yy7jXE6gYZHHOmYiDDYmxc1EF0ZBFYD2QaJL9wzZFPnXhnw1XzCtNZTSBg
         VvEeeZQJ+EJr0wHundZVnRaie6IS8fO9EcNEl42tWj6oXEKEc9RM5ohL4UjiYAyW3UQl
         PyRnZimjgwZfUUeEVmxbOYTlRXAxkG/dryTyIWuGNIl44GJy9DSjMRrMJg128RIGqh39
         KMVQcbzjmC/h3McPMoTA/5TJZIvQIODsxreZsLauQw0eCgHTPaSi4b8F4nOUtNDYReZC
         aH4g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/4l9Qca1JG5unU/U9qzO4yMZ/ZpAAd8TpUtEwQrbIfES4GIUumTbCO3x4/wLOcZwlwRIa4FP8m9WkOL+oHFD0gEnfnRXONoDSNSZ
X-Gm-Message-State: AOJu0YwxFHV/yEPgmIKylC/xiu83J4kubIKuwlCh3PEyGJ+3pZO8x1CE
	v8ofm6CG0z2luxjbSuTFQ5WDlDbZXsYIG8WoqHo+N5AIP213X0Tw
X-Google-Smtp-Source: AGHT+IFf0pYFyJPrXkEQkmuLsNx8WTW74uS7uaUzYAi1jhrJogyP6plXw0Ga6eEujFObwAMOVz6LtA==
X-Received: by 2002:a05:6a21:6da4:b0:1c0:f0af:60d with SMTP id adf61e73a8af0-1c69a59186cmr3717629637.6.1722575810159;
        Thu, 01 Aug 2024 22:16:50 -0700 (PDT)
Received: from localhost.localdomain ([180.69.210.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106e7f2981sm667143b3a.0.2024.08.01.22.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 22:16:49 -0700 (PDT)
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
Subject: [PATCH v1 1/2] lib/htree: Implementation of new Hash Tree
Date: Fri,  2 Aug 2024 14:16:35 +0900
Message-Id: <20240802051635.8179-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

new Hash Tree Features
-------------------------------------------------------------------------------
* Very small hash tree structure. [16 Bytes]
* Dynamic memory allocation and free.
* Both 32-bit and 64-bit indexes are possible
* Generate hash keys uniformly based on the index.
* Hash trees are balanced by hash keys, and have no rotation costs.
* Standard deviation of hash key is 4 or less.
* Algorithm O(n) is depth(d) x nodes(c)
* Finding walks is (d x c), min:4, avg:12, max:20
* First hash table has smallest, largest index, algorithm O(1).
* The codes implementing of the algorithm is simple.
* Adjust hash tree depth according to system memory and index nr.
* Hash list nodes use include/linux/list.h, hlist as their base.
-------------------------------------------------------------------------------

Hash Tree Summary (include/linux/htree.h)
-------------------------------------------------------------------------------
 size of one hash tree struct: [16]Bytes
 size of one data struct: (40)Bytes
 size of middle: 32Bytes

 if system has 16GB memory, number of index(nr) is 256M(middle)
 if system has  4GB memory, number of index(nr) is  64M(middle)
 ...
 index max: 1 << 50: 2^50:   1P (  1P x 32:  32P) --> depth:6 (64bits index)
 index max: 1 << 40: 2^40:   1T (  1T x 32:  32T) --> depth:6 (64bits index)
 ...
 index max: 1 << 32: 2^32:   4G (  4G x 32: 128G) --> depth:5
 index max: 1 << 28: 2^29: 512M (512M x 32:  16G) --> depth:4 (32bits index)
 index max: 1 << 28: 2^28: 256M (256M x 32:   8G) --> depth:4
 index max: 1 << 26: 2^26:  64M ( 64M x 32:   2G) --> depth:3 (32bits index)
 index max: 1 << 25: 2^25:  32M ( 32M x 32:   1G) --> depth:2

 if number of index(nr) is between 32M and 64M, hash tree depth is [2,3)

 hash array size(anum): 1 << (sbit - depth)
 dnum: [d0:anum x d1:anum x d2:anum x d3:anum x d4:anum x d5:anum ...)

 if starting hash bit(sbit) is 9:
 dnum: [d0:512  x d1:256  x d2:128  x d3:64   x d4:32   x d5:16   ...)

 dcnt(max index): (d:dnum * HTREE_NODE_CNT): (dnum * 4)
     : d0:2K, d1:512K, d2:64M, d3:4G, d4:128G, d5:2T, ...

 asum(mid index): (d:dnum * HTREE_NODE_MIN): (dnum * 2)
     : d0:1K, d1:256K, d2:32M, d3:2G, d4: 64G, d5:1T, ...

 htree depth avg(d): (3)
 hlist node cnt(c) : [4)
 algorithm O(n)    : (d) x c == 3 x 4 == 12 (finding walks)
 memory efficiency : (dcnt / asum) == 85%(/100 == 0.85) (usage eff)

 htree depth(d):   0 ---->   1 ---->   2 ---->  3 ---->  4 ---->  5
 hash bits(b)  :   9 ---->   8 ---->   7 ---->  6 ---->  5 ---->  4
 table size(t) : 512 ----> 256 ----> 128 ----> 64 ----> 32 ----> 16

 d0:b9:t512
    +-----[4)--> d1:b8:t256
                    +-------> d2:b7:t128
                                 +-------> d3:b6:t64
                                              +------> d4:b5:t32
                                                          +------> d5:b4:t16

 if sort flag is HTREE_FLAG_ASCD, first htree depth(d0) has smallest index.
 if sort flag is HTREE_FLAG_DECD, first htree depth(d0) has largest index.
 hts->most has the hash key position, algorithm O(1).

 If there is the same index:
 if req is htf_ins, the new udata is inserted next to each other.
 if req is htf_erase, the new udata is inserted, and old udata is erased.

-------------------------------------------------------------------------------
Hash Tree API flow (lib/htree.c, lib/htree-test.c)
-------------------------------------------------------------------------------

*hts = ht_hts_alloc()           /* alloc hts */
ht_hts_clear_init(hts, ...)	/* max nr, type(32/64bits), sort(ASC, DES) */
*htree = ht_table_alloc(hts)    /* alloc first(depth:0) htree */

run_loop() {
	*udata = _data_alloc(index)             /* alloc udata */
	ht_insert(hts, htree, udata->hdata, ..)	/* working data with index */
	ht_erase(hts, htree, index)
	hdata = ht_find(hts, htree, index)
	hdata = ht_most_index(hts, htree)	/* smallest, largest index */
	ht_statis(hts, htree, ...)		/* statistic */
}

htree_erase_all(hts, htree)     /* remove all udata */
ht_destroy(hts, htree)          /* remove all htree */
kfree(hts)                      /* remove hts */

-------------------------------------------------------------------------------

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 include/linux/htree.h |  247 +++++++++
 lib/htree-test.c      | 1102 +++++++++++++++++++++++++++++++++++++++++
 lib/htree.c           |  634 ++++++++++++++++++++++++
 3 files changed, 1983 insertions(+)
 create mode 100644 include/linux/htree.h
 create mode 100644 lib/htree-test.c
 create mode 100644 lib/htree.c

diff --git a/include/linux/htree.h b/include/linux/htree.h
new file mode 100644
index 000000000000..c7b10c5b9bf2
--- /dev/null
+++ b/include/linux/htree.h
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Hash-Trees header
+ *  lib/htree.h
+ *
+ *  Copyright(C) 2024, JaeJoon Jung <rgbi3307@gmail.com> 
+ */
+
+#ifndef _LINUX_HTREE_H
+#define _LINUX_HTREE_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/hash.h>
+#include <linux/hashtable.h>
+#include <linux/slab.h>
+
+/*
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
+		    +-------> d2:b7:t128
+				 +-------> d3:b6:t64
+					      +------> d4:b5:t32
+							  +------> d5:b4:t16
+
+ if sort flag is HTREE_FLAG_ASCD, first htree depth(d0) has smallest index.
+ if sort flag is HTREE_FLAG_DECD, first htree depth(d0) has largest index.
+ hts->most has the hash key position, algorithm O(1).
+
+ If there is the same index:
+ if req is htf_ins, the new udata is inserted next to each other.
+ if req is htf_erase, the new udata is inserted, and old udata is erased.
+*/
+
+struct hash_tree {		/* *htree: hash tree struct */
+	struct hlist_head head;	/* head of hash list(include/linux/types.h) */
+	struct hash_tree *next;	/* next depth hash tree of this node */
+} __aligned(16);		/* size:16, must be aligned(2^4) */
+
+
+struct htree_data {		/* *hdata: to interface with data */
+	u64 index;		/* hash index to interface with hash key */
+	struct hlist_node hnode;/* hash list node(data) to connect udata */
+};
+
+
+struct htree_state {		/* *hts: hash tree state to operation */
+	s8  sbit;		/* start bits of hash table */
+	s8  dept;		/* depth[0...127] of hash tree */
+	s8  dmax;		/* max depth[0...127] of hash tree */
+	u16 hkey;		/* hash key */
+	u16 wcnt;		/* count of finding walk steps */
+	u16 most;		/* moset smallest or largest position */
+	s32 acnt;		/* global: count of hash table alloc */
+	u64 dcnt;		/* global: count of data alloc */
+	u64 asum;		/* global: sum of hash table slot(anum) */
+	u8  idxt: 1;		/* bit flag: index type [0:64bits, 1:32bits] */
+	u8  sort: 1;		/* bit flag: sort type [0:ascend. 1:descend] */
+} __packed;
+
+
+enum ht_flags {			/* htf: htree working flags (keep order) */
+	htf_none,
+	htf_ok,
+	htf_ins,		/* insert */
+	htf_find_lt,		/* find less than */
+	htf_find,		/* find */
+	htf_find_gt,		/* find grater than */
+	htf_move,
+	htf_update,
+	htf_erase,
+	htf_freed,
+};
+
+#define HTREE_BITS_START	8	/* start of hash bits(default) */
+#define HTREE_BITS_END		3	/* end of hash bits */
+#define HTREE_BITS_SHIFT	3	/* shift of hash bits */
+
+#define HTREE_NODE_MIN		2	/* node min in one slot of htree */
+#define HTREE_NODE_CNT		4	/* node count in one slot of htree */
+#define HTREE_NODE_MAX		6	/* node max(2^4 - 2) in one slot */
+
+#define HTREE_GOLDEN_NR		25
+
+/*
+ * htgr32: hash tree golden ratio for 32bits: Standard Deviation: sqrt(4)
+ */
+static const u32 htgr32[] = { GOLDEN_RATIO_32,
+	0x8864761C, 0x64761C6B, 0x864761C6, 0x761C6B07,
+	0x4761C6B0, 0x1C6B0718, 0x61C6B071, 0x6B0718E0,
+	0xC6B0718E, 0x0718E074, 0xB0718E07, 0x18E074B3,
+	0x718E074B, 0xE074B396, 0x8E074B39, 0x74B396CC,
+	0x074B396C, 0xB396CC6B, 0x4B396CC6, 0x96CC6B07,
+	0x396CC6B0, 0xCC6B0718, 0x6CC6B071, 0x1C88647E
+};
+
+/*
+ * htgr64: hash tree golden ratio for 64bits: Standard Deviation: sqrt(4)
+ */
+static const u64 htgr64[] = { GOLDEN_RATIO_64,
+	0xB481B860C486B468ull, 0x4080B581D962C816ull, 0x86C281B581B061D4ull,
+	0xCB64C8B64D80B283ull, 0xC680C584DB60C8A1ull, 0x0C8262682B5862B6ull,
+	0x4B2B61B82616801Cull, 0x5680D518CB61C0B1ull, 0x1584CB61C816468Cull,
+	0x0B280CB60B816D68ull, 0x64680B1938B62B18ull, 0x84B261B0864180B5ull,
+	0x8064680B0938B61Cull, 0x583CB61C4C64280Bull, 0x680B282DB6D1C864ull,
+	0x51864180B481AB4Dull, 0x2BB080CB64C8D6A1ull, 0xA24680B180CB61D9ull,
+	0xC82D4680B082CA61ull, 0x80B583A461C28646ull, 0x2C460C8064D80B58ull,
+	0xA5C461C8064680C2ull, 0x1864A80B583C26BCull, 0xCB583CB6E2806064ull
+};
+
+#define HTREE_HASH_KEY(idx, d, bits)	( sizeof(idx) <= 4 ?	\
+	(((u32)idx + d) * htgr32[d]) >> (32 - bits) : 		\
+	(((u64)idx + d) * htgr64[d]) >> (64 - bits) )
+
+#define HTREE_MAX_NCNT(dept)	\
+	((dept < HTREE_NODE_MIN) ? HTREE_NODE_CNT : HTREE_NODE_MAX)
+
+#define HTREE_ARRAY_SIZE(bits)		(1 << bits)
+#define HTREE_EFF_ASUM(asum)		(asum * HTREE_NODE_MIN)
+#define HTREE_EFFICIENCY(dcnt, asum)	((dcnt * 100) / HTREE_EFF_ASUM(asum))
+
+#define HTREE_IDX_BASIC_NR		(1 << 25)	/* default: 32M */
+
+/* flag bit in the htree_state struct */
+#define HTREE_FLAG_IDX64	0
+#define HTREE_FLAG_IDX32	1
+#define HTREE_FLAG_ASCD		0
+#define HTREE_FLAG_DECD		1
+
+/* node count [0...255] to set/get at htree->next */
+#define HTREE_NCNT_MASK		0xF
+
+static inline struct hash_tree *ht_ncnt_inc(struct hash_tree *ht, u8 ncnt)
+{
+	return (struct hash_tree *)((u64)ht + ncnt);
+}
+
+static inline struct hash_tree *ht_ncnt_dec(struct hash_tree *ht, u8 ncnt)
+{
+	return (struct hash_tree *)((u64)ht - ncnt);
+}
+
+static inline struct hash_tree *ht_ncnt_set(struct hash_tree *ht, u8 ncnt)
+{
+	return (struct hash_tree *)(((u64)ht & ~HTREE_NCNT_MASK) | ncnt);
+}
+
+static inline u8 ht_ncnt_get(struct hash_tree *ht)
+{
+	return (u8)((u64)ht & HTREE_NCNT_MASK);
+}
+
+static inline struct hash_tree *ht_ncnt_pointer(struct hash_tree *ht)
+{
+	return (struct hash_tree *)((u64)ht & ~HTREE_NCNT_MASK);
+}
+
+static inline u8 ht_bits_from_depth(s8 sbit, s8 depth)
+{
+	s8 diff;
+	diff = sbit - depth;
+	return (diff < HTREE_BITS_END) ? HTREE_BITS_END : diff;
+}
+
+static inline u16 ht_get_hkey(u64 index, s8 dept, u8 bits, u8 idxt)
+{
+	return (idxt == HTREE_FLAG_IDX32) ?
+		HTREE_HASH_KEY((u32)index, dept % HTREE_GOLDEN_NR, bits):
+		HTREE_HASH_KEY((u64)index, dept % HTREE_GOLDEN_NR, bits);
+}
+
+/**
+  * htree_add - add an object to a hashtree
+  * @hashtree: hashtree to add to
+  * @node: the &struct hlist_node of the object to be added
+  * @key: the hash key of the object to be added
+  */
+#define htree_add_head(hashtree, node, key)	\
+	hlist_add_head((struct hlist_node*)node, &hashtree[key].head)
+
+
+/* public functions in the lib/htree.c */
+struct hash_tree *ht_table_alloc(struct htree_state *hts);
+
+struct htree_state *ht_hts_alloc(void);
+
+void ht_hts_clear_init(struct htree_state *hts, u64 maxnr, u8 idxt, u8 sort);
+
+struct htree_data *ht_find(struct htree_state *hts, 
+			   struct hash_tree *htree, u64 index);
+
+struct htree_data *ht_insert(struct htree_state *hts, struct hash_tree *htree,
+			     struct htree_data *hdata, enum ht_flags htf_req);
+
+struct htree_data *ht_erase(struct htree_state *hts,
+			    struct hash_tree *htree, u64 index);
+
+enum ht_flags ht_destroy(struct htree_state *hts, struct hash_tree *htree);
+
+void ht_statis(struct htree_state *hts, struct hash_tree *htree,
+	       s32 *acnt, u64 *dcnt);
+
+struct htree_data *ht_most_index(struct htree_state *hts, 
+				 struct hash_tree *htree);
+
+
+#endif	/* _LINUX_HTREE_H */
diff --git a/lib/htree-test.c b/lib/htree-test.c
new file mode 100644
index 000000000000..05b60da271de
--- /dev/null
+++ b/lib/htree-test.c
@@ -0,0 +1,1102 @@
+﻿// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  htree/htree-api.c
+ *  Hash-Trees test codes to verify
+ *
+ *  Copyright(C) 2024, JaeJoon Jung <rgbi3307@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/random.h>
+#include <linux/sched.h>
+
+#include <linux/htree.h>
+
+/*
+	Hash Tree API flow
+	------------------
+
+	*hts = ht_hts_alloc()		//alloc hts
+	ht_hts_clear_init(hts, ...)
+
+	*htree = ht_table_alloc(hts)	//alloc first(depth:0) htree
+
+	run_loop() {
+
+		*udata = _data_alloc(index)		//alloc udata
+
+		ht_insert(hts, htree, udata->hdata, ..)
+		ht_erase(hts, htree, index)
+		hdata = ht_find(hts, htree, index)
+		hdata = ht_most_index(hts, htree)
+
+		ht_statis(hts, htree, ...)
+	}
+
+	htree_erase_all(hts, htree)	//remove all udata
+
+	ht_destroy(hts, htree)		//remove all htree
+
+	kfree(hts)			//remove hts
+*/
+
+
+/*
+#define HTREE_DEBUG_INFO
+#define HTREE_DEBUG_DETAIL
+*/
+
+#define pr_ht_err		pr_err
+#define pr_ht_warn		pr_warn
+#define pr_ht_stat		printk
+
+#ifdef HTREE_DEBUG_INFO
+#define pr_ht_info		printk
+
+#else
+#define pr_ht_info(fmt, ...)
+
+#endif
+
+#ifdef HTREE_DEBUG_DETAIL
+#define pr_ht_find		printk
+#define pr_ht_erase		printk
+#define pr_ht_update		printk
+#define pr_ht_debug		printk
+
+#else
+#define pr_ht_find(fmt, ...)
+#define pr_ht_erase(fmt, ...)
+#define pr_ht_update(fmt, ...)
+#define pr_ht_debug(fmt, ...)
+
+#endif
+
+#define HTREE_TEST_SCHED_CNT	200
+
+struct data_struct {
+	/* user defined data members ... */
+	char a;
+	int  b;
+	long c;
+
+	/* must be here to interface hash index */
+	struct htree_data hdata;
+};
+
+/**
+ * _htree_data_alloc - memory allocation of user data_struct
+ * @index: 64bits index to make hash key
+ *
+ * the hash key is created using the index and connected to the hash tree.
+ * udata is linked to the index(hash key) location.
+ *
+ * connection flow:
+ * udata <----> hdata <----> htree
+ * index(64bits): udata.hdata.index --> hash key --> hash table index(htree)
+ * data : udata.hdata.hnode --> htree.head --> hash list data nodes
+ */
+static struct data_struct *_htree_data_alloc(u64 index)
+{
+	struct data_struct *udata = (struct data_struct *)
+			kmalloc(sizeof(struct data_struct), GFP_KERNEL);
+
+	/* todo: set user defined data */
+	udata->a = 97;
+	udata->b = 98;
+	udata->c = 99;
+
+	/* interface with hash index (64bits) */
+	udata->hdata.index = index;
+
+	INIT_HLIST_NODE(&udata->hdata.hnode);
+
+	return udata;
+}
+
+/**
+ * _htree_test_hash_var - calculate the standard deviation of the hash key
+ * @bits: hash table size is (1 << bits)
+ * @vbits: for loop count
+ *
+ * ht_get_hkey distributes the hash keys using a golden ratio table.
+ */
+static void _htree_hash_dev(const u32 bits, const u32 vbits)
+{
+	u64 i, v, k;
+	s64 ka;
+	u64 ks, kas = 0;
+	const u16 kcnt = 1 << bits;
+	u32 *kc = (u32 *)kmalloc_array(kcnt, sizeof(u32), GFP_KERNEL);
+
+	const u32 vcnt = 1 << vbits;
+
+	for (v = 0; v < vcnt; v++) {
+		for (k = 0; k < kcnt; k++)
+			kc[k] = 0;
+
+		for (i = 0; i < HTREE_GOLDEN_NR; i++) {
+			k = ht_get_hkey(v, i, bits, HTREE_FLAG_IDX32);
+			kc[k]++;
+			k = ht_get_hkey(v, i, bits, HTREE_FLAG_IDX64);
+			kc[k]++;
+		}
+
+		ks = 0;
+		for (k = 0; k < kcnt; k++)
+			ks += kc[k];
+		ka = ks >> bits;	/* avg: ks / kcnt */
+		ks = 0;
+		for (k = 0; k < kcnt; k++)
+			ks += ((kc[k] - ka) * (kc[k] - ka));
+		ka = ks >> bits;	/* Variance: avg: ks / kcnt */
+		kas += ka;		/* sum of Variance */
+	}
+	/* Standard Deviation: sqrt(avg:kas) */
+	pr_ht_info("vbits:%u, cnt:%u, Standard Deviation:sqrt(%llu)\n\n",
+		   vbits, vcnt, (kas >> vbits) >> 2);
+	kfree(kc);
+}
+
+/**
+ * __htree_hash_key - outputs hash key distribution data
+ * @index: index to make hash key
+ * @bits: hash table size is (1 << bits)
+ */
+static void __htree_hash_key(u64 index, const u32 bits)
+{
+	u32 k, key0, key1, key2;
+	const u32 kcnt = 1 << bits;
+	u32 *kcnt0 = (u32*)kmalloc_array(kcnt, sizeof(u32), GFP_KERNEL);
+	u32 *kcnt1 = (u32*)kmalloc_array(kcnt, sizeof(u32), GFP_KERNEL);
+	u32 *kcnt2 = (u32*)kmalloc_array(kcnt, sizeof(u32), GFP_KERNEL);
+
+	for (k = 0; k < kcnt; k++) {
+		kcnt0[k] = 0;
+		kcnt1[k] = 0;
+		kcnt2[k] = 0;
+	}
+
+	key1 = index;
+	for (k = 0; k < HTREE_GOLDEN_NR; k++) {
+		key0 = hash_min(index, bits);
+		key1 = hash_min((u64)key1, bits);
+		kcnt0[key0]++;
+		kcnt1[key1]++;
+
+		key2 = ht_get_hkey(index, k, bits, HTREE_FLAG_IDX32);
+		kcnt2[key2]++;
+		key2 = ht_get_hkey(index, k, bits, HTREE_FLAG_IDX64);
+		kcnt2[key2]++;
+	}
+
+	key0 = 0;
+	key1 = 0;
+	key2 = 0;
+	for (k = 0; k < kcnt; k++) {
+		pr_ht_info("%3u: kcnt0:%6u, kcnt1:%6u, kcnt2:%6u\n",
+		       k, kcnt0[k], kcnt1[k], kcnt2[k]);
+		key0 += kcnt0[k];
+		key1 += kcnt1[k];
+		key2 += kcnt2[k];
+	}
+	pr_ht_info("----------------------------------------------\n");
+	pr_ht_info("sum: skey0:%6u, skey1:%6u, skey2:%6u\n", key0, key1, key2);
+
+	kfree(kcnt0);
+	kfree(kcnt1);
+	kfree(kcnt2);
+}
+
+/**
+ * _htree_hash_key - test of sample hash key
+ * @bits: hash table size is (1 << bits)
+ * @vbits: loop count in use sample index
+ *
+ * outputs hash key distribution data calculated from hash_min()
+ *      and ht_get_hkey using some indices.
+ */
+static void _htree_hash_key(const u32 bits, const u32 vbits)
+{
+	u64 v;
+	for (v = 0; v < vbits / 2; v++) {
+		pr_ht_info("value:%llu, bits:%u\n", v, bits);
+		pr_ht_info("----------------------------------------------\n");
+		__htree_hash_key(v, bits);
+		pr_ht_info("\n");
+	}
+}
+
+/**
+ * _htree_test_hash - hash key test
+ *
+ * output of hash key distribution
+ */
+static void _htree_test_hash(void)
+{
+	const u32 bits = 2;
+	const u32 vbits = 12;
+
+	_htree_hash_dev(bits, vbits);
+	_htree_hash_key(bits, vbits);
+}
+
+
+#ifdef HTREE_DEBUG_DETAIL
+
+/**
+ * htree_hdata_debug - shows hlist nodes in the hash tree at same index order.
+ * @htree: hash_tree to show
+ * @index: index to find
+ * @htf: ht_flags to confirm
+ */
+static void htree_debug_hdata(struct htree_state *hts, struct hash_tree *hcurr,
+			      u64 index, enum ht_flags htf)
+{
+	u8 ncnt, bits;
+	u16 key;
+	s16 dept;
+	u32 offset;
+	struct htree_data *pos;
+	struct hlist_node *tmp;
+	const char *htfs[] = {
+		"htf_none",
+		"htf_ok",
+		"htf_ins",
+		"htf_find_lt",
+		"htf_find",
+		"htf_find_gt",
+		"htf_move",
+		"htf_update",
+		"htf_erase",
+		"htf_freed",
+	};
+
+	if (!hcurr)
+		return;
+
+	dept = hts->dept;
+	pr_ht_debug("\n((%s)) DEBUG sbit:%u, dept:%d/%d, index:<%llu>\n",
+		    htfs[htf], hts->sbit, hts->dept, hts->dmax, index);
+	pr_ht_debug("-----------------------------------------------\n");
+	bits = ht_bits_from_depth(hts->sbit, dept);
+	key = ht_get_hkey(index, dept, bits, hts->idxt);
+__next:
+	ncnt = ht_ncnt_get(hcurr->next);
+
+	pr_ht_debug("d:%d b:%u [%u] %p(%u): ", dept, bits, key, hcurr, ncnt);
+	offset = 0;
+	hlist_for_each_entry_safe(pos, tmp, &hcurr->head, hnode) {
+		if (pos->index == index) {
+			pr_ht_debug("%u:%llu(@) FOUND.", offset, pos->index);
+		} else {
+			pr_ht_debug("%u:%llu> ", offset, pos->index);
+		}
+		offset++;
+	}
+	pr_ht_debug("\n");
+
+	hcurr = ht_ncnt_pointer(hcurr->next);
+	if (hcurr) {
+		dept++;
+		bits = ht_bits_from_depth(hts->sbit, dept);
+		key = ht_get_hkey(index, dept, bits, hts->idxt);
+		hcurr = &hcurr[key];
+		goto __next;
+	}
+}
+
+/**
+ * __htree_debug_walks_all - private call recursively to show all indexes
+ * @hts: htree_state pointer
+ * @htree: hash_tree root pointer
+ * @index: index to find
+ */
+static void __htree_debug_walks_all(struct htree_state *hts,
+				    struct hash_tree *htree, u64 index)
+{
+	u8 bits, ncnt;
+	u16 k, anum, pnum;
+	struct hash_tree *_next;
+	struct htree_data *hdata;
+	struct hlist_node *tmp;
+
+	bits = ht_bits_from_depth(hts->sbit, hts->dept);
+	anum = HTREE_ARRAY_SIZE(bits);
+
+	for (k = 0; k < anum; k++) {
+		ncnt = ht_ncnt_get(htree[k].next);
+		if (ncnt > 0) {
+			bits = ht_bits_from_depth(hts->sbit, hts->dept);
+			pr_ht_debug("d:%u b:%u [%u] %p (%u): ",
+				    hts->dept, bits, k, &htree[k], ncnt);
+
+			hlist_for_each_entry_safe(hdata, tmp, 
+						  &htree[k].head, hnode) {
+				if (hdata->index == index) {
+					pr_ht_debug("< ((%llu)) ", hdata->index);
+				} else {
+					pr_ht_debug("< %llu ", hdata->index);
+				}
+			}
+		}
+		_next = ht_ncnt_pointer(htree[k].next);
+		if (_next) {
+			pr_ht_debug(">>\n");
+			hts->dept++;
+			pnum = anum;
+			/* recursive call */
+			__htree_debug_walks_all(hts, _next, index);
+			anum = pnum;
+			hts->dept--;
+		} else {
+			pr_ht_debug("\n%u]] ", k);
+			continue;
+		}
+		pr_ht_debug(".\n\n");
+	}
+}
+
+/**
+ * htree_walks_all_debug - display to debug all indexes
+ * @hts: htree_state pointer
+ * @htree: hash_tree root pointer
+ * @index: index to find
+ *
+ * this function cycles through all hash tables and outputs all indexes.
+ */
+static void htree_debug_walks_all(struct htree_state *hts,
+				  struct hash_tree *htree, u64 index)
+{
+	pr_ht_debug("[@@@@) walking: sbit:%u, dmax:%u, acnt:%d, dcnt:%llu\n\n",
+		    hts->sbit, hts->dmax, hts->acnt, hts->dcnt);
+
+	hts->dept = 0;
+	__htree_debug_walks_all(hts, htree, index);
+
+	pr_ht_debug("(@@@@] done: sbit:%u, dmax:%u, acnt:%d, dcnt:%llu\n\n",
+		    hts->sbit, hts->dmax, hts->acnt, hts->dcnt);
+}
+#endif	/* HTREE_DEBUG_DETAIL */
+
+/**
+ * __htree_erase_all - erase udata all
+ * @hts: htree_state pointer
+ * @htree: hash_tree root pointer
+ * @erased: erased udata count
+ *
+ * this function cycles through all hash tables and erase udata all
+ */
+static void __htree_erase_all(struct htree_state *hts,
+			     struct hash_tree *htree, u64 *erased)
+{
+	u8 bits, ncnt;
+	u16 k, anum, pnum;
+	struct hash_tree *_next;
+	struct htree_data *pos;
+	struct hlist_node *tmp;
+	struct data_struct *udata;
+
+	bits = ht_bits_from_depth(hts->sbit, hts->dept);
+	anum = HTREE_ARRAY_SIZE(bits);
+
+	for (k = 0; k < anum; k++) {
+		ncnt = ht_ncnt_get(htree[k].next);
+		if (ncnt > 0) {
+			bits = ht_bits_from_depth(hts->sbit, hts->dept);
+			hlist_for_each_entry_safe(pos, tmp,
+						  &htree[k].head, hnode) {
+				hlist_del(&pos->hnode);
+				udata = hlist_entry_safe(pos, 
+						struct data_struct, hdata);
+				if (udata) {
+					kfree(udata);
+					(*erased)++;
+				}
+			}
+		}
+		_next = ht_ncnt_pointer(htree[k].next);
+		if (_next) {
+			hts->dept++;
+			pnum = anum;
+			/* recursive call */
+			__htree_erase_all(hts, _next, erased);
+			anum = pnum;
+			hts->dept--;
+		} else {
+			continue;
+		}
+	}
+}
+
+/**
+ * htree_erase_all -  erase udata all
+ * @hts: htree_state pointer
+ * @htree: hash_tree root pointer
+ *
+ * return: erased all udata count
+ */
+static u64 htree_erase_all(struct htree_state *hts, struct hash_tree *htree)
+{
+	u64 erased = 0;
+
+	pr_ht_info("[~~~~) erase all: sbit:%u, dmax:%u, acnt:%d, dcnt:%llu\n",
+		   hts->sbit, hts->dmax, hts->acnt, hts->dcnt);
+
+	hts->dept = 0;
+	__htree_erase_all(hts, htree, &erased);
+
+	pr_ht_info("(~~~~] done: sbit:%u, acnt:%d, dcnt:%llu, erased:%llu\n\n",
+		   hts->sbit, hts->acnt, hts->dcnt, erased);
+
+	return erased;
+}
+
+/**
+ * _htree_insert_range - insert udata to hash tree using ht_insert()
+ * @hts: htree_state pointer
+ * @htree: hash_tree root pointer
+ * @start: start index to insert
+ * @end: end index to insert
+ * @gap: gap between indices
+ * @req: request flags
+ *
+ * If there is the same index:
+ * if req is htf_ins, the new udata is inserted next to each other.
+ * if req is htf_erase, the new udata is inserted, and old udata is erased.
+ */
+static u64 _htree_insert_range(struct htree_state *hts, struct hash_tree *htree,
+			       u64 start, u64 end, u64 gap, enum ht_flags req)
+{
+	u64 index;
+	u64 loop = 0, ins = 0, era = 0;
+	struct data_struct *udata;
+	struct htree_data *rdata;
+
+	pr_ht_info("[++++) inserting: [s:%llu ... e:%llu] (g:%llu)\n",
+		   start, end, gap);
+	for (index = start; index <= end; index += gap) {
+		udata = _htree_data_alloc(index);
+		rdata = ht_insert(hts, htree, &udata->hdata, req);
+		if (req == htf_erase && rdata) {
+			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
+			if (udata && rdata->index == index) {
+				kfree(udata);
+				era++;
+			}
+		}
+		ins++;
+		loop++;
+		if (!(loop % HTREE_TEST_SCHED_CNT))
+			schedule();
+	}
+	pr_ht_info("(++++] done: loop:%llu, inserted:%llu, same erased:%llu\n\n",
+		   loop, ins, era);
+
+	return ins - era;
+}
+
+/**
+ * _htree_find_range - find udata in the hash tree using ht_find()
+ * @hts: htree_state pointer
+ * @htree: hash_tree root pointer
+ * @start: start index to find
+ * @end: end index to find
+ * @gap: gap between indices
+ */
+static u64 _htree_find_range(struct htree_state *hts, struct hash_tree *htree,
+			     u64 start, u64 end, u64 gap)
+{
+	u64 index;
+	u64 loop = 0, found = 0;
+	struct data_struct *udata;
+	struct htree_data *rdata;
+
+	pr_ht_info("[****) finding: [s:%llu ... e:%llu] (g:%llu)\n",
+		   start, end, gap);
+	for (index = start; index <= end; index += gap) {
+		rdata = ht_find(hts, htree, index);
+		if (rdata) {
+			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
+			if (udata && rdata->index == index) {
+				pr_ht_find("*todo: find:<%llu> %c %c %c\n",
+				index, udata->a, (char)udata->b, (char)udata->c);
+				found++;
+			}
+		}
+		loop++;
+		if (!(loop % HTREE_TEST_SCHED_CNT))
+			schedule();
+	}
+	pr_ht_info("(****] done: loop:%llu, found:%llu, diff:%llu\n\n",
+		   loop, found, loop - found);
+	return found;
+}
+
+/**
+ * _htree_erase_range - erase udata from hash tree using ht_erase()
+ * @hts: htree_state pointer
+ * @htree: hash_tree root pointer
+ * @start: start index to erase
+ * @end: end index to erase
+ * @gap: gap between indices
+ */
+static u64 _htree_erase_range(struct htree_state *hts, struct hash_tree *htree,
+			      u64 start, u64 end, u64 gap)
+{
+	u64 index;
+	u64 loop = 0, erased = 0;
+	struct data_struct *udata;
+	struct htree_data *rdata;
+
+	pr_ht_info("[----) erasing: [s:%llu ... e:%llu] (g:%llu)\n",
+		   start, end, gap);
+	for (index = start; index <= end; index += gap) {
+		rdata = ht_erase(hts, htree, index);
+		if (rdata) {
+			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
+			if (udata && rdata->index == index) {
+				pr_ht_erase("*todo: erase:<%llu> %c %c %c\n",
+				index, udata->a, (char)udata->b, (char)udata->c);
+				kfree(udata);
+				erased++;
+			}
+#ifdef HTREE_DEBUG_DETAIL
+		} else {
+			hts->hkey = ht_get_hkey(index, 0, hts->sbit, hts->idxt);
+			htree_debug_hdata(hts, &htree[hts->hkey], index, htf_erase);
+#endif
+		}
+		loop++;
+		if (!(loop % HTREE_TEST_SCHED_CNT))
+			schedule();
+	}
+	pr_ht_info("(----] done: loop:%llu, erased:%llu, diff:%llu\n\n",
+		   loop, erased, loop - erased);
+	return erased;
+}
+
+/**
+ * _htree_update_range - update udata in the hash tree using ft_find()
+ * @hts: htree_state pointer
+ * @htree: hash_tree root pointer
+ * @start: start index to update
+ * @end: end index to update
+ * @gap: gap between indices
+ */
+static u64 _htree_update_range(struct htree_state *hts, struct hash_tree *htree,
+			u64 start, u64 end, u64 gap)
+{
+	u64 index;
+	u64 loop = 0, updated = 0;
+	struct data_struct *udata;
+	struct htree_data *rdata;
+
+	pr_ht_info("[####) updating: [s:%llu ... e:%llu] (g:%llu)\n",
+		   start, end, gap);
+	for (index = start; index <= end; index += gap) {
+		rdata = ht_find(hts, htree, index);
+		if (rdata) {
+			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
+			if (udata && rdata->index == index) {
+				pr_ht_update("*todo: update:<%llu> %c %c %c ",
+				index, udata->a, (char)udata->b, (char)udata->c);
+				/* todo: update user defined data */
+				udata->a -= 32;
+				udata->b -= 32;
+				udata->c -= 32;
+
+				pr_ht_update(">> %c %c %c\n",
+					udata->a, (char)udata->b, (char)udata->c);
+				updated++;
+			}
+#ifdef HTREE_DEBUG_DETAIL
+		} else {
+			hts->hkey = ht_get_hkey(index, 0, hts->sbit, hts->idxt);
+			htree_debug_hdata(hts, &htree[hts->hkey], index, htf_update);
+#endif
+		}
+		loop++;
+		if (!(loop % HTREE_TEST_SCHED_CNT))
+			schedule();
+	}
+	pr_ht_info("(####] done: loop:%llu, updated:%llu, diff:%llu\n\n",
+		   loop, updated, loop - updated);
+
+	return updated;
+}
+
+/**
+ * _htree_statis - calculate hash tree statistics and get into hts.
+ * @hts: htree_state pointer to store statistics
+ * @htree: hash_tree root pointer
+ */
+static void _htree_statis(struct htree_state *hts, struct hash_tree *htree)
+{
+	s32 acnt = 0;
+	u64 dcnt = 0;
+
+	ht_statis(hts, htree, &acnt, &dcnt);
+
+	if (hts->dcnt == dcnt && hts->acnt == acnt) {
+		pr_ht_info("[ OK ] statist: acnt:%d, dcnt:%llu ", acnt, dcnt);
+	} else {
+		pr_ht_info("[FAIL] statist: acnt:%d(%d), dcnt:%llu(%llu)\n",
+			  acnt, hts->acnt, dcnt, hts->dcnt);
+	}
+	pr_ht_info(">> asum:%llu, eff:%llu(/100)\n\n",
+		   hts->asum, HTREE_EFFICIENCY(hts->dcnt, hts->asum));
+}
+
+/**
+ * _htree_statis_info - shows information calculated by htree_statis().
+ */
+static void _htree_statis_info(struct htree_state *hts, struct hash_tree *htree)
+{
+	u32 sizh = sizeof(struct hash_tree);
+	u32 sizd = sizeof(struct data_struct);
+
+	/* total data slot of full hash table area */
+	u64 hsum = (sizh * hts->acnt) >> 10;
+	u64 dsum = (sizd * hts->dcnt) >> 10;
+	u64 smem = hsum + dsum;
+
+	if (hts->asum == 0)
+		_htree_statis(hts, htree);
+
+	pr_ht_stat("------------------------------------------\n");
+	pr_ht_stat(" hash start bits(sbit) :       %10d\n", hts->sbit);
+	pr_ht_stat(" hash tree max depth   :       %10u\n", hts->dmax);
+	pr_ht_stat(" finding walks(wcnt)   :       %10u\n", hts->wcnt);
+	pr_ht_stat(" user data alloc(dcnt) : %16llu\n",     hts->dcnt);
+	pr_ht_stat(" hash tree alloc(acnt) :       %10d\n", hts->acnt);
+	pr_ht_stat(" hash tree sum(asum)   : %16llu\n",     hts->asum);
+	pr_ht_stat(" htree nodes sum(stot) : %16llu\n",
+						HTREE_EFF_ASUM(hts->asum));
+	pr_ht_info(" hlist node cnt(ncnt)  :       %10d\n", HTREE_NODE_CNT);
+	pr_ht_info(" sizeof hash_tree(B)   :       %10u\n", sizh);
+	pr_ht_info(" sizeof data_struct(B) :       %10u\n", sizd);
+	pr_ht_info(" hash using mem(KB)    : %16llu\n",     hsum);
+	pr_ht_info(" data using mem(KB)    : %16llu\n",	    dsum);
+	pr_ht_stat(" total using mem(KB)   : %16llu\n",     smem);
+	pr_ht_stat("------------------------------------------\n");
+	pr_ht_stat(" efficiency(dcnt/stot) :   %8llu(/100)\n",
+				HTREE_EFFICIENCY(hts->dcnt, hts->asum));
+	pr_ht_stat("------------------------------------------\n\n");
+}
+
+/**
+ * _htree_get_most_index - get most smallest and largest index
+ *
+ * if sort flag is HTREE_FLAG_ASCD, root hash table has the smallest index.
+ * if sort flag is HTREE_FLAG_DECD, root hash table has the largest index.
+ */
+static void _htree_get_most_index(struct htree_state *hts, struct hash_tree *htree)
+{
+	struct htree_data *hdata;
+	hdata = ht_most_index(hts, htree);
+	if (hdata) {
+		if (hts->sort == HTREE_FLAG_ASCD) {
+			pr_ht_stat("[MOST] smallest index:%llu\n\n", hdata->index);
+		} else {
+			pr_ht_stat("[MOST] largest index:%llu\n\n", hdata->index);
+		}
+	}
+}
+
+/**
+ * _htree_remove_all - remove all udata and hash trees
+ *
+ * before run ht_destroy(), the udata must be erased all.
+ * ht_destroy() removes all hash trees, but it does not remove the udata.
+ */
+static void _htree_remove_all(struct htree_state *hts, struct hash_tree *htree)
+{
+	/* remove all udata */
+	hts->dcnt -= htree_erase_all(hts, htree);
+	if (hts->dcnt != 0) {
+		pr_ht_warn("[WARN] erase remained acnt:%d, dcnt:%llu\n\n",
+			   hts->acnt, hts->dcnt);
+	}
+
+	/* remove all hash trees */
+	if (ht_destroy(hts, htree) == htf_ok) {
+		pr_ht_stat("[ OK ] destroy remained acnt:%d, dcnt:%llu\n\n",
+			   hts->acnt, hts->dcnt);
+	} else {
+		pr_ht_warn("[WARN] destroy remained acnt:%d, dcnt:%llu\n\n",
+			   hts->acnt, hts->dcnt);
+	}
+}
+
+/**
+ * _htree_test_index_loop - main test loop
+ * @hts: htree_state pointer
+ * @start: starting index to test
+ * @end: ending index to test
+ *
+ * return: dcnt: index(data) working count
+ *
+ * testing flow:
+ *      insert --> erase,find --> insert,update --> statistic --> free,destroy
+ */
+static u64 _htree_test_index_loop(struct htree_state *hts, u64 start, u64 end)
+{
+	struct hash_tree *htree;
+	u64 inserted, found, erased, updated;
+	u64 dcnt, slice;
+
+	if (start > end)
+		return 0;
+	slice = (end - start) / 10 + 2;
+
+	/* first root hash tree alloc */
+	htree = ht_table_alloc(hts);
+
+	inserted = _htree_insert_range(hts, htree, start, end, 1, htf_ins);
+	if (inserted != hts->dcnt) {
+		pr_ht_err("[FAIL] inserted:%llu, dcnt:%llu, diff:%lld\n\n",
+			  inserted, hts->dcnt, inserted - hts->dcnt);
+	}
+
+	_htree_statis(hts, htree);
+
+	erased = _htree_erase_range(hts, htree, start, end, slice);
+	found = _htree_find_range(hts, htree, start, end, slice);
+	if (found) {
+		pr_ht_err("[FAIL] erased:%llu, found:%llu, diff:%lld\n\n",
+			  erased, found, erased - found);
+	}
+
+	_htree_statis(hts, htree);
+
+	inserted = _htree_insert_range(hts, htree, start, end, slice, htf_ins);
+	updated = _htree_update_range(hts, htree, start, end, slice);
+	if (inserted != updated) {
+		pr_ht_err("[FAIL] inserted:%llu, updated:%llu, diff:%lld\n\n",
+			  inserted, updated, inserted - updated);
+	}
+
+	_htree_statis(hts, htree);
+	_htree_get_most_index(hts, htree);
+
+#ifdef HTREE_DEBUG_DETAIL
+	htree_debug_walks_all(hts, htree, 0);
+#endif
+	_htree_statis_info(hts, htree);
+	dcnt = hts->dcnt;
+
+	_htree_remove_all(hts, htree);
+
+	return dcnt;
+}
+
+/**
+ * _htree_test_idx_range - index test of 32bits/64bits, ascending/descending
+ * @idx_type: hts->idxt: index type [0:64bits, 1:32bits]
+ * @sort_type: hts->sort: sorting type [0:ascending, 1:descending]
+ *
+ * Importance: must be use the ht_hts_clear_init() to adjust htree depth.
+ *
+ * hash array size(anum): 1 << (sbit - depth)
+ * dnum: [d0:anum x d1:anum x d2:anum x d3:anum x d4:anum x d5:anum ...)
+ *
+ * number of index(nr) is between 32M and 64M, and hash tree depth is [2,3)
+ *
+ * htree depth avg(d): (3)
+ * hlist node cnt(c) : [4)
+ * efficiency O(n)   : (d) x c == 3 x 4 == 12 (finding walks)
+ * using memory eff  : (dcnt / asum) == 85%(/100 == 0.85)
+ *
+ * you can test by changing start, end with 32bits or 64bits data type.
+ * Be careful:  if system has 4GB memory:
+ * 		if (index nr > 128M) then depth > 3, out of memory(OOM)
+ */
+static void _htree_test_idx_range(u8 idx_type, u8 sort_type)
+{
+	u64 start, end, maxnr;
+	u64 idx, dcnt, eff = 0;
+	u32 wcnt = 0;
+	const u8 loopnr = 14;
+	const u32 v1k = 1 << 10;
+	const u64 v1t = (u64)1 << 40;
+	const char *idxts[] = {	"64bits", "32bits" };
+	const char *sorts[] = {	"ASCD", "DECD" };
+
+	struct htree_state *hts = ht_hts_alloc();
+
+	for (idx = 1; idx <= loopnr; idx++) {
+		pr_ht_stat("[START) RANGE(insert, erase, find, update) \
+index type:<%s>, sorting type:<%s>\n", idxts[idx_type], sorts[sort_type]);
+
+		start = (idx_type == HTREE_FLAG_IDX32) ? idx * v1k : idx * v1t;
+		end = start + (1 << idx) * v1k;
+		maxnr = end - start + 1;
+
+		/* setting hash tree depth, index type and sorting type */
+		ht_hts_clear_init(hts, maxnr, idx_type, sort_type);
+
+		pr_ht_stat(
+		"[loop) %llu: sbit:%u, start:%llu, end:%llu, maxnr:%llu\n\n",
+					idx, hts->sbit, start, end, maxnr);
+
+		dcnt = _htree_test_index_loop(hts, start, end);
+		eff += HTREE_EFFICIENCY(dcnt, hts->asum);
+		wcnt += hts->wcnt;
+	}
+	/*
+	 * loopnr:14(16M) 32bits: ascending  efficiency avg: 85/100, wcnt: 9
+	 * loopnr:14(16M) 32bits: descending efficiency avg: 85/100, wcnt: 8
+	 *
+	 * loopnr:14(16M) 64bits: ascending  efficiency avg: 97/100, wcnt:10
+	 * loopnr:14(16M) 64bits: descending efficiency avg: 97/100, wcnt: 7
+	 */
+	pr_ht_stat("=======================================================\n");
+	pr_ht_stat("( END] RANGE index type:<%s>, sorting type:<%s>\n",
+		   idxts[idx_type], sorts[sort_type]);
+	pr_ht_stat("( EFF] loop:%u, efficiency avg:%llu(/100), wcnt:(%u)\n\n",
+		   loopnr, eff / loopnr, wcnt / loopnr);
+	kfree(hts);
+}
+
+/**
+ * _htree_test_idx_random - random index test
+ * @idx_type: hts->idxt: index type [0:64bits, 1:32bits]
+ * @sort_type: hts->sort: sorting type [0:ascending, 1:descending]
+ * @maxnr: max number of index
+ *
+ * testing flow:
+ * 	random index --> ht_insert() --> ht_erase() --> statis info --> free all
+ */
+static void _htree_test_idx_random(u8 idx_type, u8 sort_type, u64 maxnr)
+{
+	u64 i, index;
+	struct hash_tree *htree;
+	struct data_struct *udata;
+	struct htree_data *rdata;
+	u64 loop = 0, inserted = 0, erased = 0;
+	const char *idxts[] = {	"64bits", "32bits" };
+	const char *sorts[] = {	"ASCD", "DECD" };
+	const u64 check_idx = 25203307;
+
+	struct htree_state *hts = ht_hts_alloc();
+
+	/* setting hash tree depth, index type and sorting type */
+	ht_hts_clear_init(hts, maxnr, idx_type, sort_type);
+
+	/* first root hash tree alloc */
+	htree = ht_table_alloc(hts);
+
+	pr_ht_stat("[START) RANDOM: sbit:%u, index type:<%s>, sorting type:<%s>\n\n",
+		   hts->sbit, idxts[idx_type], sorts[sort_type]);
+
+	udata = _htree_data_alloc(check_idx);
+	rdata = ht_insert(hts, htree, &udata->hdata, htf_ins);
+	inserted++;
+	loop++;
+
+	pr_ht_stat("[loop) %llu: random insert\n\n", maxnr);
+	for (i = 0; i < maxnr; i++) {
+		index = (idx_type == HTREE_FLAG_IDX32) ? 
+			get_random_u32() : get_random_u64();
+
+		udata = _htree_data_alloc(index);
+		rdata = ht_insert(hts, htree, &udata->hdata, htf_ins);
+		if (!rdata)
+			inserted++;
+		loop++;
+		if (!(loop % HTREE_TEST_SCHED_CNT))
+			schedule();
+	}
+
+	_htree_statis(hts, htree);
+
+	rdata = ht_find(hts, htree, check_idx);
+	if (!rdata) {
+		pr_ht_err("[FAIL] NOT found check index:%llu\n\n", check_idx);
+	}
+
+	maxnr *= 2;
+	pr_ht_stat("[loop) %llu: random erase\n\n", maxnr);
+	for (i = 0; i < maxnr; i++) {
+		index = (idx_type == HTREE_FLAG_IDX32) ? 
+			get_random_u32() : get_random_u64();
+
+		rdata = ht_erase(hts, htree, index);
+		if (rdata) {
+			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
+			if (udata && rdata->index == index) {
+				pr_ht_erase("*todo: erase:<%llu> %c %c %c\n",
+				index, udata->a, (char)udata->b, (char)udata->c);
+				kfree(udata);
+				erased++;
+			}
+		}
+		loop++;
+		if (!(loop % HTREE_TEST_SCHED_CNT))
+			schedule();
+	}
+
+	_htree_statis(hts, htree);
+
+	rdata = ht_find(hts, htree, check_idx);
+	if (!rdata) {
+		pr_ht_info("[INFO] check index:%llu (erased)\n\n", check_idx);
+	}
+
+	pr_ht_stat("( END] RANDOM loop:%llu, inserted:%llu, erased:%llu\n\n",
+		   loop, inserted, erased);
+
+#ifdef HTREE_DEBUG_DETAIL
+	htree_debug_walks_all(hts, htree, 0);
+#endif
+
+	_htree_get_most_index(hts, htree);
+	_htree_statis_info(hts, htree);
+
+	_htree_remove_all(hts, htree);
+
+	kfree(hts);
+}
+
+/**
+ * _htree_test_index_same - same index test
+ * @idx_type: hts->idxt: index type [0:64bits, 1:32bits]
+ * @sort_type: hts->sort: sorting type [0:ascending, 1:descending]
+ * @maxnr: max number of index
+ *
+ * If there is the same index:
+ * if req is htf_ins, the new udata is inserted next to each other.
+ * if req is htf_erase, the new udata is inserted, and old udata is erased.
+ *
+ * testing flow:
+ * 	new index --> ht_insert() --> same index --> ht_insert() --> statis info
+ */
+static void _htree_test_index_same(u8 idx_type, u8 sort_type, u64 maxnr)
+{
+	struct hash_tree *htree;
+	u64 inserted, found;
+	const char *idxts[] = {	"64bits", "32bits" };
+	const char *sorts[] = {	"ASCD", "DECD" };
+	const u32 gap = 2;
+
+	struct htree_state *hts = ht_hts_alloc();
+
+	/* setting hash tree depth, index type and sorting type */
+	ht_hts_clear_init(hts, maxnr, idx_type, sort_type);
+
+	/* first root hash tree alloc */
+	htree = ht_table_alloc(hts);
+
+	pr_ht_stat("[START) SAME: sbit:%u, index type:<%s>, sorting type:<%s>\n\n",
+		   hts->sbit, idxts[idx_type], sorts[sort_type]);
+
+	pr_ht_stat("[loop) %llu: new index inserting(htf_ins)\n\n", maxnr);
+	inserted = _htree_insert_range(hts, htree, 0, maxnr, gap - 1, htf_ins);
+	if (inserted != hts->dcnt) {
+		pr_ht_err("[FAIL] inserted:%llu, dcnt:%llu, diff:%lld\n\n",
+			  inserted, hts->dcnt, inserted - hts->dcnt);
+	}
+
+	_htree_statis(hts, htree);
+
+	pr_ht_stat("[loop) %llu: SAME index inserting(htf_erase)\n\n", maxnr);
+	inserted = _htree_insert_range(hts, htree, 1, maxnr, gap, htf_erase);
+	if (inserted != 0) {
+		pr_ht_err("[FAIL] inserted:%llu, dcnt:%llu, diff:%lld\n\n",
+			  inserted, hts->dcnt, inserted - hts->dcnt);
+	}
+
+	pr_ht_stat("[loop) %llu: SAME index inserting(htf_ins)\n\n", maxnr);
+	inserted = _htree_insert_range(hts, htree, 1, maxnr, gap, htf_ins);
+	if (inserted != (maxnr / gap)) {
+		pr_ht_err("[FAIL] inserted:%llu, dcnt:%llu, diff:%lld\n\n",
+			  inserted, hts->dcnt, inserted - hts->dcnt);
+	}
+
+	found = _htree_find_range(hts, htree, 0, maxnr, gap - 1);
+	if (found != (hts->dcnt - inserted)) {
+		pr_ht_err("[FAIL] dcnt:%llu, inserted:%llu, found:%llu\n\n",
+			  hts->dcnt, inserted, found);
+	}
+
+	_htree_statis(hts, htree);
+
+#ifdef HTREE_DEBUG_DETAIL
+	htree_debug_walks_all(hts, htree, 0);
+#endif
+	_htree_get_most_index(hts, htree);
+	_htree_statis_info(hts, htree);
+
+	_htree_remove_all(hts, htree);
+
+	kfree(hts);
+}
+
+#ifdef HTREE_DEBUG_DETAIL
+/**
+ * _htree_test_index_debug - simple index test on debug mode
+ *
+ * show detailed hash tree information
+ */
+static void htree_debug_index(void)
+{
+	struct htree_state *hts = ht_hts_alloc();
+
+	ht_hts_clear_init(hts, 32, HTREE_FLAG_IDX64, HTREE_FLAG_DECD);
+	_htree_test_index_loop(hts, 0,  32);
+
+	ht_hts_clear_init(hts, 32, HTREE_FLAG_IDX32, HTREE_FLAG_ASCD);
+	_htree_test_index_loop(hts, 0, 32);
+
+	_htree_test_idx_random(HTREE_FLAG_IDX64, HTREE_FLAG_ASCD, 32);
+	_htree_test_idx_random(HTREE_FLAG_IDX32, HTREE_FLAG_DECD, 32);
+
+	_htree_test_index_same(HTREE_FLAG_IDX64, HTREE_FLAG_ASCD, 32);
+	_htree_test_index_same(HTREE_FLAG_IDX32, HTREE_FLAG_DECD, 32);
+
+	kfree(hts);
+}
+#endif
+
+static int __init htree_test_init(void)
+{
+	const u64 v1m = 1 << 20;
+
+	_htree_test_hash();
+
+#ifdef HTREE_DEBUG_DETAIL
+	htree_debug_index();
+	return 0;
+#endif
+
+	/* range(insert, erase, find, update) index testing */
+	_htree_test_idx_range(HTREE_FLAG_IDX64, HTREE_FLAG_ASCD);
+	_htree_test_idx_range(HTREE_FLAG_IDX64, HTREE_FLAG_DECD);
+
+	_htree_test_idx_range(HTREE_FLAG_IDX32, HTREE_FLAG_ASCD);
+	_htree_test_idx_range(HTREE_FLAG_IDX32, HTREE_FLAG_DECD);
+
+	/* random index testing */
+	_htree_test_idx_random(HTREE_FLAG_IDX64, HTREE_FLAG_DECD, v1m);
+	_htree_test_idx_random(HTREE_FLAG_IDX32, HTREE_FLAG_ASCD, v1m);
+
+	/* same index testing */
+	_htree_test_index_same(HTREE_FLAG_IDX64, HTREE_FLAG_ASCD, v1m);
+	_htree_test_index_same(HTREE_FLAG_IDX32, HTREE_FLAG_DECD, v1m);
+
+	return 0;
+}
+
+static void __exit htree_test_exit(void)
+{
+	pr_info("htree test exit.\n");
+}
+
+module_init(htree_test_init)
+module_exit(htree_test_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("JaeJoon Jung <rgbi3307@gmail.com>");
+MODULE_DESCRIPTION("Hash Tree Test");
diff --git a/lib/htree.c b/lib/htree.c
new file mode 100644
index 000000000000..be7b34b5d4e1
--- /dev/null
+++ b/lib/htree.c
@@ -0,0 +1,634 @@
+﻿// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Hash-Trees implementation
+ *  lib/htree.c
+ *
+ *  Copyright(C) 2024, JaeJoon Jung <rgbi3307@gmail.com>
+ */
+
+#include <linux/htree.h>
+
+/**
+ * ht_table_alloc - memory allocation of hash table
+ * @hts: hts->acnt increase
+ * return: htree: allocated memory pointer
+ *
+ * hash bits is calculated using the ht_bits_from_depth()
+ *      that is important to decision the depth of hash tree.
+ * hts->sbit is determined in the _ht_hts_get_sbit() function
+ *      in proportion to the total number of indexes.
+ * hash array(table) size is (1 << bits).
+ */
+struct hash_tree *ht_table_alloc(struct htree_state *hts)
+{
+	u8 bits;
+	u16 k, anum;
+	struct hash_tree *htree;
+
+	bits = ht_bits_from_depth(hts->sbit, hts->dept);
+	anum = HTREE_ARRAY_SIZE(bits);
+	htree = (struct hash_tree *)
+		kmalloc_array(anum, sizeof(struct hash_tree), GFP_KERNEL);
+
+	for (k = 0; k < anum; k++) {
+		INIT_HLIST_HEAD(&htree[k].head);
+		htree[k].next = NULL;
+	}
+	hts->acnt++;
+
+	return htree;
+}
+EXPORT_SYMBOL(ht_table_alloc);
+
+/**
+ * ht_hts_alloc - memory allocation of htree_state struct
+ * return: hts: allocated memory pointer
+ *
+ * htree_state is the numeric data structure for operations.
+ * It is used to calculate the starting bit and depth of the hash tree,
+ *      number of searches, number of memory allocations, and usage efficiency.
+ */
+struct htree_state *ht_hts_alloc(void)
+{
+	struct htree_state *hts = (struct htree_state *)
+			kmalloc(sizeof(struct htree_state), GFP_KERNEL);
+	return hts;
+}
+EXPORT_SYMBOL(ht_hts_alloc);
+
+/**
+ * _ht_hts_get_sbit - starting bit to determine hash table size
+ * @maxnr: maximum number of indexes to use in the system
+ * return: starting bit(stored in hts->sbit)
+
+ * Determine the size of the hash table by choosing the starting number of
+ * bits for the hash tree.  Increase memory usage efficiency by optimizing
+ * hash table size in proportion to index quantity(maxnr).
+ * hts->sbit enables maintain memory usage efficiency more than 80%.
+ */
+static u8 _ht_hts_get_sbit(u64 maxnr)
+{
+	u8 sbit = 0;
+	do {
+		maxnr >>= HTREE_BITS_SHIFT;
+		sbit++;
+	} while(maxnr > 0);
+
+	return (sbit < HTREE_BITS_END) ? HTREE_BITS_END : sbit;
+}
+
+/**
+ * ht_hts_clear_init - clear & init of htree statistic structure
+ * @hts: htree_state struct pointer
+ * @maxnr: maximum number of indexes to use in the system
+ * @idxt: type of index [0:64bits, 1:32bits]
+ * @sort: index sorting type [0:ascending, 1:descending]
+ *
+ * hts->sbit is determined in the _ht_hts_get_sbit() function
+ *      in proportion to the total number of indexes(maxnr).
+ */
+void ht_hts_clear_init(struct htree_state *hts, u64 maxnr, u8 idxt, u8 sort)
+{
+	memset(hts, 0, sizeof(struct htree_state));
+
+	hts->sbit = _ht_hts_get_sbit(maxnr);
+	hts->idxt = idxt;
+	hts->sort = sort;
+}
+EXPORT_SYMBOL(ht_hts_clear_init);
+
+/**
+ * __ht_find - private function to call recursively to find index
+ * @hts: htree_state pointer
+ * @htree: hash_tree pointer
+ * @index: user index to find
+ * @rdata: node data at the searched location to return
+ * @rtree: hash tree at the searched location to return
+ */
+static enum ht_flags __ht_find(struct htree_state *hts, struct hash_tree *htree,
+		u64 index, struct htree_data **rdata, struct hash_tree **rtree)
+{
+	struct htree_data *pos;
+	u8 bits, ncnt;
+
+_retry:
+	*rtree = htree;
+	ncnt = ht_ncnt_get(htree[hts->hkey].next);
+	if (ncnt == 0)
+		goto _next_step;
+
+	hlist_for_each_entry(pos, &htree[hts->hkey].head, hnode) {
+		*rdata = pos;
+		hts->wcnt++;
+		if (pos->index > index) {
+			if (hts->sort == HTREE_FLAG_ASCD)
+				return htf_find_gt;
+
+		} else if (pos->index < index) {
+			if (hts->sort == HTREE_FLAG_DECD)
+				return htf_find_lt;
+
+		} else {
+			return htf_find;
+		}
+	}
+
+_next_step:
+	htree = ht_ncnt_pointer(htree[hts->hkey].next);
+	if (htree) {
+		hts->dept++;
+		bits = ht_bits_from_depth(hts->sbit, hts->dept);
+		hts->hkey = ht_get_hkey(index, hts->dept, bits, hts->idxt);
+		goto _retry;
+	}
+	return htf_none;
+}
+
+/**
+ * ht_find - private function to find index
+ * @hts: htree_state pointer
+ * @htree: hash_tree pointer
+ * @index: user index to find
+ * @rdata: node data at the searched location to return(**)
+ * @rtree: hash tree at the searched location to return(**)
+ */
+static enum ht_flags _ht_find(struct htree_state *hts, struct hash_tree *htree,
+	      u64 index, struct htree_data **rdata, struct hash_tree **rtree)
+{
+	enum ht_flags ret;
+
+	hts->wcnt = 0;
+	hts->dept = 0;
+	hts->hkey = ht_get_hkey(index, 0, hts->sbit, hts->idxt);
+
+	ret = __ht_find(hts, htree, index, rdata, rtree);
+
+	return ret;
+}
+
+/**
+ * ht_find - public function to find index
+ * @hts: htree_state pointer
+ * @htree: hash_tree pointer
+ * @index: user index to find
+ *
+ * return: rdata: found node data to return
+ */
+struct htree_data *ht_find(struct htree_state *hts,
+			   struct hash_tree *htree, u64 index)
+{
+	struct htree_data *rdata = NULL;
+	struct hash_tree *rtree;
+
+	if (_ht_find(hts, htree, index, &rdata, &rtree) == htf_find)
+		return rdata;
+	return NULL;
+}
+EXPORT_SYMBOL(ht_find);
+
+/**
+ * _ht_move_to_next - private function to call recursively to move index
+ * @hts: htree_state pointer
+ * @sdata: hash list node
+ * @prev: previous hash_tree pointer
+ * @ntree: next hash_tree
+ *
+ * The number of lists linking to the same hash key is HTREE_MAX_NCNT.
+ * If this is exceeded, it moves to the next hash table in sequence.
+ */
+static void _ht_move_to_next(struct htree_state *hts, struct htree_data *sdata,
+			     struct hash_tree *prev, struct hash_tree *ntree)
+{
+	u8 bits, ncnt, dept = hts->dept;
+	u16 hkey;
+	struct htree_data *edata;
+	struct htree_data *pos, *rdata = NULL;
+	enum ht_flags htf;
+
+_retry:
+	edata = sdata;
+	pos = sdata;
+	/* find the end node on the current(prev) */
+	hlist_for_each_entry_from(pos, hnode)
+		edata = pos;
+
+	hlist_del(&edata->hnode);
+	INIT_HLIST_NODE(&edata->hnode);
+	WRITE_ONCE(prev->next, ht_ncnt_dec(prev->next, 1));
+
+	dept++;
+	bits = ht_bits_from_depth(hts->sbit, dept);
+	hkey = ht_get_hkey(edata->index, dept, bits, hts->idxt);
+
+	if (!ntree) {
+		ncnt = ht_ncnt_get(prev->next);
+		ntree = ht_table_alloc(hts);
+		WRITE_ONCE(prev->next, ht_ncnt_set(ntree, ncnt));
+		htree_add_head(ntree, &edata->hnode, hkey);
+		goto _next;
+	}
+
+	ncnt = ht_ncnt_get(ntree[hkey].next);
+	if (ncnt == 0) {
+		htree_add_head(ntree, &edata->hnode, hkey);
+		goto _next;
+	}
+
+	htf = htf_none;
+	hlist_for_each_entry(pos, &ntree[hkey].head, hnode) {
+		rdata = pos;
+		if (hts->sort == HTREE_FLAG_ASCD &&
+				pos->index >= edata->index) {
+			htf = htf_find_gt;
+			hlist_add_before(&edata->hnode, &rdata->hnode);
+			break;
+		}
+		if (hts->sort == HTREE_FLAG_DECD &&
+				pos->index <= edata->index) {
+			htf = htf_find_lt;
+			hlist_add_before(&edata->hnode, &rdata->hnode);
+			break;
+		}
+	}
+	if (htf < htf_find_lt)
+		hlist_add_behind(&edata->hnode, &rdata->hnode);
+
+_next:
+	WRITE_ONCE(ntree[hkey].next, ht_ncnt_inc(ntree[hkey].next, 1));
+
+	ncnt = ht_ncnt_get(ntree[hkey].next);
+	if (ncnt > HTREE_MAX_NCNT(dept)) {
+		sdata = edata;
+		prev = &ntree[hkey];
+		ntree = ht_ncnt_pointer(ntree[hkey].next);
+		goto _retry;
+	}
+}
+
+/**
+ * ht_insert - insert the user index into the hash tree.
+ * @hts: htree_state pointer
+ * @htree: hash_tree pointer
+ * @index: user index to insert
+ * @rdata: destination data pointer of hlist node
+ * @hdata: source data pointer of hlist node
+ * @htf: working flags
+ *
+ * The flow linked to a specific depth of the hash tree by a hash key:
+ *      user index --> hash key --> hash tree --> depth --> hash lists
+ */
+static void _ht_insert(struct htree_state *hts, struct hash_tree *htree,
+		       struct htree_data *rdata, struct htree_data *hdata,
+		       enum ht_flags htf, enum ht_flags req)
+{
+	struct htree_data *edata = hdata;
+	u64 index = hdata->index;
+	u8 bits, ncnt;
+
+	bits = ht_bits_from_depth(hts->sbit, hts->dept);
+	hts->hkey = ht_get_hkey(index, hts->dept, bits, hts->idxt);
+	ncnt = ht_ncnt_get(htree[hts->hkey].next);
+
+	if (ncnt == 0) {
+		htree_add_head(htree, &hdata->hnode, hts->hkey);
+		goto _finish;
+	}
+
+	/*
+	 * if (hts->sort == HTREE_FLAG_ASCD) then htf is htf_find_gt
+	 * if (hts->sort == HTREE_FLAG_DECD) then htf is htf_find_lt
+	 */
+	if (htf == htf_find_gt || htf == htf_find_lt) {
+		hlist_add_before(&hdata->hnode, &rdata->hnode);
+		edata = rdata;
+		if (hts->dept == 0 && hts->wcnt == 1)
+			hts->most = hts->hkey;
+	} else {
+		hlist_add_behind(&hdata->hnode, &rdata->hnode);
+		edata = hdata;
+	}
+
+_finish:
+	if (req == htf_ins) {
+		WRITE_ONCE(htree[hts->hkey].next, 
+				ht_ncnt_inc(htree[hts->hkey].next, 1));
+		hts->dcnt++;
+		ncnt++;
+	}
+
+	if (ncnt > HTREE_MAX_NCNT(hts->dept)) {
+		_ht_move_to_next(hts, edata, &htree[hts->hkey],
+				ht_ncnt_pointer(htree[hts->hkey].next));
+	}
+}
+
+/**
+ * ht_insert - public function to insert udata
+ * @hts: htree_state pointer
+ * @htree: hash_tree root pointer
+ * @udata: data_struct to insert
+ * @req: flag to proceed further after index insertion
+ *
+ * return: rdata: searched node data to return
+ *
+ * If there is the same index:
+ * if req is htf_ins, the new udata is inserted next to each other.
+ * if req is htf_erase, the new udata is inserted, and old udata is erased.
+ *
+ * insert flow:
+ *      _ht_find() --> finding rdata, rtree --> _ht_insert()
+ */
+struct htree_data *ht_insert(struct htree_state *hts, struct hash_tree *htree,
+			     struct htree_data *hdata, enum ht_flags req)
+{
+	struct htree_data *rdata = NULL;
+	struct hash_tree *rtree = NULL;
+	enum ht_flags htf;
+
+	htf = _ht_find(hts, htree, hdata->index, &rdata, &rtree);
+
+	_ht_insert(hts, rtree, rdata, hdata, htf, req);
+
+	if (htf == htf_find && req == htf_erase) {
+		hlist_del(&rdata->hnode);
+		return rdata;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(ht_insert);
+
+/**
+ * ___ht_erase - delete an empty hash tree
+ * @hts: htree_state pointer
+ * @htree: hash_tree to check if empty
+ * @bits: bits of this hash tree
+ */
+static enum ht_flags ___ht_erase(struct htree_state *hts,
+				 struct hash_tree *htree, u8 bits)
+{
+	u16 k;
+	u16 anum = HTREE_ARRAY_SIZE(bits);
+
+	for (k = 0; k < anum; k++)
+		if (htree[k].next)
+			break;
+
+	if (k == anum) {
+		kfree(htree);
+		hts->acnt--;
+		hts->dept--;
+		return htf_freed;
+	}
+	return htf_erase;
+}
+
+/**
+ * __ht_erase - private function to call recursively to erase index
+ * @hts: htree_state pointer
+ * @htree: hash_tree pointer
+ * @rdata: searched node data to erase
+ * @index: user index to erase
+ */
+static int __ht_erase(struct htree_state *hts, struct hash_tree *htree,
+		      struct htree_data **rdata, u64 index)
+{
+	struct hash_tree *_next;
+	struct htree_data *pos;
+	struct hlist_node *tmp;
+	enum ht_flags ret = htf_none;
+	u8 bits, ncnt;
+	u16 key = hts->hkey;
+
+	ncnt = ht_ncnt_get(htree[key].next);
+	bits = ht_bits_from_depth(hts->sbit, hts->dept);
+
+	if (ncnt == 0)
+		goto _next_step;
+
+	hlist_for_each_entry_safe(pos, tmp, &htree[key].head, hnode) {
+		if (pos->index == index) {
+			hlist_del(&pos->hnode);
+			ncnt--;
+			hts->dcnt--;
+			WRITE_ONCE(htree[key].next, 
+					ht_ncnt_set(htree[key].next, ncnt));
+			*rdata = pos;
+			ret = htf_erase;
+			break;
+		} else {
+			if (hts->sort == HTREE_FLAG_ASCD && pos->index > index)
+				break;
+			if (hts->sort == HTREE_FLAG_DECD && pos->index < index)
+				break;
+		}
+	}
+
+	if (ncnt == 0)
+		ret = ___ht_erase(hts, htree, bits);
+
+	if (ret > htf_none)	/* erased or freed */
+		return ret;
+_next_step:
+	_next = ht_ncnt_pointer(htree[key].next);
+	if (_next) {
+		hts->dept++;
+		bits = ht_bits_from_depth(hts->sbit, hts->dept);
+		hts->hkey = ht_get_hkey(index, hts->dept, bits, hts->idxt);
+
+		/* must be recursive call */
+		ret = __ht_erase(hts, _next, rdata, index);
+
+		if (ret == htf_freed) {
+			WRITE_ONCE(htree[key].next, ht_ncnt_set(NULL, ncnt));
+			ret = htf_erase;
+		}
+	}
+	return (ret > htf_none) ? htf_erase : htf_none;
+}
+
+/**
+ * _ht_erase - private function to erase index
+ * @hts: htree_state pointer
+ * @htree: hash_tree pointer
+ * @rdata: searching node data to erase
+ * @index: user index to erase
+ */
+static enum ht_flags _ht_erase(struct htree_state *hts,
+		struct hash_tree *htree, struct htree_data **rdata, u64 index)
+{
+	hts->dept = 0;
+	hts->hkey = ht_get_hkey(index, 0, hts->sbit, hts->idxt);
+
+	if (__ht_erase(hts, htree, rdata, index) >= htf_erase)
+		return htf_erase;
+
+	return htf_none;
+}
+
+/**
+ * ht_erase - public function to erase index
+ * @hts: htree_state pointer
+ * @htree: hash_tree pointer
+ * @index: user index to erase
+ *
+ * return: rdata: searched node data to erase
+ */
+struct htree_data *ht_erase(struct htree_state *hts,
+			    struct hash_tree *htree, u64 index)
+{
+	struct htree_data *rdata = NULL;
+
+	if (_ht_erase(hts, htree, &rdata, index) == htf_erase)
+		return rdata;
+
+	return NULL;
+}
+EXPORT_SYMBOL(ht_erase);
+
+/**
+ * __ht_free_all - private function to call recursively to free hash tree
+ * @hts: htree_state pointer
+ * @htree: hash_tree pointer
+ * @acnt: freed allocated hash tree count
+ * @dcnt: freed node data count
+ */
+static void __ht_free_all(struct htree_state *hts,
+			  struct hash_tree *htree, s32 *acnt, u64 *dcnt)
+{
+	u8 bits, ncnt;
+	u16 k, anum, pnum;
+	struct htree_data *pos;
+	struct hlist_node *tmp;
+	struct hash_tree *_next;
+
+	bits = ht_bits_from_depth(hts->sbit, hts->dept);
+	anum = HTREE_ARRAY_SIZE(bits);
+
+	for (k = 0; k < anum; k++) {
+		ncnt = ht_ncnt_get(htree[k].next);
+		if (ncnt > 0) {
+			bits = ht_bits_from_depth(hts->sbit, hts->dept);
+			hlist_for_each_entry_safe(pos, tmp,
+					&htree[k].head, hnode) {
+				hlist_del(&pos->hnode);
+				(*dcnt)++;
+			}
+		}
+		_next = ht_ncnt_pointer(htree[k].next);
+		if (_next) {
+			hts->dept++;
+			pnum = anum;
+			/* recursive call */
+			__ht_free_all(hts, _next, acnt, dcnt);
+			anum = pnum;
+			hts->dept--;
+		} else {
+			continue;
+		}
+	}
+	if (htree) {
+		(*acnt)++;
+		kfree(htree);	/* free hash table[asize] */
+	}
+}
+
+/**
+ * ht_destroy - public function to free hash tree
+ * @hts: htree_state pointer
+ * @htree: hash_tree pointer(root)
+ *
+ * this function removes all hash tree, but it does not remove udata.
+ */
+enum ht_flags ht_destroy(struct htree_state *hts, struct hash_tree *htree)
+{
+	s32 acnt = 0;
+	u64 dcnt = 0;
+
+	if (hts->acnt == 0 && hts->dcnt == 0)
+		return htf_ok;
+
+	hts->dept = 0;
+	__ht_free_all(hts, htree, &acnt, &dcnt);
+
+	hts->acnt -= acnt;
+	hts->dcnt -= dcnt;
+
+	return (hts->dept == 0 && hts->dcnt == 0 && hts->acnt == 0) ?
+		htf_ok : htf_none;
+}
+EXPORT_SYMBOL(ht_destroy);
+
+/**
+ * __ht_statis - private function to call recursively to calculate nodes
+ * @hts: htree_state pointer
+ * @htree: hash_tree pointer
+ * @acnt: allocated hash tree count
+ * @dcnt: node data count
+ */
+static void __ht_statis(struct htree_state *hts,
+			struct hash_tree *htree, s32 *acnt, u64 *dcnt)
+{
+	u8 bits, ncnt;
+	u16 k, anum, pnum;
+	struct hash_tree *_next;
+
+	bits = ht_bits_from_depth(hts->sbit, hts->dept);
+	anum = HTREE_ARRAY_SIZE(bits);
+
+	hts->asum += anum;
+	(*acnt)++;
+
+	for (k = 0; k < anum; k++) {
+		ncnt = ht_ncnt_get(htree[k].next);
+		if (ncnt > 0) {
+			(*dcnt) += ncnt;
+		}
+		_next = ht_ncnt_pointer(htree[k].next);
+		if (_next) {
+			hts->dept++;
+			if (hts->dept > hts->dmax)
+				hts->dmax = hts->dept;
+			pnum = anum;
+			/* recursive call */
+			__ht_statis(hts, _next, acnt, dcnt);
+			anum = pnum;
+			hts->dept--;
+		} else {
+			continue;
+		}
+	}
+}
+
+/**
+ * ht_statis - public function to calculate nodes information
+ * @hts: htree_state pointer
+ * @htree: hash_tree pointer
+ * @acnt: allocated hash tree count to return
+ * @dcnt: node data count to return
+ */
+void ht_statis(struct htree_state *hts,
+	       struct hash_tree *htree, s32 *acnt, u64 *dcnt)
+{
+	hts->asum = 0;
+	hts->dept = 0;
+	hts->dmax = 0;
+
+	__ht_statis(hts, htree, acnt, dcnt);
+}
+EXPORT_SYMBOL(ht_statis);
+
+/**
+ * ht_most_index - get most smallest and largest index
+ * @hts: htree_state pointer
+ * @htree: hash_tree pointer
+ *
+ * if sorting flag is HTREE_FLAG_ASCD, first hash table has the smallest index.
+ * if sorting flag is HTREE_FLAG_DECD, first hash table has the largest index.
+ * hts->most has the hash key position, algorithm O(1).
+ */
+struct htree_data *ht_most_index(struct htree_state *hts, struct hash_tree *htree)
+{
+	return hlist_entry_safe(htree[hts->most].head.first,
+				struct htree_data, hnode);
+}
+EXPORT_SYMBOL(ht_most_index);
-- 
2.17.1


