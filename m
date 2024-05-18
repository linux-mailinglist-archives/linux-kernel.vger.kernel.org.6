Return-Path: <linux-kernel+bounces-182724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF568C8EDE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F18282978
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1815D4A21;
	Sat, 18 May 2024 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gLNizZnL"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107B363D
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715991491; cv=none; b=RpAAJETr4k+M0AEuX+bL9RayIs3glII0uHL1SfZW4UMoUBt+saM7FQ8lDVHNyhD9/4pRyc+K3Cz/Wxp0zq6b8h3NFoqgyrZ0wMnh5OdojA4r8fyInFfXBPQUJlfh1DrrCfM+ecdM1PtrVPxUrTHkNJX9MNz/c0RluuEDXEJuTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715991491; c=relaxed/simple;
	bh=Uymz9RGaEBz4cZeu7DiuAzeKhXotWtQUW9Tv3ePWw8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hs5SkilmB+vOMk93loqfc+11iCu1zzLB5h1NgaU/oqgSWjanvZllkALWkintAYlrNxmuQ8GHPmhpAmGa+uU7buMj40eMPPPxsstwKBDp6aPitjs0woL0ScVfnV8LqftUh0JZVN9qQ4T8f9gM9IpFXF0ICdlQde6es/ZEfGFOyGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gLNizZnL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1edf506b216so24900075ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715991489; x=1716596289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOLQVL/T02TWP/gLUEfGdGKqwMDMKOKPwTmMExwd+Es=;
        b=gLNizZnLodSK7f8ah7us0QO9Xy/I8crCeWxIraKwYY9APHcA+M/IHq2PrIWQa/GT/4
         t61hHADDqbusU14SMMC2SfNwBF4SB+xtaDAES+yrcfqYaYn0JKuha9smgI5mc7jo1aLy
         J4zUjUHsv5rayk2QAGKyyx85YnEBIinSnUEz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715991489; x=1716596289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOLQVL/T02TWP/gLUEfGdGKqwMDMKOKPwTmMExwd+Es=;
        b=PO+kkU5IzB7R89mzO5lbPbNIlQmtyMMvhSnEwXjCx2W8oc3j6bIaBY4I4wF1TbZWGl
         jcMECugA+PAFyMFjOsBMavvHfmcCeFY0GjDdNBBBDMBil6lX62DGeOIwqWzS1RnMlpcV
         NekfBvL2PGSOQpn/t0wPiQ87ti9jwi4pYRr0w0lKdg1U86kAx3+AeHINlen+5eHSH+Ex
         DtcoTCGp57KltmWH4hXaP5leYA45oVOfGQIWRRZBHCVjCmCd0SbZy0Tb5d0TqIcBAM8o
         S6p+TtoMxAepJcbAJseTcmZJ4vAzanZLYEY5l7T10QwhcHiWY8suruJBdl9gbYI2zt83
         NhOA==
X-Forwarded-Encrypted: i=1; AJvYcCXIlQB9xipxCU+5tXLGMpAjhXSa1BqG6P3UCmCzQfzppi0aCYdDA1BKonio3d/5neajqmfC0Fk52yvSG+kVztZ8+daCk4RCJIxUY4WW
X-Gm-Message-State: AOJu0YwX6GTyxDmJnXQxKL6uMrisYH/XOfMXFR7/W+4Q/H4ZM7v/2Sud
	v89EQK1RIxx9K1tpCoXovMkQ49b0SdOd4fYjbl0Z4qsnVk27TPz2dJDEM1kbpA==
X-Google-Smtp-Source: AGHT+IE+d9yGCWrTkEXvkKzY8JkLoDpqtiZq9uh8bFOZrt5vEUiNH/DgeBWLjmMRV4Ve/lntSWdGKg==
X-Received: by 2002:a17:90b:3118:b0:2b2:c2dd:9cb0 with SMTP id 98e67ed59e1d1-2b6ccd85e94mr19386194a91.43.1715991489343;
        Fri, 17 May 2024 17:18:09 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67105666csm16054611a91.8.2024.05.17.17.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 17:18:08 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] selftests: drivers/s390x: Use SKIP() during FIXTURE_SETUP
Date: Fri, 17 May 2024 17:18:07 -0700
Message-Id: <20240518001806.work.381-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Uymz9RGaEBz4cZeu7DiuAzeKhXotWtQUW9Tv3ePWw8s=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmR/O/Rs8JHxwPnfic8fsbbhMgIvS8iScbRPm04
 rBHts7r65WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZkfzvwAKCRCJcvTf3G3A
 JqwyD/9QbmjNrx+bCJp6FJhOUOPry860Awt4ikGEV/G9GDHtUTJ8Tn1pSGgCPIkwf+OrGsMVJIe
 J5kled3BURo/Z9D4e6NYju/3PWD/bnP5gmdtZg+FFXbBozEMiSyGfQiPdPnGshwqXFk0/H6jxeI
 ron5SufK7RMxxfvh29UxnMMq/nLqlvb4tE7mx5G8ExVXR7W6JnSfEXyiDDGDtlWxRI5pwjFPfHb
 /WRflW7pJOgS3oBDtoqLOi5f5XOl11NRpRaysxN4kamKW6JyO7Bzcvf/zsceq+n5BadoaECpAZ4
 Q6y7tbo41st6By+dPt2ECJNhjVinAFUyNJjtmoYE2sS5jfAL6xouXohIxpM+KwAEK6OioGne8r4
 s0ATg8Yh2sQnkc0pBvUvLzhg4i69ZzQuNlKZELxrKnNaqs92ymI14THqJCimvqY6st29PyHRhZH
 5H17g85n5mK9OvF6B3ppMt67reo5R2wab5QI9mAwyIzvH8vS6tWroONa8T3Z8bWhS0T2/Bv0Ams
 3QO+NCyJ2AB7nOtNosjOA7GfbwNL3ume6xLi8i4j1o/7vTMbKHqEVk4ig/jCsBCf8dE1UyA+FQ8
 siQcnQEL+qrGwQoTh4k3rltFb0YaM9mKuRHEHHUlTQ0Sc+izD8DDiWnHD47185DNx7EpRqgEeio
 VHccqGT 13SESqHA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Instead of mixing selftest harness and ksft helpers, perform SKIP
testing from the FIXTURE_SETUPs. This also means TEST_HARNESS_MAIN does
not need to be open-coded.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
I wasn't able to build or run test this, since it's very s390 specific, it seems?
---
 .../drivers/s390x/uvdevice/test_uvdevice.c    | 32 ++++++++-----------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
index ea0cdc37b44f..9622fac42597 100644
--- a/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
+++ b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
@@ -18,6 +18,16 @@
 
 #define UV_PATH  "/dev/uv"
 #define BUFFER_SIZE 0x200
+
+#define open_uv() \
+do { \
+	self->uv_fd = open(UV_PATH, O_ACCMODE);	\
+	if (self->uv_fd < 0) \
+		SKIP(return, "No uv-device or cannot access " UV_PATH  "\n" \
+			     "Enable CONFIG_S390_UV_UAPI and check the access rights on " \
+			     UV_PATH ".\n"); \
+} while (0)
+
 FIXTURE(uvio_fixture) {
 	int uv_fd;
 	struct uvio_ioctl_cb uvio_ioctl;
@@ -37,7 +47,7 @@ FIXTURE_VARIANT_ADD(uvio_fixture, att) {
 
 FIXTURE_SETUP(uvio_fixture)
 {
-	self->uv_fd = open(UV_PATH, O_ACCMODE);
+	open_uv();
 
 	self->uvio_ioctl.argument_addr = (__u64)self->buffer;
 	self->uvio_ioctl.argument_len = variant->arg_size;
@@ -159,7 +169,7 @@ FIXTURE(attest_fixture) {
 
 FIXTURE_SETUP(attest_fixture)
 {
-	self->uv_fd = open(UV_PATH, O_ACCMODE);
+	open_uv();
 
 	self->uvio_ioctl.argument_addr = (__u64)&self->uvio_attest;
 	self->uvio_ioctl.argument_len = sizeof(self->uvio_attest);
@@ -257,20 +267,4 @@ TEST_F(attest_fixture, att_inval_addr)
 	att_inval_addr_test(&self->uvio_attest.meas_addr, _metadata, self);
 }
 
-static void __attribute__((constructor)) __constructor_order_last(void)
-{
-	if (!__constructor_order)
-		__constructor_order = _CONSTRUCTOR_ORDER_BACKWARD;
-}
-
-int main(int argc, char **argv)
-{
-	int fd = open(UV_PATH, O_ACCMODE);
-
-	if (fd < 0)
-		ksft_exit_skip("No uv-device or cannot access " UV_PATH  "\n"
-			       "Enable CONFIG_S390_UV_UAPI and check the access rights on "
-			       UV_PATH ".\n");
-	close(fd);
-	return test_harness_run(argc, argv);
-}
+TEST_HARNESS_MAIN
-- 
2.34.1


