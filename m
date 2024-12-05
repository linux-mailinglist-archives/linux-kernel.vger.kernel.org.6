Return-Path: <linux-kernel+bounces-434022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11519E603E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624FB284D34
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207E1CC89D;
	Thu,  5 Dec 2024 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Lr0R/22v"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A9F1AD9F9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733435383; cv=none; b=FToMVRJtdFkGhlvyrMX+swNF82VDpK8rfWfqmLUZnqXrUXJfqytKl7O54HV5dtBxA/T2upAv1/BTlRl/hsJrfHM9VDm++geYYNJPxEkVlgKWC9n00OIHXvn632TLCrGAjdJixOaF+wM2LU6pDLTlzYBmiakvz3M1KDJvH5yKd4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733435383; c=relaxed/simple;
	bh=8FnRi21KlrzOAiYqaiv4ehq3t7YDIRIjKXA+qmcuaUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DsKsicRE0/Wm2v11C9OB84OHv9sYNjSQbJDVIHgHWKMlZen3oru7ySvwaHqWfz2vEiXGL4twf/VNk2P2TFe8jY/tiKQzQLRkrJRfgMSpBJ6n2UVvM/MjUwbk4vVH6jrabkzmJKFIQZFwxn8CKHlJInqEY3g88IsKND4Iyjij8WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Lr0R/22v; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21578cfad81so12504835ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 13:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733435380; x=1734040180; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylsolAa24KJioSknE/TsKey3hUL/pRTv+tYnTAIOBOU=;
        b=Lr0R/22vtsW0zJLXjpi7Nh0FyoBYgopUY4T1UGRy2rBMubgYwIxWlHNrOHCMg3aq/k
         6kZtr1UXMtWgArRBQRgny5+YtD8xGWknTBFe9raPzhYlFlU61NY6PEIWnaVt16bwsKD8
         oZU4teDzB8aRSS4n2NR1jjkAmsL9OJkUewFOYmGw1cqS25zG176wBS8D+MzVIE3pT0tf
         E8m4JQVrmtJkKx0MCelgVM4N2lSWA6yzVRpPnZpLBcCDHKgLxoGeCtKfA44znj8I4acm
         9brlUWb8UdA3dl4ew20vOyaEBbp0AdWb7zXlrm/4DwsoXC2WmWtuaf8d9NUusxNcXOLA
         hIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733435380; x=1734040180;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylsolAa24KJioSknE/TsKey3hUL/pRTv+tYnTAIOBOU=;
        b=vynr9Tmv/xEmVTM+/OYDYMDAVTkZJ4AMgh4O+AkxeA71zQWPz73U+v3/SAQW0ImXaQ
         hIYnpEfcdmlZnLwgfodW4eAPjgzG3WVpExvr6kko+Xc5FFLfTB49E95b80KucTVV4KNW
         cpwMUgg7o7RKBAW4n1znVj6EMWZiuzOU4iQ90AA02gzM+83U3gt9WA0gm6iw386r1EoE
         zuqTrYFRADMhTrTZrvpRpoj73Nv41u5X+ebhL2MB6fXHVxwvjJilyKsXCudoL/O6qjAK
         NeW4sCaQ50S8dWGZiDo1zQPX1IQqI/Mk+7E8v6oYjwKa2cZQKNkt77mQ6a0Cx/9wCwUs
         xpfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz1ZJI/bEMDX5tUZh4x0oMBbFjhVp6v/qTAhAtErETzUss1/DE3R8hEsAh0Rkyg8JaRLvpnjFX0b26MDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGXN17Aply5InIOYGBaud6qyQz5LhRWnffhH1DJXRPdcabXty
	JsFIRHCp4O5MK1BZW6DV7imTCYTd5S7X6b/tzA30/K3ldSH9bFr8x/ypY2vHmS0=
X-Gm-Gg: ASbGncuDLTg2OPz2GQBl8jAQLlBItptR3x2DIJNbC+g2lDNnJg8YmImmQokJu+/EdX7
	ShrSQgFR9jJyHyHmxriu23xGstT+NeSrqIbrczF3amd+XF75K8P5D9lfaca/uOxiBpKuwgpoKpC
	VdFKxTbjb9bVwrtpq0ayGqMEmlePukUd/EYgQ/MB/VOUgCc5b2gm3+iVqFqYnatGNs0VAyM+8Ua
	dWkW5hsITJRCr07goHGXns4GcWz4sxt88NdSdq8mYE1sIXxqCYmo2vpnCGirkKXaA==
X-Google-Smtp-Source: AGHT+IFTb2VVc0pKxcp/N8wkyZ083cyONyg4oc637ROCo07u90M4wR/yDH/PPfe8ZbpGqnrUUyfdNA==
X-Received: by 2002:a17:902:d4ca:b0:215:96bc:b670 with SMTP id d9443c01a7336-21614d3ac68mr5579825ad.18.1733435379862;
        Thu, 05 Dec 2024 13:49:39 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9dafsm16496085ad.120.2024.12.05.13.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 13:49:38 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 05 Dec 2024 13:49:31 -0800
Subject: [PATCH v4] riscv: selftests: Fix warnings pointer masking test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-fix_warnings_pointer_masking_tests-v4-1-0c77eb725486@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAOofUmcC/5XNQQrCMBQE0KtI1kaSNKmtK+8hUtL4ox8xKfklK
 qV3N7oScaHLGZg3EyNICMQ2i4klyEgYQwl6uWDuZMMROB5KZkooLZXQ3OOtu9oUMBypGyKGEVJ
 3sXQuRTcCjcSrphagfWW0almBhgRl9TrZ7Us+IY0x3V+fWT7bv/gsueRgJbR1bRys7TZhjoTBr
 Vy8sOdDVv+rqqiy98IZ0Rpvmi9q9a6an9SqqMapphe+rbU4fKjzPD8AG0LWz4MBAAA=
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3049; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=8FnRi21KlrzOAiYqaiv4ehq3t7YDIRIjKXA+qmcuaUE=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qQ/JtKlok/ngWsEnDPXCFRfe2C1zl5v6oHFxLMZS1EJ
 md/yEjsKGVhEONgkBVTZOG51sDceke/7Kho2QSYOaxMIEMYuDgFYCL5RQx/xVd1fP3e1uLwcYuO
 oUAil+CKPN/D6+qKZ7NY3vhl4hSmzPBPT8vkr5TN5waVDWVTp9ZNZ5h/Z+ZCTuPjs+wUJnvabDz
 KDQA=
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
 tools/testing/selftests/riscv/abi/pointer_masking.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
index dee41b7ee3e3..759445d5f265 100644
--- a/tools/testing/selftests/riscv/abi/pointer_masking.c
+++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
@@ -189,6 +189,8 @@ static void test_tagged_addr_abi_sysctl(void)
 {
 	char value;
 	int fd;
+	int ret;
+	char *err_pwrite_msg = "failed to write to /proc/sys/abi/tagged_addr_disabled\n";
 
 	ksft_print_msg("Testing tagged address ABI sysctl\n");
 
@@ -200,18 +202,32 @@ static void test_tagged_addr_abi_sysctl(void)
 	}
 
 	value = '1';
-	pwrite(fd, &value, 1, 0);
+	ret = pwrite(fd, &value, 1, 0);
+	if (ret != 1) {
+		ksft_test_result_skip(err_pwrite_msg);
+		goto err_pwrite;
+	}
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
+	ksft_test_result_fail(err_pwrite_msg);
 }
 
 static void test_tagged_addr_abi_pmlen(int pmlen)

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
-- 
- Charlie


