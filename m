Return-Path: <linux-kernel+bounces-410505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6609CDC76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7880DB278F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A5A1B4F08;
	Fri, 15 Nov 2024 10:21:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0766E13D52B;
	Fri, 15 Nov 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666108; cv=none; b=AEVZOSsmONxkiTk/aXhxe2bM+WSDy3E0YTsM5ohH6uUUAXyd1QRJFzxgOVhuEgjxiaNhU2EWnP+cUz9mWTL7b6QAlKOfSlJmUed7mvrGsNaOIY0xqMoAmwShM9W/nhJLsCHJsiCSZ8sMpPKXLLY/mEJ4HTvayw2g/WNEjHBu+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666108; c=relaxed/simple;
	bh=6BQaJXZKOiOBwXYWSwcZkOiPe81Q04tYPz74uEAa5X0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcipL1XCX4He+3Jf/oTEFUYL1ve5ANlCPQqgnt1ZZvPE+5NyOTMQnubElN4MpYr1j2wccvAZaq6KSAFHrNM3zdfAMyxyh+wlAbdxksVWN/Z8diC+HSiqMPCATuHqEREVNKKZLI83z5WthCvLtE88SnWty2+gvPfJAZP37ihEsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XqY0x5bhtz10W2Q;
	Fri, 15 Nov 2024 18:19:45 +0800 (CST)
Received: from kwepemd200024.china.huawei.com (unknown [7.221.188.85])
	by mail.maildlp.com (Postfix) with ESMTPS id 37A671400DD;
	Fri, 15 Nov 2024 18:21:42 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemd200024.china.huawei.com (7.221.188.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Nov 2024 18:21:41 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<liulongfang@huawei.com>, <qianweili@huawei.com>, <linwenkai6@hisilicon.com>
Subject: [PATCH v4 2/2] crypto: hisilicon/sec2 - fix for aead invalid authsize
Date: Fri, 15 Nov 2024 18:21:39 +0800
Message-ID: <20241115102139.3793659-3-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241115102139.3793659-1-huangchenghai2@huawei.com>
References: <20241115102139.3793659-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200024.china.huawei.com (7.221.188.85)

From: Wenkai Lin <linwenkai6@hisilicon.com>

When the digest alg is HMAC-SHAx or another, the authsize may be less
than 4 bytes and mac_len of the BD is set to zero, the hardware considers
it a BD configuration error and reports a ras error, so the sec driver
needs to switch to software calculation in this case, this patch add a
check for it and remove unnecessary check that has been done by crypto.

Fixes: 2f072d75d1ab ("crypto: hisilicon - Add aead support on SEC2")
Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec.h        |  1 +
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 64 ++++++++++++----------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 70c3bdedb6ba..df2c930df2fb 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -37,6 +37,7 @@ struct sec_aead_req {
 	u8 *a_ivin;
 	dma_addr_t a_ivin_dma;
 	struct aead_request *aead_req;
+	bool fallback;
 };
 
 /* SEC request of Crypto */
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 8db995279545..c3a474e18593 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -1119,10 +1119,7 @@ static int sec_aead_setauthsize(struct crypto_aead *aead, unsigned int authsize)
 	struct sec_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
 
-	if (unlikely(a_ctx->fallback_aead_tfm))
-		return crypto_aead_setauthsize(a_ctx->fallback_aead_tfm, authsize);
-
-	return 0;
+	return crypto_aead_setauthsize(a_ctx->fallback_aead_tfm, authsize);
 }
 
 static int sec_aead_fallback_setkey(struct sec_auth_ctx *a_ctx,
@@ -1159,13 +1156,7 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		}
 		memcpy(c_ctx->c_key, key, keylen);
 
-		if (unlikely(a_ctx->fallback_aead_tfm)) {
-			ret = sec_aead_fallback_setkey(a_ctx, tfm, key, keylen);
-			if (ret)
-				return ret;
-		}
-
-		return 0;
+		return sec_aead_fallback_setkey(a_ctx, tfm, key, keylen);
 	}
 
 	ret = crypto_authenc_extractkeys(&keys, key, keylen);
@@ -1190,6 +1181,12 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		goto bad_key;
 	}
 
+	ret = sec_aead_fallback_setkey(a_ctx, tfm, key, keylen);
+	if (ret) {
+		dev_err(dev, "set sec fallback key err!\n");
+		goto bad_key;
+	}
+
 	return 0;
 
 bad_key:
@@ -1917,8 +1914,10 @@ static void sec_aead_exit(struct crypto_aead *tfm)
 
 static int sec_aead_ctx_init(struct crypto_aead *tfm, const char *hash_name)
 {
+	struct aead_alg *alg = crypto_aead_alg(tfm);
 	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
-	struct sec_auth_ctx *auth_ctx = &ctx->a_ctx;
+	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
+	const char *aead_name = alg->base.cra_name;
 	int ret;
 
 	ret = sec_aead_init(tfm);
@@ -1927,12 +1926,22 @@ static int sec_aead_ctx_init(struct crypto_aead *tfm, const char *hash_name)
 		return ret;
 	}
 
-	auth_ctx->hash_tfm = crypto_alloc_shash(hash_name, 0, 0);
-	if (IS_ERR(auth_ctx->hash_tfm)) {
+	a_ctx->hash_tfm = crypto_alloc_shash(hash_name, 0, 0);
+	if (IS_ERR(a_ctx->hash_tfm)) {
 		dev_err(ctx->dev, "aead alloc shash error!\n");
 		sec_aead_exit(tfm);
-		return PTR_ERR(auth_ctx->hash_tfm);
+		return PTR_ERR(a_ctx->hash_tfm);
+	}
+
+	a_ctx->fallback_aead_tfm = crypto_alloc_aead(aead_name, 0,
+						     CRYPTO_ALG_NEED_FALLBACK | CRYPTO_ALG_ASYNC);
+	if (IS_ERR(a_ctx->fallback_aead_tfm)) {
+		dev_err(ctx->dev, "aead driver alloc fallback tfm error!\n");
+		crypto_free_shash(ctx->a_ctx.hash_tfm);
+		sec_aead_exit(tfm);
+		return PTR_ERR(a_ctx->fallback_aead_tfm);
 	}
+	a_ctx->fallback = false;
 
 	return 0;
 }
@@ -1941,6 +1950,7 @@ static void sec_aead_ctx_exit(struct crypto_aead *tfm)
 {
 	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
 
+	crypto_free_aead(ctx->a_ctx.fallback_aead_tfm);
 	crypto_free_shash(ctx->a_ctx.hash_tfm);
 	sec_aead_exit(tfm);
 }
@@ -2226,15 +2236,15 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
 	struct device *dev = ctx->dev;
 	int ret;
 
-	if (unlikely(req->cryptlen + req->assoclen > MAX_INPUT_DATA_LEN ||
-	    req->assoclen > SEC_MAX_AAD_LEN)) {
-		dev_err(dev, "aead input spec error!\n");
+	/* Hardware does not handle cases where authsize is less than 4 bytes */
+	if (unlikely(sz < MIN_MAC_LEN)) {
+		sreq->aead_req.fallback = true;
 		return -EINVAL;
 	}
 
-	if (unlikely((c_mode == SEC_CMODE_GCM && sz < DES_BLOCK_SIZE) ||
-		     (c_mode == SEC_CMODE_CCM && (sz < MIN_MAC_LEN || sz & MAC_LEN_MASK)))) {
-		dev_err(dev, "aead input mac length error!\n");
+	if (unlikely(req->cryptlen + req->assoclen > MAX_INPUT_DATA_LEN ||
+	    req->assoclen > SEC_MAX_AAD_LEN)) {
+		dev_err(dev, "aead input spec error!\n");
 		return -EINVAL;
 	}
 
@@ -2280,7 +2290,7 @@ static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 	if (ctx->sec->qm.ver == QM_HW_V2) {
 		if (unlikely(!req->cryptlen || (!sreq->c_req.encrypt &&
 			     req->cryptlen <= authsize))) {
-			ctx->a_ctx.fallback = true;
+			sreq->aead_req.fallback = true;
 			return -EINVAL;
 		}
 	}
@@ -2308,16 +2318,9 @@ static int sec_aead_soft_crypto(struct sec_ctx *ctx,
 				bool encrypt)
 {
 	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
-	struct device *dev = ctx->dev;
 	struct aead_request *subreq;
 	int ret;
 
-	/* Kunpeng920 aead mode not support input 0 size */
-	if (!a_ctx->fallback_aead_tfm) {
-		dev_err(dev, "aead fallback tfm is NULL!\n");
-		return -EINVAL;
-	}
-
 	subreq = aead_request_alloc(a_ctx->fallback_aead_tfm, GFP_KERNEL);
 	if (!subreq)
 		return -ENOMEM;
@@ -2349,10 +2352,11 @@ static int sec_aead_crypto(struct aead_request *a_req, bool encrypt)
 	req->aead_req.aead_req = a_req;
 	req->c_req.encrypt = encrypt;
 	req->ctx = ctx;
+	req->aead_req.fallback = false;
 
 	ret = sec_aead_param_check(ctx, req);
 	if (unlikely(ret)) {
-		if (ctx->a_ctx.fallback)
+		if (req->aead_req.fallback)
 			return sec_aead_soft_crypto(ctx, a_req, encrypt);
 		return -EINVAL;
 	}
-- 
2.33.0


