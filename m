Return-Path: <linux-kernel+bounces-408935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF429C8552
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EF82818EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF0D1F709E;
	Thu, 14 Nov 2024 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CREM8NqT"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178881632DE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574451; cv=none; b=WNeXiTrErRJ3wZQ7jwXQccnC1S/rHvm7A68IVxNGaFMJlEUiDM4N2o+/KaLsvSd7/ItypbAJNW8+E2MoGe1zr3ZCwKiVGTeMhVZMaLP152eUtpkH1D6fzt0Ka3N2g8RokiBHLbsIWqGN0p4Jb0D0QJvtTwb7U/6aD+LvRAUX7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574451; c=relaxed/simple;
	bh=Jzqob3+BInvDcovTUKeAJ2gN6D2f0/2A/uIPROXYwHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iO0HyOTGc3w6QO564C0gvUcdtzHQse3STPiYLfS9xS0zSFCrHSEkuQ4TYeRieRS6FXUv9B2Y+vS7RPUYLShTohzG1ic1EgT49zWiRXDY5Xpfs6HN+jNKjZmhEO9AYz7pKZiGYftLYFBvIrQ5wMTB0VW6z6UcHKIDRSgp93crmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CREM8NqT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20caea61132so2402015ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731574449; x=1732179249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVKRgH7SGvkuoe8O5C5+b2dqvoISeKLIHWkn6cCMwZo=;
        b=CREM8NqTct+4trrQXNGdSfhUkXctieazZ06F0TehygWUeobYm+CTlZ5mW0xOnM2Tj6
         dwvrUpQOnisUQT19h1jyXO81i0XNHCyZVPHpd2CTjAM+FVnYc3JhKYmpwIZe9dvCLG0h
         LJj5TfdUj+15u9A9lYKjBqCwp26q3Y8iG3SA1CbhAhj+CPjdspIkcpWbmxcx7S8ajL8e
         XdyW4pge2VabqO1I4qCGiSA6lE57uULlylrPj2wxZ/HYkkjjHjd/I1QGDGaQwN/QjYSY
         meaIcgGod1WasYD8kxANALzXdrm+IOojrhSJQVhL00mNRgBQabQdgA8xeklrLIHlGWZg
         kogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574449; x=1732179249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVKRgH7SGvkuoe8O5C5+b2dqvoISeKLIHWkn6cCMwZo=;
        b=U7OShmmwAh3tKise0TWASQIg4X//ePRyjRzldfqciCkrWSBqwA3iMwlxqT/RSSEG3y
         paYDvrmv8TEw2CXkuyGWZLBJiZiIIXgqZNvGSvXwIRlsbZhjW6YT5pM/Hq0qcv+U+moM
         Ws91H1cq2BWcvcRto+BLEyNY/zrLV/imkJsHlmwC67DQHxtYJ/C5nIdrzIbbLeL1z7uK
         ljYceeZLbCXufjiNzZLH8GfwGcZAswvJRT3GQ4l4lzoH240jW00oQtWJhIr6Jb86OKbu
         +EueLFmlPdK/7/x94RQHevQCKgD3jVcIlCgLd3QFklyCiTgC8QhGG8ThYMYidTqfYvni
         ttqA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Cuhj71SdYsOpYRhoD6WYOArHn5+zxdZbZELQvNLzeyhaIU59Pb58JJrTIWbU1AYZxxb8wCRgrRxTzQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFcZKxYXHW/zpFFhOeXCIntiTKWgctOHJsegCsZbQ4Gp91lIe6
	GEbk7LW4MV5An8a/dsQ6+qdtDktU1YLrh3Zeib0ERLtGjOTyFjiL
X-Google-Smtp-Source: AGHT+IGvhEsDXkSxVKAh8lV5Z/KqxIIoRUPCj/ww60z0/kIfteda9BEMLh6/51raJCS1Z3mZCiwCAQ==
X-Received: by 2002:a17:902:d2cd:b0:20c:705b:4123 with SMTP id d9443c01a7336-211c4fb926emr14619155ad.21.1731574449187;
        Thu, 14 Nov 2024 00:54:09 -0800 (PST)
Received: from [192.168.0.198] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d1f57esm6057625ad.224.2024.11.14.00.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 00:54:08 -0800 (PST)
Message-ID: <4743eb0a-6ba3-4daf-a448-829931dc297f@gmail.com>
Date: Thu, 14 Nov 2024 14:24:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: aat2870-regulator: replace division condition
 with direct comparison
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
References: <20241112202041.16980-1-surajsonawane0215@gmail.com>
 <ZzSsCoYy-Cs7d_Q7@finisterre.sirena.org.uk>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <ZzSsCoYy-Cs7d_Q7@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/24 19:09, Mark Brown wrote:
> On Wed, Nov 13, 2024 at 01:50:41AM +0530, Suraj Sonawane wrote:
>> Fix an issue detected by the Smatch tool:
>>
>> drivers/regulator/aat2870-regulator.c:142 aat2870_get_regulator() warn:
>> replace divide condition '(id - 1) / 2' with '(id - 1) >= 2'
>>
>> The division '(id - 1) / 2' was used to check if the regulator ID
>> is greater than or equal to 2, which can be confusing and less
>> readable. Replacing it with '(id - 1) >= 2' makes the code clearer
> 
> This is absolute nonsense, the tool should be fixed instead.  Writing a
> division as a shift when the intent is a division is a microoptimisation
> which modern compilers really should figure out where it's relevant.
> 
>> -	ri->voltage_addr = (id - AAT2870_ID_LDOA) / 2 ?
>> +	ri->voltage_addr = (id - AAT2870_ID_LDOA) >= 2 ?
>>   			   AAT2870_LDO_CD : AAT2870_LDO_AB;
> 
> Neither version of this is particularly readable, but the new form here
> seems fairly clearly worse rather than better.
Hi Mark,

Thank you for your feedback. I see your point about the original code 
being clear enough and changing it as suggested making it worse.

Best,
Suraj

