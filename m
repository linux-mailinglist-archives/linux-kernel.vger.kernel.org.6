Return-Path: <linux-kernel+bounces-566077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A58CA672D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B160817DC01
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6D620B7E8;
	Tue, 18 Mar 2025 11:36:04 +0000 (UTC)
Received: from mailgw1.hygon.cn (mailgw.hygon.cn [110.188.70.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF5171658
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.188.70.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297764; cv=none; b=YgNfssJAvfKaD+9QWyVjc1DJO8CrGPXy+ZEoOoDNM31dlCrE8dKF91iFlyCJG62iFJLrrgAeYSQz9w1LbB64BV/KN6NojmcwZwax9zRwGdxTQtlb7QaOR3nnpg5D8DiefIUfPmgYs23nuzqdfsB9JJm1ZHZcRZosfBmAbrupJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297764; c=relaxed/simple;
	bh=A9z+0riGGgw2t4zNCs7S2YiHkDIkBJ6j9rLDEGeB3iw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J9QKij25Hj7F4SCMxmmbL8xfW53JX5Pwwa2wtaKU4aXZAOQDP3zAMS2nZiiUzqDMihsj0v09KUEgxelZi6VcxT2DY5AX2f3/FaQh0bIB+O7spL51Caaj1NCT3eVF2FkX1XNwbzxxcLjxhnheUwYUeZTncyOOYSZLQUmXwxUng6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=110.188.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id D7062F999;
	Tue, 18 Mar 2025 19:35:36 +0800 (CST)
Received: from cncheex03.Hygon.cn (unknown [172.23.18.113])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id BFFC416EC;
	Tue, 18 Mar 2025 19:35:36 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex03.Hygon.cn
 (172.23.18.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Mar
 2025 19:35:40 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%6]) with mapi id
 15.02.1544.011; Tue, 18 Mar 2025 19:35:40 +0800
From: Jianyong Wu <wujianyong@hygon.cn>
To: Peter Zijlstra <peterz@infradead.org>
CC: "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "jianyong.wu@outlook.com"
	<jianyong.wu@outlook.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] SCHED: scatter nohz idle balance target cpus
Thread-Topic: [PATCH] SCHED: scatter nohz idle balance target cpus
Thread-Index: AQHbl61OpENeMFSo9kSeuaXOI4AsgbN361aAgADT7pA=
Date: Tue, 18 Mar 2025 11:35:40 +0000
Message-ID: <5cb53e48ade14fbaab3e2940df7ed0d5@hygon.cn>
References: <20250318022358.195154-1-wujianyong@hygon.cn>
 <20250318063847.GA25930@noisy.programming.kicks-ass.net>
In-Reply-To: <20250318063847.GA25930@noisy.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Peter,

Thanks for replay.

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Tuesday, March 18, 2025 2:39 PM
> To: Jianyong Wu <wujianyong@hygon.cn>
> Cc: mingo@redhat.com; vincent.guittot@linaro.org; jianyong.wu@outlook.com=
;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] SCHED: scatter nohz idle balance target cpus
>=20
> On Tue, Mar 18, 2025 at 02:23:58AM +0000, Jianyong Wu wrote:
>=20
> Re subject; if you look at other patches for sched, you'll note that we d=
o not
> capitalize it.
[Jianyong Wu]=20
OK, will correct it.

> Also, what you're doing is not scatter, it is rotation.
[Jianyong Wu]=20
It seems. However, as nohz idle balance occurs quite frequently, in proport=
ion to the value of "HZ" and CPUs number, the selected CPU will spread to t=
he whole system soon. Compared with current situation where mostly only cpu=
0 is selected, the change in this patch is more like a "scattering" effect.=
 But it doesn't matter, "rotation" is fine. I can change it according your =
wish.

>=20
> > Currently, cpu selection logic for nohz idle balance lacks history
> > info that leads to cpu0 is always chosen if it's in nohz cpu mask.
> > It's not fair fot the tasks reside in numa node0. It's worse in the
> > machine with large cpu number, nohz idle balance may be very heavy.
>=20
> Since you seem to care about ilb and numa; there is this _very_ old patch=
 set
> that never got finished:
>=20
> 	https://lore.kernel.org/all/20091211013056.305998000@intel.com/
>=20
[Jianyong Wu]=20
Thanks for this. I'll look into it (may take some time)

> IIRC there was a problem where it would simply stop running the per-node =
ilb
> when the node went idle, leading to node level imbalances. This should be
> curable by picking one such idle node and keeping its ILB active or somes=
uch.
[Jianyong Wu]=20
I think this patch is simple enough to achieve the "fairness". WDYT?
>
> Something to poke at if you're interested..
>=20

