Return-Path: <linux-kernel+bounces-238366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B55924934
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7451F23393
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA73201241;
	Tue,  2 Jul 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="IGVwUuyc"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1FF200134
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719952099; cv=none; b=QLhiG89jL6dWzR9eru6GfsLtpffSWZ3OXhlvpjjYi3azu8vvkmYC52GUa1b+zM5ZQoGTgo8xMGTIcnwtQsUlcmXD38oF2nRJZO9Kx0nfz/WSwYsbtKv/HF4AZAvofWM7GttdKZgPyqYjHLlYhumj8o9uJAQzlNm83rG9h0fVkMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719952099; c=relaxed/simple;
	bh=ZrE3mRVGZ+ndBhYz/L7GW+MlUirBfT0klU3VQWU3i+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAj+eTset25s/3ipPBBOsFg1AmeVv9yh92IPqPw1MZk1y+XhfLYpeDuSaw4dH1+uz3MTeWIP4QNOVqASPlWJJhvcOzVgFHs3AqUgCSooCqCH9rsLfu93TXt6fdImlAt0U9FpdJ0hXozkQ1clOfLrvpxQaz5TD3lV94gmA8WiP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=IGVwUuyc; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B69013F17E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 20:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719952088;
	bh=PjCPClCpjBs/p2tUVXJFW10eusIRDwEpK2dNZ9Ttm5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=IGVwUuycj/GjEpktdg+dPio13rqWmS7q0reGIY2kqHD9yRUQDWwU/j6eCrnawOqZS
	 a9/WygOshI4RqdcM2HJSF3zJ+Og1HB+FacA8aBGFXLuJ3ZMUkO0SdUgHJBwf2B7OtP
	 R+dMMUbkxFEG8ybO2a50riFRDi6zutv0SosgEJmdnXdVZf/7igWhYCU0cPJGO1V6Bu
	 JzB6Jb5SB+42Ie2fma5htv2VKqBzKH4FRDLMBTGKRq+Cj1yJWGDx8wcFCl0pyn6FKU
	 WhktdYd7wkxIOggezy9GPLIcgD2c+1CsgR8+bO2tvoxWolKuUUZIBkTSiqdTgFeF/I
	 2qHvxKIGlKLVQ==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52cd8314430so4483825e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 13:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719952058; x=1720556858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjCPClCpjBs/p2tUVXJFW10eusIRDwEpK2dNZ9Ttm5Q=;
        b=bVDgh2OROMjBQnQmOPQkAXvF0dgQvbvUkGAiSyXmjT3uLNa2F0ssrexC2f/zbH+c3F
         pXEan6d+1U7CB4OmB91uA/YHi2iOY8+SSovdplKw+vFWI69oY+Y1VziTWMq9acvw15DM
         GsX7pibYmN5fJULUKZ9Igtl7ERM1ug5Ke2NGXTGHmTxgFZsNpcVhexBdiGHtOHfPN0HK
         h3PEpvjjTa0R4tqVvZlq9ztgTbPHy+YxXLMe4YzLiq7IHt6x/6lB2srFh4313aU4Mjag
         S17zcazvlXyF+wM5RwzLBJ8W8gXM2jJQgI+f5dDIscELNhjqw0k400ZMvRjWfLVIfsag
         9xPA==
X-Gm-Message-State: AOJu0YwLY8yRaTlCdNRGpjvbaIoPIFtzDRIHtQxdIeOXv4jFYTZm0kke
	4y6ngNwHodYgi3RK6nStZK9HYtA6Mh4Hkh2rI0q+QTsYrnv+RPmDvVCyM6oTNPoeimiAxEImxpL
	JXScrfCwzzekgjeNJIcX7kcirkNF4xAN6Mf9tIAIGA3thGtXs0gJTr7GJc+Dqh63cre6P4pMKN3
	Gg1A==
X-Received: by 2002:ac2:4e0b:0:b0:52e:767a:ad9c with SMTP id 2adb3069b0e04-52e826fc0dcmr5971734e87.53.1719952058117;
        Tue, 02 Jul 2024 13:27:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrPClqZ7t+PLQg/6c3CMMDg8NF54ih1EeXULSqoKAEw+bmf9ARIbHAngTG/EH954cztfog4g==
X-Received: by 2002:ac2:4e0b:0:b0:52e:767a:ad9c with SMTP id 2adb3069b0e04-52e826fc0dcmr5971723e87.53.1719952057709;
        Tue, 02 Jul 2024 13:27:37 -0700 (PDT)
Received: from [192.168.123.161] (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d90d5sm14187690f8f.31.2024.07.02.13.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 13:27:37 -0700 (PDT)
Message-ID: <530a2dcf-82ad-4e59-a162-5d3080766e6c@canonical.com>
Date: Tue, 2 Jul 2024 22:27:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libfdt: check return value of fdt_num_mem_rsv() in
 fdt_pack()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
References: <20240701215441.54353-1-heinrich.schuchardt@canonical.com>
 <8b083a48-5e56-493a-b235-60afaf794fd7@web.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <8b083a48-5e56-493a-b235-60afaf794fd7@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/2/24 14:54, Markus Elfring wrote:
>> fdt_num_mem_rsv() may return -FDT_ERR_TRUNCATED.
>> In this case fdt_pack() should propagate the error code.
> 
> 1. Please choose imperative wordings for an improved change description.
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc6#n94

The current subject is an imperative?

> 
> 2. Would you like to add any tags (like “Fixes” and “Cc”)?

d5db5382c5e5 ("libfdt: Safer access to memory reservations") introduced 
the check that returns the error code. But before that we could simply 
overrun the buffer. I would not know which patch to blame.

Whom do you want to Cc?

> 
> 3. How do you think about to use a summary phrase like “Complete error handling
>     in fdt_pack()”?
> 

Why should I choose a less specific subject?

Best regards

Heinrich

