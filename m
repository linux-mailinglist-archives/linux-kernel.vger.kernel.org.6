Return-Path: <linux-kernel+bounces-202712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 255868FCFE8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95901F24D98
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152DA198E80;
	Wed,  5 Jun 2024 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ncL2/DUB"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE2198A0B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594582; cv=none; b=Z6qhfPj/fP4XiL8YMbZ3U+/F6oRfbjivBFFGWxk+0G3k8PHXYLNCSLbKeiTbLDdU6AUIbYgRVVSycSDfhjPGY3g0o/VeW6WEn9kOTj+NfbO/vP7aTBW1wy4GwNUoQHf0l3CqhvKSxN6amgk3t3c8Udc562UCC1nM6EXr8j58jyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594582; c=relaxed/simple;
	bh=sGv+N55Q2rZgDMfFjYuk8xsT2jB+v5TY0XXkptLRJOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HDsSZiASARNnagXocRtDFK43JucaS5BtS+zVWhDH6su3h2s3ia0aZ4nt1ClPtD8hEHQiW1LWi0jxeVS3OTFUM/Yj1DTZGTbKOCoJhYldifBaGMA7HHfaNlFgpgcl1J4tUiGR52S1CkUKiltl4ZiqTKDwMAf/NEFSJaA4dK/Oa3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ncL2/DUB; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mingo@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717594578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hrf+zl1mmCUKsWQ2WPVS2iGG+jTHqzDmgKvRRAsUmSQ=;
	b=ncL2/DUBvAHHX2VW2rSPBfwYNc+IxtgVIdWgfRgAI1P82rk68hlom7NoI4I7Jwi27YoqSQ
	K0Jrc2dnnp7wJvzvD+7PcuZO/WbsMkgeynb8JsKYfQGsr9ldyyP3/wm9RvmmaeYmiiP1zt
	WjA1zWR+UoNxDceE4w6BH8stHTv73II=
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
Subject: [PATCH v2 0/2] sched/rt: Move sched_rt_entity::back to CONFIG_RT_GROUP_SCHED
Date: Wed,  5 Jun 2024 21:35:55 +0800
Message-Id: <20240605133557.2984-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The 'back' member in struct sched_rt_entity only related to RT_GROUP_SCHED,
it should not place out of RT_GROUP_SCHED, move 'back' to RT_GROUP_SCHED.
It will save a few bytes.

v1 -> v2:
 - introduce rt_se_back() helper function.

Yajun Deng (2):
  sched/rt: Use 'back' only if CONFIG_RT_GROUP_SCHED is enabled
  sched/headers: Move sched_rt_entity::back to under the
    CONFIG_RT_GROUP_SCHED block

 include/linux/sched.h |  2 +-
 kernel/sched/rt.c     | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 7 deletions(-)

-- 
2.25.1


