Return-Path: <linux-kernel+bounces-349551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B29D98F82C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7781F22086
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8F11B372C;
	Thu,  3 Oct 2024 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEG00k5G"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512231A76CE
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727987999; cv=none; b=Uz4K7SH28q6Vohx5tuGRQ20CTd7DvacF9MsKkI6TleQKOJ6PB0c5JuU0wBkbi1oYpPoV8uXQZZsNXxop/vj3Nm+Xe0GEY59IBYBt9upK6itzJ06zPirPkjglItP9RYDz3SVwfEdaklLPfdS2wvywVuxXiHx6TYW3KkIdd8aWgN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727987999; c=relaxed/simple;
	bh=HJx5V8rfYvrgddBXtc03d3rXWFdvIUP+4l0/loCCDEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLFYCPPNhNPI6poqDaUQwij9+xV+Dt53XDjZa1rEyKtPrZwWK/RxQUN8cWmdA7VM8QJeeCbGoBJcBsNWLR5Te5ivYvLZyUpmSVrpgUsxP7cFP+XZj9FZ0DLjRnknlQ1LvipJMHNjsxtHozAR2esY8vxdgSGECmTCRML7MBCHDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEG00k5G; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-84e88c2ce05so396194241.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727987997; x=1728592797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPDOQS4g3jiSC7koeugiFipgPQOubT+R5rh1868TSLk=;
        b=dEG00k5G5Rfn1ZQHNedhY+d7t+XNqqtSAVEsehYXVbtBUAdl7akRFcK8B2UNZF3em9
         fNMJz1htDkv/Fb5qUD8vonLYl/R81i28Q0wXauIJUSpIlPO7P1apK8yq2jOKpOZLJPAb
         zmavpFoMvAOriwDEU3jOtHI04c9FBZQOiaWPluukfLydNo7sAv1U/Gp0w2M6mEf8kEK3
         NSrQAKzagoeD8PXzIJvs2xJ1/T5uo5lvr3829Eq/FR7VfE3XdCtPi7jfTdM9Jq+cWf1R
         Tjzm4C6Jj49a6cnMoy7VsJiZdpjb0qmsMqXNDy+Boro4kTFpLiLkonl3iiyohgwYlgw8
         Tv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727987997; x=1728592797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPDOQS4g3jiSC7koeugiFipgPQOubT+R5rh1868TSLk=;
        b=o8hhCV6Zx1efGBdxjD2E/t/IV7OvyPh09MW6eBu+YYR5cpH4E+FfNGtzT/BT6Jw5B0
         BZqIHjEd+FYMNSplkwr9HIa6rs04iS92jhuZ2e9NRqK/+vT6wOWMI0ifhZ/tYeRdiPFt
         UrZ5WZQ4epd+3DRbh56o1gKeKdePVsTJTCGKoVl66SQM/CDtoxxWYV8HpHABUdekMNki
         OBN1aKS3dVnZ33Q4Wm3oq7gaj9hYyyops+pGsEHmB/TOkoYhduthz4uBvHkyrFwW53/l
         tRDm2isOcgcznhVDIrQemyILzsfk2T44F6mcI0ct1xagk+bWU4xEExjbmUIWAkh5XDoe
         5JdA==
X-Forwarded-Encrypted: i=1; AJvYcCUcvU7DdlMg/LRuH0snRnAMGKmdUBHPh7Kw+YAhWFiEQq1A9oHLQUssu5bJZykNbbzRFHMsWDiBtiZlQxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBYFmPR9Y43UatYBxPWwXZzNHDXPKpP03AhYz1DeLOnpz2BQG
	QtbdV/uASy4ZaZVN1LIds2f+pH2PPQ5a1CU+3dxFJpJ9UVSlj/8r7zFlwcTthLqXbPON1kPi0B9
	6j4Nw3KVSkHE5xYnVsTtEQF6aXvU=
X-Google-Smtp-Source: AGHT+IFFz+Yln8L/nNoifUwD/XeJ5mUA5108ak9GrdaULvEzgln+g9PdDUAcb0H7lTFYiTWuSV+s0QF4kwDd0y+d7cE=
X-Received: by 2002:a05:6102:c14:b0:49b:cfbc:63ac with SMTP id
 ada2fe7eead31-4a4057441ccmr754716137.6.1727987997227; Thu, 03 Oct 2024
 13:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930055112.344206-1-ying.huang@intel.com> <cf4a3ae4-deae-4224-88e3-308a55492085@redhat.com>
 <8734lgpuoi.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <8734lgpuoi.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 3 Oct 2024 13:39:44 -0700
Message-ID: <CAHbLzkp_SyRBR+JsxMwM_qKpF=8+TU=36hDY6TuKMHdnLnyxAg@mail.gmail.com>
Subject: Re: [PATCH] tdx, memory hotplug: Check whole hot-adding memory range
 for TDX
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, 
	linux-coco@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Dan Williams <dan.j.williams@intel.com>, Kai Huang <kai.huang@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:54=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Hi, David,
>
> Thanks a lot for comments!
>
> David Hildenbrand <david@redhat.com> writes:
>
> > On 30.09.24 07:51, Huang Ying wrote:
> >> On systems with TDX (Trust Domain eXtensions) enabled, memory ranges
> >> hot-added must be checked for compatibility by TDX.  This is currently
> >> implemented through memory hotplug notifiers for each memory_block.
> >> If a memory range which isn't TDX compatible is hot-added, for
> >> example, some CXL memory, the command line as follows,
> >>    $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
> >> will report something like,
> >>    bash: echo: write error: Operation not permitted
> >> If pr_debug() is enabled, the error message like below will be shown
> >> in the kernel log,
> >>    online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
> >> Both are too general to root cause the problem.  This will confuse
> >> users.  One solution is to print some error messages in the TDX memory
> >> hotplug notifier.  However, memory hotplug notifiers are called for
> >> each memory block, so this may lead to a large volume of messages in
> >> the kernel log if a large number of memory blocks are onlined with a
> >> script or automatically.  For example, the typical size of memory
> >> block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
> >> will be logged.
> >
> > ratelimiting would likely help here a lot, but I agree that it is
> > suboptimal.
> >
> >> Therefore, in this patch, the whole hot-adding memory range is
> >> checked
> >> for TDX compatibility through a newly added architecture specific
> >> function (arch_check_hotplug_memory_range()).  If rejected, the memory
> >> hot-adding will be aborted with a proper kernel log message.  Which
> >> looks like something as below,
> >>    virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX
> >> for TDX compatibility.
> >> > The target use case is to support CXL memory on TDX enabled systems.
> >> If the CXL memory isn't compatible with TDX, the whole CXL memory
> >> range hot-adding will be rejected.  While the CXL memory can still be
> >> used via devdax interface.
> >
> > I'm curious, why can that memory be used through devdax but not
> > through the buddy? I'm probably missing something important :)
>
> Because only TDX compatible memory can be used for TDX guest.  The buddy
> is used to allocate memory for TDX guest.  While devdax will not be used
> for that.

Sorry for chiming in late. I think CXL also faces the similar problem
on the platform with MTE (memory tagging extension on ARM64). AFAIK,
we can't have MTE on CXL, so CXL has to stay as dax device if MTE is
enabled.

We should need a similar mechanism to prevent users from hot-adding
CXL memory if MTE is on. But not like TDX I don't think we have a
simple way to tell whether the pfn belongs to CXL or not. Please
correct me if I'm wrong. I'm wondering whether we can find a more
common way to tell memory hotplug to not hot-add some region. For
example, a special flag in struct resource. off the top of my head.

No solid idea yet, I'm definitely seeking some advice.

>
> >> This also makes the original TDX memory hotplug notifier useless, so
> >> delete it.
> >
> > The online-notifier would even be too late when used with the
> > memmap-on-memory feature I assume, as we might be touching that memory
> > even before being able to call memory online notifiers.
>
> This should be OK.  Because we will not use the memory for TDX guest in
> this way.
>
> > One way to handle that would be to switch to the MEM_PREPARE_ONLINE
> > notifier, but it's still called per-memory block.
> >
> > Nothing jumped at me, so
> >
> > Acked-by: David Hildenbrand <david@redhat.com>
>
> Thank you very much!
>
> --
> Best Regards,
> Huang, Ying
>

