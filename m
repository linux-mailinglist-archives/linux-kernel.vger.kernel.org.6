Return-Path: <linux-kernel+bounces-322959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1F39735E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8EF1C23CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6552218C32F;
	Tue, 10 Sep 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="SXgnrroI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/qQsz6F"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B7714D431;
	Tue, 10 Sep 2024 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966316; cv=none; b=jXR/i5OHtT5TP/hzpp2J2raZH3l0NJDEwv/VbGC/JcMCXhC1tJZNLLIah1/5WPYjTmrldqu73r/IyeGo+MdAQyguAopBrHpn805TKBa+Y+Pz8wZ4LOEZczNX3F7B/DbPPzzYhHsWUc4/Rt+E+T54YGRmWmTvjh7R+MxZCdJbAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966316; c=relaxed/simple;
	bh=1yx9TcnUJgtqcP8mBslj5zwznPpDMjo3LS5Ve+dFVqg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GgkMpgiBOTS8kd1cdNlOiJeFI0N03CUn84hUFplZinGGeJtBUmZ7Dpr4mg8+YZJBXoG2R4h2Yv91lIfiD1alIWbmwRGg36/wS3a+GW/Yi7YrsJijyFzSLtKvsBf46EZLkmAVGs6QgH3jDT403EiU/RqtEBNwyoTNLSeOFFuftgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=SXgnrroI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/qQsz6F; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 197AC114032F;
	Tue, 10 Sep 2024 07:05:12 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Tue, 10 Sep 2024 07:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1725966312;
	 x=1726052712; bh=F072JG3GoQyszrW17lcvI6A0vuenqv3vV3Xu5Ss4cp8=; b=
	SXgnrroI/JuFScOGm0wrFjF7DBHvy9NINaZX3mMaprYkt2N/cNJB15bIoD7t/FIK
	1hhuuShPGBOYggkF05rj0Qi5hKJTrYezZJtE5Z95iyFdGdbpE9a9wLXFrIAJ0jJU
	WAH6BSCAvXRNhuGQiDIBOS9sLAuhloVr0EIEAy8SCxudtDSpESTqYbF4aHsCxM/j
	oHYDMaVk5/QGegDiQJe07zJi28edJ7//aEengwr3x+OMnXhO1VP1CHA/z5GhE3Na
	5E+VaJpSYFEMAEWPtd5CsQsOufpaEmprXU17rWFOGVHnIWz5eB+pUDnpdURqcREz
	1aJnPopFIDCrUMsPgXppSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725966312; x=
	1726052712; bh=F072JG3GoQyszrW17lcvI6A0vuenqv3vV3Xu5Ss4cp8=; b=A
	/qQsz6FRmhB94gvjUHHkB95HhEue6VgPZtVdoSDC7JyjhfzjYsm/nyt9kHBJmgWG
	UlwF6DmzSmnd8RZdCocN/AzR5BGeIVQ2KBS8SU0xADdUUb1qyOaA6IWbd8k7HKJ+
	nWb+X5gEu7+7lL0mCxXQmTFHiA0cusjpFdfzN1U5vmYNVQOdOhcpH5Uy4lftwSzp
	ws1qQvOvK6vWLjiy3npKLxUx2VxUqe1p+L2dkpn6C0+Qyyi6FetEigfrIAp4SFym
	rR/N+EIHL1GipfXqOrE65Iamo2j6v/XZPfeajtWPhLhWVXQTNcnG1SUbnmypKJVW
	K3xQpBWsmSzr19GxnCicw==
X-ME-Sender: <xms:5yfgZgNSmD-FAhCM-VxtL2jK13hh9clmOq5UlqripO6TOXubzkRDvg>
    <xme:5yfgZm-5Q2qWjMfcwiY6uV1ah6Ti4ixxvFa_JPtuFRvfMB0smrQjygrZm8qRzejVu
    hgc7o2pvmMxWcsjTGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfnfhukhgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvg
    hvqeenucggtffrrghtthgvrhhnpeehtedugfelgeeltdevvedtleffhfetgfdtjefhkefg
    udejfeeuueefvdejuddutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhi
    esghhmrghilhdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrth
    drtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5yfgZnQGJEMFrHXqinlabJr9E5c9q5RcrOBMK9yXWiTWyaJFknX11A>
    <xmx:5yfgZotj9sOcn-gjYg14JUj-SkVxzAQH354FXTDV4O4MeNb5Ng4SDg>
    <xmx:5yfgZocIv1cluDlm_k_3NFNSM97K8ZsnmVcJWyheO36YmK9-HvD_Fg>
    <xmx:5yfgZs2HWm1RBz5M0oey85nwtEE_EXJFJ8IPHcE54ABS8wfj96sMLQ>
    <xmx:6CfgZg46TSwS2ewn9NEvfmdneItGG1b5w1fSs1kGIGBh1kgFdSJn-gNb>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8A99B3360077; Tue, 10 Sep 2024 07:05:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Sep 2024 23:04:50 +1200
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com
Message-Id: <34d15b62-42f2-4be3-9e0d-69f77fb52e90@app.fastmail.com>
In-Reply-To: <baebdb06-0ada-cab0-b9c3-154346be4e72@linux.intel.com>
References: <20240910045443.678145-1-luke@ljones.dev>
 <baebdb06-0ada-cab0-b9c3-154346be4e72@linux.intel.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: don't fail if platform_profile already
 registered
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Sep 2024, at 9:39 PM, Ilpo J=C3=A4rvinen wrote:
> On Tue, 10 Sep 2024, Luke D. Jones wrote:
>=20
> > On some newer laptops ASUS laptops SPS support is advertised but not
> > actually used, causing the AMD driver to register as a platform_prof=
ile
> > handler.
> >=20
> > If this happens then the asus_wmi driver would error with -EEXIST wh=
en
> > trying to register its own handler leaving the user with a possibly
> > unusable system. This is especially true for laptops with an MCU tha=
t emit
> > a stream of HID packets, some of which can be misinterpreted as shut=
down
> > signals.
> >=20
> > We can safely continue loading the driver instead of bombing out.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  drivers/platform/x86/asus-wmi.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index fbb3345cc65a..d53c4aff519f 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -3876,8 +3876,13 @@ static int platform_profile_setup(struct asus=
_wmi *asus)
> >  asus->platform_profile_handler.choices);
> > =20
> >  err =3D platform_profile_register(&asus->platform_profile_handler);
> > - if (err)
> > + if (err =3D=3D -EEXIST) {
> > + pr_warn("%s, a platform_profile handler is already registered\n", =
__func__);
> > + return 0;
> > + } else if (err) {
> > + pr_err("%s, failed at platform_profile_register: %d\n", __func__, =
err);
>=20
> Don't print __func__ in user visible warn/error/info messages but use=20
> plain English please.

Ack. I've done this a few times now. Sorry I missed this one.

>=20
> >  return err;
> > + }
> > =20
> >  asus->platform_profile_support =3D true;
> >  return 0;
> > @@ -4752,7 +4757,7 @@ static int asus_wmi_add(struct platform_device=
 *pdev)
> >  goto fail_fan_boost_mode;
> > =20
> >  err =3D platform_profile_setup(asus);
> > - if (err)
> > + if (err && err !=3D -EEXIST)
>=20
> Hi Luke,
>=20
> Hans had a comment about this line against the previous version.
>=20
> Also, this patch has entirely lost the version information. It's v3 no=
w I=20
> think.

Uh.... sorry, I seem to have lost it in the depths of my inbox even with=
 filters and searching. I'll look it up on lore and ensure everything is=
 correct next go round.

Cheers,
Luke.

