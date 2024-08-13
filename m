Return-Path: <linux-kernel+bounces-284719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050CD950468
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FCECB26146
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C224319CCEF;
	Tue, 13 Aug 2024 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="qiR5BfWl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qa8ccDiz"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F5819938D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550653; cv=none; b=BvYtcue8CYZn7LmdxnBqVVIZR45tQEhPnS2vRl7t6TCXTnwf7l0f6WZmGQdcR8PvM1fXZIGIUpwl9kv6C3pFcmjLzWzqaGueTCZGSI3TrmGNpwSEPEMPCa5vYImGeviEXrS6yq0Ppwd67Mz2WKayiKIrU6vt0hjhjMsjoRsUIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550653; c=relaxed/simple;
	bh=oCbHtLmVK21QMimzx6T0CBY4ecCrOSJCbOoSX7zyxDo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qRQZkjSa3dw++4uUA+mbHJeurEbH7y5bGG1HbP/A4E+JGMTkkuNK5pmOgYrB89YsnMkRdIKUdMFsFg1FTxTgGJ9+8BMOaDB5fp0jHM5WhzZct1wV/mqbZJ8Vd5ryAnqOSA0d4aaTgIHbxubNl5kEKYgQrtp7+TboQO6ZMO75tg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=qiR5BfWl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qa8ccDiz; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 03255138FC32;
	Tue, 13 Aug 2024 08:04:11 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 08:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723550650;
	 x=1723637050; bh=mKU9I03RMBqTzk0r4zWqliIAggMDeY3zOoI8JbjGOPs=; b=
	qiR5BfWlIg+wGWRugCS7eGmKw7lxB9j4cl98tFxDlTe2iBBKAOtfa8TrmU0/u1n7
	XK9cRfHKLBv1bwjko7KkjZUzx7RyT9pVCa+c+gDQN1RFJKOWbxRrzyizQ7UrUrk/
	ZjFQ/cywA5Pfexirtsd0/9qThZrTq6Is8IwAQ8IW2zL3Ah/222pmdcI9ud5U9Hl1
	BqX4fHVn2JQGm24A+UVHerOHxXrjcBVaxX1XdTAo/K4lwMz1BtqEuhGS0vvICxP/
	tXptK7t9MtoXAvv+HDFmGiqHNqQiSYPd4K+G6xx7GCjfOGSVP6lSEjp9KPAGfzdu
	Y/JT/bUzNDEDXUkDw2WkWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723550650; x=
	1723637050; bh=mKU9I03RMBqTzk0r4zWqliIAggMDeY3zOoI8JbjGOPs=; b=q
	a8ccDizzSfINB+7HkggK5uT/csVm8xxvnADpTPCkJWa0VQ3uMxK/2WMt4Hq6g9Nz
	5/7WESVw6C0gawYEcV0A+q+OnGWG1Ib3egh2ES7EQP1XokzmWz3UGezIPTW5YbVn
	ceKgderuZXFEBvtqdfIIv7EUM80O4jo0RH1VpO3moqR29yVZ/F0i8xkPanqtFhE8
	xmYU+dKyhVexfpgVfBJQ1w+KAee9LubkCqkCNYxRCDngEVfP5fAsSL44Ke2bqUH1
	nrsi4yFUljjrCUJbOEPkNEzoff+oyAI2NHZN8Tv9b/ka06LMtqkwaJXseEz3vGPd
	QxzYuWSEKSGpWkNGB+fxg==
X-ME-Sender: <xms:uku7ZiUGdf6A8cJ-3CAxAjbWZOiqpe8H4DNgyivbbiPpwIxnQqlWjw>
    <xme:uku7Zun3aoO_WCAxWqF1Y8ALm1fG_UKgPBrzaszvqomn8BQJpRUGVZRJPaUK_uuUu
    zck5YCbvpr1RJFtD_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
    hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
    thdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgrthhtihdrvhgrihhtthhinhgvnhesfhhirdhrohhhmhgvuhhrohhpvgdrtgho
    mhdprhgtphhtthhopehmrgiiiihivghsrggttghouhhnthesghhmrghilhdrtghomhdprh
    gtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghf
    rggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonh
    higidruggvpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:uku7ZmY8c58_q-jdI1JY0VX9xtOaCyHYo5OwrzPDN4QJJYDwOtZAlw>
    <xmx:uku7ZpXHP9NE_3BWvL75xVVYFUpiJ3tH6TVjhyxGeyX88QSSNVeh7Q>
    <xmx:uku7ZsmcF68lZViDEp7Xd-fyoDfAmci83CsCLQTvwXotkqOw1pI3fA>
    <xmx:uku7ZufzHByyoAfUpaOEU5rWkZileF1ulF6709XFWRhcNu5a7r991w>
    <xmx:uku7ZqY-9NnYujnjGED9dteDKA_QQ-cEA2SCcxqQHksaHZxzH6aOBaCw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 97E6519C0089; Tue, 13 Aug 2024 08:04:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Aug 2024 13:03:50 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Matti Vaittinen" <mazziesaccount@gmail.com>,
 "Matti Vaittinen" <matti.vaittinen@fi.rohmeurope.com>,
 "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Mark Brown" <broonie@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <f2474f2c-c1d8-4906-a777-be6ecc7b8016@app.fastmail.com>
In-Reply-To: <78fabd1a-0c68-4e23-8293-89c56eb9010b@gmail.com>
References: <cover.1723120028.git.mazziesaccount@gmail.com>
 <32d07bd79eb2b5416e24da9e9e8fe5955423dcf9.1723120028.git.mazziesaccount@gmail.com>
 <27033022-cdbe-40d9-8a97-cdc4d5c25dbe@flygoat.com>
 <78fabd1a-0c68-4e23-8293-89c56eb9010b@gmail.com>
Subject: Re: [PATCH v2 1/3] irqdomain: simplify simple and legacy domain creation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B48=E6=9C=8813=E6=97=A5=E5=85=AB=E6=9C=88 =E4=B8=8A=E5=
=8D=8811:54=EF=BC=8CMatti Vaittinen=E5=86=99=E9=81=93=EF=BC=9A
[...]
>> This might be caused by drivers/irqchip/irq-mips-cpu.c has=20
>> irq_domain_add_legacy() called with
>> first_irq set to 0.

>>=20
>
> Right. Thanks for the report! I do appreciate this testing!
>
> first_irq gets assigned to the info->virq_base making it 0.
>
> Later, in the __irq_domain_instantiate() we use the info->virq_base as=
 a=20
> condition for
> 	if (info->virq_base > 0)
>                  irq_domain_associate_many()
> which was previously unconditionally called in the irq_domain_add_lega=
cy().

Thanks for troubleshooting!

For those who want an easy reproducer on QEMU (9.0.2):

make ARCH=3Dmips CROSS_COMPILE=3Dmips64-linux- 64r6el_defconfig
make ARCH=3Dmips CROSS_COMPILE=3Dmips64-linux- -j8
qemu-system-mips64el -M boston -cpu I6500 -kernel ./vmlinux -append "con=
sole=3DttyS0,115200" -nographic

Thanks

>
>> Do you have any idea on how should we fix it?
> Maybe we could add a flag for domain association similar to the "bool=20
> cond_alloc_descs", but maybe Thomas has some better ideas...?
>
>
> Yours,
> 	-- Matti
> --=20
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~

--=20
- Jiaxun

