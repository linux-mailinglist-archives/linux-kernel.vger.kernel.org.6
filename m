Return-Path: <linux-kernel+bounces-577578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1CCA71F13
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5305D3AF9A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6264253349;
	Wed, 26 Mar 2025 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKk2diat"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371C253B6A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017060; cv=none; b=ivwoic09fvOZhhL113RjEIxbagb7upPYI+3vJv/39xbe940PTCBAGoAzH9jtm7ipB3XHkr5mOIhC55CZ7XUV3xBLaN4G72HFuoCL2017hNKIZyEQqJqNfbCWesaP9bW4BA1y+rVxZltBNLuTcKrdNQsgyku3W6nIZVb9rQ+/a1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017060; c=relaxed/simple;
	bh=v/8sO9aY6Fj8YF2TcOYwjtbMV3BfK54upsEGdZxeTU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jL06KZkcdgQx03wbCzIKhegMYp14vetjmtq6snzHdduNUNk00VZDCAz+n0gugUy1lW10gMtaQqUoqLJj02NJK1QdeyWu2XM/qkgsEUR+otnxVO/Tg/p/vFkuMSd9KW+5imKz2PzWSweTs91ANztX6erCF3CEaLyn3vkSOFLqR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKk2diat; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743017057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WR4q0K9RINwOvLs9yveVcMM+axrOT2+6rY2lFiOG9pU=;
	b=jKk2diatSvNHy7Ea9HHapGK51/jjx56C6SK11E6te/UpFqRWJHQyHqZYzI0fZlYKQaCk+M
	Jz9i6x2Jq54xp4ziEx+lO8jqdnU+LrgCyygRtq0htxCz1BYtlVa/WyEASXQ5PkVqfzNZlX
	xkRYH9uL8BXLVNPXGsd58+GvUt6vWCM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-Kr-GH2KgMK2y5QTeTBEOnw-1; Wed, 26 Mar 2025 15:24:14 -0400
X-MC-Unique: Kr-GH2KgMK2y5QTeTBEOnw-1
X-Mimecast-MFC-AGG-ID: Kr-GH2KgMK2y5QTeTBEOnw_1743017054
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3c03b6990so31792685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743017054; x=1743621854;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WR4q0K9RINwOvLs9yveVcMM+axrOT2+6rY2lFiOG9pU=;
        b=uwtikzB7K87uG8WLP2btrOD6Rjvys3Ytje9xUgaza+hKZdCZogm8kO0ffwT7UyC/Jv
         lbwuoJyFZT9CQQCxuILHtY7jHSkECDfSWo6PNFY+lOmxcDHupdgg04L1NbEuw0ycR1Mk
         zHwW7t6pxaNsgjozOMXsnR6b5IhySKZUQ/b0a9MqKfV27fXr2sPQG5SHzJ/udNHgk1d9
         p8NiFhhWw6VYhYLUzwTc/iCsuCkeM6QWRSXrkQlSRPNqyyENMZo34nDIKQvxUmbcXtx+
         HDzya4oeb8gHOWxkqlyWY43x+0RwpCMSGOZb+PtE3gwjCQQHo6cbvD5UsCQDmkDXd863
         R9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg+jG0vN0oFJ21hxx2A+FkxNJoCgGHfa65wKTn0qHjfHFDwEjawlTBRY8wuTjp+G/ju4L/EIVJyn7tPBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUMEImQPKoA5guwmulJkQlSVI/BC4lBXBEBNuZH7jkYYiLZiAI
	a7sF5W6XECrYT5pCzQWBEb+Wbhs5DQfY3Jl6gAcQEfk2Ahq9yPl+c8lo1I3l54VyAdEQyi6um86
	1bDcR8f6smG8EfPwW+dOu3RhDptIVxzQ4vczIuWmBCnwxAKgmv8x4TpSgD4yN3A==
X-Gm-Gg: ASbGncuf59W6G+oaEJXEt3xpAEVX6pTy8iKCpIQdtI+ZZKEilYf/Aiq4zdRmTVLma/3
	KaXAxGkoF+HNJpqgSEm5HFeBF603uqzMTMGPVKQFDn775Qb/xtFIBu/QqYXszBrPLQzaVTMQlHR
	MeEZuXc+tOgN3W6LP4iPzfb8/Aauzs0H1fcxuptitK0Vem0bOh9CVQwpsCxD/ZqYs+Iar32duWU
	nwnrlvNXJ5vPd5NznJzTnB5CochtW9hnRqrT6/i2lxs++MpMGd/wIPsUlT4zIIigWenV9Ae3AVa
	+dgosRZNPzpQ
X-Received: by 2002:a05:620a:2403:b0:7c5:49e3:333f with SMTP id af79cd13be357-7c5eda7c9a6mr155660285a.36.1743017053818;
        Wed, 26 Mar 2025 12:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5UhoZ0GmEjNuQ4mGxCzC8Dkynp/HRZEvYqbRW1Hk3tatujaXIJHUQoRIRmj6q6lrFprgJbg==
X-Received: by 2002:a05:620a:2403:b0:7c5:49e3:333f with SMTP id af79cd13be357-7c5eda7c9a6mr155655685a.36.1743017053430;
        Wed, 26 Mar 2025 12:24:13 -0700 (PDT)
Received: from [172.20.3.205] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5e9a22eaesm79891185a.68.2025.03.26.12.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 12:24:13 -0700 (PDT)
Message-ID: <f8b49472-dedf-4377-b418-4ba425ed80c5@redhat.com>
Date: Wed, 26 Mar 2025 20:24:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm/cow: fix minor memory leak in
 child_vmsplice_memcmp_fn()
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250325182319.29352-1-malayarout91@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250325182319.29352-1-malayarout91@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.03.25 19:22, Malaya Kumar Rout wrote:
> Static Analyis for cow.c: error
> Exception branch exits without releasing memory 'old' and 'new'
> 
> fix the issue by releasing the allocated memory.
> 
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---

https://lore.kernel.org/linux-mm/20230404031256.78330-1-jiangfeng@kylinos.cn/

-- 
Cheers,

David / dhildenb


