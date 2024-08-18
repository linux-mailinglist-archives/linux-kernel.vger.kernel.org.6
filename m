Return-Path: <linux-kernel+bounces-291121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A9B955D97
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE181C208EF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5027915350B;
	Sun, 18 Aug 2024 16:59:56 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECB9145B21;
	Sun, 18 Aug 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000395; cv=none; b=iIoT/2e6fTf+EgO6gnuPgIxWj7duLyGVhuMFbksbgwNbcz6YSRDxSiF9y+iwWOH6SEm8kD7OIlpokzsbRaf8ZAiQG1A0ugTAnOop5tT7p2tysFweQ7yX37k1WdUco6HjDxuzU4EXICc4q8VwGZ+4z12epftZpeviQck0I5lg3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000395; c=relaxed/simple;
	bh=zadhMIMAhHYJ1waNtdLmU4A5krbN3rV+oKsxvuPZD4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gJU510d2hCKXgrFFYF5RhpLyVQbtNLI6AFjQU7xXN7PuYFr0YmaOuzoEaBZm03kd+q44waiHImWQaipob+OCmgiBZ2uf/X1fT1icZZOIJue8yyU0dX4pk0CS5oLSyrowUjJJesftLIBv3zi7vqmBtauKJ0cpUKJBueBzFE1vfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Wn1gf6LGFz9v7NM;
	Mon, 19 Aug 2024 00:40:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id BEEE2140203;
	Mon, 19 Aug 2024 00:59:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXm4VpKMJm+zZxAQ--.21009S3;
	Sun, 18 Aug 2024 17:59:39 +0100 (CET)
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
Subject: [PATCH v2 01/14] mpi: Introduce mpi_key_length()
Date: Sun, 18 Aug 2024 18:57:43 +0200
Message-Id: <20240818165756.629203-2-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAXm4VpKMJm+zZxAQ--.21009S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw17KFy3ur47KF1UAFWfAFb_yoW5Jr17pF
	4Ykw45JrWkJr1SkFyfC3Z5Ga45C3Wv9F1UKrZrJw17J39IkrnxWFZ7ua4Yva18Gr1xAF1U
	X3y3WFZ5Crn5ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UR89tU
	UUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGbBWPgB5wACs2

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the new function to get the number of bits and bytes from an MPI.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/mpi.h       |  2 ++
 lib/crypto/mpi/mpicoder.c | 33 ++++++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/mpi.h b/include/linux/mpi.h
index eb0d1c1db208..a7dd4c9d8120 100644
--- a/include/linux/mpi.h
+++ b/include/linux/mpi.h
@@ -90,6 +90,8 @@ enum gcry_mpi_format {
 };
 
 MPI mpi_read_raw_data(const void *xbuffer, size_t nbytes);
+int mpi_key_length(const void *xbuffer, unsigned int ret_nread,
+		   unsigned int *nbits_arg, unsigned int *nbytes_arg);
 MPI mpi_read_from_buffer(const void *buffer, unsigned *ret_nread);
 int mpi_fromstr(MPI val, const char *str);
 MPI mpi_scanval(const char *string);
diff --git a/lib/crypto/mpi/mpicoder.c b/lib/crypto/mpi/mpicoder.c
index 3cb6bd148fa9..92447a1c8bf9 100644
--- a/lib/crypto/mpi/mpicoder.c
+++ b/lib/crypto/mpi/mpicoder.c
@@ -79,22 +79,41 @@ MPI mpi_read_raw_data(const void *xbuffer, size_t nbytes)
 }
 EXPORT_SYMBOL_GPL(mpi_read_raw_data);
 
-MPI mpi_read_from_buffer(const void *xbuffer, unsigned *ret_nread)
+int mpi_key_length(const void *xbuffer, unsigned int ret_nread,
+		   unsigned int *nbits_arg, unsigned int *nbytes_arg)
 {
 	const uint8_t *buffer = xbuffer;
-	unsigned int nbits, nbytes;
-	MPI val;
+	unsigned int nbits;
 
-	if (*ret_nread < 2)
-		return ERR_PTR(-EINVAL);
+	if (ret_nread < 2)
+		return -EINVAL;
 	nbits = buffer[0] << 8 | buffer[1];
 
 	if (nbits > MAX_EXTERN_MPI_BITS) {
 		pr_info("MPI: mpi too large (%u bits)\n", nbits);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
-	nbytes = DIV_ROUND_UP(nbits, 8);
+	if (nbits_arg)
+		*nbits_arg = nbits;
+	if (nbytes_arg)
+		*nbytes_arg = DIV_ROUND_UP(nbits, 8);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mpi_key_length);
+
+MPI mpi_read_from_buffer(const void *xbuffer, unsigned int *ret_nread)
+{
+	const uint8_t *buffer = xbuffer;
+	unsigned int nbytes;
+	MPI val;
+	int ret;
+
+	ret = mpi_key_length(xbuffer, *ret_nread, NULL, &nbytes);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
 	if (nbytes + 2 > *ret_nread) {
 		pr_info("MPI: mpi larger than buffer nbytes=%u ret_nread=%u\n",
 				nbytes, *ret_nread);
-- 
2.34.1


