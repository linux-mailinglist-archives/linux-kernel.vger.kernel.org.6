Return-Path: <linux-kernel+bounces-534925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC00A46CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3289316641D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163872505B0;
	Wed, 26 Feb 2025 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5VHZD2d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1FC2222A5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603417; cv=none; b=VN+drNrUfeNb+GaosLGoiJgmRTo9SEgOd2TyWU+j/0+doBXxeL2qKNxIPiYsqpmXZpguXVdFFQ/aMPkPJbZlyBSp1deB7cS1ZMAZ3v29yVg2vfqTgCi1JHMV38zkV9pGjNd4nvSUEFrvX4S4gBsrMl7WCKB32wLGF2Ba26Y9pfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603417; c=relaxed/simple;
	bh=wtrGav14nqc924JHov6dgFHD0ODvX9k7DwUCy2hUKaE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y5lDdlRbYVpaEpCD6JXYv0eykQp2hxhNa6vXTkov9E70PFVbgEkF1nIqstPg4AQLXzDM9ryqhCNDUfUvQ+IZY9hARg93X9pz/LXhBILm7vACAeL7ziTN8D+yDKfUXOpqUaO3r1TfOUvGMQlK05vOsidHJN7ZzZgQMw5f8qRdwkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5VHZD2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EF9C4CED6;
	Wed, 26 Feb 2025 20:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740603416;
	bh=wtrGav14nqc924JHov6dgFHD0ODvX9k7DwUCy2hUKaE=;
	h=Date:From:To:Cc:Subject:From;
	b=W5VHZD2d24lyT/7J1H414uYQwX3ntyTleYkyNr0oqJrKryM9GuXvWDKbX6zB5CST+
	 No4D8BVOBvFNEi9AIVVvvJIwQ9UNe3/lfHDIaXI1PT2b2vL4LbWRZxrYJvgxVxlOcN
	 W4Q/mldBFyfmOSUUtASXXizhfz3eX1cGLG/+GttxmSxGYl37obMZFyHXoGpQwY14wc
	 k77+ta02/OtLapAOpnsiaprbOETTAyXX1/p0dXtRPdH2KRAQotJsqD7Gca5vKcHupi
	 yz0kXblwaZbi35DldGSbK7KjyQJdYWA19SWWaEkogriX1v/Mu6rps+m+f9c99yobru
	 PW1ErVGlTXHLw==
Date: Wed, 26 Feb 2025 10:56:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Andrea Righi <arighi@nvidia.com>
Subject: [GIT PULL] sched_ext: A fix for v6.14-rc4
Message-ID: <Z7-AF0Oi6TF24bl5@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit f5717c93a1b999970f3a64d771a1a9ee68cc37d0:

  sched_ext: Use SCX_CALL_OP_TASK in task_tick_scx (2025-02-13 06:57:33 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.14-rc4-fixes

for you to fetch changes up to 8fef0a3b17bb258130a4fcbcb5addf94b25e9ec5:

  sched_ext: Fix pick_task_scx() picking non-queued tasks when it's called without balance() (2025-02-25 08:28:52 -1000)

----------------------------------------------------------------
sched_ext: A fix for v6.14-rc4

pick_task_scx() has a workaround to avoid stalling when the fair class's
balance() says yes but pick_task() says no. The workaround was incorrectly
deciding to keep the prev taks running if the task is on SCX even when the
task is in a sleeping state, which can lead to several confusing failure
modes. Fix it by testing the prev task is currently queued on SCX instead.

----------------------------------------------------------------
Tejun Heo (1):
      sched_ext: Fix pick_task_scx() picking non-queued tasks when it's called without balance()

 kernel/sched/ext.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
tejun

