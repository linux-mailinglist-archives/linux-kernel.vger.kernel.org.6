Return-Path: <linux-kernel+bounces-329242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E057978F0D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325221C2545A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085ED13C90F;
	Sat, 14 Sep 2024 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUmjxD+O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8561FFC
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726301801; cv=none; b=oRdBOaWwR4RFS2DQMYD4J5gE5hmXkc7oot6Ewswhcc38PoObt+Jam8X6Lp4dFVodYu3Nyj6DJpwckAVvMYNEM1BOpDVmE7BnQBBZb7ydy8HD+m6Y1S3HAKjus/1Mi1vryI/8csp26UURBbCLihI+sRUE2PT0sS1NSIGXZtYumig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726301801; c=relaxed/simple;
	bh=kzKk5Q06zQ1pwbZrZjIXTAuOQYsUk99hu7LQcJDwHw0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cjWeFwHqXQPzAefhuG6haiDaL+Ao6cAXWnvRaSXcd3+b3Vc/E61Fkf02UP7lYYWy6atjESWP2Zzv0cuSWiQc5yfmy0tdxSSk4aVZn4/LClnIPWi5cxmzyvFVmC+HW7xkOoXShdMOifucb0Ec+B4QD+62sGWqpHW24Dk9/IDxpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUmjxD+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2758C4CEC0;
	Sat, 14 Sep 2024 08:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726301801;
	bh=kzKk5Q06zQ1pwbZrZjIXTAuOQYsUk99hu7LQcJDwHw0=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=iUmjxD+OIseIe9D1FnkRRAF1J/m9oN7LMjYRGMNdhpZzu4gbdjynU9Xj00rX0/Vgh
	 UrGIEYN0dBTlI+QINZ6SxuZ6MI46HNRn929FP+70hfzdR5tjvDoDKz2bli/eMpVRqe
	 EUw0s+WCoyACcIYix1BfotT61xqok9xMG7A2EHl9kquB/P9JrdYZIITBGN+XvTv+BC
	 RyGww8btoSJlWXf9+JtjawlyWO4L9MpGDq2Tn+OqUz8JfxdR9daIAcMgqyw+ghZOcK
	 nVFXC8ta17tZtnDe8nI5BACM701yeQY+sq6KvWnPS+6+j4HGa00PD2emORFvygvNCI
	 0B/RGHOCxK4BQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8619BCE0E7A; Sat, 14 Sep 2024 01:16:38 -0700 (PDT)
Date: Sat, 14 Sep 2024 01:16:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, oleg@redhat.com,
	axboe@kernel.dk, brauner@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, clm@fb.com, riel@surriel.com
Subject: [GIT PULL] exit/core-dump non-urgent sleep for v6.12
Message-ID: <bb2c5f74-2f89-4bb5-9d49-3061c218dde9@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

When the merge window opens, please pull the following exit-path
application core-dump commit for v6.12:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/misc.2024.09.14a
  # HEAD: b8e753128ed074fcb48e9ceded940752f6b1c19f: exit: Sleep at TASK_IDLE when waiting for application core dump (2024-08-02 10:55:04 -0700)

No, this is not my usual part of the kernel, but it does have Oleg
Nesterov's ack.

----------------------------------------------------------------
exit: Sleep at TASK_IDLE when waiting for application core dump

This causes the coredump_task_exit() function to sleep at TASK_IDLE,
thus preventing task-blocked splats in case of large core dumps to
slow devices.

----------------------------------------------------------------
Paul E. McKenney (1):
      exit: Sleep at TASK_IDLE when waiting for application core dump

 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

