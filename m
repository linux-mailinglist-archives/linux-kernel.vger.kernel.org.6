Return-Path: <linux-kernel+bounces-282777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF2C94E879
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925181C217C3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC63316C85E;
	Mon, 12 Aug 2024 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="GLLPI1hd"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022416C84D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451001; cv=none; b=DtZkol/uF0u15z88jWOGqp2CS6lAvMPKNpP04d3FEc5f+/f4zHlqRWxoDhzSR9NMisahvgPKThXVkAW/iW/nionpsrh9zqkWkJSV9rzejFZoKChoPeA7vfkYuQhwDs8VQhAad1c2Cfta5XpOifOVtCVI5MitrxKJFibFoWI63Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451001; c=relaxed/simple;
	bh=aY0KQUuA6Pmd/5AZE/dDtIa4VZMCD57YXtBTpddeWwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PKjQivvFTZQ9pa3+BxXT9V8ytgoUlt1N0PgakJbMWylA+qavyqd+2KWOCDUCNkWcC07h3GjroJtDZLeAW8lhGaydbQAqV1RSPoYO7AhNv+sUYbFJMlB92kLjf2JPA64F1YumsSP7qyklZXXOmDahRMOT1N/KpixY2blr/yrPHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=GLLPI1hd; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723450997;
	bh=SjGutqBaqZgjd7wqw4U0lQPoWxYx0nIAM9EvIIKTQn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GLLPI1hdFzEgX6nkjZVe0VO4bsQo5bRJxASR4AK5UZ78M88a8/LssElM6PKMmC3FK
	 3FHQdyReAjWheTxnqGT7t23bQ0IBRdlmv3TBpQ5DDHq933iufgF1u6FN/ZQi/IJb0k
	 ZriXOcGwHS/ejpyF93YpxnyuPukCO5sKBRmscjuW1gUsHB3jNWQ8Ci7RQcAJlxli5b
	 FhqIqopot8q2+bt3mhtybarzrcFDpJHuovtkTSIESV0VBicL5JyqQ/SNWk6LBn6nEy
	 DRQi1jZIQQfXwfvWWRqP6SHKC/92pw7L6xPhGF3AmFbQTsrtjzZqJytysn/t714aRR
	 k4UxPTtzp1goQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wj6wP2FB2z4x8M;
	Mon, 12 Aug 2024 18:23:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linuxppc-dev@lists.ozlabs.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, christophe.leroy@csgroup.eu,
 jeffxu@chromium.org, jeffxu@google.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com,
 pedro.falcato@gmail.com
Subject: Re: [PATCH 1/4] mm: Add optional close() to struct vm_special_mapping
In-Reply-To: <1b0e07fb-33fb-4397-b03e-65698601bc70@redhat.com>
References: <20240807124103.85644-1-mpe@ellerman.id.au>
 <1b0e07fb-33fb-4397-b03e-65698601bc70@redhat.com>
Date: Mon, 12 Aug 2024 18:23:16 +1000
Message-ID: <87h6bq880b.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Hildenbrand <david@redhat.com> writes:
> On 07.08.24 14:41, Michael Ellerman wrote:
>> Add an optional close() callback to struct vm_special_mapping. It will
>> be used, by powerpc at least, to handle unmapping of the VDSO.
>> 
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>   include/linux/mm_types.h | 2 ++
>>   mm/mmap.c                | 3 +++
>>   2 files changed, 5 insertions(+)
>> 
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index d0dfc85b209b..24bd6aa9155c 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -3624,6 +3624,9 @@ static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
>>    */
>>   static void special_mapping_close(struct vm_area_struct *vma)
>>   {
>> +	const struct vm_special_mapping *sm = vma->vm_private_data;
>
> I'm old-fashioned, I enjoy an empty line here ;)

Ack.

>> +	if (sm->close)
>> +		sm->close(sm, vma);
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks.

cheers

