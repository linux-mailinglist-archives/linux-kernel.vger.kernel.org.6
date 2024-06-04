Return-Path: <linux-kernel+bounces-201484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9B48FBEF5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707D9B21074
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B953E14C5A7;
	Tue,  4 Jun 2024 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSod8u+z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B3A5F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540340; cv=none; b=Pyc6I1INZQseAP/6URVR5XyDpHwWu+wLlUtmQxopmZmx7yk/l9vOaVABEV72uHP7SQCyCMa4MutKwbEgvZHlHl+kxfdIWDtfLf7WmgvrIbAwslkeP2DOJKtM+ZY5ns3IrcbOm7veK8FgjLTHMgr5TsdWvUCG3PSvX2fhx2u8kS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540340; c=relaxed/simple;
	bh=SqQO5m0o45KNpnKueXFfat8wyVXNsdEl7/1Nlt87arU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cYu+c68FPFA+RE+FQ+wSHAYtZCtI/T1njHzwKs1TP0OxZX8CHJ3dWC6a5TafhIXY8sE6v40ufXcTb9kDLjPVm57H9dY2VRCdAv56naI71MHh3Kvqtztc2+8RZSc78X7sfW6J0Ljojr8ETGxfUzJcd6IHAuhDaKRqp7hp8gtMloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSod8u+z; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717540338; x=1749076338;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=SqQO5m0o45KNpnKueXFfat8wyVXNsdEl7/1Nlt87arU=;
  b=GSod8u+zowf2v3vtY7IXmJDDzwZNXeabcqRxrtDX38hUdJ/pmofEhO1B
   NQW9TO6FrK+ouM2NTPkRB7g+P4efM/taAXd1Ale+wudAra/U+yjAu/guv
   us2327rccOit9Nix5oFvNU/UdpjTeaY1dhU1EsiYa9NjPQl+Le2VRtu0T
   JWbYCrdaiGKa/yPfyjqsl7Z6ZWua1kTVp3w8Vdf7EeLbkWFomsMOwm1tf
   7m8MWNn1vmDSLbkoLwVUaeCA1APGUr6Jc1c/y6AlVWp6WSI+Pa8XKOL3W
   xQFRhgQw1lJQh3IDIw0DSkSh18ifazCA+b7/hIzE8Ch8nUOHAMc4204DS
   Q==;
X-CSE-ConnectionGUID: 42LO9NweQ7aj4cEvkTf2tg==
X-CSE-MsgGUID: aNraxqvTTuyyYI7Er9Ml2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14305017"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="14305017"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:32:12 -0700
X-CSE-ConnectionGUID: mdkoWJCrQoOWvPXSy4z79A==
X-CSE-MsgGUID: SsTtftYlSsWTysI+dlZhTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37399490"
Received: from mhlooi-mobl1.amr.corp.intel.com (HELO [10.212.212.220]) ([10.212.212.220])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:32:11 -0700
Message-ID: <acb5d2789f0a2fa81f95c81d4c21d122cfddb244.camel@linux.intel.com>
Subject: Re: [PATCH] sched/balance: Skip unnecessary updates to idle load
 balancer's flags
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 Vinicius Gomes <vinicius.gomes@intel.com>
Date: Tue, 04 Jun 2024 15:32:11 -0700
In-Reply-To: <Zl53lXjEmnWhlW8p@chenyu5-mobl2>
References: <20240531205452.65781-1-tim.c.chen@linux.intel.com>
	 <Zlygeqy+SVs1KZYW@chenyu5-mobl2>
	 <c3d2a49e580cea9ae86e692f72094119310adc8f.camel@linux.intel.com>
	 <Zl53lXjEmnWhlW8p@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 10:10 +0800, Chen Yu wrote:
>=20
> >=20
> > Not sure I follow your comments about return being safe.  Let me explai=
n
> > in details.
> >=20
> > We will return directly if and only if the bits set in flags are also s=
et
> > in nohz_flags(ilb_cpu). =20
> >=20
> > The comment's intention is to say that if the above statement is true, =
then
> > the later operation of=20
> >=20
> > 	atomic_fetch_or(flags, nohz_flags(ilb_cpu))
> >=20
> > will be useless and not result in any change to nohz_flags(ilb_cpu), si=
nce all the set bits
> > in flags are already set in nohz_flags(ilb_cpu).
>=20
> Understand. My previous thought was that, what if the current nohz_flags(=
ilb_cpu) is 0 or
> NOHZ_NEWILB_KICK. If yes, return directly might miss one ipi to the ilb_c=
pu(because
> the current code checks flags & NOHZ_KICK_MASK to return directly). But f=
rom the current
> logic when we reach kick_ilb(), the flag is not 0, and the flag passed by=
 nohz_balancer_kick()
> satisfy (flags & NOHZ_KICK_MASK), so returns here is ok.

Should not have issues of missing an IPI.  kick_ilb(flags) is always called=
 with non-zero flags
value.  And the first guy who update nohz_flags(ilb_cpu) successfully with =
bits
in the NOHZ_KICK_MASK will send the IPI.

Tim




