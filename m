Return-Path: <linux-kernel+bounces-402436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2669C2779
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD3BB21BF6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C3D1E203F;
	Fri,  8 Nov 2024 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/qXkqFR"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8721C1F18
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104787; cv=none; b=pF9R7zsZq/GqtNskCxZWqweepHUlXKS5HZZHXojVzcUZ3+2Wo8CbGVFVVLDwDP/l0e7/d8TUWnrE2Lm8ORx5Nhs+AlUYtEKmnN2HVBcOJh7EOl+FSV0xYJaJT0OhT9TZn5QZ/8HOUy9no/fmqCu14WRIoZATCseKANXAEi27arQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104787; c=relaxed/simple;
	bh=UygLOv+JUt92myeHc27Sh28ikMQA4IRgIT07HWTqcPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNVyE6cB0Z4Dj6SL5A0+r6qdxdu2OW69s07aoxFl2M3lEo8GqkaAY9AiKkXnsR9qmY+L8sXyAD8vxjie+h2o8nt/xVucreXOjJoMalp48Qmel1kZDkqXAkraB16hwymkAVvvh6giLuWqLYFbYsV9i77sUT18f9hYeo083gAMP7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h/qXkqFR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c8ac50b79so41875ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 14:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731104785; x=1731709585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yC7bGxcefDbk+7WyZ9otLUL4XzSrlII+Dwdq+voZO10=;
        b=h/qXkqFRAOtrbNLVQfS4MsVXSxFo4qHpfH1YUV0sCwNGU1Jyexwidw6Jn5/5PQsygx
         KKD8DXeeCjeAPmzB9ob4ufmEdzCV69UK12nV/F896g7oEipMuoawNSY1A+YXuVGUtXts
         gJ/A+f2o0R0SY0JH/t3IcuC5wiHwgjSGoy0UrxEdKOrZoPjVyuICGPcujHmBAZFUCROA
         sXsuPB4LCdbOGVuuk5vlAsdHAi2yQGssGm1NmFOpKC7XLzhRj7IVjYOqusVidUNg1cj/
         z7gtnqQ6g1JMe7l4aMroozxy+ygG43uAJ9YObgj6+wUDdkDpE7CiiC55ZuATVMBDYWOe
         ubkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731104785; x=1731709585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yC7bGxcefDbk+7WyZ9otLUL4XzSrlII+Dwdq+voZO10=;
        b=nvBeA4Gx8RN8jO06oVdqFKozuBrfJt5g80w1GaCVE8EvC/ynrz4s5j6BAXFGz4E6Om
         SCKH4lHP4wM6GP+iE6c8geuL0AW56S2uFqHsl+QMBiwlqSNmgDKGEf6sd3nM0gOanAMO
         YOETc6SAoUcw6Eb+8hcHez0L2UVbsfiWnRnzy7diAABhsPNC8z1IgKLaTbbPqk/yyfEH
         cj1Kwif1+AFDU8S4ppK8P6UzgegLlGFVP8HZmpvdo26GPoXuuXtn2eguUQLNkL/00Kro
         BcYaaZGM6hR8FokrPjovEDsYqk9uCoZYJR0e2zzEMWxa28GBsWbSpqwez3Vd1j7JTZP3
         69qA==
X-Forwarded-Encrypted: i=1; AJvYcCVndbgZ0yyavGXMGa3b9IK8zrQfSB+QyGwzEv4FE+Xcdg7pVa/HI2jOrLyuls5R8QXVPF603kVbxLji2p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAoiYoQzT/XzEa9JsSWsMlyec020GHQzzx6OGtDH9MC2K6SEI
	jnK4vTd2hiZXYtjnkgC9SQhC2o17bZWU6uUHmRg4X3qkgd5aszJYcrhRajVAjg==
X-Gm-Gg: ASbGncsxIsyd0+IugLYJHxb/F3SHJpmgOKF5xSvRwG8GF2y5N8xBZmrEBYXCl+urZKJ
	9YfilbS2CD5lfeCCv4xAUEG06fbT2lU2fMoWC8EWNRMQlmItLsi//lOjnhuBwSQNw5/LzzjWqp2
	wDRRt/+M1MzB9VkAZt1PXxaQGwJIx9FaVIHCszdpVk/kO1NlMoOmJLMYCL9vgfM30h9goORd8tP
	ggnib/yimLnsC0CXiIPv8lfgJhY7w675FYtaJ68xQqVAQQy7ehMlwI1e2O18wCOIh1Cz25ijoBA
	wZ/sbpvj0hfHKms=
X-Google-Smtp-Source: AGHT+IH0PMHXcjRO+22hRHY8/ERNS13jQl8EO3Kxxsh3AJ6gqSdaC4Y+6pnyz+DhkhbQeUB2yA/Nmw==
X-Received: by 2002:a17:902:e5cb:b0:20c:79f1:fee2 with SMTP id d9443c01a7336-2118dea06d9mr748955ad.10.1731104785326;
        Fri, 08 Nov 2024 14:26:25 -0800 (PST)
Received: from google.com (180.145.227.35.bc.googleusercontent.com. [35.227.145.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e413d0sm35570965ad.164.2024.11.08.14.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 14:26:24 -0800 (PST)
Date: Fri, 8 Nov 2024 22:26:19 +0000
From: Carlos Llamas <cmllamas@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	David Hildenbrand <david@redhat.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v3 2/8] binder: concurrent page installation
Message-ID: <Zy6QC71iEy3w5FYA@google.com>
References: <20241108191057.3288442-1-cmllamas@google.com>
 <20241108191057.3288442-3-cmllamas@google.com>
 <xpzec7tqe43sykvqtgrlh3furu7vn2nrnkjmv7odzy7ywd4lf6@hlawbgapxcfk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xpzec7tqe43sykvqtgrlh3furu7vn2nrnkjmv7odzy7ywd4lf6@hlawbgapxcfk>

On Fri, Nov 08, 2024 at 03:41:41PM -0500, Liam R. Howlett wrote:
> * Carlos Llamas <cmllamas@google.com> [241108 14:11]:
> > Allow multiple callers to install pages simultaneously by downgrading
> > the mmap_sem to non-exclusive mode.
> 
> Since we actually allow downgrading of a lock, it would be more clear to
> say that you are changing from a read lock to a write lock.  I was
> searching for the lock downgrade in this patch :)

ah, I can see how the wording here can be misleading. I'll rephrase that
to avoid confusion.

> > -	ret = vm_insert_page(alloc->vma, addr, page);
> > -	if (ret) {
> > +	mmap_read_lock(alloc->mm);
> 
> Ah, I debate bring this up, but you can do this without the mmap read
> lock.  You can use rcu and the per-vma locking like in the page fault
> path.  If you look at how that is done using the lock_vma_under_rcu()
> (mm/memory.c) then you can see that pages are installed today without
> the mmap locking (on some architectures - which includes x86_64 and
> arm64).

Right, per-vma locking is implemented in patch 7 of this series:
https://lore.kernel.org/all/20241108191057.3288442-8-cmllamas@google.com/

> userfaultfd had to do something like this as well, and created some
> abstraction to facilitate either mmap or rcu, based on the arch support.
> Going to rcu really helped performance there [1].  There was also a
> chance of the vma being missed, so it is checked again under the mmap
> read lock, but realistically that never happens and exists to ensure
> correctness.

hmm, if there are more users of this pattern in the future then perhaps
it might be worth adding a common helper?

> You also mention the shrinker and using the alloc->mutex, well zapping
> pages can also be done under the vma specific lock - if that helps?
> 
> Freeing page tables is different though, that needs more locking, but I
> don't think this is an issue for you.
> 
> [1]. https://lore.kernel.org/all/20240215182756.3448972-1-lokeshgidra@google.com/

ha, I was not aware of this. I'll have a look thanks.

> 
> > +	vma = vma_lookup(alloc->mm, addr);
> 
> Thank you for not saving a pointer anymore.

lol, thanks to you for initiating this effort!

Cheers,
Carlos Llamas

