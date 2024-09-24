Return-Path: <linux-kernel+bounces-336802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70E898410C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B7AB23424
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB34F14F9D7;
	Tue, 24 Sep 2024 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="oZ5rsC3Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pzO6SAQL"
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA7914F9F7;
	Tue, 24 Sep 2024 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167728; cv=none; b=CNVqFx4fL5VNEoweAQ4t3P9iuK9le+VUkDMx7ONd4XdlyYkbVNJeVjW1HeZm+g3FkM84uK4Qr19pRcHyvEcGsCKC002HitOcRGPVtHMAUVPqVb4tNKevODuEtmKU12ARJgfp0GBrRkM5sfCWlg126OWNukXfuLhtN8QF2gcubeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167728; c=relaxed/simple;
	bh=zVJobRRTjJLonVyWmiQz99joek8BeSKrvLZMrfkzx8Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RpLB9k6uEv/Y56jENdV+b6ermHbl8MAOmKUxGXXD904yfthQBZ6xW92ExZTdkPme9IFmTSuT56EGfVg28MvprcTLVQuKum2KnOlwaxIxeBZsYGyhgHzPHbxyOM1qI10OpEVsL82likXQRGh2qoT/EpRrgzOenG2xtJo943SKXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=oZ5rsC3Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pzO6SAQL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C66521380483;
	Tue, 24 Sep 2024 04:48:43 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 24 Sep 2024 04:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727167723;
	 x=1727254123; bh=/9zXmS3wPiJTATpAzorp9hGCMi2EF9/SUS7XOxwY7GA=; b=
	oZ5rsC3YY+VyhDeedBb8A9CKeqOEzsqLvmL+bpxri0wBFEfKcOkUF950Yt0FaPHz
	wRKnsCd1i5yBrbFfpPGM5YpUktU5T6MvJmzkXuhwpIvIU9iCtWcuumz9Uvfb4cVL
	xFlZU0LFqvouZYao7twVDGHp2df+7DG2KUe8O4gAx5K/k8Cc8DlIksG3TPuiyGv1
	2pSpoVSX4vlrj6kaiwjkjrxC6DKasF8NuDuUOnKjRhE1oyXATQYOPU4bj19i1vid
	YTmi6dDQaIYWqoXwt6JT0Lvnj5Aujzwj3dcnJkisO2SpdQRmsAB1fQLCCjo/R0jQ
	QZbkBX6WIouf9jf+O75/rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727167723; x=
	1727254123; bh=/9zXmS3wPiJTATpAzorp9hGCMi2EF9/SUS7XOxwY7GA=; b=p
	zO6SAQLtbXcv0zhW36ZW6mzE/1f3S18B4z+RlXvQGl5O6h/gA7sNpCy1zEw9XTEt
	IvRHvBHevHv0+LZ2b28LtifxOiX+m/9G3SukLFDJcubUNtyCesqYpt/4bSsytBPR
	EguQGWjQlfodTgQ4xfgWBXRNdSAhmB2Mxy913CoeIalio5lBz5tyoC7osehx8Il7
	DrDs4wUqaTmezCfSicAJUrNaRqieqTq7pZxMA8R9Nd2hgeYIwgZtu6p4wuOh7RCM
	8YlzJkCYBO4jIeZR6P4CXj/MquObWv9A3JkQ2P8ywRVN4lCs2pleKgmkB1npFxbX
	VbfdkhPnDLcTa+Wvk2GAA==
X-ME-Sender: <xms:63zyZjlY9KqfNaIAoRPGzrDPaO40BzBU5tMd53DyKwJrAFTx_OqBTg>
    <xme:63zyZm3izlu-aydK9fVpDMDVRV5014fdmERHDNe0KiPhoNGWgSvQFvlxBDIg9BK28
    FN-gq0G-Co8f5sNFpI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtvddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehirhgvnhhitgdrrhgrjhhnvggvsh
    hhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhhiugdrvgdrsghogiesihhnthgv
    lhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhord
    horhhgpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgv
    lhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtoheplhgsuhhlfigrhhhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhhk
    rghsrdgsuhhlfigrhhhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehkvghrnhgvlh
    dqjhgrnhhithhorhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:63zyZpquYDAa9BkMv1RRRNWg7wenxsKzTkph2m1TyIB2Lt6i4FbXNQ>
    <xmx:63zyZrkf5DyidqkyR99_2o8iQIPcmlxY_p1UCNBRb1Rz6SA597oW6w>
    <xmx:63zyZh18ccqS7ijM0A9E0xPu-8gWPOLnn2BnGGYw1HoMhVGIdHmZiw>
    <xmx:63zyZquCdjnoZMqmHsbaiJPeCvURC6nJ7ExV9Amesag9sPVU3DxZaw>
    <xmx:63zyZrygFBtqZNuD5q-O8Uk4skkCzFMDS6s4xCBGhFMmpMv01UvmCCme>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0C7F82220071; Tue, 24 Sep 2024 04:48:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Sep 2024 08:48:22 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lukas Bulwahn" <lbulwahn@redhat.com>,
 "Rajneesh Bhardwaj" <irenic.rajneesh@gmail.com>,
 "David E Box" <david.e.box@intel.com>, "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Lukas Bulwahn" <lukas.bulwahn@redhat.com>
Message-Id: <9c97f947-a652-412d-825f-58f6b3304349@app.fastmail.com>
In-Reply-To: <20240924084056.48447-1-lukas.bulwahn@redhat.com>
References: <20240924084056.48447-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] platform/x86:intel/pmc: fix IS_ENABLED() check
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 24, 2024, at 08:40, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit d7a87891e2f5 ("platform/x86:intel/pmc: fix build regression with
> pmtimer turned off") accidentally slips in some CONFIG_CONFIG_X86_PM_TIMER
> (note the duplicated CONFIG prefix) in the IS_ENABLED() check.
>
> Fortunately, ./scripts/checkkconfigsymbols.py notices this accident. Fix up
> the IS_ENABLED() check with the intended config name.
>
> Fixes: d7a87891e2f5 ("platform/x86:intel/pmc: fix build regression with 
> pmtimer turned off")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---

Thanks for fixing my typo!

Acked-by; Arnd Bergmann <arnd@arndb.de>

