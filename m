Return-Path: <linux-kernel+bounces-362099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ED399B111
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5EA2847A1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59972137742;
	Sat, 12 Oct 2024 05:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtTZ2jmT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD57327702
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 05:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728710542; cv=none; b=u5nlh33/h8NuZBHwk7VKN5pRPle14KqAVi/IgaKD9og6sdpUj9sIyfqPjo1HDSMy99GyabImzwIlOCp+YlILdE6YLvL0L4KBODkpJsD7BSMhihTsoTqB6x3amwxHBPNkFfWpGxaIwPeYRa3MILrAD4BPtC1Z/q6k/MuVLmyy1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728710542; c=relaxed/simple;
	bh=KP48yn2zu/bvXJGE9dWPkWLMt3oDQ+5HzzzKc0IzQwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n51nwPJUrSN9bcFIevcOkrzwIIhdAQT+wmTp7FaP7UIow4Sn6iZAAZiwaST++8N6dOTrXFacl1LE77nz1ik4YXsv6kI4VusJfOxbtKTFOlTTQanlbh8+ZoUaYfRoBWQ+kfwwfcEhPT7FYvAJbDr8sRoXqAFNt8EelOKM/BA1dv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtTZ2jmT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728710538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvDr0hBqceMPoqKr59VTJA2PMmkK0w6bfmvafMG1XxI=;
	b=CtTZ2jmT9bnRa+ffPANB0jpFn4JjDcpBQrXhDsWTYsCxqQr+pcfOgKNqjg6yKm7xYyPrhZ
	uBGZ+dfi35qby9FrLL8oh1KkAmQd4RrSX/B9OpsUbRJFst2Oa3jff9W0CyeqGIKoiBGprt
	JRgx24BKu7PSrMkcADPdUtFO1RXG+hU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-l52he_H_Pjy2G8v3Ixwacw-1; Sat, 12 Oct 2024 01:22:17 -0400
X-MC-Unique: l52he_H_Pjy2G8v3Ixwacw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7ea59e7fb29so1026700a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728710536; x=1729315336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvDr0hBqceMPoqKr59VTJA2PMmkK0w6bfmvafMG1XxI=;
        b=DwK73KMpwG1DZMREDDBznrQTHr/n9m9R/s1wfytwEDcEvkHJWp2gZZ5sJPg8ZLTCwT
         4WWHg68jJyxPLaNG14JoNIgG/+4vYQJzb4BZEmnZQaS4IzIaeGN7lT89ibHyOYIXu9Gl
         LiiVzrwhaQDNiT4aLUwFwlK3iXlN+l1X6+bunNtFGCM0LNsm49fKtEdWFX9NCS0VWiJ9
         N8eIsfnmwLYT1Xjq+p2QbW80Tmp+ren7aKVueqHISR6eAjr+btzQ2jquqPrQFuifG7UN
         B6elrnVWI1O+pZdhVc81/ryqYRDk2/Jw8FCS8HNRRu048PrOfFYh1OYTO1fohLAlg73K
         TajQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj/Kd9Qb7QT/qxWSYdrHdAkO8jVbeTUHlu7aRX+fVfGygU5GCYOQhxpOLfEwbi2AsoSU6kv3ptGf7x0SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJYZpZ/a6HDKiILf4QbEXhYvIaGEp6zajm73mgi83xstl4cPN
	ZQSYQ6tE9Q1pY8wu5U/QPQFLceL1VVlH+YGZT7Q844+58wHa/WBjKzbQhN2qWmm7TDIl3j8Py2j
	fIPoNHMjdRhfbA/zEBLK/2MewRk3JHk0Qm1E95sXMCSey9ZP+Xzlm5dfs1wikIQ==
X-Received: by 2002:a17:903:2292:b0:20c:be0e:d47e with SMTP id d9443c01a7336-20cbe0ed77fmr27330035ad.56.1728710536125;
        Fri, 11 Oct 2024 22:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPdfPL4sLDuZbuEZ8hOCaoZXNRre8SGr7tfbn9VtHIuESumtQnMGZco/QwYJ9wvIb8IjS+5g==
X-Received: by 2002:a17:903:2292:b0:20c:be0e:d47e with SMTP id d9443c01a7336-20cbe0ed77fmr27329915ad.56.1728710535801;
        Fri, 11 Oct 2024 22:22:15 -0700 (PDT)
Received: from [192.168.68.54] ([180.233.125.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c33fdf9sm31443385ad.260.2024.10.11.22.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 22:22:15 -0700 (PDT)
Message-ID: <cfbd0cbb-bfff-41fc-b729-c8c49ce28215@redhat.com>
Date: Sat, 12 Oct 2024 15:22:06 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] arm64: rsi: Map unprotected MMIO as decrypted
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>,
 Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20241004144307.66199-1-steven.price@arm.com>
 <20241004144307.66199-6-steven.price@arm.com>
 <e21481a9-3e36-4a5d-9428-0f5ef8083676@redhat.com> <Zwkl51C3DFEQQ0Jb@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <Zwkl51C3DFEQQ0Jb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/24 11:19 PM, Catalin Marinas wrote:
> On Tue, Oct 08, 2024 at 10:31:06AM +1000, Gavin Shan wrote:
>> On 10/5/24 12:43 AM, Steven Price wrote:
>>> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
>>> index d7bba4cee627..f1add76f89ce 100644
>>> --- a/arch/arm64/kernel/rsi.c
>>> +++ b/arch/arm64/kernel/rsi.c
>>> @@ -6,6 +6,8 @@
>>>    #include <linux/jump_label.h>
>>>    #include <linux/memblock.h>
>>>    #include <linux/psci.h>
>>> +
>>> +#include <asm/io.h>
>>>    #include <asm/rsi.h>
>>>    struct realm_config config;
>>> @@ -92,6 +94,16 @@ bool arm64_is_protected_mmio(phys_addr_t base, size_t size)
>>>    }
>>>    EXPORT_SYMBOL(arm64_is_protected_mmio);
>>> +static int realm_ioremap_hook(phys_addr_t phys, size_t size, pgprot_t *prot)
>>> +{
>>> +	if (arm64_is_protected_mmio(phys, size))
>>> +		*prot = pgprot_encrypted(*prot);
>>> +	else
>>> +		*prot = pgprot_decrypted(*prot);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>
>> We probably need arm64_is_mmio_private() here, meaning arm64_is_protected_mmio() isn't
>> sufficient to avoid invoking SMCCC call SMC_RSI_IPA_STATE_GET in a regular guest where
>> realm capability isn't present.
> 
> I think we get away with this since the hook won't be registered in a
> normal guest (done from arm64_rsi_init()). So the additional check in
> arm64_is_mmio_private() is unnecessary.
> 

Indeed. I missed the point that the hook won't be registered for a normal
guest. So we're good and safe.

Thanks,
Gavin


