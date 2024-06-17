Return-Path: <linux-kernel+bounces-217300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F11990ADF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536821F231D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A8219599A;
	Mon, 17 Jun 2024 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcWoFZSz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06712195818
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627379; cv=none; b=khLxpgFNVYaslTOdrcOrtEz4DnXYr4iLCN5gfLfQwZvnp5YMtkP4SK3shL8LqF9q0toK2gT+4Ub636qVJutLWP5yEAEBj9EuhqWdKt5TN/2VhQkrPghpcJ/DNJTPtXiJPbCWtYBpFpA7KLIGBCK8JlEFkzoHp1hrVoa3tZ8zxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627379; c=relaxed/simple;
	bh=oXXpiunHz1XPLIz1naFMTm6sFnP7b0TdXzOlcK0P/sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0pNITLcOuD0bh7UVJ/7HvaTMyg5DkmbgPZ3rTVPFYb763bsHvEyr+S8X0vBlQ/zHfKlVCkBN4yKdSsApAALhbojaMdyKpX1dFLOqrmMNff49d9oYA9BdotAzlsbzrayoZoHs7NKSckAe2F4HUJx4LZdsKf31VCr3wHkBhbvkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcWoFZSz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718627377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4ssGu5P5LE/MFN4qx06ygb2gBN8nmvpUBOwBXD3IEM=;
	b=DcWoFZSzasaZNre7P6gjKmkVr/10b9YpU4oHLXk8llZzkuTYL7r8EQdssQVcksIlb1445o
	zdAeL9bRFgclKcypaaZZMsU1fCL/gYQeBdxHEdfvghxPCMVL+6JMInyGcElp7Jv2Gd4XN5
	TrO6kk5bDvFlzHUrnzKMtbfDJ3SAccw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-7ZfJ5UmlNZG1sibBJdPAdQ-1; Mon, 17 Jun 2024 08:29:34 -0400
X-MC-Unique: 7ZfJ5UmlNZG1sibBJdPAdQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c2c3b9fd4fso1167524a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 05:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718627373; x=1719232173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4ssGu5P5LE/MFN4qx06ygb2gBN8nmvpUBOwBXD3IEM=;
        b=YGZhjtatHFlVkgVaKsA8C305dpdfnwKMpNW2DfqbSyWyAduIFK/ihuj2N18oB5SCHW
         BgzRlsN2zd4Ok/QEODkyZZsHto7M6MeHDn++csohj/61T4mkCdGqK8vNdOvCzXOHIKmz
         iaqpQBMPlx9e2g4NY95f6XQX1YA+h+EQ3/PIrLWyMzLQOPV/dQgAGhfqToyo/+7pX79b
         QctMKW45h9kiKYYLIGdyCWNBmhg9L5yZzOt987SyfdRurlZnqA/iq3xQKgGQUceoxTEH
         IFH2y08kIzsomZZMveUftmXAe99mQ8g1xHihRxp9Q/3+0tTB75E6qbwN/ZMTuwsTg5ch
         xb3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1Abr0t9zfC/JxwnrL6RyjgAr1ji1c3LFcYqItzpspfj9UJlQgEepaz0EAM42rS6WMaQ44fnn5mi3FgDMUVnIy8IQKSeUvIiwN5zuu
X-Gm-Message-State: AOJu0Yz5oklZmxA14qDxi6yY+svknTXwBEnyeOpzqejd6ikZLkh25Fu3
	sf3qwXGWcApHSjuGGVqcBD2N0MVLFrcZgTRzSGflm8r1ikxiXAlt5u01X0Sjas5Y61iGFjhjyYO
	ybDMs4KJ4a3ZByFFQZmJRyA4tCVfCnNN2QmlDQEsHcSTkH60ygh5+AwhCVVJCvA==
X-Received: by 2002:a05:6a20:5aa9:b0:1b0:1be7:3708 with SMTP id adf61e73a8af0-1bae7e3d928mr8545373637.1.1718627373527;
        Mon, 17 Jun 2024 05:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOU5fYRtot9iBJXy2SS9IX2XSkrNEwI68apkvLYUeP2Vlv30jHjv3k+GFqCmYhxr4fz+B5Wg==
X-Received: by 2002:a05:6a20:5aa9:b0:1b0:1be7:3708 with SMTP id adf61e73a8af0-1bae7e3d928mr8545338637.1.1718627372892;
        Mon, 17 Jun 2024 05:29:32 -0700 (PDT)
Received: from [10.72.112.55] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc967356sm7261218b3a.63.2024.06.17.05.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 05:29:32 -0700 (PDT)
Message-ID: <9db95188-71c2-491a-a4c7-434e7cd3c407@redhat.com>
Date: Mon, 17 Jun 2024 20:29:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] KVM: arm64: Making BT Field in ID_AA64PFR1_EL1
 writable
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
 Eric Auger <eauger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Catalin Marinas
 <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Zenghui Yu <yuzenghui@huawei.com>
References: <20240612023553.127813-1-shahuang@redhat.com>
 <Zmkyi39Pz6Wqll-7@linux.dev> <8634pilbja.wl-maz@kernel.org>
 <7f1ca739-42f5-4e3a-a0c9-b1eac4522a97@redhat.com>
 <86zfrpjkt6.wl-maz@kernel.org>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <86zfrpjkt6.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

On 6/13/24 16:42, Marc Zyngier wrote:
> On Thu, 13 Jun 2024 09:31:45 +0100,
> Shaoqin Huang <shahuang@redhat.com> wrote:
>>
>> If we don't care about the FEAT_CNTSC right now. Could I fix the
>> compile issue and respin this again without the background of enabling
>> migration between MtCollins and AmpereOne, and just keep the
>> information of the different BT field between different machine?
> 
> As I said, I think this patch is valuable. But maybe you should
> consider tackling the full register, rather than only addressing a
> single field.

Yes, it would be better to tackling the full register. I will put more 
time on other fields in the register and try to making more field to be 
writable. But currently I just respin the series with deleting the 
machine specific information and fixing the compilation issue.

Thanks,
Shaoqin

> 
> Thanks,
> 
> 	M.
> 

-- 
Shaoqin


