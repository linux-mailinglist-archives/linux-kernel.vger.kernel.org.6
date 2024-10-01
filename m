Return-Path: <linux-kernel+bounces-346338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF098C34F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F3B5B2579E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE811CCB2E;
	Tue,  1 Oct 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AplgA1Xt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nmoIQ+CX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B51CC8BB
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799661; cv=none; b=aqYddRdyHWGqcPljsHXS13Mn4ohd8tzO225PGuQXxCQvi8zCruvUXfNxs273d6+KG2Q/6kliSrrVTaVM5K5MCXruYZvMAqUYlBug7fBsZSNsw+lTymTWmW60DANyO68MYARjEko6pRfHQmE11UljMtw+qhpZ18ZQGDqczFdqBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799661; c=relaxed/simple;
	bh=TRsmmRP/EWgsJv7xhYSQr8KrDcVZgvvGzDXsh4rZO7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqYryzfqXuoaiyG9ChUhF1sWxbXOEKVHMHiialxJnSPBnw3NMvVR+rqEj2JvCx5CYRESbMJ/ckWiuFPhd5b+Uaq6C3YfrxsvwwCALtzTYh8MXYbxsYrKgyXcdhKB0UUOf6kvVQBDxo/JdH/Eff7UHVokTpJvKLtU+lIVnbMmQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AplgA1Xt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nmoIQ+CX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB1D01F8B6;
	Tue,  1 Oct 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727799656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bU8OM+Iu2SHVDtuN47aGhbiaVQFgLBj/nNrko3LpMpM=;
	b=AplgA1XtGYRXzB6PXy7uviOBDeqydI1+9DKBaPwDyWgxprNQNR+mRLU3eAJdfncpUvht8g
	Eplfl7pP/wzPnicXDDTN87W9WtZvAjeGzybAjMOwsEAnwRTEEfcYhAnoG3SUECAiBUIzGY
	atzAnPFulgJBkbopKu32Gr+7PQxgVWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727799656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bU8OM+Iu2SHVDtuN47aGhbiaVQFgLBj/nNrko3LpMpM=;
	b=nmoIQ+CXr6aMq3n3w3gA9SVIiKm5Ar3CYSldzOJWri8NgHg5EN1g+YEfoRY4zsj8j46zmw
	JT7K6u5z85UwIzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B346C13A8A;
	Tue,  1 Oct 2024 16:20:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2BNXK2gh/GaHRAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 01 Oct 2024 16:20:56 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 01 Oct 2024 18:20:48 +0200
Subject: [PATCH slab hotfixes v2 1/2] mm, slab: suppress warnings in
 test_leak_destroy kunit test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-b4-slub-kunit-fix-v2-1-2d995d3ecb49@suse.cz>
References: <20241001-b4-slub-kunit-fix-v2-0-2d995d3ecb49@suse.cz>
In-Reply-To: <20241001-b4-slub-kunit-fix-v2-0-2d995d3ecb49@suse.cz>
To: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, 
 kernel test robot <oliver.sang@intel.com>, 
 Guenter Roeck <linux@roeck-us.net>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: DB1D01F8B6
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

The test_leak_destroy kunit test intends to test the detection of stray
objects in kmem_cache_destroy(), which normally produces a warning. The
other slab kunit tests suppress the warnings in the kunit test context,
so suppress warnings and related printk output in this test as well.
Automated test running environments then don't need to learn to filter
the warnings.

Also rename the test's kmem_cache, the name was wrongly copy-pasted from
test_kfree_rcu.

Fixes: 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and test_leak_destroy()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202408251723.42f3d902-oliver.sang@intel.com
Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Closes: https://lore.kernel.org/all/CAB=+i9RHHbfSkmUuLshXGY_ifEZg9vCZi3fqr99+kmmnpDus7Q@mail.gmail.com/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net/
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/slub_kunit.c | 4 ++--
 mm/slab.h        | 6 ++++++
 mm/slab_common.c | 5 +++--
 mm/slub.c        | 5 +++--
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 6e3a1e5a7142f797fe20a28967657f50a466d4ee..85d51ec09846d4fa219db6bda336c6f0b89e98e4 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -177,13 +177,13 @@ static void test_kfree_rcu(struct kunit *test)
 
 static void test_leak_destroy(struct kunit *test)
 {
-	struct kmem_cache *s = test_kmem_cache_create("TestSlub_kfree_rcu",
+	struct kmem_cache *s = test_kmem_cache_create("TestSlub_leak_destroy",
 							64, SLAB_NO_MERGE);
 	kmem_cache_alloc(s, GFP_KERNEL);
 
 	kmem_cache_destroy(s);
 
-	KUNIT_EXPECT_EQ(test, 1, slab_errors);
+	KUNIT_EXPECT_EQ(test, 2, slab_errors);
 }
 
 static int test_init(struct kunit *test)
diff --git a/mm/slab.h b/mm/slab.h
index f22fb760b2866124d9d873d28b5a7fa6867aeb90..5cf0fbab0b0554ee70f5371772bc37b290893b8a 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -546,6 +546,12 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
 	return false;
 }
 
+#if IS_ENABLED(CONFIG_SLUB_DEBUG) && IS_ENABLED(CONFIG_KUNIT)
+bool slab_in_kunit_test(void);
+#else
+static inline bool slab_in_kunit_test(void) { return false; }
+#endif
+
 #ifdef CONFIG_SLAB_OBJ_EXT
 
 /*
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7443244656150325fb2a7d0158a71821e1418062..3d26c257ed8b57c336ec5c38d4bbd5f5e51d50ff 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -508,8 +508,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	kasan_cache_shutdown(s);
 
 	err = __kmem_cache_shutdown(s);
-	WARN(err, "%s %s: Slab cache still has objects when called from %pS",
-	     __func__, s->name, (void *)_RET_IP_);
+	if (!slab_in_kunit_test())
+		WARN(err, "%s %s: Slab cache still has objects when called from %pS",
+		     __func__, s->name, (void *)_RET_IP_);
 
 	list_del(&s->list);
 
diff --git a/mm/slub.c b/mm/slub.c
index 21f71cb6cc06d951a657290421f41170bb3c76cf..5b832512044e3ead8ccde2c02308bd8954246db5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -827,7 +827,7 @@ static bool slab_add_kunit_errors(void)
 	return true;
 }
 
-static bool slab_in_kunit_test(void)
+bool slab_in_kunit_test(void)
 {
 	struct kunit_resource *resource;
 
@@ -843,7 +843,6 @@ static bool slab_in_kunit_test(void)
 }
 #else
 static inline bool slab_add_kunit_errors(void) { return false; }
-static inline bool slab_in_kunit_test(void) { return false; }
 #endif
 
 static inline unsigned int size_from_object(struct kmem_cache *s)
@@ -5436,6 +5435,8 @@ static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
 	for_each_object(p, s, addr, slab->objects) {
 
 		if (!test_bit(__obj_to_index(s, addr, p), object_map)) {
+			if (slab_add_kunit_errors())
+				continue;
 			pr_err("Object 0x%p @offset=%tu\n", p, p - addr);
 			print_tracking(s, p);
 		}

-- 
2.46.1


