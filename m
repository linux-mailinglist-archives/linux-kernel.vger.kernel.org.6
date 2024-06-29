Return-Path: <linux-kernel+bounces-234913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A66C91CC5F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65ABEB21E48
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E28F481DA;
	Sat, 29 Jun 2024 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pNkGMO7X"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324C11DA53
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719660561; cv=none; b=PAXx95SMMgORHp2qyeTKAG/oxmzMugQolOl9sSa9G3izd6Djd/Q0Yrf1cU0iFaIMTahTMYheMphBk/sHwOHDj23gsKi3oQl4NkR5x+Hw62wVVSPiBvV+Db8Bo8oDwWwbQNDsmk/0KVgGUuSZE4kuGU20OfV8HZLJFCgh6cpDisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719660561; c=relaxed/simple;
	bh=qCB1UMYulSor3eqa3ItrOCOV3SddFF8iZUzTVe7O6KI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+FopUJicbatNA6EjDEYu7OU48LxgcyltlLk5zruq6ab3YuawN6QKhxjlFvRvyx7qgBhhMduBK3BqTltLV2oOUNbIDgKlgAm+ZRCE2n0XxfEDf8K4oLJgHX/raZ1c9Ho0WdfT0rnn3+mD1sbiT4FVUIa10Gz/gsESWnNJEjdpdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pNkGMO7X; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Sy1O+
	PJbNP1kOlF4q0WfXCkse3I55Cd/vriCu4LKoDs=; b=pNkGMO7X/frfBpkMox/CB
	cT+PrrUcG2QxWLyCHV77tnqXzZyAeG6/Z1T3/ZoC1pBf0nb+F5FVD+XwTXedwkU0
	kxgIy+g1Vhzix/WUT/fRSgPM+oK3rfrlA2b5J5p6uojE2u6R8yWeucjvJe1zeszj
	Oyd+N8BRlt2Vz36zqL4YeE=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDnTyLO739mU3TCAw--.15900S2;
	Sat, 29 Jun 2024 19:28:14 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-RT sched v2 0/2] Optimize the RT group scheduling
Date: Sat, 29 Jun 2024 19:28:10 +0800
Message-Id: <20240629112812.243691-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627172156.235421-1-xavier_qy@163.com>
References: <20240627172156.235421-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnTyLO739mU3TCAw--.15900S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw45Cr1DZryfAF17JF15XFb_yoW8Ww18p3
	ykK3W5tr1kJFW7tryfAw4kurWru3WSqwsrWrsxK345Jr4ru3WSqr1xKr43XFy7WFykAryS
	vw1jvr1xu3W0yw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziLFx8UUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiYxANEGV4JCLR7AAAsI

Hi all,

Patch v2 fix the issues arising from disabling the CONFIG_RT_GROUP_SCHED
macro during compilation.

>The first patch optimizes the enqueue and dequeue of rt_se, the strategy
>employs a bottom-up removal approach.
>The second patch provides validation for the efficiency improvements made
>by patch 1. The test case count the number of infinite loop executions for
>all threads.
>
>		origion          optimized
>
>	   10242794134		10659512784
>	   13650210798		13555924695
>	   12953159254		13733609646
>	   11888973428		11742656925
>	   12791797633		13447598015
>	   11451270205		11704847480
>	   13335320346		13858155642
>	   10682907328		10513565749
>	   10173249704		10254224697
>	   8309259793		8893668653
>
>avg    11547894262      11836376429
>
>Run two QEMU emulators simultaneously, one running the original kernel and the
>other running the optimized kernel, and compare the average of the results over
>10 runs. After optimizing, the number of iterations in the infinite loop increased
>by approximately 2.5%.

Kindly review.

Xavier (2):
  RT SCHED: Optimize the enqueue and dequeue operations for rt_se
  RT test: Adding test cases for RT group scheduling

 MAINTAINERS                                   |   7 +
 kernel/sched/debug.c                          |  50 ++++
 kernel/sched/rt.c                             | 278 +++++++++++++++---
 kernel/sched/sched.h                          |   1 +
 tools/testing/selftests/sched/Makefile        |   4 +-
 tools/testing/selftests/sched/deadloop.c      | 192 ++++++++++++
 .../selftests/sched/rt_group_sched_test.sh    | 119 ++++++++
 7 files changed, 609 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/sched/deadloop.c
 create mode 100755 tools/testing/selftests/sched/rt_group_sched_test.sh

-- 
2.45.2


