Return-Path: <linux-kernel+bounces-370714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3CF9A3129
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355D21F20933
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FEF1F427A;
	Thu, 17 Oct 2024 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChehaxuT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C61EE027
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729206624; cv=none; b=OcSn5zcI6aiQRO5hkC3VZNYJE0qakFT0Q2nHLUExTOdZkEMUXD3EXzgqYCIP3jqJ7xIFb1UACyUs1fvSVHcPl9TH7GWyM5LxJBi+L7m7gp/UGApc3/BZg3P+v6tAaCC5k4ecSiPRWrDspFzjZfRIva6v4d8U/3YZ9rbgCbWqg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729206624; c=relaxed/simple;
	bh=kLIIwiAQXCgqNdxcz8z50Zez94nn91mEY4o5I5uWC3E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qw6nmFWrLsIvsVixn4oNGpvHsc6clxpW/bz3tNgyx5Fc2waYLE/9OqJn07RX4gx6AwCy9Yz4FEaXhdhnRtf4CMzjisLJ7mD0AmIvB4tSsK+JVMDnM+JskzW35pj990B3O3onBA2X9g5v/7/2xxBO6D95C2PvQ8GnKJ9/cHfeodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChehaxuT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2b9f71917bso1374102276.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729206621; x=1729811421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fr7LkEYEQ2i7ItvFzGynv5JHdOaDwJd+YsSvx5gsy4M=;
        b=ChehaxuTiGQsQ2j5fsRr1G1SJ5Rx9bon6oDV4ThxvnE4Z0OwXXEztawCsEmo8sSfVS
         FyubIcMRm7q+gNteqFMpPHrNk6KanWWTHhA/gNrx4Enwr0m162yZMRij3+STKvO7rdYC
         6O3y5NowVCOkWbVHaRIuSLJBP5uSuhRTEcu26psQZlY02/zTsvOrwDgrnFekIcjJ3JYr
         /UB4RfiC6AlVZEbdp2ldJGwolMFvqfTPuVYxc6WRA4u5De+fcqi8KRm54a1JJDG648+a
         6RaLKPi5Us4hAe3KwFqQQ2C+7nT6Vc3bJlRPtn9lyv7dVHcu5dxvnZLCuzJYJbPmDh08
         btTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729206621; x=1729811421;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fr7LkEYEQ2i7ItvFzGynv5JHdOaDwJd+YsSvx5gsy4M=;
        b=Z6y5VYyBbFegSRQlGyub3J+b5HKaSc4M9SS90J1MohFuyJb8d0jAo0xWlVE+YaJPNO
         avbCMMwSZeOvJPsT6IdtP3T+g0PDi6joqBUnSN5NpOgWob4jbi8Mx6q8CD1zCRExPDfm
         CtAzq5cOjdUsDmmfkPqosxK3WbNXEVqNIyrbRYqy8GjR8jVTe+opdlm9fGX1A0AGGpT5
         pSmodqX5//Mo/QRtkdPdV2Baz3f4m/TCXnr7qzCV4/ySPibf4ChgiPkzDgzhlbKhMVJ6
         NpUatE0/jQvVU+05infB9k70ZdFucik23bvKcGDxHkVXpwWwHYdcrnfpIuGtK9GyKGhO
         G0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIfSJzZmxBFVBp1pBK79tWYSMxrTm7wsnHjHH97/YIs08bYvEyPFsamSYIWc8FHAKiVgMRMgIoPkNODpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzG0MaTgJHRamVZWI3y3Bk59aGMBqBkH/jCXPvnR6B1utd15Ui
	NLhghBjKvVTUKB/MJpzBK35y3Hq4Lumq3wPkA2MUNAb7y3vzZZNDCuI0cqcxRrgzgXvpv8nwYRr
	a1Jo54qo7+Q==
X-Google-Smtp-Source: AGHT+IENKH1N57vAuzezME1AKL8ZcgxjFf76kHwETDmIM/ia9x3pCbTLwMe9I3IJxACLuXxxmv0ADtZTtlT+/Q==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a5b:648:0:b0:e24:c330:f4cc with SMTP id
 3f1490d57ef6-e2b9d04de9bmr11384276.6.1729206620705; Thu, 17 Oct 2024 16:10:20
 -0700 (PDT)
Date: Fri, 18 Oct 2024 07:10:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017231007.1500497-2-davidgow@google.com>
Subject: [PATCH] um: Fix misaligned stack in stub_exe
From: David Gow <davidgow@google.com>
To: Benjamin Berg <benjamin.berg@intel.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"

The stub_exe could segfault when built with some compilers (e.g. gcc
13.2.0), as SSE instructions which relied on stack alignment could be
generated, but the stack was misaligned.

This seems to be due to the __start entry point being run with a 16-byte
aligned stack, but the x86_64 SYSV ABI wanting the stack to be so
aligned _before_ a function call (so it is misaligned when the function
is entered due to the return address being pushed). The function
prologue then realigns it. Because the entry point is never _called_,
and hence there is no return address, the prologue is therefore actually
misaligning it, and causing the generated movaps instructions to
SIGSEGV. This results in the following error:
start_userspace : expected SIGSTOP, got status = 139

Don't generate this prologue for __start by using
__attribute__((naked)), which resolves the issue.

Fixes: 32e8eaf263d9 ("um: use execveat to create userspace MMs")
Signed-off-by: David Gow <davidgow@google.com>
---

See the discussion here:
https://lore.kernel.org/linux-um/c7c5228e9de1e79dc88b304e28d25f5ffd7e36dd.camel@sipsolutions.net/T/#m90c1c5b6c34ebaaa043b402e97009c5825fd158a

---
 arch/um/kernel/skas/stub_exe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index 04f75c577f1a..722ce6267476 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -79,7 +79,7 @@ noinline static void real_init(void)
 	__builtin_unreachable();
 }
 
-void _start(void)
+__attribute__((naked)) void _start(void)
 {
 	char *alloc;
 
-- 
2.47.0.rc1.288.g06298d1525-goog


