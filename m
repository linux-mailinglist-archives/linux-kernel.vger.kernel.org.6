Return-Path: <linux-kernel+bounces-335607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3942097E806
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF604281E84
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A5A188918;
	Mon, 23 Sep 2024 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbrvRcTY"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074F44C8C
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082065; cv=none; b=JdYiAlIboUA0D7BjDpQs7MK7WGLyPsPsg0qx83PZ1dmdv3e8glJhzTj/Th/LFnkN4rKorX9TN1V7Y0BNDoUV1aKTQ1jz1ADiIhEJMdeOY47zvGor4Cpz6XKkhpgTvyAuYN8I4aSuf7nRQibNgsESetGwrYu/vlrI9eoo531SurM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082065; c=relaxed/simple;
	bh=wIGVE8CFt3mM09bwjF/UJC3OcuVTqn8TrFQKRVRkbSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kz3aojW2RKDbEyZcVmbRXi5O5PLydjWXRf1IlD/b0zM2CQv6CEGXEQbKgYQ1mWAX6ML7fICk8VQ8LrfjxBhyLLjGKhqOXzURhfPOjtWGA901jdjkdzkA+8ZsxPm+PtghduGebH3nK8ALErItTo66sIjUHVNL8yNyCVP5Z7WLk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbrvRcTY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2053525bd90so36834415ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727082063; x=1727686863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZJMJAbQwfw22RiHYp9lMZI7w78fR9F4c1wJzTM4wmM=;
        b=AbrvRcTY+BjDJiqnHYNP6WSHT9pLLyqQgd3kAPM11muKbc6eqqehLDSn7Jgg6Afi9e
         sMJOFl6YPIxC0EQzTKkAmte+r7AzF8+u28OGEMnny8lBFfCg2MVhihT97x+LYTyLZRLw
         xvNYjKqeRvVesloDTZBK1kFERAq9T2GVRmYyToANGPtR2mc8VakueTXzZK4fVsrb/YtM
         OLkHtsO/rEx7bqbWaHt2GRKMV0TGceroaTdIJ+dY5mes0JLHY7WSZC1iAm0eOVP9dvu9
         pHWbY/TDSOZNIn/hzmybQ7lh/1j0mDQDsm/ZRMRLN8FRPVTncXKrK2XX5qHrijraVf9W
         Thuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082063; x=1727686863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZJMJAbQwfw22RiHYp9lMZI7w78fR9F4c1wJzTM4wmM=;
        b=kfw2WuRdXtSXUqs6hblQB1SWNq7vBQCd8i0jSPIgYiQBp4WsXEnAVH4G22EF4Yfn2E
         PJ1WcTs6nOwaRoXfZHWDj899gHCdefu0HkqGORROFINZXrgfSIUNeT76crgVA+AZHKok
         oRSrxcB5iixNQ/5ZPxWDtAG1YKYFYwxSREvoZSkNGcRs2FPdN/JOdZ1mVNXv9yi3bOl9
         gX4NmDRatnrbympCeKlnN82qyapSuue5SNpnU9AgmeM0JVhCWR027CnqvmVdzLgf5KiV
         MUKZudojgTaqT4T9TpVyC+FwqSoMfld9cBIiDUkOreFA9c8noOVKHHfW6Wq3BUMTzAVg
         gU2A==
X-Gm-Message-State: AOJu0YwFhtUrKA5Rr7s9b2SvcYiVl7+I4CL1xoAeh7yhDFswcSMFPVjw
	vXZSZXS3Ma0RYAl1LOwwRpOZRHceBo/QUHYyPL9/5YREhVkI0zPu
X-Google-Smtp-Source: AGHT+IHTAt71h76smX0aG9ssWhv25XuQ4K2zEuJ5Kn7GF30B/Rnock0v9uZiOqTHzKP8oiT++Kn20g==
X-Received: by 2002:a17:90b:208:b0:2d3:c05c:c51 with SMTP id 98e67ed59e1d1-2dd7f171fa8mr14058053a91.0.1727082063046;
        Mon, 23 Sep 2024 02:01:03 -0700 (PDT)
Received: from localhost.localdomain ([39.144.43.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f8ca487sm6768872a91.39.2024.09.23.02.00.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2024 02:01:02 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 0/3] sched: Fix irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
Date: Mon, 23 Sep 2024 17:00:25 +0800
Message-Id: <20240923090028.16368-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After enabling CONFIG_IRQ_TIME_ACCOUNTING to track IRQ pressure in our
container environment, we encountered several user-visible behavioral
changes:

- Interrupted IRQ/softirq time is not accounted for in the cpuacct cgroup

  This breaks userspace applications that rely on CPU usage data from
  cgroups to monitor CPU pressure. This patchset resolves the issue by
  ensuring that IRQ/softirq time is accounted for in the cgroup of the
  interrupted tasks.

- getrusage(2) does not include time interrupted by IRQ/softirq 

  Some services use getrusage(2) to check if workloads are experiencing CPU
  pressure. Since IRQ/softirq time is no longer charged to task runtime,
  getrusage(2) can no longer reflect the CPU pressure caused by heavy
  interrupts.

This patchset addresses the first issue, which is relatively
straightforward. However, the second issue remains unresolved, as there
might be debate over whether interrupted time should be considered part of
a task’s usage. Nonetheless, it is important to report interrupted time to
the user via some metric, though that is a separate discussion.

Yafang Shao (3):
  sched: Fix cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
  sched: Define sched_clock_irqtime as static key
  sched: Don't account irq time if sched_clock_irqtime is disabled

 kernel/sched/core.c    | 44 ++++++++++++++++++++++--------------------
 kernel/sched/cputime.c | 26 +++++++++++++------------
 kernel/sched/sched.h   |  1 +
 3 files changed, 38 insertions(+), 33 deletions(-)

-- 
2.43.5


