Return-Path: <linux-kernel+bounces-526351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C34A3FD91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A9F189B427
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8922505D2;
	Fri, 21 Feb 2025 17:37:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654102505C9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159429; cv=none; b=CpJKyxWcgE6AbAcZUHD3kqMEzBGYefJPw7EmG5G/APlKEYhajArXWFJghxSY9hCcyVwspvSJ7ZM6zQEJ9mGPOlJYmhtUap7VGLb2pIWSKgbCvPc+QuXqI68k8e504b81Jo9YLbJM/R6JmUNYnHCGUUw7C0/3VYidyni8+0a6GQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159429; c=relaxed/simple;
	bh=SM/0S75aqELInpwNA95plCPb2mbTtRI/VcjLtQaJuOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLPyQL1Ynh4B66ItWFS7N832wLcddoj8Y5QwqYkDQoJTZEtVyhIhebWgJKsDNbyPjDs8AYYAe56puNltwVnGt1HebQHj2XxiInofUiyTQv0TnCedm/keB3fs7knn9TEynugLtulePzYdxGv70LI6AvNXVtfETUn0cbjtakFhrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E1151063;
	Fri, 21 Feb 2025 09:37:25 -0800 (PST)
Received: from [10.163.38.241] (unknown [10.163.38.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E66F13F5A1;
	Fri, 21 Feb 2025 09:37:04 -0800 (PST)
Message-ID: <0c251bd0-88b7-4df0-bc53-333d16008ab8@arm.com>
Date: Fri, 21 Feb 2025 23:07:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64/mm/hotplug: Drop redundant [pgd|p4d]_present()
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
References: <20250221094449.1188427-1-anshuman.khandual@arm.com>
 <20250221094449.1188427-2-anshuman.khandual@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250221094449.1188427-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/02/25 3:14 pm, Anshuman Khandual wrote:
> [pgd|p4d]_present() are inverse to their corresponding [pgd|p4d]_none(). So
> [pgd|p4d]_present() test right after corresponding [pgd|p4d]_none() inverse
> test does not make sense. Hence just drop these redundant checks.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

LGTM

Reviewed-by: Dev Jain <dev.jain@arm.com>


