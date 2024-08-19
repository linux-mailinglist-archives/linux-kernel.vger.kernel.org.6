Return-Path: <linux-kernel+bounces-292408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82735956F15
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01417B2746A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFE812D760;
	Mon, 19 Aug 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="02Qzhtta"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5D13698B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082188; cv=none; b=qPGSrhSHutTlEeOfWAVsv4QN/y6c4eFsvf5skpx4rS4FsAAoaJYDq2HHa8TNhPBpLScYXC9WTjqKHluzo1iSUwPGiCcAFyhS08229tEUJ1EMBcNxtOXRAcwcJRrRd8NhwfmUyERDPIigxNlz2pntzy/Qo2d4ONh9Sfb+K+ietNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082188; c=relaxed/simple;
	bh=OnbR5NNY0OCqotrhIP2Y0BLGGIxSlKF1Pxp5zn4aBgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knNitxdRXvbwhlYGRWSQEt5LYb76/QNxmQitNqh4TBl0dZPBLBajCi7nqfSXD06yC/9mVb0bqmuGAjAgYFSuUIHAqM+EnTfPLzyExQ6abRUzNEDq5jaoaQrKP36YF9UI8Wfbr6o7U6Wc69BBYVCrxvlfAlqc/SmD5fQuAdeRnrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=02Qzhtta; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d445c87788so206445a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724082183; x=1724686983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFr9PgvW3y/gssX+pA9mv3i9EFg1cwN6YvkZkZmVVf0=;
        b=02Qzhtta4ig6YVgjnJ60ACZvgN4e8Ben82Z84h0uGfSXc+oBWpG94V4gIK6GuSKgpE
         ggK9lnST/ocpl36mftQB/PmYLanGEojoadKaORDN8bpO7E7ElRek7GL96HAnozJ8ENU4
         huoQcA76vnn+l0k84ggyTSbtcP5cNk0Cr7xo4EaWZe6RQJ97B/5wLJz2X8WtHWztqMSL
         dtxscrGWzZ03oo0oImbHx6n7A1bOxwhx5NuRtJ4mMPWKYJ9lfTOA2ixBfKw+VvDFGpoB
         4kL2gdLRMv44YvAfe0LHBy18EPr/FHsWPIUl8aU6IDCQ+a6cS3TMk0Nfgi7vg+DRfIoa
         iBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724082183; x=1724686983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFr9PgvW3y/gssX+pA9mv3i9EFg1cwN6YvkZkZmVVf0=;
        b=trPwaXMyIMkKgf5yISiBtxys0Ez5fsVkMMVFT2tEArjTufkkFXvPc85CdZ6gbb0AJ8
         3/sjSioQoC0uvgP81KbTQfESPdYsxpdswhmYrfi58lTtre7HzxPA/YPyR4Ft17rKa+xA
         bgc2GU49SZt5JuyMnIi/8IsjvqsNM2Dj/NFEWj9fsodaQ7FyTLJ1WnaZTb8CXUfeHj2p
         izFUXA7kNIxBptxqHAJ5IZznVI1iLaaT5WJEqGIMOSoc42a/d0adhvEFHWYhfOBAR8ZK
         NdpSTVlvy4msvgtzj60CzS5kFKt+XPNcAyoAC1vlhtf512+AsH4hn8hwZ73AmwAKkwYI
         wBkQ==
X-Gm-Message-State: AOJu0YwCYh1Rvln2lcor7Da3Awn+evoX/wW7346Orde49+rDPIhE3xxo
	OJov7tV9SlRBPkeyUOx8Wang5eAUAe6KKDBv3eoq0lNvAkoRJUeteSkntrL1GWw77YqX5N6GTY3
	P
X-Google-Smtp-Source: AGHT+IFze1ziEKv5WXquuYT84ewiRSJCdHeIgSQtIgSpY7wDp/ttdit8j3Ww40phsGimthCXvByClA==
X-Received: by 2002:a17:90b:1bc2:b0:2c9:36d3:8934 with SMTP id 98e67ed59e1d1-2d3dfc6f340mr7742076a91.1.1724082183246;
        Mon, 19 Aug 2024 08:43:03 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c751f1sm7356041a91.38.2024.08.19.08.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:43:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de
Subject: [PATCHSET v6 0/4] Split iowait into two states
Date: Mon, 19 Aug 2024 09:39:45 -0600
Message-ID: <20240819154259.215504-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v6 of the patchset where the current in_iowait state is split
into two parts:

1) The "task is sleeping waiting on IO", and would like cpufreq goodness
   in terms of sleep and wakeup latencies.
2) The above, and also accounted as such in the iowait stats.

The current ->in_iowait covers both, this series splits it into two types
of state so that each can be controlled seperately.

Patches 1..3 are prep patches, changing the type of
task_struct->nr_iowait and adding helpers to manipulate the iowait counts.

Patch 4 does the actual splitting.

This has been sitting for a while, would be nice to get this queued up
for 6.12. Comments welcome!

 arch/s390/appldata/appldata_base.c |  2 +-
 arch/s390/appldata/appldata_os.c   |  2 +-
 block/blk-cgroup.c                 |  2 +-
 fs/proc/stat.c                     |  2 +-
 include/linux/sched.h              | 10 ++++-
 include/linux/sched/stat.h         |  5 ++-
 kernel/locking/mutex.c             |  4 +-
 kernel/locking/rtmutex_api.c       |  4 +-
 kernel/sched/core.c                | 68 ++++++++++++++++++++++++------
 kernel/sched/cputime.c             |  3 +-
 kernel/sched/sched.h               |  5 ++-
 kernel/time/tick-sched.c           |  6 +--
 12 files changed, 81 insertions(+), 32 deletions(-)

Since v5:
- Make nr_iowait atomic_long_t unconditionally, as 32-bit archs have
  it as a 32-bit type. This avoids the ifdef stuff in sched/core.c.
  Thanks to Zhang Qiao for that suggestion.

-- 
Jens Axboe


