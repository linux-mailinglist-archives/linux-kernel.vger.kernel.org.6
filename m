Return-Path: <linux-kernel+bounces-341232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8CF987CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 04:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BE2285A39
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 02:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDA416DEA2;
	Fri, 27 Sep 2024 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="dQxZMayw"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C62628D
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727403786; cv=none; b=R9gw2VM1yLOz0olkYo3RL08NeDmGhQOuKSl5Pof50LY9W/ey5lFk/n0XnB6+3fkI3sMnm/aDhgqNjlP98p2EA9drdYor1yyjnp+KU8uVlmdsVzMbMiS5euC+1TUnnm1VFYIqcUPCR1VSQtwjoHOZ0MKoMjNS0SIeqjZp399Od9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727403786; c=relaxed/simple;
	bh=V5nTFEg40BS9fpyNzgTctWWGF7NZtj92BLrRC7NQ+HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIAvoYNE1pYaoEIGCgN6MGYeADKTTA9/LpUNvojooLn9jOgaqtB8AuS/olhTGgzqVCX/aoa3wUQy/esC/Up4dnmsz8Olm+LfHjF/EDsuMoNfhB09R8mBzGcdrRIdAQmRC28aaJQTk/AvukDJIvhodyt4YR8ncNUEI6kz3+CbH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=dQxZMayw; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so1208306a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 19:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727403784; x=1728008584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fm6FdUgor1DMp4AzKUDxfLdY/zKgjnsnnCTT3QZsc5c=;
        b=dQxZMaywWfRVNSvsij2ddn5q1q3tEa2PKca/DKE35Xn8Kwh9VAwLuw+Sna8VhaD95U
         vZQ8QEN1TXntbkxRvpab8otxeOB3U70/jJ4ikIYF+NY5CriZ+C5M4SESdvDZCOi2/3nJ
         L65mW331pF8ED7xRIMZZvNLan3wnMFE+MDUw9Mp7D5ECuiNoSNBwSKV4/tn2+PLjQOcA
         dOeCYby1SIZeHjRHtfgVvvdQXRljBcf4K74O25zKCpLaZfckDvoIcvkih+gKFS9Nhnq3
         Qt/XGUVsaHxxXj2SKfkvfYeVPce8B14NLR8saB2OzBpjFOWE+BvS3YBKkdlpXxg1z3k2
         1C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727403784; x=1728008584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fm6FdUgor1DMp4AzKUDxfLdY/zKgjnsnnCTT3QZsc5c=;
        b=A8rdtrk2TP0EC4SvxrZ1NAZ1amElFwa3yDutoKQJ3wwy+B12bp/q9cHOLSDCOFqa3J
         tOPtNsjwjVQBSigAsSM/0SR6fEmOsfGPv2gGODBus2ST20RnpyulxjTyNspjQXZfX9kg
         amEtjqvLpE0aVtyJc9VbfdqYIiusdpXaOkosrLfo1RBSKsx8qChNNe2wkkY8+8qCJdce
         S5ueh+Ebi3t31A5ibFPELfJIJfkUbL1NtJLDcjrHQPAkK3XFrE+nS7KT9F4pTWRAMBSH
         t++oIE3bmfoWAU+wWEWDX13+wXj6Neub47uGJdcHFMr30p457ZH65kallZ7wj8WSUib5
         xa0Q==
X-Forwarded-Encrypted: i=1; AJvYcCViM6rDHSPqULXDwymFfRvjZ5wlle4rMnHpT8Y5wWMHmPRWImiZDj5RVLPbDTlTbtNKo7egeoDemsYnaE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIMRM0xOgqzpiASIhTCNt59F1ShygX35TQ32zIYf0dZKcRRTUk
	LEfP+fhlE7Knc8mKZKFfJc/CpVEVoMfPbUCcxKFVFt04ehetIRk5YuTLFLua//0=
X-Google-Smtp-Source: AGHT+IE8eclHHp/rZtYVB0h05WFJYdKId7bC7EfQYU296diw2AVIsMjGQmM4ppAbwhdAEFSQulsWLQ==
X-Received: by 2002:a05:6a20:db0d:b0:1cf:3d14:6921 with SMTP id adf61e73a8af0-1d4fa78b468mr2830052637.35.1727403784277;
        Thu, 26 Sep 2024 19:23:04 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc443sm570468b3a.70.2024.09.26.19.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 19:23:03 -0700 (PDT)
Message-ID: <66438fad-d697-4b34-89de-528bd5e081b5@daynix.com>
Date: Fri, 27 Sep 2024 11:22:59 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 7/9] tun: Introduce virtio-net RSS
To: Simon Horman <horms@kernel.org>
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
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
 <20240924-rss-v4-7-84e932ec0e6c@daynix.com>
 <20240924130550.GJ4029621@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240924130550.GJ4029621@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/09/24 22:05, Simon Horman wrote:
> On Tue, Sep 24, 2024 at 11:01:12AM +0200, Akihiko Odaki wrote:
>> RSS is a receive steering algorithm that can be negotiated to use with
>> virtio_net. Conventionally the hash calculation was done by the VMM.
>> However, computing the hash after the queue was chosen defeats the
>> purpose of RSS.
>>
>> Another approach is to use eBPF steering program. This approach has
>> another downside: it cannot report the calculated hash due to the
>> restrictive nature of eBPF steering program.
>>
>> Introduce the code to perform RSS to the kernel in order to overcome
>> thse challenges. An alternative solution is to extend the eBPF steering
>> program so that it will be able to report to the userspace, but I didn't
>> opt for it because extending the current mechanism of eBPF steering
>> program as is because it relies on legacy context rewriting, and
>> introducing kfunc-based eBPF will result in non-UAPI dependency while
>> the other relevant virtualization APIs such as KVM and vhost_net are
>> UAPIs.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> ...
> 
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> 
> ...
> 
>> @@ -333,8 +336,10 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
>>   		return -EFAULT;
>>   
>>   	if (be) {
>> +		struct tun_vnet_hash_container *vnet_hash = rtnl_dereference(tun->vnet_hash);
>> +
>>   		if (!(tun->flags & TUN_VNET_LE) &&
>> -		    (tun->vnet_hash.flags & TUN_VNET_HASH_REPORT))
>> +		    vnet_hash && (vnet_hash->flags & TUN_VNET_HASH_REPORT))
> 
> Hi Odaki-san,
> 
> I am wondering if the above should this be vnet_hash->common.flags?
> I am seeing this:
> 
> ../drivers/net/tun.c:342:44: error: ‘struct tun_vnet_hash_container’ has no member named ‘flags’
>    342 |                     vnet_hash && (vnet_hash->flags & TUN_VNET_HASH_REPORT))
> 
> ...

You are right. I couldn't notice this error because I was testing 
without CONFIG_TUN_VNET_CROSS_LE; I'll test with the configuration and 
submit a new version with fix.

Regards,
Akihiko Odaki

