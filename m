Return-Path: <linux-kernel+bounces-355825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE82995797
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884731F26856
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ED52139D7;
	Tue,  8 Oct 2024 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXhnh1Er"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53DA8F6D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728415685; cv=none; b=BUnn6/9IToEW1CfIhndJjProqbzfK/IZ0EAV/OtdVmtVmpF9qjPKNJ7vEqZgxATqHNeMJNwph/PBj30f/v7lI6HT8sMNVeFuoxkItfEDYgED5pME157IUGXVwsv0/vwUShOe7hib3myK8Zsgr6ISiX9IyWzLfEYsZiD1N4fQ36I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728415685; c=relaxed/simple;
	bh=QqGDF6LV9cK7qR2Qdub7KLJfWHxYA1y4GpC69C5uiq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIix1shl/t1DrVIsUBAwlEoK+48piOW5/s8L28+E+CNxSoMlBSMsY3W+dIh7eVsmrzf96B/JkgSyDsluGQdvZVv7m31nffhDwkc65Q6pS2BMGExwQ4zFMq7OQCPoO5EFKpFvcJ52MVDBFyqceHICVO1UWO7ucA2yac70zrhm7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXhnh1Er; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728415682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fgdm7/WNpH2fOEVAfJT/aMekvhr9vTIvKLAK3NmYz9Q=;
	b=VXhnh1ErVMpTs7jduZq8ZnYzYaPGd2+AdhYimxWWEcH5Z0sNF18vPuh+0twZ152OS61TW6
	bl0y9KZJxUawSNgkMGrkG3DtC+90ZGMGiYxIPpXApWZjGKBFeUxPDY8Lfy1Uvz1UPOCwEy
	Mmm5UWOlvhAKTFg+PeChbZPT0pbvDnk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-cKxHfEt3MLSjXg7Xk-rpYg-1; Tue, 08 Oct 2024 15:27:59 -0400
X-MC-Unique: cKxHfEt3MLSjXg7Xk-rpYg-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1925177fdso69052735ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 12:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728415679; x=1729020479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fgdm7/WNpH2fOEVAfJT/aMekvhr9vTIvKLAK3NmYz9Q=;
        b=TVnCM0muo/TlH/5/yMrIAfAM8Mpzvomm3+93AEEY85SSpkV8wSCnO2BINS9UK+qyjx
         MEYUAyj09+T3+jsRuHZzd/G9WiJfQ0GAWxSJYw+ntAckqHbsBtJFCxAdk28x/odZ3TcW
         4JTyFcwtf5GUWQ3Jq8AXZt+tSVSAsYu2Hyexx9zUMDZ1s2cPaTfOOKQRJgCLLVlCSDJV
         maFULoU4d1O86GUBcYnvEmabqvVHB8LIGR4DqgGtpXtTzPaKEO+RAsswIY3gCiMfHNhY
         X0egArminFav8p44fXg5jdSZCk3x++uzkzt6N0BQrkWpigetQM8PpbepuixG5pnRzb0K
         OPRw==
X-Forwarded-Encrypted: i=1; AJvYcCUj/9TL/n1hryNJEkSdHbqlj8CWEewSzjWF/lISTdTmEwlTP0KYH5bc1kipS9Zbp77jZZg582V7dWou5jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkQ6KD/M1h48ITvjsLQl/XuqWsYVi0Ektchd54ZjFUwLMlYQm
	K92EdVhOJBnTKMltKx77r+7/gMp6/eZERzBWv7sqPn+zfOwmwOR+nrcg1GOj94sy/a64IrFOLGs
	/tsdGBQLOsWOggKp3UMbptwRhlIEP3P4BzQN4gkGoucTHnhXRayamz6twcrQ6vQ==
X-Received: by 2002:a05:6e02:1749:b0:3a0:9159:1561 with SMTP id e9e14a558f8ab-3a375976f16mr164699825ab.2.1728415679004;
        Tue, 08 Oct 2024 12:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOrlPN0OBjaoyzoeuR83DLEaoJbAwQdPg/qTNTdghhg8aT6BSs3sUmTR5kRLlGq5Rj1q8yCw==
X-Received: by 2002:a05:6e02:1749:b0:3a0:9159:1561 with SMTP id e9e14a558f8ab-3a375976f16mr164699515ab.2.1728415678567;
        Tue, 08 Oct 2024 12:27:58 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a7fbe19sm19960085ab.34.2024.10.08.12.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 12:27:57 -0700 (PDT)
Date: Tue, 8 Oct 2024 15:27:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: manas18244@iiitd.ac.in, Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] Fixes: null pointer dereference in
 pfnmap_lockdep_assert
Message-ID: <ZwWHuncchhMyefEe@x1n>
References: <20241004-fix-null-deref-v3-1-f9459b1cc95f@iiitd.ac.in>
 <ZwAHFtAmMq9BNuGv@casper.infradead.org>
 <ZwPg4znfu2yn2Qqw@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwPg4znfu2yn2Qqw@x1n>

On Mon, Oct 07, 2024 at 09:23:47AM -0400, Peter Xu wrote:
> On Fri, Oct 04, 2024 at 04:17:42PM +0100, Matthew Wilcox wrote:
> > On Fri, Oct 04, 2024 at 07:15:48PM +0530, Manas via B4 Relay wrote:
> > > +++ b/mm/memory.c
> > > @@ -6346,10 +6346,10 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
> > >  static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
> > >  {
> > >  #ifdef CONFIG_LOCKDEP
> > > -	struct address_space *mapping = vma->vm_file->f_mapping;
> > > +	struct address_space *mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
> > 
> > Overly long and complex line.  Much simpler to write:
> > 
> > 	struct address_space *mapping = NULL;
> > 
> > 	if (vma->vm_file)
> > 		mapping = vma->vm_file->f_mapping;
> > 
> > >  	if (mapping)
> > > -		lockdep_assert(lockdep_is_held(&vma->vm_file->f_mapping->i_mmap_rwsem) ||
> > > +		lockdep_assert(lockdep_is_held(&mapping->i_mmap_rwsem) ||
> > >  			       lockdep_is_held(&vma->vm_mm->mmap_lock));
> > >  	else
> > >  		lockdep_assert(lockdep_is_held(&vma->vm_mm->mmap_lock));
> > 
> > This one should have been lockdep_assert_held(&vma->vm_mm->mmap_lock).
> > 
> > I'm not sure that the previous one is correct.  The
> > lockdep_assert_held() macro is pretty careful about checking
> > LOCK_STATE_NOT_HELD to avoid the LOCK_STATE_UNKNOWN possibility.
> > But I'll leave that for Peter to fix.
> 
> Indeed..
> 
> Then looks like we could have quite a few other places in Linux that can
> have used this wrong.. when the assert wants to check against either of the
> two locks (one mutex or rcu read lock, for example) is held.
> 
> I'll send a patch after this one lands.

Just to follow this up and leave a record: I had a closer look today and
then quickly I found above should be all fine (similar to all kernel usages
like this, for example, rcu_dereference_check()).

The trick is LOCK_STATE_NOT_HELD is defined as 0:

#define LOCK_STATE_UNKNOWN	-1
#define LOCK_STATE_NOT_HELD	0
#define LOCK_STATE_HELD		1

So this:

#define lockdep_assert_held(l)		\
	lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)

Is the same to:

#define lockdep_assert_held(l)		\
	lockdep_assert(lockdep_is_held(l))

The lockdep_assert() was introduced exactly for such >1 lock assertion use
cases, in this commit:

commit d19c81378829e5d774c951219c5a973965b9202c
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon Aug 2 18:59:56 2021 +0800

    locking/lockdep: Provide lockdep_assert{,_once}() helpers

    Extract lockdep_assert{,_once}() helpers to more easily write composite
    assertions like, for example:

            lockdep_assert(lockdep_is_held(&drm_device.master_mutex) ||
                           lockdep_is_held(&drm_file.master_lookup_lock));

Thanks,

-- 
Peter Xu


