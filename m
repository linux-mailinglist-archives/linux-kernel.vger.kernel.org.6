Return-Path: <linux-kernel+bounces-446517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D989F2547
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 19:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCA9162D8A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A9E1B5ED0;
	Sun, 15 Dec 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu5kMjnu"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0685F13C8FF;
	Sun, 15 Dec 2024 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734286992; cv=none; b=HdvzpwTwM9KxCUviKKfr/+rqqEn8xNBYZO80K8Vg2ORLnoRGdj/GUs/LPny/K8c497ntSmDB2mpRsCxNBz9LhucM/vLZE7ygKeIIDWM7C1NmeX/kwcvKkimGlxMNcNXd5EAVON4oULx8kr7lf5YUshnKGdwpSBWTqgtYgyc6EVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734286992; c=relaxed/simple;
	bh=qu3wlW7Uo9zD+xVeSo7k1okCq8Xzu8vd8wDtAvHPJCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDJoqWBHjxrFP1Glajnr2keOcdP3+mMUgBVdHQQh3GRJVy2PYphGr6avGHLG58FW3VrITvanghrCMw16Z52cgSp72528XR89DgKJTqn2YXcHN1aAiVo1qXjZT7/jenXV6r7eFElT6hxtztM7Tvim8VR/ALJiaNugQRunXPbEPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu5kMjnu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725dbdf380aso2598636b3a.3;
        Sun, 15 Dec 2024 10:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734286990; x=1734891790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VB5U278Ekvx7PUgFX9oou4aB64U2gIbAQihOlszjNso=;
        b=Mu5kMjnuELfsbS1UXuUKRNBQSMXrrqJBgm/jun1ug5Z1BKB9NDKbmfYYwhcxPhzWQS
         NzNLmrpyLmYjABcc19Q3XHK0koRNczs1V4URxwVM/Izyj66TqmAb1Jz7cyDnZ4tDn0TM
         DvYQJojgoViUlAXGv4sHHFV5R37TEIAkEAM1W6upVvxAmWHSnkXY2LzVMmdgoEtAb7MU
         yrQXZxfCre8P/BhAXMANeTO5+RAqrT9P2qo+X5i55q+TBUJIQFj9Bhb13Ph+3EGWIOxs
         WO45d5o9C8lGSlMWbqBPpS0MbOZ2NaiifLI7reALn1YZYHsDCsJYbnWzZO6qikVGA2j/
         +hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734286990; x=1734891790;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB5U278Ekvx7PUgFX9oou4aB64U2gIbAQihOlszjNso=;
        b=m4yI2ZqCwp8HD9l2UUGzEr2i0mmJv0yBzM4+Vc6QJtWv4Yd8oJmAocqJm74H/GEYeN
         MrC5XxNrmGkQEX7zJqrFE2D1cPbx9VNAImnPUCVd0GVmUzPitWMu/Y8J7+Q4EFvvtgRy
         tO+/gjjhfLt5wn2/24InCA5N1o3hyGW7ehKIYr3pKdE5ucNFxu+PghUMQ4R8Gkj21aq0
         ygW62SpENEsQYrcmcUQOhCthU8e8X4AfgwdGHgcZwNmZB3T56YACWvB5vUsTHbkdW2Z0
         CGNFB4uSO83rF/74NEBfStRCx/HCpvrqPThMQtVuVBtPVAIVUYmJSXEl6uuQrnLnyfoz
         ljZg==
X-Forwarded-Encrypted: i=1; AJvYcCU/2honeT1/68m+QeOLHqf339uDRj5cyszfWRH4iMSj0okuVOnkXAVyOf4cpRbjbnaMcO5JNncGgGXePihs@vger.kernel.org, AJvYcCVBdrNeLyujQ+QqxJ+j/SNZuYXrD21d3ZHbdJTKP6eyGrSeUNuPQtzOBH3rWXIuPRhEoz+ygE/NRuL3NDVJXgFtMZHFvw==@vger.kernel.org, AJvYcCX52qvtXjSsLl6/O68OFsG+NjTVQYogOjNcQO/9hpeib0fgfcchsrzhGAMjmRn/El1QtYWBTYYEGV4=@vger.kernel.org, AJvYcCXc6nkQpjLithWc8WSeg9/S65dn1rKy71TtNDlKQU0KFlfiNNzHLEiuP1QxVIMO5mrNOcg03a8MGqn7AG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL2GRjALveYIiBX+3Tpfap2PO1oKEcxI0QgYhAk4zTFE+8dBrM
	P9mfqfslgDqTfPeds9jO8HqJPPJxpfDbE/2EKuAd8JWiWrdwOsde
X-Gm-Gg: ASbGncshayVDpBlgAk0xMXDXKfvl652icNzpTx0G4V7EW8sjmPXOW/1ZZUWafeHQeJ5
	o4keUsVPOvo6Px4w+7oTRNx4Unjs/7zwBnKckvo2583MPAdafOFJG21EBeTxfWQbNTO77QB6i3C
	lSJIrRzIOPJIkgZlQgf5G6U8H5b7bjg6iGTD0TiavWDS7f1ZD61CtWN1oc3D5E3Y0PAnAXXu6WT
	DAh70YmvrEn4vmWUYLXXVy4bU6m+tfnlckqC+hhwJHT//AeheCVbWh55xMaUCXO4SU7VX5+kuvR
	JZYLJMeODfY293/Yby00eeR52KHdEg==
X-Google-Smtp-Source: AGHT+IGaY1jiKlgDcsNLc4PsVmW8EQ5H3DnagxmDWb8AytHmsvLoHmi4QHkE6o1Pc8UkzGeQoPdp2w==
X-Received: by 2002:a05:6a00:3c8c:b0:725:460e:6bc0 with SMTP id d2e1a72fcca58-7290be71abemr13267218b3a.0.1734286990278;
        Sun, 15 Dec 2024 10:23:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5883sm3332314b3a.63.2024.12.15.10.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 10:23:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <04c6066f-b8ff-431c-a093-c25aedf58d3f@roeck-us.net>
Date: Sun, 15 Dec 2024 10:23:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook
 driver
To: Joshua Grisham <josh@joshuagrisham.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, ilpo.jarvinen@linux.intel.com,
 hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209163720.17597-1-josh@joshuagrisham.com>
 <797b248c-7542-43fd-8e44-f2c7d650ccff@infradead.org>
 <CAMF+Keb0cXc8t8J_T39WJUKydpD2EME92ZWT7SFr_taiCXfvww@mail.gmail.com>
 <90e6a8f6-666b-45cc-ae66-4ccbee0ba08e@roeck-us.net>
 <CAMF+KebEX+AM_6O5j=ym6GzZ64qac=Kknd1SKLx6VhJsZG-eiQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMF+KebEX+AM_6O5j=ym6GzZ64qac=Kknd1SKLx6VhJsZG-eiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/15/24 09:19, Joshua Grisham wrote:
> Den sön 15 dec. 2024 kl 17:35 skrev Guenter Roeck <linux@roeck-us.net>:
>>
>> Your v2 is highly unusual. The patch description is the change log,
>> and the patch itself seems to be a diff against v1. Did someone ask you
>> to do that ? Just wondering.
>>
>> Guenter
>>
> 
> Hi Guenter, here I was just following a patch guide (or at least,
> attempting to?); should it instead be a whole new patch against

Is that a Linux kernel patch guide ? Please provide a reference if possible.

> for-next instead of a diff from the v1 of the first patch itself?
> 

That would have been my expectation, and every revised patch series I have
seen so far did that. This is why I am curious and try to understand why
you didn't do that.

Thanks,
Guenter


