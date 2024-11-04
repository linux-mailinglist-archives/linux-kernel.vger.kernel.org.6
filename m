Return-Path: <linux-kernel+bounces-394522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DE39BB087
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693BF1C21CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5FE1AF0D5;
	Mon,  4 Nov 2024 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXdWVQbx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E1192588
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714697; cv=none; b=P5JhCNrL24+gXR1yOLM8bI3ls5pJUaUwRN+By2cbpVTt7UscKU1vbL/N1uQUK4+rm9PiKQ/c/W7arj8Ow+k1NpHokghKencSp2w65lfaN9B8QB4BJImElYpEcQm5zWvYpRUAXhedo+dsKB83JRcB558jzsQm/okidNo+9iX8XcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714697; c=relaxed/simple;
	bh=j6FK+QcFXV1PXLH5fQz7HwdZu+CP4alnNimVP6X1tMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLLX8lTtWl0PlVRm/kgtcUuB06YIuhVKRVqy6njVJGkHTtlkS/kLa+a1tOfzgVhtT8dQkvfxcWC9uhCv2MWIkj8iJV5xqB70WiTOHmEE2vp6Agh3l75U7GIF7Xj+CX/p3kOHbr0EVULthlgeDHFkUvQeUgcJz92sG7iYTkZ347E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXdWVQbx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730714693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rr0x/642zGcE80hVGdWJ4xDKS0hjceKOyLETD5XhvJ4=;
	b=JXdWVQbxSaXCbyVj4z4CgyQsOs9dvtZPKrRmdITV8IX1q8maxSGZbWv5NSQ9BT0p5LjL18
	Ekykut5s9Ar1ov3NsaP7GK2ixzrOwen9r9TYUXqXpDA39ljNv0LavAXnIgE3RT4vrPGQhM
	2+vmAreh93ywA58BGmqtKalxvjXuTRo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Q5cgnyrUNAyjlrFWojeyFg-1; Mon, 04 Nov 2024 05:04:52 -0500
X-MC-Unique: Q5cgnyrUNAyjlrFWojeyFg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a1be34c68so329002566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730714691; x=1731319491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rr0x/642zGcE80hVGdWJ4xDKS0hjceKOyLETD5XhvJ4=;
        b=AwDzOqsacqoeH4PN2C901i2GmCC78nNxekl39VJe0Be6sRVYYGyDWqF4x/XvoLKdyY
         dNtpkOTQbXazNvCrMfHdwg6fWeF3l9/ZSWjrgoZPiGwR1d1dPzbYvIopJEOSbYET3IPm
         R2zO4LAnW7IkAJXY0e+H0pwt3k7EFrNuLHu3pUd7O33C0CyJFGNs/KmO3IVFu/oblaSW
         ahFXrqmtXKf6c0bbs5hsRXu7LihvY927VBuOiKTeXcECYqNFT6bmOtOWKF3uOxozqVz6
         jbGsIM2tZtDOlFOyIb5+2XMNQfb1BbeKLDvaaP2lieDcFIw+SjchPB4/277qL6k7uEYM
         Jwsw==
X-Forwarded-Encrypted: i=1; AJvYcCUQUlqMG+Qy5hbcveSy8CCgOC1uE1Vm3fBS7qHpH0iUHkrJnziFZDcLMcnuSjtU5++quWTb9xlcEX4zGAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh57oEavHPw5lnLD07/iPoVyQLKbrc+i7IGN/Sew67LbLRUPvZ
	h7q/M8wgupu4wY9P3bFVhnymBiQUk1CnV37h9Wb6dm9b46jcJuXrOkKUvIMXDbHILNvKSDg9SUO
	cwuSZE4f9vaE2/7JAJqjiisTsy6CVDoadlEJ8CtDLqg+UecnLToZtr2xzGsLEOQ==
X-Received: by 2002:a17:907:1c1d:b0:a9a:24a2:180b with SMTP id a640c23a62f3a-a9e3a7f2174mr1755624866b.57.1730714691063;
        Mon, 04 Nov 2024 02:04:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk/6X5iphD0pbEQ2fucbUHyw3wo9CHjAKQ/X/7Vcp/jJ3z+kYYgLixvBF2Ri7qLRxsJUMjTg==
X-Received: by 2002:a17:907:1c1d:b0:a9a:24a2:180b with SMTP id a640c23a62f3a-a9e3a7f2174mr1755621466b.57.1730714690591;
        Mon, 04 Nov 2024 02:04:50 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7700dbsm4086192a12.34.2024.11.04.02.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 02:04:50 -0800 (PST)
Message-ID: <0f27f32e-bf00-4f9d-a0b6-0625a6dae203@redhat.com>
Date: Mon, 4 Nov 2024 11:04:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 1/1] MAINTAINERS: replace bouncing maintainers
To: Lee Jones <lee@kernel.org>, konstantin@linuxfoundation.org,
 baocheng.su@siemens.com, tobias.schaffner@siemens.com, pavel@ucw.cz,
 ilpo.jarvinen@linux.intel.com, wim@linux-watchdog.org, linux@roeck-us.net,
 Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-watchdog@vger.kernel.org,
 felix.moessbauer@siemens.com, christian.storm@siemens.com,
 quirin.gylstorff@siemens.com, chao.zeng@siemens.com
References: <20241028112359.3333152-1-benedikt.niedermayr@siemens.com>
 <20241028112359.3333152-2-benedikt.niedermayr@siemens.com>
 <173048213838.1966999.11456105703949125929.b4-ty@kernel.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <173048213838.1966999.11456105703949125929.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lee,

On 1-Nov-24 6:28 PM, Lee Jones wrote:
> On Mon, 28 Oct 2024 12:23:59 +0100, Benedikt Niedermayr wrote:
>> Since complaints about bouncing maintainers raised [1] we have now a
>> replacement for maintainers that stepped away from their duties.
>>
>> [1] https://www.spinics.net/lists/platform-driver-x86/msg47105.html
>>
>>
> 
> Applied, thanks!
> 
> [1/1] MAINTAINERS: replace bouncing maintainers
>       commit: 64dd44a658065ab5595bbfe2cb4d8fd30c9e34a2

I'm not seeing this on either of:

https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/log/?h=for-leds-next
https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next

?

Note I'm fine with you picking this up, I just want to make sure that
it does not fall through the cracks and drop it from my own patch queue
since it also touches pdx86 MAINTAINERS entries.

Regards,

Hans



