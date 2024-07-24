Return-Path: <linux-kernel+bounces-261379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2059393B689
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A60AB22BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85AC160783;
	Wed, 24 Jul 2024 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mH7vGz8E"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38715884B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845269; cv=none; b=g0TqVSB/LBOWkmLLm+qQjmwUNLJI9BNRD8AJImTiVtLJExSbdkBooUeALpTLANjFEGKs51JmiqAvCmA/m40p2yDgA4nRK3YiK8lKKUxonmomzcVjPV/0CZDgJZTwZrRyOswitBRFPdpWxzyrdz+4dZUTWDK9hiJPKjHlTp54xyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845269; c=relaxed/simple;
	bh=REv25IHweJQSJ/J7MmMAVaiKG1jUDlZF7c8W3aI0KZc=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=gPutYJH1WQzwAkF+0b7Q6pA/f0y4qzO8/RGIxSrDqxwPzplY/0+nzDkVR30ZtAkZmBYIXV3KbxX9+8VRdhZURzCS7I7FdOp6ESPkFbgiDyr5JMJCYW0ZfzkFNUib6ux3vhOW/r19Mu+V2w512VO3uJ9ObPk3RIOjseWkF2X+4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mH7vGz8E; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240724182104euoutp0200d540e624537b123ba1a28895a97091~lOSUvQ6Rd3222432224euoutp02I
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:21:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240724182104euoutp0200d540e624537b123ba1a28895a97091~lOSUvQ6Rd3222432224euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721845264;
	bh=WmEwAKzGIh3jRxASXU7XOPtQ+DyMRgCxKcyi/A6qrMo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mH7vGz8E2E6vQ0s0TNdzuw9ECtqvDo175ILinfP8RmZQEAS2OlfXBpZDyHV4JUXe9
	 6seAmEPG8aJoOkXIGIHAo/HXuyTns4K+UIpYyxZj0cphlF+x6VVtS6ppL7nbrYCVlo
	 AN4cw4XoH09KfEbjgbrXt1JuU2Pj5Wzg9xDrLDVk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240724182104eucas1p20dad451ecbfcdbac929fa71b8718c336~lOSUixUyZ2560725607eucas1p2s;
	Wed, 24 Jul 2024 18:21:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id F7.3B.09875.F0641A66; Wed, 24
	Jul 2024 19:21:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240724182103eucas1p201aef9e5aea99808c6029fea9c5ef100~lOSTuajyt2555325553eucas1p2j;
	Wed, 24 Jul 2024 18:21:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240724182103eusmtrp22094a2ce44484d15722db6874bdd7f76~lOSTt5Iwk0439404394eusmtrp2P;
	Wed, 24 Jul 2024 18:21:03 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-59-66a1460f8378
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 98.7B.09010.F0641A66; Wed, 24
	Jul 2024 19:21:03 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240724182103eusmtip1f6a903cf928f2f45272aa3d5f35ddf70~lOSTdScFE3172131721eusmtip1L;
	Wed, 24 Jul 2024 18:21:03 +0000 (GMT)
Received: from localhost (106.210.248.226) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 24 Jul 2024 19:21:02 +0100
Date: Wed, 24 Jul 2024 20:20:58 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <20240724182058.svxh3ux23p4fnqqf@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84dc8f21-78d2-4ea2-ad79-3f85b610c0a7@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87oCbgvTDK6+ZrSYs34Nm8W6t+dZ
	LS7vmsNm8fvHMyaLGxOeMjqwemxa1cnmcWLGbxaPz5vkPPq7j7EHsERx2aSk5mSWpRbp2yVw
	ZbSt+sZUsEC24s6v74wNjK3iXYycHBICJhJNPxcxdTFycQgJrGCU+HuwBcr5wihxYOEhNgjn
	M6PEro2X2WFanr6dzgKRWM4o8eJYFzNc1dnOs+wQzlZGie3PQIZxcLAIqErcO+AN0s0moCNx
	/s0dZhBbRMBGYuW3z2D1zAKTGCU2nL/GCpIQFoiRON+/BayIV8BB4uHZ3YwQtqDEyZlPWEBs
	ZgE9iRtTp7CBzGcWkJZY/o8DIiwv0bx1NlgrJ9D8HbdOQ12tLHFv0x5mCLtW4tSWW2B/Sgg8
	4ZC4s2UBK8gcCQEXiaYHERA1whKvjm+B6pWR+L9zPlT9ZEaJ/f8+sEM4qxklljV+ZYKospZo
	ufIEqsNR4vr3FqihfBI33gpCHMcnMWnbdGaIMK9ER5vQBEaVWUg+m4Xks1kIn81C8tkCRpZV
	jOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYgYnm9L/jX3YwLn/1Ue8QIxMH4yFGCQ5mJRHe
	J6/mpgnxpiRWVqUW5ccXleakFh9ilOZgURLnVU2RTxUSSE8sSc1OTS1ILYLJMnFwSjUwTdCZ
	tWTNXPONW/+9ZMp4p2CoKrfadAX7PJ1//nmZ6ZXN750FY/6sf1k8SXnZ6u6pWx/EBb5cLrq0
	+928c7eDk45p20dvy0wT8OU7m72hgWPyjEbZBAn/j48ffV3jY+VxxaM3JSlMUEFh4vLmty2B
	00WL9XcUbrAUtdHav+32M70qTeOVW3RXn1XbvPzu74OKs8rWWsbtPZIrJn3yWPD9Y6vvMQvH
	h36cwTD3d92diWqNV6aEXpCV6eq+/vLV+7jIoiNyu5ic/a/eqbXrt1we0mM8S9N2sWak+3xb
	N53d+hueljFPbJ8fK9K7ap3r7WXX1rkksYvf4fyg997/0MEvzxUWNK5uXh/yzfno6dqTL5VY
	ijMSDbWYi4oTAUR+JC+jAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7r8bgvTDA6f47SYs34Nm8W6t+dZ
	LS7vmsNm8fvHMyaLGxOeMjqwemxa1cnmcWLGbxaPz5vkPPq7j7EHsETp2RTll5akKmTkF5fY
	KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZbSt+sZUsEC24s6v74wNjK3i
	XYycHBICJhJP305n6WLk4hASWMoocfzXM1aIhIzExi9XoWxhiT/XuthAbCGBj4wSH2+rQDRs
	ZZTYsOc/excjBweLgKrEvQPeIDVsAjoS59/cYQaxRQRsJFZ++8wOUs8sMIlRYtqZw4wgCWGB
	GInz/VvAingFHCQent3NCDF0M4vE94/3GSESghInZz5hAbGZBfQkbkydwgayjFlAWmL5Pw6I
	sLxE89bZYHM4gZbtuHWaHeJoZYl7m/YwQ9i1Ep//PmOcwCgyC8nUWUimzkKYOgvJ1AWMLKsY
	RVJLi3PTc4uN9IoTc4tL89L1kvNzNzECo3DbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEd4nr+am
	CfGmJFZWpRblxxeV5qQWH2I0BQbRRGYp0eR8YBrIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQS
	SE8sSc1OTS1ILYLpY+LglGpgkoj162//eK3l573JRpMmJ/vcPHjpDHO0j+gJ7SvHLaUY/Faq
	vKv11HbLSzRh3u+7cN7yinlmVxN3d38tF9GI+NOZor2+P23nWQXVjZuOZz2b23fuyLRDmju0
	304teMPTy5+S2eV+Yb3MEokPGwr+3//3u+NKmmZB3rWqE///HLOZ+blA9DvTdPkORfNjM8ua
	zEOPbHRQOTtpeeLxpvuFE5xfPFm+ZGG3qeZe1SynHO5+Q49tjasExNn5Xle5CXVYsnZ9XRhW
	smPfslf3HhufrBWanh4R2fJ6gcDWW7+Wfyo4k/x/mYFK7Ie79RM+6dX6mUo8+Xyoo3KvhQWD
	VHYhc27du+sHZy7PXhos8O3VASWW4oxEQy3mouJEAL1beXdLAwAA
X-CMS-MailID: 20240724182103eucas1p201aef9e5aea99808c6029fea9c5ef100
X-Msg-Generator: CA
X-RootMTR: 20240724093233eucas1p148db81823daa1babc0b2a74ce501bbda
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240724093233eucas1p148db81823daa1babc0b2a74ce501bbda
References: <f7489470-b0da-406b-a8dd-0ae7aaeceec8@t-8ch.de>
	<20240716152705.juet6srejwq5o6je@joelS2.panther.com>
	<cdf0831f-f9af-4aa7-a3a0-970efeec1def@t-8ch.de>
	<20240717195748.fe5ttokbibcsw2ca@joelS2.panther.com>
	<8a48b4d3-94ca-4a42-bf59-c340d7316603@t-8ch.de>
	<20240724084124.hbbn3jfcbsc7pyov@joelS2.panther.com>
	<12465755-1df4-4231-9bec-1044bfcdca4a@t-8ch.de>
	<20240724091817.eohhckduvtjscibg@joelS2.panther.com>
	<CGME20240724093233eucas1p148db81823daa1babc0b2a74ce501bbda@eucas1p1.samsung.com>
	<84dc8f21-78d2-4ea2-ad79-3f85b610c0a7@t-8ch.de>

On Wed, Jul 24, 2024 at 11:32:26AM +0200, Thomas Weißschuh wrote:
> On 2024-07-24 11:18:17+0000, Joel Granados wrote:
...
> > > > ```
> > > 
> > > Yes, IIRC I got told during one review to drop it.
> > > But for me it is also necessary.
> > I also remember a comment from the XFS part of the patches where you
> > changed the formatting on some functions. What did you do to address
> > this? Did you change them manually? Or do you have a script?
> 
> Yes, the style fixes were done manually.
Ok. I have created some sed scripts to automate this.

> 
> > > Thinking back, there were other "virtual" lines, too.
...
> >   int , void *, size_t *, loff_t *);
> > ```
> > 
> > > 
> > > (It doesn't find anything else, though)
> > Maybe you are missing running it with --include-headers?
> 
> There seems to be a slight misunderstanding.
> I meant that it does not find anything *new* on top of the existing
> patch, not that it can fully recreate the patch.
Sorry, misunderstood you.

> 
> (I used --include-headers, undid one header hunk from the patch and
> validated that the hunk gets recreated)
ok. That means that "--include-headers" is active.

I actually made further changes on the cocci script for it to catch all
the corner cases that you did by hand. The patch changes substantially
as now there are much less formatting issues introduced by the script.
I'll include you as co-developed-by and in that way give you proper
credit for your work.

In order to reproduce what I did you need to run [1] with this cocci
script [2] and then run [3] with this sed script [4]. I have checked to
see that the same files are changed. The difference between what you and
I did is mainly that coccinelle does not make any formatting decisions.

Will create and send the PR shortly.

Best


[1]
```
  make coccicheck  MODE=patch SPFLAGS="--in-place --include-headers --smpl-spacing --jobs=8" COCCI=SCRIPT.cocci
```

[2]
```
  virtual patch

  @r1@
  identifier ctl, write, buffer, lenp, ppos;
  identifier func !~ "appldata_(timer|interval)_handler|sched_(rt|rr)_handler|rds_tcp_skbuf_handler|proc_sctp_do_(hmac_alg|rto_min|rto_max|udp_port|alpha_beta|auth|probe_interval)";
  @@

  int func(
  - struct ctl_table *ctl
  + const struct ctl_table *ctl
    ,int write, void *buffer, size_t *lenp, loff_t *ppos);

  @r2@
  identifier func, ctl, write, buffer, lenp, ppos;
  @@

  int func(
  - struct ctl_table *ctl
  + const struct ctl_table *ctl
    ,int write, void *buffer, size_t *lenp, loff_t *ppos)
  { ... }

  @r3@
  identifier func;
  @@

  int func(
  - struct ctl_table *
  + const struct ctl_table *
    ,int , void *, size_t *, loff_t *);

  @r4@
  identifier func, ctl;
  @@

  int func(
  - struct ctl_table *ctl
  + const struct ctl_table *ctl
    ,int , void *, size_t *, loff_t *);

  @r5@
  identifier func, write, buffer, lenp, ppos;
  @@

  int func(
  - struct ctl_table *
  + const struct ctl_table *
    ,int write, void *buffer, size_t *lenp, loff_t *ppos);
```

[3] 
```
 sed --in-place -f /tmp/constfy_formating.sed fs/xfs/xfs_sysctl.c kernel/watchdog.c
```

[4]
```
s/^xfs_stats_clear_proc_handler(const struct ctl_table \*ctl,$/xfs_stats_clear_proc_handler(\
\tconst struct ctl_table\t*ctl,/
s/^xfs_panic_mask_proc_handler(const struct ctl_table \*ctl,$/xfs_panic_mask_proc_handler(\
\tconst struct ctl_table\t*ctl,/
s/^xfs_deprecated_dointvec_minmax(const struct ctl_table \*ctl,$/xfs_deprecated_dointvec_minmax(\
\tconst struct ctl_table\t*ctl,/
s/proc_watchdog_common(int which, struct ctl_table \*table/proc_watchdog_common(int which, const struct ctl_table *table/

```

-- 

Joel Granados

