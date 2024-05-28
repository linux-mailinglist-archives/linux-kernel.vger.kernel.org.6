Return-Path: <linux-kernel+bounces-191719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3298D1314
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4703EB21072
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9248C446AF;
	Tue, 28 May 2024 03:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHVAUBg9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8413F9CC;
	Tue, 28 May 2024 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868336; cv=none; b=ADXHeHWKuoc/lDuS/JjPnc6It7BDgTB4v9sVA0pFlwm8xl/Rgjwcfnn2YmGtPKY/MWj/m2ERR5I2/dYv4Cb5esCiGsUoIDs6qV924Nbf4pf4pJhz8gKTlfTIv6ScSX1VMX2dEw1NlX0h/enRLyN1OIo0emLu+ikr0XcmHBQdCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868336; c=relaxed/simple;
	bh=rPWLmQY2zzug7xultvNTKxKIqKu9pOMzbL8ZxMT08mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aarEU5M2Po61iX9ECM1+6ivah9kKfag//W2cP5Lvg0CqqARyOYK2dm7nXJ1CjFh9IA+DPlVuxoPSn+Jb8EftMB4J+Knb732zKYRwQnAbHqgAfg8abKYjTo/2sqJIcN0Sc2RKMPgboIYYJkWKOBcjETJ8zFXCgOlpSUApSldGUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHVAUBg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931D8C3277B;
	Tue, 28 May 2024 03:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716868336;
	bh=rPWLmQY2zzug7xultvNTKxKIqKu9pOMzbL8ZxMT08mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHVAUBg9nXMbwDPxq5yoFzCfyj5GyITMqEvzvJ2IaLpGvDxga6Nj6Bot46rJcrqlB
	 uW449D89Bn1QG7mTU6MquAK3C9X9GQt+Ovof/TkZkhAFm5Y3SBK5sL9SajQvKpCMAF
	 xkjuRM4JfFG4jQ1VoJ3R3KFeD8LFy8AoBhYlGXvSQRAuF3ywHOSkE+bPyIE04EV80l
	 f3M+Pq8T38yhj/jaqqoTzQSvvowwmwQIjchD/aPywOXxYrV1TB8M3Yr92nHGAXe7rQ
	 w/FzdHY0kRIB6ip0Fq94KDOyrk/lpYXaRbKJmnFG4TjSlkjX2irZgwMmlHkK7mQ5wA
	 zOqIyfOA8fFpA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list),
	David Howells <dhowells@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v6 5/6] keys: asymmetric: Add tpm2_key_rsa
Date: Tue, 28 May 2024 06:51:20 +0300
Message-ID: <20240528035136.11464-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528035136.11464-1-jarkko@kernel.org>
References: <20240528035136.11464-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Asymmetric TPM2 RSA key with signing and verification.
* Encryption and decryption when pcks1 encoding is used.
* Enabled with CONFIG_ASYMMETRIC_TPM2_KEY_ECDSA_SUBTYPE.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v6:
* Validate RSA parameters, and also that the blob has space for
  them.
* Fix tpm2_key_rsa_destroy() memory corruption: cast to tpm2_key_rsa
* Allocate temporary buffers from heap.
* Rename tpm2_key_rsa_extract_pub to tpm2_key_rsa_probe.
* While pre-parsing, return -EBADMSG when the probing fails. This
  translates to "not detected" for the framework, i.e. should not
  be considered as an error but instead "move on". E.g. TPM_ALG_RSA
  is checked and if it is instead TPM_ALG_ECDSA, then it is passed
  to that module.
v5:
* akcipher has two *undocumented* parameters. Document this clearly.
* Remove unused variable.
v4:
* Just put the values to the buffer instead of encoding them.
* Adjust buffer sizes.
* Make tpm2_rsa_key_encode() not to allocate from heap and simplify
  the serialization.
v3:
* Drop the special case for null handle i.e. do not define policy.
* Remove extra empty line.
v2:
* Remove two spurios pr_info() messsages that I forgot to remove.
* Clean up padding functions and add additional checks for length
  also in tpm2_unpad_pcks1().
* Add the missing success check kzalloc() in tpm2_key_rsa_decrypt().
* Check that params->out_len for capacity before copying the result.
---
 crypto/asymmetric_keys/Kconfig        |  15 +
 crypto/asymmetric_keys/Makefile       |   1 +
 crypto/asymmetric_keys/tpm2_key_rsa.c | 678 ++++++++++++++++++++++++++
 include/linux/tpm.h                   |   2 +
 4 files changed, 696 insertions(+)
 create mode 100644 crypto/asymmetric_keys/tpm2_key_rsa.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index e1345b8f39f1..9d88c1190621 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -15,6 +15,7 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select MPILIB
 	select CRYPTO_HASH_INFO
 	select CRYPTO_AKCIPHER
+	select CRYPTO_RSA
 	select CRYPTO_SIG
 	select CRYPTO_HASH
 	help
@@ -23,6 +24,20 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	  appropriate hash algorithms (such as SHA-1) must be available.
 	  ENOPKG will be reported if the requisite algorithm is unavailable.
 
+config ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE
+	tristate "Asymmetric TPM2 RSA crypto algorithm subtype"
+	depends on TCG_TPM
+	select CRYPTO_RSA
+	select CRYPTO_SHA256
+	select CRYPTO_HASH_INFO
+	select CRYPTO_TPM2_KEY
+	select ASN1
+	help
+	  This option provides support for asymmetric TPM2 key type handling.
+	  If signature generation and/or verification are to be used,
+	  appropriate hash algorithms (such as SHA-256) must be available.
+	  ENOPKG will be reported if the requisite algorithm is unavailable.
+
 config X509_CERTIFICATE_PARSER
 	tristate "X.509 certificate parser"
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index bc65d3b98dcb..c6da84607824 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -11,6 +11,7 @@ asymmetric_keys-y := \
 	signature.o
 
 obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
+obj-$(CONFIG_ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE) += tpm2_key_rsa.o
 
 #
 # X.509 Certificate handling
diff --git a/crypto/asymmetric_keys/tpm2_key_rsa.c b/crypto/asymmetric_keys/tpm2_key_rsa.c
new file mode 100644
index 000000000000..4bc322580037
--- /dev/null
+++ b/crypto/asymmetric_keys/tpm2_key_rsa.c
@@ -0,0 +1,678 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* TPM2 asymmetric public-key crypto subtype
+ *
+ * Asymmetric TPM2 RSA key:
+ * - Decrypts RSA with TPM2_RSA_Decrypt.
+ * - Signs with PKCS#1 1.5 padding. Signing is implemented with
+ *   TPM2_RSA_Decrypt operation.
+ * - Encrypts with the akcipher rsa-pcks1pad.
+ *
+ * See Documentation/crypto/asymmetric-keys.rst
+ *
+ * Copyright (c) 2020 Intel Corporation
+ */
+
+#include <asm/unaligned.h>
+#include <crypto/akcipher.h>
+#include <crypto/public_key.h>
+#include <crypto/rsa-pkcs1pad.h>
+#include <crypto/tpm2_key.h>
+#include <keys/asymmetric-parser.h>
+#include <keys/asymmetric-subtype.h>
+#include <keys/trusted-type.h>
+#include <linux/keyctl.h>
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/tpm.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "tpm2_key_rsa: "fmt
+
+#define PKCS1_PAD_MIN_SIZE 11
+
+/* TPM2 Structures 12.2.3.5: TPMS_RSA_PARMS */
+struct tpm2_rsa_parms {
+	__be16 symmetric;
+	__be16 scheme;
+	__be16 key_bits;
+	__be32 exponent;
+	__be16 modulus_size;
+} __packed;
+
+/*
+ * Fill the data with PKCS#1 v1.5 padding.
+ */
+static int tpm2_pad_pkcs1(const u8 *in, int in_len, u8 *out, int out_len)
+{
+	unsigned int prefix_len = out_len - in_len - 3;
+
+	if (in_len > out_len - PKCS1_PAD_MIN_SIZE)
+		return -EBADMSG;
+
+	/* prefix */
+	out[0] = 0;
+	out[1] = 1;
+	memset(&out[2], 0xff, prefix_len);
+	out[2 + prefix_len] = 0;
+	/* payload */
+	memcpy(&out[2 + prefix_len + 1], in, in_len);
+
+	return 0;
+}
+
+/*
+ * RFC 3447 - Section 7.2.2
+ * Size of the input data should be checked against public key size by
+ * the caller.
+ */
+static const u8 *tpm2_unpad_pkcs1(const u8 *in, int in_len, int *out_len)
+{
+	int i;
+
+	if (in[0] != 0 || in[1] != 2)
+		return NULL;
+
+	i = 2;
+	while (in[i] != 0 && i < in_len)
+		i++;
+
+	if (i == in_len || i < (PKCS1_PAD_MIN_SIZE - 1))
+		return NULL;
+
+	*out_len = in_len - i - 1;
+	return in + i + 1;
+}
+
+/*
+ * Outputs the cipher algorithm name on success, and retuns -ENOPKG
+ * on failure.
+ */
+static int tpm2_key_get_akcipher(const char *encoding, const char *hash_algo,
+				 char *cipher)
+{
+	ssize_t ret;
+
+	if (strcmp(encoding, "pkcs1") == 0) {
+		if (!hash_algo) {
+			strcpy(cipher, "pkcs1pad(rsa)");
+			return 0;
+		}
+
+		ret = snprintf(cipher, CRYPTO_MAX_ALG_NAME,
+			       "pkcs1pad(rsa,%s)",
+			       hash_algo);
+		if (ret >= CRYPTO_MAX_ALG_NAME)
+			return -ENOPKG;
+
+		return 0;
+	}
+
+	if (strcmp(encoding, "raw") == 0) {
+		strcpy(cipher, "rsa");
+		return 0;
+	}
+
+	return -ENOPKG;
+}
+
+static int tpm2_key_rsa_encode(const struct tpm2_key *key, u8 *buf)
+{
+	const off_t o = key->priv_len + 2 + sizeof(*key->desc);
+	const struct tpm2_rsa_parms *p =
+		(const struct tpm2_rsa_parms *)&key->data[o];
+	const u16 mod_size = be16_to_cpu(p->modulus_size);
+	const void *mod = &key->data[o + sizeof(*p)];
+
+	u8 *start = &buf[4];
+	u8 *work = &buf[4];
+	u32 seq_len;
+
+	work[0] = 0x02;			/* INTEGER */
+	work[1] = 0x82;			/* u16 */
+	work[2] = mod_size >> 8;
+	work[3] = mod_size & 0xff;
+	work = &work[4];
+	memcpy(work, mod, mod_size);
+	work = &work[mod_size];
+	work[0] = 0x02;			/* INTEGER */
+	work[1] = 3;			/* < 128 */
+	work[2] = 1;			/* 65537 */
+	work[3] = 0;
+	work[4]	= 1;
+	work = &work[5];
+	seq_len = work - start;
+	buf[0] = 0x30;			/* SEQUENCE */
+	buf[1] = 0x82;			/* u16 */
+	buf[2] = seq_len >> 8;
+	buf[3] = seq_len & 0xff;
+
+	/*
+	 * ABI requires this according include/crypto/akcipher.h, which says
+	 * that there is epilogue with algorithm OID and parameters length.
+	 * Neither size nor semantics is documented *anywhere*, and there's no
+	 * struct to hold them.
+	 *
+	 * So zeroing out the last eight bytes after the key blob seems like the
+	 * best bet, given no better (or any) information. The size of the
+	 * parameters (two u32's) was found from crypto/asymmetric/public_key.c.
+	 */
+	memset(work, 0, 8);
+
+	return seq_len + 4;
+}
+
+/*
+ * Encryption operation is performed with the public key.  Hence it is done
+ * in software
+ */
+static int tpm2_key_rsa_encrypt(struct tpm2_key *key,
+				struct kernel_pkey_params *params,
+				const void *in, void *out)
+{
+	char cipher[CRYPTO_MAX_ALG_NAME];
+	struct scatterlist in_sg, out_sg;
+	struct akcipher_request *req;
+	struct crypto_akcipher *tfm;
+	struct crypto_wait cwait;
+	u8 *buf;
+	int ret;
+
+	buf = kzalloc(TPM2_KEY_BYTES_MAX, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = tpm2_key_get_akcipher(params->encoding, params->hash_algo, cipher);
+	if (ret < 0)
+		goto err_buf;
+
+	tfm = crypto_alloc_akcipher(cipher, 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto err_buf;
+	}
+
+	ret = tpm2_key_rsa_encode(key, buf);
+	if (ret < 0)
+		goto err_tfm;
+
+	ret = crypto_akcipher_set_pub_key(tfm, buf, ret);
+	if (ret < 0)
+		goto err_tfm;
+
+	req = akcipher_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto err_tfm;
+	}
+
+	sg_init_one(&in_sg, in, params->in_len);
+	sg_init_one(&out_sg, out, params->out_len);
+	akcipher_request_set_crypt(req, &in_sg, &out_sg, params->in_len,
+				   params->out_len);
+
+	crypto_init_wait(&cwait);
+	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &cwait);
+
+	ret = crypto_akcipher_encrypt(req);
+	if (ret)
+		goto err_tfm;
+
+	ret = crypto_wait_req(ret, &cwait);
+	if (!ret)
+		ret = req->dst_len;
+
+	akcipher_request_free(req);
+
+err_tfm:
+	crypto_free_akcipher(tfm);
+
+err_buf:
+	kfree(buf);
+	return ret;
+}
+
+static int __tpm2_key_rsa_decrypt(struct tpm_chip *chip,
+				  struct tpm2_key *key,
+				  struct kernel_pkey_params *params,
+				  const void *in, int in_len, void *out)
+{
+	u32 key_handle = 0;
+	struct tpm_buf buf;
+	u16 decrypted_len;
+	u8 *pos;
+	int ret;
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		return ret;
+
+	ret = tpm2_start_auth_session(chip);
+	if (ret)
+		goto err_ops;
+
+	ret = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	if (ret < 0)
+		goto err_auth;
+
+	tpm_buf_append_name(chip, &buf, key->parent, NULL);
+	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_CONTINUE_SESSION |
+				    TPM2_SA_ENCRYPT, NULL, 0);
+	tpm_buf_append(&buf, &key->data[0], key->priv_len + key->pub_len);
+	if (buf.flags & TPM_BUF_OVERFLOW) {
+		ret = -E2BIG;
+		goto err_buf;
+	}
+	tpm_buf_fill_hmac_session(chip, &buf);
+	ret = tpm_transmit_cmd(chip, &buf, 4, "TPM2_CC_LOAD");
+	ret = tpm_buf_check_hmac_response(chip, &buf, ret);
+	if (ret) {
+		ret = -EIO;
+		goto err_buf;
+	}
+	key_handle = be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE]);
+
+	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_RSA_DECRYPT);
+	tpm_buf_append_name(chip, &buf, key_handle, NULL);
+	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT, NULL, 0);
+	tpm_buf_append_u16(&buf, in_len);
+	tpm_buf_append(&buf, in, in_len);
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
+	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_fill_hmac_session(chip, &buf);
+	ret = tpm_transmit_cmd(chip, &buf, 4, "TPM2_RSA_DECRYPT");
+	ret = tpm_buf_check_hmac_response(chip, &buf, ret);
+	if (ret) {
+		ret = -EIO;
+		goto err_blob;
+	}
+
+	pos = buf.data + TPM_HEADER_SIZE + 4;
+	decrypted_len = be16_to_cpup((__be16 *)pos);
+	pos += 2;
+
+	if (params->out_len < decrypted_len) {
+		ret = -EMSGSIZE;
+		goto err_blob;
+	}
+
+	memcpy(out, pos, decrypted_len);
+	ret = decrypted_len;
+
+err_blob:
+	tpm2_flush_context(chip, key_handle);
+
+err_buf:
+	tpm_buf_destroy(&buf);
+
+err_auth:
+	if (ret < 0)
+		tpm2_end_auth_session(chip);
+
+err_ops:
+	tpm_put_ops(chip);
+	return ret;
+}
+
+static int tpm2_key_rsa_decrypt(struct tpm_chip *chip, struct tpm2_key *key,
+				struct kernel_pkey_params *params,
+				const void *in, void *out)
+{
+	const u8 *ptr;
+	int out_len;
+	u8 *work;
+	int ret;
+
+	work = kzalloc(TPM2_KEY_BYTES_MAX, GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	ret = __tpm2_key_rsa_decrypt(chip, key, params, in, params->in_len,
+				     work);
+	if (ret < 0)
+		goto err;
+
+	ptr = tpm2_unpad_pkcs1(work, ret, &out_len);
+	if (!ptr) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (out_len > params->out_len) {
+		ret = -EMSGSIZE;
+		goto err;
+	}
+
+	memcpy(out, ptr, out_len);
+	kfree(work);
+	return out_len;
+
+err:
+	kfree(work);
+	return ret;
+}
+
+/*
+ * Sign operation is an encryption using the TPM's private key. With RSA the
+ * only difference between encryption and decryption is where the padding goes.
+ * Since own padding can be used, TPM2_RSA_Decrypt can be repurposed to do
+ * encryption.
+ */
+static int tpm2_key_rsa_sign(struct tpm_chip *chip, struct tpm2_key *key,
+			     struct kernel_pkey_params *params,
+			     const void *in, void *out)
+{
+	const off_t o = key->priv_len + 2 + sizeof(*key->desc);
+	const struct tpm2_rsa_parms *p =
+		(const struct tpm2_rsa_parms *)&key->data[o];
+	const u16 mod_size = be16_to_cpu(p->modulus_size);
+	const struct rsa_asn1_template *asn1;
+	u32 in_len = params->in_len;
+	void *asn1_wrapped = NULL;
+	u8 *padded;
+	int ret;
+
+	if (strcmp(params->encoding, "pkcs1") != 0) {
+		ret = -ENOPKG;
+		goto err;
+	}
+
+	if (params->hash_algo) {
+		asn1 = rsa_lookup_asn1(params->hash_algo);
+		if (!asn1) {
+			ret = -ENOPKG;
+			goto err;
+		}
+
+		/* Request enough space for the ASN.1 template + input hash */
+		asn1_wrapped = kzalloc(in_len + asn1->size, GFP_KERNEL);
+		if (!asn1_wrapped) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		/* Copy ASN.1 template, then the input */
+		memcpy(asn1_wrapped, asn1->data, asn1->size);
+		memcpy(asn1_wrapped + asn1->size, in, in_len);
+
+		in = asn1_wrapped;
+		in_len += asn1->size;
+	}
+
+	/* with padding: */
+	padded = kmalloc(mod_size, GFP_KERNEL);
+	tpm2_pad_pkcs1(in, in_len, padded, mod_size);
+	ret = __tpm2_key_rsa_decrypt(chip, key, params, padded, mod_size, out);
+	kfree(padded);
+
+err:
+	kfree(asn1_wrapped);
+	return ret;
+}
+
+static void tpm2_key_rsa_describe(const struct key *asymmetric_key,
+				  struct seq_file *m)
+{
+	struct tpm2_key *key = asymmetric_key->payload.data[asym_crypto];
+
+	if (!key) {
+		pr_err("key blob missing");
+		return;
+	}
+
+	seq_puts(m, "TPM2/RSA");
+}
+
+static void tpm2_key_rsa_destroy(void *payload0, void *payload3)
+{
+	struct tpm2_key *key = payload0;
+
+	if (!key)
+		return;
+
+	kfree(key);
+}
+
+static int tpm2_key_rsa_eds_op(struct kernel_pkey_params *params,
+			       const void *in, void *out)
+{
+	struct tpm2_key *key = params->key->payload.data[asym_crypto];
+	struct tpm_chip *chip = tpm_default_chip();
+
+	if (!chip)
+		return -ENODEV;
+
+	switch (params->op) {
+	case kernel_pkey_encrypt:
+		return tpm2_key_rsa_encrypt(key, params, in, out);
+	case kernel_pkey_decrypt:
+		return tpm2_key_rsa_decrypt(chip, key, params, in, out);
+	case kernel_pkey_sign:
+		return tpm2_key_rsa_sign(chip, key, params, in, out);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int tpm2_key_rsa_verify(const struct key *key,
+			       const struct public_key_signature *sig)
+{
+	const struct tpm2_key *tpm2_key = key->payload.data[asym_crypto];
+	char alg_name[CRYPTO_MAX_ALG_NAME];
+	struct akcipher_request *req;
+	struct scatterlist src_sg[2];
+	struct crypto_akcipher *tfm;
+	struct crypto_wait cwait;
+	u8 *buf;
+	int ret;
+
+	if (!sig->digest)
+		return -ENOPKG;
+
+	ret = tpm2_key_get_akcipher(sig->encoding, sig->hash_algo, alg_name);
+	if (ret < 0)
+		return ret;
+
+	buf = kzalloc(TPM2_KEY_BYTES_MAX, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	tfm = crypto_alloc_akcipher(alg_name, 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto err_buf;
+	}
+
+	ret = tpm2_key_rsa_encode(tpm2_key, buf);
+	if (ret < 0)
+		goto err_tfm;
+
+	ret = crypto_akcipher_set_pub_key(tfm, buf, ret);
+	if (ret < 0)
+		goto err_tfm;
+
+	ret = -ENOMEM;
+	req = akcipher_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		goto err_tfm;
+
+	sg_init_table(src_sg, 2);
+	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
+	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
+	akcipher_request_set_crypt(req, src_sg, NULL, sig->s_size,
+				   sig->digest_size);
+	crypto_init_wait(&cwait);
+	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &cwait);
+	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
+
+	akcipher_request_free(req);
+
+err_tfm:
+	crypto_free_akcipher(tfm);
+
+err_buf:
+	kfree(buf);
+	return ret;
+}
+
+static int tpm2_key_rsa_query(const struct kernel_pkey_params *params,
+			      struct kernel_pkey_query *info)
+{
+	const struct tpm2_key *key = params->key->payload.data[asym_crypto];
+	const off_t o = key->priv_len + 2 + sizeof(*key->desc);
+	const struct tpm2_rsa_parms *p =
+		(const struct tpm2_rsa_parms *)&key->data[o];
+	const u16 mod_size = be16_to_cpu(p->modulus_size);
+	char alg_name[CRYPTO_MAX_ALG_NAME];
+	struct crypto_akcipher *tfm;
+	unsigned int len;
+	u8 *buf;
+	int ret;
+
+	ret = tpm2_key_get_akcipher(params->encoding, params->hash_algo, alg_name);
+	if (ret < 0)
+		return ret;
+
+	buf = kzalloc(TPM2_KEY_BYTES_MAX, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	tfm = crypto_alloc_akcipher(alg_name, 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto err_buf;
+	}
+
+	ret = tpm2_key_rsa_encode(key, buf);
+	if (ret < 0)
+		goto err_tfm;
+
+	ret = crypto_akcipher_set_pub_key(tfm, buf, ret);
+	if (ret < 0)
+		goto err_tfm;
+
+	len = crypto_akcipher_maxsize(tfm);
+
+	info->key_size = mod_size * 8;
+	info->max_data_size = mod_size;
+	info->max_sig_size = len;
+	info->max_enc_size = len;
+	info->max_dec_size = mod_size;
+
+	info->supported_ops = KEYCTL_SUPPORTS_SIGN | KEYCTL_SUPPORTS_VERIFY;
+
+	if (!strcmp(params->encoding, "pkcs1")) {
+		pr_info("pkcs1\n");
+		info->supported_ops =
+			KEYCTL_SUPPORTS_ENCRYPT | KEYCTL_SUPPORTS_DECRYPT;
+	}
+
+err_tfm:
+	crypto_free_akcipher(tfm);
+	return ret;
+
+err_buf:
+	kfree(buf);
+	return ret;
+}
+
+struct asymmetric_key_subtype tpm2_key_rsa_subtype = {
+	.owner			= THIS_MODULE,
+	.name			= "tpm2_key_rsa",
+	.name_len		= sizeof("tpm2_key_rsa") - 1,
+	.describe		= tpm2_key_rsa_describe,
+	.destroy		= tpm2_key_rsa_destroy,
+	.query			= tpm2_key_rsa_query,
+	.eds_op			= tpm2_key_rsa_eds_op,
+	.verify_signature	= tpm2_key_rsa_verify,
+};
+EXPORT_SYMBOL_GPL(tpm2_key_rsa_subtype);
+
+static int __tpm2_key_rsa_preparse(struct tpm2_key *key)
+{
+	const off_t o = key->priv_len + 2 + sizeof(*key->desc);
+	const struct tpm2_rsa_parms *p =
+		(const struct tpm2_rsa_parms *)&key->data[o];
+
+	if (tpm2_key_type(key) != TPM_ALG_RSA)
+		return -EBADMSG;
+
+	if (tpm2_key_policy_size(key) != 0)
+		return -EBADMSG;
+
+	if (be16_to_cpu(p->symmetric) != TPM_ALG_NULL)
+		return -EBADMSG;
+
+	if (be16_to_cpu(p->scheme) != TPM_ALG_NULL)
+		return -EBADMSG;
+
+	if (be16_to_cpu(p->key_bits) != 2048 &&
+	    be16_to_cpu(p->key_bits) != 3072 &&
+	    be16_to_cpu(p->key_bits) != 4096)
+		return -EBADMSG;
+
+	if (be32_to_cpu(p->exponent) != 0x00000000 &&
+	    be32_to_cpu(p->exponent) != 0x00010001)
+		return -EBADMSG;
+
+	pr_debug("modulus_size=%u\n", be16_to_cpu(p->modulus_size));
+	return 0;
+}
+
+/*
+ * Attempt to parse a data blob for a key as a TPM private key blob.
+ */
+static int tpm2_key_rsa_preparse(struct key_preparsed_payload *prep)
+{
+	struct tpm2_key *key;
+	int ret;
+
+	key = tpm2_key_decode(prep->data, prep->datalen);
+	if (IS_ERR(key))
+		return ret;
+
+	if (key->oid != OID_TPMLoadableKey) {
+		kfree(key);
+		return -EBADMSG;
+	}
+
+	ret = __tpm2_key_rsa_preparse(key);
+	if (ret < 0) {
+		kfree(key);
+		return ret;
+	}
+
+	prep->payload.data[asym_subtype] = &tpm2_key_rsa_subtype;
+	prep->payload.data[asym_key_ids] = NULL;
+	prep->payload.data[asym_crypto] = key;
+	prep->payload.data[asym_auth] = NULL;
+	prep->quotalen = 100;
+
+	return 0;
+}
+
+static struct asymmetric_key_parser tpm2_key_rsa_parser = {
+	.owner	= THIS_MODULE,
+	.name	= "tpm2_key_rsa_parser",
+	.parse	= tpm2_key_rsa_preparse,
+};
+
+static int __init tpm2_key_rsa_init(void)
+{
+	return register_asymmetric_key_parser(&tpm2_key_rsa_parser);
+}
+
+static void __exit tpm2_key_rsa_exit(void)
+{
+	unregister_asymmetric_key_parser(&tpm2_key_rsa_parser);
+}
+
+module_init(tpm2_key_rsa_init);
+module_exit(tpm2_key_rsa_exit);
+
+MODULE_DESCRIPTION("Asymmetric TPM2 RSA key");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index b3217200df28..a4be7a852bde 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -43,6 +43,7 @@ enum tpm2_session_types {
 /* if you add a new hash to this, increment TPM_MAX_HASHES below */
 enum tpm_algorithms {
 	TPM_ALG_ERROR		= 0x0000,
+	TPM_ALG_RSA		= 0x0001,
 	TPM_ALG_SHA1		= 0x0004,
 	TPM_ALG_AES		= 0x0006,
 	TPM_ALG_KEYEDHASH	= 0x0008,
@@ -271,6 +272,7 @@ enum tpm2_command_codes {
 	TPM2_CC_NV_READ                 = 0x014E,
 	TPM2_CC_CREATE		        = 0x0153,
 	TPM2_CC_LOAD		        = 0x0157,
+	TPM2_CC_RSA_DECRYPT	        = 0x0159,
 	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
 	TPM2_CC_UNSEAL		        = 0x015E,
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
-- 
2.45.1


