Return-Path: <linux-kernel+bounces-291120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F424955D93
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BAF28163D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425414E2E6;
	Sun, 18 Aug 2024 16:59:55 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1381AD2;
	Sun, 18 Aug 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000394; cv=none; b=fSZEKccjOedWCjF4xB11w3BRdLArVrjxn0uqMoAfIom96Uqt+uDSTttzRsWH/N5MeHUUO2DmjlRGCvSZm4x/zq6q3wOZ0vlL3wBWFF0bRMxYHk0+Pnl6dAbOSe/b/3UpHV+T9yPLxKXBBbHWAx+dwtIefttn9JY3OffLpEzsBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000394; c=relaxed/simple;
	bh=cHL5GsLvcXJ/g143khkpa21JYhbmnZ62EP4VsbsjZTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1jXqVA15l3dMYUeRtyxs3fmcZcGW4Kdwe6CusYLAS7FfL2F4Dng6QiU2MTtwIWckw29ei87Hk/MbZIrVVO0Y6D22OxcSnv1nSyYXuI3Aq7A9ch2Z49A+cq4E4SpH6LHM2zmtz0TDmynsTXgFDyxr833+2FKZn7hMOcZNskjpRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wn1YL6Qz0z9v7JY;
	Mon, 19 Aug 2024 00:35:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 3389114022E;
	Mon, 19 Aug 2024 00:59:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXm4VpKMJm+zZxAQ--.21009S4;
	Sun, 18 Aug 2024 17:59:44 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: dhowells@redhat.com,
	dwmw2@infradead.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 02/14] rsa: add parser of raw format
Date: Sun, 18 Aug 2024 18:57:44 +0200
Message-Id: <20240818165756.629203-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXm4VpKMJm+zZxAQ--.21009S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtry8ZryUtw45try7XrWDJwb_yoW7GFy7pF
	45G3yrKrWUJFyvyF4fuw1fJr13Jw1fuw4jqFZ3J3sYywsrWryUAw47CF4F9Fy5Gr9FyF12
	yr4Yg3WY9rn8XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jerWrU
	UUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBGbBWHEB+gAAsj

From: Roberto Sassu <roberto.sassu@huawei.com>

Parse the RSA key with RAW format if the ASN.1 parser returns an error.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 crypto/rsa.c                  | 14 +++++--
 crypto/rsa_helper.c           | 69 +++++++++++++++++++++++++++++++++++
 include/crypto/internal/rsa.h |  6 +++
 3 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/crypto/rsa.c b/crypto/rsa.c
index d9be9e86097e..66d42974d47d 100644
--- a/crypto/rsa.c
+++ b/crypto/rsa.c
@@ -272,8 +272,11 @@ static int rsa_set_pub_key(struct crypto_akcipher *tfm, const void *key,
 	rsa_free_mpi_key(mpi_key);
 
 	ret = rsa_parse_pub_key(&raw_key, key, keylen);
-	if (ret)
-		return ret;
+	if (ret) {
+		ret = rsa_parse_pub_key_raw(&raw_key, key, keylen);
+		if (ret)
+			return ret;
+	}
 
 	mpi_key->e = mpi_read_raw_data(raw_key.e, raw_key.e_sz);
 	if (!mpi_key->e)
@@ -311,8 +314,11 @@ static int rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 	rsa_free_mpi_key(mpi_key);
 
 	ret = rsa_parse_priv_key(&raw_key, key, keylen);
-	if (ret)
-		return ret;
+	if (ret) {
+		ret = rsa_parse_priv_key_raw(&raw_key, key, keylen);
+		if (ret)
+			return ret;
+	}
 
 	mpi_key->d = mpi_read_raw_data(raw_key.d, raw_key.d_sz);
 	if (!mpi_key->d)
diff --git a/crypto/rsa_helper.c b/crypto/rsa_helper.c
index 94266f29049c..fb9443df8f0b 100644
--- a/crypto/rsa_helper.c
+++ b/crypto/rsa_helper.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/err.h>
 #include <linux/fips.h>
+#include <linux/mpi.h>
 #include <crypto/internal/rsa.h>
 #include "rsapubkey.asn1.h"
 #include "rsaprivkey.asn1.h"
@@ -148,6 +149,32 @@ int rsa_get_qinv(void *context, size_t hdrlen, unsigned char tag,
 	return 0;
 }
 
+typedef int (*rsa_get_func)(void *, size_t, unsigned char,
+			    const void *, size_t);
+
+static int rsa_parse_key_raw(struct rsa_key *rsa_key,
+			     const void *key, unsigned int key_len,
+			     rsa_get_func *func, int n_func)
+{
+	unsigned int nbytes, len = key_len;
+	const void *key_ptr = key;
+	int ret, i;
+
+	for (i = 0; i < n_func; i++) {
+		ret = mpi_key_length(key_ptr, len, NULL, &nbytes);
+		if (ret < 0)
+			return ret;
+
+		ret = func[i](rsa_key, 0, 0, key_ptr + 2, nbytes);
+		if (ret < 0)
+			return ret;
+
+		key_ptr += nbytes + 2;
+	}
+
+	return (key_ptr == key + key_len) ? 0 : -EINVAL;
+}
+
 /**
  * rsa_parse_pub_key() - decodes the BER encoded buffer and stores in the
  *                       provided struct rsa_key, pointers to the raw key as is,
@@ -166,6 +193,27 @@ int rsa_parse_pub_key(struct rsa_key *rsa_key, const void *key,
 }
 EXPORT_SYMBOL_GPL(rsa_parse_pub_key);
 
+/**
+ * rsa_parse_pub_key_raw() - parse the RAW key and store in the provided struct
+ *                           rsa_key, pointers to the raw key as is, so that
+ *                           the caller can copy it or MPI parse it, etc.
+ *
+ * @rsa_key:	struct rsa_key key representation
+ * @key:	key in RAW format
+ * @key_len:	length of key
+ *
+ * Return:	0 on success or error code in case of error
+ */
+int rsa_parse_pub_key_raw(struct rsa_key *rsa_key, const void *key,
+			  unsigned int key_len)
+{
+	rsa_get_func pub_func[] = {rsa_get_n, rsa_get_e};
+
+	return rsa_parse_key_raw(rsa_key, key, key_len,
+				 pub_func, ARRAY_SIZE(pub_func));
+}
+EXPORT_SYMBOL_GPL(rsa_parse_pub_key_raw);
+
 /**
  * rsa_parse_priv_key() - decodes the BER encoded buffer and stores in the
  *                        provided struct rsa_key, pointers to the raw key
@@ -184,3 +232,24 @@ int rsa_parse_priv_key(struct rsa_key *rsa_key, const void *key,
 	return asn1_ber_decoder(&rsaprivkey_decoder, rsa_key, key, key_len);
 }
 EXPORT_SYMBOL_GPL(rsa_parse_priv_key);
+
+/**
+ * rsa_parse_priv_key_raw() - parse the RAW key and store in the provided struct
+ *                            rsa_key, pointers to the raw key as is, so that
+ *                            the caller can copy it or MPI parse it, etc.
+ *
+ * @rsa_key:	struct rsa_key key representation
+ * @key:	key in RAW format
+ * @key_len:	length of key
+ *
+ * Return:	0 on success or error code in case of error
+ */
+int rsa_parse_priv_key_raw(struct rsa_key *rsa_key, const void *key,
+			   unsigned int key_len)
+{
+	rsa_get_func priv_func[] = {rsa_get_n, rsa_get_e, rsa_get_d};
+
+	return rsa_parse_key_raw(rsa_key, key, key_len,
+				 priv_func, ARRAY_SIZE(priv_func));
+}
+EXPORT_SYMBOL_GPL(rsa_parse_priv_key_raw);
diff --git a/include/crypto/internal/rsa.h b/include/crypto/internal/rsa.h
index e870133f4b77..7141e806ceea 100644
--- a/include/crypto/internal/rsa.h
+++ b/include/crypto/internal/rsa.h
@@ -50,8 +50,14 @@ struct rsa_key {
 int rsa_parse_pub_key(struct rsa_key *rsa_key, const void *key,
 		      unsigned int key_len);
 
+int rsa_parse_pub_key_raw(struct rsa_key *rsa_key, const void *key,
+			  unsigned int key_len);
+
 int rsa_parse_priv_key(struct rsa_key *rsa_key, const void *key,
 		       unsigned int key_len);
 
+int rsa_parse_priv_key_raw(struct rsa_key *rsa_key, const void *key,
+			   unsigned int key_len);
+
 extern struct crypto_template rsa_pkcs1pad_tmpl;
 #endif
-- 
2.34.1


