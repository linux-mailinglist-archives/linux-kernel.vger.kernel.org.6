Return-Path: <linux-kernel+bounces-536310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3831A47E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C646F188848B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAEC22E3E6;
	Thu, 27 Feb 2025 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bck2HsvZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830422D7A3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660071; cv=none; b=borokL5zFhjIxsUKzHaNzPLZom/RoF2vfNnreMXhi+l5wvhETV1lgRKDnquubx1mKQfXwB32D9SzvlZYBspqE5c9oP2S3rOAHgHd/MUymHpn2IvObJ/JiV27YrmM4Oqx/7/rZYS/7+J4ayXheKYqQpFsgMGS5JHyDN/rQE6pPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660071; c=relaxed/simple;
	bh=V/uWrFw0n6vxT69u6H4TPbbmjz5vMH/2lfvgjrvFrO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvFWypzo6oodzxNb5+BAd97c5QM7zPRXslHKWan/aLv7E43M9KM3UobvrdZS5fHxKdMnCFbSVY1Oiey0xpsVM77coGwHq24QG5CJzBwFckic5Hmw5tQFzY466I2oyaJO4uwl0wWMo22Z3QB3sNJRv/x4tQYXxIXQA+IgiklTX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bck2HsvZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740660068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTINDLfPqxfQ8l+8NKRPBU7gjazJ+mnWdXheSYtrXNU=;
	b=bck2HsvZYFQm2uYZxjKDkxTG1a1p2crIdRUHoeFtku5i5ZCzmhG6Tm0prxGHOCf99UjeAq
	7r2UIhpT4I9G5qjKJVJfm0rm8UEBdcD23wN7Fecrz3h8SQx1fK8pH/BaSGNrrtCw2LD6FY
	t5wp++l/8aZxPnLveNijM2Vz7RyaDVI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-utaq725wPwOUWCpyU4suOQ-1; Thu, 27 Feb 2025 07:41:07 -0500
X-MC-Unique: utaq725wPwOUWCpyU4suOQ-1
X-Mimecast-MFC-AGG-ID: utaq725wPwOUWCpyU4suOQ_1740660066
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43947a0919aso8447555e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740660066; x=1741264866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTINDLfPqxfQ8l+8NKRPBU7gjazJ+mnWdXheSYtrXNU=;
        b=n2vcLtNQ8mqgTq2JCljOM7jijJLT9caxBno8g1D4p8OLvp4O8ZadyVZGKmRixLdwga
         H7npgZ6E5KkyxJEL1ETkLrceNy8+6SCwKWPpwpG0Afj7zhyRsv81n+tf2tg3RKKMBlD5
         /UqrlcpXf4316m3JTvV5KgvqRGDqjXNRCtf2ISK2sAtSHubY8tw/deWM7DGVt0+XeSPu
         bVW4Wmr7iDjcjIbQcEGYfYPlNhDzsrLZZ2jkSbHELeG/Zuh8cpbeFuL/ubGR0BJ6H1kP
         BKvuRzicGiLCdmmrmvoQkqCNRAS5mqbzEgjU6SaneVVMrvX8Ty9lZ3edk9as5OSNkK4X
         5ewA==
X-Forwarded-Encrypted: i=1; AJvYcCXATSUUgRRxNwhGgbwkDGqrMwpD9MNisOKl1lzokFEJY8l0SQdX3oXFzN761y9qy62eXuKZTI92zc1hfRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq/yiHjLppq8vSuWOgYXLslkWIlv8qw01sNFQ5QsT/BVob0t5T
	fhTGHhdG1lI9iDLkIuPbhF6Nv/5XWgSS18UR6xBzBgbkM7EGwS8A4I1M806iyZUwjuiglET9+tQ
	gHgbuVb+RuZnmrOW7GsbuhfQhFd8iTyIO8onKEGyNoynMOpUsfdyorQ5x3puVAw==
X-Gm-Gg: ASbGncu5zgCaNoCcrca7FHUFNVKc4iF0K5Jt4qP//97edYZTbaOBQeCb2pjHiqaBreq
	p+ZZyDYFAR3A+9ru/q6vIkk5xrvXZdTOQuxLkY/84LUNp+tdlgzA4YHsoFtd86M5NTlOr0jvwWQ
	hxFy07qRieKcW/c6Elaw2+w3c2T17wdRN7PXLxOqyCVWGww5gfQ562XqgRMblGei9jcvOIqUe+C
	/FQksyVqHjWmipncNpPGluEVzfd2YHvDQBLR4twRz6NVAZ9EIRdC/MyMcVmOMewLxQHdruOqHP8
	8yX+ryMu4z5j8Tq7iRNBpbSs9827Ci6eWYP7GEFerqqvkA==
X-Received: by 2002:a5d:6dad:0:b0:390:e018:6435 with SMTP id ffacd0b85a97d-390e0186916mr5028517f8f.45.1740660066127;
        Thu, 27 Feb 2025 04:41:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrultoF2l5s7HDAAETlWCBL1qdXIxgpD9IuaP0L2TDsWz9fpi9ZRFzjdSJpJiWmnDROX/nCA==
X-Received: by 2002:a5d:6dad:0:b0:390:e018:6435 with SMTP id ffacd0b85a97d-390e0186916mr5028492f8f.45.1740660065714;
        Thu, 27 Feb 2025 04:41:05 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a22sm1912237f8f.74.2025.02.27.04.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 04:41:05 -0800 (PST)
Message-ID: <7306618e-8c30-4963-96e6-c0b58a5bd88a@redhat.com>
Date: Thu, 27 Feb 2025 13:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: hisilicon: hns_mdio: remove incorrect ACPI_PTR
 annotation
To: Arnd Bergmann <arnd@arndb.de>, Jijie Shao <shaojijie@huawei.com>,
 Arnd Bergmann <arnd@kernel.org>, Jian Shen <shenjian15@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20250225163341.4168238-1-arnd@kernel.org>
 <da799a9f-f0c7-4ee0-994b-4f5a6992e93b@huawei.com>
 <c0a3d083-d6ae-491e-804d-28e4c37949d7@app.fastmail.com>
 <3e477135-981f-49bd-8e54-0c3ecdcc8a19@huawei.com>
 <c28e16ce-d535-4af4-972b-e19376833235@app.fastmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <c28e16ce-d535-4af4-972b-e19376833235@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 1:03 PM, Arnd Bergmann wrote:
> On Thu, Feb 27, 2025, at 12:53, Jijie Shao wrote:
>>
>> if CONFIG_ACPI is disabled, ACPI_PTR() will return NULL, so
>> hns_mdio_acpi_match is unused variable.
>>
>>
>> So use #ifdef is possible and has no side effects, and many drivers do so.
> 
> Those should be cleaned up eventually, but that is separate from
> the build warning.
> 
>> Of course, it also seems possible to remove ACPI_PTR(),
>> But I'm not sure if it's okay to set a value to acpi_match_table if 
>> CONFIG_ACPI is disabled.
> 
> Setting .acpi_match_table and .of_match_table unconditionally
> is the normal case. Historically we had some drivers that
> used of_match_ptr() to assign the .of_match_table in order
> to allow drivers to #ifdef out the CONFIG_OF portion of the
> driver for platforms that did not already use devicetree
> based probing.
> 
> There are basically no platforms left that have not been
> converted to devicetree yet, so there is no point in
> micro-optimizing the kernel size for that case, but the
> (mis)use of of_match_ptr() has been copied into drivers
> after that, and most of the ACPI_PTR() users unfortunately
> copied from that when drivers started supporting both.

Makes sense, thanks!

Paolo


