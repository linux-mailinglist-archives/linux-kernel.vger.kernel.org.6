Return-Path: <linux-kernel+bounces-327095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025A29770F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310C51C22F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698861BFDEB;
	Thu, 12 Sep 2024 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2kiwRCE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40613DBBE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167531; cv=none; b=Bctf9huGLxkoGlx/aN7+NOZSK40RiPb5gaymbZStJWEdLqv3klRVI1pxEkvRb7xWulXqapG0nkZ3vknHYsolZ2mLjY4DCcbhTRjoAg6/n0H01UE2m68sbNCvuSfMA/qHV74tijaJEyOnmaVJ+e/KW/XbukZFUCDqxbYCmx0ssBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167531; c=relaxed/simple;
	bh=pU7PzMLkb5uU3kRjiadbKr90I3ntFHmdHWsgwhgfzk4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aIxCdZRv7ZFbS7MLG9PMgtUPUOs///BROzjuEyVRE2RmSkse7VhHBUt+ysiXBKKSy3pC2ETq2S9sBXKGDTPvQS9O0oAXF1uNm8HmLMpnLmrx7sdjeOfrpu+8ihm0MPuU8BnjmZJqq2WKIfsukHDnGvTOVm3MHWuoTn5YvuxDyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2kiwRCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA2EC4CEC3;
	Thu, 12 Sep 2024 18:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726167531;
	bh=pU7PzMLkb5uU3kRjiadbKr90I3ntFHmdHWsgwhgfzk4=;
	h=Date:From:To:Cc:Subject:From;
	b=r2kiwRCETFTPt41zUWZXKcApkn8ZTR3SzT1UkQnEaaB6pyuy6Dpava6GRg2eItOwW
	 QzgoZrQdGxyop+ispJI2JyaSPklSk/CG90fmdJZ1oHPHq7MetDOB5CyXY0WuMFn9c+
	 D27c4VueFtIfW+ngSlwJ1LFj5WseFMTBYAIw/xm36dv18Ajvup2uIbAr3wIBK5yGHS
	 mZI9noBAStY2ivehELdnc/Th6GSvP15a7nZ9AThgtbULl9pTcpBnTUa/qSIoogBY0c
	 2n8ZnHI1BbMJJthyyOBp0W03Pp/nAkZg9zF62CWtA71socykVD/N+faYg1oAJ021XB
	 nW3NeL7D6JAkw==
Date: Thu, 12 Sep 2024 08:58:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue: Fixes for v6.11-rc7
Message-ID: <ZuM56t-kul8mRw9d@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c4c8f369b6a6d21ce27286de1501137771e01dc3:

  workqueue: Correct declaration of cpu_pwq in struct workqueue_struct (2024-08-05 18:34:02 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.11-rc7-fixes

for you to fetch changes up to 73613840a8896f4f859eea489cb4a7a656939e70:

  workqueue: Clear worker->pool in the worker thread context (2024-09-11 19:58:20 -1000)

----------------------------------------------------------------
workqueue: Fixes for v6.11-rc7

Contains the fix for a NULL worker->pool deref bug which can be triggered
when a worker is created and then destroyed immediately.

----------------------------------------------------------------
Lai Jiangshan (1):
      workqueue: Clear worker->pool in the worker thread context

 kernel/workqueue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
tejun

