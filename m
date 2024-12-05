Return-Path: <linux-kernel+bounces-434016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01B29E602D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063972833EB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8421CD1ED;
	Thu,  5 Dec 2024 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="g3Sn6VK7"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C41BC07A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434513; cv=none; b=EMmGgmv2A4Q+HK2bd0UgkGi7DRU8wTcPrypMhjx90n/P0viDsLWnClY6VIMMPZ9ug/ZZsMAYfX/mKAmZsQ11Jdj/a5JgtRhcHHLWxbDHnVXd/wHjsWtFtWzvVk+8wdwezl5Nn8UeExImoXXm0/N7TQQsJ+NMthz5A1WaJA2EbnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434513; c=relaxed/simple;
	bh=wdD8jAZRCjMd3Gu+Lv3upW2aM9UHvcVExGMABP3l5PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TmnD5TwZgueA48WtvGkssJcxbwAzg5nobG/DMS1NEpP87cxsGLyIsIKWDXOfFJ/j0kCBuFCs3W7oXxphBU5c+dvBb8M2tJRjZBhcj3RYx6hE4rRkSIPz5jLmW+MOK4UjBVimGn5FxkM991sEsqnoy/5uFOFXT7enWmL7LegUPZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=g3Sn6VK7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215e194b65aso12855385ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 13:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733434511; x=1734039311; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwsdH+QfnICBuJ92pYJftuHgr7/FjfSggIF1Mo3ejbQ=;
        b=g3Sn6VK7qJtwuTn3szQtNhrjxs2uxhuaoFWbEJxqtSlpNbtqsVwOOGNnR9RR/OMJmj
         /wyLQMXql4b/2s58QSEO3vBrlzxnRlGBp8FtrJ50V06G45mFRFf2Tnano+P0lCXICbm1
         F6nRVPG1w7+hlhF5UPqZmjGJrduYuFKWeCyUzv6+qzpI2IY/7yzmbAi4c7roJM6FNlhv
         UQRsLYfLDMH1EXljIqAvlEe5OhdhEUl6KCzHAG5j+njQaS+QcxE6FaK1RqJ4hZm+hYNj
         eF+9BOkYIo7xDW9DcGmlTRiUY9lo0+tLCR7ejVFLiLpvH3LBl9Xg/2ctbtLhM9KqSJVX
         18DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733434511; x=1734039311;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwsdH+QfnICBuJ92pYJftuHgr7/FjfSggIF1Mo3ejbQ=;
        b=NYMoD910OubSU7J/ZMxk7ww3Gkmq6t53hFmOYtcCihaFK0OGrSDnFl1pxDx9qhLBm4
         E7J3COOb8pIf4kVRc8yvL9e9YfPrWJb52Le+SflnaNeW/VQgctuz8YVK3/efeL2Q3fPq
         fkbFUXEpw+RMSTg73Znb/lNj8UWVwUUuj0li20IC+OgdlYXDQKrRGvefyUJ9FwFMF5Si
         szioysjo4tId5TFg9nhDrvhlVdoA8LnVD9MK3u6yK5Lz7hwjXi9aJslG4VurEZhtzG/D
         McIhpt9vwt/ypkzAJlSMiRLIaDWjemTSKMSDEXs7to0hbmJyN6yxpKBuoGWkt7ROWE3e
         GgwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbYEcvMwUBLgCaKV42nDMAHrsJT9HMKyEuZQYjqWFKXJe+w57TNlU2CAmuAXC0/RaL+DqRhO7KuKpVNvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8s+95kfHzd2TBN62yfZduWb0nVUBeyjgWXmo/CJs6p3uVvTI
	Pm5b9I26+wpG2FEHNY+XS7h5AqBD29a6QbtXtWW7xF4sE2jl5I4M9Jo21cA87KVC0nutpKl+ycu
	u
X-Gm-Gg: ASbGncuGtmAZKJDPrT1ptLxP+3/jtT+QSV53oQfc3kP706VZsUd6m4RsgWhTtNLQRD7
	mJT4gZ+N1WTHUOmdP2PuiIT6vC37s0RAX4UrkJPJKUa6Sou9GEXQr3ElzhfR1k1UAjlluwQLYWY
	ubs38prBJJcepqN966s5xsICgvSRCGKaxsSaA2TA7MuctnsLEa+KYwuY7OE+0Bl+3jpa0QAHBMh
	t8J1aK8JsoL8XdHYdjKPWa7YNG9zS/ErSpOEcFATVnYNdlplLxu+bzFHLBnjBhMBA==
X-Google-Smtp-Source: AGHT+IGw0B69pcIiyWd5mzMp+7QZEvAdzKCqvYC84V0ko8+KVSirsXGLwn19nZI7HpRamxqVkm4+8A==
X-Received: by 2002:a17:903:110c:b0:215:6f9b:e447 with SMTP id d9443c01a7336-21614db3f47mr6536815ad.30.1733434511348;
        Thu, 05 Dec 2024 13:35:11 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e414sm16857975ad.56.2024.12.05.13.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 13:35:10 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 05 Dec 2024 13:34:43 -0800
Subject: [PATCH v3] riscv: selftests: Fix warnings pointer masking test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-fix_warnings_pointer_masking_tests-v3-1-5c28b0f9640d@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAHIcUmcC/5WNwQ6CMBAFf8X0bE1bKIIn/8MYUusCG0NLuk3VE
 P7dwtEbx3nJm5kZQUAgdjnMLEBCQu8yFMcDs4NxPXB8ZmZKqFIqUfIOP+3bBIeup3by6CKEdjT
 0ykMbgSLxoq4ElF2hS9WwLJoC5NcWud0zD0jRh+/WTHJdd+mT5JKDkdBUlbZwNteAyRM6e7J+Z
 Gshqf1Wla3y0QmrRaM7Xf9Zl2X5AUDmzdUtAQAA
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2769; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=wdD8jAZRCjMd3Gu+Lv3upW2aM9UHvcVExGMABP3l5PM=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qQTFPQcfty272Tki0Tp9hVqomnGGX7rOyL86y7/yaNf
 fN5Hq2OUhYGMQ4GWTFFFp5rDcytd/TLjoqWTYCZw8oEMoSBi1MAJmIgzMiwOLJj3XaT6aty+7UK
 Hu/M+srF3f3i2TzBPw5xLmF8UWd7GP7XRf/XLcy/e0Dgwf7+0zbnVmu8eVK56/itfR/y7CYxVp/
 jBwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

When compiling the pointer masking tests with -Wall this warning
is present:

pointer_masking.c: In function ‘test_tagged_addr_abi_sysctl’:
pointer_masking.c:203:9: warning: ignoring return value of ‘pwrite’
declared with attribute ‘warn_unused_result’ [-Wunused-result]
  203 |         pwrite(fd, &value, 1, 0); |
      ^~~~~~~~~~~~~~~~~~~~~~~~ pointer_masking.c:208:9: warning:
ignoring return value of ‘pwrite’ declared with attribute
‘warn_unused_result’ [-Wunused-result]
  208 |         pwrite(fd, &value, 1, 0);

I came across this on riscv64-linux-gnu-gcc (Ubuntu
11.4.0-1ubuntu1~22.04).

Fix this by checking that the number of bytes written equal the expected
number of bytes written.

Fixes: 7470b5afd150 ("riscv: selftests: Add a pointer masking test")
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v3:
- Fix sysctl enabled test case (Drew/Alex)
- Move pwrite err condition into goto (Drew)
- Link to v2: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com

Changes in v2:
- I had ret != 2 for testing, I changed it to be ret != 1.
- Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
---
 tools/testing/selftests/riscv/abi/pointer_masking.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
index dee41b7ee3e3..2367b24a2b4e 100644
--- a/tools/testing/selftests/riscv/abi/pointer_masking.c
+++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
@@ -189,6 +189,7 @@ static void test_tagged_addr_abi_sysctl(void)
 {
 	char value;
 	int fd;
+	int ret;
 
 	ksft_print_msg("Testing tagged address ABI sysctl\n");
 
@@ -200,18 +201,30 @@ static void test_tagged_addr_abi_sysctl(void)
 	}
 
 	value = '1';
-	pwrite(fd, &value, 1, 0);
+	ret = pwrite(fd, &value, 1, 0);
+	if (ret != 1)
+		goto err_pwrite;
+
 	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
 			 "sysctl disabled\n");
 
 	value = '0';
-	pwrite(fd, &value, 1, 0);
+	ret = pwrite(fd, &value, 1, 0);
+	if (ret != 1)
+		goto err_pwrite;
+
 	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
 			 "sysctl enabled\n");
 
 	set_tagged_addr_ctrl(0, false);
 
 	close(fd);
+
+	return;
+
+err_pwrite:
+	close(fd);
+	ksft_test_result_fail("failed to write to /proc/sys/abi/tagged_addr_disabled\n");
 }
 
 static void test_tagged_addr_abi_pmlen(int pmlen)

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
-- 
- Charlie


