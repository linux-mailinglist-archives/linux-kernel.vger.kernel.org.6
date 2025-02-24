Return-Path: <linux-kernel+bounces-528734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4132DA41B96
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96D01894F66
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD62825744C;
	Mon, 24 Feb 2025 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mIO5vb/+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA0253342
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394164; cv=none; b=MhLyoDmAgQmDwyC1jasTBNgHf7A1e2CE8hij4Mvmq4MnvDGnkGG7F25iXQUajp1ElV67xA2Te5hMGl7cY4K8Q4c2oWcSqHJBs5lcVzpqRHXSXxRsz0uEacRPEqMMrI50UL3IMHUsqo6OiPV7misM3/t+5evEdvajQLTUBkkplBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394164; c=relaxed/simple;
	bh=O+3hc2uspzUuGySeq35PHHzR5JH/rChsfvYHdlzz6CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loz9zAPSsosd384ojrHFqTLZ93zUy2Y9SAxMSVp2VVhTqek7P561/0NT9fSdAyGvY+XUqBGYo4wyGgVnAUN/vp3kDT77PSTf5ZFu41rLBRKxHxRnSd3bdf/Of0LCxihdFYRb3uXenhlMLwc+eYvRzuW7dCVzanRxMp0L7e/PVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mIO5vb/+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb999658fbso541911666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740394161; x=1740998961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+3hc2uspzUuGySeq35PHHzR5JH/rChsfvYHdlzz6CY=;
        b=mIO5vb/+NY+ghdyJCROBKWXlgrOt9EFtnwud0yNzMEKqFPbp2XCPxfRemWP2+Phcv4
         LCrZjo84M63NUz7mEhosk09X9pDaI9tGjegudnstUubjox1DM7yxx3LHkLZloGADuPnh
         uMkH2dczKEdmE3jWJSncwJlfdLJ6Eu6vXWl4Iaj/Jk6IRSLefagOHszyi9oqp4wbAc80
         yIvL4yLo2q3MiHe/4elv1SZBysUNis6Jy+pJWjXAZn9wAntSLwKIaSOm28o+saK++0IM
         jZOThIWsHmNFO7zGYtO1u7A+Y6RnhkVyWAUFeSk32vloi/Iy3Ae+F8myv/5LIpv2PeUf
         dU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740394161; x=1740998961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+3hc2uspzUuGySeq35PHHzR5JH/rChsfvYHdlzz6CY=;
        b=wM2UY1fdjm82qEejAoztFrEJs5rwx47gdIxkyVmOA5ZBX00iiU6v9wpP/RaLqEumo9
         CKg1NibmhF2H0ZgVwrzM2tt9IcmJ7bcQABKwwYxYZTsZD9qiXFGjmiZqvi0cF4MZGMOt
         LGyNSz4ZW6Kb+pnND+HoJueEb9HyIhGJFBatk6MpktPo+gLryt7+PTNenY7o5jWFARvw
         t9rQ7OIZwYLGIk09dpG5xriHS6s8ajAZI5KHzYrVUMbDGzfJLlaDLbLrMnd02lMbkVWQ
         zS6lj6dTZzIxLXrjA2Q/625MOGj1uuSXNAxcJ8tEMAsaqSjNAdCqFtGDWGuufXsNuaPd
         YZug==
X-Forwarded-Encrypted: i=1; AJvYcCXV59E0pSSLqv3D8snfNoq5TZo2dImgi7yyUIrFYNDC8e5PqFP8tSSLeN677rO2xFnT4VBcANzngem7Naw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydNVNe2V9Y0PyQnVhrkzNRzYhX8S9Ii9fBLJb0qKPGMA/NlEzq
	NTfoSkGkZMoAdvdAgkiDZdxmxkXp/AstLAG+Bwb2CE222D4LOEBUB7vmZVvcGWtzoxjGYVzo3+G
	35hq/kAMEiR+QiekzAeKbGmcP+0Um2JCKcWM8tQ==
X-Gm-Gg: ASbGncs0Ma5N/JPFpK5uYqDbj4+lJujKroT0t08mPZOb93XnYlJS7CDWOJViEjTXA7k
	WbXz4/9pH/27JuI1K7zH/DVzTUgY4os7yaYSQsA/CLtaQrTCwZ8PdYjIAs7sj6lPmfBJfhikuNl
	lDViMMem0=
X-Google-Smtp-Source: AGHT+IHHpKWXIm/v2k+338UkHDIVLeb79WjMIsWoo/8r7lA3uc+V3rq9HglSj1eZuVQogWlVvckU5UsUcnUd6gUjF0M=
X-Received: by 2002:a05:6402:388c:b0:5e0:7cc4:ec57 with SMTP id
 4fb4d7f45d1cf-5e0b7266ba5mr26764777a12.31.1740394160578; Mon, 24 Feb 2025
 02:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <20250217140419.1702389-2-ryan.roberts@arm.com> <b6341aac-8d5e-435b-b900-5c9d321a7ce6@redhat.com>
In-Reply-To: <b6341aac-8d5e-435b-b900-5c9d321a7ce6@redhat.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 24 Feb 2025 11:49:09 +0100
X-Gm-Features: AWEUYZlGjIT4eI7eKQbJ3SHrGN78CEaD_5h64M0X3Xtov-A0DdsnodalQc20rYI
Message-ID: <CAHVXubjy+VmvmV7FLuR8y=bWc4MqKgoWp4R8hqUs8xKBN-DQcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Thu, Feb 20, 2025 at 10:46=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 17.02.25 15:04, Ryan Roberts wrote:
> > In order to fix a bug, arm64 needs to be told the size of the huge page
> > for which the huge_pte is being set in huge_ptep_get_and_clear().
>
> s/set/cleared/ ?
>
> > Provide for this by adding an `unsigned long sz` parameter to the
> > function. This follows the same pattern as huge_pte_clear() and
> > set_huge_pte_at().
> >
> > This commit makes the required interface modifications to the core mm a=
s
> > well as all arches that implement this function (arm64, loongarch, mips=
,
> > parisc, powerpc, riscv, s390, sparc). The actual arm64 bug will be fixe=
d
> > in a separate commit.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bi=
t")
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv

Thanks,

Alex

> > ---
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>

