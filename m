Return-Path: <linux-kernel+bounces-295507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6A6959BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462962857DD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692F5199254;
	Wed, 21 Aug 2024 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSZzqH2d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F336192D90
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243801; cv=none; b=KJzTOrqfE1v8K6EC3YJuqh8UeNWJnaUE+XbxkTl5KAlqZ7Oy5l6eatXCldLfBKkg91Lfuz4HgUZeD+EnYe+Hab33etnhPcdS0ROAqgh56fI2drFLFh6++8C47UBB5uNXvupEd/6Qq4dtGlT8XvSuJPjKYzrl+iqsP8wUiPGUme0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243801; c=relaxed/simple;
	bh=Yautcy9ck/HanBfjk9RDHnxNHXSiPTSG9X+XqexUOe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu3y4ytfxf+KcuyEghpHGfsj6o51S+kf9e69wSWJ8e397S5L4GWNXVBdg4yVJk3nGBOq6aE2bz0iJehwuEBIkAMD5dHtPSKEwmiXRoNqI9Az/ZGhxUSXH3VW/Xlyds/5iKZoMFPGV2WBKj5ai9EH2EtJMUYrYnXvJZ/OpvrDLB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSZzqH2d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724243799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+EPM0BxZa29yRtUIP6Bqy4vu3lGbdW23TC1wKLwsMs=;
	b=YSZzqH2dYiyCmUFg2PdpTyH2WloCJhwNrQqSA7brSLcbJkeiJE6Za1sAO0/6EmvucQLF48
	CwVjITH1Go0ZS/fuzGnCWiAnGAPuLV8qR/FLSoOxddZpcw0T4SIx2mFkh86bH7qTpSAAR7
	oO+dtuEq8V+2wIKa8b/UUEk3Y6FHL/A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-TGQLKAD3MFGxqxid0qWvaw-1; Wed,
 21 Aug 2024 08:36:34 -0400
X-MC-Unique: TGQLKAD3MFGxqxid0qWvaw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A9A31954B23;
	Wed, 21 Aug 2024 12:36:33 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86D4319560AD;
	Wed, 21 Aug 2024 12:36:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] keys: Move key_get() out of line so a tracepoint can be added
Date: Wed, 21 Aug 2024 13:36:11 +0100
Message-ID: <20240821123616.60401-4-dhowells@redhat.com>
In-Reply-To: <20240821123616.60401-1-dhowells@redhat.com>
References: <20240821123616.60401-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Move key_get() out of line so that a tracepoint can be added into it
without incurring circular header dependencies or overly expanding the
callers.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: keyrings@vger.kernel.org
cc: linux-security-module@vger.kernel.org
---
 include/linux/key.h |  6 +-----
 security/keys/key.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 943a432da3ae..08062b4f807c 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -299,6 +299,7 @@ extern struct key *key_alloc(struct key_type *type,
 
 extern void key_revoke(struct key *key);
 extern void key_invalidate(struct key *key);
+struct key *key_get(struct key *key);
 extern void key_put(struct key *key);
 extern bool key_put_tag(struct key_tag *tag);
 extern void key_remove_domain(struct key_tag *domain_tag);
@@ -309,11 +310,6 @@ static inline struct key *__key_get(struct key *key)
 	return key;
 }
 
-static inline struct key *key_get(struct key *key)
-{
-	return key ? __key_get(key) : key;
-}
-
 static inline void key_ref_put(key_ref_t key_ref)
 {
 	key_put(key_ref_to_ptr(key_ref));
diff --git a/security/keys/key.c b/security/keys/key.c
index 3d7d185019d3..14c7ee77ea15 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -635,6 +635,20 @@ int key_reject_and_link(struct key *key,
 }
 EXPORT_SYMBOL(key_reject_and_link);
 
+/**
+ * key_get - Get a reference on a key
+ * @key: The key to get a reference on.
+ *
+ * Get a reference on a key, if not NULL, and return the parameter.
+ */
+struct key *key_get(struct key *key)
+{
+	if (key)
+		refcount_inc(&key->usage);
+	return key;
+}
+EXPORT_SYMBOL(key_get);
+
 /**
  * key_put - Discard a reference to a key.
  * @key: The key to discard a reference from.


