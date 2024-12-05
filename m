Return-Path: <linux-kernel+bounces-432528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DF39E4C88
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7F5164A64
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272A918B483;
	Thu,  5 Dec 2024 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wZiKSkCN"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6F79DC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733367435; cv=none; b=mBz412gZGyX2dDOYK8vLOCNMKWcomFuu0WQZtx2ZcoT9QxCOmTdXSUaiSrO9dujtoAUQ+SxKajicFMdbiIJF8ugUZzCNapdPJmWR0xblD6xA70aedj+hzpSth6tohG5CDJcER7n6In2ZrChloLosMrzL5iA9dOcQdFz9F7AC7S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733367435; c=relaxed/simple;
	bh=0kdYtWwDnP1BFgEDmuauQ4kRcQgJT5fkZ+DZ/JMhTyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U/JF3ikuwkENo7oik47KyNwpSLIy5hCSBFZb3BsD/n+1Yy1er6eccpyQ698RtnnPinhG1KQAbOZJ8X2aNqsDJVW2BRMW1fWm5tHjWNxrr0HGE66D7K0pE9Kg8y0jwIvXVbwK2/V5/HCC9xUWxyoeCe80ycG5bb0ncMOnN4Q7CJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wZiKSkCN; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f22ea6d874so266390eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 18:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733367433; x=1733972233; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ipBWW2dnxGgAKU4Po5grW4q1klpnbh+IbcwsuY+B1d4=;
        b=wZiKSkCNHGlr1TVP4iy9UYrsEDDdHborp25nIvOWHhgH4W08Kplx3LiFavPQNF1eeS
         B9jw8+rxWpthSsajU+kXUrnmXEW2gM5Pl1czv8l1JpUdU49DU3/IBs4n7jvII7bDb8Po
         XV7PHvgz4heI2Rn3mt0S/MtCKcOEYy5Y9KRJAEYeXbgxjSuFiA8EMrEP4/RKOrlefpIV
         hmlp0Jw9Oeosnw6OWBU6tBjn0nysaxlgitX4zCpe6/u5xXOqO4z37ABAg81jzZ+P9WRU
         7bvsepI/eFjLbCd07kESXrXYLgg+DNFXxsj+nF2tIYRPmL6+iY1tieIGWVAE0dDDNV9M
         xLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733367433; x=1733972233;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipBWW2dnxGgAKU4Po5grW4q1klpnbh+IbcwsuY+B1d4=;
        b=clXcZGqNjH7kurShzGCecdtVprrWif7stJiUdIMbF49sbVpwfu7rboVHB/8VHoNULP
         tJWSNlmyZAYtZX8GsrFDrJ4J8Me1RcGbXHAwoWWmlBJHf6uXddpgwlaZJ+yBtxfZgPxO
         SPG4jr8q/kVgsYWXCt90ZqHIPIHmdA8eKwh88Zf3cHS3W7QiSp7yWak2cCmZFu3XWCKs
         mUxmX4ahofmdVbzx/pnMQAVN/c5pzo5f0+zZwOeRT5SQOZP6dLepcZPcRvNGoBxudCe/
         OyDypibFWHNbtNFlqvGwsn8NxH4KG2n2OyxfIgSYBIX+NpebyEDpJF8VB/hJB5otkwbI
         ubaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+zkyqabjxTunRQNHr9UCtWrkA7EDvT51DQrvf9b6cNVlsW0BOVcBRssKkjNs+MBNwGl9Xg1v8z2E55II=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmIXolUbYCmu+2DhPNYu36WDpcNvGnfE8Fx6Yy0EPVVsDkZNjn
	RKQlUfyiH3ABD5jgffjUiaySrsnfbk+3nEL6A202Ty+RCQi/0xw0I9D3xW+2ot8=
X-Gm-Gg: ASbGnctTbywOPLeW2GSwsWpuF0RqWhRF2wWnZJLbn24gLfVJySHHRQJ55UUrXs+haWu
	Z/JUm6qVF3tcJ5Y+a+8dlCQj4VZsuZ4uh1v5KZzwG/44pIzSpEJ1LKX21kYlKv6qQsPodBPgelL
	8MQGqZX7CrFBdNEub4cwBeyXrp5Uqin/TwGAQ2xyq1yxZBPGk0UxoF2m2/0zRG2QptIT09mlntu
	WB/1uqHBjBwfItrtcHAT6qzcn7AUD69IULQQhyJv+S3q+UHfNX3ggaBTTNNkYq3bQ==
X-Google-Smtp-Source: AGHT+IFEHWkyCS6LHG+yi34gQLK5jMcjxCLqzFDhxH1oJQf1pgNGxOZbslnPeagR+v0TgGJ8kNbHbQ==
X-Received: by 2002:a05:6830:6016:b0:718:9d30:3c5a with SMTP id 46e09a7af769-71dad5edda4mr11520783a34.2.1733367432913;
        Wed, 04 Dec 2024 18:57:12 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd1568f26asm269581a12.9.2024.12.04.18.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 18:57:12 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 04 Dec 2024 18:57:10 -0800
Subject: [PATCH v2] riscv: selftests: Fix warnings pointer masking test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAIYWUWcC/5WNQQ6CMBBFr0K6toaWguLKexjSNHWAiaElM03VE
 O5u9QYu30v++5tgIAQWl2oTBBkZYyigD5XwswsTSLwXFrrWRunayBFf9ukoYJjYrhFDArKL40c
 RNgEnls25q8GMTWt0L0poJSir38ltKDwjp0jv32dWX/tXPiupJDgFfde1Hk7uSpgjY/BHHxcx7
 Pv+Afx+3AbXAAAA
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=0kdYtWwDnP1BFgEDmuauQ4kRcQgJT5fkZ+DZ/JMhTyA=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qgWLsNj3bsWpZHUWmFDRf+m6jKrLVaPXf1Re3UfeFvX
 Bl0nzh0lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMJGeckaGy5E31Z6ZyXT2rDnV
 soktz/XWx30OxXv/KUQ/5P53Y87MDIZ/Gv4nj0isVhPeJ/664rZD2799yYbFnE81f2c6z9NKvqb
 DBQA=
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
Changes in v2:
- I had ret != 2 for testing, I changed it to be ret != 1.
- Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
---
 tools/testing/selftests/riscv/abi/pointer_masking.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
index dee41b7ee3e3..229d85ccff50 100644
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
+	if (ret != 1) {
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


