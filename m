Return-Path: <linux-kernel+bounces-551069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839C3A567C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB366174329
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAF6218EB7;
	Fri,  7 Mar 2025 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HI7aHCn3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D738218E99
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350330; cv=none; b=YOe7ayTih4EH4DO1N6WX56PYK37VypDtPLfxM9oX8YqeE65j5OyX9SesYbSk302gc6JyfMjRWQPfJ/9blx602+iilKbNRv4gWV89wyMR6llWUtwPi6xjSbAUKTZh9aqOMB4bwsLMxsvtCL+etWIHg48CkU9en3Ob/ImxNCbmk3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350330; c=relaxed/simple;
	bh=xI8knybLezYjJtgoCWfbOC/GevpO0GqbS04MWnM1+6c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sl+zegxOPhuzTfBehfGJ9v+z+H71pvmowmFHHvQKa5SvzBTqfoq/pZ4bkuSOAj1Wa98dftEEb+IYkPGiSJe3uPfhZXz5mg2KloW4kQ9jeM5I3E+RY4BpAFjsZR8IOW7Ko5MdxtLTGvb1ATcImp3wEmltKCIB8kYH7qp6g99NZUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HI7aHCn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772B5C4CED1;
	Fri,  7 Mar 2025 12:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741350329;
	bh=xI8knybLezYjJtgoCWfbOC/GevpO0GqbS04MWnM1+6c=;
	h=Date:From:To:Cc:Subject:From;
	b=HI7aHCn3PFVzVYothDmkEFxDsgZDMHloB6Q1XlIEoKygD7NCZKzmJkUoDfid3wsrO
	 hm2PK5WEy00z0MSdQ04p0TJ7ZrquXFWdzBWi8YUv+ILkSdoWUfZRf3sB7K+zS3D79+
	 D+W8xNKFSCRxYGGiEyTJ0lRXH3kE0RBc/xF2teWy5nWmc8+IeZgEwn7UdX9maCYM1y
	 WL5+TrrVnCxaRlCc8/R3laICJAswaQ0KyIZZ3sChk6nAvuitRPX5nef5mqfWZjacbc
	 EaJB1csFKkLS2TBW9Nxrxjtxi2wMHuM9YA0sbifNFEKw5NWk1C+VUCnxh6sw03gvLe
	 fURKxIeC+gIzQ==
Date: Fri, 7 Mar 2025 13:25:23 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] scheduler fixes
Message-ID: <Z8rls13KRGROvcZ7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest sched/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-03-07

   # HEAD: b1536481c81fb604074da799e4f2d2038a1663f7 sched/rt: Update limit of sched_rt sysctl in documentation

Miscellaneous scheduler fixes:

 - Fix deadline scheduler sysctl parameter setting bug
 - Fix RT scheduler sysctl parameter setting bug
 - Fix possible memory corruption in child_cfs_rq_on_list()

 Thanks,

	Ingo

------------------>
Shrikanth Hegde (2):
      sched/deadline: Use online cpus for validating runtime
      sched/rt: Update limit of sched_rt sysctl in documentation

Zecheng Li (1):
      sched/fair: Fix potential memory corruption in child_cfs_rq_on_list


 Documentation/scheduler/sched-rt-group.rst | 3 +++
 kernel/sched/deadline.c                    | 2 +-
 kernel/sched/fair.c                        | 6 ++++--
 3 files changed, 8 insertions(+), 3 deletions(-)

