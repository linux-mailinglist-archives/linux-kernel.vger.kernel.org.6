Return-Path: <linux-kernel+bounces-420814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B059D8349
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDA8161126
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F381917F9;
	Mon, 25 Nov 2024 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SVGPM0Fk"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083C2AD17
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530312; cv=none; b=NsyzWjCkfrCfDlFltvDm56lPRdFiiq7KkfYFf9CABNzOUiWWipseiDDRMxwPrfYKA1XGsISjIUMR/EwXuQ6rOzCYbZmCgl4N9hma3HPgXDlCAFHtWel5Eu2y51smuf2qwV8737KtIQQD4J8mhSjsOD4XTWEbd3PG3Nhk4fKiHAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530312; c=relaxed/simple;
	bh=QEPqafNo/oL9BVdZbdczy8x6PAT54tVxxJaH/BbS1SQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AxJsGLHiLXiKkwzRzS5EmGmsJt8KDCvrgjfbiNWKk3cSs/aU/xnZcE2PWoME7W70iSJsNpyX5DFnkPgTaJyEdw+bS5nRIZYLqkTAqqCJFUugxR+Tfi0j043yQOWqQX8idQjSgq5aKKAcwJzIeK3yL/MMdWtSgbNTB2YMAmNqMPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SVGPM0Fk; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60A19C0012;
	Mon, 25 Nov 2024 10:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732530301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJJFpfF2OaBan+++5E0ZDBr6mIOGHUerMQJqN74GXvA=;
	b=SVGPM0Fkf3Je9uOmJuAfKaWk/Z/L79pGzHVJFyTxZYZYE/uFuv8NJxGUGbf2MEEC2I6ftd
	HGAx3lcL33gS1dqZEUfHjDBB6Kz5RDg2tmI/5+7G+veNIDfbBt8EZW7qiOukIRCiSxMvai
	D9z/DhyYq2GD4uVDVBikfRltNCeTL1zp30yG2e2Tx4HwdY7csNn+wIhqcbGiDAzWoX5zfV
	QxhsGsy8IX4B+9WFE3FCplLgZhF9P0hN0idH8Jb/bd1ko9sCGxTYfgoa5vi/eRUb8RyTqw
	5RRRduY1qmkRHiVNz1ngW+RMDwUVqHE3KkB/2R0U0ljvI3cQjMupVe0SEjADuQ==
Date: Mon, 25 Nov 2024 10:19:49 +0000
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 =?ISO-8859-1?Q?Ma=EDra_Canal?= <mairacanal@riseup.net>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>
CC: arthurgrillo@riseup.net, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, seanpaul@google.com,
 nicolejadeyee@google.com, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_v2_17/18=5D_drm/vkms=3A_?=
 =?US-ASCII?Q?Introduce_config_for_connector_EDID?=
In-Reply-To: <87o723y7dr.fsf@intel.com>
References: <20241122-google-remove-crtc-index-from-parameter-v2-0-81540742535a@bootlin.com> <20241122-google-remove-crtc-index-from-parameter-v2-17-81540742535a@bootlin.com> <87o723y7dr.fsf@intel.com>
Message-ID: <6913165B-FA17-4DED-B1D6-CA312B20576B@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: louis.chauvet@bootlin.com



Le 25 novembre 2024 09:45:04 UTC, Jani Nikula <jani=2Enikula@linux=2Eintel=
=2Ecom> a =C3=A9crit=C2=A0:
>On Fri, 22 Nov 2024, Louis Chauvet <louis=2Echauvet@bootlin=2Ecom> wrote:
>> To properly test the EDID reading without using the DRM override, add a=
n
>> option to configure the EDID for a connector=2E
>>
>> Signed-off-by: Louis Chauvet <louis=2Echauvet@bootlin=2Ecom>
>> ---
>>  drivers/gpu/drm/vkms/vkms_config=2Ec |  1 +
>>  drivers/gpu/drm/vkms/vkms_config=2Eh |  2 ++
>>  drivers/gpu/drm/vkms/vkms_output=2Ec | 37 ++++++++++++++++++++++++++++=
++++++---
>>  3 files changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vkms/vkms_config=2Ec b/drivers/gpu/drm/vkm=
s/vkms_config=2Ec
>> index ac1a9658c5075c118d59da965ca3392355ccb2b2=2E=2E1a1234d4f10fa8e5ea6=
bd649139ecc10c991f875 100644
>> --- a/drivers/gpu/drm/vkms/vkms_config=2Ec
>> +++ b/drivers/gpu/drm/vkms/vkms_config=2Ec
>> @@ -199,6 +199,7 @@ struct vkms_config_connector *vkms_config_create_co=
nnector(struct vkms_config *v
>>  	xa_init_flags(&vkms_config_connector->possible_encoders, XA_FLAGS_ALL=
OC);
>>  	vkms_config_connector->type =3D DRM_MODE_CONNECTOR_VIRTUAL;
>>  	vkms_config_connector->status =3D connector_status_unknown;
>> +	vkms_config_connector->edid_blob_len =3D 0;
>> =20
>>  	return vkms_config_connector;
>>  }
>> diff --git a/drivers/gpu/drm/vkms/vkms_config=2Eh b/drivers/gpu/drm/vkm=
s/vkms_config=2Eh
>> index bba56c9d8aeceac97a4339ef42ab663c5dc54e65=2E=2E1220b16f6c98d1ebb0a=
e55d662a84fe25e1a6a02 100644
>> --- a/drivers/gpu/drm/vkms/vkms_config=2Eh
>> +++ b/drivers/gpu/drm/vkms/vkms_config=2Eh
>> @@ -112,6 +112,8 @@ struct vkms_config_connector {
>>  	struct xarray possible_encoders;
>>  	int type;
>>  	enum drm_connector_status status;
>> +	char edid_blob[PAGE_SIZE];
>> +	int edid_blob_len;
>> =20
>>  	/* Internal usage */
>>  	struct drm_connector *connector;
>> diff --git a/drivers/gpu/drm/vkms/vkms_output=2Ec b/drivers/gpu/drm/vkm=
s/vkms_output=2Ec
>> index fc6a0cdade0739b94820ed4e0924cf355137fe79=2E=2E56590afb33d75465971=
d10a282040690840cdbee 100644
>> --- a/drivers/gpu/drm/vkms/vkms_output=2Ec
>> +++ b/drivers/gpu/drm/vkms/vkms_output=2Ec
>> @@ -31,13 +31,44 @@ static const struct drm_connector_funcs vkms_connec=
tor_funcs =3D {
>>  	=2Eatomic_destroy_state =3D drm_atomic_helper_connector_destroy_state=
,
>>  };
>> =20
>> +static int vkms_connector_read_block(void *context, u8 *buf, unsigned =
int block, size_t len)
>> +{
>> +	struct vkms_config_connector *config =3D context;
>> +
>> +	if (block * len + len > config->edid_blob_len)
>
>The parameters to the read block function are a bit weird for historical
>reasons=2E The start offset is indicated by block number, length by
>len=2E The start byte offset is thus block * EDID_LENGTH! There's no
>smaller granularity for start offset=2E However len can be < EDID_LENGTH!
>
>So the above should be (block * EDID_LENGTH + len > edid_blob_len)
>
>> +		return 1;
>> +	memcpy(buf, &config->edid_blob[block * len], len);
>
>And this should be &config->edid_blob[block * EDID_LENGTH]=2E
>
>(Your patch would work, but just by coincidence due to the way the read
>block function is currently called=2E)

Thanks for those clarifications!=20

>> +	return 0;
>> +}
>> +
>>  static int vkms_conn_get_modes(struct drm_connector *connector)
>>  {
>> +	const struct drm_edid *drm_edid =3D NULL;
>>  	int count;
>> +	struct vkms_config_connector *connector_cfg;
>> +	struct vkms_device *vkmsdev =3D drm_device_to_vkms_device(connector->=
dev);
>> +	struct vkms_config_connector *context =3D NULL;
>> +
>> +	list_for_each_entry(connector_cfg, &vkmsdev->config->connectors, link=
) {
>> +		if (connector_cfg->connector =3D=3D connector) {
>> +			context =3D connector_cfg;
>> +			break;
>> +		}
>> +	}
>> +	if (context)
>> +		drm_edid =3D drm_edid_read_custom(connector, vkms_connector_read_blo=
ck, context);
>
>Thanks for using drm_edid_read_custom() for this btw!
>
>> +
>> +	/*
>> +	 * Unconditionally update the connector=2E If the EDID was read
>> +	 * successfully, fill in the connector information derived from the
>> +	 * EDID=2E Otherwise, if the EDID is NULL, clear the connector
>> +	 * information=2E
>> +	 */
>> +	drm_edid_connector_update(connector, drm_edid);
>> +
>> +	count =3D drm_edid_connector_add_modes(connector);
>> =20
>> -	/* Use the default modes list from DRM */
>> -	count =3D drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
>> -	drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
>
>I don't really know anything about your use case, but don't you want to
>fall back to the above for drm_edid =3D=3D NULL? *shrug*

You are right, I will probably fallback to noedid version, at least for VI=
RTUAL connectors=2E

Or maybe I will add something in VKMS configuration to use "empty edid", "=
default modes_noedid" or "custom_edid"=2E

This way you will be able to test all the scenarios for your userspace=2E

Thanks for your review,
Louis Chauvet

>BR,
>Jani=2E
>
>> +	drm_edid_free(drm_edid);
>> =20
>>  	return count;
>>  }
>

