Return-Path: <linux-kernel+bounces-358846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B9E998493
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D8F282CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDA71C32EC;
	Thu, 10 Oct 2024 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m7HhnHYx"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728A1BDAA5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558835; cv=none; b=aIy3rplWCE7Seqwijsf/TBS4C3UaTYvjEZX78o8eAhQqC61a4A6kgiI1bDwZqIyQY4ZB1NQIkM0NDBAXiCUEejPe+BIKKLfkZF6477Z17MclV7eb1tpIlOA7E5h5EN+YnIjcAsB4ygg08iPTByjhHJuGckRgslwDytKIOKNQyiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558835; c=relaxed/simple;
	bh=IHKxd2eqAyoLvkyUehXaj5FGBxUtlfDg6lBIO1T2npE=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=UBcoJNHVhg22SLnronP/WFlHjCPulFrAsbohhPWMpREiEYWzNLUV1o+qkQVJZYshtai+94NlN8cD1+Jo//hAV9Hayv1RmpS+ImLz4cl7nANuk2DF+eYrYe/B4uSf5jNTh5XO3VV+bJsMIJcbRAo9dcybkcrJVC/Wszmar+xGYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=m7HhnHYx; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241010111350epoutp03aedab893cbd3d020b33edc65766d4e2c~9ExkONPBe2423024230epoutp03i
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:13:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241010111350epoutp03aedab893cbd3d020b33edc65766d4e2c~9ExkONPBe2423024230epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728558830;
	bh=oeywdlSGmWq5cb1PEBgpyyvHTYi09dROi5wwD07qjxQ=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=m7HhnHYx412xHO78i4MpUSM2IJmI7O1MHikGtSeS64Gj0wVOTZiXpLD/KDTzM2M6H
	 IQVu27snlf6E4PEfXzO+ht38+dSbvtO/l5Q18fCfykgAPyWLzt984u9SDBQ1tgUPba
	 /H9pD/1HfE1eCzVLWFScFlePg+p278npjWQLBkEI=
Received: from epsmgec5p1new.samsung.com (unknown [182.195.42.68]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241010111349epcas5p1e357923929427e779278c858526eb1f9~9ExjrxVdx0186001860epcas5p12;
	Thu, 10 Oct 2024 11:13:49 +0000 (GMT)
X-AuditID: b6c32a44-6dbff7000000217e-0f-6707b6ed285c
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.56.08574.DE6B7076; Thu, 10 Oct 2024 20:13:49 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] sched.h: silent false ATOMIC_SLEEP warning from
 cond_resched
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From: Maninder Singh <maninder1.s@samsung.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Hariom Panthi <hariom1.p@samsung.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Rohit Thapliyal <r.thapliyal@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20241010103921.GI14587@noisy.programming.kicks-ass.net>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241010110830epcms5p4f0d7af444bb559a59f091d9966b8d535@epcms5p4>
Date: Thu, 10 Oct 2024 16:38:30 +0530
X-CMS-MailID: 20241010110830epcms5p4f0d7af444bb559a59f091d9966b8d535
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7bCmlu7bbezpBh/vqFpMf9nIYvF0wlZm
	iydth1gs7vZPZbG4vGsOm8Xkd88YLS4dWMBkcbz3AJPFxnvZFvs6HjBZdBz5xmyx9eh3dgce
	jzXz1jB6tOy7xe6xYFOpx+YVWh53ru1h83i/7yqbR9+WVYwem09Xe3zeJBfAGcVlk5Kak1mW
	WqRvl8CV8fL4G9aC3WwVj98eZ2pg7GXtYuTkkBAwkZhyZS9LFyMXh5DAbkaJ1dOPMHUxcnDw
	CghK/N0hDFIjLBAusWhbLwuILSSgKHFhxhpGkBJhAQOJX1s1QMJsAnoSq3btASsREdCUWNl2
	nw1kJLPAVBaJA8vuM0Hs4pWY0f6UBcKWlti+fCsjiM0p4CrR82ETM0RcVOLm6rfsMPb7Y/MZ
	IWwRidZ7Z6FqBCUe/NwNFZeRWL25F2pmtcTT1+fAFksItDBK7NsNU2QusX7JKrChvAK+EjN6
	1oI1sAioSly81g3V7CLxYO03sHpmAXmJ7W/nMIM8yQz0zfpd+hAlshJTT61jgijhk+j9/QTu
	rx3zYGxViZabG1hhfvz88SPUeA+Jo8sPQMNwH5PE3g12ExgVZiFCehaSxbMQFi9gZF7FKJla
	UJybnppsWmCYl1quV5yYW1yal66XnJ+7iRGcuLRcdjDemP9P7xAjEwfjIUYJDmYlEV7dhazp
	QrwpiZVVqUX58UWlOanFhxilOViUxHlft85NERJITyxJzU5NLUgtgskycXBKNTAJZO09Xeun
	cXHtkZZHKjbPMmzlrU1NUvM8X4tUi660PP4s5ancPo6AF1w+Hl+qBOYLadS/SEpObto++YBy
	Y75UjcC5ft6NDPZPb9lKs99KFDiwYOm0g+c3STi86+5u3lk6/eUfucgTO6e03Q/Jv/SSwWy3
	8Y3/5/b0VeQsuLn71OyOV7F+d35sW1YhGTDPaNvxD19dZ/dE69b0sn+5JbLw8uPHgbdM3jZv
	4oxezGNTH3PVOnN5SZZBwZyyazsCNrP/qnh70uLHiuzbs4Wdp6znSPmu86FG6qMo6w+rA99P
	iRRu9b0oo76P71qwn+6t/8vlI3unSVswPvltNmPaxRzldZYlh1+clknYpMhZsMJTiaU4I9FQ
	i7moOBEARa7iQssDAAA=
X-CMS-RootMailID: 20241010032751epcas5p1154533995a184be3fea39325c4d33740
References: <20241010103921.GI14587@noisy.programming.kicks-ass.net>
	<20241010092249.GD17263@noisy.programming.kicks-ass.net>
	<20241010032653.1922214-1-hariom1.p@samsung.com>
	<20241010100940epcms5p2f7463014f1e1cb1b27a8da300b804e08@epcms5p2>
	<CGME20241010032751epcas5p1154533995a184be3fea39325c4d33740@epcms5p4>

> > 
> > In our case there was a call to vunmap_pmd_range from __do_softirq,
> > and vunmap_pmd_range is not actually sleeping call, but because of
> > cond_resched it was giving warning with DEBUG_ATOMIC_SLEEP.
> > 
> > and cond_resched in case of CONFIG_PREEMPTION is empty function with below change:
> 
> By still having that warning we helpfully tell you your code is broken
> for that other .config. Code should be good irrespective of the .config
> used, right?

But isn't it un-necessary to report a warning for a particular .config set,
when in actual that issue can not happen and code was written accordingly.

Because for other .config it will be a total different system and user can change 
code design for that.


But you better know about it, so it is your call :)

Thanks,
Maninder Singh

