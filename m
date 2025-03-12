Return-Path: <linux-kernel+bounces-557098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AF9A5D3B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E0F175107
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30D78F32;
	Wed, 12 Mar 2025 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nBVZokNJ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CEF1CAA4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738888; cv=none; b=UrrOMjNJ5B7GRsGGOXgeOw/5IDMG3/mPNPKDUC10IA2HAH5nXr0s+iqYhOKVvfMPHFJlSlzp9XL+S1/P5Su2Zc02vUWUzaXqPxdJvLVk+p9IuyE4nB0ciXsUvXyX2fuQLrm0S2kEZjGR5nqEiauRrls8EwPPUlGblpF5tT5uidY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738888; c=relaxed/simple;
	bh=E0hajOFy+vpCtuf88R9Ti+b+60Xg+fLnjQmi+V0i0oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOi1VHhbXZQUSgvOknRmbVIt1Y4EwpJvsUnNcpwy4VntVoiHBy+lS4H1xrIEl+HHL2D3p81kXjqj/bThWBnYR5yp3Q2q2G0vPH+hTW790jbtNIVhf6wBd5gmL5ROWwt8bCUpRnU7zyEfNlK1HSy1zK0e10DZUHT82Z9AvLIFjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nBVZokNJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5ea062471so946953a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741738885; x=1742343685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miJIXyGYG3FDRWUe/NKY/2IA/SM1dTsr2zjDOOHuDTo=;
        b=nBVZokNJULTTLGlDeH+QhdefPlbGtadJTYisrscWeZKoqbMbt8ZdBdD+JAPkFjdXF9
         oqym5qLf9wyw87OIhlqnNOokF1AZLQZtrujJ3j7KT2q3XXxuUkSooXD0u+vSLh3UhddZ
         oZAw+q88AZE6Z+CbKZbiWHICyvioBpJjbEwt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741738885; x=1742343685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miJIXyGYG3FDRWUe/NKY/2IA/SM1dTsr2zjDOOHuDTo=;
        b=fJOnzUbwXcN9r/CFzsn7a6CupdsHZaRQEaBOmAnsMYW7NWU6CFwM28fmaPic01wAwh
         EIvQq+dV9pgkaItM3m9DyfN9lL9bsj125GDxsleHflbzYk6Xdl1mdlPi0HoXbMIXh3PK
         oto7NBRM7Pa1xEkHH3zVxZtjS7n/L9oMJfmZqMp9kYOuNJ1f/SglBdYqPLoaHZ2/B6OL
         zxxAcJx9lckXBwM1KgcjY48aaSOr9sTWGywjrawJVX5vi+A1ABY01aMfFRjm1Cft3kxz
         80rOrratO+VG7SqKDwajUveE7KZhkmhAdTWTORfwXtlB8UQHDe5w9K7qn0YHqLGxH9Z5
         SblQ==
X-Gm-Message-State: AOJu0Yw0s7+N1Eqri0Ax2AtaaFZLVIo4RJAYElj/wPnt2JhnxOZTGibx
	M0IapuabuBEeJkH4few9uwZ4TDkxI/PvF7e0WOtc9Cvvj3n+WWefyohut3VBdA==
X-Gm-Gg: ASbGncsVed1hrZhAQX4TErt7m6tESKOeD6aNJ8xFoJo1kibbKSyPNqGIrV1y/rI4C45
	yU83RCNQX3WbCQkOhzMCBqdac6bQsAd6HbrpkGpQu/2syrCMlUin6EmLZOwriaxQ+Qv3lS5iLvX
	mnGNZp3c3ioAMwRZ6oSo88e9pWXPNFr5K8ptRMGEI+XGooGefN3sRW57uKpQkBEi7zKlsmQfsZs
	2l4BZAVHDpYzS1CoMwN7F8qpyxU6t2E5mSw9ByRXL7XfLORIVfRKmzZ/K+ea0zfd7XQJYlR2aMq
	IHYfI2MxT1VfYZoTAVn+ABJF8NuthfRcTaVvLQFmlkwLW5vbPtW0EHJP6rIEW0p9bxrndDrabzs
	4
X-Google-Smtp-Source: AGHT+IG2RY8KyPk79cZ65JQw4p98XAf1wvRrztHIEplkXwrKzzh8fZlWbd9JzkmEqA3hVmaYTTf1Tg==
X-Received: by 2002:a05:6402:35c6:b0:5e5:e17f:22fc with SMTP id 4fb4d7f45d1cf-5e617f919d5mr7379042a12.2.1741738884777;
        Tue, 11 Mar 2025 17:21:24 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7669fd0sm8846503a12.51.2025.03.11.17.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 17:21:23 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	broonie@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	jannh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v1 1/2] selftests/mm: mseal_test: avoid using no-op mprotect
Date: Wed, 12 Mar 2025 00:21:16 +0000
Message-ID: <20250312002117.2556240-2-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312002117.2556240-1-jeffxu@google.com>
References: <20250312002117.2556240-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Modify mseal_tests to avoid using no-op mprotect.
The no-op mprotect shall be allowed.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Fixes: 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with can_modify_vma")
---
 tools/testing/selftests/mm/mseal_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index ad17005521a8..0d4e5d8aeefb 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -677,7 +677,7 @@ static void test_seal_mprotect_two_vma(bool seal)
 		FAIL_TEST_IF_FALSE(!ret);
 	}
 
-	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
+	ret = sys_mprotect(ptr, page_size * 2, PROT_READ);
 	if (seal)
 		FAIL_TEST_IF_FALSE(ret < 0);
 	else
@@ -718,7 +718,7 @@ static void test_seal_mprotect_two_vma_with_split(bool seal)
 	FAIL_TEST_IF_FALSE(!ret);
 
 	/* the second page is sealed. */
-	ret = sys_mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
+	ret = sys_mprotect(ptr + page_size, page_size, PROT_READ);
 	if (seal)
 		FAIL_TEST_IF_FALSE(ret < 0);
 	else
@@ -873,7 +873,7 @@ static void test_seal_mprotect_split(bool seal)
 		FAIL_TEST_IF_FALSE(!ret);
 
 
-	ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_READ);
+	ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_WRITE);
 	if (seal)
 		FAIL_TEST_IF_FALSE(ret < 0);
 	else
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


