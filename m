Return-Path: <linux-kernel+bounces-537629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBDAA48E50
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB5E188BB2E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C94513CFB6;
	Fri, 28 Feb 2025 02:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kok/v3L6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C7125B2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708549; cv=none; b=pFRBmIOurio7LzoVRKrunAq+gUlqbfEI+VToYqRWqgOvelFyu8JFO+oO5mGN4qdpZ8QaEb5l0YxLF3nbJqvuAU8PzIXQ5fmlW5EQn/IXJoOGel955Mquq6rNP6jVjaTUmNfGhV95NSSZdwo9PHyr4Y80qz5ceSqp0xNnb1a6+NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708549; c=relaxed/simple;
	bh=FeINGRLknlP5dt3tCP0bSzZ/i8BVmEOimAwyc+VvazU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0Dn6stvH/bkMXjFW/fLRWbWaqFkVJN5xfBDtdFh3Et2U0e9zgXeNfO0ZTViiqLDxQD54YzSyRFrpJnDksa06zWiSQ0KaYRlRNZpezIUOKCTaXGJjMtI1/Wa2SyrdIP3VneruZ+cseLXldjP+OUOqRvthOzhPQVQhfXMNySK3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kok/v3L6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740708546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDA8ZdJRcIn7ES0nC9Xy5c+VwiJPVKulN1nVpxhKFD8=;
	b=Kok/v3L6WKH2z1hE1LxjIqBN+FM1q5zVahGHmSpN4AtO7f7cATNugg3Lvdm1625IH9C1IC
	5WF5tq1g3FRvIu9xcEduyNwA3OpABU2AbZ+hBzDMLTQW8wB8q4YECSGGv3kHL6AEh8Y/dr
	77TdTt5YAJcPdQDqUQx/kvrwokICO58=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-mfTjEe20McayhuufSuP-Rw-1; Thu, 27 Feb 2025 21:08:59 -0500
X-MC-Unique: mfTjEe20McayhuufSuP-Rw-1
X-Mimecast-MFC-AGG-ID: mfTjEe20McayhuufSuP-Rw_1740708533
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22331df540aso47645115ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740708533; x=1741313333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDA8ZdJRcIn7ES0nC9Xy5c+VwiJPVKulN1nVpxhKFD8=;
        b=sMhx81PRqY/wpEhwz/kf6DEp1hsbTAVmwRx0hkN1GJymKpj5rspFtVQi36CKKzWigC
         itvYD+ABJ2HJYQKuWr0rnoMVXYQKUAq92Lfqmt3vFobVc0oua9BvbEosysTIsC0WwnCf
         /VK9oC8CyyCKqAQEcIPV4qkKszyYdcB+fcYIGrvYT7DtxL861lgEbxmTMfarWxhntwzf
         CexqnnrY5mVTibtX0SoQeJEbmzynuvAwKehKmEiCucEemenvsaMT/QMvDWk8rS4qunjl
         KM3wvHWY5VXyrvQFqHQ0g5U0e/w2fS+Px/96ICo5R78zqF+SzRvq9IHsOBcjj4UOhWeQ
         fdIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH0X6/743R/QHODqiM9m200+b8wej9yIjSJJJ4w7aOplCg3abMu8EjorlP4cvC5HVZ7CU1/qzZVm2O91c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9P2nHtC7zgLrsb+0E9JThkdpjcPwvWWXEqRGWU+KMNVTmGIzZ
	21gawDpDp68PBe2lfcXwAYF0tYuL39BXCMonxR61mPAgOZYbPT+XObVolOmgLcbmjItjXqnZse3
	/gvyDA0k0+z2kae6NH5HdTrMiemO/A9UTcgj5CW4oCb1mo5Ti2zNjxrXAUCKU/w==
X-Gm-Gg: ASbGncvzFvcp0WmssGoBMbHV/y8mqsowk7TWf4I2S285BU+4f/G75cokVGk4tGh3KF0
	KyULYZ+SnpoZRbekYW8tGZk0s73qqWsXNVZsmbNr+4/7y1G4vWc5VEZl3E61VPg6BNvT8jHOhcH
	nBGHnwZ9HQ/qZPiWLHTJzITXqMU3nd+hvP+5AO91m0Os8IYJ2ImZWs9lz1OMUG9hrGahcezjImJ
	OzcLHUg6bDimH1D/zXxo2GkpRDC5dsCMNYH6fN+G4JyHVkIJRp5cZU2WVykqccWCFWCKSRj5ch0
	W1W3Mm7j+Py+2UjTAA==
X-Received: by 2002:a17:903:fae:b0:223:674d:c989 with SMTP id d9443c01a7336-223692585fbmr22521225ad.41.1740708533545;
        Thu, 27 Feb 2025 18:08:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu9ARko1SYR5EXP3Bd9fWGTG0mutlK4ufDD7+7kHYr1uaxFIPvIaHW+HuHlgORm9NSM1R2nQ==
X-Received: by 2002:a17:903:fae:b0:223:674d:c989 with SMTP id d9443c01a7336-223692585fbmr22520815ad.41.1740708533178;
        Thu, 27 Feb 2025 18:08:53 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc3b7sm22723325ad.173.2025.02.27.18.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 18:08:52 -0800 (PST)
Message-ID: <6ae2b809-7cc6-471b-9065-be446411570b@redhat.com>
Date: Fri, 28 Feb 2025 12:08:47 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dma: Fix encryption bit clearing for dma_to_phys
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-kernel@vger.kernel.org
Cc: will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20250227144150.1667735-1-suzuki.poulose@arm.com>
 <20250227144150.1667735-2-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250227144150.1667735-2-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 12:41 AM, Suzuki K Poulose wrote:
> phys_to_dma() sets the encryption bit on the translated DMA address. But
> dma_to_phys() clears the encryption bit after it has been translated back
> to the physical address, which could fail if the device uses DMA ranges.
> 
> AMD SME doesn't use the DMA ranges and thus this is harmless. But as we
> are about to add support for other architectures, let us fix this.
> 
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Link: https://lkml.kernel.org/r/yq5amsen9stc.fsf@kernel.org
> Cc: Will Deacon <will@kernel.org>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   include/linux/dma-direct.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>


