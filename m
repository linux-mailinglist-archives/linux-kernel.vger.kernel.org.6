Return-Path: <linux-kernel+bounces-573094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA486A6D2FF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698753B2CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C3B26AFB;
	Mon, 24 Mar 2025 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uXCD+AUf"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8823A9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742782724; cv=none; b=fd8Qxlfo6Y7x16X4hvLxJ4VxCT1uUza0P+PDLFktm+nPIV+T3sEpWfirhHq6o9CHdWTDrhQ7484Eyng1Jo0EO0GYdv6ixzfbkMBzJ5PTv2HDAVW/UI2ljUrLmaQ6e814gKhsagvwFSf478NVblUrVDlRKAuhMXiEx3JS4UslYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742782724; c=relaxed/simple;
	bh=JRHrjS0IP0ok2D1xh0CVWa+WMIQKzYUSrOT8k51thX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=O9c6ciOMe/2disERw6jTn2e8+I2JVGKwPzrzUeKUlMDynUciJRMzXNFYqjkHxNk2UZ8dPowA7la/ZhPU7smZaq2WlwwJAocteshmI1x4lzSQeCuNbs+5ncZpu6/kxWm9/XiXa29YvLhcFyL1JkZ67ZZE5h2nBJHNDuK6B50abqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uXCD+AUf; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250324021833epoutp0182579f3b01950cb2f6a1406e8d4db4d2~vm6TXJn081068310683epoutp01D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:18:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250324021833epoutp0182579f3b01950cb2f6a1406e8d4db4d2~vm6TXJn081068310683epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742782713;
	bh=YRy+wMhW+8VIvrnWUSG4BSiNSe09GLh5OaCsDPxrwpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uXCD+AUfRCY+oVnycRSvmunAdxSAXDK9GayhmS07fGzMTDNgWZYzs4AzT1VjwfDLG
	 l4yRIxwb2f2qSzN759qKi5fHFY/igNofJs2GEl41VFSkaSdW9/VM1yxVCsKTE7HNyX
	 cVqDYMvX8O7Sjceh9MGm4UYlYbPK2JWVq3o4rHpw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20250324021832epcas2p31aa0f18ff800db8aab70782613c5cfc1~vm6St8EEF2531025310epcas2p3O;
	Mon, 24 Mar 2025 02:18:32 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4ZLcD80c6fz4x9Q2; Mon, 24 Mar
	2025 02:18:32 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	4A.74.10159.7F0C0E76; Mon, 24 Mar 2025 11:18:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250324021831epcas2p178a34ddcae968039b6d7e195737fcc85~vm6RqeHsW0731007310epcas2p1G;
	Mon, 24 Mar 2025 02:18:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250324021831epsmtrp11e0171ec6e1d3d3c8a74072979418569~vm6Rpik6D0218202182epsmtrp10;
	Mon, 24 Mar 2025 02:18:31 +0000 (GMT)
X-AuditID: b6c32a46-46e92240000027af-e1-67e0c0f77bf2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A6.68.08805.7F0C0E76; Mon, 24 Mar 2025 11:18:31 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250324021831epsmtip121906d6d4e69532c88b5480090f3a47d~vm6RdZX6e1690016900epsmtip1Y;
	Mon, 24 Mar 2025 02:18:31 +0000 (GMT)
Date: Mon, 24 Mar 2025 11:16:54 +0900
From: Donghyeok Choe <d7271.choe@samsung.com>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	john.ogness@linutronix.de, senozhatsky@chromium.org, takakura@valinux.co.jp,
	youngmin.nam@samsung.com, hajun.sung@samsung.com, seungh.jung@samsung.com,
	jh1012.choi@samsung.com, d7271.choe@samsung.com
Subject: Re: [PATCH v2] printk/panic: Add option to allow non-panic CPUs to
 write to the ring buffer.
Message-ID: <20250324021654.GA15429@tiffany>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z9wz9Wk28lmvy4Dg@pathway.suse.cz>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmqe73Aw/SDZqPaVhc2zuR3aJp/yVm
	i0fT17JabLsyn9Hi8q45bBb/H39ltdjX8YDJYvfGRWwWR289ZbeYtK+RyWLxgU/sDtwesxsu
	sni07LvF7vHu3Dl2j74tqxg91m+5yuLxado0do/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2V
	vIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAjlRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
	5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGd8+jiLqeASe8XDdXuZGxiPs3Ux
	cnJICJhI7Ph7kqmLkYtDSGAHo0TjvyY2COcTo8Se9X2MEM43RokTf76wwLRMOXuYEcQWEtjL
	KHH2fyhE0VOgjicdYHNZBFQlri/ZygpiswnoSkzq3AYWFxFQkng1/y4zSAOzQAuTxJUXn8ES
	wgLpEkvuvGIHsXkFdCTmbdvJCmELSpyc+QRsM6eAvsTGzbfZQZolBBZySCzv6AI6gwPIcZGY
	fJof4jphiVfHt7BD2FISL/vboOqbGSUm3XjNBOHMYJS4MvkzE0SVscSsZ+1g/zADXfFv9Qao
	ocoSR26xQIT5JDoO/2WHCPNKdLQJQXSqSJzve8AIs2vD3LdQEz0kVm3fywwJlW2MEtumL2ef
	wCg3C8k/s5Bsg7B1JBbs/sQ2C2gFs4C0xPJ/HBCmpsT6XfoLGFlXMYqlFhTnpqcWGxUYwaM4
	OT93EyM41Wq57WCc8vaD3iFGJg7GQ4wSHMxKIrx3a+6nC/GmJFZWpRblxxeV5qQWH2I0BcbO
	RGYp0eR8YLLPK4k3NLE0MDEzMzQ3MjUwVxLnrd7Rki4kkJ5YkpqdmlqQWgTTx8TBKdXAxHrc
	evLsk6vUjayPTv22o+0aq+m87kUutj++rb/0Q0b4XOYRmTnaWedjIyf/XbE7dw9nkIt+3mZv
	1cKLC3JU1YI3KX76aGK81oF902nGXR9CbsYKnejJUlM7fn7ZmoN8rmrlWpWvGLbPsJm57cji
	CJ+ZU2f1qC79e8Go7e8ZfT7xhrunju/ykeB2lbBK0jDiFr8odXLSamYro/mq8z38qzcvEV9b
	ZbD3dtWs30vnz//1vO/v28bItX9am5TilqvcS/q1wmZHIsuMPIsVVyJZLxpqP8lczW34a0Zi
	L/e5+2yr4hxcubSrvF+nzPAJl+KxtNvF90SAZ46ogfKtLUy2+ryHk/8UTttdfbBM0GbDByWW
	4oxEQy3mouJEAI0Wt/4+BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnO73Aw/SDQ5857K4tnciu0XT/kvM
	Fo+mr2W12HZlPqPF5V1z2Cz+P/7KarGv4wGTxe6Ni9gsjt56ym4xaV8jk8XiA5/YHbg9Zjdc
	ZPFo2XeL3ePduXPsHn1bVjF6rN9ylcXj07Rp7B6fN8kFsEdx2aSk5mSWpRbp2yVwZbz994il
	YCprRUPrO/YGxsUsXYycHBICJhJTzh5m7GLk4hAS2M0oMfPxf2aIhJRE+5aZTBC2sMT9liOs
	EEWPGSXWXfsBVsQioCpxfclWVhCbTUBXYlLnNjYQW0RASeLV/LvMIA3MAm1MEsdn3gQrEhZI
	l1hy5xU7iM0roCMxb9tOqKnbGCVuvWtnhEgISpyc+QTsPmYBLYkb/14CncEBZEtLLP/HARLm
	FNCX2Lj5NvsERoFZSDpmIemYhdCxgJF5FaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZG
	cKxoae1g3LPqg94hRiYOxkOMEhzMSiK8d2vupwvxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6
	N0VIID2xJDU7NbUgtQgmy8TBKdXANHPunMTMiF2TJpj/3ah132K7zCmuU+bHpwjdvsW/40Q3
	++sl304unmGwW/H7LNVVU8/c5Azm/GMx40udbOZuljxR5csdMc+S415t1tzzrSlrdev1psep
	3wQzcwXeKmhv7pj4l/Vv7MaCPyu4+RzmTNy/XGfjq2vK5noZf5InngmeckAs8IHV3zv7il3S
	ZxzWvdO4bB9TS/fNeaHXXmnoff75wUJB0+wXP5uym0SVqdHTeUzWdzvLdFsOnzgb+1E0vd83
	2SDL5vOcy4+E95jknJiud89e5vgPlpZ99p+WitXrLJv/Jyv5/bLsCbpHZ6xM/Hxw74M7+Sbp
	e3hNp3pdnvzw43fPD5OcS/WYFxv/u9SgxFKckWioxVxUnAgAgQ/4fQQDAAA=
X-CMS-MailID: 20250324021831epcas2p178a34ddcae968039b6d7e195737fcc85
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----JAxyHCgdtJ96A8.Ok.gYWmZQmsTOHaTnMoXq.aDuWNAvXzgf=_a72d_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250318022458epcas2p31c3deaea27ceca3ecc405395d2cd10d4
References: <CGME20250318022458epcas2p31c3deaea27ceca3ecc405395d2cd10d4@epcas2p3.samsung.com>
	<20250318022320.2428155-1-d7271.choe@samsung.com>
	<Z9wz9Wk28lmvy4Dg@pathway.suse.cz>

------JAxyHCgdtJ96A8.Ok.gYWmZQmsTOHaTnMoXq.aDuWNAvXzgf=_a72d_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Mar 20, 2025 at 04:27:49PM +0100, Petr Mladek wrote:
> Result:
> 
> The patch has been comitted into printk/linux.git,
> branch for-6.15, see
> https://web.git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=for-6.15&id=c1aa3daa517292303d98ff61f0440c354669f948
> 
> Feel free to ask me take it back. I am going to wait few days
> before sending pull request for 6.15.

Thank you for providing detailed explanations about your modifications.
I really appreciate the clarity, and I have learned a lot from your changes.
Your approach makes perfect sense, and I have no objections to
what you are planning to do.

Thank you.

------JAxyHCgdtJ96A8.Ok.gYWmZQmsTOHaTnMoXq.aDuWNAvXzgf=_a72d_
Content-Type: text/plain; charset="utf-8"


------JAxyHCgdtJ96A8.Ok.gYWmZQmsTOHaTnMoXq.aDuWNAvXzgf=_a72d_--

