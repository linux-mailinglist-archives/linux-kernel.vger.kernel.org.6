Return-Path: <linux-kernel+bounces-345764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A349D98BACF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DFDB2116F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D7619DFAE;
	Tue,  1 Oct 2024 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7r+lHB1"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E939B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781445; cv=none; b=ckNXAxPTFN6H6bRT+klwcrYeTqIalm36rBejeTUgYK+pqwwJeHSC38H0HEoM0urp3Ky3Hxt0pZdAyts/4QyEZuqvovVqM/wJMepn6ENLa2/wG6AA+mz+GSkbTkIihnb0DVtRT+Zqh8yh7+lqJfeLngtUh4pL6ePtFz6sNPOtcOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781445; c=relaxed/simple;
	bh=0YLQnZVYwGx7c6whhcl+f04qCpt3Q3nH+Q9EQVQpZuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EXEhYDLlfFkZ/GXED0m9CRKiRLEjKU7ifugmSZzzCMcoRXtAKKmbVCtyEnGHD5p9OVgBUOm74smYLC1o7cF6+bDhzLGM1yD5x9Co2qagOjSmogrASr1iSA4aUWEvt6IQi0Lf0OJ5Mgm2Sri5ZVThZ4GtcsSOkb2gL6+ORcViZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A7r+lHB1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cae563348so7123045e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727781442; x=1728386242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zAjT9n1ya6DgNz2t/xez0nzmqHff3JldLpR0VmIQjxc=;
        b=A7r+lHB1dCmrm6VJiXsR0Ivha6bD/W5TUt/JH3sQ///W5E77X58dOj5oSDOmNx+X9p
         4Z76f6LwjNxFAntH5Vnf5Uzy1w7xdfVXXMCQwfvbtRstjO+PX+zR1uKMTJDRLl/Ecv+i
         LBMJk9n5vY6qrvNvKZtTQIHV8rzqeF4fpq2km8XK3giuMi4yrgxTzgUDAGvNqI2mhQpW
         tnQDpsVnipZLpRw9gfnlPj/Z8u3nHycJ2hgp1shkLHnOHAKSHCDXXa/5EJjEXaI0hk8m
         qIELQx172y+unhxuj9hPIx4hglQ/MnKl9J3RY3yzm8Npz46j+r05qhlbKvJYvrRvwTLK
         AH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727781442; x=1728386242;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAjT9n1ya6DgNz2t/xez0nzmqHff3JldLpR0VmIQjxc=;
        b=MJuhsWNkwI+cvqBaeqcg9bgRzQKemkScL3l5VY5wJgkjfwdDQ0Jn9bW5aLRcEQ/fSm
         eQoC/WiTqWyW79p1VQ/KRgcmWpzfWs8bEVyfkeT4S1cAJQeDhSsJHUWt0zsLqgywA/3I
         ThWXwYvRZm34DRVCQWIlR5+ZwBrCy90Ep/9nRaJvFyPm5+7CcdL78mJkWy/8+0J18fh3
         gEHMgdLkE2eLlr45fgMWn2uRqC4tjnB6E1+eLdBSRO1ZdBca/B7+CaB5TTALaWZP1h5F
         LpzGCITW8dkb28Fl2QcOpK1q5nPKLEaMUvzIxls+IRFVW7Io1cyPPqxxhsd1HrY5EWfQ
         YEyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFBTZJx2dMaqyqc4nQXDaCKeXbZwU5Vem8ufL+AUOmYONoJp+UHHPqAfdl41hGp+pXAKWtnHKQ6ehdgRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdEIsHI0lcURmFRnEqI9K+fMtu0B+FI5LGpfKuWCHIAz1jqdmY
	RHsHscy7B76NvRwG/rn0AbUdEGN/c2hgl2k2TnmaYD8y0AheK6xPcnh6SMCln1Q=
X-Google-Smtp-Source: AGHT+IF5dXTsdwRbVu1AO70fz0ASIUiIPur+LQh9iyAH43rKaYvsaFuAQBs0YAsFATUjlpO14ujpIQ==
X-Received: by 2002:a05:600c:4711:b0:42c:b995:20c2 with SMTP id 5b1f17b1804b1-42f5e389525mr40074105e9.3.1727781442088;
        Tue, 01 Oct 2024 04:17:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd575d459sm11465893f8f.113.2024.10.01.04.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 04:17:21 -0700 (PDT)
Message-ID: <1313b5fa-b68d-4271-a4f1-241404cc1129@linaro.org>
Date: Tue, 1 Oct 2024 13:17:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] soc: marvell: rvu-pf: Add PF to AF mailbox
 communication support.
To: Anshumali Gaur <agaur@marvell.com>, conor.dooley@microchip.com,
 ulf.hansson@linaro.org, arnd@arndb.de, linus.walleij@linaro.org,
 nikita.shubin@maquefel.me, alexander.sverdlin@gmail.com, vkoul@kernel.org,
 cyy@cyyself.name, linux-kernel@vger.kernel.org, sgoutham@marvell.com
References: <20241001104948.2779665-1-agaur@marvell.com>
 <20241001104948.2779665-3-agaur@marvell.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241001104948.2779665-3-agaur@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/2024 12:49, Anshumali Gaur wrote:
> Resource provisioning for virtual functions (VFs) is done by RVU admin
> function (AF). RVU PF and AF shares a memory region which can be used
> for communication. This patch adds support for mailbox communication
> between PF and AF, notification of messages is via IRQs.
> 
> Example mailbox messages types and structures can be found at
> drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> 
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>

So you implemented mailbox drivers? Mailbox drivers are in mailbox, plus
you are supposed to use mailbox API.

To be clear: Just because I responded to you, does not mean I want to be
CCed on further patches/versions.

Best regards,
Krzysztof


