Return-Path: <linux-kernel+bounces-434138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23FC9E6221
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82647282C84
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F1C17BBF;
	Fri,  6 Dec 2024 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+PBY2p0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F757464;
	Fri,  6 Dec 2024 00:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733444662; cv=none; b=Eakc/DV7QUEgTCuVAkgqSrxi0I/5B2hyy+c/zdWXatVKEhBkOtZJ01wSZYIM2L0AUdckHZlr8jFqPbAvWt4TmCygg5ySCHvJ32wgdFBGbhyxGIIAQD5WAJYohOkaIeeR1ipaCEHsWccA33P8nL+e+Mws53DIZ5idDUTvLsa7pTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733444662; c=relaxed/simple;
	bh=L7eKHfc4jfLcy6/TN60q/oxblg8UHLvSmhvoV8Od6iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PkPNZ7NQXMAQAbevarjYDJOxPeDA+8au3Uh16umdX9jB+z+igvM3DfNtb6R82KdlBr5mi6KiGgyxnMtNL5VFxkM52XAtVBU5mCNg9dNroOQuDGlJ463gpVH3mT1JhntaQ/zK11Va1lGkc40NE9zTFDnAqeAAOAN+2El2kLS0MP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+PBY2p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F22C4CED1;
	Fri,  6 Dec 2024 00:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733444662;
	bh=L7eKHfc4jfLcy6/TN60q/oxblg8UHLvSmhvoV8Od6iw=;
	h=From:To:Cc:Subject:Date:From;
	b=a+PBY2p02gxBJfElfcR6RNS5YdwtGc7ltdN1PEI/XqTt1m5SRhnM7Yfspe4SutEax
	 vjyhd0Aw9tzCg+O5UE0kceceYN4CjduNhk8LEBCVgbBkCPeHUQnktJeBcjfgnqizRY
	 sSI1gDSx03g/LH45+caEulKM2aJL6g6nsUeRl1kblFbTrRuPMDbRO/mFwQPA3MOTJs
	 aF2zeJax3zAzhPRAcQ62O+EZJHJtrYdv5jv4SgIqPfepyor/NMx/n/fYIM33XGtgTE
	 DaCPCcQmnYHAv4XRNbJLzDnJFkVlD8WP3I82mIprR4A+y8Z6wVrs9ZIU7JGjqWxZGy
	 R8clHdw0qmFrQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	liaochang1@huawei.com,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH perf/core 0/4] Improve performance and scalability of uretprobes
Date: Thu,  5 Dec 2024 16:24:13 -0800
Message-ID: <20241206002417.3295533-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Include performance and multi-CPU scalability of uretprobes by avoiding
a rather expensive (and somewhat limiting in terms of multi-CPU scalability)
use of kmalloc()+kfree() combo for short-lived struct return_instance, used
for keeping track of pending return uprobes.

First few patches are preparatory doing some internal refactoring and setting
things up for the actual struct return_instance reuse done in the last patch
of the series.

Andrii Nakryiko (4):
  uprobes: simplify session consumer tracking
  uprobes: decouple return_instance list traversal and freeing
  uprobes: ensure return_instance is detached from the list before
    freeing
  uprobes: reuse return_instances between multiple uretprobes within
    task

 include/linux/uprobes.h |  16 +++-
 kernel/events/uprobes.c | 176 +++++++++++++++++++++++++++-------------
 2 files changed, 133 insertions(+), 59 deletions(-)

-- 
2.43.5


