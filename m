Return-Path: <linux-kernel+bounces-377269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FCC9ABC34
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C56B1F242F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBA513213E;
	Wed, 23 Oct 2024 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqQg6jnp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441B260DCF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729654411; cv=none; b=PTMJ2OdE6Ydbd9ymnAZqGMCiL1GUv8D4fS/AKIhFegBQ/BXAw7nx5ev2OrVqx3J+qaKJMq7wO+75pMa//jfqcgQFKff9jIPHmKdaQ2E9c+J6XMcbTX93sEgJDOnJN5dI5cGK/gqBjikAoBigkyLyn/IVbfrf7ws62xa7Uq9SLVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729654411; c=relaxed/simple;
	bh=ho6or0E3n/jVuK9PYenxCW+3VsheSIP0c4OklGmN1BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7+sMtmgfECSQqVFaKkUKADR85r+IMXnkuisEyRYvtzQ/QR4rlgj5yiYTAOpgie32Zbp8Va0ylq7kyYpKPZ1DieBhLPdysVEPWZCR40+qLqPV/QRZj0yO5MhOaYrBiTmaORhGDvomKpT3GB7IAcf8CNaCr2DF/kVxe9Zwsxl2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqQg6jnp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729654409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRZWBQ8JLM/V4cYvC4juoQOMsBXfCfkszQvB4MEwP7s=;
	b=KqQg6jnpUDKAWaZFVXB7xGz7BCVu/WuqX7gUUSR7wEcHtS0fLaOp7lYebEpJe8Xj4HIpmN
	JspYAIHbLsYcLlfhFSSFQllXJiOO0J8DTcmcAR5Us9cQ//hXiAuLn4c7vZYtIjCb1y4ERX
	bJ9yU1dpXLuhhh3aqRSKoRfhuQh8w2k=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-h8gKyP4_OG6bs8IBdD4WrA-1; Tue, 22 Oct 2024 23:33:27 -0400
X-MC-Unique: h8gKyP4_OG6bs8IBdD4WrA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e5a60d8af1so3306996a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729654406; x=1730259206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRZWBQ8JLM/V4cYvC4juoQOMsBXfCfkszQvB4MEwP7s=;
        b=CaXyqzk5wj1Fi+p92A/4sBaYG6zAVWxhbbRoyQFWhWPK2kfH1un4eFFUAGBvpkrvBm
         4bN0vG85IyabbAR++tyXX4anSBOcGhL4LOX4WrfuD3vms/DQPaPQWkIgr+h4ozskPCO6
         rk3kf7mcp/rqbtkY9Z+cHpDcRzsRCsFFvgcR5ptGwuOWfkxTtPU2/J94yajVI/N1e6pU
         cskaGH5lotzrrXi5ASD8uJfOuLK8iOPjjfV6Cz3aMuKRmonh2kWjOcFjVGh/jiD9Aa/g
         Zy/XNmYb6ky8dZnLUMbwceJogiN/BLjS59+pJB2ikY5EP9tinBGJpE3sVGNfHbyEliya
         yBWg==
X-Forwarded-Encrypted: i=1; AJvYcCXhlHFUnHhzvfh+JdqLAGTwBnldujrNFIxpv+yyZtVbANXzzsWxzBwFP4U4rSa2BMa4gGNwbB9brDPhkKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCsiCjlUU4HEkfhRWdrrdnZ+9jCyUM2CfdmyNDqTKm8pojjhDt
	psJzHw4G1cID9/Q8cya+z9YDqD1EI0fvZrq8eHm2toWWPbneuzf9mbvo5rClx6Wj20SogWhYDto
	bPrTmUJFz007bY29wm4Am1DKvmVkrcynv0fqFoL1YFQl5Le3leL9DOyptFZ5PYQ==
X-Received: by 2002:a17:90a:6284:b0:2e2:b45f:53b4 with SMTP id 98e67ed59e1d1-2e76b6e4998mr1205477a91.25.1729654406469;
        Tue, 22 Oct 2024 20:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA0P1K9f5Kn6IEIXY9a0xjVIiT7iFfcbST/Ja7UAXbM4WNgnC2BgET2XvmKkP3UopQjPao7w==
X-Received: by 2002:a17:90a:6284:b0:2e2:b45f:53b4 with SMTP id 98e67ed59e1d1-2e76b6e4998mr1205454a91.25.1729654406070;
        Tue, 22 Oct 2024 20:33:26 -0700 (PDT)
Received: from [192.168.68.54] ([180.233.125.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76dfb9b85sm278871a91.45.2024.10.22.20.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 20:33:25 -0700 (PDT)
Message-ID: <2030d927-2c2d-4bbf-9228-34234ea935c0@redhat.com>
Date: Wed, 23 Oct 2024 13:33:15 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] virt: arm-cca-guest: TSM_REPORT support for
 realms
To: Catalin Marinas <catalin.marinas@arm.com>,
 Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Sami Mujawar <sami.mujawar@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, Dan Williams <dan.j.williams@intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20241017131434.40935-1-steven.price@arm.com>
 <20241017131434.40935-11-steven.price@arm.com> <ZxeHSdpxocFA-SrO@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZxeHSdpxocFA-SrO@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/24 9:06 PM, Catalin Marinas wrote:
> On Thu, Oct 17, 2024 at 02:14:33PM +0100, Steven Price wrote:
>> From: Sami Mujawar <sami.mujawar@arm.com>
>>
>> Introduce an arm-cca-guest driver that registers with
>> the configfs-tsm module to provide user interfaces for
>> retrieving an attestation token.
>>
>> When a new report is requested the arm-cca-guest driver
>> invokes the appropriate RSI interfaces to query an
>> attestation token.
>>
>> The steps to retrieve an attestation token are as follows:
>>    1. Mount the configfs filesystem if not already mounted
>>       mount -t configfs none /sys/kernel/config
>>    2. Generate an attestation token
>>       report=/sys/kernel/config/tsm/report/report0
>>       mkdir $report
>>       dd if=/dev/urandom bs=64 count=1 > $report/inblob
>>       hexdump -C $report/outblob
>>       rmdir $report
>>
>> Signed-off-by: Sami Mujawar <sami.mujawar@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>> Changes since v6:
>>   * Avoid get_cpu() and instead make the init attestation call using
>>     smp_call_function_single(). Improve comments to explain the logic.
>>   * Minor code reorgnisation and comment cleanup following Gavin's review
>>     (thanks!)
> 
> Gavin, since most changes in v7 are based on your feedback, do you have
> any more comments on this patch? I plan to push this series into -next
> fairly soon.
> 

Catalin, The series looks good to me and I don't have more comments.

Thanks,
Gavin


