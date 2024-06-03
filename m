Return-Path: <linux-kernel+bounces-198706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6FA8D7C5F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13BA0B209BD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0C743172;
	Mon,  3 Jun 2024 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F8L7w/0E"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5822F482D8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399385; cv=none; b=GoXBsYssfR1hpD1jT7q2LeWjHcKLQIIEpC0E+MB/2WBj1z9XoG4L/FM9vU1cJpZS4IBqXyl+lhYi7iC+pV8710xwyEyWdcO44JVNXx9CCKf87CWtZtjPp3wDKY0SuyNDxmXDf7CG56G5TkNP37FJi81TdTOF1yVVD3EKeOOfQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399385; c=relaxed/simple;
	bh=KQZt4AJ93v3cKSsd9GvzX4O9AJNuGEg5QhKSf/Ku1ZE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=dpEIUS1q2aoYcclA93SVUGAJj5T4zi127NbAEUnTISQHGemCfxUyzbq+WNVn9vONRK4g08qBWAyr43SnZgbmBOq8T34/idaLqjsej/11BIrqHaHpJV2oXnYwxu1CiZvZDsj4XO6Fie+WIUZ7AnRkI5enrTx2xyks3vv7pZNdbhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=F8L7w/0E; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240603072301euoutp02bc2cde75c6e5b8710bdac3e82af473bc~VbaNrEh5f2835828358euoutp02r
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 07:23:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240603072301euoutp02bc2cde75c6e5b8710bdac3e82af473bc~VbaNrEh5f2835828358euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717399381;
	bh=EkbmGCzh/nQo6pGVXmEjTKKwDfhlCH+JdFkpa2Tl01Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=F8L7w/0EwLsS3cKPKrQqzZQZLof4yLDXFlCS2TxRbTTcUKcd+DIyljYKaM6VnhitO
	 WMtPBiLWMTm3lhzkN6HYbUr4KleHVcdr9wY50t0vTGZkBMRtjxU4s/KbciEfTFJIOf
	 ILT5dY22Tcm0KSQUdMYJC/flCrhQdgcYIoCwUG7Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240603072301eucas1p18dffc97ff04d814062ef3d416ec234e8~VbaNgWvFo0801808018eucas1p1F;
	Mon,  3 Jun 2024 07:23:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 62.8B.09620.55F6D566; Mon,  3
	Jun 2024 08:23:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240603072301eucas1p2b3cc1eeb1628118ff9e4c08cd93a3622~VbaNMfbqm0095500955eucas1p2a;
	Mon,  3 Jun 2024 07:23:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240603072301eusmtrp2cfa26f45234bd17b33b2934bdbdd32bd~VbaNL9LWf2227022270eusmtrp2Z;
	Mon,  3 Jun 2024 07:23:01 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-8f-665d6f55ba45
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 13.01.08810.45F6D566; Mon,  3
	Jun 2024 08:23:00 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240603072300eusmtip1051be470531aafad4a3c8167a42dc23e~VbaM-jKtN1737917379eusmtip1W;
	Mon,  3 Jun 2024 07:23:00 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 3 Jun 2024 08:23:00 +0100
Date: Mon, 3 Jun 2024 09:22:55 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kees Cook <kees@kernel.org>
CC: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, Luis Chamberlain
	<mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Current state of the sysctl constification effort
Message-ID: <20240603072255.6i3xqzwjlqk2fi36@joelS2.panther.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOd3Q/Ng0g6YtIhbr3p5ntbi8aw6b
	xY0JTxktDr2dzubA4rFpVSebx+wlN1g8Pm+SC2CO4rJJSc3JLEst0rdL4Mq4e+whY8ESropl
	O1+wNDDO5Ohi5OSQEDCROPDsBVMXIxeHkMAKRonJv44yQjhfGCXOfHjBCuF8ZpRo2PWAHabl
	8d0dUInljBJXVs1hA0mAVZ2/pAmR2MQo8f/uNmaQBIuAikT/7d+MIDabgI7E+Td3wOIiAvIS
	O+Z9AbOZBeolXjf9ZAKxhQXsJPZsWA62jVfAQWLdressELagxMmZT1gg6jUlWrf/BqrhALKl
	JZb/44AIy0s0b50NNpITaNWsix+ZIY5WlPi6+B4LhF0rsfbYGXaQOyUELnBIPPnyH6rIReLk
	0k9QXwpLvDq+BcqWkfi/cz4TRMNkRon9/z5Ada9mlFjW+JUJospaouXKE6gOR4kZK/exglwn
	IcAnceOtIMR1fBKTtk1nhgjzSnS0CU1gVJmF5LVZSF6bhfDaLCSvLWBkWcUonlpanJueWmyc
	l1quV5yYW1yal66XnJ+7iRGYVE7/O/51B+OKVx/1DjEycTAeYpTgYFYS4e2ri04T4k1JrKxK
	LcqPLyrNSS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoEk2Xi4JRqYBK8/fiXl9CKdpXCltn8
	0vY7s7bO/9Nzqsx0cXfcp4+vBM+dVCrdUJ3/8bzF35RHeVOWXY22mbvrCNsj8z6TCu9ClY/b
	FnMfb7JVVlzVHsaTWiUwI256pEWr+6pGt+n6SQeqY/oPsIS5vHnnNSv9T+iOFzIPxTTbzl31
	bQ15aLTvvNN2bqH969i37+i0OnysLsNQ7r7v77+pXbsz32xdqnRSbPrsi/bm+x7Mnd/S39L2
	RiDkm8icJxcVmx2d174JZC8KvamYGlil15LBUn43e27i34U2+10dfpz5+/rIYv9AvyfWP9VX
	f73aOn3P16BXrTptEamXPpydf/Wga+q0dvbAKvXEyM6VzjVM2j+XFCqxFGckGmoxFxUnAgDT
	4YtKmQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xu7oh+bFpBr/n21ise3ue1eLyrjls
	FjcmPGW0OPR2OpsDi8emVZ1sHrOX3GDx+LxJLoA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
	yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j7rGHjAVLuCqW7XzB0sA4k6OLkZNDQsBE4vHd
	HawgtpDAUkaJo8vzIeIyEhu/XGWFsIUl/lzrYuti5AKq+cgoMWHzcRYIZxOjRMflg+wgVSwC
	KhL9t38zgthsAjoS59/cYQaxRQTkJXbM+wJmMwvUS7xu+skEYgsL2Ens2bAcrJdXwEFi3a3r
	UEM3MkpMn3eUBSIhKHFy5hMWiGZNidbtv4EaOIBsaYnl/zggwvISzVtng83nBNo76+JHZoir
	FSW+Lr7HAmHXSry6v5txAqPILCRTZyGZOgth6iwkUxcwsqxiFEktLc5Nzy021CtOzC0uzUvX
	S87P3cQIjLhtx35u3sE479VHvUOMTByMhxglOJiVRHj76qLThHhTEiurUovy44tKc1KLDzGa
	AoNoIrOUaHI+MObzSuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqY
	hCpmmrvF7C25Jp279OqRcsv70bfW7frt+kN0muSCiXFFZ+YoLL18NHJPwWW7CWrR/12Ob5Tv
	LNm980j2mYsyfDxPm5ScN39MW7CqOvfN9njfZ5Grp+1bZqIV82T9ZT5bpYtHg1WvFH9nzFs4
	60nhEUmRI8n7Jrr2n9mht/XkT8eIf8dmT0kP5A+KikvQ0iyzuxKus5pFe3a22C+333r7zU+7
	5ZxoYr8ikLfj9OXne2r6955T02+592PxNRHpZ/VnRI4e3ZWWmflYN3XdytAbJ/QXbpfUvRy4
	08WmYuoSy+0X5nJUXdL+4e+5yuzknIV8Zx+dci71X7njEbeTDoPTw9bUfRk6zWHcsZGKBYuZ
	FyixFGckGmoxFxUnAgBZ0tDVQQMAAA==
X-CMS-MailID: 20240603072301eucas1p2b3cc1eeb1628118ff9e4c08cd93a3622
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
I was pulling all this into 6.11.

> 
> -Kees
> 
> > With this done it should be possible to also queue up 
> > sysctl: treewide: constify the ctl_table argument of handlers [2]
> > for the bots to chew on in -next.
> > 
> > My local builds are still succeeding on the last submitted version of
> > the patch.
> > 
> > 
> > Thomas
> > 
> > [0] https://lore.kernel.org/lkml/20240518-sysctl-const-handler-utsname-v1-1-27a6c8813620@weissschuh.net/
> > [1] https://lore.kernel.org/lkml/20240513-jag-constfy_sysctl_proc_args-v1-1-bba870a480d5@samsung.com/
> > [2] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-11-e0beccb836e2@weissschuh.net/
> 
> -- 
> Kees Cook

-- 

Joel Granados

