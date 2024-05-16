Return-Path: <linux-kernel+bounces-181150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6498C7842
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8141C20BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD8114900B;
	Thu, 16 May 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFklCUGc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8FB1474C6
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868582; cv=none; b=QjN4xAuayxjJvfsccw6HX2z3KqpivAwPRt0iKhaF2Dc7Dfco93kr40p1w2qo7oXziNV/9+QE0iQBKwHtxZP+CPaPB0VC0pomlb469aCMrg0dlc4lPmRyB6wggfMRmypXyZ00Qa2dvI5sptpx5Mbp06JuN9k9297aWHFdy2POtZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868582; c=relaxed/simple;
	bh=W1WXru2Z9alaapdgnToS4XIqvX+bFFl9qK211MkyCh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nCOjUUici4D5UngM4MIw9BtFqf7+1bArsBYVaoJH0FDv82kzjUp7rgae15ISS0JQHmhcGcCAJdjDyfq8CnwwueY8MeD3n5aMEjv1y8LN7Rq1QZm8/Hesl9vYuTfRywwI18J2bwOAUdG2tMUwzJmkua8aamisoE4qeWl4yiuRafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFklCUGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99951C113CC;
	Thu, 16 May 2024 14:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715868581;
	bh=W1WXru2Z9alaapdgnToS4XIqvX+bFFl9qK211MkyCh8=;
	h=From:To:Cc:Subject:Date:From;
	b=OFklCUGcaMPKiq2NQugaXY4hCWdWpUTfwJHVQ0aoW8xg7Y5JJbuWzo9fj/jsyjjyO
	 a7nE5AtJ38okBZuPqRlxl7qZjRfpw24nodVsvQyu/lIjf3tln9QuUILyqh0qGmf6Xp
	 4P5K5FAUuloTBasZ/3hwn3bVzLgHguqzGHNex251zVmEoPmi5DAOZJ1GLuVstVRhuF
	 Abcy4Tv6Ne6xjt4NREunFwMYyQg8GGWQdf4Yc+4Xl/ojteDwPWxvmr/q7Kbf+bOwhK
	 vvIgs+k+29PI3DnsGqkJ962kS1AR0CPhWIKpJudvS//JV0V4ULQwuQ4SzwozdOv6j8
	 d6XYIUjdyY4Qg==
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
Subject: [PATCH 0/4 v3] perf: Fix leaked sigtrap events
Date: Thu, 16 May 2024 16:09:32 +0200
Message-Id: <20240516140936.13694-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:

* Simplify the branch condition on [3/4] (peterz)
* Rebase [4/4] accordingly

Frederic Weisbecker (4):
  task_work: s/task_work_cancel()/task_work_cancel_func()/
  task_work: Introduce task_work_cancel() again
  perf: Fix event leak upon exit
  perf: Fix event leak upon exec and file release

 include/linux/perf_event.h |  1 +
 include/linux/task_work.h  |  3 ++-
 kernel/events/core.c       | 49 +++++++++++++++++++++++++++++---------
 kernel/irq/manage.c        |  2 +-
 kernel/task_work.c         | 34 ++++++++++++++++++++++----
 security/keys/keyctl.c     |  2 +-
 6 files changed, 72 insertions(+), 19 deletions(-)

-- 
2.34.1


