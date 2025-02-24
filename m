Return-Path: <linux-kernel+bounces-528993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A847A41EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24857161B99
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EF42571C3;
	Mon, 24 Feb 2025 12:13:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD8F2571A7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399214; cv=none; b=mZHrgJgUFcvIuzioLlzJ8h2aSZ3o55XHid2QaLe8z+Dy3dsUKG5Yp807ZhKPhLc+g+4P5Q/Ydlcop8MHWOZQrddsVZZwEwWGMR9Vkh0DH6WEgG90kj+Rd4DRVaqgMccYT/k7s7DGZVPBN5tKw8C5XqJbJcYqhtXL7Iy7KybEAwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399214; c=relaxed/simple;
	bh=vjC/h8Z3iv7wFZ/G0WFZniTbYH3M8TBQUzKGM802XrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoL+CV42+HOvMAt/sF3GghiNv8cUUifk8OuP2kHsNbuo1BRkQWCURZQVYQ12mvIqVBa9kKTxVFKOEHJVvjEgkGqKTyihX+Yr+wJl3mvvAhKTMIiltgvNxhoJ9sQnTVxEuohB5ZXV0HdZQgN0s5CVvbYu4yAgHmIbDv+BYgPhUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF6111756;
	Mon, 24 Feb 2025 04:13:48 -0800 (PST)
Received: from [10.1.27.150] (XHFQ2J9959.cambridge.arm.com [10.1.27.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391C13F6A8;
	Mon, 24 Feb 2025 04:13:27 -0800 (PST)
Message-ID: <e4b5f389-e3c6-48f5-8d13-a4a6f364fd92@arm.com>
Date: Mon, 24 Feb 2025 12:13:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Fixes for hugetlb and vmalloc on arm64
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Dev Jain <dev.jain@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <Z7YsqO7ykGgcBFEI@arm.com> <20250221153501.GD20567@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250221153501.GD20567@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2025 15:35, Will Deacon wrote:
> On Wed, Feb 19, 2025 at 07:10:32PM +0000, Catalin Marinas wrote:
>> Will, Ryan,
>>
>> On Mon, Feb 17, 2025 at 02:04:13PM +0000, Ryan Roberts wrote:
>>> This series contains some fixes for hugetlb on arm64, and is split out from v1
>>> of a wider series at [1]. While the last patch is technically targetting core-mm
>>> and is not directly related to arm64, I'd like to to go via the arm64 tree so
>>> that the wider performance improvement series (v2 to be posted shortly) that
>>> depends on this series doesn't have to be robust to the fix not being present.
>>>
>>> I've included maintainers/reviewers for all the arches that are (trivially)
>>> touched due to the API changes, hoping for some ACKs.
>>
>> These fixes look fine to me and I think we should get them in for 6.14.
>> I think Andrew was ok with them going in via the arm64 tree:
>>
>> https://lore.kernel.org/linux-arm-kernel/20250205235219.3c3a4b968087d1386d708b04@linux-foundation.org/
> 
> I think the diffstat looks worse than it really is, as the arch changes
> are reasonably mechanical. I'd like to let it sit in next for a few days
> though, so I'll pick this up once we've resolved my comment on patch #2.

Sounds good to me; if you're happy with my proposal in the patch 2 thread, then
I'll respin.

> 
> Ryan -- did you find all of these issues by inspection, or are you aware
> of anybody hitting them in practice?

All by inspection. So I guess they are not urgent to fix from that perspective.

> 
> Will


