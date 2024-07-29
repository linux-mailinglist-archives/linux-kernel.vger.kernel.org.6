Return-Path: <linux-kernel+bounces-266359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADB193FEAF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62861C21D47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD9B161321;
	Mon, 29 Jul 2024 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPQ46c/C"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C64C43152
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283399; cv=none; b=PpCVYnL6ygUkl0LUMdSgKaMDF2/GmJyRxj4pjtgvdbczFG80eSfaHLLhr2lKHGDJgTqDOaZSadZnLucBs8rR5gJCesDqVGC8V2uzT3N+ihSKJcFS6NneCOOvvkK+pWBdteNQjyWDufYxnLAkgAnfxPOcOe8NZa2OmT6gr/A85z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283399; c=relaxed/simple;
	bh=sH3OxyjISoV9gmzP4kGzgGw1Gd/8+8tJoyV1r0EshMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vp16qMdf2laa01uF169sLJcQYRZetwBN4QFci00fbjaSgC6O7Q+8NqrKRjgn23JGYxwG03fNjK2zHYTCP6Dw416EZzt2kAJrNNRdXIV6i8o3ndowARR1IzrIAT0y671YjLzH/CWyo6Dh7qbTmErH8gWjmD430Aalz+/om1LlMNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPQ46c/C; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c661e75ff6so2710573eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722283396; x=1722888196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDq1Gdt3n+usFmiUTBcsV00Y3w2xz3JMkPDIMEdofYk=;
        b=YPQ46c/CE3f0zNN3prQ0OtHUMPAFdSnCMsgdP0F1gwvcGQjLzi3rmj7EBdFdvnrCUq
         MWxnXntp738ii3VeRlu9TQYabg+q4ekrHemIGWWaO/HSMDCr1CCdn1TAks7w8sxpgOtB
         J9YumCR5XQfoDYwS0clZ5/O4PQP2bbV+TLFwXON9SZ4v3KEYSBYlrKG7meJX/EAeq1Kw
         Q519g8bOumIqcH4nSDEfqkt09jKLPpIa4g5C+O/WUcTD5DIGENNePmOxPCL6UEAzdePs
         u2eGAeQm5lbyKc2r+IsRA6K3yr96L+OFS2VwD3O8Q3wQwEmv0EACs8fRzBh3wyGj8bVd
         +Bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722283396; x=1722888196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDq1Gdt3n+usFmiUTBcsV00Y3w2xz3JMkPDIMEdofYk=;
        b=AGBFtpDsjsTOTO6hZUGDAqLIJ/FqRyo1G6w738r+blmyH5p8jkjLGJggw5Qld6we/2
         clnJrP0bZu+siRqv8vi9JJx01dxL/+jGPDYZeBdpnF21cYEpkGXrGlnvJXl1Vod7ecB1
         PRbNFP0pFlvq9Rrn8LqmERKyY45k3cOJM86ncORNp6qS0hXViJ+z15xiarP+hHEwI+BK
         Y6+xkTqbek1c7p3cu4iwR5bQ/A+NtEmI2ui0NWPRwOP1UCTG9NkcfRqrjvasWiHB5wwS
         q6qcLJFBkFKST196pAT0G4IjB60jB0JZ5fcawdUoDyLPQ3jVKca2lILoxJFHwTr5Vwxj
         U6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNuvTIu/tFMNvpr5XuIjqam/Ye5Ln5dW1a4DB5LMfhnMHxmVaeFmjpeGPRf0Iu/hh6j7iJq1KaGHpkCGiQ3VZ1ra/eh6vhLUFURqYx
X-Gm-Message-State: AOJu0Yzt8F2CFFi8kpxwrTAsEvprmOQZJea9bvfJ6+1q/u8Bf6biAL78
	BqjOIX0J6pzdRm7iRjS8Z4CNLPxxck+wSUgTGulqR46DZbH+ra5x3HhSFfFxOG1AeiS0MlO6GV/
	ZwwmsYw7kRHuqA9V5xihiA+EBwDw=
X-Google-Smtp-Source: AGHT+IGbZo8tM4Jx81FtIJRkLT4fg5oCgMI5kCyd+x+xfpAEG9W3DAU19E1zTOQK5uTv4avib9PWrMnP0uS+k/fDFa4=
X-Received: by 2002:a05:6358:d26:b0:1aa:b9ec:50ca with SMTP id
 e5c5f4694b2df-1adcbf03d0cmr1459541055d.25.1722283396404; Mon, 29 Jul 2024
 13:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-4-21cnbao@gmail.com>
 <ZqcRqxGaJsAwZD3C@casper.infradead.org> <CAGsJ_4xQkPtw1Cw=2mcRjpTdp-c9tSFCuW_U6JKzJ3zHGYQWrA@mail.gmail.com>
 <CAGsJ_4wxUZAysyg3cCVnHhOFt5SbyAMUfq3tJcX-Wb6D4BiBhA@mail.gmail.com>
 <ZqePwtX4b18wiubO@casper.infradead.org> <CAGsJ_4zXfYT4KxBnLx1F8tpK-5s6PX3PQ7wf7tteuzEyKS+ZPQ@mail.gmail.com>
 <ZqexmNIc00Xlwy2c@casper.infradead.org>
In-Reply-To: <ZqexmNIc00Xlwy2c@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 30 Jul 2024 08:03:05 +1200
Message-ID: <CAGsJ_4yqLVvCUFpHjWmNAYvPRMzGK8JJWYMXJLR7d9UhKp+QDA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mm: support large folios swapin as a whole for
 zRAM-like swapfile
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com, Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 3:13=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Jul 30, 2024 at 01:11:31AM +1200, Barry Song wrote:
> > for this zRAM case, it is a new allocated large folio, only
> > while all conditions are met, we will allocate and map
> > the whole folio. you can check can_swapin_thp() and
> > thp_swap_suitable_orders().
>
> YOU ARE DOING THIS WRONGLY!
>
> All of you anonymous memory people are utterly fixated on TLBs AND THIS
> IS WRONG.  Yes, TLB performance is important, particularly with crappy
> ARM designs, which I know a lot of you are paid to work on.  But you
> seem to think this is the only consideration, and you're making bad
> design choices as a result.  It's overly complicated, and you're leaving
> performance on the table.
>
> Look back at the results Ryan showed in the early days of working on
> large anonymous folios.  Half of the performance win on his system came
> from using larger TLBs.  But the other half came from _reduced software
> overhead_.  The LRU lock is a huge problem, and using large folios cuts
> the length of the LRU list, hence LRU lock hold time.
>
> Your _own_ data on how hard it is to get hold of a large folio due to
> fragmentation should be enough to convince you that the more large folios
> in the system, the better the whole system runs.  We should not decline t=
o
> allocate large folios just because they can't be mapped with a single TLB=
!

I am not convinced. for a new allocated large folio, even alloc_anon_folio(=
)
of do_anonymous_page() does the exactly same thing

alloc_anon_folio()
{
        /*
         * Get a list of all the (large) orders below PMD_ORDER that are en=
abled
         * for this vma. Then filter out the orders that can't be allocated=
 over
         * the faulting address and still be fully contained in the vma.
         */
        orders =3D thp_vma_allowable_orders(vma, vma->vm_flags,
                        TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
        orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);

}

you are not going to allocate a mTHP for an unaligned address for a new
PF.
Please point out where it is wrong.

Thanks
Barry

