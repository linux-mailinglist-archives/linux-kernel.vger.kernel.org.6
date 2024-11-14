Return-Path: <linux-kernel+bounces-409811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8680E9C9209
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1754FB24E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A492819993E;
	Thu, 14 Nov 2024 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTTQVWht"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1086F1487CD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610844; cv=none; b=dQpCP03mAfQsUbmSYe2mPs6D5EMCTptaw1+YEWlWTzgJliZLuV7qzLLMFENE6HNqkogJ9d3Arg0LeO9Zy9pRP28HLgqV7XBz/NzrUwEeKUhqLZ4UVrZLSRK7mFTP7Z1Hc3YUExp5F2xLYyJIBYi9gV/vO5t2Muik5rVmyCs2vXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610844; c=relaxed/simple;
	bh=MT2cirq4F2eG0a3w3MxcCuBigIlviV/yui/gg5rgS60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qL9o5pswPCyn6jVlaUf4SeuVIGIyuPoHWYhkvrv75nnQsXvvfdxdbfZ9DMPDtDr3ueSArRwk+9NBaS2LgHrWIfd6YrJDs1ZcsVRiDjs0zbckN1GPzmEePxuJ0KloC+iokzA6aPS5b5jdLh1M16J+DvgpP8HwEzcrQw4HV80qkJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTTQVWht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CCBC4CECD;
	Thu, 14 Nov 2024 19:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731610843;
	bh=MT2cirq4F2eG0a3w3MxcCuBigIlviV/yui/gg5rgS60=;
	h=Date:From:To:Cc:Subject:From;
	b=NTTQVWhtrk2dCRIiY50NJGhcPkhUyxaJB8KPAf2SdVAhe45sGKGZtFumYQQLdcenp
	 72lU2CyD4p6GBe9FCBckwfzPCWrZM+/f5DcCBqiVEc59oB9SDBIYWXeUV291/avFdb
	 vVzvVwOVbdX9/4p23hsBGKlZ4ndz7oUPlwEhUlsiPp9Jr8Gpsh/EY4HjDtZ+5hDgt6
	 0eUUAMtFwguBkSRn2c2v12hwqOQ2zd0X5uXsl8SitqTjWnX8Da05dfx7yFs431wEVm
	 z/Bsn3rR3Xf+AIFL4HiMIBlEFHAFty/PT1uG5Y6Z21nsLVrZqoNQSQxze856kzmWFJ
	 IfUgIPfZxMAqQ==
Date: Thu, 14 Nov 2024 09:00:42 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, Zhao Mengmeng <zhaomzhao@126.com>,
	kernel-team@meta.com, sched-ext@meta.com
Subject: [PATCH sched_ext/for-6.12-fixes] sched_ext: ops.cpu_acquire() should
 be called with SCX_KF_REST
Message-ID: <ZzZI2sHHNznA4VSD@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From a4af89cc50f3c1035c1e0dfb50948a23107f3e95 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 14 Nov 2024 08:50:58 -1000

ops.cpu_acquire() is currently called with 0 kf_maks which is interpreted as
SCX_KF_UNLOCKED which allows all unlocked kfuncs, but ops.cpu_acquire() is
called from balance_one() under the rq lock and should only be allowed call
kfuncs that are safe under the rq lock. Update it to use SCX_KF_REST.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Zhao Mengmeng <zhaomzhao@126.com>
Link: http://lkml.kernel.org/r/ZzYvf2L3rlmjuKzh@slm.duckdns.org
Fixes: 245254f7081d ("sched_ext: Implement sched_ext_ops.cpu_acquire/release()")
---
Applied to sched_ext/for-6.12-fixes.

Thanks.

 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 19f9cb3a4190..1ae8520b63dd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2645,7 +2645,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * emitted in scx_next_task_picked().
 		 */
 		if (SCX_HAS_OP(cpu_acquire))
-			SCX_CALL_OP(0, cpu_acquire, cpu_of(rq), NULL);
+			SCX_CALL_OP(SCX_KF_REST, cpu_acquire, cpu_of(rq), NULL);
 		rq->scx.cpu_released = false;
 	}
 
-- 
2.47.0


