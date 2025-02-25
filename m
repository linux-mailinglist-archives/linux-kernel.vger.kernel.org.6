Return-Path: <linux-kernel+bounces-532279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F15A44B01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CDA07A8BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00507199396;
	Tue, 25 Feb 2025 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UxWtQcz4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5jPo6MYP"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A1199E88
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740510181; cv=none; b=JMlrsoARBvgQuZDcu2TnP3LdDe8r4ONcbCz93O+lIKoPcDorE4HGsqIy/Y2+j1JqIn4iMRZKIrVmCShglYpSxre/DcQoixEEf/QIpGvgBVZuZM2qnP2r6bV5z0VZbDVxs+Wu/AYJTkjHM8IZ1RSyLN/GtaeWD0hQbj8DuUIyQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740510181; c=relaxed/simple;
	bh=syJ8sngRVDrJzNrZ2wDVjBiystI4anafE1fdpw4BpUs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GJ8SgUPop12bmN7Qs7bThD4PASG77UeWQ9Kh3iEzpCYHQ31+Ijvf1YVBigxwNmRfWgFXUcntX4a1wEaejYv1jM4txgd2LxMgb3srObcZ63dx3H6RNz+r316dqFTvdUkrajYOpf/So8UjGEyMzzqR+sJITPbSM7SYAO5TxPFPwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UxWtQcz4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5jPo6MYP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2EBFE11400A0;
	Tue, 25 Feb 2025 14:02:58 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 14:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740510178;
	 x=1740596578; bh=U1bc+78MhuovQPF1YquZvclztVsMOLeGmGgjTCdQjTY=; b=
	UxWtQcz4C/APAdmoVfy4gN4lHbQMkI2jy4w2i/7nvqPTIsHQQ75My1Wop/H3kDkV
	gqQSLawdu34WT4nW6FMi9J419wgq0/BuwNW2W0zQGJO8tCvQt8BobmOsN/Ddolx2
	dqzdQIj26yatR2ELcA7shFo8TA++p7WjOMTj0REtNA751kOiJr4pBHy2v0bSyuFD
	mjmQQquD0uRlMoHoPDISl+OZwiESgexvSdhIyQpVrEKzk5XqrbrhRTp9lB5zakiY
	3At2T5v+5WgCGg8luTS4GoqNhgcbNvSbxt9XpOtnYNKdxvXFURabrkUzDTQ5rsOh
	/x1hR2wIJ0CVWFQTJZRo2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740510178; x=
	1740596578; bh=U1bc+78MhuovQPF1YquZvclztVsMOLeGmGgjTCdQjTY=; b=5
	jPo6MYPsyPj7JrI6zx5UrrA3GjenXSoATNqK/xCOdQSy9xJ7pS2xseKeAcyIa0fN
	mlcM9h5qSqxSf2JTipHSGzC/wylkWXfxtV+pw67YC8rnDCMh6ry9XLA1yuB1jRRp
	rlNWaDAMYH59qZR1W8XBeNCNpkPKshfkzT4/62KMdkcaOfV/Y//EuqYSQYiJGcLF
	q2pZEn8D4vkxtX9nCH32X8w7HN/2jJ4+BKgbk7PfgVdCS9jwYGBqxCvFPPJzIuBe
	ptnt/BLRJ6t8KcnnRgLzAR2XPbJ2VRu9PsqYllKtlHQRk+nWuoP65oSB98jae8nl
	aIE0iKzExrOfPjOCFhyMA==
X-ME-Sender: <xms:4RO-ZyB30eogjq3zekWoyYQpPbyf1xoU6x33rbaaGoacMm9J2GSoqQ>
    <xme:4RO-Z8iUrAXwC-kI2jOhPMLhJamzQDwFwFHApiClFp4_Gv77yYwyRFZnk75L2EBDL
    u_RW7THx53IcgyPH1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeetkeffvedttddvtdegjeekledtuefgheevteef
    ieeuvdegkeeggfehffehtedtleenucffohhmrghinhepuggvsghirghnrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheplhgrfhhorhhgvgesghhnuhhmohhnkhhsrdhorhhgpdhrtghpthhtohepghhr
    vghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvh
    hiugesrhhofigvthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigsehtrhgvsghlihhg
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:4RO-Z1lh5wfw8vMAUaau_xNt1Yt6xQULkkj56jCVJOKZrBdR1hV6CQ>
    <xmx:4RO-ZwzV6W89jTDjJdxo1HFHO2_k38Jy0fZlLUKC5Ko30pm6DsyusA>
    <xmx:4RO-Z3RCTMf-hj1VBlXKKtRZuO5eVQrG_Ys-HIESeURkqTVB0v2thw>
    <xmx:4RO-Z7YfA7uWS_kyydLr9fd1fbveWLIOqIBtOGOJmnO8tb1tGqlwCw>
    <xmx:4hO-Z1Nh3B1HsUCBweCMK4WD-ullLm2z0_KJw3d2bPxlD6F5D3-u2HxY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5D3682220072; Tue, 25 Feb 2025 14:02:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Feb 2025 20:02:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: linux <linux@treblig.org>, "Harald Welte" <laforge@gnumonks.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, david@rowetel.com
Message-Id: <71af20fc-ed19-4bda-af61-f6061fd1422b@app.fastmail.com>
In-Reply-To: <Z74OSsZqeboJml9c@gallifrey>
References: <Z7tZhYET41DAoHVf@gallifrey>
 <07afd3cb-3ab1-4dc9-b0c1-3fef2d52f60b@app.fastmail.com>
 <Z724l3DFJbGevtPF@nataraja> <Z72_EnXyHoDACRk5@gallifrey>
 <Z73MevharqkC5dt8@nataraja> <Z74OSsZqeboJml9c@gallifrey>
Subject: Re: users of drivers/misc/echo ?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 25, 2025, at 19:39, Dr. David Alan Gilbert wrote:
> * Harald Welte (laforge@gnumonks.org) wrote:

>
> It looks like Debian is including and enabling it in it's DKMS build:
>
> # apt install dahdi-dkms
> ...
> dahdi_echocan_oslec.ko:
> Running module version sanity check.
>  - Original module
>    - No original module exists within this kernel
>  - Installation
>    - Installing to /lib/modules/6.1.0-31-amd64/updates/dkms/
> ...
> # nm /lib/modules/6.1.0-31-amd64/updates/dkms/dahdi_echocan_oslec.ko
> ...
>                  U oslec_create
>                  U oslec_free
>                  U oslec_update
> ...

I took a look at the debian sources in
https://salsa.debian.org/pkg-voip-team/dahdi-linux/

Apparently the 'dahdi-linux' package contains a copy of
the oslec module, which it puts in a local drivers/staging/echo
directory.

It has done so since at least 2015 when the package moved
from subversion to git.

      Arnd

