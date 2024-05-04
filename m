Return-Path: <linux-kernel+bounces-168693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62208BBC45
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 15:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC242822FC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A6038394;
	Sat,  4 May 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE4gRyoP"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259211799B;
	Sat,  4 May 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714829876; cv=none; b=bRMLgBXgo2rNclPAlT6yOmo0DUaWfUv1MLTiJ2xiiWAQQEWIgcfvSVYDBlskQyGYYuhYNa4sc+rwENXDJX/KC7XiHuRWiYBqqbuXcmxvBDyVwAZfRf4jL3kNsbAe8SbKngBNgbJqEIZwHq0rDmEk07T9nS9oAbbdKgqH1HgSLCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714829876; c=relaxed/simple;
	bh=+CJXx3koQLYN1B1om5/4IRE7tuuotyHp4wQJJOV4Vyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jmc+pmDt9wTBjduBAGVI+40te2lMojLzTx1QshrTTU9qLR1fiW5leayQNOCkFVm3V/stHqTBsif/ZztxV4JB5XpOo+feDq5Zc4kTpbiOh6nUp0VPKoyhvGUaeNwzk5l2f1seBo54PenDSivPcKvnurNoc9A56xzXUcFjZPEv+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE4gRyoP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3ca546d40so4416355ad.3;
        Sat, 04 May 2024 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714829874; x=1715434674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4EGKr6FjTAXUcLBcVBwQzJVvnJMccoMO665tE3tYfk=;
        b=RE4gRyoPM+vc418Qme2SDkwP4l09xPeJ+GkGZSevFmmLRDByhIViApofW7UGvPj8/r
         3RBxmZreXZNX+eX8oi17QpcDBJGUwXQJhZT0dcKwv7GfZMXrbJU7QCnPwivF6jt9zh+Q
         7Xwqy6LMB89c4jM60OeouxE+Ej7xHEPUGzfVlpnrf4AM12KZyEH7X3aod1lHq9U/tv4R
         HwjDNLnI0Ho8jleWFXgYkUHSP0fPP5XVFtfKcEs2/CUaXnb+KDlm76UG6OLzzu4PlJrU
         zL/RpMhAgnHuW8xnmmcw9OR5pDNS4RFBvJLI+Rol4py0vmo7cfrAu8rfVpEG49kJEapL
         wYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714829874; x=1715434674;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4EGKr6FjTAXUcLBcVBwQzJVvnJMccoMO665tE3tYfk=;
        b=J0sNX55+ZvYCwGb4i3z8pzh+4bDRWgTQPgxuJPwp0KswbLbmRBVnCwUwLrp6cOO+cF
         3r0SdxzswrjxRVn4txf3Vcb5t9t7noY1/Q+QC0hgq94tMNJM0f1TvsRjKm3zRq8khAyy
         v6vU+5MRuRguYnV5cZsXMusl8l/YW/cmOqBY+3QWp8Qm4zZ943dsC7NrPx3Pesq1PUkx
         N5Q7l3S2u+bAJvq3lIe5VrW/QugMucCb/VSSl8qY+phm7iTM3DzEdNjkGKcNjYpjc55y
         yQRFTgXoZrCMZsf/Uo15mJVkLjd99CZuT3vayWlMrNAxKwg3nNBKe2SvzAJsCJspylfu
         rnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCULlN9qMLTtM2xm9gNermFDpLejoHtPoo97GkB66By3NjQ75piX9oH6jxKt8FzPDHuOwRy4Brkk/esv+cpA0woR8D0Gbw7SBrjcPYsSoZk61DyNZhiLetgTXH4m3mWrsm9Rt53AfdIPc/8=
X-Gm-Message-State: AOJu0Yzftu+rsSwt4KaE8PvWUYxYuQfEfIVAJRylfSgZrzPKyf3nt/d2
	KQx/7XR7zU/aC5fIvLmG8eofgle01vdppnLzXpcUXoTrsHueBms2
X-Google-Smtp-Source: AGHT+IFg3r+K7gDnBpuBLEs/oU52paelf/WsWsHygn8lhr7kEz7oFnEyalsYUgRJVYpszLi2o89SpQ==
X-Received: by 2002:a17:902:f682:b0:1e4:3c7f:c060 with SMTP id l2-20020a170902f68200b001e43c7fc060mr6182311plg.66.1714829874263;
        Sat, 04 May 2024 06:37:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b001ec80dbb8b1sm5009265plh.73.2024.05.04.06.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 06:37:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e85861b4-b129-48a0-9ce7-fb912d4eda34@roeck-us.net>
Date: Sat, 4 May 2024 06:37:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hwmon: (corsair-cpro) Fix issues when hidraw is used
To: Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc: Jonas Malaco <jonas@protocubo.io>,
 Marius Zachmann <mail@mariuszachmann.de>, Jean Delvare <jdelvare@suse.com>,
 linux-kernel@vger.kernel.org
References: <20240504092504.24158-1-savicaleksa83@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240504092504.24158-1-savicaleksa83@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/4/24 02:25, Aleksa Savic wrote:
> This patch series fixes the behavior of the corsair-cpro driver while
> hidraw is used from userspace.
> 
> The first patch introduces a separate buffer for sending commands to
> the device to prevent it from being overwritten thanks to a hidraw
> userspace call.
> 
> The second patch replaces the complete() call in the raw event parsing
> function with complete_all() to signify that the completion is done
> until reinit.
> 
> The third patch introduces locking for the ccp->wait_input_report
> completion as it's touched in functions that could be executing in
> parallel.
> 
> Aleksa Savic (3):
>    hwmon: (corsair-cpro) Use a separate buffer for sending commands
>    hwmon: (corsair-cpro) Use complete_all() instead of complete() in
>      ccp_raw_event()
>    hwmon: (corsair-cpro) Protect ccp->wait_input_report with a spinlock
> 
>   drivers/hwmon/corsair-cpro.c | 45 +++++++++++++++++++++++++-----------
>   1 file changed, 32 insertions(+), 13 deletions(-)
> 

Series applied.

Thanks,
Guenter


