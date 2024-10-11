Return-Path: <linux-kernel+bounces-360899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3BB99A123
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4D9B24ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775BA212623;
	Fri, 11 Oct 2024 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="FN6XZub1"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330FB210C25
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641884; cv=none; b=HIViLDrVYfE3zQpOCLWLo2mrsutFeQyhfp4bN9bxt8d+jmgDpCP2/jmeRjQ8iuaTkBIW94vuSuMNVIWJGSv7MiNKMs12kxawoGzqkXFC3qYH9cBR+lqXp2o1++IjtojHWrXtNuEmb5X8yMcNiYx8BTeYEYaOQu8bFJ39W74/8O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641884; c=relaxed/simple;
	bh=u8lwS3V134LGTgbww1Vx//46blD+q9XY0T76UJjP1LE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W98SLGaBjpsh0+HTwajghpxOYkJcVL8w7pVK2k0/2SrOccWmBYywCesp5wzeK6f/C3qV6No9zhH09/2CE1oAu+K11+WGscSb8UTgDC0Z1+HEE6k5eJuz38tzgAt6LjX0Icupfm5r7XDLNV43WPCdSsRQ7h7EvYbjR+3sNK9DYZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=FN6XZub1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1728641879;
	bh=Aow3TJ3nQrfV5JgcQs4n2GrgOqvsaJyLKOJ0CQrSIuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FN6XZub1+7a2gjiGz5Hf+T9MJ4IoX4p03XA5woNlICEXJ0lIeT2ixVvGPGFPX4sTs
	 Afe83MGI5VycnY9lLOLtoaiHTN3V7LG2mNWR5xP/sjqi52g5Cd5NwLTuf0Dze5iAyE
	 Qycm8kM71TNb8POMqtJQ4Qns8nKYmhGKGnBOmhzRhL7FzhbQU/7zNAUT+ENGK4rUkU
	 SVeBZW49JVuJhq4259LD1JuyLUMbr1IKsw/mmP3JjpLn6pKMSUoxzVj22cZgWvWAee
	 qe+u21ow9ReqFx/UQkCDPkmzEOJcicQwbEjhOZh/DK11BXHTLpHrjCH6aHgnCgI8+Z
	 aaPsRBeZOLu2g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XQ2d30BPSz4x89;
	Fri, 11 Oct 2024 21:17:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, Sourabh Jain <sourabhjain@linux.ibm.com>, Hari
 Bathini <hbathini@linux.ibm.com>, Zi Yan <ziy@nvidia.com>, David
 Hildenbrand <david@redhat.com>, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Aneesh
 Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom
 <donettom@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Sachin
 P Bappalige <sachinpb@linux.ibm.com>, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>
Subject: Re: [RFC v2 0/4] cma: powerpc fadump fixes
In-Reply-To: <cover.1728585512.git.ritesh.list@gmail.com>
References: <cover.1728585512.git.ritesh.list@gmail.com>
Date: Fri, 11 Oct 2024 21:17:57 +1100
Message-ID: <87zfnb54fe.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
> Please find the v2 of cma related powerpc fadump fixes.
>
> Patch-1 is a change in mm/cma.c to make sure we return an error if someone uses
> cma_init_reserved_mem() before the pageblock_order is initalized.
>
> I guess, it's best if Patch-1 goes via mm tree and since rest of the changes
> are powerpc fadump fixes hence those should go via powerpc tree. Right?

Yes I think that will work.

Because there's no actual dependency on patch 1, correct?

Let's see if the mm folks are happy with the approach, and if so you
should send patch 1 on its own, and patches 2-4 as a separate series.

Then I can take the series (2-4) as fixes, and patch 1 can go via the mm
tree (probably in next, not as a fix).

cheers

> v1 -> v2:
> =========
> 1. Review comments from David to call fadump_cma_init() after the
>    pageblock_order is initialized. Also to catch usages if someone tries
>    to call cma_init_reserved_mem() before pageblock_order is initialized.
>
> [v1]: https://lore.kernel.org/linuxppc-dev/c1e66d3e69c8d90988c02b84c79db5d9dd93f053.1728386179.git.ritesh.list@gmail.com/
>
> Ritesh Harjani (IBM) (4):
>   cma: Enforce non-zero pageblock_order during cma_init_reserved_mem()
>   fadump: Refactor and prepare fadump_cma_init for late init
>   fadump: Reserve page-aligned boot_memory_size during fadump_reserve_mem
>   fadump: Move fadump_cma_init to setup_arch() after initmem_init()
>
>  arch/powerpc/include/asm/fadump.h  |  7 ++++
>  arch/powerpc/kernel/fadump.c       | 55 +++++++++++++++---------------
>  arch/powerpc/kernel/setup-common.c |  6 ++--
>  mm/cma.c                           |  9 +++++
>  4 files changed, 48 insertions(+), 29 deletions(-)
>
> --
> 2.46.0

