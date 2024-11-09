Return-Path: <linux-kernel+bounces-402994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957059C2F5C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 20:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 048DFB21708
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAE419F462;
	Sat,  9 Nov 2024 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZazjqJy4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836F1537C9
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731181185; cv=none; b=HrNcwXk/oQQTRHeMxUYdBwlWJCAwYEWv2/yCe3HyObLyoUUiEj7tGviM4n78apbwg8OlGyUx0bOq6DbMKNc/bfXESWwb6O1gGMETrcSBMzv0qYV/Zp3dlccS8we4P/JpxIPHlSb7JvEQi5xSr4aDfsRD7q2UDq0sDeg6fIPMZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731181185; c=relaxed/simple;
	bh=9YXG5Tto0oUrXyQnPvTvND/luOgKGDFf2E5Yx/sQdr0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DZmfmvklVqHXTp8OzrkxtXKnFt0cM1zfo//38qcE30SNb4A06Q419LjPIoAogYhGX5Dwxsu4WGZm0QOwqIopy8fyosR+3HwWCt7Fs2ZmOh7JzPmMNAGgyXkqbXM+QTSm1P+BXSlRVpQMzh2dGa4gXmgocEcr+k5ewfgNnGOBwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZazjqJy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1C9C4CECE;
	Sat,  9 Nov 2024 19:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731181184;
	bh=9YXG5Tto0oUrXyQnPvTvND/luOgKGDFf2E5Yx/sQdr0=;
	h=Date:From:To:Cc:Subject:From;
	b=ZazjqJy4ocM0B7X1Dq9ckqFSjDCrs6BpC+4A+iukOcikBnXp85123ye7uSE64SAqZ
	 dbQJaLyOAOhXJ+7J9ZM+xS6DILjX9fy8PK1PeSyFuexTLYTO3VqV/KNyfiYcfGHAEB
	 xS6RJubY8BBeU7UdCcGkpBanjEaCOlG5S0AKXD8kH3fXyIkEuU2plDaTOeuFjFScYi
	 m1AK8qZFLtdDqtp0gFyUVkw6+RHuIlMpU7aB8uDrnHpbUX0uoBcBQWpEi3TtndcwcL
	 7LhPPiu91KVtzxbVqRoxGdJU6EBIwaN8yIA6niWH55FAo47RmPA2XMBaCBsiHZpE2S
	 lX/tRq7CumQPg==
Date: Sat, 9 Nov 2024 09:39:43 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com
Subject: [PATCH sched_ext/for-6.13] sched_ext:
 scx_bpf_dispatch_from_dsq_set_*() are allowed from unlocked context
Message-ID: <Zy-6fzvwSSpVCt09@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
added four kfuncs for dispatching while iterating. They are allowed from the
dispatch and unlocked contexts but two of the kfuncs were only added in the
dispatch section. Add missing declarations in the unlocked section.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
---
Applying to sched_ext/for-6.13.

Thanks.

 kernel/sched/ext.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6766,6 +6766,8 @@ __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
 BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_unlocked)

