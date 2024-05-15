Return-Path: <linux-kernel+bounces-179464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 357938C6037
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA01D1F21768
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CF73B7AC;
	Wed, 15 May 2024 05:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca5UtmZX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D5C3B781
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751601; cv=none; b=neTQ4QwuVrB7Qy+R84lJYXF/c5PbXhrjl6xyFIl5PKxyTBe7ywgtRwra8DTLC8UVWRSBOL816GO/2aFH045HvCJd8OnYhSsXXc7iNMJJwmlP+3d2DO2qA0lpZBnauObJT7Gk5Cc4DYhkdFiGJKslPq5wCMSxDgni1gR4OREIe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751601; c=relaxed/simple;
	bh=qFeWv8GsFEP94NiH8hpu0MILQkrgqqI5f7XEUQ/bekw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tO/rwCV/aFKBXoXQdA8py/2fDsMuobx266UJgavcJh33g0XjLztoxu8Z9LyohLPR3f+Q2q3OxyeLPYoZvsorOJkAPgzEHcZ5zIrcmqurUCRgbu4r6u+Cpjf1z5LOsJaMc4yRUeAeZ/XH5+eJgREmVAVDvFKKCSS5qWd5iA7mXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca5UtmZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1DDC116B1;
	Wed, 15 May 2024 05:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715751600;
	bh=qFeWv8GsFEP94NiH8hpu0MILQkrgqqI5f7XEUQ/bekw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ca5UtmZXO0PHjPXUUdc+VZYnkPVpb5jib4ktCpzzV3ZhA546YhW9UHk5pBrTsB8fs
	 5OCudtSHCOl3d3tTP3zo7RdBrJ8iHRR/KdAfFY0cca7m/EF0pacW8X7Wpz3cWwdto7
	 QOq82dcN4g4o9WbzMkFB9Q12wjhuxcMlhN5k61iDy/Hdzzp2lWztAOY+rqK8b1NDji
	 7PoAKLqCS0xjrsOBxo4Pjl81GboukdaMGq7BdQUF1nz0FsP8sokZnjlqgS/O9SKSKy
	 ASyYdWBijdb1z+6/2VB4SVQs5vdkkYQlveAVRDdcnzToprQ2NzuYIZYWyPJQVwjBm2
	 +I5sghOxb1v1A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Albert Ou
 <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Andrew
 Bresticker <abrestic@rivosinc.com>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L
 <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/8] riscv: mm: Change attribute from __init to
 __meminit for page functions
In-Reply-To: <ZkPKazeHI4CENSP3@localhost.localdomain>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-3-bjorn@kernel.org>
 <ZkPKazeHI4CENSP3@localhost.localdomain>
Date: Wed, 15 May 2024 07:39:57 +0200
Message-ID: <87r0e3k502.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Oscar Salvador <osalvador@suse.de> writes:

> On Tue, May 14, 2024 at 04:04:40PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> Prepare for memory hotplugging support by changing from __init to
>> __meminit for the page table functions that are used by the upcoming
>> architecture specific callbacks.
>>=20
>> Changing the __init attribute to __meminit, avoids that the functions
>> are removed after init. The __meminit attribute makes sure the
>> functions are kept in the kernel text post init, but only if memory
>> hotplugging is enabled for the build.
>>=20
>> Also, make sure that the altmap parameter is properly passed on to
>> vmemmap_populate_hugepages().
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
>> +static void __meminit create_linear_mapping_range(phys_addr_t start, ph=
ys_addr_t end,
>> +						  uintptr_t fixed_map_size)
>>  {
>>  	phys_addr_t pa;
>>  	uintptr_t va, map_size;
>> @@ -1435,7 +1429,7 @@ int __meminit vmemmap_populate(unsigned long start=
, unsigned long end, int node,
>>  	 * memory hotplug, we are not able to update all the page tables with
>>  	 * the new PMDs.
>>  	 */
>> -	return vmemmap_populate_hugepages(start, end, node, NULL);
>> +	return vmemmap_populate_hugepages(start, end, node, altmap);
>
> I would have put this into a separate patch.

Thanks for the review, Oscar!

I'll split this up (also suggested by Alex!).


Cheers,
Bj=C3=B6rn

