Return-Path: <linux-kernel+bounces-282773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE9494E86D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8AD1C217AE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EB0168497;
	Mon, 12 Aug 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="l2z15q/6"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460A415443B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450972; cv=none; b=PKUL54wWeJ46MSBIXEHTHhujCoYGmDWUuFEeRuVdgzUnGYnQrICsDx2QR1WLlvMr6mFt+jUziu76XAdHYJCIaMhX4Q3Upx6xTI+LpNdnNdrpF2vOX09jYeSCrjBqMyCsjUjRmjUZRAJzSFfjSvt5CwjpeSp5WHQ/NSiZxiQn5Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450972; c=relaxed/simple;
	bh=TIyR7/yHqlM+QmqYZM+XQ5vodg9KzjfP4uRk2V69hZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZtiFLefnPYyxuCgsZrvCAMnfWtYnp6VqGjrcg+OjH0VyLo529mqCcf9+p0dB5Mvo97gYUNvWc1oTR7YWcG9E7B6Ij9nBOvSLeUjcvcQE1zRSfdrkAaHyweTfn8fmahvtKVb5PBXD+dJT8Ke0FYcb2/V+fID0j+uR+/56El4sW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=l2z15q/6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723450965;
	bh=lcfw1inZiY26WkBE9vW1bZ+oBgq6g2b1SX0NRq4RAIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=l2z15q/6MFaiN0srlNMCE+8oGe2oMoZxzhwu17NbZzqlb9LzO32+7q8FVs3jtv6V7
	 wMwKAMOM+md3aLWgR+0Rmnv55SnfOGDLDIMihj38Wbw84k65JXgNA+osN3HLkRU8xd
	 L67JYhVuK/ns6TwdyVghnDEocBLaqlBrT4MJapqAe0Uz17CbhjMl3rejRVje/GPmE/
	 rizyHwP1C0jeaxfQeglc7DWeVSTnl7HrLoK2dNz5L0/DGgZUIxrgi+TJnw5o+qw6tl
	 xTgafWQHN2xedeLcPf5KTMOnt+kKDBMGTXoGWEqBMdWa9ewfomKv7GJuB+bWS3+ier
	 gNKnC24MbmKiQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wj6vm6nX4z4x8M;
	Mon, 12 Aug 2024 18:22:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 christophe.leroy@csgroup.eu, jeffxu@chromium.org, jeffxu@google.com,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com,
 pedro.falcato@gmail.com
Subject: Re: [PATCH 1/4] mm: Add optional close() to struct vm_special_mapping
In-Reply-To: <shiq5v3jrmyi6ncwke7wgl76ojysgbhrchsk32q4lbx2hadqqc@kzyy2igem256>
References: <20240807124103.85644-1-mpe@ellerman.id.au>
 <shiq5v3jrmyi6ncwke7wgl76ojysgbhrchsk32q4lbx2hadqqc@kzyy2igem256>
Date: Mon, 12 Aug 2024 18:22:44 +1000
Message-ID: <87jzgm8817.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Liam R. Howlett" <Liam.Howlett@oracle.com> writes:
> * Michael Ellerman <mpe@ellerman.id.au> [240807 08:41]:
>> Add an optional close() callback to struct vm_special_mapping. It will
>> be used, by powerpc at least, to handle unmapping of the VDSO.
>> 
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  include/linux/mm_types.h | 2 ++
>>  mm/mmap.c                | 3 +++
>>  2 files changed, 5 insertions(+)
>> 
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 485424979254..ef32d87a3adc 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -1313,6 +1313,8 @@ struct vm_special_mapping {
>>  
>>  	int (*mremap)(const struct vm_special_mapping *sm,
>>  		     struct vm_area_struct *new_vma);
>
> nit: missing new line?

Ack.

>> +	void (*close)(const struct vm_special_mapping *sm,
>> +		      struct vm_area_struct *vma);
>>  };
>>  
>>  enum tlb_flush_reason {
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index d0dfc85b209b..24bd6aa9155c 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -3624,6 +3624,9 @@ static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
>>   */
>
> The above comment should probably be expanded to explain what this is
> about, or removed.

I expanded it slightly, happy for others to wordsmith it further.

>>  static void special_mapping_close(struct vm_area_struct *vma)
>>  {
>> +	const struct vm_special_mapping *sm = vma->vm_private_data;
>> +	if (sm->close)
>> +		sm->close(sm, vma);
>
> Right now we have the same sort of situation for mremap calls on
> special: we have a call to the specific vma mremap() function.
> ...
> So, are we missing an opportunity to avoid every arch having the same
> implementation here (that will evolve into random bugs existing in some
> archs for years before someone realises the cloned code wasn't fixed)?
> Do we already have a fix in ppc for the size checking that doesn't exist
> in the other archs in the case of mremap?

I took this as more of a meta comment/rant :)

Yes I agree the implementation should eventually be generic, but this series
is just about moving the existing powerpc behaviour from arch_unmap()
into this hook. 

cheers

