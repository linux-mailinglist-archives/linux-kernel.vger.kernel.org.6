Return-Path: <linux-kernel+bounces-263463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C768993D669
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7315C1F24B27
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E2178CFA;
	Fri, 26 Jul 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="jKbyNKNP"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5476B1171D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008999; cv=none; b=T5IYGKbh5GvLZlTqS18vUuXuswNlsHf/50xO4NtWQ3hZoIyayJpN0OaY/3p0RfU9bGkBMLs2Bz6AiP3quep0LFW5BQYv/D/fNzDGWPhYsV3QW7V1eMu/O2k8EbsVpEbpCKd2TA4sWGQYKgXefz5OIX0zTrRzSxTmaaVrD79aP/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008999; c=relaxed/simple;
	bh=ZVjNmYH0CFCMOJu5tLroppDvKSB8ERbSbPAQ70CYN6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LOTyD59ZsK4h1SpDVtSxABc0B33LqUOaaX/s2LblAGVERPy6txuBp6ErgThYXjZEhsx8q38/vkn2ULf8vB5uFnNgeecQ68X3TwrETu1SdC1RBBGPpeQxfNXZE3ZHj9vmVGBncSMNJbGl21uztnlp/Ot88IWhVfp0n2Z8KmEzO7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=jKbyNKNP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so3123433a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722008996; x=1722613796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJmIU/xMtXs5ILphdbN0nBg+cHcFFdfHSxNrMLT9xnY=;
        b=jKbyNKNPrr/t9THq+bUAF2SjvrEyejvR9GYHE+ij/WmN07v97qXtKYTB1+4+komHWS
         g5YtLHZQHAQhmhXTtZjcM9xjEOp5K0cUfLNgKTzwIw9MgLe6jlnEHXTqkj9r+SAwO8dV
         BpH0ehvjpRhaiveFxQFsJmXYnJXtMmgTiP5wyJzvtdF10CwcLdJj4rmnK4m9Gl1kOX95
         4nFtmPYOPQUK1PfUbrniKlmbwcaLViwQ9fd9qiCNLSvNTG3L2Yiuw0pzdrhdQpq4lktF
         dlR7oPTQCz9bwxy/MtYCga5jq8mfl8/bnuhnWPPmPtGszFu2epPi2VAQn6lQzPkLTWMo
         1QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722008996; x=1722613796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJmIU/xMtXs5ILphdbN0nBg+cHcFFdfHSxNrMLT9xnY=;
        b=B5OZuvU4Vg/9vWZ4k/CDiKG3nj6I4bE8pFCoZB+OWeLinnC3ew4/6woS6OVrJVSoJy
         UC9BdQCyjGF27N5v/5LPcZJt+ZUvxd20mi8MBZOdCBtgdRUWaGSrLHNFUnQpvSRkMx91
         /FJM673VSQdWVYxe82pEGAl0r04RxvYiJysJmNnt6m1mQe/YJ0GowGqvwjHmDn9hKJEN
         vf3Jv/JNX4gCxyFPRZMnBebj2MWOI8IWpgT9JrOggq2jAuYohxho4UYpQulyzW0ghABS
         CIcKf3b4PAZtjhv+XaHFEEgy9ssa9hmBW2PshooEQYu+2gXdhU/RxAvHZfH6Hk/d27oo
         8cdQ==
X-Gm-Message-State: AOJu0Yygt6FQcsZ9Q3xP4Mm9ndsU4ePwfLxv+aN7zr9KhTa4Sh2YWJ3q
	5Mji+I2Ta1G2e5Zi0shpQyRWhAO9atu3YnaNeXKofxQs3X5P1+m7bdbZHTtDOMY=
X-Google-Smtp-Source: AGHT+IHE6mKmIoUGO6LEog/bMeOJtuAahkq+yuppNC31XhzC/J7PHLxbb6EKh1Hx9zcgz32g8K5ICg==
X-Received: by 2002:a17:907:7204:b0:a7a:9144:e23b with SMTP id a640c23a62f3a-a7acb3fb925mr369040266b.19.1722008995552;
        Fri, 26 Jul 2024 08:49:55 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de6fsm191156266b.63.2024.07.26.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:49:55 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] lib: checksum: Use ARRAY_SIZE() to improve assert_setup_correct()
Date: Fri, 26 Jul 2024 17:49:46 +0200
Message-Id: <20240726154946.230928-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ARRAY_SIZE() to simplify the assert_setup_correct() function and
improve its readability.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 lib/checksum_kunit.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index 4e4d081a1d3b..be04aa42125c 100644
--- a/lib/checksum_kunit.c
+++ b/lib/checksum_kunit.c
@@ -468,12 +468,9 @@ static __wsum to_wsum(u32 x)
 
 static void assert_setup_correct(struct kunit *test)
 {
-	CHECK_EQ(sizeof(random_buf) / sizeof(random_buf[0]), MAX_LEN);
-	CHECK_EQ(sizeof(expected_results) / sizeof(expected_results[0]),
-		 MAX_LEN);
-	CHECK_EQ(sizeof(init_sums_no_overflow) /
-			 sizeof(init_sums_no_overflow[0]),
-		 MAX_LEN);
+	CHECK_EQ(ARRAY_SIZE(random_buf), MAX_LEN);
+	CHECK_EQ(ARRAY_SIZE(expected_results), MAX_LEN);
+	CHECK_EQ(ARRAY_SIZE(init_sums_no_overflow), MAX_LEN);
 }
 
 /*
-- 
2.39.2


