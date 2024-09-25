Return-Path: <linux-kernel+bounces-337814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E49984F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6ABE2841E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBF7256D;
	Wed, 25 Sep 2024 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajhUXtgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7AE1870
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222787; cv=none; b=G9gZ3DYIfpC5rdGtFlIej8BgsPRSmrGNzZ3+v2/k6P8TnTXwOajwQ/hoxYsPTuvWxcTHvVbme734C+HIX7fdmpp+4iZXyCI2F6dAcndb96dnNpVd0PR8OUhIruTeVLghaMiSTm3c9Rr32R3IrQUXAJ/9IMwVsTJC93b+fyibqbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222787; c=relaxed/simple;
	bh=kNsTps8+wc0qKcjcHlTgAAU9oCTvxjbwqehgmHIjbWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON/bCxyxnVvOcp/Eobtbk6TlGZvfJW3iiihXKlWC/j36OlUBX8vmGvLOn6bHSrBsf2atjNyGn+UH3GhgYPMxCdadkjinbZbJS+TSuNOSU4hz3coHpcUpZHii1Dnj9q3tNBLF2jQPcGX06e1bfSlwY1jZUKTyfDcB0jO9DoYNZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajhUXtgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD5BC4CEC7;
	Wed, 25 Sep 2024 00:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727222787;
	bh=kNsTps8+wc0qKcjcHlTgAAU9oCTvxjbwqehgmHIjbWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ajhUXtgTt/pM6ao+g8FokAXHqGANQg5dWSBNdi4K0e9qWKhSkmgl/b1LJlGZpIfzZ
	 XyiS8KKYz5AMD9ziCWd5cRGjQ50HNHOWOopVb/IVpEiDM3DpCaZJwpVFVziCxU96Rg
	 56W887yT4JtEOuSDA0HMLSw44ZiwWW4oIpb0mCymr6+JCr1ViPhPM6vx4uQHB0dvFq
	 FfPdiTmlqRO4CTI0OLA7JxuaNKC/z/f+JQcNfbQoR9mnBMHjo2EMiFYr4uOI5YviBU
	 RewCqg7nfs8yA+Cv5Zal6SkKgE5N3ZJbnEJ25iEDit1yYUeUlW5vJ9haxE8hDzbSvH
	 BVNbj3p643zWg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/5] scx_flatcg: Use a user DSQ for fallback instead of SCX_DSQ_GLOBAL
Date: Tue, 24 Sep 2024 14:06:03 -1000
Message-ID: <20240925000622.1972325-2-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240925000622.1972325-1-tj@kernel.org>
References: <20240925000622.1972325-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_flatcg was using SCX_DSQ_GLOBAL for fallback handling. However, it is
assuming that SCX_DSQ_GLOBAL isn't automatically consumed, which was true a
while ago but is no longer the case. Also, there are further changes planned
for SCX_DSQ_GLOBAL which will disallow explicit consumption from it. Switch
to a user DSQ for fallback.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_flatcg.bpf.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 3ab2b60781a0..5027aafb2682 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -49,7 +49,10 @@
 /*
  * Maximum amount of retries to find a valid cgroup.
  */
-#define CGROUP_MAX_RETRIES 1024
+enum {
+	FALLBACK_DSQ		= 0,
+	CGROUP_MAX_RETRIES	= 1024,
+};
 
 char _license[] SEC("license") = "GPL";
 
@@ -378,7 +381,7 @@ void BPF_STRUCT_OPS(fcg_enqueue, struct task_struct *p, u64 enq_flags)
 			scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
 		} else {
 			stat_inc(FCG_STAT_GLOBAL);
-			scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+			scx_bpf_dispatch(p, FALLBACK_DSQ, SCX_SLICE_DFL, enq_flags);
 		}
 		return;
 	}
@@ -781,7 +784,7 @@ void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
 pick_next_cgroup:
 	cpuc->cur_at = now;
 
-	if (scx_bpf_consume(SCX_DSQ_GLOBAL)) {
+	if (scx_bpf_consume(FALLBACK_DSQ)) {
 		cpuc->cur_cgid = 0;
 		return;
 	}
@@ -838,7 +841,7 @@ int BPF_STRUCT_OPS_SLEEPABLE(fcg_cgroup_init, struct cgroup *cgrp,
 	int ret;
 
 	/*
-	 * Technically incorrect as cgroup ID is full 64bit while dq ID is
+	 * Technically incorrect as cgroup ID is full 64bit while dsq ID is
 	 * 63bit. Should not be a problem in practice and easy to spot in the
 	 * unlikely case that it breaks.
 	 */
@@ -926,6 +929,11 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 	p->scx.dsq_vtime = to_cgc->tvtime_now + vtime_delta;
 }
 
+s32 BPF_STRUCT_OPS_SLEEPABLE(fcg_init)
+{
+	return scx_bpf_create_dsq(FALLBACK_DSQ, -1);
+}
+
 void BPF_STRUCT_OPS(fcg_exit, struct scx_exit_info *ei)
 {
 	UEI_RECORD(uei, ei);
@@ -944,6 +952,7 @@ SCX_OPS_DEFINE(flatcg_ops,
 	       .cgroup_init		= (void *)fcg_cgroup_init,
 	       .cgroup_exit		= (void *)fcg_cgroup_exit,
 	       .cgroup_move		= (void *)fcg_cgroup_move,
+	       .init			= (void *)fcg_init,
 	       .exit			= (void *)fcg_exit,
 	       .flags			= SCX_OPS_HAS_CGROUP_WEIGHT | SCX_OPS_ENQ_EXITING,
 	       .name			= "flatcg");
-- 
2.46.0


