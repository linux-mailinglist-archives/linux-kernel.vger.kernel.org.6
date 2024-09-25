Return-Path: <linux-kernel+bounces-338003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E80985224
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B661C22D81
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790CE150980;
	Wed, 25 Sep 2024 04:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHRnt69w"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC971E49E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727240272; cv=none; b=KUtHbbDxYrTf+0GGJDWz2gyCaRPUYcnIPv1UecrHpW7D+zcVf3t7f1LFJ4VQxN0DE25o4PDQ4uFOLHIRKr/XpbypirhfcEQ6p++DC1zgwSVQfYgEA2xMBW6upJNWtF+w/bsHfwSafw+g0YcrcXXzzk783GBP6yQWMCW3LmFzODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727240272; c=relaxed/simple;
	bh=lBlqDp6O0540f+oYifxSFcL8Gq2kXJlTpK3ZOe2hZgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwFxpjYe9bBDDSkfuUYQImMQ6iuYt5/TTVDJ2lYesnaBQ+FwoAXZtbZ42asenBsJ2W3xCSnjQT8bEjhPZVHzpK+0x2IcBUDHlkr6FYXkv8V9D4mfru2dIDXMmdSBKOA9ghLbRMOVRiPP4ycmhvLVRwNXRf8+/8v+Hng57QC7S3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHRnt69w; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365928acd0so2903264e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727240269; x=1727845069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJV2XVw94OreIIZVf5rIJQQIM7YKtPS2fDsN8P1COgs=;
        b=BHRnt69wWEyAQzZXu+fILzTnteBWpxI1XajR4BK7sGuOggVLYDJJeMQEgEAoOwhTkz
         5p4Nr0obIQ+HmU3JrzUwGE9d6aI9qY5NiVvtMRrvlX9e5ds/d609zuL4AVAsMrYgkw8A
         FELof/5Quw4GUTU3NkPAK55WYDwMF/Y5UwJOMjqkgpZT5+1yz8XIsKEtUXQ/rMA5Nfmv
         Ds0S9DC9zeK+IxnbBy4Onv1iI24EiLbEKrYejELUNJ1Ehsv/9Hh+Qo9Xc2O0Ytbo5M5W
         1GMBHWohwEV6GrS1TaA1GnoCq7YPpCSGIyM3aL2crt0Wkk4y5wzDapCZ84DSkBmKKEb9
         LyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727240269; x=1727845069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJV2XVw94OreIIZVf5rIJQQIM7YKtPS2fDsN8P1COgs=;
        b=fT9nqpFEPUUSoXuvfrSK1Unv9lzj+eYsB4WcoTw8+YTWaTNBv7lKIzciIcC2RzKQnr
         btTtWhaMEH5myvmBF0NZoVchjrWQNYYPyWSItpSxIXL75P+ywhSbYRfSQIZPAjwrYYWZ
         Bf3nwwKUYOsZZJ8RaytpLGRmK40Bihr6LXkcrhp7VddyFfCe5jegKQ2bFI0SvVQws1OZ
         4jjbxo9Uhdrtj2vy/LYfGvyCbuNju14Q4wEDUBw/Uth/S910vYyWNDYg8qtpBRfrhPN0
         hrzkwWdpqTR/Q+5/WDaday1rYAe5P2hoYCGcYkjcES/aDt67Ukpp2MNnKWoitCAyJE7r
         U0oA==
X-Gm-Message-State: AOJu0Yz4qPO5NPTT4k7nJ7vCrzedlE7vLd6emhvFXc+kbsIbzhrTPcCD
	b613fg8uQMnnkgzVD7GaAPk8RtJpiZs7+m18XmZyJRPbGNCtvHzL
X-Google-Smtp-Source: AGHT+IHvIZ9ytjnTfTrHAoLOSG/2WoPRP+wSLREr5FT7kJLNJsoiAWwZGG/siWZPj+zJwm36wiK38g==
X-Received: by 2002:a05:6512:1383:b0:530:ab86:1e with SMTP id 2adb3069b0e04-5387048b8d3mr767764e87.6.1727240269058;
        Tue, 24 Sep 2024 21:57:49 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85f06bbsm413902e87.84.2024.09.24.21.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 21:57:47 -0700 (PDT)
Message-ID: <5ec5c65d-8bdb-4dec-87b2-75413a025657@gmail.com>
Date: Wed, 25 Sep 2024 07:57:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: bd96801: Use maple tree register cache
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20240924-mfd-bd96801-maple-v1-1-04fe33e1f009@kernel.org>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240924-mfd-bd96801-maple-v1-1-04fe33e1f009@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mark,

On 9/24/24 19:22, Mark Brown wrote:
> The maple tree register cache uses a more modern data structure than the
> rbtree cache and makes implementation decisions more suited to modern
> hardware, switch the bd96801 driver to it to take advantage of this newer
> code. No functional changes.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks! So, I should have used maple tree with regmap instead of the 
rbtree when sending this... Do you know, is there any occasion where the 
rbtree would be better?

As a unrelated thing - seems like you've made it safely back from the 
LPC. It was nice finally meeting you :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


