Return-Path: <linux-kernel+bounces-272282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D694599E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6512F1C2299A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69361C3793;
	Fri,  2 Aug 2024 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="U/lC3tfm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UAiC7APk"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879671C378C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586093; cv=none; b=TwfVMY1toM5nfzWTKSrL46USCz7NEZTWeTin/IBB4UB924lr3PMJmz3aWZlUWYBkv7p3cSmzIH0dy8vuYAWxdisU05QZFFdZ4whtX5sUQGnCtptdg4AkcKNDDw4RPAgM6gfKJA0LvbRP1Bnd839TXP8lbcSVKDiOxQhKsj9pZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586093; c=relaxed/simple;
	bh=mkR/LYxkfo/tgTSdp/fyWadhTiJcw4VsteJOABAQJNE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=I5spxgWfu78pOynt0/DF7U3A6V5XNhv4KTaYK6ezaBxu7LNcgODkY1sbKOeyCwzQxUKN4tQaZ7qIuDHvGKaW4dqxB/frcVcL51So7bhoo2vuZU8lSkiBpcDwSoRmEgJP1UaWBZmc3geQovWugWLH1dfju8689+NQl1titwnAlB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=U/lC3tfm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UAiC7APk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id A1779138FD0A;
	Fri,  2 Aug 2024 04:08:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Fri, 02 Aug 2024 04:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722586090;
	 x=1722672490; bh=y4/TUpMDZe5UrbGtuYUpqr1clGh2RECOdwYSwWIcrUM=; b=
	U/lC3tfmtx6TajgJwrhVR5UgT753LKTOi42skYCZ8xAPjkQTykz8zr7iXqRmPfWt
	7E7Jkq6ibrsV4Hbg/Q+fXyLzlA1vB87MLRB37snpxHzHrjLLZPkZ9gIskKh3XXOS
	6D5MVTJXXvOPj2hvkG2YDVuSdCkB3Y30VQE9w05Nnxb7h/BQPdxKYT1b76NfWjnb
	bSYFZwcWG9iHUQtoaStmgF8ZzmwdLt2nB5U4JFqkXhZR45hWcmgvTitt2Ejdl3Ua
	3XD6O5ZCXtfrX49TlwEDag68GbnsCRZ1VkdC54JEMt8PhT4yThT44yNJOfDyUEDK
	ydvrYCiXvh5IhQ1XJlVpcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722586090; x=
	1722672490; bh=y4/TUpMDZe5UrbGtuYUpqr1clGh2RECOdwYSwWIcrUM=; b=U
	AiC7APk1qgYLkuG3rj8tI5k9QvgbIL0MoVsVRH4AjmeKf3Tx+RvA4xZDBNfICEJO
	5dUiiOWZQ+TmgCUN505vgW6QIBVE0vSTAwmByZH2goQ9Mzs7WRnfPVlw3YHGJXKb
	K6q+75M71ZZeK/VgKcpXbNP3M9FwxHVZPefhuOGoQ7bgWzdyIrcihlcxZGO6NxQa
	zixAfLT4rkSKNEe/2H4u/G08iETV5QIX4aeP0WVqhU7amK2Cm0PKzaW0DxOzHbvR
	1Ydbv/R/iycWT6dANwDWhnzDILZCFtECct2EiHDeXHzaE1ErkblV1LS1yN6JEsZz
	5BsMIPT7G3BSCyPlSLfkw==
X-ME-Sender: <xms:6pOsZrCbSsuBk4YK3SNzIG8B4bGuqdMCzbJsp45HbA__Kjzgn2jeGw>
    <xme:6pOsZhiG2gSwmcvDClKI1OIRoMeTxclM4KIhUMKKEixqfUsOACdQnSVoiSG5rQsQN
    jpj8I0ru-lYHUD6S44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefh
    vdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:6pOsZmkABcu61aJ5mPD83EYMLd2mo9CgikLQiUdaDe1JQ0Gn4t81MQ>
    <xmx:6pOsZtzuLqP2R0I2LYrbj4xKBZT87RScNjFe6kiJdzi2G_KZvag93Q>
    <xmx:6pOsZgQgqdxhoUJYny-e1v2o0VxEqXN_RVi6KJGu4qDrP9vj1O45oQ>
    <xmx:6pOsZgbWXGPxKxOyXYMxcLiF-p-3TroNiFInFfsRSgS_rldNY1eRtg>
    <xmx:6pOsZlTG0aW4WDgmnOBL3LWyT1eu86mwf0AzzQZCcoYEASkF-EMuLqzi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 429A9B6008D; Fri,  2 Aug 2024 04:08:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Aug 2024 10:07:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Frank Li" <Frank.li@nxp.com>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Kent Overstreet" <kent.overstreet@linux.dev>,
 "open list" <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Message-Id: <fea17390-f3de-470b-b252-e80f3ea2135f@app.fastmail.com>
In-Reply-To: <ZqumhgZ5heh0OYuA@lizhi-Precision-Tower-5810>
References: <20240731233145.2485874-1-Frank.Li@nxp.com>
 <969fb014-682e-4984-ad1b-7ab4f068ed85@app.fastmail.com>
 <ZqumhgZ5heh0OYuA@lizhi-Precision-Tower-5810>
Subject: Re: [PATCH 1/1] linux/io.h: Add cleanup defination for iounmap() and
 memunmap()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 1, 2024, at 17:15, Frank Li wrote:
> On Thu, Aug 01, 2024 at 09:27:40AM +0200, Arnd Bergmann wrote:
>> On Thu, Aug 1, 2024, at 01:31, Frank Li wrote:
>> > diff --git a/include/linux/io.h b/include/linux/io.h
>> > index 59ec5eea696c4..7695d7973c8ff 100644
>> > --- a/include/linux/io.h
>> > +++ b/include/linux/io.h
>> > @@ -163,6 +163,9 @@ enum {
>> >  void *memremap(resource_size_t offset, size_t size, unsigned long flags);
>> >  void memunmap(void *addr);
>> >
>> > +DEFINE_FREE(iounmap, void __iomem *, if (!IS_ERR_OR_NULL(_T)) iounmap(_T))
>> > +DEFINE_FREE(memunmap, void *, if (!IS_ERR_OR_NULL(_T)) memunmap(_T))
>>
>> I don't like the use of IS_ERR_OR_NULL(), which tends
>> to indicate a problem in the interface design.
>
> Just !(_T) ? I just refer kfree()'s implementation.

Right, I think !(_T) is what we want here. I did see that kfree
has the same construct you are adding here, but did not read
up on how it got there.

>> In which cases do you expect to need scope based cleanup
>> on an error pointer here? The only interfaces I see that
>> returns an __iomem error pointer are the devm_* ones, but
>> those have their own cleanup method.
>
>
> devm_* can help much especial in probe() function. but scope base cleanup
> also useful.

Yes, that's fine. My only point here is that you can't combine
the cleanup function you added with devm_ioremap(), as that needs
to be paired with either implicit cleanup or with devm_iounmap() but
not plain iounmap().

    Arnd

