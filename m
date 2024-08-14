Return-Path: <linux-kernel+bounces-286409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF5D951A97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A52E1F22136
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E4F1AED53;
	Wed, 14 Aug 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="H5T/6uG8"
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945A1AED37
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637469; cv=none; b=VygpKAWZd5xyy21FXuW2h0Mfjtvq7iK0yRHiT2n+SrlEuIK3C13BFpxolgJ350DryzE52hcBwLRrzZPhjFEg0vKhx9jwNRb0L63+eNHlV8my45yl9GvTtr5AccjdEtG2oEnvA8vwMaeAmi7HVb3Rbsl7OrRBnJVxhsHasrhrAHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637469; c=relaxed/simple;
	bh=lDa+v/b3ui4BIZ0dCseiQutSd1NwePc39n7jeg10ztk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GaeYv/J0qJiE3AjNrM6yVG0yvpViVy8mrfzMDJgvCqd8bziLPxX+fMJScbeKQ4MbHIu4scYErcZpZoEnj3PVj/BuU51EaaQVO5Yv6ymUspzN+IR3vfjL+Hk7bdsCUXW0GGPgP8dz44tzXD0MP5iR6uLOQM0tSOGb6evlWqs3sG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=H5T/6uG8; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202408141210547010f2d98c70e0d717
        for <linux-kernel@vger.kernel.org>;
        Wed, 14 Aug 2024 14:10:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=gj/TtbceaGYu2XagWF6yfjY7nIb82Llpf/ppwA0ij98=;
 b=H5T/6uG87f46QzC2GHACf0/nSV++C4V7zJA8uL7DuRC62D3wPr8NXND4tQeG9nz72H8wdp
 CMHbXbDwE+ll0NAUQp+yZMTm3hfRE66bmoAJ1f1V4vDTTD74xcVtYqaoyO/OBy2x2tR5EnxR
 fpnzmcia5jjv0gZSjhjBMDoKYzX0+Xw8eDXCcYD+0s7MoML+/HQuDeaLzGi6vj6BWF0xCO6h
 rVMZnn5u+BLWpA4oScr0/NI6VN/epaltcwBZfrFFHAE2C698VeoLEX4e4vW5DDLpCLc4Ns7/
 8w/S4Bg5853y3fgER8lmlegtNX49xMgmDb7uoCUEgsxCsGRSTIdDw12Q==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	qyousef@layalina.io,
	frederic@kernel.org,
	jan.kiszka@siemens.com,
	bigeasy@linutronix.de,
	anna-maria@linutronix.de,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v4 0/1] hrtimer: More fixes for handling of timer slack of rt tasks
Date: Wed, 14 Aug 2024 14:10:31 +0200
Message-Id: <20240814121032.368444-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

This series fixes the (hopefully) last location of an incorrectly
handled timer slack on rt tasks in hrtimer_start_range_ns(), which was
uncovered by a userland change in glibc 2.33. It does so by removing all special
handling of timerslack on RT tasks by instead setting the timerslack to 0 when
switching to an RT scheduling policy.

Changes since v3:

- short circuit on timerslack=0 in select_estimate_accuracy. This avoids
  useless computations
- add explanation to the commit message why we ignore setting the
  timerslack on RT tasks

Changes since v2:

- complete re-design of approach (as proposed by Thomas Gleixner): Instead of
  overwriting the timerslack in the hrtimer setup path, we now set the timerslack
  to 0 when switching to an RT scheduling policy.

Changes since v1:

- drop patch "hrtimer: Document, that PI boosted tasks have no timer slack", as
  this behavior is incorrect and is already adressed in 20240610192018.1567075-1-qyousef@layalina.io
- use task_is_realtime() instead of rt_task()
- fix style of commit message

v1 discussion: https://lore.kernel.org/lkml/20240805124116.21394-1-felix.moessbauer@siemens.com
v2 discussion: https://lore.kernel.org/lkml/20240805140930.29462-1-felix.moessbauer@siemens.com
v3 discussion: https://lore.kernel.org/lkml/20240813072953.209119-1-felix.moessbauer@siemens.com

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (1):
  hrtimer: Use and report correct timerslack values for realtime tasks

 fs/proc/base.c          |  9 +++++----
 fs/select.c             | 11 ++++-------
 kernel/sched/syscalls.c |  8 ++++++++
 kernel/sys.c            |  2 ++
 kernel/time/hrtimer.c   | 18 +++---------------
 5 files changed, 22 insertions(+), 26 deletions(-)

-- 
2.39.2


