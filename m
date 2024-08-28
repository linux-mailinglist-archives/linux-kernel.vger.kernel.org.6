Return-Path: <linux-kernel+bounces-304148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD96961B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373CBB21A00
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32EA101EE;
	Wed, 28 Aug 2024 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLV8/KC9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6DD512
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724804454; cv=none; b=PPtXs+oCZcrYVuDXln6LrgcsxOn+2Mtafa9ddlbIqwy+7e9wMClc2N0oynEHeAdFwKqjH2ZmQ8ipECbddRgG92rN6h6+wC0ojKQUYb617/YETUW7DwFWu3/70elBkSWcMp/BEu9Tzdx9iYXw5dwLbqgwiF239VLWb0D+khpIuEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724804454; c=relaxed/simple;
	bh=cr2epjNuymrlcrOKG8uBpd3a7MuHtxq2kTQeIR2lt4A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gMHI9F7H/3HZ6lX7dMv4OktxxXdOV4Ixx3Txtask7w7nOzWR5tAfblYIxLVahvmLrS6lQ/Wj9VL2yTfmP1siL/2a2mcc/hByInF2ZON9qKnn3oGcWTe1SdB9EbcmmrQQn/HCIlYVuznp4QhG0cs/rotDnF2iDwnyhosHOXlLBnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLV8/KC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C5CC4DE1A;
	Wed, 28 Aug 2024 00:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724804453;
	bh=cr2epjNuymrlcrOKG8uBpd3a7MuHtxq2kTQeIR2lt4A=;
	h=Date:From:To:Cc:Subject:From;
	b=VLV8/KC9q+sGbTFWd7E5IUs310IkgOVFgdc1gJnEgMMigslMbmJndOgHGW7gFx6vn
	 M5MAPngA69vCnjDAxq+rJXI1ZwA5JG2IebbE1GF+fmUYOlWSYv+pYtj8EbxXnNGuzO
	 PnjBWljZfwz8VmJnmJJJshsOZgtGt7JkP5ZkKLpTtJ6Rf5MtrUOEDGrTHafzyKO3q/
	 rvw/Cg5e2rNIgi5xzv/wL1hth1mkCsT9o4/wa+Q0pByfqb0cso6WnjFHI82eabkCx3
	 7BMAUwDa6MjlaAjqqROeOJxrHCRD5gf2DyW1ZpwNM1/SL2B25JCyTiHIoZUJ3hyOxC
	 NeH044gM/0euA==
Date: Tue, 27 Aug 2024 14:20:52 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.12] sched_ext: Add missing cfi stub for
 ops.tick
Message-ID: <Zs5tZFZvlwpU_av-@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From bf934bed5e2fd81f767d75c05fb95f0333a1b183 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 27 Aug 2024 14:17:20 -1000

The cfi stub for ops.tick was missing which will fail scheduler loading
after pending BPF changes. Add it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applying to sched_ext/for-6.12.

Thanks.

 kernel/sched/ext.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b9bf9ee5ed01..57f30b1604db 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5051,6 +5051,7 @@ static s32 select_cpu_stub(struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 static void enqueue_stub(struct task_struct *p, u64 enq_flags) {}
 static void dequeue_stub(struct task_struct *p, u64 enq_flags) {}
 static void dispatch_stub(s32 prev_cpu, struct task_struct *p) {}
+static void tick_stub(struct task_struct *p) {}
 static void runnable_stub(struct task_struct *p, u64 enq_flags) {}
 static void running_stub(struct task_struct *p) {}
 static void stopping_stub(struct task_struct *p, bool runnable) {}
@@ -5079,6 +5080,7 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.enqueue = enqueue_stub,
 	.dequeue = dequeue_stub,
 	.dispatch = dispatch_stub,
+	.tick = tick_stub,
 	.runnable = runnable_stub,
 	.running = running_stub,
 	.stopping = stopping_stub,
-- 
2.46.0


