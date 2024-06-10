Return-Path: <linux-kernel+bounces-208242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327E69022C4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9EA2843CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7E1824B2;
	Mon, 10 Jun 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyZJkLHe"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6774048
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026771; cv=none; b=jDYwbNiHwVUPWkq/pqVfx+fN//HxNFRv4GUa80CmZ5J5a9hkhy4AxdorLvF7M6QxdRfeB0ELiAhzcwns9ckzKyMu0AmTy4YLChiJy+oxvdQWlMyGv8iD4dJfcC8KXNZ1YyB/NPkMVn8lUIbiCFGN78GxPn4c57rEMpY3551pl/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026771; c=relaxed/simple;
	bh=VNvjgBuWCWK2hEJ77TrUw1MiOTGVq/NEcqmXKBOQ1Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDgvOTP7L8MgVFUDLWfrVVTUZMD/dTdEq64BplUTh6PZRII2COj9jOdJ4UjTrHWm7Crt18jTswtNT+n8SQQvizRicyteFHmGLDUuEfsDkie65J7QFvRLSLIa2MGbHjycAwWq/F7Wh2uSbXmekAMguUSwMv5vzpP2IELeDtvjqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HyZJkLHe; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35dc1d8867eso3455670f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718026768; x=1718631568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXGo4Ghsn84PBkyTy4nR9hzZ+hfFgUawGb7DBhECELs=;
        b=HyZJkLHeB7L8Eem0CZySDBBXnJgCVZ6FwSlw/bWEB18/FlIy633eBNofDEfzYXcM7O
         sakeweXD8WtPwGpdpMOq4UVKNeXr1YRad5cdnPWLwvnBbavye4+4ASDbD6aVkaZEQtw4
         B5T1rV0MyksdbFIYyOMR1s8HxzzZxFSePtmW/Um0lI1Eam9Ufj6ck5tWZzHuCdoTKEsN
         YMHnLTtEaRVoob1LqfNFtqCk04xnWAZmzZQHOXBpNwvcLlLfw9xlyM32bi8c4n8i6a9A
         wFBcGwVWESzBKGThs2JF7e+Tu8DqBnnU9O5SbwofmVEfug78vrMHaxtAfSiPrsOoBWlf
         3p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718026768; x=1718631568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXGo4Ghsn84PBkyTy4nR9hzZ+hfFgUawGb7DBhECELs=;
        b=Nw37fjmiNigFSn6FtqvABMfhk2G7sxFdh+vSyocW+j51Jkh+b1hCHiv9+95jhHxc8a
         TC//4sJINkdZ8s8As264bzO3lv2111NdyyqmW13jd2jsBuBd67ovZ7okV1L0/YylApbQ
         n0+hqL+exn2NYJNyz4tw6GN64LBFnNoREaJCG+VfkSDoyXNV0we6kmBMzhEip42MBXxC
         0iiQltTxlJtYxjS6xlDEkbP/mG9vYaJ08vehRBTwQQ3jonTxDyE09jZECDjzxIE1LjM2
         Mmtt9lCgkI5dG3hrxHOt+AgEINSG3WICMaeOeLprfcGdMe0iXbG0Tgc/yqa8LKbFJ0Di
         V+Og==
X-Forwarded-Encrypted: i=1; AJvYcCW4HBg8vPNmcp20wO2qFMuGFvyFdP3e7IYqaMtuJLZmblqPDfUKxaAls7yi07G6PAB2EOIp5YMOOtMwe1ldYPGcIRf1m+tbQBOPcbQr
X-Gm-Message-State: AOJu0YzFLR3s33GjefqGuLzMQUxAd480cq0UPa6eevJhSQLX0Ca26Qa3
	6+q30GE5M4Dbj5U066U8Tzf3FCLtbo9ZID1/99/JRe/ndpznW9bYYFlPZqOBcS4eAP9j4uR3iBB
	E
X-Google-Smtp-Source: AGHT+IH3TGlVAcwfP6ZmHz/3RzbtahP2MF9yhZIh+3WPUd8VKv+Fo0HktmDdeibBHAqvPrJiOiqI9g==
X-Received: by 2002:a5d:4d4b:0:b0:35f:1d55:622b with SMTP id ffacd0b85a97d-35f1d55626emr3135273f8f.16.1718026767901;
        Mon, 10 Jun 2024 06:39:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35f269f9589sm1818707f8f.105.2024.06.10.06.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 06:39:27 -0700 (PDT)
Message-ID: <1ca6f4db-a7cc-4f47-b626-51daf7175885@linaro.org>
Date: Mon, 10 Jun 2024 15:39:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] thermal/debugfs: Do not extend mitigation episodes
 beyond system resume
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <5794974.DvuYhMxLoT@kreacher> <2337425.ElGaqSPkdT@kreacher>
 <dd446bf6-05ca-4861-b3b1-f113c3528f13@linaro.org>
 <CAJZ5v0jku1tptD3O=x-rptgUWGQFOQT-U3rsxk9k4XXsyeq3Kw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jku1tptD3O=x-rptgUWGQFOQT-U3rsxk9k4XXsyeq3Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/06/2024 13:29, Rafael J. Wysocki wrote:
> On Mon, Jun 10, 2024 at 10:28 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 28/05/2024 16:53, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Because thermal zone handling by the thermal core is started from
>>> scratch during resume from system-wide suspend, prevent the debug
>>> code from extending mitigation episodes beyond that point by ending
>>> the mitigation episode currently in progress, if any, for each thermal
>>> zone.
>>
>> Why it is done at resume time and not at suspend time ?
> 
> Because it is related to thermal_zone_device_init() which also runs at
> the resume time, so IMV it's better to keep these two pieces together.
> 
> Why would it be better to run this during suspend?

 From a logical point of view, it makes more sense to cancel something 
at suspend time rather than resume. That prevents future readers to be 
puzzled by an action done in an unexpected place.

Technically speaking there is no difference if it is done during suspend 
or resume. Well... we want to prevent actions to be done at resume time 
in order to not increase the resume duration but I'm not sure this code 
is doing a big difference.

If you want to keep it as is, feel free to add my:

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


