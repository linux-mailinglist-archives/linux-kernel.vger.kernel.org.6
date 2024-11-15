Return-Path: <linux-kernel+bounces-410794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC479CE10B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F1D1F213B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252AE1CEAD1;
	Fri, 15 Nov 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEnSk/my"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C3E12F585;
	Fri, 15 Nov 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680087; cv=none; b=ep1QLWOyTVyda0cSHeK3CaN5Wjg6v2cLt4ZxNFf3aU64EyVRiVLYo9L4iQrhMKPcNIiNKXQ3Bwo7HBYRvpvXVBE3snh/t+xmjqePzEQqm6aeWO12znaVjLy0NPOcNr141+Sdq5a+ZPOcut7l/y9EDHQ4wdtfaX2Fbr8bld+Q7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680087; c=relaxed/simple;
	bh=yuUxLc6D9XDcKQf5JNUqqHuRN/tBQOk/83njnKGYMhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvQsm9Y8U9ZKZVaXQJv+YMDir1TZIT+RTpn6IuyI3mR3G5o0L4eRMH8omI9URF1EUxlo8bMjA9MB3hqe2L4kle3sQHZ/gNEzKGb9X+L38iYn49yb3VGX1bqgjwXVP6JUYQ1ry67vFUMXw6ljinsgy+UBgW+TQUHxtkNDY3RZ0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEnSk/my; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f4325168c8so462618a12.1;
        Fri, 15 Nov 2024 06:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731680085; x=1732284885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hdBOW1zRepWzxo6HoqaQG9xnO62A2hy2qcPfPGGea4c=;
        b=XEnSk/my7lOiQgl27slwHVqDx+yPsDXSpuirz9HeK/Nf8TMdNZ7PgPNB3atxP7b73K
         gD6ThvLXwWfWel1xqqxV6a5cOlnIDWn8XP0tpkVd+bAcqKTULW4BC9vI6/yKTNf0yT+a
         nPe035ccCrs7AIImrXXS+poN+otqgoLswKXvsjES18oRJP8F/Y/vlD4FKRrDLteIomFx
         IVuq5A1+XaP4Tqq2Hi7xeGuShRFLcNIXqNJ8nHydnnaLa6ZcdD0lPrhbExgirx9bBLY1
         d+JWEBf8yAUUwMVmuRH9iSRtL8V1Z5fV2om3ciXG2Yb6MQbHL4SazBi7e3FhX5KvGgod
         YsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731680085; x=1732284885;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdBOW1zRepWzxo6HoqaQG9xnO62A2hy2qcPfPGGea4c=;
        b=TVyAtRawHwtQZQ/aCLST1bjj09t3owf745vdgegdlLPsGX+knnoAT5w9urnIiS/IRZ
         MTQxwb12rfdLfJ5TJmGgg1Q8iSO2klTKKen4jUzP+E14LSIilGeRKZU4UXZOWoLGfrNp
         Z8Y3Bag+csOsiF2lV0COiuzK5A3lv7GoYr7cmKWcbjNEczPl3Tryk5Lz2i8Z4oXuVxAe
         RBvxtez346g+MEGHtetA+I2xdxDoNrgAY7LJjdaxiJLFcxKx9rZr3imyoEsdG07KDe3r
         MUpOBqNp8riVM1jqxdcTBQIRDMs8VbVBLlihcp2/jRuFPDIzOJNyySp9Z/tz+HP5eT8T
         s0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVndHk2TC7CAeU1gWKzK2Y9ssiCzqLmnJQTTx0hbUz2NzP2ZZUUBi6Qr//Hq41ouoDlbHksLhaSbHhyug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/nq+3eeU3O77VdQPprGYXsbX9S5HXjTnwugXI8zXdlPNM2JwV
	DufdSnxPBdXZzJD7P5xlQfqEaOfkQmZifMq/ZuwBDwipqgG3IRlm
X-Google-Smtp-Source: AGHT+IGK/02FFTC7YOI/niGeLPbTMoZLhSve589dyZD2gBsgiynD5eXWxGcuIJMyk1BK0mlGHGxiDA==
X-Received: by 2002:a05:6a20:2447:b0:1db:de38:294b with SMTP id adf61e73a8af0-1dc90c1a822mr4069520637.38.1731680085029;
        Fri, 15 Nov 2024 06:14:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0de2sm1371493b3a.116.2024.11.15.06.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 06:14:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a44bffff-f465-49a9-ac02-f4d04f59c797@roeck-us.net>
Date: Fri, 15 Nov 2024 06:14:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: Add Congatec Board Controller monitoring
 driver
To: Thomas Richard <thomas.richard@bootlin.com>,
 Jean Delvare <jdelvare@suse.com>, Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com
References: <20241108-congatec-board-controller-hwmon-v2-0-16e337398527@bootlin.com>
 <20241108-congatec-board-controller-hwmon-v2-1-16e337398527@bootlin.com>
 <609715ff-973a-484d-9267-ff80be7e36f3@roeck-us.net>
 <c4eb5a59-4551-476a-aa03-06849dc9680e@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c4eb5a59-4551-476a-aa03-06849dc9680e@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/24 06:00, Thomas Richard wrote:
> On 11/11/24 20:31, Guenter Roeck wrote:
>>
>> I don't understand why this would be needed anyway. The current channel
>> index is well known, so adding or subtracting a constant should do it.
> 
> My first idea to use this macro was to avoid issue if a new voltage
> sensor is added in the future.
> 
> But it's useless. If in a new generation of Board Controller a voltage
> sensor is added, it will be added at the end of the list.
> 

Exactly. And if it isn't added to the end of the list, the array with
the sensor names and types would have to change, meaning a new array
would be needed anyway. If that happens, it would be easier to just
add another constant for that second controller variation.

Thanks,
Guenter


