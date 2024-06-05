Return-Path: <linux-kernel+bounces-201894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA6C8FC4DD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E49285610
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853918FDAA;
	Wed,  5 Jun 2024 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="ioZ+xpME";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l4X5pr2j"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D518C34D;
	Wed,  5 Jun 2024 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573413; cv=none; b=tQH9ivxpysk6KIeKe5f9zscB+JWvGlFKKG0OJSMkzEGXWsZ6N7GaX30SUFY7ToZ32eAa+jc5Y8DmyOcdb+45urbDLGJVIIlB8y4Z+KelJHHrtBTMA1zOCC20DofF//TytqxSqNhte6+9gA8B1laX6hH0/X9EQLfxm2L9VDdmJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573413; c=relaxed/simple;
	bh=tUU99Qo+LcQZiTUCE3P4DUm0whUVST6beixKmzD7IDI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HrWrW3j0h9IOTbPu8DImk7J/OxHcGXVqXj0FkbugfV0NgfFPe0vHf2987jiCrZ/v56S7VzaSeA4wH4b1PGvh1s38wM1JHUw/c2mTXaj1pJq7ogmWWYyHVAU+Tz9rLplYIUBlbpYlwJbyNWgwo+ldb3QbL6TzARHF+TFQbvd7/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=ioZ+xpME; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l4X5pr2j; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id BCF9D13800BA;
	Wed,  5 Jun 2024 03:43:29 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Wed, 05 Jun 2024 03:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1717573409;
	 x=1717659809; bh=SMBKMXdKR5AV8mqVmMCVhzgXj9mxs6ky4diUGGrkC60=; b=
	ioZ+xpME8XXXb4TB0fDP6XVC6IhGZIPW5Dw0m1nA3Po0zv5NG6j29/GdRhtP6Nv6
	vn/lW3S2Zq6cWNNmICDym65dKCVJk2+bdAEs7RPTFIX/C8qs8XCil+/6/ZLCLHl6
	XSN8v35x5wBPc5y+xN7mnpw0lDBi+eth9F6A6wYGREBQqqNalEmh3FoNYB+iRx6X
	khItyL/bLJEn182CkRHu/aV+56Jv6OXZeachjh+6jvVAXZxQmQAspG6XvytaHwmi
	qfxvI5otENveGCcnDmaS22Ka4AHSzjReUInGR/gt/H3Gcy10WTd/WS/tVdnI+0Bi
	USW5sk0yk5mbbwhsxZytTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717573409; x=
	1717659809; bh=SMBKMXdKR5AV8mqVmMCVhzgXj9mxs6ky4diUGGrkC60=; b=l
	4X5pr2jsQ8qr0USyNoG15lEi10cl4mjlugVL9EvxdT8iMkdCyxKPx6ktP44Cqq2r
	uI8cZtKZGdjrd56UOmWUG68OP3CYF/jEFfYftggxASYasK5QJV44YcTAJqHnAroG
	jS5HxVPVdB0DknVcrDxHAyQTBNf/vwb/MY56y6b48OZrGXOg3FZPRjP6lrgN7U49
	Bu/08526H1c4PS07mvlcDXpnMXJ7+A4OLfzakrGqOquBFIiYLSEe+K+hDZvnewNO
	j2u/+bhNsRKsKRyUW9WjMHFl5y3bxUeNakpsNfnn7ZPxdAlc+/Q717y4XPV7EBPd
	raPUqSY/G1aHn5GuYsQBA==
X-ME-Sender: <xms:IBdgZrLFySDRu-Zdc35cv0_qNXxekwkXOaLNl2O_8wQwDs5_gpiH2w>
    <xme:IBdgZvI0lSFnL1qPwTPNaVW6oEJkVz0E_1HrXClGgzjCvtQ4UaWjs78CWWZn4wjLZ
    20KTM2lqBBvkdHJRCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    nfhukhgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrg
    htthgvrhhnpeefuefghfdvueefheeiledvgeefffevgeelhedtvdehgeekteeugedtgeeu
    hedvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:IBdgZjtPkfyMM-7qW5e7mEz01k4W_odjU_JGvSrPhBEirZeaML6ZeA>
    <xmx:IRdgZkYqVZB5SoVir5zfSDyMOhy4HS3iVWWBq_2--ftdFtmgTr0crA>
    <xmx:IRdgZiaoCeE8WZGYjKOJf5a12QSqLR5h4cJXJzKQDvGPRR6IcSFgGQ>
    <xmx:IRdgZoBYHfay46cMfCieapI8Im4wYwlgabCRbmplMJWQARXaInDcuw>
    <xmx:IRdgZpWJGn1yBuWMUC89ZRh7rqW8taKNoDJeKQ40k8IeETvlQy1tDTqW>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C399A2340080; Wed,  5 Jun 2024 03:43:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4de768c5-aae5-4fda-a139-a8b73c8495a1@app.fastmail.com>
In-Reply-To: <f126562f-54c8-de58-3f98-7375c129f66a@linux.intel.com>
References: <20240421194320.48258-1-mohamed.ghanmi@supcom.tn>
 <20240421194320.48258-2-mohamed.ghanmi@supcom.tn>
 <de8fcb82-3e08-41e6-b099-75df27c6df23@redhat.com>
 <aee09e9f-6269-43ef-b509-a9a7b5e1752f@app.fastmail.com>
 <f126562f-54c8-de58-3f98-7375c129f66a@linux.intel.com>
Date: Wed, 05 Jun 2024 19:43:08 +1200
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 "Mohamed Ghanmi" <mohamed.ghanmi@supcom.tn>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] platform/x86: asus-wmi: add support for vivobook fan
 profiles
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, 3 Jun 2024, at 10:29 PM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 3 Jun 2024, Luke Jones wrote:
> > On Mon, 29 Apr 2024, at 10:20 PM, Hans de Goede wrote:
> > > On 4/21/24 9:43 PM, Mohamed Ghanmi wrote:
> > > > Add support for vivobook fan profiles wmi call on the ASUS VIVOB=
OOK
> > > > to adjust power limits.
> > > >=20
> > > > These fan profiles have a different device id than the ROG series
> > > > and different order. This reorders the existing modes and adds a=
 new
> > > > full speed mode available on these laptops.
> > > >=20
> > > > As part of keeping the patch clean the throttle_thermal_policy_a=
vailable
> > > > boolean stored in the driver struct is removed and
> > > > throttle_thermal_policy_dev is used in place (as on init it is z=
eroed).
> > > >=20
> > > > Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> > > > Co-developed-by: Luke D. Jones <luke@ljones.dev>
> > > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > > ---
> > > >  drivers/platform/x86/asus-wmi.c            | 93 ++++++++++++---=
-------
> > > >  include/linux/platform_data/x86/asus-wmi.h |  1 +
> > > >  2 files changed, 51 insertions(+), 43 deletions(-)
> > > >=20
> > > > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/=
x86/asus-wmi.c
> > > > index 3c61d75a3..1f54596ca 100644
> > > > --- a/drivers/platform/x86/asus-wmi.c
> > > > +++ b/drivers/platform/x86/asus-wmi.c
>=20
> > > > @@ -3747,7 +3753,10 @@ static ssize_t throttle_thermal_policy_st=
ore(struct device *dev,
> > > >  return count;
> > > >  }
> > > > =20
> > > > -// Throttle thermal policy: 0 - default, 1 - overboost, 2 - sil=
ent
> > > > +/*
> > > > + * Throttle thermal policy: 0 - default, 1 - overboost, 2 - sil=
ent
> > > > + * Throttle thermal policy vivobook : 0 - default, 1 - silent, =
2 - overboost, 3 - fullspeed
> > > > + */
> > >=20
> > > throttle_thermal_policy_write() always expects normal (non vivoboo=
k) values and
> > > then translates those to vivo values, so this comment is not corre=
ct.
> > >=20
> > > The only difference is that vivobook also has fullspeed, but the w=
ay userspace
> > > sees it 1/2 or silent/overspeed are not swapped, since the swappin=
g is taking
> > > care of in throttle_thermal_policy_write().
> > >=20
> > > Also the new fullspeed is not exported through the platform_profil=
e interface,
> > > for setting values this is somewhat ok, but fullspeed can be set t=
hrough
> > > sysfs, and this will then cause asus_wmi_platform_profile_get() to=
 fail
> > > with -EINVAL, so this need to be fixed. Either map fullspeed to
> > > PLATFORM_PROFILE_PERFORMANCE in asus_wmi_platform_profile_get(), o=
r add
> > > a new platform_profile value for this.
> > >
> >=20
> > I would much prefer if "fullspeed" was not included at all unless it=
 was=20
> > an individual setting. It very rarely contributes anything good to t=
he=20
> > driver, and most certainly won't be of value in the platform_profile.
> >=20
> > Otherwise, what is the status on this?=20
>=20
> Hi,
>=20
> I was expecting an update that addresses Hans' review comment.
>=20
> Luke, are you arguing that his comment is not valid and v3 is fine?
>=20
> (In any case, I've summoned v3 back from archive into active patches i=
n=20
> patchwork so this doesn't get forgotten if v4 is not needed).
>=20
> --=20
> i.

Hi.

I am saying I would like to see ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED r=
emoved, or placed somewhere else such as in <sysfs>/asus-nb-wmi/hwmon/hw=
mon3/pwm1_enable.

It certainly shouldn't be included in platform_profile and I'm not keen =
on seeing it in thorttle_thermal_policy either.

A lot of this reasoning is now coming from the refactor I've just done o=
f asus-wmi and the "features" such as this one to place them under firmw=
are_attributes class and begin deprecation of them in asus_wmi. From wha=
t I've achieved so far with it it is much *much* more suitable than this=
 ad-hoc style of adding features I've been doing here (I'll submit this =
work soon, it repalces the last patch series I did).

In light of the above I'm considering the possibility of removing thrott=
le_thermal_policy completely to wholly favour the use of platform_profil=
e. It doesn't make all that much sense to have two different things mani=
pulating the same thing - and as such I don't think the "full speed fan"=
 setting fits at all with platform_profile as it is not a performance tw=
eak.

Mohamed, I would be happy to include the Vivo support so long as:
1. the fullspeed setting is removed
2. the modes map correctly to platform_profile

I hope this makes sense. Very sorry about the previous brief response (I=
 was recovering from surgery trauma).

Cheers,
Luke.


