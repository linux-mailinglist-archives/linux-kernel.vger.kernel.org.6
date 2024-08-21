Return-Path: <linux-kernel+bounces-295509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8E6959BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248C01F225CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A988199958;
	Wed, 21 Aug 2024 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLxsr7ZY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0754192586
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243806; cv=none; b=huALZl5XXisFTij+Qzh50NWXB9dFv10YeRpfEf5qmLUR7BSdwS4wB0waM44cNonspZs4+dzgFAsAA8JlMhND9JK4qSB+QOmVx/eAiRlXROlYSQNoHZJQV6w35hyOZ78Dea3O+9Wt0jqz7hmbtXdT5Y2Y7vW1n60NeHv8dXs8ZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243806; c=relaxed/simple;
	bh=kb6yfCuD7s6K/AHQzrVFBVg8+XRRIKgNnPIONhfxYIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmV18JoDSZfEim3y2cD6wLZsIrkakW2PL6ya57lRpfxdnI5DxrLxaAu6/Oklvvp/dex9WCe0G111sMtfY3ECKTHk7OauQJ+kvDfToblFVZG4qECqYUNOsAzSFEdkNVrHpJR63mp1tXqqnASJxyXulRRtbtqTe2vUAyPLh/cdO24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLxsr7ZY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724243804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oz5JS8PzZhZufjj9rN9JEylCZMH16sWmhd40JDN5AsI=;
	b=WLxsr7ZYZpsRUbt1Xdh53VUMnXvjQXOPwJybXfNrez6qDJe2y2m7yuoNfeqL2jLZt0UjOH
	utX+ToecYvnvf1nRhhclVq1O1Whyj5W6wUz+X/0ONfWW6p4dOc5yD4G11/QWnaZDpSxTkZ
	XJpl6AKW8aCdtPfSfyGCK/Oc+19DVrM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-nSzOlTbMOXqTvozKjZLZmQ-1; Wed,
 21 Aug 2024 08:36:43 -0400
X-MC-Unique: nSzOlTbMOXqTvozKjZLZmQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE32A1954B15;
	Wed, 21 Aug 2024 12:36:41 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63E5B1955DD8;
	Wed, 21 Aug 2024 12:36:40 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] keys: Provide a key_try_get() function and use it
Date: Wed, 21 Aug 2024 13:36:14 +0100
Message-ID: <20240821123616.60401-7-dhowells@redhat.com>
In-Reply-To: <20240821123616.60401-1-dhowells@redhat.com>
References: <20240821123616.60401-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add a key_try_get() function to try to get a ref on a key and switch code
that's manipulating the key refcount directly to use it.  This will allow a
tracepoint to be emplaced there later.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: keyrings@vger.kernel.org
cc: linux-security-module@vger.kernel.org
---
 include/linux/key.h     |  1 +
 security/keys/key.c     | 16 +++++++++++++++-
 security/keys/keyring.c |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 80d736813b89..4e5baf3e7286 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -300,6 +300,7 @@ extern struct key *key_alloc(struct key_type *type,
 extern void key_revoke(struct key *key);
 extern void key_invalidate(struct key *key);
 struct key *key_get(struct key *key);
+struct key *key_try_get(struct key *key);
 extern void key_put(struct key *key);
 extern bool key_put_tag(struct key_tag *tag);
 extern void key_remove_domain(struct key_tag *domain_tag);
diff --git a/security/keys/key.c b/security/keys/key.c
index 14c7ee77ea15..59cffb6f9b94 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -649,6 +649,20 @@ struct key *key_get(struct key *key)
 }
 EXPORT_SYMBOL(key_get);
 
+/**
+ * key_try_get - Get a ref on a key if its refcount is not non-zero.
+ * @key: The key to get a reference on.
+ *
+ * Get a reference on a key unless it has no references and return true if
+ * successful.  @key must not be NULL.
+ */
+struct key *key_try_get(struct key *key)
+{
+	if (!refcount_inc_not_zero(&key->usage))
+		return NULL;
+	return key;
+}
+
 /**
  * key_put - Discard a reference to a key.
  * @key: The key to discard a reference from.
@@ -709,7 +723,7 @@ struct key *key_lookup(key_serial_t id)
 	/* A key is allowed to be looked up only if someone still owns a
 	 * reference to it - otherwise it's awaiting the gc.
 	 */
-	if (!refcount_inc_not_zero(&key->usage))
+	if (!key_try_get(key))
 		goto not_found;
 
 error:
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index e77d927f1d4d..a09a4c2b1bcb 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1174,7 +1174,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 		/* we've got a match but we might end up racing with
 		 * key_cleanup() if the keyring is currently 'dead'
 		 * (ie. it has a zero usage count) */
-		if (!refcount_inc_not_zero(&keyring->usage))
+		if (!key_try_get(keyring))
 			continue;
 		keyring->last_used_at = ktime_get_real_seconds();
 		goto out;


