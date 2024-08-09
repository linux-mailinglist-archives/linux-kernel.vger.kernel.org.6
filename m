Return-Path: <linux-kernel+bounces-281178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA6194D400
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACFA28118C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71711198E63;
	Fri,  9 Aug 2024 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UrmA/vOH"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7385168B8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218724; cv=none; b=IrUJEY5ptkVWYrlb/ZnAzjyb5Z8T3aK1SgQXhtbZaAFRyPj2vPC19TJDzw0lIj64heWGc2/GNVd8XGnaPqsRBIWj2bg9UIMO+6IsCzBB3CBmzcusnQsJO2BBTI0qU44WedAY1xcO6z35LEyWx89T7aJAR+TgSK2FmUSvjUPFgjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218724; c=relaxed/simple;
	bh=Aoe1tUdGN9EszDwJoMQScE40lj1e/glqHFnZQ6+LxtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6OjFkD8EvM7WtA0+hRI6vA5b3UbCobKnFZbF9nonSc36pgT2ipBQ6IVkNPFa5GA6OM86btBMDM48gHRk/Iu00GlckRp6wA6kKVWpNHxjvNKLv+fj68xnP4jv+6Qi1ITZu+KX1OarDv5FpK/8oal+Jawdgsx7kHMb0z3M2Jw5Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UrmA/vOH; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-810ca166fd4so8386939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723218722; x=1723823522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KF0ax7W1P20MaxQnCV8sySibamf26ozw3OigTBi50ug=;
        b=UrmA/vOHF09oQk9hQ5pBmtRdUc2ZcsIwq4jz9L55ZMXrb1egAkGXhWy8MO+UeASU+2
         8RqyBP4KVzVN2LKIoktyF+89Qgbx8QnMKjvjPLA66FBTB6PdXjQ/AGEafglkI3Zaj6DG
         3fZVRlHiRcaIrVAf77eq6s1TGwFN36qfTJjuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723218722; x=1723823522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KF0ax7W1P20MaxQnCV8sySibamf26ozw3OigTBi50ug=;
        b=ipkwdlGlNF+SpueddFqLgm99zoGVM9O2xQkTpXag1zlHIPI1Nwo8Vu8GaQlbVldhkN
         AH1Qj8uWj8Lz0ojaBXUuecmC7/BHjT1jTiiobUHo0fxc7Zj7UXBmvGTqp6ZJCzXm6TkQ
         jtJCcjXzuVMLfeyOAq4l8dzjoRdHcTx1jZgzidSQYH/pgNq1QPxXtNepue+WtqNFgtAI
         0Jd9hfTG+Cj8AmfmB5n4bxB4Sxf4iEyss57oe56dkWT4VtCXUnzi2D6U4o3z18mItEjm
         CkDD5udALDnWojfeUMLaQCy/am2J1mOLXuk0XhsRUcDg47k52vH28g3B5/+v3tQj7P68
         5JZw==
X-Forwarded-Encrypted: i=1; AJvYcCVFL89r/4BZukfw+BZFs8nGfPzxQcV6aep5Gvqo1VVhO71MLAQkZLHO1RtmUkUmuBOY19qBkSrAV6hJiik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5w/HUb8BGUeIsGFoOVoqDFRcinAEgCqnlc8gW3HqzLVRzMqGJ
	7UIduwdVThohKLKvExeW4a32kNYycyxXejtwvqxbLGs+0CoBUiCJqzU5EVzqZWE=
X-Google-Smtp-Source: AGHT+IEacVzfZxGYgS2156+QwFCiFEXj4BEbmIa8BBPXXEUNPS4UZLc9VOdK5aRJKr56+itJk9oxfw==
X-Received: by 2002:a05:6e02:1aa9:b0:39a:ef62:4e96 with SMTP id e9e14a558f8ab-39b86f8553dmr14604925ab.4.1723218721875;
        Fri, 09 Aug 2024 08:52:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20ab6c3bsm65747215ab.47.2024.08.09.08.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 08:52:01 -0700 (PDT)
Message-ID: <2036d89d-0387-4477-92b5-7d220b0430ba@linuxfoundation.org>
Date: Fri, 9 Aug 2024 09:52:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kerneldoc: Fix two missing newlines in drm_connector.c
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240808084058.223770-1-danielyangkang@gmail.com>
 <20240809032350.226382-1-danielyangkang@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240809032350.226382-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 21:23, Daniel Yang wrote:
> Fix the unexpected indentation errors.
> 
> drm_connector.c has some kerneldoc comments that were missing newlines.
> This results in the following warnings when running make htmldocs:
> ./Documentation/gpu/drm-kms:538: ./drivers/gpu/drm/drm_connector.c:2344: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
> ./Documentation/gpu/drm-kms:538: ./drivers/gpu/drm/drm_connector.c:2346: ERROR: Unexpected indentation. [docutils]
> ./Documentation/gpu/drm-kms:538: ./drivers/gpu/drm/drm_connector.c:2368: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> ./Documentation/gpu/drm-kms:538: ./drivers/gpu/drm/drm_connector.c:2381: ERROR: Unexpected indentation. [docutils]
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
> 
> Notes:
>      v2: added "Fix the unexpected indentation errors" line to description.
> 
>   drivers/gpu/drm/drm_connector.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 80e239a6493..fc35f47e284 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2342,7 +2342,9 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
>    *
>    *	Default:
>    *		The behavior is driver-specific.
> + *
>    *	BT2020_RGB:
> + *
>    *	BT2020_YCC:
>    *		User space configures the pixel operation properties to produce
>    *		RGB content with Rec. ITU-R BT.2020 colorimetry, Rec.
> @@ -2366,6 +2368,7 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
>    *		range.
>    *		The variants BT2020_RGB and BT2020_YCC are equivalent and the
>    *		driver chooses between RGB and YCbCr on its own.
> + *
>    *	SMPTE_170M_YCC:
>    *	BT709_YCC:
>    *	XVYCC_601:
> @@ -2378,6 +2381,7 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
>    *	DCI-P3_RGB_Theater:
>    *	RGB_WIDE_FIXED:
>    *	RGB_WIDE_FLOAT:
> + *
>    *	BT601_YCC:
>    *		The behavior is undefined.
>    *

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

