Return-Path: <linux-kernel+bounces-253045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981A931BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28441F207BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D04613BC11;
	Mon, 15 Jul 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WkGVZiUZ"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0713AD33
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075010; cv=none; b=SAY1k7r12aCEXnEgzbMSI0k7DYDCMBUD8tfY85d6MUr6D2u6eyP5rByTaXbj5rAFY9FSKszFDRGwBOVyZ2fTPQPO3JeVnpXJx6gbW3YPfGZGnpMrQlz9eQMfPqJ1beKLFF6LickREJZD00pwB6VQdGaaQzp4jkKiooFoE82sTWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075010; c=relaxed/simple;
	bh=xdP1cP9Z+O2ws0WmFY7+pifZEztirUMQzv9Apd7q9Lg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=ggjMt9Xzt2qU2NAHDGDOhq9a8HO0SLekTUbYLWr9URS22Z/0K6a7w4oWe82l8fxsvtsjOMpXXp0d93BAHBACfilgTZ6A4IbzRah6rYeHsJveUUFnrHRMdgcmOAWypFYpsEj8oxUeYSIVBe6RJuZn8Vjc9Z+FcmGgpQOkeFccdEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WkGVZiUZ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240715202325euoutp01823a08a61d0b043faa945016ee5f4b4f~ifJlQ9_6e0104401044euoutp018
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:23:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240715202325euoutp01823a08a61d0b043faa945016ee5f4b4f~ifJlQ9_6e0104401044euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721075005;
	bh=vN7x0hq6+p6q0t6yeDdJXRFb2GOC/OnEqwOTieT18EM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WkGVZiUZ3GoKBlGtXny4CyTTon9eKlm1Yd4T1nSzb8EXL3Vlma5CM0IEi4RhRv6fi
	 jOjF6Rqg5YAY4j6u+YLoz3ORpu3HSyvITMu2+iAAme3NQQjrsvGIyUkfz1YKySQ8Kr
	 X88F4wuDe24cWM7hKN3GduuHMvCQ13EmKhoAXtY0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240715202324eucas1p127c3be5f29570e87141ea4477224f1d5~ifJkOfN4G0337603376eucas1p1L;
	Mon, 15 Jul 2024 20:23:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 84.3F.09620.C3585966; Mon, 15
	Jul 2024 21:23:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240715202324eucas1p2f56cc2ca88610b417ddba5c0d6bb9826~ifJj2bS5f1153511535eucas1p26;
	Mon, 15 Jul 2024 20:23:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240715202324eusmtrp209cf96026a899431fe9cc5f4e4a63ec0~ifJj173OK3252132521eusmtrp2t;
	Mon, 15 Jul 2024 20:23:24 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-b2-6695853c1454
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 58.70.09010.B3585966; Mon, 15
	Jul 2024 21:23:23 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240715202323eusmtip17cdea21cf97e490ac8c957acc46582c3~ifJjn7zi50199301993eusmtip1Z;
	Mon, 15 Jul 2024 20:23:23 +0000 (GMT)
Received: from localhost (106.210.248.117) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 15 Jul 2024 21:23:23 +0100
Date: Mon, 15 Jul 2024 22:23:19 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <20240715202319.mccb6jlsa6dkynap@joelS2.panther.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87o2rVPTDLacFLKYs34Nm8W6t+dZ
	LS7vmsNm8fvHMyaLGxOeMjqwemxa1cnmcWLGbxaPz5vkPPq7j7EHsERx2aSk5mSWpRbp2yVw
	Zaw5t5C14ChPRfvOCSwNjKc4uxg5OSQETCQ6O3+zdTFycQgJrGCUmLVtByOE84VRov/WQ1YI
	5zOjxOnW5exwLb+2MYHYQgLLGSWefImEK1r6fglU+1ZGif/fulhAqlgEVCXONX9nBrHZBHQk
	zr+5A2aLCNhIrPz2mR2kgVlgEqPEhvPXWEESwgIxEuf7t4AV8Qo4SJy4u4EFwhaUODnzCZjN
	LKAncWPqFKDLOYBsaYnl/zggwvISzVtng7VyCvhKbFtxjRniamWJm/++M0HYtRJrj50B2ysh
	8IBDYt3bz4wQCReJJY3noN4Ulnh1fAuULSPxf+d8JoiGyYwS+/99gOpezSixrPEr1FhriZYr
	T6A6HCUW32hjB7lOQoBP4sZbQYjr+CQmbZvODBHmlehoE5rAqDILyWuzkLw2C+G1WUheW8DI
	sopRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMw1Zz+d/zrDsYVrz7qHWJk4mA8xCjBwawk
	wuv9c0qaEG9KYmVValF+fFFpTmrxIUZpDhYlcV7VFPlUIYH0xJLU7NTUgtQimCwTB6dUAxPv
	S6Oq0ndaWe9/pQfGL3a84rtmvdIGr3czFNJ1rOfUXz/l+vBTavsRk4VzRWXyuLibV4fkPUyW
	W/tkGl+kpkzF0b/T969dcOy9082lUeYFTys2aGf171De9cqxUK0qRWt+gZH64ynzN5hY6N32
	XNZ58+5/3gc7nzbv6OWabx7LVdvlYTSxMOv4Sn3VI9funl+3OyPxRsecul0e3KmxpsX77aSM
	bf+fP7z4jmTRYcnEy5vK5Plizl08cT0w8kB/x67WnZx6P2c56bjxMvYey3OpWj6n53TU7Dlv
	77O2tc4ILv3sO8fnwVSpuU+WRfo/3ry2/PKlS0yS7dvNenacYZF/oM68W29i3v3jvebLRLWV
	WIozEg21mIuKEwEY10tTpAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xu7rWrVPTDPbPM7OYs34Nm8W6t+dZ
	LS7vmsNm8fvHMyaLGxOeMjqwemxa1cnmcWLGbxaPz5vkPPq7j7EHsETp2RTll5akKmTkF5fY
	KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZaw5t5C14ChPRfvOCSwNjKc4
	uxg5OSQETCQ6f21j6mLk4hASWMooceTVBnaIhIzExi9XWSFsYYk/17rYIIo+Mkp8mTUZqmMr
	o8Tmz5vAOlgEVCXONX9nBrHZBHQkzr+5A2aLCNhIrPz2mR2kgVlgEqPEtDOHGUESwgIxEuf7
	t4AV8Qo4SJy4u4EFYuoCRon/n06wQiQEJU7OfMICYjML6EncmDoF6A4OIFtaYvk/DoiwvETz
	1tlgczgFfCW2rbjGDHG2ssTNf9+ZIOxaiVf3dzNOYBSZhWTqLCRTZyFMnYVk6gJGllWMIqml
	xbnpucVGesWJucWleel6yfm5mxiBkbjt2M8tOxhXvvqod4iRiYPxEKMEB7OSCK/3zylpQrwp
	iZVVqUX58UWlOanFhxhNgWE0kVlKNDkfmArySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNL
	UrNTUwtSi2D6mDg4pRqYim0jzjg3RDH/92ioX1klUC/FFfO7d1ewWtWsj4vlAvsSzRq+XjC/
	YWBbwPD16Tn3Pe4VfGbLunIKe8w3MCVpsLZy7OEsvpO1O3VWsnmRdeq3vztdLsjvKq1ZaJy6
	RuxZkrThiS4DSauUyrdFunxHmVhTz2ur81tcTL3Ouk7nTv3Cj32LDdY73DntwfHuobRe1deW
	/y8Zjp5vDgoJYJrwXtl5QU1Xx5PTN7rOBXbzvFSb77zwvtf0LVXVUw862mjk7NT0u35s2qmF
	l/RuMp5ed6+lfIJM8kW/a2slTj7o8p1tVxoqlD49r2m30zxm8fyAe7+f7O08XLF78bIQbu5N
	5zf6cvOtPFO791A3d4cSS3FGoqEWc1FxIgAkzV4nTQMAAA==
X-CMS-MailID: 20240715202324eucas1p2f56cc2ca88610b417ddba5c0d6bb9826
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
> ---

The merge window is now open. I want to send this patch on the Wednesday
of next week (jul 24).

@Thomas: Some questions

1. Are there any updates?
2. Does it still apply cleanly against the latest master branch?
3. Are you able to do the last update at the beginning of next week (Jul
   22)?

Best


-- 

Joel Granados

