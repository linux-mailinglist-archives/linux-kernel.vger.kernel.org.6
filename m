Return-Path: <linux-kernel+bounces-357486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5C99971C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B567280A81
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE62C1E3DF5;
	Wed,  9 Oct 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcHjRUbR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F63149E00
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491563; cv=none; b=Rd5E1h2NXMnjWR3TkD00SBORrI9BRxRKAA4Mxyk6455rLSbAe4Jq2gvYavJM8lPhTt5aPzgaH0YaZvEXNzucQRKy1GGWwF+QR4Mgdy+lVsH026LAuGF4MCxMhn3RHYaHA4vSf1V2UmzmhYyeZAY4Uis3R7pZ/rUpFCtxOJfOsEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491563; c=relaxed/simple;
	bh=qaQixhuwLIikdSFP8Lc/q7fT/ooLAsq7WT3k3IkixUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OD7dK3+3LfwzhWdD8OTUsLHiTZTnC5Vmdyn3ID3XYa/u02m9swHX4ZZhMXjzalq6Au/x9smxrTJxnZENG76u/5MLMu1wuCK3oTBLzK4yoXsZWR0tMPqyanoxkpY2TZZVvPOqX4f7opHP2z7VS+7rVoKVq9I6HrqAsSZv1CL03yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcHjRUbR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728491560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsmJarmkb+eUvOZfdr4ZWVZI9jzrARuYBuLJ/6l/+6Q=;
	b=JcHjRUbRvDZVRhMxjdqOdk+4M7dlm8n6cBtk9ueBTw5bzQVSCqhoY6HyVFN3r3qE8ouXkA
	/o7Pr908uGeEUADyCCuiQnGx/Lw02GIs4OMnwYYLED+hQppdezWmU8mslGYQ9HnR/fBjYt
	afWdYFcwATlJ9yqGjA8Bp5fOxUXXyMA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-kA715NYrP-GZ3u02Anqdsg-1; Wed, 09 Oct 2024 12:32:38 -0400
X-MC-Unique: kA715NYrP-GZ3u02Anqdsg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43058dce286so7519645e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728491557; x=1729096357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsmJarmkb+eUvOZfdr4ZWVZI9jzrARuYBuLJ/6l/+6Q=;
        b=xET9iu8VpiKMf1NPHzq7elfrFcR8+DlQrBIne6Jtq0o7QWVzkhtXDAukM3MLbQsUSx
         JEUIo8+A6u1YtYQLwPw2I8QIQT1or8WCXdrZ3lJx/z7LXvehGIbZ859BOtKs0hRt08rl
         zMXQ9jNeSd6LFSkEqJV/JP2JsBXVTrulASzvkbDafTU0jaORAi/1tWmceIN6SWog/3cO
         RpW7zt5b2QYiRjmVa9TvZkEsa6XycH9IGF2gC9NMlc1nUWn6AlnKojO9c+yT/TQ2TB9+
         Fug8dNboknkH/B1/ZKO6ZqWuygESJ/kOjbpYOCxX3oYB9b/M82IP56G37m54RRZSKc+k
         1oEA==
X-Forwarded-Encrypted: i=1; AJvYcCVGDvYiz1yRJt03Aj3QBOS4pJMdCjO5jufUUZP5CkoTmJN9nhtdnpol3l56GiZbgqHjfUpXBN2KUAFsvO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKyQq0pC9oeIqCekloXdenNcKiS37/+tpGSlO9wO75b1+5csi5
	ZLlN5Q0JaUfvJwdfpnyncqbvHyLHLzq4Q6LxCJm09YAnCPBJkVsVYqAfhhsR3nq2AoZTJ4APCFk
	h+4Wsxjtx0ovN9NFwKd52G0hV70J2q6uICSCHqV6zHpKqC5m6mQ6/zGICwRF5EQ==
X-Received: by 2002:a05:600c:3543:b0:430:5819:7585 with SMTP id 5b1f17b1804b1-430ccf50fc6mr20583125e9.18.1728491557494;
        Wed, 09 Oct 2024 09:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgAtVz7a0GcP4x49OMbkuuqnX4Wns7sjAolEw0Y21+aNP2bd+EmH8lJYgCuWlis1C2+PUPjA==
X-Received: by 2002:a05:600c:3543:b0:430:5819:7585 with SMTP id 5b1f17b1804b1-430ccf50fc6mr20582965e9.18.1728491557040;
        Wed, 09 Oct 2024 09:32:37 -0700 (PDT)
Received: from [192.168.88.248] (146-241-42-55.dyn.eolo.it. [146.241.42.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d7487c4csm24983965e9.32.2024.10.09.09.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 09:32:36 -0700 (PDT)
Message-ID: <be4be68a-caff-4657-9a49-67b3eaefe478@redhat.com>
Date: Wed, 9 Oct 2024 18:32:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 14/14] mm: page_frag: add an entry in
 MAINTAINERS for page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
 <20241008112049.2279307-15-linyunsheng@huawei.com>
 <20241008174350.7b0d3184@kernel.org>
 <a3f94649-9880-4dc0-a8ab-d43fab7c9350@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a3f94649-9880-4dc0-a8ab-d43fab7c9350@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/9/24 06:01, Yunsheng Lin wrote:
> On 2024/10/9 8:43, Jakub Kicinski wrote:
>> On Tue, 8 Oct 2024 19:20:48 +0800 Yunsheng Lin wrote:
>>> +M:	Yunsheng Lin <linyunsheng@huawei.com>
>>
>> The bar for maintaining core code is very high, if you'd
>> like to be a maintainer please start small.
> 
> I did start small with the page_pool case, as mentioned in
> [1] of a similar comment, and the page_frag is a small
> subsystem/library as mentioned in commit log.
> 
> I think I still might need a second opinion here.
> 
> 1. https://lore.kernel.org/linux-kernel/dea82ac3-65fc-c941-685f-9d4655aa4a52@huawei.com/

Please note that the 'small' part here does not refer strictly to code 
size. Any core networking code has the bar significantly higher than 
i.e. NIC drivers - even if the latter could count order of magnitude 
more LoC.
AFAICS there is an unwritten convention that people are called to 
maintain core code, as opposed to people appointing themself to maintain 
driver code.

Cheers,

Paolo


