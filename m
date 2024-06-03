Return-Path: <linux-kernel+bounces-199419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E498D86FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C622281A90
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CE2135A4B;
	Mon,  3 Jun 2024 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGzVvi4g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE412D205
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431370; cv=none; b=H1sMPVhUfnuG3lVEA8KtrJ5bx/wBWegB5tR5LsR3r/xJkKn0q8sM+YWEQdcCGCmV6nNWV6wTF2Xu4gn8Vo2VCN6Od2bC0GBPLDSqJEqIQpKvtwWIoowrw+W1m6HAjgvB+FMYDFTtUrByyMg7Bo+iqFtBh4blwJXtCV6ZU1fQOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431370; c=relaxed/simple;
	bh=NjJX0xKM5DPMuTwBiyi6UFsD0n9pOuHRMR2Y1oanS1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tnFDbZlDEw626ycvQrDqVHysM4S5el+GzVP6QE+yKdRhfhx22yljuWTk1QXbACw9GIUD5k8mZjCTYEB8yFl1U4xrAPbNeS7Maznu+Lk+hk6U655oO4/+WGGUcGv+c0T9r6fGxf87TREGtqjLLmyNl92NyuP28Zo1cAg/2GuFRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGzVvi4g; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717431369; x=1748967369;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NjJX0xKM5DPMuTwBiyi6UFsD0n9pOuHRMR2Y1oanS1o=;
  b=dGzVvi4g7iJlhrepokwZkR2Q1/kfLzFPCfMY8YyamiX7hCh8Lv0rZ2Tp
   QEFrjCm4mEQhYQJozbkffzKdkR3sw5iqlL4AnmRIm7O2Prlv0YGdJ51Rs
   AwlSgBw+on0Y+1QTSuKwLS4+u5flX5t/JL8ZdhuYTn/YeUpMpiZgQw16i
   89Iug7HIMgWDPAJv+KyqVYUU5b2iRH1FdFi75ZmSzR2bLGhUi/RLr8++j
   j2Ei4BP+D/t2Av6oAH7NlEAKvIcAjVOup0v3y768gkRhac8EpmqzEDtR1
   JW0gQmtFkDlOQFGQequMcScf92u3j3AYbVSufKpv9pmJ7g3DFoxtC8B6o
   A==;
X-CSE-ConnectionGUID: 1EFdWXwURzOtLG+6oPJxkQ==
X-CSE-MsgGUID: NKESAfI9S9uXCXGMpl/Fqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24556309"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="24556309"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 09:13:48 -0700
X-CSE-ConnectionGUID: mLGO8cpdSeWD3nsCWZrRKA==
X-CSE-MsgGUID: pLeFbCtMTFqXRiZOtIBYYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="74416911"
Received: from tjancza1-mobl.amr.corp.intel.com (HELO [10.209.38.23]) ([10.209.38.23])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 09:13:47 -0700
Message-ID: <c3d2a49e580cea9ae86e692f72094119310adc8f.camel@linux.intel.com>
Subject: Re: [PATCH] sched/balance: Skip unnecessary updates to idle load
 balancer's flags
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 Vinicius Gomes <vinicius.gomes@intel.com>
Date: Mon, 03 Jun 2024 09:13:47 -0700
In-Reply-To: <Zlygeqy+SVs1KZYW@chenyu5-mobl2>
References: <20240531205452.65781-1-tim.c.chen@linux.intel.com>
	 <Zlygeqy+SVs1KZYW@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-03 at 00:40 +0800, Chen Yu wrote:
> >=20
> > With instrumentation, we found that 81% of the updates do not result in
> > any change in the ilb_cpu's flags.  That is, multiple cpus are asking
> > the ilb_cpu to do the same things over and over again, before the ilb_c=
pu
> > has a chance to run NOHZ load balance.
> >=20
> > Skip updates to ilb_cpu's flags if no new work needs to be done.
> > Such updates do not change ilb_cpu's NOHZ flags.  This requires an extr=
a
> > atomic read but it is less expensive than frequent unnecessary atomic
> > updates that generate cache bounces.
>=20
> A race condition is that many CPUs choose the same ilb_cpu and ask it to =
trigger
> the nohz idle balance. This is because find_new_ilb() always finds the fi=
rst
> nohz idle CPU. I wonder if we could change the
> for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask)
> into
> for_each_cpu_wrap(ilb_cpu,  cpumask_and(nohz.idle_cpus_mask, hk_mask), th=
is_cpu+1)=20
> so different ilb_cpu might be found by different CPUs.
> Then the extra atomic read could brings less cache bounces.
>=20

Your proposal improves scaling.  However,
that could result in many idle CPUs getting kicked.  I assume that
current approach of delegating to a common idle CPU will disturb fewer CPUs
and let them stay in deeper idle states, and get the power benefits
from NOHZ scheme.

> >=20
> > We saw that on the OLTP workload, cpu cycles from trigger_load_balance(=
)
> > (or sched_balance_trigger()) got reduced from 0.7% to 0.2%.
> >=20
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  kernel/sched/fair.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8a5b1ae0aa55..9ab6dff6d8ac 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -11891,6 +11891,13 @@ static void kick_ilb(unsigned int flags)
> >  	if (ilb_cpu < 0)
> >  		return;
> > =20
> > +	/*
> > +	 * Don't bother if no new NOHZ balance work items for ilb_cpu,
> > +	 * i.e. all bits in flags are already set in ilb_cpu.
> > +	 */
> > +	if ((atomic_read(nohz_flags(ilb_cpu)) & flags) =3D=3D flags)
>=20
> Maybe also mention in the comment that when above statement is true, the
> current ilb_cpu's flags is not 0 and in NOHZ_KICK_MASK, so return directl=
y
> here is safe(anyway just 2 cents)

Not sure I follow your comments about return being safe.  Let me explain
in details.

We will return directly if and only if the bits set in flags are also set
in nohz_flags(ilb_cpu). =20

The comment's intention is to say that if the above statement is true, then
the later operation of=20

	atomic_fetch_or(flags, nohz_flags(ilb_cpu))

will be useless and not result in any change to nohz_flags(ilb_cpu), since =
all the set bits
in flags are already set in nohz_flags(ilb_cpu).

So will it be clearer if I say

	/*
	 * Don't bother if no new NOHZ balance work items for ilb_cpu,
	 * i.e. all bits in flags are already set in ilb_cpu.
	 * Later OR of flags to nohz_flags(ilb_cpu)
	 * will not change nohz_flags(ilb_cpu).
	 */

Thanks.


Tim

> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
>=20
> thanks,
> Chenyu
>=20
> > +		return;
> > +
> >  	/*
> >  	 * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who set=
s
> >  	 * the first flag owns it; cleared by nohz_csd_func().
> > --=20
> > 2.32.0
> >=20


