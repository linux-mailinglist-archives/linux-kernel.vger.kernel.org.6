Return-Path: <linux-kernel+bounces-349411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19A798F58C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA3A1F24DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B621AAE1C;
	Thu,  3 Oct 2024 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tr+SM4F3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788451A76AB
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977696; cv=none; b=IxoyoTAjchUBecixrhZCXpxATUuvNrs0gyl37pdrPjhmMQBqiy/fyfwSLsVRS9bHT4oo/FEc8wiznh7uG4x0tKS32nQPuekYaxUkdLZLb4zx6MjEqiRe1gmPxzw3vbAjt7Tl/cY6oiNWKyNUrZFaEZnix3sTyu558nXSDTpPFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977696; c=relaxed/simple;
	bh=1Atha0vBPlz3ASMkcMVeInjgiEwnND5WbIednEfGvaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfFvWDy/vyjYeRXCykdyzQOegIkZc1WHvX59kZw4HUQo8DU+Pum9mwzxmUpPniIuVPHpX5RwccrWisTlZDmsF/6jrfMjuFs9pN3FrEgq+MbbPOugZPODKcKkYPEDif3sbafxqan8ZC1Ind/RGErivQAA+eo1p+5IEdzVlSUXJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tr+SM4F3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727977691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJlvHuDkFg4to1w3gK1SxyjzDAKplXT0LaEvspziFW8=;
	b=Tr+SM4F330n0Yb9LHgaOvGq7KMgc058dHhgERBLMhLUR0A+KoeAXwKhvRwZWv9Estioy00
	ZbxDx7q/5CUYWADCu4fSiCIcB/7xjR1sJuKboJmYw972ZmVh19o4naxZZ1dLJzmwR6KlZm
	907ClR2JHdhZvd8pCy5944yNvcHCAE0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-kzPy1eiLMJSHty0_n-XIqQ-1; Thu, 03 Oct 2024 13:48:08 -0400
X-MC-Unique: kzPy1eiLMJSHty0_n-XIqQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8a80667ad8so97790966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 10:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727977687; x=1728582487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJlvHuDkFg4to1w3gK1SxyjzDAKplXT0LaEvspziFW8=;
        b=jw+z5ILVAJFRHPr3kK6GLCNLtBPsralMVPbMXoQRwDYF7OgZWD+8tAObIEBTbM3Eg6
         mSLfXiyINlfYyupo8B/N3BWhCUMXqCF9efCMlw6FeYJr66PvB1NlD8UNdNvLq/CSWSvl
         hEC0fAJuYCZefSZhi5VG47Tej8r7tOAhdm5iZQozZBcIiTsaHUyOAOwOV/ukx7Ixfnc9
         nRH7nHYHcOCBM/S/dcfNrlYNe89YxoN+RihwLdQmk0CjFvdtllLzeRRBPq8Ou4HIhwCM
         TIvKDS1kPSJKmSMyEvRdhdniif0CaZaQK0kh8zxxCJWuOl6sYUZLGARPI7+7oL8YDiv8
         Xiag==
X-Forwarded-Encrypted: i=1; AJvYcCUi0DsPTmPgrVj77vxEcMwSivt6KbCSyG8Vgl9sU7gt0rF4kleeaArLj2skqSpaaHugxiCFpxj/ELn5JwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnKTIbng3hCQ89vVE79/zGUmAPG3J/jg7oxmR/zbTlf9LWBV10
	vhnYN1MusIoYQKks2aGt0gHNrARAPul8QtmFGY+6wNOwrzisiN8brflaskF9KWthwpCzke1UyaX
	vVswOjfqhqi1xrTvbYN6a004c11h/OLoPQgZV5GS++mAdIqOW/xOD6qxyBZ3PzQ==
X-Received: by 2002:a17:907:60c9:b0:a7a:a212:be4e with SMTP id a640c23a62f3a-a991bd139b8mr19030766b.7.1727977686760;
        Thu, 03 Oct 2024 10:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxxyof7QTMVZMS4QNE9XWZWHySOEJl7HxWxaAtNzVU5rP1ukRtbeYX6GNSgRO9L7MYoOQwEQ==
X-Received: by 2002:a17:907:60c9:b0:a7a:a212:be4e with SMTP id a640c23a62f3a-a991bd139b8mr19029366b.7.1727977686306;
        Thu, 03 Oct 2024 10:48:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a991047318esm113328866b.179.2024.10.03.10.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 10:48:05 -0700 (PDT)
Message-ID: <8adb805f-14f9-467e-a37a-668e3a9e7b07@redhat.com>
Date: Thu, 3 Oct 2024 19:48:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: add late_register for connector
To: Alex Deucher <alexdeucher@gmail.com>, Wu Hoi Pok <wuhoipok@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christian Zigotzky <chzigotzky@xenosoft.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241003060650.18454-1-wuhoipok@gmail.com>
 <CADnq5_PA37NQ52-Y8r6JEtXDRwPehzM5+cxysiZgVks4AkivjQ@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CADnq5_PA37NQ52-Y8r6JEtXDRwPehzM5+cxysiZgVks4AkivjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3-Oct-24 5:54 PM, Alex Deucher wrote:
> + Hans
> 
> On Thu, Oct 3, 2024 at 2:33 AM Wu Hoi Pok <wuhoipok@gmail.com> wrote:
>>
>> This is a fix patch not tested yet,
>> for a bug I introduce in previous rework of radeon driver.
>> The bug is a null dereference in 'aux.dev', which is the
>> 'device' not registered, resulting in kernel panic. By having
>> 'late_register', the connector should be registered after
>> 'drm_dev_register' automatically.
>>
>> Please help testing thank you.
>>
>> Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>

Thank you both for the Cc and the patch. I can confirm that this
fixes the crash which I was seeing. Also IHMO this should have
a fixes tag for the original commit introducing the problem:

Fixes: 90985660ba48 ("drm/radeon: remove load callback from kms_driver")
Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





>> ---
>>  drivers/gpu/drm/radeon/atombios_dp.c       |  9 ++-------
>>  drivers/gpu/drm/radeon/radeon_connectors.c | 17 +++++++++++++++++
>>  2 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/atombios_dp.c b/drivers/gpu/drm/radeon/atombios_dp.c
>> index fca8b08535a5..6328627b7c34 100644
>> --- a/drivers/gpu/drm/radeon/atombios_dp.c
>> +++ b/drivers/gpu/drm/radeon/atombios_dp.c
>> @@ -228,10 +228,8 @@ void radeon_dp_aux_init(struct radeon_connector *radeon_connector)
>>  {
>>         struct drm_device *dev = radeon_connector->base.dev;
>>         struct radeon_device *rdev = dev->dev_private;
>> -       int ret;
>>
>>         radeon_connector->ddc_bus->rec.hpd = radeon_connector->hpd.hpd;
>> -       radeon_connector->ddc_bus->aux.dev = radeon_connector->base.kdev;
>>         radeon_connector->ddc_bus->aux.drm_dev = radeon_connector->base.dev;
>>         if (ASIC_IS_DCE5(rdev)) {
>>                 if (radeon_auxch)
>> @@ -242,11 +240,8 @@ void radeon_dp_aux_init(struct radeon_connector *radeon_connector)
>>                 radeon_connector->ddc_bus->aux.transfer = radeon_dp_aux_transfer_atom;
>>         }
>>
>> -       ret = drm_dp_aux_register(&radeon_connector->ddc_bus->aux);
>> -       if (!ret)
>> -               radeon_connector->ddc_bus->has_aux = true;
>> -
>> -       WARN(ret, "drm_dp_aux_register() failed with error %d\n", ret);
>> +       drm_dp_aux_init(&radeon_connector->ddc_bus->aux);
>> +       radeon_connector->ddc_bus->has_aux = true;
>>  }
>>
>>  /***** general DP utility functions *****/
>> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
>> index 528a8f3677c2..f9c73c55f04f 100644
>> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
>> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
>> @@ -1786,6 +1786,20 @@ static enum drm_mode_status radeon_dp_mode_valid(struct drm_connector *connector
>>         return MODE_OK;
>>  }
>>
>> +static int
>> +radeon_connector_late_register(struct drm_connector *connector)
>> +{
>> +       struct radeon_connector *radeon_connector = to_radeon_connector(connector);
>> +       int r = 0;
>> +
>> +       if (radeon_connector->ddc_bus->has_aux) {
>> +               radeon_connector->ddc_bus->aux.dev = radeon_connector->base.kdev;
>> +               r = drm_dp_aux_register(&radeon_connector->ddc_bus->aux);
>> +       }
>> +
>> +       return r;
>> +}
>> +
>>  static const struct drm_connector_helper_funcs radeon_dp_connector_helper_funcs = {
>>         .get_modes = radeon_dp_get_modes,
>>         .mode_valid = radeon_dp_mode_valid,
>> @@ -1800,6 +1814,7 @@ static const struct drm_connector_funcs radeon_dp_connector_funcs = {
>>         .early_unregister = radeon_connector_unregister,
>>         .destroy = radeon_connector_destroy,
>>         .force = radeon_dvi_force,
>> +       .late_register = radeon_connector_late_register,
>>  };
>>
>>  static const struct drm_connector_funcs radeon_edp_connector_funcs = {
>> @@ -1810,6 +1825,7 @@ static const struct drm_connector_funcs radeon_edp_connector_funcs = {
>>         .early_unregister = radeon_connector_unregister,
>>         .destroy = radeon_connector_destroy,
>>         .force = radeon_dvi_force,
>> +       .late_register = radeon_connector_late_register,
>>  };
>>
>>  static const struct drm_connector_funcs radeon_lvds_bridge_connector_funcs = {
>> @@ -1820,6 +1836,7 @@ static const struct drm_connector_funcs radeon_lvds_bridge_connector_funcs = {
>>         .early_unregister = radeon_connector_unregister,
>>         .destroy = radeon_connector_destroy,
>>         .force = radeon_dvi_force,
>> +       .late_register = radeon_connector_late_register,
>>  };
>>
>>  void
>> --
>> 2.46.2
>>
> 


