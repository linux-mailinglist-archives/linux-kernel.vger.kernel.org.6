Return-Path: <linux-kernel+bounces-413579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF619D1B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21C61F21E71
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EF51E8851;
	Mon, 18 Nov 2024 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2SML3F0"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869451E7647
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970347; cv=none; b=Eb2UQ7gJ+bL8c5risaNgK1iu88oTXppuc/oLBzf74/EKSdiAVSOBxOn0ks8SrNf3qIux9rT0NhqUbbAT1uokguBRNdjWX4xpdNYFK6bDhecQv4L+Z6IWYWNKOdxaKJjgaZFIu/RVO3RqyJISGxO9MgpUD7GIaakk0cTkyCosOio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970347; c=relaxed/simple;
	bh=ZdXm3iVe/pHNYaMtoEOpHIfW69+kJg3c731+QVPRDrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZzZZ4ASU2auSBaDIsUjUiPoSnjiT5yowwP29mgJWRnjaa0P5wWadA+38UJqW91EWswxSrAlc2QK5RuzLpxl2x8XT8Ij0t2vUBH5hAJ2L7HsXQLRSle7dSU/AbQC3rVJAS6qAa+iWKLlQXsfHhWQw4cbexoL+Ua1NegllpF5EfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O2SML3F0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so32362125e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731970344; x=1732575144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQZ1H7BLVJlHjVImlFPAn8pO0c0uma6JbIMH8fW7XIk=;
        b=O2SML3F0n/cV6xRkSM+M770ZzpSBgOsUysjLsZEf8jD5N5igqp7FPr3NwPnduG+kLS
         HjfZZL42cNf6AB3/sqALDwJjwgiNeSrcSHoHNy0InWAuMcZLJ7jhz1FpM7+gJ/SZsckd
         ei3WeEhHX8MpeHe2W8OzXFe3qm8zleXJyDKwqSzzFAcU0vzIbfPw7mVxw3kEENE3aP3B
         uApBG3lWVz0lHQ9dI0jHQlXGRh6BOkPKA/zrFskayzaqWw/XqLN49ZvWdNhn9r3iBsTv
         9x4YVftZgwpCyrzzlWpAnNgzY9/0Fzrpe1A+z7UExTei5DT0k4gednYQLh8MUsTPcQoD
         EtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970344; x=1732575144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQZ1H7BLVJlHjVImlFPAn8pO0c0uma6JbIMH8fW7XIk=;
        b=rTVAxd47p0oH6mRSz90fL/NceeGEa6xmm/glgl5RedhlMseM2mX6GKkasLheuf3euN
         rlSwNOYON4OlTYUIF7Rs3OrhbqFurnIMNvT14dnvDEWd9fV4PC9GkuXivS0moe4lvGf4
         3jCKPgpngdR9KG+8j81aAUNJ3XTd9HGOKyPiDvj1V/3YBi5WxVkIG1UQN2KlYq84R4d4
         MhipgmUGrI9d8XNr4+soI5CyhfMxH7d4SDx0T4dX0/gfh9w/QAgPjyJ7NLw641m2Dx4E
         nT8jz7ktL2eESdLv9/U/0NxqviY/AwfC0dHVwy6lZm3VDErwgsB8widugj2v0bi4LPyv
         dLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjXK47WPF+mzSBQKWTQy5VWTNvzNfPUqyviqyb6buU22p0OXMvAWft/lPJyr+K538NopKDO5RoSUxVDOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMqEGpLg8qNzNM8uU/s55iQ922cbycLa8qF8vqoTZ2kYwoGL7m
	tKf/S3F4ax9BI11kxs8k9cETYO+e2MksxledXSDU92QDwYHVZU3VFu0f74f510I=
X-Google-Smtp-Source: AGHT+IEpllqNeXrLFAJ6hV+Vn+2k7uE4VkD/xEA3WWU8D/eic5WliEwLRK82P9EcMjRhkP5rXePrFw==
X-Received: by 2002:a5d:6d02:0:b0:382:4b63:96b5 with SMTP id ffacd0b85a97d-3824b6398ffmr1759861f8f.57.1731970343837;
        Mon, 18 Nov 2024 14:52:23 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382435f6986sm5752267f8f.42.2024.11.18.14.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 14:52:23 -0800 (PST)
Message-ID: <79fcefae-ef01-4499-9532-fbb87ef8f0eb@linaro.org>
Date: Mon, 18 Nov 2024 22:52:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: qcom: common: Add support for power-domain
 attachment
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-0-b7a2bd82ba37@linaro.org>
 <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-1-b7a2bd82ba37@linaro.org>
 <8a33c0ff-0c6d-4995-b239-023d2a2c2af5@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <8a33c0ff-0c6d-4995-b239-023d2a2c2af5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/11/2024 22:17, Vladimir Zapolskiy wrote:
>      ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
>      if (ret < 0 && ret != -EEXIST)
>          return ret;
> 
> That's it. No need to introduce a new function, not saying about 20 LoC 
> off.
> 
> Next, you have to call dev_pm_domain_detach_list() in your version of the
> change on the error paths etc., fortunately this can be easily avoided,
> if the resource management flavour of the same function is in use.

 From memory I _thought_ I concluded this was necessary

+    /* Only one power-domain platform framework will hook it up */
+    if (dev->pm_domain)
+        return 0;

=> for clocks which have a single power-domain the core framework will 
already have setup the linkage by the time we get to this point in the code.

But, I'll check again to make sure.

---
bod

