Return-Path: <linux-kernel+bounces-418634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEC79D63A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15389B217F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C031DF73A;
	Fri, 22 Nov 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LIqHSlgV"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A6842056
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298562; cv=none; b=fBQe0sq4wxQ95Xsipq27KJjTFY4j4miKWwSI6zSGeqSdshLvnzcOEXii0Zr9G0JP+QLaPSwxgHGWoUUc5jxp88uA/Rn0a99m2WiTL308VMrTBqq7zuIMxRYf6R5QJqIYLHrolqbb6ht3ZgxQzBOMcjHPevmipfIK3Lq2kq34Z64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298562; c=relaxed/simple;
	bh=ekCCgGqoPHo4zcbNwXZU0Fyaydg0OUHdYZ+WKARSEKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppqAQWOJY8oGeLnC6YO7qMMaMvi1zy/gK1yyUz0GKmYHRZzmEoY3v4dmW5eQaDOxHFxLJCjiRrixuOZItTTGyePNbG0W2B8pvslo6eevSg7y+q9z/anT6ZfZ8ZJeatOvIHBgdFXp8PPSL/cO+3mYh/3N3WurIixD9oEaJ4vmH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LIqHSlgV; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-83eb38883b5so91687139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732298559; x=1732903359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1UKK6R6clrCso3TZBJx1KSDVNI3/xH6YnlT32kTkAIw=;
        b=LIqHSlgV3JQ6Jp0OOGhUFdVUouIi0PUXOSpNMNRj4iucPInGBwttzzKFlEnDQsTcyV
         FZ5BzCLvtt7Q6sdvDgzqh2Qh7+x434EBDh1UKTJQPcjDjA3uDRDqXRpBQ/adWiGibP7v
         VogoGAKFYrF2Dh0O34BBhhpyUxHIytdN6Idz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732298559; x=1732903359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UKK6R6clrCso3TZBJx1KSDVNI3/xH6YnlT32kTkAIw=;
        b=CFsS86SU1PL7lih4qWeIp0AgaxNA0oTgWvoBK62sLNmga9pr0Jlh8I9Vz2JtLX5qeV
         veVFGy1EX32yDBwP1uCCmneevMi4rhX/O1MUI0h249rpdEOqicEf77hx/G3aZ0iyOzJO
         xfyFvmNQEjd6bXSCZoWQYy+TA2qwb1OhFES/gIA4Q8vC9N16/Kg976iIi/XQJN1TLwVZ
         oym7tf7CLVvudlaaeJj3J/WCY8eE5wgwRO8Cg/FAlPiYMrurov75uf8HPzM4S2+nFtqG
         ZkLo7zGwxMwN0kkhntoxphAT/qPz6R3mfMJKZN/ksLoo1oC5hNbMfIO0OBajGYA3f2R7
         FGYg==
X-Forwarded-Encrypted: i=1; AJvYcCVQWan3CrBDFezh4kuzAd9ukcPcbPnqOTOQKjO/tMJk5zkExD2TiVG191wHYK9pjUa7muvBGHF9sLpF/L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQjd0D2IITNM2gegbq3K84XZck7IcCNs5+yPnUel3fUycuyQlW
	rUeUR8a3TZLtTw+gUQPyHkOYXQgQKdS890wOnVZMHRTBLbsKt1gshxyyFxE6p9s=
X-Gm-Gg: ASbGncvRoUHktIgx7ncUXZ0ZXIC127H/2278dmt4KfBL7zydwOLhVhi8jfCWwN4Ck3p
	lPDNqo2NbVYKPZwdobJKWkM5vFfGPPjHHAfQXbza8dBenwKYkMdXcoSbc/9Y5GhVvit1Ei5SsHb
	YVDEphbQv7LVZVzj0ZRz/hD2X9NJDjYxjDeAtqx82rM+F8V+G1fzE8P4qP6f7ErJCqVOeBePmbA
	0vzTFiVR5XYQeUpRCTCRpPgOOA+AsW26D5ICzHkO8Pz3W5gqKToq5NCLTUUjQ==
X-Google-Smtp-Source: AGHT+IFWzkCdRFFv1WAJ4OhtVkdsgjqMg1uTPe5WFau1RnEd7XbEpWY5vU7jhdifNFmZIwph0mKcAA==
X-Received: by 2002:a05:6602:164c:b0:83a:a9cc:69ff with SMTP id ca18e2360f4ac-83ecdd2ff2cmr388799539f.13.1732298559336;
        Fri, 22 Nov 2024 10:02:39 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ecd3ea05dsm55605439f.37.2024.11.22.10.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 10:02:38 -0800 (PST)
Message-ID: <6546a78d-9989-417f-925c-c6422c28f2f2@linuxfoundation.org>
Date: Fri, 22 Nov 2024 11:02:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Fixing memory leaks
To: liujing <liujing@cmss.chinamobile.com>, trenn@suse.com, shuah@kernel.org,
 jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241121133212.6809-1-liujing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241121133212.6809-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/24 06:32, liujing wrote:
> If execlp fails, page memory is not freed, so fix it.

How did you find the problem?

> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
> index 9ec973165af1..36d486199630 100644
> --- a/tools/power/cpupower/utils/cpupower.c
> +++ b/tools/power/cpupower/utils/cpupower.c
> @@ -98,7 +98,7 @@ static int print_man_page(const char *subpage)
>   	}
>   
>   	execlp("man", "man", page, NULL);
> -
> +	free(page);

The memory gets free'ed when process exits. Why do you need this?
  
  
>   	/* should not be reached */
>   	return -EINVAL;
>   }

thanks,
-- Shuah

