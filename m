Return-Path: <linux-kernel+bounces-347593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 964F798D65D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD35D1F21C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019781D0796;
	Wed,  2 Oct 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cE6ddQWe"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919DC1D0164
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876323; cv=none; b=gL6YiPKk+TT2qKVA77RUNWuczQws2fjAQvswjF8cplEVMnaySwUAs48+QfV5A4PvpIpGk4LJHUmhzFNwJiI+srqqWSJHf56qQEf+4ox9iRNmo8T22F0T6i/hRVn44SRTJOzEHiUhx0FuEeO5xUScWAVSAkkFO0PFPVZJAXN/EuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876323; c=relaxed/simple;
	bh=gcIDH13e2aTfwel1X1F7pzYx1hu5LIhtIRQQf+osTqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S0/ss/zqTPtMyouEgXnziXhvx5f0K5p64aaO+OCybJQQHAaEBMN2Uq3AxfEfMhQc8rI/GCstpZjxXU1xOSWainYS0wBHVwb9oJplPmPxJTESmIyLgCqECFETBqJKqhA3VHgyzLk4FPjOeBuwGYo7VyFJuYRBcWVXIXb/vQJMsIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cE6ddQWe; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cb2f272f8bso60333226d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727876320; x=1728481120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yLxCOAKddqmh7qui9eIfopVppaY+rnlB+VJVr6JHh78=;
        b=cE6ddQWecsBVhZ1nZnWAEnXeYQddvFksy5IjQydCZcpKi/DW5yTmpjZQzNCeVd1JR0
         +l6k7PSXbW7qS4zqSZm23C97otXbvJdLOWHm45A9CgKXEn7PNi/+8Is1nfSoRG0KF5Nc
         GSDFQJG9nUj6PEFy3sqnP9uIFcaT8/AaE7DBZE01Ihv5kmcK8PMUhQAhDMi7zDnQz48y
         5pbH+11ULyXiwlfad9UEQePQbMzgwqcqS2zM3fFmzK/N3x1dvfVZkiX93jWdYkFZT0Ru
         40ke7t/Lkzb8yhbaA3H8wTdZPCAXhtjC0njusqq7Z6jQaDZVW8O58Q7rmIwTWdUQLWHv
         /HPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727876320; x=1728481120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLxCOAKddqmh7qui9eIfopVppaY+rnlB+VJVr6JHh78=;
        b=bcBfxfISSjFOdpmBnOQsREGRhhH5btCEOeUyUges/veHUJO8VvyCie/p1vuwnVK+BW
         nLWlWTvRNXZ8e+bhFTUJJtsW5QEcJeo5ZaQ4HP0VtvRGmHghSsyFAXJCLdk7RKIkMWxG
         qmXGZL7RT/ieLi+7U6VVL5vlM4NLbIJFaBflJ7mXjylBlfgw9x+EjQqWo+Crm+fZgkts
         5QKxCKq4AGhHmtrOw0xtJ87FWqzD1kFioIBDRdyNt2m6sNlRPyez33oBicpO0DtRuqM4
         Ryk0MyOIgy2l0DDXKqlPJ4vG4W6fO1u+ZPg8uhnc1RIEsEqVJqPrQSJj69Nj9mUq6euY
         b6cg==
X-Gm-Message-State: AOJu0YwFv17w2SToiYe6R+RHnoFHDGWNxfrZSNWYTzQ9sXbjydN3k9lg
	GaQJKS/01A8wO6ByTUS6usJ3jLwZprWgSzl5prX5ScNu7YSKFOWWpbk3zmIlQw6JtvVp21Djyjp
	C
X-Google-Smtp-Source: AGHT+IHHaRCQL0sDuXF7HKHgY5Z1QFVZFXy4DLiY0UoZyyprKOFlem1QR1tbag4HUFUyUKoniteYZg==
X-Received: by 2002:a05:6214:4521:b0:6cb:458d:6525 with SMTP id 6a1803df08f44-6cb81a30afemr60363076d6.26.1727876320060;
        Wed, 02 Oct 2024 06:38:40 -0700 (PDT)
Received: from localhost ([93.115.195.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b610d4dsm61423336d6.49.2024.10.02.06.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:38:39 -0700 (PDT)
From: Fam Zheng <fam.zheng@bytedance.com>
To: linux-kernel@vger.kernel.org
Cc: fam@euphon.net,
	David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	fam.zheng@bytedance.com
Subject: [PATCH] sign-file: Add -D "digest mode"
Date: Wed,  2 Oct 2024 14:38:37 +0100
Message-Id: <20241002133837.1030094-1-fam.zheng@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows the command to sign by a binary digest file, instead of the
original ko file.

Combined with the -p (save_sig), we can now split module building (e.g.
dkms) and module signing into different steps and environments, while
_not_ requiring copying the whole module file back and forth.

Example usage:

1. On host side:
    mod=ip6_gre.ko
    openssl dgst -binary -sha256 $mod > $mod.digest

2. Send $mod.digest over to a signing service

3. On the server side, sign the digest using new mode:

    ./sign-file -dpD sha256 private_key.pem cert.pem $mod.digest

4. Server returns the signature (it will be named $mod.digest.p7s) in
binary

5. Client uses the returned signature to sign the ko locally:

    ./sign-file -s signature sha256 cert.pem $mod

Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
---
 scripts/sign-file.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 7070245edfc1..29e1aa798f54 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -56,6 +56,9 @@
 	defined(OPENSSL_NO_CMS)
 #define USE_PKCS7
 #endif
+#if OPENSSL_VERSION_NUMBER > 0x30200000L
+#define HAS_CMS_final_digest 1
+#endif
 #ifndef USE_PKCS7
 #include <openssl/cms.h>
 #else
@@ -80,9 +83,9 @@ static __attribute__((noreturn))
 void format(void)
 {
 	fprintf(stderr,
-		"Usage: scripts/sign-file [-dp] <hash algo> <key> <x509> <module> [<dest>]\n");
+		"Usage: scripts/sign-file [-dpD] <hash algo> <key> <x509> <file> [<dest>]\n");
 	fprintf(stderr,
-		"       scripts/sign-file -s <raw sig> <hash algo> <x509> <module> [<dest>]\n");
+		"       scripts/sign-file -s <raw sig> <hash algo> <x509> <file> [<dest>]\n");
 	exit(2);
 }
 
@@ -229,6 +232,9 @@ int main(int argc, char **argv)
 	unsigned char buf[4096];
 	unsigned long module_size, sig_size;
 	unsigned int use_signed_attrs;
+	bool digest_mode = false;
+	unsigned char digest_bin[4096];
+	long digest_len;
 	const EVP_MD *digest_algo;
 	EVP_PKEY *private_key;
 #ifndef USE_PKCS7
@@ -253,11 +259,20 @@ int main(int argc, char **argv)
 #endif
 
 	do {
-		opt = getopt(argc, argv, "sdpk");
+		opt = getopt(argc, argv, "sdpkD");
 		switch (opt) {
 		case 's': raw_sig = true; break;
 		case 'p': save_sig = true; break;
 		case 'd': sign_only = true; save_sig = true; break;
+		case 'D':
+#ifdef HAS_CMS_final_digest
+			digest_mode = true;
+			break;
+#else
+			fprintf(stderr, "digest signing is not supported by the openssl version in use\n");
+			exit(3);
+			break;
+#endif
 #ifndef USE_PKCS7
 		case 'k': use_keyid = CMS_USE_KEYID; break;
 #endif
@@ -301,6 +316,17 @@ int main(int argc, char **argv)
 	bm = BIO_new_file(module_name, "rb");
 	ERR(!bm, "%s", module_name);
 
+#ifdef HAS_CMS_final_digest
+	if (digest_mode) {
+		digest_len = BIO_read(bm, digest_bin, sizeof(digest_bin));
+		if (digest_len >= sizeof(digest_bin)) {
+			fprintf(stderr, "sign-file: Digest file too large (max %ld)\n", sizeof(digest_bin));
+			exit(3);
+		}
+		ERR(BIO_reset(bm) < 0, "%s", module_name);
+	}
+#endif
+
 	if (!raw_sig) {
 		/* Read the private key and the X.509 cert the PKCS#7 message
 		 * will point to.
@@ -324,10 +350,15 @@ int main(int argc, char **argv)
 		ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
 				     CMS_NOCERTS | CMS_BINARY |
 				     CMS_NOSMIMECAP | use_keyid |
+				     (digest_mode ? CMS_KEY_PARAM : 0) |
 				     use_signed_attrs),
 		    "CMS_add1_signer");
-		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) != 1,
-		    "CMS_final");
+		if (digest_mode)
+			ERR(CMS_final_digest(cms, digest_bin, digest_len, NULL, CMS_NOCERTS | CMS_BINARY) != 1,
+			    "CMS_final_digest");
+		else
+			ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) != 1,
+			    "CMS_final");
 
 #else
 		pkcs7 = PKCS7_sign(x509, private_key, NULL, bm,
-- 
2.20.1


