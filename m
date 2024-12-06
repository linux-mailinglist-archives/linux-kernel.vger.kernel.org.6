Return-Path: <linux-kernel+bounces-435441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7CF9E77B7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB0416C7D4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC2D1F3D4D;
	Fri,  6 Dec 2024 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eUmeuz36"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61152206B2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733507542; cv=none; b=TBfEFh634KD0Gc1c+yM1x7Su/moMkCuDhcxgI1qjAfkQAShbB6c6k2vaoQ4/KnXJWRvlqwmIxc5mYuLCI/yHMkEJ7PapJYJmP7yMpEh18ZARyrv1SyY3AZVPq3R62c06yJwLcwLWL7pSPpegxA+6FmkK2dmyk/HK9JUdRxJovHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733507542; c=relaxed/simple;
	bh=wHElZ6pqb0iSr7hWzaw1Hkcd5+EIf3oGgJDHM5LJtKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NuZfhmZ7VNSpA+2qV2WyJ+9DLPNL/SVhVtjqzOsMhDYS5PJOjhgQCgOcCgW/wHrIZY5ccqoAZ9lQjOo4RbDhuzI6CbBfYOmy7VSjVhJqQQqJBQ33Pq6XSEPvaUk930HXq5UwIwpFyCI7IxpUATQfXo6uhsiqHodhVTK5yJ77wsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eUmeuz36; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21628b3fe7dso1178425ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 09:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733507540; x=1734112340; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t74r+A3G8A2DioiaE7k2dQqMFjTyp32lyeabaPRYOLc=;
        b=eUmeuz36WYFcHIIXHRdBBNzR7iw+0lCbHbq5gX1aQAQGWLheLdWZgo+79Kao1nWA5M
         kJpWcjrAUx0Di8FsdAff228Bk5/LngfXeTgFvkbbgseQKf46h9SEPfgvKMVk2U5m9A3l
         RbyeibmleXsEH9yltJI3pTGR1DCOsJwYrBNO472NGJm5qtaD3Rho1N1rrVm1QZroieug
         VQXvPoNyaPgMm2vlSqS65eseKjJ42KdDV35gwyHE+jxbjthxlJE9SOO3O7U3sGTdE2tV
         4swUFEd9ZRsnYMO3cINjtDM1CxFhWBvFtXRMa/QxjUTh4GLsRlz+lVeOO7AbDriPcQdz
         nhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733507540; x=1734112340;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t74r+A3G8A2DioiaE7k2dQqMFjTyp32lyeabaPRYOLc=;
        b=i26rbwzI85grDjdlJwz0iexYNmopo7j1tfl0LtnDztiezZCecuWn6vJRV29hSGSvhl
         85ddbDSe+CT4qNyglwExFn3IrpZNwbX2azrHtd/cj0aZtIxWsrSyltEuBDhY2/qVqyr5
         QHrcN/yFmhYmsRXWohXnCslyFSWkl9c1DKorSkvEGHtEWssHq1ndx+zaUR9I869A8d6s
         2DF16ToNZsLftzF17t0k2kDg1Ozo9C6dJoFpJgGC44t4AMvGsWntliuAaljBQ9Z1SW4F
         Ml5jvqMfqkACDmejWwJG0FiRmemnpK5Vevt4cSvHouViz5BIuiBpQnhE1tyU8OQ63Irg
         HEng==
X-Forwarded-Encrypted: i=1; AJvYcCWgo2BUaDOil9wgWGuftNLbcwlh5ih85mHiK1Ejmb17w+W5YPyeMEYcdg+PcEp2BESe04S0Nbuw+5SM+DA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/k2l5yhuPftly3gBHBjB46Ukdss0ACINGXKqJ6EL5OuvFr2uK
	gIJxkCh5/dESI3N194Jq394PgRYQBMTwuaBEANOR9pr1j+07vhvgTDLgqGZxFBwlnzVoKN1MWYH
	1
X-Gm-Gg: ASbGnctSmbkmJBqyaz/XWHtHSLhsAXLa2Ul3OpJ1ql1Di/ADpn9MeWT7E4GefvOmaEM
	iSy8NGv5zJrPkW6HsuYt0VfixZeudjrTRx07QZWBUDDpjLNAE/jAhhTlCCR5qEr3utKQbzKwx+R
	P56yJyzwKOah3oc4wWjkJxrFbrXWxX2ZIwVAzVHYiFd5Cid0NbPSa7zQseYkrKUXAOY3RIu3bZ/
	a7vHGADV62ZdR3bQ+cc91vxhj/PJI1cBax/xjXh8S9yG3giOfC2d+T31oOigI4Aqg==
X-Google-Smtp-Source: AGHT+IHJY3+a/koaJNAgjd3cks/U/UAswsKw1upCByf2SIYnfguQrHFIStQdCoJiAXcWG1KzXuXRfg==
X-Received: by 2002:a17:902:cecc:b0:215:b18d:ef with SMTP id d9443c01a7336-21614d4e548mr43127485ad.25.1733507539892;
        Fri, 06 Dec 2024 09:52:19 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f091fesm31464545ad.194.2024.12.06.09.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:52:19 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 06 Dec 2024 09:52:11 -0800
Subject: [PATCH v5] riscv: selftests: Fix warnings pointer masking test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241206-fix_warnings_pointer_masking_tests-v5-1-ed566c2f27e8@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAMo5U2cC/5XNwW7DIBAE0F+JOJcKMIvtnvofVWRhsiSrKhCxF
 k0V+d9LcqqqHOrjjDRvboKxELJ4291EwUpMObUALzsRTj4dUdKhZWGUsdooKyNdpy9fEqUjT5d
 MacEynT1/tmJakBeW3eAU2tiBNaNo0KVgWz1OPvYtn4iXXL4fn1Xf20181VJL9BpH5yBg798L1
 cyUwmvIZ3F/qGa7apqq56gCqBEiDE/U7rcK/1K7pkIww6zi6Kw6PFHtdtU2VYW+x7k3YAf3R13
 X9Qcc1RmG2QEAAA==
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3302; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=wHElZ6pqb0iSr7hWzaw1Hkcd5+EIf3oGgJDHM5LJtKY=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qw5WnfF8acWToTNvwVzjh6/IRoUr4p30Q17/mnt2Y4i
 z86P/V+RykLgxgHg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABOpXc3I0HJaKCGA4+SsaGXr
 gzOO/z8lu0HcLq3kG8uhQMlPnwXqpRn+V0wy9V5u0n42cNmH3xl2xyY/aFn91TXqtvw1OUOfB0c
 auQA=
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
Changes in v5:
- No longer skip second pwrite if first one fails
- Use wrapper function instead of goto (Drew)
- Link to v4: https://lore.kernel.org/r/20241205-fix_warnings_pointer_masking_tests-v4-1-0c77eb725486@rivosinc.com

Changes in v4:
- Skip sysctl_enabled test if first pwrite failed
- Link to v3: https://lore.kernel.org/r/20241205-fix_warnings_pointer_masking_tests-v3-1-5c28b0f9640d@rivosinc.com

Changes in v3:
- Fix sysctl enabled test case (Drew/Alex)
- Move pwrite err condition into goto (Drew)
- Link to v2: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com

Changes in v2:
- I had ret != 2 for testing, I changed it to be ret != 1.
- Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
---
 .../testing/selftests/riscv/abi/pointer_masking.c  | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
index dee41b7ee3e3..50c4d1bc7570 100644
--- a/tools/testing/selftests/riscv/abi/pointer_masking.c
+++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
@@ -185,8 +185,20 @@ static void test_fork_exec(void)
 	}
 }
 
+static bool pwrite_wrapper(int fd, void *buf, size_t count, const char *msg)
+{
+	int ret = pwrite(fd, buf, count, 0);
+
+	if (ret != count) {
+		ksft_perror(msg);
+		return false;
+	}
+	return true;
+}
+
 static void test_tagged_addr_abi_sysctl(void)
 {
+	char *err_pwrite_msg = "failed to write to /proc/sys/abi/tagged_addr_disabled\n";
 	char value;
 	int fd;
 
@@ -200,14 +212,12 @@ static void test_tagged_addr_abi_sysctl(void)
 	}
 
 	value = '1';
-	pwrite(fd, &value, 1, 0);
-	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
-			 "sysctl disabled\n");
+	if (!pwrite_wrapper(fd, &value, 1, "write '1'"))
+		ksft_test_result_fail(err_pwrite_msg);
 
 	value = '0';
-	pwrite(fd, &value, 1, 0);
-	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
-			 "sysctl enabled\n");
+	if (!pwrite_wrapper(fd, &value, 1, "write '0'"))
+		ksft_test_result_fail(err_pwrite_msg);
 
 	set_tagged_addr_ctrl(0, false);
 

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
-- 
- Charlie


