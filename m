Return-Path: <linux-kernel+bounces-315750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD92C96C683
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F411F26A91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37591E2006;
	Wed,  4 Sep 2024 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkaCkshh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FB91E1A2F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475025; cv=none; b=kMOr6u+gJZ69bQiLWWvUStrCDtxHGWUwKj4WOSiXEShCtgO19XfupTUo6HorJzvHHhfSiGpUwglbGCLevNHdUW3RhwyZ0+RrMH1QNapmUy0vTnI8Tk1bHBkzuI3U7YqdPkPAX0ObL9aR1v5k+MQTAZMX9slEF1Pyahd039/47Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475025; c=relaxed/simple;
	bh=VN/f1BOZXW2+WfCChWnIiCxRbwuHxBLwO1zdfHqMXRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BASYZUOkMRubDzCCDR/CAAVcDHW3JDhXLR/w6m1U1+ZTNO6qfefcQ6WM9TiDUufgWLl+sVunyLXEDLXO4e3g5U23oODjkMflLoKjB6p2arDWspXAa5P11CzuMHpLztX4SSJpFgHsDr3Eu0QpTpkF45Fhjts0D1RGQYgMAmaqnQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JkaCkshh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725475022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cDFw0U1LzeNwEj7T3sJ+Z6xuRsiSKv0SdDuGEg131ho=;
	b=JkaCkshhW04vv7KETUoWQkGBkgbT/I0WuPj62QaG7JUR3TlLfaoySmY0v83CMuTvNfIGrS
	IDNWsjRV+nxdEKD9yEfGUdT0ZzirUOL7qkax7c+pfV2fW9rscoZq3m31nZ9HWA2e4eIOBh
	t8HFHBaa7Pd0+ry0B0to7hdDmS1k2DI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-aJ0jZGL6P_G7hELRVmE9KQ-1; Wed,
 04 Sep 2024 14:37:00 -0400
X-MC-Unique: aJ0jZGL6P_G7hELRVmE9KQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAE1B19560BD;
	Wed,  4 Sep 2024 18:36:58 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.172])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF7601955F45;
	Wed,  4 Sep 2024 18:36:55 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v3 0/2] sched: Miscellaneous isolation related cleanups
Date: Wed,  4 Sep 2024 14:36:48 -0400
Message-ID: <20240904183650.1053708-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

 v3:
  - Fix incorrect housekeeping_nohz_full_setup() flags setting.

 v2:
  - Remove HK_TYPE_SCHED and related dead code
  - Change consolidated name from HK_TYPE_NOHZ_FULL to
    HK_TYPE_KERNEL_NOSISE as suggested by Frederic and update
    isolation.c as well.

This series contains a number of miscellaneous sched/isolation related
cleanups.

[v1] https://lore.kernel.org/lkml/20240818234520.90186-1-longman@redhat.com/
[v2] https://lore.kernel.org/lkml/20240904171441.1048072-1-longman@redhat.com/

Waiman Long (2):
  sched/core: Remove HK_TYPE_SCHED
  sched/isolation: Consolidate housekeeping cpumasks that are always
    identical

 include/linux/sched/isolation.h | 19 ++++++++++++-------
 kernel/sched/fair.c             | 14 --------------
 kernel/sched/isolation.c        | 10 ++--------
 3 files changed, 14 insertions(+), 29 deletions(-)

-- 
2.43.5


