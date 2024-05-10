Return-Path: <linux-kernel+bounces-175101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256798C1A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF91F1F229F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD6E2D05D;
	Fri, 10 May 2024 00:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pITzxVD3"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E72581
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299766; cv=none; b=ta1qIcfgBbzvR6Dn2owZjLQ5OIp2FcOsNeigwdVKMSjospysTS+sN0wO3xT48jZcfiVzeafr8vR5Aza6uzc8qoH4P4KNAi1dGqULVU5zhBuJ5sb0AorsdVakYc37V4myk9HDNJY3BT9mbxJaeRHqDKEUCA8vl04F7iAJh4Jt3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299766; c=relaxed/simple;
	bh=k2mxng2RX5GUHfGf5TqA107hGVgyxKKMveycAQ4p3io=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OY/XtRMGe7nBnM+OCLCrdKPX+OCI3g1mtoYagu9jb3l5ernCcE2QB4+tpOe23FwbzIzXnKwnvJ/+u5Za/+D9NNHFkMREyQFE95pIwc3xZ+G5sPuM4QbnKGMJxNJ88l5xM7XsQXgIlEzrxURFeYPAP44BNQ++GvGYgaxYjKKwdk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pITzxVD3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f49fc7b5e6so1545567b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299763; x=1715904563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5hVF24XSWQsJ+4cb95KYVo5LMwPzJ3133L9BIUCMMM=;
        b=pITzxVD3C7TrrraHAZZ29bi7mELrKMSAIrWUdW1s2See/thmVNqx8Eaf+0RbEX+JMZ
         UJGUDIJl1ZXGva6chhZudIlEMWeypdaunZkcLJ3SHESUlw4cV7Vo6A1ElqoM7pv7h/DZ
         N/HsnB1KyTvDGl2tVLfN0EqERtyxHOJYkEDz0mrftGfiQJM7/bapf4HDNRrwVN1nrcz1
         qaIZ4+DXIVt+M4iX3RDGVWCnY7Xbu7CZOXrQcaCCxgpNi4ZGyE/HaeG8/+3p+yH4Hpmr
         x1/nEFKB7L3OgGuwJvGcLgM4Cfj8CrmOE02zs65TmuotWvGTk6stEwhlSKf6Uiwvo9IW
         VNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299763; x=1715904563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5hVF24XSWQsJ+4cb95KYVo5LMwPzJ3133L9BIUCMMM=;
        b=JkOLSXzZBWcqKlrHzKpFBwitu6xphXEl9uGgE968HW/+DXimxwTthHx/BgVaynmf5I
         3d7LkfCirbm8FmyC5THZEyz2I7Huf77YmKekONDhaupiZASPMW0149iX1fE52PiO09DQ
         Jb9LmfE5vE3bFzECw+Rh8x8XcisvipUM6Ktipsc1QunY02aKwo/MggIWRDuC/A8u+BgN
         jtqcDMdv+p9YNFxFwNQFNZAywv/mFY79/l9L4de9ZbHa+X9vVM9NuHpbgoon3DlxDhsz
         +AdmyVM+hy8Uyrbeke9jLs3JkSW7W/S2j6hwdrJDXmfzzMhzqvI4AKC9NgRi13IwyfQq
         E5cQ==
X-Gm-Message-State: AOJu0Yz+aag0F0yTcioJvAGJA0X3XOO5jAtLVjSy0qudzxJrko3tf+Sn
	6c21oR7eiH+bmEurK47l3QLvqlrhFEPpKMT/OZWPfZt+06IrZoE1qhRX8t2z19b2jTrdaPbinYa
	FtA==
X-Google-Smtp-Source: AGHT+IEoI8M57361krHh5PkKsd9cif4/fJudIIqhtt6uxwIPL0mJF3ug6wUz8Vwy6IK0xIyS4kuYOOUid4o=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:a91:b0:6f4:d079:bb24 with SMTP id
 d2e1a72fcca58-6f4e0296acamr50019b3a.1.1715299763075; Thu, 09 May 2024
 17:09:23 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:22 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-6-edliaw@google.com>
Subject: [PATCH v4 05/66] selftests/breakpoints: Drop define _GNU_SOURCE
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
 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c   | 3 ---
 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index e7041816085a..e5a95187ac12 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -7,9 +7,6 @@
  * Code modified by Pratyush Anand <panand@redhat.com>
  * for testing different byte select for each access size.
  */
-
-#define _GNU_SOURCE
-
 #include <asm/ptrace.h>
 #include <sys/types.h>
 #include <sys/wait.h>
diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index b8703c499d28..695c10893fa4 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -2,9 +2,6 @@
 /*
  * Copyright (C) 2016 Google, Inc.
  */
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.0.118.g7fe29c98d7-goog


