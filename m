Return-Path: <linux-kernel+bounces-181717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B438C802E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 05:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AC01F22214
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 03:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1E2DDB2;
	Fri, 17 May 2024 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GiSRI5Yh"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35A9D530
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715916548; cv=none; b=TJJiqiQ7w4ANRmZkbeekfzs1qgQaJds5S6Vqa84qZcc7VRa8+fcGoaegbBRVl9OPleiF5UXmkvlgNFK+s6ltOZD2B9KOz/bWLIgH+ZRyLSYBuHKRfnjkLb65hWFEG0YkpfPxDeOQdp0EUVnINgf8FBPkBh4kNMygAxvMRLcBruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715916548; c=relaxed/simple;
	bh=DcXdB8GNx2KcWYNHFKagw9Ps/O3VZoaqADWYxpjyocs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nlT1u6kH2TpcBhD4ASnMJJsymBmdEj8Y/uOUVbDtlH9FioYUtaMr9uV3n8VoCrWwfkqDvLGov1IHDN93Pc/WaqI0wE1b4cPu2cCuBGd0NiCpbSt2J4K37RHOqdz4dqMfbizK1GepFMJ2B4CeI5F7GQLLVShnZksrS9t6cpfHObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GiSRI5Yh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec43465046so80251675ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 20:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715916546; x=1716521346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXYj5ljf4V6lUFY+k/rklmJ4IyTKYsmTsQbIEcSBGH8=;
        b=GiSRI5YhlWati2/zfqVq4sdRV9nO4ULB5PylIG//Zjuvm4h0rndX//kPLC9Mk8vJkw
         FI/aLmMZ5WE8pJoAFoJn2gHFeQ4h9V4WXsF2nwaVpRM9+RC+a2tKo1rsGoVJSNBWjvIT
         f96yaaiCS5o23S5DcygzJpVGve/lCoGjPwCzUe5J0QXiQuUcljQ6nVdXT7z5cmtTd5EK
         sEFBgPZ5hkXKAJbLCLZ5TQViTycc5cWGH0/WOqsxxF83K4XjaW5JvPwe30DPM/m3MQxo
         w6ArLd/rIeXQ7Sq/0GynySNhc5cFY3S2cV1T82YnI6t1jfyF/uV1/rgeXV8D1ZoVwl3i
         fKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715916546; x=1716521346;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FXYj5ljf4V6lUFY+k/rklmJ4IyTKYsmTsQbIEcSBGH8=;
        b=Csnmgw/WuQTPc5Rwh6pMUdm+ujSNxidJZOB89W9A+Eh5nYm/FuDiub8gqODYY3fiY+
         jF5WfYc7+FrUYP/an7ghDVJbFYiNb2ia5UPOUGDUYZFxTogciej/uwNaEnc3aPvYFXfv
         9exDEyu4sRS8f9WTwIWvuLVlAxVVWx1fXrqz1Y2fkAXOE8q6moyz8++1r5pbcxGCZTTX
         979rdQbBj+/cL0s2jbQN7tUQ51zkZKyVGfXzTNmblT9F+PunDIrlh7OBHl9znBAM9qVG
         B9AdMrQtWdyt8UInwa9YbZjmjaivZfme30IgyVrhO1mUOY0XzLaaNsVVyzuoBx+kPt3S
         baqg==
X-Forwarded-Encrypted: i=1; AJvYcCV009z53IJrA93gdzTBjJE1ytNF39VY7WjLfTKUkkwPMosSclxzdx19AWHfaHz1wZbgVt8V8fWD6zZsoFzzm6SiMLyV0eG7xxZySExH
X-Gm-Message-State: AOJu0YyRkVz3SSzQqMQJ/wuopnWo++P/p4FhgyRncsyaGX05KDNa/7m4
	UQPRzj8eQnG3i4PZJKnKzF2ANzfEn12ooQrtHGmJz/zdjGnC0Atx1ByykcvfzN+SptnJ7NFntTo
	k8udpAY2+7Q==
X-Google-Smtp-Source: AGHT+IGm1pgzVh+nSNkG9RlbnCCf7stxvXa4P2LTeK+MqjVR3x4BdHTPcLFyDC0DLTvHlQWAbBdOHK6GdSLeTA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:903:32ce:b0:1dd:cc3f:6510 with SMTP
 id d9443c01a7336-1ef43c0fd41mr8121565ad.3.1715916546061; Thu, 16 May 2024
 20:29:06 -0700 (PDT)
Date: Fri, 17 May 2024 03:28:27 +0000
In-Reply-To: <CAH5fLgjP8eozdA3wSari2LHyVUzaOMNTU12JWb2rzGgy9RRpsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAH5fLgjP8eozdA3wSari2LHyVUzaOMNTU12JWb2rzGgy9RRpsg@mail.gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240517032849.58437-1-cmllamas@google.com>
Subject: [PATCH v4] binder: use bitmap for faster descriptor lookup
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-kernel@vger.kernel.org, 
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
index 000000000000..2cf470702bbb
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
+	if (unlikely(bit < (dmap->nbits >> 2)))
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


