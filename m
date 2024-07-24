Return-Path: <linux-kernel+bounces-260771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E26293ADFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414F7B23695
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BE614BFB4;
	Wed, 24 Jul 2024 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g2/rYsx+"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D82114A61E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810495; cv=none; b=Nm79mso5EMxsLQF7W8tkOTFmzxW8ZqtpHy9lDThzEXv0umQ0Ma1k8wN3Kb1VHo1ySqxLTdK/vxObDB9C87Yx2YX6nV5tPkit29CixCAEXzLYFBbenIbmBl+DOti8vd/woQzM1uIsVdlEqtaxdr12DlQ6hCXAVF0ooxx7uXZ1q10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810495; c=relaxed/simple;
	bh=F0Xd0DKGc0mYWZloYrihjc6dS4yazwWRp/NSRYm82dA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=FnNXa1ggij7Fe2WxgvmoWhGYpUZJQql2bpIcwh+2sSPEJ+rdwwnazBJDYEXd5vJTk4ittleaxnJcXi/445o1abHfqX0wWBdnzRpyEvJo2ae9P/eqmpHOYavOB0plEDzsvD6QjbJPSQhH3G7++Ca7n0rWOvrYQakp5tJKdTfOUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g2/rYsx+; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240724084130euoutp029f3c6275a19b145b6591fae09dc83b57~lGYS2Oycn1864218642euoutp02C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:41:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240724084130euoutp029f3c6275a19b145b6591fae09dc83b57~lGYS2Oycn1864218642euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721810490;
	bh=MoujBrNUNwrCTT5sbfadXAlSHOApLoPfpff5mIQSa38=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=g2/rYsx+pKabwcJlcUDRy4rWHc/6IjzmEB2+859IZhJeWpXRZC/fqGpCxKpa3UcjN
	 1kvMsR+1dn7VTnSRYiPhVYq+xLutrAopjF8bOs+HPLhMcU2hPeI5TZMeaROguEuiMT
	 EBga/kJDzc8B/EtHdGKoM/8AfbzYCh54tAlIEwUs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240724084130eucas1p176b6989640ce93507119b5a8a289dfb7~lGYSq0DON1160211602eucas1p1g;
	Wed, 24 Jul 2024 08:41:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 38.2E.09620.93EB0A66; Wed, 24
	Jul 2024 09:41:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240724084129eucas1p28cd4e15e05f6037e3a7740e8a1c3d7f5~lGYSTMLUe1606116061eucas1p2H;
	Wed, 24 Jul 2024 08:41:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240724084129eusmtrp10f26c3dc44a39812ad4934ad144f5e63~lGYSSiNA-3269632696eusmtrp17;
	Wed, 24 Jul 2024 08:41:29 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-1f-66a0be3948f2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.02.08810.93EB0A66; Wed, 24
	Jul 2024 09:41:29 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240724084129eusmtip29f7ce1a44388fa1c92012901f6b1416f~lGYSFubWV1474814748eusmtip2G;
	Wed, 24 Jul 2024 08:41:29 +0000 (GMT)
Received: from localhost (106.210.248.226) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 24 Jul 2024 09:41:28 +0100
Date: Wed, 24 Jul 2024 10:41:24 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <20240724084124.hbbn3jfcbsc7pyov@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a48b4d3-94ca-4a42-bf59-c340d7316603@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduznOV2rfQvSDKZ2MlrMWb+GzWLd2/Os
	Fpd3zWGz+P3jGZPFjQlPGR1YPTat6mTzODHjN4vH501yHv3dx9gDWKK4bFJSczLLUov07RK4
	MnoOf2cs2C1ZMffWFsYGxk/CXYycHBICJhIz/75kBLGFBFYwSsw8b97FyAVkf2GUuPxsBiuE
	85lR4uC8VmaYjgeXrrJDJJYzSqw7vJINrurbkdlQzlZGibn3JrOBtLAIqEqsb3sJZrMJ6Eic
	f3MHbJSIgI3Eym+fwUYxC0xilNhw/horSEJYIEbifP8WoCIODl4BB4kJrQ4gYV4BQYmTM5+w
	gNjMAnoSN6ZOYQMpYRaQllj+jwMiLC/RvHU2WCcn0PjGqToQRytL3Nu0B+qBWolTW24xgWyV
	EHjAIfG9ZSMbRMJF4sT0o6wQtrDEq+Nb2CFsGYnTk3tYIBomM0rs//eBHcJZzSixrPErE0SV
	tUTLlSdQHY4Si2+0sYNcISHAJ3HjrSDEcXwSk7ZNZ4YI80p0tAlNYFSZheSzWUg+m4Xw2Swk
	ny1gZFnFKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmGZO/zv+dQfjilcf9Q4xMnEwHmKU
	4GBWEuF98mpumhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5VCGB9MSS1OzU1ILUIpgsEwen
	VAOTaW59cuSt6fFzkgLPyC1sPT3n+ku/nirxK545sw1+qsTU3ot6w8Xo+/DaDF0LhYB32mHb
	C+M3OXztN7ETvZYxv8CnTuTpxa6Podq8q1r6fzj03HyWGxTIJZLU+K944T67smluF3h9TufO
	MmqLSVvT48Sq8cPFY+nfVRtuzPn27J9g8MovN7il+Zp/3Psf4zfpUb3Nuv3rmy2/5mnW/NwR
	dlL1hnfjRza7FRL5d4UNlBX4fi/99kT3sJ9Z/50lDdPqXGzurZZkfWF3Z7GoOuN6M+VC2Zft
	wfpt5dl31rdebt2T+7qpyUlM/bxBFOdMs82R4ufPaV/WPHQvkuETV86LbeaafwTXLGvImqnX
	26nEUpyRaKjFXFScCACebnjlogMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7qW+xakGRzapmYxZ/0aNot1b8+z
	WlzeNYfN4vePZ0wWNyY8ZXRg9di0qpPN48SM3ywenzfJefR3H2MPYInSsynKLy1JVcjILy6x
	VYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy+g5/J2xYLdkxdxbWxgbGD8J
	dzFyckgImEg8uHSVvYuRi0NIYCmjxJQjfcwQCRmJjV+uskLYwhJ/rnWxQRR9ZJTomnoNytnK
	KNHx7AwLSBWLgKrE+raXbCA2m4COxPk3d8AmiQjYSKz89hlsBbPAJEaJaWcOM4IkhAViJM73
	bwEq4uDgFXCQmNDqADH0NrPEjoWbwVbzCghKnJz5BGwBs4CexI2pU9hA6pkFpCWW/+OACMtL
	NG+dDTaGE2hX41QdiKOVJe5t2gP1TK3E57/PGCcwisxCMnQWkqGzEIbOQjJ0ASPLKkaR1NLi
	3PTcYkO94sTc4tK8dL3k/NxNjMAo3Hbs5+YdjPNefdQ7xMjEwXiIUYKDWUmE98mruWlCvCmJ
	lVWpRfnxRaU5qcWHGE2BITSRWUo0OR+YBvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tS
	s1NTC1KLYPqYODilGpgim8w41//Y62bp6+mWtVL4cHx+5eI7BzNXHLyb0KEV6hgivGk2I+ua
	EHnF4uAJOpsKW5iLFJ5mzc2W6FbwqLfZtCRoxaWZ6V9/3H19LXqik5gW17nim4cP101aOuF/
	Orvqo5eMholpNz94rHTfv7e/+p4ke0OA7Z+K6/Gyy0tetFlm9DX9rox0v5E9neu0gOWLvjf2
	TeccvgUc0Ymb3deb6/fzlrjv8g/PFvGcPMZ0uM1v6993TrwHBE3fz9v6+MeH2NsKPec1Hiy5
	dmZKW1VRaHeg0oOvFevcot82F/5kv873fMvsTGnflweW/ZaY4e1nNXmTkckX0eyqW7w6Oxy9
	lVNY099rnxfNvhxh+kKJpTgj0VCLuag4EQBdzv5NSwMAAA==
X-CMS-MailID: 20240724084129eucas1p28cd4e15e05f6037e3a7740e8a1c3d7f5
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

On Mon, Jul 22, 2024 at 09:41:36AM +0200, Thomas Weißschuh wrote:
> Hi Joel,
> 
> On 2024-07-17 21:57:48+0000, Joel Granados wrote:
> > On Wed, Jul 17, 2024 at 05:26:44PM +0200, Thomas Weißschuh wrote:
> > > On 2024-07-16 17:27:05+0000, Joel Granados wrote:
> > > > On Mon, Jul 15, 2024 at 10:58:10PM +0200, Thomas Weißschuh wrote:
> > > > > On 2024-07-15 22:23:19+0000, Joel Granados wrote:
> > > > ...
> > > > > > The merge window is now open. I want to send this patch on the Wednesday
> > > > > > of next week (jul 24).
> > > 
> > > <snip>
> > > 
> > > > > > 2. Does it still apply cleanly against the latest master branch?
> > > > > 
> > > > > Not against mainline master, but against next-20240715.
> > > > > To apply cleanly (and compile) on mainline master it still requires the
> > > > > net/ and sysctl trees to be merged.
> > > > > Otherwise some modified functions are missing, leading to (trivial) merge
> > > > > conflicts or the preparation commits are missing, leading to compilation
> > > > > errors.
> > > > 
> > > > Understood. I have just sent Linus the changes for sysctl-next, so those
> > > > should land in master soon (baring any issues with the pull request).
> > > > 
> > > > These [1] and [2] are the two series in net-dev that are the deps for
> > > > the constification treewide patch. Once these two go into mainline, then
> > > > we are good to go. Right?
> > > 
> > > Right, but...
> > > 
> > > It turns out the preparation patch for mm/hugetlb.c [0] is also still
> > > missing. I missed it in all the errors triggered in net/.
> > > But as far as I can see this patch will be part of Andrew's PR for mm.
> > 
> > Thx for the heads up, I'll Add that one to my radar of things that need
> > to be in master before we send the PR to Linus. Will check these three
> > dependencies on Wednesday next week and send your V2 [3] if I see that
> > it applies cleanly.
> 
> All dependency PRs (sysctl, net, mm) are now merged.
> My compilation tests all succeed now.

How did you apply the coccinelle script? I ask because if I do this:
```
 make coccicheck MODE=patch SPFLAGS="--in-place --include-headers" COCCI=SCRIPT
```

I have to add "virtual patch" to the first line of the script you had
sent. So it would look like this:
```
virtual patch

@@
identifier func, ctl, write, buffer, lenp, ppos;
@@

int func(
- struct ctl_table *ctl,
+ const struct ctl_table *ctl,
  int write, void *buffer, size_t *lenp, loff_t *ppos)
{ ... }
```

Additionally, this cocci script is not changing the header files. Even
if I pass --include-headers. Did you change those by hand?

Best

> 
> > > <snip>
> > > 
> > > [0] https://lore.kernel.org/lkml/20240518-sysctl-const-handler-hugetlb-v1-1-47e34e2871b2@weissschuh.net/
> > > 
> > > > [1] net: constify ctl_table arguments of utility functions
> > > >     https://patchwork.kernel.org/project/netdevbpf/list/?series=856252&state=%2A&archive=both
> > > > [2] bpf: constify member bpf_sysctl_kern::table
> > > >     https://patchwork.kernel.org/project/netdevbpf/list/?series=854191&state=*
> > 
> > [3] https://lore.kernel.org/20240619-sysctl-const-handler-v2-1-e36d00707097@weissschuh.net

-- 

Joel Granados

