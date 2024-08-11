Return-Path: <linux-kernel+bounces-282202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E494E0CD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9DF1F2176E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64244436C;
	Sun, 11 Aug 2024 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e8XkSEQ0"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A86364BE
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723371578; cv=none; b=hUZet/Cfo/zz26rHqWu881fBo9q9FHGARGTu+DjrhjS2GJy+hp3QStUpG55ROQaq1NrVlo2ujwWO9gspJBvXU1BV6nuWWcyZI/cIvbeqLg3mOKL5N/+kWjdM+TaR74zH/M+vL6MgjpBOYotz2tfOM4XmZw2PBc/QH8C45hfuufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723371578; c=relaxed/simple;
	bh=v5jSDFfK2NHEbMWosQWn6G/sglvlKQQhmlLCRg1Qa+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Poqnc77MW0T/ESWSmMguuEAklATz/L08t87hUieG0JqvYRTCkyqb1k2YcEpyhiKzqRRvnA9rGHeK/XESEG2RB46xK6ivJnbImIxrRaMTGWBl3W71EKS624JiAsJuHkg7yCxCTHN6VA3lfCHMOCeFBRuU0sJoDeCAngXzXjQ3WZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e8XkSEQ0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc566ac769so30712555ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 03:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723371574; x=1723976374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHD6u79EjEv29RNRwjvBd/7eFbzoXwrn3wscnjegDn4=;
        b=e8XkSEQ0qgJnnMxMR9IClm61xMA/aEiPiVpy0ZUrPkbKY55R+rzH7dJ1GFdTuWNY+S
         91HF8kZaGDLEHs9dwEybieO0maTIv1mYbBI2gc/M5XCXZmpIMUaygux1WJmxFBAk0ym6
         yMmeO8UPBhr+9GgQ5K+eXxAl/aobI4fD17bW62RgoOX/BJ1KqcuxxV5VHhn5lR2TMPWc
         sQ2P16F5u8W7djiFDng1m4pE6bCFz2FHe2MkPIfDCcZwaAyD4xl9vuSrd7aHmpFUhTZe
         fcVCx25xSNjLcBNV42wA2ibVteZq/PBlL/xL6fHVd8pEc4y4mP3vwHPRHiL5gfU2M/i3
         tYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723371574; x=1723976374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHD6u79EjEv29RNRwjvBd/7eFbzoXwrn3wscnjegDn4=;
        b=MtLlRVDpTphdQjAzqL9N0XzrXKXD3tAgGnbgJfUjr5rPhw4qX4oRfAihkJN0zjgno1
         S6PwbfRn4qwhqgvg7Nc1K+k1ggrkFH3mdA4p4kKgHIkXFwh6i1eJkUf6ksFydXgACXy3
         nf4gQ7dBN24ecF/cOinfryPKvY14zOKlYeod5psekIMawQc4pGp38EmLkJiqyOy6aGIC
         gIz4QiszMS6eMfR/gmr76E2YG73eFnGoNg6WdugzT0sGqbrAbs96wawUqroArUuJkCT+
         LO7XNsrGhial2rnRJR9rHZVbn5eGcMNwVkTRriWXNB5q306GRYAnPjWB1j5VpMiH30lH
         T0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTrdj/vUvyNssuBns79DX9wf9fjcJhCSWrobi4wZBe8aHAtf303S/TC784+dxQS+/x4X2KoPUCkFFT2JGkmSxD/U5jrVSAwON+Uyxx
X-Gm-Message-State: AOJu0YwHnsekmfmeKGAKFFAhsz12udYqXr29bgD4RVOiNfL8x32XFKuk
	ma5YJbBCm95LQp1MzAU7+rqywiu5f0Bu0+FPpUX3HLBhTOQedEej5XX4TByaLjA=
X-Google-Smtp-Source: AGHT+IGnfFBgy7ehBxC2BcVfMoI1OSpkPsLoKJsbaGtA2u9Fcei/Z4OQpt6ly4oSLVcYPET3eEeJKw==
X-Received: by 2002:a17:902:e747:b0:1f8:44f8:a364 with SMTP id d9443c01a7336-200ae5abed8mr79055675ad.48.1723371573903;
        Sun, 11 Aug 2024 03:19:33 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb48b81sm20992155ad.297.2024.08.11.03.19.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Aug 2024 03:19:33 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/4] Fix some starvation problems
Date: Sun, 11 Aug 2024 18:19:17 +0800
Message-Id: <20240811101921.4031-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We encounter a problem on our servers where there are hundreds of
UNINTERRUPTED processes which are all waiting in the WBT wait queue.
And the IO hung detector logged so many messages about "blocked for
more than 122 seconds". The call trace is as follows:

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

The WBT module is used to throttle buffered writeback, which will
block any buffered writeback IO request until the previous inflight
IOs have been completed. So I checked the inflight IO counter. That
was one meaning one IO request was submitted to the downstream
interface like block core layer or device driver (virtio_blk driver
in our case). We need to figure out why the inflight IO is not
completed in time. I confirmed that all the virtio ring buffers of
virtio_blk are empty, so the root cause is not related to the block
device or the virtio_blk driver since the driver has never received
that IO request.

We know that block core layer could submit IO requests to the driver
through kworker (the callback function is blk_mq_run_work_fn). I
thought maybe the kworker was blocked by some other resources causing
the callback to not be evoked in time. So I checked all the kworkers
and workqueues and confirmed there was no pending work on any kworker
or workqueue.

Integrate all the investigation information, I guess the problem should
be in block core layer missing a chance to submit an IO request. After
some investigation of code, I found some following scenarios which could
cause similar symptoms. I am not sure whether this is the root cause or
not, but maybe it is a reasonable suspect.

Muchun Song (4):
  block: fix request starvation when queue is stopped or quiesced
  block: fix ordering between checking BLK_MQ_S_STOPPED and adding
    requests to hctx->dispatch
  block: fix missing smp_mb in blk_mq_{delay_}run_hw_queues
  block: fix fix ordering between checking QUEUE_FLAG_QUIESCED and
    adding requests to hctx->dispatch

 block/blk-mq.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

-- 
2.20.1


