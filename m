Return-Path: <linux-kernel+bounces-271956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E53CE945568
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739F3286428
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB17FC11;
	Fri,  2 Aug 2024 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbFfDc3k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E36D51E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558649; cv=none; b=RT/r55/GzNZTn7co2RI5415ARY4Qty5D/s00hV3zmCcHrrG4GVulZ+ryAwFp6G3UiNdPZoGPPGSoPSevNA+SvUfiMyVcSnz9YrTQkK9JYyOPHZS3Ccq1cy6kt1BkDw+cUzvfPPqOQh0EW40CjE3MzGmqjSn0F+C5gX56RaIlJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558649; c=relaxed/simple;
	bh=GOsLE2H2kxozZGmGGy11M/q8AzvicOB0v4IKkxs553w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCHTwJ5F7u583/Mq98SgvQci+3H7d3WiCIBadOAGJPw89D1+VRy0BX5HgPp7nFQ9mW2Cf/DkJ4L7cdcAd7L51EuIBiaiw9t+y4VhMx/gIEXy1zU1OyC8hmFZTOCk64SErSyH/wyyweqoR2fCe4ZbDrF+g1d5+Un+2XkrTrMX1WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbFfDc3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869ADC4AF0A;
	Fri,  2 Aug 2024 00:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558648;
	bh=GOsLE2H2kxozZGmGGy11M/q8AzvicOB0v4IKkxs553w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbFfDc3kU+sa5h4LiyXBiMNWMS/ohMRjT0qVpeRS1HGbH4DsBaHK+Q58j6MtAVUuf
	 ehwjpQaAJ37bvNLN9EssSjDq/2Tp7lwRseE/1Mih41o7PRgiTQ6saSkKq0/TvA7nHA
	 SHn3DPQ0PnzzlV3s3/vjMyMBZq0fZVTApAdSOqoiZduHqNDtm+tRaRoINt2L0dlKjW
	 SR6+cV4tXAMJovXSmAB/TUlCAoIEJ6vnTCixPqD1lez0r72nqA+aEUPA9Y4u6j4b7q
	 jwqwYwboTBK7U0Mwcc/lTVwRqVxasIlUU5nnyW51wrZ1y0Ie348UynyTT5yLn8GWss
	 dxXq7O4M7WqOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2F230CE0A01; Thu,  1 Aug 2024 17:30:48 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Rik van Riel <riel@surriel.com>,
	Anhad Jai Singh <ffledgling@meta.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH misc 2/2] exit: Sleep at TASK_IDLE when waiting for application core dump
Date: Thu,  1 Aug 2024 17:30:46 -0700
Message-Id: <20240802003046.4134043-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d70d1654-fed2-477f-8f4f-f81322784f17@paulmck-laptop>
References: <d70d1654-fed2-477f-8f4f-f81322784f17@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the coredump_task_exit() function sets the task state
to TASK_UNINTERRUPTIBLE|TASK_FREEZABLE, which usually works well.
But a combination of large memory and slow (and/or highly contended)
mass storage can cause application core dumps to take more than
two minutes, which can cause check_hung_task(), which is invoked by
check_hung_uninterruptible_tasks(), to produce task-blocked splats.
There does not seem to be any reasonable benefit to getting these splats.

Furthermore, as Oleg Nesterov points out, TASK_UNINTERRUPTIBLE could
be misleading because the task sleeping in coredump_task_exit() really
is killable, albeit indirectly.  See the check of signal->core_state
in prepare_signal() and the check of fatal_signal_pending()
in dump_interrupted(), which bypass the normal unkillability of
TASK_UNINTERRUPTIBLE, resulting in coredump_finish() invoking
wake_up_process() on any threads sleeping in coredump_task_exit().

Therefore, change that TASK_UNINTERRUPTIBLE to TASK_IDLE.

Reported-by: Anhad Jai Singh <ffledgling@meta.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Chris Mason <clm@fb.com>
Cc: Rik van Riel <riel@surriel.com>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 7430852a85712..0d62a53605dfc 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -428,7 +428,7 @@ static void coredump_task_exit(struct task_struct *tsk)
 			complete(&core_state->startup);
 
 		for (;;) {
-			set_current_state(TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
+			set_current_state(TASK_IDLE|TASK_FREEZABLE);
 			if (!self.task) /* see coredump_finish() */
 				break;
 			schedule();
-- 
2.40.1


