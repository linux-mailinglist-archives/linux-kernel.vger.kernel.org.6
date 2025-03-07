Return-Path: <linux-kernel+bounces-551705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A4A56FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18887189181E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F2224290E;
	Fri,  7 Mar 2025 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD9D24cx"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B64A217718;
	Fri,  7 Mar 2025 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369996; cv=none; b=YAJVBi+YHI21IpfFVzBXhv0F/+uLIRzYwT0uHULSAtfcZL5hVsv6r66XCSXxyynDk99LSDIdVbAFI3+jf9iR9axnqfU38F6GqxIjtzzdxy/k/wgYAf5Iwqz7zOJC6uoBthKkgUUEFU/qTpnqeoE4TuBTlfJ4vYbeUfowv5VoCZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369996; c=relaxed/simple;
	bh=rr19sBwsRVx6eT7qGK7eZbt1MWHgFKS3zq9OvUcxx5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHHSDo11yttyNdtauBuQ1tG2EUaMRGqlEZgakS2wOMCm152pkBG0bB1roXFWJ5tkOkONkk3BKEEe9lAxzwg9QoHfJoACKkf4Snn4dYFFcaigd605GD1lSx/1HbPX+VQPZkOqzGYrzScNqhneARG/XrXs6YbvWi+dyynWhDzXZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD9D24cx; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5499659e669so587394e87.3;
        Fri, 07 Mar 2025 09:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741369993; x=1741974793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8awcwolQNhF4G4i2+3gjV99xCmgkzISBAp5ygv3cfg=;
        b=QD9D24cxUPR9i9/cg4oCpEebXcsj2ATWK43xalnJ+SrtTAh7ldAdKUDkOqQ35Ht8Kx
         vBhAnAWKUBPhgsyhPxuCRb/s8yZ+2rhwhAdV1tbVbEGxypPmeJXV4O2NOUPNUZoqukhO
         JvjBt4+hDIUOtIDwbFpSj6VdKnD+c/D+ZawuW8I7W6OG5EyxVOBPqVMA/8vpj0/+80+I
         0zEMNZCw670dOpRXx8Z2FnaUFQKnFqLw4CjbNrPMVeYUF8wAO3PyJNX87OTl5otVI0Yx
         u3nlsyOhGLxZYvuLpJ+XkP4PbHBIEUJ8IOi6EtKjIQFd5Kx1PR5OglM46Xlaae24bXrz
         KH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741369993; x=1741974793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8awcwolQNhF4G4i2+3gjV99xCmgkzISBAp5ygv3cfg=;
        b=BpG+HDq9z29POJBO+hhzmI1YkcJtDugripgLoZeFYEvW2zguKQmTPr6HlEsuFfQunC
         b2s533hFzY9gr+cCMafQtFJ6QkX+hD2+uwEJ+LfNuIXgW3aVpiMghTnuGV27cSytTcz6
         uGNtJ4cROsJ0cMrowxdDdeS2hDf7fNXeeaGQBz9YmeLdesKNl8dyFVWNVUJfj3IP/BM+
         gsHQ2I/sgnHBtE4zg8PE8/Qm2RxpbvLieJT6IpMxesEd2s/G7PhoccQWipM5x9uYsDcW
         I2mvicN5w9UDnYSMI0214BUPHKfJp/Fw7GKpYHyv8mZRtAwsuZXObSvOyQQAjX+efz73
         hAlg==
X-Forwarded-Encrypted: i=1; AJvYcCXHYwklbM5czoxYDkBKYLPm5qC7B/8o7vKNUGJ3JbqgZuqHjQYkHrEsDZKcJyZe7Y9s5oXLqlUu6s4h2/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSEA3XCdaLnnwTD7a88jdWrLmxNKxi3lwoWbZzHSVMQjI+wW+
	tscEj8JPbiAY/uLwEfDVoeEub4Q38q7dKPpiuY7PBkw4SNio1Jr/
X-Gm-Gg: ASbGncsk24ukwwVibDmc5KZvAsiyu5JIPPAkbkrkoUyVoMExwr6VjiiJQmdpyOtloec
	auUfTCxJLo1sfJoBTXXfLVyJ7k1mjxuMwUsc0mlhPZL7pnQWNEnup2EhFFIPVz7bJNfk7b9Ogew
	6AS2fwo5lJlcPLWvOOonB4m5IC6Yt/cZSwSxHtT4Zg6qDU/0XarpscoQ1ucuOMxH6Nu68lFR51U
	uYFh2sTamsp3y//cFZbf/LCWxsPLZ0g+lB/C0deI2gJ6w0eJqZF17NHLNS4xJ8CHaIed4ZGzbVc
	1235AaS92hbpnUi6KQUX5TIyiFkzSl74tSjcdPPxW+GZg5UvidwlaIz9bYr3zimHGJd/B/qVNdE
	Z4xXjFfv0NgOYvviqkCYFAA==
X-Google-Smtp-Source: AGHT+IGl09OB0dqYCWBH02itDKGKUCJJ7qvwBmuOJq8stuaveEuflIp46xdYOfUbEyjC7svNNa5IMQ==
X-Received: by 2002:a05:6512:238d:b0:549:8f10:ec25 with SMTP id 2adb3069b0e04-54990e6734amr1611796e87.31.1741369992223;
        Fri, 07 Mar 2025 09:53:12 -0800 (PST)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae591e1sm554933e87.102.2025.03.07.09.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 09:53:10 -0800 (PST)
Message-ID: <1b812436-5e9c-4fd9-9ec8-24ba106347b3@gmail.com>
Date: Fri, 7 Mar 2025 19:53:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/7] rust: pci: impl AsMut<Device> for pci::Device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
 <20250307110821.1703422-4-abdiel.janulgue@gmail.com>
 <2025030747-caramel-blade-4b8a@gregkh>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <2025030747-caramel-blade-4b8a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/03/2025 16:18, Greg KH wrote:
> On Fri, Mar 07, 2025 at 01:06:20PM +0200, Abdiel Janulgue wrote:
>> From: Danilo Krummrich <dakr@kernel.org>
>>
>> Some device methods require mutable references, since they change the
>> underlying struct device without lock protection.
>>
>> Hence, make it possible to retrieve a mutable reference to a Device from
>> a mutable pci::Device.
>>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
> 
> Note, you can't forward on a patch from someone else without also
> signing off on it.  Please read the DCO for what this means and why.
> 
Thanks for the reminder! Will do so in next revision.

Regards,
Abdiel

