Return-Path: <linux-kernel+bounces-180019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3968C68EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A2C282A27
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5615572C;
	Wed, 15 May 2024 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRMbFTY8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E4B5C8EF
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784199; cv=none; b=hqGj70G0D1uBH4/t/t4Nyu6vozvy5I30lTBUN9jF/cD0NtXITir9nClKGeC4mQE5kVs+DIQ1phJUg45eGLmmRNiXQ6fJtzKLckae+m84a0i60jUuP5zNXKQHJiYCfqS/BhuhjOkOSVVd/qmcN+T4BhjxIEUAy4ApbIjdHdfWX8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784199; c=relaxed/simple;
	bh=MYxrG/4OoDfLVTkkT8WxuDkgYkCERZjlW9K+2Ac+afc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cuH9oXclELYRJ0IzMPyGSQcg3ZOjUNi8bi0tS1oiHMnfjnGD5+yyqcPQKZIF7/VyhVbdaIWf++RTkOiXS+af1kgej2szhOWwvnXvqSbjdQo/qHPLTVbLKsHl/28h1JVRIUOBGc01za1cJSCCP2DQNAFln+fh6Al/peDvEY6Gy9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRMbFTY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB4DC116B1;
	Wed, 15 May 2024 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715784198;
	bh=MYxrG/4OoDfLVTkkT8WxuDkgYkCERZjlW9K+2Ac+afc=;
	h=From:To:Cc:Subject:Date:From;
	b=RRMbFTY89VVK/01ttxKV2j/aSHNu5ebpD+Q20Ve9NouZsmjakgg7NlGXpoTrcs0ic
	 m8sVe+2k1d1hD42M5+aNjodLR5oguObBVR7c+saYsKKFsQ3diRYBW/awacHHZKOBKg
	 ErKu1JL0wzVRvTShyTh/so9/9jhUXBRFmHsi6iMjNYIhuZD1ZnXP0bKGoLcOaMFSuU
	 9n7tTgnlKabApJUYv6NgL6Fvp35iEfIjEkPSy9m1gsZsaajdcA3K6j1YtrER9Ypm/p
	 I4YJN2jcsitYb+5dli8hRhM5mz/KV5FBPsxZok0Nn30rzjLTRjO301Bye+0hVFNnIP
	 TJWfXV+e2Fx0A==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/4 v2] perf: Fix leaked sigtrap events
Date: Wed, 15 May 2024 16:43:07 +0200
Message-ID: <20240515144311.16038-1-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

After discussions with Sebastian, here is an updated version of
https://lore.kernel.org/all/20240329235812.18917-1-frederic@kernel.org/

Changes since v2:

* Use rcuwait instead of waitqueue (more RT-friendly when preemption is
  disabled)

* Add a few comments about RCU-ordering expectations

Thanks.

Frederic Weisbecker (4):
  task_work: s/task_work_cancel()/task_work_cancel_func()/
  task_work: Introduce task_work_cancel() again
  perf: Fix event leak upon exit
  perf: Fix event leak upon exec and file release

 include/linux/perf_event.h |  1 +
 include/linux/task_work.h  |  3 ++-
 kernel/events/core.c       | 45 ++++++++++++++++++++++++++++++++------
 kernel/irq/manage.c        |  2 +-
 kernel/task_work.c         | 34 +++++++++++++++++++++++-----
 security/keys/keyctl.c     |  2 +-
 6 files changed, 72 insertions(+), 15 deletions(-)

-- 
2.44.0


