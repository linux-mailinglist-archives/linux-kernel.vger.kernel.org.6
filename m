Return-Path: <linux-kernel+bounces-275401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD89484F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7BE1F22A5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECFA16B720;
	Mon,  5 Aug 2024 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="haReA+r1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H71bNqvp"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7357323;
	Mon,  5 Aug 2024 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722894104; cv=none; b=CjnTTx9Fofd+0/giqff3jyp61vAGYPryoahV0qMaZ1Z/xdC118rL6SaJvIlEXVSza3jw5FT0nQs/C9QnRalsUK0Oxze1Pg/qVxidUKkgpmUiETc7iJvJt8X/XXnIDBFJbp4NVhzulxS3/WAykRVVkTpwpVR40BLPr2pw6sA7RwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722894104; c=relaxed/simple;
	bh=LxqNl93oNDBVHrlq+WL9mX2KsBWdtglfzkx5RO5LGww=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fgovIT0a+ljOcS1sWkeV5LvwHzdgjRTIuXn2Yu/XJfBoZ/8+k39HKymglgf+f4ZR2AA+KrAo4M7lwrCw1hjbIQjQeN+1qld97Gt19wamx14Iz+P9+2V6R9lbrl2EoRhhqIMWdXISz2ykqh0SCwgh0tbMQY7+tX5WC7nJshPoCkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=haReA+r1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H71bNqvp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5B39A114AB25;
	Mon,  5 Aug 2024 17:41:40 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 17:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1722894100;
	 x=1722980500; bh=gY+Y0Y9pBsBrT+Hu1S5yds/9bTz/ceRETXNYGdVafCQ=; b=
	haReA+r1/ylPhTMP6hvskrYAPxYiCgo1I1BnORe+hB0VUz8+8PtOwLLeehF8/Y3i
	TVxgctr4sazr7jrRwd439hW3uQKmsMjhoLptjJIUbEK9SkbkUClsQyn49twQuHAu
	gNetInDeAtlL/lK6KG66hmRGKujkJQnjNj6Uz+rgesBSxk9xLz6SbDywD4PUQFs3
	3mlit0OSs1v/w9a6uSUYqWrvGKkrm6gFyYbJPNiLMtF3t1NvlLngm71OjN7Lpc/w
	ilIfYJAOvIm+xoZFc4R0vkWD6iHOeIfiZG3rqJhD8n9IXzpA+gJcAG3hSDBZA7zJ
	hkS4xGNwo7UDy8bOiTWbuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722894100; x=
	1722980500; bh=gY+Y0Y9pBsBrT+Hu1S5yds/9bTz/ceRETXNYGdVafCQ=; b=H
	71bNqvpV2411g6vndo4HCVxJAqvNWKSGfGRkb6UIlyF3RqvarG8mIK/tJB75dlHi
	ud4d87cE7O5xORRGdmTuXxem62rgwz42BAk5wWoALH+a2icMHAOmBoatPNvMskoU
	AUcXReztR7JMM4rpksoyiIX8SPi18UQnYx/8vqs+rWi23OsyviFUeZWQUe0950hB
	qUR+Dnomud0TkLEksk75a36IIy09vGLPtS4ndxwoIE20ZKjGNmUJHTD+pU7GKFnI
	Sxn+eQUPUBQdnaFCVXHxG+XLMYan7CwHP7Up7qQ64Dzbm4vR4v6Njkdh9/4wCiom
	ghF5+aYzCdlX55RzKaMVQ==
X-ME-Sender: <xms:E0exZvpDP-2Oi1VhqKX4cnm8JFFzWFRS0C-Tmr8mloruu9Ymh6xefw>
    <xme:E0exZpqpcJmlRGzlu_eL5Gpq6iyL-If5aZWwoznm-d3_2ANqTmytk-M2UoOtFrbIA
    AMQf7rqU-ZIrjin5AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfnuhhk
    vgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvg
    hrnhepkeevvdejheeihfekffeuhfdtueelkefflefgieduvddtheektefhheelheegvedu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggp
    rhgtphhtthhopedt
X-ME-Proxy: <xmx:E0exZsPqsGqRheq7crAldQ_wG6WZ5CqSchTBrCCh4r_LB1KkaR1ayQ>
    <xmx:E0exZi6T5iqrY8xus4lAfpboFUv1R69QSfeTGi-4mwf37JoVUd8fLQ>
    <xmx:E0exZu7CEzuG5mJM-pd56xRa60Ol4wZEJvmTRSpr8GW4wi5c71j4lA>
    <xmx:E0exZqhv2oB3q5SyvTfI8iX3MyJQDON510Rn7BytlYex7lRwc2ZgUg>
    <xmx:FEexZp3ORQXjbajfN64Kf7OPzAWQr_0IlGhsAQe4IETjAlvSPnpmdCV0>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DAC5A2340080; Mon,  5 Aug 2024 17:41:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Aug 2024 09:41:19 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com,
 "Mario Limonciello" <mario.limonciello@amd.com>,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <a35c923e-be2c-4083-8c65-c83b49fe4350@app.fastmail.com>
In-Reply-To: <517aa9f5-00cf-4a68-b1d7-a6dc9f942e7c@redhat.com>
References: <20240716051612.64842-1-luke@ljones.dev>
 <8273ed57-4c65-41da-ad7d-907acf168c07@redhat.com>
 <e9f4fb37-5277-a7f0-2bec-8a6909b4e674@linux.intel.com>
 <1e309d39-43d3-4054-88a9-0c1da3de26eb@app.fastmail.com>
 <517aa9f5-00cf-4a68-b1d7-a6dc9f942e7c@redhat.com>
Subject: Re: [PATCH 0/5] platform/x86: introduce asus-bioscfg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Aug 2024, at 3:18 AM, Hans de Goede wrote:
> Hi Luke,
>=20
> On 7/17/24 4:34 AM, Luke Jones wrote:
> > On Wed, 17 Jul 2024, at 3:11 AM, Ilpo J=C3=A4rvinen wrote:
> >> On Tue, 16 Jul 2024, Hans de Goede wrote:
> >>> On 7/16/24 7:16 AM, Luke D. Jones wrote:
> >>>> This is the first major patch I've ever done with the intention of
> >>>> introducing a new module, so it's highly likely I've made some mi=
stakes
> >>>> or misunderstood something.
> >>>>
> >>>> TL;DR:
> >>>> 1. introduce new module to contain bios attributes, using fw_attr=
ibutes_class
> >>>> 2. deprecate all possible attributes from asus-wmi that were adde=
d ad-hoc
> >>>> 3. remove those in the next LTS cycle
> >>>>
> >>>> The idea for this originates from a conversation with Mario Limon=
ciello
> >>>> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-80=
2f-4ec27a945c99@amd.com/
> >>>>
> >>>> It is without a doubt much cleaner to use, easier to discover, an=
d the
> >>>> API is well defined as opposed to the random clutter of attribute=
s I had
> >>>> been placing in the platform sysfs.
> >>>
> >>> This is a bit of a novel use of the fw_attributes_class and I'm not
> >>> entirely sure of what to think of this.
> >>>
> >>> The fw_attributes_class API was designed for (mostly enterprise)
> >>> x86 machines where it is possible to change all BIOS settings dire=
ctly
> >>> from the OS without entering the BIOS.
> >>>
> >>> Here some ACPI or WMI function is present to actually enumerate all
> >>> the BIOS options (which can be set this way) and get there type.
> >>>
> >>> IOW there is not a static list of options inside the driver, nor
> >>> is there special handling in the driver other then handling differ=
ences
> >>> per type.
> >>>
> >>> And if a new BIOS version has new options or a different machine m=
odel
> >>> has different options then these are discovered automatically.
> >>>
> >>> This new use is quite different from this. Although I do see that
> >>> at least for the attributes using WMI_STORE_INT() + WMI_SHOW_INT()
> >>> that there is quite some commonality between some of the attribute=
s.
> >>>
> >>> I see how using the existing firmware-attributes class API definit=
ion
> >>> for this, including allow tweaking this with some of the fwupd
> >>> firmware-attributes class commandline util work Mario did is a use=
ful
> >>> thing to have.
> >>>
> >>> I guess using the firmware-attributes class for this is ok, but
> >>> this _must_ not be named bioscfg, since the existing hp-bioscfg
> >>> driver is a "classic" firmware-attributes drivers enumerating all
> >>> the options through BIOS provided enumeration functions and I want
> >>> the name to make it clear that this is not that. And the Dell
> >>> implementation is called dell-wmi-sysman so lets also avoid sysman
> >>> as name.
> >>>
> >>> Maybe call it "asus-bios-tunables" ?   And then if Asus actually
> >>> implements some more classic firmware-attributes enumerable interf=
ace
> >>> we can use "asus-bioscfg" for that.
> >>>
> >>> Mario, Ilpo what is your opinion on this ?
> >>
> >> What you suggested sounds good to me.
> >=20
> > Thanks guys. I think there might be a few names that could be suitab=
le
> >=20
> > 1. asus_bios_tuning/tunables
> > 2. asus_fw_tuning/tunables
> > 3. asus_fw_settings
> > 4. asus_armoury
> >=20
> > I'm shying away from the "tuning/tunables" label since there are als=
o a lot of settings which are just toggles for various features rather t=
han actual tunable things. It makes sense in some contexts at least.
> >=20
> > Armoury Crate is the software collection that Asus uses for the gami=
ng laptops, and they tend to lump these settings under that label.
> >=20
> > Personally I'm leaning towards "asus_fw_settings" as it more accurat=
ely describes what the module does.
>=20
> "asus_fw_settings" sounds good to me. I'm looking forward to v2 of thi=
s series.

I've actually done a poll on my discord, folks voted overwhelmingly for =
`asus-armoury` and I went with this before your response. The reasoning =
here is that many of these users are coming from windows where Armoury C=
rate is an app that exposes all the same functions and so that's what th=
ey look for on linux.

If you don't think this is suitable I'm happy to change.

> Regards,
>=20
> Hans
>=20
>=20
>=20

