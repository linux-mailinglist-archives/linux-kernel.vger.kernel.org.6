Return-Path: <linux-kernel+bounces-425125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B999DBDAC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7511658DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09D91C68B2;
	Thu, 28 Nov 2024 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="WBw7x/8M"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ED11C57B1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732833114; cv=none; b=l4xjBbm9p9dG6TxHiBL0NW5n2bda8XgSlF0XWK+7hxMrKCRWFLC8YrWHb3GrlwKq8j5IndpJvU9Cpp0DTQ9uvcmdte7S1UsD66tdRK8Zb75WMfc2qRUt9gW6q2/Tah3lQUKiE4+BVA3kDWahePsuuXrEzKG3bWmOQC02jqkmTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732833114; c=relaxed/simple;
	bh=vSBgqREdabS/n09oBGSsyVKJgzrWW8gMM+XuvFh8jGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqTfqh62x7grmVrLFNEynL026ZDxi68BG4WmHmU1sQkfU2nwn39hPb4mVZafgo5eNAI5zJtEIWBAZzNSi5kxoaku6q7EdDjm4DtZ8hf+y1deg7dcs8mnKsxE2wJuoHGLbfaqBw0vZW9UyOU11MXPYX+D/3psqmAnC04RmfJG3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=WBw7x/8M; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cfcf4df87aso1433084a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1732833109; x=1733437909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhEu1O8tP+5SOvMxJ5NzUYLjAfFINMkgnefleOw9LAo=;
        b=WBw7x/8MyxeOYA35C1drkYvwbmGeO4FR5l2nNU6fJHvRM1qoyCHGsAv+XHBcX7CSgS
         kZzVQ4seYlS/9DDpIZfWfLa1hPRbBWoxFL69gT7gxVvc7OdVA5Nb2/SAVdTYk/+tt1JY
         fKHnC1WJsTNWaddqounV/z7vb1KtRS94MGLv+CzVZp/9SZzPqfb+k3tZOw56C6jV5lwD
         p9ZZEy41vl386is+dJELTtcCJTV5jtvrV+0X1be2iJ0HdLMKgnkavT8cQ8wJw70lU4R2
         ZR0r+wQ0AzQ9HMKOG+3k5KfalhYadA6xN+RMlK6fpiWH54YC40aXrohS6YbbGs3OKEbX
         7XFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732833109; x=1733437909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhEu1O8tP+5SOvMxJ5NzUYLjAfFINMkgnefleOw9LAo=;
        b=o5fT/WVTLLVa4GgInGWwM8uuSYoHYIiD9RDk9bNLf0HcOf2RLFLO6szciDuH1dS904
         H4DNDZanf1Ux6OBgc1tnzsO8LRTKck9WMo8a2lTQWCJnfnvi//Y28gsQBrD+GIeFmq+u
         uZ/C16uhTItJLeUq23ME6c1A7a9v9JjNCV5cNTYbNFzmUZ5phnF9sneyTHye+DDxh+x/
         yXrimoBb6nj2zu3bKN4WhESgffdnh1mxmhihZVMoRX3+AoVsbdY8dIWxShyxwSlyMVS0
         Wq9tCjlAIh8cG5rH3RPcAQfkRoCtJPem0pyyLQQ7IBgbypjCQG+tDzTEMg/iqpYfZnBc
         Ttuw==
X-Forwarded-Encrypted: i=1; AJvYcCUt5ntA+24P9T6QEncktOrff5e2bRxr/cpeKz+yTL7b35+/KmFLmg+TcT/qso0enBPUp4F8EPIIw/w+Qr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWDDg3iaDAJ0uZ3r3KFotK9sn+gFVPAbvyFxlJO7yvoYp/+Dh
	qevh/1ht+T/JufHkVdzIhuFJloSkdW3apYG2RIZgx419zAfguguujimtxStt544=
X-Gm-Gg: ASbGncud8gt7OgTe2mlztOrfZnt+iiEQu8NxGBQr8RdDVQphBnNwnwa7PB+Kp+pnppD
	A+sBOhjEkkP2WH0VVujdQmFLRTTN4MJ/vXCXHQKA81ym6i+/Ku6aIxiA7P59zEfUdfUQ3i/v08Y
	u+/x5Frgy1jDa3svg7WTLGcgWukq8sPQpP/ZKVbRdUXEQYIA0D8CDUWGUCclJg7YbM0gz3p2lMJ
	GhQx/88RlogSVv/6SbuLI05scATnHLXjJtISu+RaPeyLDdXE/L6CrpIP2dODbX3JQ==
X-Google-Smtp-Source: AGHT+IF9dnpn+7M0c6EI2JeDjVFOmRxhuBpL/4iDLEvFEuP8URE+Rh0/zEacF8TcZBK3JG2szgyFfw==
X-Received: by 2002:a05:6402:3546:b0:5cf:de89:9364 with SMTP id 4fb4d7f45d1cf-5d080bb2f99mr8554599a12.10.1732833109274;
        Thu, 28 Nov 2024 14:31:49 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097e8db19sm1133180a12.61.2024.11.28.14.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 14:31:48 -0800 (PST)
Message-ID: <73fffc4f-f8a8-4011-8d69-cab4c29223c3@nexus-software.ie>
Date: Thu, 28 Nov 2024 22:31:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: document csiphy_lanes_cfg structure
To: David Heidelberg <david@ixit.cz>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128200142.602264-1-david@ixit.cz>
Content-Language: en-US
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20241128200142.602264-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/11/2024 20:01, David Heidelberg wrote:
> From: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/media/platform/qcom/camss/camss-csiphy.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git ./drivers/media/platform/qcom/camss/camss-csiphy.h ./drivers/media/platform/qcom/camss/camss-csiphy.h
> index eebc1ff1cfab..e3b9e8f12806 100644
> --- ./drivers/media/platform/qcom/camss/camss-csiphy.h
> +++ ./drivers/media/platform/qcom/camss/camss-csiphy.h
> @@ -26,6 +26,12 @@ struct csiphy_lane {
>   	u8 pol;
>   };
>   
> +/**
> + * struct csiphy_lanes_cfg - CSIPHY lanes configuration
> + * @num_data: number of data lanes
> + * @data:     data lanes configuration
> + * @clk:      clock lane configuration (only for D-PHY)
> + */
>   struct csiphy_lanes_cfg {
>   	int num_data;
>   	struct csiphy_lane *data;

Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

