Return-Path: <linux-kernel+bounces-336169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A1597F00D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A7E1F2204E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFA719F475;
	Mon, 23 Sep 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="3GGB5rFj"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE019F429
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114283; cv=none; b=lutbGVHMKzg3P7sIyQOIAbPz3+2+NWrYdeZl2xnADV9JHIAj2yi/yJuuv3f2WDozZTy6zx5772ZF32t5aPFXBbS+GIS2S+A9czo2lvRB8yvnBmoehhJFwEDAMdJxV6njK0HVCzEJfmxiE7HVwC7knP7mpmwBmtnL39KQ+6VPLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114283; c=relaxed/simple;
	bh=uZwoYgcVajR3HZVdBXuMYB+l5DXtrqtEemr8LFR4GzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJa1eNWQwtylLpynxV+QEZWcYLj1tUua3QlS6Uk7hztVTIGDkuDdXPxBeZrZskjD4nFf7BeKLnrqy7y39OCitQQgrq2Zytq1vNy189RxRj0P1JGlarpE1w+aeRonnId4UGO05FJC6CLYmDVP+67onBGZ+7iS2dyyM6AGg838ehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=3GGB5rFj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c40942358eso7645611a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727114280; x=1727719080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8B2VxfA36wALlD20rKzanMGJ4TcWL9akGgnKfYckb4=;
        b=3GGB5rFjaEnElX+BXftmX1UbycXreLPoXh3Y2MQlXU9SBBibKbhxrg8eUkr+Qlm/0t
         kQtQbCkUXm9OL6fXM2E0MN7142+PntTODWqrJadvRj9qgM/MOf820J74jxaxO7MLf793
         Netx/LzRmMimAyvB+4CFj2zPnRLeDrUoKqd3yOP0J1mj8PU76tt9Au8I9XiujYlsIZCu
         b/hvhyl582JZZ9gePcbHZ1cXum2nHR4b9Vwkt1bnMyqfkdTSFxatYqYeISdzqalyqAVX
         2hhjOWYyL38K6eMsKPY5I5iAno/JMa/xtya30pievCWBzOibn/pzEGuO/2OKKu/GbSrw
         CSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727114280; x=1727719080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8B2VxfA36wALlD20rKzanMGJ4TcWL9akGgnKfYckb4=;
        b=tmz3P27Ehx2AqVE3AutI0Lyf29jsvM1kSYmr7DNg1O6XvI6xPF7zgfPsayB2sHZJ4J
         rU0V8+FZ1uGNXJkQ7A3x2pEi8PmRwGxj0pfz4ML6jEqUNhEEeTqmRcCikec2cI3M0NOJ
         xM6LrXfQTr+gEzd8AqprvtYfWKDNPNolwn0bPbt4vPY5a7qSSalgZyBxhpr3SwKaM2sC
         2EcULa9W8l1p+axNr84kjbkUx6AO72cKKIga+9gN4vRw31xjgaqHPhdQV7a+UFgL7/47
         r5ajjdtAmf6C3NC8RM4ap15heyXhRmIr3sJo6cVRa49Jz2EIP97V0dDsu+PVfwWkO4qy
         ef6w==
X-Forwarded-Encrypted: i=1; AJvYcCXodxQcfLL+GQYS8KN6pozoSQJyCHTyJr7HegkAdgtv7K+VWinzSDvtSJSjL8EdjGyPYX2wmnB7w+nAPlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzIw8ErXG2D/7wKWOEGqAM/1k6x8eYm6K2iGt20fIu4uLLzZLM
	JUxOwIcsIjlx8rw1/2tuYgrjVdLgAEu0Z65We6SDvPcEE/EJFTKCm4G42SIwfD8=
X-Google-Smtp-Source: AGHT+IHxrY3ucRKh97wx+nkV5psN+Kb2p868ccznvAGCqF4s1A84WPgovtg4ccAlF/He1jwEhUdFDQ==
X-Received: by 2002:a05:6402:40d5:b0:5c5:ce3d:41a2 with SMTP id 4fb4d7f45d1cf-5c5ce3d41ccmr501122a12.10.1727114279788;
        Mon, 23 Sep 2024 10:57:59 -0700 (PDT)
Received: from [10.102.105.220] (brn-rj-tbond07.sa.cz. [185.94.55.136])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89e2asm10550958a12.73.2024.09.23.10.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 10:57:59 -0700 (PDT)
Message-ID: <e59f0525-4f3b-4f9c-a359-659fd47dc385@daynix.com>
Date: Mon, 23 Sep 2024 19:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 0/9] tun: Introduce virtio-net hashing feature
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
 <20240915124835.456676f0@hermes.local>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240915124835.456676f0@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/09/15 21:48, Stephen Hemminger wrote:
> On Sun, 15 Sep 2024 10:17:39 +0900
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
>> virtio-net have two usage of hashes: one is RSS and another is hash
>> reporting. Conventionally the hash calculation was done by the VMM.
>> However, computing the hash after the queue was chosen defeats the
>> purpose of RSS.
>>
>> Another approach is to use eBPF steering program. This approach has
>> another downside: it cannot report the calculated hash due to the
>> restrictive nature of eBPF.
>>
>> Introduce the code to compute hashes to the kernel in order to overcome
>> thse challenges.
>>
>> An alternative solution is to extend the eBPF steering program so that it
>> will be able to report to the userspace, but it is based on context
>> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
>> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
>> and vhost_net).
> 
> This will be useful for DPDK. But there still are cases where custom
> flow rules are needed. I.e the RSS happens after other TC rules.
> It would be a good if skbedit supported RSS as an option.

Hi,

It is nice to hear about a use case other than QEMU or virtualization. I 
implemented RSS as tuntap ioctl because:
- It is easier to configure for the user of tuntap (e.g., QEMU)
- It implements hash reporting, which is specific to tuntap.

You can still add skbedit if you want to override RSS for some packets 
with filter. Please tell me if it is not sufficient for your use case.

Regards,
Akihiko Odaki

