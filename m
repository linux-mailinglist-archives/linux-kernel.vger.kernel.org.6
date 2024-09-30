Return-Path: <linux-kernel+bounces-343581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F54989CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1A2B23DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F7817C7CB;
	Mon, 30 Sep 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eapi/7j4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZNY4OLn4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JtOhNOU6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8/CDxZyy"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1217B4FC
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685473; cv=none; b=OMC+torNh5puIbGr2tfM7xtck4UORvjGMHgXDApnGzPQez4EQIiGoS1ohwiO0ITn6ZFmQglVcvK7m38ct4IM8L3M31dgeph0MD6GO9wxekhdEsxnV3wL4XpefWOM1YLZKBR/LsvBEFTg2kEj4lqRpbLtJmE36B01qGAdtCmrACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685473; c=relaxed/simple;
	bh=TRsmmRP/EWgsJv7xhYSQr8KrDcVZgvvGzDXsh4rZO7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KKOdWYdQOwwksWrwh9b0bcVfNTGuyE840Fbx42eZkJ5VF/m1ujgVVOXpaa4mX6JGs9CiE0SGEI+NQPnSqzQIgnPEfZ5BGo6azfhV4DhJjU4erCWMTO0XiO2pRfgdlNJSpED7omGPU/EjI8HhyVaHB4nLDSCtckDet1OH4tzAlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eapi/7j4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZNY4OLn4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JtOhNOU6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8/CDxZyy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E2075218B0;
	Mon, 30 Sep 2024 08:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727685470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bU8OM+Iu2SHVDtuN47aGhbiaVQFgLBj/nNrko3LpMpM=;
	b=eapi/7j47CIR610xcRtKWaTmoHGo9tQ41p+LljS7/4ctWF12FebGE92rkIQHS6X9YC6n/Y
	YX7mxFyHEDuS9jLgYxgGc4xVPTk/plfmIoapm+WziYVh7iXEEjXbwZm9ZpXzXXY0aSEhAu
	F/wAA1JShOoBov2YNMdf3z+eyryuswA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727685470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bU8OM+Iu2SHVDtuN47aGhbiaVQFgLBj/nNrko3LpMpM=;
	b=ZNY4OLn49qpjeyHj7FJmKolvZwxe4QR0VErbjWZ84tXTTRje2sxEYOLZohougT/VkEXqhj
	jtHc5vApQulIDiAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JtOhNOU6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="8/CDxZyy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727685469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bU8OM+Iu2SHVDtuN47aGhbiaVQFgLBj/nNrko3LpMpM=;
	b=JtOhNOU6urOKMDlg889U7b+6rrtIhOCKQVNij+lQJl/a/TgKVx/e2oqRtDPYEhGfupvcPK
	MM0rJFLZv8eX8G+KH4aeYoZf+CPI5GrVqtBY3OvWw0sgUjuGRrEIt9SbgaP+VRFBqY0n1c
	h9pQpQs+0uU+0BGX3byz8P66mC4dHds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727685469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bU8OM+Iu2SHVDtuN47aGhbiaVQFgLBj/nNrko3LpMpM=;
	b=8/CDxZyyA/rjYBHfb7Uid2wz8hwIjQwkA0Dn8TUi4nwChZkpd9+zQw1yqSrzk+4heLlE5V
	cQNH+6m55W1woGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0ADE13A97;
	Mon, 30 Sep 2024 08:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SBnFLl1j+mYhHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 30 Sep 2024 08:37:49 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 30 Sep 2024 10:37:16 +0200
Subject: [PATCH slab hotfixes 1/2] mm, slab: suppress warnings in
 test_leak_destroy kunit test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-b4-slub-kunit-fix-v1-1-32ca9dbbbc11@suse.cz>
References: <20240930-b4-slub-kunit-fix-v1-0-32ca9dbbbc11@suse.cz>
In-Reply-To: <20240930-b4-slub-kunit-fix-v1-0-32ca9dbbbc11@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, 
 Guenter Roeck <linux@roeck-us.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4054; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=TRsmmRP/EWgsJv7xhYSQr8KrDcVZgvvGzDXsh4rZO7U=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBm+mNYIupbfQOMIbodDHrMfP0p13Sj7mMKww+on
 0VZNDz4lsmJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZvpjWAAKCRC74LB10kWI
 moqTB/4yOcUChFNz4v0h8ffjMzyiKsgWuPz70yOFy93E0AfuSaY3mqUC4SVx+OEinFKyOoJBKpt
 bQbR6Sn4JxJ034jdGWYUIbAEhmH0bhkPWV92Dw1HVKxVEXGuBaUvekt9ARvenbhs0IA7iEiaJcN
 /UJdiV3/UShFK1R/BaROKDPTN+kwN8IobcXcRE/Tf4uCHQzIpVbuo6940GjzHBZ8OUMyGnakW8w
 D+oZ2Y0QQJd3Wc2m60impMHrLLQAIuRM9yk1ymuU/8yIwDmKOpS38uyQFUx/iZnw46TxFMit3+1
 GSy+LWYKeqjeNGVmFdFFp0PSI+qR3lwKjSRu5diKac1Ehdfh
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Rspamd-Queue-Id: E2075218B0
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,linux.com,google.com,linux.dev,gmail.com,vger.kernel.org,kvack.org,suse.cz];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhc4kaujr6ihojcnjq7c1jwbi)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

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


