Return-Path: <linux-kernel+bounces-239499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8BC9260F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529F81C22C3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6164517966D;
	Wed,  3 Jul 2024 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="pzDjb0Bh"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE04179641
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011252; cv=none; b=QsWQUaq0yyg8FqhhYrCpwOSscYIEZSPwpOdYnJj4tkp5GKiGR1SI/JpVe0hjP7BbBDsfrx5NifbiNP7lyVXZla1DvD1bcuiqHbobW3WTbIsiaEL8PMjCSt4cBpBCTJVnuYIS4w8c6JZUwi+YSLL5Tjzxmfl3GQmUPkSjj4ODJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011252; c=relaxed/simple;
	bh=ej4DRPK0/rYZog3eIJb7t75rQM0X53llNTBRXQWgPLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jV7PwU/NAEcOLiBZcMhNB3YrbTlyTEXaO1ox52yruTtp52Ym9CtsaDQDqgeHwCrmlf6IPZ1C35S9Qnt82cDzTnsQyGNKLMaCkb5NcGxwk45aLIRI9yuthbTIyz9dQKo18afw1qjiUiCReFFAfHHMA4008y/bDwJPaL3hRxK+nls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=pzDjb0Bh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36789d19ffbso760558f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1720011249; x=1720616049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogZkpiiKmUATBh2P81264pdDXZ4qUG+ZRQsmJgTVO3k=;
        b=pzDjb0BhgBglNJt+nB9q5tIdc5qvg8mBaV5P+q2TbwHDYO2HFZhJS8OHeTQsadQrU9
         S0SoJQZfmbGpl3Pfo2TdyoS1SyUnQ0EBot6yMwFYOdFXX93Xz4xaqTq2wH6y2LDwmyT3
         QQ980iPI5y2ifYorHKQdlMvXTqUtxjKdhwpqvSkW8iiLDS3icpb0YyibWaUYS0gxwcNo
         CAeGgPwh+g1i35I+GxaoruzkoXNAQdDEDV9/vlP7p4XB1jK91TuA57nRmvF/GtmFkA1d
         4XrySlj7z4bEfcKLnaWyTsE2SyESScMU20sYwkL5gIZoDimJDKCGtZTG3aYLEbPNBvg0
         Sg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720011249; x=1720616049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogZkpiiKmUATBh2P81264pdDXZ4qUG+ZRQsmJgTVO3k=;
        b=h7HSCMjxcCyobiKGvqLDlYhrIClXQS17D3f76ILH6wCVze8LjBOcu6/KPclasludyC
         R0lFzpqK3CN2flmqRhOHNluW+cKOZiB1z9wLIhp8NUtkpge9/ZlN3F9X698G3R1LgV0+
         qxeZpO63Ad7IeCIpsz2H9tGHmAyXzhOd5hQfG8QZE1OL28BFSerUkFI65pHuBHRAVjs/
         fTKoO9/hWy7AC+yW3T6Uwp4DwbJ+VSwEg5nHcggisKa+ASlzlYqOQ9qDi9ioqwfFC8R7
         CHBymij1WGRqkKPP6DFvvWPwYCH6RvQP6g0VZIoz0jh/c8cEIczt6m9G3YXaG88vpQsx
         j38Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVq8ajMLumw8b7Vxl9GZODH9yWYK2NrizbbxsnnnAM28KWS0i1Oh6ZAqET73Bc8YFeKd8UaG+FoZCirGufzvkiA7p5DFfRvwkDJj4I
X-Gm-Message-State: AOJu0YzMlRSSmo9mN5mCS22xjUFxTAfmd7nJo3ddmfaLbq6/tTjE3FV5
	DukycibT85di4vUj+ExRn2+Oy7TvUNVduTcrRiNyw45aIfIYgH1hHUKM1SycI3U=
X-Google-Smtp-Source: AGHT+IF0v/eZhOIu9x1sxCmfokLUMTeBD5wN6QOfncceonScPm4movN63YwShRHYE2qtmSUJ0jf9uw==
X-Received: by 2002:adf:a395:0:b0:367:8383:6305 with SMTP id ffacd0b85a97d-367838364e4mr2581253f8f.55.1720011249184;
        Wed, 03 Jul 2024 05:54:09 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-36792881856sm1791613f8f.6.2024.07.03.05.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 05:54:09 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
To: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
	Richard Weinberger <richard@nod.at>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Gstir <david@sigma-star.at>
Subject: [PATCH 2/2] KEYS: trusted: dcp: fix leak of blob encryption key
Date: Wed,  3 Jul 2024 14:53:53 +0200
Message-ID: <20240703125353.46115-2-david@sigma-star.at>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703125353.46115-1-david@sigma-star.at>
References: <20240703125353.46115-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trusted keys unseal the key blob on load, but keep the sealed payload in
the blob field so that every subsequent read (export) will simply
convert this field to hex and send it to userspace.

With DCP-based trusted keys, we decrypt the blob encryption key (BEK)
in the Kernel due hardware limitations and then decrypt the blob payload.
BEK decryption is done in-place which means that the trusted key blob
field is modified and it consequently holds the BEK in plain text.
Every subsequent read of that key thus send the plain text BEK instead
of the encrypted BEK to userspace.

This issue only occurs when importing a trusted DCP-based key and
then exporting it again. This should rarely happen as the common use cases
are to either create a new trusted key and export it, or import a key
blob and then just use it without exporting it again.

Fix this by performing BEK decryption and encryption in a dedicated
buffer. Further always wipe the plain text BEK buffer to prevent leaking
the key via uninitialized memory.

Signed-off-by: David Gstir <david@sigma-star.at>
Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted keys")
---
 security/keys/trusted-keys/trusted_dcp.c | 33 +++++++++++++++---------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index b0947f072a98..4edc5bbbcda3 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -186,20 +186,21 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len, u8 *key, u8 *nonce,
 	return ret;
 }
 
-static int decrypt_blob_key(u8 *key)
+static int decrypt_blob_key(u8 *encrypted_key, u8 *plain_key)
 {
-	return do_dcp_crypto(key, key, false);
+	return do_dcp_crypto(encrypted_key, plain_key, false);
 }
 
-static int encrypt_blob_key(u8 *key)
+static int encrypt_blob_key(u8 *plain_key, u8 *encrypted_key)
 {
-	return do_dcp_crypto(key, key, true);
+	return do_dcp_crypto(plain_key, encrypted_key, true);
 }
 
 static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
 	int blen, ret;
+	u8 plain_blob_key[AES_KEYSIZE_128];
 
 	blen = calc_blob_len(p->key_len);
 	if (blen > MAX_BLOB_SIZE)
@@ -207,30 +208,36 @@ static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 
 	b->fmt_version = DCP_BLOB_VERSION;
 	get_random_bytes(b->nonce, AES_KEYSIZE_128);
-	get_random_bytes(b->blob_key, AES_KEYSIZE_128);
+	get_random_bytes(plain_blob_key, AES_KEYSIZE_128);
 
-	ret = do_aead_crypto(p->key, b->payload, p->key_len, b->blob_key,
+	ret = do_aead_crypto(p->key, b->payload, p->key_len, plain_blob_key,
 			     b->nonce, true);
 	if (ret) {
 		pr_err("Unable to encrypt blob payload: %i\n", ret);
-		return ret;
+		goto out;
 	}
 
-	ret = encrypt_blob_key(b->blob_key);
+	ret = encrypt_blob_key(plain_blob_key, b->blob_key);
 	if (ret) {
 		pr_err("Unable to encrypt blob key: %i\n", ret);
-		return ret;
+		goto out;
 	}
 
 	put_unaligned_le32(p->key_len, &b->payload_len);
 	p->blob_len = blen;
-	return 0;
+	ret = 0;
+
+out:
+	memzero_explicit(plain_blob_key, sizeof(plain_blob_key));
+
+	return ret;
 }
 
 static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
 	int blen, ret;
+	u8 plain_blob_key[AES_KEYSIZE_128];
 
 	if (b->fmt_version != DCP_BLOB_VERSION) {
 		pr_err("DCP blob has bad version: %i, expected %i\n",
@@ -248,14 +255,14 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 		goto out;
 	}
 
-	ret = decrypt_blob_key(b->blob_key);
+	ret = decrypt_blob_key(b->blob_key, plain_blob_key);
 	if (ret) {
 		pr_err("Unable to decrypt blob key: %i\n", ret);
 		goto out;
 	}
 
 	ret = do_aead_crypto(b->payload, p->key, p->key_len + DCP_BLOB_AUTHLEN,
-			     b->blob_key, b->nonce, false);
+			     plain_blob_key, b->nonce, false);
 	if (ret) {
 		pr_err("Unwrap of DCP payload failed: %i\n", ret);
 		goto out;
@@ -263,6 +270,8 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 
 	ret = 0;
 out:
+	memzero_explicit(plain_blob_key, sizeof(plain_blob_key));
+
 	return ret;
 }
 
-- 
2.35.3


