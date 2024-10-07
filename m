Return-Path: <linux-kernel+bounces-353388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731B4992D2C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1622AB2433F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8CD1D3560;
	Mon,  7 Oct 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCABMyHc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659741D3564
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307437; cv=none; b=YqUJKacv5bvDo3SOyCGqoR7ZAHIGoVIasAfxM6AlppebiqnyYbrZ9nswl3RCdoqc2iRFMY1ZZ/3D+WIftJDRhBkaCaqYbYtrV3JuJtM9MSu9F2/LRGylpQ+sCx/41U5+bpj/hCWMPeM5pT5VAYOlRf99Qh5M1Gx9s++7E0gWxTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307437; c=relaxed/simple;
	bh=l7PB8vmPFt0UC3cWpvhdxRfD+zy17/mAKmQGCajEi9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYezwpPwmeKwFBwJZE28LTNEc7VyQ5tui/JYs7aA7cZmzh/xoZEO2owfAIdr+KQnpWPuPhb8ulyReSDqDx1xdlaUo6LnNx2ppVhgFYBi3bZZYWIJOiorL4JifkfRu7kTg/NW2iuelr07URAPywXMi2yMInhNVicODoU8mVzxg8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCABMyHc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728307432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oss3ICSNrAKdOFGCKeG0o3dAFNOBHVsvSmNPB5Fkn9w=;
	b=QCABMyHcoXXvM7zd0aLO90RoHxEUJ47luk9ufxnZJGzgg4noqeBwUoNDayXj0bX0yVNSWQ
	Av7APqtE8Ifs6Hw0iWy9/9HfKWFXRF9Z+OVh/+4a0nK2bs3rC9FNHVIPANavx5yLkpecZ3
	tXs0G0Ferh6nm8KMPMysTBhEIs0w5wI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-fwxigLokN0eK35tm9o_CNQ-1; Mon, 07 Oct 2024 09:23:51 -0400
X-MC-Unique: fwxigLokN0eK35tm9o_CNQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a9b6181a99so1123563685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307430; x=1728912230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oss3ICSNrAKdOFGCKeG0o3dAFNOBHVsvSmNPB5Fkn9w=;
        b=WM8hxwSLFvh7tzKSa2DLnbItX4gOSw7zHtsy2sE66MMlE5oKnSvAXusvTQWTDlz9jk
         M0SI9zeK55sjGjV7/AYOMfr0FsZqCU6KJ3R0iAwDNl7S6EEiwMTaoTlVGFRRBCUdhRbe
         oGfRuQ66YTxZS2UqhLUu9ZIo6pyrJ3hRPRMrt21gbTV0596L5u+bXaRzrhvZFdqw6Acu
         u4Gs+SSe03c+lfw7v9EI01kW8nVFwLk+jGQUhKKhoqudB1ztxq5IswOzRspCfSIIgl7W
         AETJrbRCqv+K0oTzQaJCXRiuLPAxYKd0u6LXkp+FDZmV7py7RR2yRBakFC0EYnZLAhZx
         Yh6g==
X-Forwarded-Encrypted: i=1; AJvYcCVFAGGSQpjwkj/x7yI5FKKjyKH9c+wubrA9kl9jj9qYXuFiGSmy3K2MWYOSqoz6dgqEI9b5DnDjZ5YrREs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jh8ba77jFRB6q4pvCftuQlncdGQSV8HKGgw80cCkuQhQRqRX
	Jda6hX7VopP25/gs55fa9MQBdKGRALxzKqyDEw9KnYx9mdHqfDL1sgI1QbkVrxjyY7XaEtrvrHM
	JEyavf5GSjOVoei6w5bWLXaucOeU3jss8TLh12D+AfeHRknpWMXe/Pk7eBrpODQ==
X-Received: by 2002:a05:6214:2d4a:b0:6c1:8663:e8f0 with SMTP id 6a1803df08f44-6cb9a438d1emr180438126d6.28.1728307430599;
        Mon, 07 Oct 2024 06:23:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOwuVLJDMVviv8FvhVYRSLdM+vw/6uHZ/RtpIv7gJwA0MDjLHNEEhXPwvBiBNetWVJSwIfsg==
X-Received: by 2002:a05:6214:2d4a:b0:6c1:8663:e8f0 with SMTP id 6a1803df08f44-6cb9a438d1emr180437856d6.28.1728307430224;
        Mon, 07 Oct 2024 06:23:50 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46e267bsm25698446d6.46.2024.10.07.06.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:23:49 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:23:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: manas18244@iiitd.ac.in, Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] Fixes: null pointer dereference in
 pfnmap_lockdep_assert
Message-ID: <ZwPg4znfu2yn2Qqw@x1n>
References: <20241004-fix-null-deref-v3-1-f9459b1cc95f@iiitd.ac.in>
 <ZwAHFtAmMq9BNuGv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwAHFtAmMq9BNuGv@casper.infradead.org>

On Fri, Oct 04, 2024 at 04:17:42PM +0100, Matthew Wilcox wrote:
> On Fri, Oct 04, 2024 at 07:15:48PM +0530, Manas via B4 Relay wrote:
> > +++ b/mm/memory.c
> > @@ -6346,10 +6346,10 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
> >  static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
> >  {
> >  #ifdef CONFIG_LOCKDEP
> > -	struct address_space *mapping = vma->vm_file->f_mapping;
> > +	struct address_space *mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
> 
> Overly long and complex line.  Much simpler to write:
> 
> 	struct address_space *mapping = NULL;
> 
> 	if (vma->vm_file)
> 		mapping = vma->vm_file->f_mapping;
> 
> >  	if (mapping)
> > -		lockdep_assert(lockdep_is_held(&vma->vm_file->f_mapping->i_mmap_rwsem) ||
> > +		lockdep_assert(lockdep_is_held(&mapping->i_mmap_rwsem) ||
> >  			       lockdep_is_held(&vma->vm_mm->mmap_lock));
> >  	else
> >  		lockdep_assert(lockdep_is_held(&vma->vm_mm->mmap_lock));
> 
> This one should have been lockdep_assert_held(&vma->vm_mm->mmap_lock).
> 
> I'm not sure that the previous one is correct.  The
> lockdep_assert_held() macro is pretty careful about checking
> LOCK_STATE_NOT_HELD to avoid the LOCK_STATE_UNKNOWN possibility.
> But I'll leave that for Peter to fix.

Indeed..

Then looks like we could have quite a few other places in Linux that can
have used this wrong.. when the assert wants to check against either of the
two locks (one mutex or rcu read lock, for example) is held.

I'll send a patch after this one lands.

Thanks,

-- 
Peter Xu


