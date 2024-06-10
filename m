Return-Path: <linux-kernel+bounces-207819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C61D6901CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EE01F24935
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067227E785;
	Mon, 10 Jun 2024 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vuj9GxnQ"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB37BB17
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007050; cv=none; b=lSlpdV5u0Ty1LKoPhzXpZXZRLWNFPf+MwDQXxAI/0yetrtVbCVFTCOPCMmqO6FkM5IKVh3n0MLkKOWTPtgZMQL4SxJ1L1ZUwD72T5+Dsr46AUc1FZbPEz5ZR7siGgfVUKpGJcUavxy8dRcpkWaJJcTJXZOu2H+ceXGjS2eOEj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007050; c=relaxed/simple;
	bh=SEVrejtRx5bsF9pw0ubQNHd5vWI/yPCdrrfPiuiqR/4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=MAyg1x+DKppdDbt9Oa9UBhdwmI4ImVc/NXDov1Ksv23ZHAuYe/Yff8BFOc8qNy7iMMhZwVNZ1phaub8cWSixH2WXb0pUzXXtBFOOBe8PPoMyCHSRLz/KOVZdns34boWsKl5cyKw4wUqU6ZtGoQagd4HreFB9qFiXPiifuLKYjAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Vuj9GxnQ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240610081041euoutp020af945fe99820b075d6de2e99a91170a~Xlk0-aGlI2472924729euoutp02k
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:10:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240610081041euoutp020af945fe99820b075d6de2e99a91170a~Xlk0-aGlI2472924729euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718007041;
	bh=9Jy2Hm3+jpYB+BkG9IB8B67ubZlXJPox5iBKTImF8nE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Vuj9GxnQuLkc8YH8msV7VAgEKsqDszUvCN6miLYzU6a7xXlJrbN8ytzkvnY7ZW873
	 KDHwYcPKBzC9l7/NScExKJpWm5/JCsBXeM3apU76J3LoKJr01iHGC5uJcyO8roMc+l
	 vtl4uTFQzc+Nn6jVMbMgkWmPnmh2OOBtOEBcQ4YY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240610081041eucas1p1b0c210cb92489f8e6159c7405ef65235~Xlk0z8QEI3147531475eucas1p1B;
	Mon, 10 Jun 2024 08:10:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.00.09875.005B6666; Mon, 10
	Jun 2024 09:10:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240610081040eucas1p127eb67dcbd6b4d1f759feb634ef45cca~Xlk0TOyqj1882418824eucas1p1h;
	Mon, 10 Jun 2024 08:10:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240610081040eusmtrp14694ae48b0d4c3785ce643efbbf1d37d~Xlk0RkxpE1516215162eusmtrp1V;
	Mon, 10 Jun 2024 08:10:40 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-b7-6666b5007ee6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C0.CE.08810.005B6666; Mon, 10
	Jun 2024 09:10:40 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240610081040eusmtip2fe7e5238608ef78b80d11d77fc26197f~Xlk0IBdI_3175331753eusmtip2D;
	Mon, 10 Jun 2024 08:10:40 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 10 Jun 2024 09:10:39 +0100
Date: Mon, 10 Jun 2024 10:10:36 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
CC: Luis Chamberlain <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: Current state of the sysctl constification effort
Message-ID: <20240610081036.bugf62o3y2wh2ugu@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37d5fd30-9327-4b57-8e4d-22af929d3fc4@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzneV2GrWlpBjOf2Vic6c61uLxrDpvF
	jQlPGS0OvZ3O5sDiMbvhIovHplWdbB6zl9xg8fi8SS6AJYrLJiU1J7MstUjfLoEr4//tt4wF
	C/krVrbvZGpgnMrTxcjJISFgItF65R17FyMXh5DACkaJnddeMkE4XxglTu/+AOV8ZpR4cucR
	YxcjB1jL8Vk2EPHljBK/96xkhStqalkH5WxmlPhy5Tc7yBIWAVWJvosvmUFsNgEdifNv7oDZ
	IgLmEncOzgazmQVyJeZd6garFxawk9izYTmYzSvgIHHj5ylGCFtQ4uTMJywQ9XoSN6ZOYQO5
	iFlAWmL5Pw6IsLxE81aIkZwCNhITmmeyQ/ypKPF18T0WCLtWYu2xM2A/Swhc4JBobXrPBJFw
	kfi7/QOULSzx6vgWqGYZidOTe1ggGiYzSuz/9wGqezWjxLLGr1Ad1hItV55AdThKrHi4nA0S
	XnwSN94KQlzHJzFp23RmiDCvREeb0ARGlVlIXpuF5LVZCK/NQvLaAkaWVYziqaXFuempxUZ5
	qeV6xYm5xaV56XrJ+bmbGIHJ5fS/4192MC5/9VHvECMTB+MhRgkOZiURXqGM5DQh3pTEyqrU
	ovz4otKc1OJDjNIcLErivKop8qlCAumJJanZqakFqUUwWSYOTqkGJqf1zKmB7Il1Ezesn6X0
	+duNgsMrP055c39y7j2+5Te8LmzfJPruz93lPFYdLZonpZ/c/Jkyx11zgWyYikvWMluufaej
	dlm+uXqHfe3/OwLzDz+aNu/AJeW688w+e7z2PCp7985T97hJjzKXbMXhvfmH/WwTj5nG8pnv
	Yto2S9mUK7BtVceVq2sfiv/ZeeOM/M6ax6HNfCIlO7b7h53yLDFvdVRK6xDZuNmtT2PXzph1
	/spu3uJFVQzhL88rrdt8fan2au2e5HVT9fdXK9qdn7B+3boWpueZJb17TmutFZw5/8uVFjXd
	xeKzn2dnRum/cas5s3F7VcWkmN4+Te/71Zv8/ovNKJ7O9iGeRdXe+JcSS3FGoqEWc1FxIgDG
	15uanQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t/xe7oMW9PSDFr6lC3OdOdaXN41h83i
	xoSnjBaH3k5nc2DxmN1wkcVj06pONo/ZS26weHzeJBfAEqVnU5RfWpKqkJFfXGKrFG1oYaRn
	aGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8f/2W8aChfwVK9t3MjUwTuXpYuTgkBAw
	kTg+y6aLkYtDSGApo8Svs3eZuxg5geIyEhu/XGWFsIUl/lzrYoMo+sgosfLBXihnM6NE16v/
	7CBVLAKqEn0XX4J1swnoSJx/cwfMFhEwl7hzcDaYzSyQK/H2xHwwW1jATmLPhuVgvbwCDhI3
	fp5ihBj6g1Fi4Y/PLBAJQYmTM5+wQDTrSdyYOoUN5GxmAWmJ5f84IMLyEs1bIeZzCthITGie
	yQ5xtaLE18X3WCDsWolX93czTmAUmYVk6iwkU2chTJ2FZOoCRpZVjCKppcW56bnFhnrFibnF
	pXnpesn5uZsYgZG37djPzTsY5736qHeIkYmD8RCjBAezkgivUEZymhBvSmJlVWpRfnxRaU5q
	8SFGU2AQTWSWEk3OB8Z+Xkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMH
	p1QDU30v+5mIupvdkgn7Vi5dPNd+o1Uvv55BsWPUXL3NOm+79aYExASJ7HKNb522R+rcLGeO
	dbufMbzd9ylU8TYrP/e/KKXVjPIGDTGMy6Y35fa0H2hin1Uz72rqIcZt5vvyLVetcTvKe8Hh
	Atf1vDjuBydN5hTVb7mbXiP04f/HRo1ZNrtnsU5wi9Q13l4aN6c4R7PwRuyBAx7OXUs0Zgio
	qdU6hkXvZ6ox6uT21AnQ+JJhd/njo0szwt+JdXH/a26pWXu+e8txldtXnHfOiZyVf/PvoSb/
	X2EeK7auXLwlnue2Ufxv0QmT+eynS7/6+Un4EN+JRn1TtxhXdbea9WUKsq898+Z7WMuV9emd
	L96gxFKckWioxVxUnAgA8t9rEkUDAAA=
X-CMS-MailID: 20240610081040eucas1p127eb67dcbd6b4d1f759feb634ef45cca
X-Msg-Generator: CA
X-RootMTR: 20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2
References: <CGME20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2@eucas1p1.samsung.com>
	<7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>
	<20240607094053.x3cmkhmrgaw6jqd3@joelS2.panther.com>
	<37d5fd30-9327-4b57-8e4d-22af929d3fc4@t-8ch.de>

On Fri, Jun 07, 2024 at 03:54:01PM +0200, Thomas Weißschuh wrote:
> On 2024-06-07 11:40:53+0000, Joel Granados wrote:
> > On Fri, May 31, 2024 at 12:50:32PM +0200, Thomas Weißschuh wrote:
...
> > Is there anything left to do besides
> > what is being discussed in this mail, to start changing the ctl_tables
> > to `static const`?
> 
> The changes to the tables also need (as per [0] and [1]):
> 
> * sysctl: move internal interfaces to const struct ctl_table
> * sysctl: allow registration of const struct ctl_table
> 
> I think we do the handlers for v6.11, the rest of [0] and [1] for v6.12
> and then we can go through the rest of the trees ctl_tables.

LGTM. Once you send "sysctl: move internal interfaces to const struct ctl_table" and
"sysctl: allow registration of const struct ctl_table", I'll put them
into sysctl-testing and have them there until they can go into sysctl-next
(after the end of the next merge window). Please send both of them in one
series and remember to work on the "what" and the "why" for the commit
messages and cover letter.

You can be inspired by this
"""
# Motivation
The reason we are constifying is:
1. It provides increased safety: Having things in .rodata section reduces the
   attack surface. This is especially relevant for structures that have function
   pointers (like ctl_table); having these in .rodata means that these pointers
   always point to the "intended" function and cannot be changed.
2. Readability: because it is easier to know up-front that data is not supposed
   to change or its obvious that a function is re-entrant. Actually a lot of the
   readability reasons is about knowing things "up-front".
As we move forward with the constification in sysctl, please include a more
detailed motivation in all your cover letters. This helps maintainers (that
don't have the context) understand what you are trying to do.
"""

Best

-- 

Joel Granados

