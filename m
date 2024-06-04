Return-Path: <linux-kernel+bounces-201540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AFE8FBFBF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5170A1F23850
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B29D14D458;
	Tue,  4 Jun 2024 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htXTRpR4"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A6F1411F3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542996; cv=none; b=Al+G85TEKRMWqAbUTPNj2vCBX8J2Tr6GD/tP4uAnedEM1C91yW6sLCF7NxBnKyB0rAtnvDTWa5GCknKzjnIXOj1yVhRYWuyCznI1jYUJHKLwwTejy6DQAXTNYZk514MHWEGaTb1jcXm6T8LTQYXzDTKXWhGe9FHJQD84qyR6H0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542996; c=relaxed/simple;
	bh=d3KD+dGdQ4ZHnHhSkskyUBnHOtvBSxNQVc1S9GV3jlM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bAVLK3sMV1S6C83jwVmW1CdIEdfGG7RX3/RG3K0aTHv0fpuc7Y2IotwY26u60khNfo+NkcowWQV4RwwLG0RY+R7G/nBHCO0XAgHK4k9ZqcwnuHzUlVy5hikZk2PNpOLLxfa7MSu59qanetBo5K7N+k9YzfF+4Yh+pMGQDHN63As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htXTRpR4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a08273919so25429027b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717542994; x=1718147794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WZNrZXaQe5QjyrPFceQH2LfhlF3G2burIHCEgVqIZ78=;
        b=htXTRpR4QIB4i1YJBt5laFa6GBBoLwVvJZTLsxPx+VbyK3eL9dVoIVFwert05DLdW5
         cbFRoGwhGbGAzJH9Kh5wPmZKU3etS5ECGnpJzQLl28kM3Cr6XUsoiGq2WtgmitRa6nvw
         so1gqxJV6GH6Y1TLqRuVMgeZnfckPQ6bMLuw27MbXf0oBJIcuSeT+r2Dz11smGBkobNF
         u/n3AYhufEeMK3u3dqAeIaRHz4sjUPUYIEXB9KTXs3n434aeX/19C1nxzvl8PjUWI9Dv
         91z3W2j0l0Ophb7gAA+P1AoEH4q4zwHbcPBxdfvneA4j0Sd+xVuuLZSu933AcXb5BNg9
         XSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717542994; x=1718147794;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZNrZXaQe5QjyrPFceQH2LfhlF3G2burIHCEgVqIZ78=;
        b=uGS8Fq0J2dxlAdIQ2yLDxZ95mil1l5k/iHZvNi/F3jOsxIaKyW8XpP+grwHLZTrlbE
         bAN74NPxnvdbHkNcx9uojdC0ZY03QIPHYrNGEbGYG1Mi+TcSZ1D6Y0Jj+hv4lGNjpbiq
         6o9v3W4jVdZp0q7xnMZv5jgnBsCOdSZBWfdXefo0LmoulABYe/mhlZV8eRR9gtdl4TuD
         HGM1lEaBv+g+rvgTf71x2yQZv4Cn4mHZtwiXICr/UGKLdD+Z0Ir3DcU7MbCZjavEnTlR
         +tW6YGCvIx9JA7nUxrnMuanyF03NZMLFUEWneI5Yvj3xakYMpbeKPUUN1Od6FyaEaa7u
         tHkg==
X-Gm-Message-State: AOJu0YxYruTYoBqI1urf6r9EYCHHaqHbH1fGB3RiNWgamKWPqT973Qup
	OWzr31hnHbQSpWsCoEtujHMI1Ia2sLWPACtUbydMnzevRdOj2OpeKInDyCN9U+djMpl+AF1blsH
	Tig==
X-Google-Smtp-Source: AGHT+IGjXoXe+YCWwO+tWw0X7qGEAnModzncTc1ziQR914tc4YoJFWMBFQKkS7uv8fTlHNhwtR04tsmeZDo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:887:b0:62c:35fd:678b with SMTP id
 00721157ae682-62cbb5ab5a2mr885387b3.8.1717542994498; Tue, 04 Jun 2024
 16:16:34 -0700 (PDT)
Date: Tue,  4 Jun 2024 23:12:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240604231219.444603-1-edliaw@google.com>
Subject: [PATCH] selftests/timers: Guard LONG_MAX / LONG_MIN defines
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Add ifndef guards around LONG_MAX / LONG_MIN defines. When building with
Android bionic, these macros are redefined because bionic's time.h will
include linux/time.h, which includes limit.h.

INFO: From Compiling common/tools/testing/selftests/timers/valid-adjtimex.c:
common/tools/testing/selftests/timers/valid-adjtimex.c:107:9: warning: 'LONG_MAX' macro redefined [-Wmacro-redefined]
  107 | #define LONG_MAX (~0UL>>1)
      |         ^
prebuilts/clang/host/linux-x86/clang-r522817/lib/clang/18/include/limits.h:47:9: note: previous definition is here
   47 | #define LONG_MAX  __LONG_MAX__
      |         ^
common/tools/testing/selftests/timers/valid-adjtimex.c:108:9: warning: 'LONG_MIN' macro redefined [-Wmacro-redefined]
  108 | #define LONG_MIN (-LONG_MAX - 1)
      |         ^
prebuilts/clang/host/linux-x86/clang-r522817/lib/clang/18/include/limits.h:52:9: note: previous definition is here
   52 | #define LONG_MIN  (-__LONG_MAX__ -1L)
      |         ^

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/timers/valid-adjtimex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index d500884801d8..3d9f1baff86e 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -102,8 +102,12 @@ long outofrange_freq[NUM_FREQ_OUTOFRANGE] = {
 	 1000 * SHIFTED_PPM,
 };
 
+#ifndef LONG_MAX
 #define LONG_MAX (~0UL>>1)
+#endif
+#ifndef LONG_MIN
 #define LONG_MIN (-LONG_MAX - 1)
+#endif
 
 long invalid_freq[NUM_FREQ_INVALID] = {
 	LONG_MAX,
-- 
2.45.1.288.g0e0cd299f1-goog


