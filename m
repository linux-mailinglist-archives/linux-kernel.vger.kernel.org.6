Return-Path: <linux-kernel+bounces-350291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 489919902EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F7FB21B79
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4760C15C142;
	Fri,  4 Oct 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bE0jJOSB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3828158531
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045001; cv=none; b=l5j5hbwDETppmGKd47EKOPEz184/mzNf+FE8qp1Lw/NeNM0BuKhKrz2OxFLIpmZ/f0861K0omvyWwdGLdhY1+nWets+v6zWjN0qeQSdL9lGEQDET87RwVnSToJ2sE+4+F++LOHBxZlIo/zQ5GR1y/VIgJtfSwL1lyNxuSHXsoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045001; c=relaxed/simple;
	bh=3TGnwqe6pH6yzjo+/5S3ndlehEYz7X5DL5wyZMzf4Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YloxPRW5lh2t9jQ/GdxaD5I4y2U2XUCGDg8wVw5Ativ0+aN/XiONKfFUWQAx9dPp8x+Dn2YvJnXhRtg0ZktmvmNSLSATYvNhqTPJH72jMsB+0HmZ+o/4+/A/B83rre4snfS+dYZkHho6uo68Wb04LoxoaY3L/jWgmdRgjZqx/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bE0jJOSB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728044998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PAqCpbPcjTa60QGnKgX/pWA4eizlmYCszb/O3nJb7rs=;
	b=bE0jJOSBL4M7YH747RhuHi5+I5kobjiiVm867FY+OjvDTTKINQ6y3DC4NBN7J5QveVqkzF
	YjCyKO/4As6e8xeeJlaBDpnTmeoVMag3Qp4WmT+CUbdoREB29KqOtoPhTgAQk4IkfDtdK+
	vGNvcWW/rHC0NOGN8G423SGZeMhC/ns=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-6DL8YWvfNWK_hxBA_aGHFQ-1; Fri, 04 Oct 2024 08:29:57 -0400
X-MC-Unique: 6DL8YWvfNWK_hxBA_aGHFQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-831e873e4e4so185820439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 05:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728044995; x=1728649795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAqCpbPcjTa60QGnKgX/pWA4eizlmYCszb/O3nJb7rs=;
        b=qcGS0/WWJkIsXXrog3GRONeQWJI2BRp84jPF/zFrDsaTqzL5Lm1+ckhPrrRrrrCjAN
         GXOUY/UinT0AG6lFCaKWwSB/r/S0ZGMg5+SEZsSnqr5sFBDpTr/nZE5DvfcnhHUbiVZu
         rAMamP2VksPUTZZV11kLWdpUEHr0TQO2SLNdLn4GMx758JQEMCJr5YkKZuWQszRwCuW9
         mcNbFt3Mr52bIE3NEvKrr5icReAgWvpvlFMBxRbO/mR2pxrilsHzt1eZXDzyA4d4F7Mx
         nIfudsuH/t1sIS80fpIKR/4k+ugW1xyONJdgoY8WrXBQ9qpX2fQYy3wZoi19zT3L1wdf
         GE0w==
X-Forwarded-Encrypted: i=1; AJvYcCXNtKDP/2Jw7wumkvWk7TZFMvP9ENXXlP073rfPak/M7ojGsRkBi7KyNux1Og6BKXQnxjKtYTxslkbIews=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJwL2o9E21Hv13f0ENrGg3KVDOIhKZOOIc6JpZBFUz2cWP3dzO
	/TuQLKabULeGSRZaXDv1/pVj7PqSoW1ANRklR3cli80SjqxAcMOA12kNIydT01wDoWkq+hq803t
	n+eJiSdN/mWKlbGwNtZOyUuCdWOZLy+njpD1LbhaE+3wU73Uk98zQwotipP38hg==
X-Received: by 2002:a05:6602:2c8e:b0:82d:96a:84f4 with SMTP id ca18e2360f4ac-834f7c59281mr256758739f.1.1728044995423;
        Fri, 04 Oct 2024 05:29:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc6dhM6aGERdLCiIedy/mWB5gb7I1GfZLWBKkN1LewsT7P9eK/brRD8er9FJGqj4t1fIuKWg==
X-Received: by 2002:a05:6602:2c8e:b0:82d:96a:84f4 with SMTP id ca18e2360f4ac-834f7c59281mr256755639f.1.1728044994976;
        Fri, 04 Oct 2024 05:29:54 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834efcaeadasm73257639f.26.2024.10.04.05.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:29:54 -0700 (PDT)
Date: Fri, 4 Oct 2024 08:29:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Manas <manas18244@iiitd.ac.in>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fixes: null pointer dereference in pfnmap_lockdep_assert
Message-ID: <Zv_fvzALs9SNVnUn@x1n>
References: <20241003-fix-null-deref-v1-1-0a45df9d016a@iiitd.ac.in>
 <Zv7JPl_1mxNkvLQy@x1n>
 <x4zctv3fdymenonaao2vwsy6ldab6d6pfappdzepfcax6ycc4n@nx46w3lncvqr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <x4zctv3fdymenonaao2vwsy6ldab6d6pfappdzepfcax6ycc4n@nx46w3lncvqr>

On Fri, Oct 04, 2024 at 03:43:12PM +0530, Manas wrote:
> Hi Peter, thanks for reviewing.
> 
> On 03.10.2024 12:41, Peter Xu wrote:
> > On Thu, Oct 03, 2024 at 09:31:06PM +0530, Manas via B4 Relay wrote:
> > > From: Manas <manas18244@iiitd.ac.in>
> > > 
> > > syzbot has pointed to a possible null pointer dereference in
> > > pfnmap_lockdep_assert. vm_file member of vm_area_struct is being
> > > dereferenced without any checks.
> > > 
> > > This fix returns if vm_file member in vm_area_struct is NULL.
> > > 
> > > Reported-by: syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b
> > > ---
> > > This bug[1] triggers a general protection fault in follow_pfnmap_start
> > > function. An assertion pfnmap_lockdep_assert inside this function
> > > dereferences vm_file member of vm_area_struct. And panic gets triggered
> > > when vm_file is NULL.
> > > 
> > > This patch returns from the assertion pfnmap_lockdep_assert if vm_file
> > > is found to be NULL.
> > > 
> > > [1] https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b
> > > 
> > > Signed-off-by: Manas <manas18244@iiitd.ac.in>
> > 
> > Thanks for the patch!
> > 
> > > ---
> > >  mm/memory.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 2366578015ad..b152a95e543f 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -6346,6 +6346,9 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
> > >  static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
> > >  {
> > >  #ifdef CONFIG_LOCKDEP
> > > +	if (!vma->vm_file)
> > > +		return;
> > > +
> > 
> > Hmm I guess I wasn't careful enough here as I was mostly only thinking
> > about file mappings, but I just notice we have other pfnmaps like the vvar
> > mappings.. the mapping var can also already be reused later when available.
> > 
> > Logically even if !vm_file we can still check against mmap write lock.  So
> > would it be better to do this instead:
> > 
> >        struct address_space *mapping = vma->vm_file && vma->vm_file->f_mapping;
> > 
> This will lead to `-Wint-conversion` error in the assignment. We can either do a
> cast like the following:
> 
>         struct address_space *mapping = (struct address_space *)(vma->vm_file && vma->vm_file->f_mapping);
> 
> But I am not sure if it is the canonical way of doing it. It will also lead to
> warning about pointer from integer casting.
> 
> Or will a conditional like this work here?
> 
>         struct address_space *mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;

Sorry, that was a pretty stupid mistake of mine, just to show what I meant
without any compilation tests.  Yes this one.

Thanks,

> >        if (mapping)
> >                lockdep_assert(lockdep_is_held(&mapping->i_mmap_rwsem) ||
> >                               lockdep_is_held(&vma->vm_mm->mmap_lock));
> >        else
> >                lockdep_assert(lockdep_is_held(&vma->vm_mm->mmap_lock));
> > 
> > ?
> > 
> 
> > >  	struct address_space *mapping = vma->vm_file->f_mapping;
> > > 
> > >  	if (mapping)
> > > 
> > > ---
> > > base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> > > change-id: 20241003-fix-null-deref-6bfa0337efc3
> > > 
> > > Best regards,
> > > --
> > > Manas <manas18244@iiitd.ac.in>
> > > 
> > > 
> > > 
> > 
> > -- 
> > Peter Xu
> > 
> 
> -- 
> Manas
> 

-- 
Peter Xu


