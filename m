Return-Path: <linux-kernel+bounces-525963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE910A3F7DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CEF188095D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8368E214210;
	Fri, 21 Feb 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BddO19hh"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9043212FA1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149850; cv=none; b=g9kFUi/DbhilMKyDJDypwtneRox/F9SSr8Oyo91YZE26xMuC4padvtf32fyScc5UYGajpgP28oxbhX2Bd+2XX3R9LUPaIO+brrunavD+m75q5qek8hJ3gB3MF8l5sORWFZHg5xPDuu7ou3chi3KwZSvQCax0oLC7bWr2iXYdQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149850; c=relaxed/simple;
	bh=a0b8vh2weZa6N0zDcDKvMXH11KDB83NoUPOYB696ja0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COKL/3VVZgNgX4nD1JG0yUDdWo/X453RVe0nwyMTKFDqj9QxIeI0KjHHzecWuU1fykQPfIYE7nv8H7se0j8GWacAgEWFQnG0VxPoGM1nTnu5Y03v3Ns7Duo/MBxM6DEfGXzjlo3fgpAYpiva7w+9RqAwPjWERyD6D9ebSiHxGMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BddO19hh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abbae92be71so258003666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740149847; x=1740754647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTn14//Twzxa7bbEpoUNqfHWIloQboaDypqrRQwa0yM=;
        b=BddO19hhSNL57N5kstrgk8Cm4hmutch2dpOCIo+D5cO99PJd4hUWtQLSEQqtSCJWHh
         d1jkYt5mlfUENpRzDVdFrmq3k+zW5vsXQWmJaJe6lcH8dZqxM+dfHTa2yLaaUN8FDota
         pxayQrHo9WuRI9yCYev87kNB1OYDPhmi4T1ykmPthbFlGxN3IxGN3TVrQkvZM2AhXcbX
         JoIUj944pv7Ozi8jukqpr275Sp8UX46nEybmunmGoyrxBZDNt6bnhzf9lpBZ+Mv1uUvW
         X6lDrcIL2U/E6Qhh0LMZSNNkptilouZYd3Qr5Ug22BcbmvIC2dvyscHNfRpghyydxaJQ
         t8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149847; x=1740754647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTn14//Twzxa7bbEpoUNqfHWIloQboaDypqrRQwa0yM=;
        b=FMgj2QvWz2X+qRsLObCUihpkhqq1z2cj0xMg5WtiqElUOaZMWa8tGb6CF6jvkC6+Z0
         MBDXV+vDjC1jNSc0x4dM8uvl+XVjL1J0v9rIYKwphR5tg6pwOzdxO+O3HRgIfBxZPSBq
         MW+8cgoaDGIBY0RvcA7KouvCTiSBj8d2EUTZMBCA+Ywy9OMbOhFMfn4w1PZZ/EDZGTVN
         JzG7ZofJBSndkFTWJ35GyiNiLVkwQKwCVfAKeVFZHUz8ePey7pbCigR3kT1bjtzRYO7Q
         76v+v3WyNoZkZbEnhCPWRhGpuvdzQWzJEX+3sb15f0oLhy43ldzSXlQW8gw0vUTAa9us
         xnFg==
X-Forwarded-Encrypted: i=1; AJvYcCUYEsMYkfsAlxL1n+K3DT5Po/4PAyewtsomxdoDg1TyHKG8TgoPoy7eBE2Hh1AI7SWyrXr00eBposJUWNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznhiYWk/in+Qs17u8v4ikXEDZuSR5o5kzQpwnrSBeWPCnRwMYd
	aMfMovyoztnz09eXwN8fr5cz9AGyImEmYJO6MMvGiziVYnQxkdye
X-Gm-Gg: ASbGnctsa8FbAccIyiBphHBT/JywLBIse6EmkfQIca8tkl2FTc01VcUSiU6zPWiehOI
	Ozv3oPpP+cWC08U5H7bh9tK9hzJdQw4c+dP6sHl05iYh93Bd0Hqatnd3folFHIlTNpnydloJpsR
	IbI9nYANEB6D1j5SQv3ACtfg7wwxlxZgHlMig/Y5fn1OTQdlCq68CQlBX1axPzxM0oMNu27/03M
	t5KhOl/qOem+Txt5lpvz+cDLvM6lfCoEO5wKCZTYEJO8Azbi1CVzZ+xT9uRDeP9ZrJtbtTgqsWA
	+EuHASmEA1iZ5cqtkojoNbP+1StKPA==
X-Google-Smtp-Source: AGHT+IGxWZkxw9GUj0Nhbp+zJvHQXsflhyYVRSHQyoqMZQm+7AVnlbhrji99aXWfqxrZmHbunm+mRw==
X-Received: by 2002:a05:6402:3223:b0:5e0:818a:5f4d with SMTP id 4fb4d7f45d1cf-5e0b72650b8mr8443196a12.28.1740149845950;
        Fri, 21 Feb 2025 06:57:25 -0800 (PST)
Received: from localhost ([2a02:587:860d:d0f9:2a79:b9e6:e503:40e9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abba278e1b1sm932855266b.99.2025.02.21.06.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:57:25 -0800 (PST)
Date: Fri, 21 Feb 2025 16:57:24 +0200
From: Lilith Gkini <lilithpgkini@gmail.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Fix Off-By-One in the While condition in
 on_freelist()
Message-ID: <Z7iUVJA-luvNaIac@Arch>
References: <Z7DHXVNJ5aVBM2WA@Arch>
 <Z7blsPJiOPTFWEL2@harry>
 <Z7b0CvTvcS47o7ie@harry>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7b0CvTvcS47o7ie@harry>

On Thu, Feb 20, 2025 at 06:21:14PM +0900, Harry Yoo wrote:
> On Thu, Feb 20, 2025 at 05:20:00PM +0900, Harry Yoo wrote:
> > On Sat, Feb 15, 2025 at 06:57:01PM +0200, Lilitha Persefoni Gkini wrote:
> > > The condition `nr <= slab->objects` in the `on_freelist()` serves as
> > > bound while walking through the `freelist` linked list because we can't
> > > have more free objects than the maximum amount of objects in the slab.
> > > But the `=` can result in an extra unnecessary iteration.
> > > 
> > > The patch changes it to `nr < slab->objects` to ensure it iterates
> > > at most `slab->objects` number of times.
> > > 
> > > Signed-off-by: Lilitha Persefoni Gkini <lilithpgkini@gmail.com>
> > > ---
> > >  mm/slub.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 1f50129dcfb3..ad42450d4b0f 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -1435,7 +1435,7 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
> > >  	int max_objects;
> > >  
> > >  	fp = slab->freelist;
> > > -	while (fp && nr <= slab->objects) {
> > > +	while (fp && nr < slab->objects) {
> > 
> > Hi, this makes sense to me.
> > 
> > But based on what the name of the variable suggests (nr of objects),
> > I think it makes clearer to initialize it to 1 instead?
> 
> Oh, actually iterating at most (slab->objects + 1) times allows it to catch
> cases where the freelist does not end with NULL (see how validate_slab()
> calls on_freelist(), passing search = NULL).
> 
> It's very subtle. A comment like this would help:
> 
> /*
>  * Iterate at most slab->objects + 1 times to handle cases
>  * where the freelist does not end with NULL.
>  */
> 
> -- 
> Cheers,
> Harry

nr is the number of "free objects" in the freelist, so it should start
from zero for the case when there are no free objects.

Oh, you think its on purpose to catch edgecases, like a defensive
programing sort of way? Huh, thats interesting!

In that case it would prevent a case where every object in the slab is
freed and the tail of the freelist isnt NULL like it should be, maybe because
of some Out-Of-Bounds write from another object, or a Use-After-Free.
If that pointer is some gibberish then the chech_valid_pointer() check
on line 1441 will catch it, set it as NULL in line 1445 with
set_freepointer() and then break from the While and continue with the
rest of the program. nr will correctly remain as the number of freed
objects and the freelist will have a NULL in its tail, as it should!

But if the pointer isn't some random address and instead is an address in
the slab, lets say as an example the address of a free object in the
linked list (making the freelist cicrular) it wont get caught by the
check_valid_pointer() since technically it is a valid pointer, it will
increment nr to slab->objects + 1 and then exit the While loop because
it will fail the conditional nr <= slab->objects.

Then later on, in line 1470 slab->objects - nr will be -1 which is not
equals to slab->inuse and enter the If case where it will set the
slab->inuse to -1, but because slab-inuse is an unsinged short it will
be stored as 0xFFFF, ie 65535, corrupting the slab struct with an
unreasonably large "inuse" value.

You mentioned validate_slab(), I assume you are refering to how it
searches for NULL when it calls on_freelist() and if it does find NULL
in the freelist it will return 1 (basicaly TRUE).

In the example where every object is freed it will return TRUE
regardless if NULL is in the freelist or not, because on_freelist()
returns search == NULL if it doesnt find the search in the freelist. In
this case it would be NULL == NULL which is TRUE again.
This will have the same behavior even if we remove the equals sign from
the While, like the Patch suggests.


I am still pretty new to this so I apologize for any mistakes. I
appreciate the feedback!
Is it ok to refer to lines of code, or should I copy paste the entire line?
I understand that even small changes could have a huge effect to some
other function or subsystem in ways that might not be obvious to someone
not as familiar with the codebase. I hope I am not coming off to
strong or anything.

