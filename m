Return-Path: <linux-kernel+bounces-222437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788E691018A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C52A1C211F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A4F1AAE0D;
	Thu, 20 Jun 2024 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OWadIRwr"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C592594
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879702; cv=none; b=pYMlrqTh5E0sSSgnK3KizE1lxmqWmUQJqtNKkGaE9tKV72TmUytvo/g8M5OVqNzE/IgzDGRvRPh3TZ4j/xbG0Mjo09P3l4iwID08jYeD5hlPB8O8RkAUfaXWHN9oXdCECZS4DhOaN8UY0K75xpeZ10OL3+EsBvZvg0FkjBWktP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879702; c=relaxed/simple;
	bh=lCyupJdafA3dXGgAIhEV7XI5qV1P7+a/6Gib3SE/mrc=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=JeV3OZ8+F1OdFXOngdQYu/SOUVoPTeCy1zj0p+vvq6CvzMiRax9GR2DonvIOaEudjwCtXb1x2i+/D+Hja0UpgYF8gy32+Qavu9SJ+FWPZjUNUBc0dygap/Zj5MF9m8m99dDh3I45shUCGQxwhv/ULsZBhwgVVX4GitC4h1qv/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OWadIRwr; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240620103457euoutp01aba6dcb4c80017490606b000d08a2a88~ar-pZOKqX2475024750euoutp01p
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:34:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240620103457euoutp01aba6dcb4c80017490606b000d08a2a88~ar-pZOKqX2475024750euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718879697;
	bh=K2XlRvGpvnjCHdsUkw4csbNzLzNzCgYTkIMsnQI6LhY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=OWadIRwrnG8ERyR0Z72rwC52Hh68ItuCMqk9n4bEJ3kO4W8sznq3VjIKYokUdUz5+
	 aPqyAzT20RGMp35Cpb0rqWyeR/Rcitr3xSBp2qGhTwTIerXmUV/HenpDUghiHf7wV1
	 XFcVB41NB8gzPsdTAKEBACQJfJLTXidN6CfSLfaM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240620103457eucas1p2e6f09a2914a058897fdf1250de5d47ae~ar-pPMDkt1317913179eucas1p27;
	Thu, 20 Jun 2024 10:34:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 1F.DA.09620.1D504766; Thu, 20
	Jun 2024 11:34:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240620103456eucas1p1578e3a4017dcd11c6d48b6022a3522ce~ar-oroHTg0858808588eucas1p1G;
	Thu, 20 Jun 2024 10:34:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240620103456eusmtrp2ce837deca67868d4554386c61f582368~ar-orAU0P3267132671eusmtrp2y;
	Thu, 20 Jun 2024 10:34:56 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-96-667405d1f90f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id E9.39.08810.0D504766; Thu, 20
	Jun 2024 11:34:56 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240620103456eusmtip2311da91bb4412085b8730b0b2d192bc1~ar-obUxW_0676706767eusmtip2O;
	Thu, 20 Jun 2024 10:34:56 +0000 (GMT)
Received: from localhost (106.210.248.242) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 20 Jun 2024 11:34:55 +0100
Date: Thu, 20 Jun 2024 12:34:51 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <20240620103451.7c4oznlkwty53bzs@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619-sysctl-const-handler-v2-1-e36d00707097@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7oXWUvSDOZ8F7SYs34Nm8W6t+dZ
	LS7vmsNm8fvHMyaLGxOeMjqwemxa1cnmcWLGbxaPz5vkPPq7j7EHsERx2aSk5mSWpRbp2yVw
	ZUy+3sZcsI2/Yv/O6cwNjJN5uhg5OSQETCQ239vK3sXIxSEksIJR4valdlYI5wujxJ3dfxgh
	nM+MEoeWnmeFaXn79iwLRGI5o0Tb68uscFUdT/ewgFQJCWxllGi65gxiswioSrxcdZsJxGYT
	0JE4/+YOM4gtImAjsfLbZ7DlzAKTGCU2nL8GtkJYIEbifP8WsCJeAQeJnRuuQNmCEidnPgFb
	wCygJ3Fj6hS2LkYOIFtaYvk/DoiwvETz1tlg5ZwCvhLbVlxjhrhaWeLLpzdQdq3E2mNnwPZK
	CDzgkGjsbmeESLhIzJn1nB3CFpZ4dXwLlC0j8X/nfCaIhsmMEvv/fYDqXs0osazxKxNElbVE
	y5UnUB2OEotvtLGDXCchwCdx460gxHV8EpO2TWeGCPNKdLQJTWBUmYXktVlIXpuF8NosJK8t
	YGRZxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZhqTv87/nUH44pXH/UOMTJxMB5ilOBg
	VhLhfd5VlCbEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7NbUgtQgmy8TBKdXA
	JDkhpnh6t/1SGx/btmWLE8XPFy70+bDLaen5vrST9bFCt2oeFy23F1+rtUForuzs2tuP5vYu
	KNp1w68rv3+O6PyI3cmuwZd/Fra0GnT3lucXmzB+esV9+CLL2zlvP5i3vnz55pnhcybDYkex
	MMV565oyzYPDnv/3N3G+xNUn0fOmSK5B+NOZrWzXvgnOC2KdvNd+OfP0Rvk76zIMDxVq3bws
	085qJPBuJfvj+4UbU/WbLq+6ukbt80W53HLmD4u/rRGWmxgbH/VukQWXmmmcuBkziw5vlZGA
	KOf3Os5Zr55dmFu56177nzSZHWcy3r04uqZst8qTC5LKLfdiLQ33aiTOWLiz1OvRmu1fGm9H
	KrEUZyQaajEXFScCANEdcXSkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7oXWEvSDOZd1bCYs34Nm8W6t+dZ
	LS7vmsNm8fvHMyaLGxOeMjqwemxa1cnmcWLGbxaPz5vkPPq7j7EHsETp2RTll5akKmTkF5fY
	KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZUy+3sZcsI2/Yv/O6cwNjJN5
	uhg5OSQETCTevj3L0sXIxSEksJRR4sGvN8wQCRmJjV+uskLYwhJ/rnWxQRR9ZJQ4Pns+VMdW
	RolLU86zg1SxCKhKvFx1mwnEZhPQkTj/5g7YJBEBG4mV3z6zgzQwC0xilJh25jAjSEJYIEbi
	fP8WsCJeAQeJnRuuMENMXcAo8f/TCVaIhKDEyZlPWEBsZgE9iRtTpwDdwQFkS0ss/8cBEZaX
	aN46G2wOp4CvxLYV16BeUJb48gnmnVqJV/d3M05gFJmFZOosJFNnIUydhWTqAkaWVYwiqaXF
	uem5xYZ6xYm5xaV56XrJ+bmbGIGRuO3Yz807GOe9+qh3iJGJg/EQowQHs5II7/OuojQh3pTE
	yqrUovz4otKc1OJDjKbAMJrILCWanA9MBXkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp
	2ampBalFMH1MHJxSDUzpv/Mk+4TOrwgQ9jySmvq/72dbrfy7S2w/Vxu4TEtuvPr7Lu9HM8Ej
	O3x4mRaukfm/Q2n5VqHmqA1d0tMOO7amSMRJHd+TnFfk5nwyrOPLhA8qrDNXPSo3vv9I5Ojy
	nYL3jhyaxSst5r/NqXDCDObrhg/59GXVOt/OzM8VvtZxNW4pfz9v8pptj9XmNn0oSJ93/Mw7
	fr1lF4zO/879+Xmy18GbuvNtnz6Y5yiwYYKFb3+7g72U28dlvbXHJnhe/nLf0OnkAiZxJ6VS
	/omTZdTqahb3TXv0JUfC1/sotwB31krrW9kRByRFP9jOaxFtWLUj8HHWUZVC/ek1B81/HXVh
	FbodP1tWJWT7qnc9hoJKLMUZiYZazEXFiQBsVivlTQMAAA==
X-CMS-MailID: 20240620103456eucas1p1578e3a4017dcd11c6d48b6022a3522ce
X-Msg-Generator: CA
X-RootMTR: 20240619100941eucas1p25d522dca3b74c899434b97b0c0dc78a0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240619100941eucas1p25d522dca3b74c899434b97b0c0dc78a0
References: <CGME20240619100941eucas1p25d522dca3b74c899434b97b0c0dc78a0@eucas1p2.samsung.com>
	<20240619-sysctl-const-handler-v2-1-e36d00707097@weissschuh.net>

On Wed, Jun 19, 2024 at 12:09:00PM +0200, Thomas Weiﬂschuh wrote:
> Adapt the proc_hander function signature to make it clear that handlers
> are not supposed to modify their ctl_table argument.
> 
> This is also a prerequisite to moving the static ctl_table structs into
> read-only data.
> 
> The patch was mostly generated by coccinelle with the following script:
> 
>     @@
>     identifier func, ctl, write, buffer, lenp, ppos;
>     @@
> 
>     int func(
>     - struct ctl_table *ctl,
>     + const struct ctl_table *ctl,
>       int write, void *buffer, size_t *lenp, loff_t *ppos)
>     { ... }
> 
> In addition to the scripted changes some other changes are done:
> 
> * The "typedef proc_handler" in include/linux/sysctl.h is changed to use
>   the "const ctl_table".
> 
> * The prototypes of non-static handlers in header-files are adapted
>   to match the changes of their respective definitions.
> 
> * kernel/watchdog.c: proc_watchdog_common()
>   This is called from a proc_handler itself and is als calling back
>   into another proc_handler, making it necessary to change it as part
>   of the proc_handler migration.
> 
> No functional change.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
Will test this in 0-day in [1] to avoid potential conflicts with all the
other stuff going into linux-next and because it does not apply cleanly to
sysctl-next. Don't expect any issues from 0-day as it is a
non-functional trivial change.

I'll use this patch as is when the time comes during the end of the
merge window (at that point it should apply cleanly) and go into 

@Thomas: Can I ping you during the merge window to double check that
there are no additional proc_handlers (without the const argument)
that might not be present in today's linux-next?

Best

[1] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/log/?h=jag/constify_proc_handlers

-- 

Joel Granados

