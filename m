Return-Path: <linux-kernel+bounces-330360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC12A979D18
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE9528304D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD013DDDF;
	Mon, 16 Sep 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EVPPzeXp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nr85X2Rg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E26B487A7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476249; cv=none; b=Cx3Jxbot4NensNJcpyJ0gcyRIi7+ZVxu9OpckEzz4mxUS8XjKLHdTkHve4MxhhR863fuABod1AHLLwZriOYXXbZ0hbic8/+Luv+1F3wHrRg+gcWM5JgMsdtfESiD+GrsrS1wqU4ukflAYAwbR748n+zYLTrwMp3NEboHQ1XaldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476249; c=relaxed/simple;
	bh=FGUcE5IXZf6gxCZRrVUSsewzF6Fn3dR4xtCRhwgA+wQ=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=DSqj4kalJE45VGtDEjzGGs62UFXRp3j8EKQ1AzMd5MILYSs876rol75lQlI/g6Axtfasz/LppxCeEoWVKgr+qCc9VReDDGUL1Bw582I7/LA7/bgkqxRoEd49ZTz0UBdmQQwWfup7gUUMBpf8OFYBsyqOBDN6V2VFTpyPISGUdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EVPPzeXp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nr85X2Rg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726476246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XnVKUIb/7DABqHz/gYtb58fK8zEm+TR05A//rwx3e6g=;
	b=EVPPzeXpqUBfi0fJBtP9QZLo1TEYYQACq+sYLVZGJsIDyXzrmUNhboyKPkekvCXfV6y937
	Qd6QHaZMqB6+EaF/dacRR0t4+T1su9+Y5SPAy8OP2IU4Nam/0ytzJDPkqx35R5t3cz1Upw
	n3bNzZCWcf6YHa46rP1sG2EMB+PBv66rFZT1tGG2E5MpApAyeFCQ0EvxbynDlTCdooGJ7u
	xd4+ffd51d0TzEi1TmC+djmHFgRf7Mw4Bf+EJ5AME43lmmPVh4KD1ghxv/ua+ESBqAndFy
	DlkgBu4ys+rgLH6V4Wa1pAARQUfmZg7cmonXonhP7eoLa7HPmiRFRTEJ+Fcg7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726476246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XnVKUIb/7DABqHz/gYtb58fK8zEm+TR05A//rwx3e6g=;
	b=nr85X2RgR5LTQ3ANr+X/0W/LhWmZQW5sb/vXdVZpHZSpYV+xzKZFrTDRLHQR8G6zZV5JHg
	YO5mvm2ba8/WnNAg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/debugobjects for v6.12-rc1
Message-ID: <172647588843.2450257.3544233832195550173.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Sep 2024 10:44:05 +0200 (CEST)

Linus,

please pull the latest core/debugobjects branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobject=
s-2024-09-16

up to:  63a4a9b52c3c: debugobjects: Remove redundant checks in fill_pool()


A set of updates for debugobjects:

  - Use the threshold to check for the pool refill condition and not the
    run time recorded all time low fill value, which is lower than the
    threshold and therefore causes refills to be delayed.

  - KCSAN annotation updates and simplification of the fill_pool() code.

Thanks,

	tglx

------------------>
Zhen Lei (3):
      debugobjects: Fix the compilation attributes of some global variables
      debugobjects: Fix conditions in fill_pool()
      debugobjects: Remove redundant checks in fill_pool()


 lib/debugobjects.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7cea91e193a8..5ce473ad499b 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -70,10 +70,10 @@ static HLIST_HEAD(obj_to_free);
  * made at debug_stats_show(). Both obj_pool_min_free and obj_pool_max_used
  * can be off.
  */
-static int			obj_pool_min_free =3D ODEBUG_POOL_SIZE;
-static int			obj_pool_free =3D ODEBUG_POOL_SIZE;
+static int __data_racy		obj_pool_min_free =3D ODEBUG_POOL_SIZE;
+static int __data_racy		obj_pool_free =3D ODEBUG_POOL_SIZE;
 static int			obj_pool_used;
-static int			obj_pool_max_used;
+static int __data_racy		obj_pool_max_used;
 static bool			obj_freeing;
 /* The number of objs on the global free list */
 static int			obj_nr_tofree;
@@ -84,9 +84,9 @@ static int __data_racy			debug_objects_fixups __read_mostly;
 static int __data_racy			debug_objects_warnings __read_mostly;
 static int __data_racy			debug_objects_enabled __read_mostly
 					=3D CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
-static int __data_racy			debug_objects_pool_size __read_mostly
+static int				debug_objects_pool_size __ro_after_init
 					=3D ODEBUG_POOL_SIZE;
-static int __data_racy			debug_objects_pool_min_level __read_mostly
+static int				debug_objects_pool_min_level __ro_after_init
 					=3D ODEBUG_POOL_MIN_LEVEL;
=20
 static const struct debug_obj_descr *descr_test  __read_mostly;
@@ -95,8 +95,8 @@ static struct kmem_cache	*obj_cache __ro_after_init;
 /*
  * Track numbers of kmem_cache_alloc()/free() calls done.
  */
-static int			debug_objects_allocated;
-static int			debug_objects_freed;
+static int __data_racy		debug_objects_allocated;
+static int __data_racy		debug_objects_freed;
=20
 static void free_obj_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(debug_obj_work, free_obj_work);
@@ -135,20 +135,19 @@ static void fill_pool(void)
 		return;
=20
 	/*
-	 * Reuse objs from the global free list; they will be reinitialized
-	 * when allocating.
+	 * Reuse objs from the global obj_to_free list; they will be
+	 * reinitialized when allocating.
 	 *
-	 * Both obj_nr_tofree and obj_pool_free are checked locklessly; the
-	 * READ_ONCE()s pair with the WRITE_ONCE()s in pool_lock critical
-	 * sections.
+	 * obj_nr_tofree is checked locklessly; the READ_ONCE() pairs with
+	 * the WRITE_ONCE() in pool_lock critical sections.
 	 */
-	while (READ_ONCE(obj_nr_tofree) && (READ_ONCE(obj_pool_free) < obj_pool_min=
_free)) {
+	if (READ_ONCE(obj_nr_tofree)) {
 		raw_spin_lock_irqsave(&pool_lock, flags);
 		/*
 		 * Recheck with the lock held as the worker thread might have
 		 * won the race and freed the global free list already.
 		 */
-		while (obj_nr_tofree && (obj_pool_free < obj_pool_min_free)) {
+		while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
 			obj =3D hlist_entry(obj_to_free.first, typeof(*obj), node);
 			hlist_del(&obj->node);
 			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);


