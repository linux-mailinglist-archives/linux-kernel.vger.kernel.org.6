Return-Path: <linux-kernel+bounces-175104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C2D8C1A70
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775601C21FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AD6481CE;
	Fri, 10 May 2024 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4YHOHhb7"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115445979
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299773; cv=none; b=BTJnQcB+GLL4kUuApLTFXzxtS27IN3Pw1yzlXfsrNMxZvxeUicS7q9cdBg+2u43ByVJgjkf84KVrL68WX1c9OuqcEa+T6j0C7+9OilzI3w0eIGwjZFnyvMYmJlxuYxwWokKr4IwE+ClMjaBk5LfqAHZRkf4dptKCYRpLsJMoNO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299773; c=relaxed/simple;
	bh=TsIsQdr7UVoy4bxCdw4tMhojSKrH6NIh2l4zBu3z9q0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K/2Nf5pgFBcYTaCOIqwMlSF5TjPxr2TKW0nqLVLc2FZHVUIxKhIS1f0Y8jm7wnJWaPElWJrDLoejPXdGehkU37zYbG2xxagnG4tG2lffWoaEcRL59ZJt1M6nvS/ZFzG2bPLhRQs7nvPzf8D/QjeMGCrHo5zfnRa3Jy7fCZZAU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4YHOHhb7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so26538747b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299771; x=1715904571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ryQJTviHp0IGCXbDhH7pUWkG12d3AaS6WDLra+PaznQ=;
        b=4YHOHhb7NWjFIfOFofCOKXQKqVCkkO2IC4krTiX40xRfniUA5svPgvUDrt+npRv7Y+
         kkpTcGOUhPwAGmCCq+sxwCXb7H6cbs9TV2Y2Lhry5TZpJrJZ1XpF77hyIyoHX0XRKdDc
         oNv+7WYV7EQgdQXx8P/+ABG39f9T5m7KffRK4V2rNb2QKSaFTYYJB9A1evW9Z9Ecj5FC
         ngJr72wsBfPm6Qo7NTlzLBkCBE/+B1ndukTS5O2jMJtRAv/BsL9vHhL84xDTNve4daMk
         Zm5Eh0ryOtPjRzK1RKOc3w6vGUYlhMUQTr5ZVhxBE6t8CiJDg9FD91MhQarnzSE9KX+Z
         4p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299771; x=1715904571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryQJTviHp0IGCXbDhH7pUWkG12d3AaS6WDLra+PaznQ=;
        b=YWDHhlsXPqNUl89FLJ9kdnC9oznVfBhP64RaqvBcUUfSxeJ4VQkuefINTyaF+oT5Rn
         5Nk1/ZUgpSPA9KBpypgBSJUwW0RvINWGmIYGRbjqeJneTHzCPh/ed+2aMsnuQ073Irnf
         R21a51o0od6289MMi5Clm/Bxru7gElj/cVLGxR1feykRMSQyKxamdqCb+6m1j1dG7V8B
         7oLx9oO/BmjumtyF8VcG8xfw2vkSyNIwcfud4W/YedbH2mAyKd4sXsi/slWZW5/MMLWl
         Pz72CZdYiUujI2J8wi1+3jV+hJPx16QYNyxSNyfB+UiPE9rTCBeSQRCZStMy29CdNPWX
         VLWg==
X-Gm-Message-State: AOJu0YzrS9PG7TFVK77m9cxVPNZEzJEG0TNQkgBNwEJwO8mps3KhoSVM
	lSWo+9qxHdKa2gXBVYUpVncHGYpnQk6QJInJUCvt+1epEOedYApZjptgeT7inck+J+Sgxd44vzh
	+xQ==
X-Google-Smtp-Source: AGHT+IF91iKdotUjwmFTJdv3hHy+ZWcgNpEXa3QGcsFOHdNTuSebKSYhR/TL6dX2vV5PjHVT+dvJb7v+gsc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6c87:b0:61b:e15c:2b84 with SMTP id
 00721157ae682-622afff942fmr3115277b3.6.1715299771144; Thu, 09 May 2024
 17:09:31 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:25 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-9-edliaw@google.com>
Subject: [PATCH v4 08/66] selftests/cgroup: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c        | 3 ---
 tools/testing/selftests/cgroup/test_core.c          | 2 --
 tools/testing/selftests/cgroup/test_cpu.c           | 2 --
 tools/testing/selftests/cgroup/test_hugetlb_memcg.c | 2 --
 tools/testing/selftests/cgroup/test_kmem.c          | 2 --
 tools/testing/selftests/cgroup/test_memcontrol.c    | 2 --
 tools/testing/selftests/cgroup/test_zswap.c         | 2 --
 7 files changed, 15 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 432db923bced..ce16a50ecff8 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -1,7 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/limits.h>
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index a5672a91d273..de8baad46022 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <linux/limits.h>
 #include <linux/sched.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index dad2ed82f3ef..5a4a314f6af7 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <linux/limits.h>
 #include <sys/sysinfo.h>
 #include <sys/wait.h>
diff --git a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
index 856f9508ea56..80d05d50a42d 100644
--- a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
+++ b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <linux/limits.h>
 #include <sys/mman.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 96693d8772be..2e453ac50c0d 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <linux/limits.h>
 #include <fcntl.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 41ae8047b889..c871630d62a3 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define _GNU_SOURCE
-
 #include <linux/limits.h>
 #include <linux/oom.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 190096017f80..cfaa94e0a175 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <linux/limits.h>
 #include <unistd.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


