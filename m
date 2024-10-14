Return-Path: <linux-kernel+bounces-363107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D007799BDEA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 768E2B21AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3EF7602D;
	Mon, 14 Oct 2024 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL0ZrgUn"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505DE5A4D5;
	Mon, 14 Oct 2024 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728874568; cv=none; b=M5jEl37cNN0+9ukapT6iwBQsqjdP2nPwfD023nat22EeZJNZNLEygZr2m7gyiMrRCgSd/Q2fS2b2Qq+tpAytWFt9eK9c2I4Nt1yUtQXni/gQWUhJ6nm/sRx79TPWd5hhh/kF19LAkYphMpzuXLHuPG+SpMdLQwonSGXMPY1AESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728874568; c=relaxed/simple;
	bh=Qe2ChtW/mBRF94ySzEHdaeNT66y9rdZInIjzCEIRchI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i40RvNxG6uVI/ug0R9iz97bb4quj4QoNalXBiQMB3Z5B7d/UTkINmC9CzASz5wQlhOBSBh8ahs8QJ27TT3e5vC2DALoftG1QuzR7gVIvuu1ZajldedOaytujbrN1bKV0CQlz+ifqtLI2Yx5cwPT+gHvw4e/iqP8u3g6lL5QRPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL0ZrgUn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c96936065dso1537612a12.3;
        Sun, 13 Oct 2024 19:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728874565; x=1729479365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsia9jopa1EBGuIlree1T5OAe+wj8zghwoJWVSExaNA=;
        b=BL0ZrgUnE8KYw819rzDDM98Nda7D5h2637zGFp/eIa5fwGhXjyVD6kgbaI+/LAa2Gu
         4ayh7NsVKJdJqregKkNRHLhcA7+AGY495irr+3yHRyYwW0wERUNdS/ZyYMAhgHIYMcoF
         vBZkJxJ11pBR9+FNRUul92QI1w/APdQHmD7FsiBx/1rrfD/SF7OOhGB5uXYgrBBPNgR0
         aC31+SgTBUaKv9gNAKiHYcSSbHFAcVUFd1UyClj/dfUVbqQu58Zpg3b3Al42lUbHEA5k
         1JLV4mKJ/85pjouSoC18XnC0PvpoewL90livGsNTvE5HJXZN2eG8vtUNlV2w+8PT7/8J
         re0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728874565; x=1729479365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsia9jopa1EBGuIlree1T5OAe+wj8zghwoJWVSExaNA=;
        b=MXTo7RtNNqksyVtyr+bKfX/agOpSdwZRBObhMecLgaa6q+rGH23FQl82lT12aTji7A
         8ZLsZQwiBJtbmDP+Z3mhiPD/WI7LbCzdEiXPvsN75YkEROMc0BmIuiBayZt/KHyf4jOD
         QzpYybT/XmnShOtfhrD7tGYdFlPJ+jdjMg7xAg1TZRDn2O4YyTjmh9IeqLL79FZ1kpz2
         Po40a5ofLTIV8EDp6Bwy2PGxqaR1dvrBRFWfQ/3OEMJyqptkebd7hgU1dbCRMEDz37Al
         HnLc3qHU3CFKnMeOeOTV5EhDkwFB0wPBq31p2TqEXY62avLkScnSAWed9j8griMB7oGU
         L/mg==
X-Forwarded-Encrypted: i=1; AJvYcCUag4GWUnYoNd5bXRjkJV1J9eKg9lqbzhiqC6tPJXyTrKUON6zrXWiFq/BXrUKDNabx4HR1+La+C3gZSsCZ@vger.kernel.org, AJvYcCVFm7Pc/oCCTZGpSNE7S96goy67AcswK8FcVNDZBPADsY2qsR+pceJoo3GBe/0ZGNxTB44pf0PJDok=@vger.kernel.org, AJvYcCXfYBWRWa+YT4QAlwttBIPGha3cTHra096VCpEWz4qGssIvPC8dOxgK7S40/A0Oje2vKLKLDVSq1OTM@vger.kernel.org
X-Gm-Message-State: AOJu0YxyglI+Vdux8OES8BC4WPrvOkY2Lg4SbM9HA3NGgw6ShcTzRQix
	IMH1EjMqGasL/qfcVSuNxs3859apBtVK9uE7P81rsBy9HD2il+zT
X-Google-Smtp-Source: AGHT+IGnwwZeigphOJ9brMGXGLoktj1FJV8WBeBfj1WroyrEnTp3w3CdGAC9gyG0bLeuTFdMUZwEGA==
X-Received: by 2002:a17:906:6a12:b0:a99:742c:5c7 with SMTP id a640c23a62f3a-a99b9305ed1mr791073066b.10.1728874565516;
        Sun, 13 Oct 2024 19:56:05 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99ebdfbff1sm270501366b.39.2024.10.13.19.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 19:56:05 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com
Cc: 2023002089@link.tyut.edu.cn,
	akpm@linux-foundation.org,
	alexs@kernel.org,
	corbet@lwn.net,
	dvyukov@google.com,
	elver@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	siyanteng@loongson.cn,
	snovitoll@gmail.com,
	vincenzo.frascino@arm.com,
	workflows@vger.kernel.org
Subject: [PATCH RESEND v3 1/3] kasan: move checks to do_strncpy_from_user
Date: Mon, 14 Oct 2024 07:56:59 +0500
Message-Id: <20241014025701.3096253-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014025701.3096253-1-snovitoll@gmail.com>
References: <CA+fCnZcyrGf5TBdkaG4M+r9ViKDwdCHZg12HUeeoTV3UNZnwBg@mail.gmail.com>
 <20241014025701.3096253-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since in the commit 2865baf54077("x86: support user address masking instead
of non-speculative conditional") do_strncpy_from_user() is called from
multiple places, we should sanitize the kernel *dst memory and size
which were done in strncpy_from_user() previously.

Fixes: 2865baf54077 ("x86: support user address masking instead of non-speculative conditional")
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 lib/strncpy_from_user.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 989a12a6787..f36ad821176 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -31,6 +31,9 @@ static __always_inline long do_strncpy_from_user(char *dst, const char __user *s
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
 	unsigned long res = 0;
 
+	kasan_check_write(dst, count);
+	check_object_size(dst, count, false);
+
 	if (IS_UNALIGNED(src, dst))
 		goto byte_at_a_time;
 
@@ -142,8 +145,6 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 		if (max > count)
 			max = count;
 
-		kasan_check_write(dst, count);
-		check_object_size(dst, count, false);
 		if (user_read_access_begin(src, max)) {
 			retval = do_strncpy_from_user(dst, src, count, max);
 			user_read_access_end();
-- 
2.34.1


