Return-Path: <linux-kernel+bounces-348767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A2998EBA7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE35B28112E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3007413CA8A;
	Thu,  3 Oct 2024 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="px/1BsEF"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E565385C5E
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944387; cv=none; b=gad/bFLzC+bShMPlq/ZqIirY1+uP7cxZvnTMhb4NQXRKBEYBradockpJlOBzdPX8XVKWnuyH084QPT761shY3I8V+QqHDwMCFInLW5G6rAfjcMncf92qDKyXA4JW+vv+ehQH8sq+/UhLl1AET9gnq5G0tCusELAr0J0w8Cxc5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944387; c=relaxed/simple;
	bh=u4OLv+on1w5ZpzDGkYaICMJJsNef8x3hvDTkCCV6EDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4Ocx0St/uMRO4aoInOFTi967tl7NkpjI4bWQjOHfv9YIOYHncN4VliYSaJHT3QVtg2R9lURIp5biJCmp2GKSM1b3ePKBi2ibpBkmYUw31MwPlFKjepmYp0fJRyRWMEIzrMtIqoKUTU0iEuyAnVLeLAMQ/GS2+mLw+tGXxj1WN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=px/1BsEF; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fad75b46a3so7294621fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727944384; x=1728549184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ut9/6tzTcXAHL2hTz8WOjBkkwiPd7bJB3/FRKaJ13Q8=;
        b=px/1BsEFKwEtWdhQSRoqjazLq9us/KpEKWe0ENctIGnOmwJxgwCm0Cizv5TZslbQMe
         txXv3kp8lOTmYBtmg/DLUdsOFRuceqDyw3Dfdf60zhSN4Y+rPyIa0BwQiqOXD8+LQMj5
         cOTpaMOKfG9Y3iN3edz6AiTyviX62sVhP+aWUJtMHQ2Q+Va1aq83qxKmgCnDS5ss7atV
         IPajX1f1dkwRMCR8gsWS7QP/d+VGoXtbTfXXnGBZZMI8tuazfi02mw5cVPEh0EOt24eI
         q0bCxzxl49H0zOSVcCoU2hhAqFYFj/AjUD/e0W0LKkJjLpIM1/6wbfrvcfd5rHw902Xd
         OPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727944384; x=1728549184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut9/6tzTcXAHL2hTz8WOjBkkwiPd7bJB3/FRKaJ13Q8=;
        b=i/A5DKSjhPoV4GpDsVULTO6Cd+pcLhHGwFN8Ebw2554fZDwo0hkKek63Y1sqqEeugi
         Er5v0hTxybDth/JdRM/Bp8NbNJnYybElkdWXATDR+PBAsHvqnQ63FQG1mft4AQfnNmPW
         5SLA7DbND19BsBTpuwkWpoWqa0EaJd5lGBqoXkfhDS74C58WS65YSkQsnW91XE1t6zoP
         ivRFytFnp4qnk/VbyuoiMJa92TdFVn7ImXB9/7Tc8PWu0C1YyFZj6gpVUxmJ/SVkiTYn
         Dzzw+M/+n9Ku+BCB9zeYcx+LX9pzOCK+QFqzR4ouwF1l59Ft1wROQYNuHOuc+B7YsKzl
         b09w==
X-Forwarded-Encrypted: i=1; AJvYcCU4bS9silupDPq28KJcz/3A9yPgFQzyoPTH8dVvDPmgK7haJNBhsOC+ZPEZWF7baHq1n252jo8CXpgbu3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVEO8av86mduKKnI4xhDyoAHceITquttHwrZnJV3hwiNfbYOMT
	oGC1jM2imvdoEoCDJ4XIx5/J+QGbQUxvWD/YkWdTmpgKWuoTB1PIT5GmmEmDiuI=
X-Google-Smtp-Source: AGHT+IFzzydZhzRyTcrKJI/fWPPYaGOnihdLKAdpEL3h8L33Wgv6a8fHoeQeUjmFsMHAoV6o50i6EQ==
X-Received: by 2002:a2e:b8c1:0:b0:2f6:5f0a:9cfe with SMTP id 38308e7fff4ca-2fae1082debmr37433871fa.30.1727944383150;
        Thu, 03 Oct 2024 01:33:03 -0700 (PDT)
Received: from [192.168.0.15] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca3bd7bfsm452630a12.14.2024.10.03.01.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 01:33:02 -0700 (PDT)
Message-ID: <a86d05c3-5151-4161-8612-58894b1d0203@linaro.org>
Date: Thu, 3 Oct 2024 09:33:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] media: dt-bindings: Add OmniVision OV08X40
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jason Chen <jason.z.chen@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241002-b4-master-24-11-25-ov08x40-v3-0-483bcdcf8886@linaro.org>
 <20241002-b4-master-24-11-25-ov08x40-v3-2-483bcdcf8886@linaro.org>
 <t4fajppdqagkl7wr2krcucsga4zocz6liar64odk2mnasdyfms@5fp7bfwalson>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <t4fajppdqagkl7wr2krcucsga4zocz6liar64odk2mnasdyfms@5fp7bfwalson>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/10/2024 09:29, Krzysztof Kozlowski wrote:
> On Wed, Oct 02, 2024 at 02:58:44PM +0100, Bryan O'Donoghue wrote:
>> +        properties:
>> +          data-lanes:
>> +            oneOf:
>> +              - items:
>> +                  - const: 1
>> +                  - const: 2
>> +              - items:
>> +                  - const: 1
>> +                  - const: 2
>> +                  - const: 3
>> +                  - const: 4
>> +
>> +          link-frequencies: true
> 
> Not much changed here and you did not continued discussion about it.
> 
> Best regards,
> Krzysztof
> 

Ah my mistake, I didn't read the bit at the bottom of your email

