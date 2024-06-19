Return-Path: <linux-kernel+bounces-220780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B09AC90E6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4166F1F230E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E26180034;
	Wed, 19 Jun 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BnnY+FAE"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90D7D07F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789142; cv=none; b=RH/OqHph9eWUP3BgsuokczgFxvjBXv9uYQ32zo4rWeodPMf85DzblQGfWI57oAjDNRjUpd+jMh/ZnaydlkReTOASNxZqEl9zlpb0KZ8ciNYhvbyqyU1gHc43b4g6Kfpft74NJ9/vO4aXJX8Q1vV1cy97ZyMJ9f6XnLCcIrRVDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789142; c=relaxed/simple;
	bh=SJ5MjWa+kg4P31QsjkiYysOM7MxcX3F2b7YYfaZ041c=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=rY3dOMeC1MJFrsu7xYoOegx8RQQrdwwVJTgHZSlZdM0VvNxXD2CfbXXYBqftDEsy6NUK4VRMYyyMRpso2TXlWx/57QpTIf26hj/nl4KDMNLujC/Xb75YAawpmV26cyovxsslR/Vtv5AfLbXLLylKCQxt7PGmbI8rbYZnUafj078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BnnY+FAE; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240619092537euoutp0103bdc661a388d28bb982e13fc79ebd95~aXZ1JqB-v1844518445euoutp01Y
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:25:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240619092537euoutp0103bdc661a388d28bb982e13fc79ebd95~aXZ1JqB-v1844518445euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718789137;
	bh=C7MUlZlbXbQr4FMlK3fzLH/GoaX9/kMf7dZJJ5mXoMI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BnnY+FAEtR+19kI8WwkzyEVWmVs16dDRtv2WlyogNLEVPnhYHPMe6xT0JvQzDgVLE
	 3s87CTjiC64z2rri1bEu7r3uoBnIraeagnlBDlQNxICDum+eGpIe3cIvjC9cKo4zZg
	 xtLdzVaHyVmYMie9Xgf8G8vVDmwG/lCEfwbbWKRo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240619092537eucas1p13e685ae3537564bd31c99a38bc77fd09~aXZ06Soem2953529535eucas1p1_;
	Wed, 19 Jun 2024 09:25:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 53.9E.09624.114A2766; Wed, 19
	Jun 2024 10:25:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240619092537eucas1p1564630b83ceb4990be6a7b63ceaa2c53~aXZ0qRCRd0106301063eucas1p1G;
	Wed, 19 Jun 2024 09:25:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240619092537eusmtrp1cac2e927199573b3d9a841eb1488065d~aXZ0pt5qB1897818978eusmtrp17;
	Wed, 19 Jun 2024 09:25:37 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-ef-6672a411bdbc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 81.5C.08810.114A2766; Wed, 19
	Jun 2024 10:25:37 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240619092536eusmtip1d4363510ce4f54eb14c36cec66c6a062~aXZ0QoJu60386803868eusmtip1I;
	Wed, 19 Jun 2024 09:25:36 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 19 Jun 2024 10:25:36 +0100
Date: Wed, 19 Jun 2024 11:25:31 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
CC: Luis Chamberlain <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>, <martin.lau@linux.dev>
Subject: Re: Current state of the sysctl constification effort
Message-ID: <20240619092531.ighb6pxh2ls4qjpu@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd22004b-9bed-4537-b7d5-bc218ffc0087@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87qCS4rSDC7+ULU4051rcXnXHDaL
	NZ0rWS1uTHjKaHHo7XQ2B1aP2Q0XWTw2repk81jYMJXZY/aSGywenzfJBbBGcdmkpOZklqUW
	6dslcGVMejGTuWCSUMXbXp8Gxh18XYwcHBICJhKPlvt1MXJxCAmsYJRYtnktM4TzhVGi/ekX
	FgjnM6PE7a4nQA4nWMeTk5dZIRLLGSX+bpnDCFfVMfMqO4SzmVHi4s0f7CAtLAKqEjO6z4DZ
	bAI6Euff3GEGsUUEzCXuHJwNtpBZoJVR4t2TRWwgCWEBO4k9G5aDNfAKOEj0vNvIDGELSpyc
	CXEHs4CexI2pU9hAvmAWkJZY/o8DIiwv0bx1Nlg5p4CNxJvuc+wQZytKfF18D+qFWom1x86A
	HSoh8IJDYuvVHlaIhIvE7pszoIqEJV4d3wLVLCNxenIPC0TDZEaJ/f8+QHWvBoZZ41cmiCpr
	iZYrT6A6HCVWPFzOBgljPokbbwUhruOTmLRtOjNEmFeio01oAqPKLCSvzULy2iyE12YheW0B
	I8sqRvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwIRz+t/xTzsY5776qHeIkYmD8RCjBAez
	kgjv866iNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC6YklqdmpqQWpRTBZJg5OqQYm
	samHE1vX/9rR+/dIKUe7vvdC96kX/jFoXtucZvbn9dsWlg9rsru3Z4jnBoqynXj9+o1HvHIT
	f/5d/aaV1XNLNY+ILpXb1CH6tdlhRpb2ifSVRg9/x94qrW4N0zi/Zt0M6RmO2hYhdSsXBTJ0
	GBwuklsz64sl7yV2pmLLI6vPHlLomdKZZDy7oWsrj5P/Ah73Jg2tAymupx3FA9Qzgsr3fLjP
	vd6S47cOu665yIO+LSUCcbrZdyp4tzDI+pxMD/x3p/x2+e6IxQ7JRfsmCZqvmiAme/VznfyP
	dLm9G18e/OX/XXVlodr11Yci31Wx3ezbuC3wmbzf+5qfB3wKQs4zTzgRzbBk61HjyCu6f94o
	sRRnJBpqMRcVJwIArd+o5qcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7qCS4rSDE4t47c4051rcXnXHDaL
	NZ0rWS1uTHjKaHHo7XQ2B1aP2Q0XWTw2repk81jYMJXZY/aSGywenzfJBbBG6dkU5ZeWpCpk
	5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVMejGTuWCSUMXbXp8G
	xh18XYycHBICJhJPTl5mBbGFBJYySuxsKoCIy0hs/HKVFcIWlvhzrYuti5ELqOYjo8SZDW9Z
	IZzNjBI72s4yg1SxCKhKzOg+ww5iswnoSJx/cwcsLiJgLnHn4GxmkAZmgVZGiR/3D7OAJIQF
	7CT2bFgO1sAr4CDR824jM8TUh0wSXX17GSESghInZz4Ba2AW0JO4MXUK0B0cQLa0xPJ/HBBh
	eYnmrbPBlnEK2Ei86T7HDnG2osTXxfdYIOxaiVf3dzNOYBSZhWTqLCRTZyFMnYVk6gJGllWM
	IqmlxbnpucWGesWJucWleel6yfm5mxiB0bjt2M/NOxjnvfqod4iRiYPxEKMEB7OSCO/zrqI0
	Id6UxMqq1KL8+KLSnNTiQ4ymwDCayCwlmpwPTAd5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC
	6YklqdmpqQWpRTB9TBycUg1M+a/uPP7w6OlBp3155g+rPPObgi14NyR7Te/TvFDWdCX0zXVT
	bSfbLd9ibA7McmKSm759zplG1vZlYl4q1W5uhyzS5aSWreZuZQ1gvZwTGsjb9zLFosywc7bl
	a403q2at+Xh52RG9g1c+zPHVO6K/8aT0BJW5be8+2HNNz67cVfEx7Mi5M2Lit5+cm/r12yfn
	jCW/tvf2vGGJL+9Rub3SIOTLnfrOMw++lrYsbn/0/3LTvJ6rLUntE5T0T72YfeOkj0ycyqP7
	i2edqz59uGHuK42mafW2V/dzVIVMSSy/7PfW7Z1L25OVN1zXHRNP/vt7RcyR96++lkk3FJlc
	PSjjqy97f9ObFWdMP97f+kz3nqASS3FGoqEWc1FxIgCwxQD0TwMAAA==
X-CMS-MailID: 20240619092537eucas1p1564630b83ceb4990be6a7b63ceaa2c53
X-Msg-Generator: CA
X-RootMTR: 20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2
References: <CGME20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2@eucas1p1.samsung.com>
	<7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>
	<20240607094053.x3cmkhmrgaw6jqd3@joelS2.panther.com>
	<37d5fd30-9327-4b57-8e4d-22af929d3fc4@t-8ch.de>
	<20240610081036.bugf62o3y2wh2ugu@joelS2.panther.com>
	<dd22004b-9bed-4537-b7d5-bc218ffc0087@t-8ch.de>

On Sat, Jun 15, 2024 at 10:18:48PM +0200, Thomas Weißschuh wrote:
> On 2024-06-10 10:10:36+0000, Joel Granados wrote:
> > On Fri, Jun 07, 2024 at 03:54:01PM +0200, Thomas Weißschuh wrote:
> > > On 2024-06-07 11:40:53+0000, Joel Granados wrote:
> > > > On Fri, May 31, 2024 at 12:50:32PM +0200, Thomas Weißschuh wrote:
> > ...
> > > > Is there anything left to do besides
> > > > what is being discussed in this mail, to start changing the ctl_tables
> > > > to `static const`?
> > > 
> > > The changes to the tables also need (as per [0] and [1]):
> > > 
> > > * sysctl: move internal interfaces to const struct ctl_table
> > > * sysctl: allow registration of const struct ctl_table
> > > 
> > > I think we do the handlers for v6.11, the rest of [0] and [1] for v6.12
> > > and then we can go through the rest of the trees ctl_tables.
> > 
> > LGTM. Once you send "sysctl: move internal interfaces to const struct ctl_table" and
> > "sysctl: allow registration of const struct ctl_table", I'll put them
> > into sysctl-testing and have them there until they can go into sysctl-next
> > (after the end of the next merge window). Please send both of them in one
> > series and remember to work on the "what" and the "why" for the commit
> > messages and cover letter.
> 
> IMO all of the remaining commits can go in as one series, as they all
> belong to the sysctl core
This sounds good to me. If everything is related to sysctl core, then it
belongs in one series.

> (I can leave out "sysctl: constify standard sysctl tables")
This also sounds good. You can push this through when you are actually
changing all the static struct ctl_table occurances

> 
> FYI recent changes to the sysctl core introduced another prerequisite
> for "sysctl: move internal interfaces to const struct ctl_table", which
> is "bpf: Constify ctl_table argument of filter function".
> 
> See https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.git/ sysctl-constfy
I see it. This looks like something related to BPF [STORAGE & CGROUPS]
(cc: martin.lau@linux.dev). We can push it ("bpf: Constify ctl_table
argument of filter function") through sysctl-next, if Martin is OK with
it. Otherwise you need to send a separate patch to bpf@vger.kernel.org.

Best

-- 

Joel Granados

