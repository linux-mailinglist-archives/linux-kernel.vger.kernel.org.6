Return-Path: <linux-kernel+bounces-557990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C70CA5E01C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D1E3A21E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FCF25C6E7;
	Wed, 12 Mar 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dY+5nCBM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="74udpUd+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20BC257AC9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792612; cv=none; b=prjSraeXwUeRDsTr9QZHcvV2j0GBB/57SmtVbx8KWpwdUenjMQwMZfN6x4DmFvxfd8MAjL5LE/xVAqKB7eUa/AEncUcN6a/OxPcXXSa5cTO+5xdcLaHm/aRNkmKOr4gbYDwtwYctdXvTAcxJFd30NsgBUG4HymuYcrE4IrDLcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792612; c=relaxed/simple;
	bh=bl4cLDhuMd74Mq6Ih/NF2BqPljxDr4IxOUtL/VE90fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byCwwoJRwSJA90XcrKfAZcwn/wDFOLDme1EpfC30Xdr3hNVpGHhZUrfWbOjER62TAP1XvLuXvTkNjez3UKCtPZHVZL1iKZ6B8Gn96BloedzwF6P7HN7vljH6LBnFu+8lNpW4Oi/9E7oTNP50iQOMMv/zbbaLww7qLaZfuzxCCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dY+5nCBM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=74udpUd+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3LCm1d64Y7YEyqKbvy7JXW7DiwDUF3lDXFWlqN3fEY=;
	b=dY+5nCBMOwL76hZ8hxWz+9CJ6Qv26mX5PmnwFseYvvXCSHJG72mdt0GU5+S8X/hucQrEAM
	cb8qswksdCMs6o7C24zyhoVffI5kbaUk1TxhGFyzkKhjgKcA6OINHPZlPqwJA87CBaK18H
	0HlQcqTE302w1AHo7w1ZwGTlujDEGY6UeQAm3E5sMIieFOH035DWhclbWoHi/WP9f9GCbd
	JlatNei4Zuxwmm00KmH4cuOovllwpScJ4mdwL58JmVGuDIdrDGrnJddG/GcfsliO58lDqE
	W1g+DYZjjuPl2+Np1VJwLrcI2HbTZE8nX2Wf2458eLJ72IiE4tEK9soL3XrQCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3LCm1d64Y7YEyqKbvy7JXW7DiwDUF3lDXFWlqN3fEY=;
	b=74udpUd+7OGwkKSwjUlMrXivZGp/74I0kHpzQuJMGvKuOlzRpym3/raVCoVFNPBv7FDVBk
	E21i2547TgA4AuBQ==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v10 20/21] futex: Implement FUTEX2_NUMA
Date: Wed, 12 Mar 2025 16:16:33 +0100
Message-ID: <20250312151634.2183278-21-bigeasy@linutronix.de>
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Zijlstra <peterz@infradead.org>

Extend the futex2 interface to be numa aware.

When FUTEX2_NUMA is specified for a futex, the user value is extended
to two words (of the same size). The first is the user value we all
know, the second one will be the node to place this futex on.

  struct futex_numa_32 {
	u32 val;
	u32 node;
  };

When node is set to ~0, WAIT will set it to the current node_id such
that WAKE knows where to find it. If userspace corrupts the node value
between WAIT and WAKE, the futex will not be found and no wakeup will
happen.

When FUTEX2_NUMA is not set, the node is simply an extention of the
hash, such that traditional futexes are still interleaved over the
nodes.

This is done to avoid having to have a separate !numa hash-table.

[bigeasy: ensure to have at least hashsize of 4 in futex_init(), add
pr_info() for size and allocation information.]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h      |   3 ++
 include/uapi/linux/futex.h |   8 +++
 kernel/futex/core.c        | 100 ++++++++++++++++++++++++++++++-------
 kernel/futex/futex.h       |  33 ++++++++++--
 4 files changed, 124 insertions(+), 20 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 7e14d2e9162d2..19c37afa0432a 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -34,6 +34,7 @@ union futex_key {
 		u64 i_seq;
 		unsigned long pgoff;
 		unsigned int offset;
+		/* unsigned int node; */
 	} shared;
 	struct {
 		union {
@@ -42,11 +43,13 @@ union futex_key {
 		};
 		unsigned long address;
 		unsigned int offset;
+		/* unsigned int node; */
 	} private;
 	struct {
 		u64 ptr;
 		unsigned long word;
 		unsigned int offset;
+		unsigned int node;	/* NOT hashed! */
 	} both;
 };
=20
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index d2ee625ea1890..0435025beaae8 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -74,6 +74,14 @@
 /* do not use */
 #define FUTEX_32		FUTEX2_SIZE_U32 /* historical accident :-( */
=20
+
+/*
+ * When FUTEX2_NUMA doubles the futex word, the second word is a node valu=
e.
+ * The special value -1 indicates no-node. This is the same value as
+ * NUMA_NO_NODE, except that value is not ABI, this is.
+ */
+#define FUTEX_NO_NODE		(-1)
+
 /*
  * Max numbers of elements in a futex_waitv array
  */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index bc7451287b2ce..b9da7dc6a900a 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -36,6 +36,8 @@
 #include <linux/pagemap.h>
 #include <linux/debugfs.h>
 #include <linux/plist.h>
+#include <linux/gfp.h>
+#include <linux/vmalloc.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
@@ -51,11 +53,14 @@
  * reside in the same cacheline.
  */
 static struct {
-	struct futex_hash_bucket *queues;
 	unsigned long            hashmask;
+	unsigned int		 hashshift;
+	struct futex_hash_bucket *queues[MAX_NUMNODES];
 } __futex_data __read_mostly __aligned(2*sizeof(long));
-#define futex_queues   (__futex_data.queues)
-#define futex_hashmask (__futex_data.hashmask)
+
+#define futex_hashmask	(__futex_data.hashmask)
+#define futex_hashshift	(__futex_data.hashshift)
+#define futex_queues	(__futex_data.queues)
=20
 struct futex_private_hash {
 	rcuref_t	users;
@@ -326,15 +331,35 @@ __futex_hash(union futex_key *key, struct futex_priva=
te_hash *fph)
 {
 	struct futex_hash_bucket *hb;
 	u32 hash;
+	int node;
=20
 	hb =3D __futex_hash_private(key, fph);
 	if (hb)
 		return hb;
=20
 	hash =3D jhash2((u32 *)key,
-		      offsetof(typeof(*key), both.offset) / 4,
+		      offsetof(typeof(*key), both.offset) / sizeof(u32),
 		      key->both.offset);
-	return &futex_queues[hash & futex_hashmask];
+	node =3D key->both.node;
+
+	if (node =3D=3D FUTEX_NO_NODE) {
+		/*
+		 * In case of !FLAGS_NUMA, use some unused hash bits to pick a
+		 * node -- this ensures regular futexes are interleaved across
+		 * the nodes and avoids having to allocate multiple
+		 * hash-tables.
+		 *
+		 * NOTE: this isn't perfectly uniform, but it is fast and
+		 * handles sparse node masks.
+		 */
+		node =3D (hash >> futex_hashshift) % nr_node_ids;
+		if (!node_possible(node)) {
+			node =3D find_next_bit_wrap(node_possible_map.bits,
+						  nr_node_ids, node);
+		}
+	}
+
+	return &futex_queues[node][hash & futex_hashmask];
 }
=20
 /**
@@ -441,25 +466,49 @@ int get_futex_key(u32 __user *uaddr, unsigned int fla=
gs, union futex_key *key,
 	struct page *page;
 	struct folio *folio;
 	struct address_space *mapping;
-	int err, ro =3D 0;
+	int node, err, size, ro =3D 0;
 	bool fshared;
=20
 	fshared =3D flags & FLAGS_SHARED;
+	size =3D futex_size(flags);
+	if (flags & FLAGS_NUMA)
+		size *=3D 2;
=20
 	/*
 	 * The futex address must be "naturally" aligned.
 	 */
 	key->both.offset =3D address % PAGE_SIZE;
-	if (unlikely((address % sizeof(u32)) !=3D 0))
+	if (unlikely((address % size) !=3D 0))
 		return -EINVAL;
 	address -=3D key->both.offset;
=20
-	if (unlikely(!access_ok(uaddr, sizeof(u32))))
+	if (unlikely(!access_ok(uaddr, size)))
 		return -EFAULT;
=20
 	if (unlikely(should_fail_futex(fshared)))
 		return -EFAULT;
=20
+	if (flags & FLAGS_NUMA) {
+		u32 __user *naddr =3D uaddr + size / 2;
+
+		if (futex_get_value(&node, naddr))
+			return -EFAULT;
+
+		if (node =3D=3D FUTEX_NO_NODE) {
+			node =3D numa_node_id();
+			if (futex_put_value(node, naddr))
+				return -EFAULT;
+
+		} else if (node >=3D MAX_NUMNODES || !node_possible(node)) {
+			return -EINVAL;
+		}
+
+		key->both.node =3D node;
+
+	} else {
+		key->both.node =3D FUTEX_NO_NODE;
+	}
+
 	/*
 	 * PROCESS_PRIVATE futexes are fast.
 	 * As the mm cannot disappear under us and the 'key' only needs
@@ -1597,24 +1646,41 @@ int futex_hash_prctl(unsigned long arg2, unsigned l=
ong arg3)
 static int __init futex_init(void)
 {
 	unsigned long hashsize, i;
-	unsigned int futex_shift;
+	unsigned int order, n;
+	unsigned long size;
=20
 #ifdef CONFIG_BASE_SMALL
 	hashsize =3D 16;
 #else
-	hashsize =3D roundup_pow_of_two(256 * num_possible_cpus());
+	hashsize =3D 256 * num_possible_cpus();
+	hashsize /=3D num_possible_nodes();
+	hashsize =3D max(4, hashsize);
+	hashsize =3D roundup_pow_of_two(hashsize);
 #endif
+	futex_hashshift =3D ilog2(hashsize);
+	size =3D sizeof(struct futex_hash_bucket) * hashsize;
+	order =3D get_order(size);
=20
-	futex_queues =3D alloc_large_system_hash("futex", sizeof(*futex_queues),
-					       hashsize, 0, 0,
-					       &futex_shift, NULL,
-					       hashsize, hashsize);
-	hashsize =3D 1UL << futex_shift;
+	for_each_node(n) {
+		struct futex_hash_bucket *table;
=20
-	for (i =3D 0; i < hashsize; i++)
-		futex_hash_bucket_init(&futex_queues[i], NULL);
+		if (order > MAX_PAGE_ORDER)
+			table =3D vmalloc_huge_node(size, GFP_KERNEL, n);
+		else
+			table =3D alloc_pages_exact_nid(n, size, GFP_KERNEL);
+
+		BUG_ON(!table);
+
+		for (i =3D 0; i < hashsize; i++)
+			futex_hash_bucket_init(&table[i], NULL);
+
+		futex_queues[n] =3D table;
+	}
=20
 	futex_hashmask =3D hashsize - 1;
+	pr_info("futex hash table entries: %lu (%lu bytes on %d NUMA nodes, total=
 %lu KiB, %s).\n",
+		hashsize, size, num_possible_nodes(), size * num_possible_nodes() / 1024,
+		order > MAX_PAGE_ORDER ? "vmalloc" : "linear");
 	return 0;
 }
 core_initcall(futex_init);
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 8eba9982bcae1..11c870a92b5d0 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -54,7 +54,7 @@ static inline unsigned int futex_to_flags(unsigned int op)
 	return flags;
 }
=20
-#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE)
+#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_NUMA | FUTEX2_PRIVATE)
=20
 /* FUTEX2_ to FLAGS_ */
 static inline unsigned int futex2_to_flags(unsigned int flags2)
@@ -87,6 +87,19 @@ static inline bool futex_flags_valid(unsigned int flags)
 	if ((flags & FLAGS_SIZE_MASK) !=3D FLAGS_SIZE_32)
 		return false;
=20
+	/*
+	 * Must be able to represent both FUTEX_NO_NODE and every valid nodeid
+	 * in a futex word.
+	 */
+	if (flags & FLAGS_NUMA) {
+		int bits =3D 8 * futex_size(flags);
+		u64 max =3D ~0ULL;
+
+		max >>=3D 64 - bits;
+		if (nr_node_ids >=3D max)
+			return false;
+	}
+
 	return true;
 }
=20
@@ -290,7 +303,7 @@ static inline int futex_cmpxchg_value_locked(u32 *curva=
l, u32 __user *uaddr, u32
  * This looks a bit overkill, but generally just results in a couple
  * of instructions.
  */
-static __always_inline int futex_read_inatomic(u32 *dest, u32 __user *from)
+static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
 {
 	u32 val;
=20
@@ -307,12 +320,26 @@ static __always_inline int futex_read_inatomic(u32 *d=
est, u32 __user *from)
 	return -EFAULT;
 }
=20
+static __always_inline int futex_put_value(u32 val, u32 __user *to)
+{
+	if (can_do_masked_user_access())
+		to =3D masked_user_access_begin(to);
+	else if (!user_read_access_begin(to, sizeof(*to)))
+		return -EFAULT;
+	unsafe_put_user(val, to, Efault);
+	user_read_access_end();
+	return 0;
+Efault:
+	user_read_access_end();
+	return -EFAULT;
+}
+
 static inline int futex_get_value_locked(u32 *dest, u32 __user *from)
 {
 	int ret;
=20
 	pagefault_disable();
-	ret =3D futex_read_inatomic(dest, from);
+	ret =3D futex_get_value(dest, from);
 	pagefault_enable();
=20
 	return ret;
--=20
2.47.2


