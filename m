Return-Path: <linux-kernel+bounces-407379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055719C6C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3E02896CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7191FB3FD;
	Wed, 13 Nov 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQJsX5Gm"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2514518A6DE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492981; cv=none; b=AVoX6PnjzSCHnZZ8k9jhyNGEGVBu4W9RBMy+fo1QFL0wuGFd8Zgw2/F/qNX0mUoc1kQP0qfr7epE+66P/gxqu4DoRf9sQOBIR/uo1q61J3SE0r+Q8dAUHS/scwUHArZN7pVaHeWBpykEp2UcePmlW8wsSnKO08uiefZRAxeSsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492981; c=relaxed/simple;
	bh=j3qFw05rD17QyA9UhxFYZ9b7cVvjCQTg7bQIEaZoBH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzF+2QB3/94YwtLCu9inVG2x6hQ4rGNgsC9liF3zAgnqSQ8Q4yBvBcF+jCtAli1vhdGYC8RWaRG3+sTikpyxXk4fSK/nO5AreRsf3n7b/ebeNKY1Sae82QT70ym+J20zzwwxnsd+1b6We8sMNnz3/BX+KtPlpJGrZqWPwlVOxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kQJsX5Gm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so56450815e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731492977; x=1732097777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/s6vyJT3HK78gb+ChTyaGH3ZjuHobo/DAVRQSopMWU=;
        b=kQJsX5GmZRueKVgGMC/VJ4Vmr/Y6odTIMTMOCmHtVn9VmqB4xq4TvIMYp4ur5oWglg
         VJzjLMS9TZY37f34D4l8ACE0q76CCFeSaWRC9aJtDgS56StISnz5wCkZxmWz9zTaCLRG
         +6ZJ1OH0YgNj6UmW4HrU8R3MjGnTrJnmgxUsQqdFWJ//TWfuO51pSpUmkka7jWA4Nc7O
         7DHfHFnzPu1vST7QBJqNWOksak+mEYnuxh5mCeJEH/fDRNPpLAOCib2hxFKAM1Ub7xE+
         KFDfY63q9XRqAvCB08MtTMx/ETAiSKJWV7riZHXRJT7LN0Od8pOrseQCpe4X9x6x50bm
         G9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492977; x=1732097777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/s6vyJT3HK78gb+ChTyaGH3ZjuHobo/DAVRQSopMWU=;
        b=QqHzaFSy6wgrZ5ShmIrNSoPpVlAZk9yfK+HjrUtqAfPpIAtFDFxfhWHbnTpDwIoFcF
         TKcLddTL4RrFv9GfiZPg/5QsCVcnG8vA8Mmmx9L6Ie6WkLub2W8YxtehKpHpIaSzRnOG
         yBcKD78DJsMQ5Beyg3a8b58887WPCbblOFpAxyEabxQ81veCDwtCrsO224AJrSwe8Xu0
         +YgYozEBgA0jagX9buKCTBvW/V/qRpqlBbG8XwtIYHImqigUg6pUUV5lqPcsSW2oRU60
         JYa5zQjj/+j9aMdtYv4urssrOgGptbZncmMe6CV+blTlaOB2YdG0it0J1r+dQ3oT+p7n
         wXGg==
X-Gm-Message-State: AOJu0YyiNEUcftMejAh/+3O9OP26Icp5NCSm6/agFX3maxOzO0kO3iHT
	nOxFq0E2E+jPTojJiZDe1e0vBbIWg+Gj6+VZSkV4PSK7mEQAkMc0QXw87dVcriw8Q3+6vD/ns1k
	G
X-Google-Smtp-Source: AGHT+IG/4tFCvVhHPznah4g0OCv3JfJsSppJiv4m7DTwOF29E9X2LqJwM3JVZZBEfKJHxUqIGgjOJg==
X-Received: by 2002:a05:600c:5125:b0:430:52ec:1e41 with SMTP id 5b1f17b1804b1-432d4ab80d5mr24665935e9.17.1731492977366;
        Wed, 13 Nov 2024 02:16:17 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432d552ea45sm19002365e9.44.2024.11.13.02.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:16:17 -0800 (PST)
Message-ID: <01f2d980-79d9-42b6-871a-a95b8245f514@linaro.org>
Date: Wed, 13 Nov 2024 11:16:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: Remove redundant casts
To: Tang Bin <tangbin@cmss.chinamobile.com>, verdun@hpe.com,
 nick.hawkins@hpe.com, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
References: <20241107074619.2714-1-tangbin@cmss.chinamobile.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241107074619.2714-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/11/2024 08:46, Tang Bin wrote:
> In the function gxp_timer_init, the 'int' type cast
> in front of the PTR_ERR() macro is redundant, thus
> remove it.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

