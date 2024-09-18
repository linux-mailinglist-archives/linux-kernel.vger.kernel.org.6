Return-Path: <linux-kernel+bounces-332431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF3B97B99B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9F11C21CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CCE176FBD;
	Wed, 18 Sep 2024 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="B7vr7B5I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FIi0FtUY"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D33DF6C;
	Wed, 18 Sep 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649456; cv=none; b=Fzkju2Vjjwawkk8v0FD9fWSRPmMAMXC4kiElEUjrhNJDiHvN3VGSALRVmaIl830pnvuntA4sfKfiM1CaCXagc1oyBjNi35kHmmhPuqBT3wY6UI/rmAVGLnZA3X51oe6FRYsxC/uRNXHCkaIYlRr8Bj9f9AQyP1mAZDddsXD0YKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649456; c=relaxed/simple;
	bh=WZiUv3EmkdmIas8JtLy47tGLPxijQqw8UaIvbITreZk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j1aVFyVrAs9Nn+tq8rqPJvBZ088ic7oCzhifVUsEDmxBC21IpFdsx1YZOTD/R6ampsT8mcaQbdMGEwDznS57Hiofc8i8nBz4KsXASMivpo9fWooU5H9P2Wcu3L+uIpq1LyJmlNk19UfmM5Iwyw7+75WspP2R48EE5i6XBZDndnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=B7vr7B5I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FIi0FtUY; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38C3F11402DF;
	Wed, 18 Sep 2024 04:50:52 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Wed, 18 Sep 2024 04:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726649452;
	 x=1726735852; bh=C1K8o/kaN4c667QZfKLfXRtlS3piE1KZOKHfMOAZg48=; b=
	B7vr7B5Ib4Y3Mo6TFu8LhLzNZ24guMqxZ4B9xiDWle0qo+s/IrT9ljFAn6jRmouq
	PIj2Nb40t0Hzw9JzElTs3aiklkCzOGbh4UOVKREk3ezkx40L7PeugU6ZfBylaCQt
	El2Q+tq6U3MJTN87n/XPjXBXI8mbqsYhf1PyXMZuNdAqZO1dP2g8H3eJV120B5cO
	gRZng0Ng4Gtl7vT9Bs4dx78ApFoG6ch66cAJvKRfxhLK9/MN/zW7AyiE3X0G18v9
	F8kl3HF0qAe6aTCRuAKXEIP9/FtnNlK97QDwxTbZAZ2MK1NimnwCO/wUnNITa4vD
	y23NG9t0jburzl9vKLt2sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726649452; x=
	1726735852; bh=C1K8o/kaN4c667QZfKLfXRtlS3piE1KZOKHfMOAZg48=; b=F
	Ii0FtUYu6+kHRGdUNEGoJQOK+LH2yesqXwjJt5IaFGFnjYV2mehPYsyylgmrM+5x
	rgjixhGxOgHkSu/vMOjODaEt9U7CML8/8cAkZHz6gaHdprto8u4n1Az1HJyTnrBL
	ktykeYHllPtpTbcz2uX4pT5J/xN8NuQXkrtTIqkYfhW0WE1sJBtDatWnXvbnIvs0
	zxIuY/n6bg2wMHFuBOQuiFKXWmVrvVAv3t8FaGcF/HWnuj17KaDCgc36t5Sl/amU
	Xn/XSSurp+RQf8BFLwZyS6CjspOD3fU5NFxYrJcedNmoihj16eO5meRDa+h5H/W6
	BxYNq3BGtSsb0fRqOgmEw==
X-ME-Sender: <xms:a5TqZrhUJKMg1hq78qWZgw7dnSa2tyDU4i-JhmvUNCi5a5e-wFyATw>
    <xme:a5TqZoB-KwxrO9WP2R-8JdBYlRuEBw1SS0ZEFOQFULBMjlm1HGiVBrofQ5aAEimrO
    pfnzHqrk8CjDzATSKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfnfhukhgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvg
    hvqeenucggtffrrghtthgvrhhnpeekvedvjeehiefhkeffuefhtdeuleekffelgfeiuddv
    tdehkeethfehleehgeevudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhho
    nhgvshdruggvvhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheptghorhgvnhhtihhnrdgthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtph
    htthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhlrg
    htfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:a5TqZrE0jNfiAiuO-pFyA2BjH3A3OvjThEyTqpYAO4BPHvSXP6-USA>
    <xmx:a5TqZoThGBRtAhEjxfr4ABNDTmPeR4jhOqMVm5VcXUue8kmlUwEo0Q>
    <xmx:a5TqZoxhKINArXcXToyKhj6LdfbVYYA6u0d-kMelPcowNj_kTnWkzA>
    <xmx:a5TqZu7sy_XzfRqzVj2Xxg23qp0_xanDVvqETJZVvwlqBrBPF6d76Q>
    <xmx:bJTqZk_Cf00Furq0257DhzdkxuyQPHgRzP53q4m-fY5FNSbJTphWgfAp>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9315E3360077; Wed, 18 Sep 2024 04:50:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Sep 2024 20:50:31 +1200
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com
Message-Id: <3f244316-f259-4d61-90ae-4caa183c1a32@app.fastmail.com>
In-Reply-To: <27027d00-214d-e566-6339-95ed4397b99d@linux.intel.com>
References: <20240806020747.365042-1-luke@ljones.dev>
 <20240806020747.365042-3-luke@ljones.dev>
 <bb056dee-508c-6186-324a-d45bbd1c2306@linux.intel.com>
 <7dc2cb6a-3b42-425a-85d3-2f3670bfd8eb@app.fastmail.com>
 <27027d00-214d-e566-6339-95ed4397b99d@linux.intel.com>
Subject: Re: [PATCH v2 2/6] platform/x86: asus-armoury: move existing tunings to
 asus-armoury module
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Aug 2024, at 7:37 PM, Ilpo J=C3=A4rvinen wrote:
> On Sun, 11 Aug 2024, Luke Jones wrote:
>=20
> > On Tue, 6 Aug 2024, at 10:16 PM, Ilpo J=C3=A4rvinen wrote:
> > > On Tue, 6 Aug 2024, Luke D. Jones wrote:
> > >=20
> > > > The fw_attributes_class provides a much cleaner interface to all=
 of the
> > > > attributes introduced to asus-wmi. This patch moves all of these=
 extra
> > > > attributes over to fw_attributes_class, and shifts the bulk of t=
hese
> > > > definitions to a new kernel module to reduce the clutter of asus=
-wmi
> > > > with the intention of deprecating the asus-wmi attributes in fut=
ure.
> > > >=20
> > > > The work applies only to WMI methods which don't have a clearly =
defined
> > > > place within the sysfs and as a result ended up lumped together =
in
> > > > /sys/devices/platform/asus-nb-wmi/ with no standard API.
> > > >=20
> > > > Where possible the fw attrs now implement defaults, min, max, sc=
alar,
> > > > choices, etc. As en example dgpu_disable becomes:
> > > >=20
> > > > /sys/class/firmware-attributes/asus-armoury/attributes/dgpu_disa=
ble/
> > > > =E2=94=9C=E2=94=80=E2=94=80 current_value
> > > > =E2=94=9C=E2=94=80=E2=94=80 display_name
> > > > =E2=94=9C=E2=94=80=E2=94=80 possible_values
> > > > =E2=94=94=E2=94=80=E2=94=80 type
> > > >=20
> > > > as do other attributes.
> > > >=20
> > > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
>=20
> > > > +static ssize_t attr_int_store(struct kobject *kobj, struct kobj=
_attribute *attr,
> > > > +       const char *buf, size_t count, u32 min, u32 max, u32 *st=
ore_value,
> > > > +       u32 wmi_dev);
> > > > +
> > > > +static ssize_t int_type_show(struct kobject *kobj, struct kobj_=
attribute *attr, char *buf)
> > >=20
> > > inline missing
> > >=20
> > > > +{
> > > > + return sysfs_emit(buf, "integer\n");
> > >=20
> > > Lukas Wunner might have done something to make emitting constant s=
trings=20
> > > easier, please check out if that's already in mainline.
> >=20
> > I'm not sure what I'm looking for here. Searching my current pdx86 p=
ull=20
> > isn't returning anything likely and I can't find anything on lore.
>=20
> I think that was done mostly outside of pdx86, here it is:
>=20
> https://lore.kernel.org/all/cover.1713608122.git.lukas@wunner.de/
>=20
> So DEVICE_STRING_ATTR_RO() seems the way to go, I think.

Thanks. I did try this but the signature is different to the bulk of wha=
t I;ve done already. I don't have the time for it yet and will revisit i=
t later.

>=20
> > > > + * On success the return value is 0, and the retval is a valid =
value returned
> > > > + * by the successful WMI function call. An error value is retur=
ned only if the
> > > > + * WMI function failed, or if it returns "unsupported" which is=
 typically a 0
> > > > + * (no return, and no 'supported' bit set), or a 0xFFFFFFFE (~1=
) which if not
> > > > + * caught here can result in unexpected behaviour later.
> > > > + */
> > > > +int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
> > > > +{
> > > > + int err;
> > > > +
> > > > + err =3D asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_i=
d, 0, retval);
> > > > + if (err)
> > > > + return err;
> > > > + /* Be explicit about retval */
> > > > + if (*retval =3D=3D 0xFFFFFFFE || *retval =3D=3D 0)
> > >=20
> > > Please name the literals with defines.
> >=20
> > Should have been ASUS_WMI_UNSUPPORTED_METHOD :)
>=20
> Is one define enough if you have two ways to indicate "unsupported"?

This function body wasn't correct. It now is and that retval =3D=3D 0 is=
 removed.

>=20
> > > > + return -ENODEV;
> > > > +
> > > > + return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(asus_wmi_get_devstate_dsts);
> > > > +
> > > > +/**
> > > > + * asus_wmi_set_devstate() - Set the WMI function state.
> > > > + * @dev_id: The WMI function to call.
> > > > + * @ctrl_param: The argument to be used for this WMI function.
> > > > + * @retval: A pointer to where to store the value returned from=
 WMI.
> > > > + *
> > > > + * The returned WMI function state if not checked here for erro=
r as
> > > > + * asus_wmi_set_devstate() is not called unless first paired wi=
th a call to
> > > > + * asus_wmi_get_devstate_dsts() to check that the WMI function =
is supported.
> > > > + *
> > > > + * On success the return value is 0, and the retval is a valid =
value returned
> > > > + * by the successful WMI function call. An error value is retur=
ned only if the
> > > > + * WMI function failed.
> > > > + */
> > > > +int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retv=
al)
> > > >  {
> > > >  return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
> > > >  ctrl_param, retval);
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(asus_wmi_set_devstate);
> > >=20
> > > Namespace exports.
> >=20
> > I'm sorry, I don't understand.
>=20
> Use EXPORT_SYMBOL_NS_GPL(). The driver using the functions, will then =
do=20
> MODULE_IMPORT_NS() to pair with the namespace defined by the=20
> EXPORT_SYMBOL_NS_GPL().

Got it. I did wonder about this while reading a few kernel books (rather=
 old now).

>=20
> --=20
> i.
>=20

