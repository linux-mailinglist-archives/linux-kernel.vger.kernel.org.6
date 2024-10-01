Return-Path: <linux-kernel+bounces-345580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D94498B7BA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047822815B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DB319C57B;
	Tue,  1 Oct 2024 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRKQb3wz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3219AA68
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773066; cv=none; b=QzhFO8GYiFfynx12ugA+FIcH+97aqHlkVea+QtEgZiXMOQyYKOEKsouW9/FGK9NjSWqJRpHT1E7uKdJ6znYpmYyYLdG6JEHbGAZsAVs0FDzcb3cILCgoJmejNEJvOiASw6U+KFH/omzhWmBji6fnLjmYDsaVQLcRmGnwKHvzJgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773066; c=relaxed/simple;
	bh=0rWuWdHzo/SLyCRS5WAeT0wFgXi2wmzOHtxCvKR12LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bvUO0etmZqTIxBZo32sz9/5FqoyGxquYgvMO1VVqtIlNhTFOMsSKqVh3PyPz6EZf/q8dbD7vs/T2VY1jVUdUfZAtiAk0VBQG1UHHjcynRyhFs7tx3575R1eIelXjSlYDf5LGqSdgnKocThwtl7gPnAYujLitV3qAoeRR04/O41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRKQb3wz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727773063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tel1LpaxCz4nYryVAUogU9yAyr5ZoGgY5gwFfwz2zgo=;
	b=XRKQb3wzniYQtnDxLvqAGvxrjOyIgPXmxvOIiIG+51Ae/ZF82xVbsGC03sK1DAcbOhviUd
	tYbDqpY+3/BFw4szKUDmqGr9aiCSb04q/haBhBIH1USjPFi9XLF5S7AVoMp00jxJLKdBHg
	l9UV58CMPohDCxQLdVv5QE/vckHiJA8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-T_hNU3MZMPiHBcvtI5Gkxw-1; Tue, 01 Oct 2024 04:57:41 -0400
X-MC-Unique: T_hNU3MZMPiHBcvtI5Gkxw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb940cd67so53550255e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727773060; x=1728377860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tel1LpaxCz4nYryVAUogU9yAyr5ZoGgY5gwFfwz2zgo=;
        b=oRn8mlKKT05R9OAYPLba7A8m609+DJLjXRxfQPd47RGAOxdz1C3TUDPiaZw7thzYfI
         /c5ctQ3r8lzMlw9T2yogkjnPdXyMQgWvn14SPIhsWJ7zhu6JyRe9jK7bh4nhuni6NNZI
         jJSp2Hm1ckx4DsLt0xbDjV2DRSeEC5K57+7QNCabTDTpwQfGsWpGZjFcJu508uk6RD7g
         ov4477Xm/2/Nw5VlQJeMqqjVzZ6U9etr7yk1EPtzxBPWKqywi82qkTTIp3EyhJGNRCrx
         qpAMRmRsrjlLVfnIUAGT3MF4xwTyJnDE6i5nRaEgETe7rMNqxGy9oEo+kgiN2VK09XMj
         e3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXecnKAKYADmcV7HAVe6BoWXVGjrLBjdv4AMGMBVFBpo3naNPYxZgzEAc5Rhzsl0nwgfkjv2ZGVO/0MjU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuY0X6ebq8xQ7LZSHyQX9UnON+Se7NB0X6TMYetn+O0IGg1uhR
	mJiV5cyo/0HCWTqQA1n+k+os7aZhQvlDLNPhdEgT1woCBV1TeSVftW2YuCKgFGdloWkZdArkdLm
	6w2NIj9AG3wJOVZNHYQtzXZPoHH0gf6UjljMAYxLQJZ+cO9wcuLjctbpl+zwhPg==
X-Received: by 2002:a05:600c:1da1:b0:426:62c5:4731 with SMTP id 5b1f17b1804b1-42f584a1821mr158033655e9.29.1727773060152;
        Tue, 01 Oct 2024 01:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDEVnOgFXLBwjP/N0/qO2QYcxJk+fhQ4Bc5AcBVgYNvDnnZR0OhDiecntFBnJOkLo5rnwIVw==
X-Received: by 2002:a05:600c:1da1:b0:426:62c5:4731 with SMTP id 5b1f17b1804b1-42f584a1821mr158033515e9.29.1727773059817;
        Tue, 01 Oct 2024 01:57:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c? ([2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969f1a76sm173796175e9.12.2024.10.01.01.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 01:57:39 -0700 (PDT)
Message-ID: <090742d5-e801-4c12-a49f-b3e06adde82d@redhat.com>
Date: Tue, 1 Oct 2024 10:57:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/1] net: ethernet: lantiq_etop: fix memory
 disclosure
To: Aleksander Jan Bajkowski <olek2@wp.pl>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 jacob.e.keller@intel.com, john@phrozen.org, ralf@linux-mips.org,
 ralph.hempel@lantiq.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240923214949.231511-1-olek2@wp.pl>
 <20240923214949.231511-2-olek2@wp.pl>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240923214949.231511-2-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/23/24 23:49, Aleksander Jan Bajkowski wrote:
> When applying padding, the buffer is not zeroed, which results in memory
> disclosure. The mentioned data is observed on the wire. This patch uses
> skb_put_padto() to pad Ethernet frames properly. The mentioned function
> zeroes the expanded buffer.
> 
> In case the packet cannot be padded it is silently dropped. Statistics
> are also not incremented. This driver does not support statistics in the
> old 32-bit format or the new 64-bit format. These will be added in the
> future. In its current form, the patch should be easily backported to
> stable versions.
> 
> Ethernet MACs on Amazon-SE and Danube cannot do padding of the packets
> in hardware, so software padding must be applied.
> 
> Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

For future submissions, please avoid adding the cover letter in case of 
a single patch.

Thanks,

Paolo


