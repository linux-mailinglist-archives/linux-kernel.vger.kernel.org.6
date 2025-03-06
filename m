Return-Path: <linux-kernel+bounces-548361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FD4A543E2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65AA188F0A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0DB1DA634;
	Thu,  6 Mar 2025 07:44:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C96184E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247077; cv=none; b=M5CHdsydI5PoEW00CVBeqvNfBOQeuV0AfPzwOM6qktjCSkbMCRfQGEMUyC2HruJB0fyarkrH5eNz1LGOdPE/nm4TsCYA820BazjCK9URNM5XX1F5yeYmtCbl5bC52vwyWT4gfE6MQzYRPIlcFWdQ23lbgspydUB7FC7XNQaT85I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247077; c=relaxed/simple;
	bh=r2T06Cy5PLAcGoW0/RTZ1qUoefsoaOi9ZAhoUZOgaI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZY1GJ/Zde7I0sPeAyHJdE1lzjJ29aX4BJKVi68gfqUkKDmdUd2cCfY4Cp9R+5A9RVZnbneVsb053HevaJzMGSNaCHa6B+TI4WemxKf5ClNdIJ9fkHjQ+Pk3Ox5RoNmhO7A+QuNvdhreVl5XnMHKE+KBbT5c+lxJrKj+/746lv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B8C9FEC;
	Wed,  5 Mar 2025 23:44:46 -0800 (PST)
Received: from [10.162.43.28] (K4MQJ0H1H2.blr.arm.com [10.162.43.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 414733F66E;
	Wed,  5 Mar 2025 23:44:28 -0800 (PST)
Message-ID: <ca1a6d9d-bc0e-4c3a-a9bf-da06801903e0@arm.com>
Date: Thu, 6 Mar 2025 13:14:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vma: Do not register private-anon mappings with
 khugepaged during mmap
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ryan.roberts@arm.com, anshuman.khandual@arm.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, david@redhat.com, willy@infradead.org,
 hughd@google.com, ziy@nvidia.com
References: <20250306063037.16299-1-dev.jain@arm.com>
 <20250305223856.bc1a0c90339cf0d353e8be34@linux-foundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250305223856.bc1a0c90339cf0d353e8be34@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/03/25 12:08 pm, Andrew Morton wrote:
> On Thu,  6 Mar 2025 12:00:37 +0530 Dev Jain <dev.jain@arm.com> wrote:
> 
>> We already are registering private-anon VMAs with khugepaged during fault
>> time, in do_huge_pmd_anonymous_page(). Commit "register suitable readonly
>> file vmas for khugepaged" moved the khugepaged registration logic from
>> shmem_mmap to the generic mmap path. Make this logic specific for non-anon
>> mappings.
> 
> Please fully describe the userspace-visible effects of this bug.

Apologies.

The userspace-visible effect should be this: khugepaged will 
unnecessarily scan mm's which haven't yet faulted in. Note that it won't 
actually collapse because all PTEs are none.

Now that I think about it, the mm is going to have a file VMA anyways 
during fork+exec, so the mm already gets registered during mmap due to 
the non-anon case (I *think*), so at least one of either the mmap 
registration or fault-time registration is redundant.

> 
>> Fixes: 613bec092fe7 ("mm: mmap: register suitable readonly file vmas for khugepaged")
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> 
> Thanks, I'll add cc:stable.


