Return-Path: <linux-kernel+bounces-179100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BB48C5BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C8D282651
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CCD181315;
	Tue, 14 May 2024 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfV27Ypb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D76144D0B
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715715102; cv=none; b=ktO8DVUdiJ4X7+vyRWMftXsiLp5bFcfbsrDhCWAjB+1PWyhHHkCimE196NPlmCuB4tgpEk/M6KkPugrz0m4SWNROAbcVX2SasXGVBaoqcBiLtGe7DkmNMrHfoVNQfSYpQ5tuXhq03TQrWAD+EHbEYdF7yOTLzKj3+6wyYzDjKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715715102; c=relaxed/simple;
	bh=Se3Ij8G283o4D8/qcripghOev92UNfpmzpuWpKYRLZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JoIF0axpthh6pErWonmKViFOIT1vN0gVoyo/2fXamdbN1yNw6nhYt5l2Pel5UeJ60Jh8Wq8K9MjCJX77jAhasA0zB3fiXLynuRxZ0pxZ7TMk1mI68JPOAeVVbYm7OzBcwoSmQcjW7YIrI579nzebBWFG9Hq4R5w+QIZuw0Ba++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfV27Ypb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FDBC2BD10;
	Tue, 14 May 2024 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715715101;
	bh=Se3Ij8G283o4D8/qcripghOev92UNfpmzpuWpKYRLZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DfV27Ypb9DUvKPmZ1am0CxQXDO+ouVeL4LJZgUYe35yJPaFRkBqmI5HGhUiUkGIp2
	 urZIW/6Hx1MHSOG9mF7TIWBpMaCVwfab/uUZZrdidwMqzJTbIopXD9/LNs7bEpS2M6
	 aceqBh5tXX79S+7rMaEQ2EuxSPz1VR+N230Of4BmNUBRMVELVeLgchHn5nsBWKqgqR
	 oVYDu3KUvODgxvR83K9SK/olDocN/FyKkuiFwoXguQvjVPxXE2tOrozgpT/lO2UqKo
	 YDSy0QwJbyejnaH4W02iFtelUOu9vl73PWhmYHqvSuALLfB/xyrHymtDRHKI0fhrEM
	 psIL73cdwNqBw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Andrew Bresticker <abrestic@rivosinc.com>, Chethan
 Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Oscar Salvador <osalvador@suse.de>, Santosh Mamila
 <santosh.mamila@catalinasystems.io>, Sivakumar Munnangi
 <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/8] riscv: mm: Add memory hotplugging support
In-Reply-To: <CAHVXubh8VpOmFqXrAN+G_Om-+6VjfeEyTRAFp8EWae3mFgjB=Q@mail.gmail.com>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-5-bjorn@kernel.org>
 <CAHVXubh8VpOmFqXrAN+G_Om-+6VjfeEyTRAFp8EWae3mFgjB=Q@mail.gmail.com>
Date: Tue, 14 May 2024 21:31:38 +0200
Message-ID: <87eda442cl.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> On Tue, May 14, 2024 at 4:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:

>> +int __ref arch_add_memory(int nid, u64 start, u64 size, struct mhp_para=
ms *params)
>> +{
>> +       int ret;
>> +
>> +       create_linear_mapping_range(start, start + size, 0, &params->pgp=
rot);
>> +       flush_tlb_all();
>> +       ret =3D __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT=
, params);
>> +       if (ret) {
>> +               remove_linear_mapping(start, size);
>> +               return ret;
>> +       }
>> +
>
> You need to flush the TLB here too since __add_pages() populates the
> page table with the new vmemmap mapping (only because riscv allows to
> cache invalid entries, I'll adapt this in my next version of Svvptc
> support).
>
>> +       max_pfn =3D PFN_UP(start + size);
>> +       max_low_pfn =3D max_pfn;
>> +       return 0;
>> +}
>> +
>> +void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *=
altmap)
>> +{
>> +       __remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap);
>> +       remove_linear_mapping(start, size);
>
> You need to flush the TLB here too.

I'll address all of the above in the next version. Thanks for reviewing
the series!


Bj=C3=B6rn

