Return-Path: <linux-kernel+bounces-268676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B24B19427B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740C32864CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2481A71EC;
	Wed, 31 Jul 2024 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SI3v2Moo"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBBB34CDE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410360; cv=none; b=nnB9ZOrx8N8CHOseHwEkDyTew4wElWKGhLNwTEW6MyD0NKq0Ilfkc78oRbphSVFRaDk7+jPE2oZ9uGMjxVkUr/RUnhbA48EO9XCGA/2eOFO6srKQZQMu2/Zj2W2btSlSDL7/vvhfzFYYBPSmj52sLC/mzK5Ty8PX+6TO+goXpCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410360; c=relaxed/simple;
	bh=YXyztcZ8q8UbJFmvee1//uOJs/GQNeqriSoxrxqu9lk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=DWnzPTh7HrgPeP9NwQ6MIC3e2DkJZeWJgNVBaLtpEybv9CKhIU5vFgY5mdhKeF0F72Onaqce46/WoN1fpr8JB+UlNsebkoFFD0dxV07uCU9bc+iR/EKoHoMGUjWzCcfaYJJOnapakzl0cLqGDK1PdZgjDdG0aW9WuiqIDTGGacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SI3v2Moo; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240731071910euoutp010dc8e47b51f2ec646484823bab6710f3~nOxaGcWk50782307823euoutp018
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:19:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240731071910euoutp010dc8e47b51f2ec646484823bab6710f3~nOxaGcWk50782307823euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722410350;
	bh=DMrUmFzzGloxE0IIp3OmARdgDsO9finkG4bs6+d7dAI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SI3v2Moo+blonhjvKHvit1cq29HaU6V+nTRW1qDVH1MsoIl4AdCzvMxq8EJ2jiI8O
	 10yohAO/DZuNDbxXEO3Ki7/aA7xZ6h6VI4K86fn5u4ftSak/DzxEa/SxV6y9AcxCPE
	 QEt0giO7boX737QrSe8aUTVSsMQAWRbiQ+andscc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240731071909eucas1p12a802dc60e207cb8260128d8cd993836~nOxZnejn32742427424eucas1p1s;
	Wed, 31 Jul 2024 07:19:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id CB.70.09624.D65E9A66; Wed, 31
	Jul 2024 08:19:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240731071909eucas1p2a48b67ccc855b512829d9eb377e7501b~nOxZQZWoG0956109561eucas1p2_;
	Wed, 31 Jul 2024 07:19:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240731071909eusmtrp2eb3ee2ea7bb85ef608cf36a6546366e3~nOxZPxYym1794017940eusmtrp2j;
	Wed, 31 Jul 2024 07:19:09 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-f2-66a9e56df5d1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id EE.99.08810.D65E9A66; Wed, 31
	Jul 2024 08:19:09 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240731071909eusmtip1e864e685bfc4a2ac598c0176de638a7b~nOxZASW2T3117031170eusmtip1V;
	Wed, 31 Jul 2024 07:19:09 +0000 (GMT)
Received: from localhost (106.210.248.77) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 31 Jul 2024 08:19:08 +0100
Date: Wed, 31 Jul 2024 09:19:04 +0200
From: Joel Granados <j.granados@samsung.com>
To: Wen Yang <wen.yang@linux.dev>
CC: "Eric W . Biederman" <ebiederm@xmission.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Christian Brauner
	<brauner@kernel.org>, Dave Young <dyoung@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: simplify the min/max boundary check
Message-ID: <20240731071904.xiydz3icjslwaxzl@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240715150223.54707-1-wen.yang@linux.dev>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djP87q5T1emGTzebWTx+vAnRouGiQ0s
	Fv+3tbBbnOnOtbi8aw6bxY0JTxkt3q+5z+rA7jG74SKLx6ZVnWweCxumMnu833eVzePzJjmP
	KYfaWQLYorhsUlJzMstSi/TtErgyXmy9wFzwh7OiY08jWwPjTo4uRk4OCQETiV1z17N3MXJx
	CAmsYJQ4euUCM4TzhVFi6t+9rBDOZ0aJu5PusHQxcoC1PF/DCBFfziix8v1ydriih4/3Q2W2
	MErMvfyUGWQJi4CqxO1VuxlBbDYBHYnzb+6AxUUEFCXm7l3EBNLALPCcUeLtto1gRcICzhJf
	t9xmA7F5BRwkZmzaywhhC0qcnPmEBcRmBhq0YPcnNpCTmAWkJZb/A3uIU8BCYn3TRVaI55Qk
	Nh1+zwZh10qc2nILbJeEwAcOifn3JrFAJFwkHszbB9UgLPHq+BZ2CFtG4v/O+VANkxkl9v/7
	wA7hrGaUWNb4lQmiylqi5coTqA5HiZ27u9kggcQnceOtIMShfBKTtk1nhgjzSnS0CUFUq0ms
	vveGZQKj8iwkr81C8toshNcWMDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEw8p/8d
	/7SDce6rj3qHGJk4GA8xSnAwK4nwCp1cmSbEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVI
	ID2xJDU7NbUgtQgmy8TBKdXAVNFww8P1q3+loXi1nvJGj46Vuue1RF78L3Xnqut58HZm2hbn
	ZPWvfWkuDn9dHr1/dHOWlLiG2rWpOXruz5gff6x0Tq48v1v2o6asuNLE9try6FWRSsKHttYt
	Xqnv9W4F/3K1STEfr/OZpbUqJD07lG8RcIf/TomB0cH3S09dcDPv0uBNZft1Ir1cd9qJlQnb
	LRI9H7gXHrrlxMLHHuxyq95jtvtdMadtf53k/nCniGn7+EXOEEn2mPXU/s4Vi+y9cyN2lM+U
	LLBy6az9GCHO/nf5TNYdMdcfzVNn9v3xbWrmvoAlqrd+PDlVblcXV2saNdtixpz/lyfOYEg6
	N/lw+Zvo++t3lyftrmZ2qq9SYinOSDTUYi4qTgQAwBBE3asDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7q5T1emGXzaLmbx+vAnRouGiQ0s
	Fv+3tbBbnOnOtbi8aw6bxY0JTxkt3q+5z+rA7jG74SKLx6ZVnWweCxumMnu833eVzePzJjmP
	KYfaWQLYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
	EvQyXmy9wFzwh7OiY08jWwPjTo4uRg4OCQETiedrGLsYuTiEBJYyStz4vIupi5ETKC4jsfHL
	VVYIW1jiz7UuNoiij4wSx35Mg+rYwiixf/5JNpAqFgFVidurdjOC2GwCOhLn39xhBrFFBBQl
	5u5dxATSwCzwnFHi7baNYEXCAs4SX7fcBmvmFXCQmLFpL9TUbkaJ3rtP2SESghInZz5hAbGZ
	gaYu2P2JDeRuZgFpieX/OEDCnAIWEuubLkKdqiSx6fB7Ngi7VuLz32eMExiFZyGZNAvJpFkI
	kxYwMq9iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjL5tx35u3sE479VHvUOMTByMhxglOJiV
	RHiFTq5ME+JNSaysSi3Kjy8qzUktPsRoCgyLicxSosn5wPjPK4k3NDMwNTQxszQwtTQzVhLn
	9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgCtm6Jkxvcq331zUi7GINE/5Jpe7YZH2jIrmAf8+3
	OVdmPDo0WTwycNNBPr/A8uypy49n+exr/6B1JXDWjK0l2VGfTrAdeHYnN/mw/adE9VUN7uvD
	N6SXdP6JsDliGbhqd8r1in0ZN+xkn86YvmLTtwnVlbuZkme8+JN9rfJbzzmbmz0tbOuKCuK0
	Eu3aHaIaFs9x/xS2mi/9+89v3J4V+euumDnduHXr3/0LpSfsZn/yO9t78cOn04LFfXXOqWp5
	f83eZrj2Jkles50+IZ+fj//r8jWCKhtN+2SnZ+67K54XrqxrevSJxGrBPkX919+eLnG4WdOx
	33mq9aGUnHn5x7PPrzi0R/XpgqRde2OLXimxFGckGmoxFxUnAgAsmsaIRwMAAA==
X-CMS-MailID: 20240731071909eucas1p2a48b67ccc855b512829d9eb377e7501b
X-Msg-Generator: CA
X-RootMTR: 20240715150300eucas1p2c7b7124555f53da23db4e47636c3300d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240715150300eucas1p2c7b7124555f53da23db4e47636c3300d
References: <CGME20240715150300eucas1p2c7b7124555f53da23db4e47636c3300d@eucas1p2.samsung.com>
	<20240715150223.54707-1-wen.yang@linux.dev>

On Mon, Jul 15, 2024 at 11:02:23PM +0800, Wen Yang wrote:
> The do_proc_dointvec_minmax_conv_param structure provides the minimum and
> maximum values for doing range checking for the proc_dointvec_minmax()
> handler, while the do_proc_douintvec_minmax_conv_param structure also
> provides the minimum and maximum values for doing range checking for the
> proc_douintvec_minmax()/proc_dou8vec_minmax() handlers.
> 
> To avoid duplicate code, a new do_proc_minmax_conv_param structure has been
> introduced to replace both do_proc_dointvec_minmax_conv_param and
> do_proc_douintvec_minmax_conv_param mentioned above.
> 
> This also prepares for the removal of sysctl_vals and sysctl_long_vals.
> 
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/sysctl.c | 107 ++++++++++++++++++++++++++----------------------
This does not cleanly apply to current 6.11-rc1. Please send a v3 that
applies to current release. Thx

Best

-- 

Joel Granados

