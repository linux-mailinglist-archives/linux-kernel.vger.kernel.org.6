Return-Path: <linux-kernel+bounces-348216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0C98E434
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BAF1C22D18
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E6A216A21;
	Wed,  2 Oct 2024 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYb4/XA6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CD781720
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901279; cv=none; b=jndv2efIVuYC2NsDlxQb863/5uyLh2FdPIqffRh6fsGW2zQ7LV/eAB9XkbnOjSH9TULBKBqiZrwJxT0J0R7Vi+UYLe9RGTKkCX+slmQhTHXj4CpZ/QT7l0khMq1VIYsK7UJOXUkP8LFsvOimJ05Yb5hSLFsuPX8BfZpqMlFdcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901279; c=relaxed/simple;
	bh=BuOTIuN7kMUN1otA9h9fZ7pefULgH3MQ/PzB4PCxyMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MSYdfWuFh7VxMzhwAGws4WYCEmj992CDkZiFyw2g1+/sNuhvgU3+6AJ/zY5VatEfDpf3QZv2zTNpb6WlpaThq9Qqbxf4vLsE7LZYKL+eGZNDb9PyMq4NY9WHQ+pEpvsUJGqI1etEnh/iVGdN6JcbowDceSqREMrMumerX+hjwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYb4/XA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D9DC4CEC2;
	Wed,  2 Oct 2024 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727901279;
	bh=BuOTIuN7kMUN1otA9h9fZ7pefULgH3MQ/PzB4PCxyMc=;
	h=Date:From:To:Cc:Subject:From;
	b=SYb4/XA6rgbdLWrOM7/5ElFD0HXODv4xW0gG2B3ZcKs36AX5lgFHNcjACqsdjaIvL
	 ahT+/RWyk6d74fV/evbb3fL0WkNDKKDrbi3u/0l50SpBX89fsabDWo84zx4kW6Txk1
	 JOyYCGGKDDEYRIw33wh21Hq6v1NrSGN+p5nobrOCNR0dpKV8nBX1tqw+O7SdttBzvQ
	 ruSE9lFx/AgsCgJOWRo25z6izybPS+aTBXTGySNigMl2jsEMGl95KoQnLov+kEuZB6
	 wkWuxmBTG7lKgymFnkMOIaFfmrhynZgyYHVSxE05YiLxRVCaP0vzD7ZC/2mB9NslsX
	 u37gbKheHJPug==
Date: Wed, 2 Oct 2024 10:34:38 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.comm, sched-ext@meta.com
Subject: [PATCH sched_ext/for-6.12-fixes] sched_ext: scx_cgroup_exit() may be
 called without successful scx_cgroup_init()
Message-ID: <Zv2uXn0bP-YDCkc_@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

568894edbe48 ("sched_ext: Add scx_cgroup_enabled to gate cgroup operations
and fix scx_tg_online()") assumed that scx_cgroup_exit() is only called
after scx_cgroup_init() finished successfully. This isn't true.
scx_cgroup_exit() can be called without scx_cgroup_init() being called at
all or after scx_cgroup_init() failed in the middle.

As init state is tracked per cgroup, scx_cgroup_exit() can be used safely to
clean up in all cases. Remove the incorrect WARN_ON_ONCE().

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 568894edbe48 ("sched_ext: Add scx_cgroup_enabled to gate cgroup operations and fix scx_tg_online()")
---
 kernel/sched/ext.c |    1 -
 1 file changed, 1 deletion(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4119,7 +4119,6 @@ static void scx_cgroup_exit(void)
 
 	percpu_rwsem_assert_held(&scx_cgroup_rwsem);
 
-	WARN_ON_ONCE(!scx_cgroup_enabled);
 	scx_cgroup_enabled = false;
 
 	/*

