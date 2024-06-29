Return-Path: <linux-kernel+bounces-234851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C5F91CB88
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 09:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EE4283A8D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 07:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1210E2D05D;
	Sat, 29 Jun 2024 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="STasOpS/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NvStODn4"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB87EC5
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719646513; cv=none; b=IslXeg/a2+4hNNhQhKvQhmnEqtflWgI07Od7AR80INyvzzmLm2w4OKG+9L2ZiV7G3vjdUIPmptzhhRLqToUsBDrwH9XOrJMGahYWV6k9uwwvvykl0vilAm3L80K3w3GjvHnCNrYNNkQSQrrI+ScQ1cVgZCC7pN3xzacd+2MlYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719646513; c=relaxed/simple;
	bh=txj+LmLX9jr5nqKpoL2zy5sCbQepLTIfsOBKkye+lWs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Ua23ReUZcgdE9djFqnm1NAcDod4jpymf+HwE4VDy2STDZLFZVTGGf3WSgNMXf88jtfiX1KVfM89aEtEw9zD5hNk2pNW2Sz2IdgDAjr/RUyZLfhxrUhH9mstXSwF3mVotQyToT1vhb9dI6vmGCV1hpoZ1mz4WMrR+WEpkE4tTmHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=STasOpS/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NvStODn4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6FF461140268;
	Sat, 29 Jun 2024 03:35:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 29 Jun 2024 03:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719646510; x=1719732910; bh=/eAJr3xw+7
	2LsYHdcWA8X2fuSZiecOT09RuA7xMMUQM=; b=STasOpS/6E043HeTNYIF4yCu/7
	i3uvyuFz280bduLHi/ntXje1isrAJbYVKpVKyHPHkNMX82crsN3NV7fGWouTtY1G
	5EWFWeITX7uiFmxLvYISQw0zjcS6ycFPbibGWQU9kzWssKTH/y5WafdZZTDeH1q8
	r4oe+f3lRsuXmlBUUzy18vUql1vh6CBAOh4tvY2zyqBzWLm8sFbyJ6d+Fpw+265K
	NfRxbGBw6ye2fXk3HmLgb5Y9jtMN5tdrP4W8et4u+Mbs6voAxsMErbUvIzjEG0sb
	X6wX64Go0PopIjlCg7excfYVpN9uyIkGqHjuNtfPK3wm2qqmXDwUurcJHEpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719646510; x=1719732910; bh=/eAJr3xw+72LsYHdcWA8X2fuSZie
	cOT09RuA7xMMUQM=; b=NvStODn4fl4djEPbZZEGSy2FqLsod56yDU0dV4YvLvpk
	gpPUzlWxv/CG8fg7iqBmSHHKBKADyX5oM96cKMqR/yCkVUb//ZCSAVVcVAu2Z4e9
	MQZtORB9/AMl8A/CLltCNu/NM+TDfr3ZKBMUQ/G7e4wI+15pyudFRKVoUJDv7oE4
	H5luZu7e7wMKc5/yAyoTP9DTGeU5mD3IHBC5ia5fFZZJKAma83oJJqyZ131ERS0M
	8qMhXfmcSNx86HKM3fpn2Aiz1DFCPbie38uySx6/d47UdcK/4AuRkDBxay+Vbbvz
	1RoRSSkstEOwPNP29lhnJcRGhh34/uJWEyXUE5sPNg==
X-ME-Sender: <xms:Lbl_Zo_j-X9slK6CC7ssHIMSphOeizP5f6Z5nstLj-K0OJpG2YtG6w>
    <xme:Lbl_Zgt6ohG5LhPYevNUMjxnSZrpEGoU9WjQ8zefq0zr87Tb9K-jAUaq-bP7SHUbC
    TNaUR0g5-SGi8GQVwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdekgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Lbl_ZuAwWH_DFJUO2GmR_tEUogcqr5lGjipbskVDQ-HLEUQVhvRTMg>
    <xmx:Lrl_Zod72QeZClYkLSgHVVMpU2OHlrwd8pjBmcDG-eduA7ID66J4IQ>
    <xmx:Lrl_ZtOmTOuzLvTEdpC6VZOP1uJ73nLw_UvfkGsNAWwAoxWRXkTOnQ>
    <xmx:Lrl_Zik271J1CXntBmroYw92FdoiTx0jDFKXrRO8Jc_V8056qwrq6A>
    <xmx:Lrl_Zgedmh6qx2LPZ5HvyY31Zj4i3_-TTa3ea8u0xnpRY8o8cSs4KdMR>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D14ACB6008D; Sat, 29 Jun 2024 03:35:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5d028f7f-a884-4983-ae8a-9b6b42e0ac4d@app.fastmail.com>
In-Reply-To: <Zn8uywbvZDDVSjT0@google.com>
References: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
 <ed9dd921-56a6-48cf-9f25-b8bb079c4249@app.fastmail.com>
 <Zn8uywbvZDDVSjT0@google.com>
Date: Sat, 29 Jun 2024 09:34:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Daniel Mack" <daniel@zonque.org>, "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Linus Walleij" <linus.walleij@linaro.org>, soc@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] ARM: pxa: use software nodes/properties for GPIOs
Content-Type: text/plain

On Fri, Jun 28, 2024, at 23:44, Dmitry Torokhov wrote:
> I would like to eventually switch everything to the software
> nodes/property entries. The GPIO lookup tables were introduced before we
> had software nodes and were really convenient way to describe GPIOs on
> non-ACPI non-DT boards. However now that we have software
> nodes/properties we can move away from both custom platform data and
> lookup tables in the board code and remove platform data support from
> the drivers, unifying the driver behavior.

Right, makes sense.

> I am not in any rush with this, so if some boards are on a cutting block
> I am happy to wait. I started poking at Spitz and the rest of mach-pxa
> because Linus W sent out a patch to ads7846 ;) and I also remembered
> that you already dropped bunch of PXA boards that were no longer
> relevant so I assumed spitz and gumstix still have some use.
>
> Could you tell me which ones are likely to stay vs ones that might go? I
> think arch/arm/mach-s3c/mach-crag* is staying? jornada720?

I think in the long run all of them will either get removed
or converted to DT, though it looks like the DT conversion has
not picked up for anything other than ep93xx.

For the timeline, I need to ask the same people again that
wanted the board files to stay two years ago. omap1 might be
a good one to prioritize for software nodes, as that likely
still has users and it would help getting closer to a DT
version.

     Arnd

