Return-Path: <linux-kernel+bounces-299805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD9495DA3E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756B9284AE8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB50257D;
	Sat, 24 Aug 2024 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJiBFL9J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FD161
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 00:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724460297; cv=none; b=mJxRDyvuZt0ZA7SCzvrGT4UvwWs3Bwr78qtkXRQdqTHK3ZFZzR+ktxb30dYQ9xJ9pMLn4Dyyg1tIc90qlllkwAbT6Rl+a2RGLuFUKmDRGsUSM0WXfypm1YpdFwKUMZAQN/dJgLE9c/7iv3IeOvTqDg2CWazCR8LFZJJGU+pTgZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724460297; c=relaxed/simple;
	bh=HHEjcaYJKwK2DJBCvLb41BHJFBYqPtFELEzoih4Ng2M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bCZDU4V0UzPWfrL2mdPF6syzTjZVrl/LtPg7/p3yEdX/QP0J12ST+s9J8JsWFJgO8Us3xYfvkVb81S3IkJqXWF86gcn0BujAOlR58vhw1mvDlNYpUtmw4qe+GQVAI/US0qFI/pxaa6K2whwQGgGummCr2yWI0VAY0stzi9E2fds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJiBFL9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923B5C32786;
	Sat, 24 Aug 2024 00:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724460296;
	bh=HHEjcaYJKwK2DJBCvLb41BHJFBYqPtFELEzoih4Ng2M=;
	h=Date:From:To:Cc:Subject:From;
	b=QJiBFL9JpfD6tSf//s4VNTTx0bHJTbmOhQBJrCbt+rDJGmNd0iW20sKqLNksuk8nP
	 PAKGSuscHZWY81rIAXZgiiM9NrF/AOTmcMOD36agbddTp0FOomuqT6RbjQ6W7LP4fw
	 8h59rSgTKJujj3flNQ/T/TWmCJRB/wU+yBrKDYay7n/qX2XiXwxQQoGdofXfct7r0P
	 AvyGOqH30O327vPZhkRvFcsshmQWt0gmODTkjgL3IKoCY7XQYCXQr5yOqfK7teuv+J
	 8I50YmUIXyD1RoWIw8Oxrt1SA8cJOtkGlfxsh55kg120i9teDZawY/tJuSwhJ9tKdd
	 qlvDspvmpCscw==
Date: Fri, 23 Aug 2024 14:44:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue fixes for v6.11-rc4
Message-ID: <ZsktB3D_K-80uc35@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.11-rc4-fixes

for you to fetch changes up to c4c8f369b6a6d21ce27286de1501137771e01dc3:

  workqueue: Correct declaration of cpu_pwq in struct workqueue_struct (2024-08-05 18:34:02 -1000)

----------------------------------------------------------------
workqueue: Fixes for v6.11-rc4

Nothing too interesting. One patch to remove spurious warning and others to
address static checker warnings.

----------------------------------------------------------------
Lai Jiangshan (1):
      workqueue: Remove incorrect "WARN_ON_ONCE(!list_empty(&worker->entry));" from dying worker

Nikita Shubin (1):
      workqueue: doc: Fix function name, remove markers

Tejun Heo (1):
      workqueue: Fix spruious data race in __flush_work()

Uros Bizjak (1):
      workqueue: Correct declaration of cpu_pwq in struct workqueue_struct

Will Deacon (1):
      workqueue: Fix UBSAN 'subtraction overflow' error in shift_and_mask()

 Documentation/core-api/workqueue.rst |  2 +-
 kernel/workqueue.c                   | 50 +++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 24 deletions(-)

