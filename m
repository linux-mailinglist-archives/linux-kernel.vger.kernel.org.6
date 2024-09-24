Return-Path: <linux-kernel+bounces-336511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711D0983BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D521C225D2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33011BC20;
	Tue, 24 Sep 2024 03:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmQv1JsT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185BC1B85D6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 03:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727149622; cv=none; b=lhOJJ/FOlDm1ycaG5XXtsnVnjm0oTrU5+CWGbSkYo0NyNVoka5ykrpztlndXK+Tax4ymAPaQcptL+T47GZikPRxqtmwwiQLTt9Pjj1cPsx/lc+zq4+0L9hwFHVfWzvmWr6/Qr2A0L/6ZNZj5EV0NACkjHXnHmQINIF/xUbxlsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727149622; c=relaxed/simple;
	bh=ZsfPtAmPCws/tonD7SZr9X6Jm5y+tkex/iMmts4C8T8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qm+VwrXncvfgw+qi11uIYNcpWMZfzYIyIWzN8CmrzxNihv+24Y1obU7HkIT7oUcPm6cbPcACQiJ69LRCusJyOgZpl32TglULWlKCcSI5u/wNz98WJFKbzLpxLkhBKnrvac+23chwz4PBip1nsYho1cizaPAeg6uP7QzxTkrRSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmQv1JsT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727149620; x=1758685620;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZsfPtAmPCws/tonD7SZr9X6Jm5y+tkex/iMmts4C8T8=;
  b=fmQv1JsTJ/K+EnH01MH00oT+P8pIASaq24jkbI57AqA/Ir/0OZKOI+Mw
   VVxRSWgQOQh2TCjBm7ks5Nm/35ciKGRTsUMvyk8IPbBkPIit6Vd5g5SQK
   zztf9gvUZa172d1OfI+A1YmXX2J9xYrB6t+LWFw3xofHLiehKsCXNeSQX
   G5Z35CLn+4d0Rb2/CmwPzi+GS+8+1JmfhYQ+AHEYroh4oxKXqNHl2sQSY
   gHHLOvxI9+8xukdyUL8AGGRnryhbk0Uw6wP/0PrPqoDTiieb+++84Yv6Z
   W24QwPJQPBzed8fkvL9O4VyZkM4BU8srSDzKW/PGKFbNLVW1EHQx4YIBs
   w==;
X-CSE-ConnectionGUID: 9uh2JSD5S3OXcv1fFwY1fw==
X-CSE-MsgGUID: 4Wk/RjYLR9OQRutTHAtrHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="37502022"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="37502022"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 20:46:59 -0700
X-CSE-ConnectionGUID: MQkvF/YbRzimdbu7jEWLqw==
X-CSE-MsgGUID: jVH5co9ySSG/rak8k4mAuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="75381335"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 Sep 2024 20:46:58 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sswVs-000Hsj-0R;
	Tue, 24 Sep 2024 03:46:56 +0000
Date: Tue, 24 Sep 2024 11:46:31 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/sched/ext.c:6053:25: error: implicit declaration of function
 'move_remote_task_to_local_dsq'; did you mean
 'move_local_task_to_local_dsq'?
Message-ID: <202409241108.jaocHiDJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   abf2050f51fdca0fd146388f83cddd95a57a008d
commit: 4c30f5ce4f7af4f639af99e0bdeada8b268b7361 sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()
date:   2 weeks ago
config: sparc-randconfig-r133-20240923 (https://download.01.org/0day-ci/archive/20240924/202409241108.jaocHiDJ-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240924/202409241108.jaocHiDJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409241108.jaocHiDJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:63:
   kernel/sched/ext.c: In function 'scx_dispatch_from_dsq':
>> kernel/sched/ext.c:6053:25: error: implicit declaration of function 'move_remote_task_to_local_dsq'; did you mean 'move_local_task_to_local_dsq'? [-Wimplicit-function-declaration]
    6053 |                         move_remote_task_to_local_dsq(p, enq_flags,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         move_local_task_to_local_dsq


vim +6053 kernel/sched/ext.c

  5977	
  5978	static bool scx_dispatch_from_dsq(struct bpf_iter_scx_dsq_kern *kit,
  5979					  struct task_struct *p, u64 dsq_id,
  5980					  u64 enq_flags)
  5981	{
  5982		struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
  5983		struct rq *this_rq, *src_rq, *dst_rq, *locked_rq;
  5984		bool dispatched = false;
  5985		bool in_balance;
  5986		unsigned long flags;
  5987	
  5988		if (!scx_kf_allowed_if_unlocked() && !scx_kf_allowed(SCX_KF_DISPATCH))
  5989			return false;
  5990	
  5991		/*
  5992		 * Can be called from either ops.dispatch() locking this_rq() or any
  5993		 * context where no rq lock is held. If latter, lock @p's task_rq which
  5994		 * we'll likely need anyway.
  5995		 */
  5996		src_rq = task_rq(p);
  5997	
  5998		local_irq_save(flags);
  5999		this_rq = this_rq();
  6000		in_balance = this_rq->scx.flags & SCX_RQ_IN_BALANCE;
  6001	
  6002		if (in_balance) {
  6003			if (this_rq != src_rq) {
  6004				raw_spin_rq_unlock(this_rq);
  6005				raw_spin_rq_lock(src_rq);
  6006			}
  6007		} else {
  6008			raw_spin_rq_lock(src_rq);
  6009		}
  6010	
  6011		locked_rq = src_rq;
  6012		raw_spin_lock(&src_dsq->lock);
  6013	
  6014		/*
  6015		 * Did someone else get to it? @p could have already left $src_dsq, got
  6016		 * re-enqueud, or be in the process of being consumed by someone else.
  6017		 */
  6018		if (unlikely(p->scx.dsq != src_dsq ||
  6019			     u32_before(kit->cursor.priv, p->scx.dsq_seq) ||
  6020			     p->scx.holding_cpu >= 0) ||
  6021		    WARN_ON_ONCE(src_rq != task_rq(p))) {
  6022			raw_spin_unlock(&src_dsq->lock);
  6023			goto out;
  6024		}
  6025	
  6026		/* @p is still on $src_dsq and stable, determine the destination */
  6027		dst_dsq = find_dsq_for_dispatch(this_rq, dsq_id, p);
  6028	
  6029		if (dst_dsq->id == SCX_DSQ_LOCAL) {
  6030			dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
  6031			if (!task_can_run_on_remote_rq(p, dst_rq, true)) {
  6032				dst_dsq = &scx_dsq_global;
  6033				dst_rq = src_rq;
  6034			}
  6035		} else {
  6036			/* no need to migrate if destination is a non-local DSQ */
  6037			dst_rq = src_rq;
  6038		}
  6039	
  6040		/*
  6041		 * Move @p into $dst_dsq. If $dst_dsq is the local DSQ of a different
  6042		 * CPU, @p will be migrated.
  6043		 */
  6044		if (dst_dsq->id == SCX_DSQ_LOCAL) {
  6045			/* @p is going from a non-local DSQ to a local DSQ */
  6046			if (src_rq == dst_rq) {
  6047				task_unlink_from_dsq(p, src_dsq);
  6048				move_local_task_to_local_dsq(p, enq_flags,
  6049							     src_dsq, dst_rq);
  6050				raw_spin_unlock(&src_dsq->lock);
  6051			} else {
  6052				raw_spin_unlock(&src_dsq->lock);
> 6053				move_remote_task_to_local_dsq(p, enq_flags,
  6054							      src_rq, dst_rq);
  6055				locked_rq = dst_rq;
  6056			}
  6057		} else {
  6058			/*
  6059			 * @p is going from a non-local DSQ to a non-local DSQ. As
  6060			 * $src_dsq is already locked, do an abbreviated dequeue.
  6061			 */
  6062			task_unlink_from_dsq(p, src_dsq);
  6063			p->scx.dsq = NULL;
  6064			raw_spin_unlock(&src_dsq->lock);
  6065	
  6066			if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_VTIME)
  6067				p->scx.dsq_vtime = kit->vtime;
  6068			dispatch_enqueue(dst_dsq, p, enq_flags);
  6069		}
  6070	
  6071		if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_SLICE)
  6072			p->scx.slice = kit->slice;
  6073	
  6074		dispatched = true;
  6075	out:
  6076		if (in_balance) {
  6077			if (this_rq != locked_rq) {
  6078				raw_spin_rq_unlock(locked_rq);
  6079				raw_spin_rq_lock(this_rq);
  6080			}
  6081		} else {
  6082			raw_spin_rq_unlock_irqrestore(locked_rq, flags);
  6083		}
  6084	
  6085		kit->cursor.flags &= ~(__SCX_DSQ_ITER_HAS_SLICE |
  6086				       __SCX_DSQ_ITER_HAS_VTIME);
  6087		return dispatched;
  6088	}
  6089	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

