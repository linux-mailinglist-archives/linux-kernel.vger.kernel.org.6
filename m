Return-Path: <linux-kernel+bounces-179465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5B68C603A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED70F1C20BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622DE3A1D7;
	Wed, 15 May 2024 05:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUVIDYBV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391D26ACE
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751711; cv=none; b=pA2D008wf1W5mKbsMlni3hzK6vQJoX+g1zdPFzxVMWPpdPTly0kPPnturrcVXMbMQ07NseICfNKUo4SSic7QXCCiU152ZB3LQKS61H06hsoSbJ3suP2hwwnlqxAymKrY+Yci+/PjHk81mN/yb7SyGTZb2F7FF1/Ja5ubDkrfWSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751711; c=relaxed/simple;
	bh=mmF1KeXBL7U8C83N3jzFBWR9OlDzinn1tPvhQxIcJoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AQ69orNUd7biuCMPNgfdYmyBHGgfpAwSR+cDPJDXUouNwiBwvDxG2ZAq+yDSyDfl8wd76xgLin3MQuRubsRUkUMHDAwkYYxg4MEM+vDZv6OkLtLPIN6x1NTHYBdhr6TkqOn8yFfn23Tj2K8GuEBDdax2uvWhGYMWiUOEhiRTl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUVIDYBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C70C116B1;
	Wed, 15 May 2024 05:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715751711;
	bh=mmF1KeXBL7U8C83N3jzFBWR9OlDzinn1tPvhQxIcJoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TUVIDYBV82kiQ+MFfP94+TJanOMTxDKNqpExsyY9WyUZ6gqtJJodG6QmXkZONJXu6
	 1aK0ScbFd5P7+OEvorRw1zak3jD3s7josaNFDIOSM+aAHbyC82x0oBfodS6bxHnsMy
	 FPKE6S+7j/+G3Dq8AJw8dGiJaHb175oVUGu0KEjaFR+ZTgHymuInC4OSeDzGTmIKVE
	 kc5kWNkFxUxTTMla+TmklOYF4jdwnWpSAE4BNWIi1Eg7XQX9dgykMF3lx348dpGUf3
	 91UIiOXPBMy79Wt/kYXkcI+Yx0xixEsVwhv5FjyfPazlBlTv79liNDyERSF+kyo5XH
	 uo2vBxfXbfz/g==
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
Subject: Re: [PATCH v2 4/8] riscv: mm: Add memory hotplugging support
In-Reply-To: <ZkPOaAUZrRWRGke0@localhost.localdomain>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-5-bjorn@kernel.org>
 <ZkPOaAUZrRWRGke0@localhost.localdomain>
Date: Wed, 15 May 2024 07:41:47 +0200
Message-ID: <87msork4x0.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Oscar Salvador <osalvador@suse.de> writes:

> On Tue, May 14, 2024 at 04:04:42PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> +static void __meminit free_vmemmap_storage(struct page *page, size_t si=
ze,
>> +					   struct vmem_altmap *altmap)
>> +{
>> +	if (altmap)
>> +		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
>> +	else
>> +		free_pages((unsigned long)page_address(page), get_order(size));
>
> David already pointed this out, but can check
> arch/x86/mm/init_64.c:free_pagetable().
>
> You will see that we have to do some magic for bootmem memory (DIMMs
> which were not hotplugged but already present)

Thank you!

>> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>> +void __ref vmemmap_free(unsigned long start, unsigned long end, struct =
vmem_altmap *altmap)
>> +{
>> +	remove_pgd_mapping(start, end, true, altmap);
>> +}
>> +#endif /* CONFIG_SPARSEMEM_VMEMMAP */
>> +#endif /* CONFIG_MEMORY_HOTPLUG */
>
> I will comment on the patch where you add support for hotplug and the
> dependency, but on a track in LSFMM today, we decided that most likely
> we will drop memory-hotplug support for !CONFIG_SPARSEMEM_VMEMMAP
> environments.
> So, since you are adding this plain fresh, please consider to tight the
> hotplug dependency to CONFIG_SPARSEMEM_VMEMMAP.
> As a bonus, you will only have to maintain one flavour of functions.

Ah, yeah, I saw it mentioned on the LSF/MM/BPF topics. Less is
definitely more -- I'll make the next version depend on
SPARSEMEM_VMEMMAP.


Bj=C3=B6rn

