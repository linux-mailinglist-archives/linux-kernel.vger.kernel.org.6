Return-Path: <linux-kernel+bounces-306151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B449639F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8389B2426D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7C514B967;
	Thu, 29 Aug 2024 05:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOx5tUFh"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3D14B94B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724909867; cv=none; b=hAycPNxalo6JD43o1xe30gBCbOWg/xUMihi8L5ykmYJ2tLdGMsg5qgMdqR4c9/6nb+MMrOm/anEqZ5wJJK8gmhy+5+PKUEcItt0WlkrFuBWRsZOhSlK31HfaGyINx8I1MNdTltdKFohv2EPRWUP88o/x09rSFqapqeiUI83NpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724909867; c=relaxed/simple;
	bh=lkk6anRFctndRZTQo8ST3rqb53GeepJeRWThtCQMT4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aqo0Z2HWXq8OWNmTFGtWFBLGDdJ33bGXQrdaCPyy2W5yWrfQzU6knYfiVPFVJ2BCfzcz2ee2ouq7oQFH4ZKNninXGwE1JIQN0ZynEzNOU+sGlotyWOlza5IaBrpQw/Q95aNZgQmuBFns+CSR1w9c7yu9xR5ZA04SubYkSCAReQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOx5tUFh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a843bef98so14750566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724909864; x=1725514664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Mpl613ImjjzIum6yob4Qlo8XGEpDoFGTb4R5TS3Up0=;
        b=hOx5tUFhPYe82xx2gHAYIyQz5uoum6lBjw2XxeZCGzsS8wImmgnVr7IYJQKNLczess
         s9RMN/30NbB0CXK4bDwG7fdfC7xmAH/2J7ZFHfR3ukqMQMjOG68GeVRLMTlHvgqwxCXZ
         BX31qSUjeye4w/4IJxqQnhMabOYHk6wvvUiFV/HPTa3yHcCycKq9/z1vRzYhZBT62AO2
         +xuC1X03AqKWaaaePXa0RncHxXXPrWtimCKs+YAG3MCHEqxSGTs9hIT92/er2zi57daX
         Qj7UvL0rmfqXGAYafPrS0fwcvjZIe/JWZtSqW/gr/v9bdUtawE2eKs7sbYtowUcxRaj/
         ermw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724909864; x=1725514664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Mpl613ImjjzIum6yob4Qlo8XGEpDoFGTb4R5TS3Up0=;
        b=EQvar4MFGZTkbtPznxp4EZkbOOZbFMTesiZsZmvfcYo51z7x6ui3XyfxMSA5RNPenQ
         x/cq+ICFhMkqQlzx0dgnLVRMolCJ0EcwmKLB5tqZeHizBSr2xsD5Qhnilx66YyKfJn+W
         2sMbez2HZ/ADkMWuCoDSQY2VcXjKIQP2/OmYzIwKYzjJO0rsshGxkMMwNbzzS0MIOjFS
         k5/gWeXgzTOWTSTMDDfT5blhzGEs0L06reH/VQh+DPctpu2LXRmSibE9BLKrPABXwYwP
         pP/+NBWMkZyakZzoKY6vSTKNWevHKBjbceknKzxWm4bqtpH+Zvj+3WNnaY/YiWkQEgW8
         ij1g==
X-Forwarded-Encrypted: i=1; AJvYcCVgAw8lkgga47LjoRmPW7rZ/ng3bBWeMGeC4Z1prQHp8Tmntis8u2Dm+h2YDz2aiBQ24BiXOzCFwTI9ZsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp6RtL8snUBAeMDgLEdRWBOJpeETkaRkwQGESDZtOebju/ap3p
	8OYezNN5BzSyUYdvYIPa422ufpoTTysHMgWxdHo5IIAiv2Id5U0y
X-Google-Smtp-Source: AGHT+IF478ZX6mihGbhF8/Ix51ceNwaRw26Ei+3LxKfnJGJbMcL7UmotJXindpua0hcV/Qn1ax/abA==
X-Received: by 2002:a17:906:f588:b0:a86:7a84:abb7 with SMTP id a640c23a62f3a-a897f83b28cmr113530566b.20.1724909864088;
        Wed, 28 Aug 2024 22:37:44 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f079sm29667266b.66.2024.08.28.22.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 22:37:43 -0700 (PDT)
Message-ID: <0c76ca65-acc1-4167-b2ca-d6d7ef0b5c64@gmail.com>
Date: Thu, 29 Aug 2024 07:37:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] staging: rtl8712: Fix style issues in rtl871x_io.c
To: Manisha Singh <masingh.linux@gmail.com>,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240828222153.68062-2-masingh.linux@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240828222153.68062-2-masingh.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 00:21, Manisha Singh wrote:
> Refactor the _init_intf_hdl() function to avoid multiple
> assignments in a single statement. This change improves code readability
> and adheres to kernel coding style guidelines.
> 
> Signed-off-by: Manisha Singh <masingh.linux@gmail.com>
> ---
> Changes since v2:
> 	- commit message updated.
> 	- assignment done before goto fail.
> 
> Changes since v1:
> 	Broke the patch into 2 different fixes.
> 
>   drivers/staging/rtl8712/rtl871x_io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
> index 6789a4c98564..378da0aa7f55 100644
> --- a/drivers/staging/rtl8712/rtl871x_io.c
> +++ b/drivers/staging/rtl8712/rtl871x_io.c
> @@ -48,8 +48,8 @@ static uint _init_intf_hdl(struct _adapter *padapter,
>   	set_intf_funs = &(r8712_usb_set_intf_funs);
>   	set_intf_ops = &r8712_usb_set_intf_ops;
>   	init_intf_priv = &r8712_usb_init_intf_priv;
> -	pintf_priv = pintf_hdl->pintfpriv = kmalloc(sizeof(struct intf_priv),
> -						    GFP_ATOMIC);
> +	pintf_priv = kmalloc(sizeof(struct intf_priv), GFP_ATOMIC);
> +	pintf_hdl->pintfpriv = pintf_priv;
>   	if (!pintf_priv)
>   		goto _init_intf_hdl_fail;
>   	pintf_hdl->adapter = (u8 *)padapter;

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> AW-NU120

