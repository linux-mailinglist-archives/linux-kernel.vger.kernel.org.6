Return-Path: <linux-kernel+bounces-339349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31058986495
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A6BB39563
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9086147F46;
	Wed, 25 Sep 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uzt28pqu"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D73D45007
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278155; cv=none; b=t1+jGR47SKf1ZtRxAVhhYmvUZDRPwmaVsSnHBTHNn4zNBz5FqcEIINXlq/RUJOwar6iio7Z1JihWGxIwrYoVCNkubt1dzFVhiLxWHf+6AwIH7s5Z7m9oTaNcKp3lSUR593XXibw8bXa3QRkcwIqGZoWfiNLtShHcdGyt6W770D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278155; c=relaxed/simple;
	bh=awUb+63RtxxR3p0ghGoxn+GAKa9yv1HStrK0WvOwAGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seMxHzoRXkwVf9dO3e3yKTLAyduMLarrM5iI1JJ9C1RqlM8u9PxNMwU/WT+GKbSfxqlq5MWuJcMfj3Yg8V9r4GjjzLA3N1KrYcg52s7pBB9pl9CHkd7hCGoxYvrS3ol44G81ROYgbg0E0p3OiSbky5+Eb59lLHnP5LAHiRjGOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uzt28pqu; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39f51934f61so24481615ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727278151; x=1727882951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7ojFoyh79dJqXkUovYSl140R+kqroy7gdR2sYzeq1o=;
        b=Uzt28pqu+8NJcMXYkzXCknPgo0yI5PZrr/Alnu0Tid/whC/Q0YWgZXeSSjLvbyPEAJ
         7+OAxlk9CAbhoZaWGljJpCG19GxStqyskkcIz3cY6XmJLtlrW/HuhUJYzj3ERVd6IMT4
         Jwsu2kzDKhirlxghUae3FcZ7bkfq8Jl1o1oNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278151; x=1727882951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7ojFoyh79dJqXkUovYSl140R+kqroy7gdR2sYzeq1o=;
        b=pRk7SRgW2fK39o/JXySAcHRinlnXDcX6kpgLQdD9bP8NPBmap746IMhP/okRD4mDGH
         DB9rCXNGeGgpmnRBes6TwyVCchQWpSUJQxOY7zrgWHJQzec87oVVNy9uoFVAsL0Csqgb
         7BT/sfFKQQcSq+Cmq2WY6AT0csZ7f1WEhrqntzz9AOqXNCIuNI86K0ac3A1s9mjmGLZ7
         jW+T8hqRLu9f+1/stO3LoYI0kvBsDyJIsg58hCkdZGSSHO8VV1I5LBFriC5GXnW29FAD
         0/X3oeOmKRjz2sE/n+t5/V4Y6cVtWtrVR6gNaqoM7Z9NboztGfp1YIbOJD0M3W5DSVD+
         5U+w==
X-Forwarded-Encrypted: i=1; AJvYcCWe3GjFw6CiZdSFxmEVE82n1yjry5N2cT4XkXpvn0nv+dWKmSYTG0hNMcVelb+sIe2DBT6BZCTg8Sy9Vp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHSQ2xd/yk4hC2WadLBs4VTVqMu8uOx3o+G8uzlzR055sKGoh
	kyxSDBGNOP74hnPJDGuaR9qYxfonzk5GRDbLhZyvKXD9VpjJYKklDZb67/i+rKw=
X-Google-Smtp-Source: AGHT+IEyn8zxCQI4LXGAW9iUNRNo4xbikPRpAjRbgtUqaUaXloiAyB7z5cxOZVVM4/wdkLLVMNHhyA==
X-Received: by 2002:a05:6e02:164a:b0:3a0:4d72:7f5e with SMTP id e9e14a558f8ab-3a26d742c7emr38512285ab.7.1727278151258;
        Wed, 25 Sep 2024 08:29:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f12e86esm1125517173.58.2024.09.25.08.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 08:29:10 -0700 (PDT)
Message-ID: <7c7f42ec-8d9d-40b6-b275-ef139bcc4b79@linuxfoundation.org>
Date: Wed, 25 Sep 2024 09:29:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memfd: fuse_mnt: remove unused macro
To: Ba Jing <bajing@cmss.chinamobile.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240903044455.11268-1-bajing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240903044455.11268-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 22:44, Ba Jing wrote:
> The macro FUSE_USE_VERSION is never referenced in the code,
> just remove it.
> 

How did you find this problem and how did you test this change?
This patch is incorrect - please see below.

When you find unused defines, do check first if they are indeed
unused checking tree wide to see what happens if you remove it.

> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/memfd/fuse_mnt.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/memfd/fuse_mnt.c b/tools/testing/selftests/memfd/fuse_mnt.c
> index 6936f2a001f3..f9f06fd43c5f 100644
> --- a/tools/testing/selftests/memfd/fuse_mnt.c
> +++ b/tools/testing/selftests/memfd/fuse_mnt.c
> @@ -12,8 +12,6 @@
>    * file-system.
>    */
>   
> -#define FUSE_USE_VERSION 26
> -
>   #include <fuse.h>
>   #include <stdio.h>
>   #include <string.h>

You probably noticed https://lore.kernel.org/all/202409241613.KyXs9fiF-lkp@intel.com/
found build problems with this change.

Also you have to define this to pick up the new API from fuse.h
Removing #define FUSE_USE_VERSION 26 from this source file causes
the version 21 API to be used, hence the build errors.

/usr/include/fuse/fuse.h

/** @file
  *
  * This file defines the library interface of FUSE
  *
  * IMPORTANT: you should define FUSE_USE_VERSION before including this
  * header.  To use the newest API define it to 26 (recommended for any
  * new application), to use the old API define it to 21 (default) 22
  * or 25, to use the even older 1.X API define it to 11.
  */

#ifndef FUSE_USE_VERSION
#define FUSE_USE_VERSION 21
#endif

thanks,
-- Shuah

