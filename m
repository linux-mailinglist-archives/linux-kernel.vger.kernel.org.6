Return-Path: <linux-kernel+bounces-270858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F084C944650
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA811282871
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25C516D4EF;
	Thu,  1 Aug 2024 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OvIFEuGp"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612913D891
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500220; cv=none; b=mOLaWUJnpiIfJ2dO/+Pm4wAb+0ceCtQIYgyR0rPRoRMXwYanWUyNDrRXEBG1oMpQ73HhNXHk1NbTLXSwyFimdxXugmX/eDBlFBmfjKvpiFwInkG17iH2R+yM6Dh3c1tT6KrJG2D3/x3o9mP5krRoFID7AZLyT+44CIic6PShLQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500220; c=relaxed/simple;
	bh=q5fun1stuBG+6UPuqpS76nEA11lt40c4cJptlg3SGjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iD3qcIpJJ2WkBquVZhZqnl5dtbqKXxQyJtaxqOVHjs7STGVsjcOkpV5tDi8xHNaPJLn4ky0pl9jKzuGjPsYDJwMxZLf9mfYgnbmNiD9D19KPJo56Feacp0brloSoBcQw9BikH+jY8/+5VseYWGqbVw7PuvpxKk3hcl2VEmUpDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OvIFEuGp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-369cb9f086aso3662847f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722500217; x=1723105017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XP9tpFtaN6upuW6t7vjYg0wgdfL/oQQOrVIWRer9/9A=;
        b=OvIFEuGplgnRFbJ71Y7Zv14yuDJHIDp2TaVBF9QaIvJqNhPv287Uzi009ebJWh7OSE
         KSR8mEK5balCEEuXd9Y0iI7Ob7DOpE1NGOdYAFGVRrn2IIajPrb6V7+2HrmgLx8fuw/d
         N4DlAN34bHFRHGGi5Z9rw9JC2tv0Cp8VSpsuKGFhGu52Z5MMeBY73MVdnOSy2Y2SFtUU
         MREb0se2+bmDOHoCmH4Dq9VQcNJ0+QNivAtlNhjeNIa7YW/nbHeWpk8rnbQjjLJrvQow
         N2NbBG20TyHHSMLWOeJHZBIKwpNi0LR6GqdAJ+/YZkldgFkII/ttZi5vQh99o+f6RcMq
         vjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722500217; x=1723105017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XP9tpFtaN6upuW6t7vjYg0wgdfL/oQQOrVIWRer9/9A=;
        b=j7+dz1uzEpYM9eN/7xMxqPEMJZOjj18KqiHVWFY8/K7pSRKz8bkac7OKPexMO+4uk+
         bQe5CEXFqqrUtkpCSDbI/56qz0EAmTsGwSVgG2jn+SBqTZ6WTYAAFM6QWBXwSn9OwXGd
         9SoHXxuzszD7tP0LwyVFfYdmGO+c99L5ysf280E6+gnTSIzV2roP3C9mV4PN0igFDUxO
         DjstCTJpDRq2+9K+3mww8ZtSjWt3aRbX4mQgsoMd+p9CAEeglUZh8vyF/UmxjQfXZDS0
         UvS2jZJUwGQm/qSMTQPeb2nl//IZCgXOB6VF73ohjMkreGyFpgBVylpljtP//ZorpoTx
         d13A==
X-Forwarded-Encrypted: i=1; AJvYcCXSaDzpi6cAf/rQTc7952xaHDbFVWENrgwyGcETLKsrC7o1MnXtdzhix8SeNVEn9wgonvMSsHvMrAkE7HGNOv1VO5b9C8FM0jlD+dGy
X-Gm-Message-State: AOJu0YzDcCRSXfFPjz4IisyYpG+SCKEROWw4LkeXdHUQQM+yKDCezTeG
	xAggipv56vy2q3fH1WpRvH664nyOUFoRAwQJVEBKdReSZnA7KCKiJD116bMbZSI=
X-Google-Smtp-Source: AGHT+IEZ6N3OkZhSfrB0OlObra87UiMAZT58iQxNd4nFWX93KOp+dwXPH4pd9kz7+mSHV+7alm6HBQ==
X-Received: by 2002:a05:6000:1364:b0:367:9ce3:1667 with SMTP id ffacd0b85a97d-36baacc7d04mr1233681f8f.15.1722500216713;
        Thu, 01 Aug 2024 01:16:56 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9b30sm18869773f8f.40.2024.08.01.01.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 01:16:56 -0700 (PDT)
Message-ID: <fafda7d5-3853-428a-b0eb-9993fc2d4f56@linaro.org>
Date: Thu, 1 Aug 2024 09:16:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] media: qcom: camss: csiphy: Add an init callback to
 CSI PHY devices
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240709160656.31146-1-quic_depengs@quicinc.com>
 <20240709160656.31146-5-quic_depengs@quicinc.com>
 <6dfc2c79-fc6d-4eed-bf3f-94396130cb4f@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <6dfc2c79-fc6d-4eed-bf3f-94396130cb4f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/08/2024 00:43, Vladimir Zapolskiy wrote:
>> +    ret = csiphy->res->hw_ops->init(csiphy);
> 
> Here.

What name would make more sense to you ?

---
bod

