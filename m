Return-Path: <linux-kernel+bounces-199132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1606F8D82CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FD428B34B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E6112C481;
	Mon,  3 Jun 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="As/kBY4B"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3947BAE5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419030; cv=none; b=jAfgOlej19Yh8o/KmDoYht5TB3XWGX4brJWyWXTm8DqwBcCsUeSFNtjc4p5m/dqMAGmnS/au4wcMljwUkcRL/+LDf4Mr9I4wIAECj4lTqUIibWh20e9YWfv32jj6cBnORktoEXCkgz99w+vGbTQQV76hRuolA/O3Gc4BFr30YEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419030; c=relaxed/simple;
	bh=eeNvZtmXaiAgrzLPlBYhjIru0uYXAtMNCSwxO2AEPQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SxVboLVunXWbPD+M7Yr2azrME/Idj52ZeNppF92c98KPrUkbbacdhMfdzEMaMzvOkiErcUPbVo6jI5q/uWXlD14wUEhMTDsX2VLS88+e2D4tGwx3AUirIIXl+3/CV9HHszxfx6EeCe4/8MweJHo+HFHJHDyaGPndpTim1LCGum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=As/kBY4B; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mingo@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717419026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zINx7zgXaLxiTnQyIJHNsLg+DAsyZYoDEk1K9wuFt3o=;
	b=As/kBY4Bgyhe2MJHQQOU/1edFw6S+SDK6xnpELfhvTRXGuGPoGXa38CCt/7m+wTH7ylgNH
	ZswtpVej3v42+e2NsXipdt7ZOEHryhAxGJ1M3iA4mKsmFNkvrlbE3jp2zLCs3QUkXPgihJ
	UfEG6kRRUuSmfkAh51PAJyavHkZlPtw=
X-Envelope-To: peterz@infradead.org
X-Envelope-To: juri.lelli@redhat.com
X-Envelope-To: vincent.guittot@linaro.org
X-Envelope-To: dietmar.eggemann@arm.com
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: bsegall@google.com
X-Envelope-To: mgorman@suse.de
X-Envelope-To: bristot@redhat.com
X-Envelope-To: vschneid@redhat.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: yajun.deng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 0/2] sched/rt: Move sched_rt_entity::back to CONFIG_RT_GROUP_SCHED
Date: Mon,  3 Jun 2024 20:50:00 +0800
Message-Id: <20240603125002.3086-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
it should not place out of RT_GROUP_SCHED, move back to RT_GROUP_SCHED.
It will save a few bytes.

Yajun Deng (2):
  sched/rt: Use 'back' only if CONFIG_RT_GROUP_SCHED is enabled
  sched/headers: Move sched_rt_entity::back to under the
    CONFIG_RT_GROUP_SCHED block

 include/linux/sched.h |  2 +-
 kernel/sched/rt.c     | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.25.1


