Return-Path: <linux-kernel+bounces-374060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D082E9A6156
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92424281C56
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756701E47B4;
	Mon, 21 Oct 2024 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X3XfLI/C"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582E1E3DEA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505071; cv=none; b=ckFoy662fM3p0r0iz2ezDa/b2w+tkTqLwZQM0dAmUGXFHto8y+KIEMhd9mcS7Ob5EKxeObrlipsIf4Ai03EpawCujbl21ABz7CA2fFeG15WMfLISbqLuK6daysYzvEuItV++LfCgjTr+X+doLfrWmqg7epYFYpVwX2nLsKv9cKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505071; c=relaxed/simple;
	bh=zBwwiICl41FAygMh+FLshXJ/tGa7gogHxJLxu7b+uJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/9xO/pR9Vw0V0fTaCgMDAVA2daswchj/GVUtTklHBFZI3bO834fcCqY977MClg5M99v7i044HRxpLZKeICavyQvxy0R0LxIWriAsRx1x8As01hOyeIxM53BGy8idXVnjAGKUKVIwZymLiPs6J75H2vvot9+A55orLt4gInpLrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X3XfLI/C; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso38239445e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729505068; x=1730109868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NXr9D+QiqUrfHWA03bUKiVKqnoPxUJl2IUDHzBbrn2o=;
        b=X3XfLI/CMGx/8NgdO7PgLwUXleN4BzbYhvXFgZdq1vCbDfufG4Qlue4pwftP+AMcAx
         foEmNjdYjoHMUEzdu568GpMCcjINJtL/G4R59Vn0dj/Eypqb/lmO9t5wLoI+kE2/Za2s
         /tr82SPvJPHEbw/+68ckEa/WtPsle1NSHvnyQwBoXdIUrxUAn8mOygcDiMMp7E9wKoxG
         kmPnd62WfrFVTa/IQ+SWgo+TEZELWDIaHOKSNUEs2sO7MoEadkzc4dH7z1C608GNWPVq
         8gdW21GZC1EcrRbTGT03qux6NTXlqh1JTFXpgzs1P2LRAeXbimtixQQowvChQ6IGNLTu
         6oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729505068; x=1730109868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXr9D+QiqUrfHWA03bUKiVKqnoPxUJl2IUDHzBbrn2o=;
        b=oSBer1nadLxp2psMVBGdhYPQJXCWlN+6MJH6Wr6by6VQBOChXzoqOHPrDWg8BHxLrk
         iX1Pdu9dgkeVStdAJxUFsXwSI0yuvVM5enbnBWavvRUboOWX1oLPQoECqKARD00VOIU9
         rrZGutL/L3Oc/cxbYZn4uUdMG3XtN1Quhd3ukvZ93nNFHjcjlsgQdUJKH4xE4BSxWq2o
         2lz2M0BbwTeemuXywMb/hb0fpJSANqDBGfy+bTbWPbQ7kNiFOEfvCmhBo7USVxQlHaZy
         nR2+Zerso3Z7JCYNzjaP3c+z2M7n6LtTynnAcGdrn8qSaK2FzcNYIa/9y6jks2spuQMf
         pknQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj6CIqwPwzU9LyyOegnFZziIBZfM4gmOphwNeD6DyiqSp3uiHmntj9rbWUrZ2VCy/sW5EsKEd+Qr40QJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUv5BhrHR+sr7JmsIpbR61ufbLk0ZV72YCcH6qz8lMdQwqm04
	5a7KnnbH96Hvz6rUUcqX7sqJW/fpNy2RaWd2pvQc9WSwVpkIdpeawr2wzwbax1E=
X-Google-Smtp-Source: AGHT+IGW4z70tBtJjYVEC25NjW4Zh4Gpf7rFYYWBzMKvqYBqjTj3bmz732iSxhNJelTfx86Iie8/xQ==
X-Received: by 2002:a05:6000:124a:b0:37d:9508:1947 with SMTP id ffacd0b85a97d-37eb476876amr8204119f8f.51.1729505068250;
        Mon, 21 Oct 2024 03:04:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b40b:61e8:fa25:f97b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a64dc1sm3918652f8f.65.2024.10.21.03.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:04:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
Date: Mon, 21 Oct 2024 12:04:21 +0200
Message-ID: <20241021100421.41734-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The output of ".%03u" with the unsigned int in range [0, 4294966295] may
get truncated if the target buffer is not 12 bytes.

Fixes: 3c9f3681d0b4 ("[SCSI] lib: add generic helper to print sizes rounded to the correct SI range")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 lib/string_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 4f887aa62fa0..91fa37b5c510 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -57,7 +57,7 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	static const unsigned int rounding[] = { 500, 50, 5 };
 	int i = 0, j;
 	u32 remainder = 0, sf_cap;
-	char tmp[8];
+	char tmp[12];
 	const char *unit;
 
 	tmp[0] = '\0';
-- 
2.43.0


