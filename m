Return-Path: <linux-kernel+bounces-198705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B98D7C5A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E816283E6D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A137D433BE;
	Mon,  3 Jun 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UT0va7Om"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B033F9EC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399301; cv=none; b=Wc7WU6f2oe4nHja13ay6V21SnakFMaLYzr/ikQ7wlrvtu+ltyCVFLZsyTx9PJ/abXinkuqQa3UXsCbSrs3qQse5kOzqEy1xbB1yUhi4zpjqMt+ZvG7FvPUBkWXeAC9+SiWU6CHx6vwD86cs1agyQtpyWFH0j4fc713le4dg0kHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399301; c=relaxed/simple;
	bh=eoCWKqOHYN2ze7yljZBylfR7DEimxZMJimxi2bjNq+s=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=nAKVrG4fhumpoWmcIsYbiipe+7rUBGxMepwENWVBVUGAicWc9uKOcw7YB3TdUoF6A+LJQ3Fen1+Z2BNum6AApkKW6PTFSr+A/u2VG4WhbQJS22DjOO0NHGOJ2Ohakdvw7fDbIjGpeqmjI2VyR8t6FbEP7YBzAmLUpjnRvak6lzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UT0va7Om; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240603072130euoutp02b3dff7617bac94560bfc7b87cd174c5d~VbY5VSWLX2414924149euoutp02h
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 07:21:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240603072130euoutp02b3dff7617bac94560bfc7b87cd174c5d~VbY5VSWLX2414924149euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717399291;
	bh=A3GJqBOGda1XX1J1THbvxvncPq9YyoJs+9JK1OPRqLw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UT0va7OmlGC4TWQ5dyOvsSjUcMdQT+z9dO6Xtkgtw0fO+L+Hf1qPXuwW8d6pXrLNI
	 2U7vUfHgZEUSJpFw2kS+OevYGMbd8VPd8ALVbn9/vOUMMaUemqV0x7gEUHjSw6VKnr
	 WA1GB20GRyVZyINR6drT8o0YPmDn8dBYFyl56uK8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240603072130eucas1p1614496ab167ccda86c91200fb968570d~VbY5Cr4Ac2940629406eucas1p1s;
	Mon,  3 Jun 2024 07:21:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 71.CD.09624.AFE6D566; Mon,  3
	Jun 2024 08:21:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240603072130eucas1p11d5ede76d3a846a2d8a73781196ac482~VbY4p3M1s2940629406eucas1p1r;
	Mon,  3 Jun 2024 07:21:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240603072130eusmtrp10a9b3a16213ae34263f174550bd59013~VbY4pSpr80870508705eusmtrp1Q;
	Mon,  3 Jun 2024 07:21:30 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-f6-665d6efa6b81
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.CE.09010.AFE6D566; Mon,  3
	Jun 2024 08:21:30 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240603072129eusmtip2fbcc0a3471f04bc43786482b21eefbe7~VbY4ZxQO32701327013eusmtip2s;
	Mon,  3 Jun 2024 07:21:29 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 3 Jun 2024 08:21:29 +0100
Date: Mon, 3 Jun 2024 09:21:24 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
CC: Luis Chamberlain <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: Current state of the sysctl constification effort
Message-ID: <20240603072124.gagi6uxkdux2p6qa@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned1febFpBrPuq1uc6c61uLxrDpvF
	jQlPGS0OvZ3O5sDiMbvhIovHplWdbB6zl9xg8fi8SS6AJYrLJiU1J7MstUjfLoEr48SRVYwF
	S7gqDvyYzdLAuImji5GTQ0LARGLSjz3sXYxcHEICKxglnq/ewAbhfGGUaPt2mBXC+cwocXvx
	RlaYlm0T70NVLWeUmLTgDzNc1cuva6FaNjFKLOvbC9bCIqAi8fH4biYQm01AR+L8mzvMILaI
	gLnEnYOzwWxmgVyJeZe62UFsYQE7iT0bloPZvAIOEs0/5rFA2IISJ2c+YYGo15O4MXUK0Bkc
	QLa0xPJ/HBBheYnmrRAjOQVsJGbs38UGcbWixNfF91gg7FqJtcfOgD0tIXCBQ+LV99tgcyQE
	XCS+LU+CqBGWeHV8CzuELSNxenIPC0T9ZEaJ/f8+QDWvBnqy8SsTRJW1RMuVJ1AdjhIrHi6H
	GsonceOtIMRxfBKTtk1nhgjzSnS0CU1gVJmF5LNZSD6bhfDZLCSfLWBkWcUonlpanJueWmyY
	l1quV5yYW1yal66XnJ+7iRGYXE7/O/5pB+PcVx/1DjEycTAeYpTgYFYS4e2ri04T4k1JrKxK
	LcqPLyrNSS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoEk2Xi4JRqYNKJiHEseG+yq3ZHg8Ke
	O6JPk3edKDc2PBObKyQ/7fb5go0qr67WpFQ+bTb8oqVq2/xAR6VwwuSVpvr1NzaeT86qTLvq
	l6VSPsE1yqzCYMEsqZqkjad4tv1xZs8+r732VLH7lTb2Ipelt0LeFhZPPKtRazl/d5s71+V/
	O6OyT/Bqhky9ctDxv9fXCL2M2UHLuPJenGviOLKxwXe+/9E9mrJBBmKay04mPtRavNW66IXy
	omWKlysc2j6vXKax9MFb3ls1yrUyJX4Nd/JkWXdHqSWIerYJbUxhmM/if3qXk3/Kk6mvdlss
	jW8s3GDJ/9Vz9tNVsalrar/bvZS5vNFb7PumoEn9U3oEuGJLorNllFiKMxINtZiLihMBo1Sx
	9Z0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7q/8mLTDJYv4rY4051rcXnXHDaL
	GxOeMlocejudzYHFY3bDRRaPTas62TxmL7nB4vF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGe
	oaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexokjqxgLlnBVHPgxm6WBcRNHFyMnh4SA
	icS2iffZuhi5OIQEljJKNNw8yw6RkJHY+OUqK4QtLPHnWhdU0UdGiRuNZxghnE2MEpNOzGYC
	qWIRUJH4eHw3mM0moCNx/s0dZhBbRMBc4s7B2WA2s0CuxNsT88FsYQE7iT0bloNt4xVwkGj+
	MY8FYmg/o8SdZ1MYIRKCEidnPmGBaNaTuDF1CtAZHEC2tMTyfxwQYXmJ5q0Q8zkFbCRm7N/F
	BnG1osTXxfdYIOxaiVf3dzNOYBSZhWTqLCRTZyFMnYVk6gJGllWMIqmlxbnpucVGesWJucWl
	eel6yfm5mxiBsbft2M8tOxhXvvqod4iRiYPxEKMEB7OSCG9fXXSaEG9KYmVValF+fFFpTmrx
	IUZTYBBNZJYSTc4HRn9eSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwen
	VANTuPzka5/j/h89d/zk7KLecM2t/iKB96WVfqzYMcsrpWG6Zdgy3kiJHqOEgKD2CZF7a1Ze
	0g/Q4ZuVNps3VN1+21eDf04B7wUunLhYW+KivKjx5sztu1+0JLlKFrK9dczZkfvJ72QbW1T7
	wfwEw4rkV4eaGnTWJUf1Xijb0f3EJTDv9lq79tuzP3DYzppcn9yd62q49uTmI42918V/9Pfw
	bO+88fnhQokC0fnbZwi0H7k5y8Nr59XSLSUK52INzdIfrruw6eta56dJnW8WP72xi2vqmhX3
	zP29WK+dVVy+vOt/++/QYqG5N66ZeE+LmdG2+oPkjjVL2Ldqur2atbh+Qd3XOTckXq2xPnew
	Y3/nWyWW4oxEQy3mouJEAP3rBGlGAwAA
X-CMS-MailID: 20240603072130eucas1p11d5ede76d3a846a2d8a73781196ac482
X-Msg-Generator: CA
X-RootMTR: 20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2
References: <CGME20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2@eucas1p1.samsung.com>
	<7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>

On Fri, May 31, 2024 at 12:50:32PM +0200, Thomas Weißschuh wrote:
> Hi Joel, Hi Luis,
> 
> most of the sysctl handler preparation patches have been picked up by
> the subsystem maintainers and are available in -next.
> 
> Only two are missing:
> 
> * utsname: constify ctl_table arguments of utility function [0]
> * sysctl: constify ctl_table arguments of utility function [1]
> 
> Both of them are going through the sysctl tree anyways.
Indeed. These are going to go into sysctl-next as soon as I get around
to creating the branch (this week, if all goes well :)

> 
> With this done it should be possible to also queue up 
> sysctl: treewide: constify the ctl_table argument of handlers [2]
> for the bots to chew on in -next.
> 
> My local builds are still succeeding on the last submitted version of
> the patch.
Indeed, and I have also tested it in the kernel test bots through my
kernel.org repos. So this is no surprise. 

> 
> 
> Thomas
> 
> [0] https://lore.kernel.org/lkml/20240518-sysctl-const-handler-utsname-v1-1-27a6c8813620@weissschuh.net/
> [1] https://lore.kernel.org/lkml/20240513-jag-constfy_sysctl_proc_args-v1-1-bba870a480d5@samsung.com/
> [2] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-11-e0beccb836e2@weissschuh.net/

-- 

Joel Granados

