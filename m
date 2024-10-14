Return-Path: <linux-kernel+bounces-363700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE899C5C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED191F23CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B44B13DDAA;
	Mon, 14 Oct 2024 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZvdRwl5o"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F4155727
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898361; cv=none; b=OWYeXz66oAWeBQ25MvbSkejk6tUA1g2ictvhZLu5pWcm51KtFgJsJtOnzSQuPSNL/TLgPUYR8ZMeUNWRUpWF73xhY4AjnDxNetPCVCig2Q58jF2KPIi6L6/3Tms+ZtY3IL98BtvpI/AgMni72QDCCnjNlA09RM6oRs+b5xD9U5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898361; c=relaxed/simple;
	bh=paxtq8DGH1QuphnI3BlUnhiBze44+6OFfkrMCUBsYNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U3x4NvUImQRDanpb8yBHR7tnzzU8Rfz50qm5LQ4LUW8ZwvfbW8T2QldIICsdMEnWnFywaENaVTVxXOlqLEPJktsz7FOAFp4q2mOPgoVBt9REnk8WPRgeXuV1LwW58KuBU+PPcLLGfVIB56loFgWgK6qqmicZBtJKs8nat7Ldb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZvdRwl5o; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea784aea63so361131a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728898359; x=1729503159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/2a46OQ5WaS5274HZtlPL6nHGoqHOePxGG4Boyap1o8=;
        b=ZvdRwl5o7BmRELvsR5m1sE/NY/pKsV8dmIQRUKm3UfWaHltUZhyGkAHI39mstUzbqp
         e/H9hWbqEym5UZ2W2b15jGgNhbR3DuxNpSFCa7uUp8gHEMeFy0sbk7IkFhzMdQrOSob0
         zj9n2O0deaoxS9P0ROIOwu7Y8/wzIMp8y7b/Z2R/2HOgjdrfF64d3fCn44D+R+exgowe
         KgYzknAscuJJDMENglrRhL1ALLMbNGUJFmO3eywOc6Po8QozY8TTVQSQ3q5LcvHcsVKF
         4Ac6Y8FwU0KbLBnPJaFH0Q5Xlhor7ppqXpYFLI0Fbr1qfyG8HLHO2hOaXo7l7MqjfrIN
         I9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898359; x=1729503159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2a46OQ5WaS5274HZtlPL6nHGoqHOePxGG4Boyap1o8=;
        b=RUbjEZ1ro77pfjuPfgxFEOsLBwsk2m3li2/l7v+iDAI9QRK5Sv5jM5weUnQP18jXAD
         GaURilSvcxOXXCu7r3Zy1uSsed7iRTNmSAgS/WCbmTGTOUrbltfZQoVTZR7uF8u2QUR6
         gf7Y/PQTwU0njYlxntAWh0MsJkVUHX5yTFKpuCa0y3+U5TzmtGLbUQ09bnS7lxMBXJDB
         cPEmTIwmOlaebEVQIfPWu6P5t2pqYSLCcN3VmWFw4Jz3WTHg9t7H/szxZlHrvcUqEsGv
         InqJKOyZNK2isjIZoX0bubnEC11tEsjatNg2RQXmsm9mL3+zmxrW7ojl3vH55gM22KV4
         EmEA==
X-Forwarded-Encrypted: i=1; AJvYcCW4tQepBVLFjrxC+FaNVfa1ZqAdvEAoLa1ZyX+BfIv9mz1rM0n2f78FXF1DftkisQ071k4T5zfAWZm0TCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu3E5UlCYE/Mlb6yZWLMBxmu+n72+Fh4YN8elTKY6LZyYYXaMK
	cLQGflSFC5ArPh0IduqKmuN9WXnd7ld7c+CkHYfVU5vwBEQ7z3Eq12dDgN4MCDdkzshqHoQ1CyM
	xtGk=
X-Google-Smtp-Source: AGHT+IE3QonfzctOIyuGHOkWcEXy23f9rkntZUePeqmkYtiTJFgr1do91bHAzWnzlxzIr73qa/S40A==
X-Received: by 2002:a05:6a21:a4c1:b0:1d8:aadd:64f2 with SMTP id adf61e73a8af0-1d8bcf449d4mr18377246637.22.1728898359111;
        Mon, 14 Oct 2024 02:32:39 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e60bbec80sm2339338b3a.95.2024.10.14.02.32.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 02:32:38 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RESEND v3 0/3] Fix some starvation problems in block layer
Date: Mon, 14 Oct 2024 17:29:31 +0800
Message-Id: <20241014092934.53630-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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


