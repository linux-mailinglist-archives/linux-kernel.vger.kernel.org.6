Return-Path: <linux-kernel+bounces-344919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACE798AFB3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6314D1C218F8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB61B18891C;
	Mon, 30 Sep 2024 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IctUzN5x"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3631A2643
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734366; cv=none; b=EJNd4EkR093M1sveqauq0yoYd+MGeuInCd97UaTh/zHuy0TYukmFBY8xuooaomoIBQL/j9mJkxWY8KV+eotW5iIYzwFEkwmDs3VRIksZ+4dCH76pq2NIfiW5qJmIJRn6TFjPaCt0jGVCsHiGQ/TdtBiLYxYDcYqCUJmK1tX24NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734366; c=relaxed/simple;
	bh=OuJ6HD0YhG6sS3DJ/fC5Ctolj9yx6iOFSJvVEhOfNiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RA2e1XG12ZgiTwXAfpFEZJMOUiZ5yeJeexpCFjtMbFz5EKpij5/iuHhiFpiYDZCTEmTOCnbhWeqaE8YorV9t2XoA2e4QsICKQKf9GWJwrdkjLbOb7YYy7nCvtvhnTTWh34d8wy4djYEJ8Cn/v6C8Cc0dxmNeYf5ifwvGc79znl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IctUzN5x; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8323b555a6aso427150539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727734363; x=1728339163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvzJHLSjGnSyKfVHRJCVIJ5T2wLxEa5cRWvlQ80yiGo=;
        b=IctUzN5x9hnBsObW7waCuhOhsPyso2kNQALdAsaYpPaoEY6HY/SpacLGJsHY5fRiBc
         /gdfSbycbRN/IPpeFPNJ1xSiLqPth2kMs9jP0monlgOXS9v/5du6vOhgb5xM7wiQJYu4
         8LRe/2UaxGGMwGngkQKislc5dmLRApB3WaNck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727734363; x=1728339163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvzJHLSjGnSyKfVHRJCVIJ5T2wLxEa5cRWvlQ80yiGo=;
        b=UIYr7MZ6CkUYqnhE/lJTFh0oPYmHx3vutkYIxiTE+F33PPrT8lSv1vD5Y5BgY1pQ+M
         R3d0WXRAJCxEk3tJkALJ/pVKhSwF+6jrfd0LRsDGNvLfL43EurP8IoP+e87dk+uciQQf
         lcAIq4GZ1FbtBHMV35pnSFGuMLi7yRnCQpEUJLIYnvAqdf/+AFJVtQCfA8vXpsuSvREg
         j+DGGjetSix8Vk43VEWJa83rCvNrvUFdXL76xVvto5+mJ6TcHRcs1JVWL6NJrmrLNAr8
         zh8XsDusLQwVU/VwAThLZRX7afTCGfXuUgreKIRZupaCYfQhiSHnHcVDX+HyAopgipsz
         VfMQ==
X-Gm-Message-State: AOJu0YyyrujDHelPfUJYtXH6X4OnY+bi8zOd/wLitezTWeFfB3mGzMh2
	XDfd11lM+Z1HSnxwD7nN6DQ4tfamTO4wwi2P0+1SqGTDLn+8pcXo+V1lHKQJJUg=
X-Google-Smtp-Source: AGHT+IEPmKeco7rzyBVd0zeENJ0CL2Q3z1EggoqbGYYGZCwqCddSrVdRG9W5FTk8lXGyJA23GdxGTQ==
X-Received: by 2002:a05:6e02:170e:b0:3a0:a71b:75ee with SMTP id e9e14a558f8ab-3a3451bc0b1mr124460455ab.19.1727734362055;
        Mon, 30 Sep 2024 15:12:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888835130sm2316262173.13.2024.09.30.15.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 15:12:41 -0700 (PDT)
Message-ID: <7dcaa550-4c12-4c2e-9ae2-794c87048ea9@linuxfoundation.org>
Date: Mon, 30 Sep 2024 16:12:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update core.c
To: Okan Tumuklu <okantumukluu@gmail.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240930220649.6954-1-okantumukluu@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240930220649.6954-1-okantumukluu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/24 16:06, Okan Tumuklu wrote:
> From: Okan Tümüklü <117488504+Okan-tumuklu@users.noreply.github.com>
> 
> 1:The control flow was simplified by using else if statements instead of goto structure.
> 
> 2:Error conditions are handled more clearly.
> 
> 3:The device_unlock call at the end of the function is guaranteed in all cases.

Write a paragraph - don't use bullet lists.

Please refer to submitting patches for details on how to
write shortlogs and change logs.

"Update core.c" with what? Write a better short log.

Why do you this 117488504+Okan-tumuklu@users.noreply.github.com
in the list? It will complain every time someone responds
to this thread. This is not how patches are sent. Refer to
documents in the kernel repo on how to send patches.

You are missing net maintainers and mailing lists.

Include all reviewers - run get_maintainers.pl

> ---
>   net/nfc/core.c | 28 ++++++++++------------------
>   1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/net/nfc/core.c b/net/nfc/core.c
> index e58dc6405054..4e8f01145c37 100644
> --- a/net/nfc/core.c
> +++ b/net/nfc/core.c
> @@ -40,27 +40,19 @@ int nfc_fw_download(struct nfc_dev *dev, const char *firmware_name)
>   
>   	if (dev->shutting_down) {
>   		rc = -ENODEV;
> -		goto error;
> -	}
> -
> -	if (dev->dev_up) {
> +	}else if (dev->dev_up) {
>   		rc = -EBUSY;
> -		goto error;
> -	}

Did you run checkpack script on this patch? There are a few
coding style errors.

> -
> -	if (!dev->ops->fw_download) {
> +	}else if (!dev->ops->fw_download) {
>   		rc = -EOPNOTSUPP;
> -		goto error;
> -	}
> -
> -	dev->fw_download_in_progress = true;
> -	rc = dev->ops->fw_download(dev, firmware_name);
> -	if (rc)
> -		dev->fw_download_in_progress = false;
> +	}else{
> +		dev->fw_download_in_progress = true;
> +		rc = dev->ops->fw_download(dev, firmware_name);
> +		if (rc)
> +			dev->fw_download_in_progress = false;
> +		}
>   
> -error:
> -	device_unlock(&dev->dev);
> -	return rc;
> +		device_unlock(&dev->dev);
> +		return rc;
>   }
>   
>   /**

thanks,
-- Shuah

