Return-Path: <linux-kernel+bounces-568276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C3A692AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A417F7A6B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453EB1CB332;
	Wed, 19 Mar 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="fqYYj4hy"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C351B422A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396831; cv=none; b=kuiR/cCbMA0cLk5Gi7/0BtvPjy4RvNyQ4vBngLeFLL8fDjJ0heUwMyFJ3GPJeby1c0MwYcLii0L/GL3mNKTjAyMG0eN76r0MPy0j8TPYpDmUf5eYUl5rHyG9XyAV59ExYEnrSgrGyKpYfu0k8kebQ5noBF1mAoja9BE58HKV6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396831; c=relaxed/simple;
	bh=1eZHquLTepqy42xh0mfP0tdtkd1zv4tldeAHj1pBwyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hz2OmwH+Ppjgop/qo1Y2qgrZ5mKcSEy4TPtLwgmT0S7RCF6YOsELCDnrpC0wtSvGRXYeQYBU7S2dTGsvJwtN6I3yhdFhIWprD2LbGqd6lzkhqC6jAU8CUswTnXsqeezn7IhRhzXraJN5PQYnS9Rp9T4/D3Ohe2KcMehg5RECfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hifiphile.com; spf=none smtp.mailfrom=hifiphile.com; dkim=pass (2048-bit key) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b=fqYYj4hy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hifiphile.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so46923945e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1742396828; x=1743001628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zNv4YENHPmtSPb1F94zL2vQ71swaDzySWvLHzeXUzS4=;
        b=fqYYj4hyfN+07nOSw7m2RfVCS70WVtGZy7hwnwMxSZ2TarYTxSuKWZwkfIqatVCn07
         n9zGPI0+iP+KGyURCwCXbw/kHO6VNUiD2BANUMXqNwFbDUYIZLcdJWbFxY788OkSYG8Z
         QmJgx5OQNF2yW3ixU6nVEzY61VW7w3o0c98dBZ/5cEe8Fgu3yIzp+UbSqhnC6PEBRd/1
         poMjg7Az5VjnNtKwXvt4VO1cnRQU1Y/0PyCqteucHYJse/qj+/axZJ2eEbEfnOYHQO3K
         vYslelwG6QhF0cZfDlvVJKRkLXYShnc4KnkuTt9OU5CmT6AAEe1YS0ZG38yJPRZ1tBFc
         9U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396828; x=1743001628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNv4YENHPmtSPb1F94zL2vQ71swaDzySWvLHzeXUzS4=;
        b=Il4bZ95uoo+wQDUcRk+1NHO5QoEnx5bOb1OzVAMgs5iNWvQguwaSSCn0Vvzqp2Yv9T
         aJvhSE+4Z9+uScZLlQFUhEXmGdYWOg8DnYBLkHdgIaJKJZnYD/IBk1ttuSL2W2TjX+MP
         rUzIis4PN6lYSCE0B1mFWAJQAIpS3kw97hBOnCaQlK/e1RFhbsWK7ggaQkckmgKGs8FM
         jw+988cOx3rFi4w7WXSDvyUqs8ceQuKmSET/2IFvq3OxnxDLFs6MHPDdlyb29ffQbS1w
         xmqcgdPAKQWG4f+IAjcWnHGLGK1zbs/tGXkIbmv6LCpbcT+TO/JqWSBVH6avbCox5q9k
         A81A==
X-Forwarded-Encrypted: i=1; AJvYcCUsyRb0pPHAQyUEUnKzVZWc3sMWIBNAZlxuDn59oCU37d0bZvOorfpINyjSE1hBU1jswWcRQwQAj3RAlGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoX676PK3EaIwIch4qlJWFW3VWCNr/A0VxaL/cO1r8qSl0cVxL
	NN/WFb5VRF5B2XEOJSu/Rd7epM6dvshqy0VxhcHjvwMwNq7neeG6GJ0r2G5g/5w=
X-Gm-Gg: ASbGnctlxHxaiO8Z8mbW2jpRf/VyzPpzQ7uIhpMCXZKz63hqJ98/jffEppTaFQt3lBW
	W5M14I7zu3LLsFUhrCU4vkKP3EmhaAaLGJIsEGZ7N4c7rrluWGDHmZQB5F+fVPF9rssFhWjWntV
	begLfuKnFUkTNFprw4fWtz4BzXYuYGgr49trAQ1IBBXkuSMbdwDX7hLQuhe4NXulBCI+IiFyGY5
	sd6dh8NiyMXFsx2KkGx+usiZWBgmL/NNY78MXzuyv6Bjga6tCSh8QPN8Y79RdqIUy5eGTzSwtpp
	muvwixgzGFiLX7Li76Xcm6tUYNQVNPAV7TbKGSl28V9U/w==
X-Google-Smtp-Source: AGHT+IG1T0wpdC2jhhxGsViaMerXWFKA7E61APRJ0hjnELjvuOcDSh7XS5SLOgX4CwPT1xf8fTb5ZQ==
X-Received: by 2002:a5d:47c9:0:b0:391:2a9a:478c with SMTP id ffacd0b85a97d-399739c81bfmr2840201f8f.23.1742396827667;
        Wed, 19 Mar 2025 08:07:07 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395c7df33aasm20875247f8f.2.2025.03.19.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:07:07 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Zixun LI <admin@hifiphile.com>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: atmel - add CRYPTO_ALG_KERN_DRIVER_ONLY flag to atmel-aes, atmel-sha, atmel-tdes drivers
Date: Wed, 19 Mar 2025 16:06:56 +0100
Message-ID: <20250319150657.2698916-1-zli@ogga.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixun LI <admin@hifiphile.com>

This patch introduces the CRYPTO_ALG_KERN_DRIVER_ONLY flag to the
atmel-aes, atmel-sha, and atmel-tdes drivers. This flag is set for
hardware accelerated ciphers accessible through a kernel driver only,
which is the case of these drivers.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/crypto/atmel-aes.c  | 5 +++--
 drivers/crypto/atmel-sha.c  | 6 ++++--
 drivers/crypto/atmel-tdes.c | 3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 90dcae7049b7..8a6ee5ac9956 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -1948,7 +1948,8 @@ static struct skcipher_alg aes_xts_alg = {
 	.base.cra_driver_name	= "atmel-xts-aes",
 	.base.cra_blocksize	= AES_BLOCK_SIZE,
 	.base.cra_ctxsize	= sizeof(struct atmel_aes_xts_ctx),
-	.base.cra_flags		= CRYPTO_ALG_NEED_FALLBACK,
+	.base.cra_flags		= CRYPTO_ALG_NEED_FALLBACK |
+						  CRYPTO_ALG_KERN_DRIVER_ONLY,
 
 	.min_keysize		= 2 * AES_MIN_KEY_SIZE,
 	.max_keysize		= 2 * AES_MAX_KEY_SIZE,
@@ -2471,7 +2472,7 @@ static void atmel_aes_unregister_algs(struct atmel_aes_dev *dd)
 
 static void atmel_aes_crypto_alg_init(struct crypto_alg *alg)
 {
-	alg->cra_flags |= CRYPTO_ALG_ASYNC;
+	alg->cra_flags |= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY;
 	alg->cra_alignmask = 0xf;
 	alg->cra_priority = ATMEL_AES_PRIORITY;
 	alg->cra_module = THIS_MODULE;
diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 3622120add62..40f6ed5b20ee 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -1254,7 +1254,8 @@ static int atmel_sha_cra_init(struct crypto_tfm *tfm)
 static void atmel_sha_alg_init(struct ahash_alg *alg)
 {
 	alg->halg.base.cra_priority = ATMEL_SHA_PRIORITY;
-	alg->halg.base.cra_flags = CRYPTO_ALG_ASYNC;
+	alg->halg.base.cra_flags = CRYPTO_ALG_ASYNC |
+							   CRYPTO_ALG_KERN_DRIVER_ONLY;
 	alg->halg.base.cra_ctxsize = sizeof(struct atmel_sha_ctx);
 	alg->halg.base.cra_module = THIS_MODULE;
 	alg->halg.base.cra_init = atmel_sha_cra_init;
@@ -2043,7 +2044,8 @@ static void atmel_sha_hmac_cra_exit(struct crypto_tfm *tfm)
 static void atmel_sha_hmac_alg_init(struct ahash_alg *alg)
 {
 	alg->halg.base.cra_priority = ATMEL_SHA_PRIORITY;
-	alg->halg.base.cra_flags = CRYPTO_ALG_ASYNC;
+	alg->halg.base.cra_flags = CRYPTO_ALG_ASYNC |
+							   CRYPTO_ALG_KERN_DRIVER_ONLY;
 	alg->halg.base.cra_ctxsize = sizeof(struct atmel_sha_hmac_ctx);
 	alg->halg.base.cra_module = THIS_MODULE;
 	alg->halg.base.cra_init	= atmel_sha_hmac_cra_init;
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index 099b32a10dd7..3a6a890172cd 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -898,7 +898,8 @@ static int atmel_tdes_init_tfm(struct crypto_skcipher *tfm)
 static void atmel_tdes_skcipher_alg_init(struct skcipher_alg *alg)
 {
 	alg->base.cra_priority = ATMEL_TDES_PRIORITY;
-	alg->base.cra_flags = CRYPTO_ALG_ASYNC;
+	alg->base.cra_flags = CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_KERN_DRIVER_ONLY;
 	alg->base.cra_ctxsize = sizeof(struct atmel_tdes_ctx);
 	alg->base.cra_module = THIS_MODULE;
 
-- 
2.48.1


