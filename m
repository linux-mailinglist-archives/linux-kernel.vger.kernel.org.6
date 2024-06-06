Return-Path: <linux-kernel+bounces-204365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC418FE7C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80251F22DE0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2B9195FEB;
	Thu,  6 Jun 2024 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UbIj6muS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FB8M25H/"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA9195FD7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680548; cv=none; b=NEc15EgkyKYctBAcw3lrNiyvB2JEstQYCMSv93H9lxbKqw2uEzoO4McHDXV/SxDo0MqIpcKovnT5J7x6Xs1PP90e4HPXDydNxxLOo68CVMfYn8wf9CkS8P8EMmVL7deP7Fq0CVbfJnslBpK8FHSMInhNCVYBRl2rRBn7IbBP/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680548; c=relaxed/simple;
	bh=6mFw9xg8rMa8PO3Sip3z29IbOqBV7T4dtI0N1CykVhs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=hQ+Iya06wKYIitq+7zytPpDuI4HQV8egTglq0L86rHMRnjtpI3FbEZV16rq1IUid6yY8YAPSBFCQhC/GiHfFP6N6bIkVgyIDJDsS3Yc/fhEStWlU+CNrFFUugYq8PDnRTCSldBrYXjSrqp4sF4lzAVDJ+BVYodG58FkhLeUR2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UbIj6muS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FB8M25H/; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id BB9C01C00158;
	Thu,  6 Jun 2024 09:29:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 06 Jun 2024 09:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717680545; x=1717766945; bh=6mFw9xg8rM
	a8PO3Sip3z29IbOqBV7T4dtI0N1CykVhs=; b=UbIj6muSiE3/OfHr5FZnb30ZtP
	7tjF5JESPYkfPQChJrLYodHo5tRVAWnFFyS0tmHOuBRIoeVJisuJFA8roSGGe5BL
	FMgrzmZu4j9I2Ey2nwuzFVWWJomhe+yrHyQvtTe4w2F3pkQKN15XRlyxF12e7iaY
	tBS5F1allUbspA22+DVI2ria3PonOrDt38axYA83ht+oEZRhIuxBj/2i0herJTgS
	FUNSYBhcQxeFsLlSXi9Q7hcTCL8g5OGbBHMRWKZhRxM0RJyita7NRaLvDqEt0SW0
	4YluxKajhwZ4oeii33h0NZhoFrU9IM8IS3GvPzknBb5YP1fuJIYMbNg4XHKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717680545; x=1717766945; bh=6mFw9xg8rMa8PO3Sip3z29IbOqBV
	7T4dtI0N1CykVhs=; b=FB8M25H/2Zvc1KXuAUQqjQXCSnvt2G2AmfJhP2Jc+Od+
	AkqDO508Q90dFkZD3wSu6auFVUe2N65mxWxBut8wkvmDTLpM/eAvV54vUyv/2qZ5
	64QTjU3vkoYFZUyhN3NksTeBqrO/N7HhGKlYXiBsWdRMS0AJeNvxVl1/aHgHpKpI
	Aq+Y2c/n0V2A5vRL6y2IUiX2ueweYLQQ01TJHgZp8n/zQG9WG1w8BErJd3awJIs0
	s3yAuSrWwHuNyTVUlOYkBQvA3ZwdiI3cmmqcstG9EcEFNNCKGyqkshKMV48STxCf
	M1wfD0U39aG955rl5Yh7cbM0MAUUsr3ZABbJMxYVKg==
X-ME-Sender: <xms:oblhZquJJZY271kBXIgrFe9sFHGFHDa2FRvyO0bcFw0JEa21vQ3oFw>
    <xme:oblhZvdbRSOnEo_RAGE6RW6-C3K530Zjl4Sk25nmXKk1daFLGHHMuvGWrt42o8EqF
    I7PZCuZM1Vdd2ZbnLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffgeffuddtvdehffefleethfejjeegvdelffejieegueetledvtedtudelgfdu
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:oblhZlxqPEaxQY3F791PQzxZGL1_qhCTtxA-KyE4YxBtsk4IamoqHw>
    <xmx:oblhZlNd-0hbvoKNco5tMkAmldNpx-AlLHGDnDgaUTFlzHzqGKKGPQ>
    <xmx:oblhZq8SpydgoW0hjsKjRCW6a9wdk0BWn4HHYchC6e6rsZOOWPbjAw>
    <xmx:oblhZtXKJnkXRI4TPBSoKPyxYKwieucgOEY_dOTXLOsC2qYiEWQ_NA>
    <xmx:oblhZhbWazdx29tdozq_a6jfemj3bJ8c-YTN-LGWYKdZ4QeljJfH2-WE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 022FEB6008D; Thu,  6 Jun 2024 09:29:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <74c2e8ee-d2fa-4312-86f5-46e5c6da4047@app.fastmail.com>
In-Reply-To: <20240606123908.738733-1-zhe.he@windriver.com>
References: <20240606123908.738733-1-zhe.he@windriver.com>
Date: Thu, 06 Jun 2024 15:28:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "He Zhe" <zhe.he@windriver.com>, "Clemens Ladisch" <clemens@ladisch.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hpet: Support 32-bit userspace
Content-Type: text/plain

On Thu, Jun 6, 2024, at 14:39, He Zhe wrote:
> hpet_compat_ioctl and read file operations failed to handle parameters from
> 32-bit userspace and thus samples/timers/hpet_example.c fails as below.
>
> root@intel-x86-64:~# ./hpet_example-32.out poll /dev/hpet 1 2
> -hpet: executing poll
> hpet_poll: HPET_IRQFREQ failed
>
> This patch fixes cmd and arg handling in hpet_compat_ioctl and adds compat
> handling for 32-bit userspace in hpet_read.
>
> hpet_example now shows that it works for both 64-bit and 32-bit.
>
> root@intel-x86-64:~# ./hpet_example-32.out poll /dev/hpet 1 2
> -hpet: executing poll
> hpet_poll: info.hi_flags 0x0
> hpet_poll: expired time = 0xf4298
> hpet_poll: revents = 0x1
> hpet_poll: data 0x1
> hpet_poll: expired time = 0xf4235
> hpet_poll: revents = 0x1
> hpet_poll: data 0x1
> root@intel-x86-64:~# ./hpet_example-64.out poll /dev/hpet 1 2
> -hpet: executing poll
> hpet_poll: info.hi_flags 0x0
> hpet_poll: expired time = 0xf42a1
> hpet_poll: revents = 0x1
> hpet_poll: data 0x1
> hpet_poll: expired time = 0xf4232
> hpet_poll: revents = 0x1
> hpet_poll: data 0x1
>
> Cc: stable@vger.kernel.org
> Signed-off-by: He Zhe <zhe.he@windriver.com>

Fixes: 54066a57c584 ("hpet: kill BKL, add compat_ioctl")
Reviewed-by: Arnd Bergmann <arnd@arndb.de>

