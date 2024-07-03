Return-Path: <linux-kernel+bounces-239195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB89257E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D384F1C25646
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005BB14D42C;
	Wed,  3 Jul 2024 10:07:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA9F13DDA1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001275; cv=none; b=N+UKv3MxVsCIuD/uXt1dILG//Mn+eTADNvXkUYVxXJc59YrCG8ms07RyN5BFURYWV27/2iNhqeY/me6ZZ3uT+2D1E1wVOpRnmVucVVjvXztEAI6PmBuVPgPEw9n8JyTeMd0bOsLBKiKm5tiZJlPFZGPtQDPqMhYIe+WvTFAAaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001275; c=relaxed/simple;
	bh=9DJYjW/ca2L9cBZDJA7xYMtpGPyERgP8agG4YVqMgzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FGx9tehvVLl78ZCJTJuquqlvoHrBcLk5TEE383Aiofq0XWIxyHS8KN8oXU5yNApz5/W3prTeJJ0PWbIrUrcZzZc73d+hK1v5FM/Bi4Khscj5rwP0giUmZM2S7ij56RHvRYkV7vksrINCO8ukiY44YTvE+9dSA9pxKsh844E6iY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A22C9367;
	Wed,  3 Jul 2024 03:08:17 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36FC63F766;
	Wed,  3 Jul 2024 03:07:52 -0700 (PDT)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Move uclamp to each sched_class
Date: Wed,  3 Jul 2024 11:07:46 +0100
Message-Id: <cover.1719999165.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi. I only just started looking at sched_ext a couple of days ago so
feel free to correct me if sched_ext patches have different rules,
different cc's and different mailing lists than normal LKML.

This mini series delegates uclamp operations to each sched_class. The
problem with the current handling of uclamp is that it seems to be a
global thing but it conditions on sched_class->uclamp_enabled anyway, so
it is in fact already kind of sched_class-specific. So, remove
sched_class->uclamp_enabled and just let each class decide what to do.

More importantly, sched_ext no longer unconditionally follows the
existing uclamp implementation, but instead each custom scheduler
decides itself what to do. It can re-use the existing uclamp, ignore
uclamp completely, or have its own uclamp implementation.

Some simple testing with trace_printk() shows uclamp_rq_{inc,dec}() are
called successfully from a sched_ext scheduler:

	[002] d..21  1016.017441: uclamp_rq_dec: sched_ext uclamp dec
	[002] dN.21  1016.017456: uclamp_rq_inc: sched_ext uclamp inc

Hongyan Xia (2):
  sched/uclamp: Delegate uclamp to each sched_class
  sched/ext: Add BPF functions for uclamp inc and dec

 kernel/sched/core.c                      | 14 ++------------
 kernel/sched/ext.c                       | 16 ++++++++++++----
 kernel/sched/fair.c                      |  6 ++----
 kernel/sched/rt.c                        |  7 +++----
 kernel/sched/sched.h                     | 15 +++++++++++----
 tools/sched_ext/include/scx/common.bpf.h |  2 ++
 6 files changed, 32 insertions(+), 28 deletions(-)

-- 
2.34.1


