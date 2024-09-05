Return-Path: <linux-kernel+bounces-317757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D038F96E36C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341EFB213BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D916190049;
	Thu,  5 Sep 2024 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JZPtTjIT"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F615AAD9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565617; cv=none; b=Ag4iZROsgVXA+9mREYCZzLGJxV/6/tf4600U+CYykJCt7GXy+xJ+hr+r3e0fqr0jV+Tjz4ziOZVh5fgXu+NvGesODN5ozAg4QIzZ/xKW6s+cSyO7EUB9G5HHKjr6kCBESpmhaw+FS8jgXQzbLFOytYF8y47iHvNi5NKJgExHTQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565617; c=relaxed/simple;
	bh=Rj9EBbv8T82SbHtDUYf48lO4jfistsnG+jbe1pq8Yh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ar8uwo9ZD1lqfUIoIasLNVrOjZMtUjV/SlyPH4wX4882UnJ9LQt5PFcBem27cBgrfzd6rKxvi2l5X3hilcXcGq8CVNm3ZF1aLeIq430+E+4VlaIHbdIUgKcZ05ua9A3ZbQTy+br+06S3FSMnqaMkXPQHwS0zHBEX8atcTq6wjio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JZPtTjIT; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70f645a30dcso929442a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725565615; x=1726170415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZL8vVvQXcg/nFczvtC9w0usBRA91vb3WVnfhcCu7W8=;
        b=JZPtTjITbQ2LmnSAqatyWf2OTCVJskO7AYo1ZeW68OSqDgdQmvWN7KREUOpjVFECYY
         odsUb7lyQwKY6VtIf1jPq+5rVUm+5Hv0GCK8GuL9QdpQlSuzGmwyM4NfFSmMGI9qBfFi
         1qwBfZFLF0VZ9tYqoDfYa5RD/gQ0G6XT4oa98i7ftWW7Ih0DRGjEQ1Z/r9nXya58WzfD
         LH2NWCVFAfOUy2+gXxJb95M8r5aq1JMzZ4BygHi8wXLkJZjv7BbOy2Rn1vTEgZnM+sQA
         LTBnPu5CfXLEbQoyLvztZT3UTtxyVrCPS5aU3G/1htZVeSVE+GUCz1qw3c0XiIBo3z0+
         liLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725565615; x=1726170415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZL8vVvQXcg/nFczvtC9w0usBRA91vb3WVnfhcCu7W8=;
        b=tvQVSOzMDFZ98JX7XblHCD05ESYBNGoU3c8DahmKzFkGaiWwKNy9jIfknOEfwnV5tU
         RER5V5VuplrO6tnoYDZAAW6xCGUuTpKpX+lnP40XP7zBoFGvJoIVOwstlGjwXOSZJvrv
         mRX1PpbnjSavp8nOvj0+PEwStWmxribFlHfP3XYJZwoUBHCQQEUHZMrb+d8kYun5JFCR
         TZ+Tf125YjBuykqxRMtrazg5E6GaRAQLVRhF1bdYPrqfquLYNPy/t85xKjAp02xE4EhF
         XU/SQi541NHQURxzfiePCWyl667DAh8lVJbNmUTqPOaniCQvXg4iu3B5ON/6vqtREYg9
         chtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl9Bu2q4W//XbysWs+MXGJVgBpM3vBWY9rp6Rcfic6KCzyXFpipcKENMKr4LsEIC40G5w7+LWU4P7Aviw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybnFRakpbL5jfvmfARib5FdkDucBn+gtUMfGB2r1/GV5Zlve3p
	n/O4FmjMKoWuK8cjujOXe+rD/63VlD/QR3BBvPeDHRrQ9yKiLxi7dhedtMRQGFA=
X-Google-Smtp-Source: AGHT+IEHPlIovYEH27hEkBbb+vjFH3QYPh/IbNkdMwHYBPqS+CTAHK+w94F+Gf/vMRtIbUsPJ+Zu+Q==
X-Received: by 2002:a05:6830:6718:b0:709:46ca:665c with SMTP id 46e09a7af769-710cc217cd7mr243472a34.1.1725565614803;
        Thu, 05 Sep 2024 12:46:54 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f67142890sm3356143a34.12.2024.09.05.12.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 12:46:54 -0700 (PDT)
Message-ID: <dc0e45c4-3876-4d45-b5dd-60f89c9d09e1@baylibre.com>
Date: Thu, 5 Sep 2024 14:46:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] iio: add support for the ad3552r AXI DAC IP
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/5/24 10:17 AM, Angelo Dureghello wrote:
> The serie comes from the previously discussed RFC, that i
> converted to a normal patch from this v2.
> 
> Purpose is to add ad3552r AXI DAC (fpga-based) support.
> 
> The fpga DAC IP has been created to reach the maximum speed
> (33MUPS) supported from the ad3552r. To obtain the maximum
> transfer rate, the custom module has been implemented using
> the QSPI lines in DDR mode, using a dma buffer.
> 
> The design is actually using the DAC backend since the register
> map is the same of the generic DAC IP, except for some customized
> bitfields. For this reason, a new "compatible" has been added
> in adi-axi-dac.c.
> 
> Also, backend has been extended with all the needed functions
> needed for this use case, keeping the names gneric.
> 
> Note: the following patch is actually for linux-iio/testing
> ---
> Changes in v2: 
> - use unsigned int on bus_reg_read/write
> - add a compatible in axi-dac backend for the ad3552r DAC IP
> - minor code alignment fixes
> - fix a return value not checked
> - change devicetree structure setting ad3552r-axi as a backend
>   subnode
> - add synchronous_mode_available in the ABI doc
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Co-developed-by: Nuno Sá <nuno.sa@analog.com>
> 
We didn't actually write any of the code, so I don't think
Co-developed-by: is the right way to give us credit. But we
can give our Reviewed-by: tags when this is ready to be merged.


