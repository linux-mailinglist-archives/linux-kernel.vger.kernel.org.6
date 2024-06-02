Return-Path: <linux-kernel+bounces-198445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBBE8D7844
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 23:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5504281344
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 21:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA8B78C87;
	Sun,  2 Jun 2024 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj0X2ubC"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C67E572;
	Sun,  2 Jun 2024 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717363451; cv=none; b=jodjEDo0o2libRw9yEiOaWv7Yb7QRBIiFCYc3t8bQRjNUp07e6UceUZSyrUl1MF9VyGDK7Vu/DkZicVJHiSn2Ra2qJwpCGTxxQNQ0Updwx6BywnNRnUyi3EmXdbe5qni6G2KsNTjtoXlpsthbaVNYc9+VscHTOGa3qxy4wYNVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717363451; c=relaxed/simple;
	bh=HFX5ILZb9XHa3gXdR28+3+3Zxyeb/56o6mcwZulKFNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K9dLFqvFuIcMyC4yYS7DpSZY3SLxokdHbrASiOUrYUuG4njYvQlw4UnEMX8fZ6EEZKVnB44meF4XcGCTJfM/hayA8ePyN6DCf2fdrJUHFOg9h21Ng9T4VuyoF7nl37yZ4gsaq/TIHE6RGHP6fCgl6u5msBg48hJD1oyvbLCGXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj0X2ubC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70260814b2dso597362b3a.1;
        Sun, 02 Jun 2024 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717363449; x=1717968249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fehWw2Q3hvuPjotfkHtyslpO07/fzvMRkA6Gu59QBjw=;
        b=Yj0X2ubC6VfdeeCxPioWWSyRKTgDUOqEAefzDvDxVfJV0WPPqP4oGjvX+LphT93YP3
         yZ8cgwSzo7VMj9nN/n44EKAUwcoedRl41oNJd0dVZvJ8708D+1uJ+n6EqfRGH96z5kE+
         MFVj5E6DbJ8K/35Zh0MMYyjwTx/VT1ML3BFMXm7tTVWJth+VSnRjod5jSGD+vl8udf1j
         3X+rCSJVNeLdqCMBwIfP5FAcJMBj9JbHxHaF5TUcS/Wa312c4iIznB1Oczsr6UkWuBrI
         1K6jBXmGJ8k8kF/oPkZbaYMAh0uw4t4Sntifxb+3fMBH6rB2072Z3hibSdz5xdzPCRkN
         Ml8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717363449; x=1717968249;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fehWw2Q3hvuPjotfkHtyslpO07/fzvMRkA6Gu59QBjw=;
        b=wDlv2tUEDFtIx5seZrHdiisAJK9QhHlSI5kKTmGdPyJcs+meaFieZp4LjiqD5GxUPa
         P+NL4qfX1k4jZQ00CBJPULsuheCr1NEghZwytd1iH9Xfr46FDMTccjJzCgrOGFERxKHx
         +xlfApnn969bMGfmiYLoHXHBE9aYrb1QgcZN6ilR3ROXyYeka44shUy5Wt2GXkwR6UA9
         o50ZcftEH2TQxCIC5m6Ybdiq/hT4P56q9dbGeD5dRnGufdIRfr+cuVtTGTbIO/FjToxx
         AT44MVfnBAKoD9TZ2jx07OKkJMxQaHEahcH7C9rzMQ1Cxz4T+J0lSqwNoKms9RO4k8m9
         0tfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTHqMOAoEdtv/URyXj3qNpAZXhFJuGiXqMssflmGM+N1SO/OOlpETKZ0Evoj+3DxHT54MAFEQAgywnCd0tQW9heqbUBhNXOWmKkCiw9p3DX1b+ai1LVc2/2x1cTsGtAKuzRInwbSoGVtCwbrmd43EpuyPF9w/jrbZm/fmb8HfRSlzd/gQM
X-Gm-Message-State: AOJu0YxEOCMZtEXOYx+Qp0r70mEU5mTRzqvKI+goP36CRFVsLtLdJOky
	0PGv4+Wrdqj1DXe73DF5Em3d+7Lf4Vbf0jSCuDjx5Qu0+jd0Fy9W
X-Google-Smtp-Source: AGHT+IEBjUw67Hqm1wHcerEB8j86G63QD+b2PrXRxZCKYyRLaATXQhT2nKupBBGnvOtyRUojGVzuFA==
X-Received: by 2002:a05:6a00:4fd6:b0:6ea:ed87:1348 with SMTP id d2e1a72fcca58-702457ab646mr10610871b3a.13.1717363449076;
        Sun, 02 Jun 2024 14:24:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423cf27fsm4482032b3a.12.2024.06.02.14.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 14:24:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <006ab9a8-f1d4-466f-82c4-eff219ccf617@roeck-us.net>
Date: Sun, 2 Jun 2024 14:24:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] hwmon: Add support for SPD5118 compliant
 temperature sensors
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
References: <20240531230556.1409532-1-linux@roeck-us.net>
 <20240531230556.1409532-3-linux@roeck-us.net>
 <uvikiflwuoz3szchmvke7p3ymqvcngkydehk6cctdv24cxsh6r@7d5vxcvdca6l>
 <e5d95d3d-1ca5-43f1-8c17-d24bd38f28b7@roeck-us.net>
 <baktuhx525cyrxam63z4oyy62p35s3n7n7wsv3yz6opyoprp6z@vtxlfwdejdmt>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <baktuhx525cyrxam63z4oyy62p35s3n7n7wsv3yz6opyoprp6z@vtxlfwdejdmt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/24 13:18, Wolfram Sang wrote:
> 
>> would introduce a cross-subsystem dependency. Of course, that depends a bit
>> on your position about such dependencies. If I do that as part of this series,
>> would you Ack it, or would you want to handle that through the i2c tree ?
> 
> I would ack it. If I'd have a conflicting commit in my tree (unlikely),
> I'd ask you for an immutable branch to pull into my tree.
> 

Sounds good.

Turns out we can not entirely remove the detect code anyway.
i2c_register_spd() depends on DMI support, which is not a given
on all systems supporting DDR5, and it is limited to a maximum
of 8 memory modules. I'll try to make it conditional with a
configuration option.

Thanks,
Guenter


