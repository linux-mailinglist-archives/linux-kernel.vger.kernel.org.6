Return-Path: <linux-kernel+bounces-563687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1351A646AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A86127A823B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20850224242;
	Mon, 17 Mar 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5BSSkU7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA8E2222DF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202568; cv=none; b=n6nOEN2lZlGSVkyYm+H9TTOaufQvP9CUujCo543WG1GoMakflw7ake8t/EGT25mEqE5ZKZ65QXlCtGp2XDo4oOcE39Gp4zorXp/+MaM7USuYkGbviKobnShBSasQ7F6KKSdq/K7n/ruVFiQoyjtHzcRNBS8b+8oPddPr6teiMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202568; c=relaxed/simple;
	bh=UGeKxti/Rtl1+ILDl2QXu4lQBMO2Zbk90augSVkNHLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBJ5z5mDViw0pOVPf0Ys+A81hihqiAxVRH4GhHyLlsj+TA6zdTclAcNZzfxDWhcF0XlUbWByGC/zsQdxhL9ihQX7aP0Ebz+PkSec8m1QJHKovkKDVyqh6HuXgPbmIbvJIL8SK/gymHvvczD0f+2KpI+7bNS9geqNRYExulZHtug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5BSSkU7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742202564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bww8JOfOpzHjN4KnEpLdpIzThEx7K4HigFEfHRKZmPk=;
	b=D5BSSkU7t8CBNmrFXxsyUPMDtyOsyxbVzw3XAhF0DLwZgtUmFh3aw3rulyvVAO7YSFYTZ1
	VFopZJAlGKoltz8BemaPp+dayWd1gELXj7XHhbXI9cPWph/jdHxmseTfKc99HxmCl0lL4L
	+s3EaFfd2CDvLJA2ic7GsFT3nAd8ehk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-NunBFmFwP8u8d1vu6rIViw-1; Mon, 17 Mar 2025 05:09:23 -0400
X-MC-Unique: NunBFmFwP8u8d1vu6rIViw-1
X-Mimecast-MFC-AGG-ID: NunBFmFwP8u8d1vu6rIViw_1742202562
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d9e4d33f04so3580421a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742202562; x=1742807362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bww8JOfOpzHjN4KnEpLdpIzThEx7K4HigFEfHRKZmPk=;
        b=oChM7WORe+PkwTa0qBXIlQVi58jeoMHTQ5ZqN8wdIMCQ1mBpuimN3IHtjFKpKUTQk0
         qT513pYCBtYosSRUhuY1cBO05H9KUd/n7guDmEoGfXYCjxwZBrpxQfiWxRCY2MITVitf
         uohBYiMhuOLGG/who/UI96SRYzlTeQ//qrCCzBmDRHHGoxdUKl8FV7wqVJ6Rt5PhU53L
         BUXLH8OCvQzvhUU0pwzs7vfUcqH23cO2XBw7Gb/AqYEiUeBkwRORmaEDiIB2X5v87clj
         v5WOMtl9xWrQVKDQ4HSZMONhz56RvmMNPXvaDCdw4L9YVwllTgFkM15S8GHNuZAzVB2l
         m2eg==
X-Forwarded-Encrypted: i=1; AJvYcCUeJz/XRCdzPROJe3TKW7UrSTI4qTdkm0wzo6w01Yl0hMIp/JnjtBkq74xsRYD5kfJLNMoSj8dXIAAG/XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwElMnBMq6RNG5QrQza3D57alaF1rNlf9N+k0WbuCbVTta1gllR
	sBhjdGXrUAHb0R50EWR0MaveBlZ0iYzRjVWS0GB9a2Gp7YGXx5TO72ehgJWH6+KXqJM7SWqEOVJ
	KxW13rn0oIfNkwa15SxoBtZl9/b3554KopxwLQ9vAjEnvJyQGkYA7xvogW7HkPA==
X-Gm-Gg: ASbGncsTn9v6cPMM0z3S5xU/aAKeCIdIpuFfxyuYBgR9Fw24Ue+agJQjQJoCMIjl7/2
	UU+NvhgqnVWqgLX2BWwwl06YL031otVSQPuG1p2PGPdr8EYCNaEFd15TKPnL8ICq0AiNeqCS/u8
	rGXmIwVVlSJbodU6dZcMG6ANO949EFMddGZYaaTf+Msk5Zp86g92lFPIAfxXc5LxBtu+4UwNWau
	AO1vz3rWgLJghi3pXyHfutaV3lx88jNGe8PbA9A3+gPVAqgYnWB/agvgUOKh9XzPHAPuw7ANDLc
	ClCSbvUa6mDLUgs4GJk=
X-Received: by 2002:a17:907:7d87:b0:ac3:26fb:f420 with SMTP id a640c23a62f3a-ac3303715c9mr1316675566b.42.1742202562165;
        Mon, 17 Mar 2025 02:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbzLKOvU6u087cvw4eQbB3+jMOWQmFWk87CZXwlrr7X5z5g/l5JBC7ADKxnGSg2zX1KEVA2A==
X-Received: by 2002:a17:907:7d87:b0:ac3:26fb:f420 with SMTP id a640c23a62f3a-ac3303715c9mr1316673666b.42.1742202561824;
        Mon, 17 Mar 2025 02:09:21 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a3d3d7sm634405166b.132.2025.03.17.02.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 02:09:21 -0700 (PDT)
Message-ID: <9ca06bfe-84fc-44fb-bd32-c5914ab553d8@redhat.com>
Date: Mon, 17 Mar 2025 10:09:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm: panel-orientation-quirks: Add OneXPlayer X1 Mini
 (AMD) quirk
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
References: <20250222164321.181340-1-lkml@antheas.dev>
 <20250222164321.181340-3-lkml@antheas.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250222164321.181340-3-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 22-Feb-25 17:43, Antheas Kapenekakis wrote:
> The OneXPlayer X1 mini features a 2k 8.8 display with a portrait
> orientation. Add a quirk to set the panel orientation to portrait
> mode. There is no Intel variant.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 17b4f57d64d7..1378690b7287 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -461,6 +461,12 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1 i"),
>  		},
>  		.driver_data = (void *)&lcd1600x2560_leftside_up,
> +	}, {	/* OneXPlayer X1 mini (AMD) */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1 mini"),
> +		},
> +		.driver_data = (void *)&lcd1600x2560_leftside_up,
>  	}, {	/* OrangePi Neo */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),


