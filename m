Return-Path: <linux-kernel+bounces-432527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F6A9E4C84
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44041881832
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C751891AB;
	Thu,  5 Dec 2024 02:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zPbDmK1P"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7A179DC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733367222; cv=none; b=axdmqdRfW5nZSLXrliaGtWmEZO+KXijEw8neDa7H4E5dGrshvuq7crMuV5asJflE4W3FeERtP7QAgbOer2ABml8NUDzWPsgcl+sfFjj08Hrsps52/ROC73b62p4dqwXqOrrof24bApEETqUJ67CyeVLRF2pmXhN+NZLSqq7n7eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733367222; c=relaxed/simple;
	bh=h5pkF7WFsF6QKVOZr0OZCA6MCXRJdUGJ2thXdNkkSus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZN/VYI/1HTvEdKyFZU+OUEIFVhXuWJs2g/E9pdaOjzwodKAfZZA3HUSpBGYynP8V8xsYp5A04H1xHEmLDneCxM+1MqBIo3bdNVcUrXPXmjagkzIgWYJdZkt5/5uavFgAcPqBm2qLT6GrBNONDCMthccz5bcMasHsW6zaeKARXQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zPbDmK1P; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215b13e9ccbso4083585ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 18:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733367219; x=1733972019; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5i2W/fX0uIIT+J5MfXCDS794yT/hd4XA/lGS5kDrh8=;
        b=zPbDmK1PDYrvD/d1U7IofH5xeW6hmcFbFFIk6qU0yHAeRtlOrUeAQ20vnSQZmu/RlN
         TA88ovcPl7FzN4/4XjIzU8N/b2ddq3P0NJGXE8XsJ6zvA1YjRX9Z6DX8WQXbXayoOMJk
         xuTA3CbSHxfR2BNbzpyKlNa9s2y3uV7T9AV3Rds8BPakVlWuuzZXJ2IqyjhilbHTYr9e
         zhxwBVXWiTQ5wn7SZsoxrdfcpYPs9PzDla0YnY7tU5OzAo2PCThbGSy+MOOmTgMaW3Pb
         U3dTofuH4z054rE6GrKqU6YcB+L173zNvy5g+eQxi3pz5bPBCix/KoUIZ/9OZd0c/xtO
         Jx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733367219; x=1733972019;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5i2W/fX0uIIT+J5MfXCDS794yT/hd4XA/lGS5kDrh8=;
        b=FPtKmN5go21wPUDg57ZEfXc97T2WtB3hQc4u32P65hC3gg1j2bQFR3l1WKEU5NpkuO
         dxaBfB4ErUdZsjw+9bB81ywEr2V2l781ejEkCSUPrLeoelH0Rv5AtJOfWSe50jqkj1Vt
         pT+vX99Fm4ph5ZwwT3gEKD75ahPijTiXe4CgPEktgg1LEYk5LpqGnI6JoXDcXFWbfyEV
         F+08C/hW2i71HfVrXPKbj4DtZlN6x54ZVXEG+MP5f5r/Ses/SP0cZvP2DOfxm7bYdA52
         T/QLxg8rbWhnnQGmEFyBaSUCza6FU8l/JkOcVS9wee0rtIaPhtqCD+D4ubo91iKbp/EY
         vCqw==
X-Forwarded-Encrypted: i=1; AJvYcCXfFmOUcIWzc0gim2ZWlp3VGKegqxLQ0qd4j7GnUtkU7AbHk15DNbl7DEleXnR1EX1n15R8Wju+8NX29VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYkwBTYoOhc6odJtdmyhvYNzYqp1bP1xWwX0DWF6ObwI795wki
	KJumbZt4q27TE06qS7siQCFVvYwMZMUGa3h8wkdhKqN4b439LT/TB50QRauWhnM=
X-Gm-Gg: ASbGncsTiBPM8vFge9PYIKQKs8u00Uyibr7IS/S4yoOMC4MF5umwt7VFeSNKnuNbQJE
	Z2FJNn/RnW6Bps5/Jxkx1Y70AeYscUs6lpbpRO8uqmM+7JX4Mb6sXcok8taMO6ClzCesiUsRfFd
	QG3HrdrURhRr5fvGOH/nTwQ2xtaCdVdcWbb+Zf2uavqGVp166mWXT0r2GKGEKokp4EGYXdAkdbJ
	tLegg84w1fNvKkwZplUqaB3NQVrY7wSxPsd2BC7YOAuiz8zJSKW4d6YbgXC1rU3sQ==
X-Google-Smtp-Source: AGHT+IF0E05Cz0CNGSRzqNmt+I+ohBvI+aYOdKpP0GLbqUbjAZpdOYjCbypomo4HQRAuwyG/o5iD3A==
X-Received: by 2002:a17:903:2442:b0:215:a98c:aabb with SMTP id d9443c01a7336-215bd0e66a5mr135859375ad.24.1733367219179;
        Wed, 04 Dec 2024 18:53:39 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e62c36sm2468565ad.65.2024.12.04.18.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 18:53:38 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 04 Dec 2024 18:53:28 -0800
Subject: [PATCH] riscv: selftests: Fix warnings pointer masking test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAKcVUWcC/x2N0QrCMAxFf2Xk2ULXVVF/RaSULa1BzEZSVBj79
 4U9ngvnnhUUhVDh3q0g+CWlmQ36UwfjK3NFR5MxBB9iH3x0hf7pl4WJq6ZlJm4o6ZP1bUNqqE3
 dcL14jGU4x3ADO1oEzToij+e27SDGsaZ0AAAA
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2409; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=h5pkF7WFsF6QKVOZr0OZCA6MCXRJdUGJ2thXdNkkSus=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qg6MoFCz3CMjK6WW9+Xj7vzKoNdvv6WxY//7S91L3LQ
 fve+dW6HaUsDGIcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAEyk3ozhf7klwyeXpJcfj+S0
 X121KjA9Lpf1y9ZW3ZyL5p3/Tj6bas7IcEDHblf3zqw9WfE7GXaWXpL7s/DgNf7JpQ5ejlbvv31
 7ywUA
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
 tools/testing/selftests/riscv/abi/pointer_masking.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
index dee41b7ee3e3..5ae941e9ac73 100644
--- a/tools/testing/selftests/riscv/abi/pointer_masking.c
+++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
@@ -189,6 +189,7 @@ static void test_tagged_addr_abi_sysctl(void)
 {
 	char value;
 	int fd;
+	int ret;
 
 	ksft_print_msg("Testing tagged address ABI sysctl\n");
 
@@ -200,14 +201,24 @@ static void test_tagged_addr_abi_sysctl(void)
 	}
 
 	value = '1';
-	pwrite(fd, &value, 1, 0);
+	ret = pwrite(fd, &value, 1, 0);
+	if (ret != 1) {
+		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
+		return;
+	}
+
 	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
 			 "sysctl disabled\n");
 
 	value = '0';
-	pwrite(fd, &value, 1, 0);
-	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
-			 "sysctl enabled\n");
+	ret = pwrite(fd, &value, 1, 0);
+	if (ret != 2) {
+		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
+		return;
+	}
+
+	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
+			 "sysctl disabled\n");
 
 	set_tagged_addr_ctrl(0, false);
 

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
-- 
- Charlie


