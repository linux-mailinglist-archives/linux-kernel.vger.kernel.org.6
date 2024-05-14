Return-Path: <linux-kernel+bounces-179050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 914198C5AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21EA1C212EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5294C181BA6;
	Tue, 14 May 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u38RF5v7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA01180A63
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710630; cv=none; b=CWm0mulDZJ+SlgspCfZ9o4QGuI9P1njbYQ9pUMM4YBGZWgHmthf2x9ki/iPvh2Z0BD4KDFTaxJchsTN34ReB1HLP1dmafCd6GbvoX8jJ+48dMmBcQIdamwMGnD652/h43j9KUZhv8MS++auqwRVN8uqWoxcdk7pYMRrehX4DPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710630; c=relaxed/simple;
	bh=uzmplbv5D7iNpVC5UJ5KWf/1DYXGoJz78n4vD8h3RCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ekDAZ/V5QN1GVfa8bIiQKYbwop2zstMXVpWPp0nzhD1g+clGPjFfGm4Xsxdgnx0UjlqCcjf166lENIuconztGWSbUcM7jmJDr9aR2jfZ/sPEwRujtM8UBsC/bdiDmdxY894jtNFlfM9H7gDLoW72DioofVeeOor1I9EymUJf6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u38RF5v7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144BBC32782;
	Tue, 14 May 2024 18:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715710630;
	bh=uzmplbv5D7iNpVC5UJ5KWf/1DYXGoJz78n4vD8h3RCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=u38RF5v7U/Hj9CZLp1QiPYeERCnEJgoh07ZTr+NKJv4kYr6gTe+D0EMu11P6CY8WM
	 /VfOglY7oR6cehdaIV8d5RfRqP3YkvRPS6ZuFytkN9ntM2JD3fnW9WVcVZX+YPfn1s
	 V1JJgAkfMSmbtlqYqWLmuCpUHKlabxHwkmygy68bRl7MFYxLgZpGDfOSgKNIgHLLS6
	 mJphqO0rTj088VEgKiFLU+djfgj7UyrKYsvnbKp7uj9Pp5HYfONWTVRtwLk6i+/rs7
	 AKsfNR1dGyB4iibT2WBW09lq69oEBj3rFdo/HNilveyC2k1vfSie5VIQtaj4urzRoD
	 5YC3msP+vLJjQ==
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
Subject: Re: [PATCH v2 6/8] riscv: Enable memory hotplugging for RISC-V
In-Reply-To: <CAHVXubi6Hv_FCTi=a5FFoxqiUBucrX_NhVGBAWE6qXRXdzOYsA@mail.gmail.com>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-7-bjorn@kernel.org>
 <CAHVXubi6Hv_FCTi=a5FFoxqiUBucrX_NhVGBAWE6qXRXdzOYsA@mail.gmail.com>
Date: Tue, 14 May 2024 20:17:05 +0200
Message-ID: <87r0e4l0m6.fsf@all.your.base.are.belong.to.us>
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
>>
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
>> RISC-V.
>>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  arch/riscv/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 6bec1bce6586..b9398b64bb69 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -16,6 +16,8 @@ config RISCV
>>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>>         select ARCH_DMA_DEFAULT_COHERENT
>>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATI=
ON
>> +       select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && 64BIT && MMU
>
> I think this should be SPARSEMEM_VMEMMAP here.

Hmm, care to elaborate? I thought that was optional.

