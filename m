Return-Path: <linux-kernel+bounces-193126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B218D272E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D571F2209F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937F417BB2C;
	Tue, 28 May 2024 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="IPDeRljL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hve18XNY"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C317BB08;
	Tue, 28 May 2024 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932276; cv=none; b=uKEkzD/Bs2fo+d69li+ax72IBWNXAMT/iYfHzGvaSaEbxka2ClwCoBBt5xVpllqnxhngs/U35eqrgkJ1M2y1mMtK1I2pTiBb4BpTb0YyMidbiuXLjKU2UgRo31xlQHAP8z1qHVYd+1vM9okoqzMzSPJbAdWFHq4ojXLUpLqu6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932276; c=relaxed/simple;
	bh=R/HsicMJlYLrjtAfiU+F9j/7/gZohzq4BEe82lohKfM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=hGn0DmivUQanfEdMuDv8dJduJqvDA44rXQ6yIN7++pN5CDkzHhE1jzLZOaSDAQckSyvCxf66jBmSwkfh2aVYV2B5579RKaxBK1yUw3EYj3Q4lmWCcx54bkZOz1uUx/ObrMeEdm+OT+vqyvq7UArflHgRsQu+nnR3IcDO402yDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=IPDeRljL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hve18XNY; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id C595B18000C8;
	Tue, 28 May 2024 17:37:53 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Tue, 28 May 2024 17:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1716932273;
	 x=1717018673; bh=Z4gInH7+jobeFXZ5owoWpleJ3cPNt4nDoKMyy5VdAto=; b=
	IPDeRljLBbVgK6Hkj/L5hKqpEg49aeMT80ZYbtMB4KxwC1WalCRo+zWeT44Nrfam
	BEKFoRDwlteTSBuFANbQVt1ADXWL6bnDHDU1aSDkczZBeQYchmcvWK+A5ykozDIy
	fNrrj1mMW7rxTDRtYmNVT1WlJojKiKbSfBNUf+S/p6VMfHKwJYFLc2M3DBuWGWHq
	Z8iWbk7iLGUfRUFcpyhS3/rfzBTHLQ45SinRbHqAZh4OBUbnh6Pz5f0UToNnitT7
	g9ej8yUl/0HWKqzuNr9TbMEmxilW8dHNgM7CbS1gX6oNc3ijOtq03yaMStIxYJRh
	11e2jMCdfheCvIWohg7+Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716932273; x=
	1717018673; bh=Z4gInH7+jobeFXZ5owoWpleJ3cPNt4nDoKMyy5VdAto=; b=h
	ve18XNYgcbOos429JBHVkUpBUlJgtyD4O22Nh0UIOSLX64USBdm6YlAkz+iYqMDX
	c2/HnK3ew3ILwRGjmZYaPW+v+o+95QZtVSnTcPK+BWwxNupQHlE8KF5FIQsZVXmG
	5qWYT7T23Gvvgv9CxNbXR605wq0dLsAYZsECF9cTO5aGuCkmmildgmmFw/s8rzkc
	zri8LOMStLypT/gLZjOmo7FPUPfWDwZEd12TZSQwRofhSB9vO4Dckjq4J9ch+/T3
	zwqFOPQPst61ZdUnFS1xqBfU9/lGiH57X4ihGy9sAeuKH7KoNMvyin6Hr2vAMjvL
	q8JUFEYEcuUVgdkyYil6Q==
X-ME-Sender: <xms:sU5WZohDSsTr8NjdHT6nXV5CYxQXGIqwzhC0zltnB0i7uP-00sxQQg>
    <xme:sU5WZhANocVYCckUIVNG1AkfclCb-trSGVKhIxFi5_sph7f9WQXSpd0FSECk9VEUx
    PpBAOeWgxDjs-7YY50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejlecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfnfhukhgv
    ucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeefuefghfdvueefheeiledvgeefffevgeelhedtvdehgeekteeugedtgeeuhedvleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:sU5WZgFIb7l-S2ekLIQmYlGFX_ljRz-2ZEuXPTnPcFujoEyGxUD3Hw>
    <xmx:sU5WZpT64XKKTUpegcsgNZpdYuUZ35y4rBjB4ab14Q7-3boDxr-Ztg>
    <xmx:sU5WZlxtDIbBuI5JwTbcaFEDKO21XHFSckvNoAN8csyodQQLiK8kww>
    <xmx:sU5WZn7UQVenBlEBCYpaFFcHNHye1kScNi3kF-WLq2Dq2nG2t8To0A>
    <xmx:sU5WZt8LVQCcGsC3uw1D5ktiW5UlO7OOeHEuqCjBpRVkucBZEXq9NIfw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 128EA2340080; Tue, 28 May 2024 17:37:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a476aebc-fb31-4236-81cf-70a9e1e564a3@app.fastmail.com>
In-Reply-To: <4660daf1-f42f-9b65-eaf5-30daf2931058@linux.intel.com>
References: <20240528013626.14066-1-luke@ljones.dev>
 <20240528013626.14066-8-luke@ljones.dev>
 <4660daf1-f42f-9b65-eaf5-30daf2931058@linux.intel.com>
Date: Wed, 29 May 2024 09:37:32 +1200
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Hans de Goede" <hdegoede@redhat.com>
Cc: corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/9] platform/x86: asus-wmi: add enable/disable CPU cores
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, 28 May 2024, at 9:27 PM, Ilpo J=C3=A4rvinen wrote:
> Hi,
>=20
> Hans, please check my question below.
>=20
> On Tue, 28 May 2024, Luke D. Jones wrote:
>=20
> > Exposes the WMI functions for enable/disable of performance and
> > efficiency cores on some laptop models (largely Intel only).
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
>=20
> > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Doc=
umentation/ABI/testing/sysfs-platform-asus-wmi
> > index 3b4eeea75b7b..ac881e72e374 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > @@ -226,3 +226,22 @@ Description:
> >  Set panel to UHD or FHD mode
> >  * 0 - UHD,
> >  * 1 - FHD
> > +
> > +What: /sys/devices/platform/<platform>/cores_enabled
> > +Date: Jun 2024
> > +KernelVersion: 6.11
> > +Contact: "Luke Jones" <luke@ljones.dev>
> > +Description:
> > + Enable/disable efficiency and performance cores. The format is
> > + 0x[E][P] where [E] is the efficiency core count, and [P] is
> > + the perfromance core count. If the core count is a single digit
>=20
> performance
>=20
> > + it is preceded by a 0 such as 0x0406; E=3D4, P=3D6, 0x1006; E=3D10=
, P=3D6
> > +
> > +What: /sys/devices/platform/<platform>/cores_max
> > +Date: Jun 2024
> > +KernelVersion: 6.11
> > +Contact: "Luke Jones" <luke@ljones.dev>
> > +Description:
> > + Show the maximum performance and efficiency core countin format
> > + 0x[E][P] where [E] is the efficiency core count, and [P] is
> > + the perfromance core count.
>=20
> performance
>=20
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index 4b045f1828f1..f62a36dfcd4b 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -815,6 +815,46 @@ static ssize_t panel_fhd_store(struct device *d=
ev,
> >  WMI_SIMPLE_SHOW(panel_fhd, "%d\n", ASUS_WMI_DEVID_PANEL_FHD);
> >  static DEVICE_ATTR_RW(panel_fhd);
> > =20
> > +/* Efficiency and Performance core control ************************=
**********/
> > +static ssize_t cores_enabled_store(struct device *dev,
> > +     struct device_attribute *attr,
> > +     const char *buf, size_t count)
> > +{
> > + struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > + int result, err;
> > + u32 cores, max;
> > +
> > + result =3D kstrtou32(buf, 16, &cores);
> > + if (result)
> > + return result;
> > +
> > + err =3D asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_CORES_MAX, &max=
);
> > + if (err < 0)
> > + return err;
> > +
> > + if (cores > max) {
>=20
> This only checks one part of it and the P part can contain whatever=20
> garbage as long as E is small enough?
>=20
> But I'm not sure if it's good idea to have these two changed through t=
he=20
> same sysfs file, I'm leaning more on that it would be better to split =
the=20
> interface for P and E.
>=20
> Hans, what you think about this?

I'm inclined to agree. It's no issue to change it.

Ack all reviews. I'll work through them over the week but with a lower p=
riority while I await both yours and Hans response in other replies with=
 Mario regarding the firmware_attributes change/use.

>=20
> > + pr_warn("Core count 0x%x exceeds max: 0x%x\n", cores, max);
> > + return -EIO;
> > + }
> > +
> > + err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_CORES_SET, cores, &re=
sult);
> > + if (err) {
> > + pr_warn("Failed to set cores_enabled: %d\n", err);
> > + return err;
> > + }
> > +
> > + pr_info("Enabled core count changed, reboot required\n");
> > + sysfs_notify(&asus->platform_device->dev.kobj, NULL, "cores_enable=
d");
> > +
> > + return count;
> > +}
>=20
> > @@ -4131,6 +4173,9 @@ static umode_t asus_sysfs_is_visible(struct ko=
bject *kobj,
> >  devid =3D ASUS_WMI_DEVID_PANEL_OD;
> >  else if (attr =3D=3D &dev_attr_panel_fhd.attr)
> >  devid =3D ASUS_WMI_DEVID_PANEL_FHD;
> > + else if (attr =3D=3D &dev_attr_cores_enabled.attr
> > + || attr =3D=3D &dev_attr_cores_max.attr)
>=20
> Wrong alignment.
>=20
> --=20
> i.
>=20
>=20

