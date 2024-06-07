Return-Path: <linux-kernel+bounces-205733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0517E8FFF89
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 321BEB27235
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880BC12FF96;
	Fri,  7 Jun 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kcvYmwh8"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24EC78C9A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752670; cv=none; b=PNDmHz3MjkMjWNDXW/M0JjrNRQLOj36dJUgu/Ojp4ZYKott2XEC00U23lbeevW0KnOkw26hRgT6qIDhgh3MUWo1ksFYdIyjAAprs8htqbRoG37S1HDmmK5blVZo5E+zluhqGw7YX8+c+fgAM4wx8l4gsUvWFhEIzmvpBhogqjUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752670; c=relaxed/simple;
	bh=gG+bUJnrPtgwLsrV97ksKD5NtK/Ty4/nFj2SETrG6Yw=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=KS1EZPcwE4iqSNQsOOSahD7qu9RPR3XSsLwn4H1izvdhTUidhsHClYT7rmxwQ8LddsQNwkSB/dYlILG+MPc/C8Jx5N6Jz/C9gnDkf5a+7ZtE1kPrTQ69ga8qDMbS+BhO2lJSQyGM6I9zI1ZmdHJjwJwqhMekeJo1x9wToCr9oGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kcvYmwh8; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240607093059euoutp0112646fa693cdb71c3101b9294d655503~WrvF3RAK23011330113euoutp01_
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:30:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240607093059euoutp0112646fa693cdb71c3101b9294d655503~WrvF3RAK23011330113euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717752660;
	bh=yw9YtbT2H6sEFUZcewAsaEnL0TT9wgQkl8MWZgYfP6c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=kcvYmwh8YnhvgmnthNno42e+tSrmfD90wZc3OkTRz6ftumImo+f3Vs2cxDOMk3UGs
	 FeOyRwCaXkdnxYNBo6v/QJNuTnHcC0PxpIwX2ZfWBXPbBwAP4JdiRgI7dJPY3i9M8D
	 cpc1gHJXZYAiZGhe1NZXaZAF3F92+D0m0aWtofC8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240607093059eucas1p1b2abe8e6ba8feee61fdc4c5c51cbc890~WrvFrEYCA2220722207eucas1p1U;
	Fri,  7 Jun 2024 09:30:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E8.D6.09624.353D2666; Fri,  7
	Jun 2024 10:30:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240607093059eucas1p2825b2366c6f98880a48fb7933bbd56be~WrvFTdyCC3036530365eucas1p27;
	Fri,  7 Jun 2024 09:30:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240607093059eusmtrp15939478975890a2e54d37b78db05ca02~WrvFS8eo72550625506eusmtrp1Q;
	Fri,  7 Jun 2024 09:30:59 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-e5-6662d353d0f4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id CC.A3.09010.353D2666; Fri,  7
	Jun 2024 10:30:59 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240607093059eusmtip29803f72998c7624e4f0120292a5cf728~WrvFBdDei0560405604eusmtip26;
	Fri,  7 Jun 2024 09:30:59 +0000 (GMT)
Received: from localhost (106.210.248.166) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 7 Jun 2024 10:30:57 +0100
Date: Fri, 7 Jun 2024 11:30:53 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kees Cook <kees@kernel.org>,
	=?utf-8?B?PT91dGYtOD9xP1Rob21hc19XZWk9QzM9OUZzY2h1aD89?=
	<linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Current state of the sysctl constification effort
Message-ID: <20240607093053.ig6cqrr3xdxhbbt5@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202406061143.27C12F44A3@keescook>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djPc7rBl5PSDD781LRY9/Y8q8XlXXPY
	LH7/eMZkcWPCU0YHFo9NqzrZPD5vkvPo7z7GHsAcxWWTkpqTWZZapG+XwJXx+ehkpoKnfBU7
	/1g0MO7n7mLk5JAQMJE4sWMWaxcjF4eQwApGiVd32llBEkICXxglFp0QhEh8ZpR4cWAhC0zH
	/E932CASyxklGi73MUJ0AFW9/qcHkdjCKNHatQ6sg0VAReLk1ftgNpuAjsT5N3eYQWwRgRKJ
	4x9vAcU5OJgFPCT2TggFCQsL2Ens2bCcHcTmFXCQ2P5hIjOELShxcuYTsDHMQGMW7P7EBtEq
	LbH8HwdImFNAX6L57QRmiDuVJU6tmsYGYddKrD12hh3kNAmBPRwSd1sWMUEkXCQaf/+HahCW
	eHV8CzuELSNxenIPC0TDZEaJ/f8+QHWvZpRY1vgVqttaouXKE6gOR4kZK/exglwkIcAnceOt
	IMShfBKTtk1nhgjzSnS0CUFUq0msvveGZQKj8iwkr81C8toshNcWMDKvYhRPLS3OTU8tNsxL
	LdcrTswtLs1L10vOz93ECEwbp/8d/7SDce6rj3qHGJk4GA8xSnAwK4nw+hXHpwnxpiRWVqUW
	5ccXleakFh9ilOZgURLnVU2RTxUSSE8sSc1OTS1ILYLJMnFwSjUwTXWaFBH0R3Z9tpJ+SfX6
	aqP9q62dwja3/bJXqwjOMp6wbKv4tG1f7NftyJl3sZWleIF+l7zlRdPlAS9SM5c+1HslcZ6v
	/YMoW7RKVPtlGwmhT7zHZ/zhW+5VZnzWw+LS9dNTdLKrW8qb7Cav/3bKwXKZUWstx3zLlSt/
	aX08mfvpwczDh5Qt6pUvmb0oPtX+KDGWr/99mMamOZ2Fz+N8A/NdrD89TvZfEey5pPfQzaKX
	+079TFp77qz4pJWR5+OfyUi827Lc12yHTXZ20zbBqLjPnS80mHasd9Ro/zbbLObd/pkpunL2
	vWvbl+1r/jDloM+fy+Zzjgcfnrqd9+QN95MFvMHZtsFPfr6zfnmNXYmlOCPRUIu5qDgRAEkV
	uMaKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xe7rBl5PSDH48FLRY9/Y8q8XlXXPY
	LH7/eMZkcWPCU0YHFo9NqzrZPD5vkvPo7z7GHsAcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
	ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfx+ehkpoKnfBU7/1g0MO7n7mLk5JAQMJGY/+kO
	WxcjF4eQwFJGiR0Tv7BCJGQkNn65CmULS/y51gVV9JFRYuO5AywQzhZGidWzvrGAVLEIqEic
	vHofzGYT0JE4/+YOM4gtIlAicfzjLaA4BwezgIfE3gmhIGFhATuJPRuWs4PYvAIOEts/TGSG
	mNnLJLHw9xlGiISgxMmZT8BmMgPNXLD7ExvEHGmJ5f84QMKcAvoSzW8nMEMcqixxatU0Ngi7
	VuLV/d2MExiFZyGZNAvJpFkIkxYwMq9iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjJ9tx35u
	2cG48tVHvUOMTByMhxglOJiVRHj9iuPThHhTEiurUovy44tKc1KLDzGaAkNiIrOUaHI+MILz
	SuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYzPf+mHxE1G/ZfGHP
	en5nsfjD3luSt+y57LBLgOflRcuU9eXORw3dRfYySbRpPRFefGtLvN+5hd4HBc0W2D/xEMt4
	WNT64L5kpsY6kcTarzXv+O6++58Z0JPGv5BL57fIz5ev6xavsEmSffqrqvHBcr28jNSpCTdT
	Zm/w3Px74voq9iSlC1tWy6g9fXLHdjf/1oSQ0PK9xxjLG1fMy8yIr37+2erOwZPilrmPjsv8
	vJH0dp3Ml9//ZzdHrq95ELrnbfnDex/XqkoyXN8zx/d61KsznXxFtpf0dR4c9ylbv/bmu2dt
	UZ8iRGWOMq/ReCSry5Ilu0Kif11CztYD8zcUma8TVvKVWXarSDNU/8wUcyWW4oxEQy3mouJE
	AJWn/fIoAwAA
X-CMS-MailID: 20240607093059eucas1p2825b2366c6f98880a48fb7933bbd56be
X-Msg-Generator: CA
X-RootMTR: 20240531163128eucas1p20976d08e829373bfa8aa04fda1c7bec4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240531163128eucas1p20976d08e829373bfa8aa04fda1c7bec4
References: <7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>
	<CGME20240531163128eucas1p20976d08e829373bfa8aa04fda1c7bec4@eucas1p2.samsung.com>
	<202405310930.5E2728A@keescook>
	<20240605082625.6hwdc3haim66rr7v@joelS2.panther.com>
	<202406061143.27C12F44A3@keescook>

On Thu, Jun 06, 2024 at 11:52:25AM -0700, Kees Cook wrote:
> On Wed, Jun 05, 2024 at 10:26:25AM +0200, Joel Granados wrote:
> > On Fri, May 31, 2024 at 09:31:24AM -0700, Kees Cook wrote:
...
> > @kees: Since you have probably done these before, I'll ask you the
> > questions:
> > 
> > 1. The idea is to send Linus the treewide-constify patch on its own at
> >    the end of the merge window for 6.11. Right?
> 
> Right. The best time is likely around Wed on the second week of the merge
> window, assuming all dependencies have landed. And it could be sent
> earlier if all the dependencies land sooner than that.
That makes sense. I have added a reminder to myself to do this when the
time comes. Feel free (@kees and @thomas) to scream at me if you see
that I might be forgetting :)

> 
> > 2. Is there a special way to send these treewide patches? Or is it just
> >    a regular PR with an explanation on why it is being done?
> 
> I would do a regular PR with all the details for Linus to do the change
> himself, but many times people send these as an explicit patch. For
> example, include the full Coccinelle script, or the "sed" command
> line, etc, and then detail any "by hand" changes that were needed on
> top of that.
@Thomas: have you sent the 11/11 patch on its own to the lists? I cant
find it in my history. Please send it as a stand-alone patch, so It can
go into sysctl just like the others.

> 
> > 3. Can you please send (if there are any) me any examples where this has
> >    been done in the past. Maybe some lore.kernel.org links?
> 
> I found this one that is a good example, though it's a PATCH not a GIT PULL:
> 
> https://lore.kernel.org/lkml/20221220134519.3dd1318b@gandalf.local.home/
> became
> https://git.kernel.org/linus/292a089d78d3e2f7944e60bb897c977785a321e3
> 

Thx for the help

Best

-- 

Joel Granados

