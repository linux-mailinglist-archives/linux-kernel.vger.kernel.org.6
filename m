Return-Path: <linux-kernel+bounces-334811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E09A97DC75
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 11:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBACC1F20EF3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31487156F3C;
	Sat, 21 Sep 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="kPcN2B7R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hNKAzwol"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2B1547DB;
	Sat, 21 Sep 2024 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726912166; cv=none; b=p/hMT3C0h+aMBDDoz5j6/2X/Tq1hl2J66dkNyXxrlkcJOlUs6HJJb9VZH4P4WMjWjukUzMeHd57zKPTDnh56IuxuHoAg2v7tNg9yaE9CEqY4Pybg1kG81fGgc1OJ5qRWRed2K1fUvqE6zf7mOTfopdA+nQweXVudUcJaAVjrsRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726912166; c=relaxed/simple;
	bh=tgx+3pBSjApEr890aFzX07FED1DeO0aZCWgQ84s9U9k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=i/XEvFAbt1mqdwieSs1eNEr32Bayr/sGwJgNAk8Rjjpvvk4hpBluhOaBRs1UsFCXJIDIg8v297WehH8mfXO8gzv1RIjHc/zA54k177jvA2ppT+vdSuOaAHu0+TBnGPB4x+duEKJwCC4ELrhF/3ggXylhJDbgH6GQg4KMepp3sHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=kPcN2B7R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hNKAzwol; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C154411402D7;
	Sat, 21 Sep 2024 05:49:22 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Sat, 21 Sep 2024 05:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726912162;
	 x=1726998562; bh=h0Jb1B7I+y06bdcTrt0fdeas11Z535afVAejtBFKrG0=; b=
	kPcN2B7RA9kRn0+TzAE3V8skD+UchLnA79S5rAfW/NeLLSAtK577PPOMFVf8maRZ
	SrWHA+47esFdSxo/70X/SbJcsmFDBsgSCjYPjEE6xg3qMAN3vnvWprWQXPDoEeUs
	5JWeT+EWLBds9iiGNqHwKjy97oIWwDiGT4Dgsp1P2iHrpiZjwb203lufXsSE2qp2
	W5eeK0eoIK6M0uAqRACG/sRqSwHq9mUtgjj08FiFPI9DdKssEYy7pFGc3fLPV/+m
	ZQ9C97gl5XBD5mNZs1DptmGCT6bdAfAAwQowR9txkD1sBWlYc7W/rX4eAySALck0
	sF8MhjUmKVHp1YcQZxuDiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1726912162; x=
	1726998562; bh=h0Jb1B7I+y06bdcTrt0fdeas11Z535afVAejtBFKrG0=; b=h
	NKAzwolICKQ8aU9b8+PYtSgXB+B3rTII3fO46zZeG3RfFT8SKkFPh3l7cnEdmNPn
	5FW9eHGuX3WqJx/zh7wWqm8Pv3as4/WNqU2YdAQvBAVLtdSPAcvoCbCGMGrfsmZS
	Dnxd2BNipwWLce/du5RZCV5jhaMPHtavDjN+1e99m5tMwW8pTlYJ6HNNwggEx9QT
	70YbS8NoCXxtyQfhQTwqQXwR5ii9yLNEk1CkJYQP+zM7cZwmNZIcwKK7m+dU+b+y
	k/8NiRcG0wopd4wN7sSlEhj8OAVYMeJ4ONCmBb1AVMlGqo3A332tXjav4DaBZ7Dz
	xfzMDJSnBrI73SZgJnCWA==
X-ME-Sender: <xms:opbuZoiXtwgur3zYJ9uoDigcH2wZoCPBVuDp6WnRh0IWcZ9auWqgWg>
    <xme:opbuZhDRpZHCDcQvuqliPDUaOTiUqbK-SAXSXeIVD_pAC1UVHEjqh_ijtObo4g0S9
    lyWEvZKtXES4oWiVWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelhedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfnfhukhgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvg
    hvqeenucggtffrrghtthgvrhhnpeehtedugfelgeeltdevvedtleffhfetgfdtjefhkefg
    udejfeeuueefvdejuddutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhi
    esghhmrghilhdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrth
    drtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhjrghi
    lhhlvghtseifrghnrgguohhordhfrh
X-ME-Proxy: <xmx:opbuZgG8jo-sU_9TK8VX0lhayofVtlo5UYm2mx7TAB4g-w4d3_ev_A>
    <xmx:opbuZpReftBCj_km3GpZwZNFM5ZolFZf27SiGnyQRDRd_1CD5JE92g>
    <xmx:opbuZlwBexPPaDk8nW0SPiOeh9fvCPayDk6qqkdtCRaAWGWwh7RtZg>
    <xmx:opbuZn7YTljcwRmhSGZ8Z3w1D5QaiZwXWCQvZDGlbXKkLARSrOxzoA>
    <xmx:opbuZns7TaOK46EOMXoqCx6t6gzqo1n1rI6kAT8f4zptE6TfMvoEKNmp>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 339993360077; Sat, 21 Sep 2024 05:49:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 21 Sep 2024 21:49:01 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 corentin.chary@gmail.com
Message-Id: <c9b0780a-a6f9-4902-b801-2ae5bde1bae3@app.fastmail.com>
In-Reply-To: <33519933-f171-4bbe-adad-dbe51115cc0a@wanadoo.fr>
References: <20240918094250.82430-1-luke@ljones.dev>
 <20240918094250.82430-2-luke@ljones.dev>
 <33519933-f171-4bbe-adad-dbe51115cc0a@wanadoo.fr>
Subject: Re: [PATCH v3 1/5] platform/x86: asus-armoury: move existing tunings to
 asus-armoury module
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Sep 2024, at 7:13 PM, Christophe JAILLET wrote:
> Le 18/09/2024 =C3=A0 11:42, Luke D. Jones a =C3=A9crit :
> > The fw_attributes_class provides a much cleaner interface to all of =
the
> > attributes introduced to asus-wmi. This patch moves all of these ext=
ra
> > attributes over to fw_attributes_class, and shifts the bulk of these
> > definitions to a new kernel module to reduce the clutter of asus-wmi
> > with the intention of deprecating the asus-wmi attributes in future.
> >=20
> > The work applies only to WMI methods which don't have a clearly defi=
ned
> > place within the sysfs and as a result ended up lumped together in
> > /sys/devices/platform/asus-nb-wmi/ with no standard API.
> >=20
> > Where possible the fw attrs now implement defaults, min, max, scalar,
> > choices, etc. As en example dgpu_disable becomes:
> >=20
> > /sys/class/firmware-attributes/asus-armoury/attributes/dgpu_disable/
> > =E2=94=9C=E2=94=80=E2=94=80 current_value
> > =E2=94=9C=E2=94=80=E2=94=80 display_name
> > =E2=94=9C=E2=94=80=E2=94=80 possible_values
> > =E2=94=94=E2=94=80=E2=94=80 type
> >=20
> > as do other attributes.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
>=20
> Hi,
>=20
> a few nitpick below, should it help.

every review is helpful, thank you :)
=20
> > +/* Boolean style enumeration, base macro. Requires adding show/stor=
e */
> > +#define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)=
     \
> > + __ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);    \
> > + __ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible); \
> > + static struct kobj_attribute attr_##_attrname##_type =3D          \
> > + __ASUS_ATTR_RO_AS(type, enum_type_show);                \
> > + static struct attribute *_attrname##_attrs[] =3D {                \
> > + &attr_##_attrname##_current_value.attr,                 \
> > + &attr_##_attrname##_display_name.attr,                  \
> > + &attr_##_attrname##_possible_values.attr,               \
> > + &attr_##_attrname##_type.attr, NULL                     \
>=20
> It would be more readable if ", NULL" was on its own line, IMHO.

Ah yes, I didn't see this. Fixed, plus all following.
=20
> > + };                                                              \
> > + static const struct attribute_group _attrname##_attr_group =3D {  \
> > + .name =3D _fsname, .attrs =3D _attrname##_attrs             \
> > + }
> > +
> > +#define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname) \
> > + __ATTR_CURRENT_INT_RO(_attrname, _wmi);                 \
> > + __ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> > +
> > +#define ATTR_GROUP_BOOL_RW(_attrname, _fsname, _wmi, _dispname) \
> > + __ATTR_CURRENT_INT_RW(_attrname, 0, 1, _wmi);           \
> > + __ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> > +
> > +/*
> > + * Requires <name>_current_value_show(), <name>_current_value_show()
> > + */
> > +#define ATTR_GROUP_BOOL_CUSTOM(_attrname, _fsname, _dispname)      =
     \
> > + static struct kobj_attribute attr_##_attrname##_current_value =3D \
> > + __ASUS_ATTR_RW(_attrname, current_value);               \
> > + __ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> > +
> > +#define ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi, _possible,=
 _dispname) \
> > + __ATTR_CURRENT_INT_RO(_attrname, _wmi);                           =
     \
> > + __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)
> > +
> > +/*
> > + * Requires <name>_current_value_show(), <name>_current_value_show()
> > + * and <name>_possible_values_show()
> > + */
> > +#define ATTR_GROUP_ENUM_CUSTOM(_attrname, _fsname, _dispname)      =
       \
> > + __ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);      \
> > + static struct kobj_attribute attr_##_attrname##_current_value =3D =
  \
> > + __ASUS_ATTR_RW(_attrname, current_value);                 \
> > + static struct kobj_attribute attr_##_attrname##_possible_values =3D=
 \
> > + __ASUS_ATTR_RO(_attrname, possible_values);               \
> > + static struct kobj_attribute attr_##_attrname##_type =3D          =
  \
> > + __ASUS_ATTR_RO_AS(type, enum_type_show);                  \
> > + static struct attribute *_attrname##_attrs[] =3D {                =
  \
> > + &attr_##_attrname##_current_value.attr,                   \
> > + &attr_##_attrname##_display_name.attr,                    \
> > + &attr_##_attrname##_possible_values.attr,                 \
> > + &attr_##_attrname##_type.attr, NULL                       \
>=20
> It would be more readable if ", NULL" was on its own line, IMHO.
>=20
> > + };                                                                \
> > + static const struct attribute_group _attrname##_attr_group =3D {  =
  \
> > + .name =3D _fsname, .attrs =3D _attrname##_attrs               \
> > + }
>=20
> ...
>=20
> > +static const struct dmi_system_id asus_rog_ally_device[] =3D {
> > + {
> > + .matches =3D {
> > + DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> > + },
> > + },
> > + {
> > + .matches =3D {
> > + DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
> > + },
> > + },
> > + { },
>=20
> I think that an ending comma is not expected after a terminator.

Never really been clear on this myself. A massive amount of other code d=
oes include the comma so that's what I followed. And then a massive amou=
nt of other code uses the opposite so I could follow that too.. but I wo=
rk in most of the asus stuff and it looks like that's what is common the=
re so I'll remove the comma.

Many thanks for taking the time to review.

> > +};
> > +
> >   #endif /* !_ASUS_WMI_H_ */
>=20
> ...
>=20
> CJ
>=20
>=20

