Return-Path: <linux-kernel+bounces-201064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F868FB8DC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA04D1F2790B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6CC33F6;
	Tue,  4 Jun 2024 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khSw4mWj"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9E14830B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518397; cv=none; b=aPLu1j8XeMd4H4Cnen019zNLSblTb0QQPv9S4rbxDXJI13vE4kPIqtFIMmPdhs1DKxezL2fuHQFUj42Ajc23F73WUs5QlYLd7txF97sc1f6/3pzx5MRcUUeCGQxlSVglfrfwJJS9/e/j7QcUKGuBt8q5n98MqlQ7VTVjVfaoDAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518397; c=relaxed/simple;
	bh=iQ2gF2aw3EqtVz6mXx/ihGp7xrtcrjNwJoL3Ih+kJYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GM03Oq3ep0xkWEGmfn7BKMyVGpXNf8aIOj6UVbdpsLjHf/rkmcJTzXyjRQi8P/1JoYz/VBF6Cx7IaUNyonsMDM+T5yQeApjg/D2au1UwaHay0vjFpY6+4dxz+Y4PVnbItjSd1UXjL3uLQpwzaxWJMh3sQfAAvFknRhIxrr72xE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=khSw4mWj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354be94c874so4826467f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717518394; x=1718123194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUCeKEvxZz0HcOYxIJIcV5v8P469mjR1k6zX1etfeFc=;
        b=khSw4mWjDBSa6XWHjGJRXbZx+V0WWgRLYRcVLBHg2HVjwwUO76gOvKh7yFtOZyQtDi
         etn8AH/PzNrCUkSplpYsgArXNe5EjzuLXv55dO3sImXpL8J2WFL6+bF07CchOxusy5OQ
         zV8BxjUDLYTpWLfgccVm6XIi5fdVhvxzp6otnExDCp/HoNpFYiui2e4AWIWAj3Nba6Zm
         /7e3CLZGoWXp4LWQUJUEpAZvBuQU1KtGTstDpnFg12kJMmFXRvFLZ/iDJaxGBOcoHIX4
         DyCZRScZ/oNJSJUll7+H1pbcfTwaKmzsBfq4H6iwMS0RsDFTzVPc6Y6UYgdWgT44Gnih
         hDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717518394; x=1718123194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUCeKEvxZz0HcOYxIJIcV5v8P469mjR1k6zX1etfeFc=;
        b=PAYQyc5gmEXUEy584Hcz6FqwESLoBym1gCwggBTuojuFnSwQR/tYvVPyoO/GytJ4TM
         DhDebjD3IbSAqVw/igSqdgIQDQFDCivtkvdSl0h0P/tfcHo2z6M/19LEGJc1PGkPyxCU
         fa6SeX/Kss2rOHz9KXvSRNZYN2QuY/GPiYej0gGSWXMkIXSy6s502efqi1LC9ZJKqppl
         ZOQkh6lpFpPhFi0Buxp7ecDaupZrkPi/n/aqIA3zWShfDHB+zcPX2KvbalPJ8PWfdI7Q
         PijCOVzVJnOQbGUcYpDJDJOInLdv/kZiAu4rCBAIBTn4kO84hbrCHwXj+creO5tJV8eN
         ZZog==
X-Forwarded-Encrypted: i=1; AJvYcCUazWK9xoiO4Tj585aMvqXlTKlenomBMcl0rDgOnOw9JNNfRaTdG8Nf2A9jUS5fbBaf+O1DlR80NsH5kGfXCxORCqqu6ofI6FQVoBM4
X-Gm-Message-State: AOJu0YybP21L0WH75p/joCtSs1p+ROOv6TKe8ahVRiPSe9EfD6QDDzMf
	Hg2UkucugV/HlEd9HZ1/OuiFk7Xoe1LtmH61c/twdHP1TVOtM3z9lBtOCcXO7hE=
X-Google-Smtp-Source: AGHT+IGK57QEvZAxhgQzPqjoqwkElo9aa4K3ynD1xAtn0P8/VrG1nhjr5im/3WDHATMN2L5PdEq7og==
X-Received: by 2002:a05:6000:b90:b0:359:b737:51e4 with SMTP id ffacd0b85a97d-35e0f2599f2mr11664148f8f.2.1717518394363;
        Tue, 04 Jun 2024 09:26:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e559:5ee:5c4:82bc? ([2a05:6e02:1041:c10:e559:5ee:5c4:82bc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd064dfd1sm12164509f8f.108.2024.06.04.09.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 09:26:34 -0700 (PDT)
Message-ID: <246f3565-8d54-4569-a9b0-164b653b3f81@linaro.org>
Date: Tue, 4 Jun 2024 18:26:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Return error in
 case of invalid efuse data
To: Julien Panis <jpanis@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/06/2024 14:06, Julien Panis wrote:
> This patch prevents from registering thermal entries and letting the
> driver misbehave if efuse data is invalid. A device is not properly
> calibrated if the golden temperature is zero.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


