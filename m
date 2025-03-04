Return-Path: <linux-kernel+bounces-543438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F71AA4D58C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870343A99C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8607A1FBCA9;
	Tue,  4 Mar 2025 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="H95Yqy4z"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB21FBCB0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075177; cv=none; b=ng//SGLnbKVP/p3iqjyk91NNlI0YJVBrg5BQH3j+HgxUiDUTN0hd5sBOfwljxRmeYY0gJp03pyA2M3yFVaMX+vCGqxGjYGEyc1XF3lZSk9KF4XCXnFMV4pedAzpcbvra8l5TCqe4A9kwKM7UgqtNl4JJ3yvXx1ajUcRDs3mrvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075177; c=relaxed/simple;
	bh=OmpLaD36OmgP2KxXvtkrxv7kXf2SUSNINdzlwSDRI24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCbXbBabdUoD5IK/RvVOrMSk6BlgcRek0qD0U7KJJJmxU2sLjFZt3VifTyJR/b02eakLCQ6ruR2lJAgHe0MJ/b+tiYeq8P928P/WDQNa7ylbM3bEyvpsYL55vtrHjs8rSodbEVKDbs10wX3z2Hqu9As8OD10liX58nNhIIxIFw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=H95Yqy4z; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so21358135e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741075173; x=1741679973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0+vePg+vh0lu4DwI91iCUCQCjYjpI2M5+FTmi5A+xg=;
        b=H95Yqy4zb8y5GnWeR7+fYbXf7tcN0UFNXl4SMi2RcYP938bIlzl9UcqCdR41noA0zw
         /puJJKab9cSObHZGeFsi5KfaJqZ6dc0v+WRXdkZSThzArlDAeIK+3a2YpBZjWi8D53XF
         HL9Gi90qpIUm6DUdhgTYXsbDSFSedawVa6I3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075173; x=1741679973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0+vePg+vh0lu4DwI91iCUCQCjYjpI2M5+FTmi5A+xg=;
        b=G7A748/gzOFl4W8rBm/nhkA6xJvnVSzObkeZ17FSw3EfPcSHMC27WSW+cRmQt/dXrQ
         W4kA0RMLqXIRSisUN8SCD9/jhDseMCc8Xy2WMwNU+hg9x5AzxcdS8BUhTOyh4wwhZmUI
         mf0KWsvcDPh4blL2UxhEpi8hjACklpGs7oM7n+zEAAdmh8FejToT5ehvZCcFpw1AC61c
         XcyJCHqygtg3T/TLZJBwgkz0r+CSA3FjYBKC8im+3FWaCOdUcTvomhSPdVAuLlB4bep5
         TZFVYO2+6SSejEZK+4oY0VSD9AjrCIpOdy0GD1VLmrOteo43mGUp5cRMXrwCLyu0oz1o
         gX0w==
X-Forwarded-Encrypted: i=1; AJvYcCVjjjpX8CJyVWJRWzlTllkA8x9z10mAjcqGcBgZKYmkNL4+yTLuPfT05DnAz8J/ZrwMZje8e5FcyrdoPLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWBNOZKFOm55RRorEY+xtReK68nzaqYnlBX5buHxFYue3OHxl
	cwhhALZgXg2kUubEJE5TGXtCxFzuwlIF9RvI3vPpV9ljyxcqlCycdUUCyxN2Yco=
X-Gm-Gg: ASbGncv4/iSEgqDvL+5AUAEbTJp399ViMpW/zyBbC+UnXiitEslUmHOe2q1QWDNZidc
	t7pa+DDGc5Ylf9VjjKtYN3YFwf8/vyoenP36cJtBbv6Z/BUMGW2zlZVPcso86m8zVqBVmCKOSTu
	35p6eargvOcrdhxDLdRvrZABG3YIiFocB8RznqFEi5tb5DXuEw2JG4d2LwzXeMEJxpr0nNPtxaw
	z0oxs+aVHBZOL3+smFgbToI9YkrQpl/BcID4usnoprMc6KsBaiFeBjvobMyQsFLWjk1mcjdIELV
	rqW2sgm+d6qLLkMewiP+sgQxv3rXJC/1LhBEc9O/ZUZo7EQ2BvR14NeAAtm22WAIl8sp4ClBzle
	eiuIO3Q==
X-Google-Smtp-Source: AGHT+IH9+UXTVhNFEk7r+u4miSHhAhVXhg6fiMdMSbnv+lSnLx4G8t9lr0LTTlz7YiOkc87QvcbFQw==
X-Received: by 2002:a5d:5f84:0:b0:390:e9e0:5cb3 with SMTP id ffacd0b85a97d-390ec7cd28amr16223888f8f.12.1741075172781;
        Mon, 03 Mar 2025 23:59:32 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796517sm16618101f8f.5.2025.03.03.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:59:32 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <shuah@kernel.org>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] tools/nolibc: mark more test functions as static
Date: Tue,  4 Mar 2025 07:58:19 +0000
Message-ID: <20250304075846.66563-5-louis@kragniz.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250304075846.66563-1-louis@kragniz.eu>
References: <20250304075846.66563-1-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was mentioned that a new test_ function should be static, so go back
over existing functions and mark those static as well.

Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 2a1629938dd6..b5464ca8d050 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -807,7 +807,7 @@ static int test_dirent(void)
 	return 0;
 }
 
-int test_getpagesize(void)
+static int test_getpagesize(void)
 {
 	int x = getpagesize();
 	int c;
@@ -836,7 +836,7 @@ int test_getpagesize(void)
 	return !c;
 }
 
-int test_fork(void)
+static int test_fork(void)
 {
 	int status;
 	pid_t pid;
@@ -861,7 +861,7 @@ int test_fork(void)
 	}
 }
 
-int test_stat_timestamps(void)
+static int test_stat_timestamps(void)
 {
 	struct stat st;
 
@@ -883,7 +883,7 @@ int test_stat_timestamps(void)
 	return 0;
 }
 
-int test_uname(void)
+static int test_uname(void)
 {
 	struct utsname buf;
 	char osrelease[sizeof(buf.release)];
@@ -922,7 +922,7 @@ int test_uname(void)
 	return 0;
 }
 
-int test_mmap_munmap(void)
+static int test_mmap_munmap(void)
 {
 	int ret, fd, i, page_size;
 	void *mem;
@@ -980,7 +980,7 @@ int test_mmap_munmap(void)
 	return !!ret;
 }
 
-int test_pipe(void)
+static int test_pipe(void)
 {
 	const char *const msg = "hello, nolibc";
 	int pipefd[2];
@@ -1001,7 +1001,7 @@ int test_pipe(void)
 	return !!memcmp(buf, msg, len);
 }
 
-int test_rlimit(void)
+static int test_rlimit(void)
 {
 	struct rlimit rlim = {
 		.rlim_cur = 1 << 20,
-- 
2.45.2


