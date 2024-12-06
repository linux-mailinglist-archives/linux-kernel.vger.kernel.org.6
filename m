Return-Path: <linux-kernel+bounces-435479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A599E785E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3620016D20D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E541D5ADD;
	Fri,  6 Dec 2024 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBs8JEGt"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8A7194A63
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510947; cv=none; b=eYFe1AzIOJ7H8URu+dFEd9k9O0YQksQzKX8esaiAhKCaNPwwHs7lNOuH+SWQs0C1yOwM0E8uh4yrBotrU46yc8tw0xzMQLNGyODWwlaDxRuNHQ4h0AYJ9Rvsi1pBYR5ZmHRHt1wfUGYwQjlFVtCs4erMe55onrrvdYLwwQ1SaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510947; c=relaxed/simple;
	bh=i6dDmxl6sZ0ioAnQJbf8X/EZv9XQ9Ern4yzl29wBPYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twUq8UpAQr5r+kBn14IP5QI2svwHB09Bd/triokpSWj4OR9s1sAd2q8wr7fovbV7teFKa3fq7KIB1XayIQRKxkcI0orHdIjgxqfIAf2GoAWAxLt7vLZ/n9TmFRP2MD4wG1FtLmRhuynYG758IwuHNz0hMlCSf83g+G+wsrQEj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBs8JEGt; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4afd56903b7so192057137.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 10:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733510944; x=1734115744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDe94JiUBLyj5M0Nz9phYsYy6Pis/1/rK91oYvpIJPc=;
        b=MBs8JEGtx2idC8zuYDUs+J0jc2fTqD2+i09PfHwPApU6epd4e8BEolhuzXD7hLqLYV
         QqQCr16H/kYjMhhTyr+wIjqyVx6kKhD48yjLzcUFQdukBt0V7bjeNghyABsZPBmLcShE
         YLy+B381MUFLv50/3PTTP4A15ntSlQfa9ibT1Qc/3lhDa8mlhM10Bce/7db1wIDD9mMM
         feZYfb9IsghCY3IKwIlnqEAl1YfTN1pCki0tAX7XAhJeqB4ceacPtAJmprkGJKSm2iI/
         6d8d2UuNKSu82Z54k2615mBRf9JvrALho3KicUO8SXsW76AErotAZCw/UUzKkBaSSfKq
         8Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733510944; x=1734115744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDe94JiUBLyj5M0Nz9phYsYy6Pis/1/rK91oYvpIJPc=;
        b=Jd5KmZzQMgHt+5zsyswkdMkBzVC55/KsElo1NbuAB6TW7hxHfy925edI9brWIO0QaZ
         jVLBvtjjNTwnydLxk4Da34Zz48OU+0p3lnzWd8pIvXSGLe85ad1m17KiG8i6ln9lsz8C
         uS/nME+rzZrYpiFwXZeiJ6kPZ39Y+B0D5s/9jnAvIYxRoWMb7JIX56ijvGILt/I0pw4M
         uP0Gz264O7/ECm2eKU4PTN4cM4SiSxWbhx/E0PdJRudPtb4qcDgqVArziAf0ZfOrDtCr
         7+wNkk/FhaLLS+Rb4hVmOMto71EWTejN1T3wnwV3I22ACy7HlBrojGpKZsVNr7VM4epM
         ZmOA==
X-Forwarded-Encrypted: i=1; AJvYcCXdJBHOYQif2hT52DTNchsJpcfDVQt/eAlVeGbYn/cT+EMfmin4mED3nmkOJlbxFgpvFjWeGHwLcZqDwZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykOoWaJzqDLl8zdFyWK0DOWJd39Xfa6XLWKwOXBYCfDJkMn2Cq
	1doOS7Xw1UlO7hIygSH6NdPITBPZ0ONcBf1h0FaHZb9drBFK/fwjQmrdI4wjbAR2R6ra/eLSzLW
	7d2P3Ql9wGg5eF9VVc3vNm5zmsJs=
X-Gm-Gg: ASbGncv0phpTJEQMbNftLTWztGJW3EX3KDI0PVSBz9quXxSQapR/WHWyfiyOMU3rGF2
	ewPNJ7VTv9rtk+TA0p4xoYGlUqU7vna3FJJbdxkNiJ+HYleXv/E4v60oGJN2QXNI=
X-Google-Smtp-Source: AGHT+IFdVK/2SW0dQA9D83t33zskmSCGjoh2wu0VKQvtZhnyeVm/Yo0+w+FJ+Tpyj82NsvB6vY+bbP+azdgpqNLFeRs=
X-Received: by 2002:a05:6102:3714:b0:4a4:781f:167e with SMTP id
 ada2fe7eead31-4afcaaa5ceemr5632763137.16.1733510944103; Fri, 06 Dec 2024
 10:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
 <F94D21C0-8189-404A-B796-BB3C6620AB89@nvidia.com> <315752c5-6129-4c8b-bf8c-0cc26f0ad5c5@redhat.com>
 <CAPYmKFuAKNw86auGUHBOpJDTK4=UFC6z4QMJWO6qn3BWczbuYw@mail.gmail.com>
In-Reply-To: <CAPYmKFuAKNw86auGUHBOpJDTK4=UFC6z4QMJWO6qn3BWczbuYw@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 6 Dec 2024 18:48:52 +0000
Message-ID: <CAKbZUD27ZiA+xX56_FG1WOnaFjEB2LFC0-qgPwf3pXdgErfKtA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v2 00/21] riscv: Introduce 64K base page
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, ardb@kernel.org, 
	anup@brainfault.org, atishp@atishpatra.org, xieyongji@bytedance.com, 
	lihangjing@bytedance.com, punit.agrawal@bytedance.com, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 1:42=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> wr=
ote:
>
> Hi David,
>
> On Fri, Dec 6, 2024 at 6:13=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 06.12.24 03:00, Zi Yan wrote:
> > > On 5 Dec 2024, at 5:37, Xu Lu wrote:
> > >
> > >> This patch series attempts to break through the limitation of MMU an=
d
> > >> supports larger base page on RISC-V, which only supports 4K page siz=
e
> > >> now. The key idea is to always manage and allocate memory at a
> > >> granularity of 64K and use SVNAPOT to accelerate address translation=
.
> > >> This is the second version and the detailed introduction can be foun=
d
> > >> in [1].
> > >>
> > >> Changes from v1:
> > >> - Rebase on v6.12.
> > >>
> > >> - Adjust the page table entry shift to reduce page table memory usag=
e.
> > >>      For example, in SV39, the traditional va behaves as:
> > >>
> > >>      ----------------------------------------------
> > >>      | pgd index | pmd index | pte index | offset |
> > >>      ----------------------------------------------
> > >>      | 38     30 | 29     21 | 20     12 | 11   0 |
> > >>      ----------------------------------------------
> > >>
> > >>      When we choose 64K as basic software page, va now behaves as:
> > >>
> > >>      ----------------------------------------------
> > >>      | pgd index | pmd index | pte index | offset |
> > >>      ----------------------------------------------
> > >>      | 38     34 | 33     25 | 24     16 | 15   0 |
> > >>      ----------------------------------------------
> > >>
> > >> - Fix some bugs in v1.
> > >>
> > >> Thanks in advance for comments.
> > >>
> > >> [1] https://lwn.net/Articles/952722/
> > >
> > > This looks very interesting. Can you cc me and linux-mm@kvack.org
> > > in the future? Thanks.
> > >
> > > Have you thought about doing it for ARM64 4KB as well? ARM64=E2=80=99=
s contig PTE
> > > should have similar effect of RISC-V=E2=80=99s SVNAPOT, right?
> >
> > What is the real benefit over 4k + large folios/mTHP?
> >
> > 64K comes with the problem of internal fragmentation: for example, a
> > page table that only occupies 4k of memory suddenly consumes 64K; quite
> > a downside.
>
> The original idea comes from the performance benefits we achieved on
> the ARM 64K kernel. We run several real world applications on the ARM
> Ampere Altra platform and found these apps' performance based on the
> 64K page kernel is significantly higher than that on the 4K page
> kernel:
> For Redis, the throughput has increased by 250% and latency has
> decreased by 70%.
> For Mysql, the throughput has increased by 16.9% and latency has
> decreased by 14.5%.
> For our own newsql database, throughput has increased by 16.5% and
> latency has decreased by 13.8%.
>
> Also, we have compared the performance between 64K and 4k + large
> folios/mTHP on ARM Neoverse-N2. The result shows considerable
> performance improvement on 64K kernel for both speccpu and lmbench,
> even when 4K kernel enables THP and ARM64_CONTPTE:
> For speccpu benchmark, 64K kernel without any huge pages optimization
> can still achieve 4.17% higher score than 4K kernel with transparent
> huge pages as well as CONTPTE optimization.
> For lmbench, 64K kernel achieves 75.98% lower memory mapping
> latency(16MB) than 4K kernel with transparent huge pages and CONTPTE
> optimization, 84.34% higher map read open2close bandwidth(16MB), and
> 10.71% lower random load latency(16MB).
> Interestingly, sometimes kernel with transparent pages support have
> poorer performance for both 4K and 64K (for example, mmap read
> bandwidth bench). We assume this is due to the overhead of huge pages'
> combination and collapse.
> Also, if you check the full result, you will find that usually the
> larger the memory size used for testing is, the better the performance
> of 64k kernel is (compared to 4K kernel). Unless the memory size lies
> in a range where 4K kernel can apply 2MB huge pages while 64K kernel
> can't.
> In summary, for performance sensitive applications which require
> higher bandwidth and lower latency, sometimes 4K pages with huge pages
> may not be the best choice and 64k page can achieve better results.
> The test environment and result is attached.
>
> As RISC-V has no native 64K MMU support, we introduce a software
> implementation and accelerate it via Svnapot. Of course, there will be
> some extra overhead compared with native 64K MMU. Thus, we are also
> trying to persuade the RISC-V community to support the extension of
> native 64K MMU [1]. Please join us if you are interested.
>

Ok, so you... didn't test this on riscv? And you're basing this
patchset off of a native 64KiB page size kernel being faster than 4KiB
+ CONTPTE? I don't see how that makes sense?

/me is confused

How many of these PAGE_SIZE wins are related to e.g userspace basing
its buffer sizes (or whatever) off of the system page size? Where
exactly are you gaining time versus the CONTPTE stuff?
I think MM in general would be better off if we were more transparent
with regard to CONTPTE and page sizes instead of hand waving with
"hardware page size !=3D software page size", which is such a *checks
notes* 4.4BSD idea... :) At the very least, this patchset seems to go
against all the work on better supporting large folios and CONTPTE.

--=20
Pedro

