Return-Path: <linux-kernel+bounces-253652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342CD932459
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70241F2172A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4297A198E75;
	Tue, 16 Jul 2024 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="brPDGIEw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rk6tIhpX"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC621C68C;
	Tue, 16 Jul 2024 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126922; cv=none; b=aBVcZd40yJdibD6Zgtywzo73A477wH3vlKfYmFWjbipIYr3kpDkKJt9eXkDK13yUDwBxeaEk1sYY+34sgbRKXHzd8LV9IxEXEtv+0fWiuLwvSyLk1/Vb/ffXco5og2u8xFPg2WWvZZgdjrkfAmXE8mwy+eAUd+44ZeiYhgIuZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126922; c=relaxed/simple;
	bh=vxb8fujrmulzBliMHJSFSkDTVtyU+U8eaP4eG/fhmM8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dnqvZoV/gFqhbTlMUxwCR9c7Y3hQeX31QprgCZvTjwkzGQz4UloJCh4nknJ3o6itSyr7+3wNE0TT5MbCbNrYxTmhz9deg3QY4NSPxypQNnpDaT8QJjSrhv5yAa4QFz0HXQO7TKTA9fb4lRMPepFIjF2xthHmQot9Cu5gGpDtLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=brPDGIEw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rk6tIhpX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CA0E911482FE;
	Tue, 16 Jul 2024 06:48:39 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Tue, 16 Jul 2024 06:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1721126919;
	 x=1721213319; bh=eLyOA6YOUXpYdPPvWopuMfNTUy73XMV5CrsQCvSxqNA=; b=
	brPDGIEwNHF12ggREho1/324zFOsdRrNW4gfjqzPiZaKNmqFJia9gZyi9VNGN446
	a99k+8aVomskKKMSwVTX0W1RDlEbOi8HiW84ycha+HX3tbZK5yIjULbZ+nWPLNH5
	GF2vv5Ji+ib2VzvKNArQzeNGgyfvFgLykUWbsBaphLJrlrab6rHx2N6UjNRzlLTH
	IJL7NeRNN9gVGsj7w23O8CxD1tpBIoU1N44iY2h9eKOrkuwN9P+7bsGO1o1fmvUA
	qDJJLRfSDW1aXjKhRFdg717F61G+0u0Cr195eQB05oMCMemx0PiOXdIA/ODD9v7M
	hjI7bA059qXP6uDGaf7xqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721126919; x=
	1721213319; bh=eLyOA6YOUXpYdPPvWopuMfNTUy73XMV5CrsQCvSxqNA=; b=R
	k6tIhpX4ARciT9eyTcztS0XympFppDvXdPJjE45vqHZyPOeDqo5fqOxHsWELhRyx
	MAhmQI84bhZk6SVsMJ3ukGt7GPs/vTMFy5BHSEK4VQnyEO0dGsHEodTLpyiprY4u
	WuhJr9cj4/pyzK5kx754En7F34bneQgXVhAHcxF/Q/OKvzwwjp6D0MCZJt+n9PWr
	FGqRfjKS6ydzoy/nqQS1X5O1oPVrGxzen83zoqhdHKPQMktTkHfLI2V4WbudCC9b
	W8umdzkC0bnEX7E5LyikuMW0nYJ9KJzxmhWhDtdOWXpvpbGqYtZl9Bn8HE52cSqS
	ZZUmI2RRNxCgkI57aYUkg==
X-ME-Sender: <xms:BlCWZj2AeCm-M3oJ3yXFU507riH7m5EI5K5LjsoDIC8gZjl9-HhOFQ>
    <xme:BlCWZiGEt1Ho1m5VdTw5nSVBLgNMqM4HZMNm3hdgshQdn3wWrdbZNNoHkaiOu2LKe
    Y3Vox9WMb_3sLb_iqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpeefuefghfdvueefheeiledvgeefffevgeelhedtvdehgeekteeugedtgeeuhedv
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:BlCWZj5ApQ_6YR8RFdihr3hmO8XeHzB07afwdH-3Y47aZ5qIVDzd2g>
    <xmx:BlCWZo16H2ODehmtJAJG0qS2seimcAkKHUGH9RkyJBx5om5zv_nmxw>
    <xmx:BlCWZmGgwfh7IzWhH5s4ReZuOu12KHXb0wrlbsXjF1Yo9kw2VoM22A>
    <xmx:BlCWZp8L21j8IB9iCtQbSLtKHhA1LZVe1fYFpNHTKH6O5KJbb84RzA>
    <xmx:B1CWZigbZriKqdVd_x6EfKgvfZ4Kgd-hQn_rlVH4DAyGt2e0ZjrLrIff>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7BB3D2340080; Tue, 16 Jul 2024 06:48:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f401fd68-c5e6-4c97-ab82-400141c42cd7@app.fastmail.com>
In-Reply-To: <9123108d-cb50-43bb-b7ff-0327fb760a89@redhat.com>
References: <20240716051612.64842-1-luke@ljones.dev>
 <20240716051612.64842-2-luke@ljones.dev>
 <9123108d-cb50-43bb-b7ff-0327fb760a89@redhat.com>
Date: Tue, 16 Jul 2024 22:48:18 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Hans de Goede" <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Mario Limonciello" <mario.limonciello@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] platform/x86 asus-bioscfg: move existing tunings to
 asus-bioscfg module
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jul 2024, at 9:50 PM, Hans de Goede wrote:
> Hi Luke,
>=20
> On 7/16/24 7:16 AM, Luke D. Jones wrote:
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
> > /sys/class/firmware-attributes/asus-bioscfg/attributes/dgpu_disable/
> > =E2=94=9C=E2=94=80=E2=94=80 current_value
> > =E2=94=9C=E2=94=80=E2=94=80 display_name
> > =E2=94=9C=E2=94=80=E2=94=80 possible_values
> > =E2=94=94=E2=94=80=E2=94=80 type
> >=20
> > as do other attributes.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
>=20
> Interesting (also see my reply to the cover-letter).
>=20
> Note this is not a full review, just a few small remarks
> with things which I noticed while taking a quick look.
>=20
> <snip>
>=20
> > +static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
> > +{
> > + return !strcmp(attr->attr.name, "gpu_mux_mode");
> > + !strcmp(attr->attr.name, "panel_hd_mode");
> > +}
>=20
> The second statement here is never reached, I believe you want
> a || between the 2 strcmp() calls:
>=20
> static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
> {
> return !strcmp(attr->attr.name, "gpu_mux_mode") ||
>        !strcmp(attr->attr.name, "panel_hd_mode");
> }
>=20
> <snip>
>=20
> > +/* Simple attribute creation */
>=20
> I think it would be good to do the following for registering
> these "simple" attributes ... continued below.
>=20
> > +ATTR_GROUP_ENUM_INT_RW(thermal_policy, "thermal_policy", ASUS_WMI_D=
EVID_THROTTLE_THERMAL_POLICY,
> > + 0, 3, "0;1;2", "Set the thermal profile: 0=3Dnormal, 1=3Dperforman=
ce, 2=3Dquiet");
> > +ATTR_GROUP_PPT_RW(ppt_pl2_sppt, "ppt_pl2_sppt", ASUS_WMI_DEVID_PPT_=
PL2_SPPT,
> > + cpu_default, 5, cpu_max, 1, "Set the CPU fast package limit");
> > +ATTR_GROUP_PPT_RW(ppt_apu_sppt, "ppt_apu_sppt", ASUS_WMI_DEVID_PPT_=
APU_SPPT,
> > + platform_default, 5, platform_max, 1, "Set the CPU slow package li=
mit");
> > +ATTR_GROUP_PPT_RW(ppt_platform_sppt, "ppt_platform_sppt", ASUS_WMI_=
DEVID_PPT_PLAT_SPPT,
> > + platform_default, 5, platform_max, 1, "Set the CPU slow package li=
mit");
> > +ATTR_GROUP_PPT_RW(ppt_fppt, "ppt_fppt", ASUS_WMI_DEVID_PPT_FPPT,
> > + cpu_default, 5, cpu_max, 1, "Set the CPU slow package limit");
> > +
> > +ATTR_GROUP_PPT_RW(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DE=
VID_NV_DYN_BOOST,
> > + nv_boost_default, 5, nv_boost_max, 1, "Set the Nvidia dynamic boos=
t limit");
> > +ATTR_GROUP_PPT_RW(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_=
NV_THERM_TARGET,
> > + nv_temp_default, 75, nv_temp_max, 1, "Set the Nvidia max thermal l=
imit");
> > +
> > +ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_C=
HARGE_MODE,
> > + "0;1;2", "Show the current mode of charging");
> > +ATTR_GROUP_BOOL_RW(boot_sound, "boot_sound", ASUS_WMI_DEVID_BOOT_SO=
UND,
> > + "Set the boot POST sound");
> > +ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_M=
CU_POWERSAVE,
> > + "Set MCU powersaving mode");
> > +ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANE=
L_OD,
> > + "Set the panel refresh overdrive");
> > +ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_P=
ANEL_HD,
> > + "Set the panel HD mode to UHD<0> or FHD<1>");
> > +ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID=
_EGPU_CONNECTED,
> > + "Show the eGPU connection status");
>=20
> Create an array of simple attribute groups for this
> entire set of simple attributes:
>=20
> struct asus_attr_group {
> const struct attribute_group *attr_group;
> u32 wmi_devid;
> };
>=20
> static const struct asus_attr_group simple_attribute_groups[] =3D {
> { &thermal_policy_attr_group, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY },
> { &ppt_pl2_sppt_attr_group, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY },
> ...
> { &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
> };
>=20
> And then in asus_fw_attr_add() .. continued below:
>=20
> > +static int asus_fw_attr_add(void)
> > +{
> > + int ret;
> > +
> > + ret =3D fw_attributes_class_get(&fw_attr_class);
> > + if (ret)
> > + goto fail_class_created;
> > + else
> > + asus_bioscfg.fw_attr_dev =3D device_create(fw_attr_class, NULL,
> > + MKDEV(0, 0), NULL, "%s", DRIVER_NAME);
> > +
> > + if (IS_ERR(asus_bioscfg.fw_attr_dev)) {
> > + ret =3D PTR_ERR(asus_bioscfg.fw_attr_dev);
> > + goto fail_class_created;
> > + }
> > +
> > + asus_bioscfg.fw_attr_kset =3D kset_create_and_add("attributes", NU=
LL,
> > + &asus_bioscfg.fw_attr_dev->kobj);
> > + if (!asus_bioscfg.fw_attr_dev) {
> > + ret =3D -ENOMEM;
> > + pr_debug("Failed to create and add attributes\n");
> > + goto err_destroy_classdev;
> > + }
> > +
> > + /* Add any firmware_attributes required */
> > + ret =3D sysfs_create_file(&asus_bioscfg.fw_attr_kset->kobj, &pendi=
ng_reboot.attr);
> > + if (ret) {
> > + pr_warn("Failed to create sysfs level attributes\n");
> > + goto fail_class_created;
> > + }
> > +
> > + // TODO: logging
> > + asus_bioscfg.mini_led_dev_id =3D 0;
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE)) {
> > + asus_bioscfg.mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE;
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &mini_led_mod=
e_attr_group);
> > + } else if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE2)) {
> > + asus_bioscfg.mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE2;
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &mini_led_mod=
e_attr_group);
> > + }
> > +
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX)) {
> > + asus_bioscfg.gpu_mux_dev_id =3D ASUS_WMI_DEVID_GPU_MUX;
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &gpu_mux_mode=
_attr_group);
> > + } else if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX_VIVO)) {
> > + asus_bioscfg.gpu_mux_dev_id =3D ASUS_WMI_DEVID_GPU_MUX_VIVO;
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &gpu_mux_mode=
_attr_group);
> > + }
> > +
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU)) {
> > + asus_bioscfg.dgpu_disable_available =3D true;
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &dgpu_disable=
_attr_group);
> > + }
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU)) {
> > + asus_bioscfg.egpu_enable_available =3D true;
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &egpu_enable_=
attr_group);
> > + }
>=20
> Replace the block starting here and ending ...
>=20
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU_CONNECTED))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &egpu_connect=
ed_attr_group);
> > +
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &thermal_poli=
cy_attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PL1_SPL))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_pl1_spl_=
attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PL2_SPPT))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_pl2_sppt=
_attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_APU_SPPT))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_apu_sppt=
_attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PLAT_SPPT))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_platform=
_sppt_attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_FPPT))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_fppt_att=
r_group);
> > +
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_NV_DYN_BOOST))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &nv_dynamic_b=
oost_attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_NV_THERM_TARGET))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &nv_temp_targ=
et_attr_group);
> > +
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_CHARGE_MODE))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &charge_mode_=
attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_BOOT_SOUND))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &boot_sound_a=
ttr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_MCU_POWERSAVE))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &mcu_powersav=
e_attr_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PANEL_OD))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &panel_od_att=
r_group);
> > + if (asus_wmi_is_present(ASUS_WMI_DEVID_PANEL_HD))
> > + sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &panel_hd_mod=
e_attr_group);
>=20
> here, with:
>=20
> for (i =3D 0; i < ARRAY_SIZE(simple_attribute_groups); i++) {
> if (!asus_wmi_is_present(simple_attribute_groups[i].wmi_devid))
> continue;
>=20
> sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, simple_attribute_=
groups[i].attr_group);
> pr_dbg("Created sysfs-group for %s\n", simple_attribute_groups[i].attr=
_group->name);
> }
>=20
> This will make adding new simple attributes a matter of just:
>=20
> 1. Declaring the new attr using one of the macros
> 2. Adding it to simple_attribute_groups[]
>=20
> And this also takes care of you logging TODO for simple attributes
> without needing to add a ton of pr_debug() calls.

Ah perfect, this was one problem I ws trying to figure out a better way =
of doing. I'll have a crack at this after addressing all other concerns =
mentioned so far.

Cheers,
Luke.

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20

