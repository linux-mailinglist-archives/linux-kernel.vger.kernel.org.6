Return-Path: <linux-kernel+bounces-321621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DA6971D02
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8282D1C23128
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815CB1BBBC8;
	Mon,  9 Sep 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="Xmu91i6+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PqVeMoTs"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF551BBBC5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893212; cv=none; b=RNVGrjepc+iKZo9QCbo9StNB/SbK4PxIImcyjO6+auK4BKBLNrKca3eQVc8LRok/l4pW98qgOIwBfbgsgK6WW1Q4545Mr6bEBbkppExufOhcoS+SxMjSuU44Husf5Fuzo+bGdEFfFW749UDiuEV2qBcvrwaVh7i5btOu7JsTe4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893212; c=relaxed/simple;
	bh=8xvWbBML4TyWscbLSzxavYubs79x3ko2o4WBRVxcvYk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iWoQFZOJsbV6sXRze3Tfe28gIGSv55IYm6FIJ/LeH5BRpPuuOk0AQa4UntDoZadhLmU6fEPrzhJJ9vmlZvpMPAllPOjNwUgduzk5/WmjUnztWQTp/faRwF3FrI7d4RK2v1Uji72LxIOQPNvAK0IfXByL++dAX26tEmiTmQL99qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=Xmu91i6+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PqVeMoTs; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D4E6D138024A;
	Mon,  9 Sep 2024 10:46:49 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-02.internal (MEProxy); Mon, 09 Sep 2024 10:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725893209;
	 x=1725979609; bh=i/QwEHWyOi+YdDf93y59YH6Ui41AbGHNMvvbwJyFu10=; b=
	Xmu91i6+GBq7R5vxYcsohi+FgyKyOWpzBD7ZOE5XniwWn67STOnlHGpOxqQcBBRY
	6yxDst9+CCnVwyaaaf7ZrN6Ly3b6gZFCOKvACdlpDqFsxEy3vdnDOipReT0N4lsP
	T6GdPQ+8ZmzZJN4bhH9SdcXgu2YrtxxPxTGy2RRXZl1sNr5m8IVy3F6C7u06lJXN
	12rNQAv/Km7OX6Ds5PDfknD/ZBGjlwpwsl0Hk1b4atiM39zPLKUBvOzvQ2kRTZg7
	Tz9l6tVT8rsLumZHB0nWb143veg2HDGfFvvYmkYXnAU9GtsN6OMepEkxa9bl7cmg
	TsqHOqgvjPyWTG1IRqxwCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725893209; x=
	1725979609; bh=i/QwEHWyOi+YdDf93y59YH6Ui41AbGHNMvvbwJyFu10=; b=P
	qVeMoTsMqow53PaDxz9CGuDMvPGgnnYcxqOelsyc8URFk96/zj0sG+fVp0Yb6MPx
	XrKMwaO0Ry6wHmzgKcZ1Y+jORN5c1jneR2+itvO1CPRkZuJCbeK5/j7/wu3Qs5eK
	9ALkCZ0g6aRnwiRk+Nn4VUWFWlY92y6OFDPiJQ/lXjvuTjtT+EFFaIzX0wMtT+17
	D5JYvoNMKRULUHzF0f8WX9J6lxnKN99d60U9nCpAhksWGyk+xg2Ts/NZi2ZYwI5W
	/pzLJZhFx3wuBnR5h4z6oHbh3MgGenfKQqP/Dkqv3+9P83865CCc7s7yrBknhTit
	7T+4BkE1CTcLFBhw4i21g==
X-ME-Sender: <xms:WQrfZsYT0LedlWhlgRns7ysMymwEXDOBQfafiFotwhKUC9BiERY9BA>
    <xme:WQrfZnZr2msRsHtFrEQf6h3qe_bgwYiZ2I1d6omg51VQbYMdNTZjDzf7_SGKACwWU
    JmiKYs1oRjV0iG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgieehucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:WQrfZm8dtISpRrJfTZ2vdhP6mqmPLpIUYVR7gvlTZtAxyr7fZqH2Kg>
    <xmx:WQrfZmquWfxwGccpMaqY-y-fP5RpC2jUmr7Wt6CxePfhcIdRkH1Z1Q>
    <xmx:WQrfZnpD3vZOzIzkppN0ViGf6jkT4rkbnDspOkJCXHBifFYG3Xww4A>
    <xmx:WQrfZkTzoE4bzTKLYmSvCBrbuMHE7ysMf8RK66yfhIU8dk_PJN5w_g>
    <xmx:WQrfZu2F_CEauXi6X998S_S5gFEtcT4KtIVM9YbY1ms2Ry_gf8lb7Fj6>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2742A29C006F; Mon,  9 Sep 2024 10:46:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Sep 2024 10:46:28 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
Message-Id: <91310d4c-98d5-4a8b-b3db-2043d4a3d533@app.fastmail.com>
In-Reply-To: <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
 <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
 <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Sep 9, 2024, at 10:14 AM, Gao Xiang wrote:
>
> Not quite sure about hard limitation in EROFS
> runtime, we could define
>
> #define EROFS_SYMLINK_MAXLEN	4096

Not sure that a new define is needed versus just reusing PATH_MAX, but that's obviously just a style thing that's much more your call than mine.

> But since symlink i_size > 4096 only due to crafted
> images (and not generated by mkfs) and not crash, so
> either way (to check or not check in kernel) is okay
> to me.

Yes, but my understanding was that EROFS (in contrast to other kernel read-write filesystems which are more complicated) was aiming to be robust against potentially malicious images.

Crafted/malicious images aside, there's also the IMO obvious angle here that we should avoid crashes or worse out-of-bound read/write if there happens to be *accidental* on-disk/memory corruption and having high bit(s) flip in a symlink inode size seems like an easy one to handle. Skimming the XFS code for example it looks like it's pretty robust in this area.

