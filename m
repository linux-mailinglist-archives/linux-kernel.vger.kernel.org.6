Return-Path: <linux-kernel+bounces-532221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF85A44A73
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CCB863CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F722036F0;
	Tue, 25 Feb 2025 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="GNbCf/o3";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="ByhPtz+6"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDAB19DF4F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507847; cv=none; b=PYBt2NQj9O3ajfyr5OocyMHfCmA0TYPcTn2uCxxXKU4m7h/3Db9oysulbgMvsOC8ULBh4GbPezl1vGn9nm4K5sHtBZKgvQuQ+gYshLTCoxrIoKO1mxA9ufc4W3IP57P23Fqbcsk7mtliNDjoh6/ZuakmA9vebmb0PfhKABYhY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507847; c=relaxed/simple;
	bh=SBkC6K1saiGACNoan7QB2EPwo5J7cMg6MkvBnK5tNHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTxOYkaGsZt4sZu0GxwWYwj6nrQ/hGMotOPfCQiA/jHjz5RBHfO8pGq5YiKt1Lpw5kqtv1/LMkn9iEY2Rr9qNc32jlYfFQFybU5UrVl7ctwqpYFtHEM3LXwtq0MQNcAp8v/xwPJU29/7MlFnQdeo4P5+4YRt0DoKE18dwAe+Wi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=GNbCf/o3; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=ByhPtz+6; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=xkCeOl6nj9IK5tQwcy8oiuh52jYXAnIOceDA8IVe+lQ=;
 b=GNbCf/o3kO4exRHdGWDWiY3J0McRGr0JhvLtWvKZSi4gvTxctTYvYJCMrZN8wnFMs8w+0oVAqH0YfOrErVm8FUZ4FSZsGrVKTDIVBPOdfSgpn4NTX27FeXDKHSEkiLKQepjv6ZSqjyq59K74d1ND3tDVtKrWisFydo2+PFMpu6qbDHeT+RJAsVewpWVvkqWVSVc1xDQQyP1qHuEaWgVS0nPr+9jYA25c/xslJQ8HB6X8r5B/DatCUNg9ySwXvC2XqnaQ7fvpjzHkPxo18tUi8w7HiV0mis8Z2FI3LndPM2NvyI8yRX673H01XrACrPX3xo4f55gZypUc6SkVtoXQqg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id CB548C000A4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:23:57 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c0a3568f4eso603741485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740507837; x=1741112637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xkCeOl6nj9IK5tQwcy8oiuh52jYXAnIOceDA8IVe+lQ=;
        b=ByhPtz+6sYVf8zlqsbegd7OBAPxJEaI+Sa4hVVjMqZWjlEPCOObPpn9Pa69c4bRcrO
         qnxHWgfM4/9grqrl94sWuniKGSW+hVUKxXGYJUdsDmJcte6tmDRepOUNTrNAnVODX9qL
         /hMioBcHCNQqSiLUKy1c4CUutUK3KpkhW4MvjaaWBss8mBXnpAKvbFMQa8dsPtgnEcPA
         qRFZzaLh3oWGpbVU5yDIqevqCIv4oEdse63nWnu2w0e5Pj0WAdUUMuD+xEwjE8NflsvP
         p4t1dKlREyexIyk3GJ8GA8/NpgM4n1pIjOvy5iVRgfOsNOP6ck/rCqHgKhfyiZHTR/bn
         FrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507837; x=1741112637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkCeOl6nj9IK5tQwcy8oiuh52jYXAnIOceDA8IVe+lQ=;
        b=TyVQMx3A698DFBmBVpEJpESyGHXxny1q1cqeRFz7dwHuw/YLBT3lKtQzIzq6PUbd1g
         bxvJb/Wwe9PhGh0jqUEhYCt/Sd6Ce5qEDkFX7SsrW/IfhqXtG9F+vHy932X33FQSG7ju
         qE947CaP2lSFZc+7AnH0E2T2XIEljLIy+c51/edohqpBny+qcPGY92/9uzLW4zd7Yy1h
         LWseuWtgKl9p1yJTMKwTGJsZsYNjoXxI+lapdAWuSmHQA6onFQRZGkCYbyuUxRA6qApD
         CWpWaB0H0KYHE7WD1aGzHYgh8B7eUbt2d4xDqg0twzQU0YncIiODsWLmSv/6+uU7Fm3q
         bQiA==
X-Forwarded-Encrypted: i=1; AJvYcCX53506oQGL4pozoTa3h/LySCGM5ejUEUqbuuDMBiDckjypztDtuawtbUpinw/JZGkhy0JRFSK8SmjjqKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRtmibmjyCP/T54bWKPW3lxa7kgLLhkAH34tvF9q7Efc/c8S7a
	whoOWdx9psRgDwbDJzjwwB4IVUgtoUmukqSzZEQzNdrPhjW13iHj0BHoJcw2SVLN7bD558ENSWa
	SDAsrh0Q+Voip86dDkZ8KV0tMM5RCRpHVYKmXWD9uxXbLFHMW7ZqeBxgf7cedIpPbSm5ZT9zYGc
	qXVVs+6QI=
X-Gm-Gg: ASbGnct9jyxlymMpGDTNLZVBgEAVyquIPZBV3/BPMW5JzAqmiu6a3/E8dLHD/3vhRgK
	u/ljokRisQHZUaqAvrF6hIp2EOZSS1uW5V9nAo00jIe2+YRuJenY14lspVjdfCsSsNmFWFXkA3C
	OPy50vLkGDsRM9BIvAhODZmR57pdA1zL1AhoiDHK+2n1D9GmBk2mWzBiRQW9x3k/nMUe8B5xgTF
	zyObOn3Xou3oxsk+V9IhyH0WjxVn/wHplKdtwEbDaBn2tcWrdVczicr5sjfyN9TXz4dKlXeyIvG
	4tmsvoAZWSYngjXnnl7ahYR4qykn/5F74btqS19iS75pyGoq7AJVsI7HPYjwJaFJa3PQFUQMuWo
	m8Dw1KaDWSCBDTV1WMjKTFLnPcN99iWzCobHU
X-Received: by 2002:a05:620a:294f:b0:7b6:d8da:9095 with SMTP id af79cd13be357-7c247f20022mr65059885a.13.1740507837368;
        Tue, 25 Feb 2025 10:23:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH55M+1Ifas+XqNzr8X3+KkOff8XpRApkTQhxLbzscTrrKWkaE4uVGMnrWH4qExo9dqce3f1g==
X-Received: by 2002:a05:620a:294f:b0:7b6:d8da:9095 with SMTP id af79cd13be357-7c247f20022mr65054885a.13.1740507837013;
        Tue, 25 Feb 2025 10:23:57 -0800 (PST)
Received: from ghostleviathan.computer.sladewatkins.net (syn-076-037-141-128.res.spectrum.com. [76.37.141.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b06dd6esm12101966d6.19.2025.02.25.10.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 10:23:56 -0800 (PST)
Message-ID: <09882df3-a186-404f-adce-cdde1a6e887a@sladewatkins.net>
Date: Tue, 25 Feb 2025 13:23:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/153] 6.12.17-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250225064751.133174920@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20250225064751.133174920@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1740507838-bH1dWjC0lI69
X-MDID-O:
 us5;at1;1740507838;bH1dWjC0lI69;<slade@sladewatkins.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-PPE-TRUSTED: V=1;DIR=OUT;


On 2/25/2025 1:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.17 release.
> There are 153 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Feb 2025 06:47:31 +0000.
> Anything received after that time might be too late.

Hey Greg,
No regressions or any sort of issues to speak of. Builds fine on my 
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
-slade


