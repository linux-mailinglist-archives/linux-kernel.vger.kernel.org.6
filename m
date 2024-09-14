Return-Path: <linux-kernel+bounces-329227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4154B978EE6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE1F1C22E24
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D1B146585;
	Sat, 14 Sep 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JGhPSGsP"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA7013B7A3
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726299054; cv=none; b=Oilr2lSGX0mWFXFtnuCujHMu0ZFaL9M9PvW5LpKNkfZy/uDTvpM3itPiawV+Q5eGSGaV2TjATK5hfJgwVRmWY2Cf0THi+vc8uOPDWHDnlWvPKqUYU4SdJQLifRJYMz7hztkMnxeXGIgL8F/MP++DZpjo0Y0Kl0dkDQcArXi+JWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726299054; c=relaxed/simple;
	bh=paxtq8DGH1QuphnI3BlUnhiBze44+6OFfkrMCUBsYNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nr0lmpJs1CPPaZUF6ViFbWu6P9PWDbMYXFQzwXZAFwk8LmTy+2dL7RAVFAtpBZEGcCetWopJgLOU4dj0LpcsxBvOc8TaGSRkmbcbmjlEuSJKrvex6EfIqIPTKsENhwMzLAeQhzwIoaNbh0dhLy45eWOJJ1hMn6gFU4zV+jzlQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JGhPSGsP; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so2273209a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726299051; x=1726903851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/2a46OQ5WaS5274HZtlPL6nHGoqHOePxGG4Boyap1o8=;
        b=JGhPSGsPX5Qk6Imt41A12XCdWBy+ESkbovQpEEssrMHOTvBd6rY6LVNYrwwAx3jb4e
         eIzXcZKDE/lquLYgoIq3fNyIMME7+lBqF+yyDWLodSage/MmQQPbBAXIm4pzV/ZPD1yb
         OeYdIyrJg2pNwh4Qr7hYLUQMuRXpRcxuTQm6gHKQvEvkKllP6HCIhgo2ZcgoDGlGNeE/
         kTKzB/JI60WnDwBvSUV1zCOWlCSzEKCr3m4NdI7vXJOuw5apn9Yb4Fl5mazIL1GZswEe
         hPFHsn5U3+dgtj3jXHU0o6JVVUs0U8q+sW5S6MTPRa8hhCnsJ7sd3OvCmgZNVLpMRRZb
         MnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726299051; x=1726903851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2a46OQ5WaS5274HZtlPL6nHGoqHOePxGG4Boyap1o8=;
        b=MBVAp0fAgNtz0Qw7jTgWU+WwX6n8Ws2bIntfZGpRNJZxA93OaWOyNXU7vr6/q11FLG
         aPmuukfEH+8cpPe091eMfd0QWIdCPiEqejlKudQx/s0KvNw2g7HWnWNMWO2TjGlyC9r6
         FU8tlWxHLXmBahKm+Sx8QmgFldSgEmWKPUhwUB2nZGA3N4bNEVJUTzpQWvFB+s8J6vIm
         5qYg3RIpZsIOzADGKOoxCRstxNN3IZhOfNFedAWsy+XS9mSK+KS71Set3z6ChFaXGuR+
         EuhHC4B0rg05RQWIZqcbNKVsCvpwnf47ZMucQBnBneo1rkEPBvvgg1t3HMRG45S3SQI/
         sFwA==
X-Forwarded-Encrypted: i=1; AJvYcCUdyA1N3Zs7b4l+le4vbm6LgBS//VLdZgCK+R9YBgl3IsHxfnVDT0s/ESsBmsJz8+wl5HGCzM2WLvdgTE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZM4q8/UNBPGuWSPemGHnGYliJmKvbOGrzp86wNy9JINbjJGZH
	2A82fxKoRrKB8Lr99wF1Cc3ich1ASakmWdWSqD8zlcaHG1CLjhCmAI68Yu2G48gpwv9i2uHgLVn
	Utcc=
X-Google-Smtp-Source: AGHT+IGaqFo9ChX70Ea5mL7gUNEzX04dCGW52S5KwDopHouW0juPkOoymuCAu/hO1wv1BIbgmO427w==
X-Received: by 2002:a05:6a21:4d8a:b0:1cf:2218:1be6 with SMTP id adf61e73a8af0-1cf764b02aemr12874259637.50.1726299051497;
        Sat, 14 Sep 2024 00:30:51 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b9ac05sm555687b3a.155.2024.09.14.00.30.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Sep 2024 00:30:50 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/3] Fix some starvation problems in block layer
Date: Sat, 14 Sep 2024 15:28:41 +0800
Message-Id: <20240914072844.18150-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We encounter a problem on our servers where hundreds of UNINTERRUPTED
processes are all waiting in the WBT wait queue. And the IO hung detector
logged so many messages about "blocked for more than 122 seconds". The
call trace is as follows:

    Call Trace:
        __schedule+0x959/0xee0
        schedule+0x40/0xb0
        io_schedule+0x12/0x40
        rq_qos_wait+0xaf/0x140
        wbt_wait+0x92/0xc0
        __rq_qos_throttle+0x20/0x30
        blk_mq_make_request+0x12a/0x5c0
        generic_make_request_nocheck+0x172/0x3f0
        submit_bio+0x42/0x1c0
        ...

The WBT module is used to throttle buffered writeback, which will block
any buffered writeback IO request until the previous inflight IOs have
been completed. So I checked the inflight IO counter. That was one meaning
one IO request was submitted to the downstream interface like block core
layer or device driver (virtio_blk driver in our case). We need to figure
out why the inflight IO is not completed in time. I confirmed that all
the virtio ring buffers of virtio_blk are empty and the hardware dispatch
list had one IO request, so the root cause is not related to the block
device or the virtio_blk driver since the driver has never received that
IO request.

We know that block core layer could submit IO requests to the driver
through kworker (the callback function is blk_mq_run_work_fn). I thought
maybe the kworker was blocked by some other resources causing the callback
to not be evoked in time. So I checked all the kworkers and workqueues and
confirmed there was no pending work on any kworker or workqueue.

Integrate all the investigation information, the problem should be in the
block core layer missing a chance to submit that IO request. After
some investigation of code, I found some scenarios which could cause the
problem.

Changes in v3:
  - Collect RB tag from Ming Lei.
  - Adjust text to fit maximum 74 chars per line from Jens Axboe.

Changes in v2:
  - Collect RB tag from Ming Lei.
  - Use barrier-less approach to fix QUEUE_FLAG_QUIESCED ordering problem
    suggested by Ming Lei.
  - Apply new approach to fix BLK_MQ_S_STOPPED ordering for easier
    maintenance.
  - Add Fixes tag to each patch.

Muchun Song (3):
  block: fix missing dispatching request when queue is started or
    unquiesced
  block: fix ordering between checking QUEUE_FLAG_QUIESCED and adding
    requests
  block: fix ordering between checking BLK_MQ_S_STOPPED and adding
    requests

 block/blk-mq.c | 55 ++++++++++++++++++++++++++++++++++++++------------
 block/blk-mq.h | 13 ++++++++++++
 2 files changed, 55 insertions(+), 13 deletions(-)

-- 
2.20.1


