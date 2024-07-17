Return-Path: <linux-kernel+bounces-255181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C1A933D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8DD284A90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277C01802C9;
	Wed, 17 Jul 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LuwE7COF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p6TKtICW"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B691802AA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721220789; cv=none; b=XsrLENmdi4zodfynQUal8OzUOzo0RRBUdW+AvIVlAzxAWXERPhWeQrhVUodzuG5fTsu5Y3MC7FQ+O/DwmNY4K/Fy0IgGoFu17/vP1cvSoTeQKQrWuMX9nlaiGulSCy/4SrH5MkpVfcV+87lWSZmGyTUBf9BqAKQNWjFFO0550Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721220789; c=relaxed/simple;
	bh=E5UxEJQvzm5aGWqSVcQVuJvL+T6sGixJsBgas54whUc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=SlnyTMSBOg8Rc1RXAMLFicYCjaCJ5RUz8PEjUVH0REeoYfqyHgw632BzNgptaFrF4g4uNrBp7qmuWe6TqG4R7H6F33rHXPTmdA6NbAFBQslQQF1Cx3u6QDYxrutkvYd+lgEihgaiH9UanzEIA1KuBm7mFWyCrNDh6W4rlSg0+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LuwE7COF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p6TKtICW; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute9.internal (compute9.nyi.internal [10.202.2.228])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A9AAC1140136;
	Wed, 17 Jul 2024 08:53:06 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute9.internal (MEProxy); Wed, 17 Jul 2024 08:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1721220786;
	 x=1721307186; bh=71I4lqOEDwbKsYe1nUPlQ2wMAj2pJYMpu8D4uwG2BYk=; b=
	LuwE7COFDuW+bCsGQfIAnHNCAYcn2Wpofs2Go2ibCzgGdugqq55vv0SYQEBSp3pE
	XilSNn2SRqhXFLIPxYC1EXGYvPWxDWMBwCscQgJ+yojdH+QOEwBxgYUan3eGZfQ+
	Gd8KuIs50lzEBl+ZPrHkyej3CFMDWsDouliVameiGqpXqoHlkzVBWlgVvH26z9ho
	sG6n4cTXCw92y6o0Vj13GeisYApPOlTT333Ny6MkJ7tHDCxTaEYTUIgCNa0X6sUm
	2n1YZX5z1qiKRKV6vC1VEUQxR/Gpl5M1lDsrDkVbcqWVbZWaGhweDih7icsRTjEG
	btXOzR01FmWVCH2SdzIqow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721220786; x=
	1721307186; bh=71I4lqOEDwbKsYe1nUPlQ2wMAj2pJYMpu8D4uwG2BYk=; b=p
	6TKtICWlkQSnBZd7kX7LtLJLgQf+sqFXGhod4G1mK21rLclJoKJ8W0X6qc//jF66
	3tcYYExf2Ww/iZfVChbZgxT4QaVKukugGuWKXpoYr8+PIfpfKixA9Poetgpox3Bp
	DklNuxJevsKwfaEZYtHeld0hZk9lDYJ6JwPPdZ8w43O90zFm7JPhrgvaow3N1Cfo
	asEtbu61EwoS4bpFRPoeGYDXkGxwVpM+duavD3PWYGMUeGBcBV5fQh/8xbUCRjJR
	UpYskRV2hJI5lqrLjL3AJ6r/p4/cvL3fXNnzTOgCuhvyY3Se1DlfKjD+0RmJeVzn
	qG3d2doqRuO9ueti6rmKQ==
X-ME-Sender: <xms:qb6XZh0wQKGXwk7nNGlabY0V5lFf7gpsU1P9OsToABedD7f6P3T7qQ>
    <xme:qb6XZoGmQBzzcfy8xRCmEczrgs81obGhRKzoaMzrmRQuEnj1ddXKSc7H9louPEBhX
    RLpnpg2OOQw2agkxMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:qr6XZh4ja3HM27Tv__vTtlmg9Miw0hNtPjjftK9_a9PrjxnS_LJtfw>
    <xmx:qr6XZu1TtjSKurC-tMV95zZ-zjMvIq7HLe0zQ0psyyw2AhSjineNjQ>
    <xmx:qr6XZkFuyGGBfQYbtEK-_HR2XcHyZYzaPXvxTQMTOhzfDXYkyhatTg>
    <xmx:qr6XZv_zNziEJm8nOANCAx7jFE8A4f3A_WOxA6F0qm_nscJalk-j7Q>
    <xmx:sr6XZgiInNg3G_eF8k4tQi2g7M0JQJH4YwOscQjgXTkJTkwitvXBi1po>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C372C19C0062; Wed, 17 Jul 2024 08:52:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c88241df-96bd-4156-bd65-7c3194ec3f44@app.fastmail.com>
In-Reply-To: 
 <SJ0PR18MB52463B1A7393F36673548989A6A32@SJ0PR18MB5246.namprd18.prod.outlook.com>
References: <20240717045225.138799-1-vattunuru@marvell.com>
 <2024071709-nephew-scooter-5c6b@gregkh>
 <MW4PR18MB5244DBBC231E986EDBEDD5BEA6A32@MW4PR18MB5244.namprd18.prod.outlook.com>
 <22bf9a24-b4db-4017-b5a9-1b03e6f20bff@app.fastmail.com>
 <SJ0PR18MB524672A30BAE8A7163FABECCA6A32@SJ0PR18MB5246.namprd18.prod.outlook.com>
 <024d85a1-6a4e-4552-a5dd-adebfb195be8@app.fastmail.com>
 <SJ0PR18MB52463B1A7393F36673548989A6A32@SJ0PR18MB5246.namprd18.prod.outlook.com>
Date: Wed, 17 Jul 2024 14:52:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vamsi Attunuru" <vattunuru@marvell.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Jeff Johnson" <quic_jjohnson@quicinc.com>
Subject: Re: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation issues on
 32-bit ARM
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024, at 14:17, Vamsi Krishna Attunuru wrote:
>>
>>On Wed, Jul 17, 2024, at 13:=E2=80=8A45, Vamsi Krishna Attunuru wrote:=
 > > Neither of
>>them worked in our case, HW folks also confirmed that only > 64bit acc=
ess
>>work correctly. > I will just include the header that address the comp=
ilation
>>
>>On Wed, Jul 17, 2024, at 13:45, Vamsi Krishna Attunuru wrote:
>>>
>>> Neither of them worked in our case, HW folks also confirmed that only
>>> 64bit access work correctly.
>>> I will just include the header that address the compilation errors
>>> with ARCH=3Darm, anyways nobody will use this driver on 32-bit kerne=
l.
>>
>>Please just use a Kconfig dependency then. If the device requires 64-b=
it
>>register access, then the driver should not use the fallback.
>
> Ack, since it needs to skip compilation on 32-bit platforms, can you p=
lease
> confirm below change is suffice or not.
>
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -588,7 +588,7 @@ config NSM
>  config MARVELL_CN10K_DPI
>         tristate "Octeon CN10K DPI driver"
>         depends on PCI
> -       depends on ARCH_THUNDER || COMPILE_TEST
> +       depends on (ARCH_THUNDER || COMPILE_TEST) && 64BIT
>         help
>

Yes, this is correct, thanks!

I would probably put the 64BIT dependency in a separate
line, or next to the PCI one, but the result is the same,
so pick whichever makes most sense to you.

     Arnd

