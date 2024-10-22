Return-Path: <linux-kernel+bounces-376075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7539A9FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F811C21568
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7441993B8;
	Tue, 22 Oct 2024 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tiiYHIeU"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC10145B24
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591835; cv=none; b=jqaMqaKbyTDMW3wTVoTUQXvsH3JLkVC3LkxnbSyA39vqGjvYd2TXoQVKU3NZQ0yDKnJp6sZTRcsJWVGmM6Mt28E6NDFCFqj3yL1K1dF6FOeYIgrrM8UnxhXQIH83SAfSUGjcYn3ahizINzn1nORcefbHbFDdisalIKaG1xSvPWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591835; c=relaxed/simple;
	bh=FIGCc34l/KzyPkK2y49w3mqxIkeHm6Ilr0enOnJYEZk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AhfiUCM/JSCN5EzEjADHtYmhyL5jG1fysKn9Hlc7en9dA8lophOJip/ovOrw7HzEdVRPLZrwGYquRL2whIXwuIbxc+o3GvKhiOUbZ2IcujrEFcvmFFEWKMqK6ogmD/bEIGKaYsps33LiifS8C92yS8KitWD0jwUqx5CbZGeAc2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tiiYHIeU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2bd09d2505so4732915276.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729591833; x=1730196633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4evqWcCKtntX1Xzr/IbjfUtruIcLXYCqTru+K/PxlXk=;
        b=tiiYHIeU8E+oBCT3Yifo6eHdFN1H7JZ19P398bfECQMHyUq6lHDy9sZrHGT7DUOYHB
         4vxyJGHXq/pf13r7UTck1iam4C+gG4qZCmfNJSD0BDmm8cucEyA4mq7dd06A2wZAkllU
         P/H5B0Pgosa/OxxDK946Nq4vJLDlOdfh4r0gduoS7wBwwQzD0RvnTmW8j1ztWkRuGNAV
         eJN5RP8moaHbLzzak9U0KLRgofmUaUBwo2Jw4dv+R9xmksyFV/6BPyR6l65h+trw4rXw
         9TXjnAoytVAMM1u78m4OCsF0zzwQyX4M+/QUCDI5FDiZJ6IvfpnHUJ61FUeLicPwuUjc
         BoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729591833; x=1730196633;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4evqWcCKtntX1Xzr/IbjfUtruIcLXYCqTru+K/PxlXk=;
        b=LMQ64XU5nZIVkRd0ENamoWkEGv13ecMtf+zwlwwN47Wrt8Edah056BoS5myFDr/WG2
         7bM94x4m5PW0tt6YL8ZGzyuEbznDTvIUsYBqeveoq9diVt6ShAvHsyCK2AhVQqmbGLTZ
         oteEUAGOUVDoLK2cBHXZ0q/kVTpWY6EgM2yoVZaOAIaXdec2MfEAmNOSIGz6fA/U9aob
         ialuQJEMuqaYhxTCszTIGQ+8jdGx4yCLm0ew9mI6/O7axgX+yrdUoz7tZsf7Lz7Z9vbD
         oN3EX7uFYMzxlGvCwzrk6JKR2su1uLRnX9E2iEE7+lZSpNU+WcYUD+b5AgPPIyYT/FVX
         tLBA==
X-Forwarded-Encrypted: i=1; AJvYcCXaxGRTOR9zT2XnmG8YVjYXqxi6/ACEYPcA4vB8ZVX1Bto/X6wC1dplihynEMydB0xLDLwLSxocE+nsVB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuDLmYfSHV3Ht21kwq68vHRk9tGyAosdzJVqsL8uiTS6uJenRb
	yRh0JpwAouJ2PUqGqphKlEoXukOs4oNPoG6sJuU7V6QxMSnu1ITlpPWd+QHHUl+PYA64E/S1XOJ
	ewhe7PGiyFg==
X-Google-Smtp-Source: AGHT+IFyN2RsLo9pg/6lwITR5zdqym1uZ8LIP79EcuE7xlsum0X4k0qeoG1BtnS4XQ1CrESKB9PJ3BQm+Ms0Jw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a25:e0d6:0:b0:e28:f302:3582 with SMTP id
 3f1490d57ef6-e2bb11b09e5mr8383276.2.1729591833214; Tue, 22 Oct 2024 03:10:33
 -0700 (PDT)
Date: Tue, 22 Oct 2024 18:10:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022101016.2565249-2-davidgow@google.com>
Subject: [PATCH v2] um: Fix misaligned stack in stub_exe
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

Force the compiler to emit code to re-align the stack in real_init(), so
that the generated SSE code doesn't crash. This isn't necessarily the
_correct_ way of solving the problem, but it avoids the need to rewrite
__start in assembly for each architecture for now.

Fixes: 32e8eaf263d9 ("um: use execveat to create userspace MMs")
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-um/20241017231007.1500497-2-davidgow@google.com/
- Use force_arg_align_pointer on real_init() instead of naked on
  __start, which works with clang.

 arch/um/kernel/skas/stub_exe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---
diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index 04f75c577f1a..50fded2384e6 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -6,7 +6,7 @@
 
 void _start(void);
 
-noinline static void real_init(void)
+noinline __attribute__((force_align_arg_pointer)) static void real_init(void)
 {
 	struct stub_init_data init_data;
 	unsigned long res;
-- 
2.47.0.105.g07ac214952-goog


