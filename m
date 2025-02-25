Return-Path: <linux-kernel+bounces-531975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF70A44755
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F52867516
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE87E18DB38;
	Tue, 25 Feb 2025 16:58:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C1D21ABC4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502707; cv=none; b=mL59vLv8FlQBSUjrdJrT+PXP/SimFwVhkUamkDjulkyNLnR24dy40kOEGsIf9PKd3qG8eqCS33ULggXEHgy2wNxNq0dndLIvlr0QXUb3+7r7maWja0d7bqFWPa/h5QnK30nspZddqQkbe6oEjuLwVHjeCmFCYWPUy5M1OLxjgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502707; c=relaxed/simple;
	bh=S4VAtKxcYi0QKLp35ve2vYkp97o5Asnl+7BlscWqOsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfZaTX5NxNVVOKUhaYs3M1xM9ycNiu6gW7N+jDUqPAFn8RKky78qBJ+87RKbrjXGT+rMnOyzZFxTzMJXniTUpIbaKC/nsEKcjsQR4AwXcpknqiSOw+nzeRkRp3hHmOvlfOtTt2ijXixk3iF8stLWFaKqBIv6Os+Miw21+E3UA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A21961BCB;
	Tue, 25 Feb 2025 08:58:41 -0800 (PST)
Received: from [10.1.27.154] (XHFQ2J9959.cambridge.arm.com [10.1.27.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 539A53F5A1;
	Tue, 25 Feb 2025 08:58:23 -0800 (PST)
Message-ID: <a734d321-c839-498b-ac5d-2e9ab5355cff@arm.com>
Date: Tue, 25 Feb 2025 16:58:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] mm/vmalloc: Batch arch_sync_kernel_mappings()
 more efficiently
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-12-ryan.roberts@arm.com> <Z73jrWlV5X9senZw@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z73jrWlV5X9senZw@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/02/2025 15:37, Catalin Marinas wrote:
> On Mon, Feb 17, 2025 at 02:08:03PM +0000, Ryan Roberts wrote:
>> When page_shift is greater than PAGE_SIZE, __vmap_pages_range_noflush()
> 
> s/PAGE_SIZE/PAGE_SHIFT/
> 
> Otherwise it looks fine.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

