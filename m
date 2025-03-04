Return-Path: <linux-kernel+bounces-544531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0044A4E207
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F27137A2E60
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1730B25FA13;
	Tue,  4 Mar 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bADCX+fW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qbCw/KiU"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3B327CCEF;
	Tue,  4 Mar 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100098; cv=none; b=n4huGt5Jm7q08A6Iivf/iRUYhNOWZB0VHDG0trzZbdbFhq+qkggMjXNUzCAGytpDDrrDg8Lhhkgy2AedBrTFdF7MmC5xdBZRQb6TthxNkQaFMoDmCXfKubCOVlrk8CECmFdbisztsBlKKpkeS4sAU9zSLhHAH1j9baxjq/JPcyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100098; c=relaxed/simple;
	bh=SOmsv57xosOfo9Yhjd9h2fMWjPgtkmaO1MKNSucdFJc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s1UocSFpBRRSt2OAHmDhicCj8GPQ6xBVKQmFAQ2vWPgwxOmw6KcW8Idy3zyhEWYuLMW4Lr5aXdzG1osIoVTdFra51GnQo/dRgK/W0sSKlTH59EZTDMi7Oi3ghQul1W28BFw66P4aLs079mUu42+Rh4JXr3WeUXW/Tr5P7sOrT8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bADCX+fW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qbCw/KiU; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F96011400E9;
	Tue,  4 Mar 2025 09:54:55 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Tue, 04 Mar 2025 09:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741100095;
	 x=1741186495; bh=NIjHXQqJ/X6NgY/8tEc8s1i/m83G8SEan7lIojIImsE=; b=
	bADCX+fWtumpWO0Q9G3irDmZ6yOvJtvyLnMHI2E4bxAmshvuK3sJ9piapcAO7L5q
	6tNpX2+URpe3xqKOOs9fppPDtk6rpapX2VWUxvO3J59rtqDgkxhpnMn3ClEpMJkG
	y0+YoMCprj0t7J9PKYu2O1ru9sTxE+GjnwTMj8Gxl6WdWAETnrOVWVdEsdoek7Ha
	rmZdrLxv2s7rSBZxQ1iM7wi/NgaCQRq/x9G2wO/t+h8Dwc25TMG2X+dx48u2bUyz
	n/J5FbClWBUTmuuQJg2CjEmqPAgs5Zf9xYl6kmYRDQv0zTjnbkIi+0FH5srbCcJk
	pzzbwtd16HOgkcG0IdaIPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741100095; x=
	1741186495; bh=NIjHXQqJ/X6NgY/8tEc8s1i/m83G8SEan7lIojIImsE=; b=q
	bCw/KiUsrJ6oZHJ/6yvVBUvYI1NDbpcEJ5p5LNvoRSXuWSHSQo55ydsfLapJr70J
	i13YJV/6ozT3oVroR8Ryc6DqNwu67pPERAZdvQHqAQNhodHkvnZgYXEBstQXAgSV
	eLZ4IoV4kC3+9+F5qAtlvzzmIPTvF9+2gt5o8/MzqWBqY6VuI3FRUUHTgM62fHP5
	qLSRYQ89mnIyKY+lr1KZ6Q0euq+kGJaVnw/KRFlbOAl9EnUEx8J67cj4JTUo/vWC
	oFzX7o53wPvQdl2URJ5bVErgXsWCZSahQugsfVQ5ZmlrRZJtVnWCs2Vu4sK3CYUX
	eG8BfYfSKQiwFrxOAyRbw==
X-ME-Sender: <xms:PRTHZ88fNJddVeftWP-vWDqejeanhCo5vvTjZbHaixmzNGARsEbTEg>
    <xme:PRTHZ0uhj1JArlYL9b9zcmE7Rq-ORv0ctzbgsR7hHo3bLniAJxp6j0ABq1u9k_-U0
    9p4HTPVKWSfH5QVZ64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhoshhhsehjohhshhhurghgrh
    hishhhrghmrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsihhmohhnthesohhpvghnshhouhhrtggvrdgtihhrrhhushdrtghomhdprh
    gtphhtthhopehpvghrvgigsehpvghrvgigrdgtiidprhgtphhtthhopehkrghilhgrnhhg
    sehrvggrlhhtvghkrdgtohhmpdhrtghpthhtohepthhifigrihesshhushgvrdgtohhmpd
    hrtghpthhtohepthhifigrihesshhushgvrdguvgdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hsohhunhgusehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PhTHZyBnleRBThoIgOa87cdaUXxtu3v2sleyySotxhbrgSWR3UeSBA>
    <xmx:PhTHZ8cUp6TjIPdMc9tiw0OyKSqbf54OKi2FYeNRM8hUoBuvThhN1Q>
    <xmx:PhTHZxNnhi0bjXktsopkm9S5SaUCXwLzZuTusnGpWyx359-HWmR6Pg>
    <xmx:PhTHZ2mRPyPSajQ-YlIcFTlU4eoWfp6sEgsIMGqWr536unoa5L9R9w>
    <xmx:PxTHZ6hX7CbmFByp2uPfFav6F-W5SsF7J77RYMQFmKeoNTzaTGY2IBIC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E15D32220072; Tue,  4 Mar 2025 09:54:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 04 Mar 2025 15:54:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Takashi Iwai" <tiwai@suse.de>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Kailang Yang" <kailang@realtek.com>,
 "Simon Trimmer" <simont@opensource.cirrus.com>,
 "Joshua Grisham" <josh@joshuagrisham.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <94b39ea3-bc29-49f0-bd34-eec45d61ff1b@app.fastmail.com>
In-Reply-To: <87tt88oo05.wl-tiwai@suse.de>
References: <20250304142620.582191-1-arnd@kernel.org>
 <87tt88oo05.wl-tiwai@suse.de>
Subject: Re: [PATCH] snd: hda: realtek: fix incorrect IS_REACHABLE() usage
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 4, 2025, at 15:43, Takashi Iwai wrote:
> On Tue, 04 Mar 2025 15:25:55 +0100,
>
> Thanks for the patch.  Indeed it's a very corner case, but I still
> hesitate to add a kconfig dependency.  Can we take an alternative fix
> to define the proper dummy functions like below instead?

I'm sure that works, and I had considered something like that,
but I really dislike the IS_REACHABLE() use because I think it
causes more problems than it solves. (I introduced the macro
originally but regret that).

Note that the only way to disable input is to have manually flip
CONFIG_EXPERT and CONFIG_TTY as well as the major GPU drivers
that select it:

config INPUT
        tristate "Generic input layer (needed for keyboard, mouse, ...)" if EXPERT
        default y

so in the end, there is very little difference between
your patch and mine, as they both fix build testing on
randconfig.

    Arnd

