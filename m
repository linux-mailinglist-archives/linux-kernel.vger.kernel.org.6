Return-Path: <linux-kernel+bounces-416870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE839D4B75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1916B25D83
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11FE1D2F6D;
	Thu, 21 Nov 2024 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOIC11VV"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C491D2B13
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187929; cv=none; b=tN1OyJzwYiAuF5p+arIte7WwjuoyyrQVey/Xuv7PF9hpkB5Dgc7pwpezvjoPY1t1hiIQi0JNgGYItolXpn9jhuj4eb7DrdoG87AEnV+I2zinsfEaaAv8kZDjRvd/V6Zo5EcKCln1tw4Kk8cHFu0lsl7wmAKp7QoeP10zHQosrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187929; c=relaxed/simple;
	bh=h7yqjg8qTOCU5iiScDJgky08gNrxLCksBvTs866z2T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzmW7gihbnFrlVatApLuH92Axgbu4COIUn+pGr/pMaJUMCbnD7HGHdk/dyPF6T75eHVFBuh2QZavJIs6epO3xwROt4BpdgiUkhSFlmi8meafKP3OO+PQYqL0CCsonmeLIqDJB/3OPr4xtliyBpsUCRH+2xVDmkfXELxD4ana8WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOIC11VV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53da24e9673so741893e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 03:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732187925; x=1732792725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXX0ErhFOVu8Od8Q7ZNgo+Y4NZ3xb4nv+yBNbXca4Fo=;
        b=dOIC11VVApQNcoBIHaxgTCF3A64hBiVS16TERyGlCJ2Osi63X+2rCkOIaN1ypn+RLf
         3ENzLBpdW+46h1COlGyNjQnZquNj6KBr14dXJCZCW8BNmZCt/UkvtyoBBYJPeRnzcoeY
         ZGusMRjmvK2VyOZGjvXDzs+SyijwZH7QKW8ADf8TwEmcAxwSmWPkBa1ZX6hPT57bU32J
         9TmFVvETNULLHh9Z0s7carbyk6iKV/uNUMllC/1sb8Zgv832mBTDGfydkFAk7BSyGbmN
         lgKXlBxxgwQ+kQrAbcpyh21KzVDjLgR4SseWOY+B5HtsixDFA5As1BR6ZqXG3TS/ZEGx
         eYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732187925; x=1732792725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXX0ErhFOVu8Od8Q7ZNgo+Y4NZ3xb4nv+yBNbXca4Fo=;
        b=M/0D+h08FoEQKhnBqvNXHBSRPBmUA0PkfoQ9hiJJ4y6fQ17ATq20VJY1nOR8piZiL7
         gG6KEsowrn8TwZstDIXZTJssmr/GB0zyWoITEBB7BVYJAhlallpn6pIw+0xiLklAgv+J
         LeSiVb4c5S96h8XsBnyIdff0vsoA5tcptK/x4/PaSlkzLpItEaO2x2NKNuJCd+j5Aaqp
         PdqwPWHD2fDufSak8hbJ8t7iHQTxIkhvj8uEtGyuW8LrLkin2h8dZK3/GDXgByD4MNKY
         CqJb/n08COoeIJdy2yBdq/sMBLafRJzNZcEHIlPmlUD0G34uXFgK1HGJTvy8ovXiaGyo
         pvAw==
X-Forwarded-Encrypted: i=1; AJvYcCWIAD6MU4U7k/N8q7/C9agtroUDR1ArF6dMbKo86bxMkYxjaLXy4Lfybr4aZY+dP/sBM+Hs8vScjVbp8sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ5/uhJgz25jqFwPYcwbpWf7RmXwvXW9HGtWrsRiodnr8xw5cP
	unnndmTE6QG6pHpm91OVZKV5oXxDPb2DHSjd7xL2bjQLg2L96GYH
X-Gm-Gg: ASbGncs6ea/CH2hEqPr0dpujNIcswv4STR86cFCRBE2hPi320zOQwCpTZaITpqT7YQU
	3eDUCeBUBr7BIxnPthvJxKdC6yzZ/SP67m6sJKq54wNv1fR6izf5p1AM1TzZq4t0LL9BwPTWzNf
	3h5Evp0xN5t2i18r55O+LdnDYuNjsEqRL1ciqWKAS8d26vqBJSgrYDxODqoL0nfLeJTIRVSTmm3
	aF44JW3YMPbfpE8eTpbUddhedmmxUJ0/mi5wIPM2VV7x7Nrm/1eRkW0TFaqkh7BIkXiw/eQe+AX
	fEn1Ww9oe8kGeXaBW1Q=
X-Google-Smtp-Source: AGHT+IGQJYMemdhzchakHAvCcrLvXLVQyZudyNgQh0lKIDqfAYSpRnqffoUO4VS2mZVGjuE0xgBPbQ==
X-Received: by 2002:ac2:4e06:0:b0:539:ea0f:cc43 with SMTP id 2adb3069b0e04-53dc13384b9mr2398710e87.19.1732187925266;
        Thu, 21 Nov 2024 03:18:45 -0800 (PST)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e117bsm55427445e9.8.2024.11.21.03.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 03:18:45 -0800 (PST)
Message-ID: <c3e3b5b4-1b67-4564-ab3e-da7a073f45ec@gmail.com>
Date: Thu, 21 Nov 2024 12:18:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sti: Add __iomem for mixer_dbg_mxn's parameter
To: Pei Xiao <xiaopei01@kylinos.cn>, alain.volmat@foss.st.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, --to=lkp@intel.com
Cc: ville.syrjala@linux.intel.com, kernel test robot <lkp@intel.com>
References: <202411191809.6V3c826r-lkp@intel.com>
 <c28f0dcb6a4526721d83ba1f659bba30564d3d54.1732087094.git.xiaopei01@kylinos.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <c28f0dcb6a4526721d83ba1f659bba30564d3d54.1732087094.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



> Sparse complains about incorrect type in argument 1.
> expected void const volatile  __iomem *ptr but got void *.
> so modify mixer_dbg_mxn's addr parameter.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411191809.6V3c826r-lkp@intel.com/
> Fixes: a5f81078a56c ("drm/sti: add debugfs entries for MIXER crtc")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Hi,

Thanks for your fix.

Acked-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

Regards,
Raphaël
> ---
>   drivers/gpu/drm/sti/sti_mixer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_mixer.c b/drivers/gpu/drm/sti/sti_mixer.c
> index 7e5f14646625..06c1b81912f7 100644
> --- a/drivers/gpu/drm/sti/sti_mixer.c
> +++ b/drivers/gpu/drm/sti/sti_mixer.c
> @@ -137,7 +137,7 @@ static void mixer_dbg_crb(struct seq_file *s, int val)
>   	}
>   }
>   
> -static void mixer_dbg_mxn(struct seq_file *s, void *addr)
> +static void mixer_dbg_mxn(struct seq_file *s, void __iomem *addr)
>   {
>   	int i;
>   


