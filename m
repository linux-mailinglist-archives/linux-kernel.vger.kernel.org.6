Return-Path: <linux-kernel+bounces-568485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E71D9A6962A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842B3188A51F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED281E8322;
	Wed, 19 Mar 2025 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NV6DiiT+"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891C29A2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404480; cv=none; b=mQg4GQpOiX7uXWEuSMJtuFamyra8YxyFHcyYI2+Q6b5ew05aVhieBkKzVVAssRuOxOhgC9iD8gAPKOYzcOU5Utv3eqVuQacD0v7glWeIQBSJonlpR7O6n22N17o9lybGMX17m0yd1J4HQ7nBP7zDS4+JTBiu67IN+RpzuGy+LDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404480; c=relaxed/simple;
	bh=cI905EyR1QV5ule/ac6xi5BGrF0In1v50J7J/neUJ84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OQ9RfghEkiTdodxEF6+JS13riV0ntC6p60fUEaiv3EXhygM518KhC+z4YSIB0KbbwKO/yYxCZ+ZoqXropXl4Vlv173XLQju8j04ycB05o6eGIGSibQjOZW/vIYByAOP8Em1I2LEYTZOtAo4sDbMRmWuKeShAGNK73nLCO6aDuBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NV6DiiT+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0782d787so33755945e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742404475; x=1743009275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YZaMra1ssJxIId58WGC9RPWJsExMyYY90fDGgTuSLwg=;
        b=NV6DiiT+CfNp5XMrw43gxaXq6qOI78plZbqLSGuHx9CIwr2mCjZ3cN37G4BjTGD/+k
         12vYPp3X+nUknS5UB620arI5rygqMcgpo9qV7qPGru8kY2YHdIS+bWAXKiH9+FIthuQZ
         7+eBa9SCjYVjhF06GSu92wb98UMSOVwc1JguEl4DfUn7EJvoSs+jgLUa1xDy70ylBFAN
         UUpKTO1FGWz9chGmj6t5i7LrjUefUcwe1ap964sPQJOIwVDMWGYrPnSrMVwRKm8GAciT
         6+pCGQ3VzrMDElNo1cG02+MmLLeanfzW0fysJFABHKLzKhQkjw2PXBVqFGOlQ+U6AkZf
         2g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742404475; x=1743009275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZaMra1ssJxIId58WGC9RPWJsExMyYY90fDGgTuSLwg=;
        b=P/R7ReQD/k1CDX8zIUxtMZQZRAVZDveUPcukg+QsvV03hf0PFp/TJxhgRF7f5D0Jl0
         23ruwC0kvB1c+by/NS43YDE0lUkfPkzwU3JD/k8x0sFyw8XNLIIFq7iL2ts0+On8DK0y
         ufHeL6UaaPRo4sOzNCJWDpAUzP4iCeek4Wl6cbunA8WDXHtoA+6DrUw9J3dmDE8eQv/g
         kCJ0NYiJA6wyalnP37GRZ0gLCBIbxuHf2VGsyrGihwdVZjAKmFpk7Iq44PHC9JntpvQB
         KChrTgrnrI348jD+yV5YJ6smdh9Ixux84E6pZigbEjnTROPfryDZlprLQ0Mb5iDhhEE7
         +M2A==
X-Forwarded-Encrypted: i=1; AJvYcCWUFIfAS5SwAjqswkZEc9zwyJ//ujoUD8bVcs9Ye05awdkwG5iZOLCfyMHDD5v478IlyihbTbM1oOAEPfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzJgMiTZuwomGjrgzoZcwa6YiAKIzPob5qiTgiRmDkN0t8yuGB
	SO7R0BxldByJaRy9q52XgvnZIJB8y0notwj8N/592gihFK+sA90O0DWgiOKhAXTedkOOxugPQYs
	o
X-Gm-Gg: ASbGncvlLoZdPBUPHmmfCXalgH62ZcfmcRVja33WpsORAOCb6xzUpmCfCPDiogFXuob
	+eElK9jrmFgCcffppEzTL+wUrz7UK4azpH+dklQaiKtRGjiLZwOlDJa2XhR6s9g0gZdaudIx/2M
	UIo7JNUEbp6ytQ/JUtdynXR/n1BkNuCVQ7A7q6YpvL33BMIaiVR6/fqunrmD0T7mojmg1Io6QY8
	9jSLVrP9r5tGotO+GV1+FXpBqTfFviYJy4DOIhGr9Wtqgo2u5MFVO0T+vj4vSEoK8GdiatDg2uq
	uwq6OEXGpevbqbpza4xOQ6lpE4V+BjTIR/eC0Wi34U37CFQyBGtqLb47PWOzMqqf8rFCGjwvS6P
	KfCIqaacsKwk=
X-Google-Smtp-Source: AGHT+IFjxMuen/3dfdvje1Lu8s3iB63S63MQ58G2kouckCGXmdlQqsHnNRHhzFxw+CejkXTGBwcNbQ==
X-Received: by 2002:a5d:6da9:0:b0:38d:d0ea:b04c with SMTP id ffacd0b85a97d-399795d89a3mr281508f8f.38.1742404475106;
        Wed, 19 Mar 2025 10:14:35 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b748bsm21809923f8f.39.2025.03.19.10.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:14:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] math64: Provide an uprounding variant of mul_u64_u64_div_u64()
Date: Wed, 19 Mar 2025 18:14:25 +0100
Message-ID: <20250319171426.175460-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=cI905EyR1QV5ule/ac6xi5BGrF0In1v50J7J/neUJ84=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGfa+3KgbXAJorWDeJ4QTijsVKG4NJE4nuYx5BZlbz2B0y888 IkBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJn2vtyAAoJEI+A+1h9Ev5O3R8H/1ud 5wbjG3g2e2Cq4JVZZa9FkoqnoIHEUt4zsDfQZtoo5266l6IOC6k43IdoGPK6Vr0luU2OBXPG3GF TPxTaGF+hG6JIxw29VQJ/bi7VIg/78fFYooEUNKxxmg4JJ1vDuWk5+VnLB0InpNgLlAB5noImo6 7tKhleaKVCTw1Jpl2wUB5UERVBbGnGhzc8A9q96FR5eAJwINazcHkU+AEdn8VvqzS51CCJKWDzr XZ9t1dAatNjzqn+mtM/XWuiYDlB+Pg1IgWXUnGTbAyNhbcybvKSkDTeJa+9IMndx8LnJVkEKc6y pYp4aBgHsuG5r/n3642pBLQ1GEJ9rJMmxdRJgzU=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This is needed (at least) in the pwm-stm32 driver. Currently the
pwm-stm32 driver implements this function itself. This private
implementation can be dropped as a followup of this patch.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 include/linux/math64.h |  1 +
 lib/math/div64.c       | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 6aaccc1626ab..0c545b3ddaa5 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -283,6 +283,7 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 #endif /* mul_u64_u32_div */
 
 u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
+u64 mul_u64_u64_div_u64_roundup(u64 a, u64 mul, u64 div);
 
 /**
  * DIV64_U64_ROUND_UP - unsigned 64bit divide with 64bit divisor rounded up
diff --git a/lib/math/div64.c b/lib/math/div64.c
index 5faa29208bdb..66beb669992d 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -267,3 +267,18 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
 }
 EXPORT_SYMBOL(mul_u64_u64_div_u64);
 #endif
+
+#ifndef mul_u64_u64_div_u64_roundup
+u64 mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c)
+{
+	u64 res = mul_u64_u64_div_u64(a, b, c);
+	/* Those multiplications might overflow but it doesn't matter */
+	u64 rem = a * b - c * res;
+
+	if (rem)
+		res += 1;
+
+	return res;
+}
+EXPORT_SYMBOL(mul_u64_u64_div_u64_roundup);
+#endif

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.47.1


