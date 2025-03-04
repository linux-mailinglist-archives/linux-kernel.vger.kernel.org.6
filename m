Return-Path: <linux-kernel+bounces-543092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A24A4D15B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 03:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55D81888D44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EB7126C03;
	Tue,  4 Mar 2025 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q+auKt3+"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CFB11CAF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053771; cv=none; b=Apyi1NWzjEcv3SC+Yc5Af1x1jY/9Mf6fiCVf6BjQPvNruj1Uz20ZD67pmTVf33Hnbv4YJfnOLm9KWVti8eH3JOh//bcLWdQIfd43qjihB6X+sy4YHJroiPOrTeb/tk1KDpYh+Es0J+Qk3A4NYqUePbNOkGu2gtNUc68RVO4Je9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053771; c=relaxed/simple;
	bh=xL8GUEn/vwdpXXPsERGaf8Y7keADiyEIFN5H1xU3VdY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=oSOuBYTLQ6P1phMmfSI47XoW9iRw5oVPbHHJNTeDRKwl6Sp1f8/0k4Qkdcin3H1SOaVYco/jBn9L8Cj9fuBN2EK7r8szQfS063G+Kp/F/NhRJGqVRo/LujtmOGUEIYA1liuGLqnbqckuXRC0AYwRH6uvDQtS/inSkXoB4yht+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=q+auKt3+; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250304020245epoutp01628a70b83b7915caf30c97911c1047b6~pdyzsd9vD2466824668epoutp01X
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 02:02:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250304020245epoutp01628a70b83b7915caf30c97911c1047b6~pdyzsd9vD2466824668epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741053765;
	bh=Qrd7/S1JC7LosFpai/AEnDWuwoNJz4mlVxqYVZIqCEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+auKt3+OhAL0xXUOouFvnv21cjJfOBaAzT3C7BNNvQm57H3UugG3ig4RMR+TfM1/
	 mDZRH90ybHmdqRdpo6XCdNw/lRv5BHnTajJwtAGuqMqPVi2eJOToJuLaP1CgiBNPyA
	 qk2IAqFNQ1p/FSlticJtdSas9SrOmKVk9fmYEccQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20250304020245epcas2p12b2f2bb23def186b1901e2c1c4b5f7b2~pdyzSfsPu1033610336epcas2p16;
	Tue,  4 Mar 2025 02:02:45 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Z6Jq84vLYz4x9Q1; Tue,  4 Mar
	2025 02:02:44 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	EE.38.22094.44F56C76; Tue,  4 Mar 2025 11:02:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250304020243epcas2p3940bb7425df452c76383540f7baf8c84~pdyyBkd561730517305epcas2p3R;
	Tue,  4 Mar 2025 02:02:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250304020243epsmtrp2ce63000ec5cee944b26786b6f6771f22~pdyyA5t2_0514905149epsmtrp2X;
	Tue,  4 Mar 2025 02:02:43 +0000 (GMT)
X-AuditID: b6c32a46-484397000000564e-08-67c65f446152
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.03.18729.34F56C76; Tue,  4 Mar 2025 11:02:43 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250304020243epsmtip2f7f9c8ca0a2611215a6743a9850c16ae~pdyx0zDzX0786307863epsmtip2j;
	Tue,  4 Mar 2025 02:02:43 +0000 (GMT)
Date: Tue, 4 Mar 2025 11:01:12 +0900
From: Donghyeok Choe <d7271.choe@samsung.com>
To: John Ogness <john.ogness@linutronix.de>, pmladek@suse.com
Cc: linux-kernel@vger.kernel.org, takakura@valinux.co.jp,
	youngmin.nam@samsung.com, hajun.sung@samsung.com, seungh.jung@samsung.com,
	jh1012.choi@samsung.com
Subject: Re: printk: selective deactivation of feature ignoring non panic
 cpu's messages
Message-ID: <20250304020112.GA4025668@tiffany>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8434fytakt.fsf@jogness.linutronix.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmha5L/LF0gwP/FC2a9l9itng0fS2r
	xbYr8xktLu+aw2bx//FXVoujt56yW0za18hksfjAJ3YHDo93586xe/RtWcXosX7LVRaPT9Om
	sXt83iQXwBqVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
	lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQ
	wMDIFKgwITvjyPdvzAUz2SuOL/nB1sDYwtbFyMkhIWAisaZrB3sXIxeHkMAORom+M52sEM4n
	Rom5y/sYIZxvjBILX/WywrS0PZ4HldjLKHFp132o/qeMEocnb2MGqWIRUJE4+W43I4jNJqAr
	MalzG9hCEQFbiX2/7zCBNDALLGCUmPNqBxNIQlggSuLe1y9AKzg4eAX0JNo2uICEeQUEJU7O
	fMICYnMKGEt8b9nGAtIrIfCXXeLCkr8sECe5SKz98A3qPGGJV8e3sEPYUhKf3+1lg2hoZpSY
	dOM1E4Qzg1HiyuTPTBBVxhKznrWDncoskCkxvbuLGeQKCQFliSO3WCDCfBIdh/+yQ4R5JTra
	hCA6VSTO9z1ghNm1Ye5bqIkeEvNf7WOChMoXRol9retYJjDKzULy0Cwk2yBsHYkFuz+xzQJa
	wSwgLbH8HweEqSmxfpf+AkbWVYxiqQXFuempxUYFRvA4Ts7P3cQITp1abjsYp7z9oHeIkYmD
	8RCjBAezkgjvrfaj6UK8KYmVValF+fFFpTmpxYcYTYGxM5FZSjQ5H5i880riDU0sDUzMzAzN
	jUwNzJXEeat3tKQLCaQnlqRmp6YWpBbB9DFxcEo1MB1kenY/OsYliNHk+f4rci8Xv22U3Hbj
	a2558oc97iuOL0zNNeg6VVbczzGxbIfpqz7+6F8BvyWvznY9nGt03S00hntenRnrOXuLQpWK
	56tSYj8z9afweWz4cV9q7u2/G8MMs5bK3uq0ksoM+f3s3JM1sWEVs07oqK5e6zjXPVLn0MQ3
	5VVeB5lCS7z3LN+msJJ5UnEB00bjSHOzeV6HTZ5d61lXZevoLrGXS79ybtfK3BsH56nH7p0w
	q2V1+tmlVUsX2u0X8Px7SkF8U0n8GavXs9b/rn7YHsOk/2iP2tfnmT4Tu3ff8HET/fe9p0x/
	TWZFi4HymrXGE75/P3uHff+Sd1qvzabxfzr7mWnTWm4lluKMREMt5qLiRADO6aZUJgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSvK5z/LF0g13TzCya9l9itng0fS2r
	xbYr8xktLu+aw2bx//FXVoujt56yW0za18hksfjAJ3YHDo93586xe/RtWcXosX7LVRaPT9Om
	sXt83iQXwBrFZZOSmpNZllqkb5fAlbF+2hmmgmssFS2vFrM1MN5i7mLk5JAQMJFoezyPsYuR
	i0NIYDejxMc1C6ASUhLtW2YyQdjCEvdbjrBCFD1mlNjf2cwKkmARUJE4+W43I4jNJqArMalz
	GxuILSJgK7Hv9x0mkAZmgQWMEiu7V4IVCQtESdz7+gWomYODV0BPom2DC8TQH4wS5ybeZwep
	4RUQlDg58wkLiM0soCVx499LJpB6ZgFpieX/OEDCnALGEt9btrFMYBSYhaRjFpKOWQgdCxiZ
	VzFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBIe9luYOxu2rPugdYmTiYDzEKMHBrCTC
	e6v9aLoQb0piZVVqUX58UWlOavEhRmkOFiVxXvEXvSlCAumJJanZqakFqUUwWSYOTqkGpq3z
	rZZoXMtl0d61bf3nfenbbeK/Oe1LUPlw+Pei6V8VP9fwnlqQu/zen9snv1fvk4gPSV3wwLJb
	Rf/6vH4Wtu1Lph3+Ur738CbrrTvXWe0vmSP86SZff+SSP/obpCTmH2Rk31LNrvwqIe1PwaOE
	8ymv0pRcLhTtC9rsbb/hyVOlxVV9bHF/ynfsvt9UfGHxfX2e0Cch5SsrO2/m3dEoiHl1+uf2
	ZRt3Ry1sYPt/o9Lfjnf3Dl5VXaNvaYKdO32Y42WKr6qxLVDKd9thlHSwdPeOo02yfYZ1AfZd
	Pn+LGoPf64fNuZs7vWL1370LblRqZevHqrJdcVU9zOIpGyxUWilezpmSrWSbnxMnxhs+Q4ml
	OCPRUIu5qDgRAGObaHrqAgAA
X-CMS-MailID: 20250304020243epcas2p3940bb7425df452c76383540f7baf8c84
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----7MjMDun-wBTKD0aJGk8MrTq1WBha5gge0B_F3lDBYtizvuhb=_17f4bb_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0
References: <CGME20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0@epcas2p3.samsung.com>
	<20250226031628.GB592457@tiffany> <84ikoxxrfy.fsf@jogness.linutronix.de>
	<Z78eGNIuG_-CVOGl@pathway.suse.cz> <8434fytakt.fsf@jogness.linutronix.de>

------7MjMDun-wBTKD0aJGk8MrTq1WBha5gge0B_F3lDBYtizvuhb=_17f4bb_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Feb 28, 2025 at 03:26:34PM +0106, John Ogness wrote:
> Perhaps Donghyeok might be happy enough if the debug option simply
> allowed the non-panic CPUs to store records. There are plenty of tools
> available to get at the dmesg buffer.
 
That's right. Just the addition of debug options can make me very happy.
If I find any problems using debug option on, I'll share them with you
immediately.

First, Shall we reflect only the patch that adds our debug option?
I will also study the problems raised. I want to be able to
participate in your discussion someday.


Thank you.

------7MjMDun-wBTKD0aJGk8MrTq1WBha5gge0B_F3lDBYtizvuhb=_17f4bb_
Content-Type: text/plain; charset="utf-8"


------7MjMDun-wBTKD0aJGk8MrTq1WBha5gge0B_F3lDBYtizvuhb=_17f4bb_--

