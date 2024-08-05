Return-Path: <linux-kernel+bounces-275113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61429480BA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FF91C21007
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A403315F418;
	Mon,  5 Aug 2024 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="f8pKmzbN"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FDC15ECF2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880393; cv=none; b=nRxsAeCzXgrYcfurnL4mjMURKMtYoxSgObOOcUuRLupfE2ArQFrNTml06Hf7iQWR6+grnR/1FSFp9Amj7X+fHq57blhX0PHjrwgDaA03oefQiBx+kALBC5NewKHXaQKr3PzScLnDSOTruotQ+KKznqcPZ/K65zWQhgq+0DZcKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880393; c=relaxed/simple;
	bh=37JxbYtgj0UGmkJjr7UoHvqcTRSFFhKr2Vl6ibBWKk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxAx/xk+LALr0zmTzqS/dToPJ1BJ3qHiaJLpzY/7GpMVa+j9pJ3GJ1ZIc+xDKKnZhyi8JulkpWbsBwTNO78Wocwl2s/ovbbhMumMf54pjaWpEFwpV5sMNQFNJt8Mi4Io0ZGAH74UjP5XWc8Gr3bXqkoQD1y+PxxiwD6Hgkh0zHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=f8pKmzbN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso74645925e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722880389; x=1723485189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vqwe0/CvqutnT3l9d7/bTn3dqeHNjAfCcV9ZLukVbM=;
        b=f8pKmzbN0/ZM/QxuwCBdH+N06OQKotZqtz8yH41AO62ttbRG371WCfw8SQPPlOPT3q
         USIyL6ZRuPWeO4y4T3RBB8nu/6fcWTJTNK4xlUa4wRCFyIHj/NmXScXQ1QGQuGX3O++x
         zgIazL2/Ej4+AO1p3QVNXVcLKhpAqaSF9ojHA5Q/Gnh5XCARExOS989fbpe85Z4HMyzX
         OO913yMCiRfBcOG/+S6Q5lfgmyBt1D0yDfabqPoM7wkE18C/d65G0p116I1aj9DMK4St
         cRswLk4C5hmawy6SIjNGWqbrde8Ex03wWJqr8mTrcBGlLJFyp7MawCnmtEgehtEgvj7m
         phjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722880389; x=1723485189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vqwe0/CvqutnT3l9d7/bTn3dqeHNjAfCcV9ZLukVbM=;
        b=Gh9iH9jU7bHs6oDqTIVWnevWt2KhHBBbKzNuPyy7uPhVYJRRVMr+OdlgbAE4lx4Gxq
         1gB8m6Q8McaBRvyPR+hQ6sPLR2Ah/iZ0crJ4OoVSKVlhzAWuC2yMS5e7lr/pYYCwiZiH
         Q8iY7lnIO70Ln/WwjkzABE8eeq3uMYHQwjVJuQSAOblxWfrsAjoNRIAIAKqM3jeJc3cr
         s9DPhBSsWYksT9w2wE7sSzWdJ9/8P8BsZJUswBiXTQXkY4FnWO+IRM6o0v8QEE7gNOb9
         /LKn3VUg75sdK91BJSJnWRLiMg96A/J0QDcDybApj8LWCK7hMzzujhONBuTiWVzKG2IZ
         IdNA==
X-Forwarded-Encrypted: i=1; AJvYcCW5iaTU0nZBLThPR8G+ewXiNv5019a5jeBRgOjVuqN/Sh1jWZBU3vZMsfK22iLQ0n4WBiksUfzHi9J/EzFuwjpB6BqqJPNXxnbplLQM
X-Gm-Message-State: AOJu0Yx0/2IzghHDAGaSYMz86dpTMK/zgnqcGseeGdE5iHMlWaR13CPq
	Nix7u40jLrgJPrmDwBGHjgSPZIX0VQ8owC6Zhn2+OKEi736DEeCiwwKXwAc2rFc=
X-Google-Smtp-Source: AGHT+IFsapBhb8f6mICFhltKqRUHmpBomLHqM0Xug77XUaSdZlzbbtSgJltdKCGcKWuJfAdIFBDA9g==
X-Received: by 2002:a5d:6083:0:b0:367:340e:d6e6 with SMTP id ffacd0b85a97d-36bbc1bcadfmr7746862f8f.41.1722880388924;
        Mon, 05 Aug 2024 10:53:08 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06dfbfsm10593716f8f.99.2024.08.05.10.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:53:08 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] crypto: chacha20poly1305 - Annotate struct chachapoly_ctx with __counted_by()
Date: Mon,  5 Aug 2024 19:52:38 +0200
Message-ID: <20240805175237.63098-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
salt to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Use struct_size_t() instead of manually calculating the struct's size.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 crypto/chacha20poly1305.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/chacha20poly1305.c b/crypto/chacha20poly1305.c
index 9e4651330852..b37f59a8280a 100644
--- a/crypto/chacha20poly1305.c
+++ b/crypto/chacha20poly1305.c
@@ -27,7 +27,7 @@ struct chachapoly_ctx {
 	struct crypto_ahash *poly;
 	/* key bytes we use for the ChaCha20 IV */
 	unsigned int saltlen;
-	u8 salt[];
+	u8 salt[] __counted_by(saltlen);
 };
 
 struct poly_req {
@@ -611,8 +611,8 @@ static int chachapoly_create(struct crypto_template *tmpl, struct rtattr **tb,
 				       poly->base.cra_priority) / 2;
 	inst->alg.base.cra_blocksize = 1;
 	inst->alg.base.cra_alignmask = chacha->base.cra_alignmask;
-	inst->alg.base.cra_ctxsize = sizeof(struct chachapoly_ctx) +
-				     ctx->saltlen;
+	inst->alg.base.cra_ctxsize = struct_size_t(struct chachapoly_ctx, salt,
+						   ctx->saltlen);
 	inst->alg.ivsize = ivsize;
 	inst->alg.chunksize = chacha->chunksize;
 	inst->alg.maxauthsize = POLY1305_DIGEST_SIZE;
-- 
2.45.2


