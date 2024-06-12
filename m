Return-Path: <linux-kernel+bounces-210905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6799049F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E9A1C233BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23514208D4;
	Wed, 12 Jun 2024 04:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5N+rRoW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251CD29B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166348; cv=none; b=koVCg1hArvyAHNvx1fTv1eJHI0I45qkyDlV8F3uWUhe5YWlaNTSkZtqH5n1CH2Rqjpar9WmL/2cXuIXR8zGUP9VzxQGD0PVFPSEI09mt+hd0Jy5a3JHj4R/R6pfkBRqq34pijo8Lde3HUxXkEvdOgv5TZ66/aBGNy+uG/qpEyQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166348; c=relaxed/simple;
	bh=RjlRdsFfWeP+Ouej4fwIiVXlPB66OL2Q1Zw3Q0pAxRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rud3rWxsGN4R664HaVUHI3lCXwC9LyK8E+YVMjNhg16iJ2FMYU+P4C8xWv7b0NtXyHwXUbtKZ20ayjc/CYPGwKHiQF+kOYwJEH0MUsuDs5cvSDBQwPQSEsCYaHV8wSeKh3S1f5Udvd5n7EGgwt7IuhD3Nv1uqN1SkIVnT8rTPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B5N+rRoW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627dd6a56caso105294957b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718166346; x=1718771146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BWkR9xnSCmjg82HrPtfGOlFlsbnfed88Ca/4+4drV0=;
        b=B5N+rRoWLbVCrXDkSz8J1XSYS+1EWCZ3BpTo8QGQdxdQJV6MP3tTOLVIQHrr4yP4NW
         uDA5HA71XdmdQeIui3tQk09+sS8y0Pw2pdnSIkCep+sRytZLQ5A5KspX0s/WNvbo5D1a
         CE8DIXYfiZ9v0LdVI7dSjBA9YX3Q6pb6r+nXgsxCneI1OeP57p530fAoj/8k/RR/PjBf
         8Uc7y/o8R/rlf295ienLztpALjL6J0um27JmJ2hPlngstx6mpfEZQF8aSR2kKYhAyUBJ
         yEgA7KZUE2NO+I15nQMLGaw+4582woObai/hqRnGQ4NS/wtzfn9XyvC2lu6loL+5MhVE
         MJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718166346; x=1718771146;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6BWkR9xnSCmjg82HrPtfGOlFlsbnfed88Ca/4+4drV0=;
        b=smDuTpX3xwd77aMQ1tLOPdip4+5iTMPVsy19VfUURIHiXL+J3pY4L4MiBQTp0ogn8x
         Y1AY4VqIZWAAKNV7tMpNdvFaG9dzb0xKs/vTgQz8zgXjW6/0amWnNJi7DJ12WVMvfDBQ
         Kx0XIpm55FU9t2+qDVQakdHWiTPCOpf9f12wnYF2AEJOMBans+14vrGDTLszzmYKpTqw
         2VbIv3SeHq/UMrcpcIfFk5BPbC/3ImNAEIwNSs6DaS0lpVxbM2EugnHcgsvMOj5QHWyH
         DfuAjkndbQcrHDUGJvPqLVdshrEWkmgUEPcPwAylwjhDeTjm9unjkvHth7RhkTP5d3/E
         VBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUO4y1hYNCg//EfpQ0quY02h6L1JY4aJ3mXwsgpGjIO+jO3/vwa4ueMDEKY2GH1vPq3d+ewfrSevF380Ais5Zd4s39cbPP4CiaMdep
X-Gm-Message-State: AOJu0Yw1sXmNNbpQGnFgi6llKbfQJ0OaK1wNme98jk8cLr9Co1XY28rz
	onhjR03DUQJ3K4Rp56uEJouYU+unWwZq4kGb6xL4QSBZGw7iLcvffOJqWxeP5TJ67+W9Ewd2HyJ
	jBcf9gaeR9w==
X-Google-Smtp-Source: AGHT+IEjD4TDId1kniwMBagL693iz7vd1S5B8jeTeoX0lrESMpj0x8bd+ZIRQU9D+5UA1DKbFaND+LWX+tB4cQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6902:c12:b0:dfb:fb2:ebd with SMTP id
 3f1490d57ef6-dfe68a1c580mr40879276.8.1718166345966; Tue, 11 Jun 2024 21:25:45
 -0700 (PDT)
Date: Wed, 12 Jun 2024 04:25:13 +0000
In-Reply-To: <2024060442-fedora-maybe-e857@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024060442-fedora-maybe-e857@gregkh>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240612042535.1556708-1-cmllamas@google.com>
Subject: [PATCH v5] binder: use bitmap for faster descriptor lookup
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Tim Murray <timmurray@google.com>, 
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
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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
   =20
    v4: fix bit range check for 25% bitmap capacity.
   =20
    v5: Per gregkh's feedback:
        - fix new file copyright line according to Google's policy
        - add plenty of comments documenting dbitmap's behavior
        - drop (un)likely() and let compiler/cpu do a better job
        - use dmap->nbits to determine if dbitmap is disabled
        Also:
        - make sure dbitmap can't clear BIT(0)
        - rename "_expand()" to "_grow()"

 drivers/android/binder.c          | 112 ++++++++++++++++---
 drivers/android/binder_internal.h |   5 +-
 drivers/android/dbitmap.h         | 176 ++++++++++++++++++++++++++++++
 3 files changed, 279 insertions(+), 14 deletions(-)
 create mode 100644 drivers/android/dbitmap.h

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b21a7b246a0d..0c2161b1f057 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1045,6 +1045,66 @@ static struct binder_ref *binder_get_ref_olocked(str=
uct binder_proc *proc,
 	return NULL;
 }
=20
+/* Find the smallest unused descriptor the "slow way" */
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
+ * Find an available reference descriptor ID. The proc->outer_lock might
+ * be released in the process, in which case -EAGAIN is returned and the
+ * @desc should be considered invalid.
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
+	if (!dbitmap_enabled(dmap)) {
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
+	 * The dbitmap is full and needs to grow. The proc->outer_lock
+	 * is briefly released to allocate the new bitmap safely.
+	 */
+	nbits =3D dbitmap_grow_nbits(dmap);
+	binder_proc_unlock(proc);
+	new =3D bitmap_zalloc(nbits, GFP_KERNEL);
+	binder_proc_lock(proc);
+	dbitmap_grow(dmap, new, nbits);
+
+	return -EAGAIN;
+}
+
 /**
  * binder_get_ref_for_node_olocked() - get the ref associated with given n=
ode
  * @proc:	binder_proc that owns the ref
@@ -1068,12 +1128,14 @@ static struct binder_ref *binder_get_ref_for_node_o=
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
@@ -1088,6 +1150,10 @@ static struct binder_ref *binder_get_ref_for_node_ol=
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
@@ -1095,14 +1161,7 @@ static struct binder_ref *binder_get_ref_for_node_ol=
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
@@ -1131,6 +1190,7 @@ static struct binder_ref *binder_get_ref_for_node_olo=
cked(
=20
 static void binder_cleanup_ref_olocked(struct binder_ref *ref)
 {
+	struct dbitmap *dmap =3D &ref->proc->dmap;
 	bool delete_node =3D false;
=20
 	binder_debug(BINDER_DEBUG_INTERNAL_REFS,
@@ -1138,6 +1198,8 @@ static void binder_cleanup_ref_olocked(struct binder_=
ref *ref)
 		      ref->proc->pid, ref->data.debug_id, ref->data.desc,
 		      ref->node->debug_id);
=20
+	if (dbitmap_enabled(dmap))
+		dbitmap_clear_bit(dmap, ref->data.desc);
 	rb_erase(&ref->rb_node_desc, &ref->proc->refs_by_desc);
 	rb_erase(&ref->rb_node_node, &ref->proc->refs_by_node);
=20
@@ -1298,6 +1360,25 @@ static void binder_free_ref(struct binder_ref *ref)
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
@@ -1334,8 +1415,10 @@ static int binder_update_ref_for_handle(struct binde=
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
@@ -4931,6 +5014,7 @@ static void binder_free_proc(struct binder_proc *proc=
)
 	put_task_struct(proc->tsk);
 	put_cred(proc->cred);
 	binder_stats_deleted(BINDER_STAT_PROC);
+	dbitmap_free(&proc->dmap);
 	kfree(proc);
 }
=20
@@ -5634,6 +5718,8 @@ static int binder_open(struct inode *nodp, struct fil=
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
index 5b7c80b99ae8..7d4fc53f7a73 100644
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
+ * @dmap                  dbitmap to manage available reference descriptor=
s
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
index 000000000000..b8ac7b4764fd
--- /dev/null
+++ b/drivers/android/dbitmap.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2024 Google LLC
+ *
+ * dbitmap - dynamically sized bitmap library.
+ *
+ * Used by the binder driver to optimize the allocation of the smallest
+ * available descriptor ID. Each bit in the bitmap represents the state
+ * of an ID, with the exception of BIT(0) which is used exclusively to
+ * reference binder's context manager.
+ *
+ * A dbitmap can grow or shrink as needed. This part has been designed
+ * considering that users might need to briefly release their locks in
+ * order to allocate memory for the new bitmap. These operations then,
+ * are verified to determine if the grow or shrink is sill valid.
+ *
+ * This library does not provide protection against concurrent access
+ * by itself. Binder uses the proc->outer_lock for this purpose.
+ */
+
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
+	return !!dmap->nbits;
+}
+
+static inline void dbitmap_free(struct dbitmap *dmap)
+{
+	dmap->nbits =3D 0;
+	kfree(dmap->map);
+}
+
+/* Returns the nbits that a dbitmap can shrink to, 0 if not possible. */
+static inline unsigned int dbitmap_shrink_nbits(struct dbitmap *dmap)
+{
+	unsigned int bit;
+
+	if (dmap->nbits <=3D NBITS_MIN)
+		return 0;
+
+	/*
+	 * Determine if the bitmap can shrink based on the position of
+	 * its last set bit. If the bit is within the first quarter of
+	 * the bitmap then shrinking is possible. In this case, the
+	 * bitmap should shrink to half its current size.
+	 */
+	bit =3D find_last_bit(dmap->map, dmap->nbits);
+	if (bit < (dmap->nbits >> 2))
+		return dmap->nbits >> 1;
+
+	/*
+	 * Note that find_last_bit() returns dmap->nbits when no bits
+	 * are set. While this is technically not possible here since
+	 * BIT(0) is always set, this check is left for extra safety.
+	 */
+	if (bit =3D=3D dmap->nbits)
+		return NBITS_MIN;
+
+	return 0;
+}
+
+/* Replace the internal bitmap with a new one of different size */
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
+	if (!new)
+		return;
+
+	/*
+	 * Verify that shrinking to @nbits is still possible. The @new
+	 * bitmap might have been allocated without locks, so this call
+	 * could now be outdated. In this case, free @new and move on.
+	 */
+	if (!dbitmap_enabled(dmap) || dbitmap_shrink_nbits(dmap) !=3D nbits) {
+		kfree(new);
+		return;
+	}
+
+	dbitmap_replace(dmap, new, nbits);
+}
+
+/* Returns the nbits that a dbitmap can grow to. */
+static inline unsigned int dbitmap_grow_nbits(struct dbitmap *dmap)
+{
+	return dmap->nbits << 1;
+}
+
+static inline void
+dbitmap_grow(struct dbitmap *dmap, unsigned long *new, unsigned int nbits)
+{
+	/*
+	 * Verify that growing to @nbits is still possible. The @new
+	 * bitmap might have been allocated without locks, so this call
+	 * could now be outdated. In this case, free @new and move on.
+	 */
+	if (!dbitmap_enabled(dmap) || nbits <=3D dmap->nbits) {
+		kfree(new);
+		return;
+	}
+
+	/*
+	 * Check for ENOMEM after confirming the grow operation is still
+	 * required. This ensures we only disable the dbitmap when it's
+	 * necessary. Once the dbitmap is disabled, binder will fallback
+	 * to slow_desc_lookup_olocked().
+	 */
+	if (!new) {
+		dbitmap_free(dmap);
+		return;
+	}
+
+	dbitmap_replace(dmap, new, nbits);
+}
+
+/*
+ * Finds and sets the first zero bit in the bitmap. Upon success @bit
+ * is populated with the index and 0 is returned. Otherwise, -ENOSPC
+ * is returned to indicate that a dbitmap_grow() is needed.
+ */
+static inline int
+dbitmap_acquire_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
+{
+	unsigned long n;
+
+	n =3D find_first_zero_bit(dmap->map, dmap->nbits);
+	if (n =3D=3D dmap->nbits)
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
+	/* BIT(0) should always set for the context manager */
+	if (bit)
+		clear_bit(bit, dmap->map);
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
+	/* BIT(0) is reserved for the context manager */
+	set_bit(0, dmap->map);
+
+	return 0;
+}
+#endif
--=20
2.45.2.505.gda0bf45e8d-goog


