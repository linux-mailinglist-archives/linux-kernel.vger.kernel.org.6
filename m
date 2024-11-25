Return-Path: <linux-kernel+bounces-420772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ECC9D82F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE438282EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D15191F94;
	Mon, 25 Nov 2024 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TO9X7ZIj"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619CB18F2E2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528624; cv=none; b=D/uvnXIDwFXMKE5mQxwYspt8m4XvsEJBKb9PvmLZZnY8mTRTbroJ1/S+0sxHcBxymzt0+9G1ETJyFQy8wIva+sfkJ48WfaVIU9ruNkS1tR1qLVQS+rUzcl+/IXmmVhm3W3cRS8/U8uf3Fmg/B5IYHZOX0nNnSGNYQOFdtgTHV1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528624; c=relaxed/simple;
	bh=l0jR/NITfiqNey1d38dsrLHY6+72et0wn8dCSRdtVL0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=biRvqhma9cLAbH+gra98YBo0tXGtJPS9jN7BLa58nRDDe9E+oDZ18UkfwiqklRmxlcwTTojm9Xw8O29NDBlbUlb7McXt2I+aVLSr50XB8/9YKnR7L2zecDnmidjuQ/e9mZ3nZYwKhWwi5PaQnl0XpSSD6jj8DT77nRj6kg6etEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TO9X7ZIj; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 7E602C10E7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:50:15 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A83481C000C;
	Mon, 25 Nov 2024 09:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732528208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jqZBXXpYqlZ47ruOLuRIl9U+AjdNaJHZhWEuBmxnpx4=;
	b=TO9X7ZIjxELNyehRFohEvZu5Ytg4Orkmwagi8FV3r9FnxdqYF495c70sCD3W3/8+OeG/pI
	Kzc2tCscyRjUfmXzzL+Nnna+IOP7AAwHDMCyJFNnRgqJeosB3788l5ESCunMLd1tnNsQ/v
	M4RrHbGEVD10+8A4pW01fCq8ESW1VMz7uiyHmZktOTo6o7gjZaZaJwgsvjmy7cJ+2QW0/H
	7oAzP7NKHf6dtg1LDs+xLJuj5x3lKbU9UNw3Jp+Vgsohc2HjgCkyEwgmFOAEQWxwQS2NJG
	VTHMFK2d6fjFoE70ad2L7fMeVzsDh/oAjMjZhXTCpVmjm9D0YBP02DXICYBUgg==
Date: Mon, 25 Nov 2024 09:50:01 +0000
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
Subject: Re: [PATCH RFC v2 10/18] drm/vkms: Introduce config for encoder name
In-Reply-To: <87ttbvy84z.fsf@intel.com>
References: <20241122-google-remove-crtc-index-from-parameter-v2-0-81540742535a@bootlin.com> <20241122-google-remove-crtc-index-from-parameter-v2-10-81540742535a@bootlin.com> <87ttbvy84z.fsf@intel.com>
Message-ID: <65C56D17-EDFE-42E6-A8E0-57DEFF577886@bootlin.com>
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



Le 25 novembre 2024 09:28:44 UTC, Jani Nikula <jani=2Enikula@linux=2Eintel=
=2Ecom> a =C3=A9crit=C2=A0:
>On Fri, 22 Nov 2024, Louis Chauvet <louis=2Echauvet@bootlin=2Ecom> wrote:
>> As an encoder will be a directory in ConfigFS, add the configuration fo=
r
>> encoder name so we will be able to reflect the configfs directory name =
in
>> the drm name=2E
>>
>> Signed-off-by: Louis Chauvet <louis=2Echauvet@bootlin=2Ecom>
>> ---
>>  drivers/gpu/drm/vkms/vkms_config=2Ec | 6 ++++++
>>  drivers/gpu/drm/vkms/vkms_config=2Eh | 2 ++
>>  drivers/gpu/drm/vkms/vkms_output=2Ec | 2 +-
>>  3 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/vkms/vkms_config=2Ec b/drivers/gpu/drm/vkm=
s/vkms_config=2Ec
>> index e44ed904cefb97b8b6ab8fc27623e315397e0106=2E=2Ea2539fb56b602569b75=
748fdf9c4784f104b0bff 100644
>> --- a/drivers/gpu/drm/vkms/vkms_config=2Ec
>> +++ b/drivers/gpu/drm/vkms/vkms_config=2Ec
>> @@ -41,6 +41,10 @@ struct vkms_config *vkms_config_alloc_default(bool e=
nable_writeback, bool enable
>>  	encoder =3D vkms_config_create_encoder(vkms_config);
>>  	if (!encoder)
>>  		goto err_alloc;
>> +	encoder->name =3D kzalloc(sizeof("Main Encoder"), GFP_KERNEL);
>> +	if (!encoder->name)
>> +		goto err_alloc;
>> +	sprintf(encoder->name, "Main Encoder");
>
>Drive-by comment, maybe kstrdup()?

Nice catch, thank you!
I will update for next version=2E

Thanks,
Louis Chauvet

>> =20
>>  	if (vkms_config_encoder_attach_crtc(encoder, crtc))
>>  		goto err_alloc;
>> @@ -238,6 +242,7 @@ void vkms_config_delete_encoder(struct vkms_config_=
encoder *vkms_config_encoder,
>>  		}
>>  	}
>> =20
>> +	kfree(vkms_config_encoder->name);
>>  	kfree(vkms_config_encoder);
>>  }
>> =20
>> @@ -403,6 +408,7 @@ static int vkms_config_show(struct seq_file *m, voi=
d *data)
>> =20
>>  	list_for_each_entry(config_encoder, &vkmsdev->config->encoders, link)=
 {
>>  		seq_puts(m, "encoder:\n");
>> +		seq_printf(m, "\tname: %s\n", config_encoder->name);
>>  	}
>> =20
>>  	list_for_each_entry(config_crtc, &vkmsdev->config->crtcs, link) {
>> diff --git a/drivers/gpu/drm/vkms/vkms_config=2Eh b/drivers/gpu/drm/vkm=
s/vkms_config=2Eh
>> index 8f247fc09373fb2c8145e83be05c6afec1ffac1c=2E=2E4223edd94ec270915dd=
658c0b5efd489554d33a5 100644
>> --- a/drivers/gpu/drm/vkms/vkms_config=2Eh
>> +++ b/drivers/gpu/drm/vkms/vkms_config=2Eh
>> @@ -50,6 +50,7 @@ struct vkms_config_crtc {
>>   * struct vkms_config_encoder
>>   *
>>   * @link: Link to the others encoders
>> + * @name: Name of the encoder
>>   * @possible_crtcs: List of CRTC that can be used with this encoder
>>   * @encoder: Internal usage=2E This pointer should never be considered=
 as valid=2E It can be used to
>>   *         store a temporary reference to a vkms encoder during device=
 creation=2E This pointer is
>> @@ -58,6 +59,7 @@ struct vkms_config_crtc {
>>  struct vkms_config_encoder {
>>  	struct list_head link;
>> =20
>> +	char *name;
>>  	struct xarray possible_crtcs;
>> =20
>>  	/* Internal usage */
>> diff --git a/drivers/gpu/drm/vkms/vkms_output=2Ec b/drivers/gpu/drm/vkm=
s/vkms_output=2Ec
>> index 03498a20d78dd8a66f9fc66b360c5ea57fc48d88=2E=2E6277ad72fdd476d1eff=
52ad037389bdb1a254f5e 100644
>> --- a/drivers/gpu/drm/vkms/vkms_output=2Ec
>> +++ b/drivers/gpu/drm/vkms/vkms_output=2Ec
>> @@ -92,7 +92,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>>  		if (!config_encoder->encoder)
>>  			return -ENOMEM;
>>  		ret =3D drmm_encoder_init(dev, config_encoder->encoder, NULL,
>> -					DRM_MODE_ENCODER_VIRTUAL, NULL);
>> +					DRM_MODE_ENCODER_VIRTUAL, config_encoder->name);
>>  		if (ret) {
>>  			DRM_ERROR("Failed to init encoder\n");
>>  			return ret;
>

