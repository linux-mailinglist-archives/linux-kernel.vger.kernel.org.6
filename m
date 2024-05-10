Return-Path: <linux-kernel+bounces-175115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2BC8C1AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BA0281189
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A5410788;
	Fri, 10 May 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkjTU/oM"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443348612C
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299800; cv=none; b=NhDIiRw4MFnnxyr24SxW+p5RAKXLRnSz9L7/+HmT29U4e89wiItLA6wMxdz2fCgRBHjQuYBZ0ywVOW8WVjj55GUIZFa8f2dUpCKZ6lQxOUuVxvT8kwGx7oVofvFFIkzc9Dq7J2nbQT03efDM4Gfw5AZovVEZPgrAlbYmH8puaCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299800; c=relaxed/simple;
	bh=NS+QgDPuHwkS/IkUVppos2L/t0CSidNHyGZCykoSTr0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MTu7pard51TybY6oCW94MlaPf/dpJ0Axh4fJSiAgGqcZ/bnVfox+pBZywxTUtc1YJ++n4EGrZ9mfPioq4/x3oDHfRYd4gWEh98X594F2xHo2GHXM5y24wHroXvXdfqfqlSKCKvZeA9+XnP3IUGdXfou+gEg3orKQwTZxg78RXaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kkjTU/oM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f45487858eso1034608b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299799; x=1715904599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6h0yxxJBIGq2jf0OFxRdvAuf0GSm4XtFP+RSMXkmCzo=;
        b=kkjTU/oMzTIc7mJ8xr4qth/mZU3+aOp9onC0D34qbao1Uh3kVh8iMTcDMUIiiGsRWb
         6l8CIxNdRLuKWWEPtkoDKGdoDubagPUAJ45iW5XrKPC4qmgzgzNb29R5tbOSGq8wmj79
         IO7XqGDFwIlJruuGoIQI7Um+Ndpx8Se6L0XjqRNy4BaXFg+pZniFTFXP1U+5XguH3aPn
         HFDpRi2lsjCjHF4v0X08t8cHG87Ej1gYM5ZUufkURLm1qwDexHU51XthXqb65ZKXFBHY
         OgK9Ex9AfuQVNx9382fwCKeaXVrXPBv34DDX6ejtVBO2klzmJTIyGB3VH9rlr931LEmN
         9hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299799; x=1715904599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6h0yxxJBIGq2jf0OFxRdvAuf0GSm4XtFP+RSMXkmCzo=;
        b=iBPAcv6ES2Pc4N7M4xha9Ljsj3l39u0SCqI8lknDHZ225t3xYxYlKm9Bgk9pY0zWgd
         IcnLZkfU/VvJb0CF2CENP4+59QTC6v/7VTG+vPia05c/p53brY8eRHfrDCu4GZ0Knvnd
         qZxIP4QqZ53pkrq/iM8CTcDe6ByCGE88VoaqmqVw5ZxIvNVwzCAE5EdsYrw8EIHbGtER
         wqFkwkSO4KtCeGyKXnahlQG0DjgrU/+6UzQayObyLTYIkDLo1jQmE9ot9uofa2i4W9hY
         bU9EfTcy34NGwIV+qSPNRhvNjV0sUoATED6VxkyaV3W/bA7SfsAjNTBlW1DVh1BebgmY
         r/WA==
X-Gm-Message-State: AOJu0YybmybVfpep6kbLuHipoUSU/t2Hl4/sgzXYPatMFZzaeQmaxQK7
	AUmqRj9TelIYN0mYrGSS6bnBX1WrZxX6IxfS2R0NlPyoJRDptV1QFBy0RWoxw694aD8gw1W7N/g
	nWA==
X-Google-Smtp-Source: AGHT+IG39H4pksU0ri/+4ci/+CMifWOpp212NwWMPxr1jqe+yuMoJVZrhw9Tl2uxP+3cDEXB3PYnzZeCYzw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:1d26:b0:6ed:d215:9c30 with SMTP id
 d2e1a72fcca58-6f4e0415f96mr2708b3a.6.1715299798449; Thu, 09 May 2024 17:09:58
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:36 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-20-edliaw@google.com>
Subject: [PATCH v4 19/66] selftests/futex: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>
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
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 7f3ca5c78df1..8e41f9fe784c 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -16,9 +16,6 @@
  *      2009-Nov-6: futex test adaptation by Darren Hart <dvhart@linux.intel.com>
  *
  *****************************************************************************/
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <limits.h>
 #include <pthread.h>
-- 
2.45.0.118.g7fe29c98d7-goog


