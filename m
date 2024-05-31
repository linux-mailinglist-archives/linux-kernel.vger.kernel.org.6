Return-Path: <linux-kernel+bounces-197470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6894C8D6B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E3F28869B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FDD23777;
	Fri, 31 May 2024 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0FcRpT5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C78208D4
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188747; cv=none; b=ay3bp+Z7vp5i+5AhS8AKZbU1nAF7QuhVv44H8C2pudxvVhOFMeneDs7QS7LiKWz9Phm2bWK2/ueUFRgOJZReuLrZcC7WULyb8/PA0Tkx1IN8n8N0P7XT0npQjbPgapaPDiwZvRKaxQTk03+wV0vbUod6UoFXwSuBLYqWXA3KPrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188747; c=relaxed/simple;
	bh=x4yRE+8eJOrqN0Tg8eCdRDR/ydVszAFAvviD2pLZoPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=krwOx7X2sr9nmv0zTlBvqXzonuX2VaDPr1ouP5/fBpoaexPKCD3+EJkMvDDP06l0Xl0Esn3aclXMtRoP4ORICdKCqOv+k1RKdDhCuaq+FwwI29CMfIdcayw9juVx1sGVwe3Uaad9zbPL6E5OHcDGxt4P1wB31YH+NadihPc8i7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0FcRpT5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717188745; x=1748724745;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x4yRE+8eJOrqN0Tg8eCdRDR/ydVszAFAvviD2pLZoPA=;
  b=e0FcRpT5c94Oxjql0fTbKOkGLC10gfmFivPdM2/rxtg8goXK1U1J8T2X
   mwItITVBLFfjAziWMepcIukEafVDPoNQUXSxQ4/iUR56qJ+8un4C77YWC
   Cj8Sp5etqNNUfoVXYOhKEPOvnvoRlJ69iNoFNPnsguiGViAXv6NR1/m8J
   Ux6CeQ2O4ZTXsR0eK8iJ7VJq/QKsJgUEqIphqS2pnf4Zc7HN/bfyeW3m3
   6+1bsSd2kPVUwuR+aT4jtrWFASOB7TfZ+JJW1Xv516LtLoGAm7v413cSq
   bImRHLuDh/VGdBZIIcNGKGiOHBJ9rcTS3KRRTAyVZLYey2wdjC2fXUleW
   w==;
X-CSE-ConnectionGUID: ERis017UQhSZlHa11bN1Fg==
X-CSE-MsgGUID: FLN+L6e2Tkec3GcQfW50gg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13873119"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13873119"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 13:52:25 -0700
X-CSE-ConnectionGUID: 2nRCBILhRv+cgSARzCATcQ==
X-CSE-MsgGUID: PeXTGiktRPaD88FL+iSStA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36726557"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa006.jf.intel.com with ESMTP; 31 May 2024 13:52:25 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	Vinicius Gomes <vinicius.gomes@intel.com>
Subject: [PATCH] sched/balance: Skip unnecessary updates to idle load balancer's flags
Date: Fri, 31 May 2024 13:54:52 -0700
Message-Id: <20240531205452.65781-1-tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We observed that the overhead on trigger_load_balance(), now renamed
sched_balance_trigger(), has risen with a system's core counts.

For an OLTP workload running 6.8 kernel on a 2 socket x86 systems
having 96 cores/socket, we saw that 0.7% cpu cycles are spent in
trigger_load_balance(). On older systems with fewer cores/socket, this
function's overhead was less than 0.1%.

The cause of this overhead was that there are multiple cpus calling
kick_ilb(flags), updating the balancing work needed to a common idle
load balancer cpu. The ilb_cpu's flags field got updated unconditionally
with atomic_fetch_or().  The atomic read and writes to ilb_cpu's flags
causes much cache bouncing and cpu cycles overhead. This is seen in the
annotated profile below.

             kick_ilb():
             if (ilb_cpu < 0)
               test   %r14d,%r14d
             ↑ js     6c
             flags = atomic_fetch_or(flags, nohz_flags(ilb_cpu));
               mov    $0x2d600,%rdi
               movslq %r14d,%r8
               mov    %rdi,%rdx
               add    -0x7dd0c3e0(,%r8,8),%rdx
             arch_atomic_read():
  0.01         mov    0x64(%rdx),%esi
 35.58         add    $0x64,%rdx
             arch_atomic_fetch_or():

             static __always_inline int arch_atomic_fetch_or(int i, atomic_t *v)
             {
             int val = arch_atomic_read(v);

             do { } while (!arch_atomic_try_cmpxchg(v, &val, val | i));
  0.03  157:   mov    %r12d,%ecx
             arch_atomic_try_cmpxchg():
             return arch_try_cmpxchg(&v->counter, old, new);
  0.00         mov    %esi,%eax
             arch_atomic_fetch_or():
             do { } while (!arch_atomic_try_cmpxchg(v, &val, val | i));
               or     %esi,%ecx
             arch_atomic_try_cmpxchg():
             return arch_try_cmpxchg(&v->counter, old, new);
  0.01         lock   cmpxchg %ecx,(%rdx)
 42.96       ↓ jne    2d2
             kick_ilb():

With instrumentation, we found that 81% of the updates do not result in
any change in the ilb_cpu's flags.  That is, multiple cpus are asking
the ilb_cpu to do the same things over and over again, before the ilb_cpu
has a chance to run NOHZ load balance.

Skip updates to ilb_cpu's flags if no new work needs to be done.
Such updates do not change ilb_cpu's NOHZ flags.  This requires an extra
atomic read but it is less expensive than frequent unnecessary atomic
updates that generate cache bounces.

We saw that on the OLTP workload, cpu cycles from trigger_load_balance()
(or sched_balance_trigger()) got reduced from 0.7% to 0.2%.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..9ab6dff6d8ac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11891,6 +11891,13 @@ static void kick_ilb(unsigned int flags)
 	if (ilb_cpu < 0)
 		return;
 
+	/*
+	 * Don't bother if no new NOHZ balance work items for ilb_cpu,
+	 * i.e. all bits in flags are already set in ilb_cpu.
+	 */
+	if ((atomic_read(nohz_flags(ilb_cpu)) & flags) == flags)
+		return;
+
 	/*
 	 * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who sets
 	 * the first flag owns it; cleared by nohz_csd_func().
-- 
2.32.0


