Return-Path: <linux-kernel+bounces-563955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267DBA64ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676511884CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A437D2356DE;
	Mon, 17 Mar 2025 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BZU7zoAf"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76287EED6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208544; cv=none; b=BdOZnvq0Ihu5n1ZixSAzi1IBO0B7XRh3S5ZEjM6fM2iWs6NWkeXjsLWl38dqQ3NTlqitsm/x0DNSqkovPmO0VkOlGQqKkeRoj6SauYLnjOS59AuvREvSLzIQFuTo7WF5JG84kPBOYyOPAa0KNL5Wlp5lQO+U1F7TzqUqEAg7A8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208544; c=relaxed/simple;
	bh=Kp18ekQ3AfM4qDIYttsL+4agfm89UIpbN5I4b9i+xME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEt2OOSczgA1BbOT1ThlfnwIVOmIR9F9loKitw3pW3to92nk91Ews/UOG8a215QKZMvJg6jKzLa/bM04exODcr0PdE5XQTc9BTDanszzYHyfispm3+Bfm6iogMHtPwMCk7OycqIKTZ36z0EYgZ9twsuXbshnjAyWqJSnETbH8R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BZU7zoAf; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742208538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EIOtecTr1V7gaL+HzDR3DlZXqtP21yGqlv128Jc8x58=;
	b=BZU7zoAfU6RK+MPW7YLHc7etIt6k9f7fHRaHe6saXSWWtlxWvOwLP/bi3TSTrelDLcs816
	oqwq+LOvDmYx9iYyEndZHoyEFCMSK6nZDOiZ3IuKnuNKam9CRaNdE1c2WPLEfs4YHpZARH
	SRMKSFQryMHtP4bAhzH3bQAWU600Tv0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: x509 - Replace kmalloc() + NUL-termination with kzalloc()
Date: Mon, 17 Mar 2025 11:48:41 +0100
Message-ID: <20250317104841.54336-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use kzalloc() to zero out the one-element array instead of using
kmalloc() followed by a manual NUL-termination.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index ee2fdab42334..2ffe4ae90bea 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -372,10 +372,9 @@ static int x509_fabricate_name(struct x509_parse_context *ctx, size_t hdrlen,
 
 	/* Empty name string if no material */
 	if (!ctx->cn_size && !ctx->o_size && !ctx->email_size) {
-		buffer = kmalloc(1, GFP_KERNEL);
+		buffer = kzalloc(1, GFP_KERNEL);
 		if (!buffer)
 			return -ENOMEM;
-		buffer[0] = 0;
 		goto done;
 	}
 
-- 
2.48.1


