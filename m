Return-Path: <linux-kernel+bounces-416660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D036A9D4867
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11ED1B21F02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615E11C9B9A;
	Thu, 21 Nov 2024 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXk0KoTs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352504206E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732175807; cv=none; b=Fa0EQ0yfwLoahXHp02SweoalCrjHPy5Aj/RdIyd0FgtGsjapxDA6tboGpRbmXu7+Lqp4uLWsfsQW30Nvk0hfRIQwo2UgB0tLCVddgvdnPtXbC+vbIUJcsnkNUcJWMjwQnPsJ4VVivZtfiFeYSoC7jivjFBmNaB9HWnvKjopQ6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732175807; c=relaxed/simple;
	bh=0UUY1iK+qbSYtbagsSs4Ufir7soHFJ3WlfPQ18B46Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bk1X8K+BSwUMYu2EdzRJMJtqvTgEwq/jd7RA8niSw02FwasRvsVSl7WfWKaOtfRsWJNXT9Kx9xD/BnZTvTsuISnhUJ2w/xANxM15897u2JSiMFm8ChGfhS0YTVcpP1bp9QVZh1uVJ6T9RgjXPvI5AfkrtM4UHI5UMFZ3W+BTB00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXk0KoTs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732175805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92gCfLlbkoSQ+MHQdw6XXaTfuBEXHZVZp1ICXYhuYKw=;
	b=gXk0KoTsFjHc+in37GKaOKWYWrpHAqKov4R6f2HCS7J2HolcqDNRFl4NPZ8rA8KmOencb3
	GP/iqCZRMh5j+Ib7zjNWXxykVxHDp3imTPm150Xk0nxQEO4HuIKtf8hYgjFFmJH+H5p7Hf
	UWf/sxHAIjqmZ9vgJH+j2wWPdSoj9qM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-oWdJ3zLMPmC7RhBaldoaYA-1; Thu, 21 Nov 2024 02:56:43 -0500
X-MC-Unique: oWdJ3zLMPmC7RhBaldoaYA-1
X-Mimecast-MFC-AGG-ID: oWdJ3zLMPmC7RhBaldoaYA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315f48bd70so3916845e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732175802; x=1732780602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92gCfLlbkoSQ+MHQdw6XXaTfuBEXHZVZp1ICXYhuYKw=;
        b=XYqwIrrrfJZCiz9wj2tPG+JkkbnU/sVXzP1B3VB0lwQw1zgyJGuoI4lYO1J4fql25f
         ZL6FF/z9XSgEl6heumhi9Z6HCxteA3IPdw6W7uXZHPylhcuTzKbpXGGXR5GAK5vekxJf
         2pKOSjVKxRKN/UYL6u2f6MpV6mrD1c5q88MRnEN2eGY98o0UGfPfP121KPlcTK/hNa0h
         Dkkq7fskNoeCvK63rpidJFsFkwTR6/6NvkmvhPzytd4TDflqK+L6kIeIbBtRaaGc8KuC
         qCxtcJkVqzQ9ktc4epKxWXitAx+UUo5066osGlH4arrlRua2aRioU5jN2Ps5d5VzjECK
         8ZJw==
X-Forwarded-Encrypted: i=1; AJvYcCU25qbe6IwM1jUvE7TdtH47BOj/le6ytgbXIM0aGVbJ+4v7kbf4geYoO6OWMoTiCX522tlIc/eUBZvcARM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbyHQywW2t3P9m1YJzxBvd7dIgYG7BhLMGhmCACEu3Ny1aluyG
	kX/TIRJrgyX/8DqOnrJ0pUgV26IFzdMvyWScWxCI8RrXO9RgWIPXbkK4xibiQxh889B6x8t8Ulj
	TxO8OviHEWvfZelf8gcrEk/jZ133Z0DDxLngwOphBZhijKyIrAF0hu+OydsDU0w==
X-Received: by 2002:a05:600c:1f89:b0:431:60ac:9b0c with SMTP id 5b1f17b1804b1-4334f022976mr44764475e9.20.1732175802517;
        Wed, 20 Nov 2024 23:56:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9Dv/HXrS6bFeraR7f6sCHP1IXYQOcRMLqrn6BC9ptxW9TsIBcM2hZN2n9VyoonPSe3ABPUw==
X-Received: by 2002:a05:600c:1f89:b0:431:60ac:9b0c with SMTP id 5b1f17b1804b1-4334f022976mr44764195e9.20.1732175802157;
        Wed, 20 Nov 2024 23:56:42 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382549107f9sm4076856f8f.51.2024.11.20.23.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 23:56:41 -0800 (PST)
Message-ID: <75abc41f-a406-4562-9282-bcac0010545c@redhat.com>
Date: Thu, 21 Nov 2024 08:56:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] net: microchip: vcap: Add typegroup table
 terminators in kunit tests
To: Guenter Roeck <linux@roeck-us.net>,
 Daniel Machon <daniel.machon@microchip.com>
Cc: Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241119213202.2884639-1-linux@roeck-us.net>
 <20241120105202.cvmhyfzvaz6bdkfd@DEN-DL-M70577>
 <24a5975e-a022-4bf4-a2ec-76012f977806@roeck-us.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <24a5975e-a022-4bf4-a2ec-76012f977806@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 15:58, Guenter Roeck wrote:
> On Wed, Nov 20, 2024 at 10:52:02AM +0000, Daniel Machon wrote:
>> Hi Guenter,
>>
>>> Comments in the code state that "A typegroup table ends with an all-zero
>>> terminator". Add the missing terminators.
>>>
>>> Some of the typegroups did have a terminator of ".offset = 0, .width = 0,
>>> .value = 0,". Replace those terminators with "{ }" (no trailing ',') for
>>> consistency and to excplicitly state "this is a terminator".
>>>
>>> Fixes: 67d637516fa9 ("net: microchip: sparx5: Adding KUNIT test for the VCAP API")
>>> Cc: Steen Hegelund <steen.hegelund@microchip.com>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> resend: forgot to copy netdev@.
>>
>> You are missing the target tree in the subject - in this case it should be
>> 'net'
> 
> Sorry, I seem to be missing something. The subject starts with
> "net: microchip: vcap: Add ...". How should it look like instead ?

The correct subject should have been:

[PATCH net RESEND] net: microchip: vcap: Add typegroup table terminators
in kunit tests

the target tree is identified by the subj prefix - whatever is enclosed
by []:

https://elixir.bootlin.com/linux/v6.11.8/source/Documentation/process/maintainer-netdev.rst#L12

Please don't resent this patch just to address the above, but please
keep in mind for future submissions.

Thanks,

Paolo


