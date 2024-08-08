Return-Path: <linux-kernel+bounces-279663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9794C02E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4481C222CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D0818A6A0;
	Thu,  8 Aug 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PSfaEOiR"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A650BBE5D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128315; cv=none; b=PIuxF32C6pZPL0J4uRT/RpwiFBP6/XCnf9aPf8b/KBNgdLogIa0+eDw6o/aKbTrAnRVwVw452qudRmoDFnJhhm7Dgfhtei9fpcERqlkxcXjQriGfPdl/bAxMzGhyL4a0oH+gpkHn2Wi1Rx/bWBbP5ggVuMw42AakJffpkOhOFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128315; c=relaxed/simple;
	bh=KpALEWerRE9Ihb8BvAaMPRncWWeI5MDABubpleySyrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLclr+TrWpGAJEtiKR4u77kqXv+dRjC8REzixoMbLu5DYGN8pfjhvIP5um69ectCRacSKoz+LLx8MB+XbYINuYiXhe7C537LBSU06tk0OgIhqvgpx0h1c+fZThx8f2qPHEvkDYRL/UQ5WONJWAqDmqRGqrsKxJW24mCW8M/0wPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PSfaEOiR; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39aeccc63deso454865ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723128313; x=1723733113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOyLR96pj1FmhAY2pd0AwP2D0CmcEpgxNczBjEIKOY0=;
        b=PSfaEOiRNDENzNOnamXI+Y6NZ7G7stq2VJ2o4v/STs52q0P/vftCTQyhlTctHnRtT1
         dxhgfGMn2ARloF4Cq/bLgwxLGpN/ApzX3ZeBP0SoRWg/xfgO4r4qit9uJs1Rdcs4lVfR
         YlarhRnMYVH8wpYirpvOaizMBOuodGuT/Jihg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128313; x=1723733113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOyLR96pj1FmhAY2pd0AwP2D0CmcEpgxNczBjEIKOY0=;
        b=DgDcxETi9WC1UeTkdb3NYMS5EwtBB/Y6fH5dF4wC2ixgUn7RqO9MPFKkt6CXggCGpa
         /5u/TNCB2CtFsSN2+XZukFjQarWanUu6TScBmkFv/BAjyso2XbMX+absaw+az/WD+m3t
         ce4/RH1GhlwE4kfKqzXdL1dTtf4R8mbsl0xN4wDlbT9pGjEgtr5miKQkBZoW8JpRxFGs
         HWdqQy6leFg7GN1yIfAkJkCY19juoJFdnF6gGhJ27ObX9H4J1WthbI5EhAEC0HWhmxt3
         NS4GY5r9X6hKxfDEUgjMhbqlUezkEy5x7/xPLZDmkjYn2639AKi8jYTAl4yWXiv6mfHw
         zdjA==
X-Forwarded-Encrypted: i=1; AJvYcCUtxdRePfOALLnM8gNnXShWGs8Lttli8cWearecBQwVOjBKhFKK1qjvO+AKI0x2xSQFsvuCbqqj/shzmxShHQyhxr1gdhHPLsLh2e2x
X-Gm-Message-State: AOJu0YwiQhgLusfqocEvCxswe+Ws+5zqE2QO9lfItKxZFUX64hcQ/Nyi
	uUnGm/lly5sHMahYhIB1b4RzhIdTMOiuEEEXcesWYI83btLMAjvlAw7BoEEdV9Y=
X-Google-Smtp-Source: AGHT+IGIrmSZpTANKFadpi4Xa8lpeuWa1JDx7izZT0ePNLlGrzbH9rBwlgoGg+JdS+CnC09zUSfpqg==
X-Received: by 2002:a5d:9317:0:b0:821:dad2:cc0 with SMTP id ca18e2360f4ac-82253773b3bmr160018039f.0.1723128312636;
        Thu, 08 Aug 2024 07:45:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca6300b223sm240120173.131.2024.08.08.07.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 07:45:12 -0700 (PDT)
Message-ID: <86c0af63-d5b6-4076-ac50-36ac4334c8b0@linuxfoundation.org>
Date: Thu, 8 Aug 2024 08:45:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kerneldoc: Fix two missing newlines in drm_connector.c
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240808084058.223770-1-danielyangkang@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240808084058.223770-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 02:40, Daniel Yang wrote:
> drm_connector.c has two kerneldoc comments that were missing newlines.
> This results in the following warnings when running make htmldocs:
> 
> ./Documentation/gpu/drm-kms:538: ./drivers/gpu/drm/drm_connector.c:2344:
> WARNING: Definition list ends without a blank line; unexpected unindent.
> [docutils] ./Documentation/gpu/drm-kms:538:
> 
> ./drivers/gpu/drm/drm_connector.c:2346: ERROR: Unexpected indentation.
> [docutils] ./Documentation/gpu/drm-kms:538:
> 
> ./drivers/gpu/drm/drm_connector.c:2368: WARNING: Block quote ends without a
> blank line; unexpected unindent. [docutils] ./Documentation/gpu/drm-kms:538:
> 
> ./drivers/gpu/drm/drm_connector.c:2381: ERROR: Unexpected indentation.
> [docutils]

Add a line to say "Fix the unexpected indentation errors"

drm maintainers will have a final say on this. :)

> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
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

thanks,
-- Shuah

