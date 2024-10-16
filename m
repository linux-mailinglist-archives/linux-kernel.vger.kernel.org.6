Return-Path: <linux-kernel+bounces-368579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A629A119D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2971EB20DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063CD18BC33;
	Wed, 16 Oct 2024 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NkAVhJkT"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9418BB89
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103540; cv=none; b=oLSCT42Dx6W0wK5I/T5isbWHEchsGZy4EhmulNHoLyDUoj2CP77umUyD0aKriRxgP6VfgL5qJjIaV0kuoki4XKbQSOy6MhAShy2nsGr/cb/r5zbOLl5O2Wf9CGAOGsBc5J6QLQ8NdZHjGKRe4fdqlM89FOxr/RMNVAyqRkJJhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103540; c=relaxed/simple;
	bh=EUpKjPw0TjH6jIqO9u+AwJdLn0bo9vlIlSUSehKj3xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdJMUUS5mbyi+ToxBxIJGm9hNXKrtNlKK55aqHcsHsL9fuTqCL5FieHe7cUs3J1E7FkYrRGMnWSU8A6JWUTtKYdP2d3DBlVMkcgn+dptzClQif3b7wRfpAnRuoGDTggD0nf9HqcX/XTp/nYX5YjjUGFQ6w5GWz0vjlJS8iSw55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NkAVhJkT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314311959aso1183475e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729103536; x=1729708336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5wnG/XXkbBBxfuxVxDQB2UThw1UiIyk7I2E8YBU9cg=;
        b=NkAVhJkT5imoZhhphqyq/PxDLHPEXudUnT+1ZjgkVvEpS0yf9NBmv8UlPNgfkwThPE
         nXsnMTA8W4OS97WRoi053pNQuIhTMfw2iaUOCrtbpMDCD4rmjb31W6nO0pGVMrrWA1NU
         KrOMA4mWB6xb6kqzh1FIsyRjUSeDdvXjpkQi/gGiyKQ+mQtiMlfdEWHDBfxqdwuWBD4w
         ml8wOqJ9LrC5Ut8GDJXYBI+jpu9NwRhQp+FKu8h3VRwBcsGXywznDE5iqRcwNdmAKDyy
         E8QkWaHQH3BzPaCzllLDYBClCv9iYvxyKBiFf+UJ009r0Le0/kwH3M7/jRVUb3O9gPkW
         YCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729103536; x=1729708336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5wnG/XXkbBBxfuxVxDQB2UThw1UiIyk7I2E8YBU9cg=;
        b=AMQbSgEy3FABK6lji8V5sA3uJAuFNK7c7CfTnWk+Vi7KMlfLEpc+wPB29jy/hjq5Al
         wfa/Zqh5SxgA8WuVywvUIT0YTZp9+yK6He5PKpIgYFrbfZzQ2XeY9aQIiuUI0wV3T/uQ
         kzr0cHVsnxvGeVqAdIqX/tlbcvbhABXEzQMoOjMaqZ95EoSUBLNJY+zTuE4QTHMDdNKU
         OcSW0TEGaeoSQOfe2mFMHyhkkNGB7zIYqhmXbZawII36yXfwxUnibOPatUnWJBLN020K
         6LYRnaDPqPpPIVHuDutZSOKAIRPS6vjYxW8PbApifTUxZ1ARow53i5f8TvXPkHtw8AAZ
         8XfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyEPLoJq8CHUdtkWRHCXIiDHT96RAo+Qvfh/zQgNgMCTRtU/ynDp8mnakRG/4Zk0G+VeCr2AMNUXPUeKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCFEglfcpg1FmA56ZK+wXtt6HNDgSHufIV5xgEcY/wJIeLYdGa
	fCASoSe2f1uIjYzP1Jo8NpkYSctdgTk5tqs0XaELdOZnqzwsWlAEq4To7Gv6fWA=
X-Google-Smtp-Source: AGHT+IFLcus725VljaUUGVmu/rOwU1gPwfoWv724VI3Thb10mvWyJcaDjIPQyXmNkdDE63CvpwwwfA==
X-Received: by 2002:a05:600c:3b14:b0:42c:bae0:f065 with SMTP id 5b1f17b1804b1-431255d4e77mr155553275e9.5.1729103535871;
        Wed, 16 Oct 2024 11:32:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:a9c0:1c6c:5427:e89d? ([2a05:6e02:10a5:e010:a9c0:1c6c:5427:e89d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc40a24sm4962549f8f.104.2024.10.16.11.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 11:32:15 -0700 (PDT)
Message-ID: <ba5a5208-50c5-4f84-b1e2-18fa9bbe3b75@baylibre.com>
Date: Wed, 16 Oct 2024 20:32:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] irqchip: Kconfig: module build support for the TI
 interrupt router driver
To: Thomas Gleixner <tglx@linutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 vishalm@ti.com, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Nicolas Frayer <nfrayer@baylibre.com>
References: <20241016-timodules-v3-0-fa71091ade98@baylibre.com>
 <20241016-timodules-v3-1-fa71091ade98@baylibre.com> <875xpsatqo.ffs@tglx>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <875xpsatqo.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi ,

Le 16/10/2024 à 18:38, Thomas Gleixner a écrit :
> On Wed, Oct 16 2024 at 11:41, Guillaume La Roque wrote:
>> From: Nicolas Frayer <nfrayer@baylibre.com>
> irqchip: Kconfig: is not a valid prefix.
>
> This is about the TI SCI router, so this wants to use the
> irqchip/ti-whatever prefix.
>
>> Added module build support in Kconfig for the TI SCI interrupt router
>> driver
> Added?
>
> This wants to be 'Add ...'
>
> You fail to explain why it is valid to build this as a module, i.e. you
> did the analysis that there is no dependency on this before modules can
> be loaded.


i will rewrite commit message and title .

>
>>   MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
>>   MODULE_DESCRIPTION("K3 Interrupt Router driver over TI SCI protocol");
>> +MODULE_LICENSE("GPL");
> This change is not mentioned in the change log.

it's mandatory for have possiblity to build in module so for me no 
really needed to explain this but i will add why in commit message.


thanks for review.

Guillaume

>
> Thanks,
>
>          tglx



