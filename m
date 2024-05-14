Return-Path: <linux-kernel+bounces-179190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64508C5CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0B61C21AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F57181BBD;
	Tue, 14 May 2024 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTIT9KHw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D887180A77
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722477; cv=none; b=LqSJFx+6gh8eR9DFp1rr/RFyoLoPU7xLWN7ng0wx9mdBd54EBu3bd49r07BEYAvUgQqcKiuSs1cspwcoPjbsMYwBl2duK9zGy5Ky/OkxkhrMdwsHszqHp27Wqcj/6VD6N6m+APPteiQblVHkinTSuMwwmt1N9ROLXRWJeX2+qLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722477; c=relaxed/simple;
	bh=dg3D8jzXOepk90HJ2oawVVRby4i/Jql8l3UJpoy8uQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG9au8Pl+q0+wcmA+6HmG+qVG1IUKEzQfCih83jTtooDlHDmZ+f3xi9Yo5HM+U9uVVYkUbEwoYoGNOXpfCQkkcyWs7oKFqwu1sekEXdhX4w2EoCEGH0r8akeJoJT58HN+pXeUCTve3bVidNoP9OA9Vam/lDzPzloXBfsORewiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTIT9KHw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715722475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2Xu6ycBxA1ncNcxZjTIGSkpvUsVz0mp4Jxa+4CoWmo=;
	b=BTIT9KHw68mN4wCkOXqiaWaVuqqAC5cOpFTlCr7QNfcppPB8rDIGUjTJiGis4TBWK0wZ5S
	Gr0j+aBgTggMB27XKFXm1kq0WwFhDv70iQ8JrG55FMq8L9aYQQpTyywwcoSsIr70XpHFL/
	MZvmKHMadcFzuw7q8Hjt5BtSQIUahsY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-2k4pTwKtNI2NtnTQd_m6Jg-1; Tue, 14 May 2024 17:34:33 -0400
X-MC-Unique: 2k4pTwKtNI2NtnTQd_m6Jg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b83ee6ef60so1484748a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715722472; x=1716327272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2Xu6ycBxA1ncNcxZjTIGSkpvUsVz0mp4Jxa+4CoWmo=;
        b=kQ7UA0wDwbgCUn8lXp+5mO0I0b+LRGyWQPd9a9Wr5YPM5WqzTlQV37712yiHDBzlTp
         htdoP9rn6DGtYdumWDUp0llvHPuMbtUe3AfDm0Xd9EwUJcLJHBvixAuMAi0jBoLWn6hw
         5Eq4xWizbpDlE8rgKsx/W4hCc71JBNa6aRZqx+eXCVfAPNlTo4sd74kWTm638gqC2r/v
         l9tF4nK2tkFly5h6cMAsUjS/oPRZ4Akoc4q/AH78YJLXblt2DGmRgVFTv86vDEoQBRUS
         HpkxF2IfNeCL8mIGR8bt8Evhrk5HuLu4uKefiFMBaXqrXDWNJ3N4wHO4+0ti+QQkaUPC
         ylYw==
X-Forwarded-Encrypted: i=1; AJvYcCWqsQ1tpr9O7q+pCSZSKqeuyeGfDwldALZge6dGFR9zmU+S2kFHKe2Mg/bVe4Pl+X7LjnSceIEbXJEajJqro1+SmrhhpXvlVAVyyL2J
X-Gm-Message-State: AOJu0YwVR3a4s91jd1C/6/C2CTDbSL8Bkwltzp/cqYyYjSa9HQmcD6M0
	Eie/fr/S489xma9jYXrrxexI8Sa3LqM14yWBirJcWugJtC2KMbcGdmUhd9CBeTPMGemFzKgPuIF
	PEgi4RUHhliopScyFaybxukS//keALGlCMHNZXsrUlveD2rM/1QUIHhtKTvi0KA==
X-Received: by 2002:a17:903:246:b0:1eb:50eb:c07d with SMTP id d9443c01a7336-1ef441aa0a2mr161489395ad.4.1715722472117;
        Tue, 14 May 2024 14:34:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlPBl9ea4KstMsjdvAfVmaII4uiOPY4sbbUGcaeXkU+KlSg8op9ntpdI4qQN60DSBg7ZfBtw==
X-Received: by 2002:a17:903:246:b0:1eb:50eb:c07d with SMTP id d9443c01a7336-1ef441aa0a2mr161488855ad.4.1715722471349;
        Tue, 14 May 2024 14:34:31 -0700 (PDT)
Received: from x1n ([50.204.89.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad9da4sm102645805ad.107.2024.05.14.14.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 14:34:30 -0700 (PDT)
Date: Tue, 14 May 2024 15:34:24 -0600
From: Peter Xu <peterx@redhat.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Liu Shixin <liushixin2@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 1/1] arch/fault: don't print logs for pte marker
 poison errors
Message-ID: <ZkPY4CSnZWZnxjTa@x1n>
References: <20240510182926.763131-1-axelrasmussen@google.com>
 <20240510182926.763131-2-axelrasmussen@google.com>
 <Zj51rEwZeSK4Vr1G@x1n>
 <ZkPJCc5N1Eotpa4u@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkPJCc5N1Eotpa4u@localhost.localdomain>

On Tue, May 14, 2024 at 10:26:49PM +0200, Oscar Salvador wrote:
> On Fri, May 10, 2024 at 03:29:48PM -0400, Peter Xu wrote:
> > IMHO we shouldn't mention that detail, but only state the effect which is
> > to not report the event to syslog.
> > 
> > There's no hard rule that a pte marker can't reflect a real page poison in
> > the future even MCE.  Actually I still remember most places don't care
> > about the pfn in the hwpoison swap entry so maybe we can even do it? But
> > that's another story regardless..
> 
> But we should not use pte markers for real hwpoisons events (aka MCE), right?

The question is whether we can't.

Now we reserved a swp entry just for hwpoison and it makes sense only
because we cached the poisoned pfn inside.  My long standing question is
why do we ever need that pfn after all.  If we don't need the pfn, we
simply need a bit in the pgtable entry saying that it's poisoned, if
accessed we should kill the process using sigbus.

I used to comment on this before, the only path that uses that pfn is
check_hwpoisoned_entry(), which was introduced in:

commit a3f5d80ea401ac857f2910e28b15f35b2cf902f4
Author: Naoya Horiguchi <nao.horiguchi@gmail.com>
Date:   Mon Jun 28 19:43:14 2021 -0700

    mm,hwpoison: send SIGBUS with error virutal address
    
    Now an action required MCE in already hwpoisoned address surely sends a
    SIGBUS to current process, but the SIGBUS doesn't convey error virtual
    address.  That's not optimal for hwpoison-aware applications.
    
    To fix the issue, make memory_failure() call kill_accessing_process(),
    that does pagetable walk to find the error virtual address.  It could find
    multiple virtual addresses for the same error page, and it seems hard to
    tell which virtual address is correct one.  But that's rare and sending
    incorrect virtual address could be better than no address.  So let's
    report the first found virtual address for now.

So this time I read more on this and Naoya explained why - it's only used
so far to dump the VA of the poisoned entry.

However what confused me is, if an entry is poisoned already logically we
dump that message in the fault handler not memory_failure(), which is:

MCE: Killing uffd-unit-tests:650 due to hardware memory corruption fault at 7f3589d7e000

So perhaps we're trying to also dump that when the MCEs (points to the same
pfn) are only generated concurrently?  I donno much on hwpoison so I cannot
tell, there's also implication where it's only triggered if
MF_ACTION_REQUIRED.  But I think it means hwpoison may work without pfn
encoded, but I don't know the implication to lose that dmesg line.

> I mean, we do have the means to mark a page as hwpoisoned when a real
> MCE gets triggered, why would we want a pte marker to also reflect that?
> Or is that something for userfaultd realm?

No it's not userfaultfd realm.. it's just that pte marker should be a
generic concept, so it logically can be used outside userfaultfd.  That's
also why it's used in swapin errors, in which case we don't use anything
else in this case but a bit to reflect "this page is bad".

> 
> > And also not report swapin error is, IMHO, only because arch errors said
> > "MCE" in the error logs which may not apply here.  Logically speaking
> > swapin error should also be reported so admin knows better on why a proc is
> > killed.  Now it can still confuse the admin if it really happens, iiuc.
> 
> I am bit confused by this.
> It seems we create poisoned pte markers on swap errors (e.g:
> unuse_pte()), which get passed down the chain with VM_FAULT_HWPOISON,
> which end up in sigbus (I guess?).
> 
> This all seems very subtle to me.
> 
> First of all, why not passing VM_FAULT_SIGBUS if that is what will end
> up happening?
> I mean, at the moment that is not possible because we convolute swaping
> errors and uffd poison in the same type of marker, so we do not have any
> means to differentiate between the two of them.
> 
> Would it make sense to create yet another pte marker type to split that
> up? Because when I look at VM_FAULT_HWPOISON, I get reminded of MCE
> stuff, and that does not hold here.

We used to not dump error for swapin error.  Note that here what I am
saying is not that Axel is doing things wrong, but it's just that logically
swapin error (as pte marker) can also be with !QUIET, so my final point is
we may want to avoid having the assumption that "pte marker should always
be QUITE", because I want to make it clear that pte marker can used in any
form, so itself shouldn't imply anything..

Thanks,

-- 
Peter Xu


