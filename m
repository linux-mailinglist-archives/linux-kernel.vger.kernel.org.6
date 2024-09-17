Return-Path: <linux-kernel+bounces-331623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B0E97AF1A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595F728256B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB7716131A;
	Tue, 17 Sep 2024 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGzJbUGg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA415A853
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569791; cv=none; b=hrItbqn6BL00U0TFNfn97wjxHfkMWNrvPpVYHXG15aYSYsktx5ikIdnEETjc45Ns7TpMiIQ+n3jjp6T2MuJ+4y+v/5cqZrGGccq2trYgATnBvzN37lkNOvMTgtmEzitRtM6F3CMU/rMtW1ED/wB+T9kjcHQ1FvVXxfY2jt+1kug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569791; c=relaxed/simple;
	bh=0MoxXkvJSKaSgaXMrCaZm73NkLPBSB9YPiMym0u652k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEUcK29U1WxWMlRObT2j3dm1LuifU2b3VMfQ2GsibPVsIyMEr6vs+APCVArxuRFrnB7+K5EKBMnMO0d2zH31S28iVOu3raYzbjZLTvqw4terH+bNdIOUwkzFwyT8usO6x9IDaeHxyz5nHXFIq+85yRacIEPATwWqOYQCOA03yeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGzJbUGg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726569789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoYRHGXy6LiSQ7ig9viAYulgFxGklMeMzesdPkQzrxE=;
	b=dGzJbUGgUmJoDBbLFUaXafkAa0v2QAoQKVirGx4uG4laZgxtb09J5p1tcVWv72IR+q2zv/
	ZbHQqMbosmIaxvJHQzxSk9t17VEZubL0WUGvtcDm19Gzb1D5218nMuizsQU95Irh7rhBaK
	LPRPXiaeXvSIAvz3csOTvkUY1z5ylnQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-u05_x8IxM2iGnfygJms5gA-1; Tue, 17 Sep 2024 06:43:07 -0400
X-MC-Unique: u05_x8IxM2iGnfygJms5gA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f759688580so29477771fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726569786; x=1727174586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoYRHGXy6LiSQ7ig9viAYulgFxGklMeMzesdPkQzrxE=;
        b=R33YDjJEfeV5CtuQ09P3b4JryKS1CyxZjiDOJ5z2aGJBTfp4buGSNK7EV3OwQC3006
         vHcLyFkvkXWbYKv/4I0ycCVVWPHN5wLhvSvgR6/DlF5PH00UQbq/m9IP5v+pIsHnfdXq
         LYYsQ8sIdy9TXBBuENY1X62NpGQncci2sceoxAWqUePrJZ7XWQBgtSBoIrBszf2l8SM6
         YuXXgS82u+v/mH8QwGSEoajF4qFgdnIlQZUUJqaZboy12stqVGqHZ6/hbDZfuR7NT44Y
         eMGcv2L8aBzZGsNmXlzuxfc0wRC1uVk6ToXp/+T2KJFiTwaRG0U3cxPjwbqKYOEBVjZ9
         m/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVAkWjLE4s4OsYlgRmvh6LRuCoQ06e3sfsamY3GS11Nu3+av6WpAC47lP0oozdHQTdZ47LyQlAfzNwbJQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjbXY/Po5UID2kPaj7xOtzzYE0mzJfC/pyKeEODUyXnPv/Alof
	wX7IEXDLR9iLpq3Uk66uOZrbEVFfICwO+8mFUfSxdF+zrjc8uc8/eHusQJs4Cq+s6uWKlNtrEiR
	unUrc+kIJ15O1L39eNlAjLEg2SiCVUDScwmtXpuoI7RKpj3ytBfdcUlnc2fmWmA==
X-Received: by 2002:a05:6512:b03:b0:536:53c2:8179 with SMTP id 2adb3069b0e04-53678feb22dmr10992071e87.37.1726569786229;
        Tue, 17 Sep 2024 03:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZygkqRefwIJhNMGJUQJEghGkf7TGezwH/8E+OMWQLK5GoIADd56o7ucnqsVHGcAHn2LqRQw==
X-Received: by 2002:a05:6512:b03:b0:536:53c2:8179 with SMTP id 2adb3069b0e04-53678feb22dmr10992044e87.37.1726569785667;
        Tue, 17 Sep 2024 03:43:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e5731sm430913866b.183.2024.09.17.03.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 03:43:05 -0700 (PDT)
Message-ID: <ea5a2d34-32b2-4641-99c5-6e64dce88ac7@redhat.com>
Date: Tue, 17 Sep 2024 12:43:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in INTEL MID PLATFORM
To: Lukas Bulwahn <lbulwahn@redhat.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20240917103955.102921-1-lukas.bulwahn@redhat.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240917103955.102921-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/17/24 12:39 PM, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 5f1cda51107f ("platform/x86: intel_scu_wdt: Move intel_scu_wdt.h to
> x86 subfolder") moves intel-mid_wdt.h in ./include/linux/platform_data into
> the x86 subdirectory, but misses to adjust the INTEL MID PLATFORM section,
> which is referring to this file.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Adjust the file entry to this header file movement.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Thank you for your patch, I've applied this patch to pdx86/for-next:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next

Regards,

Hans




> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4c4116045664..9a4fa88edcd3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11646,7 +11646,7 @@ F:	drivers/platform/x86/intel_scu_*
>  F:	drivers/staging/media/atomisp/
>  F:	drivers/watchdog/intel-mid_wdt.c
>  F:	include/linux/mfd/intel_soc_pmic_mrfld.h
> -F:	include/linux/platform_data/intel-mid_wdt.h
> +F:	include/linux/platform_data/x86/intel-mid_wdt.h
>  F:	include/linux/platform_data/x86/intel_scu_ipc.h
>  
>  INTEL P-Unit IPC DRIVER


