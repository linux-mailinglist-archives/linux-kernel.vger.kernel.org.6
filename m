Return-Path: <linux-kernel+bounces-527053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F31FAA406CC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5035A16DF0E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D06206F02;
	Sat, 22 Feb 2025 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab5BtX6y"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D42063FC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740216302; cv=none; b=tW2V3H9oZNfcetiWs+bQoWuU/awjlINYL2tMIMJuPereIvACOW0Wwl46shGkaZupYjlL1FAMRs4X+Sz7HpVndyKMF46mYjQ7OwqX1cUyM9pqA06yq7aLg3q+fXkwHQRsyIpHIPmaApwZ3XCCJ35Dgbl9KkQs405U2JAFrgGLUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740216302; c=relaxed/simple;
	bh=Dzooruq98EMyGInSltVTxLrrNZATnVNkbJbORgRvfl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQxX7wIC6mWSPZdXWXuZF2t3QHXXcyjwjGhq1jgkuALRzrz2Y+HgPm3uF9P1imXrvRwmz49AVPXaJDQR1O2U5c21rARbt6NxZ8Q0mbIgEQDMqItloe5AC41ALbTZJl09Ar6YXobHtXQpWvpfpJAaLaXDRS2lQxbqreqjDL8PPHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab5BtX6y; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso440899866b.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740216298; x=1740821098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3yD6gjY6AcVo0spaca0J4KOetQq7mGQ5hrKWIAthpNI=;
        b=ab5BtX6yAolMm3wLpZr3o8CCvw8ny/XenoGl9sY7h8O08S4yPS9o9r4H5muoJUju23
         X1Bzmmg7w6ZdJJzvKxOzaGRTejlCzaoCebLtYSlmwScwMO6rjk0lTg61UlrYvTHKLK1Y
         uBxv/YUPCZ3acpUjQS+9Cfzppr/Vz6KjXPlnYsz8HSUFmOschiA2fxbiv4uevEIDkYfR
         ILDRsWYuicz395pFXvM/AwjCOzzKxkmg55chs29djdC3LGZFd4Js2oYulX/ceD66Prkd
         UNmq0BtTq7uteh5tfb8NOnu8cD2QVIp2r2IxrP3GjPil6NONY/+s625sE4JxQsLs/Tjs
         dI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740216298; x=1740821098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yD6gjY6AcVo0spaca0J4KOetQq7mGQ5hrKWIAthpNI=;
        b=svAqks3t70l1+hAecJH9WdWy2OtD/jF9YMJsk/WhXGvcCFqD8utGKIvUs6hFNWNAjK
         9LdqyV2u+OISdd7BpY3IiOJ+32S0+3R/QZ+bnDk+RuPq6UGBGm5gmwcU9jeDUmRfmS9r
         a9eKaq56K+UExKXmZpgcMvAHWrLJm/M+AIVcIFJYqssr/PnrgUUZexFGuZN17GS+rgQN
         YI8DbVb7dNKIUMnEh6Ki6zaFLL7L1HP67jLBkb3O8TRvPebcMkg5LCKxoqwIlN7wlLFG
         CB5WjBqY6Js5mTwy3HCXdyZFw5kj3WOvtRMilp8DLaGsux0DNvsJNNtDbbo/SeZ7jL+z
         +wng==
X-Forwarded-Encrypted: i=1; AJvYcCXT/kmbpDYccozDdJ2CkHnQrak1nrqZbG8SQtg79TBIep3553wRUb+sEKtF4Ai4xWVvVtuU+k/q/8f5ako=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQVRq5jf8G2+pHuFbdQ10sEGU5maBsMWg7dkkbtPjMJrAO5BQs
	NhUhK1LyAvRZGnURFw2IejiNh8JvdaA/gm0PXA4/g6pRnX/RDk8/
X-Gm-Gg: ASbGncvJTW7k7lx8YYUnDa4b9vsg2E33QoeS5t9KSyrxVb+yWXbtA81YitHIf1YWgkz
	wRw4XB1uzpWrSM2vCwCCA31LVGX5Wv4aqgdcNCoWO1I5uHZTf4bcyrClVQ7izHnSEjQqsArv4kB
	mgjYoLQUpM/7cJgrtm+pql5pqVh6Sp/xeIM3XjbnGukg2gANq3msTHp9+Be2cZ/Akv0RU76IQB0
	TSlkZeeKECcUZ9Sivkyao9vu0KPKfhIvM9+J6/3oPkE1yEy6i+/W7h3uv82HJ4v2aJ3LjVWDgTq
	tvE5f+UcdXg0NI6JH7UvSTOOQAgjgw==
X-Google-Smtp-Source: AGHT+IEut/GnIJBBNogqaoK2P1dFuBK0cH+uLmMcDLZBmoF4AfCfhulOqPyPmL25bvVwu8oP6DK0SQ==
X-Received: by 2002:a17:907:6d05:b0:abb:cb01:f3b7 with SMTP id a640c23a62f3a-abc0d988619mr611112466b.1.1740216297857;
        Sat, 22 Feb 2025 01:24:57 -0800 (PST)
Received: from localhost ([2a02:587:860d:d0f9:2a79:b9e6:e503:40e9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb77551c60sm1408859466b.63.2025.02.22.01.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 01:24:57 -0800 (PST)
Date: Sat, 22 Feb 2025 11:24:56 +0200
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
Message-ID: <Z7mX6PFxUptwX0mW@Arch>
References: <Z7DHXVNJ5aVBM2WA@Arch>
 <Z7blsPJiOPTFWEL2@harry>
 <Z7b0CvTvcS47o7ie@harry>
 <Z7iUVJA-luvNaIac@Arch>
 <Z7lLXCZB2IXth7l8@harry>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7lLXCZB2IXth7l8@harry>

On Sat, Feb 22, 2025 at 12:58:20PM +0900, Harry Yoo wrote:
> On Fri, Feb 21, 2025 at 04:57:24PM +0200, Lilith Gkini wrote:
> > On Thu, Feb 20, 2025 at 06:21:14PM +0900, Harry Yoo wrote:
> > > On Thu, Feb 20, 2025 at 05:20:00PM +0900, Harry Yoo wrote:
> > > > On Sat, Feb 15, 2025 at 06:57:01PM +0200, Lilitha Persefoni Gkini wrote:
> > > > > The condition `nr <= slab->objects` in the `on_freelist()` serves as
> > > > > bound while walking through the `freelist` linked list because we can't
> > > > > have more free objects than the maximum amount of objects in the slab.
> > > > > But the `=` can result in an extra unnecessary iteration.
> > > > > 
> > > > > The patch changes it to `nr < slab->objects` to ensure it iterates
> > > > > at most `slab->objects` number of times.
> > > > > 
> > > > > Signed-off-by: Lilitha Persefoni Gkini <lilithpgkini@gmail.com>
> > > > > ---
> > > > >  mm/slub.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > > index 1f50129dcfb3..ad42450d4b0f 100644
> > > > > --- a/mm/slub.c
> > > > > +++ b/mm/slub.c
> > > > > @@ -1435,7 +1435,7 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
> > > > >  	int max_objects;
> > > > >  
> > > > >  	fp = slab->freelist;
> > > > > -	while (fp && nr <= slab->objects) {
> > > > > +	while (fp && nr < slab->objects) {
> > > > 
> > > > Hi, this makes sense to me.
> > > > 
> > > > But based on what the name of the variable suggests (nr of objects),
> > > > I think it makes clearer to initialize it to 1 instead?
> > > 
> > > Oh, actually iterating at most (slab->objects + 1) times allows it to catch
> > > cases where the freelist does not end with NULL (see how validate_slab()
> > > calls on_freelist(), passing search = NULL).
> > > 
> > > It's very subtle. A comment like this would help:
> > > 
> > > /*
> > >  * Iterate at most slab->objects + 1 times to handle cases
> > >  * where the freelist does not end with NULL.
> > >  */
> > > 
> > > -- 
> > > Cheers,
> > > Harry
> > 
> > nr is the number of "free objects" in the freelist, so it should start
> > from zero for the case when there are no free objects.
> 
> Hi Lilith,
> 
> You're right. It was an oversight.
> 
> > Oh, you think its on purpose to catch edgecases, like a defensive
> > programing sort of way? Huh, thats interesting!
> > 
> > In that case it would prevent a case where every object in the slab is
> > freed and the tail of the freelist isnt NULL like it should be, maybe because
> > of some Out-Of-Bounds write from another object, or a Use-After-Free.
> > If that pointer is some gibberish then the chech_valid_pointer() check
> > on line 1441 will catch it, set it as NULL in line 1445 with
> > set_freepointer() and then break from the While and continue with the
> > rest of the program. nr will correctly remain as the number of freed
> > objects and the freelist will have a NULL in its tail, as it should!
> 
> Yes, but corrupted freelist implies that the number of the free
> objects (nr) may be invalid? (if free pointer in the middle is
> corrupted).
> 
> But that's another story...
> 
> > But if the pointer isn't some random address and instead is an address in
> > the slab, lets say as an example the address of a free object in the
> > linked list (making the freelist cicrular) it wont get caught by the
> > check_valid_pointer() since technically it is a valid pointer, it will
> > increment nr to slab->objects + 1 and then exit the While loop because
> > it will fail the conditional nr <= slab->objects.
> > 
> > Then later on, in line 1470 slab->objects - nr will be -1 which is not
> > equals to slab->inuse and enter the If case where it will set the
> > slab->inuse to -1, but because slab-inuse is an unsinged short it will
> > be stored as 0xFFFF, ie 65535, corrupting the slab struct with an
> > unreasonably large "inuse" value.
> 
> While (slab->inuse + nr != slab->objects) will prevent overflow,
> I think either way is functional, because it prints error when there are
> more or less objects than it should have on the freelist.
> 
> > You mentioned validate_slab(), I assume you are refering to how it
> > searches for NULL when it calls on_freelist() and if it does find NULL
> > in the freelist it will return 1 (basicaly TRUE).
> 
> Yes.
> 
> > In the example where every object is freed it will return TRUE
> > regardless if NULL is in the freelist or not, because on_freelist()
> > returns search == NULL if it doesnt find the search in the freelist. In
> > this case it would be NULL == NULL which is TRUE again.
> > This will have the same behavior even if we remove the equals sign from
> > the While, like the Patch suggests.
> 
> Ok. that's actually a good point.
> 
> But as validate_slab() expects to return false if there is no NULL
> in the freelist, I think we need to fix on_freelist() to support that?
> 
> I'm not sure why on_freelist() returns (search == NULL).
> It has been there since the beginning of the SLUB allocator
> (commit 81819f0fc828).
> 
> Since commit 53e15af03be4 ("slub: validation of slabs (metadata and guard
> zones)"), validate_slab() started passing NULL to on_freelist().
> Looks like passing NULL to on_freelist() has never worked as intended...
> 
> Can we return false in on_freelist(), if it could not find
> target object (search) in the loop? (need some testing to verify,
> though...) regardless of search is NULL or not?
> 
> > I am still pretty new to this so I apologize for any mistakes. I
> > appreciate the feedback!
> 
> Your questions are valid.
> 
> > Is it ok to refer to lines of code, or should I copy paste the entire line?
> 
> I prefer copy-and-paste because sometimes it's not obvious what commit
> is HEAD of your repository.
> 
> > I understand that even small changes could have a huge effect to some
> > other function or subsystem in ways that might not be obvious to someone
> > not as familiar with the codebase.
> 
> That's why we need to be as careful as possible and test the code ;-)
> 
> > I hope I am not coming off to strong or anything.
> 
> It's ok. I don't think so.
> 
> -- 
> Cheers,
> Harry

Hi!

> Since commit 53e15af03be4 ("slub: validation of slabs (metadata and guard
> zones)"), validate_slab() started passing NULL to on_freelist().
> Looks like passing NULL to on_freelist() has never worked as intended...

Haha, yeah, it would seem like.

> Can we return false in on_freelist(), if it could not find
> target object (search) in the loop? (need some testing to verify,
> though...) regardless of search is NULL or not?

You are right, I should write a test driver that uses on_freelist() and
analyze it through GDB with QEMU to see how it actually behaves when I
have the time, but just looking at it I am thiking that something like 
`return fp == NULL` could replace the `search == NULL` and check if NULL is
at the end of the freelist or not, in addition to my original patch.

The reason I m saying this is cause the While loop is looking through
every non-NULL freelist pointer for the "search" pattern. If someone
wants to search for NULL in the freelist that return 1 will never
trigger, even for normal freelists. If "fp" was ever null it wouldn't re
enter the loop. Thus the result of the function would be search == NULL
because the original writers assumed the freelist will always end with
NULL. 

As you correctly pointed out there might be a case where the freelist
is corrupted and it doesnt end in NULL. In that case two things could happen:

1) The check_valid_pointer() catches it and fixes it, restoring the
corrupted freelist.

2) The check_valid_pointer() fails to catch it and there isn't any NULL.


In the first case the problem fixes itself and thats probably why
validate_slab() worked fine all this time.

The second case is pretty rare, but thats the case that validate_slab()
wants to rout out when it checks the `!on_freelist(s, slab, NULL)`,
right?

Also to make my added suggestion of `return fp == NULL` work in the first
case (since it does corrrect the freelist we want it to now return TRUE)
we could also add a line that nulls out the fp right after the 
`set_freepointer(s, object, NULL);`.

But words are cheap, I should test it out dynamically rather than just
reading the code to see how it behaves. Feel free to also test it
yourself.

I know I am supposed to send a proper Patch with the multiple added
lines, but for now we are mostly brainstorming solutions. It will be
better to see its behavior first in a debugger I think.

I hope I am making sense with the thought process I outlined for the
return thing. I probably shouldn't be writing emails ealry Saturday
morning, haha.

Also I really appreciate the kind feedback! The Linux Kernel is infamously
known for how rude and unhinged people can be, which can make it a bit
stressful and intimidating sending any emails, especially for someone
starting out such as myself.

Thank you.

