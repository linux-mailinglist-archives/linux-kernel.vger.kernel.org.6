Return-Path: <linux-kernel+bounces-203974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335128FE271
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3721C239FB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7097E152E00;
	Thu,  6 Jun 2024 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqgY//Cu"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F91527A4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665591; cv=none; b=B7/mnpUH2e3qYfrssMyXzIMkee4mYJ9uMiECGokZDktJdPVs+NpG417BaQrTzLLoFKczT8LvM6E6ZWWXaRgwlvg4yE0pwfN7y/VMPX5oDLtYry84QH9L0VNytSxo/s7AubETPG1YQJAguAd42+lZmSYQfMHuS6O6zxUEBTtbLi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665591; c=relaxed/simple;
	bh=EzWA7J6+Si0GsYhDrB0GB62Cf6i5+4xDtWUlgWkWX6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=luH7nVvMT4g7lliCKKxoMnO/2sz1B18TsfgBjlgITwqFuWHr2WbeyKV0AWDhVi19ErCa1gPdAi1bAUFnTvJ9SPxG6l5EdcAIvu35ejhFuxJhrRt6tdJLUPab1BqHwawoGYQg+NpEwdyDfCEKz/wtpFUSgruvZiu58vAFdRxpkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqgY//Cu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70260814b2dso554939b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717665590; x=1718270390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcXIPNgQrR+DgSrmuymqN3XstidFD7hYTTqhH9jc/cs=;
        b=cqgY//Cuk0S7WgwZ5QzTtSqqqrMB5Rgj4hNZdl5Pm5uf+McIgBZe3I5io8ZA+qJ7/y
         bROjmsmzsv/2hZW/s2CwT2onr7vnFo6DK7nHODgKVHODLs4IJea3tjL+qRHH3Tp1rsV4
         pKRYZczeVZC2AXAaZmblhwoizl6bInGsjAosnBBQ5r4x0WYJfp7lVgLB830H+l7HMoys
         2+V8veU3Whi/QtoqpNZIxxHvez9nXXMyEZHifDKvTOr+QlWPubvWoE3egnWjF9xNxEkq
         d2qeXagnPavCdc1x5jgnxsSHXemfOsYXAaCAIDqvWJws8pEPk62ER3ztw7DdMO6lPYel
         hekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717665590; x=1718270390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcXIPNgQrR+DgSrmuymqN3XstidFD7hYTTqhH9jc/cs=;
        b=Y/GWx+hLiiaaZZnhxf90ms0V/Splm13SU+UDGLyyjOzKmWfvMSXiby0rjSVEfVzbRL
         OADj607TL1aMif17kPwUz+DOcoWI6A0mcMn2Kd8ylKL+y0kzSkSlLoff+yMN5pPBQw9Q
         1N2V1dULKLrWJHB1RlnC/nF9pjFiAZSp51TkulCSoKEHTBEET0PK/s0WqQ1GNQcWoIVY
         1CAYrCcSXIgHdhk+V94u3KsSg23vzcX6c/dwakAqVTqFUbWfWkXuYsHsTC5ZCdWgCtzP
         Ns6Mk/xo61+iccGgMslT2e0k4Dmy/Lp9sAChyn3a+n4SfnZfWmI2FXFEAHj9x783/PU6
         XBcg==
X-Forwarded-Encrypted: i=1; AJvYcCVXueh4RXdhcR1s8gLfphlxphgWqt3yGgSj+2t7G+ztCxuZYzrvFD+pWg9LJhv2xumou7Ab6qVdk6nXaviX2nn+xRBLO8QrNKneQbId
X-Gm-Message-State: AOJu0YzC8wKnYMy7xsBfYAjKp45SvFl0kexpJadhhNQqCHgj6MfjL/Oi
	Uy0+s2DPpiPhYtRp8a/MPVWjjcqj4nFKxUy5ysFIPczTrbowIRkp
X-Google-Smtp-Source: AGHT+IE6vItge6EIOf2KkT1CewcIPxnHEa3MD+88q4PYxlbZpxsL6BYG31xISWNOSxIAb+RtJTQ3AA==
X-Received: by 2002:a05:6a00:1992:b0:6f8:c94f:578a with SMTP id d2e1a72fcca58-703f8875bdfmr3234762b3a.12.1717665589656;
        Thu, 06 Jun 2024 02:19:49 -0700 (PDT)
Received: from localhost (97.64.23.41.16clouds.com. [97.64.23.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd53e0d0sm732983b3a.211.2024.06.06.02.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:19:49 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Wenchao Hao <haowenchao22@gmail.com>
Subject: [PATCH] sched: Remove header files which are included more than once
Date: Thu,  6 Jun 2024 17:19:23 +0800
Message-Id: <20240606091923.3512950-1-haowenchao22@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following warning is reported, so remove these duplicated header
including:

./kernel/sched/core.c: stats.h is included more than once.

This is just a clean code, no logic changed.

Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
---
 kernel/sched/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..8e93fdbfeff4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -90,7 +90,6 @@
 #include "autogroup.h"
 #include "pelt.h"
 #include "smp.h"
-#include "stats.h"
 
 #include "../workqueue_internal.h"
 #include "../../io_uring/io-wq.h"
-- 
2.38.1


