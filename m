Return-Path: <linux-kernel+bounces-185595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167618CB75D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7105281EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C50E1474C7;
	Wed, 22 May 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdTClnEu"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803D0146D62
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339629; cv=none; b=lRhm1n8cY6Y3Tigvr016G6/pHoC53qjiCfsZRNZumVLqke4m8MU/d9LRYRZkHCmFHG0EnADWDWpdqjelP2tSHyHACGmM9FL5Isfv5ZMBL7XKk2MTzAMw5pfXjB+rRJr2TpIuIJgM1lS4ZZOdNlNsIwWDNF8dmChxGR57AtAIYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339629; c=relaxed/simple;
	bh=Ct0Oc2HtbbTeGYqwAwT54uZjMuIOV6TtzJ5jkv+HoWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T4sGZfLwh627ltoSKnIaukHWLDs0+KFdlxxXwcsoJ/wnal/WTEWWAVAEdhU/tys5/wRcb+O/MYmxWfA43yK+3/NVzRZWp4n9A9T4VxdfvWLO4WZ3/SGGYQXlCWk41Chii2xJHJMp3JrBbc8Pg7rjJvozzVaYllzAQ7HbpUerd08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdTClnEu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6576ea645caso5097968a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339628; x=1716944428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DziTrN+GdHrDDu0b2xCQRkg6aq3Bg4PfuS8x+kzAAOY=;
        b=QdTClnEuyELh6FWkQAfDZZSZCUt2LwbD+85+I46Md6zshsoFN/5Nh11VnXpc1d7abX
         Hhl5n3SngENyFPSVA8Sjcl9p91ZVPiK1PPUN9Gr0p9v2sVyF7OqOGC9Kk0Fm57L9v58M
         3zXRm+6EgCy1gZNR1txWqnVqwAFKo94/FspUA3J+zM5On0o44lZT2FvHiVOf+MzJGZQz
         ZWgffbCTW8tOyWxQDEDc8OBjVXYcxbF58Ib0QV5zzWLoVFBbv4dDd0J4cQpeGo+j6Bx5
         DCSuSHssE7b/zbJLTQldORfYH1tNM+iOw9MKyOcabEPMRfj9qYIkFUsV0MsJcoKvz+ja
         9YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339628; x=1716944428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DziTrN+GdHrDDu0b2xCQRkg6aq3Bg4PfuS8x+kzAAOY=;
        b=Eo2gSws1OtFlhZnhjKjGXyA0s0H1Av5q/E3LCnQXq1Bg3I11WKKI2EukSFE9ugA1ol
         Y97ILsCNA2RcfOYpo9S73xNE0ZS+pfoIHVH1abY5OVlnwyf+3ePiewwvCAsH3iU2xqpv
         ghcd1qxFrkCdiRNtiLroQqIKWgI1lW/By4wmf6AHSct/asyZdOITHyUBzCoZmC20hkBG
         9vPWBNR0l6xLn321KWEY9hdSF7EyT4AuvtK6b3ls7rdaiBTkKVte/1vzrs4AEEizFjzS
         pFk3Twgo9vuq0hj7rchcEhoTiKg/1/1jDcWBCvIkGwvHgxm4On1U2fkKmry546eGZ3OS
         wcMw==
X-Gm-Message-State: AOJu0YymWcoVCzQGdbZK90VXp214dRZI2rWOlt9CIhOV5ckloiaVRLa+
	tCIR+YLE+07JdWUogkhxs4JP7Z6ckGCXNe0FAhPx0h2ZQmeq7dC/LUN1CxRW/Q2dnRMF4UhXCSz
	jIg==
X-Google-Smtp-Source: AGHT+IFgwS5SmrnU+8gmUbVy29pAPQw7ZKiyJ7SJwcCOOTLzFKbZfEl6jzxNvPo3fpwYrrE3JFhJVx4/2uM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:7250:0:b0:645:571c:52b6 with SMTP id
 41be03b00d2f7-6764eb14050mr1133a12.12.1716339627896; Tue, 21 May 2024
 18:00:27 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:06 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-21-edliaw@google.com>
Subject: [PATCH v5 20/68] selftests/futex: Drop define _GNU_SOURCE
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
2.45.1.288.g0e0cd299f1-goog


