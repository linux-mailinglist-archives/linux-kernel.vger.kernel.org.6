Return-Path: <linux-kernel+bounces-321554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7F9971BFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC531F23813
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692A1BA276;
	Mon,  9 Sep 2024 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="al054RjZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZdEhuMa"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D03C3C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890327; cv=none; b=j49D66fQ0yp5zf3UG69P018s+xIFE4a/kj9z1BlF74ojKE0w+p30ejD2uC6pmNH+9gpFmZ3TkALjuNCqiaY2FHjjeMr3fHsbfBVthL6eqR6R64GbILKW55E+yb6d5r48Whtoastw1K8Sumvc8fZAHlCxMeO9fLBwXVJDFFL9KFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890327; c=relaxed/simple;
	bh=VxE50fNIuSst7DDd6wYwPsc4WfbCi+cVMqbF38cbHDo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SZpAVYCk+Z8Eq0I+w05QwYz/aKmTqJULBxGoV0f14ioNcwMkg+SNO+BKldBug754+iVdiyhPVxWa3eMZUE4lIsWKH71iuiRhHTZ/6amTKPkxcA1AXj2tjbpyUJfXg3Y1yrsVoRoWXXOVh/KtTVEiEC+kb9qosrZPRgIoFyHwbY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=al054RjZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZdEhuMa; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B36801140191;
	Mon,  9 Sep 2024 09:58:43 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-02.internal (MEProxy); Mon, 09 Sep 2024 09:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725890323;
	 x=1725976723; bh=eVRD64FOzRlp7ciLKEZlsqJYsnWp7ClsvlIqP1czsQo=; b=
	al054RjZPVf6vUDNPlVxHMbhv8EAmVD/teRbBLRAO7V7xVGT2leBGBlsUQZ2SjfU
	1yAhCYLeUyoZFDznQURVByJNeYmuwmqkobAIXxaDiqkhw1gAv5SPkQRdo7pIPOYY
	lZ/NDEKS8AgvS9vI6RFV+VGUx5z6nNXT78lbLT6qR+6x/FkGhx0zWNyPBtcdWDNE
	fuGix4nac0E1/VcStiEBvBldEq3fLIC8uWyHQ3swSAfFDBRf3NsVbv0lDGlDI9FT
	jznrgRZrBzlmSWjW74ezj4cVu+AUlwHuumGZyH24eC/003jC8aOcu+veC8hqHLUH
	akGsyoCGgw9w30sp9HGKmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725890323; x=
	1725976723; bh=eVRD64FOzRlp7ciLKEZlsqJYsnWp7ClsvlIqP1czsQo=; b=M
	ZdEhuMadO3YCtpm0XmLhQa+P7I8tjLdpuJl1ocPBAZYuJLrjV8ZghUO7rCNWCTO2
	/U6Qda2K2VF1TEVOzxPY2GFd5P6tSYY2FBjgiwIZGb0cV2bjlqzgeEesYROHYCmE
	NlK1wJAV2oj6lGdqQjHajvF6yOTSBelLpJOiwSCrxJ+D7S2ftb0W8lqr5jUCZEVg
	iwZxdI49iFZ8rnGkvGedDYzBsGETPJ+y+0CJGlunJieK/b96+pEE4+3ATfe2iUYY
	qVoCv7xdAdMtzckdCc5mWg48ITgnIMgDEFxy+MJBDK42iTn2ga4ZkMYIE6yGnDGu
	FEdmsxgg+EGqe86fwwtHg==
X-ME-Sender: <xms:E__eZl99U9UhRvgHS4oh-RvIM-ZljGuungU-6Fh1Y6Lq8KyG6RSfHQ>
    <xme:E__eZpvXuRTaz4ahNT7hiKGxIxqPiLzb_wo1eaLfhphrhTT5UPxvf8fj2J4CHQ0kh
    LaDLWhbfqSBAYNt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevohhlihhnucghrghlthgv
    rhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecuggftrfgrthhtvghrnh
    epteeflefhieetffdvhefgudevieejgfevueevleeuueeviefffffhvdffveefuedvnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvg
    hrshesvhgvrhgsuhhmrdhorhhgpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehhshhirghnghhkrghosehlihhnuhigrdgrlhhisggrsggrrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqvghrohhfsheslhhishhtshdrohiilhgrsghs
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:E__eZjBnGu9y-epUSyny4mRIjApb0AOX0_HvAwreDeqfpTGRFvOkJA>
    <xmx:E__eZpd7Fox736CpDEq0w1NeTs5IBc0HWmtiQSEOnx6bydsZzjh7aA>
    <xmx:E__eZqMNFPYo_ZQzrChMh0tlaRiHzUMQaU9jGhnTqvFFgg8CJadiKQ>
    <xmx:E__eZrnc9DdkV7uJoWKSObwOcRaX0ugiIeo3XtlzYQPZ1BqbCgvWvw>
    <xmx:E__eZjYMaB83mPL2L9COuG4zHKf8LEYeYpAAWXOQ3A2XywmSjt2WgMPE>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2673C29C006F; Mon,  9 Sep 2024 09:58:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Sep 2024 09:58:16 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
Message-Id: <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
In-Reply-To: <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Sep 9, 2024, at 9:21 AM, Gao Xiang wrote:
> 
> It can be bigger.
>
> Like ext4, EROFS supports PAGE_SIZE symlink via page_get_link()
> (non-fastsymlink cases), but mostly consider this as 4KiB though
> regardless of on-disk block sizes.

But symlink targets can't be bigger than PATH_MAX which has always been 4KiB right? (Does Linux support systems with sub-4KiB pages?)

I guess let me ask it a different way: Since we're removing a sanity check here I just want to be sure that the constraints are still handled.

Hmm, skimming through the vfs code from vfs_readlink() I'm not seeing anything constraining the userspace buffer length which seems surprising.

Ah interesting, XFS has 
#define XFS_SYMLINK_MAXLEN	1024
and always constrains even its kmalloc invocation to that.



