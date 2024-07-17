Return-Path: <linux-kernel+bounces-254780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B72933783
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FAA28161B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2621618E11;
	Wed, 17 Jul 2024 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bzMbEJxh"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02BE17721
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199619; cv=none; b=UoMVr4IJUejqt9dqS4XbzTKe722EzBkeSu8hPu+QxYroN0r+RlYCn91KkntpXES5DgYJnKp4QnGA4hOW80/FFh962CBgvyLUoSr7g+KRjkdTfUubI28dob0TMF3w0rLz/uO9Mw5TxpNSTimuKQeOQiadblMcws3PqFcqncZUiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199619; c=relaxed/simple;
	bh=EqwiWs+iOpk7g0tuP/hjx3eQs5pRF88hGkWdz2xsbZA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=u0ybek1fuunGbqTWqaQxyjdG7IiO7O4z+BGl/lDTdl52cxQvVUW4KYZUPzXRee3abWz++epvSwZJx5WYvgGRYxyezPCUPdOBbIEqEamQBatrEtfANRizdB4IlGBV/9DPjKYL+eQnxJqR9iiiBcPtcQKbFptecOeheDKxWLgKHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bzMbEJxh; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240717070014euoutp020c01430d07c880e040fe99e75f2ba31e~i7e4r3d8T2476324763euoutp02-
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:00:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240717070014euoutp020c01430d07c880e040fe99e75f2ba31e~i7e4r3d8T2476324763euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721199614;
	bh=BqQmvxngJh/jUxT0xcjtnge0rHXvJkSYChxldhCU0eE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bzMbEJxhp/nKl9JiIt1VulHwaX0xk/a+NqGGLgkmlJArTfxQMXwQ+0QEyxxXDu6Zl
	 KwL0YewYMXgKIElqESXKkRypynA04juO0lqYOoiU0ORbMAzTXpfipQuVp4OKzLPrTJ
	 ziuZGp9j8T1/8coqRlH5obralGAiumC93PGRPa5o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240717070014eucas1p25a69ebd8b04ffeac75fccbfe6ebde1db~i7e4dkgr91989919899eucas1p2h;
	Wed, 17 Jul 2024 07:00:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 67.C0.09620.EFB67966; Wed, 17
	Jul 2024 08:00:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240717070014eucas1p26bc42b2b532e6e40210ec5bc57c827ec~i7e4F6f9b2430324303eucas1p2D;
	Wed, 17 Jul 2024 07:00:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240717070014eusmtrp2210e51f611f3db51d99c7c885c1d6852~i7e3914lb0570805708eusmtrp2k;
	Wed, 17 Jul 2024 07:00:14 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-26-66976bfe3f1a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D5.28.09010.DFB67966; Wed, 17
	Jul 2024 08:00:13 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240717070013eusmtip270865bcd1140da1f214f4a2c2fca5523~i7e3u-c_71582415824eusmtip2D;
	Wed, 17 Jul 2024 07:00:13 +0000 (GMT)
Received: from localhost (106.210.248.174) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 17 Jul 2024 08:00:13 +0100
Date: Wed, 17 Jul 2024 09:00:09 +0200
From: Joel Granados <j.granados@samsung.com>
To: Markus Elfring <Markus.Elfring@web.de>
CC: <kernel-janitors@vger.kernel.org>, <cocci@inria.fr>, LKML
	<linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: latencytop: Use seq_putc() in lstats_show()
Message-ID: <20240717070009.g33selzj27lqg44n@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1b7f067-efa9-4550-8351-8923a71826fa@web.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned1/2dPTDJ6/kLP4/mABu8XLS62s
	FltvSVtc3jWHzeL/rOesDqwek14cYvGYdzLQ4/MmOY/bz7axBLBEcdmkpOZklqUW6dslcGW8
	2XCRraCPqeLx7FVMDYw3GLsYOTkkBEwkLndfYO9i5OIQEljBKNGxfQUThPOFUeLc6y1QzmdG
	iXm9W4BaOMBaHt5zhYgvZ5Q4PLGdHa7o/r+brBDOVkaJGc2X2EE6WARUJd58dQLZxyagI3H+
	zR1mkLCIgJbE08cmIOXMAh2MEg1zH7CA1AgLWEhMvg9Sw8nBK+AgMW32ViYIW1Di5MwnLCC9
	zAKaEut36UOY0hLL/3GAVDALyEs0b50N1skpYCVxZmU/K8SXyhLvH+xjgbBrJdYeOwN2soTA
	HQ6JAxNWQYPCReLh/SaoImGJV8e3sEPYMhL/d85ngmiYzCix/98HqO7VjBLLGr8yQVRZS7Rc
	ecIOCSFHibn7IiBMPokbbwUhjuOTmLRtOjNEmFeio01oAqPKLCSPzUJ4bBbCY7OQPLaAkWUV
	o3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYHI5/e/41x2MK1591DvEyMTBeIhRgoNZSYR3
	AuO0NCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC6YklqdmpqQWpRTBZJg5OqQYmcQbP
	1De7p/NU/zvNuTzd65Ps1YWPWO133DDLu/kndAebykNHRo3fq45kpAau9Tr04raa19OF997/
	FVkSzXJQfOoE8ZMnp0+bVKB69tdNth0TfJ/tee5gd7BFYe3DqXEVl1lX9RvzRczgFooP/von
	uj371eMpMoyrDgrFeYm0rv89v2GTOM/Ela5bG5X/n/Df8e6a0BKR2Nmtk2QzrJ+yLZWdJDnt
	VHBm6q8JEdLNGeUdr0//e2ux//VppyzntKk77ry8brz7U4rY3GjXMJG0iz5FyiHsbxk2LSqR
	Y3m72kjHMkxr+2SPKd2r3rS8njHbm/OfpOVUvv/x94RPXI86f3CWrfeWNLsfxT0COVd99yqx
	FGckGmoxFxUnAgCbnA9nnQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7p/s6enGfxqMrf4/mABu8XLS62s
	FltvSVtc3jWHzeL/rOesDqwek14cYvGYdzLQ4/MmOY/bz7axBLBE6dkU5ZeWpCpk5BeX2CpF
	G1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GW82XCRraCPqeLx7FVMDYw3GLsY
	OTgkBEwkHt5z7WLk4hASWMoocXrJGvYuRk6guIzExi9XWSFsYYk/17rYIIo+MkrM2XSfCcLZ
	yiixo/0QM8gkFgFViTdfnUAa2AR0JM6/uQMWFhHQknj62ASknFmgg1GiYe4DFpAaYQELicn3
	QWo4OXgFHCSmzd4KNfMLo8TGPz1sEAlBiZMzn7CADGIW0JRYv0sfwpSWWP6PA6SCWUBeonnr
	bLAxnAJWEmdW9kPdrCzx/sE+Fgi7VuLV/d2MExhFZiEZOgth6CyEobOQDF3AyLKKUSS1tDg3
	PbfYSK84Mbe4NC9dLzk/dxMjMPa2Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuGdwDgtTYg3JbGy
	KrUoP76oNCe1+BCjKTB8JjJLiSbnA6M/ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7
	NbUgtQimj4mDU6qBad8ZVkPWRYEzl6p07V8kv3au22MDL5HglX/uL9F8xTbN8kWL/XNW3y39
	xwVTLMrqpLWsY86ys3pt90ypvvkgzWWbz6ttF0JOS/M9tVzYeUHk81IrC65pG0+HFmmuW2Uf
	een3acUI9tcq/Jcs4wqvzzf2FX456Y/ye6aHMl9z728QcahVPBO+cuZnww3F2zy7vvM+Ud/B
	/Tno/f7QM2KGj2u/2DRtOn7bc69Q+sbOTcXGq01qXsifulB5K9buhV3eC88ZDRUqbsycNVo/
	ZqdkmSeedJ2Uv3DrEzY29XeNEjN2qE/iTpKwlxI+8pRz889wE4sjeQsYjOyjHvvUKseUnf/A
	6qPJIf6G/6uT/nFjJZbijERDLeai4kQArV/QQ0YDAAA=
X-CMS-MailID: 20240717070014eucas1p26bc42b2b532e6e40210ec5bc57c827ec
X-Msg-Generator: CA
X-RootMTR: 20240714100031eucas1p16b701d3e5852ccb40305a73bdb2a2759
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240714100031eucas1p16b701d3e5852ccb40305a73bdb2a2759
References: <CGME20240714100031eucas1p16b701d3e5852ccb40305a73bdb2a2759@eucas1p1.samsung.com>
	<19c77c4d-7f81-4980-a124-d6a8e14675d9@web.de>
	<20240716154520.vtlqv4jxlihy2h7r@joelS2.panther.com>
	<a1b7f067-efa9-4550-8351-8923a71826fa@web.de>

On Tue, Jul 16, 2024 at 07:06:06PM +0200, Markus Elfring wrote:
> > Not sure why this got forwarded to me.
> 
> The script “get_maintainer.pl” pointed your recent contribution out.
Makes sense. I'll still defer to arjan@linux.intel.com.

-- 

Joel Granados

