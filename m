Return-Path: <linux-kernel+bounces-271685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1049451A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005411F23A38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1251B9B33;
	Thu,  1 Aug 2024 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qo+S57tv"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305F3182D8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534177; cv=none; b=iVLF8L4CplaObhPVaWPEQRaIyH1ifC+HAfeRGTubd8epFXqaHEuE00zNQhebzv5p46cw7mgNxUioXC9OZ/OZeDIM65fhTtohZzXFEe0KfTUkICq8SKNMOc1fcIG/TmRfXjl0jYOepkpV1HF+ttmcnWy1n7IZS4AM4/wCV9t5lbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534177; c=relaxed/simple;
	bh=Tu0Qt29Sf3zu3N2MCW34cf3Mn0Ia9Ftkpu+1QBKlSa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Am/taC8yT7/Pt3hxTuzHqtIutyslTtLfjvX9g8fKuPotHo95hXzkHDflzzxq3sD/kaL4RNTCgVsI8PqpfpkImBwdAFQZquHHc0HDVaU3lJJz3HDyYIy0XBhfcqYaevxMtnEEtMnW5KyacHQJV2vIXpzRfzoll1t6OXJaE6oZp/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qo+S57tv; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39aecad3ea7so1322595ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722534175; x=1723138975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBnd36bay4hhdM/MV8RWPa6InughtfdUXHcR9nnfWLA=;
        b=Qo+S57tv8Egi3w7wkRHStj2Hc30LCw/7YUOKPrrk2eY/jI4G6kIbSQ/5NM6KCKcuX/
         xLegXlyybd8Rj+bq8FX7WSIMYmNR2gIPGgb8lUNcsVn0LlProhvEhwJnHeoGtmfh32I0
         42CM/6CNLflmwTsIUugF8NKZM24BEJVMfdZ7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534175; x=1723138975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBnd36bay4hhdM/MV8RWPa6InughtfdUXHcR9nnfWLA=;
        b=R5uq4+/KI0nAWh8oOLKHAdIPDMGH3Oasnm1qNDGQ0N/WIUdkTibS8i6oF+bmoW2nJ8
         PQglZ8IHuQ6BtQKDWmgQcwNBPN8HRqEJxam9b0yxDGNkDRaN4zMis42YnthTuYCy0MwW
         NTAPUWfmDYrjaSpT/FbaYf6cxmSiChbFKKlP0BE/73gMiIbM5NaxemoJzzxYTLt+W+S6
         nyfMTSgMuiEl2miRU/JN+slby4eb2ij+hw2j3MrGP1wZCXn6XO6+mAQxnOA6kZmCsOsY
         67bEFqz8KRs9u6zNaN+vZMYz3pjlok0kdTIczmzJlYVV7AFO3DQyyQU53ifCBu8lKD+p
         nzhQ==
X-Gm-Message-State: AOJu0YwfoezOFptBR1+7CFc6DZQnqAoSclsVRMP5oLTK+h+6okrjaeFb
	r+yZUPtPLxUxQAKr3BOwbu76c7f3KC633KaFBLZ49jcr0YLwR+wc+8x/i6zIW8E=
X-Google-Smtp-Source: AGHT+IGnLXptorn53kY6ONM/mfuWg1xNPcd4q5JlmJn5fg/AU9Nm25hPHmSxW7Ynw0s/PXAU8JRFog==
X-Received: by 2002:a05:6e02:1c2d:b0:39a:ea4c:8c39 with SMTP id e9e14a558f8ab-39b1fc44fdbmr6285455ab.4.1722534175022;
        Thu, 01 Aug 2024 10:42:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20af151dsm613555ab.77.2024.08.01.10.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 10:42:54 -0700 (PDT)
Message-ID: <907c05d6-9c9c-4866-813b-a185a081c815@linuxfoundation.org>
Date: Thu, 1 Aug 2024 11:42:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] documentation: key header files: fix member variable
 description warnings
To: Alissa Guo <guoalissa@gmail.com>, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, brauner@kernel.org, kuba@kernel.org
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240731043609.9762-1-guoalissa@gmail.com>
 <20240801005206.126984-2-guoalissa@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240801005206.126984-2-guoalissa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 18:51, Alissa Guo wrote:
> Fix the following documentation compilation warnings from missing member variable descriptions when 'make htmldocs' is called:
> 
> Fixed misspelling of @j_transaction_overhead to @j_transaction_overhead_buffers in ./include/linux/jbd2.h:1303

Fix

> 
> Add description of 'target_rr_divider' in  ./include/drm/display/drm_dp_helper.h
> 
> Add description of 'width' and 'height' in struct 'drm_plane_size_hint' in ./include/uapi/drm/drm_mode.h
> 

Lines should be wrapped at 75 columns

Refer to Documentation/process/submitting-patches.rst

Didn't you send this patch and got review feedback? You
are supposed to send v2 - Fix these problems and send
v2.


> Effects:
> 
> The following warnings should no longer arise upon 'make htmldocs'
> 
> ./include/linux/jbd2.h:1303: warning: Function parameter or struct member 'j_transaction_overhead_buffers' not described in 'journal_s'
> ./include/linux/jbd2.h:1303: warning: Excess struct member 'j_transaction_overhead' description in 'journal_s'
> ./include/drm/display/drm_dp_helper.h:127: warning: Function parameter or struct member 'target_rr_divider' not described in 'drm_dp_as_sdp'
> ./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member 'width' not described in 'drm_plane_size_hint'
> ./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member 'height' not described in 'drm_plane_size_hint'
> 
> Signed-off-by: Alissa Guo <guoalissa@gmail.com>
> ---
>   include/drm/display/drm_dp_helper.h | 1 +
>   include/linux/jbd2.h                | 2 +-
>   include/uapi/drm/drm_mode.h         | 6 ++++++
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> index ea03e1dd26ba..7f2567fa230d 100644
> --- a/include/drm/display/drm_dp_helper.h
> +++ b/include/drm/display/drm_dp_helper.h
> @@ -112,6 +112,7 @@ struct drm_dp_vsc_sdp {
>    * @target_rr: Target Refresh
>    * @duration_incr_ms: Successive frame duration increase
>    * @duration_decr_ms: Successive frame duration decrease
> + * @target_rr_divider: Target refresh rate divider
>    * @mode: Adaptive Sync Operation Mode
>    */
>   struct drm_dp_as_sdp {
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 5157d92b6f23..17662eae408f 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1086,7 +1086,7 @@ struct journal_s
>   	int			j_revoke_records_per_block;
>   
>   	/**
> -	 * @j_transaction_overhead:
> +	 * @j_transaction_overhead_buffers:
>   	 *
>   	 * Number of blocks each transaction needs for its own bookkeeping
>   	 */
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index d390011b89b4..c61b72bc04a6 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -864,7 +864,13 @@ struct drm_color_lut {
>    * array of struct drm_plane_size_hint.
>    */
>   struct drm_plane_size_hint {
> +	/**
> +	 * @width: Desired horizontal size of the plane in pixels
> +	 */
>   	__u16 width;
> +	/**
> +	 * @height: Desired vertical size of the plane in pixels
> +	 */
>   	__u16 height;
>   };
>   

thanks,
-- Shuah

