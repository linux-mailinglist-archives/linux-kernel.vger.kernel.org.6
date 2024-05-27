Return-Path: <linux-kernel+bounces-191517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A548D109B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E821F22108
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38CD13C674;
	Mon, 27 May 2024 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="zi77ixl2"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C857110A1E
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716853521; cv=none; b=NFwPlFrqQnkwsx8p91/bZLCqrIJ3IUaTZ5/uDXrJaCpttm5fx5qGSGWx/jKfBsIbGBC5WhzsAOhiVxrICBj72T14KitL2KPy7x3pEqCuqrtF2tfVwvD7UWVjuF3WeLcLuvTXjmAvrQ9MPiKeHhl75gMb1FJWUevQ7SMjLrUqgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716853521; c=relaxed/simple;
	bh=ilnFqztr6YvKOP1wiWFQn72ziqayuZkyKp9feAbsV5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ezxU0lQQWfWNjjJc9gqqf6OCmkmdt0lF26T0HEZt4Np79b4jmncJlmr70Jwc2KH0/uN/rNc6SPMKc3u1lDXs/MOH3GJrN/gHoLGZgVCOYaXoDkiq2sQi9QiHP4/cdK/kRvWRCkaDHfHAo7uafcYqFOCQZ9+8vWBEaxgsV5vcQ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=zi77ixl2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-356c4e926a3so164306f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716853517; x=1717458317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRO/CnRPtpBsbl7nBhwPcIaynZHQudWyGgLN4ebnUfQ=;
        b=zi77ixl2RElbuX0WbF4Yz3H/D0XISXLJIh7v0bUM8mDk8K7gUaIlsNk+wG+CeoIc+i
         HZuO8hKnRr7arFfxPo+/KGIq/EJeJ8KJnsIye1XqISfn9SfFo2U+uw/re6ceeHVekQx2
         d/yJsVbBNxatKEZ5ot/gJP5Zncn+bkIQrCUmoc5zTvTNUNq7l0eBEnSHmQPBYVd1VDHw
         3KV+aYaR09ptHGgGvRu6lVw12cecdMdWSFHu2LioFVJwI8WpyQj+v2uadESWA8ySo1Ub
         9Tf/9vfIA8knJto9G2xmoGxBoayMXSrW0c59xAdv2Z7BNTW0xxYxxICnlW2xLMY43N5J
         mXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716853517; x=1717458317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRO/CnRPtpBsbl7nBhwPcIaynZHQudWyGgLN4ebnUfQ=;
        b=xC2SgyEksYF/HCW/w0COeP2ExUSu7iegL97OZ0bKzagV0Tef3Yjz5InxqTwcEGKaPo
         r1E80RJm4hGRzyg05wNWHmHFsv4RxumGlxCfXsfhiyFu1Y3U0DsXmBFxoVliOZCdRG38
         acx/mAOtHxTsgSvD21nSjcS55OngFhqb8/S9ELcE6bm7w4reHfMSJ/OE/1qBQ5ySu27g
         vZrIi+PRiqoJWmDmXStIV/VlmivpXeK6mv/HdeoINux+wLhsif60yumHnWu9JkifNp1V
         hoyYLxpFAMx1Xe5YW1jBG5n+yNEgtq/yueMLBchzumTYo8LSXOdy5I9vwYn29LeJ6AsY
         C/1w==
X-Forwarded-Encrypted: i=1; AJvYcCW4/SbhpG9WqEvmYfLCoC9NBfXmsVSJoOzksVLNcbD6tO7EmGgObyQ8p62NUA9SZyJAmoPogc6siA1ZOOkAwu538PhOqKc+FAU5fqps
X-Gm-Message-State: AOJu0YwiItqFig00YxZksHnbKbyWu7UxTB+mw65B2bf2o7ApQpZDEeKa
	DXHsIW3c3eB3AgwrwDzYV1eR2YMLnpt5gJqPX8ShktOkRjsb0SnHUSp4zE0H9d4=
X-Google-Smtp-Source: AGHT+IH9cpBoOavUU39BKyiX5ZVVtYqsyiD57pc9wsnRSAnUTzf+Xg02xdlAzGi0KOkEJdwOY+claQ==
X-Received: by 2002:a05:600c:6b04:b0:41f:e7ac:cc72 with SMTP id 5b1f17b1804b1-421089f9a09mr75891875e9.40.1716853516966;
        Mon, 27 May 2024 16:45:16 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970967sm123535515e9.17.2024.05.27.16.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 16:45:16 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v3 0/3] Clean up usage of rt_task()
Date: Tue, 28 May 2024 00:45:05 +0100
Message-Id: <20240527234508.1062360-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make rt_task() return true only for RT class and add new realtime_task() to
return true for RT and DL classes to avoid some confusion the old API can
cause.

No functional changes intended in patch 1. Patch 2 changes hrtimer users as
suggested by Sebastian. Patch 3 cleans up the return type as suggested by
Steve.

Changes since v2:

	* Fix one user that should use realtime_task() but remained using
	  rt_task() (Sebastian)
	* New patch to convert all hrtimer users to use realtime_task_policy()
	  (Sebastian)
	* Add a new patch to convert return type to bool (Steve)
	* Rebase on tip/sched/core and handle a conflict with code shuffle to
	  syscalls.c
	* Add Reviewed-by Steve

Changes since v1:

	* Use realtime_task_policy() instead task_has_realtime_policy() (Peter)
	* Improve commit message readability about replace some rt_task()
	  users.

v1 discussion: https://lore.kernel.org/lkml/20240514234112.792989-1-qyousef@layalina.io/
v2 discussion: https://lore.kernel.org/lkml/20240515220536.823145-1-qyousef@layalina.io/

Qais Yousef (3):
  sched/rt: Clean up usage of rt_task()
  hrtimer: Convert realtime_task() to realtime_task_policy()
  sched/rt, dl: Convert functions to return bool

 fs/bcachefs/six.c                 |  2 +-
 fs/select.c                       |  2 +-
 include/linux/ioprio.h            |  2 +-
 include/linux/sched/deadline.h    | 10 ++++++----
 include/linux/sched/prio.h        |  1 +
 include/linux/sched/rt.h          | 31 ++++++++++++++++++++++++++++---
 kernel/locking/rtmutex.c          |  4 ++--
 kernel/locking/rwsem.c            |  4 ++--
 kernel/locking/ww_mutex.h         |  2 +-
 kernel/sched/core.c               |  4 ++--
 kernel/sched/syscalls.c           |  2 +-
 kernel/time/hrtimer.c             |  6 +++---
 kernel/trace/trace_sched_wakeup.c |  2 +-
 mm/page-writeback.c               |  4 ++--
 mm/page_alloc.c                   |  2 +-
 15 files changed, 53 insertions(+), 25 deletions(-)

-- 
2.34.1


