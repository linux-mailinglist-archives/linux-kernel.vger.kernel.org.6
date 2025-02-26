Return-Path: <linux-kernel+bounces-533141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92959A45615
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A966C3A7207
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE39269AEA;
	Wed, 26 Feb 2025 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoeQ1WYs"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4D5028C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552994; cv=none; b=ikYDIReU0jyE9JQGKSCkd/c6KU8OBt1TQwCKwNrtpbjaSfTJ3Td35A3eocnozQRDpxpBQOtNugcs6EAOwrbfNaz7V3nYba+paHqSXqIwMLaRC3c1MvnOjia04bxkAdP2E8ivDzrAB8g2Hfc3dKoYGXYGywU8SCtaxzCRSQCmoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552994; c=relaxed/simple;
	bh=maWE2ec0tJrqxvlM/sGG8sDlN+b8R1Q5EaLQCSNYN3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MLG/daZSmAU1uUxAwkz18nBHd3acU8l+iLT8G6Iybkjiyz2N3E4vWrPYt7ITlOgs8UGVMg/V3YcCzVIDa70OhCgICfpQQA+1t+o7IN7T02KMncmjZjvOnxPp9WR4PUDs+StnOAsc+pw10nNPETOXxX8GDlAdZyPEtXCUQnSJrT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoeQ1WYs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-222e8d07dc6so10063585ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740552992; x=1741157792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UvBUkvrpnaWOB4XGkZSpuc/FodpmoXmalQA7k8tmnYE=;
        b=JoeQ1WYsfuB7RyMMdA3+9W6pemWuotKy08QhOoGhm056R+Btdu4Zuso/E25ogQB7u0
         XI8Lu8479vCmSZ3FqWXSxRFEspKl18zidfukbrkWkJcxazqGH95sgmmytCcpH8UNH3st
         touDl2EazpCpHQCY0yWhXXO2ioVTp48fs48Jpv0pSTG6aqaFgHyNWiOnGrhX3IZC5ai4
         5j/0DdDjve7PMSr2zFZs2hE6zclp4Dd41mcizIzm7U+izLo22vjfuPHMbjsmQI4B4MYK
         divuWYXxCbzcU2Zspev771qXLmkRfBWwlCXVM34MqV3xNLckxrNn6api531+y/G4dGDT
         7ZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552992; x=1741157792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvBUkvrpnaWOB4XGkZSpuc/FodpmoXmalQA7k8tmnYE=;
        b=V8vIhOEyrqst6t6t21I9xw35H+pSlbYPCK3fAi2Lc/RA9uyAwjCDPVqj7rfcodafjZ
         2F7UpaMKdt46hGwSiLaN5bkNKyz4/MULXphye2xhpanpQXKS2uQbDrByrDJwpoW2DJsz
         phwR8HfzKwI/uPh65PqfCTDyueMQ44d1vsTa/sjVYVQ5A3mcgiKoHTb3yNbVoLINAGOh
         9374bGD6Z79kI8eLmfGsRepZ+I5qmQzgX51ZZP7U5f1A1Snl3jX9Qo+cEZ3tq2v7kTfz
         L3X7vmK5BWteciS7Oc+SlCq5U2wE2yR57txASSohWKmmGomfuZ4xwlelWwhNHHE4zB7B
         ZoQw==
X-Forwarded-Encrypted: i=1; AJvYcCUl0Kt4xfPYqIv2QCfspkNGNIuA47Ua1ioJXhowItEIZOFWyyglGHngHRrtXfYI8af+YPIxoZTY27cqXHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2XhBTnWiPq7G/h/k4S7WuXShjX0WqAMnNTSRMR3v/QxhmrH0
	YCJhfFIcL9d6ztSXAI3brY9qo3vDy5aO+fVMYhRF92r+QMiY7zdPpv4t7g9v
X-Gm-Gg: ASbGnctQBz1KQGHeskFTbpsOnEI2WWUvW6WLYg413t1b9D0dunbkzjS4fVMtdU/kpEj
	wTscmLeF0bjZtbmz6MjVFG70ebWkAU9gmsDZnqtvMXpNXOOUvmnkSOnoGKEqmpnmV/fN/nxeJXn
	0r/9OvfhN1c9m02KozUzNrSri3xKwMHMEg54aWXorDcpjxyLvIksROHtl1RR0y/6VoBBl3CwtXr
	3zojZzCRF0GAJmmkQdX3y4LzyLtgfrE5dHjoDAN+nX/ki6QmM7Nk9URNoa5ECTTA0Ic3WR5AAEZ
	zXWx7bNjPOKGGpGIC+L7VOj888VLaDxTThOhZfKm/X/tTWyxCDUULgi3
X-Google-Smtp-Source: AGHT+IHWNgMRxS2wDsQ8DfmTVlhhQ98TvahLD3DSbQQe0MJnnyowlR0MgLuR1nRqrbVlX+8Z8D6BeA==
X-Received: by 2002:a17:902:d2c1:b0:21a:7e04:7021 with SMTP id d9443c01a7336-221a001fb74mr306421785ad.24.1740552992216;
        Tue, 25 Feb 2025 22:56:32 -0800 (PST)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:484a:6ad2:2b8e:884b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a00ab54sm25236725ad.77.2025.02.25.22.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:56:31 -0800 (PST)
From: I Hsin Cheng <richard120310@gmail.com>
To: yury.norov@gmail.com
Cc: david.laight.linux@gmail.com,
	anshuman.khandual@arm.com,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	skhan@linuxfoundation.org,
	mka@chromium.org,
	akpm@linux-foundation.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH v3 RESEND] uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"
Date: Wed, 26 Feb 2025 14:56:23 +0800
Message-ID: <20250226065623.1567363-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch reverts 'commit c32ee3d9abd2("bitops: avoid integer overflow in
 GENMASK(_ULL)")'.

The code generation can be shrink by over 1KB by reverting this commit.
Originally the commit claimed that clang would emit warnings using the
implementation at that time.

The patch was applied and tested against numerous compilers, including
gcc-13, gcc-12, gcc-11 cross-compiler, clang-17, clang-18 and clang-19.
Various warning levels were set (-W=0, -W=1, -W=2) and CONFIG_WERROR
disabled to complete the compilation. The results show that no compilation
errors or warnings were generated due to the patch.

The results of code size reduction are summarized in the following table.
The code size changes for clang are all zero across different versions,
so they're not listed in the table.

For NR_CPUS=64 on x86_64.
----------------------------------------------
|	        |   gcc-13 |   gcc-12 |   gcc-11 |
----------------------------------------------
|       old | 22438085 | 22453915 | 22302033 |
----------------------------------------------
|       new | 22436816 | 22452913 | 22300826 |
----------------------------------------------
| new - old |    -1269 |    -1002 |    -1207 |
----------------------------------------------

For NR_CPUS=1024 on x86_64.
----------------------------------------------
|	        |   gcc-13 |   gcc-12 |   gcc-11 |
----------------------------------------------
|       old | 22493682 | 22509812 | 22357661 |
----------------------------------------------
|       new | 22493230 | 22509487 | 22357250 |
----------------------------------------------
| new - old |     -452 |     -325 |     -411 |
----------------------------------------------

For arm64 architecture, gcc cross-compiler was used and QEMU was
utilized to execute a VM for a CPU-heavy workload to ensure no
side effects and that functionalities remained correct. The test
even demonstrated a positive result in terms of code size reduction:
* Before: 31660668
* After: 31658724
* Difference (After - Before): -1944

An analysis of multiple functions compiled with gcc-13 on x86_64 was
performed. In summary, the patch elimates one negation in almost
every use case. However, negative effects may occur in some cases,
such as the generation of additional "mov" instruction or increased
register usage. The use of "~_UL(0) << (l)" may even result in the
allocations of "%r*" registers instead of "%e*" registers (which are
32-bit registers) because the compiler cannot assume that the higher
bits are zero.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
Changelog:

v1 -> v2:
	- Refer the patch explicitly as a revert of commit c32ee3d
	- Squash commits into 1 commit
	- Perform compilation for numerous compilers, architectures and
	  compare code size shrink for each of them
	- Perform cpu-heavy workload test inside x86_64 VM and ARM64 VM
	- Analyze the result of disassembly of several small use cases

v2 -> v3:
	- Refactor code to single line
	- Disabled CONFIG_WERROR to ensure no additional compilation errors or warnings
	- Remove description for unrelated compilation errors and warnings
	- Summarize the result into a better looking table
	- Rephrase the patch and fix typos


Hi Yury,

Sorry about the last iteration that I included everything, making
the email too large and difficult to read. However, you still reviewed
it and gave me feedbacks, really big thanks for your patience and those
feedbacks. Running these tests also gave me a great opportunity to learn
a lot.

If there's anything else needed to be test or modified, please let
me know, I'll ammend them as soon as possible.

Hi David,

Thanks for your advise on alternative ideas for this code. I ran some
simple test (basically check the result of code size reduction) based
on your suggestions.

For gcc-13 on x86_64 + defconfig.
* "(_UL(2) << (h)) - (_UL(1) << (l))"
	Before=22438085, After=22438193, Difference ( After - Before ) = 108
* "((_UL(1) + _UL(1)) << (h)) - (_UL(1) << (l))"
	Before=22438085, After=22438209, Difference ( After - Before ) = 124

I tried to do an analysis on "intel_arch_events_quirk()", it only +2 in
code size change, I think it would be a nice example to see the differences
in generated code.

So the result shows that your proposal can save 1 negation and 1 "and".
-ffffffff83278ad2:	48 f7 d8             	neg    %rax
-ffffffff83278adc:	83 e0 7f             	and    $0x7f,%eax

However, one more "mov" and one more "sub" are generated.
+ffffffff83278acf:	b8 80 00 00 00       	mov    $0x80,%eax
+ffffffff83278ad7:	48 29 d0             	sub    %rdx,%rax

No change in total number of instructions, but negation only requires
one register, and the "mov" generated is more expensive then usual.
(Usually "mov" of the following form are generated,
"48 89 ea             	mov    %rbp,%rdx",
"89 c3                	mov    %eax,%ebx" ).

Thanks for your advise again, in some scenario it does have positive
effect, but unfortunately, the overall impact is not beneficial.

Best regards,
I Hsin Cheng.

Tests performed on ubuntu 24.04 with AMD Ryzen 7 5700X3D 8-Core
Processor on x86_64 with kernel version v6.14.0-rc1.
---
 include/uapi/linux/bits.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
index 5ee30f882736..682b406e1067 100644
--- a/include/uapi/linux/bits.h
+++ b/include/uapi/linux/bits.h
@@ -4,13 +4,9 @@
 #ifndef _UAPI_LINUX_BITS_H
 #define _UAPI_LINUX_BITS_H
 
-#define __GENMASK(h, l) \
-        (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
-         (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
+#define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))
 
-#define __GENMASK_ULL(h, l) \
-        (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
-         (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
+#define __GENMASK_ULL(h, l) (((~_ULL(0)) << (l)) & (~_ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
 
 #define __GENMASK_U128(h, l) \
 	((_BIT128((h)) << 1) - (_BIT128(l)))
-- 
2.43.0


