Return-Path: <linux-kernel+bounces-379473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ED19ADF13
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702401F234D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ED81AF0CF;
	Thu, 24 Oct 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1I0nika"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447EE18A6AB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758373; cv=none; b=h5UmUHhrsCkR8rVHRjOulOMu1u57eCzeFD8LNbIQd62wrbGO/UN1ZzI6z9eKh/jn1R4dTynmNvSOrMNvEHhbv7sMJ2xYvowKhkN4Rq+krXDWzwZvIm6Svv6v9UwuD20Mki84jRSiWlbyO20JRS3B6VP5PiWR0AgHVEiZIDNkn5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758373; c=relaxed/simple;
	bh=91V0h/7zDnGI9sCOjMHFf6NA0Jnh9LCDW0ToMZO1JSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OR8jUGQmim2lSFcK73NSb5qwQnVtiHjUG/E5VQSmcVAS3jY929DDSiAZOPWI2iUruH5gyjbYL+NqFO60kIN71VMPV+dM6OJwMpbsvgkfhpcTTOjd3gR3+7yavEnURBWaQY41ArwswqtWorBet8wEYlCHPGps0ZizKx3vYU1AnJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f1I0nika; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729758367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CwIK22jJTXiNl/4qz1QFJTbAu0ESQS65/f/CMFNbJQE=;
	b=f1I0nikahp7iU2DPDdc8rKd6OCwQtukMBjL7E0Gosug2Mluv8/Z+uDalQkKNTPYRPI6Sso
	vz/WZ8rL8FU/MDtdn9WD/w2/NgrEI4LVgT2o4i1MHbWilXK98nppmFvTHhftjmYjcREbwq
	0Im3j56qvM5kY9LaYD4pMqQdYM3shDU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-aabdOaKvM1SOC8LSSWu11w-1; Thu, 24 Oct 2024 04:26:05 -0400
X-MC-Unique: aabdOaKvM1SOC8LSSWu11w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d5116f0a6so351499f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729758364; x=1730363164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwIK22jJTXiNl/4qz1QFJTbAu0ESQS65/f/CMFNbJQE=;
        b=mzbbCvXKciK5mYTarPAB3c7jY8Q//Q9EmtM0B87/DFR2rkEBvaZcYR0yDA4BPGVBO/
         lK+oq7jOL5AzxnjIB9cdmsOSGTPfDkgHrN0rLwc6mwW6E7ujgkJ6DLXgBO5hC6bplFzp
         N0fic4qI4bzzjXp/ZOcQMTJO2zT9h/JRc839eEZLehvORT5unIK3g7pJCoFxBevLdfYz
         nqbKorEbG+lOhCeM7hDyebFne44oXwppKHEHF61iSZFeL28SwfV46wRKIJzCeymSxXNK
         1pNokzw9LVhx1KNc4JtSp0znxYXyN7QmpSpUF2vbZRtU4ckpF3M934rFHtyn154Tna+g
         tuQA==
X-Forwarded-Encrypted: i=1; AJvYcCW+m77oTWkRwjqPuEO/TuS1Vnw8x7HZWN6ZuIzYaQ6vvRV/t+ZyqAWG8CRjd5d9JLoeiL4pv0U8grlBqS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzelbsajLaY/GSVALoZWxPGK9nRkLRCk0vslr/fm3SvUolAa5Ta
	Mwoqgzwupf/W42TOiDROhCD4BJStTF8IkFbs9ivvqk4FEX739C+6iak7QXOymvikvq/zBlb2Umi
	ocvHccNvRh2uK0luCabGXmiPumi6v1gMkVd2UMB6tMU3VfyG2Z4bk2pIugv5xzQ==
X-Received: by 2002:adf:f0cb:0:b0:37d:46fa:d1d3 with SMTP id ffacd0b85a97d-37efcf33bb0mr3582920f8f.34.1729758364346;
        Thu, 24 Oct 2024 01:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUHc3F4aF9Xtr+r5ckouML3Lz2RpgiwwzhufdwsDQDe1WdqdqUHPm6HAtVWSTtcDcEHoiDqQ==
X-Received: by 2002:adf:f0cb:0:b0:37d:46fa:d1d3 with SMTP id ffacd0b85a97d-37efcf33bb0mr3582905f8f.34.1729758363954;
        Thu, 24 Oct 2024 01:26:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94071sm10764981f8f.89.2024.10.24.01.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 01:26:03 -0700 (PDT)
Message-ID: <50874428-b4ef-4e65-b60b-1bd917f1933c@redhat.com>
Date: Thu, 24 Oct 2024 10:26:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 1/9] net: hns3: default enable tx bounce buffer
 when smmu enabled
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shenjian15@huawei.com,
 salil.mehta@huawei.com
Cc: liuyonglong@huawei.com, wangpeiyang1@huawei.com, lanhao@huawei.com,
 chenhao418@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241018101059.1718375-1-shaojijie@huawei.com>
 <20241018101059.1718375-2-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241018101059.1718375-2-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 12:10, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> The SMMU engine on HIP09 chip has a hardware issue.
> SMMU pagetable prefetch features may prefetch and use a invalid PTE
> even the PTE is valid at that time. This will cause the device trigger
> fake pagefaults. The solution is to avoid prefetching by adding a
> SYNC command when smmu mapping a iova. But the performance of nic has a
> sharp drop. Then we do this workaround, always enable tx bounce buffer,
> avoid mapping/unmapping on TX path.
> 
> This issue only affects HNS3, so we always enable
> tx bounce buffer when smmu enabled to improve performance.
> 
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

I'm sorry to nick pick on somewhat small details, but we really need a
fixes tag here to make 110% clear is a bugfix. I guess it could be the
commit introducing the support for the buggy H/W.

Thanks,

Paolo


