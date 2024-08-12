Return-Path: <linux-kernel+bounces-283687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF8494F7C4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E98283D24
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4F0192B6A;
	Mon, 12 Aug 2024 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wvl86XgM"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C023191F85;
	Mon, 12 Aug 2024 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492804; cv=none; b=Y69EVtlaZCy7Ht0AqBKxq7Q2v31IY/0u/5Nnz0rfZm5Fuy6mBBkkDLU1n+zdl56H5fYiHmUpgVVcmG1JdnAbJQ0jW5+PVhA2Jd0BhOf5htGKVKqsmwLg40hzwq7HwjFQ2sP+csgiDLh/eLHBoNiuQYkrA3nF5eHHBt5Sv5kvsGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492804; c=relaxed/simple;
	bh=avFD1LlUcf1dSl/c1/+dZbZxf3+J/nDqkccuNJZUydQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnw3Wzk8o7AORH24RpTCPtbAEpa/9rhZSpXeqKTL0CjLYE1aBKr/kHWEgz1La7rbgkviVQQUasbuMJOax+HXMa3ywmP54p7CDT2hijKgRm6AKpFPJhYg1Ww+oU9csG4qWo5lycXAneHkQwtbEjioj8tDZkog0Tn60TJbf4BduxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wvl86XgM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36d2a601c31so2440640f8f.0;
        Mon, 12 Aug 2024 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723492801; x=1724097601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ao0ZXFLg7v2QvZz434llCl1Nat8PYLcu6tU4rBBTmg=;
        b=Wvl86XgMV+PgcVcQNZXRYkgHeV0IevnAqGERWbqKThwRW2mXSVuilUZtyUbNCzWbYL
         nVh0J1s4APqpP+9rLh94RoZETHXkFqIBL0aoeVFVC+yqJ25OJ2aO7Y2jHGniyN4OZBW/
         98D9TyDZ07Ul59aoPzXS/TJSZeQFgXjRHbMFubNMu2rZbD9E8KenQ27iGThoPLJcTjoF
         oVibkUvllIWhc3qZPPcrDCS/rJo4WCja/vz/0KFJBvzBa4/dhgkkCLyI1tCBjN9zUsA4
         HPw1RlNK/ZGOS0QOeOMRcTkfQUpF1EGLrnZihqRi5D1hVaDOkfLrLyQuEPurHNXOJgwg
         OHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723492801; x=1724097601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ao0ZXFLg7v2QvZz434llCl1Nat8PYLcu6tU4rBBTmg=;
        b=wD6an6GSnjjRaGSPuFuDJXa3SEPmHHy4rX9Jo1orUEBXx9Yr9B7QCJw2WdBZ0PeG/e
         b7YjUAfAkVzgKWPU1cods3Bblxtsjj2SjzAL5bwNI/wC6cB/ORBP2W8GqBNIm1N/OYB6
         EmVpQMevfz+lR6BjoJJT1j8lmkeS1QHM86XwgdY8qyIIKODh+ZsRgn0lPg5sj8iLQ2wK
         NaPryhRsjZD1I96ZTCKlcS5llmAAQDFov5bcYZZrGasJn4+mMIPQC1WDGDavbIYqd2/E
         F5Meu4KoFrSRxdF1t7cfF5L+QAQOojAoEGOGTHm1wstVIUO7M9TX+5czW2keIMSzzsMH
         BamQ==
X-Forwarded-Encrypted: i=1; AJvYcCUudwlr9MywbiQuI8JS84EvyqTi228p6tGvNCDXvSJQZcG2WVZlqEUIUplm8RF/lIZj8XUpSlSCZ/+uII8sZBy4xvrRAChaS7qZkqyk
X-Gm-Message-State: AOJu0YxAALlPzbQgDhnqkFJVFll2YCCqhkkFaCxqiSAFM4PyW6mklNQc
	AKzEww8+7OX4oRo58QOpVs/9g3LTacTOv8vwPXpJXBZXLP0IRV1s
X-Google-Smtp-Source: AGHT+IGbqZEoLfrQgXObtuQyMnLN8NINsVSBStefN5CaF/7HYlYKpwoWP194Dyl4Kc9MBWjXAc87cw==
X-Received: by 2002:a5d:4ccf:0:b0:360:7812:6abc with SMTP id ffacd0b85a97d-3716cd2c2bamr945006f8f.60.1723492801109;
        Mon, 12 Aug 2024 13:00:01 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd330fsm8267251f8f.96.2024.08.12.12.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 13:00:00 -0700 (PDT)
Message-ID: <9659c699-1ce4-4b74-b697-83d926d80b35@gmail.com>
Date: Mon, 12 Aug 2024 21:59:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: chipcap2: disable sensor if request ready irq
 fails
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240812-chipcap2-probe-improvements-v1-0-3cdff6d16897@gmail.com>
 <20240812-chipcap2-probe-improvements-v1-2-3cdff6d16897@gmail.com>
 <9b4f88e8-5fc6-4c4a-b89c-7f96675e81ac@roeck-us.net>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <9b4f88e8-5fc6-4c4a-b89c-7f96675e81ac@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/08/2024 18:49, Guenter Roeck wrote:
> On 8/12/24 08:43, Javier Carrasco wrote:
>> This check is carried out after getting the regulator, and the device
>> can be disabled if an error occurs.
>>
> 
> I do not see a possible path for a call to cc2_enable() at this point,
> meaning the regulator won't ever be enabled. Please provide a better
> explanation why this patch would be necessary.
> 
> Guenter
> 

Hi Guenter,

this patch enforces the state where the dedicated regulator is disabled,
no matter what the history of the regulator was. If a previous
regulator_disable() failed, it would still be desirable that the
regulator gets disabled the next time the driver is probed (i.e. a new
attempt to disable it on failure).
cc2_disable() checks first if the regulator is enabled to avoid any
imbalance.

Best regards,
Javier Carrasco

