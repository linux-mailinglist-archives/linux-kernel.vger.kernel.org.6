Return-Path: <linux-kernel+bounces-557745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD2A5DD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DAB77AA63D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0723244EA1;
	Wed, 12 Mar 2025 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNMitbK4"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314923A9B6;
	Wed, 12 Mar 2025 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784161; cv=none; b=oSdIrxOfaNrId4NhOs5nmv4WHynKcZUmOGYs6LgvquqfxlWSo3seZWcBCOLqvbk1FFhhG/fw6rY+7598/pwn3DQ2sz1Gaq2JtncLFCJMTa+7bZep9n8qCU/AtvsNdXM7yLsJmWZpdP9nbyfcdi8brdlM/UTMHbmRVmXWatD/lCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784161; c=relaxed/simple;
	bh=m752jzKuXs1015LB95B52b/mMal0yvInOt6e91a6Rig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bt1597Qrf5nIoev7sFbPY5EcvsZthbQlxkUBYsq+AsEMA+GwVJh364uuLmYZSiZwK7F96dJOcpSlNO0BtCHfA/OVLSjnUPqki0Eau0fZshKPe/oYQ6/LfqIHIZB/1dKRQvzDqc22waDI6uuL3XH69u/ojNjmblvtbxJSbPsiqIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNMitbK4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223959039f4so132849925ad.3;
        Wed, 12 Mar 2025 05:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741784159; x=1742388959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eym45oKm+OA7GJAGr3OieSc/8yhtuvItR6ugQDb4d30=;
        b=QNMitbK4onbs/c6CQlCAoaqt9nV+hkIKILlx/LJk1MlNQzjuKrtChqMbkjOsXMGVBK
         bGKmPE38Fuu5kdMwRrc2l+OjOLcEcCbZg1toQWtSCbz7pbcWLjI82ghyqgJHUPstw8iv
         kUo429PfoM2aUKrphcY5CdTdRTlL3JPQhs/IFfsKU456xsAhbZZ4BdBW5IxED+L6AUeb
         xCG6sSkRtnxXqOayFHv7mZqvNCKANLvRKt3W+1mTn5Op1JkguxUsNR+FLTerrToVFthx
         N2ajkgZZSDNquHyKDY0nCbdyPMWXv1FfuuCCEQQIsfrEGCRfvy8HUDHFl4A/xQTbYow9
         lZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784159; x=1742388959;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eym45oKm+OA7GJAGr3OieSc/8yhtuvItR6ugQDb4d30=;
        b=H66ZMWGw3MqOdOt94PqoyqJb4VV7pOC/oGOdbXomEwnO2qxZn+nfvxwVSM4J5lEUa3
         vKUo6h2s1eKi1v7DDF7fJgCs5Uq4CXtZq4BuJXwANnvJVuUFcPneOMjOITlGHFQAHgYB
         f2Pw5N5S2LYBJ+IGY/HTADOj3XaOHKdrJ+G3zaeafm9G7W1ivpG8CIE7rXbziC2/dnTX
         8Cd1lQc40ckasG0clSqy55jV09eRbVMAs00uCFKgXUwScy8arfF8eAAyV3fGVIlZJI5X
         HNHfUy+aqe/Etv4whr4syuEYhB4OGGEViGkooNFFfi5Us5xdCk3JiqpqBsCEbDJlur33
         am9A==
X-Forwarded-Encrypted: i=1; AJvYcCWS/f9guF3tOoylINPbKG6gWVJpkl9v7dPhIUxlFBdR8Z8eHUGzKfYc9LXlhD2aaeg+7x7K/+WZiKwYG2bK@vger.kernel.org, AJvYcCXRc3n4E2Buz94oOI6nDdBwgCVJi8ZxAtcTA8SswcQfPMdCbX9/Mn85AkUKRqn4diC3XhMD9U5rGcsIXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKUhrxJ1BX1tZc08xVyDydLRYuSeSb0WU4TzauQDSK76+PfNS
	ybsxuxyoAaVW340dGJw63KqmxxzD8Y9cG7k0sUyDfgyoRYehTRoJ
X-Gm-Gg: ASbGnctOpeetJsayTcRrmM3x2LgKb3vnfZKk04FxLtA+fhJj0EnRoUB/BxY/OWXOsjL
	gvq5N0LBfZyAso6YNXtPsIOgbgIKaGAYcbnlH0cUke/9gxrWZaDRGaKq0Veeq1u+GxSwtlllTbh
	UXDoBIEC6fhGNU8YbB8zE0PVNbkuwEeCrFri7SppTwvl072fKpOk8KAOGqJYDK59eFtDiwZCpzX
	L3Hw0qXWciPXf/fV+V5FWJc3ftCiYRIcC4R26ZSkzYUBIvyAuv7McmVXsJM76wTi0Y63pIVtfSA
	H0pZByHIYvMLbpQsuqKe/+b5g28TriWM/7hnq1c7xfyLEiKeC1+z4JsBakgAuoM1qj9Qb+oejmI
	Hg2rIHhDABFHMqbWxDZIExmmNb65D
X-Google-Smtp-Source: AGHT+IH/RhjuvbllU1lf6q0ffvOOvQgia+o04XWNrakfWolu5n7J3aPbV3KFOvRFvxWyuMckr6F0cQ==
X-Received: by 2002:a17:902:fc4c:b0:21f:7077:2aaf with SMTP id d9443c01a7336-22428bf1715mr392334475ad.44.1741784158875;
        Wed, 12 Mar 2025 05:55:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e8587sm114697645ad.62.2025.03.12.05.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 05:55:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a148578c-0eca-4646-9abc-92684de4b9e1@roeck-us.net>
Date: Wed, 12 Mar 2025 05:55:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add support for newer macs in applesmc
To: Subu Dwevedi <messigoatcr7nop@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Jean Delvare <jdelvare@suse.com>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250312123055.1735-1-messigoatcr7nop@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250312123055.1735-1-messigoatcr7nop@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 05:30, Subu Dwevedi wrote:
> This patch series adds MMIO support for newer Macs in the AppleSMC driver
> and enables fan control for these models.
> 
> Patch 1 introduces MMIO-based access for AppleSMC on modern Macs, replacing
> the older I/O port-based access where applicable.
> 
> Patch 2 builds on this by implementing fan control using the new MMIO method.
> 
> Subu Dwevedi (2):
>    hwmon/applesmc: add MMIO for newer macs
>    hwmon/applesmc: add fan support for newer macs
> 
>   drivers/hwmon/applesmc.c | 347 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 314 insertions(+), 33 deletions(-)
> 

Isn't this the same series that I have seen before, pulled from some other repository,
incomplete, and without acknowledging the original authors ?

Guenter



