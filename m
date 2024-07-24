Return-Path: <linux-kernel+bounces-260805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6309E93AEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E041F25256
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32356142E73;
	Wed, 24 Jul 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rhs5q7WD"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5D14B968
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812712; cv=none; b=qesqwBYHMr4MY4xfAmghfh2CHQTwsJLcR0c7lPIpJ+6tSWzk4PYWLGG4n5J1fOFmchmJxcwli6X1rv/PR/cNFcRG3xbBt7aOyZXCP6u+fWWuvKe5s/lXmRBTmmMjKNdXvouJpEbebAdpaHC1L2hRT29SxubJ3dpPB990E8Kecx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812712; c=relaxed/simple;
	bh=diP9p40UC4pm2YLGL0ajjrKv50qOVBNFugnh/7jyn1E=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=E4/rvWDZ0BQ211pCwSaR7wbyBlc1sEJ4LvnuBVTCyojTar6WQ9L/YE1FrTxsAhtpSRGY7moynzSVAunVV9xrayq+ge20tPmT0PuWEVQXM5mvDvejG5xrXlhJzGMgu1pj2iSiva/rNhPWlUPCp4bd9lmpwB+2HU2KHByYYKYRlkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Rhs5q7WD; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240724091823euoutp010fa0082ea49fabc80b1c01e42349e868~lG4gOHFiC2381223812euoutp01F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:18:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240724091823euoutp010fa0082ea49fabc80b1c01e42349e868~lG4gOHFiC2381223812euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721812703;
	bh=YjlT2agvRT5+U7aYKX196G717NI0pqvVla48zBYjtd4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Rhs5q7WD4OYKcPtIMo949hP+6q1P3cvV229kOT+xyj3PNH3+Lk6pjh4p3lEkck30n
	 ThDJtGFib23dtCUcNUUj3MwjaoKaHZplSjdyRzHGk1Igofjg0KEzF+PhggNsCN8E1l
	 tyD1YYWo0dWFdQVDItjsoZU9bBRB4oSScYPdEiPQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240724091823eucas1p10446b875485c3c6d51b59a2f186d25d7~lG4gGfuHs2347723477eucas1p1x;
	Wed, 24 Jul 2024 09:18:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id D5.3C.09624.FD6C0A66; Wed, 24
	Jul 2024 10:18:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240724091823eucas1p1e492bb2a469d02b89c308c3dc304ed06~lG4fp_A790404404044eucas1p1B;
	Wed, 24 Jul 2024 09:18:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240724091823eusmtrp2fcc9f61c55c9d6270e9f0cc3874cc25d~lG4fo-9aP2169021690eusmtrp2S;
	Wed, 24 Jul 2024 09:18:23 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-47-66a0c6dfb1ac
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id EA.29.08810.ED6C0A66; Wed, 24
	Jul 2024 10:18:22 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240724091822eusmtip2005d7f5d223faf34c4c02dd138d55f69~lG4fYvkRC3232032320eusmtip2u;
	Wed, 24 Jul 2024 09:18:22 +0000 (GMT)
Received: from localhost (106.210.248.226) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 24 Jul 2024 10:18:22 +0100
Date: Wed, 24 Jul 2024 11:18:17 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <20240724091817.eohhckduvtjscibg@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12465755-1df4-4231-9bec-1044bfcdca4a@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87r3jy1IM2g/I2MxZ/0aNot1b8+z
	WlzeNYfN4vePZ0wWNyY8ZXRg9di0qpPN48SM3ywenzfJefR3H2MPYInisklJzcksSy3St0vg
	yji15SFLwSnxioNPLrE0MP4V7GLk5JAQMJHY/PMHaxcjF4eQwApGiXOH7rCDJIQEvjBKdH8q
	hUh8ZpTY/KKfGaajYeMqNoii5YwSt5YowhVt7LsLNWoro0TTyUWMIFUsAqoSu/bcZQKx2QR0
	JM6/uQM2SUTARmLlt8/sIA3MApMYJTacv8YKkhAWiJE4378FrIhXwEFi+c5tjBC2oMTJmU9Y
	QGxmAT2JG1OnAJ3BAWRLSyz/xwERlpdo3jobrJUTaP70uS0sEFcrS9zbtAfqg1qJU1tuMYHs
	lRB4wCFxb9dkJoiEi8SejoOMELawxKvjW9ghbBmJ/zvnQzVMZpTY/+8DO4SzmlFiWeNXqG5r
	iZYrT6A6HCUW32hjB7lOQoBP4sZbQYjr+CQmbZvODBHmlehoE5rAqDILyWuzkLw2C+G1WUhe
	W8DIsopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMw0Zz+d/zTDsa5rz7qHWJk4mA8xCjB
	wawkwvvk1dw0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryqKfKpQgLpiSWp2ampBalFMFkmDk6p
	Bqapu+60az0VfySp9WXVwk6Vn6LWLR/6Z2mf+SU4Pyzz0q1FG2/f0e8OO3V/um20ZWmfHlu0
	iItCVuW0twv2uQg6/o7cUdLVY/Nw7qxN9/VF0zZdbH65kZP36PHoe4JmNdOULiUYfGdUz3oh
	sFJxIVdQ5AIruVv/uUV9l97ZuToubU6GbIfNqQLdw8He/n1n2d8V/gzsPH4kbLlayDYLqw+b
	Sw8w231aKTNlQfHjwJf7BY2OcGWWuiy4vXr7d24mH6X+SpdLajmKW6Ryew6rep7w+77ka3ts
	Xdx/ljBhQUPrZUpMjKuuX9VPunNJfvmFX532r//alyW5HywWcxNmO8dZzlb2as1MztA3sdEP
	+pVYijMSDbWYi4oTAZbAlSWjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7r3ji1IM/hxzsZizvo1bBbr3p5n
	tbi8aw6bxe8fz5gsbkx4yujA6rFpVSebx4kZv1k8Pm+S8+jvPsYewBKlZ1OUX1qSqpCRX1xi
	qxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3Fqy0OWglPiFQefXGJpYPwr
	2MXIySEhYCLRsHEVWxcjF4eQwFJGiTfbfzBDJGQkNn65ygphC0v8udYFVfSRUWL31c2sEM5W
	RolTt+4wglSxCKhK7NpzlwnEZhPQkTj/5g7YJBEBG4mV3z6zgzQwC0xilJh25jBYg7BAjMT5
	/i1gRbwCDhLLd25jhJh6hEWi89NkRoiEoMTJmU9YQGxmAT2JG1OnAN3BAWRLSyz/xwERlpdo
	3jobbA4n0LLpc1tYIM5Wlri3aQ/UO7USn/8+Y5zAKDILydRZSKbOQpg6C8nUBYwsqxhFUkuL
	c9Nziw31ihNzi0vz0vWS83M3MQIjcduxn5t3MM579VHvECMTB+MhRgkOZiUR3iev5qYJ8aYk
	VlalFuXHF5XmpBYfYjQFhtFEZinR5HxgKsgriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJ
	zU5NLUgtgulj4uCUamBizVt2MMbJf5L9vbKdSTnyT5ewHMxUO32H+/1VsZhb/ydrPSr96/Qo
	U8GYb/ekmOo17tMib5S569+LjTg35WLTW0/2AzOEBV9eCp39fnVqxLKiPZuuyfytf+v8KOfv
	MS7O5oCvmjcWrGMLr872O7L6wbsLPw/KMlevELJzjhU+e5hr7erlL+79msHQ1Z4sLjj7xKYN
	DZP8XWf1qsqqcOz+5S9boHeNTWDH72/fbwRyRQvzPU5/M3FFWOT5ubZ8S2dyL9p+NG2SQIpC
	0NaUGPUMB8edVmyXH1pOPD19H3Pg3Nk686I2BXtqLKrT7grNndOfPNGw+zIH47dHf+7efSwd
	ubXMPvfS7Azu8q01fqpKSizFGYmGWsxFxYkALHAJaE0DAAA=
X-CMS-MailID: 20240724091823eucas1p1e492bb2a469d02b89c308c3dc304ed06
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
	<20240724084124.hbbn3jfcbsc7pyov@joelS2.panther.com>
	<12465755-1df4-4231-9bec-1044bfcdca4a@t-8ch.de>

On Wed, Jul 24, 2024 at 10:56:10AM +0200, Thomas Weißschuh wrote:
> On 2024-07-24 10:41:24+0000, Joel Granados wrote:
...
> > > > to be in master before we send the PR to Linus. Will check these three
> > > > dependencies on Wednesday next week and send your V2 [3] if I see that
> > > > it applies cleanly.
> > > 
> > > All dependency PRs (sysctl, net, mm) are now merged.
> > > My compilation tests all succeed now.
> > 
> > How did you apply the coccinelle script? I ask because if I do this:
> > ```
> >  make coccicheck MODE=patch SPFLAGS="--in-place --include-headers" COCCI=SCRIPT
> > ```
> > 
> > I have to add "virtual patch" to the first line of the script you had
> > sent. So it would look like this:
> > ```
> > virtual patch
> > 
> > @@
> > identifier func, ctl, write, buffer, lenp, ppos;
> > @@
> > 
> > int func(
> > - struct ctl_table *ctl,
> > + const struct ctl_table *ctl,
> >   int write, void *buffer, size_t *lenp, loff_t *ppos)
> > { ... }
> > ```
> 
> Yes, IIRC I got told during one review to drop it.
> But for me it is also necessary.
I also remember a comment from the XFS part of the patches where you
changed the formatting on some functions. What did you do to address
this? Did you change them manually? Or do you have a script?

> 
> Thinking back, there were other "virtual" lines, too.
> Maybe those were to ones that needed to be removed, but
> "virtual patch" should stay.
Understood.

> 
> > Additionally, this cocci script is not changing the header files. Even
> > if I pass --include-headers. Did you change those by hand?
> 
> Yes, I changed these manually, originally.
> 
> To do it through the script, you need a second subpatch:
> 
> ```
> @@
> identifier func, ctl, write, buffer, lenp, ppos;
> @@
> 
> int func(
> - struct ctl_table *ctl,
> + const struct ctl_table *ctl,
>   int write, void *buffer, size_t *lenp, loff_t *ppos);
> ```
Yes. But you are still missing one more subpatch to catch the function
declarations in header files that don't name the arguments; like the
ones in include/linux/mm.h. This is what I used for those:
```
@r3@
identifier func;
@@

int func(
- struct ctl_table *,
+ const struct ctl_table *,
  int , void *, size_t *, loff_t *);
```

> 
> (It doesn't find anything else, though)
Maybe you are missing running it with --include-headers?

This is the full cocci script that I have:
```
virtual patch

@r1@
identifier func, ctl, write, buffer, lenp, ppos;
@@

int func(
- struct ctl_table *ctl,
+ const struct ctl_table *ctl,
  int write, void *buffer, size_t *lenp, loff_t *ppos);

@r2@
identifier func, ctl, write, buffer, lenp, ppos;
@@

int func(
- struct ctl_table *ctl,
+ const struct ctl_table *ctl,
  int write, void *buffer, size_t *lenp, loff_t *ppos)
{ ... }

@r3@
identifier func;
@@

int func(
- struct ctl_table *,
+ const struct ctl_table *,
  int , void *, size_t *, loff_t *);
```




-- 

Joel Granados

