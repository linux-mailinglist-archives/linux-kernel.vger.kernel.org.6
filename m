Return-Path: <linux-kernel+bounces-198011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B217C8D71FD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 23:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366062820A1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 21:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481132374E;
	Sat,  1 Jun 2024 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="TLwXvDBd"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C347B1CD2F
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717277613; cv=none; b=WzbCyVDmN77Z81KIghEF3xwEDGnKS6zbExIGQbe8iX+W8exTR1RzbtcBa5eA8UPz2V7Kn2E1cVYbQHNk/sqN8QJ0nGiyKuvriV8NrCb9hCrjNJDzjarY6IoXf/7fJwMeSzswIGxWJXgkKJx8WgOGvD2XP6f+TVau5l5x0WtiFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717277613; c=relaxed/simple;
	bh=3sBwYo/AqZ+0RfDJFg+GCK+aWleW3pxMfuHyAah0dzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m30IDPOeF+WiSOEz69hpm6ui9p+IGho5O1ZZ1MJ6GMjxl6GJyLgz544Dm7AJ7mK9u2dp3e1aCOSEssZgpb5hGPt5j+6D+GVb+09kRdyGAw4NdIqt+lMzQZJPBp2AeVhqEhPFr1phbMmA9zxP0qfaRI2gKTsi4Kfer4tX2UJ+/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=TLwXvDBd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-421396e3918so1254105e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717277610; x=1717882410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJt3Ya3JYlNDKcCqPU+4dBowkDesFTehUTcWLYXANYk=;
        b=TLwXvDBd2KibpGurTDNi0sS+F1f2zelbruqHlBywSWqKU0TBnjVDV2I9he92JaYU+J
         wkztfGH/CioZVK4nKw0NVukUyatKtpyj/Qw9a7+0w6AOW61OOyUmKQQK/YDiWuohdgj1
         7hq0QEZu++TL9htN8+fffSxcA1BTQRsNaE9fv082V56CEc+wTYar/pfjMOhwxek2VFGc
         HqkJRulNSTqpx5rfrUIglt6di5bT2mYLGJr/3yYSZMybL0C/13lEHP5uOSiipbdXvaAL
         /d0ROzAFVNH7iXSpNoOgKPIn1MbQtYIMiooXq6730LwBebTl3KzTYl6xueNsTXl4Bx0S
         JVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717277610; x=1717882410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJt3Ya3JYlNDKcCqPU+4dBowkDesFTehUTcWLYXANYk=;
        b=b4WYnEPSh2eUn55wtc9LZoeJL+DcXnGB0kgpnuLKn1z2fcWQp9yLD3L34IAwvm0l2l
         J3zQwj1Rs64XViUXn+IXeCjm7r1ZelGmuCBKe9V7bqCb+jgT5G33fmLFVaAdrqa7n7w4
         H5k78y+Lhtq2egCbEaRprNvhhSxYVLPGM3h0H9rY1nY69ciIufX6PgYQCaF4+pnRF30V
         mJ5xs6ynTYy+h57kpcWER4jU38pgyZFLUc+yHjNIiTTgqKCM0URM85TsCz+iyORZuemx
         weVdRWsJT5/vml6XBPsMpIrItM9Czy3/g+qwop0vkuQTpJBs4JHd8Y6/WrFo/UPPS5Q3
         JuCA==
X-Forwarded-Encrypted: i=1; AJvYcCVP+vPRJhS2DP1AbOevarraQzUlfOHwMNhGiv7FrN6Q5qxmKjPIhnYYdzn7KpFgDIFYkIFH+ILM6TnZDlGUNIE/20OU/bFqhAhDsTFv
X-Gm-Message-State: AOJu0YzYbUelwbVijIw3qQ7essbi12RfeOm/GQ4sMCWTPsacjUPNDByZ
	84GUNHP0SsV9R4P/nUvXfo7jJAj5IT+fuR7oPbESQLnHdD+YalHscUFsLAbOrLw=
X-Google-Smtp-Source: AGHT+IGl9Hl1b8VRJQpVpXl7hCsSBOPLOHgRsVLux3bAWL4Geb2ApKKwM1lVHyceYADVoADXs17YOw==
X-Received: by 2002:adf:e80f:0:b0:354:f724:6419 with SMTP id ffacd0b85a97d-35e0f25509fmr4554299f8f.8.1717277609843;
        Sat, 01 Jun 2024 14:33:29 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0839sm4751324f8f.23.2024.06.01.14.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 14:33:29 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Clean up usage of rt_task()
Date: Sat,  1 Jun 2024 22:33:07 +0100
Message-Id: <20240601213309.1262206-1-qyousef@layalina.io>
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

No functional changes intended in patch 1. Patch 2 cleans up the return type as
suggested by Steve.

Changes since v3:

	* Make sure the 'new' bool functions return true/false instead of 1/0.
	* Drop patch 2 about hrtimer usage of realtime_task() as ongoing
	  discussion on v1 indicates its scope outside of this simple cleanup.

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
v3 discussion: https://lore.kernel.org/lkml/20240527234508.1062360-1-qyousef@layalina.io/

Qais Yousef (2):
  sched/rt: Clean up usage of rt_task()
  sched/rt, dl: Convert functions to return bool

 fs/bcachefs/six.c                 |  2 +-
 fs/select.c                       |  2 +-
 include/linux/ioprio.h            |  2 +-
 include/linux/sched/deadline.h    | 14 +++++++------
 include/linux/sched/prio.h        |  1 +
 include/linux/sched/rt.h          | 35 ++++++++++++++++++++++++++-----
 kernel/locking/rtmutex.c          |  4 ++--
 kernel/locking/rwsem.c            |  4 ++--
 kernel/locking/ww_mutex.h         |  2 +-
 kernel/sched/core.c               |  4 ++--
 kernel/sched/syscalls.c           |  2 +-
 kernel/time/hrtimer.c             |  6 +++---
 kernel/trace/trace_sched_wakeup.c |  2 +-
 mm/page-writeback.c               |  4 ++--
 mm/page_alloc.c                   |  2 +-
 15 files changed, 57 insertions(+), 29 deletions(-)

-- 
2.34.1


