Return-Path: <linux-kernel+bounces-233021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D9591B127
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F671C233DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A5F19F469;
	Thu, 27 Jun 2024 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TRX5JU5Z"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6ED13FF9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719522257; cv=none; b=ViCPxQ+qGeR2BcBkT2DWIsc4MBhHVfUqUDiidNLgSKx17jBjP46D0FS5GSBTE2D0dtE14hx2KyFb4NatXPDYSZZ9XXYU6/3ihUsyOyl1AzGdh7pgKeNyx0bObxEfpUfLzVwW9bC8z5vJtPl5RWwpU24S3qw5yKsC+GMXXMc0is4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719522257; c=relaxed/simple;
	bh=QLy8lysBJKgceNm/zrfcBq2pJG4E5noGbFzG0IaGj00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iy2/iCSdokGg5ka1+RBTwM/exWEwfVkFTeTtcXSzJ9ok9RLGXFt1RH31RjWKto/Km/6beMW5WiWfsA4DVghjTV2Kd9MowdmJHkhvWbhz5cnQhbhGY4rpFdG4JR4b0OzSOWkFDCHQ/P3LFZLIKaZ8QzzyTkIa4ZPg07CN0ELmbmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TRX5JU5Z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4255f915611so5145e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719522254; x=1720127054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1Son9PgFZxipUqIwP1rlgNrA3yZxpgDflb001yGw5A=;
        b=TRX5JU5ZMeB/DUWLrhnC224zer/7ScwlbOGseDocZ5u1qH9S5m6u+cCVzNGA+7PZrG
         hKhyKNmchO00skFl/6iJosb+kVjU+1yvyVVfd+lnE2bsMCbOQtuX86Haa1XCJ9zKBG7i
         uRNEDnGQ4YKox8qPUy1VCDMS4R7Ze2X6wOdU0j2o9N4Bf6x5o67n9vij1sJ3MhUPqLd7
         9q4ssDPkmewFttpkl9lfrUtNZO5aklCRzNJfCW8ccRX3G3VJKDLkCqjAPZPavep4RIFj
         6nSuVBWhbsl2b8vAopLssdqny1+94hVQgbpuCUJyACnUW6Ab7mcjVlPWrwP8ExswDhQ8
         f7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719522254; x=1720127054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1Son9PgFZxipUqIwP1rlgNrA3yZxpgDflb001yGw5A=;
        b=UFcLOi9Ib1xlHD732miv7/KiDfy5qUtzr0SQ0hrTY2D3usyVdJYy/J++RS/KGv1+Ky
         a0BGZvFZaw+9X3uTG+g+EOeJ1C0sTppB65tx6W8+Hu61uomcvG159QNKJcC7bp0pVMCj
         UUzb+MYu6dKxQD0cHnDEV8uneVBr7R+ywT08+iJ8zVXfvwNRPU09VNXkjWzymJzobiNN
         frzMzLSEGAuuARFycLHc/zKinbSR0HDgMoeGjbdt0xjD/1QknXe42E21FtPJsmyLwPqQ
         WEzTXjxZHwLGC7fLZD/A0Zqn5tuWcmdtt8DlBYF6h00op6KfY4fXnqb+PBHbeyRfAj8s
         JUZg==
X-Forwarded-Encrypted: i=1; AJvYcCUtAohzyFYSJKIcvdHmnghe+Kq0F3GlSRs7sgstV/XJ0wP1eeajN/tMyHEWFayp0/XNNV9w27KP3ni6GmL5C6kNR37KPhjcnNlJcHbU
X-Gm-Message-State: AOJu0YzTSHnFm0Qk1sNCdrgG7zjFwR4VuSCTwWEMXoNbrT1OLvLfvIUy
	6qaE6jFekyWNcQLtxhJXKNj5GAU5S6UT17sJJz/dsNhpV6lHXx+XZLJeKrOa8B/fHAuvhEx2+SA
	6e17RU0NqzsyBKZe/E25MZw49N7Kb6zQQ5oRkB+XJPP/lNy4idpaI
X-Google-Smtp-Source: AGHT+IF2M2h8golpqelyS8GkrbBkEYKMYLHQAr/rmMTFu2PNvyLpFVgJPntRKGsxwIzhN/r5HizzGcjI1uK5/VFqFR0=
X-Received: by 2002:a05:600c:1c19:b0:424:8a45:dd90 with SMTP id
 5b1f17b1804b1-4256c28f6d0mr123395e9.3.1719522253773; Thu, 27 Jun 2024
 14:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck> <ZcNnrdlb3fe0kGHK@casper.infradead.org>
 <ZcN1hTrAhy-B1P2_@arm.com> <44075bc2-ac5f-ffcd-0d2f-4093351a6151@huawei.com>
 <20240208131734.GA23428@willie-the-truck> <f8a643a9-4932-9ba4-94f1-4bc88ee27740@google.com>
 <22c14513-af78-0f1d-5647-384ff9cb5993@huawei.com> <ZnkGps-vQbiynNwP@google.com>
 <17232655-553d-7d48-8ba1-5425e8ab0f8b@huawei.com>
In-Reply-To: <17232655-553d-7d48-8ba1-5425e8ab0f8b@huawei.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 27 Jun 2024 15:03:36 -0600
Message-ID: <CAOUHufY8AZ7Td=OKg+Bbbnk+B-XspJQH2XDsEeZsiDJ-GuQgcQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: David Rientjes <rientjes@google.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Matthew Wilcox <willy@infradead.org>, muchun.song@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, anshuman.khandual@arm.com, 
	wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosryahmed@google.com>, Sourav Panda <souravpanda@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 8:34=E2=80=AFAM Nanyong Sun <sunnanyong@huawei.com>=
 wrote:
>
>
> =E5=9C=A8 2024/6/24 13:39, Yu Zhao =E5=86=99=E9=81=93:
> > On Mon, Mar 25, 2024 at 11:24:34PM +0800, Nanyong Sun wrote:
> >> On 2024/3/14 7:32, David Rientjes wrote:
> >>
> >>> On Thu, 8 Feb 2024, Will Deacon wrote:
> >>>
> >>>>> How about take a new lock with irq disabled during BBM, like:
> >>>>>
> >>>>> +void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte=
)
> >>>>> +{
> >>>>> +     (NEW_LOCK);
> >>>>> +    pte_clear(&init_mm, addr, ptep);
> >>>>> +    flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> >>>>> +    set_pte_at(&init_mm, addr, ptep, pte);
> >>>>> +    spin_unlock_irq(NEW_LOCK);
> >>>>> +}
> >>>> I really think the only maintainable way to achieve this is to avoid=
 the
> >>>> possibility of a fault altogether.
> >>>>
> >>>> Will
> >>>>
> >>>>
> >>> Nanyong, are you still actively working on making HVO possible on arm=
64?
> >>>
> >>> This would yield a substantial memory savings on hosts that are large=
ly
> >>> configured with hugetlbfs.  In our case, the size of this hugetlbfs p=
ool
> >>> is actually never changed after boot, but it sounds from the thread t=
hat
> >>> there was an idea to make HVO conditional on FEAT_BBM.  Is this being
> >>> pursued?
> >>>
> >>> If so, any testing help needed?
> >> I'm afraid that FEAT_BBM may not solve the problem here
> > I think so too -- I came cross this while working on TAO [1].
> >
> > [1] https://lore.kernel.org/20240229183436.4110845-4-yuzhao@google.com/
> >
> >> because from Arm
> >> ARM,
> >> I see that FEAT_BBM is only used for changing block size. Therefore, i=
n this
> >> HVO feature,
> >> it can work in the split PMD stage, that is, BBM can be avoided in
> >> vmemmap_split_pmd,
> >> but in the subsequent vmemmap_remap_pte, the Output address of PTE sti=
ll
> >> needs to be
> >> changed. I'm afraid FEAT_BBM is not competent for this stage. Perhaps =
my
> >> understanding
> >> of ARM FEAT_BBM is wrong, and I hope someone can correct me.
> >> Actually, the solution I first considered was to use the stop_machine
> >> method, but we have
> >> products that rely on /proc/sys/vm/nr_overcommit_hugepages to dynamica=
lly
> >> use hugepages,
> >> so I have to consider performance issues. If your product does not cha=
nge
> >> the amount of huge
> >> pages after booting, using stop_machine() may be a feasible way.
> >> So far, I still haven't come up with a good solution.
> > I do have a patch that's similar to stop_machine() -- it uses NMI IPIs
> > to pause/resume remote CPUs while the local one is doing BBM.
> >
> > Note that the problem of updating vmemmap for struct page[], as I see
> > it, is beyond hugeTLB HVO. I think it impacts virtio-mem and memory
> > hot removal in general [2]. On arm64, we would need to support BBM on
> > vmemmap so that we can fix the problem with offlining memory (or to be
> > precise, unmapping offlined struct page[]), by mapping offlined struct
> > page[] to a read-only page of dummy struct page[], similar to
> > ZERO_PAGE(). (Or we would have to make extremely invasive changes to
> > the reader side, i.e., all speculative PFN walkers.)
> >
> > In case you are interested in testing my approach, you can swap your
> > patch 2 with the following:
> I don't have an NMI IPI capable ARM machine on hand, so I think this feat=
ure
> depends on a higher version of the ARM cpu.

(Pseudo) NMI does require GICv3 (released in 2015). But that's
independent from CPU versions. Just to double check: you don't have
GICv3 (rather than not have CONFIG_ARM64_PSEUDO_NMI=3Dy or
irqchip.gicv3_pseudo_nmi=3D1), is that correct?

Even without GICv3, IPIs can be masked but still works, with a less
bounded latency.

> What I worried about was that other cores would occasionally be interrupt=
ed
> frequently(8 times every 2M and 4096 times every 1G) and then wait for th=
e
> update of page table to complete before resuming.

Catalin has suggested batching, and to echo what he said [1]: it's
possible to make all vmemmap changes from a single HVO/de-HVO
operation into *one batch*.

[1] https://lore.kernel.org/linux-mm/ZcN7P0CGUOOgki71@arm.com/

> If there are workloads
> running on other cores, performance may be affected. This implementation
> speeds up stopping and resuming other cores, but they still have to wait
> for the update to finish.

How often does your use case trigger HVO/de-HVO operations?

For our VM use case, it's generally correlated to VM lifetimes, i.e.,
how often VM bin-packing happens. For our THP use case, it can be more
often, but I still don't think we would trigger HVO/de-HVO every
minute. So with NMI IPIs, IMO, the performance impact would be
acceptable to our use cases.

