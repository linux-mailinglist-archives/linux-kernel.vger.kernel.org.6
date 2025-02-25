Return-Path: <linux-kernel+bounces-531969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1026AA4470D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D78189ED70
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009231624D1;
	Tue, 25 Feb 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyBMeaPs"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83511422A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502486; cv=none; b=of+iUBy/pkt0tqZADsqYQ3yuW+9zmMcRUZrw81RcVOBt/Nf+cqoldJWy81C0X6fRnhxnjH/Lq03iV/XMIA8Ai2ycVkSIAFbmOq5OiZOZBKioi2TZijoc7ChNiqae2eGtbMZdXBjxg3Cp1sBe8uvzSjI015yeY5G/qikQ095adys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502486; c=relaxed/simple;
	bh=MZpbA1lcqhGGNCZlfkwIew0pmlQo83M4XaoBPEbjqDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eg+m/rI/KUrF5nY9MR23QnHCzRXZNmeckZPrconK9e3zLugMP8qHSrszPcV7wt8ZZ7Klhhiq3TZtNmAiW2EPDwNUXKfPKVxv+rjsv+lq53tmuhL9xsbw+4Scn1TNMrcxT8DyVY6DxH8K9qz/CQS5nijD1lukVF/l0cZO4nxAko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyBMeaPs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220f4dd756eso124792365ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740502484; x=1741107284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QAoxeaZeMW5HX3hQoq0oSvQ/xgTnieCNH0dOJphUQrs=;
        b=ZyBMeaPsM8dAhhSHKDMwSntBwRafUjGpEqxdsBTROyb7dGcBGmH/DulJMp0Q/K1qoJ
         hZV8+WvasMjQIuhitX29mZe2AFfj8pLeto769wZO7WCoiC6GnFJHIvDqqV9Bh6GinDey
         Vig79E8ukebwgxDqyAw+5/IVd4dVyR7ca+4E0gqL1gf1v9jXhVb3D1aplLD22wDiEaC6
         SXGAPUmpN3CBEJ7jgUdo8M7gzgSFwIFWRb3UkpkS6B0PU/j6MXueoiD13yFIR3TWcJnE
         /IZiDJ2h/36LaLMXZqCvBcx1Crtb17qfZs9OJMmUCFUg7hK+Xr5DZYmOIb2wdUbQxYjf
         j3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502484; x=1741107284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAoxeaZeMW5HX3hQoq0oSvQ/xgTnieCNH0dOJphUQrs=;
        b=nUwbA+NBBty3+BXFela6b38iTi2smjhRB7OuMtDqEN9mQGAzufB6u+wUogfoajEc3c
         C3nIZu0aWpJ1hwOAqY8aGuT51OrzRwWN1Lh8PYCRVpVNgMFlF1Vv7TNjikSCfYyru8As
         CeZ6srQAAXjWLo9xGyTKXYoNAhy6c7rdEwvkMVhE48py3X/H3erENQ8uUn3fSYPl9kIr
         A+nP6YmmUKcPr/ibiJqauCS+dF/HPcizL+p4Nivv0etIX66mC8OFd8Z+82Ch7970eUI2
         xkWlc/qnFFzO/aGDUhtz/BpKqJnfKGAzDohIhPJnLl75/Qwd3qYyMaNTjVj9owBLYBqz
         8njQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp5NLkIORYUOvwwsrzZsbTVhxMqJWJLguV3RrJZnTWoe9VvT4ScTnJYSFbhRDQDxJWKVxWj+MkNLbc68w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhw/dKPzSc1jM5sH0TE37qrby4RGcLpTzXmOabHkmi+M/WFemb
	/Mk7R/9dON1uNgHV37et+fze029GlHgekeqzdzZRXqH+RLhk5QIK
X-Gm-Gg: ASbGncvwrXJYYa+0+B7BBUwFVylr+7xQm690afj/9OLQcZDs7SusqQoXjul4Jsabic/
	7DBopAnbkxpNlWHSMD8ut+QKA0YjpxaJ0eVcMSP2G9EDgXegRj0OrVL1OpAbEVNDjVPGLQSkqi0
	BRoYIot4PQbb/vfszGvZFOrngEavvVMLNqzrwPMY7WZVQqrB+Ut4bYblSmBuKnhSAPCCFTwuDCS
	ja22LGVEYcoggxtgadaNYTaZ42cycwClxzvWuSnc2qVDTV5lXpNeeivr57yz7JF0k+KkcWScvU7
	kafcBKSqVP0IHx1yWA2JK0iLluKNddq6a+YxNcL/O+w3f9GiTsXs0+5/
X-Google-Smtp-Source: AGHT+IFY4TBFYKhkUj0BN79fRWitXH1jLvDAGzBxTLCQdNJPhOKzY+6wZ5w5PlmKTz+rbHxoC2ypMw==
X-Received: by 2002:a05:6a00:929a:b0:732:5276:4ac9 with SMTP id d2e1a72fcca58-734790c6b86mr4804966b3a.9.1740502483760;
        Tue, 25 Feb 2025 08:54:43 -0800 (PST)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:9617:42b0:63f7:9aef])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a83cd78sm1788634b3a.176.2025.02.25.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:54:43 -0800 (PST)
From: I Hsin Cheng <richard120310@gmail.com>
To: yury.norov@gmail.com
Cc: anshuman.khandual@arm.com,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	skhan@linuxfoundation.org,
	mka@chromium.org,
	akpm@linux-foundation.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH v3] uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"
Date: Wed, 26 Feb 2025 00:54:37 +0800
Message-ID: <20250225165437.1554395-1-richard120310@gmail.com>
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

The patch was applied and tested against numerous compilers, inclduing
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
register usage> The use of "~_UL(0) << (l)" may even result in the
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


