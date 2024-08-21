Return-Path: <linux-kernel+bounces-295510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F75A959BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31AF1C219FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7104192D69;
	Wed, 21 Aug 2024 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6hFqhqL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FAE196D90
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243807; cv=none; b=WswiuVmUuGeGE4V13hx0TlekDdUn3yaDToVN6PEC3GIXNSNwj5Ly0+xGuZt5sTjg7yglx8OC75rBBxYpJlqvN+tXF+5iu1DJr+RsyFKEAaYs4MV34+4Ha8aJroEUZze2CJsBaSfwJVQeOzW5n7v7kyJhD0ZWP1Pz3qT+RhKBEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243807; c=relaxed/simple;
	bh=POSRcUENXI3EPk3+g/oKXBGninv57eRKGcZLPy9oZh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvEqvJinbkw2pk3nPYaFsdoDpqrh839lyMdiF3RSmrtBuf4tT5zggHOUWx3Sg8Hev1GAGtmg0L9Qc/1xedLgkngyYVWpl+AhaclhXD/nFDps23nvyuzdzfCGVTyKFU7YhNkZrwaUC8TG+VO8Tzvsm62CtVx74OuRk5Ga8jA3PFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6hFqhqL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724243804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aC1VMLaM7iGzjE0S+YKf7RFlhMIrzMBJdSI6+j4wcG0=;
	b=Z6hFqhqLC87X+7Qhlg6EeuxEFz8Plh+TygCfVn08rHerjS5dXNFb+3Sdgw4BGgnMuiEQ1+
	0KVk/RXeif03v4URR3QSO8lx6akD0i81ki9OXCAOfPiXHBkFBnJq67rVrO/1E4MRZTjAYx
	MdLQhNerTPhDijDIkSkxqa7lPC7oxrQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-HZ4uwCiUMHe_IVN9rk_Ueg-1; Wed,
 21 Aug 2024 08:36:40 -0400
X-MC-Unique: HZ4uwCiUMHe_IVN9rk_Ueg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2DC51955BF7;
	Wed, 21 Aug 2024 12:36:38 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BD1C1956053;
	Wed, 21 Aug 2024 12:36:37 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] keys: Use key_get() instead of __key_get()
Date: Wed, 21 Aug 2024 13:36:13 +0100
Message-ID: <20240821123616.60401-6-dhowells@redhat.com>
In-Reply-To: <20240821123616.60401-1-dhowells@redhat.com>
References: <20240821123616.60401-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Switch users of __key_get() over to key_get() so that they benefit from the
future tracepointage thereof also and remove __key_get().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: keyrings@vger.kernel.org
cc: linux-security-module@vger.kernel.org
---
 Documentation/security/keys/core.rst |  1 -
 crypto/asymmetric_keys/restrict.c    |  6 +++---
 include/linux/key.h                  |  6 ------
 security/keys/keyring.c              |  4 ++--
 security/keys/process_keys.c         | 15 ++++++---------
 5 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 326b8a973828..0b179540d885 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -1217,7 +1217,6 @@ payload contents" for more information.
  *  Extra references can be made to a key by calling one of the following
     functions::
 
-	struct key *__key_get(struct key *key);
 	struct key *key_get(struct key *key);
 
     Keys so references will need to be disposed of by calling key_put() when
diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index afcd4d101ac5..1ea7bfd4e5d7 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -267,20 +267,20 @@ static int key_or_keyring_common(struct key *dest_keyring,
 			if (!sig->auth_ids[0] && !sig->auth_ids[1]) {
 				if (asymmetric_key_id_same(signer_ids[2],
 							   sig->auth_ids[2]))
-					key = __key_get(trusted);
+					key = key_get(trusted);
 
 			} else if (!sig->auth_ids[0] || !sig->auth_ids[1]) {
 				const struct asymmetric_key_id *auth_id;
 
 				auth_id = sig->auth_ids[0] ?: sig->auth_ids[1];
 				if (match_either_id(signer_ids, auth_id))
-					key = __key_get(trusted);
+					key = key_get(trusted);
 
 			} else if (asymmetric_key_id_same(signer_ids[1],
 							  sig->auth_ids[1]) &&
 				   match_either_id(signer_ids,
 						   sig->auth_ids[0])) {
-				key = __key_get(trusted);
+				key = key_get(trusted);
 			}
 		} else {
 			return -EOPNOTSUPP;
diff --git a/include/linux/key.h b/include/linux/key.h
index 50a19e5f9e45..80d736813b89 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -304,12 +304,6 @@ extern void key_put(struct key *key);
 extern bool key_put_tag(struct key_tag *tag);
 extern void key_remove_domain(struct key_tag *domain_tag);
 
-static inline struct key *__key_get(struct key *key)
-{
-	refcount_inc(&key->usage);
-	return key;
-}
-
 static inline void key_ref_put(key_ref_t key_ref)
 {
 	key_put(key_ref_to_ptr(key_ref));
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 7f02b913c560..e77d927f1d4d 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1122,7 +1122,7 @@ key_ref_t find_key_to_update(key_ref_t keyring_ref,
 		kleave(" = NULL [x]");
 		return NULL;
 	}
-	__key_get(key);
+	key_get(key);
 	kleave(" = {%d}", key->serial);
 	return make_key_ref(key, is_key_possessed(keyring_ref));
 }
@@ -1367,7 +1367,7 @@ int __key_link_check_live_key(struct key *keyring, struct key *key)
 void __key_link(struct key *keyring, struct key *key,
 		struct assoc_array_edit **_edit)
 {
-	__key_get(key);
+	key_get(key);
 	assoc_array_insert_set_object(*_edit, keyring_key_to_ptr(key));
 	assoc_array_apply_edit(*_edit);
 	*_edit = NULL;
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index b5d5333ab330..01291b2d0888 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -333,7 +333,7 @@ int install_session_keyring_to_cred(struct cred *cred, struct key *keyring)
 		if (IS_ERR(keyring))
 			return PTR_ERR(keyring);
 	} else {
-		__key_get(keyring);
+		key_get(keyring);
 	}
 
 	/* install the keyring */
@@ -641,7 +641,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		}
 
 		key = ctx.cred->thread_keyring;
-		__key_get(key);
+		key_get(key);
 		key_ref = make_key_ref(key, 1);
 		break;
 
@@ -658,8 +658,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 			goto reget_creds;
 		}
 
-		key = ctx.cred->process_keyring;
-		__key_get(key);
+		key = key_get(ctx.cred->process_keyring);
 		key_ref = make_key_ref(key, 1);
 		break;
 
@@ -688,8 +687,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 			goto reget_creds;
 		}
 
-		key = ctx.cred->session_keyring;
-		__key_get(key);
+		key = key_get(ctx.cred->session_keyring);
 		key_ref = make_key_ref(key, 1);
 		break;
 
@@ -717,7 +715,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		if (!key)
 			goto error;
 
-		__key_get(key);
+		key_get(key);
 		key_ref = make_key_ref(key, 1);
 		break;
 
@@ -732,8 +730,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 			key = NULL;
 		} else {
 			rka = ctx.cred->request_key_auth->payload.data[0];
-			key = rka->dest_keyring;
-			__key_get(key);
+			key = key_get(rka->dest_keyring);
 		}
 		up_read(&ctx.cred->request_key_auth->sem);
 		if (!key)


