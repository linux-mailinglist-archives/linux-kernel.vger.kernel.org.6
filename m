Return-Path: <linux-kernel+bounces-565077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D29CA66073
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE9016E006
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF882036E5;
	Mon, 17 Mar 2025 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UFmKUQ++";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cPOhIKkE"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C437201278;
	Mon, 17 Mar 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246757; cv=none; b=OlwJS7vpFC9B1rrB7x4GvznEQSGiPQG8DxUDHOy3KYdPHRnaycBTEbp+lY/yY1eKGiYdtDcQ5UH6b4fEY4PSD9uaRa9B+0dOxDPNaoE+TLk5AYU5sx2l/dIBa9rYblYdGhaTgraMOWUDvathec7v/SsrOgVPMzhDA/e7SH6gQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246757; c=relaxed/simple;
	bh=hidze6Lmm2kEBDShJAmbSCXjiyYDNNZa1xFsxR7Xits=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rgK+08MJ4HYBkzPXZGauV51OdyNHIqkXcukN0/3Rv1+xRf6Kn9AFAjyb/mYoGnCWqVuRa0deurOJlQWnH0QDjO9NQXJE4vRRIeAL1JzGvTxdWBQruMCb9HVk/SEMFY6HOxJtxN1aMCW9kGa/ik+bSLf8AW36HitHd2sc4HJxZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UFmKUQ++; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cPOhIKkE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 286141140274;
	Mon, 17 Mar 2025 17:25:55 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 17 Mar 2025 17:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742246755;
	 x=1742333155; bh=hidze6Lmm2kEBDShJAmbSCXjiyYDNNZa1xFsxR7Xits=; b=
	UFmKUQ++TBS2I3IIsIXwAXRy9Sq8XRu05gL8aG/W6NDl+zLH8k81CrCjZMAYFeLI
	OtY3QDcz/ZTPCzH9CDJOd3VZNoXH84fdUMFe1g1kB3TucdtleQPoCnnLufRb0acA
	HOuwwBG9UUmGdwolZG0oHngWDpmti/0PX7NhuRApPymwFVBmZ5JAI76dxCq14PsL
	P7PLnSCbHB7Sy6Pf/wOX7ZqE65HWoHf4msAx2ktEsGfiJxWT8WIXJljG+QNQIUbd
	zxvhqDKoaX0uqupvCb1HDyXJNLQrYpi/AmXMjKoK9zlS2bTjIr0GOWL4ChARx6TR
	VVo2EOvUJWtMAWJdXgR73w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742246755; x=
	1742333155; bh=hidze6Lmm2kEBDShJAmbSCXjiyYDNNZa1xFsxR7Xits=; b=c
	POhIKkEx1gqYmHDwULePhMJI3H5VrJHyp9Cp2eYDRvVmYN6S9NigCWb6VcH6LX2n
	TswyW9pcXqISrYYdQi5cfnj1wEZkuCLtaVVMV0D4RHBz0yco0rpn+KPE54dzID3l
	rO6Eq2lcAHDWvGRdCr1wuJVy+DK4Ufbh7z96AhwrLtA7Ham1knTXAniDwr/CWRam
	n0XWNY7gTaejt7dK6HebRdSmmcrB/7iW55D+z+3+KfkukU8kaXEJ3UFwqogKuHam
	kpcwKY2nMGMwEzlBase2kgzEpXn7QLmZLDfRdpjTVy+BteFhkUuCqwq2GEq4F5au
	NlD0XO4BsrdDBDI9UjB6w==
X-ME-Sender: <xms:YpPYZ_qqGQZQOPRTRzKVjOZp3bTqqQPXQgdQ5kduSmVfGYIiZwt7WA>
    <xme:YpPYZ5qE-FpB3Ple67LdTYaC3MQawx4M2GXnrGfO3E8v4JvLkmw2xab-f2tZAKX7B
    S_wh90MA7ruNjPAh0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehlkhhunhgurhgrkhesvhefrdhskhdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhushgssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YpPYZ8MpS8QW-Kukar9pKO723yLpHAm0rzRI9AMgySBLmK-tdlJ_iQ>
    <xmx:YpPYZy5mLfoa6ymnDOE9hYoon-cCCCZxzwn4d_cZYjHKEpZQBaUBbw>
    <xmx:YpPYZ-6ZzaE0LZtjT_nAfg2WXlDRELpdoe7N0T2lRTgT39FHguXznQ>
    <xmx:YpPYZ6j6JGm2xe2EbYkOUySj2UU0kWlu5mp-Aoxh07AG5EIdOm9U4Q>
    <xmx:Y5PYZ53d-0b6GdHUVkSaxQ7xzW8-QQFRtFFe2I1nRLW1ALfEevVuvsHw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 814CC2220072; Mon, 17 Mar 2025 17:25:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Mar 2025 22:25:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rob Herring" <robh@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Lubomir Rintel" <lkundrak@v3.sk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Message-Id: <a46ecbcd-4c1d-4a04-8c7f-6d7e97670ccd@app.fastmail.com>
In-Reply-To: <20250317200941.563287-1-robh@kernel.org>
References: <20250317200941.563287-1-robh@kernel.org>
Subject: Re: [PATCH] usb: Remove orphaned Marvell UDC drivers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 17, 2025, at 21:09, Rob Herring (Arm) wrote:
> These drivers have no way to probe as there are no match tables nor
> devices created with a matching name in the kernel tree.
>
> UDC was only ever supported by board files which were removed in 2022.
>
> For U3D, which was added in 2012, the PXA2128 aka MMP3 support was
> never upstreamed with board files and only revived in 2019 with DT
> support. No U3D DT support has been added since then.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Looks ok to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

I see two additional udc drivers without users:

drivers/usb/gadget/udc/fusb300_udc.c (could not find any users)
drivers/usb/gadget/udc/net2272.c (formerly used on blackfin)


