Return-Path: <linux-kernel+bounces-354400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBA6993D10
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BDC1C21F0D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270B2AE77;
	Tue,  8 Oct 2024 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8R8Kn7x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58431EA85
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728355894; cv=none; b=AnywMiVdKES6NatO4ykIwz3WfwQC0YlU6sF/rK/9CBb8aTdPjwZOpuETgJxDw/9AOxhq5ptRBEane3UFVGB4ks4X8AjwpqK8AXsRK04DOBUPjxBbl9f4Dzu8FEuSOx8Xrh93D4hmeXuj/qua8AIF9VDpuOQ/jUdHH3VWbKXz6rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728355894; c=relaxed/simple;
	bh=fLMDCQsubowFDRbzB3GNMUKP1kvwbKmtntwMRelY1Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYsYudko/4NZaRe5XADvrxMu5hCD8Xub9mzO5SxiSrZD13veF4WM3rXMgPAtPsXTIg+oIjots6KDrP98pRzoLHNdEB67+huwf6p1hubDeYCsCjz1ADOF7cvXjFv9aTfFb+YoxcB8/ziqvvH09IRXKWKmVlO1qUBR32ZUU7BFXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8R8Kn7x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728355891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4sFhYYgaf5zWGjjw37V+FmIhrEBzr4NtQ/62b1VBOU=;
	b=R8R8Kn7x6EhOW6Hb0s80a82qjl59Gj09uAMIIiOQ/uxyoMLheWrYs1it3dJHjO9aW58WT3
	U0pNqnO2F26ypbcEWMz6lagVEUVbDoA5PTx+nw3TX9ACefjrP0n3K/thrfP17K+etjL6gv
	z441CipZ2jF3Rqd4V1VH2K9ppTHhv30=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-LXHGr7v-NlK8-QbT2n1pJQ-1; Mon, 07 Oct 2024 22:51:30 -0400
X-MC-Unique: LXHGr7v-NlK8-QbT2n1pJQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e18a72bf94so6850373a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 19:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728355889; x=1728960689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4sFhYYgaf5zWGjjw37V+FmIhrEBzr4NtQ/62b1VBOU=;
        b=g0qI9P+oxPtpKhNj2TsLSsQyNxslExWPypD+HrU7Iq6X7p240P/mbn/+aJQaxW64BW
         ieeWdSmCEtOzVGhZ8AZkWA901A5lXCujts8hHOwvCzJF2XkH9DwI7/id67L48c+LrVFN
         TKz9OF/bdVkLkRmXjHbv/9BMnqfbAPcfiD/kfw5eUsGkfWQ90ujmlRrWT2EyFwls85Ka
         zeS5OCbsuENfOZN3tLC98FNLM9wsFYBUbBLHd0mJ21EXzaPfrF2Q0XPl0oKupqURlJa7
         NytL4UurKszabVY6z0hVHKC1CvpwBBIy6jDkS+U4BeGtXGSQhEPKwBZtUJ+51r6Jolrw
         5cfw==
X-Forwarded-Encrypted: i=1; AJvYcCVgarS14Ms+XU1i95/k/GVVUqHhrCtThVL/IRIyWGCEKZ4UwTSBgC14+G8jEpboncai5Gm3rcWme64ZH+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNBIBKL8gx1kJoYckVLEXMGLuf9VOJljWWEvla+TbnVrF5l1w
	AwzJRjVS5/7PWh2Set73sbEciS/FPYZAC8sq2IX3cPXyyU126cVl6+ueCIiHZ3qZSqJcA8piJ9A
	GOs89c5jVUVyv7VNrgONMojjWF1d8CSRGn0eIrx/uGMmfR/C4wTv26ngIJqJ1aQ==
X-Received: by 2002:a17:90a:3d81:b0:2d8:8d60:a198 with SMTP id 98e67ed59e1d1-2e1e6366bd6mr19154107a91.37.1728355888979;
        Mon, 07 Oct 2024 19:51:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1a155oDsYUskhbrb04GQtySwR7IiTCMTLOrXqEs3PGt+CLIahMwaNAu0NiGjx/qhM6odUKA==
X-Received: by 2002:a17:90a:3d81:b0:2d8:8d60:a198 with SMTP id 98e67ed59e1d1-2e1e6366bd6mr19154081a91.37.1728355888658;
        Mon, 07 Oct 2024 19:51:28 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f9c7csm6264516a91.38.2024.10.07.19.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 19:51:28 -0700 (PDT)
Message-ID: <01f08a52-3b96-4384-b9cf-aa74ea1d5faf@redhat.com>
Date: Tue, 8 Oct 2024 12:51:20 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/11] arm64: Enforce bounce buffers for realm DMA
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
 <20241004144307.66199-8-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241004144307.66199-8-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/24 12:43 AM, Steven Price wrote:
> Within a realm guest it's not possible for a device emulated by the VMM
> to access arbitrary guest memory. So force the use of bounce buffers to
> ensure that the memory the emulated devices are accessing is in memory
> which is explicitly shared with the host.
> 
> This adds a call to swiotlb_update_mem_attributes() which calls
> set_memory_decrypted() to ensure the bounce buffer memory is shared with
> the host. For non-realm guests or hosts this is a no-op.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> v3: Simplify mem_init() by using a 'flags' variable.
> ---
>   arch/arm64/kernel/rsi.c |  1 +
>   arch/arm64/mm/init.c    | 10 +++++++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


