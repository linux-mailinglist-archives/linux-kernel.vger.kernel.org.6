Return-Path: <linux-kernel+bounces-202000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F378FC663
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B561F259E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA061946BD;
	Wed,  5 Jun 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ebrizkpz"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FDF1946B2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576002; cv=none; b=DzaIFxTDgeIJ7xbEtS5QZorJ/5cKRKKiXDLd6vZUZ/GiUAC8aowGEAeadzBIrVCVJCcX5Yao8NTrAQkLEOmRQPBFdDW3W8TIR+h8fBwN/AlBYr8ui8S6ap/7ceg2JgH9rRw3MWl7nId/8z/4OO4Q1toiDPLyW1ecXqTO/Nt5f+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576002; c=relaxed/simple;
	bh=+cl6rgudeiiLBUD63PbZLMpUnEG+QiOIGc+pelJ3+I8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=bYUQqE+ghn3dxlg+YTw5vTEFd/D0GVoCf8QxzpzMTXkj7zj88WKZ2ZrxsV1fJPggBUKdwjMQnpv3syxd2kQ06iXSKpG5XyDxEWna0fsDXO1CMZE7zvuNibbhuhgQGuc2LLwy1CjtKQsp05kI4pOQbY9xLbKex1wZWIGeEJkuJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ebrizkpz; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240605082631euoutp01c9095ae6dd83fabb1ce560f0c706e39e~WDkOzgxt51194711947euoutp01e
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:26:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240605082631euoutp01c9095ae6dd83fabb1ce560f0c706e39e~WDkOzgxt51194711947euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717575991;
	bh=+YzdbY3Eo7YidevssvYDgo7A4uBztMQmdrWcxxE5wSw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EbrizkpzGXZX4V46d4cv6tD+uy3QptDZe6S8o64iiewnSN57mFYGPF6rJfM595u5U
	 KosDLyG6ZlR5/a9fiJs3FcSA8ao8CG/4497N06ghKoozs3mgrYMsiNEZqoKjsZjwqF
	 175c3CzjmP/2aniM0TNykn1/TQwUxBAcQ8+f76oU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240605082631eucas1p28fe06b75a172e67e34b8020e4c22837c~WDkOo5V2P2093620936eucas1p2m;
	Wed,  5 Jun 2024 08:26:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 78.F5.09875.73120666; Wed,  5
	Jun 2024 09:26:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240605082631eucas1p245e3ce3d1c696eaf29e6fbfe62057824~WDkOQx5TQ2102821028eucas1p2l;
	Wed,  5 Jun 2024 08:26:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240605082631eusmtrp2f8fdfce5f7861c3260c568edce874f3c~WDkOQI1NI2841128411eusmtrp2W;
	Wed,  5 Jun 2024 08:26:31 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-19-6660213794af
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 1C.32.09010.73120666; Wed,  5
	Jun 2024 09:26:31 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240605082631eusmtip16a83b7a2d895970c5e800c07b151d521~WDkOGIxrw2282322823eusmtip1d;
	Wed,  5 Jun 2024 08:26:31 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 5 Jun 2024 09:26:30 +0100
Date: Wed, 5 Jun 2024 10:26:25 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kees Cook <kees@kernel.org>
CC: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, Luis Chamberlain
	<mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Current state of the sysctl constification effort
Message-ID: <20240605082625.6hwdc3haim66rr7v@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202405310930.5E2728A@keescook>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzneV1zxYQ0g54tyhbr3p5ntbi8aw6b
	xY0JTxktDr2dzubA4rFpVSebx+wlN1g8Pm+SC2CO4rJJSc3JLEst0rdL4MpoOdbIXtDLVdGy
	6xdLA+Md9i5GTg4JAROJt/sWsnQxcnEICaxglGh9/YsJwvnCKHFy6ywo5zOjROPaWYwwLVeW
	XoRKLGeUmLZmBStc1csN36Eymxgljl46ADSZg4NFQEXi7FFFkG42AR2J82/uMIPYIgLyEjvm
	fQGzmQXqJV43/WQCsYUF7CT2bFgOdiCvgINEQ+dEZghbUOLkzCcsEPWaEq3bf7ODjGcWkJZY
	/o8DIiwv0bx1Nlg5J9CqWRc/MkMcrSjxdfE9Fgi7VmLtsTPsIGdKCFzgkNg89yXUZy4SL/qf
	QdnCEq+Ob4EGkozE/53zmSAaJjNK7P/3Aap7NaPEssavTBBV1hItV55AdThKzFi5jxXkOgkB
	PokbbwUhruOTmLRtOjNEmFeio01oAqPKLCSvzULy2iyE12YheW0BI8sqRvHU0uLc9NRio7zU
	cr3ixNzi0rx0veT83E2MwKRy+t/xLzsYl7/6qHeIkYmD8RCjBAezkgivX3F8mhBvSmJlVWpR
	fnxRaU5q8SFGaQ4WJXFe1RT5VCGB9MSS1OzU1ILUIpgsEwenVAOTgE/Y6xW1a52Obz66Sf7L
	3diWFwemLvwi/19y+jXBD8u9ps9d88x4gTvL5nu9zfvuxS6Leu2+qHWXxue2mQ8O6/9QPuv6
	ojFLdP76sjM6jP9UbVcWfbs2IdfWcu7VHq8naxcWCuXoq/Fz6Clv5p5WsGOXhZnvkrx1rVdm
	nuk82ZJ+4AILm3TPWhP+zQu25YR8mTPtSfPMtpwqPiPnO8rpfz8zcRq+r9o38bRFd8su48WK
	v2vP8dYISQXcvN92bHKuyZ7ZbjYHXjlFSzJE74ow3cUmfyBpz73p1rFtFy/rfNA3aN6fynZJ
	do6t9xV9zmPxWy+2sTNZ1z1SWdIcqTo3I/mup+d8ttnhQTJPr5iuUWIpzkg01GIuKk4EAMVe
	lKuZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xu7rmiglpBn0PuSzWvT3PanF51xw2
	ixsTnjJaHHo7nc2BxWPTqk42j9lLbrB4fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
	ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfRcqyRvaCXq6Jl1y+WBsY77F2MnBwSAiYSV5Ze
	ZOpi5OIQEljKKLHn4TVGiISMxMYvV1khbGGJP9e62CCKPjJKvL30nxHC2cQo0XuiF6iKg4NF
	QEXi7FFFkAY2AR2J82/uMIPYIgLyEjvmfQGzmQXqJV43/WQCsYUF7CT2bFgOdgWvgINEQ+dE
	ZoiZGxklps87ygKREJQ4OfMJC0SzpkTr9t/sILuYBaQllv/jgAjLSzRvnQ02nxNo76yLH5kh
	jlaU+Lr4HguEXSvx6v5uxgmMIrOQTJ2FZOoshKmzkExdwMiyilEktbQ4Nz232EivODG3uDQv
	XS85P3cTIzDith37uWUH48pXH/UOMTJxMB5ilOBgVhLh9SuOTxPiTUmsrEotyo8vKs1JLT7E
	aAoMoYnMUqLJ+cCYzyuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRq
	YGqUW/Hj7srwd1quHxxOzyu5aWZ688z3AMnSY31XryeErOe63LbyV6jvKSuTzXXMB11TziQq
	6nq9qP9QssU19tvmn9UXtv2NcWf8dkl96Y/atOpMsYoC3d3aC2YxWt5lmMe1aUeQ+sLGqRqc
	tb0HZx9oe397jpMxT5OJ2dcD5tL3FU+p/c9xYvDRvSe4IJklPX7VBO+D8uGrm93Ljhc/Yt4g
	qHSUOfjpGaEzK0+V5nRuUD6wtjrrXvpGD/eYOyvM1i6Ie8YkyZn39YGr9I/7Ru374uPmHOo+
	3VoksjFKTuDK3AlNO2NkY+7GLTJ61q7xx+H3lbnL9mlveLo/d3pW9p2DJ2vt/yidLjwXPsPJ
	8r4SS3FGoqEWc1FxIgDiVArEQQMAAA==
X-CMS-MailID: 20240605082631eucas1p245e3ce3d1c696eaf29e6fbfe62057824
X-Msg-Generator: CA
X-RootMTR: 20240531163128eucas1p20976d08e829373bfa8aa04fda1c7bec4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240531163128eucas1p20976d08e829373bfa8aa04fda1c7bec4
References: <7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>
	<CGME20240531163128eucas1p20976d08e829373bfa8aa04fda1c7bec4@eucas1p2.samsung.com>
	<202405310930.5E2728A@keescook>

On Fri, May 31, 2024 at 09:31:24AM -0700, Kees Cook wrote:
> On Fri, May 31, 2024 at 12:50:32PM +0200, Thomas Weißschuh wrote:
> > Hi Joel, Hi Luis,
> > 
> > most of the sysctl handler preparation patches have been picked up by
> > the subsystem maintainers and are available in -next.
> > 
> > Only two are missing:
> > 
> > * utsname: constify ctl_table arguments of utility function [0]
> > * sysctl: constify ctl_table arguments of utility function [1]
> > 
> > Both of them are going through the sysctl tree anyways.
> 
> This is great! Is the target v6.11 or v6.10 for these?
> 
> -Kees
> 
> > With this done it should be possible to also queue up 
> > sysctl: treewide: constify the ctl_table argument of handlers [2]
> > for the bots to chew on in -next.
@kees: Since you have probably done these before, I'll ask you the
questions:

1. The idea is to send Linus the treewide-constify patch on its own at
   the end of the merge window for 6.11. Right?

2. Is there a special way to send these treewide patches? Or is it just
   a regular PR with an explanation on why it is being done?

3. Can you please send (if there are any) me any examples where this has
   been done in the past. Maybe some lore.kernel.org links?

Best

-- 

Joel Granados

