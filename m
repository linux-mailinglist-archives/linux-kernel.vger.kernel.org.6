Return-Path: <linux-kernel+bounces-324899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEEE975253
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D7C1F2649E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462E191F9F;
	Wed, 11 Sep 2024 12:30:15 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEED1885B0;
	Wed, 11 Sep 2024 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057815; cv=none; b=QOEU0rgmZN5SCbhc8phjZ0lT9suuIpk100EtMvnBz9YVsHjrApaw5xdhWhi34w2/UraZQTBvI6B173bCTfoPAvEAsROgN23dtA/Z9g1G+x/SH0hZ1VEpOg2wKzMY9vcUdLarLOuOeOmmxyhYvqXXLJJ5QeTv0D2uOgiRB9ooy5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057815; c=relaxed/simple;
	bh=fhV7NqXF8wDIS3ft1+SUHhDw/x5Ya402ySo8Gw3kCqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jyq0VDgWNFSj1fQ6UK/ioRL/QDWUx+vjkfwlcE70KMCwtf/Ro1JGXuBLV372dOHUT57joW/KsxWPSLaRaHf+6nHqU3l0hZ2uAqxNFPBFIlgzrjATRtp0Bb7qdijQqO3kX3OkgMUtHwCbV10NEighVcdpOpRLv+kL6Jl3PXZKs5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X3fXw1W6pz9v7Hm;
	Wed, 11 Sep 2024 20:10:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id BD5FB140B21;
	Wed, 11 Sep 2024 20:30:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3pscjjeFmDBG3AA--.60453S7;
	Wed, 11 Sep 2024 13:30:03 +0100 (CET)
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
	torvalds@linux-foundation.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 05/14] PGPLIB: Signature parser
Date: Wed, 11 Sep 2024 14:29:02 +0200
Message-Id: <20240911122911.1381864-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
References: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwD3pscjjeFmDBG3AA--.60453S7
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW8tryruF45Cw1rJr48tFb_yoWDGryfpa
	4Iy34fKrWUG3ZavrW8Ar47X3y5Cr40yry7Ga9Yq3WYy39agrn8ZrZ2kFyFkF98t3Z5X3yx
	CrZ8ta98ur4kZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGbg-HQHzQAFsH

From: David Howells <dhowells@redhat.com>

Provide some PGP signature parsing helpers:

 (1) A function to parse V4 signature subpackets and pass the desired ones
     to a processor function:

	int pgp_parse_sig_subpkts(const u8 *data, size_t datalen,
				  struct pgp_parse_sig_context *ctx);

 (2) A function to parse out basic signature parameters from any PGP
     signature such that the algorithms and public key can be selected:

	int pgp_parse_sig_params(const u8 **_data, size_t *_datalen,
				 struct pgp_sig_parameters *p);

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/pgp_library.c | 284 +++++++++++++++++++++++++++
 crypto/asymmetric_keys/pgplib.h      |  25 +++
 2 files changed, 309 insertions(+)

diff --git a/crypto/asymmetric_keys/pgp_library.c b/crypto/asymmetric_keys/pgp_library.c
index 1b87f8af411b..a9708ccbcb81 100644
--- a/crypto/asymmetric_keys/pgp_library.c
+++ b/crypto/asymmetric_keys/pgp_library.c
@@ -260,3 +260,287 @@ int pgp_parse_public_key(const u8 **_data, size_t *_datalen,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pgp_parse_public_key);
+
+/**
+ * pgp_parse_sig_subpkt_header - Parse a PGP V4 signature subpacket header
+ * @_data: Start of the subpacket (updated to subpacket data)
+ * @_datalen: Amount of data remaining in buffer (decreased)
+ * @_type: Where the subpacket type will be returned
+ *
+ * Parse a PGP V4 signature subpacket header [RFC 9580: 5.2.3.7].
+ *
+ * Return: packet data size on success; non-zero on error.  If successful,
+ * *_data and *_datalen will have been updated and *_headerlen will be set to
+ * hold the length of the packet header.
+ */
+static ssize_t pgp_parse_sig_subpkt_header(const u8 **_data, size_t *_datalen,
+					   enum pgp_sig_subpkt_type *_type)
+{
+	enum pgp_sig_subpkt_type type;
+	const u8 *data = *_data;
+	size_t size, datalen = *_datalen;
+
+	pr_devel("-->%s(,%zu,,)\n", __func__, datalen);
+
+	if (datalen < 2)
+		goto short_subpacket;
+
+	pr_devel("subpkt hdr %02x, %02x\n", data[0], data[1]);
+
+	switch (data[0]) {
+	case 0x00 ... 0xbf:
+		/* One-byte length */
+		size = data[0];
+		data++;
+		datalen--;
+		break;
+	case 0xc0 ... 0xfe:
+		/* Two-byte length */
+		if (datalen < 3)
+			goto short_subpacket;
+		size = (data[0] - 192) * 256;
+		size += data[1] + 192;
+		data += 2;
+		datalen -= 2;
+		break;
+	case 0xff:
+		if (datalen < 6)
+			goto short_subpacket;
+		size  = data[1] << 24;
+		size |= data[2] << 16;
+		size |= data[3] << 8;
+		size |= data[4];
+		data += 5;
+		datalen -= 5;
+		break;
+	}
+
+	/* The type octet is included in the size */
+	pr_devel("datalen=%zu size=%zu\n", datalen, size);
+	if (datalen < size)
+		goto short_subpacket;
+	if (size == 0)
+		goto very_short_subpacket;
+	if (size > INT_MAX)
+		goto too_big;
+
+	type = *data++ & ~PGP_SIG_SUBPKT_TYPE_CRITICAL_MASK;
+	datalen--;
+	size--;
+
+	*_data = data;
+	*_datalen = datalen;
+	*_type = type;
+	pr_devel("Found subpkt type=%u size=%zd\n", type, size);
+	return size;
+
+very_short_subpacket:
+	pr_debug("Signature subpacket size can't be zero\n");
+	return -EBADMSG;
+short_subpacket:
+	pr_debug("Attempt to parse short signature subpacket\n");
+	return -EBADMSG;
+too_big:
+	pr_debug("Signature subpacket size >2G\n");
+	return -EMSGSIZE;
+}
+
+/**
+ * pgp_parse_sig_subpkts - Parse a set of PGP V4 signatute subpackets
+ * @data: Data to be parsed (updated)
+ * @datalen: Amount of data (updated)
+ * @ctx: Parsing context
+ *
+ * Parse a set of PGP signature subpackets [RFC 9580: 5.2.3].
+ *
+ * Return: 0 on successful parsing, an error value otherwise.
+ */
+static int pgp_parse_sig_subpkts(const u8 *data, size_t datalen,
+				 struct pgp_parse_sig_context *ctx)
+{
+	enum pgp_sig_subpkt_type type;
+	ssize_t pktlen;
+	int ret;
+
+	pr_devel("-->%s(,%zu,,)\n", __func__, datalen);
+
+	while (datalen > 2) {
+		pktlen = pgp_parse_sig_subpkt_header(&data, &datalen, &type);
+		if (pktlen < 0)
+			return pktlen;
+		if (test_bit(type, ctx->types_of_interest)) {
+			ret = ctx->process_packet(ctx, type, data, pktlen);
+			if (ret < 0)
+				return ret;
+		}
+		data += pktlen;
+		datalen -= pktlen;
+	}
+
+	if (datalen != 0) {
+		pr_debug("Excess octets in signature subpacket stream\n");
+		return -EBADMSG;
+	}
+
+	return 0;
+}
+
+struct pgp_parse_sig_params_ctx {
+	struct pgp_parse_sig_context base;
+	struct pgp_sig_parameters *params;
+	bool got_the_issuer;
+};
+
+/*
+ * Process a V4 signature subpacket.
+ */
+static int pgp_process_sig_params_subpkt(struct pgp_parse_sig_context *context,
+					 enum pgp_sig_subpkt_type type,
+					 const u8 *data,
+					 size_t datalen)
+{
+	struct pgp_parse_sig_params_ctx *ctx =
+		container_of(context, struct pgp_parse_sig_params_ctx, base);
+
+	if (ctx->got_the_issuer) {
+		pr_debug("V4 signature packet has multiple issuers\n");
+		return -EBADMSG;
+	}
+
+	if (datalen != 8) {
+		pr_debug("V4 signature issuer subpkt not 8 long (%zu)\n",
+			 datalen);
+		return -EBADMSG;
+	}
+
+	memcpy(&ctx->params->issuer, data, 8);
+	ctx->got_the_issuer = true;
+	return 0;
+}
+
+/**
+ * pgp_parse_sig_params - Parse basic parameters from a PGP signature packet
+ * @_data: Content of packet (updated)
+ * @_datalen: Length of packet remaining (updated)
+ * @p: The basic parameters
+ *
+ * Parse the basic parameters from a PGP signature packet [RFC 9580: 5.2] that
+ * are needed to start off a signature verification operation.  The only ones
+ * actually necessary are the signature type (which affects how the data is
+ * transformed) and the hash algorithm.
+ *
+ * We also extract the public key algorithm and the issuer's key ID as we'll
+ * need those to determine if we actually have the public key available.  If
+ * not, then we can't verify the signature anyway.
+ *
+ * Return: 0 if successful or a negative error code.  *_data and *_datalen are
+ * updated to point to the 16-bit subset of the hash value and the set of MPIs.
+ */
+int pgp_parse_sig_params(const u8 **_data, size_t *_datalen,
+			 struct pgp_sig_parameters *p)
+{
+	const u8 *data = *_data;
+	size_t datalen = *_datalen;
+	int ret;
+
+	pr_devel("-->%s(,%zu,,)\n", __func__, datalen);
+
+	if (datalen < 1)
+		return -EBADMSG;
+	p->version = *data;
+
+	if (p->version == PGP_SIG_VERSION_3) {
+		const struct pgp_signature_v3_packet *v3 = (const void *)data;
+
+		if (datalen < sizeof(*v3)) {
+			pr_debug("Short V3 signature packet\n");
+			return -EBADMSG;
+		}
+		datalen -= sizeof(*v3);
+		data += sizeof(*v3);
+
+		/* V3 has everything we need in the header */
+		p->signature_type = v3->hashed.signature_type;
+		memcpy(&p->issuer, &v3->issuer, 8);
+		p->pubkey_algo = v3->pubkey_algo;
+		p->hash_algo = v3->hash_algo;
+
+	} else if (p->version == PGP_SIG_VERSION_4) {
+		const struct pgp_signature_v4_packet *v4 = (const void *)data;
+		struct pgp_parse_sig_params_ctx ctx = {
+			.base.process_packet = pgp_process_sig_params_subpkt,
+			.params = p,
+			.got_the_issuer = false,
+		};
+		size_t subdatalen;
+
+		if (datalen < sizeof(*v4) + 2 + 2 + 2) {
+			pr_debug("Short V4 signature packet\n");
+			return -EBADMSG;
+		}
+		datalen -= sizeof(*v4);
+		data += sizeof(*v4);
+
+		/* V4 has most things in the header... */
+		p->signature_type = v4->signature_type;
+		p->pubkey_algo = v4->pubkey_algo;
+		p->hash_algo = v4->hash_algo;
+
+		/*
+		 * ... but we have to get the key ID from the subpackets, of
+		 * which there are two sets.
+		 */
+		__set_bit(PGP_SIG_ISSUER, ctx.base.types_of_interest);
+
+		subdatalen  = *data++ << 8;
+		subdatalen |= *data++;
+		datalen -= 2;
+		if (subdatalen) {
+			/* Hashed subpackets */
+			pr_devel("hashed data: %zu (after %zu)\n",
+				 subdatalen, sizeof(*v4));
+			if (subdatalen > datalen + 2 + 2) {
+				pr_debug("Short V4 signature packet [hdata]\n");
+				return -EBADMSG;
+			}
+			ret = pgp_parse_sig_subpkts(data, subdatalen,
+						    &ctx.base);
+			if (ret < 0)
+				return ret;
+			data += subdatalen;
+			datalen -= subdatalen;
+		}
+
+		subdatalen  = *data++ << 8;
+		subdatalen |= *data++;
+		datalen -= 2;
+		if (subdatalen) {
+			/* Unhashed subpackets */
+			pr_devel("unhashed data: %zu\n", subdatalen);
+			if (subdatalen > datalen + 2) {
+				pr_debug("Short V4 signature packet [udata]\n");
+				return -EBADMSG;
+			}
+			ret = pgp_parse_sig_subpkts(data, subdatalen,
+						    &ctx.base);
+			if (ret < 0)
+				return ret;
+			data += subdatalen;
+			datalen -= subdatalen;
+		}
+
+		if (!ctx.got_the_issuer) {
+			pr_debug("V4 signature packet lacks issuer\n");
+			return -EBADMSG;
+		}
+	} else {
+		pr_debug("Signature packet with unhandled version %d\n",
+			 p->version);
+		return -EBADMSG;
+	}
+
+	*_data = data;
+	*_datalen = datalen;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pgp_parse_sig_params);
diff --git a/crypto/asymmetric_keys/pgplib.h b/crypto/asymmetric_keys/pgplib.h
index 3ec4b408a11e..25191cea33a4 100644
--- a/crypto/asymmetric_keys/pgplib.h
+++ b/crypto/asymmetric_keys/pgplib.h
@@ -31,3 +31,28 @@ struct pgp_parse_pubkey {
 
 extern int pgp_parse_public_key(const u8 **_data, size_t *_datalen,
 				struct pgp_parse_pubkey *pk);
+
+struct pgp_parse_sig_context {
+	unsigned long types_of_interest[128 / BITS_PER_LONG];
+	int (*process_packet)(struct pgp_parse_sig_context *context,
+			      enum pgp_sig_subpkt_type type,
+			      const u8 *data,
+			      size_t datalen);
+};
+
+extern int pgp_parse_sig_packets(const u8 *data, size_t datalen,
+				 struct pgp_parse_sig_context *ctx);
+
+struct pgp_sig_parameters {
+	enum pgp_signature_version version : 8;
+	enum pgp_signature_type signature_type : 8;
+	enum pgp_pubkey_algo pubkey_algo : 8;
+	enum pgp_hash_algo hash_algo : 8;
+	union {
+		struct pgp_key_ID issuer;
+		__be32 issuer32[2];
+	};
+};
+
+extern int pgp_parse_sig_params(const u8 **_data, size_t *_datalen,
+				struct pgp_sig_parameters *p);
-- 
2.34.1


