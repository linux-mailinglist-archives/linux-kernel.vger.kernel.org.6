Return-Path: <linux-kernel+bounces-549669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C04A55541
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691D41894004
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD60270EC6;
	Thu,  6 Mar 2025 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="EFWz9dw6"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EC32702B8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286545; cv=none; b=OsIQCUcphb7RMVqwFqWRX0bdh8zZOwem8N3KqGG2dMnhwKajrek3E9fYvNZ0zN2PQ2BWu/GmLnykeezoaNux5rJ4YZJ4D5sBjPVeD8Ny4IQTSmdG6akHIuT9RsO6d6zvzusQacCcL9cPikkg++CTffhR83fgXic8n38XXGofAGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286545; c=relaxed/simple;
	bh=9Dig6sAHtsyHbkq2491f7Tg8tRugSKtgbFGFfoTAC3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjcZVafHgr3sj8MAWP42PHJrF9sg4vLgpVQRNBHqaVk/U/UWqRiAhpzNAOORstLr7oINbdHKFTv+vfAMtiLDp33vUWHSa2NCG09PlB6BUKYbxXZMvaR75FB4z2i9U+TGw4/lHlrjlx3ZKZ7up6EmyEKGo/YkgS6uB7xuGWrXpSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=EFWz9dw6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso12310835e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741286542; x=1741891342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAl6qbd5AUIqBk2GNL7RYgkgYgmohGeVwmROfTx+sCw=;
        b=EFWz9dw6n6WUMBqu2bwYeIT6Oh7OKtdAXlw04wweBBV/anWKZmrRtGxaSdE1KZf0EK
         RvaDX0TmekAoxoGUWTxHbYPi5/kePwX+YxYSoJNV5MRkQK5t3aoaD9VcR9axCASVDjNE
         5/7oRzDzbhnOFDI10ZDQSFkKXNIGF9fmswR+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741286542; x=1741891342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAl6qbd5AUIqBk2GNL7RYgkgYgmohGeVwmROfTx+sCw=;
        b=eWzw1FU3DtrORy2Gc7POeJQ+QjkXXiMy1G34t0aqfJ8k4H2Ojyj3EAiglnWcys9Vse
         kJMiH2uhiYnBQBHmKfBBeZgK2cY6dPBqPjaZ3Wto5F2BUHVsfNE48iOoHSxxZkKjQ7qz
         Y7GQb425xlsOUycOhmrBwIHZTA9Dn3c92NNRrC5624hYqhCO4EoRY0Rr6XDkVMumkPZt
         nShRvnaBTzPeBSKOYTbL6t1QXQ0lhlZb7FI+CiyE2wgXuK4pYyO9ajlTqqyCq3r1rqeg
         FeV+eDN1Dcs0ZiHCir6wc745PRYGqzvfW0BhOII+k15A2QOrj8gZUKIU4C8DZQn8dW9S
         osPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyD/0fjhZxsL8oEax5VO5SjoW6+BUxRVn7Mu5JlPDXFIMyBpTGwqXWsJwTTxAPxqi8XU+xr+NXw3pyZE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNM24PuVkMwCHR3c4TSOd3fMo7ThJOaxii18gDVYDYnk9ALmg3
	tXFbDlRu5UCY6ejNeh6KPs1JiEtNgAAeqA/8msjKz93XN5msvaGC893La+XTfhmeX0Y4bTaPprh
	MPZ4BFg==
X-Gm-Gg: ASbGncvSLRfdgHieAGgVG6IbvIGqf73yWg4qTEGzK7jjRlglrwTIdZVaLxlIz/aTcRR
	HG3MvAjhwh5bDN9wxWUGfxjGcAbyBUVYipvO+1NOtDo0jn9qcjh/rrmyXXMaEPYuGJqv3kULJK2
	fJcazM8327/f/u4qbNGfxKKVvZtBY9fA7SxvRE9afjJ7RLQejdnNcmT1Z3GSymH4+04pr4Jhdb6
	2xHHsqFSWiN0HSIF5b6hcL1dJoTu2DuucrmcBA/0gUsgDSCKMA17vBfvzJdCEgQve93cSHaBCtD
	Yn2F9e81FpTRuRmgegTHPKUJOX1H0mxXUBJclsyTwHLrh3hY/A0d3JWthypRTiJGQFCFM4b4WBh
	rYchAUA==
X-Google-Smtp-Source: AGHT+IEe5BwBXjl5g/UzaCny2ATgwBksaUC6y4ZTKWmkNFRie4pvQ0MC4LOjIjjxc7s/T6NPUmwSxg==
X-Received: by 2002:a05:600c:3b1e:b0:439:9ee1:86bf with SMTP id 5b1f17b1804b1-43c5c98089bmr7080135e9.7.1741286541998;
        Thu, 06 Mar 2025 10:42:21 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c55e6sm57052725e9.23.2025.03.06.10.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:42:21 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <shuah@kernel.org>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] selftests/nolibc: use O_RDONLY flag instead of 0
Date: Thu,  6 Mar 2025 18:41:22 +0000
Message-ID: <20250306184147.208723-5-louis@kragniz.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306184147.208723-1-louis@kragniz.eu>
References: <20250306184147.208723-1-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This doesn't matter much, but is what the standard says.

Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index e8faddcecf9d..a5abf16dbfe0 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1130,8 +1130,8 @@ int run_syscall(int min, int max)
 		CASE_TEST(mmap_bad);          EXPECT_PTRER(1, mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL); break;
 		CASE_TEST(munmap_bad);        EXPECT_SYSER(1, munmap(NULL, 0), -1, EINVAL); break;
 		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
-		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
-		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
+		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", O_RDONLY), -1); if (tmp != -1) close(tmp); break;
+		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", O_RDONLY), -1, ENOENT); if (tmp != -1) close(tmp); break;
 		CASE_TEST(openat_dir);        EXPECT_SYSZR(1, test_openat()); break;
 		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
-- 
2.45.2


