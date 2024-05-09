Return-Path: <linux-kernel+bounces-174901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383358C16F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E00B25B2E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FAA145328;
	Thu,  9 May 2024 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5FhxovH"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC96144D0C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285009; cv=none; b=JhYaW/UwVDwTsGmYQfJTt1IhrHuyaBxvCgpGyD/AvILDn1TTK62/61ljic722gKi5wiz7glQcdC0Cc4FO7+NkrwWDdqpa53k33ERdqrnFFmIF7+AF1WOay0bWYdovwBVBhSUfC8XIQsDjzXLms9It5cV0kFQ5A3XRpLX5/5ZU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285009; c=relaxed/simple;
	bh=pheNRGIZ7Jb9gDEOFkz02vcCvP3I894WauR7YBXEH2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cz1BwuZj9ecZlC8qyUagp11DR4vfZ5j3c2HBHD22QA4sPkNXtmO7x+NZKzJdGDk32Gf8GQ+64Sh7hfEMZKMdW1xj7KAAfQ/xOHyWIveW65Q7a/e2kDo28v/Gyq7K5wO4g2kZ0WVC/QgUQRTAeEMBgl6cAS7vJll4NoqVAai8CVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5FhxovH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ed8876c40eso11956645ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285007; x=1715889807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ccXjE517WZwlLlM0behvDO/LOfu8pdZVCqhExHkVOs=;
        b=U5FhxovHOrHSLMzwzl8e+C34z4khiHNqugLm4BuTUbp/vdfySq6qz3gyyc0pPgl+hO
         F9KdflLxmh/c5vHwfiAb/vTsdnP9lqebY836D7ynyqiqeDGqblGiMl68KrP6dgakUOrr
         dto5HMwXxU36qe1zQpxGiQ2yKmvzPeNWnGhu3jbL56nhQ0UOazI69gJb/F7gO/d8YDOo
         YvI1mXwnc7g32oieXO+MYErkomGufdr1bezfGrLGgae2i4nqxLEdwBaOeEzcU5FvDjTc
         Oztc6o4Z/yEGJ9RcMchzOlyUCTB8eZR5Yprtny872l9HIqfc5mLxaX5DaTSN90HxYfh/
         zHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285007; x=1715889807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ccXjE517WZwlLlM0behvDO/LOfu8pdZVCqhExHkVOs=;
        b=R+fa3NiCYPOWcgu4nXRhNAu9cFXQRiUkWFq+wZFknhB7jvkmdF7QQftzHD5+Pw0tWn
         LBs+HAxsZYF8u/KdWJamKP/AAfdSD2MWEL5Swybk+Gsa563ZkgA+GRWo5tyf5hCU9i3V
         0I1POm38k+7EoAyN2DR2IHiNSqlOHF15sa7v/swtpMtw9aa6oXfXikp9c3Y8Kmoa7NpJ
         ttjIrEDbDEShcVAn8EYDRRHBz6RYPBf9VEeJo+LoVIMr2rs3AXoTQPo1HT/hwgFnjnyZ
         +9BmLNnbmFU2Cf4DTGJhNbnNuS/M0KIMGr3D18+SpfebLg3cA+gSZPHcFAnnNWa4VSLo
         lHQA==
X-Gm-Message-State: AOJu0YyJdBu2rTHiW6+EW99M92cf92ewV82K+XC5klz2fJ2ZQB46bmSR
	Ub4prgSwHS/K9BcwajJTJsczyqT0U3CDKJfVGQKA9/w+mEkC3Xh+wsAYS08aL1OJ5ASLXRBtKp7
	L3A==
X-Google-Smtp-Source: AGHT+IEmYCo2fAVcVFzbT06uCl1b7km+bYO6VkBBGQbcdnBxjbxybQ275C+Yl6mrmjNooG8Mn284PxdVRnw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:d482:b0:1ea:b100:df14 with SMTP id
 d9443c01a7336-1ef43f4ca81mr428645ad.8.1715285006518; Thu, 09 May 2024
 13:03:26 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:46 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-55-edliaw@google.com>
Subject: [PATCH v3 54/68] selftests/rseq: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/rseq/basic_percpu_ops_test.c | 1 -
 tools/testing/selftests/rseq/basic_test.c            | 2 --
 tools/testing/selftests/rseq/param_test.c            | 1 -
 tools/testing/selftests/rseq/rseq.c                  | 2 --
 4 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index 2348d2c20d0a..5961c24ee1ae 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: LGPL-2.1
-#define _GNU_SOURCE
 #include <assert.h>
 #include <pthread.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/selftests/rseq/basic_test.c
index 295eea16466f..1fed749b4bd7 100644
--- a/tools/testing/selftests/rseq/basic_test.c
+++ b/tools/testing/selftests/rseq/basic_test.c
@@ -2,8 +2,6 @@
 /*
  * Basic test coverage for critical regions and rseq_current_cpu().
  */
-
-#define _GNU_SOURCE
 #include <assert.h>
 #include <sched.h>
 #include <signal.h>
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 2f37961240ca..48a55d94eb72 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: LGPL-2.1
-#define _GNU_SOURCE
 #include <assert.h>
 #include <linux/membarrier.h>
 #include <pthread.h>
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 96e812bdf8a4..88602889414c 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -14,8 +14,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * Lesser General Public License for more details.
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <sched.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


