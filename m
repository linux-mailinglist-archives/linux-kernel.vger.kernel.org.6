Return-Path: <linux-kernel+bounces-247227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB9F92CCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53DB8B246C4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC8B85947;
	Wed, 10 Jul 2024 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTYl3Hc5"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FC685626
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599681; cv=none; b=GiTwJ/Z87nlYx9awTIg3Hm9S393JevpAKt/Zpudcy0DI28NRsUZDfiIM0riq1Ia8EA22dk/+hPmJoE67DRXlQCtSt/h8cL7xEVJU/wCLfdnEWwTvKrigJlbMWk1WmkxC9ZS+/URkgrkmCGNLOL8CDXtI5j6QWnnPug15GLpfIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599681; c=relaxed/simple;
	bh=DPUABfizu486Q5eVvbw6KkdOv+B8Z+bW41UY+AodGpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEasnmuAkhA09IOtnUE6xuxCoVW5zfQz97450fk6mFjOGnIRLFbk43D8SvjZbWhAkXzG+aL03FKvHA7xFjwmdhm3Vmy/rioh8lC9fKDxZoOfR/n6K2yr+M9pvYaeMABJkGo/A4OxWGMXXMnGvsxLtN7KDSpRoVE7D0MQHns6UNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QTYl3Hc5; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e9c6b5a62so6576739e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720599678; x=1721204478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejCg0yAtNCGL4j9toWYxPv6vOenYQMFwdFWp7I8WoIw=;
        b=QTYl3Hc5Nwhz7ODrp9bBZR+HIiqBI/TyonBIfOc8OIE9tug7EPvLZzbWyhyRR7Qtmq
         sYGAoOAN3ifzprZOinuYmQgkp7+R3sbJ2o+1Yq7m9EcogNrN8/dwsdeDR37mykZWjnNM
         qldoeBrmyruWE0AI9F7KFlk2n9Wv0hZWBQc4cSUzYJie0Lyipa+G6VaElh9HrkuoXCrI
         moViggghdWAUwL0vllZ4FImRcHIOkxT3sHEDHyBV2MuVXfA3+ZB1TDOvX0qEpS259x6W
         hOL8slgQx5tZa76IxTwYcHww11HrpJ/xraIN7Ps8vk4Wxu16I+5zIA75lUyh97u2d9ex
         K0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599678; x=1721204478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejCg0yAtNCGL4j9toWYxPv6vOenYQMFwdFWp7I8WoIw=;
        b=IfIZ2dNt7oH3CppBdhZYTH2DUm3UYsTYW5qKRrTdFbhsYxUW+57ta8q1sXTmWa/ja4
         8uLG2CxfGphneLVjEf41hKDv8n7dsfpJn3enYACCfUVa7q/k1bSIxicB58BMWVW4qpBR
         IFIZe2papg4b6EGHb0IcUC6BJ14eseQDffJKzGFpJcRulRDAeyKyLBRUgQ+fH5xgwy0k
         wj6DW6v8p+5pH1zEBEOmfbyoz1GjeLHqdpLFaZM8K9PL2/2kTGUFETQ9LnynEz4S3suU
         ZJjlr3a3vTOcKxiCxE2OFymSjMGaxZiLH0XVlRmTwaTORjgfTrSpsOsnb3SeBn7EvA/l
         wXcA==
X-Gm-Message-State: AOJu0Yz+e22xYxuL/xczRw+fppZpPfWp+W68w0XYTEAbpOYWzqg6Ob09
	etYC9GjjTYXIhYGkWTTJ5dv3lVkr5v1kqP5ai0XSPK7pC+NWzC5SV3SXScHIyzs=
X-Google-Smtp-Source: AGHT+IFR2VaiF8nRlz26qTf2UpRo4vfxDesGLvpWFLmdyH6ySWNa8QPtFyOYWwmZtI7XuRNLWt5ODw==
X-Received: by 2002:a19:6411:0:b0:52e:7f18:1775 with SMTP id 2adb3069b0e04-52eb99919e9mr2388589e87.6.1720599677934;
        Wed, 10 Jul 2024 01:21:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6932:abde:fac8:217d? ([2a05:6e02:1041:c10:6932:abde:fac8:217d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42727805e4csm34747155e9.27.2024.07.10.01.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 01:21:17 -0700 (PDT)
Message-ID: <f1bd41eb-eabe-43da-8e6c-c6320f05ea01@linaro.org>
Date: Wed, 10 Jul 2024 10:21:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] clocksource: realtek: Add timer driver for
 rtl-otto platforms
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, tglx@linutronix.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 tsbogend@alpha.franken.de, paulburton@kernel.org, peterz@infradead.org,
 mail@birger-koblitz.de, bert@biot.com, john@phrozen.org, sander@svanheule.net
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, kabel@kernel.org, ericwouds@gmail.com,
 Markus Stockhausen <markus.stockhausen@gmx.de>
References: <20240710043524.1535151-1-chris.packham@alliedtelesis.co.nz>
 <20240710043524.1535151-8-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240710043524.1535151-8-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/07/2024 06:35, Chris Packham wrote:
> The timer/counter block on the Realtek SoCs provides up to 5 timers. It
> also includes a watchdog timer which is handled by the
> realtek_otto_wdt.c driver.
> 
> One timer will be used per CPU as a local clock event generator. An
> additional timer will be used as an overal stable clocksource.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


