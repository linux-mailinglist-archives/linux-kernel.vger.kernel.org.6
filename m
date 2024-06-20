Return-Path: <linux-kernel+bounces-222238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F78C90FEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56403B213B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EE617D8BA;
	Thu, 20 Jun 2024 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="owi0wwrO"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F05B05E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871756; cv=none; b=sYJb0PM24K4R6Hv44NOzK3GCfV+A/xS+l5f2BO7NOdeV7kjUPDhvmStiw6APAR/5uvvEnBEn1gfu5ZOFM2gy8XtZF8eck1F8EPDcoQxhN65mT/L50I2jcvJMPm/BFEebTwS3VnbUBjtp2ixwnea9nc+yXTvFMkaVo8G8PXclJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871756; c=relaxed/simple;
	bh=/QRRV5Y+fhggm6vBABCLYV+GPogqQaGYxTFZwUDbD9M=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=as25ficRy+mOSr/7v4makESccFzaLy1Q/npag5KaCY5/P/c6bPUEWvWM5SgMgyY6qlmJfCGEzwsfEkVy2Qsef5uOeSqbIbV9JGCBZLbMHTgeLWQK0jQq34UOMOT+6wk9iuVilToRV4Vl7FX+4ikcpF1ZER0cNdZMpvV8iidi/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=owi0wwrO; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240620082230euoutp02e55d4da833ba16de31e293d856d075fe~aqL-5tHMY1882818828euoutp02m
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:22:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240620082230euoutp02e55d4da833ba16de31e293d856d075fe~aqL-5tHMY1882818828euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718871750;
	bh=Zk7Gix7gLeub5T20XQwXYVwIrwOIXJSeDe4H5XwnMV4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=owi0wwrOlYq21wzaYeLnIptokD1WTuTd2qUhh0RO2bO6xEwc/1FiRbLEp/nqVfO+K
	 u0Oqz2Q9lP1xS8kqHJNDG9pQK3lOiGmMpDwonB2TBdEZklmMVRBQQFdnY2MTqs/lUR
	 zULY24MJBqfiZrCbf0aL3raqhIbWhlw8/iNnPnRM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240620082230eucas1p1afc7ac69d9398fd2c6d54bc75902a7f3~aqL-xSiJy1010310103eucas1p1S;
	Thu, 20 Jun 2024 08:22:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.61.09624.6C6E3766; Thu, 20
	Jun 2024 09:22:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240620082229eucas1p11da205609ce753fb185ea353058d2770~aqL-ep3Um0580305803eucas1p1r;
	Thu, 20 Jun 2024 08:22:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240620082229eusmtrp15605c68b5590fa653accf1ff2f1b2f13~aqL-eCe9F0563405634eusmtrp15;
	Thu, 20 Jun 2024 08:22:29 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-51-6673e6c6cd99
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id C0.2E.09010.5C6E3766; Thu, 20
	Jun 2024 09:22:29 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240620082229eusmtip13ea2df257e40f476cd26e849059d3aa7~aqL-VISCe1477014770eusmtip1d;
	Thu, 20 Jun 2024 08:22:29 +0000 (GMT)
Received: from localhost (106.210.248.242) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 20 Jun 2024 09:22:29 +0100
Date: Thu, 20 Jun 2024 10:22:24 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <20240620082224.ugseptlfdx23y5al@joelS2.panther.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7rHnhWnGSxdyGwxZ/0aNot1b8+z
	WlzeNYfN4vePZ0wWNyY8ZXRg9di0qpPN48SM3ywenzfJefR3H2MPYInisklJzcksSy3St0vg
	yvi2YT5rwW2uinVrJzA3MC7i6GLk5JAQMJG4tPYDaxcjF4eQwApGib6bq6CcL4wSjw92M0M4
	nxklDny8zAjTsqWzkwUisZxR4uTWVQhVU+YvY4JwtjJK/O+/xgbSwiKgKrF4eR8riM0moCNx
	/s0dZhBbRMBGYuW3z+wgDcwCkxglNpy/BlYkLBAjcb5/C1gRr4CDxPqzB6FsQYmTM5+wgNjM
	AnoSN6ZOAVrAAWRLSyz/xwERlpdo3jobrJxTwFdi24przBBnK0t8+fQGyq6VWHvsDDuE/YBD
	4tFHRQjbRWLnsm4WCFtY4tXxLVA1MhKnJ/eAvSwhMJlRYv+/D+wQzmpGiWWNX5kgqqwlWq48
	gepwlFh8o40d5DgJAT6JG28FIY7jk5i0bTozRJhXoqNNaAKjyiwkn81C8tkshM9mIflsASPL
	Kkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMBUc/rf8U87GOe++qh3iJGJg/EQowQHs5II
	7/OuojQh3pTEyqrUovz4otKc1OJDjNIcLErivKop8qlCAumJJanZqakFqUUwWSYOTqkGpjJX
	j+LbJ3Zb7T++dkbXoY7fdQtjFt+91mvXpRPG7PGZJ/KaXVQg203/vlSe56fCpSQjOqYtUDjF
	/1FWdgOncsjqK6r5AdtN3wntC1Dq5I41bk4+NPF6iJVle1ZEyZvbQuf4T9n6il34esx55d02
	6aNtgRmvBR/3lq36/XIZj8bdJPbKwN9/wma3epq/9ejVMebtzzvuxB7R9NgdmIAFulQVC+0N
	HvEqcAqpXeldGnZqqsqGU2lesReelt5NDMns7luban2Z87dEwlVv6bkS2sqRTCb7pqmymMcy
	Hy7i7D661OT+ajG1VuVM3+6ySdoGE/e+mG17lkvujkp/kMKP+vTGjVNXPapl38E6R4mlOCPR
	UIu5qDgRAJJU0rqkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xu7pHnxWnGcyYp28xZ/0aNot1b8+z
	WlzeNYfN4vePZ0wWNyY8ZXRg9di0qpPN48SM3ywenzfJefR3H2MPYInSsynKLy1JVcjILy6x
	VYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/i2YT5rwW2uinVrJzA3MC7i
	6GLk5JAQMJHY0tnJ0sXIxSEksJRRYk1fFwtEQkZi45errBC2sMSfa11sEEUfGSV2nL/FBOFs
	ZZR4vOYsWBWLgKrE4uV9YDabgI7E+Td3mEFsEQEbiZXfPrODNDALTGKUmHbmMCNIQlggRuJ8
	/xawIl4BB4n1Zw8yQ0xdwCjx/9MJVoiEoMTJmU/AbmIW0JO4MXUK0B0cQLa0xPJ/HBBheYnm
	rbPB5nAK+EpsW3GNGeJsZYkvn95A2bUSr+7vZpzAKDILydRZSKbOQpg6C8nUBYwsqxhFUkuL
	c9Nzi430ihNzi0vz0vWS83M3MQIjcduxn1t2MK589VHvECMTB+MhRgkOZiUR3uddRWlCvCmJ
	lVWpRfnxRaU5qcWHGE2BYTSRWUo0OR+YCvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tS
	s1NTC1KLYPqYODilGpgKrE9rx8/sbmt/+FK7RnWXfEJ456H3RrvuXonUbi7YePDun8QVDc/4
	TVdbLit8n/O3UPaS2vf++39/L7x3p7B062KT5zxv50yeyua/v3aPetqc/itWOvzM3Ws3XX9n
	2qSfquchIZa87jt/2tSLD19eW/1mybSbienRW8QiNGRMXtbOXTnvXLPRz3M5RWFZ+u8vJ3xi
	9dxuWTRF3u7c7bBItbgujiYntjnScqum8ImWrF/6Zqv7NfObBorPzT9P9dq9K+Yc19YWkece
	hTzvGwr89xc/3cXLmnR9zcqG4wpHHkbkmO/1+t93sq9zQsez3Qfry5WWHD5e+/hFzOlXPE4B
	78/M1NsSlH3sTraY18/bSizFGYmGWsxFxYkAZbviPk0DAAA=
X-CMS-MailID: 20240620082229eucas1p11da205609ce753fb185ea353058d2770
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

Awesome stuff!!! thx.

Signed-off-by: Joel Granados <j.granados@samsung.com>

Best
-- 

Joel Granados

