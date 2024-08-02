Return-Path: <linux-kernel+bounces-271958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D6794556A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EB11F2275D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F3BA93D;
	Fri,  2 Aug 2024 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mywQDgBb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0AA4A00;
	Fri,  2 Aug 2024 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558861; cv=none; b=FQ3xnqWgZmfX9tMuQfJGhcIDdrcgb9ojlEZgXp/TnG1hXY+nspFRadaoQC84s1NlugCUp+6HANoaCNneM8EQx0b2nQ8i4BC3JQvrtgisOtz7YUsBZIxGE/HSZmInIi9cZrJb/IDX9jP4cN4Eas/xw91Zk/TlvuflKra8ccUFQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558861; c=relaxed/simple;
	bh=dQ40J4b/wSpKgjjEfA9lJ+zUfFA7GoFIjkpYH+ASOk0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=smiz6llTGsaaJvef7Z6arYKOnYZH9eOWdTFImDRKD4l9+FDf3tcXqrDUjAmXFDcW1Uvthk/Yae3jOvBLGTkh9XpSKw2cpaxoxynxMaf9xGS+pbc9C8DvCUuBplcn/LAWaYwbJnf+m5KA/UFWz/5TMVlp8zjbobn5z+b3VFOZpFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mywQDgBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10C4C32786;
	Fri,  2 Aug 2024 00:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558860;
	bh=dQ40J4b/wSpKgjjEfA9lJ+zUfFA7GoFIjkpYH+ASOk0=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=mywQDgBb9CY1pcKthkh2O6SHWQjGgcTgik9DKbonNdD4gAukKfhcciZynPSkMLvPT
	 AWStATYOT0360e9jGyuRE4AsbaKTwRC8zEHhP8YUjFWpuS/v1v8wtpZ/jPLMEVeox9
	 ughYKauYm6oR994do9cnbcVkXBBWX5eB6X9s1ahSZMJWz8d1Qoj8BS06S1s+S8V25x
	 nkx8bVr0w+dCQ+b9aR//MeFXdE7ijHQfB6g731e29POBCSpid4EEGW9lOig/+K1Njm
	 3NO3sDRBOJQxUgnjLjXtD90blSrff+8AqWHCcX+xXrgwa9jmgfzNXIOAqMZvOkeIS6
	 9BJNan9OVXEag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 76DC3CE09F8; Thu,  1 Aug 2024 17:34:20 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:34:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/6] Add RCU Tasks diagnostics and documentation
Message-ID: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series adds RCU Tasks diagnostics and documentation:

1.	Check processor-ID assumptions.

2.	Update rtp->tasks_gp_seq comment.

3.	Provide rcu_barrier_cb_is_done() to check rcu_barrier() CBs.

4.	Mark callbacks not currently participating in barrier operation.

5.	Add detailed grace-period and barrier diagnostics.

6.	Add rcu_barrier_tasks*() start time to diagnostics.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |    3 +
 b/kernel/rcu/rcu.h         |    5 +++
 b/kernel/rcu/tasks.h       |    1 
 kernel/rcu/tasks.h         |   75 ++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 79 insertions(+), 5 deletions(-)

