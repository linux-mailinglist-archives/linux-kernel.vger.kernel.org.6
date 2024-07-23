Return-Path: <linux-kernel+bounces-259762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2DF939CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5ECD1F2212C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B114D6F1;
	Tue, 23 Jul 2024 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uym/xQN0"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6B14D428
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723592; cv=none; b=BlD8VpcfAFV8BS7NkGocIF8KUtiKwSxlNrPDCqcieLKqJR6n/MFAHVfSLp7lL6xBNsKAeCDX6bI64ib5Kc5PKiBY49AX8Uafa7XuHZmTTBTzxgPaXegoRiGnEzdni/FR9beR4PfNZJZz8jkgCUbiCBNYnwGKoY/2zhTCs+JWg8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723592; c=relaxed/simple;
	bh=I+W78kJ7h3fxyDld8rmmYXDoPsduCUAq1iTS1HPMIJU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=iG+9JoTV2zkt59gSK9PjDrsN/4WMxyqm0OJMGYGh/l8Ev6mgOquFZ/dfueM3erNR9EQ9DEgAzLT7ToJB2iMfSxjGr/RY3yKI5t1I1i69wtTLhDeThJthCBPTpuoH6i4yIf93LQ0MxD5fGZSHoLZJUmh4waRrIXWvM6JlHwb9NS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uym/xQN0; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240723083307euoutp01c1f796842ec84af09888c661a734ab83~kynsvrwLw0341203412euoutp01f
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:33:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240723083307euoutp01c1f796842ec84af09888c661a734ab83~kynsvrwLw0341203412euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721723588;
	bh=ZA1hebOFxLLkZ36onYR7qXf9hAnWg2HrzbqXfPPdnBQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uym/xQN0rVTevyslC4aSDB3GOgladnf8nI0evX2CoGlan/OpR6VhdNsbEC5VNnkwD
	 S4MPcL8F2Zlgi1kjSKZk2/5U8xApdi+W5aETf71/FyeWKALSuW9kI/BzdLBdeEtgyz
	 DMAJMZbcg4Z4Ti2+KzoIQAPaGaj8431+vp6O1qcU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240723083307eucas1p2461d808d8ac3f103bd451287992ab9ae~kynsliDJA0266202662eucas1p26;
	Tue, 23 Jul 2024 08:33:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id D8.BB.09624.3CA6F966; Tue, 23
	Jul 2024 09:33:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240723083307eucas1p2171f64272c8e07865402467bae99229e~kynsNYUnS1584815848eucas1p2i;
	Tue, 23 Jul 2024 08:33:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240723083307eusmtrp198a2ad087cc0210312e987e7caeda1e7~kynsMbUA60202302023eusmtrp1-;
	Tue, 23 Jul 2024 08:33:07 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-7c-669f6ac3c12e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E9.B1.09010.3CA6F966; Tue, 23
	Jul 2024 09:33:07 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240723083307eusmtip1c613fa8f09c284eecfdd458eb42a74ad~kynr940jU3020130201eusmtip1q;
	Tue, 23 Jul 2024 08:33:07 +0000 (GMT)
Received: from localhost (106.210.248.226) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 23 Jul 2024 09:33:06 +0100
Date: Tue, 23 Jul 2024 10:33:02 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <20240723083302.pp74ontnqujknt6q@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a48b4d3-94ca-4a42-bf59-c340d7316603@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd3DWfPTDO5d1LWYs34Nm8W6t+dZ
	LS7vmsNm8fvHMyaLGxOeMjqwemxa1cnmcWLGbxaPz5vkPPq7j7EHsERx2aSk5mSWpRbp2yVw
	Zex8/oWpYJpoxd7+dawNjIcEuhg5OSQETCT+PT3L2sXIxSEksIJRonnnHSYI5wujxOSnj6Ey
	nxkl5r9ZzA7TcqH/KlTVckaJ35NWsYEkwKpe/bKASGxllHj07xxQgoODRUBVYtPWcpAaNgEd
	ifNv7jCD2CICNhIrv31mB6lnFpjEKLHh/DVWkISwQIzE+f4tYEW8Ag4SP6euZoewBSVOznzC
	AmIzC+hJ3Jg6BWw+s4C0xPJ/HBBheYnmrbOZQcKcQPMbp+pA3KwscW/THmYIu1bi1JZbTBD2
	Ew6JbX+EIGwXiV9nLkHFhSVeHd8C9a+MxOnJPSwgZ0oITGaU2P/vAzuEs5pRYlnjV6gOa4mW
	K0+gOhwlFt9oYwc5QkKAT+LGW0GI2/gkJm2bzgwR5pXoaBOawKgyC8ljs5A8NgvhsVlIHlvA
	yLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMMmc/nf80w7Gua8+6h1iZOJgPMQowcGs
	JML75NXcNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC6YklqdmpqQWpRTBZJg5OqQam
	0r+VkrueuAlWPZzC4eJ8nusrv/iLpqWcs9/fWSua8mHphTe1357XW5RMLJvd/acqpNR7ehJz
	6WGB9HfFS6ozt0lVyFb9XvjzvfAW359t3hNDVCX3WMqs+TD9lH/gkcdWi78sKb3pwPNvBn9p
	WYDrDZfq1xp7ZJ0ebC3cek1NfpGJt9q8v6kprcGPUw5raWsub7WdLh0b1/14ln9TH6Oj2EHd
	qfIOpyWa5e6xCxQFvPMSz3z3KdPbiNPS9/E3jwPWyV6FnE2Pp1Xvy+cMSmXzeKP+yM3lxNmD
	wXzeUZylpWekpm8227W5cX/SBxULj+n/Ox4IcdXdPP/1b9PPZJ7+pi3p3X9v2zVe+ftyZZMS
	S3FGoqEWc1FxIgBgeaq+oQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7qHs+anGZzvFbKYs34Nm8W6t+dZ
	LS7vmsNm8fvHMyaLGxOeMjqwemxa1cnmcWLGbxaPz5vkPPq7j7EHsETp2RTll5akKmTkF5fY
	KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZex8/oWpYJpoxd7+dawNjIcE
	uhg5OSQETCQu9F9l6mLk4hASWMoosXrKR0aIhIzExi9XWSFsYYk/17rYQGwhgY+MEp/uJ0I0
	bGWUeLlhI1A3BweLgKrEpq3lIDVsAjoS59/cYQaxRQRsJFZ++8wOUs8sMIlRYtqZw2ALhAVi
	JM73bwEr4hVwkPg5dTU7xNDbzBI7Fm5mhUgISpyc+YQFxGYW0JO4MXUKG8gyZgFpieX/OCDC
	8hLNW2czg4Q5gZY1TtWBuFlZ4t6mPcwQdq3E57/PGCcwisxCMnQWkqGzEIbOQjJ0ASPLKkaR
	1NLi3PTcYiO94sTc4tK8dL3k/NxNjMAY3Hbs55YdjCtffdQ7xMjEwXiIUYKDWUmE98mruWlC
	vCmJlVWpRfnxRaU5qcWHGE2BITSRWUo0OR+YBPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTS
	E0tSs1NTC1KLYPqYODilGpicthzbHzwzX1qjfMacbQ9UDx1s0Tp/7qrq0TK9K6Gfajqa1kSc
	KtxVOfmYis1x/oUWNptEzDqnTf3BntsnvMV+09+HRz1f/LGMdl79Nl1we8sH68SWzB3h8zK+
	LDG+9WIl58qX7Jf+ndp+oJtfLu6VBhe3yWLPOx5VG/OYHfe2OoQnG6S3TFtgqv14oYnSFWOR
	dbe1dkryrEp4G5pvsUBN6VOfu4v+bAvtkLN7lZ32d+if1WNcFZ421bvFY/ukOXO+BpXc//Hh
	kY0Jl1b7o3M2kbUrHC3MVzA+EiqO0q9nUdO5tSml8nTdplXHtdbJTLR/vHFxFIN3upTswvl/
	uL0rZA+udlP5tdn51zo2d38lluKMREMt5qLiRAAAtAyHSgMAAA==
X-CMS-MailID: 20240723083307eucas1p2171f64272c8e07865402467bae99229e
X-Msg-Generator: CA
X-RootMTR: 20240619100941eucas1p25d522dca3b74c899434b97b0c0dc78a0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240619100941eucas1p25d522dca3b74c899434b97b0c0dc78a0
References: <CGME20240619100941eucas1p25d522dca3b74c899434b97b0c0dc78a0@eucas1p2.samsung.com>
	<20240619-sysctl-const-handler-v2-1-e36d00707097@weissschuh.net>
	<20240715202319.mccb6jlsa6dkynap@joelS2.panther.com>
	<f7489470-b0da-406b-a8dd-0ae7aaeceec8@t-8ch.de>
	<20240716152705.juet6srejwq5o6je@joelS2.panther.com>
	<cdf0831f-f9af-4aa7-a3a0-970efeec1def@t-8ch.de>
	<20240717195748.fe5ttokbibcsw2ca@joelS2.panther.com>
	<8a48b4d3-94ca-4a42-bf59-c340d7316603@t-8ch.de>

On Mon, Jul 22, 2024 at 09:41:36AM +0200, Thomas Weißschuh wrote:
> Hi Joel,
> 
> On 2024-07-17 21:57:48+0000, Joel Granados wrote:
> > On Wed, Jul 17, 2024 at 05:26:44PM +0200, Thomas Weißschuh wrote:
> > > On 2024-07-16 17:27:05+0000, Joel Granados wrote:
> > > > On Mon, Jul 15, 2024 at 10:58:10PM +0200, Thomas Weißschuh wrote:
> > > > > On 2024-07-15 22:23:19+0000, Joel Granados wrote:
> > > > ...
> > > > > > The merge window is now open. I want to send this patch on the Wednesday
> > > > > > of next week (jul 24).
> > > 
> > > <snip>
> > > 
> > > > > > 2. Does it still apply cleanly against the latest master branch?
> > > > > 
> > > > > Not against mainline master, but against next-20240715.
> > > > > To apply cleanly (and compile) on mainline master it still requires the
> > > > > net/ and sysctl trees to be merged.
> > > > > Otherwise some modified functions are missing, leading to (trivial) merge
> > > > > conflicts or the preparation commits are missing, leading to compilation
> > > > > errors.
> > > > 
> > > > Understood. I have just sent Linus the changes for sysctl-next, so those
> > > > should land in master soon (baring any issues with the pull request).
> > > > 
> > > > These [1] and [2] are the two series in net-dev that are the deps for
> > > > the constification treewide patch. Once these two go into mainline, then
> > > > we are good to go. Right?
> > > 
> > > Right, but...
> > > 
> > > It turns out the preparation patch for mm/hugetlb.c [0] is also still
> > > missing. I missed it in all the errors triggered in net/.
> > > But as far as I can see this patch will be part of Andrew's PR for mm.
> > 
> > Thx for the heads up, I'll Add that one to my radar of things that need
> > to be in master before we send the PR to Linus. Will check these three
> > dependencies on Wednesday next week and send your V2 [3] if I see that
> > it applies cleanly.
> 
> All dependency PRs (sysctl, net, mm) are now merged.
> My compilation tests all succeed now.
Great. I'll push this up to Linus tomorrow as planned.
Thx for the heads up.

> 
> > > <snip>
> > > 
> > > [0] https://lore.kernel.org/lkml/20240518-sysctl-const-handler-hugetlb-v1-1-47e34e2871b2@weissschuh.net/
> > > 
> > > > [1] net: constify ctl_table arguments of utility functions
> > > >     https://patchwork.kernel.org/project/netdevbpf/list/?series=856252&state=%2A&archive=both
> > > > [2] bpf: constify member bpf_sysctl_kern::table
> > > >     https://patchwork.kernel.org/project/netdevbpf/list/?series=854191&state=*
> > 
> > [3] https://lore.kernel.org/20240619-sysctl-const-handler-v2-1-e36d00707097@weissschuh.net

Best
-- 

Joel Granados

