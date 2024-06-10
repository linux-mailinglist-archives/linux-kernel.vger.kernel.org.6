Return-Path: <linux-kernel+bounces-207874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0158901D52
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48FF1C21132
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD0F4D8C9;
	Mon, 10 Jun 2024 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SG3vJ4ZK"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35941C69
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009587; cv=none; b=P/4mtfLzUmLBXu/Ye1g9B9F2Cw09ZRWFhfk7JHwSm4GS6AUv63+oRL/LSzFmO8p+PCbAtM4PNB2/7aOn3PK+kJQgZfPjHR3fLB5RSWJT3gLgXwTGICOfLKGRUMUF2pckMEHejlsUc+UMp5fear7nd1XeWrWO0LzITFhNZEZWWD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009587; c=relaxed/simple;
	bh=jbKj2WaybwFmXo3hBH7Wln3dmWvh62gbab2vHQxJrzs=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=aWffdlQGtTtcZ7JGHqJcLL5WEdXFDua5mZF1F+1QMk4v9Ck8now0IYUWzIf3AOq7My14KcXyFsYYRGgNnc7pMrSvAvVBA3PKJvdRCzQAZxNftjAEYZHLw5tNf/5fbV4w+8U0MY96dy9J0FZIG4+9asPV37j25CA3RtbiUh52D6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SG3vJ4ZK; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240610085303euoutp02fa65fe76336e43366c3f6c26399a8f58~XmJ0SZahC0697406974euoutp02s
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:53:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240610085303euoutp02fa65fe76336e43366c3f6c26399a8f58~XmJ0SZahC0697406974euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718009583;
	bh=aY5zE5Az+KjV5gUHZuSCo5Ka39W2XFAzS0RqdALIlAk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SG3vJ4ZKEE/H1gTgIMqYz+vJIpFJRD9e7TNHQnCW0kiRY61SPkTV1JptRVeoqSZrr
	 3gL0ULXLQkOduELQ5EeT4MyORNfqRT4/bT6pHZcqHVGk7wq2b+aovpsPmiVSDeGX8X
	 4DMzKgp6Wdys0bJF4DIG3QgmqTP/wG1aZZS1Rh3Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240610085303eucas1p204b1b4d6e6f9f7bfd3ad8c96a5da3489~XmJ0HExp21436414364eucas1p2h;
	Mon, 10 Jun 2024 08:53:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 8F.4C.09624.EEEB6666; Mon, 10
	Jun 2024 09:53:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240610085302eucas1p222933623970153fdbdb6fbed7a5db86d~XmJziayNX1088610886eucas1p2t;
	Mon, 10 Jun 2024 08:53:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240610085302eusmtrp260becb9d15af52921cd6aaffac59122a~XmJzhaE5M0762407624eusmtrp2c;
	Mon, 10 Jun 2024 08:53:02 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-c3-6666beee020b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B6.68.09010.EEEB6666; Mon, 10
	Jun 2024 09:53:02 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240610085302eusmtip2690a2ce7f7c808332b11adedcbd7aa60~XmJzT7iK42235022350eusmtip21;
	Mon, 10 Jun 2024 08:53:02 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 10 Jun 2024 09:53:01 +0100
Date: Mon, 10 Jun 2024 10:52:58 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: Current state of the sysctl constification effort
Message-ID: <20240610085258.y6wextl4rk2tqflz@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a872f104-32ed-4479-9480-0cc01c31e998@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduzned33+9LSDP7GWqx7e57V4vKuOWwW
	v388Y7K4MeEpowOLx6ZVnWwenzfJefR3H2MPYI7isklJzcksSy3St0vgyvi7oIWlYJNIxfb1
	exkbGGfxdzFyckgImEjMXXCMpYuRi0NIYAWjxJyFH5kgnC+MEqd2f2aHcD4zSlw60sMG03J1
	412oxHJGiVlta9jgqpb9eMAM4WxmlLi5YCXQZA4OFgFViYknpEC62QR0JM6/ucMMYosI2Eis
	/AaygpODWSBdYlvra0YQW1jATmLPhuVgcV4BB4lrr+8wQtiCEidnPmGBqNeTuDF1ChvIeGYB
	aYnl/zggwvISzVtng43nBBq/rekjK8TRihJfF99jgbBrJdYeOwP2gITABQ6J6+2foT5zkVh1
	ZCU7hC0s8er4FihbRuL/zvlMEA2TGSX2//sA1b0a6OPGr0wQVdYSLVeeQHU4SsxYuY8V5DoJ
	AT6JG28FIa7jk5i0bTozRJhXoqNNaAKjyiwkr81C8toshNdmIXltASPLKkbx1NLi3PTUYsO8
	1HK94sTc4tK8dL3k/NxNjMCUcvrf8U87GOe++qh3iJGJg/EQowQHs5IIr1BGcpoQb0piZVVq
	UX58UWlOavEhRmkOFiVxXtUU+VQhgfTEktTs1NSC1CKYLBMHp1QDk+7BLd/U9s081bzPqSnL
	RYX3QcxPpkPTT009nZK3QKmv3nP+YouumjX2lnosYZ2X2rubdaOFV7Idm7wi8J/x+enNrFfL
	fRa9ZV1WVRkavbHxpu96tilLzIybp798cExP47knX4bWWuUbIpckv+UaTJu90/ulxt19c0sj
	PPXWCotZTyu89fv1TxXts/7LPViZN2U3yLpprBWpmhx3z27GXEs5L4kbMjkvCpqfzyz4nFH4
	ofCWT+CysCs5UwT+NRc+25KvG7Ih2GjD11ncZjd2M724t1JTpdrBfMVRrfTGlQyyF+fY6n3U
	/rrjqP0kpk0f5ig6/0mssb/5xO2NbNqvZVmCC9Yq7sh+wVTFFWP8XomlOCPRUIu5qDgRAFmV
	mLaYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xe7rv9qWlGdw8LWyx7u15VovLu+aw
	Wfz+8YzJ4saEp4wOLB6bVnWyeXzeJOfR332MPYA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
	yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j74IWloJNIhXb1+9lbGCcxd/FyMkhIWAicXXj
	XXYQW0hgKaPE5qWCEHEZiY1frrJC2MISf651sXUxcgHVfGSUWPh3NzOEs5lRovnJOaBuDg4W
	AVWJiSekQBrYBHQkzr+5wwxiiwjYSKz89hlsAbNAusS21teMILawgJ3Eng3LweK8Ag4S117f
	YYSY+Y1J4sLr3awQCUGJkzOfsEA060ncmDqFDWQXs4C0xPJ/HBBheYnmrbPBdnEC7drW9BHq
	aEWJr4vvsUDYtRKv7u9mnMAoMgvJ1FlIps5CmDoLydQFjCyrGEVSS4tz03OLjfSKE3OLS/PS
	9ZLzczcxAuNt27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRFeoYzkNCHelMTKqtSi/Pii0pzU4kOM
	psAQmsgsJZqcD4z4vJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkG
	popf8fG3IjfscvRLWLd0yyOFqf8S1ZbriCb5zSi5tF1uvu1C1r3sFnFd3d+7GhX6j/HXm15j
	3bjJ3HAN97qIncYnttq/eGL6Z6rHm/x5OguSZQ+e3cUaNkHDT/CezIl4H5ebmkV6qfk8L9s3
	9/ww2modvvKDhZ97zvnPc19xlkyxdErf77/gC7/pu/vKwnxp1/uUda9mLSo2sfW2flSz+OCO
	ymsLF3DK8jC0Fa55MPfqw+mrS94/+JrtuPuRpv12p8P7apJ3Prm2hOlUjQRfhovNQtmQ2z8P
	PFt6ND6lvHPxl9W/Db45frRzO3v9tuLmyDLlk7NPSv854J8kveBEaGWc6POaQpfJdzKFF0jq
	OyixFGckGmoxFxUnAgCyEtf3QAMAAA==
X-CMS-MailID: 20240610085302eucas1p222933623970153fdbdb6fbed7a5db86d
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
	<20240607093053.ig6cqrr3xdxhbbt5@joelS2.panther.com>
	<a872f104-32ed-4479-9480-0cc01c31e998@t-8ch.de>

On Fri, Jun 07, 2024 at 03:48:20PM +0200, Thomas Weißschuh wrote:
> On 2024-06-07 11:30:53+0000, Joel Granados wrote:
> > On Thu, Jun 06, 2024 at 11:52:25AM -0700, Kees Cook wrote:
> > > On Wed, Jun 05, 2024 at 10:26:25AM +0200, Joel Granados wrote:
> > > > On Fri, May 31, 2024 at 09:31:24AM -0700, Kees Cook wrote:
...
> > > 
> > > > 2. Is there a special way to send these treewide patches? Or is it just
> > > >    a regular PR with an explanation on why it is being done?
> > > 
> > > I would do a regular PR with all the details for Linus to do the change
> > > himself, but many times people send these as an explicit patch. For
> > > example, include the full Coccinelle script, or the "sed" command
> > > line, etc, and then detail any "by hand" changes that were needed on
> > > top of that.
> > @Thomas: have you sent the 11/11 patch on its own to the lists? I cant
> > find it in my history. Please send it as a stand-alone patch, so It can
> > go into sysctl just like the others.
> 
> No, I didn't send it to the list on its own yet.
> Do you want some changes or can I send it as-is?
> (Plus the new motivational blurb)

Please work on the commit message; no need to change the diff.

Here is more specific feedback on how to change the message in [1]

1. Say what was done in the first sentence. Something similar to this:
  "Add the const qualifier to the proc_handler function signatures to
  make clear...."

2. Include the general constification motivation. Something similar to
   this:
   "This patch is a prerequisite to moving all static ctl_talbe structs
   into .rodata which will reduce the attack surface in sysctl by
   ensuring that proc_handler function pointers cannot be changed."

3. No need to mention that this is to avoid lengthy transition. Please
   remove it from the commit. You can add it to the cover letter or just
   leave it out altogether. Up to you.

4. Please leave the cocci script. But I would be more specific on the
   rest of the changes. Something like this:

   "
   The patch was mostly generated by coccinelle with the following script:

       @@
       identifier func, ctl, write, buffer, lenp, ppos;
       @@

       int func(
       - struct ctl_table *ctl,
       + const struct ctl_table *ctl,
         int write, void *buffer, size_t *lenp, loff_t *ppos)
       { ... }

   In addition to the cocci changes:
   * Added a const qualifier to the ctl_table argument of the
     proc_handler typedef.

   * ... Change the others accordingly ...

   "

Best

-- 

Joel Granados

