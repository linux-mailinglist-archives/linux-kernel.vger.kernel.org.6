Return-Path: <linux-kernel+bounces-354407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25266993D1F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA26B222C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55FA25776;
	Tue,  8 Oct 2024 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxYFyvgV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBBB20326
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 02:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356210; cv=none; b=dA/dpd7BNMOxO+QADP8Ar7+ddvebnhCk8CJmnjp7XwJzSy+e84D16LjAZpedaTwQfUDtz1Ni0ZPXFddW/lgfTOWStJXy1JXMdmK9eCxcZW7I3mX2VFS/XrLDkg7WaQ1Pz9JrC5+fxr/ZHdasSQ2xsF/aI3DDMzr2n6zyv2usTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356210; c=relaxed/simple;
	bh=JD5rRprLSwx+mhh0teGCAAawEXaNzQDmovD5hjPdgJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcEuWkFpI/4sHyX3mXvuWmYPFI026fZKXWV/ccimQCdIF/0F8Z8VP05PEc5hj0qw226StUZwCEmnceX+t+Kh9EEwZJRHTnuwd9a9BYFUzYtHfrLJ90GX2SM/pWJiJ82iiPEpvR28vcvEI1XLZ+pCghNgdmHOrs0LRtKCMQEko2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxYFyvgV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728356207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KM6xf6sEqcjRtyhQgAbYMNmNaySSsAseblPrEZ4b2lY=;
	b=VxYFyvgVdWZll6kyvqSyTeWvEAZZp//sZf4PZ3mgki401BrxPU6xWVbTqyu84g8I7KZeyd
	GiI2+xDok2oVPk8t6CzX2GwKxggoTrdjPB9whs3lXXelYr8zzXercTatlkDXHp3XZHaUwY
	W7xHzKXoAvgMORw5NpnfoKVSGVCIKE0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-IVhBx1gfN2OuFhC-racM5A-1; Mon, 07 Oct 2024 22:56:46 -0400
X-MC-Unique: IVhBx1gfN2OuFhC-racM5A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e2898549e0so87121a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 19:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728356205; x=1728961005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KM6xf6sEqcjRtyhQgAbYMNmNaySSsAseblPrEZ4b2lY=;
        b=ta7x5SIre7Xoxs4L8sx6E5VZXJudqJuIjhamnNdYcz5bw5PE3hMvCWhQrW80pbqiRF
         UF7XMog8NwBs/lX7vu/2Nwq4Py2jCO2wR9+2O5UBAJsEolMFFJbYQ2GoTJC+2KxIrwZY
         pBWzQ8t7BR6v81/kwIRmyuWqUffuNqWSj0P3w6SjBeSh2LascbPCIUNRPYO4CbIcM7vI
         zlpvycrqfExr8sWHHZRnN//PAKFFjUnTS1HkqRtTSEFVdJfUmG7koHm/WvapR+pjsPAq
         CKpR7fa7Mr6BR+fafl//c4/gOj2iBjZXp1xP5v0L1lBUXCdR5ufRLLlKTvpkTrcJVCvh
         ek/w==
X-Forwarded-Encrypted: i=1; AJvYcCV289/eIepODKezOI4a5dukWrv+GFY5hI/JdDMfj5uardSIXzWNe2xbxGAbqmN7PxQQcdMsgVmuyJxArVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+758L1gym1bb8NKeM5bnhBsKoDRnD1OX6T8k4UHj6u6koH7a
	Y6r14fjyqsMuZMF2201STtu1VejpYkcLsCMa/dXvgC0UOSWq3UKC0tA91DOV0Y7lehyoXFB0+h7
	JaW4JpvMHEH/cC9T6/DeDSQtQROtM54bnq+xr+Gh4vhdjlrWf317Ji5R/44ZkIA==
X-Received: by 2002:a17:90b:3c87:b0:2da:905a:d893 with SMTP id 98e67ed59e1d1-2e1e636c83dmr16775541a91.31.1728356205266;
        Mon, 07 Oct 2024 19:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0LUzICRMByd9uxAUa++9+87v1zVZqbecdEx3xdGyOmYX5ElCHosgfateZaUDyS8uZx+7XTA==
X-Received: by 2002:a17:90b:3c87:b0:2da:905a:d893 with SMTP id 98e67ed59e1d1-2e1e636c83dmr16775512a91.31.1728356204947;
        Mon, 07 Oct 2024 19:56:44 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85da3f0sm7939061a91.30.2024.10.07.19.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 19:56:44 -0700 (PDT)
Message-ID: <6fda5d7d-4214-460c-a727-9bb3382aa78f@redhat.com>
Date: Tue, 8 Oct 2024 12:56:36 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/11] arm64: Enable memory encrypt for Realms
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20241004144307.66199-1-steven.price@arm.com>
 <20241004144307.66199-10-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241004144307.66199-10-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/24 12:43 AM, Steven Price wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Use the memory encryption APIs to trigger a RSI call to request a
> transition between protected memory and shared memory (or vice versa)
> and updating the kernel's linear map of modified pages to flip the top
> bit of the IPA. This requires that block mappings are not used in the
> direct map for realm guests.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Co-developed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> Changes since v5:
>   * Added comments and a WARN() in realm_set_memory_{en,de}crypted() to
>     explain that memory is leaked if the transition fails. This means the
>     callers no longer need to provide their own WARN.
> Changed since v4:
>   * Reworked to use the new dispatcher for the mem_encrypt API
> Changes since v3:
>   * Provide pgprot_{de,en}crypted() macros
>   * Rename __set_memory_encrypted() to __set_memory_enc_dec() since it
>     both encrypts and decrypts.
> Changes since v2:
>   * Fix location of set_memory_{en,de}crypted() and export them.
>   * Break-before-make when changing the top bit of the IPA for
>     transitioning to/from shared.
> ---
>   arch/arm64/Kconfig                   |  3 +
>   arch/arm64/include/asm/mem_encrypt.h |  9 +++
>   arch/arm64/include/asm/pgtable.h     |  5 ++
>   arch/arm64/include/asm/set_memory.h  |  3 +
>   arch/arm64/kernel/rsi.c              | 16 +++++
>   arch/arm64/mm/pageattr.c             | 90 +++++++++++++++++++++++++++-
>   6 files changed, 123 insertions(+), 3 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>


