Return-Path: <linux-kernel+bounces-211025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6CD904C41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B656B23B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F9D1649BE;
	Wed, 12 Jun 2024 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLcdgR8O"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070EA1649D9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175709; cv=none; b=myLyM2QVWQ5ZPudv5U7IRsIlelBIL9A2zrnju9IkfGM62MolGV+78tBULEwmpq7JQpvsGUWw6dsx8P1YjedJ8ctDbHgf+JBBHDtLoN9/b1UnWmXU50uQcw5wYG+/7RocDfSVZXu7C0pAqt2yA9yvM8094EAjFoWKAyipmDgUwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175709; c=relaxed/simple;
	bh=FJCoOW4yGo4etWOi6yCPRyJjAQ2QtPwcw1bo0tKaYis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc6AuEhIYd38ZRnPcendR1NVC99ZvYpi+mwCbvfSkfFY1MoqJ7EOxiF9hVZVSk4nVf8T1dJNL5S5N3kc0rbtnyB/eK+eb1YxyNLojwS82XkHCvSG3NM2dxErXPqzhd9nekDo0cFAGX4pwPaU5Y4YNJGEGDNTqJURqkDFW5XUBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLcdgR8O; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c72d6d5f3so4830869a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718175706; x=1718780506; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZWb2w/0OFEI08wSIySsA4c0/SlbB29gBCLByPB2Zh8=;
        b=JLcdgR8O+SEByjLQa7KuGegRahFWZLbB2SEIlbji/ntjeWqkyYUJPOuWbz6ZHDIqS0
         46Frs1HY/n7PqhVJlN+XyiFrF0/buu1NvMOV8BwuDdGcoEDwvOiH1pzoo7ESDVQl2kw9
         QxuUbGGCh+7FsEOMsY7YG3HMA+0d207nUVFIX2elAq3rJM0q6Wy75YLlG/iKFhxSP2HU
         fpXd218Ke5fQ1vSvmmgN0oUlK9y0RUwj2mwxr2nRwI2vCFFjZ3Eez0tuFigGw2gWLPzZ
         MYnH3dEWzBqR4lcoGqwVQE7qrQlk73Ylm7Zs+GwSQh/3PWi5NGVLcIiyVM0jP3VOJgs0
         zXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718175706; x=1718780506;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZWb2w/0OFEI08wSIySsA4c0/SlbB29gBCLByPB2Zh8=;
        b=Rs60wlD5hCXavwVNUL1/QewgJOgcsrPMXWSZJvTGxhT/JJw/M77OpE9zYm7cWdH1Gr
         9obgVvadwVG7gkVj+t5ycrlQNtfmIf+sZ+zHrgoep0oYvrv3w7ovp/bYtOTjCA3WV0lS
         NVEzVa3Okchn/bqckatXaAV+UpUQozuLVc03J386T1D7vrD0HvfEg7EnyyhUgyKryF8u
         Z3mLwtvAg/1ZzHyd0y1EF19Ka+RsktJsL5HRgX1pNGVloHOMyNNFE5keOKREdSrmgWPv
         NZTcKINCERNR9+v6LXMr/DUY/8l7O6burW6uUeDJNT/Kt599tV8EBrq0Ih6rZKwrM8+g
         3yfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ymGhHMm/j29zS667KR3ig+BfAjbfL00GoZSskkH9VAcwskgYHsWZ6qeSlK/TjaO8Chw0r5xUwiO2SLgz7ZycYRdsbQ/uXdNEbGrw
X-Gm-Message-State: AOJu0YzGQ8WJhqDclrbhsr/HKsnEPqyITH+BCMndziqp6LZyiM04gUFb
	aAhP+SxTi30Grxsur4Rc9CyikqsI9K7CQel7E+tSAbiQZb+yBseY
X-Google-Smtp-Source: AGHT+IEv6+Oc78NKNWzu+X/qVCIvMEWWddDcJq63Bl4+Z+rURzKK9VufbNW/KtVVgGXgkIaV6IO60w==
X-Received: by 2002:a05:6402:3086:b0:57c:677a:a941 with SMTP id 4fb4d7f45d1cf-57caaac68e0mr382554a12.40.1718175705832;
        Wed, 12 Jun 2024 00:01:45 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae229712sm10543736a12.81.2024.06.12.00.01.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2024 00:01:45 -0700 (PDT)
Date: Wed, 12 Jun 2024 07:01:44 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 2/2] mm/highmem: make nr_free_highpages() return
 "unsigned long"
Message-ID: <20240612070144.q6rpbq2hkwtielav@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240607083711.62833-1-david@redhat.com>
 <20240607083711.62833-3-david@redhat.com>
 <ZmZ1x6QQYPFSOd7O@localhost.localdomain>
 <99073d55-5b18-4ed2-b860-8c09e056f585@redhat.com>
 <20240611005636.g6525rkqpos43yds@master>
 <04b3dda2-c6a8-4f26-90b8-75fe7580d63e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b3dda2-c6a8-4f26-90b8-75fe7580d63e@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Jun 11, 2024 at 11:20:00AM +0200, David Hildenbrand wrote:
>On 11.06.24 02:56, Wei Yang wrote:
>> On Mon, Jun 10, 2024 at 10:22:49AM +0200, David Hildenbrand wrote:
>> > On 10.06.24 05:40, Oscar Salvador wrote:
>> > > On Fri, Jun 07, 2024 at 10:37:11AM +0200, David Hildenbrand wrote:
>> > > > It looks rather weird that totalhigh_pages() returns an
>> > > > "unsigned long" but nr_free_highpages() returns an "unsigned int".
>> > > > 
>> > > > Let's return an "unsigned long" from nr_free_highpages() to be
>> > > > consistent.
>> > > > 
>> > > > While at it, use a plain "0" instead of a "0UL" in the !CONFIG_HIGHMEM
>> > > > totalhigh_pages() implementation, to make these look alike as well.
>> > > > 
>> > > > Signed-off-by: David Hildenbrand <david@redhat.com>
>> > > ...
>> > > > -static inline unsigned int nr_free_highpages(void) { return 0; }
>> > > > -static inline unsigned long totalhigh_pages(void) { return 0UL; }
>> > > > +static inline unsigned long nr_free_highpages(void) { return 0; }
>> > > > +static inline unsigned long totalhigh_pages(void) { return 0; }
>> > > 
>> > > Although I doubt it has any consequences, I would just leave them both with UL,
>> > > so the return type is consistent with what we are returning.
>> > 
>> > These suffixes are only required when using constants that would not fit
>> > into the native (int) type, or converting from that native (int) type to
>> > something else automatically by the compiler would mess things up (for example,
>> > undesired sign extension). For 0 that is certainly impossible :)
>> > 
>> > 
>> > That's also the reason why in include/linux we now have:
>> > 
>> > t14s: ~/git/linux/include/linux $ git grep "return 0UL;"
>> > skbuff.h:       return 0UL;
>> > uaccess.h:static inline unsigned long user_access_save(void) { return 0UL; }
>> > t14s: ~/git/linux/include/linux $ git grep "0UL;"
>> > bitmap.h:               *dst = ~0UL;
>> > dax.h:          return ~0UL;
>> > mtd/map.h:                      r.x[i] = ~0UL;
>> > netfilter.h:    return ((ul1[0] ^ ul2[0]) | (ul1[1] ^ ul2[1])) == 0UL;
>> > skbuff.h:       return 0UL;
>> > uaccess.h:static inline unsigned long user_access_save(void) { return 0UL; }
>> > 
>> > 
>> > ... compared to a long list if "unsigned long" functions that simply "return 0;"
>> > 
>> 
>> Seems this is the current status.
>> 
>> Then my question is do we have a guide line for this? Or 0 is the special
>> case? Sounds positive value has no sign extension problem. If we need to
>> return 1, we suppose to use 1 or 1UL? I found myself confused.
>> 
>> I grepped "return 1" and do find some cases without UL:
>> 
>> backing-dev.h: wb_stat_error() return 1 for unsigned long.
>> pgtable.h: pte_batch_hint() return 1 for unsigned int.
>> 
>> So the guide line is for positive value, it is not necessary to use UL?
>
>I think when returning simple values (0/1/-1), we really don't need these
>suffices at all. The standard says "The type of an integer constant is the
>first of the corresponding list in which its value can be represented.". I
>thought it would always use an "int", but that is not the case.
>
>So, if we use "-1", the compiler will use an "int", and sign extension to
>"unsigned" long will do the right thing.
>
>Simple test:
>
>-1 results in: 0xffffffffffffffff
>-1U results in: 0xffffffff
>-1UL results in: 0xffffffffffffffff
>0xffffffff results in: 0xffffffff
>0xffffffffU results in: 0xffffffff
>0xffffffffUL results in: 0xffffffff
>~0xffffffff results in: 0x0
>~0xffffffffU results in: 0x0
>~0xffffffffUL results in: 0xffffffff00000000
>0xffffffffffffffff results in: 0xffffffffffffffff
>0xffffffffffffffffU results in: 0xffffffffffffffff

I expect this to be 0xffffffff. Why this extend it to a UL?

>0xffffffffffffffffUL results in: 0xffffffffffffffff
>
>
>I thought that "0xffffffff" could be a problem (sign-extending to
>0xffffffffffffffff), but that does not seem to be the case -- likely using
>"unsigned int" as type. Also, I'm surprised that 0xffffffffffffffffU works as
>expected, I would have thought the "U" would make the compiler complain about
>the value not fitting into an unsigned int.
>
>
>When only returning values, the compiler usually does the right thing. Only
>when performing operations on the constant (see ~ example above), we might
>have to use the suffixes, depending on the intended outcome.
>

Looks the guide line is

* no need to put suffix on return value
* add suffix when performing operations, like ~, <<

>-- 
>Cheers,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

