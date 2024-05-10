Return-Path: <linux-kernel+bounces-175161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862EF8C1B95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136581F2124A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40CD143729;
	Fri, 10 May 2024 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAtmuD9W"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943F1420BE
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299928; cv=none; b=PlaHO1BDaQnpDoC7m4na3bbxP4umqnb006qfYLBSc4PJ3aBYhRJIF6YO/VxgC74xsqKevT/ie2zFASQzu4DyMmD+fP1/rc+8SZKMbkmTpTz/m0eyX4E1/TmdxMK1J2KR7yxQVk7h41E/uZUneahdkWg/ZkKDgPYS1i5DXpGzdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299928; c=relaxed/simple;
	bh=cY1yLjDVOZyUKN7zy3cH0I6yfDbGKSufrusCzHder2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fnFbboppEjm0ph7HiX8p95S1+JDhaO0wmwVbPIDBZ7TEEDDUrKXi6WkTAWq0VTCyKdtdM44LKUe2fih07TBIJo9VNSjtl5pJ6PPNu2WGZXPCRAyXEt4/ekCJa/14AOaDCCNECAhMEZl+/BRX5nK+e75ZEmJUOy9xLPjUksq6zNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAtmuD9W; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f46acb3537so1038165b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299926; x=1715904726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+/kjO6igpY5Z9IiOKAmMz8PNt+9Eolw6t7DBSMXgDQ=;
        b=EAtmuD9WCSKsTAnkTmM1crXLqjyHlaYH7cg8jF9zWPnpcoKSaJa5NQ8TpIX4K+ZdEO
         djjWGkIe9TQfNArCNwaDQSzEK2DhQHaGEy7qIZqN9Yf2ibkx3jFgQcuLFCEOTZD/cfSI
         8GQC07RRQnBFEWEqtPi/zxLmO0GbvgT+if54SKdS50NbXZ5FNqLniKAOuG75X0esoOIP
         maDV9Jg6AQul8dMw7tKBpsJZ7AzoNLzEKC3NYnctIgzmzFyfz15OmPIy+ob2jt2EC4at
         FOQHtWdbjel7Qqhqzj2mG3iJINrPj9xA1yXuAEgPlPQhntyenYijZJEindY2AnYn3akP
         FdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299926; x=1715904726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+/kjO6igpY5Z9IiOKAmMz8PNt+9Eolw6t7DBSMXgDQ=;
        b=qMpFpxzoOFKBYgypBSjfPdmRwUTcM8CsNC5ccM2Hz0JDV8mrybOEbzRnckmeax814O
         BRQ09JMfiPzbb851WXy8fjbzFyik+7ZlOd8oY2UKNgPzkGi3u40cCCZpWKxxx6dR0FaE
         3aUzM0usoiG4L/0UojBxenhxTSVpRqgOetkHBlS99DQKBZo6H7p7AfO7lEMAb8ad5wHU
         xDTymF5/TSmChvMzX71Zvj0CJjaYzriV6GtvAHwnALwzQf32PETPRji1l1CF8Mdpu4JP
         iVcVrVvD1ZLjEMAXYHkq394A5x2ufgSjOshBo4Bp8CJjUyTno4J/6gPgjtf7CfJmTnQf
         r1aA==
X-Gm-Message-State: AOJu0YwU9yZjBAGKtRyjVbcYAH290Fl6Crzim6UbQzFPbL6DnURjSANU
	mgM8nJJtp6t6JuS65gechWzsH9i3WmSGcaJW8mhQsdCV41EqdMaQ52nLfKxiN4PekcYP5fxgLZt
	oXg==
X-Google-Smtp-Source: AGHT+IFqVJhwpwwqiHXuwXmYYl8rNoTCx5/ixsGah9it9PhH2pp2rnYEYGHSA0lrqROCVxUa7NHIESir2HY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3992:b0:6ea:dfc1:b79 with SMTP id
 d2e1a72fcca58-6f4df42b865mr83743b3a.2.1715299926061; Thu, 09 May 2024
 17:12:06 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:21 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-65-edliaw@google.com>
Subject: [PATCH v4 64/66] selftests/vDSO: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c          | 1 -
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c | 2 --
 tools/testing/selftests/vDSO/vdso_test_correctness.c  | 3 ---
 3 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 96d32fd65b42..fb01e6ffb9a0 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -14,7 +14,6 @@
 #include <time.h>
 #include <sys/auxv.h>
 #include <sys/time.h>
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/syscall.h>
 
diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
index 38d46a8bf7cb..f0adb906c8bd 100644
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -10,8 +10,6 @@
  * Power (32-bit and 64-bit), S390x (32-bit and 64-bit).
  * Might work on other architectures.
  */
-
-#define _GNU_SOURCE
 #include <elf.h>
 #include <err.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index e691a3cf1491..c435b7a5b38d 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -3,9 +3,6 @@
  * ldt_gdt.c - Test cases for LDT and GDT access
  * Copyright (c) 2011-2015 Andrew Lutomirski
  */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <sys/time.h>
 #include <time.h>
-- 
2.45.0.118.g7fe29c98d7-goog


