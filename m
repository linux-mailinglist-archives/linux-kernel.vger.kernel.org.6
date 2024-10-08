Return-Path: <linux-kernel+bounces-354402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9964993D12
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0795C1C23F68
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08982B9A2;
	Tue,  8 Oct 2024 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0i2Sy+r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE911EA85
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728355942; cv=none; b=uy2ChnHnHnds+sau8xijs2opV4ajFyKvxEi5hOXi/Uf2hU21NsuUMoySUC5XJM9I3iZA+08q3ZvJovMCcpXLCFwm8PAy7GOOMeTKb6vtGRiAV3hhmNhgGPPseUR21ekjt6ESf6QmmqytDrItsrRglE9uFmT3W/Cz2Jd/C5uBkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728355942; c=relaxed/simple;
	bh=tSvTHzhJ7hY0Co3waacqVaZp8uierrT18ii5XkgbO2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRpYv/MuVczMSpW6HjZdsckBeQHVap0AfDDIw3L/XNxj/xqM7ntdXOCgt7O+7ZKZeY4oGGM0v/gT3XvuCqs/VmyM8HRUgfpqHzKA6jDctDKbvJJ5khNPwloFmRM4Ajtx3p+rkNa4JkpEn20EDZ9zf2OqgYEQMCuwsN31kY9m4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0i2Sy+r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728355939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=411PCtmrgkUidrOIqeQapBevB2yXfvIcGC2vMMOYdOE=;
	b=f0i2Sy+rGhZX3iH4cjjCB/lrLvSeUryU5983gzrVlUF3QoS2VhwJ6EHf3qCeE63H7OqMpW
	k+v7Ilm3TSyBN6jtvK0pwX+/2YktOXxJMY+hjxo6U5wF5DMRI0dHLCAK5yVZ3j+XwOFqbe
	kA8F3wOkVxgMNX4VMVMyZu4Ul/c4NJo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-15QhAVvxOaKQD9Lx7VxbKw-1; Mon, 07 Oct 2024 22:52:18 -0400
X-MC-Unique: 15QhAVvxOaKQD9Lx7VxbKw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-71dfe2c33f2so2683431b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 19:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728355937; x=1728960737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=411PCtmrgkUidrOIqeQapBevB2yXfvIcGC2vMMOYdOE=;
        b=lanx2tkXvOxqZpDlcERFEJxVQhWcWDL9Zkjk2bSyj7MhwfmIZWXZoWVyOo2vfOovbr
         ly4C/8dtpZ8a5ntMFafbnjdrVtfxkq1kqnPoMKWiPdv9zH+tX83GvXlQfSMLrKoWOUqp
         0j2LNqQLniNhmza0KFp99EaKZ327eFLRJssK6IjSm0gHr5XJeeOQXiTIvlDSawtrUTbu
         3cNedRLrFc3bZz7Axr/EXzOS6g5eL2SCxhqL5YDJ2Nagu7vJi/0DfRd3wscrokUIkqR8
         dZCx8Una97bQQdX2PXT+H7/QEuiixjHCx9VbkrMWd+PCRC/J6jw5n58czEYsSA19zvNZ
         HJ2g==
X-Forwarded-Encrypted: i=1; AJvYcCUBi+XuCNA+mnjEVmX5QHX9er1DvIpSOwZxR2pq2cvh2xrN2C/roqYaxHx0Ob0oYqdOo4EmuF3lJ2VhQT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3st+3AX49YxznsDRcjU4hOgUrjYQvPKJ9ORztvjmCi2WyrCCc
	FQPTBAnhHx5K1w/QbTkdX8fXTrqq/gN93wQganSqcXjIwi8Zt44sWECwM6547j/zrHIq32xS906
	4Pu5bHfK5HcL+6F7/DvNMpLWrAP70sCcmO5g0VicAAccCwSN+aXvenm/zNYFQqw==
X-Received: by 2002:a05:6a21:a24c:b0:1cf:3d14:6921 with SMTP id adf61e73a8af0-1d6dfabc386mr1247895637.35.1728355937671;
        Mon, 07 Oct 2024 19:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENsa/q7SoMe551s0e4cZsDtqunjGqFm6PflV4U0LuYkndGEcrIqyHC1aiUGs/dtevm0SUCUA==
X-Received: by 2002:a05:6a21:a24c:b0:1cf:3d14:6921 with SMTP id adf61e73a8af0-1d6dfabc386mr1247865637.35.1728355937364;
        Mon, 07 Oct 2024 19:52:17 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd2a1bsm5112671b3a.85.2024.10.07.19.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 19:52:16 -0700 (PDT)
Message-ID: <85192743-4bb0-41bb-8ac6-6965cb149307@redhat.com>
Date: Tue, 8 Oct 2024 12:52:08 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/11] arm64: mm: Avoid TLBI when marking pages as
 valid
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
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
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20241004144307.66199-1-steven.price@arm.com>
 <20241004144307.66199-9-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241004144307.66199-9-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/24 12:43 AM, Steven Price wrote:
> When __change_memory_common() is purely setting the valid bit on a PTE
> (e.g. via the set_memory_valid() call) there is no need for a TLBI as
> either the entry isn't changing (the valid bit was already set) or the
> entry was invalid and so should not have been cached in the TLB.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> v4: New patch
> ---
>   arch/arm64/mm/pageattr.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


