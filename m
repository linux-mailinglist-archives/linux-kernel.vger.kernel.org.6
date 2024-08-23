Return-Path: <linux-kernel+bounces-299186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8025E95D14C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E491C219ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844BF188A1E;
	Fri, 23 Aug 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jRE1v6Zq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sKSG43sb"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7CC18891D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426646; cv=none; b=GweC7HdNUnZawtwy7+DQMwih0Yr42HXO2ZiDDKGES1yxvgQ3lMdBRSxJNOPbFU5XZ+TBl0hOz/6wCGCp1SEH1A3TYDXcBUoaKYXJarYLHY7f/1C4lUYW8nEWZGFDBq9b2BfrMXLGVY5SsB1tyBGQwVXD/R6zUB0DvsBv7Eh/dTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426646; c=relaxed/simple;
	bh=dXXaT+XrLzWzSMAiHu2CPA6F0g3w3AL16WhsN2tFcTU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gjgGAkoaiQ3q/OuielGczgfw4GqMU/NXIMSAryEH7jFRxkcQImVP6Uxy6poiWOwPNMC8n0TSaI0CFEY0VT75jlAYsIdPnqBdNyo0nrvYC3chFWRXtHC/8eRS8GPWJ2u/WyNyCD7ABuDY9prxelz5GNTQ04MiDIR9rOZR5h8fCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jRE1v6Zq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sKSG43sb; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6D000138FF2B;
	Fri, 23 Aug 2024 11:24:03 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Fri, 23 Aug 2024 11:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724426643;
	 x=1724513043; bh=7DkSDfC4nKtBQlrSWTZo8b6YkpGWZDzUq9d5F4Eo5Y8=; b=
	jRE1v6Zq2US909ELF6jnrMrnVJK+p31B/UAlLV6BIpSV6yftsbt69khFVTsq5/8q
	7qP4DRE1Fx1t3LYbfKZwcRfCKdoFRnZUKZdZ3GrrCFteQqAfPS+108gU8KQSiq/f
	gHpBavBmeCy1sP/WbWZyPBMFFWB57rY8YpAy+P81zGgWAFTaC+w70PvCJleRFEYM
	j+8t1j9Ux2QT98urcjHaWB3qTwVL27mCxgCknTGf6mCX1QC8EExpOFOXPkhJfiTQ
	MWMRH3rWFj6KJS3XENDed8aylC2sfx3iRR9Z1naBWdu3lX/+qWrNZctjpbyfydtT
	/b/BIf5BQofNbhXFc4CrlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724426643; x=
	1724513043; bh=7DkSDfC4nKtBQlrSWTZo8b6YkpGWZDzUq9d5F4Eo5Y8=; b=s
	KSG43sb/qodEuIQIrOrxZ49SD6glxxnMaoyFWj80aebXIAkpgORyfnLLHzYZ0Uwv
	3QySglveaR14U3HvwyEo7DvA4+jO5NGYss/Z+vHMAJsi0CTYIE9H5UkSWvJn6ost
	tkS7v+m+s7IMd4UmO93X7yNapHdG9VQMEQb8+w3GIJ03Uey/NViyD06m5ad1lIo+
	dcXOUZ5n87baHL7UaDgiOYuP9DK/huQ/xGleCNvfvLXkEVh694JSIUlWx8bIrXfx
	P6Fo7tLhNYEVoCsiIu1QoxJiUW4WEw0XkzfLmQO8BjBSq2pxlfPBOGLb1jtBBz5a
	O4FIkqWwcIKODXtsfuXqw==
X-ME-Sender: <xms:k6nIZsNJhIHB-yDrgQbAYFxN0j47iv8-CX490YfySnB9YUOZfM7qhw>
    <xme:k6nIZi-2UmFjG7XOh0MkvFSyNM0J72rYK8AFO1NpZjlU5GW_mIBWYpZ1DbE3Rss-a
    UKkIkrSH9Vk9IpcOgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegstghmqdhkvghrnhgvlhdqfhgvvg
    gusggrtghkqdhlihhsthessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepfhhlohhr
    ihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopeifrg
    hhrhgvnhhsthesghhmgidrnhgvthdprhgtphhtthhopehkihgvrhgrnhdrsghinhhghhgr
    mhesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtoheplhgruhhrvghnthdrph
    hinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehumhgr
    nhhgrdhjrghinhesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepuggrnh
    drtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepghhrvghgkhhh
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrg
    hrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:k6nIZjQkmmwA7bufIwMsCGGsoo_ehDcfeV8DxvFYdHHOdsPuvlkEzA>
    <xmx:k6nIZkuO-3aoPWDIZLr8M5hnlZoYVSoU6dQPMDz2QHRBEtP-cwE2Kg>
    <xmx:k6nIZke8Wh6IRPmejjYMXOzCV61tkuzbApf4tB77UfU_oOOwBwBOmA>
    <xmx:k6nIZo2QJBZcg0vLoYk4_D1cpTcMcbyDdEXhoagBwkvLNOZvDsUi5A>
    <xmx:k6nIZj98LaEDW8uSrVNVkh6vqb_lGoehWitlyQjRsl22bFtOxLWviYYl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2A16E2220071; Fri, 23 Aug 2024 11:24:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Aug 2024 15:23:42 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Umang Jain" <umang.jain@ideasonboard.com>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Broadcom internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Dan Carpenter" <dan.carpenter@linaro.org>,
 "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
 "Kieran Bingham" <kieran.bingham@ideasonboard.com>,
 "Stefan Wahren" <wahrenst@gmx.net>,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>,
 "Phil Elwell" <phil@raspberrypi.com>
Message-Id: <8174beea-9260-4248-abb5-4104a886b905@app.fastmail.com>
In-Reply-To: <20240823-to_sent2-v1-1-8bc182a0adaf@ideasonboard.com>
References: <20240823-to_sent2-v1-0-8bc182a0adaf@ideasonboard.com>
 <20240823-to_sent2-v1-1-8bc182a0adaf@ideasonboard.com>
Subject: Re: [PATCH 1/7] staging: vchiq: Factor out bulk transfer for
 VCHIQ_BULK_MODE_WAITING
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 23, 2024, at 15:14, Umang Jain wrote:
> The bulk transfer is VCHIQ_BULK_MODE_WAITING is used by VCHIQ ioctl
> interface. It is factored out to a separate function from
> vchiq_bulk_transfer() to bulk_xfer_waiting_interruptible().
>
> This is a part of vchiq_bulk_transfer refactoring. Each bulk mode
> will have their dedicated functions to execute bulk transfers.
> Each mode will be handled separately in subsequent patches.
>
> bulk_xfer_waiting_interruptible() is suffixed with "_interruptible"
> to denote that it can be interrupted when a signal is received.
> -EAGAIN maybe returned in those cases, similar to what
> vchiq_bulk_transfer() does.
>
> Adjust the vchiq_irq_queue_bulk_tx_rx() in the vchiq-dev.c to call
> bulk_xfer_waiting_interruptible() for waiting mode. A temporary
> goto label has been introduced to jump the call execution over
> vchiq_bulk_transfer() for waiting mode only. When all dedicated bulk
> transfer calls are introduced, this label shall be dropped.
>
> No function changes intended in this patch.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>

This looks reasonable, just one think I would change:

> +int
> +bulk_xfer_waiting_interruptible(struct vchiq_instance *instance, 
> unsigned int handle,
> +				void *userdata)
> +{
> +	struct vchiq_service *service = find_service_by_handle(instance, 
> handle);
> +	struct bulk_waiter *bulk_waiter = NULL;

> +
> +	bulk_waiter = userdata;

Since you always pass a 'struct bulk_waiter' here, please
replace the 'void *userdata' with the typed argument directly.

       Arnd

