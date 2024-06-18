Return-Path: <linux-kernel+bounces-219964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F073190DAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C70B23BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B9E13FD72;
	Tue, 18 Jun 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cGA6nXUm"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CB1420C9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732567; cv=none; b=XAKaEMvX8JVcuWJfihqGYf03Y83ICPvMx7o3R7oMPKPJtlwhAW/+M8t+i7/XsZCtQe86FeZ+SsJxkSxVy8iWucXtgn3SV2Bh5Vw241rueOED6JaQORwBe8zIr+w+TUTlVImsxK5lNH+YnXNqjSkza1LDvi6pwg639TFfThSh6MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732567; c=relaxed/simple;
	bh=+KXHaWJRWeE9SvAOhI7bkcjwVi5BF70oFRcy1jR3idk=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=op6u5v8edm5fjo9lHLTnYz6p0aByKUHOwtu/xtt0ZHWAlWOOCLWual0AKmm3Z/0591gnN0PSpBjs52L1ZtsV67bTcY26haOPa7JmJZafxQeMsyzaQR1uzQmMOSnP7Sq0i1/Up7qVeRSxpyc5wj5XhmsNlpHagFisHkefywocSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cGA6nXUm; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7ebac4d032bso9125139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718732564; x=1719337364; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k4kuU5u9SGuQEygwCjUeiFjjBzMumH1fP75ahMq3wIQ=;
        b=cGA6nXUmooQoWHinl1fni5opQsfYufi2e8JaIIx6jb3GN3xHVTd7tboNLcPNJebX3V
         YAafZIyruR3Qa2VXX+anACJe7jLHufn+/BvmpLGroGhm30ZSiFHPhbVQ2oSpf1ZEOxGp
         ULxGJlfV2BoG7Q3IUiLbJnj0dukgS2dyxPVZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718732564; x=1719337364;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4kuU5u9SGuQEygwCjUeiFjjBzMumH1fP75ahMq3wIQ=;
        b=WCpJqT2DF5YmUgqYrepINXi4hd+AopcymHtyRXISAJF91SSy/ci1FByn/7NI03k0T8
         kYlgsqJaz4RqEwfYZFM2QGiC17MUTQuOox0CLWe1eoFyfmYhBYvIo+x9GlCoBUgVq6Ib
         I/ioeeUFgB3X0FGg5FJm+1qMP2cojrp875QerKTJk5b8sCo/OXttxOkxfB+vHJHPgzAx
         4cWGPSYafBq/39F01YZuGNoSs9h6YqKc7B4g6f50ZFNzGBTsFM1mtwiQ6Ed9uXXnmxkp
         IoOZcda97TFqxsx1coYUGIHl2EBqPC2PhXN7IWFzh6mZ///dQK+8B+tjufValxA98TH7
         0yaA==
X-Forwarded-Encrypted: i=1; AJvYcCVhXq9SoHAeOTA0cBOu0JbHGUdg4lyQbpfvRBnbEkS6rFLLkX7tcpVj88SASqiy2l+vXJwzrWewjY65qvKN62G5faVwoh6xXZmL+JVM
X-Gm-Message-State: AOJu0YzpjQt01GBXEWCLYX+HOH2oynIH3dJLDm+QLp5E9bjkz/UK2lLw
	1fLDyJYt86Iss3vWhMTwdyAdYlZmYfYDUdBpyCRebySmiLIEBtSPaA5Bf0kv1Uo=
X-Google-Smtp-Source: AGHT+IF7G4RmejRcO1xloqnVQ5ZeUGAmm9vPWOpgZXO47kbtYs4Jf3cx0KK1+808T1dcENznmujtAw==
X-Received: by 2002:a05:6602:1d57:b0:7eb:ea26:3471 with SMTP id ca18e2360f4ac-7f13ee6c867mr56834239f.2.1718732564389;
        Tue, 18 Jun 2024 10:42:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956a20bc6sm3301638173.123.2024.06.18.10.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 10:42:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Fnxyrn8oxAwDvUk22LM0pFdd"
Message-ID: <772723d8-a7bb-4053-be40-b00680b518bf@linuxfoundation.org>
Date: Tue, 18 Jun 2024 11:42:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes for Linux 6.10-rc5

This is a multi-part message in MIME format.
--------------Fnxyrn8oxAwDvUk22LM0pFdd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull this kselftest fixes update for Linux 6.10-rc5.

This kselftest fixes update consists of 4 fixes to the following
build warnings:

- filesystems: warn_unused_result warnings
- seccomp: format-zero-length warnings
- fchmodat2: clang build warnings due to-static-libasan
- openat2: clang build warnings due to static-libasan, LOCAL_HDRS

diff for pull request is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 4bf15b1c657d22d1d70173e43264e4606dfe75ff:

   selftests/futex: don't pass a const char* to asprintf(3) (2024-05-31 14:37:10 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.10-rc5

for you to fetch changes up to ed3994ac847e0d6605f248e7f6776b1d4f445f4b:

   selftests/fchmodat2: fix clang build failure due to -static-libasan (2024-06-11 15:05:05 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.10-rc5

This kselftest fixes update consists of 4 fixes to the following
build warnings:

- filesystems: warn_unused_result warnings
- seccomp: format-zero-length warnings
- fchmodat2: clang build warnings due to-static-libasan
- openat2: clang build warnings due to static-libasan, LOCAL_HDRS

----------------------------------------------------------------
Amer Al Shanawany (2):
       selftests: filesystems: fix warn_unused_result build warnings
       selftests: seccomp: fix format-zero-length warnings

John Hubbard (2):
       selftests/openat2: fix clang build failures: -static-libasan, LOCAL_HDRS
       selftests/fchmodat2: fix clang build failure due to -static-libasan

  tools/testing/selftests/fchmodat2/Makefile                 | 11 ++++++++++-
  .../selftests/filesystems/statmount/statmount_test.c       | 12 ++++++++++--
  tools/testing/selftests/openat2/Makefile                   | 14 ++++++++++++--
  tools/testing/selftests/seccomp/seccomp_benchmark.c        |  6 +++---
  4 files changed, 35 insertions(+), 8 deletions(-)
----------------------------------------------------------------
--------------Fnxyrn8oxAwDvUk22LM0pFdd
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.10-rc5.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.10-rc5.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2ZjaG1vZGF0Mi9NYWtlZmls
ZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2ZjaG1vZGF0Mi9NYWtlZmlsZQppbmRleCA3
MWVjMzRiZjE1MDEuLjQzNzNjZWE3OWI3OSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvZmNobW9kYXQyL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2ZjaG1vZGF0Mi9NYWtlZmlsZQpAQCAtMSw2ICsxLDE1IEBACiAjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCiAKLUNGTEFHUyArPSAtV2FsbCAtTzIg
LWcgLWZzYW5pdGl6ZT1hZGRyZXNzIC1mc2FuaXRpemU9dW5kZWZpbmVkIC1zdGF0aWMtbGli
YXNhbiAkKEtIRFJfSU5DTFVERVMpCitDRkxBR1MgKz0gLVdhbGwgLU8yIC1nIC1mc2FuaXRp
emU9YWRkcmVzcyAtZnNhbml0aXplPXVuZGVmaW5lZCAkKEtIRFJfSU5DTFVERVMpCisKKyMg
Z2NjIHJlcXVpcmVzIC1zdGF0aWMtbGliYXNhbiBpbiBvcmRlciB0byBlbnN1cmUgdGhhdCBB
ZGRyZXNzIFNhbml0aXplcidzCisjIGxpYnJhcnkgaXMgdGhlIGZpcnN0IG9uZSBsb2FkZWQu
IEhvd2V2ZXIsIGNsYW5nIGFscmVhZHkgc3RhdGljYWxseSBsaW5rcyB0aGUKKyMgQWRkcmVz
cyBTYW5pdGl6ZXIgaWYgLWZzYW5pdGl6ZSBpcyBzcGVjaWZpZWQuIFRoZXJlZm9yZSwgc2lt
cGx5IG9taXQKKyMgLXN0YXRpYy1saWJhc2FuIGZvciBjbGFuZyBidWlsZHMuCitpZmVxICgk
KExMVk0pLCkKKyAgICBDRkxBR1MgKz0gLXN0YXRpYy1saWJhc2FuCitlbmRpZgorCiBURVNU
X0dFTl9QUk9HUyA6PSBmY2htb2RhdDJfdGVzdAogCiBpbmNsdWRlIC4uL2xpYi5tawpkaWZm
IC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZmlsZXN5c3RlbXMvc3RhdG1vdW50
L3N0YXRtb3VudF90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9maWxlc3lzdGVt
cy9zdGF0bW91bnQvc3RhdG1vdW50X3Rlc3QuYwppbmRleCBlNmQ3YzRmMWM4NWIuLmU4YzAx
OWQ3MmNiZiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZmlsZXN5c3Rl
bXMvc3RhdG1vdW50L3N0YXRtb3VudF90ZXN0LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvZmlsZXN5c3RlbXMvc3RhdG1vdW50L3N0YXRtb3VudF90ZXN0LmMKQEAgLTEyNSw4
ICsxMjUsMTYgQEAgc3RhdGljIHVpbnQzMl90IG9sZF9yb290X2lkLCBvbGRfcGFyZW50X2lk
OwogCiBzdGF0aWMgdm9pZCBjbGVhbnVwX25hbWVzcGFjZSh2b2lkKQogewotCWZjaGRpcihv
cmlnX3Jvb3QpOwotCWNocm9vdCgiLiIpOworCWludCByZXQ7CisKKwlyZXQgPSBmY2hkaXIo
b3JpZ19yb290KTsKKwlpZiAocmV0ID09IC0xKQorCQlrc2Z0X3BlcnJvcigiZmNoZGlyIHRv
IG9yaWdpbmFsIHJvb3QiKTsKKworCXJldCA9IGNocm9vdCgiLiIpOworCWlmIChyZXQgPT0g
LTEpCisJCWtzZnRfcGVycm9yKCJjaHJvb3QgdG8gb3JpZ2luYWwgcm9vdCIpOworCiAJdW1v
dW50Mihyb290X21udHBvaW50LCBNTlRfREVUQUNIKTsKIAlybWRpcihyb290X21udHBvaW50
KTsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL29wZW5hdDIvTWFr
ZWZpbGUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9vcGVuYXQyL01ha2VmaWxlCmluZGV4
IDI1NGQ2NzZhMjY4OS4uMTg1ZGM3NmViYjVmIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9vcGVuYXQyL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL29wZW5hdDIvTWFrZWZpbGUKQEAgLTEsOCArMSwxOCBAQAogIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgogCi1DRkxBR1MgKz0gLVdhbGwgLU8yIC1n
IC1mc2FuaXRpemU9YWRkcmVzcyAtZnNhbml0aXplPXVuZGVmaW5lZCAtc3RhdGljLWxpYmFz
YW4KK0NGTEFHUyArPSAtV2FsbCAtTzIgLWcgLWZzYW5pdGl6ZT1hZGRyZXNzIC1mc2FuaXRp
emU9dW5kZWZpbmVkCiBURVNUX0dFTl9QUk9HUyA6PSBvcGVuYXQyX3Rlc3QgcmVzb2x2ZV90
ZXN0IHJlbmFtZV9hdHRhY2tfdGVzdAogCisjIGdjYyByZXF1aXJlcyAtc3RhdGljLWxpYmFz
YW4gaW4gb3JkZXIgdG8gZW5zdXJlIHRoYXQgQWRkcmVzcyBTYW5pdGl6ZXIncworIyBsaWJy
YXJ5IGlzIHRoZSBmaXJzdCBvbmUgbG9hZGVkLiBIb3dldmVyLCBjbGFuZyBhbHJlYWR5IHN0
YXRpY2FsbHkgbGlua3MgdGhlCisjIEFkZHJlc3MgU2FuaXRpemVyIGlmIC1mc2FuaXRpemUg
aXMgc3BlY2lmaWVkLiBUaGVyZWZvcmUsIHNpbXBseSBvbWl0CisjIC1zdGF0aWMtbGliYXNh
biBmb3IgY2xhbmcgYnVpbGRzLgoraWZlcSAoJChMTFZNKSwpCisgICAgQ0ZMQUdTICs9IC1z
dGF0aWMtbGliYXNhbgorZW5kaWYKKworTE9DQUxfSERSUyArPSBoZWxwZXJzLmgKKwogaW5j
bHVkZSAuLi9saWIubWsKIAotJChURVNUX0dFTl9QUk9HUyk6IGhlbHBlcnMuYyBoZWxwZXJz
LmgKKyQoVEVTVF9HRU5fUFJPR1MpOiBoZWxwZXJzLmMKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3NlY2NvbXAvc2VjY29tcF9iZW5jaG1hcmsuYyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3NlY2NvbXAvc2VjY29tcF9iZW5jaG1hcmsuYwppbmRleCBiODMw
OTkxNjBmYmMuLjk0ODg2YzgyYWU2MCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvc2VjY29tcC9zZWNjb21wX2JlbmNobWFyay5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3NlY2NvbXAvc2VjY29tcF9iZW5jaG1hcmsuYwpAQCAtMTk0LDE0ICsxOTQs
MTQgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAlrc2Z0X3NldF9wbGFu
KDcpOwogCiAJa3NmdF9wcmludF9tc2coIlJ1bm5pbmcgb246XG4iKTsKLQlrc2Z0X3ByaW50
X21zZygiIik7CisJa3NmdF9wcmludF9tc2coIiVzIiwgIiIpOwogCXN5c3RlbSgidW5hbWUg
LWEiKTsKIAogCWtzZnRfcHJpbnRfbXNnKCJDdXJyZW50IEJQRiBzeXNjdGwgc2V0dGluZ3M6
XG4iKTsKIAkvKiBBdm9pZCB1c2luZyAic3lzY3RsIiB3aGljaCBtYXkgbm90IGJlIGluc3Rh
bGxlZC4gKi8KLQlrc2Z0X3ByaW50X21zZygiIik7CisJa3NmdF9wcmludF9tc2coIiVzIiwg
IiIpOwogCXN5c3RlbSgiZ3JlcCAtSCAuIC9wcm9jL3N5cy9uZXQvY29yZS9icGZfaml0X2Vu
YWJsZSIpOwotCWtzZnRfcHJpbnRfbXNnKCIiKTsKKwlrc2Z0X3ByaW50X21zZygiJXMiLCAi
Iik7CiAJc3lzdGVtKCJncmVwIC1IIC4gL3Byb2Mvc3lzL25ldC9jb3JlL2JwZl9qaXRfaGFy
ZGVuIik7CiAKIAlhZmZpbml0eSgpOwo=

--------------Fnxyrn8oxAwDvUk22LM0pFdd--

