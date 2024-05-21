Return-Path: <linux-kernel+bounces-184680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E8B8CAA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FC41C21A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE9156766;
	Tue, 21 May 2024 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfDtXDG0"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE52209F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716282388; cv=none; b=tL3WzqZuKx/pHhBh1gpr/Hnc4SabesDiKl3mgAZTVGOC+85C3u6Py+rPKKdyyAK0gqzUq3b7xgXP5GyYpF2Wmcmjw/aQCo5YnJ94ZfSbaVWmJYQIvbuFa5XXtgj2dnTA6itDlJfGHysW7/B/UdHxZ2xbQfGKpGfuSlBUKtAMLnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716282388; c=relaxed/simple;
	bh=bsAhFihn815vBtTHR8DbQhKVT37veYmF+S7PhbmBdXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdOKY3kisZXf1JC2zMiIFbTmUELeAYJMbQpneiVudemF/+4vmyp9/e8JVIc7GJY6hVQnA0d+8q2cgAVo6ln4PublzJnei7yagB3K+QeZdE7wuJDbNN0xVoS0lRLeQWMDXCigSD4BvsqRd+FqsSRcZ2Dsq7UnIJx4zqKb88efAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfDtXDG0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354cd8da8b9so787857f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716282385; x=1716887185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMYY1KE/ZtKqUz0lxLzk49TxJFJt2lbdNgplL1dA484=;
        b=cfDtXDG099m9goonTvN5W8iYXDbnqWN6IoWRMRIymvSVEzsRctnmgnFV7C0LTg9i6Z
         sOiDlxDJSS7/wT7Sj+iros54L9ejCYkPeIP4SosF216bX6Q1jgibfM64IhO58lBgbTr1
         aymGocrJeszB6sm4I2w2AQt93hGxdc5SEt5bC3f5BWQQThqlMGK1xccWcHhP/RdZbGTp
         75CYoPqvnE4hzVtpHqwxhhjzHzXwM9nrQjL4soE1T5S4pX34RVurXJlymYbPBxC3ULL6
         WqXkR5yYTIT9/gdypWYFOOXhMV/NwfUdZyum0vsQJSGr8Ycr9GDW6e2bloljmva1aLXU
         s96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716282385; x=1716887185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMYY1KE/ZtKqUz0lxLzk49TxJFJt2lbdNgplL1dA484=;
        b=cllsMTYFWTxVymo3odKkTrbcqQCu2Dvkkkz9KznAJTP0TCsYGKg9h/g/2qpUChkUso
         jB2snqooSX4PmKEKFdvSKtqjdGMx+goZFsfikunGwyXJJpyOREmiwwKJfC91UvHqJgCp
         +X1flkQTCEhRlsPXMUOMCo44kqbwuFj+y0TANT39p56MBdWd55ICDCn+nhh55xFGO6mH
         yrP0S4onJdJjAH19sLS9vYjenHRgwGOiLSZACFxAGLpVBqKVsPisQquvKRSqV769RrOJ
         /4xIzmbFaRtUKdIjKsNl4Jmte2bSb0LffZ0HkqJ8GjFhvlR3wNW479g3e9kT0tYAqI2N
         qwyA==
X-Gm-Message-State: AOJu0YzZjDyCIAzFKacxpRt3NJD/fYrURSM69HvA1uOfrFSZ2H4sDMz0
	0VQiF32/lGet09/rPXcz8Zj/goxmwEI9xCKny16J5xuVKDoj6j7q02MgH4MZhg==
X-Google-Smtp-Source: AGHT+IHqJ0D1Y0alYMEKM4YqnGdv6JwZaQcHewLXB9jPc03xtcncpFKk1Dw9zFUsOpMdR6786VBPXg==
X-Received: by 2002:a5d:698d:0:b0:34d:354:b9ba with SMTP id ffacd0b85a97d-3504a73e32dmr21835351f8f.30.1716282384666;
        Tue, 21 May 2024 02:06:24 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bdbcsm31255495f8f.23.2024.05.21.02.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:06:24 -0700 (PDT)
Date: Tue, 21 May 2024 10:06:20 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, rostedt@goodmis.org
Subject: Re: [PATCH v1 1/2] mm/memory: cleanly support zeropage in
 vm_insert_page*(), vm_map_pages*() and vmf_insert_mixed()
Message-ID: <ZkxkDPnPiQzPEm-0@google.com>
References: <20240430204044.52755-1-david@redhat.com>
 <20240430204044.52755-2-david@redhat.com>
 <Zkdys7YKC5pe1vAu@google.com>
 <3decc6c8-9035-44d6-89c6-8d42a5e0bc40@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3decc6c8-9035-44d6-89c6-8d42a5e0bc40@redhat.com>

On Tue, May 21, 2024 at 10:25:43AM +0200, David Hildenbrand wrote:
> On 17.05.24 17:07, Vincent Donnefort wrote:
> > Hi David,
> > 
> > [...]
> > 
> > > -static int validate_page_before_insert(struct page *page)
> > > +static bool vm_mixed_zeropage_allowed(struct vm_area_struct *vma)
> > > +{
> > > +	VM_WARN_ON_ONCE(vma->vm_flags & VM_PFNMAP);
> > > +	/*
> > > +	 * Whoever wants to forbid the zeropage after some zeropages
> > > +	 * might already have been mapped has to scan the page tables and
> > > +	 * bail out on any zeropages. Zeropages in COW mappings can
> > > +	 * be unshared using FAULT_FLAG_UNSHARE faults.
> > > +	 */
> > > +	if (mm_forbids_zeropage(vma->vm_mm))
> > > +		return false;
> > > +	/* zeropages in COW mappings are common and unproblematic. */
> > > +	if (is_cow_mapping(vma->vm_flags))
> > > +		return true;
> > > +	/* Mappings that do not allow for writable PTEs are unproblematic. */
> > > +	if (!(vma->vm_flags & (VM_WRITE | VM_MAYWRITE)))
> > > +		return false;
> > 
> > Shouldn't we return true here?
> 
> Indeed, thanks! I wish we would have user in the tree already that could
> exercise that code path.

I have a patch ready to use this path from the memory map tracing! I can either
send it once this one is picked-up or you can add it to your series?

> 
> [...]
> 
> > > @@ -2043,7 +2085,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
> > >   	if (!page_count(page))
> > >   		return -EINVAL;
> > 
> > This test here prevents inserting the zero-page.
> 
> You mean the existing page_count() check? or the (wrong) vma->vm_flags check
> in vm_mixed_zeropage_allowed() ?

I meant this page_count() here. As a quick test, I removed that check (also fixed
the vm_flags above) and the zero-page was properly mapped!

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

