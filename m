Return-Path: <linux-kernel+bounces-340520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9580987493
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7401288F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A9A3B7A8;
	Thu, 26 Sep 2024 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNR9EdMj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB54D8AD
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357988; cv=none; b=Ti1M4xMW49rONGGV0p7ToZaBjYbGMFDGSm+tQo3zUOFikNfUhu0S7w/7gvEvQoLSeEKyp2IYtgKCSwpSZoZD2SMT1KX85H56ef2HAk3pTrhkVm0GVs2T40EPmo3SvUHF8XykiFJUD7xnWuUmsBOAx7zDIwxqL0ZSimMjOUpmlKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357988; c=relaxed/simple;
	bh=oAf0NwzQ3QmouSyP6H440AZ79XLW/wUP/mrX3oEeTlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcQJky8WBtSI1teU6GbICD5I4YZAhnQejInefzjKUqFeChAnt26SJDNsLPovVASG5BXNO9UUS999ndpJtTex6VZa3/rzb8qDjBNA+CHdbjthNBrLEIir8lam5qsFFaEir+B260ss2YlOfsV1QaN3sd1oghuMPIyUtnN9ywN0YCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bNR9EdMj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727357985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NP3xVwUHECq3mYbUhkAhql8+7RvmrTr41ZucVz/QUbY=;
	b=bNR9EdMjjp9GkbeMo6ecTVUwmyREWWbpWTIN5tW/cZ7ES1vjo+ehs4Q2njGBtl69ougEKA
	O00XyxOP4yeKlZFytKRyawWj8nxFcNBNfowGqEHqIRiot8WffPWOXSDrmVOxEIm21ThsxS
	Jm+2Hrz8PbVCYv8gpchG3gwRBb64bA8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-P5FEJ8RTOwKExzNoQTg4TQ-1; Thu, 26 Sep 2024 09:39:44 -0400
X-MC-Unique: P5FEJ8RTOwKExzNoQTg4TQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4585482ca78so16730831cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727357984; x=1727962784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP3xVwUHECq3mYbUhkAhql8+7RvmrTr41ZucVz/QUbY=;
        b=mXnNmbgkjlYHpmRV0LYi2eV3QdVxLJ5zXq+H0rTOuQpGnd7/7pZb1TPMsxxPPXNycm
         0PggYmzjwlsQuDsHrvPzJ0hAmh/n77JKeBhuWECBQOJrmSdXQNiDWabjgF/SwWQNJKnV
         X2edyZ0kVHRQvy7LPX7VsGu2qUasAntRrcWBKs6DzQVXplAWEJB6LT4KiQBWMZs6VYYA
         pL/15xsj1bp31pnN+Hy6ucWyrzBl41mgF50ZQrsx2Z4VvtX3ZgOLq4UboVUwsKuSSKP9
         H/1CyUlPpc8GFfoVbkUxDpXB0t6AY7az7w3AGsDj/S7jbLgVz9nDynr7bJFNS+yCi7g3
         bnLw==
X-Forwarded-Encrypted: i=1; AJvYcCWm83Gw1NtJHEozcybdBjBvhVocGj/zVDqEkuLtPwi65EI0LCHAWr68Kq8WW9ZR1MiWrcULs+xHp9+4e10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkD8oplcWS0/LHAGFgYJ7AH6q5ZqjWxYkGO6vEUTS2GXAE2b+j
	DBHA4ic0EVFl2yUv0WbaN3fZKNDC6hOzNMt96k5XRbYUxyi2jg1cjNK3HfBmMOOQNBrZyovCfpV
	LhiJGDyR5JODvksHKUog6f8RWJ5f6yzcZyZCrYI6grTuwEzh6Y6GAkfyxfKVEBQ==
X-Received: by 2002:a05:622a:5b8e:b0:458:2b7b:c45c with SMTP id d75a77b69052e-45b5e02c71dmr99988861cf.39.1727357983988;
        Thu, 26 Sep 2024 06:39:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlgkMdRbCIjZgM2jAU3EsasilPQSNVYQpC12otQiRQwzMqn0cbvcQHcFFaNZ2vnTph4U0i1A==
X-Received: by 2002:a05:622a:5b8e:b0:458:2b7b:c45c with SMTP id d75a77b69052e-45b5e02c71dmr99988491cf.39.1727357983497;
        Thu, 26 Sep 2024 06:39:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b526aac64sm25778181cf.92.2024.09.26.06.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 06:39:42 -0700 (PDT)
Date: Thu, 26 Sep 2024 09:39:39 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, jgg@ziepe.ca,
	leitao@debian.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mingo@redhat.com, rppt@kernel.org, syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] [mm?] WARNING in copy_huge_pmd
Message-ID: <ZvVkG4aSxS9rNoRd@x1n>
References: <66f15c8d.050a0220.c23dd.000f.GAE@google.com>
 <4f96130c-12b7-4afa-ada3-bec354576112@redhat.com>
 <ZvRBYpCrSZj9YZoF@x1n>
 <60e29e62-4864-4393-b899-01489ee73b91@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60e29e62-4864-4393-b899-01489ee73b91@redhat.com>

On Thu, Sep 26, 2024 at 12:48:19PM +0200, David Hildenbrand wrote:
> On 25.09.24 18:59, Peter Xu wrote:
> > On Tue, Sep 24, 2024 at 04:45:00PM +0200, David Hildenbrand wrote:
> > > On 23.09.24 14:18, syzbot wrote:
> > > > Hello,
> > > > 
> > > > syzbot found the following issue on:
> > > > 
> > > > HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
> > > > git tree:       upstream
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c36c27980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=e851828834875d6f
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=bf2c35fa302ebe3c7471
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12773080580000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ed5e9f980000
> > > > 
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/0e011ac37c93/disk-88264981.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/f5c65577e19e/vmlinux-88264981.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/984d963c8ea1/bzImage-88264981.xz
> > > > 
> > > > The issue was bisected to:
> > > > 
> > > > commit 75182022a0439788415b2dd1db3086e07aa506f7
> > > > Author: Peter Xu <peterx@redhat.com>
> > > > Date:   Mon Aug 26 20:43:51 2024 +0000
> > > > 
> > > >       mm/x86: support large pfn mappings
> > > > 
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17df9c27980000
> > > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=143f9c27980000
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=103f9c27980000
> > > > 
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com
> > > > Fixes: 75182022a043 ("mm/x86: support large pfn mappings")
> > > > 
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 1 PID: 5508 at mm/huge_memory.c:1602 copy_huge_pmd+0x102c/0x1c60 mm/huge_memory.c:1602
> > > 
> > > This is the
> > > 
> > > VM_WARN_ON_ONCE(is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd))
> > > 
> > > So we have a special-marked PMD in a COW mapping.
> > > 
> > > The reproducer seems to involve fuse, but not sure if that makes a
> > > difference here.
> > 
> > That chunk of code seems to be there only making sure the test won't get
> > blocked due to any fused based fs being stuck, via writting to the "abort"
> > file:
> > 
> >        snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
> >                 ent->d_name);
> >        int fd = open(abort, O_WRONLY);
> >        if (fd == -1) {
> >          continue;
> >        }
> >        if (write(fd, abort, 1) < 0) {
> >        }
> >        close(fd);
> > 
> > So far looks not relevant to this issue indeed.
> > 
> > Unfortunately I cannot reproduce it even with the reproducer.  So this one
> > is a bit tricky..
> > 
> > What confuses me yet is how that special bit is set, if it's only used so
> > far with vfio-pci, and this test doesn't seem to have it involved.
> > 
> > The test keeps invoking processes, then threads, doing concurrent accesses
> > over a few stuff (madvise, mremap, migrate_pages, munmap, etc.) on the
> > pre-mapped areas, but none of them seem to create new memory that can
> > provide hint on how special bit can start to occur.
> > 
> > I wonder if some of these operations can race in a way that mm can wrongly
> > create the special bit (alone with it being writable).. and then it could
> > be a historical bug, only captured by this patchset due to the newly added
> > WARN_ON_ONCE somehow, then it could mean that it's not the WRITE bit that
> > is not intended, but the SPECIAL bit altogether.
> 
> I assume you are missing a check for present/non-swap pmds. Assume you have
> a migration entry and end up using the special bit -- which is perfectly
> fine -- your code would assume it's a present PMD with the special bit set.
> 
> Maybe for the time being something like:
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0580ac9e47b9..e55efcad1e6c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1586,7 +1586,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct
> mm_struct *src_mm,
>         int ret = -ENOMEM;
> 
>         pmd = pmdp_get_lockless(src_pmd);
> -       if (unlikely(pmd_special(pmd))) {
> +       if (unlikely(pmd_present(pmd) && pmd_special(pmd))) {
>                 dst_ptl = pmd_lock(dst_mm, dst_pmd);
>                 src_ptl = pmd_lockptr(src_mm, src_pmd);
>                 spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);

Good catch!

I definitely overlooked it, and I did check the config has THP_MIGRATION
set indeed.  So it's very possible relevant.

Do you want to send a formal patch?  You can also push a branch with "#syz
test", looks like syzbot can constantly reproduce.

Thanks!

-- 
Peter Xu


