Return-Path: <linux-kernel+bounces-414107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5659C9D2320
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1749C28144C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0B31C1F35;
	Tue, 19 Nov 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6uo4YtP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C09219D06E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011144; cv=none; b=SODzpXO8nYspfo12cLft0Nbz3h7DyCf014e9yvQcGVj2k3eMh267scrJGqU5E2Q7wjSGBdKlsBNOruX7N5b+5Tg7+IV33Z5bgsaqY0yfiyMjT8QGIk+QeN5CGvu6VLruMtB1fg0YInhjVnOL4v/vNfnvUcBzY4m5u7T8I8g/EQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011144; c=relaxed/simple;
	bh=RZKQppqR9ulv5+UY512XsPJDhRPR3ltZNrET/GxkkTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Me3hTd2jIP3L4y2/9ip0nRpqJnmf+Ip5CSIH8hq52hofo0QgQzD4rONBW0kfKpxwSZKFHb5QRUdT1D8NsRr1s7fNjDGpO86vNSMPyC5PYTfJ6Ngpfa+9j58rBWt+6yNfg0yEUezla5+uNnz2A0ci8tDtR9DT3Q0HHxI5StzAvUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6uo4YtP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732011142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/ll/h4cIcHRULNe5533lZjrqgLdazs+/VxZDeHMmso=;
	b=d6uo4YtP/v45WmKuufMYZ5zeYVmyMCvOE2ItXflnK6juVrKBonwnArmUU1jCLMWRcEKnOi
	GpolrU4RVTvQ1IfdqeHbGDDJfAKyDkoEEwrwDrcPJOE39rCOX7nOIiGDB233vLy6jrKnuP
	/FNLIJ04uUOSvgbEa323bftsILZ9Ai0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Mhm2z8xePbGn5N-NwCFI9Q-1; Tue, 19 Nov 2024 05:12:20 -0500
X-MC-Unique: Mhm2z8xePbGn5N-NwCFI9Q-1
X-Mimecast-MFC-AGG-ID: Mhm2z8xePbGn5N-NwCFI9Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3822ebe9321so2294186f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011139; x=1732615939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/ll/h4cIcHRULNe5533lZjrqgLdazs+/VxZDeHMmso=;
        b=EdrCkyuJwHAr84rbpaqkqHQnCPd0v/97iC/KLHDEO655ceJ7AzuQiUqhEtz2JnpEgk
         gpj2eeqdNGhdCkzvkjLSsLjYnBH3TcvpLHL9CVydrNd1eY0czdbfXtsNnv4sVNHKfSRE
         B+4Mozmg/pEvfJ/RRrQVB53QEcND2+YXMWGQaTY2bUPFxii/WUl/fv7A3oPR93lNoK/J
         fWTf7kiSPT3Vrb1UPyFrBKK3aislmAyJXvqpjAwOo88kgBCToRF8Af4u+uwdxV96WTwz
         4e7ZSIXadH94gczQgNX39eQS7+WNMHyldTImTFDs/uvKvjU9vBcP4yweA7OYoc4GSbAR
         e8yg==
X-Forwarded-Encrypted: i=1; AJvYcCW1YdF18a0UF44QWP6AdA+hOAW4NEv2avyCjWXepXPAAk4PJZq5PYuW5PC6dc41otPMNKWDjfDJ/EHiVqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8f9HgD4hR/6nbnai01snAn5ZE+sD3seaZfeMh/+6f0lp0RNZ
	2HYQAI+ND/bOQK3HvYgHZWudfwW8aXuYeXb3inEI38ukKP72+8+w60PCbxFavfXyxjZH2OcK3Wx
	KOD4zvgrqL9dLkGjJTscqRzU5vYkl/QY+KFOC45fvzw6f2wVHecCLaF+o4vWyGg==
X-Received: by 2002:a5d:64c8:0:b0:382:2d59:b166 with SMTP id ffacd0b85a97d-3822d59b4c3mr9274027f8f.31.1732011139218;
        Tue, 19 Nov 2024 02:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsZiTehmq/TGAqmnasd9Ezz+OKagNClXCsAKRt9ii4MiUiLKopP3o2dTpIdkPJjOhag9LPew==
X-Received: by 2002:a5d:64c8:0:b0:382:2d59:b166 with SMTP id ffacd0b85a97d-3822d59b4c3mr9274006f8f.31.1732011138858;
        Tue, 19 Nov 2024 02:12:18 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38246b7db13sm5907061f8f.91.2024.11.19.02.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 02:12:18 -0800 (PST)
Message-ID: <554d8684-7eec-4379-9a21-0b4a562358be@redhat.com>
Date: Tue, 19 Nov 2024 11:12:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/3] selftests: nic_performance: Add selftest
 for performance of NIC driver
To: Mohan Prasad J <mohan.prasad@microchip.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch
Cc: edumazet@google.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, horms@kernel.org, brett.creeley@amd.com,
 rosenp@gmail.com, UNGLinuxDriver@microchip.com, willemb@google.com,
 petrm@nvidia.com
References: <20241114192545.1742514-1-mohan.prasad@microchip.com>
 <20241114192545.1742514-4-mohan.prasad@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241114192545.1742514-4-mohan.prasad@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/14/24 20:25, Mohan Prasad J wrote:
> +#Setup:
> +#Connect the DUT PC with NIC card to partner pc back via ethernet medium of your choice(RJ45, T1)
> +#
> +#        DUT PC                                              Partner PC
> +#┌───────────────────────┐                         ┌──────────────────────────┐
> +#│                       │                         │                          │
> +#│                       │                         │                          │
> +#│           ┌───────────┐                         │                          │
> +#│           │DUT NIC    │         Eth             │                          │
> +#│           │Interface ─┼─────────────────────────┼─    any eth Interface    │
> +#│           └───────────┘                         │                          │
> +#│                       │                         │                          │
> +#│                       │                         │                          │
> +#└───────────────────────┘                         └──────────────────────────┘
> +#
> +#Configurations:
> +#To prevent interruptions, Add ethtool, ip to the sudoers list in remote PC and get the ssh key from remote.
> +#Required minimum ethtool version is 6.10
> +#Change the below configuration based on your hw needs.
> +# """Default values"""
> +#time_delay = 8 #time taken to wait for transitions to happen, in seconds.
> +#test_duration = 10  #performance test duration for the throughput check, in seconds.
> +#send_throughput_threshold = 80 #percentage of send throughput required to pass the check
> +#receive_throughput_threshold = 50 #percentage of receive throughput required to pass the check

Very likely we will have to tune the thresholds and possibly make them
dependent on the H/W and S/W setup (Kconf), but overall I think it makes
sense as a first step.

Thanks,

Paolo


