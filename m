Return-Path: <linux-kernel+bounces-530546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE512A434FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A7F1899E27
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAB8256C7D;
	Tue, 25 Feb 2025 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="Fqj4ChlC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e1LoKoWI"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B405256C68;
	Tue, 25 Feb 2025 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464020; cv=none; b=JV8h8M39lW0mv7DhBES/6wKqIWG6rnNpXzBcQJbNq59ydJyRxizbAx5McZlHk2roiaRAd+t+P60QIU1PvZY3EaJ58dkhEJhJsmISVjwq9qWbneX2Hwc49PUcuZ4T9uN3+fTiEvaZMEdUbY2KDkkRh0DbEmISQDYwCaG5leThFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464020; c=relaxed/simple;
	bh=0bNrTd+0Kri939AjowYkwp5sI3m8I9so+4v3iNbKFNc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MylY6py2i3wyJjoKwd3I2D9lBLFUTDzIxgT4s7jgLEGCEByQE/uDIzZD3Lv4CljwEQvCzv1obXIviVvGdWL+QZaiVOPIamFSEMFRsNsUd4BHiT77soELOCs0LAlFXCS2noJ5mcM82Q3bZdAZ83heW71jm21SWyHhjoR/BWeK5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=Fqj4ChlC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e1LoKoWI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2587113816C4;
	Tue, 25 Feb 2025 01:13:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 25 Feb 2025 01:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740464016;
	 x=1740550416; bh=66pDvVk6+iDQJbtSXtpwsgbq4SfVodI4UVwSnweQfZ4=; b=
	Fqj4ChlCV6CGNNn0iS4msDiYQ+4+GvJYES/bix1GYkljSYFBzOLSENl5a4xV8xfi
	/kvSAiqPZdlL4h4cCU4WspxzvkAClTu3ITfIeZOJSsdZzkW8aN6/sTgZHKHjeZBc
	s8sF+AXRm6PKI0uMiA3AoxzjZbyM2/uCFPYf87iFGw8TeBXhLIIinbxHuN2NxtRT
	Qg+7OmkNE08QpAaWXM074DdKjVCPgv+qLizEjPu2XNs3P2YQFhcTboeA+DB1FDlc
	mIflIbi5Q8IhpKSXjW0APJhFcIieeMKTiEohQ5B7Cq2gfA4QqySPLkWLgYSZTkLL
	og9BiHo3ArdkI3cH6Ei4rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740464016; x=
	1740550416; bh=66pDvVk6+iDQJbtSXtpwsgbq4SfVodI4UVwSnweQfZ4=; b=e
	1LoKoWIiSoMw2FFxNGrUxCEcXKyxI90SWeuEZZ1Zt9Rd0P12Qv1RPLdu906UX0BE
	iMPRW/zkrTiW6Puq/fgBfsi1oyyzwXnGH5loRuEp5ScVFCKv3iW4lgE1jvVJXrjT
	2ClCzP7iNUSiydBevhWsJHFWkKPJR3exS7SIEu57soKHRLcQjG9khl4jWIlWk5wd
	F8cPuwE9b9yPWeaQVxssnIJmyIEFfYi0XBvPWQq0EiKRArEAyRIifyTCgiYARrrV
	JR4M1Acg0EKg+LEXNrlxAJSgtOMeH+juRmt5R51vXSxaFtOAFKKk/Iq0OATlA+oQ
	sxSkqH8GkUlEsvRbspFqw==
X-ME-Sender: <xms:j1-9Z3Bz5Fxt4lGOsdVaBNttyE9O7CSPvTfyvgYXhiiyaSYAX0kaPw>
    <xme:j1-9Z9jiMaBrAanuNvJdT9cros7R6u7phBKcruChjsF96Fj_sjIs1H_NTarY0vJjV
    OleacGE3BJGmvEkD4c>
X-ME-Received: <xmr:j1-9Zyn-i20TFebVjb5013k1IyNtdN8CTs7KarOxzdP6o-gDGUrgRNKAc2WAbr3Cn2niS5xt2xk4SP7s9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttder
    jeenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvh
    eqnecuggftrfgrthhtvghrnhepkeefffeujeevueejueegleelhedtgedvledukedttdff
    hfeifeelvdduheefjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlh
    hlohesrghmugdrtghomhdprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdig
    keeisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgvnhhtihhnrd
    gthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrd
    hinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j1-9Z5x5o4sAMjF9hDDrRHGya6_sQ4H_EpZk6FdAcaGfZTyQjdl6hQ>
    <xmx:kF-9Z8Sz8POeMpYxl4tMpcynCIuqLA6MyhlJSvvQoqoGqDuvyo_gyA>
    <xmx:kF-9Z8Y-lVDcHP_SE2ZXg9a1Ji6sOCDCWoqagwayjQfLqAb-UMf_lw>
    <xmx:kF-9Z9QvF2srdtSlt8ASmMdOVbelwn128eJPxq1XwG8PSLPM9iPYzg>
    <xmx:kF-9ZxJ40EA_2UhlkPz5GbUS5cd2RhwGKKP8KzVEFl35dAwPnTB4epCV>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 01:13:33 -0500 (EST)
Message-ID: <0d67e31ce334085b815f79f9c57a2c4e35870423.camel@ljones.dev>
Subject: Re: [PATCH] platform/x86: asus-wmi: change quiet to low-power
From: Luke Jones <luke@ljones.dev>
To: Mario Limonciello <mario.limonciello@amd.com>, 
	platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Date: Tue, 25 Feb 2025 19:13:29 +1300
In-Reply-To: <7a958091-84a0-4ec5-bd4a-3e5f973772e0@amd.com>
References: <20250224223551.16918-1-luke@ljones.dev>
	 <7a958091-84a0-4ec5-bd4a-3e5f973772e0@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 18:39 -0800, Mario Limonciello wrote:
> On 2/24/2025 16:35, Luke Jones wrote:
> > From: "Luke D. Jones" <luke@ljones.dev>
> >=20
> > Change the profile name "quiet" to "low-power" to match the AMD
> > name. The
> > primary reason for this is to match AMD naming for
> > platform_profiles and
> > allow both to match. It does not affect Intel machines.
> >=20
> > The quiet profile is essentially a low-power profile which tweaks
> > both TDP and fans - this applies to 80+ ASUS laptops.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
>=20
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>=20
> IMO - this should have a fixes tag since this should probably go in
> the=20
> 6.14 cycle too.
>=20
> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple
> handlers")
>=20

Good point, thanks. I assume when pulled in this can be added?

> > ---
> > =C2=A0 drivers/platform/x86/asus-wmi.c | 6 +++---
> > =C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/asus-wmi.c
> > b/drivers/platform/x86/asus-wmi.c
> > index d22748f1e154..de19c3b3d8fb 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -3945,7 +3945,7 @@ static int
> > asus_wmi_platform_profile_get(struct device *dev,
> > =C2=A0=C2=A0		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> > =C2=A0=C2=A0		break;
> > =C2=A0=C2=A0	case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> > -		*profile =3D PLATFORM_PROFILE_QUIET;
> > +		*profile =3D PLATFORM_PROFILE_LOW_POWER;
> > =C2=A0=C2=A0		break;
> > =C2=A0=C2=A0	default:
> > =C2=A0=C2=A0		return -EINVAL;
> > @@ -3969,7 +3969,7 @@ static int
> > asus_wmi_platform_profile_set(struct device *dev,
> > =C2=A0=C2=A0	case PLATFORM_PROFILE_BALANCED:
> > =C2=A0=C2=A0		tp =3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > =C2=A0=C2=A0		break;
> > -	case PLATFORM_PROFILE_QUIET:
> > +	case PLATFORM_PROFILE_LOW_POWER:
> > =C2=A0=C2=A0		tp =3D ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> > =C2=A0=C2=A0		break;
> > =C2=A0=C2=A0	default:
> > @@ -3982,7 +3982,7 @@ static int
> > asus_wmi_platform_profile_set(struct device *dev,
> > =C2=A0=20
> > =C2=A0 static int asus_wmi_platform_profile_probe(void *drvdata,
> > unsigned long *choices)
> > =C2=A0 {
> > -	set_bit(PLATFORM_PROFILE_QUIET, choices);
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> > =C2=A0=C2=A0	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> > =C2=A0=C2=A0	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> > =C2=A0=20
>=20


