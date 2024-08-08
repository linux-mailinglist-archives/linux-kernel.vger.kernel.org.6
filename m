Return-Path: <linux-kernel+bounces-280176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5907A94C6C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECC91F22CFF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219215A85F;
	Thu,  8 Aug 2024 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbF7DaBH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3715B542;
	Thu,  8 Aug 2024 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154950; cv=none; b=Dl7LzLs8PIVIO5qkRGBmykPR0D01DVCqvzFjtBv3DTRydD/e+Oz1WCjB9UUMGF9k12DKGhfscjdj6048XmJX4BCrVpW+L1EZ4054WKVs3QdysN+cGAvtg4fTx324SJwZKbdSpSgavvdxYr3Nyk+QkSSvlUCMXzZiiFHqfOPqpG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154950; c=relaxed/simple;
	bh=icIcJ39Tay+d9YIQF/Wf7xniASP333IDPZk/wyxr3w0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PdKCurj8mQqH2ye3g9U8+047VOPoXIaQp4El/93na+EVbPq+tQStkP8c1KidH4pvZq6+tyVkcT1rXeIE1xsuuDRFBaEzL/M4OiT495Rw3762aLCZgR/L5SYq6o2FQS+gJefmVdTwHfDO3pHKYSWJn4eXaigLrL7l4tcW8hrHC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbF7DaBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87FAC32782;
	Thu,  8 Aug 2024 22:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723154949;
	bh=icIcJ39Tay+d9YIQF/Wf7xniASP333IDPZk/wyxr3w0=;
	h=Date:From:To:Cc:Subject:From;
	b=gbF7DaBHX2vVnNjwHq5hxp4z+6zAPDIYbuGZuqrawkCbEt31pM+iQ5+zlo5nht8GF
	 AFNHdcQsoP8fWZpd4hNykFJYGPXHkDSSWLaJ4PLzyZahnIK/lysgUvRB5LH5EHC+Y/
	 CxEbspM0RYcUZ09tTN79MpEH+JAh+o6O5D6t7KmYSQGsECeL6N2lJXH0rn9BbeC1NM
	 mBENIKwlHOzjhj2+nsxxDJvDax1iEpwRZPwg316LO+FkwN2WxIJF+cTknEHIopnaw/
	 4TGbcgH5MGRXsPSdGw/jD1ZdYUGQ+qjqudKhDsq0OUB+XDsl0hxSZGpksPXdP5nNfi
	 0/rN7rMr1jZuw==
Date: Thu, 8 Aug 2024 16:09:06 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Haren Myneni <haren@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] crypto: nx - Use static_assert() to check struct sizes
Message-ID: <ZrVCAqGrl+5prW1Y@cute>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 1e6b251ce175 ("crypto: nx - Avoid -Wflex-array-member-not-at-end
warning") introduced tagged `struct nx842_crypto_header_hdr`. We want
to ensure that when new members need to be added to the flexible
structure, they are always included within this tagged struct.

So, we use `static_assert()` to ensure that the memory layout for
both the flexible structure and the tagged struct is the same after
any changes.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/crypto/nx/nx-842.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
index 25fa70b2112c..887d4ce3cb49 100644
--- a/drivers/crypto/nx/nx-842.h
+++ b/drivers/crypto/nx/nx-842.h
@@ -157,6 +157,7 @@ struct nx842_crypto_header_group {
 } __packed;
 
 struct nx842_crypto_header {
+	/* New members MUST be added within the struct_group() macro below. */
 	struct_group_tagged(nx842_crypto_header_hdr, hdr,
 		__be16 magic;		/* NX842_CRYPTO_MAGIC */
 		__be16 ignore;		/* decompressed end bytes to ignore */
@@ -164,6 +165,8 @@ struct nx842_crypto_header {
 	);
 	struct nx842_crypto_header_group group[];
 } __packed;
+static_assert(offsetof(struct nx842_crypto_header, group) == sizeof(struct nx842_crypto_header_hdr),
+	      "struct member likely outside of struct_group_tagged()");
 
 #define NX842_CRYPTO_GROUP_MAX	(0x20)
 
-- 
2.34.1


