Return-Path: <linux-kernel+bounces-179011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4254B8C5A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6CDAB22236
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90BF180A6F;
	Tue, 14 May 2024 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nxuG1FSr"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD481791ED;
	Tue, 14 May 2024 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708346; cv=none; b=IjfKDCs/QXtah3O9OYhevka32bgEjQtZFNt8B0SYq6oQap6oi/FiGaXUwD1W4Vcw+L+ovA/m4ZG7eO42Dai2NGxSh4eGFD6GxOgeAFa3IuRP3Ssf02xQx7yMWFVKtbPQVpAzIBqMLMQcUz8tk+oFC3W4ZGxcAXj/ynNsCBtzsVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708346; c=relaxed/simple;
	bh=RczWejKBOgrW3Q8V4vHFz4+EEVj1cRZ5VDsVar5dYHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GW4w6G6YpenYUuqwijC8b6e9F6+WEqAUPT/DQD7Ckfvm2fXEhn9nI4Beb7S9iQKfSDKBy/LurQqV9AYgR5ueP+FKyZaMEIzSDMRhN4opYKjVy4VgMkGmR6gp1/kGORqXtfEjPr6u7v3ADnzJasdDgkNJ2rcz4I4896KUpkAlXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nxuG1FSr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EFb95h032729;
	Tue, 14 May 2024 17:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TSEbfUfA16PW9NBoI5Sb0F9RiCAwAd2qS/Xm8JAFC88=;
 b=nxuG1FSrte5RHP2lqAQazRh2zNvQS4o7G0LeHeVWEn70dSnUScZYHWJsiR3dS3Z5hk8N
 Fhzz20qSK2x5UANtyV/aPDtOs6enKIHgQ7ZVfNSXl0jHlcahPw65kJmVYIcjGl87fH49
 tgwtkIPt4Z4UAvKDiQczqjQ0Fqm/0B10Ryr7vNV5vVuIh+1L8v5oZj0mYvWOaERmmMOx
 pe8LcodrqmlV6vl1+7JnXFeS4f0G32dHNavX/UMQXuscysg/7cHaMhbEh+anbgcziA1o
 YYCBu9q9t3gO+e43fBFGgreWRqxVSYHywATvFEycx/Y17EtDU7pqUaWP88bOfTByQAgv /A== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4ark0ahb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 17:38:48 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EG0lSc005986;
	Tue, 14 May 2024 17:38:46 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgmen11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 17:38:46 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EHchkA8847820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 17:38:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6444258052;
	Tue, 14 May 2024 17:38:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 160AD58056;
	Tue, 14 May 2024 17:38:43 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 17:38:43 +0000 (GMT)
From: Danny Tsen <dtsen@linux.ibm.com>
To: linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, leitao@debian.org, nayna@linux.ibm.com,
        appro@cryptogams.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com,
        Danny Tsen <dtsen@linux.ibm.com>
Subject: [PATCH 2/3] crypto: X25519 core functions for ppc64le
Date: Tue, 14 May 2024 13:38:34 -0400
Message-Id: <20240514173835.4814-3-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240514173835.4814-1-dtsen@linux.ibm.com>
References: <20240514173835.4814-1-dtsen@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UNguCyCxK8zfcuPEa-jcFePBKIrTkUY6
X-Proofpoint-GUID: UNguCyCxK8zfcuPEa-jcFePBKIrTkUY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_10,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140124

X25519 core functions to handle scalar multiplication for ppc64le.

Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
---
 arch/powerpc/crypto/curve25519-ppc64le-core.c | 299 ++++++++++++++++++
 1 file changed, 299 insertions(+)
 create mode 100644 arch/powerpc/crypto/curve25519-ppc64le-core.c

diff --git a/arch/powerpc/crypto/curve25519-ppc64le-core.c b/arch/powerpc/crypto/curve25519-ppc64le-core.c
new file mode 100644
index 000000000000..6a8b5efc40ce
--- /dev/null
+++ b/arch/powerpc/crypto/curve25519-ppc64le-core.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2024- IBM Corp. All rights reserved.
+ *
+ * X25519 scalar multiplication with 51 bits limbs for PPC64le.
+ *   Based on RFC7748 and AArch64 optimized implementation for X25519
+ *     - Algorithm 1 Scalar multiplication of a variable point
+ */
+
+#include <crypto/curve25519.h>
+#include <crypto/internal/kpp.h>
+
+#include <linux/types.h>
+#include <linux/jump_label.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+
+#include <linux/cpufeature.h>
+#include <linux/processor.h>
+
+typedef uint64_t fe51[5];
+
+asmlinkage void x25519_fe51_mul(fe51 h, const fe51 f, const fe51 g);
+asmlinkage void x25519_fe51_sqr(fe51 h, const fe51 f);
+asmlinkage void x25519_fe51_mul121666(fe51 h, fe51 f);
+asmlinkage void x25519_fe51_sqr_times(fe51 h, const fe51 f, int n);
+asmlinkage void x25519_fe51_frombytes(fe51 h, const uint8_t *s);
+asmlinkage void x25519_fe51_tobytes(uint8_t *s, const fe51 h);
+
+#define fmul x25519_fe51_mul
+#define fsqr x25519_fe51_sqr
+#define fmul121666 x25519_fe51_mul121666
+#define fe51_tobytes x25519_fe51_tobytes
+#define fe51_frombytes x25519_fe51_frombytes
+
+static void cswap(fe51 p, fe51 q, unsigned int bit)
+{
+	u64 t, i;
+	u64 c = 0 - (u64) bit;
+
+	for (i = 0; i < 5; ++i) {
+		t = c & (p[i] ^ q[i]);
+		p[i] ^= t;
+		q[i] ^= t;
+	}
+}
+
+static void fadd(fe51 h, const fe51 f, const fe51 g)
+{
+	h[0] = f[0] + g[0];
+	h[1] = f[1] + g[1];
+	h[2] = f[2] + g[2];
+	h[3] = f[3] + g[3];
+	h[4] = f[4] + g[4];
+}
+
+/*
+ * Prime = 2 ** 255 - 19, 255 bits
+ *    (0x7fffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffed)
+ *
+ * Prime in 5 51-bit limbs
+ */
+static fe51 prime51 = { 0x7ffffffffffed, 0x7ffffffffffff, 0x7ffffffffffff, 0x7ffffffffffff, 0x7ffffffffffff};
+
+static void fsub(fe51 h, const fe51 f, const fe51 g)
+{
+	h[0] = (f[0] + ((prime51[0] * 2))) - g[0];
+	h[1] = (f[1] + ((prime51[1] * 2))) - g[1];
+	h[2] = (f[2] + ((prime51[2] * 2))) - g[2];
+	h[3] = (f[3] + ((prime51[3] * 2))) - g[3];
+	h[4] = (f[4] + ((prime51[4] * 2))) - g[4];
+}
+
+static void finv(fe51 o, const fe51 i)
+{
+	fe51 a0, b, c, t00;
+
+	fsqr(a0, i);
+	x25519_fe51_sqr_times(t00, a0, 2);
+
+	fmul(b, t00, i);
+	fmul(a0, b, a0);
+
+	fsqr(t00, a0);
+
+	fmul(b, t00, b);
+	x25519_fe51_sqr_times(t00, b, 5);
+
+	fmul(b, t00, b);
+	x25519_fe51_sqr_times(t00, b, 10);
+
+	fmul(c, t00, b);
+	x25519_fe51_sqr_times(t00, c, 20);
+
+	fmul(t00, t00, c);
+	x25519_fe51_sqr_times(t00, t00, 10);
+
+	fmul(b, t00, b);
+	x25519_fe51_sqr_times(t00, b, 50);
+
+	fmul(c, t00, b);
+	x25519_fe51_sqr_times(t00, c, 100);
+
+	fmul(t00, t00, c);
+	x25519_fe51_sqr_times(t00, t00, 50);
+
+	fmul(t00, t00, b);
+	x25519_fe51_sqr_times(t00, t00, 5);
+
+	fmul(o, t00, a0);
+}
+
+static void curve25519_fe51(uint8_t out[32], const uint8_t scalar[32],
+			    const uint8_t point[32])
+{
+	fe51 x1, x2, z2, x3, z3;
+	uint8_t s[32];
+	unsigned int swap = 0;
+	int i;
+
+	memcpy(s, scalar, 32);
+	s[0]  &= 0xf8;
+	s[31] &= 0x7f;
+	s[31] |= 0x40;
+	fe51_frombytes(x1, point);
+
+	z2[0] = z2[1] = z2[2] = z2[3] = z2[4] = 0;
+	x3[0] = x1[0];
+	x3[1] = x1[1];
+	x3[2] = x1[2];
+	x3[3] = x1[3];
+	x3[4] = x1[4];
+
+	x2[0] = z3[0] = 1;
+	x2[1] = z3[1] = 0;
+	x2[2] = z3[2] = 0;
+	x2[3] = z3[3] = 0;
+	x2[4] = z3[4] = 0;
+
+	for (i = 254; i >= 0; --i) {
+		unsigned int k_t = 1 & (s[i / 8] >> (i & 7));
+		fe51 a, b, c, d, e;
+		fe51 da, cb, aa, bb;
+		fe51 dacb_p, dacb_m;
+
+		swap ^= k_t;
+		cswap(x2, x3, swap);
+		cswap(z2, z3, swap);
+		swap = k_t;
+
+		fsub(b, x2, z2);		// B = x_2 - z_2
+		fadd(a, x2, z2);		// A = x_2 + z_2
+		fsub(d, x3, z3);		// D = x_3 - z_3
+		fadd(c, x3, z3);		// C = x_3 + z_3
+
+		fsqr(bb, b);			// BB = B^2
+		fsqr(aa, a);			// AA = A^2
+		fmul(da, d, a);			// DA = D * A
+		fmul(cb, c, b);			// CB = C * B
+
+		fsub(e, aa, bb);		// E = AA - BB
+		fmul(x2, aa, bb);		// x2 = AA * BB
+		fadd(dacb_p, da, cb);		// DA + CB
+		fsub(dacb_m, da, cb);		// DA - CB
+
+		fmul121666(z3, e);		// 121666 * E
+		fsqr(z2, dacb_m);		// (DA - CB)^2
+		fsqr(x3, dacb_p);		// x3 = (DA + CB)^2
+		fadd(b, bb, z3);		// BB + 121666 * E
+		fmul(z3, x1, z2);		// z3 = x1 * (DA - CB)^2
+		fmul(z2, e, b);		// z2 = e * (BB + (DA + CB)^2)
+	}
+
+	finv(z2, z2);
+	fmul(x2, x2, z2);
+	fe51_tobytes(out, x2);
+}
+
+void curve25519_arch(u8 mypublic[CURVE25519_KEY_SIZE],
+		     const u8 secret[CURVE25519_KEY_SIZE],
+		     const u8 basepoint[CURVE25519_KEY_SIZE])
+{
+	curve25519_fe51(mypublic, secret, basepoint);
+}
+EXPORT_SYMBOL(curve25519_arch);
+
+void curve25519_base_arch(u8 pub[CURVE25519_KEY_SIZE],
+			  const u8 secret[CURVE25519_KEY_SIZE])
+{
+	curve25519_fe51(pub, secret, curve25519_base_point);
+}
+EXPORT_SYMBOL(curve25519_base_arch);
+
+static int curve25519_set_secret(struct crypto_kpp *tfm, const void *buf,
+				 unsigned int len)
+{
+	u8 *secret = kpp_tfm_ctx(tfm);
+
+	if (!len)
+		curve25519_generate_secret(secret);
+	else if (len == CURVE25519_KEY_SIZE &&
+		 crypto_memneq(buf, curve25519_null_point, CURVE25519_KEY_SIZE))
+		memcpy(secret, buf, CURVE25519_KEY_SIZE);
+	else
+		return -EINVAL;
+	return 0;
+}
+
+static int curve25519_generate_public_key(struct kpp_request *req)
+{
+	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
+	const u8 *secret = kpp_tfm_ctx(tfm);
+	u8 buf[CURVE25519_KEY_SIZE];
+	int copied, nbytes;
+
+	if (req->src)
+		return -EINVAL;
+
+	curve25519_base_arch(buf, secret);
+
+	/* might want less than we've got */
+	nbytes = min_t(size_t, CURVE25519_KEY_SIZE, req->dst_len);
+	copied = sg_copy_from_buffer(req->dst, sg_nents_for_len(req->dst,
+								nbytes),
+				     buf, nbytes);
+	if (copied != nbytes)
+		return -EINVAL;
+	return 0;
+}
+
+static int curve25519_compute_shared_secret(struct kpp_request *req)
+{
+	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
+	const u8 *secret = kpp_tfm_ctx(tfm);
+	u8 public_key[CURVE25519_KEY_SIZE];
+	u8 buf[CURVE25519_KEY_SIZE];
+	int copied, nbytes;
+
+	if (!req->src)
+		return -EINVAL;
+
+	copied = sg_copy_to_buffer(req->src,
+				   sg_nents_for_len(req->src,
+						    CURVE25519_KEY_SIZE),
+				   public_key, CURVE25519_KEY_SIZE);
+	if (copied != CURVE25519_KEY_SIZE)
+		return -EINVAL;
+
+	curve25519_arch(buf, secret, public_key);
+
+	/* might want less than we've got */
+	nbytes = min_t(size_t, CURVE25519_KEY_SIZE, req->dst_len);
+	copied = sg_copy_from_buffer(req->dst, sg_nents_for_len(req->dst,
+								nbytes),
+				     buf, nbytes);
+	if (copied != nbytes)
+		return -EINVAL;
+	return 0;
+}
+
+static unsigned int curve25519_max_size(struct crypto_kpp *tfm)
+{
+	return CURVE25519_KEY_SIZE;
+}
+
+static struct kpp_alg curve25519_alg = {
+	.base.cra_name		= "curve25519",
+	.base.cra_driver_name	= "curve25519-ppc64le",
+	.base.cra_priority	= 200,
+	.base.cra_module	= THIS_MODULE,
+	.base.cra_ctxsize	= CURVE25519_KEY_SIZE,
+
+	.set_secret		= curve25519_set_secret,
+	.generate_public_key	= curve25519_generate_public_key,
+	.compute_shared_secret	= curve25519_compute_shared_secret,
+	.max_size		= curve25519_max_size,
+};
+
+
+static int __init curve25519_mod_init(void)
+{
+	return IS_REACHABLE(CONFIG_CRYPTO_KPP) ?
+		crypto_register_kpp(&curve25519_alg) : 0;
+}
+
+static void __exit curve25519_mod_exit(void)
+{
+	if (IS_REACHABLE(CONFIG_CRYPTO_KPP))
+		crypto_unregister_kpp(&curve25519_alg);
+}
+
+module_init(curve25519_mod_init);
+module_exit(curve25519_mod_exit);
+
+MODULE_ALIAS_CRYPTO("curve25519");
+MODULE_ALIAS_CRYPTO("curve25519-ppc64le");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Danny Tsen <dtsen@us.ibm.com>");
-- 
2.31.1


