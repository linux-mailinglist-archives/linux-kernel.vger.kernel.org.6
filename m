Return-Path: <linux-kernel+bounces-577655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CDCA71FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B964F178319
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494B5255252;
	Wed, 26 Mar 2025 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2ARqfRg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C31F4736
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019932; cv=none; b=Gj5OBVG2avxV6N1GcSACmFu+iYoqo8/HfcW3EXe0t9H/mEo+GhqR+lb833BfYtKWedsyU2QskBPyfBq3RpOQKbS96Is4tb/qaz9YqYowtX313JapZgT+xHTSHpSJLE/jRfxo8LlN2zvQ8Ogm8GZ2hXyj5OTELpBMHFzv5SKFluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019932; c=relaxed/simple;
	bh=P2Bu+JrD1ebUe0fy98h9H0HTrMnKVVvDOMeazGj1ih0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Lkg22bKe7pCtMvuUmAz7Rw05/aoWXJH9WlmEY1x+EwUEkjqfHjxA/bvXWNkkx0qV3BMABfxkjs4dD9HZy1PN/5C0l+fTZQbu7uDDT876Geq49BRjSFT/ZLPnqyp9NTk2mssfIb5pGueioZaXAwmM8Idc1cWNhAcI+HTx0Gvhnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2ARqfRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C662C4CEE2;
	Wed, 26 Mar 2025 20:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743019932;
	bh=P2Bu+JrD1ebUe0fy98h9H0HTrMnKVVvDOMeazGj1ih0=;
	h=Date:From:To:Cc:Subject:From;
	b=s2ARqfRgjILCH1iif/OyrjXtXmzbJFZK/mHJ6g+Nce8yrMVRWqggD/DxWLt1QqnNA
	 Jb6SH+OazUcdKPKIbmM42lZYz0PoAnMkJfGO2W5nz51UcEtXHbx8Y7nSbqFPFTI11G
	 9ngHS4qkf4uFdvuNh9wyF/iI8virTirfIym+WFOXTAqGZnuJuEsBtBp4Mk8vTYjs5d
	 IRo9LswksrJoH9JJ9Qf/bckDoTerlxMW8gMN54OclRGsVG5WPY/TotRNRz5EEB4SqK
	 uzLG+5eEmHVOOzs9Gdq79ucwI7ZvlbMdvc1167ppVztKlSNr9xKJiS9bkr7+Pq7etQ
	 aajcEwoMLMDog==
Date: Wed, 26 Mar 2025 10:12:11 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.15-fixes] sched_ext: Remove a meaningless
 conditional goto in scx_select_cpu_dfl()
Message-ID: <Z-Rfm5MVdm5rDyYC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

scx_select_cpu_dfl() has a meaningless conditional goto at the end. Remove
it. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>
---
Applied to sched_ext/for-6.15-fixes. Thanks.

 kernel/sched/ext_idle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 45061b584380..b5f451e616d4 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -584,8 +584,6 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	 * increasing distance.
 	 */
 	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
-	if (cpu >= 0)
-		goto out_unlock;
 
 out_unlock:
 	rcu_read_unlock();
-- 
2.48.1


