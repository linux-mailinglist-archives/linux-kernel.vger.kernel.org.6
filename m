Return-Path: <linux-kernel+bounces-336042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB3E97EE69
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BE41F2267E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3178F7D;
	Mon, 23 Sep 2024 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpQZDwk5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC41126C01
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106192; cv=none; b=eI56g3Lr/umYJFABAs5ncRnT2ro0mM6dEtvdNrVdAzF6SPORr6bNDfDHAzYcq7cJnC8QbtoOlPUv9bohdibIhS7WAEmxHU9o7c52ZDBSzId9Zh6p04LfYaofGwoP4kFrcS+aVYYpwWUxOzRboCb+50mPtv47oElgNf3tbKp8YtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106192; c=relaxed/simple;
	bh=zPyNbzcjm4grWlNm7sx45+kDDygsbik4KwyJ/2EXoEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDQClYvMIm4q6kmOP/lDK3/ufjus+qkxF/0vNGNmABS31QTbZjOpbHcU3tv19hNSnJRDs+7/NDykm/csUlj4pwme5VUEKnBAlFCOjwnOosUKdsosLr2RWJS7pVD0aoXXu2/tE6SbeaZqOwdcCrLc+BEv1Q4ZBGBT2J9Rm8fcBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpQZDwk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612F8C4CEC4;
	Mon, 23 Sep 2024 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727106191;
	bh=zPyNbzcjm4grWlNm7sx45+kDDygsbik4KwyJ/2EXoEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpQZDwk5gYTHJq/Clmo/NQ0QAAhdCNLYJbJc4hDyBU8Uka2q2XPG9ZNA+ZWjTPumH
	 5cIjjbyJxdMhkVKw6iuR5kFAK6+FLroz0uYUFAlrG0k7qeVgc7XFpbkGvK0Z1xi93I
	 /BpphYzeC9UH5JGPBJ7yFjnh8AMBsX1rVJm4s06eH6NjvbnYh6yZZlDg3cItXp423X
	 hNq6OWNgwuVaFWCkl/45uF6uTmxfNtJTPGgX2wSlTDrk/YH4GCOblK7I0ugvWmDJkS
	 6yeGiPiBiE5hCfrNDUfCb8D/yCE3N1GoRO/Qo+HJthZAliMpX/75KpEo9YqvC12pj5
	 Z/gNMb6GbyYvg==
Date: Mon, 23 Sep 2024 05:43:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Pat Somaru <patso@likewhatevs.io>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	sched-ext@meta.com, peterz@infradead.org
Subject: Re: [PATCH sched_ext/for-6.12-fixes] Disable SM_IDLE/rq empty path
 when scx_enabled
Message-ID: <ZvGMjn1Va3aNbieH@slm.duckdns.org>
References: <20240920194159.158152-1-patso@likewhatevs.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920194159.158152-1-patso@likewhatevs.io>

Applied to sched_ext/for-6.12-fixes with minor edits:
------ 8< ------
From edf1c586e92675c4e0eb27758fcdb55a56838de1 Mon Sep 17 00:00:00 2001
From: Pat Somaru <patso@likewhatevs.io>
Date: Fri, 20 Sep 2024 15:41:59 -0400
Subject: [PATCH] sched, sched_ext: Disable SM_IDLE/rq empty path when
 scx_enabled()

Disable the rq empty path when scx is enabled. SCX must consult the BPF
scheduler (via the dispatch path in balance) to determine if rq is empty.

This fixes stalls when scx is enabled.

Signed-off-by: Pat Somaru <patso@likewhatevs.io>
Fixes: 3dcac251b066 ("sched/core: Introduce SM_IDLE and an idle re-entry fast-path in __schedule()")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b6cc1cf499d6..43e453ab7e20 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6591,7 +6591,8 @@ static void __sched notrace __schedule(int sched_mode)
 	 */
 	prev_state = READ_ONCE(prev->__state);
 	if (sched_mode == SM_IDLE) {
-		if (!rq->nr_running) {
+		/* SCX must consult the BPF scheduler to tell if rq is empty */
+		if (!rq->nr_running && !scx_enabled()) {
 			next = prev;
 			goto picked;
 		}
-- 
2.46.0


