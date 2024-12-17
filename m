Return-Path: <linux-kernel+bounces-449582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 348689F5108
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6911645BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593931F7558;
	Tue, 17 Dec 2024 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GDQ9rIaV"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991DA211C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453040; cv=none; b=PDnuEgYJEvDVFJRVRBeokEqHVxEGO+Cxy0WmTGo5tC2R9G9FttOGVf5gVO9Zqs1nHr7aFBck8rWBtWUWONFRSC4qVqw5eHGH3K3k/xcmF5IA3sxXefUNzn9INPJljGHF3nOaneVuaLWHJkUMgddHdfUlbO10vfUZgrMklF3lnrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453040; c=relaxed/simple;
	bh=MkPlOU9Np8qUPmVxBacmMIMYl2oSkgbeO8c3DYO4490=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXwgDKgtp7aoDyQDlSHY/8q8NUtF8WpDen9sC48TYuwXQaGOb/bSiDk0iQ/N1W/q7ZpIPGgkEN9yNj7AdJy78tpVx1YiM6ejjkZ/zX+bQBQ2RHp2vIO3TnmIOu1eLaRyYSbGL/tJG/8L12FcPoB55CcS7KhAoW5hhQ+Pc04Vp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GDQ9rIaV; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a7dd54af4bso19496625ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734453038; x=1735057838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEDKHfNxLLhMxMAjmKBgYR4NMvDMw6yuLjE3m7stOZQ=;
        b=GDQ9rIaV+h0C0wDMU/feUdX6+6Ihs2QutSHkRav8v44pefXwjPuG0VkDE7g5rgE5kj
         7ux8ZQv+Qxu1zFlt3dtjRUbUPpC75OIy48ua9w9JNBS14pna9jW3u1dK4RAw/Do97wb2
         f7wIS68y0Kj0oYc9c0boyKIU2pdsV3Jtwa8Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734453038; x=1735057838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEDKHfNxLLhMxMAjmKBgYR4NMvDMw6yuLjE3m7stOZQ=;
        b=gO3sHUCUpvD3rNVWfyX3LOadl5ox//+l9VWUYkKLkIk+iGc0vpTqWfnVo6dvialLiN
         W4nHz1yX2Pr2Pl68S3UTtFfRCxW0bZiHdsnBLFJ48KJ2SG29eNnIsJZziZPTTY/K5wNQ
         OLQ6zVP1oUfC62WrVBPcXLVIJtXDiLatbYT/FG9pd2foKHrDZFmyARnPhf6pmymun2Gz
         arABJGRT+4HfP7dcXBkOVeXlpRkzFhohrRIvRSKfOMgCEkGE9sx/4jy7+Jr8Ke5pTPn2
         Lk0z3CiiTOt/WtfaME6g2czM5JlEraNN2/r08547u+E9yhFmP9SuaZoUrBI6w/G3YBDH
         g9lg==
X-Forwarded-Encrypted: i=1; AJvYcCUiDv1Mf8kMGsCUTaE3WZEEIfSiX+KVVuxSS+5BO7mV/yURQqo03PZKWOWtWVMywA5wZX9VXQCYa8ucoAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwS2k5aFw4npoRuG7unKEkXpxQrwVP8A/hxmAegpng4pTwi1uF
	6Cg0NE33Z3wOCoDW0/2VU0fduUZYergQACkacprnZPdqEA84aq03oSxPyyarGcY=
X-Gm-Gg: ASbGncs7fT2MqwggjnmYmpEFwZSq9RLI1vzj9cK65Uadme7/OGO68hv+josu6dExWfG
	6Bu+w0RTR9LsGcNEpxOcjQCsS+Yq8qnCqxMql5dCj0YVn2h4ohSyqYpPAkqvJxWrlnleFzvLHqj
	kuk4w5AiNUNr1cg7m8wUrqA06eSY4sufRrWbOyNKoeEnnwdJOmpueYZt2hvldvqichw7geIvbjh
	cpBnKS8NsCeeLDpXgltzGjz+Iu5IXHyrKPa5dXfBYfOsJjw0paViAYqPGuapMAOFspx
X-Google-Smtp-Source: AGHT+IGg7Gi7gWhTEi4s+1hPh2zcRL+Pf3/Q2M6W75aJGIBtWKQW9xL7s088BBP+ftbhmeE7QbFuhw==
X-Received: by 2002:a05:6e02:12c5:b0:3ab:8db6:12ac with SMTP id e9e14a558f8ab-3aff4616e30mr145746905ab.4.1734453037526;
        Tue, 17 Dec 2024 08:30:37 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2475afae7sm21853645ab.13.2024.12.17.08.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 08:30:36 -0800 (PST)
Message-ID: <41a2e17e-0aaa-4dca-a28d-313a270d2016@linuxfoundation.org>
Date: Tue, 17 Dec 2024 09:30:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: kselftest: Fix the wrong format specifier
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241202043111.3888-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241202043111.3888-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/24 21:31, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The format specifier of "unsigned int" in printf()
> should be "%u", not "%d".
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/kselftest.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index 29fedf609611..062c02a7be2d 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -403,7 +403,7 @@ static inline __noreturn __printf(1, 2) void ksft_exit_skip(const char *msg, ...
>   	 */
>   	if (ksft_plan || ksft_test_num()) {
>   		ksft_cnt.ksft_xskip++;
> -		printf("ok %d # SKIP ", 1 + ksft_test_num());
> +		printf("ok %u # SKIP ", 1 + ksft_test_num());
>   	} else {
>   		printf("1..0 # SKIP ");
>   	}

Applied to linux-kselftest next for Linux 6.14-rc1

thanks,
-- Shuah

