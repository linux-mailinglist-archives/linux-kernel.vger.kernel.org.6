Return-Path: <linux-kernel+bounces-261599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3EB93B9B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 02:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A076285E94
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB5B7FF;
	Thu, 25 Jul 2024 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVI5ohfx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46116181
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721865899; cv=none; b=WiycNdQf3rb+5muqAUmm1RvUW9PtycERTIkiXW3iLemozn2kjbhASsnkoOnDvOq3y4b2pSakIq3/D3o88/1ZkmH6lZ4b4iQ8PuRFX0kZ/Bpe3mfaTUScdd+3A1KpTHlA5H+g4JLD24Su/M2e16SH0ARxD8w8ESZasaYq8VVAEc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721865899; c=relaxed/simple;
	bh=yytwQzW55WVCEakyBSX9S4svu9zoCf7LcvbhPeAmraU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M1oIgPZRDb0/OzvK3iiMhIebIGLJ8lIIwUxXl0jap2vyi+g5ynzU5xr17EWSGFRt+98jbo6rqMFFEQWBd+DOXnmrOlgzA5QeOw2eKSuRgGHG0FiLn+1ExugXM+4Qpz7fpR2Daee3anywXG5EYDB5NccMLd4m/qM8H32dgL2Q7mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVI5ohfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AFFC32781;
	Thu, 25 Jul 2024 00:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721865898;
	bh=yytwQzW55WVCEakyBSX9S4svu9zoCf7LcvbhPeAmraU=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=sVI5ohfxuKzE7yvibUrc3fDhWMWKsOPOhWG5RBxvI7ExxoPoccEiB1C2KQNdaPnzh
	 Al6YuYOnmfFS/RcmkmuV8SJbA13BPyGTKKHBKkZj6qjpxkp/3gJNnTc6LEiTLmdfe6
	 TZ8azB1m6DD34CZUeJfTmEm38tTUELUS7iNx28FjbFmbz9SfPzdxTomLiAAbHdFsgc
	 w3qgCa7fKdYI51YAKmJLpPYJ59USXKpJSLSPOL/UufdemXak8QYIyxqiYBQx/APfGL
	 pBbYxZqxCJk7gNleR9OTFMXtHqYrAXEl4XNWeEBcAWFWZ5KT2RThrH0RDn08lLtyci
	 90MsDK4Lt9mgw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6BE0CCE0BC6; Wed, 24 Jul 2024 17:04:58 -0700 (PDT)
Date: Wed, 24 Jul 2024 17:04:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, brauner@kernel.org, oleg@redhat.com,
	akpm@linux-foundation.org, willy@infradead.org, clm@fb.com,
	riel@surriel.com, ffledgling@meta.com
Subject: [PATCH RFC exit] Sleep at TASK_IDLE when waiting for application
 core dump
Message-ID: <1936bd18-775b-43e3-bfd5-2cd343565f06@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Currently, the coredump_task_exit() function sets the task state to
TASK_UNINTERRUPTIBLE|TASK_FREEZABLE, which usually works well.  But a
combination of large memory and slow (and/or highly contended) mass
storage can cause application core dumps to take more than two minutes,
which can triggers "task blocked" splats.  There does not seem to be
any reasonable benefit to getting these splats.

Therefore, change that TASK_UNINTERRUPTIBLE to TASK_IDLE.

Reported-by: Anhad Jai Singh <ffledgling@meta.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Chris Mason <clm@fb.com>
Cc: Rik van Riel <riel@surriel.com>

diff --git a/kernel/exit.c b/kernel/exit.c
index f95a2c1338a8..b0d18f7b6d15 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -429,7 +429,7 @@ static void coredump_task_exit(struct task_struct *tsk)
 			complete(&core_state->startup);
 
 		for (;;) {
-			set_current_state(TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
+			set_current_state(TASK_IDLE|TASK_FREEZABLE);
 			if (!self.task) /* see coredump_finish() */
 				break;
 			schedule();

