Return-Path: <linux-kernel+bounces-366885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7DA99FBCF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E611F24694
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191041D63D7;
	Tue, 15 Oct 2024 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Un9LAJ15"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0621B3948
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033009; cv=none; b=ZPaS6fgdTqVd7nJYhCnAvJhqjVBA4iIHk8mVcVpstIVTMO7O+tN4+a83wZ0a1P5o8bjTKy+PQ6wADnZI5b/hX9bBQhNS86jp6maaTpCwpyBB9O2ui81p/MMiv/hmHhy4cKODfbQqScIRyzgYe7dSJkC/pqHZGhcOUTfpsmkRJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033009; c=relaxed/simple;
	bh=jMeRwO20l5JpD+DQduUGcATCU9gZoGqu9rHPJtVdwOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwX5TCgNmlz7+GGzTiabi2PlxLkUOFDxNzk9oOYKwGxLEdVai0K8et7y6/BfvwQx305UFy+bBLxGRu1fWjtxR4u50AvSnO6YluDOIIA69bM8OjufIMzsAJzNUYIw5u49xZgFxBGBwHfA2czL8pcyPSLNMx6xCJqlpl7pn0XRqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Un9LAJ15; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-837ec133784so172482439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729033006; x=1729637806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FjlkyL55BEA/LHXfBh8aUrjY1xF4pwwamxqyKY1rGNQ=;
        b=Un9LAJ15Tp52Vf5PFY/Nmn8zo8ywYTS1hCDoDOy8E9lY7KhYff4XKU17mMxYmWI0k+
         WZ69aDM1dqABa+YwBu8kiwSgmpmI1VzuskDJcDZJLbVBzSCOKpUnHRHeyNq7aAWiQQfM
         dHaCwT3uA5Bz/MgJmHpIh+6eODAiTaL5zYaFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729033006; x=1729637806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FjlkyL55BEA/LHXfBh8aUrjY1xF4pwwamxqyKY1rGNQ=;
        b=NtSv6bzbGeVNyYjA1pIUtUsAG4xnoOY0K4W7fQ4OWZWj3J1+5V9th1oIu4kOV1liki
         l/EXffNXVxp+Q2ZxmnwxkH09ibVLkEWQHhNjTG3RTQAtYdEu8E69bzyF46MFQpRWvSPn
         dg7Btu3Fuo5KrEHDDAEvTMp7dQ7p0Tt3Ce7aHp62jNQqYIR+ABPFeAO58uA5SeQjUVqQ
         USPDbI8JUeEvqQcVvT67oEOQKhRpbViSwCmU2wpt81RUjGCPaTch1PKtlJwaB+mVIWHU
         UEkSRpNaO3iaaPROHzIGBYBVNFnjs5CXAPRPHYQb4ow9AGyffw7bqhC2Sc+isfkubSDY
         TqxA==
X-Forwarded-Encrypted: i=1; AJvYcCUXsWnCnbPm6Xkr8M8PysgpHe/VOHxQ+DXmyw++ixYNsikx3VjRL/BrSzOXjJBQlcGylD2wTJf96yv6c3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLUgR0LFO8SuJWQ5bYso082Ci24Ppmh8Fro7bZqAxLHNLwHBM
	az60paQx5XfJDwOWalc4ELdQaZoMc+2KOSAG8hWBNpjEQc5pCyB1KKpdrhhdOv0=
X-Google-Smtp-Source: AGHT+IH98mTXWtwBQGO9LPwwOZt8H5IzAX/9kllbYRhcvWaX308QtFiL4ugqrfFKYOJSCqaBTaRgoQ==
X-Received: by 2002:a05:6e02:168e:b0:3a0:451b:ade3 with SMTP id e9e14a558f8ab-3a3b5f6b26bmr148652045ab.10.1729033005914;
        Tue, 15 Oct 2024 15:56:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d70747edsm5306855ab.7.2024.10.15.15.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:56:45 -0700 (PDT)
Message-ID: <ca5aef7c-4569-43ec-a1e0-a4b9e1c63daf@linuxfoundation.org>
Date: Tue, 15 Oct 2024 16:56:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: gpib: Remove unused value
To: "Everest K.C." <everestkc@everestkc.com.np>, dpenkler@gmail.com,
 gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241015210300.17941-1-everestkc@everestkc.com.np>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015210300.17941-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 15:02, Everest K.C. wrote:
> The variable `complement_count` is assigned a value which is again
> overwritten in the next statement.
> Fix this by removing the first value assigning statement
> 
> This issue was reported by Coverity Scan.
> Report:
> CID 1600790: (#1 of 1): Unused value (UNUSED_VALUE)
> assigned_value: Assigning value from length to complement_count here,
> but that stored value is overwritten before it can be used.
> 
> Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
>   drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> index 1da263676f2a..e19e18892468 100644
> --- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> +++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> @@ -759,7 +759,6 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
>   	if (!out_data)
>   		return -ENOMEM;
>   	out_data[i++] = 0x0d;
> -	complement_count = length;
>   	complement_count = length - 1;
>   	complement_count = ~complement_count;
>   	out_data[i++] = complement_count & 0xff;

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

