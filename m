Return-Path: <linux-kernel+bounces-212268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A04905D82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014D91F2284B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98798526C;
	Wed, 12 Jun 2024 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izJ5P8rZ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26D784E00
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226894; cv=none; b=CE0f43WwZfOWRTDtUbvejnu5N4yspBjD2G92Bb8xqmhmnZ3AQ+i3CX0pdIf+pkMHsvRd2ANsA/97QqbKHEmnRhmYYCKu4hczNnB/fI2WHYOhlIgxh7De60+rcrSlHeuoANKA9cESeCxccorV5MlvRlyjgWUG2Y4fFYV4bGzNAx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226894; c=relaxed/simple;
	bh=2l4CBWe6q7CNgxn5yu4AhHkrHM8iPliCKhrEYDXKk7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VKgQhb0Uz0PUBq6lQrqYIA0n6gSqA1UvFtB+0D6gKkzhMBDdVP3wa0fqwkNEsdzF4QBgvynm3LVe38c/6kVLxS8+qFPR6ebHb4GVY9QkUw10ZPusvcRImVZzpF/XlaZS0gX+RnOEUHp4iUBiSBD/1gs3MVKpHGn7lCCV3ObE+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izJ5P8rZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c61b3be3eso18953a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718226890; x=1718831690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xo5IIcIQjLyjRrtVLD88BI3QmE0inmNeEyBU3/k3os4=;
        b=izJ5P8rZAZ51wCiRst5jx542eHVsjGr+C1SajafxRnue8kD0XN/M8jfgjvQe1PC9xG
         OOhCA4vcV2l79HCuOPHB1Z+R2llo4maoiO/SrdeADggGZhpEus4GGeo10GPXxbauOBIS
         EQOSmRIXoD9J9r8j2M93A9RC8Kr2et/YZH8vi2Fs6gLJ/IlmXl0CAyLIgo+jx/kPvfUx
         J3dFn35QY+4bn/phgjDrEo7ba2TEvE3z+4lSR+WuJIEZbVVw/i0JgX2Lp4zjYxBEaccF
         BkZgUyEv85y/FPk2eQcpmmbyFhlgzh7PZN0pYtCdirb78hmgMdCLJwh8/6RqceMwVWlW
         +tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718226890; x=1718831690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xo5IIcIQjLyjRrtVLD88BI3QmE0inmNeEyBU3/k3os4=;
        b=bfgVzv+XElM682ie6Rqh9z4gfG/J4BOXeWzlQg7bXuWLKxh8AkfgHYn5vjTK2Q7HOE
         Is4EJvYH0qKyzv1V4e+8FiYglCIV1DWZYaO4SwIOjlF5sdu7JeLqy8o+xULJYfZcl1AS
         u3ljw708HER+Hd7hwkr/tqI5VKrktRUqujeMK+8uwvys/PA8UAEM8Mwbusdo/jigkbl0
         IA381FkOOepO4f1/SJJdNgYc1s/sBg1QRqIh3ZZaedv1tQ/BPNSz2gAO7Lo+kR8U4DZN
         q9aq2nI9dszC8KHVeRgvNLYPvd54/Cmp9WW2J5ekP3W29J9nV2rwHjgT23msS6VghQq3
         o9dg==
X-Forwarded-Encrypted: i=1; AJvYcCVrpgwxAJtKVVGdNKe5o7RReVwEPhDxl+rSVe4F9aWpHrLYdR0EeFt14pBjwIlG1A97muY0yk6RP7Ot/w1y117i9uYAgTJ0+/5Ttm3e
X-Gm-Message-State: AOJu0YwMLVV/VlbZJHLZof5vmGnm9jPen4O4uqaPCDmVb4fAFCRDSFN5
	Ry11eru/vrM9/4y54tJVJLRybTPn7N8H9UFRUhWCEHuEBCuwVkgq
X-Google-Smtp-Source: AGHT+IHzify8DAB7btVxLaOF1hblcRjk7bMIcKkdwn6H44fx5jaz2p0/uO48qfqKrRG09x2M0ZM4Ww==
X-Received: by 2002:a17:906:a89:b0:a6f:513a:a63 with SMTP id a640c23a62f3a-a6f513a0e43mr64541466b.1.1718226890019;
        Wed, 12 Jun 2024 14:14:50 -0700 (PDT)
Received: from [192.168.0.104] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f26b84265sm367571466b.119.2024.06.12.14.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 14:14:49 -0700 (PDT)
Message-ID: <5224351f-7b40-4edd-abc7-c5011a92f179@gmail.com>
Date: Wed, 12 Jun 2024 23:14:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: Remove unused constant IC_VersionCut_C
To: Teddy Engel <engel.teddy@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240612143326.6764-1-engel.teddy@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240612143326.6764-1-engel.teddy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 16:33, Teddy Engel wrote:
> Remove unused constant.
> 
> Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
> index 8c85f1c866d3..2cab232bbf30 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
> @@ -88,7 +88,6 @@ enum version_8190_loopback {
>   	VERSION_8190_BE
>   };
>   
> -#define IC_VersionCut_C	0x2
>   #define IC_VersionCut_D	0x3
>   #define IC_VersionCut_E	0x4
>   

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

