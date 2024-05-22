Return-Path: <linux-kernel+bounces-185618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4223E8CB7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655641C218E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750D2153563;
	Wed, 22 May 2024 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+2OWzkr"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0F1534ED
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339696; cv=none; b=uJa8dMEtBhw13UXFglfFW4SGNlSakAJSVqsfv0JjTwJ8Vs5+dAiOWSFV6YCBslXWshLcKzLYmBCHxqSLIIM8BbFTPtPh3NAsUL3NrwqcHFkfI5NDbNlrqx4167vWESccANZQE9wHighrI3XxIBAuG2D58VlV44vTZFJzXzu3Qbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339696; c=relaxed/simple;
	bh=NAJYxqCPknYhqA3yyvXxPpoo15475nrhk+HBgIL4eTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HRuVmZL5IrifelybRsbgpjPJxWIuPwMK3NRgmzEPB5qfnTmS9PAS0aDpcuNyKw8yE1opcuSttnRonR8AwMCn6QYNp2nNg82HkSc0hyQSu3ZVZXZS7QF0VwTaZqTkL3oBfx0MhLmY7hoCeKzgFcAp3M1po5s8sIOTXTr6NG79qJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+2OWzkr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ee4e9a73a8so138153485ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339695; x=1716944495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pLnRSS+yUn+MQ4n2AryJR9rl6Su/0Qm7BmHquzszBTA=;
        b=j+2OWzkrYb7qnzl2VFhWWKoqSGtWg+SSDqd8E9z3tFReqgB8XCNNHSpU/0Yhqa2Edm
         SxmT4orlD7uqMIAuLlVx720Wjc1eiFfwWdNPM/McqZ90e8eXJic9itJa7iqUWKGtCmi+
         hOk+O1mFqJBaQI/EjX+itAT2DqCbIp688j4SGjsjpIJilwzWAu6y5Y4V+wb7LHtvi5hj
         /sqQ0je9JN0FSOXQHbarrthGjQtza6d0ln+iGlyDwal7fWQQkkLXSfp19aKW2PvwaS+u
         LKxyB/6zpCaHsRahIh6MbFe0MT/cFosnMsHqWBEQpbNhHLLUeYGVsKxUE6+CWxtEuyYk
         PLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339695; x=1716944495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLnRSS+yUn+MQ4n2AryJR9rl6Su/0Qm7BmHquzszBTA=;
        b=MYJf/KmESVZHwkccuFxUyhxtJ5DPAx4AkZneKRJFj5pbnNg9SGABy3+QpY3Q3u5FYm
         AKGNeH8EPyk0lyH+5JQ7YgG3yl3aeV1dIJbptB0ieNY6bRPu4uKnPddYH2GxO/rn2sQE
         GSyo52APHOLppGf+2dcq2x8vza097YU2Rrpsy12vQxCcmI8ffS6krOpiC0QOCZLVtpXY
         usXoBDVQgH6rpJI7VbCcBvMa69WaVfoOnMFxqU6zQ2l2fRy1dLhJrln9itD3K8vUhfoM
         d0jDRcUaU5GsKrOkEfoAIMm6H4CxJFyQNMaRo6aHj0jlSFtB0iAS+xb661mWx9oY6RZB
         R1hA==
X-Gm-Message-State: AOJu0Yyo/Ia4ZTbQfeOU+YaTeDlYiZokP9+MEsrdgXoPAblTUIfjWLEw
	+4GsbkLPVQMxXnJvHhZWcyNWbprcp9IyHOZAyyLEI4fDXr3b3YZkGpQafIppToSD86g6IQMOAym
	5Gw==
X-Google-Smtp-Source: AGHT+IG+8e8TBZZn3utok5/p5VNTf5xnorMVZ83TTS8mYS88H3TfUbRMjUB57+emmSy8pkL4qV3IXFBaRV8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f7cd:b0:1eb:829:b6e3 with SMTP id
 d9443c01a7336-1f31c9672a0mr174615ad.4.1716339694571; Tue, 21 May 2024
 18:01:34 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:28 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-43-edliaw@google.com>
Subject: [PATCH v5 42/68] selftests/pidfd: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/pidfd/pidfd.h             | 1 -
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 2 --
 tools/testing/selftests/pidfd/pidfd_getfd_test.c  | 2 --
 tools/testing/selftests/pidfd/pidfd_open_test.c   | 2 --
 tools/testing/selftests/pidfd/pidfd_poll_test.c   | 2 --
 tools/testing/selftests/pidfd/pidfd_setns_test.c  | 2 --
 tools/testing/selftests/pidfd/pidfd_test.c        | 2 --
 tools/testing/selftests/pidfd/pidfd_wait.c        | 2 --
 8 files changed, 15 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 88d6830ee004..e33177b1aa41 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -3,7 +3,6 @@
 #ifndef __PIDFD_H
 #define __PIDFD_H
 
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index f062a986e382..84135d75ece7 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index cd51d547b751..b6a0e9b3d2f5 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index c62564c264b1..f6735eca1dab 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
index 55d74a50358f..83af8489c88e 100644
--- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
 #include <poll.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 47746b0c6acd..518051f0c3a1 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9faa686f90e4..53cce08a2202 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/types.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index 0dcb8365ddc3..54beba0983f1 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/sched.h>
 #include <linux/types.h>
-- 
2.45.1.288.g0e0cd299f1-goog


