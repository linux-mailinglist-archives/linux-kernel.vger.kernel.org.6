Return-Path: <linux-kernel+bounces-558086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B66C9A5E172
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC343BC5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EB11BCA07;
	Wed, 12 Mar 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HZe/Rgjw"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D71C84A0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795646; cv=none; b=oJZW0d0/nSLR6/61rgAuwtZo4ttl1PV/LggXk4S8oeGxJgRnAgqzQFtwUEL6H3eQ6u20P8ql2DLEJz9co5aqSm6jYXNwAwoZB53ZhjOXEJ+MklnIcB2QGZqbaQN/JMusq2gcLGebWO3HOG2pHW5N4J77R3B/c//7FoQfaxLXuy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795646; c=relaxed/simple;
	bh=+DPcVpt5jm09eAi/Y9n5785dJsafsofbqA8F/h57dus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLOjnBCekJBEQanluFiD1CmlHaG1DfcLuXVnrNu8EJ9kv8uuDFAQHMLj6ZG0stCT965XtJfTsko9FxY4pdAoiE6CIyhQlTmIKwMv/GgOFqrmj0GeN0Qyw2IeH44dQQ4vNAn4jbwFLeEQfsxaEPvlOs//62oywesXDe1BROo/QRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HZe/Rgjw; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso139239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741795643; x=1742400443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExMoY/YUEJ2sXZfuXzKCTdc9+tog41q5+FPX04PqUyM=;
        b=HZe/RgjwWI1hEqmeTUpZ7rLgRzKZbdsCLSjpiIZwywmwJMJ7rpKITg+E+bNy2VmPA3
         IXP66hluxKFO1nUuFB97+n015rW282h0l3WS6oSFD4BCQGeDnXInZkpeJJGAJx5xKHo1
         wylHfhTaRJRSVDoQX0JR0cIYXPLxmrcGiXnxPtenFa7zE4adRUaOKenn9Q6mwk2/sjpe
         ObaEDKowiY/sh2AF5g5FVxhgZZ76mQY6Xfa/1zeE1UrBHyU0gz2AWaUwnb1xhI3RbcAb
         BMkdAkiZzlHY3FyxqDwxgT5FQHU9ZZBWxOb/LHgS5vNpc7nEVtO8uWyp+B5c4UTP/PUY
         BAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741795643; x=1742400443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExMoY/YUEJ2sXZfuXzKCTdc9+tog41q5+FPX04PqUyM=;
        b=eK8mdzH4HT9YbLrxTFTGMUIeDoqqBNPnRcdKu8kghFgwjwFSbAqjzja6EyB3h6XHca
         IhoNeC4cUxJp/7biqB4k64tRkyJsD+f2amMl0keVP1xPnfD9bUrSPVYkdSlPb2cIMm7o
         zXtkAzb5IRsPZu7EpVsGWuweEb70XeJGjwvNu05x17kMyjUcjsLk5CM+GFiAwdSN84fM
         0svjw8c2mDYsugSIHv5krh9E7NlDg8T80jCKK7UhEzA1Sx6Cj6BxlN941RtZAf19Uij7
         K6XKuSp5HLbGGkjiUIAW760rgDh8L8JuIovpYI66m5YyLGxP5/920MDkaSVJu9aLn4Es
         NgTw==
X-Forwarded-Encrypted: i=1; AJvYcCXpU3foqVzpE3t04DfLJ/zF6KFeZo71rxF5KNUX2Frr4/M7c2d18UplGTG8qBEP3/+hgfpreIg052w3av8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZ4NZAwUtsCBQBgBeB1bflMPfzxOIpKRWENWm03Uq5cNatBpU
	E/pFBRZxQzXzv1sAqDOnaQI7wG0qiiXFuu61RtSXn2EYq5LjZahE84lRPWNg/pw=
X-Gm-Gg: ASbGnctiL4ZTRCcUi3xpqjpfy8GpyBvYuZEqHZBfLPbP97O3Y7Enmyej9pNm/P9BaBF
	SyPpMb9agihg7TwMkq9DU16D5h4ZmQNbPOSSRHFPPvBEbolYnOh1zh4BIHgrxYMVDUF8PlYbtuC
	o06ZWDCYfsISBWROpv5mV2KJbpEIa97/h5FQhsTw+5AS7QjtXhPZRwr1KW2x6ADi3o2oRAPRQy8
	GHd4DvcHUgnNdb1aGDzz4yfREWkjYEhUEimgK+H8e3HIDU4DjOarfgO/Pl4W6YVxggwLMnFCPKP
	ar3OF6O3iRk9XLFSeEykY2d73V3IGYn52ieHsEbe
X-Google-Smtp-Source: AGHT+IElo/nFdPS6E/5N5+GL1pAZfk0yR7kOrU1+gao2muzmo9g0AwgP1v3zMHzkrcml22cA5yeNRw==
X-Received: by 2002:a05:6602:398f:b0:85c:5521:cbfe with SMTP id ca18e2360f4ac-85d8e2233c5mr1023090939f.8.1741795642951;
        Wed, 12 Mar 2025 09:07:22 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85b119a823asm284201939f.14.2025.03.12.09.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:07:22 -0700 (PDT)
Message-ID: <6115bfac-658c-4e8c-859f-d4a1a5820dae@kernel.dk>
Date: Wed, 12 Mar 2025 10:07:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: dodge an atomic in putname if ref == 1
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
 viro@zeniv.linux.org.uk
Cc: jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 audit@vger.kernel.org
References: <20250311181804.1165758-1-mjguzik@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250311181804.1165758-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 12:18 PM, Mateusz Guzik wrote:
> diff --git a/fs/namei.c b/fs/namei.c
> index 06765d320e7e..add90981cfcd 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -275,14 +275,19 @@ EXPORT_SYMBOL(getname_kernel);
>  
>  void putname(struct filename *name)
>  {
> +	int refcnt;
> +
>  	if (IS_ERR_OR_NULL(name))
>  		return;
>  
> -	if (WARN_ON_ONCE(!atomic_read(&name->refcnt)))
> -		return;
> +	refcnt = atomic_read(&name->refcnt);
> +	if (refcnt != 1) {
> +		if (WARN_ON_ONCE(!refcnt))
> +			return;
>  
> -	if (!atomic_dec_and_test(&name->refcnt))
> -		return;
> +		if (!atomic_dec_and_test(&name->refcnt))
> +			return;
> +	}

Looks good to me, I use this trick with bitops too all the time, to
avoid a RMW when possible.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

