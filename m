Return-Path: <linux-kernel+bounces-207749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EFB901B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9688F1C214A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217141BF2A;
	Mon, 10 Jun 2024 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C9IWgKrI"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214E21364
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718002768; cv=none; b=OmEuJ48VMJzH2JNrF2E0VMTDWRNI6hjw/fFkTtczvyDmNFIm9SPyaCPm+HaGqZAecIQJfuls8v17bgeTPrPvxGpwprb4ICICvoVJiWkQkLWxu1ncvQunx6ydlmwgURaTxAEJGTh+2rjJHpWooC+5xpVlVw/yHnV9aSmaNoGh/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718002768; c=relaxed/simple;
	bh=fpqc3BGiClB/F6MGjNoNK1oIPopFNiKyI7v9DsVa320=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPr7VlTEupAxZwLnHSJdEPdG6+nTQmIO2f7qMRQnB1cUgjjoBElK9/xUUeA5cGE8EPFtu6d4YA5hELyYS5mDQSwSAdds6QdZIJMWBLj4JxCPcwUTbUmD84PsSgtPnRwWyZUhM5FjkEK9edFdTrVUxiqJmMQU/QxkNLDj70oeots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C9IWgKrI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b7ffd9f6eso4531798e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 23:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718002764; x=1718607564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94hswRoG4QejpgWk52uXPLn3esD4s603onPMyFxGKdw=;
        b=C9IWgKrIY5KC5LK+AbYHhNR2Bw4mIllkbsTvNHpZiFdSQMm67nWyBV9CzrpI//qM3m
         iXy63QDbDspqK7wdQN1RPVewZP+/813YMTvaxvsuN2Qea2SN7HGB7rfMU+z3HFJiweZ9
         3/T63iqV6N3EXHkrtYgszCR3M18HYyFCaXcc839FFrC/ij8W1MS3sexd143auxO79tWA
         0xr+MMYAZBPPPO82ccxRfowdJi9MO2mOBRmvY6WXC3VuFL31kma0TJiCelD9ZiJLtewl
         W1suoHYKqk82Yi7Ir0dxPSMwjsAqUu0fAtejPKc/3uWI2lbq7Ann6Kqghy+7yVRfiE8G
         B4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718002764; x=1718607564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94hswRoG4QejpgWk52uXPLn3esD4s603onPMyFxGKdw=;
        b=cY8ItJG5m/S5GRMc2D923P88RUWjnRiAQOUN7qGGVEgbhiJ7//tIuLfNacx8yCIWlA
         MQ1+6UZoDtoM63oq7B3QJaXfqvD8hXt3MeYnzhtQ+sU3OdlzE+i8xdFFMhbsQ7HKrIS2
         6gWSkvCZHGMyqGH2Ld0BMYNX578gNNUPpmKjRiW7uv6hDCTrZDLa3fKvqWyJZYKmk7ZK
         buN0g958DnVadxndzwrPuzZVaf5Jiv52ULkWmSTHQ3RUl+pUiQS8s7iX0QSrnNekUI+v
         GUjkhZD/5si2x4l5ScnhacaZvCFHfoMpJ1RgRnaI/8ghqUQNO0SMcVbi1qCT7BiMFL2Q
         ePYw==
X-Gm-Message-State: AOJu0YwUCtiLWeTbP6hjbz0EGn/oSMSCmuefw0l7FsTChPkEPvGUrWPE
	+18Infn0W+1Ll6Iyv0pvX9Gzks8+8+yew1Do+3kHyq59HgWAgeG3Odc6dxPwtaztfTCasoY2Js2
	Z
X-Google-Smtp-Source: AGHT+IGV/p9GDC5Sd0Kltr9kbdtzm76qQuGxgsNUUNRg21SrgvTvv7W65we9g7WsAzFWS7C0LaFlOQ==
X-Received: by 2002:a05:6512:1108:b0:52c:81fc:eba2 with SMTP id 2adb3069b0e04-52c81fcecbemr3607177e87.44.1718002764128;
        Sun, 09 Jun 2024 23:59:24 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:f459:e30d:c5ec:5a8e? ([2a10:bac0:b000:7579:f459:e30d:c5ec:5a8e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f26857582sm949974f8f.77.2024.06.09.23.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 23:59:23 -0700 (PDT)
Message-ID: <3c0235d7-219f-4a3e-bb58-eb662f61f570@suse.com>
Date: Mon, 10 Jun 2024 09:59:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu: Consolidate identical branches
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240521124832.486390-1-nik.borisov@suse.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240521124832.486390-1-nik.borisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21.05.24 г. 15:48 ч., Nikolay Borisov wrote:
> It's pointless to have 2 identical branches one after the other, simply
> collapse them in a single branch. No functional changes.
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>

Ping

> ---
>   arch/x86/kernel/cpu/common.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 69265c0acaea..369037a166fd 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1732,12 +1732,11 @@ static void generic_identify(struct cpuinfo_x86 *c)
>   {
>   	c->extended_cpuid_level = 0;
>   
> -	if (!have_cpuid_p())
> +	if (!have_cpuid_p()) {
>   		identify_cpu_without_cpuid(c);
> -
> -	/* cyrix could have cpuid enabled via c_identify()*/
> -	if (!have_cpuid_p())
> +		/* cyrix could have cpuid enabled via c_identify()*/
>   		return;
> +	}
>   
>   	cpu_detect(c);
>   

