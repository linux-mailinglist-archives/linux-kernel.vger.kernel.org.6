Return-Path: <linux-kernel+bounces-295508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC4A959BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837371C21957
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F68B199925;
	Wed, 21 Aug 2024 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiPJDM3F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8117418C929
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243803; cv=none; b=CaHfpVGKHg14dVusEPk1XxNptYg4gnhSrKJn2kMeTLiXh4Hrcie7NANr7qzlQj+SISXt2kth2/MojB6jQseegzMcuyyBcAAbNdIFr/2eGDP126fDPgc3NhGBi3TRfoZecNneSjO4bZipALlN2sf3KGPIpYkxGrGG0CLpaP5DH5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243803; c=relaxed/simple;
	bh=oivQtnOu9efmEnO/ADZ+WlTYAALrj3lzSKJQB2IwQIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqAPMs3jdIF/gJQj6ZbH4788Wi2bQyxmvEsQs35MhvtKffm2plx2ESVVkdkgRCGD0s9R6eaOsK+EEriIO/gzhyRAoPpRNQ3LuNKToUDDIhvk/ZZiZG3mkcUQIXmwwyWKDpMZ0ODoWLnuzquXWzoq/2EqOBrM8Y5jVoraW0un4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iiPJDM3F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724243800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXncICABB6w0gnMhh6f892KrTOfN/hhwAjfLKmFuv/M=;
	b=iiPJDM3F5K1rc9PfVlMguvGf7InTFCmK3TlQjmuxE2CnVKysUsnTPR294kyZ5Zq/RCtwh0
	VrqL2kCbAteA/oNd6xYbw81qyRSOuBRpbzuB2u+FV4eiyRh848mI4475A4cBmAbPwJh7gm
	XDFFLdLFYDRwSvElD2/6LbAP8mVLmCs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-BBAWbVe6PLCVnuVLaV_XxA-1; Wed,
 21 Aug 2024 08:36:37 -0400
X-MC-Unique: BBAWbVe6PLCVnuVLaV_XxA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CF581956048;
	Wed, 21 Aug 2024 12:36:36 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 773AA300019C;
	Wed, 21 Aug 2024 12:36:34 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] keys: Add a key_ref_get() wrapper
Date: Wed, 21 Aug 2024 13:36:12 +0100
Message-ID: <20240821123616.60401-5-dhowells@redhat.com>
In-Reply-To: <20240821123616.60401-1-dhowells@redhat.com>
References: <20240821123616.60401-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add a key_ref_get() wrapper function to go with key_ref_put() and use it
for the place that needs it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: keyrings@vger.kernel.org
cc: linux-security-module@vger.kernel.org
---
 include/linux/key.h     | 5 +++++
 security/keys/keyring.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 08062b4f807c..50a19e5f9e45 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -315,6 +315,11 @@ static inline void key_ref_put(key_ref_t key_ref)
 	key_put(key_ref_to_ptr(key_ref));
 }
 
+static inline void key_ref_get(key_ref_t key_ref)
+{
+	key_get(key_ref_to_ptr(key_ref));
+}
+
 extern struct key *request_key_tag(struct key_type *type,
 				   const char *description,
 				   struct key_tag *domain_tag,
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 0eed018448cb..7f02b913c560 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -920,7 +920,7 @@ key_ref_t keyring_search_rcu(key_ref_t keyring_ref,
 
 	ctx->now = ktime_get_real_seconds();
 	if (search_nested_keyrings(keyring, ctx))
-		__key_get(key_ref_to_ptr(ctx->result));
+		key_ref_get(ctx->result);
 	return ctx->result;
 }
 


