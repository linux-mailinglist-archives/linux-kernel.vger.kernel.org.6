Return-Path: <linux-kernel+bounces-572097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1902FA6C66F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45DAE7A5592
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81BE22155E;
	Fri, 21 Mar 2025 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlYTX96u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37E19007D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742599991; cv=none; b=tbNl8MZ1nNMgoyDd3r2uqTYn96e6wxfIN1qrOXOuu9rAPJWqwqWTX9osphip/d1cqeinyvP2FdqrJ/ywY2pAITYW5oWBT96AON/VeXGpz2dCTw9X8EJVS/wFGG0Br1OTtoyyRLTpI/oMJx77lDUJDzL4BT5IA67lvF8kW6eN58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742599991; c=relaxed/simple;
	bh=HKG6pqnyHQn+e766ETMQO+3qbtt2ptfRLWDnx9u+O0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ssz/SW/Iv+H9K/V3fb2jnmc8gf/8aPRT//i915vsjoSctQ34u3k7uqZZYyzm7F113a8XaV4Pi9DegYziYTFwpQRXxa2m9elcs/0z2XbfiRKNuiCmQ7UYOTclFqtOCxUuWGbYN3nMjuTnTcjlSlkkwpDT/Qye+6HbkV6DoQ2tM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlYTX96u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B99BC4CEE3;
	Fri, 21 Mar 2025 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742599989;
	bh=HKG6pqnyHQn+e766ETMQO+3qbtt2ptfRLWDnx9u+O0M=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=hlYTX96ulge67fR/x0Fi4zF0DGDwf/ZsEXU+ZaY0s+dplrY9/lLrhzUgelHG/OLRA
	 scutthEMq0WJIhfRE1y99YteW3Bq5wwpPyfVcV954aIw38Zo4ISm6x7FiJRMaCWvE0
	 jx2b9aQXYEg2Z63qJTdMRS4KniiHahkZL5HK3J6whIedsmz0rmEiXzMi4AinbfYRe1
	 N0dt6i29KSOMX9ZkTL3oIFibN06RmtwruICDvKIZLpvwobOH7S25PsKNnzO+FNzHjM
	 6lubSp/2ta9h/z2tJx25wTSw78vaKWfWh2CJ2Fp4FiZ4sgCISKUwcxNWaIajbjCJgW
	 kmQ2VChoenIDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 18FA3CE0D1D; Fri, 21 Mar 2025 16:33:09 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:33:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, tglx@linutronix.de,
	vschneid@redhat.com, neeraj.upadhyay@kernel.org,
	frederic@kernel.org
Subject: [GIT PULL] Stop-machine change for v6.15
Message-ID: <a64ef1d7-95c3-487d-8c72-2343580bad95@paulmck-laptop>
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

Once the v6.15 merge window opens, please pull this stop-machine update
from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu tags/stop-machine.2025.03.21a
  # HEAD: 2af8780d6c8addecda5a0f624c4f084a3a9578fe: stop-machine: Add comment for rcu_momentary_eqs() (2025-03-11 10:15:52 -0700)

----------------------------------------------------------------
stop-machine: Add a comment for rcu_momentary_eqs()

Changes
-------

* Add a comment for the call to rcu_momentary_eqs() from multi_cpu_stop()
  explaining that its purpose is to suppress false-positive RCU CPU
  stall warnings.

----------------------------------------------------------------
Paul E. McKenney (1):
      stop-machine: Add comment for rcu_momentary_eqs()

 kernel/stop_machine.c | 1 +
 1 file changed, 1 insertion(+)

