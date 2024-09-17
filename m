Return-Path: <linux-kernel+bounces-331427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F5997ACC8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3461CB2B1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8DE154429;
	Tue, 17 Sep 2024 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrORAqEf"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14314A60D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726561282; cv=none; b=uuewvUlOfbgHr+jFP1yQbQ3o967OMouJhthBo0eNJFnJcTIhPtko753rrQALnvIHwG7l3KIFvO54EOWQKT6xVkhDM/hq1g1Vuy0YWmEt4lYBs+5EVCiwQYSA+Weg7lcdcwJLg/9RlLqixQ419fMGCVSNcHG/R5JWnpFbEwagHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726561282; c=relaxed/simple;
	bh=Qamxe5M4Gu+pC+loKbr1+wEKyhOzZm3j9Zos4H/zOxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T//QqtQ4RsmgXYEgN8XICKkH4nBDd7s3xhq1EKXbJyWJ7usUgKu+SsWDyxD+o66sbOPsHdhxZAlApJ+wWuDuIjZe2P4Tbz0VPunqh2IiekXYU2ft5Ylr79OfiIGWZdQd0IS3EQPssW81hzUxRq6bSOv/6Z7Lb3bkLc8d41nPeOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JrORAqEf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374b3632ef0so382689f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726561279; x=1727166079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Gl1ESV0nmMekk7cixSwa+VlYUedGg6ylCQTX5FvxwA=;
        b=JrORAqEfqZ1DAFVk5rNOdxWOjvsEAZhX3O2/nmSEMWZKOkhLGzuHaKBsFRvZce1Hj8
         vFt0gtM6PFBSIeJMCeqf6YBdW8BhyqvSb3yVY9FpStstSZzut80P6xcZvdiRhnY51FlW
         naY+u4J7GddGEX79toC1khcUQV3rNQsilPcDMPdMTx45lQ9ohNChK8Nt+aqekmRvi7yz
         qmcU9qbRfSfVWAimPt4QclP5LQ9tdzsKLL/EpWwUxE7EXyKpvJCIy3mxx7rOaVYJqUGC
         xHNZG4eWE3E48oLVTQ91iT40ERqYD4/vyB3u1BwA8UCQGZE6igPY+dsI7XR3pL4tuH4M
         iwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726561279; x=1727166079;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Gl1ESV0nmMekk7cixSwa+VlYUedGg6ylCQTX5FvxwA=;
        b=Vek5IOna5sC21SmBgUf75ivm62ZGCZ7Okf23E2/UASAiHN4t6RwzbZBxXn+5Q+V3UW
         mm1g9isg0/BqtDhZteTqX8LUUvod5BxwnpqkgQubxQ75YF6YRJlDY2fnuSqOqlncIjWP
         i90jqBEcTdZNxxaCC577VSreXhNoAcJPkDQhRPjeqqERPvZjl5yfGrtXo8nkwa16YtLL
         MZKY6ZBfzHbDzkz1lo3IpLHhYh4j1eU5AC+r4rlirIDrrYoF/eMFViLfNo5fQUISXl2i
         syAkWvpehaxDGCFHASx86E0fdX080U9EFbtHSYoRAeLQxdbpXy1W8THkqakDQcmY97uF
         mTsw==
X-Forwarded-Encrypted: i=1; AJvYcCVrw/y9CwpnfxI3Pgq/vwk9pgPPt4HwfHqPHXYN9C17ccuirhi/gQQyDFOA1pB73vuvY7fc5IKTJOTHyjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZoZJQMo8jTV/UcMMBX2P+8ymfeej5r9RSrKOceqZGLQJsaHM
	cQl0qAMnrx2OJCpp5IMy4WPYE9BPIxbAuqPRJ10TibTWojybBR3r3nXiNpqTWoU=
X-Google-Smtp-Source: AGHT+IEXv0rbBAZB6e2w4JwrMueIjjeZhUB+JJEveyf7HxKC3yDudNiuaVwf0qkhZVvlqLek+zBsDA==
X-Received: by 2002:a5d:5848:0:b0:374:d0a1:6fbd with SMTP id ffacd0b85a97d-378c2d07c60mr5502836f8f.8.1726561279286;
        Tue, 17 Sep 2024 01:21:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05dee7sm129105905e9.18.2024.09.17.01.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 01:21:18 -0700 (PDT)
Message-ID: <99a6eec3-ed24-47b2-af07-b4764c6de6a9@linaro.org>
Date: Tue, 17 Sep 2024 10:21:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: colibri-imx8x: Add ad7879_ts label to
 touchscreen controller
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
References: <20240910152213.2072743-1-ghidoliemanuele@gmail.com>
 <1cfe3f3a-28a3-4030-b6ba-3892a2a7bc79@linaro.org>
 <20240917074544.GA7916@francesco-nb>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240917074544.GA7916@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2024 09:45, Francesco Dolcini wrote:
> Hello Krzysztof,
> it seems that this patch requires more explanation, maybe something
> that should be part of the commit message, let's see ...
> 
> On Mon, Sep 16, 2024 at 06:10:55PM +0200, Krzysztof Kozlowski wrote:
>> On 10/09/2024 17:22, Emanuele Ghidoli wrote:
>>> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>>>
>>> The device tree defines the touchscreen controller, but it cannot be
>>> enabled because it lacks a reference label.
>>
>> It can be. Just enable it...
> 
> colibri-imx8x is a SoM, it's not a complete self-contained device. The
> display touch controller is part of the SoM, however it is kept disabled
> since you need an actual touchscreen to make any use of it.
> 
> This label would be used where an actual touchscreen is defined, this can
> happen with a DT overlay, for example.

DT overlay should be in the tree.

> 
>>> This commit adds a label to allow it to be referenced and enabled.
>>
>> You changed here nothing. For me this patch is churn and pointless.
>> You add the label when you need to use it.
> 
> DT files from the Linux kernel GIT are used also outside the Linux kernel
> sources, see for example U-Boot OF_UPSTREAM [1], to me it's fair to add
> a label for an out-of-tree user, am I wrong?


For U-Boot or any other upstream project: yes. It's enough to point to
lore patch or lore link. For downstream projects: I don't care, just
churn. Downstream should upstream their stuff to be considered.

Best regards,
Krzysztof


