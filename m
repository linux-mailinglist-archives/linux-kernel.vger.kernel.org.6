Return-Path: <linux-kernel+bounces-319325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D9996FB20
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3892328D83D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7F8EAE7;
	Fri,  6 Sep 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbMItjVq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9221B85C0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646594; cv=none; b=UngaMVZQJE5odm46kuA/WMPW4kuKVYyyRqMn8eGp28Lmd0xg/Bd96Vccsdq8KSFGE+5z4XBIe11Hqb6WVTJQyWBXaCcEEdM/tKcXiSl23sF/KlaDoyI2LJPqp0tRXmugOfl72B3J5t3yiVGLf/4yuMfyj5P0JiOmSHdUEa6kBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646594; c=relaxed/simple;
	bh=GZHL7D+MBgYcABBKs+FeN0MX0EQs2lTWirBYm7V2E+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEVFsYl96bl5e3MxGxI7VmYXVH1ThED3R+vZ0OtVLv3Pkn3n3TRQ21dQpBmIEfXWq8TsVcrSwKjT+9UmVAYuWrrnVUboD6TAWYKrJN48ewfkJ3BTeFsA4Ye1ORjmopGQGhOk7bikUepBgJ6fe0yt84w/g3wP6NDf5/Z9/AEH+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbMItjVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D293FC4CEC4;
	Fri,  6 Sep 2024 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725646594;
	bh=GZHL7D+MBgYcABBKs+FeN0MX0EQs2lTWirBYm7V2E+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbMItjVqVulKodaFgM+uZuW80Y4XrNATowby9UEtkuVidVTqYoccKocW/754+7ydW
	 ueswCELfej6R9VvefZG/EbTiQ1ZrseQ9f/tsIrUIbsYPVDntGvlHJxRAW1/0euBxHh
	 8PkwI9YViLzMyJ9pC/WFFKfEBopRDhkAxUuQ3itodEo7HJpTtCyKj2za7wGMF01r7+
	 G+ZDnAAyljBHMGwPdNCnJsdnWsKqvFcwGIwsb+fVAHhsnJr2yRULeERqFLCxiEPfWn
	 15vn/Ssj6N4e2jJ+UQgmlNVU+uv+SXgtpwh22gM8imyQzjHSExGTV/PtCNDrCz4wkC
	 OO1KlBXKKTCRA==
Date: Fri, 6 Sep 2024 08:16:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH sched_ext/for-6.12] sched_ext: Temporarily work around
 pick_task_scx() being called without balance_scx()
Message-ID: <ZttHAAcXOGimyBuc@slm.duckdns.org>
References: <Ztj_h5c2LYsdXYbA@slm.duckdns.org>
 <20240905092858.GA15400@noisy.programming.kicks-ass.net>
 <20240905150012.GF4928@noisy.programming.kicks-ass.net>
 <ZtnfRnmo-EpWKcyC@slm.duckdns.org>
 <ZtpYGQ73WQcb95Fe@slm.duckdns.org>
 <20240906090420.GU4723@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906090420.GU4723@noisy.programming.kicks-ass.net>

pick_task_scx() must be preceded by balance_scx() but there currently is a
bug where fair could say yes on balance() but no on pick_task(), which then
ends up calling pick_task_scx() without preceding balance_scx(). Work around
by dropping WARN_ON_ONCE() and ignoring cases which don't make sense.

This isn't great and can theoretically lead to stalls. However, for
switch_all cases, this happens only while a BPF scheduler is being loaded or
unloaded, and, for partial cases, fair will likely keep triggering this CPU.

This will be reverted once the fair behavior is fixed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
Applying a simpler workaround to sched_ext/for-6.12 for the time being.

Thanks.

 kernel/sched/ext.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2909,9 +2909,24 @@ static struct task_struct *pick_task_scx
 	 * If balance_scx() is telling us to keep running @prev, replenish slice
 	 * if necessary and keep running @prev. Otherwise, pop the first one
 	 * from the local DSQ.
+	 *
+	 * WORKAROUND:
+	 *
+	 * %SCX_RQ_BAL_KEEP should be set iff $prev is on SCX as it must just
+	 * have gone through balance_scx(). Unfortunately, there currently is a
+	 * bug where fair could say yes on balance() but no on pick_task(),
+	 * which then ends up calling pick_task_scx() without preceding
+	 * balance_scx().
+	 *
+	 * For now, ignore cases where $prev is not on SCX. This isn't great and
+	 * can theoretically lead to stalls. However, for switch_all cases, this
+	 * happens only while a BPF scheduler is being loaded or unloaded, and,
+	 * for partial cases, fair will likely keep triggering this CPU.
+	 *
+	 * Once fair is fixed, restore WARN_ON_ONCE().
 	 */
 	if ((rq->scx.flags & SCX_RQ_BAL_KEEP) &&
-	    !WARN_ON_ONCE(prev->sched_class != &ext_sched_class)) {
+	    prev->sched_class == &ext_sched_class) {
 		p = prev;
 		if (!p->scx.slice)
 			p->scx.slice = SCX_SLICE_DFL;

