Return-Path: <linux-kernel+bounces-339450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC9898653F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1BE1C23BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D9E4F899;
	Wed, 25 Sep 2024 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+UktMrO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2194644E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727283566; cv=none; b=nLCP20Wk6QsIPKWXTFcsouumRaf1uVC1qyT3Bbc2WmHuo2Q7VNUc1ZlYpjf8Nh1neaKpDMAcIzTjaZMj+PHjYc9SWffKK63+G5j3qE2cUSLvuUJ5UMeQKoj+s7VSvK+gbNze8+IZt3KwDjL820qh/lV24l2E7M/c/Tsj29GjVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727283566; c=relaxed/simple;
	bh=GO5iJvL+PpFwPgo4xScIPDw6hFXYSSvqrFheASwOea8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc+6XXpRVk2cDX2/SqODwIjUfuY4HE8HRxXJ/s3rXqbveCVNEXsPXmAimzCVg8ec1DpcoTSJR1mSIUHWe1Nnkz0hdW7EnB9USGa7AEeASZDD9/ZREEigvogPj0ORoSuUXXS2lAQphXBjiO5Fgys1ez32a1h8xSXJZZNVwngFs9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+UktMrO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727283563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUA9LXbkN391EUYxjsESS3z+vG+hLybL/x8qsNWRo6s=;
	b=b+UktMrOJ3sss4hl1SiCHuT40H4Z/C3z23RGvRl0fG902ulbZFTSo7Bo1UWidPhotjOASK
	vtt3JoSGH2kPcCewdaQeDlyIHne/wRTUHch96DRgZ6HxQk6dW57v7JYVHzjQdCQSoDEM89
	GdS0HZpneRoiBDfAmz+QWYWXoaoGoSk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-OO3EZDMPNluEXOO0XooK5g-1; Wed, 25 Sep 2024 12:59:22 -0400
X-MC-Unique: OO3EZDMPNluEXOO0XooK5g-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-718ea791e44so207877b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727283561; x=1727888361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUA9LXbkN391EUYxjsESS3z+vG+hLybL/x8qsNWRo6s=;
        b=AgpaR9iu2APF+BafMO0l0tA+EyfCNN1kSt73eDo0qTV9UndW2oVP3NpH3gJ95wURKo
         O+pQBxOPTnJEapicWV3O1YdV4pjZlgRQr29HgDxw+z3NDP95tj03vc085Jn2tB1FZ/t/
         TXoYfY+benmAfYHjdqwGm9mvt3SsQ3GZs3KLaVF3khe1uMLGC2uVnzXCP7BDpPHuVx/3
         1G0cNSSqtSDal+9UcqJnspHfVy3Wmy8k0b8jQy6ZbznEsURUHDZGAHoMZ15aN1xRkuet
         BTFboX4VezhEeMFqaSmOQQts06bHvICk8z0WdjQ/Dtywyq9y8RMMaGKjQUEOJPvC/R3B
         +Kkg==
X-Forwarded-Encrypted: i=1; AJvYcCU9puEwy7DWK6cj5wddsZGmCsrTbaWrckMtAB6Gcblwcvqu8waAT0S8FRRMQBJ9X5oT99TvnPFItKAbFX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDh4lRWkYDpIiMGbt0S71A8hgme1hopa9IdFjlw9ICIWhPKFBc
	DV5odR2LwMPxoJ9wScZK6h10ZCQwGITiH5s928LXhXZ0A5rCEGVL1RDdg2N1yTamZQUcICsi1QT
	v9bXufPMk0zqgwanMNjQXamve1mvCfMOtSPd0ECSLXkVYsfU9FS4la7k1dXzVUA==
X-Received: by 2002:a05:6a00:23c3:b0:719:8f48:ff00 with SMTP id d2e1a72fcca58-71b0aadee07mr4329480b3a.15.1727283560948;
        Wed, 25 Sep 2024 09:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5v6SWA5OsXCNldz7Hi+0GCMfYUPOK1lRv7vpdkJLj4uqGyXW3gFDGEVZxA9yeYM+T6sjk3Q==
X-Received: by 2002:a05:6a00:23c3:b0:719:8f48:ff00 with SMTP id d2e1a72fcca58-71b0aadee07mr4329461b3a.15.1727283560596;
        Wed, 25 Sep 2024 09:59:20 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c30827sm2922964a12.18.2024.09.25.09.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:59:20 -0700 (PDT)
Date: Wed, 25 Sep 2024 12:59:14 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, jgg@ziepe.ca,
	leitao@debian.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mingo@redhat.com, rppt@kernel.org, syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] [mm?] WARNING in copy_huge_pmd
Message-ID: <ZvRBYpCrSZj9YZoF@x1n>
References: <66f15c8d.050a0220.c23dd.000f.GAE@google.com>
 <4f96130c-12b7-4afa-ada3-bec354576112@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f96130c-12b7-4afa-ada3-bec354576112@redhat.com>

On Tue, Sep 24, 2024 at 04:45:00PM +0200, David Hildenbrand wrote:
> On 23.09.24 14:18, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c36c27980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e851828834875d6f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=bf2c35fa302ebe3c7471
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12773080580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ed5e9f980000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/0e011ac37c93/disk-88264981.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/f5c65577e19e/vmlinux-88264981.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/984d963c8ea1/bzImage-88264981.xz
> > 
> > The issue was bisected to:
> > 
> > commit 75182022a0439788415b2dd1db3086e07aa506f7
> > Author: Peter Xu <peterx@redhat.com>
> > Date:   Mon Aug 26 20:43:51 2024 +0000
> > 
> >      mm/x86: support large pfn mappings
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17df9c27980000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=143f9c27980000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=103f9c27980000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com
> > Fixes: 75182022a043 ("mm/x86: support large pfn mappings")
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 5508 at mm/huge_memory.c:1602 copy_huge_pmd+0x102c/0x1c60 mm/huge_memory.c:1602
> 
> This is the
> 
> VM_WARN_ON_ONCE(is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd))
> 
> So we have a special-marked PMD in a COW mapping.
> 
> The reproducer seems to involve fuse, but not sure if that makes a
> difference here.

That chunk of code seems to be there only making sure the test won't get
blocked due to any fused based fs being stuck, via writting to the "abort"
file:

      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd = open(abort, O_WRONLY);
      if (fd == -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);

So far looks not relevant to this issue indeed.

Unfortunately I cannot reproduce it even with the reproducer.  So this one
is a bit tricky..

What confuses me yet is how that special bit is set, if it's only used so
far with vfio-pci, and this test doesn't seem to have it involved.

The test keeps invoking processes, then threads, doing concurrent accesses
over a few stuff (madvise, mremap, migrate_pages, munmap, etc.) on the
pre-mapped areas, but none of them seem to create new memory that can
provide hint on how special bit can start to occur.

I wonder if some of these operations can race in a way that mm can wrongly
create the special bit (alone with it being writable).. and then it could
be a historical bug, only captured by this patchset due to the newly added
WARN_ON_ONCE somehow, then it could mean that it's not the WRITE bit that
is not intended, but the SPECIAL bit altogether.

Thanks,

-- 
Peter Xu


