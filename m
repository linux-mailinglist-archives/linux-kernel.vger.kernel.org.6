Return-Path: <linux-kernel+bounces-336136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9AC97EF94
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52A8280E42
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F97A1991D9;
	Mon, 23 Sep 2024 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csKyqyOS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34913D625;
	Mon, 23 Sep 2024 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110329; cv=none; b=c0GUInV1hVwgltg63BBeRPH5JTA62rBaE6euuIhwLaVOjQAIs+7vVS3GrsbzHeRFy0nCQQKTctgriC8sMT2FpCepjnelIADPL73dp/qp3QDl9UgqMKFyM9H6QD9I96/g+2wJVAZprdWtUDTSH8p+CmsAyc2VRHRPCXw5uBxG6LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110329; c=relaxed/simple;
	bh=kReOaSEBMPWdtVqRl8nN//eta4B3RwA7Jv8OsUWxPLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC5li7XE23bqk2jSVTDn9/OEkXv2Vhz5Y+O5FQl6ICLcWKNYzmmGNq74Dl5xUAZ5/NzXeEFfjoWwFsoFglP7Q+cVEZQbLs9+b8oPV7iYeZCKgNeURrgwhclwb6w92TWiB6zGRery0TWdQY5TgCLuYZQH65D76UO9jgZ8YU58clM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csKyqyOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ADCC4CEC4;
	Mon, 23 Sep 2024 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727110329;
	bh=kReOaSEBMPWdtVqRl8nN//eta4B3RwA7Jv8OsUWxPLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csKyqyOSNRYqCM3COZqMEW720O8ECVw6Jstj9/TWSQyEDBeByKcGcLGX25jAQQlbB
	 lImh8O3T/7fqf4lwvu9IU69ip+oEVLz7yudoPRq3SYTEqTtzBPPYfgAPb9zS/I5yEx
	 hoIV0h3VPx4jJqH/eDIPMLbx6RAqdfSzkbIXjQdxLXHDd2k017NOKl1gtUcGl1D8Fz
	 /uIgDPQeFHSvJ+nhVY/52ZJohPATxh/Y57MMsWIGJGWfeYDmctk1OWixAVj1lHCfRu
	 4xPI/5M9mf/jIbIQgJi0DjCuCkego/quGunNXGG4c3qxsWzk1WLPoQWOsxB8k0n6KU
	 WScSAIbcI8Htg==
Date: Mon, 23 Sep 2024 06:52:08 -1000
From: Tejun Heo <tj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.12-fixes] sched_ext: Fix build when
 !CONFIG_STACKTRACE
Message-ID: <ZvGcuI89a1A_i2Ie@slm.duckdns.org>
References: <202409220642.fDW2OmWc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409220642.fDW2OmWc-lkp@intel.com>

From 62d3726d4cd66f3e48dfe0f0401e0d74e58c2170 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 23 Sep 2024 06:45:22 -1000

a2f4b16e736d ("sched_ext: Build fix on !CONFIG_STACKTRACE[_SUPPORT]") tried
fixing build when !CONFIG_STACKTRACE but didn't so fully. Also put
stack_trace_print() and stack_trace_save() inside CONFIG_STACKTRACE to fix
build when !CONFIG_STACKTRACE.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409220642.fDW2OmWc-lkp@intel.com/
---
Applied to sched_ext/for-6.12-fixes. Thanks.

 kernel/sched/ext.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9ee5a9a261cc..7c320dcd72d5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4469,8 +4469,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 
 		if (ei->msg[0] != '\0')
 			pr_err("sched_ext: %s: %s\n", scx_ops.name, ei->msg);
-
+#ifdef CONFIG_STACKTRACE
 		stack_trace_print(ei->bt, ei->bt_len, 2);
+#endif
 	} else {
 		pr_info("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
 			scx_ops.name, ei->reason);
@@ -4847,10 +4848,10 @@ static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
 		return;
 
 	ei->exit_code = exit_code;
-
+#ifdef CONFIG_STACKTRACE
 	if (kind >= SCX_EXIT_ERROR)
 		ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
-
+#endif
 	va_start(args, fmt);
 	vscnprintf(ei->msg, SCX_EXIT_MSG_LEN, fmt, args);
 	va_end(args);
-- 
2.46.0


