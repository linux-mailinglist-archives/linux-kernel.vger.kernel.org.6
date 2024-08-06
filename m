Return-Path: <linux-kernel+bounces-276770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477D294982E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EC51F23364
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830FC146A6D;
	Tue,  6 Aug 2024 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SqXCxba7"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7188047F4D;
	Tue,  6 Aug 2024 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972283; cv=none; b=RVnDXwYA1QOhmK5PvXN5tPZS8Fe8/vBGHygwfpCoJ0UHoyP+FQ5Pl+fRhb5VA45BHTRmcHmT8JtaFOkdZCq0O4SKhY2XU2jruRTYyMM9oiEEXVhckejIjr4EEQw7NklanytnFE+jNjpa5SHtcAbzS0SgSno3R82+LMyLJ6nNcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972283; c=relaxed/simple;
	bh=lx4SKSYG9IQt/tT0YU0rp35SXnpgN8Tt+kd6Z8utk2I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BiPhH57Nw+c5abNujH3Vt1e6PMnnO/5zmbTe5DdT8+dNeMA77imlTzLrQ4JekjN+AIDBzR18X2m7A8qvM1LKAAgDkdazat62ZRFGpaxdoYUOPrbP/6nd16CVOo2+Eekyq9rbd7v2GTh51sqjoA+6eGKf1S8b+0gieAZM8aXQnXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SqXCxba7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.49.54] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8018920B7165;
	Tue,  6 Aug 2024 12:24:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8018920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722972281;
	bh=Qbx96xFbGoYdTWGhHn3B+cy2pNWGVzfzN21Xqhn+OSk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=SqXCxba7R3fhOrXQIUZw3R4WO4OkqLSq0ky5wLl6zBu3kxtU4lSB7e0xih8mApH5E
	 sCdfu13aveEjfkIQ9CMyGkjBs7+EvZF46Gr4HZ5p1dckvpOkNliR0kW2lXLKpCg8Km
	 1KUtVl+grJYw+dT7Ck7tx9MIrgOovUzrlSZqbCI4=
Message-ID: <389da90e-df78-4ea4-8453-ae2080a68956@linux.microsoft.com>
Date: Tue, 6 Aug 2024 12:24:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@rivosinc.com, Lu Baolu <baolu.lu@linux.intel.com>,
 Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v8 7/7] iommu/riscv: Paging domain support
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1718388908.git.tjeznach@rivosinc.com>
 <bdd1e0547e01d012bf40c5e33b752e77c6663c90.1718388909.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <bdd1e0547e01d012bf40c5e33b752e77c6663c90.1718388909.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/14/2024 10:27 PM, Tomasz Jeznach wrote:
> Introduce first-stage address translation support.
> 
> Page table configured by the IOMMU driver will use the highest mode
> implemented by the hardware, unless not known at the domain allocation
> time falling back to the CPU’s MMU page mode.
> 
> This change introduces IOTINVAL.VMA command, required to invalidate
> any cached IOATC entries after mapping is updated and/or removed from
> the paging domain.  Invalidations for the non-leaf page entries use
> IOTINVAL for all addresses assigned to the protection domain for
> hardware not supporting more granular non-leaf page table cache
> invalidations.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/riscv/iommu.c | 642 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 639 insertions(+), 3 deletions(-)
> 

> @@ -856,7 +1473,7 @@ static struct iommu_domain riscv_iommu_identity_domain = {
>  
>  static int riscv_iommu_device_domain_type(struct device *dev)
>  {
> -	return IOMMU_DOMAIN_IDENTITY;
> +	return 0;
>  }

<snip>
Sorry for the drive by comment, I just happen to be in the nearby code
context.

Nit: It may be better to use IOMMU_DOMAIN_BLOCKED here for readability
rather than the bare value.

Thanks,
Easwar

