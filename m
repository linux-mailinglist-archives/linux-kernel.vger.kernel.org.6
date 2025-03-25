Return-Path: <linux-kernel+bounces-575153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C65A6EE54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935B83B5779
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E71254AE2;
	Tue, 25 Mar 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4iN+90m"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD54C13AA2E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900395; cv=none; b=l6c2Pe0J3wpg1eOBDQqUED8iSWenKL9IWC6fjETLLcOAzcLKc1JZga1ZjWFlhoRF0FHfZnAQ89/+ikCtYrz3R28bjGDVf2ac2RcozGRJagHMx9695yoE0QDqsaw/VK8hCJ1exwwkDZS3CoBz66vb3JnST7IAHcMr2/zc3d6si/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900395; c=relaxed/simple;
	bh=YjREIxTDCFTVrBPkyv22s8RBbzeSuH9SuXQUGB8gEIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcqmN6JtCZgKq0iCBRUS+39+OSZEYM0lI9MhVjANavcoVXspFr5xozv9te+d+PrFYy9q0/LcedSKNxIVA6uuSwbZj1fhVr+doFNvh9Laevz0TE1B/wGtGcy5TtSUtSZSSxodKSrAxuHlNVT1hT7fibscs5CL50KOtvwA4TlbB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4iN+90m; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso903653166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742900389; x=1743505189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LMtty6cGMmzUHfutIOt+LOLN8v7G4YKIi5s+o2pEa0=;
        b=F4iN+90mrmelegcCK/kBjndNOirQMuyUfzEsHOUMdeY127uqHar4vSIPo5+gikql9G
         ifgktX4I0gcGjeB9AkA34ClUVIX12c6ugZ3DlahPJkFhn0kV6Elx/x63PSf1a8nzd40y
         e46ceb2bLqaVpbNAKoVY3Wn2HpeeCyA6bfLF6DVRe/goeibg/1DyN2yYhhWxlBcs70WO
         tYqJ+jDGsTwJpoV38bULrUJENE0TzZ6xZjWaGzMw9IBayi6jwwPgthldhvYyT0+Fj4zF
         MCGsfrRSd4yHiJUaTYFgx71FNEmPYHHL+Y3cGzYkrfFoQLyHngRWTQ8jZP479E7UHYVO
         htVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742900389; x=1743505189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LMtty6cGMmzUHfutIOt+LOLN8v7G4YKIi5s+o2pEa0=;
        b=CDguMyVhkZ4oxKzlNSit6Qv0de2Ub9lAgn5oxu9Tww7Nqw8L0tSFA8r2UinBRcd7Q9
         WAWcMHlOn2a/EVQcppLPXpMfJ1kZ8DyaxTk4WlJFweif5L6k7r4e2Q3W+ajQ50EdwWSf
         D9YxC0pgR/nFTM4n6ptL6+pjxaP1f5e7Fw83uq/+P/Jvqn0XsNx+RkQCkeYYkg7lbPL+
         NcGfk9+nms0qcj6hHdJuh8us4gcTadoLdd+Kx2STofLK6yTKy+KQLRhy3vm16XGTswOq
         K2t6k8f24mo4Ngc3ppjHybVwVo+ve4LKStxypcz2epZZPOc8aJYu1Dkw39b3HKgldeB8
         hSgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuHQ7/1qMggS2zq9BtCn1BaMA5D+Cd8SlERf1ZTRLkYcDUfKTl+jSXBZlggzcOfzZmbYqvwuya4zqXimw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypsH6DLe8WDtu5sTDJs9koNeDyiu+jghRUysKcwfTGbijHfcVW
	RM9SYAW7SRpzmuYet7GkYW3yc/4QukIFhoIrHX4Tb2mb800mphEx
X-Gm-Gg: ASbGncsGShIyiP4p+d+6t6cwcBVMnSxmREpcyqfYYj3L7wU0m4CmbICj0NVZeGJCWMs
	oZQV/OojdpvCN8fYCJucJcu087SCAJiLEjX40NlHqu6aqr68HpOBGhCYy5HT9tS8IhsoWWdr+Hw
	FZW559AMv89mTHexhY9gMScJRepnHNFvy4wxDxYVXtywJDl1y8S1gKgTCxQMFjfkdI0aBQ0OYhj
	g08hlrQZ6ekIcE1L3+Dqv0mTV3q8MHxK8rRFCXSpcGRQJrde8clFXYQ6df44R46SNEY3r0BQi/H
	BoIUJ3EIx77HH4ycJDuJWVdHZOVi+kbSN0UT5frDH6yoNHlTQ+LPqR0eGcvul0NRSmpKwcN0vUs
	v6gCaQQ==
X-Google-Smtp-Source: AGHT+IFJap1XWmtph0+CjjdJDJ0Y/ELKEFWKn+AYCttTyUH8kj0PBBXw7dbG4hNAd3sEDnuEcMIr/A==
X-Received: by 2002:a17:907:3ea2:b0:ac2:baab:681c with SMTP id a640c23a62f3a-ac3f22b2bddmr1625201766b.28.1742900388562;
        Tue, 25 Mar 2025 03:59:48 -0700 (PDT)
Received: from [192.168.242.77] (mail.ultratronik.de. [82.100.224.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd24e7fsm828763066b.153.2025.03.25.03.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 03:59:48 -0700 (PDT)
Message-ID: <8019801e-d934-495b-898b-dedba0468f63@gmail.com>
Date: Tue, 25 Mar 2025 11:59:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] MAINTAINERS: Add maintainers for Ultratronik SoC
 Boards
To: Rob Herring <robh@kernel.org>
Cc: =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <gradenovic@ultratronik.de>,
 linux-kernel@vger.kernel.org
References: <20250321111821.361419-1-goran.radni@gmail.com>
 <20250321111821.361419-3-goran.radni@gmail.com>
 <20250324160512.GA129330-robh@kernel.org>
Content-Language: en-US
From: Goran Radenovic <goran.radni@gmail.com>
In-Reply-To: <20250324160512.GA129330-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank You for the feedback. I'll squash it. Yes, it is only one board 
for now. The other board which comes soon is not an stm board, so 
wildcard does not seem proper to me.

Best regards
Goran

On 24.03.25 17:05, Rob Herring wrote:
> On Fri, Mar 21, 2025 at 12:18:17PM +0100, Goran Rađenović wrote:
>> From: Goran Rađenović <gradenovic@ultratronik.de>
>>
>> Add maintainers for Ultratronik SBC STM32MP1 board.
>>
>> Signed-off-by: Goran Rađenović <gradenovic@ultratronik.de>
>> ---
>>   MAINTAINERS | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 00e94bec401e..26896dd2ceb3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -24336,6 +24336,12 @@ S:	Maintained
>>   F:	drivers/usb/common/ulpi.c
>>   F:	include/linux/ulpi/
>>   
>> +ULTRATRONIK BOARD SUPPORT
>> +M:	Goran Rađenović <goran.radni@gmail.com>
>> +M:	Börge Strümpfel <boerge.struempfel@gmail.com>
>> +S:	Maintained
>> +F:	arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts
> This file doesn't exist yet. Just squash this with patch #4.
>
> Is this the only board? Perhaps make it a wildcard so the next board
> doesn't need a MAINTAINERS update.
>
>> +
>>   UNICODE SUBSYSTEM
>>   M:	Gabriel Krisman Bertazi <krisman@kernel.org>
>>   L:	linux-fsdevel@vger.kernel.org
>> -- 
>> 2.43.0
>>

