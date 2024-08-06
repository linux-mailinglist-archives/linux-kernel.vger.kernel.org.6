Return-Path: <linux-kernel+bounces-276791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71568949875
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5061F22CE5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC61158DC0;
	Tue,  6 Aug 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dgXFt8rq"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF402146D60
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972988; cv=none; b=Q3T2eA7d+KBAkh43YyUJ8l6bY6tvKL0lKVFkFO/SyOXzkA5LjmZBFlsRwpgh8PJXGqiVFrZdYNaC8POoPN9mD0ZAvJ1RZe3Dp5/VMavm3PHzai/VI3BffBBXg4exrAbiUVQrSpZzeVJMXWrdgkZ7pMsn5dzyXglPQs0mc5GVsOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972988; c=relaxed/simple;
	bh=iEz7lCKN6LmqkDmIh7w+RAirspZH+Yr49vveXIUCT2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CN3QzTwjUhemQzm77/VRZUF4h5fHKfcTPwGzrVjG7cNkcnb99Uclo1/ei/tYXCrl4PpXFKrVnNx+guei5cuoY1vT7L17irk3RuU2ueJ3pA26PFovtR6DCJZvIJ6kHBGcSZZFa2UK77rxntovuf1sen8h5h/j5AzKwmBo1fvtLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dgXFt8rq; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39b37e5f8fdso716465ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722972984; x=1723577784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IcNnXdUnkI1mV+s9deswScXVelqj2JzGCxi8Q1hYao=;
        b=dgXFt8rq338v9mNPgwgFpyQeEyP9PhlbTH0gd/5M7tHssveTygnJUSoOPDz1s7zoEE
         vrXqctZJ3rctpjXUVqMPwL6X/tRQnb/2HsOyBqlkjG+8c0fMU5I73PouwXQytmKaxy2b
         I6DfJ98qKJ91h8g816wg/YeFcfIfIoxRJQTdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722972984; x=1723577784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IcNnXdUnkI1mV+s9deswScXVelqj2JzGCxi8Q1hYao=;
        b=uI9AT1S9/Djrn1vlw2KEfEg9th1vJv0ZNaiDtdqI08+MQfHJL/DnvHBwqZYyGzIK0C
         gjpNdQ5Ts0jEClnoLbfyDvYZjFSP+cAwGNqiV6xGa2zzsCb/XNmNZBUpyVk4P0fJ6QV+
         vz9LTi8JITldoINUIrPatuqm4xrVYu6oiH0nBRNNQ7DqHUz6rowHvZCeUS4Kcsl6JiVR
         OvYzEUn0v2qKuqsDKR2wOzKrHImUKP+tf7sqyVle4CwOHBa8tvPQOnI3KmaPGziNAtvA
         GyShQGCjJ8S6HuyDYVv123rTzN6qlu+Dv/U6FHQzB1Rh+DYQ5YX+naKEp9MNx5iE6r7s
         3CRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2AGTEaMNHejnaM3AceF91A2+ZXi6F3BIMkjSsrOjrSYuwxBkJLeHkkSRXOzIeETDZ4FoAGkr9R8T3+QAuY88gT5kzuooBx8BpYroA
X-Gm-Message-State: AOJu0YyZeVwYiJ4CvsCU/3xHIfk1u/WhcoIel4ZUhICUjB/Lp5zXQJsq
	ABZ9xIzqvVnN8nH4UMSjd6ktqK385sBSu+LUSRX03WKftfb/xEE6xnR0sbC6454=
X-Google-Smtp-Source: AGHT+IEZoVlqN5oqC2UZRAj8/ipXO6L3aUE6bBqVulf2yqdJndVbcARXaKrOBMfnhl2rIFv8JufbBQ==
X-Received: by 2002:a6b:7b02:0:b0:81f:a783:e595 with SMTP id ca18e2360f4ac-81fd434de8bmr1018147939f.1.1722972983992;
        Tue, 06 Aug 2024 12:36:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d830afsm267206139f.55.2024.08.06.12.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 12:36:23 -0700 (PDT)
Message-ID: <ed207f8a-893d-489f-8e41-d698292ab918@linuxfoundation.org>
Date: Tue, 6 Aug 2024 13:36:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] selftests: harness: refactor __constructor_order
To: Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 linux-kernel@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, kvm@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rtc@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240727143816.1808657-1-masahiroy@kernel.org>
 <202408052126.E8A8120C1@keescook>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <202408052126.E8A8120C1@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 22:27, Kees Cook wrote:
> On Sat, Jul 27, 2024 at 11:37:35PM +0900, Masahiro Yamada wrote:
>>
>> This series refactors __constructor_order because
>> __constructor_order_last() is unneeded.
>>
>> No code change since v1.
>> I reworded "reverse-order" to "backward-order" in commit description.
>>
>>
>> Masahiro Yamada (2):
>>    selftests: harness: remove unneeded __constructor_order_last()
>>    selftests: harness: rename __constructor_order for clarification
> 
> Thanks for resending this!
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> 
> Shuah, do you want to take this via kselftest? If not, I can carry it...
> 
> -Kees
> 

Just about to ask you if you want me take it :)

Yes I can take this - I will apply this for Linux 6.12-rc1.

thanks,
-- Shuah



