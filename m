Return-Path: <linux-kernel+bounces-261529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D7B93B858
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B6D282A89
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491B313AD3D;
	Wed, 24 Jul 2024 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YDmgcHdW"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124A6446DB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855119; cv=none; b=YwO5ZLqEdghBtUA3N8UjRwgsS3XViZm1jBM7wcjcr6IOJOaTFTca3fRyC9Q2lRr/LgkKrP137N6bk850PgRjsXgldx+KXPBwt0WvEVXCF5/xrj4/h9DNN7o5QN7X43GHVDsKxxHDNZdoLs8iiC3stnI/uXBfHvmn9DsPBz5WTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855119; c=relaxed/simple;
	bh=S84Hyr9EJDtWax4kJjtv51sFZDdcbLpccor0G85Rcz8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=JMljI6jBS7Lh8rz2nfyI4iHwT23jd8Y58Aof2wRNISZuKQLOs1BDpiOvu58fo1BhYhSQNFxOiEC69B7ksUOCDIz0kYeiEHXvo4N6BykbUyIFe+dUXrhz2Js2M9grm7MfSws0RskD4kja93NJRmDBqL1Pv6AvdWWQhMvFT0SD0DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YDmgcHdW; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240724210515euoutp02aa863df60ae84a64049c27c6352cd163~lQhrITR4-2009420094euoutp02D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:05:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240724210515euoutp02aa863df60ae84a64049c27c6352cd163~lQhrITR4-2009420094euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721855115;
	bh=Gfdodfqa8VOyHuBAYhmzdZnewRGz2UsIph3mC4WoUb4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YDmgcHdWnNYO1Id6LiRBHqsvPomIG52jofdjQZ9bGFrfO0gGi+465d8qlW5GafNcA
	 FPhi6aTCsAjKODIaHHGvMpMbNIqQrDHPoB0jZ3Fzf/Zq7PuWr6019lz7aJScwXxdWA
	 m8n8kM0xKGmoJCFr3SYVO9VOn60+xIi1RdIPTfTw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240724210514eucas1p2f08d5620ec23db279a205a76a8c21bca~lQhq0BUrP1418714187eucas1p26;
	Wed, 24 Jul 2024 21:05:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 8D.59.09620.A8C61A66; Wed, 24
	Jul 2024 22:05:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240724210514eucas1p20bfda97bcfa7886bbc32af817c92b006~lQhqVk3Vh1418714187eucas1p25;
	Wed, 24 Jul 2024 21:05:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240724210514eusmtrp1eacd84cdd75b30c9e74e3c7dbd4e258f~lQhqVEQ_Z1386213862eusmtrp1N;
	Wed, 24 Jul 2024 21:05:14 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-56-66a16c8a0230
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 87.9D.09010.A8C61A66; Wed, 24
	Jul 2024 22:05:14 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240724210514eusmtip2c30ded720e6f0018e8134609dea2a9db~lQhqJ-0OJ1346713467eusmtip2B;
	Wed, 24 Jul 2024 21:05:14 +0000 (GMT)
Received: from localhost (106.210.248.226) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 24 Jul 2024 22:05:13 +0100
Date: Wed, 24 Jul 2024 23:05:09 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kees Cook <kees@kernel.org>
CC: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Luis
	Chamberlain <mcgrof@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <20240724210509.b3n7eefakigdn2i5@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202406191350.BB98FF1@keescook>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7pdOQvTDG6/MbWYs34Nm8W6t+dZ
	LS7vmsNm8fvHMyaLGxOeMjqwemxa1cnmcWLGbxaPz5vkPPq7j7EHsERx2aSk5mSWpRbp2yVw
	ZRxt+sxS8J2nonvKBNYGxjecXYycHBICJhK3709g6WLk4hASWMEoMWn6GkaQhJDAF0aJ49dU
	IBKfGSUeLX/MBNNxbuV2RojEckaJ+3dns8FVnVq0E2rWVkaJtwtPsIO0sAioStxd0w/Wziag
	I3H+zR1mEFtEQF5ix7wvzCANzAIbGSV+b2wGSwgLxEic798CZvMKOEhM+/mQEcIWlDg58wkL
	iM0soCnRuv030AIOIFtaYvk/DoiwvETz1tlgrZxAu762P2OFOFtZ4t6mPcwQdq3EqS23mED2
	Sgjc4ZC482srG0TCRaLnTzc7hC0s8er4FihbRuL05B4WiIbJjBL7/31gh3BWM0osa/wKDRlr
	iZYrT6A6HCVmftgJdp2EAJ/EjbeCENfxSUzaNp0ZIswr0dEmNIFRZRaS12YheW0WwmuzkLy2
	gJFlFaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmCqOf3v+NcdjCtefdQ7xMjEwXiIUYKD
	WUmE98mruWlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotgskwcnFIN
	TF5fImZv1V22//zi12r5Qf9ypyxZtz9m7dU5zCdiH2e26e9uPv/1S+sMJu1XHeymixxmhl29
	GfR2o5qZLMPG8Lp5/v7Hft3+9mRmaLu1pY/cqhdRM+U9I1wMTkqWaFTH2UspMbP5LPrssebu
	FG7XZ+FZgpzXfysEXPWNXbgpzbRAd9sN9RuSLpx1f64fsdvLanhQZc/lzwyH3U22V8a9fDRn
	V519u+YZ/aSj2S/XplmUZktPsxV7P1PX1vvKnouWwt8frDt2QdTzQKCSu3nyWd6llmFLdilZ
	n70nrxp7KCO29t+Bm1bq9dY8wkws/h2xq5bf4FP5EMGmM+nYKr/idclWT256WZ1vWj579eMr
	b5VYijMSDbWYi4oTAUsA4hakAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7pdOQvTDD7skbCYs34Nm8W6t+dZ
	LS7vmsNm8fvHMyaLGxOeMjqwemxa1cnmcWLGbxaPz5vkPPq7j7EHsETp2RTll5akKmTkF5fY
	KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZRxt+sxS8J2nonvKBNYGxjec
	XYycHBICJhLnVm5n7GLk4hASWMoo0bOhnRUiISOx8ctVKFtY4s+1LjaIoo+MEovuX2WCcLYy
	Shy+t4INpIpFQFXi7pp+JhCbTUBH4vybO8wgtoiAvMSOeV+YQRqYBTYySjzZsAOsQVggRuJ8
	/xawIl4BB4lpPx9C3XGIUeLk5DtMEAlBiZMzn7CA2MwCmhKt23+zdzFyANnSEsv/cUCE5SWa
	t84Gm8MJtPhr+zOos5Ul7m3awwxh10p8/vuMcQKjyCwkU2chmToLYeosJFMXMLKsYhRJLS3O
	Tc8tNtIrTswtLs1L10vOz93ECIzEbcd+btnBuPLVR71DjEwcjECXczArifA+eTU3TYg3JbGy
	KrUoP76oNCe1+BCjKTCMJjJLiSbnA1NBXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2
	ampBahFMHxMHp1QDE9PUTvUr6jcun52b92r/PmOOp//ymxaVyXLMfinZUFD7+ujZ7b/iXklu
	urW31tU8ctvEisi4ys+3Fl7v5bZlllziLyC1sjZj5oqnqYlaFqwz/F751gdEKt5NP53M9Wp9
	flVxoqyXq9fC4wfPZzG+6f6zJcyNvX3Dt/X1dXocZasdl937euSA8rdDZYvDvCZYNDo+n/r0
	5++pFQx6ug6MDbrBu8Jyf34Us9laIrCPJXSPh/bTi2I3ms86KMbfXzJxlhDPs/3HlX67pQtd
	zqiU1Zxx5050/nK/VaaRQrYyG4XzfvkGTz3tNf/pq/eLOsX6OYyFslYcE07d+i3Dcr3xX+uG
	zUpCkjHe/LsDHGWzlFiKMxINtZiLihMB9QR5Pk0DAAA=
X-CMS-MailID: 20240724210514eucas1p20bfda97bcfa7886bbc32af817c92b006
X-Msg-Generator: CA
X-RootMTR: 20240619205121eucas1p1b96e118efb0cb2325f6850e540a42ae6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240619205121eucas1p1b96e118efb0cb2325f6850e540a42ae6
References: <20240619-sysctl-const-handler-v2-1-e36d00707097@weissschuh.net>
	<CGME20240619205121eucas1p1b96e118efb0cb2325f6850e540a42ae6@eucas1p1.samsung.com>
	<202406191350.BB98FF1@keescook>

On Wed, Jun 19, 2024 at 01:51:15PM -0700, Kees Cook wrote:
> On Wed, Jun 19, 2024 at 12:09:00PM +0200, Thomas Weiﬂschuh wrote:
> > Adapt the proc_hander function signature to make it clear that handlers
> > are not supposed to modify their ctl_table argument.
> > 
> > This is also a prerequisite to moving the static ctl_table structs into
> > read-only data.
> > 
> > The patch was mostly generated by coccinelle with the following script:
> > 
> >     @@
> >     identifier func, ctl, write, buffer, lenp, ppos;
> >     @@
> > 
> >     int func(
> >     - struct ctl_table *ctl,
> >     + const struct ctl_table *ctl,
> >       int write, void *buffer, size_t *lenp, loff_t *ppos)
> >     { ... }
> > 
> > In addition to the scripted changes some other changes are done:
> > 
> > * The "typedef proc_handler" in include/linux/sysctl.h is changed to use
> >   the "const ctl_table".
> > 
> > * The prototypes of non-static handlers in header-files are adapted
> >   to match the changes of their respective definitions.
> > 
> > * kernel/watchdog.c: proc_watchdog_common()
> >   This is called from a proc_handler itself and is als calling back
> >   into another proc_handler, making it necessary to change it as part
> >   of the proc_handler migration.
> > 
> > No functional change.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> This looks good! I'll be glad to see these all be read-only. :)
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
Since the patch and the coccinelle script changed, I removed your
Reviewed-by tag from the commit that I sent. Just FYI.

-- 

Joel Granados

