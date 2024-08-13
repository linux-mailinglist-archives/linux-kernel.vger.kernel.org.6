Return-Path: <linux-kernel+bounces-285007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A538A95080A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A7E1F21766
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324EB19EED4;
	Tue, 13 Aug 2024 14:44:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCD419EEA6;
	Tue, 13 Aug 2024 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560240; cv=none; b=I8GAu+jAs+odAIhxUWWfsblX31s9yHH5EoFkqqO1RkVux99tsVhliKtV2sg++A11SGTMavIDHqxwbxkM97q1kikspdVFSdCv4wFvsE7iNL1BuO/yP618bdQ+GGom7tZ9XvlvERQ6TiBFTEQTH9yOWWSM5VWlAUH3IHgP2VLGg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560240; c=relaxed/simple;
	bh=YNg/KKJ0sSvf3vGZvLY2X31BCdxXV1DKmzobQPyQwDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgpun8cyjpjRHEICa4miPZygM10kqEg2cTJAvY777Q0ud9qFtIcV7LIsf52LG+goHunEug/QckLkkG920oNWb2PWEBxnfibpGwI7hSt4ZV8DKiSElU420SBdp2AANrm86YOhC4qFApIDSVOUJWVtL5+mSS+pgZofGMi4SqNttog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C46BB12FC;
	Tue, 13 Aug 2024 07:44:22 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.84.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3BCCE3F58B;
	Tue, 13 Aug 2024 07:43:54 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: vincent.guittot@linaro.org,
	qyousef@layalina.io,
	peterz@infradead.org,
	daniel.lezcano@linaro.org,
	rostedt@goodmis.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/4] sched/deadline: nanoseconds clarifications
Date: Tue, 13 Aug 2024 15:43:44 +0100
Message-Id: <20240813144348.1180344-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of clarifications about the time units for the deadline
parameters uncovered in the discussion around
https://lore.kernel.org/lkml/3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com/

While at it I changed the documentation example to chrt instead
of the schedtool fork.

No functional changes.

Christian Loehle (4):
  sched/deadline: Convert schedtool example to chrt
  sched/deadline: Clarify nanoseconds in uapi
  cpufreq/cppc: Use NSEC_PER_MSEC for deadline task
  sched/cpufreq: Use NSEC_PER_MSEC for deadline task

 Documentation/scheduler/sched-deadline.rst | 14 ++++++--------
 drivers/cpufreq/cppc_cpufreq.c             |  6 +++---
 include/uapi/linux/sched/types.h           |  6 +++---
 kernel/sched/cpufreq_schedutil.c           |  6 +++---
 4 files changed, 15 insertions(+), 17 deletions(-)

--
2.34.1


