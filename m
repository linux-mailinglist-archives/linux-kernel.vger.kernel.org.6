Return-Path: <linux-kernel+bounces-347754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C1898DE19
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F801F21276
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B90A1D04A8;
	Wed,  2 Oct 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcXqt6s2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93B12F44;
	Wed,  2 Oct 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881065; cv=none; b=My+tTUngGQ8vS5H+4tYw7Xj+t4DVbXHxv0Yvt20AxsX7OXrlvcV3VZqPv9KTGDSq5/Rj+jnZeLdUyERipeKl44I7ujZ4Pd+Lt8cCCmTu+wFvisB1buHMx6lLAHWoEcPd+V0MCfePiCMdE3ovnKAMYl5zEs7Zy/GKyT47V9x0r+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881065; c=relaxed/simple;
	bh=LQ+m8emgyeASgsohucqCHIH10ejXMfAdv2m9/v6FdLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4iBwEXsuCsIlWUFN+OKZHTQ6N2t3fCiETZhiE14EVfxzCIDHdBhugUuICTit4yfYApup2cd//IbdTPW+0pvT3rLvMiubd8UoiWvdC9rFLRcYw/yLc3qFDNXb2PLmGUbzbWyFDJCw4GQg0/bJaGihxY0Gz0FOFSQTrNfqxuVi00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcXqt6s2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706F7C4CECE;
	Wed,  2 Oct 2024 14:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881065;
	bh=LQ+m8emgyeASgsohucqCHIH10ejXMfAdv2m9/v6FdLA=;
	h=From:To:Cc:Subject:Date:From;
	b=VcXqt6s2L4lbRbUoeWo3EKyb1RktT799yPV50Sru8ZR/bzhx+lnD9vqEz54LOjfaf
	 T8sgKW+ssvKI8CiUbzXRkMri+7llI+cFtQehcAxStd5X7NZis7N+02QUX8grXBlVVL
	 Q7HFCEHoJ25eNKo15bsoYa5Igl0ecx28QhjZXgJT+EKCpzeHPA3twyJ9ZUS37RRJFB
	 O7zuEkGDzTTobkoQpOcSp7j0fjUfRC2PDSh8BU3K2dEl6Y3i9fMfL+HP7/sEdk0bck
	 z0p7YkeTvWzpljidMLaerwOdKJpj3P4Yj8SH2DkOz496MjukNaqo1/C+XJJtluOF6x
	 T+9pE0GnyIAJQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/3] rcu: Fix yet another wake up from offline related issue
Date: Wed,  2 Oct 2024 16:57:35 +0200
Message-ID: <20241002145738.38226-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A new warning has been reported due to swake_up_one_online() use
from an offline IRQ:

	https://lore.kernel.org/oe-lkp/202409231644.4c55582d-lkp@intel.com

Here is a tentative fix.

Similar issue can happen with exp kthread and GP kthread if offline tick
fires and there is a pending deferred quiescent state to report on
PREEMPT_RCU. Currently only oneshot ticks are disabled while the CPU is
offlining. I have yet to take care of the periodic tick implementation.
Work in progress...

Frederic Weisbecker (3):
  rcu/nocb: Use switch/case on NOCB timer state machine
  rcu/nocb: Fix rcuog wake-up from offline softirq
  rcu: Report callbacks enqueued on offline CPU blind spot

 kernel/rcu/tree.c      |  3 +++
 kernel/rcu/tree.h      |  1 +
 kernel/rcu/tree_nocb.h | 47 +++++++++++++++++++++++++++++++-----------
 3 files changed, 39 insertions(+), 12 deletions(-)

-- 
2.46.0


