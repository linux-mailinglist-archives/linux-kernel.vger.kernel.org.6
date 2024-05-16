Return-Path: <linux-kernel+bounces-181131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F388C77D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96031F22E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8921474B5;
	Thu, 16 May 2024 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfjcAlXY"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B43328680
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866799; cv=none; b=apBKzd1mlZN9ewD5nIlSPd0PiUMg+fqxq7NmeNVRo5dNKkO6P2dt/jDVhQc52SeAj7Z9qzcwJXzMj0lTwUakReTUwRgvZGu7RuCcfggkNhByl2Fu8J5s0dsQu67kxK4TwmAbrZeC0OvnUUAtMyjTU574GATEJMWtPX76NUQevjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866799; c=relaxed/simple;
	bh=k3GMVpX2i91C27/HKVxj2D7JJAIVUwfd1Ff4nS0LM98=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t4dCltS4BaHATq/VHyEWpmR/D0bNXEfDnFG50hcL8CqOym4Q8lp2FNOe8xFdfS8KEIADq6f064dB9ozTaqHEeq616+lxKQAp1Lzdfd3TXFdNfm0igZeTi0yrG9y6ISvV1g4meVIm8hT7L0zx24gIsaJjOSF1aunhZhQoJrvoHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfjcAlXY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62777fe7b86so15723937b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715866796; x=1716471596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z12TnsNL/hTi746MVANatY4Tjh00xqLL128AtUtBao0=;
        b=lfjcAlXYtLmrPeKt/l7ONDcGC1nlSedUwTekRqiiS0gDuDmO8as9HtbOfNrU1VCU7o
         kL3BtK09koAphTsj3ukWrDVnvVHCFlwc+2/QdsTTx5+YeHKgVdR8y63ADZ+ieLJe1yoc
         IKjRr3NbkMK8smfK8CsSSRcUgFNUP2ZPSLTgvNgLwknot/2TKVC7ozSMalT+p2R6ozdW
         OGoZErc1fxefz16kZVHAp4c5uSpfOfgImk4X3zvY/RC0W2FIRMZCDsvH9oVS+BtxrXXF
         57cjn2WUA+xISeL9/efvoYBwEzu5U7Z0X8apHwZIY+C9ZGS9aThaxobSUKu4qz34j1ys
         Eeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715866796; x=1716471596;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z12TnsNL/hTi746MVANatY4Tjh00xqLL128AtUtBao0=;
        b=gC1tq1UZYoNLxSTavD8FM4119LwXCLLus6bMWbo0wDrL3b0nicYPY4H14K4vo2d/49
         IpXU/YkOJ2tEqE4LqXhUL8b96uefLZonbcMmx9+KVy0/MajD5u/IB2BztFE+/7dWtpQM
         ahsWz9W3lwloxg8D1zrhLdDGIWm6PiRqKwz0o5A970tedTRTKtINlaqePr/3d9QoBsCg
         F9LBoDS9PlLfbbhpvn3N9Xzu0Lw9UL5aT7UxNH6m1teHmxi0hkod55Tq8mo+FhzzRXwq
         6Tl5HsE32R72jb+CggTlbTKeyTBkPCfP4juh41Crvxk7VoBGHagvzrY/Q19lwmMA4M5k
         zhdQ==
X-Gm-Message-State: AOJu0YxsRDBqh+UiOeb/l1C2texZpn4JQFa2OWDe7vaGB3k3BoWGaBAe
	xPWZjApjZ/Y2XnMHRi7iYapqyIxlOd5+3/MwEfqTY0N2B44r5yeSI60BuRQw9UYprK1jKUJMiaj
	3a08YalULVQ==
X-Google-Smtp-Source: AGHT+IFCnSxC67NuntQJBLKiX0Yt4ODrfN0OVPAns4hgNba/c6/FzxgIQqmDHwdBpLhksSJItjS0ntXwlwCu5Q==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:4507:b0:61b:3b02:6901 with SMTP
 id 00721157ae682-622b001dd60mr44555357b3.9.1715866796174; Thu, 16 May 2024
 06:39:56 -0700 (PDT)
Date: Thu, 16 May 2024 13:39:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240516133952.4072309-1-cmllamas@google.com>
Subject: [PATCH v3] binder: use bitmap for faster descriptor lookup
From: Carlos Llamas <cmllamas@google.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Tim Murray <timmurray@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	John Stultz <jstultz@google.com>, Steven Moreland <smoreland@google.com>, Nick Chen <chenjia3@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When creating new binder references, the driver assigns a descriptor id
that is shared with userspace. Regrettably, the driver needs to keep the
descriptors small enough to accommodate userspace potentially using them
as Vector indexes. Currently, the driver performs a linear search on the
rb-tree of references to find the smallest available descriptor id. This
approach, however, scales poorly as the number of references grows.

This patch introduces the usage of bitmaps to boost the performance of
descriptor assignments. This optimization results in notable performance
gains, particularly in processes with a large number of references. The
following benchmark with 100,000 references showcases the difference in
latency between the dbitmap implementation and the legacy approach:

  [  587.145098] get_ref_desc_olocked: 15us (dbitmap on)
  [  602.788623] get_ref_desc_olocked: 47343us (dbitmap off)

Note the bitmap size is dynamically adjusted in line with the number of
references, ensuring efficient memory usage. In cases where growing the
bitmap is not possible, the driver falls back to the slow legacy method.

A previous attempt to solve this issue was proposed in [1]. However,
such method involved adding new ioctls which isn't great, plus older
userspace code would not have benefited from the optimizations either.

Link: https://lore.kernel.org/all/20240417191418.1341988-1-cmllamas@google.=
com/ [1]
Cc: Tim Murray <timmurray@google.com>
Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: John Stultz <jstultz@google.com>
Cc: Steven Moreland <smoreland@google.com>
Suggested-by: Nick Chen <chenjia3@oppo.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---

Notes:
    v1: first solution using a new "flags" ioctl:
        https://lore.kernel.org/all/20240417191418.1341988-1-cmllamas@googl=
e.com/
   =20
    v2: switched to different implementation using bitmaps.
   =20
    v3: dropped __GFP_ZERO when using zalloc().
        renamed ...get_first_zero_bit() to ...acquire_first_zero_bit()

 drivers/android/binder.c          | 113 +++++++++++++++++++++---
 drivers/android/binder_internal.h |   5 +-
 drivers/android/dbitmap.h         | 139 ++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+), 14 deletions(-)
 create mode 100644 drivers/android/dbitmap.h

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index dd6923d37931..39e3d840fb96 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1045,6 +1045,67 @@ static struct binder_ref *binder_get_ref_olocked(str=
uct binder_proc *proc,
 	return NULL;
 }
=20
+/* find first non-zero available descriptor the "slow way" */
+static u32 slow_desc_lookup_olocked(struct binder_proc *proc)
+{
+	struct binder_ref *ref;
+	struct rb_node *n;
+	u32 desc;
+
+	desc =3D 1;
+	for (n =3D rb_first(&proc->refs_by_desc); n; n =3D rb_next(n)) {
+		ref =3D rb_entry(n, struct binder_ref, rb_node_desc);
+		if (ref->data.desc > desc)
+			break;
+		desc =3D ref->data.desc + 1;
+	}
+
+	return desc;
+}
+
+/*
+ * Find an available reference descriptor. Note that the proc->outer_lock
+ * might be released in the process. In such case, -EAGAIN is returned and
+ * the provided descriptor is invalid.
+ */
+static int get_ref_desc_olocked(struct binder_proc *proc,
+				struct binder_node *node,
+				u32 *desc)
+{
+	struct dbitmap *dmap =3D &proc->dmap;
+	unsigned long *new, bit;
+	unsigned int nbits;
+
+	/* 0 is reserved for the context manager */
+	if (node =3D=3D proc->context->binder_context_mgr_node) {
+		*desc =3D 0;
+		return 0;
+	}
+
+	if (unlikely(!dbitmap_enabled(dmap))) {
+		*desc =3D slow_desc_lookup_olocked(proc);
+		return 0;
+	}
+
+	if (dbitmap_acquire_first_zero_bit(dmap, &bit) =3D=3D 0) {
+		*desc =3D bit;
+		return 0;
+	}
+
+	/*
+	 * The descriptors bitmap is full and needs to be expanded.
+	 * The proc->outer_lock is briefly released to allocate the
+	 * new bitmap safely.
+	 */
+	nbits =3D dbitmap_expand_nbits(dmap);
+	binder_proc_unlock(proc);
+	new =3D bitmap_zalloc(nbits, GFP_KERNEL);
+	binder_proc_lock(proc);
+	dbitmap_expand(dmap, new, nbits);
+
+	return -EAGAIN;
+}
+
 /**
  * binder_get_ref_for_node_olocked() - get the ref associated with given n=
ode
  * @proc:	binder_proc that owns the ref
@@ -1068,12 +1129,14 @@ static struct binder_ref *binder_get_ref_for_node_o=
locked(
 					struct binder_node *node,
 					struct binder_ref *new_ref)
 {
-	struct binder_context *context =3D proc->context;
-	struct rb_node **p =3D &proc->refs_by_node.rb_node;
-	struct rb_node *parent =3D NULL;
 	struct binder_ref *ref;
-	struct rb_node *n;
+	struct rb_node *parent;
+	struct rb_node **p;
+	u32 desc;
=20
+retry:
+	p =3D &proc->refs_by_node.rb_node;
+	parent =3D NULL;
 	while (*p) {
 		parent =3D *p;
 		ref =3D rb_entry(parent, struct binder_ref, rb_node_node);
@@ -1088,6 +1151,10 @@ static struct binder_ref *binder_get_ref_for_node_ol=
ocked(
 	if (!new_ref)
 		return NULL;
=20
+	/* might release the proc->outer_lock */
+	if (get_ref_desc_olocked(proc, node, &desc) =3D=3D -EAGAIN)
+		goto retry;
+
 	binder_stats_created(BINDER_STAT_REF);
 	new_ref->data.debug_id =3D atomic_inc_return(&binder_last_id);
 	new_ref->proc =3D proc;
@@ -1095,14 +1162,7 @@ static struct binder_ref *binder_get_ref_for_node_ol=
ocked(
 	rb_link_node(&new_ref->rb_node_node, parent, p);
 	rb_insert_color(&new_ref->rb_node_node, &proc->refs_by_node);
=20
-	new_ref->data.desc =3D (node =3D=3D context->binder_context_mgr_node) ? 0=
 : 1;
-	for (n =3D rb_first(&proc->refs_by_desc); n !=3D NULL; n =3D rb_next(n)) =
{
-		ref =3D rb_entry(n, struct binder_ref, rb_node_desc);
-		if (ref->data.desc > new_ref->data.desc)
-			break;
-		new_ref->data.desc =3D ref->data.desc + 1;
-	}
-
+	new_ref->data.desc =3D desc;
 	p =3D &proc->refs_by_desc.rb_node;
 	while (*p) {
 		parent =3D *p;
@@ -1131,6 +1191,7 @@ static struct binder_ref *binder_get_ref_for_node_olo=
cked(
=20
 static void binder_cleanup_ref_olocked(struct binder_ref *ref)
 {
+	struct dbitmap *dmap =3D &ref->proc->dmap;
 	bool delete_node =3D false;
=20
 	binder_debug(BINDER_DEBUG_INTERNAL_REFS,
@@ -1138,6 +1199,8 @@ static void binder_cleanup_ref_olocked(struct binder_=
ref *ref)
 		      ref->proc->pid, ref->data.debug_id, ref->data.desc,
 		      ref->node->debug_id);
=20
+	if (dbitmap_enabled(dmap))
+		dbitmap_clear_bit(dmap, ref->data.desc);
 	rb_erase(&ref->rb_node_desc, &ref->proc->refs_by_desc);
 	rb_erase(&ref->rb_node_node, &ref->proc->refs_by_node);
=20
@@ -1298,6 +1361,25 @@ static void binder_free_ref(struct binder_ref *ref)
 	kfree(ref);
 }
=20
+/* shrink descriptor bitmap if needed */
+static void try_shrink_dmap(struct binder_proc *proc)
+{
+	unsigned long *new;
+	int nbits;
+
+	binder_proc_lock(proc);
+	nbits =3D dbitmap_shrink_nbits(&proc->dmap);
+	binder_proc_unlock(proc);
+
+	if (!nbits)
+		return;
+
+	new =3D bitmap_zalloc(nbits, GFP_KERNEL);
+	binder_proc_lock(proc);
+	dbitmap_shrink(&proc->dmap, new, nbits);
+	binder_proc_unlock(proc);
+}
+
 /**
  * binder_update_ref_for_handle() - inc/dec the ref for given handle
  * @proc:	proc containing the ref
@@ -1334,8 +1416,10 @@ static int binder_update_ref_for_handle(struct binde=
r_proc *proc,
 		*rdata =3D ref->data;
 	binder_proc_unlock(proc);
=20
-	if (delete_ref)
+	if (delete_ref) {
 		binder_free_ref(ref);
+		try_shrink_dmap(proc);
+	}
 	return ret;
=20
 err_no_ref:
@@ -4931,6 +5015,7 @@ static void binder_free_proc(struct binder_proc *proc=
)
 	put_task_struct(proc->tsk);
 	put_cred(proc->cred);
 	binder_stats_deleted(BINDER_STAT_PROC);
+	dbitmap_free(&proc->dmap);
 	kfree(proc);
 }
=20
@@ -5634,6 +5719,8 @@ static int binder_open(struct inode *nodp, struct fil=
e *filp)
 	proc =3D kzalloc(sizeof(*proc), GFP_KERNEL);
 	if (proc =3D=3D NULL)
 		return -ENOMEM;
+
+	dbitmap_init(&proc->dmap);
 	spin_lock_init(&proc->inner_lock);
 	spin_lock_init(&proc->outer_lock);
 	get_task_struct(current->group_leader);
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_int=
ernal.h
index 7270d4d22207..256bb75d9d8c 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -14,6 +14,7 @@
 #include <linux/uidgid.h>
 #include <uapi/linux/android/binderfs.h>
 #include "binder_alloc.h"
+#include "dbitmap.h"
=20
 struct binder_context {
 	struct binder_node *binder_context_mgr_node;
@@ -368,6 +369,8 @@ struct binder_ref {
  * @freeze_wait:          waitqueue of processes waiting for all outstandi=
ng
  *                        transactions to be processed
  *                        (protected by @inner_lock)
+ * @dmap                  bitmap to manage available reference descriptors
+ *                        (protected by @outer_lock)
  * @todo:                 list of work for this process
  *                        (protected by @inner_lock)
  * @stats:                per-process binder statistics
@@ -417,7 +420,7 @@ struct binder_proc {
 	bool sync_recv;
 	bool async_recv;
 	wait_queue_head_t freeze_wait;
-
+	struct dbitmap dmap;
 	struct list_head todo;
 	struct binder_stats stats;
 	struct list_head delivered_death;
diff --git a/drivers/android/dbitmap.h b/drivers/android/dbitmap.h
new file mode 100644
index 000000000000..496f3f904b6c
--- /dev/null
+++ b/drivers/android/dbitmap.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_DBITMAP_H
+#define _LINUX_DBITMAP_H
+#include <linux/bitmap.h>
+
+#define NBITS_MIN	BITS_PER_TYPE(unsigned long)
+
+struct dbitmap {
+	unsigned int nbits;
+	unsigned long *map;
+};
+
+static inline int dbitmap_enabled(struct dbitmap *dmap)
+{
+	return dmap->map !=3D NULL;
+}
+
+static inline void dbitmap_free(struct dbitmap *dmap)
+{
+	dmap->nbits =3D 0;
+	kfree(dmap->map);
+	dmap->map =3D NULL;
+}
+
+static inline unsigned int dbitmap_shrink_nbits(struct dbitmap *dmap)
+{
+	unsigned int bit;
+
+	if (dmap->nbits <=3D NBITS_MIN)
+		return 0;
+
+	bit =3D find_last_bit(dmap->map, dmap->nbits);
+	if (unlikely(bit =3D=3D dmap->nbits))
+		return NBITS_MIN;
+
+	if (unlikely(bit <=3D (dmap->nbits >> 2)))
+		return dmap->nbits >> 1;
+
+	return 0;
+}
+
+static inline void
+dbitmap_replace(struct dbitmap *dmap, unsigned long *new, unsigned int nbi=
ts)
+{
+	bitmap_copy(new, dmap->map, min(dmap->nbits, nbits));
+	kfree(dmap->map);
+	dmap->map =3D new;
+	dmap->nbits =3D nbits;
+}
+
+static inline void
+dbitmap_shrink(struct dbitmap *dmap, unsigned long *new, unsigned int nbit=
s)
+{
+	if (unlikely(!new))
+		return;
+
+	/*
+	 * Make sure we can still shrink to the requested nbits as
+	 * this call might have raced with another shrink or more
+	 * bits have been assigned. In such case, release the @new
+	 * bitmap and move on.
+	 */
+	if (unlikely(!dbitmap_enabled(dmap) ||
+		     dbitmap_shrink_nbits(dmap) !=3D nbits)) {
+		kfree(new);
+		return;
+	}
+
+	dbitmap_replace(dmap, new, nbits);
+}
+
+static inline unsigned int
+dbitmap_expand_nbits(struct dbitmap *dmap)
+{
+	return dmap->nbits << 1;
+}
+
+static inline void
+dbitmap_expand(struct dbitmap *dmap, unsigned long *new, unsigned int nbit=
s)
+{
+	/*
+	 * Determine if the expand is still valid as it might have
+	 * raced with another expand or free. In such case, release
+	 * the @new bitmap and move on.
+	 */
+	if (unlikely(!dbitmap_enabled(dmap) || nbits <=3D dmap->nbits)) {
+		kfree(new);
+		return;
+	}
+
+	/*
+	 * ENOMEM is checked here as we can now discard a potential
+	 * race with another successful expand. In such case, disable
+	 * the dbitmap and fallback to slow_desc_lookup_olocked().
+	 */
+	if (unlikely(!new)) {
+		dbitmap_free(dmap);
+		return;
+	}
+
+	dbitmap_replace(dmap, new, nbits);
+}
+
+static inline int
+dbitmap_acquire_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
+{
+	unsigned long n;
+
+	n =3D find_first_zero_bit(dmap->map, dmap->nbits);
+	if (unlikely(n =3D=3D dmap->nbits))
+		return -ENOSPC;
+
+	*bit =3D n;
+	set_bit(n, dmap->map);
+
+	return 0;
+}
+
+static inline void
+dbitmap_clear_bit(struct dbitmap *dmap, unsigned long bit)
+{
+	clear_bit(bit, dmap->map);
+}
+
+static inline int dbitmap_init(struct dbitmap *dmap)
+{
+	dmap->map =3D bitmap_zalloc(NBITS_MIN, GFP_KERNEL);
+	if (!dmap->map) {
+		dmap->nbits =3D 0;
+		return -ENOMEM;
+	}
+
+	dmap->nbits =3D NBITS_MIN;
+	/* 0 is reserved for the context manager */
+	set_bit(0, dmap->map);
+
+	return 0;
+}
+#endif
--=20
2.45.0.rc1.225.g2a3ae87e7f-goog


