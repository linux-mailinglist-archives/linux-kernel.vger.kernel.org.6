Return-Path: <linux-kernel+bounces-188315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F62A8CE071
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCB11F21FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585E6383A3;
	Fri, 24 May 2024 04:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="paD3jrKn"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C4528E3
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 04:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716526031; cv=none; b=F6K6GzhjRExtjRFPrE4nxz6JPUOo9GpEX1Zv5cWbz0qLl36OshaSQXSHrPe+UBap3eFWNTnRPs3gG6hFMM7q341RM5ihPUMNUyKnDwGl5/k941qC0ZFzTo90M/FZjRVeJKj+Ea+0T+bcsI0IXvKCtU1D9P6H1TezEb5ZYB3yNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716526031; c=relaxed/simple;
	bh=zxdXzL2PCMh6kiCv/XWG2AEF0zsaulh91lqpiueOgUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A8mWcRljtGCC6kvwg6WmUn9opuNiN3GFIZCC3Y8A+s7FntFth9JMxaqKPHpRyzjFJa8eCJZjgAyA/1cdx94vT3h9pIuV9LsWFBZakxiXaAc+HX+rQWYpCKAYThxZD5wnnjIy2qn4NgCMmCQdTDfa48f44c16ShViXkt+Jfnt1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=paD3jrKn; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716526018;
	bh=Lsx8n8TfdeBc5jT/DgUGbVF60hkQdqk58hk4W7Gj/N4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=paD3jrKnTyE62MX67uraqx0iJ6R9LHZwCYGsNl1DhIFk2hoURmUhHtaz+3v9Sqvd5
	 deSi032lPBUkourOaqJRLGrgE32hFS1nP6wHE4+18GamlqWCJVbSwlrkL+AGHGusvf
	 5gouHmpmhQv7AUf7GHkbT7mbExy4oNYoD974jskemhyOHLpbkllkMfTgOgZh2iyX+3
	 qWo4Fi/F7Sdh5TyeuSoonwnWaFMBSxiD4o7TbkUXaK0EVOgt8XZub99BKk7WiGy1mJ
	 fLXfaHMdWTevEcy6BdGIhd5cA27GUnBT5pPzLBD3hSoKMkpz5VNC8FIj6/wGOYvLcN
	 tijBRbbBEo2jA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vlsvk2vflz4wcR;
	Fri, 24 May 2024 14:46:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Xu <peterx@redhat.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Oscar Salvador <osalvador@suse.de>, Nicholas Piggin
 <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 00/20] Reimplement huge pages without hugepd on
 powerpc (8xx, e500, book3s/64)
In-Reply-To: <Zk-bpBZ_yjsj_B2z@x1n>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <Zk-bpBZ_yjsj_B2z@x1n>
Date: Fri, 24 May 2024 14:46:58 +1000
Message-ID: <87jzjj4y0t.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Peter,

Peter Xu <peterx@redhat.com> writes:
> On Fri, May 17, 2024 at 08:59:54PM +0200, Christophe Leroy wrote:
>> This is the continuation of the RFC v1 series "Reimplement huge pages
>> without hugepd on powerpc 8xx". It now get rid of hugepd completely
>> after handling also e500 and book3s/64
>> 
>> Unlike most architectures, powerpc 8xx HW requires a two-level
>> pagetable topology for all page sizes. So a leaf PMD-contig approach
>> is not feasible as such.
...
>
> Great to see this series, thanks again Christophe.
>
> I requested for help on the lsfmm hugetlb unification session, but
> unfortunately I don't think there were Power people around.. I'd like to
> request help from Power developers again here on the list: it will be very
> appreciated if you can help have a look at this series.

Christophe is a powerpc developer :)

I'll help where I can, but I don't know the hugepd code that well, I've
never really worked on it before. Nick will hopefully also be able to
help, he at least knows mm better than me, but he also has other work.

Hopefully we can make this series work, and replace hugepd. But if we
can't make that work then there is the possibility of just dropping
support for 16M/16G pages with HPT/4K pages.

> It's a direct dependent work to the hugetlb refactoring that we'll be
> working on, while it looks like the hugetlb refactoring is something the
> community as a whole would like to see in the near future.
>
> We don't want to add more Power-only CONFIG_ARCH_HAS_HUGEPD checks for
> hugetlb in any new code.

Yes I understand.

cheers

