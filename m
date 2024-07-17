Return-Path: <linux-kernel+bounces-255607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3569342DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3FCB21B70
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3F918411B;
	Wed, 17 Jul 2024 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BWK3A9BW"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7091836D8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246279; cv=none; b=QuIlR2XOGzQrzBX7tQFSsQ5tKtGMiHLz20jpBrbiZ8rrPAOWDhTxF0n5/tINj2T4P9nN33QWn+d5dLFUCUk91whZLC9Hv0JbjQSo9QxKtsIlYR2xrPn4QpVSbAOD7LtFDyaAExYN5ME2JWKZ0aDs3VLdlqDNYAwVRhB9Entdwao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246279; c=relaxed/simple;
	bh=fOdF9z0BzGRwtshRGgEaXObCANR+CLUqJpkWuXQdGSI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=OheJiaAnr2JqBvHa5HGdnErJ63hr6S7MM+imTPppXyQ3pBr2E0Rh/3VQ9BrsWlqdeai5rV7N+CKtRnlSg3fP6eHn+7SAjS+1Z9MH8lFWEA8aM25Ovk1MA0jIQrgONhGWaVQSpds5V6kn8Wx7fj5aw7S/TelQoHB0t1itp/Wq+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BWK3A9BW; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240717195754euoutp01d72355290e92c5e36b25f603203f2d7b~jGF4X8i4Z0073800738euoutp01m
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 19:57:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240717195754euoutp01d72355290e92c5e36b25f603203f2d7b~jGF4X8i4Z0073800738euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721246275;
	bh=w8qylMqO39i2bUZS8vwnMmUxK7qC/iLaf9vLCdDfD7I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BWK3A9BWw7+wXQ9A6bYSAwrrTQ32vsA8UaAPfyM1IsUVtIoB2uGkkoWyCL+vnLXAp
	 bAesX0Y9CHLnj0epwxtc+0CtXgKUPsmX+fv+AdxejgtalOdPEmMjnptmcdujejF0Pg
	 Xysi1Cwivmr+z3P6fYImK2aUfy8PLmQpvCyaJC08=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240717195754eucas1p22804fd7e2e6fab78b30f2dff2a7943ae~jGF3_TvkI3094030940eucas1p2D;
	Wed, 17 Jul 2024 19:57:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 12.64.09875.24228966; Wed, 17
	Jul 2024 20:57:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240717195753eucas1p2655aa2a9d2af84a0b5bdc35a99db9abc~jGF2yELjL0736307363eucas1p2l;
	Wed, 17 Jul 2024 19:57:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240717195753eusmtrp1463789b9fc0a40ff4fb0a84f9542d8d1~jGF2xkrni1030310303eusmtrp1H;
	Wed, 17 Jul 2024 19:57:53 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-76-6698224289b6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 09.4B.09010.14228966; Wed, 17
	Jul 2024 20:57:53 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240717195753eusmtip145b2e617c45ce082b68b94f113678b92~jGF2iThUk1265412654eusmtip1n;
	Wed, 17 Jul 2024 19:57:53 +0000 (GMT)
Received: from localhost (106.210.248.174) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 17 Jul 2024 20:57:52 +0100
Date: Wed, 17 Jul 2024 21:57:48 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <20240717195748.fe5ttokbibcsw2ca@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdf0831f-f9af-4aa7-a3a0-970efeec1def@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduzneV0npRlpBqs/SVnMWb+GzWLd2/Os
	Fpd3zWGz+P3jGZPFjQlPGR1YPTat6mTzODHjN4vH501yHv3dx9gDWKK4bFJSczLLUov07RK4
	Mmb/XMBesEiwovf3PeYGxte8XYycHBICJhKHfr9kBrGFBFYwSvxYUNfFyAVkf2GUuPhzKwuE
	85lR4vyle4xdjBxgHVc70iHiyxklXqxtRyiauqePEcLZyijRMGMSO8hcFgFViU/blrKB2GwC
	OhLn39wB2yciYCOx8ttndpAGZoFJjBIbzl9jBUkIC8RInO/fwgyyjlfAQeJ5pyRImFdAUOLk
	zCcsIDazgJ7EjalT2EBKmAWkJZb/44AIy0s0b50NNp4TaPyqL2fZIN5Ulnj/YB8LhF0rsfbY
	GbC1EgIvOCQav/YyQXzmIrHupgtEjbDEq+Nb2CFsGYnTk3tYIOonM0rs//cBqnk1o8Syxq9M
	EFXWEi1XnkB1OEosvtHGDjGUT+LGW0GI4/gkJm2bzgwR5pXoaBOawKgyC8lns5B8Ngvhs1lI
	PlvAyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMMmc/nf8yw7G5a8+6h1iZOJgPMQo
	wcGsJMI7gXFamhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5VCGB9MSS1OzU1ILUIpgsEwen
	VAOTTWznaVsZxXOrJSYtT5t95rTzjROhiaFzpHpZn9t8/2U3K8frY6LazSd3P0w4VG+wwVDv
	2bJYe67yJ6vYzPf7/bkp2ekza+mH6BnRbzLzX3VUH7rmfl9DxfvrCYUobb8rFV2vLz/Jz3iU
	/TWt+8RtIV9HiQn7Xwj/KzN2yPxc9oQlT8lOa5pteP7z455JDotsTsS8ui2/NLDO0K45ujI1
	b+d33W+dTGw9+s4vvVcmxhsv+JkVaeirceOs1PF5fDkupQJhnzgqt7RlWcYnlGt/9ylsitrF
	KXZYSd/t2cHQ+9ern+pPePnFUbNCzuHr7DqFZIvAyWx+MwWfNzwTaHGp0Gl5nXv8w4yUOwuE
	A5RYijMSDbWYi4oTAZGY5suhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7qOSjPSDBbt5LCYs34Nm8W6t+dZ
	LS7vmsNm8fvHMyaLGxOeMjqwemxa1cnmcWLGbxaPz5vkPPq7j7EHsETp2RTll5akKmTkF5fY
	KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZcz+uYC9YJFgRe/ve8wNjK95
	uxg5OCQETCSudqR3MXJyCAksZZTYeoIFxJYQkJHY+OUqK4QtLPHnWhdbFyMXUM1HRokZi/ez
	QzhbGSWef17LDlLFIqAq8WnbUjYQm01AR+L8mzvMILaIgI3Eym+fwRqYBSYxSkw7c5gRJCEs
	ECNxvn8LM8gVvAIOEs87JSGGfmKS+P7+MlgNr4CgxMmZT8BOYhbQk7gxdQobSD2zgLTE8n8c
	EGF5ieats8F2cQLtWvXlLBvE1coS7x/sg/qmVuLV/d2MExhFZiGZOgvJ1FkIU2chmbqAkWUV
	o0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYAxuO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMI7gXFa
	mhBvSmJlVWpRfnxRaU5q8SFGU2AQTWSWEk3OByaBvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQh
	gfTEktTs1NSC1CKYPiYOTqkGpuKTAQ3Ku2SezX5UYnj/wv7qxAf/dpusWqKh8WVX4/YM39t3
	XCaeT5v3TjFfu05cJvzapvCIwM+luvPja/oj6sslg2e9CvsnKc0dFVkp4XfeNOX7xYvSyosD
	jkXenXdXc439meorTIuKw29H9668fuCT8LyPth8vhF0+6bRdvfnIPHOBX+c73nrydtckpXf0
	X+oV1Qw/9Wfnwh0fv3aJnjvafqjzIEOveaLV27wX0+6X9bEW/li4+lOO9uP5raKWG4XvaK53
	rp37dsXxtDNrsr7vy5635sGHsMKTD/pmqOr2nquX7HN+lyRudY65o7C5O2XDIpYTjEbtb9/s
	WjrrTSP/Ts4TuVfmxQZ3v3hwTFSJpTgj0VCLuag4EQCOCaQzSgMAAA==
X-CMS-MailID: 20240717195753eucas1p2655aa2a9d2af84a0b5bdc35a99db9abc
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

On Wed, Jul 17, 2024 at 05:26:44PM +0200, Thomas Weißschuh wrote:
> On 2024-07-16 17:27:05+0000, Joel Granados wrote:
> > On Mon, Jul 15, 2024 at 10:58:10PM +0200, Thomas Weißschuh wrote:
> > > On 2024-07-15 22:23:19+0000, Joel Granados wrote:
> > ...
> > > > The merge window is now open. I want to send this patch on the Wednesday
> > > > of next week (jul 24).
> 
> <snip>
> 
> > > > 2. Does it still apply cleanly against the latest master branch?
> > > 
> > > Not against mainline master, but against next-20240715.
> > > To apply cleanly (and compile) on mainline master it still requires the
> > > net/ and sysctl trees to be merged.
> > > Otherwise some modified functions are missing, leading to (trivial) merge
> > > conflicts or the preparation commits are missing, leading to compilation
> > > errors.
> > 
> > Understood. I have just sent Linus the changes for sysctl-next, so those
> > should land in master soon (baring any issues with the pull request).
> > 
> > These [1] and [2] are the two series in net-dev that are the deps for
> > the constification treewide patch. Once these two go into mainline, then
> > we are good to go. Right?
> 
> Right, but...
> 
> It turns out the preparation patch for mm/hugetlb.c [0] is also still
> missing. I missed it in all the errors triggered in net/.
> But as far as I can see this patch will be part of Andrew's PR for mm.

Thx for the heads up, I'll Add that one to my radar of things that need
to be in master before we send the PR to Linus. Will check these three
dependencies on Wednesday next week and send your V2 [3] if I see that
it applies cleanly.


> <snip>
> 
> [0] https://lore.kernel.org/lkml/20240518-sysctl-const-handler-hugetlb-v1-1-47e34e2871b2@weissschuh.net/
> 
> > [1] net: constify ctl_table arguments of utility functions
> >     https://patchwork.kernel.org/project/netdevbpf/list/?series=856252&state=%2A&archive=both
> > [2] bpf: constify member bpf_sysctl_kern::table
> >     https://patchwork.kernel.org/project/netdevbpf/list/?series=854191&state=*

[3] https://lore.kernel.org/20240619-sysctl-const-handler-v2-1-e36d00707097@weissschuh.net

Best

-- 

Joel Granados

