Return-Path: <linux-kernel+bounces-296576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7E595AC53
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF811F22D90
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44B1CD3F;
	Thu, 22 Aug 2024 04:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KNKi5Lzh"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6F6FB9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724299247; cv=none; b=HW+I5oizR8AmbjnN8XdJZxpLyZucg/ULC0atIK3l81U3fFdoHAPz1HAhhjdhZnqyj2GXeJK/fgJHXkshSKgpxNzA2lQrUDlV0qBGXetqpsPGbeKdwR0Cv6iqDaIl/lGgSLYcxwpRKhHInin6bs35Ssw0LFVZBofdvsUIkjCrUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724299247; c=relaxed/simple;
	bh=ZNBnb2MBRZChM5p5DlBJ+j/8JEsahVpm4SRU8iYMuQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYLOjCgFyr8fMJzavyDf1viXRhSLHThoa5C6EhmIQrHS/wgyTlFdBTO0Y/Ic7j02DfU3UXLL3fwYl/XPWFUzs1Hl7zvo4mIWbyShZa1WdUOclU2Nu1Lb8S/pi9NbedeATUmH+hZjW9oQnZTqwHzYM6PfY/seEWIwZBr454yLHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KNKi5Lzh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d1c655141so279898b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724299244; x=1724904044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IC6CfuTtEHvKBNzqsZ0ny4OYlztAT2lA7Mfqh0zGmfs=;
        b=KNKi5LzhtNSFo26ZLfBagzgENkjC8K8qCqqmHYjarZ/9BSb64LL01XzxHihlwRr5IK
         dLRVUXkUDUvDC3Vs+aaPGsymj1WJsTgVGJVirr83AwrwiyyLLSIkGqrmZB2da9pMIGpl
         uul/k9zuy8KlSpyZaN9OEJY/vl0TfLiBvSqzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724299244; x=1724904044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IC6CfuTtEHvKBNzqsZ0ny4OYlztAT2lA7Mfqh0zGmfs=;
        b=ty68wzr0Di4qHFfjaiHVLKo35S3OoBzv1+nwgeILGwLhuMQLHSyNqkLr0nhHvgxyiz
         vDCRDF+0yhidG07m3a0yeSdjlkLlh8EEX74VFpyuMZYtwYodxC3pFsgddaqlUL0K/3hC
         g/Q6AIiNUq0X9h5ojRN47MP28mJ/D8f+JLpfors7RSK0x0+FJ7d+3PNtNwPo7GUftZc2
         t4j89ZbGIvHg/mC+JANEzf2FKdeWtBkzeDlJzGSkUQgH/yZxjbF6bKg2UObDKZ8lWP5P
         gg09dZPahL0MI2gjdK0a3OijNIHaxmTkm2O3vAYGlEdXEX02r/x3qw0KFL+Wh9p7n0hU
         dJJw==
X-Forwarded-Encrypted: i=1; AJvYcCX/roPWq/n8huuZmM/VLiz4uz4E1PGxC043+eT/zqc5BUjhk/yH6spQf80a9g7Gh2sTH0QsrnDxg5iUovw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ7hBvolsJwsH3X/hl1j/hENQ3cWwTyQtOMzF8X/XMhN5jajdu
	zyktmpOLhYZ536LjOnPOWSEQxJEXPf4UjIbdePknB8j+vnsXX6bVcQxxOLTXbrw=
X-Google-Smtp-Source: AGHT+IGpiUh7868KEC0x1i2/YY+kSSNWvJC4PyummMLhe5yqtFWXCz4fCtcDkQFRLNryHKTDBEqj/A==
X-Received: by 2002:a05:6a21:918a:b0:1c6:a83c:d5db with SMTP id adf61e73a8af0-1cad7fd2893mr4553030637.31.1724299244174;
        Wed, 21 Aug 2024 21:00:44 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad55b2asm391187a12.71.2024.08.21.21.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 21:00:43 -0700 (PDT)
Message-ID: <d18ac213-a4cf-4a29-a696-0e99b45b96e2@linuxfoundation.org>
Date: Wed, 21 Aug 2024 22:00:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include: uapi: drm: drm_mode: fix documentation and
 coding style issue
To: Nihar Chaithanya <niharchaithanya@gmail.com>,
 maarten.lankhorst@linux.intel.com
Cc: tzimmermann@suse.de, linux-kernel@vger.kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240821202039.63516-1-niharchaithanya@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240821202039.63516-1-niharchaithanya@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 14:20, Nihar Chaithanya wrote:
> Fix documentation and coding style issue in include/uapi/drm/drm_mode.h.
> Changes include:
> - Adding description of function parameter.
> - Correcting block comment style.
> 
> Fix documentation warnings in include/uapi/drm/drm_mode.h encountered
> from make htmldocs:
> ./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member 'width' not described in 'drm_plane_size_hint'
> ./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member 'height' not described in 'drm_plane_size_hint'
> 
> Fix coding style warning in include/uapi/drm/drm_mode.h reported
> by checkpatch.pl:
> WARNING: Block comments use a trailing */ on a separate line
> 
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
> ---
>   include/uapi/drm/drm_mode.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index d390011b89b4..bbdba76a5d25 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -147,7 +147,8 @@ extern "C" {
>   
>   /* Scaling mode options */
>   #define DRM_MODE_SCALE_NONE		0 /* Unmodified timing (display or
> -					     software can still scale) */
> +					   * software can still scale)
> +					   */
>   #define DRM_MODE_SCALE_FULLSCREEN	1 /* Full screen, ignore aspect */
>   #define DRM_MODE_SCALE_CENTER		2 /* Centered, no scaling */
>   #define DRM_MODE_SCALE_ASPECT		3 /* Full screen, preserve aspect */
> @@ -864,7 +865,9 @@ struct drm_color_lut {
>    * array of struct drm_plane_size_hint.
>    */
>   struct drm_plane_size_hint {
> +	/** @width: Width of the plane in pixels. */
>   	__u16 width;
> +	/** @height: Height of the plane in pixels. */
>   	__u16 height;
>   };
>   

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

