Return-Path: <linux-kernel+bounces-211655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EB59054F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F40C8B2452E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FD85336D;
	Wed, 12 Jun 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwNHUoEr"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A417DE06;
	Wed, 12 Jun 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201890; cv=none; b=iZ7iU09FrDt46h3DM3wVD3Z1MKzbMsMD6HCy6wiIcUUCs2EJC+lE3X9OOen9ORlTbEkssq56HrL4g75CgbU7L/mrxVtcV7kHhlavFAyqIsKI2EBakw2ArUd4kH7GS6KHUAHycA/q0Q5Hb6egOYC30+1IEFEDQJ8T6VQ1yM3cwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201890; c=relaxed/simple;
	bh=YXIdG8Cu8DfnRnzDjLA/KcUHFB8cUiSt1hLOsWlN2MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPLGwAYo11ZY1zpaHS9Irnl4fotjmU6tNEQz2RcVUbkmwVnNev+gQceIxTSUXCvJwaCf5SsEp2qCJmN3gorR2XhCmUJZ9RGNrub8jm1Zon35aSl/kYtpa1evciJrZxAmTn2RmJXo4xWLzQZSJK7Ek0y87pA6mqh0YeyPdal/K74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwNHUoEr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-705bf368037so575483b3a.0;
        Wed, 12 Jun 2024 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718201888; x=1718806688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pxqNL565NWmPeGrXLhi1hyl8lckCal08zSMZyztgL+Y=;
        b=hwNHUoEr7eB5hmTiHYkQRQG6ualX5wK+66DWuCXq+e05vJ1Q5PlUEpejdSgOB6okG3
         6bg685gdhlvbY8HZNB109JW2fCgyAaIsmx97XFqq26Qnq+UFjNKN4WGYVXLgzBm7j3QT
         Fjswx9hS8tdjusIXNxC1rqDyzc0AawQwXeeKFb5iAAxbsiW7QLt7puiCnNXkNxVVHR8z
         hdHn8k+TAtAApS/VSSBfVsGF8/3W65sObcL3+0HVnP/ei5kh1DvITLuQ1Et4rfLn/ikU
         rrn35968B9yC9BViuYh4GqBYnEGD+gKOZyboySVX6jU2zCq5uEHe+MR5+ekNXtvHycNO
         yEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201888; x=1718806688;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxqNL565NWmPeGrXLhi1hyl8lckCal08zSMZyztgL+Y=;
        b=bimVLO42KczrVxhmSvIpODDKjlt+7HkgzOEuAuhJN0KjrXZsMWTWIOz1aGi4HyMmQJ
         /n7cS4Ls1yJtP5VGr0vIJo0tO9nZmjpbDp+vV4Ij2C/80/yszUZ/cQfUgdL9cgVTFgcQ
         erUcOcRvObFW8Q2wlHrB3MZnz+iDw9EqeARWlaGol1c6wz8rM7odX9dLcmlSnK1VX5gP
         HC0Qny3FUG9FgzjsnEDgpXAUsBxtoyUh4M3jQiU5UwTB2ERiddm8kgKttU4SSCzuXaqo
         YA7Lvk46Tc+IuwMRgjl8+r24fxe/3YATsOk6BD6yIAB5imrT16Iu+66kan29njsQcz1V
         afwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPfNiPE3gJQDDVTNLpBe6Ejd4R8u36myh8I4CqRgJWHPzsKyluNoFGh4wxlwIQ5TDADjXdyp4txXkZajmrkKtWG4MtxdJGc092bIJ7oUeb4a6zLTZMkAu2U75q91gmgC3Vd7XN0SFLng==
X-Gm-Message-State: AOJu0Yw4wGvsJRSVXg3AxAJLQysnwLtzHmWVDrOWUeoQNLEfzZsQFPTL
	AUSMnlkKH8ZchlTqU54CDzCGV5sacSkksz1lAN96hMEW974nJkfVCenPDg==
X-Google-Smtp-Source: AGHT+IHDQvXjMLdL88OFf+YQ7k2+FaY0EqKRh17/5byTfA0vFMPAWVjc1fzka1+etT7NKq31JPWM4g==
X-Received: by 2002:a05:6a00:b41:b0:704:3521:fb58 with SMTP id d2e1a72fcca58-705bceac04fmr2598102b3a.27.1718201888444;
        Wed, 12 Jun 2024 07:18:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70419ec2bfdsm8647589b3a.167.2024.06.12.07.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 07:18:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ab648952-769a-42bf-b7bb-ee13b58f8794@roeck-us.net>
Date: Wed, 12 Jun 2024 07:18:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] hwmon: (ina2xx):Add Suppor for passing alert
 polarity from device tree to driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Amna Waseem
 <Amna.Waseem@axis.com>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240611-apol-ina2xx-fix-v4-0-8df1d2282fc5@axis.com>
 <34fe20d5-c67a-44e6-8ec1-566d80e25447@kernel.org>
 <ef71090e-13c7-4ef1-b34e-d6fe9546b705@axis.com>
 <629a1867-94b7-4f89-821a-a38b92189af5@kernel.org>
 <4af156a3-37a6-4995-a3cd-8340c17345c2@axis.com>
 <2e0eeac2-891e-44c8-a1e1-36ec759d1b84@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2e0eeac2-891e-44c8-a1e1-36ec759d1b84@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 23:44, Krzysztof Kozlowski wrote:
> On 12/06/2024 08:37, Amna Waseem wrote:
>> On 6/12/24 08:20, Krzysztof Kozlowski wrote:
>>> So you require someone to re-review?
>>
>> Yes that will be great if someone re-review.
> 
> You are joking, right? We have hundreds of other patches to take care of
> and you ignore review tag, so you get duplicated work from the same
> reviewer? That's huge waste of time and actually quite disrespectful to
> our time.
> 

I applied v3 of the devicetree patch (after comparing the two to make sure
there are no changes).

Amna, I would suggest to run checkpatch on your patches in the future
to find problems such as the following.

ERROR: trailing whitespace
#178: FILE: Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml:74:
+      the alert polarity to active-high. $

Thanks,
Guenter


