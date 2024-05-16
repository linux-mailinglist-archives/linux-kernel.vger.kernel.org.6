Return-Path: <linux-kernel+bounces-180532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E7C8C6FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15C91C21F05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB2E4A15;
	Thu, 16 May 2024 00:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwEyg9iM"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2BF2576F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715821040; cv=none; b=e5JxbsKQgK8hOyvVAdODIODFIZyziWa+QWhoEXxvrlvAG5eQdq0BQW3nW1+xYIZFZtQzsv/btxLaBfInq3mYGJcblUInzWaJ7miVDZApjeyOGfmIecDaOcTaKoATGDKL/INM9P2SgY2xcAjTPLN0bcnADDtJ3nHWlD0youAkuZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715821040; c=relaxed/simple;
	bh=qYQXzcLuAV0jvWoVt9msAbI3yKoLxOlg3GEvdiWZ8ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDkPyS/FjZ+ELRiwf8h7xyyteX7NJYdOL/WgMm7huuEDGIheLHt4uKRXwzvOZ6bMjSOopZq7d6BYeRhXq4KEgjzSQxQi3iR5a/e5wDjOM+LkBZTGSNVEZCdL3R/BVMI4/drS5pg0yRPa6eKeccEvTEtRDrIfm+tR+bmPJdy9ftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwEyg9iM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ed96772f92so59596605ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715821038; x=1716425838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gFBgu52DdThoDcp9sgf7YVJ2ynu0qzvCbw71qNmWOA=;
        b=DwEyg9iMY1CYDrxGidYj/4wRnUFeowFIyBEK5Q4/vqKEYZhIvAIr/wu8aWIeoh7SSL
         tRpjJX5C6/LmAPV5tuXla/Uji7yaxNFA++hTRhdGpNAQsWFyf4G1Wez6nQSHrNMnZtmo
         4KDpLJArhjqhOWZ4YeO4zOjXSxk6fT9h/KGYh9gBxyNFYMKPJLVXsft7t9lU8oNYB31n
         VDoE8htwVe9Vg8kKt6knNPoAJv2qkn549gJkphUY6u0U62gzMfRvLeo0ZWWh3s/XMbo9
         LamQXixfGmtTK9ImYcU0kWgNKmEPQrPxhCFi4y/CKxTz8alSFdpHspbaIknodQ1W/NAj
         nEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715821038; x=1716425838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gFBgu52DdThoDcp9sgf7YVJ2ynu0qzvCbw71qNmWOA=;
        b=hgw7nLHFI7j/pOv79Dg/RW3eZ4nhdUlhVywTnUZqw6iYmypBc46UCF15oSkCWyQl3/
         801/0P2DfsmwoBAtfY9qQrc+wC9hs1ze/S0xaY2fhAqH2du1m+VlZKGadUTtFogyePlm
         PaokJ8CVL5oWygkVkMHTn3ve1H8grXvugCj5NZatm94mzN2mOVmTmZAlGzt/nhD7DbTY
         u/QVOxXdwY9NBkUhD+ZorqWZpIbkp6MReSHgoTv0mNoTYE580mfyGWHuTro4xcGb2mSp
         Mt3kJzCjxrsKGrhuZ0MHmcjC5DUyuKr95blHpebxNMC8M6d61r4aUHpQ4YjAsOESrAwG
         4yIQ==
X-Gm-Message-State: AOJu0Yz8Tc1U6TC67dQJKbiJGy1tavjWC8m0LNaNgXRLdmi3FjftXJ9f
	x0QS8yUD3TC77UDaVhMDvmL6bvYfSk/4hs5E7rBulH9TgwAW9ecK
X-Google-Smtp-Source: AGHT+IGqccRvitGCuoH3zcN0NJV93epanPrlEMluwRO5jHAkS58UOhEgCSNDK1BOce6h2uimZ4DyvA==
X-Received: by 2002:a17:903:184:b0:1e4:24bc:426e with SMTP id d9443c01a7336-1ef43d2eac1mr230135795ad.28.1715821038018;
        Wed, 15 May 2024 17:57:18 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad5f30sm125580455ad.64.2024.05.15.17.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 17:57:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 May 2024 14:57:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL FIXED] workqueue: Changes for v6.10
Message-ID: <ZkVZ7PtjmXr3Yrbg@slm.duckdns.org>
References: <ZkU2kmQxdZ3jRfyB@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkU2kmQxdZ3jRfyB@slm.duckdns.org>

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.10

for you to fetch changes up to 51da7f68edae38e81543d57fd71811f7481c0472:

  workqueue: Use "@..." in function comment to describe variable length argument (2024-04-22 10:08:04 -1000)

----------------------------------------------------------------
workqueue: Changes for v6.10

- Work items can now be disabled and enabled, and cancel_work_sync() and
  disable_work() can be called form atomic contexts for BH work items. This
  closes feature gap with tasklet and should allow converting all existing
  tasklet users to BH workqueues.

- Improve pool sharing for unbound workqueues with strict affinity.

- Misc changes including doc updates, improved debug annotations and
  cleanups.

----------------------------------------------------------------
Allen Pais (1):
      workqueue: Introduce enable_and_queue_work() convenience function

Dan Williams (1):
      workqueue: Cleanup subsys attribute registration

Kassey Li (1):
      workqueue: add function in event of workqueue_activate_work

Kemeng Shi (1):
      workqueue: remove unnecessary import and function in wq_monitor.py

Lai Jiangshan (3):
      workqueue: Use INIT_WORK_ONSTACK in workqueue_softirq_dead()
      workqueue: Move attrs->cpumask out of worker_pool's properties when attrs->affn_strict
      workqueue: Use list_last_entry() to get the last idle worker

Tejun Heo (6):
      workqueue: Preserve OFFQ bits in cancel[_sync] paths
      workqueue: Implement disable/enable for (delayed) work items
      workqueue: Remove WORK_OFFQ_CANCELING
      workqueue: Remember whether a work item was on a BH workqueue
      workqueue: Allow cancel_work_sync() and disable_work() from atomic contexts on BH work items
      workqueue: Use "@..." in function comment to describe variable length argument

Zqiang (1):
      workqueue: Add destroy_work_on_stack() in workqueue_softirq_dead()

 include/linux/workqueue.h        |  54 ++++-
 include/trace/events/workqueue.h |   4 +-
 kernel/workqueue.c               | 453 ++++++++++++++++++++++++---------------
 tools/workqueue/wq_monitor.py    |   9 +-
 4 files changed, 327 insertions(+), 193 deletions(-)

-- 
tejun

