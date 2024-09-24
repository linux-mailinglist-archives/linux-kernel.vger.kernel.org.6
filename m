Return-Path: <linux-kernel+bounces-337626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60159984C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107EA1F249EE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E613D276;
	Tue, 24 Sep 2024 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjtRpoDa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609A513CF86;
	Tue, 24 Sep 2024 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212443; cv=none; b=P0bCWpa7HUnQdSvV1K0ZjgbBq21SrHZ7M/mCQqVb5CtN5NNptF+Tkn+5wGxStxVXnV8cfb9QXxwGzRzdz5lcQKK1JukrwD5ULAfR4RdZlj2+36pJhbgJH4c270WJyqQAL6lm8apORakGSmC86Xk9yyGjSsNYN7VFSCjP760ZwsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212443; c=relaxed/simple;
	bh=rAvMuAgzCiY+2tD6owH9gDdOAwfKPQd9UezfteH+QtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aimrc0NwnePofgC04FKIhObqba/gH/EdIS80OBF5jNhuWA2B0GeawBV8supnR7oiRne65N3myzHaZWxuLunsKWCGKPDlRXXaOcrRhG5aBn7UY7FijKNz1RYYZMbXXaHlEqhJpavqIn6ZnT3xM217j35j3IuMF7CK3/X2X2/mc4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjtRpoDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E91C4CEC4;
	Tue, 24 Sep 2024 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727212442;
	bh=rAvMuAgzCiY+2tD6owH9gDdOAwfKPQd9UezfteH+QtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjtRpoDaOYp1iYreUuvECWjgSmZGVHwUuMQmfwb1qtJJmKRHAZhjUGwEmHtmHiBYw
	 bnO25TNExC1ZFJ9Hy8AHvEuPnIK93fVT9dvmY2/cGXI5IrXEoXDEN4PGD8UlykFIW2
	 M+FsWiTk8lQOz/OzP7wewz31kAQPMD2cHaGSTvq4gTs5cfiNMvD6GFRH0Bruo/Ij5d
	 Se5bzrkFtqQxir4GoDKBoR4wTZl//ePUcwYmKIMeUEpxjHiquMfMw9p4BMUjG9BEP3
	 bvJASK3rmB6AXo7KuHRBP9ovPV6tFsvuPKl7fzGmyNqUXE+LKZngnsoVhZn2ZafJky
	 YFWyKHzvoKuZg==
Date: Tue, 24 Sep 2024 11:14:01 -1000
From: Tejun Heo <tj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.12-fixes] sched_ext: Build fix for !CONFIG_SMP
Message-ID: <ZvMrmRyWklgVjHJ4@slm.duckdns.org>
References: <202409241108.jaocHiDJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409241108.jaocHiDJ-lkp@intel.com>

From 42268ad0eb4142245ea40ab01a5690a40e9c3b41 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 24 Sep 2024 11:10:07 -1000

move_remote_task_to_local_dsq() is only defined on SMP configs but
scx_disaptch_from_dsq() was calling move_remote_task_to_local_dsq() on UP
configs too causing build failures. Add a dummy
move_remote_task_to_local_dsq() which triggers a warning.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409241108.jaocHiDJ-lkp@intel.com/
---
Applied to sched_ext/for-6.12-fixes.

Thanks.

 kernel/sched/ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c09e3dc38c34..d74d1fe06999 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2357,6 +2357,7 @@ static bool consume_remote_task(struct rq *this_rq, struct task_struct *p,
 	}
 }
 #else	/* CONFIG_SMP */
+static inline void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags, struct rq *src_rq, struct rq *dst_rq) { WARN_ON_ONCE(1); }
 static inline bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq, bool trigger_error) { return false; }
 static inline bool consume_remote_task(struct rq *this_rq, struct task_struct *p, struct scx_dispatch_q *dsq, struct rq *task_rq) { return false; }
 #endif	/* CONFIG_SMP */
-- 
2.46.0


