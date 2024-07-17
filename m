Return-Path: <linux-kernel+bounces-254613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4931933577
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71E61C22651
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C839524F;
	Wed, 17 Jul 2024 02:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="sxJEp+w4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sCYIK8VT"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C14E320B;
	Wed, 17 Jul 2024 02:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721183691; cv=none; b=MOtvgOJZZlFtMuyKnxX6REoGS+wzThDUN5dHYh1WqZv5xx8DaADo/KgZt8tVQ3jUYeoz305d/cHv0aPHTBGa8BbdXBffQrS2xuuLR9QDjX7azp9iC9h5Orb4zQa5jzMA994ZHadLazjaMgv4ou017J3291hhUdne8QOJlSzEHxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721183691; c=relaxed/simple;
	bh=s508GMUD55YkvfpV5rDzEB48jcAuAy4o4TDmH8hmkcY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=F4YKohzAiCplyPh93hV0GocX2x+xYwaLo91P8pn+jYxr3s+Mg+6FDuKc1dDD2AHWTxyxxuUnv/mA0W4YVj1FoJftEiJ97bxvubWmEGh3915nv/Fuf2s9CUuQdVICqZ5dXY/zQJJ8g0+QDotfHdjdPr9KMtPZktnfZQwe/GgDMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=sxJEp+w4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sCYIK8VT; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 12A88114806D;
	Tue, 16 Jul 2024 22:34:48 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Tue, 16 Jul 2024 22:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1721183688;
	 x=1721270088; bh=5e+PEx4nBMHw+X2jMix1TzvpU4CTfhbsw0jM9VxrD2c=; b=
	sxJEp+w4IGZI1CdSL/9wjvpgxx2qXnR1HKHtx5kF5nIUsqZmgaGtdAwxR8RbMEyi
	PcKhSp7xL7aCNwt6wjSlHZf5AqM30bMZUP++hx40rI4r55K78AXFY6yN7vlL9+XI
	uLhZcF1ARimcxrLfrdmAMryxTcKJWH6dFWebQKd8/r356JZmAGsjVoH0DnsrJKNd
	vsVcVDgmn85dDl+s195LSyQYY/g3mtQSItDmTE7GqHo3pHPvxsdnMf/O+cQj0L5C
	QZaGsDIqnxGi1xzFKxqzY8KdsBQxqXx6hDaKT436wD4nLG/TONXQa2GqCpKUDClB
	NvPotzm3DVeH9lvuk8E/tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721183688; x=
	1721270088; bh=5e+PEx4nBMHw+X2jMix1TzvpU4CTfhbsw0jM9VxrD2c=; b=s
	CYIK8VTYhybhRS8NLxe3eYGMrcCr3OKolBb6eS7GIMilupVUy6dm8TAMrtAnembk
	2GpOKkRe4uUEDy8wm0zoW9VElC7W58Gy8IJZyc52j1ueU9WySJNearX8XPP2GJY7
	xek174minbcPMGmfIROl6+MGksARk5YxCqvKhKajlXj+JKHs7BazHot7KxBn29IQ
	WIBKCVR+ynU2CUHj6CT6ZNo/nuXEVZirRRbM/kJiOmua9ClEJcYc9WFf/8mxQ/dr
	5cUA6uR1ft992txkk7y62LWaYwUxCV+U5b/4l3s/BsMvBuW2qtzt3BZmDvcIz9Fj
	EbO+dwLUKZn5auxnb6bKQ==
X-ME-Sender: <xms:xi2XZsTp7_8azGBzu6bc40iHSRbSamsVLq5BH50PAgHRZnTHpC58fQ>
    <xme:xi2XZpy80kVzVCOR7TnSm0bYEKDY8uYpVLil-C3h_idp-8yRJJjDcfXVmF3NHxXJf
    rLQtaTeMvhDDmmo5_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeehgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpeeukeeitdeftefhuedugeeitdevffetfeeuieevjeeigeekhefggefhfffgkeet
    veenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:xi2XZp3OXi8fDdYw59EM2-TOhjkmfAD9TiREipXZ6T4ufbBTbRUYFg>
    <xmx:xi2XZgBznjzSzwLm3xG_lBV48n0Y-3IorwRK7C2VX_EQc44MXNrELw>
    <xmx:xi2XZli7DGsu_XstJvV3Ch6zcXRwegBfvEkki2Zcq7BzgJCozCdIPQ>
    <xmx:xi2XZspww4r6HuhxBAb3duoHfI7fKlulku0cKQeG4x_ufzxoRmnHvw>
    <xmx:yC2XZleLX3sNf3hrnopipsJ5y-jGY33JyixzcdIL77NQvryeIk_4ZHS7>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CC4AEC60098; Tue, 16 Jul 2024 22:34:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e309d39-43d3-4054-88a9-0c1da3de26eb@app.fastmail.com>
In-Reply-To: <e9f4fb37-5277-a7f0-2bec-8a6909b4e674@linux.intel.com>
References: <20240716051612.64842-1-luke@ljones.dev>
 <8273ed57-4c65-41da-ad7d-907acf168c07@redhat.com>
 <e9f4fb37-5277-a7f0-2bec-8a6909b4e674@linux.intel.com>
Date: Wed, 17 Jul 2024 14:34:26 +1200
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Hans de Goede" <hdegoede@redhat.com>
Cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com,
 "Mario Limonciello" <mario.limonciello@amd.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] platform/x86: introduce asus-bioscfg
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jul 2024, at 3:11 AM, Ilpo J=C3=A4rvinen wrote:
> On Tue, 16 Jul 2024, Hans de Goede wrote:
> > On 7/16/24 7:16 AM, Luke D. Jones wrote:
> > > This is the first major patch I've ever done with the intention of
> > > introducing a new module, so it's highly likely I've made some mis=
takes
> > > or misunderstood something.
> > >=20
> > > TL;DR:
> > > 1. introduce new module to contain bios attributes, using fw_attri=
butes_class
> > > 2. deprecate all possible attributes from asus-wmi that were added=
 ad-hoc
> > > 3. remove those in the next LTS cycle
> > >=20
> > > The idea for this originates from a conversation with Mario Limonc=
iello
> > > https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802=
f-4ec27a945c99@amd.com/
> > >=20
> > > It is without a doubt much cleaner to use, easier to discover, and=
 the
> > > API is well defined as opposed to the random clutter of attributes=
 I had
> > > been placing in the platform sysfs.
> >=20
> > This is a bit of a novel use of the fw_attributes_class and I'm not
> > entirely sure of what to think of this.
> >=20
> > The fw_attributes_class API was designed for (mostly enterprise)
> > x86 machines where it is possible to change all BIOS settings direct=
ly
> > from the OS without entering the BIOS.
> >=20
> > Here some ACPI or WMI function is present to actually enumerate all
> > the BIOS options (which can be set this way) and get there type.
> >=20
> > IOW there is not a static list of options inside the driver, nor
> > is there special handling in the driver other then handling differen=
ces
> > per type.
> >=20
> > And if a new BIOS version has new options or a different machine mod=
el
> > has different options then these are discovered automatically.
> >=20
> > This new use is quite different from this. Although I do see that
> > at least for the attributes using WMI_STORE_INT() + WMI_SHOW_INT()
> > that there is quite some commonality between some of the attributes.
> >=20
> > I see how using the existing firmware-attributes class API definition
> > for this, including allow tweaking this with some of the fwupd
> > firmware-attributes class commandline util work Mario did is a useful
> > thing to have.
> >=20
> > I guess using the firmware-attributes class for this is ok, but
> > this _must_ not be named bioscfg, since the existing hp-bioscfg
> > driver is a "classic" firmware-attributes drivers enumerating all
> > the options through BIOS provided enumeration functions and I want
> > the name to make it clear that this is not that. And the Dell
> > implementation is called dell-wmi-sysman so lets also avoid sysman
> > as name.
> >=20
> > Maybe call it "asus-bios-tunables" ?   And then if Asus actually
> > implements some more classic firmware-attributes enumerable interface
> > we can use "asus-bioscfg" for that.
> >=20
> > Mario, Ilpo what is your opinion on this ?
>=20
> What you suggested sounds good to me.

Thanks guys. I think there might be a few names that could be suitable

1. asus_bios_tuning/tunables
2. asus_fw_tuning/tunables
3. asus_fw_settings
4. asus_armoury

I'm shying away from the "tuning/tunables" label since there are also a =
lot of settings which are just toggles for various features rather than =
actual tunable things. It makes sense in some contexts at least.

Armoury Crate is the software collection that Asus uses for the gaming l=
aptops, and they tend to lump these settings under that label.

Personally I'm leaning towards "asus_fw_settings" as it more accurately =
describes what the module does.

