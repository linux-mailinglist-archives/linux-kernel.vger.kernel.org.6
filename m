Return-Path: <linux-kernel+bounces-575449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71646A70296
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8C83BCDBD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EDD255E2E;
	Tue, 25 Mar 2025 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Au2ANczD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="acoEiW6Y"
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212A1494CC;
	Tue, 25 Mar 2025 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909882; cv=none; b=kZ4ruWsgeCeKeS/3rhcOIt6PmIf44eWKDbOS7ViWVOaqBDAP0tXKy2UHEa78z5MITTL/hT6Cu1V7nW/JM6u4nYqSU/uWF2zMIU20KASyqP2jR7PSsE71WB6tjYJPOfgW4cbE/zf/TJXmzNLWPXoLByJNmUFoDYmYGdBzUsQtwdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909882; c=relaxed/simple;
	bh=Oq8mL1lN6G868BzCGd5HVNTfkTOGPBrWvu9alSwJKgw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kUCl0qBBtT3P75x5Cbuw4+2EA/dKwiDcg49bEwS47LmMp21FLGGq+4xjrY/BL+vko/0tB5SZDBcCa28cPfDyobpPiTc/cf/nLZrylAY0zu+Gehp824LWYSxFyePRe4Qcd5V1F4Nk7TrCd7RktUaPRoVvEXPIM2xHnaGhGK+hyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Au2ANczD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=acoEiW6Y; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E29011401C7;
	Tue, 25 Mar 2025 09:37:59 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Tue, 25 Mar 2025 09:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742909878;
	 x=1742996278; bh=YVVVPHTJJIvcEN2whYB7APWkmV047iaLL0bj63L8CHk=; b=
	Au2ANczDbIHtAdxayC+o550QqpDia0xGS+TRWIMXtD4fmNT1ZNWLO4cBEk9tpz+L
	BbZWtmRX7ivx1CITgcOeG86WKmInaKgmkvDDqq5sHKHRf+Uuy5zi12iBtshKZ9Y2
	g/VFuhvO1i0XEq9kfRQekjZAgQMNy0VYrb8Yk+Y7gm7lhwBrK6kjAomR/uRBNh18
	Ro/GLeOyOQPuQdbgmRjxpkN56g7wb9OwOX91+bVueYfcK1u8K0+f4rZK6L1vLm05
	y1PObKEAGDJFH5Z4lMPafSjBw96pdErn0q539WrUcrfvsJy0kn3/JYzBeNv38tAI
	1k8mpNV4dMwkxo4R+c6J1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742909878; x=
	1742996278; bh=YVVVPHTJJIvcEN2whYB7APWkmV047iaLL0bj63L8CHk=; b=a
	coEiW6YB9psb32zPnTViK0GEPfKgAqNhfvgD24lIIRfVZuYYK021YXsbNnhFYpuV
	OBnpwYXR7NxCr2OhW+Kq4iFznusAWaq4ChovCvX7iraWpFL+o3oJrcDjMhgHJEH2
	OlBkUqzWqK7Ajb6PXj0CStnkZC+LetFaLH74fWWiwKrZA4+19kCxqq7Lhm4rE1Ea
	wga+yyvda6tq89ht5jwPlcrh8aFgtSbeDn65glPOlDWmm4d4F0adNA7FI10a9+zr
	9AJMkd1fcjWrq1ETTa59gYvta24ZrEV5pdoh+zmsiX0BfqnJXdM4aNmiQx/IsA4A
	NpJ1P7oWgf01gNjVEBFXw==
X-ME-Sender: <xms:trHiZ53vsdgbD7FLpdiJuCvCQIJTSFLB7b2QjIApqrrfacyS_-ga9Q>
    <xme:trHiZwEwvHN0r5kcHVqlxDm1Uj2f2bu_8HSbfv_FiiyJ2_pyPOSBFUSra-cKwyfLj
    3J6fnAGsRNv6SjpEO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnheptdevjeefjefhudeileehjeeuudeiudevfedv
    jeffteekudehueeiteelkefhheetnecuffhomhgrihhnpegrmhgurdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrkhhshhgrhidrghhuphhtrgesrghmugdrtghomhdprhgtphhtthhopegrnhgr
    nhgurdhumhgrrhhjihesrghmugdrtghomhdprhgtphhtthhopehgrghuthhhrghmrdhshh
    gvnhhohiesrghmugdrtghomhdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghl
    lhhosegrmhgurdgtohhmpdhrtghpthhtohepnhgrvhgvvghnkhhrihhshhhnrgdrtghhrg
    htrhgrughhihesrghmugdrtghomhdprhgtphhtthhopehshhihrghmqdhsuhhnuggrrhdr
    shdqkhesrghmugdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunh
    gurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigsehrohgvtghkqdhushdrnhgv
    thdprhgtphhtthhopehlihhnuhigqdhhfihmohhnsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:trHiZ56ujXDaHCcHmHO0Iiyd6A-jvRSwFJsQQT4GcVVawIaN2q5tGQ>
    <xmx:trHiZ225wHlHj8I_meBXHxRONikU_-MkNveWrp3t9H-nel0hE1Q2nQ>
    <xmx:trHiZ8GlZrAp27JaXS0rF_MR18Khd4sU2xdchTCwWZOWOoV7ycxR0w>
    <xmx:trHiZ3-VcgFKbbOeb7v26y5TNio-jnbhtjCYoAtjUy3VTbLCfODcVQ>
    <xmx:trHiZ3AP222OAndQkimzhj62jH4YiTFQsYYPvpWN8Ep80MPZAldjj79Y>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8C6EF2220072; Tue, 25 Mar 2025 09:37:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9168aded715bd4fc
Date: Tue, 25 Mar 2025 14:37:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Akshay Gupta" <Akshay.Gupta@amd.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Guenter Roeck" <linux@roeck-us.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, shyam-sundar.s-k@amd.com,
 gautham.shenoy@amd.com, "Mario Limonciello" <mario.limonciello@amd.com>,
 naveenkrishna.chatradhi@amd.com, anand.umarji@amd.com
Message-Id: <eedd6e17-b6e0-4e02-8c12-ba835b0dba15@app.fastmail.com>
In-Reply-To: <b26e9abc-10bb-46a0-be05-d0cd2ce835bd@amd.com>
References: <20250324145815.1026314-1-akshay.gupta@amd.com>
 <20250324145815.1026314-7-akshay.gupta@amd.com>
 <c9138dd3-6a09-47a2-a8fe-716c8894042e@app.fastmail.com>
 <b26e9abc-10bb-46a0-be05-d0cd2ce835bd@amd.com>
Subject: Re: [PATCH v6 06/11] misc: amd-sbi: Add support for AMD_SBI IOCTL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 25, 2025, at 13:35, Gupta, Akshay wrote:
> On 3/24/2025 9:10 PM, Arnd Bergmann wrote:
>
> Link for the documentation: 
> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57883.zip 
> <https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57883.zip>
> You may refer to section: 5.4.2.2 SB-RMI Mailbox Service
> At present, more than 70 mailbox commands ids are supported.
> The number is increasing with each platforms.
> however, the input and output for all mailbox commands are maintained 
> as 32 bit, hence, we can use the same structure and differentiate the 
> functionality.

The large number of mailbox commands is exactly what I'm worried
about. Having 70 well-documented ioctl command numbers is not a problem,
since the numbers are cheap, but having an unfiltered pass-through
inteface between userspace and a PMIC is scary, and it's worse if
future hardware version has additional registers here.

A lot of the values reported through this interface could simply
be sysfs files, some look like they should integrate into existing
kernel subsystems (scheduler, pci, ...) and not be directly
visible to userspace.

      Arnd

