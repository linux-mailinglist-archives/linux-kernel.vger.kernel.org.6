Return-Path: <linux-kernel+bounces-192030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 363058D177E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC131F21491
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A065617E8F4;
	Tue, 28 May 2024 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJ93Alfn"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD723B295
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889567; cv=none; b=ZexKWleO+H3736WMvLoPWMjZFNl+zrQ2VHFa0hE4DNHJuR3/M/76aOXNYSUeLkgewavRhcyn8hH7jIRaUc629b5fTrg6kPNq+gKkJvI4DPcJSEwS0HdZ+6IIfDIFBJ6CrQMbaF+LvtAC51LzBAIK66HO1yaJ+rVGdPTc9n9x8P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889567; c=relaxed/simple;
	bh=NflXgaa7gzI3nUDBEsag0fwCyQx4HjJEGZE6UwuNB5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAaeWUmeN+ZcKYMRTVGWVwEgJ8IDJpGz9zVYvRlxdDU0F/8rcYc4Mwgtyy12ew96X5pa6C5AzPACPDqzt4KyojeoQLQ5JwRL5aMWcAuiQsl0T38dTR0li1BfQaOM870WRiMZLSGWgiXtlVS97a3C2K9KYhlHi2pKXDYn0fTvNXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJ93Alfn; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so8079991fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 02:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716889563; x=1717494363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KY/5/nBeVbrcHKu+ny0EKXullC6QCm1eMO2M/0SXeUA=;
        b=LJ93Alfn2pY9wAPi5c5vejhhTpkphlef4IeHRE0D9a68Ew3aGdUfBVD7Awszw+aJcx
         MUNXmnffv5E8rwD+ptRS2K8n3RsN8V6/k0/gDOuVbWGXpjNHTXPCcGOutQIrT2SzTweT
         K/urniT/Gz3+Ymtw/uGkxFogBI9ziJpJxTndgwy6n+4n1nJWIFMSW2MERmFxvLQzL15l
         I1owUyS4Scww5iLu3+pkAEnt3dWQ6ZHeHpe5aCLhpz4/eACQq16P+Vw/Vd1qPDR3m+SS
         5dA8QgdJciab5xe5tUe3mLaYH189qmnjhkJNRrRB1YBp8sT5kkQcEqSyDKGTl+yzP7EK
         9aeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716889563; x=1717494363;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KY/5/nBeVbrcHKu+ny0EKXullC6QCm1eMO2M/0SXeUA=;
        b=dQcKapWDTLgrCYkibhe5GMwURW4dwX313o2vtQqO1mUBxGvjeZySLlA6ePpxjQNcru
         tf5HmNbsaiZT0MRxW7oWR0Wr/lU9kKpPgWCmQ7jPmF5vADlE3qWu8V1pmKd1tagsNf8i
         RX0ZBUbrO1ek9CBcuUjWA7/OkOpkoOVAH3SvbOi90MKiI+r11xDMxx/tMKYe3rAaILLk
         lGfXi1citk2Y+zwGuvruq5ontgOFNRHsAcBLIHg/uDbsIQLG9wEUHdvDDmuGHtlQQbBU
         9Fr5F9vd7QO4Bt544HcqOZx/tIznZNftq3IjiP4ubSF2vBBwJNeWZcmK2gr/EKsqtqye
         MgZw==
X-Forwarded-Encrypted: i=1; AJvYcCX+5YqOJvvX5b3glfWFrjaRdme6qAPaf0WoDiuVRx3E7i/8i9Zp4HRvcaPTTzEEFArASoz1ZiqUz2XWoL0CrWg2c7Y97KlS+A3uQzXZ
X-Gm-Message-State: AOJu0YxXRz52/EUPNzWpnUuNd0YHxjgIKAOnzlcZHDkXB2iHknGjAaJP
	rFY4uxlAriMsZt1qxyawzLYqRDcxvBXmjZFEIs1Hz/ZBqsHipYcxWC//UA7uts8=
X-Google-Smtp-Source: AGHT+IH5q0zRQt4om06kgRMF2RCpF5R7k7N6kRZAE+jg0CmZmI7XuPYjUVberS6pHiZtgrXHIDCmuw==
X-Received: by 2002:a2e:98c5:0:b0:2e9:8679:137a with SMTP id 38308e7fff4ca-2e986791446mr12641441fa.44.1716889562512;
        Tue, 28 May 2024 02:46:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a631220b5b4sm155206466b.5.2024.05.28.02.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 02:46:02 -0700 (PDT)
Message-ID: <b6d3d336-5999-424a-9e38-3cf793b6627e@linaro.org>
Date: Tue, 28 May 2024 11:46:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] media: dt-bindings: Add ST VD56G3 camera sensor
 binding
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Sylvain Petinot <sylvain.petinot@foss.st.com>,
 benjamin.mugnier@foss.st.com, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240521162950.6987-1-sylvain.petinot@foss.st.com>
 <20240521162950.6987-2-sylvain.petinot@foss.st.com>
 <8afe1888-5886-45fc-b576-98db3d392d37@linaro.org>
 <ZlWiQTfag5yTA4YM@valkosipuli.retiisi.eu>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZlWiQTfag5yTA4YM@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/05/2024 11:22, Sakari Ailus wrote:
> Hi Krzysztof,
> 
> On Mon, May 27, 2024 at 09:04:38PM +0200, Krzysztof Kozlowski wrote:
>> On 21/05/2024 18:29, Sylvain Petinot wrote:
>>> Add devicetree bindings Documentation for ST VD56G3 & ST VD66GY camera
>>> sensors. Update MAINTAINERS file.
>>>
>>> Signed-off-by: Sylvain Petinot <sylvain.petinot@foss.st.com>
>>
>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ef6be9d95143..554e6861425b 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -20885,6 +20885,15 @@ S:	Maintained
>>>  F:	Documentation/hwmon/stpddc60.rst
>>>  F:	drivers/hwmon/pmbus/stpddc60.c
>>>  
>>> +ST VD56G3 DRIVER
> 
> I might add this is a sensor, i.e. "ST VD653G IMAGE SENSOR DRIVER".
> 
>>> +M:	Benjamin Mugnier <benjamin.mugnier@foss.st.com>
>>> +M:	Sylvain Petinot <sylvain.petinot@foss.st.com>
>>> +L:	linux-media@vger.kernel.org
>>> +S:	Maintained
>>> +T:	git git://linuxtv.org/media_tree.git
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my or other reviewer's previous comments were not fully
>> addressed. Maybe the feedback got lost between the quotes, maybe you
>> just forgot to apply it. Please go back to the previous discussion and
>> either implement all requested changes or keep discussing them.
> 
> The above MAINTAINERS entry is roughly in line with what else we have for
> the Media tree. I'm in favour of listing the people who would look after
> the driver, not just those who merge the patches (or even send PRs to
> Linus).

I did not propose to drop the entry.

> 
> In other words, I think the above entry is fine as-is.

I propose to drop duplicated, redundant git entry. Maintainer of this
driver does not have access to git tree and the git tree is already
explained in media subsystem entry. If you ever update the git tree, you
need to update 100 driver entries which is meaningless...


Best regards,
Krzysztof


