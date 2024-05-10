Return-Path: <linux-kernel+bounces-175146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A437B8C1B49
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F87289AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11A213CF87;
	Fri, 10 May 2024 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3O2IGWl"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CAA13C9AA
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299891; cv=none; b=qev481Je9uE00Kvh7tB8mujCxvYcKpmRIvvo4Idze70vax9XQjh3qpwzTqor1/OwXsKZbdyctP/Ggkvg6wd2VmRx2WUGxpSsomnbK9/UyB288ApgRO+vUpMIQ6qs30hrmgL20b1GDrOB8TpvOdFIPQ7srMq+GN5tfRRPA4T+Ly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299891; c=relaxed/simple;
	bh=IBU/NuSGvQtjM8xGos15Pkr68BKEzjA0BEJAs909nTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T/2NX7gK7XNpN3i4c7i7C7FZjER9VbdiydneUg1gvwd/bm0G4rNo4/alp7pqpxiTO/jwONxnOZEb5fGI/0oYOtzK9kVduiQz74sw+iFTMe7c12GjMGbeCbG9j78lcZdjjroTUO5PF86qyHmAf4tbDwSe8+zGD6NnAmfneP4mt3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3O2IGWl; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ee128aa957so1490006b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299888; x=1715904688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LuB3m194wkKvY0eVyf5M25YoLPjrODu7ClV5j+qOpls=;
        b=n3O2IGWl9Zq/A9XSyxaDukijDRxz4BJN8dyJcfqn/PgAuljQ6MlIQg6efMlRXmQLmH
         Ah/YGdfxBXT0GSBU80V9nlhmftG/eMTKYhWhoAbriXxWU16AsIWTzlHu2+0ewttgStuq
         QDCuRM4jd6VY5+UZ0RhfyBNYp5YmDlCg5SW0Ckkx5G4y0fUal5J2JlVcoP3gDCuWwkec
         BIMyzRhmVDktvY7dMorKjN2AuXyrctG5AI19OaH4ElKSuZHmQ7wWg9H4hL29JGibQI1k
         gUFLvJBRLUULeR8burOiKNGTX91qulll2X/xGwt0HO1d2t1q/Uxu/qvVatbq1SFt+gwx
         wbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299888; x=1715904688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuB3m194wkKvY0eVyf5M25YoLPjrODu7ClV5j+qOpls=;
        b=LlEcGfZ029m1zdpkyjZqPsK+nD/vjfUWLAYJJSoYnpXZAHuBHrBVc/irQD5oECf72+
         +AfVI4X7Ua9n0D9GWqKoqhpqEgnFag9uG9X3p4Jd0V8lgJGJEHwkZBW6+T+N37sUnqtf
         SGoGaJYLKoP28C1gVfzaba8PZGKZhr87AoX2vOmAQhXyYPsgCpZlCrgt0s8UOOPflFCv
         6RR5fuZXkiNiScuDzX/QoOP5lEr1qgkzx/R1LWf/n3t6ZFQyYdSd/WFOjIriYalfhYth
         G0Ji/1X8jnJkIx4CldLmAvnE1/3np9GYIIuQa1P/t50LtYeSYbJvrRcUnJ/ISEi6YP/t
         ujUw==
X-Gm-Message-State: AOJu0YxqOk37q41SnCceeOHFcIaJxMCrSZQ3z0EV4EzR9Rl7K+s9mZO8
	wvQwtlxRiGeY8U0q7ikoJuQbrL1K5i98+EIeTdhGaumWLvkreatn0vikQMkBaKMdHw4oEsGsfaw
	F1g==
X-Google-Smtp-Source: AGHT+IEAPDmiCGGPRhY6JBRoUT6dlR+CkZjrxhOj+xsSstNk+8V5LsggLR8ug+7H1pKBdhGr0v4AK8MG9gc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:17a0:b0:6ec:ee42:b143 with SMTP id
 d2e1a72fcca58-6f4e02ad1f1mr31327b3a.2.1715299888557; Thu, 09 May 2024
 17:11:28 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:06 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-50-edliaw@google.com>
Subject: [PATCH v4 49/66] selftests/riscv: Drop define _GNU_SOURCE
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
 tools/testing/selftests/riscv/hwprobe/cbo.c        | 1 -
 tools/testing/selftests/riscv/hwprobe/which-cpus.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index a40541bb7c7d..4de6f63fc537 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -5,7 +5,6 @@
  * Run with 'taskset -c <cpu-list> cbo' to only execute hwprobe on a
  * subset of cpus, as well as only executing the tests on those cpus.
  */
-#define _GNU_SOURCE
 #include <stdbool.h>
 #include <stdint.h>
 #include <string.h>
diff --git a/tools/testing/selftests/riscv/hwprobe/which-cpus.c b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
index 82c121412dfc..c3f080861c06 100644
--- a/tools/testing/selftests/riscv/hwprobe/which-cpus.c
+++ b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
@@ -5,7 +5,6 @@
  * Test the RISCV_HWPROBE_WHICH_CPUS flag of hwprobe. Also provides a command
  * line interface to get the cpu list for arbitrary hwprobe pairs.
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.45.0.118.g7fe29c98d7-goog


