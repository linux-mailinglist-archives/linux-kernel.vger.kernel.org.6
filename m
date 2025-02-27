Return-Path: <linux-kernel+bounces-536890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1396CA48560
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CE83AB291
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB741B0409;
	Thu, 27 Feb 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBukHBoZ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493F41B2EF2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674422; cv=none; b=jRpJE1GyZgbXWIF0XBmGZyfMFWKb716q4hBiXfVlyNtyIl1H8WJrnIylvIwHarCiHDkqAZKZcfTrJZ1hCjGIjaM3sVXnGMLmrOxG6ANM2W8zBTnKh7/r2xFCZ185B6e0FFxOjd1sfYcUL2g3acr789L5zp4IsKuvgCHC6Mz/ef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674422; c=relaxed/simple;
	bh=ArQ8vb7OdrqsADkRLXtAAh8PoPP/d0F8mlmhR6c/KkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6IUpbrscSnqJb67OyKiN2KnZGC6HO7Zd9psYh2EnY9xrQXkh3Sqz60Eg8yxGuQHXWVi3Kq/Wd0dCpWmbpSI+CLhfDLRmU29pya2iJZFzU9EXkxN/PBjDGtwZxtXhVAErM7YWDGBha6uCaMzRt/LVYREQYd54n9NmCsYqMxblCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBukHBoZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390dd3403fdso973089f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740674418; x=1741279218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tlqa3xJHdsKH2Fvg1chISi5Lg7orvZo0XWjFT2khQYo=;
        b=NBukHBoZza6gtXUwE8g0OJl6b9fHqfU+dOpeg9f17Bf61IFsoy9HTb2c+6CvXrwg5S
         NIBChc6QsToM00wLYtR0Lxg26pOp8AnfQlxxC86LKnqsyQDfvn0mxXrEW1qujqh9yBSC
         MqQvF/gKbXcY8Q+S8U7DusC4lJgdq67JLFEgBUE8bI6Q8YaMr840ThrAESjfaNL4oAjK
         /+6a46mSuQm0/uvPXwo5DebOYh5bOVMgBkefXskuJIr3fMao7BKBJM4oFfFSrxmkaQ/p
         K414PNts6HkU+pkFDg6TpkifwCfGibIujwoKoumFXqKnJN126RTrxJ8q6RzwlgSN8UP6
         Xetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674418; x=1741279218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlqa3xJHdsKH2Fvg1chISi5Lg7orvZo0XWjFT2khQYo=;
        b=QzaGToQUQnjNutEZqJqEHF6sH8GiC1nmp5D2a8HbeAGOyOsGwVn9KLZ9CkLfjK84XL
         FVP6CUzVVwMdoalUG2khWe8cP/AHs/rsa3MI5RZn/uz2klnPffvRc1j6L7w1PwSn4hdV
         hRld71xoVxJ6DSX8BiEFovjRyL47l2gV+a6fcMTs6eJd3BgkSmGUVxsJq/qxeSlLuDFb
         KKvATGzQuDCfawGJzd6K56uC1el2HzpqzyWHOl39+M6qTCnaH1DxVcT7kZjI+uHg0rZf
         Y25V4IZ6U8B48aLWNjh/sIV5sJfcVZB5gTxAxl082PKrf8kS0glYRi3lOIp3s3jfYuPr
         rtQw==
X-Forwarded-Encrypted: i=1; AJvYcCVErk0a8yTKpM0ssSyyzllM/BLE0137wejohsDfZkaoDVOPwaKTrhWbvT7kQaUwmvt56xNpbHSmiWy88KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzkKrnM7wl8FnEoWVj+stSfHAeHT/tUXGRyZuXnlIIx5Qvx+o
	o0WHu7RDMS958/GCfEuaiTHlUqtxTCskhlW2+NuAU2PTx3nHSqRV
X-Gm-Gg: ASbGncsvuVDVzwuU9hp7bHgx6copyvlLEEIcabWB6SHvn8roPsjqFKOawFCq/153KqR
	qI1d2UFEA7798Xu0orfp6+PfYZ92+pHw3jD8CZrPKBQeiqoO0wRuXWH76KO7iogbJe4W9nR3ZJB
	W5wsx683Ny5qN5l6ABW86P88SbDGXm8VaX4O4XwUeD6a7IcpqYwBYkuZ7V0ukDS3agBSVj9YO81
	g8deuREJEMFA004vdhA6lo3naJV/nrBIEFpxCmilGcCLJFOb3ZkaKl5PgA1+aTT/+IkGvu0ldlD
	ZblSVxrEdOq5WfY0cnFBg2YFk86UrQ==
X-Google-Smtp-Source: AGHT+IEFsNMCjcv2uWdCqrUOWTTQaKN1QqTUQaSQl389HYTLOqtSHSlCTFqIUxo4mgOaPaYLGrXOiQ==
X-Received: by 2002:a5d:47a3:0:b0:385:fc70:7f6 with SMTP id ffacd0b85a97d-390d4f377eemr6710738f8f.7.1740674418042;
        Thu, 27 Feb 2025 08:40:18 -0800 (PST)
Received: from localhost ([2a02:587:860d:d0f9:2a79:b9e6:e503:40e9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba539466sm63521195e9.18.2025.02.27.08.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:40:17 -0800 (PST)
Date: Thu, 27 Feb 2025 18:40:16 +0200
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
Message-ID: <Z8CVcNMGa7pTZvGB@Arch>
References: <Z7DHXVNJ5aVBM2WA@Arch>
 <Z7blsPJiOPTFWEL2@harry>
 <Z7b0CvTvcS47o7ie@harry>
 <Z7iUVJA-luvNaIac@Arch>
 <Z7lLXCZB2IXth7l8@harry>
 <Z7mX6PFxUptwX0mW@Arch>
 <Z7u2jgDadOwceYeN@harry>
 <Z7xiHTN0Q5yI-UmP@Arch>
 <Z72WiUlhxOGnrXFb@harry>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z72WiUlhxOGnrXFb@harry>

On Tue, Feb 25, 2025 at 07:08:09PM +0900, Harry Yoo wrote:
> On Mon, Feb 24, 2025 at 02:12:13PM +0200, Lilith Gkini wrote:
> > On Mon, Feb 24, 2025 at 09:00:14AM +0900, Harry Yoo wrote:
> > > On second thought (after reading your email),
> > > I think it should be (fp == NULL) && (search == NULL)?
> > > 
> > > When fp is NULL after the loop, it means (the end of the freelist
> > > is NULL) AND (there were equal to or less than (slab->objects - nr) objects
> > > on the freelist).
> > > 
> > > If the loop has ended after observing fp == NULL,
> > > on_freelist() should return true only when search == NULL.
> > > 
> > > If fp != NULL, it means there were more objects than it should have on          
> > > the free list. In that case, we can't take risk of iterating the loop
> > > forever and it's reasonable to assume that the freelist does not               
> > > end with NULL.
> > > 
> > > > The reason I m saying this is cause the While loop is looking through
> > > > every non-NULL freelist pointer for the "search" pattern. If someone
> > > > wants to search for NULL in the freelist that return 1 will never
> > > > trigger, even for normal freelists. If "fp" was ever null it wouldn't re
> > > > enter the loop. Thus the result of the function would be search == NULL
> > > > because the original writers assumed the freelist will always end with
> > > > NULL.
> > > 
> > > Agreed.
> > > 
> > > > As you correctly pointed out there might be a case where the freelist
> > > > is corrupted and it doesnt end in NULL. In that case two things could happen:
> > > > 
> > > > 1) The check_valid_pointer() catches it and fixes it, restoring the
> > > > corrupted freelist.
> > > > 
> > > > 2) The check_valid_pointer() fails to catch it and there isn't any NULL.
> > > > 
> > > > 
> > > > In the first case the problem fixes itself and thats probably why
> > > > validate_slab() worked fine all this time.
> > > > 
> > > > The second case is pretty rare, but thats the case that validate_slab()
> > > > wants to rout out when it checks the `!on_freelist(s, slab, NULL)`,
> > > > right?
> > > 
> > > Yes.
> > > 
> > > > Also to make my added suggestion of `return fp == NULL` work in the first
> > > > case (since it does corrrect the freelist we want it to now return TRUE)
> > > > we could also add a line that nulls out the fp right after the 
> > > > `set_freepointer(s, object, NULL);`.
> > > 
> > > Why?
> > > fp = get_freepionter() will observe NULL anyway.
> > > 
> > > > But words are cheap, I should test it out dynamically rather than just
> > > > reading the code to see how it behaves. Feel free to also test it
> > > > yourself.
> > > 
> > > Yes, testing is important, and you should test
> > > to some extent before submitting a patch.
> > > 
> > > > I know I am supposed to send a proper Patch with the multiple added
> > > > lines, but for now we are mostly brainstorming solutions. It will be
> > > > better to see its behavior first in a debugger I think.
> > > 
> > > I think it's generally considered good practice to discuss before
> > > writing any code.
> > > 
> > > > I hope I am making sense with the thought process I outlined for the
> > > > return thing. I probably shouldn't be writing emails ealry Saturday
> > > > morning, haha.
> > > > 
> > > > Also I really appreciate the kind feedback! The Linux Kernel is infamously
> > > > known for how rude and unhinged people can be, which can make it a bit
> > > > stressful and intimidating sending any emails, especially for someone
> > > > starting out such as myself.
> > > 
> > > You're welcome ;-)
> > > 
> > > -- 
> > > Cheers,
> > > Harry
> 
> Hi, Lilith.
> 
> If you don't mind, could you please avoid bottom posting and
> reply with inline comments like how I reply to you?
> It makes it easier to follow the conversation.
> 
> > Alright, I managed to run some tests through a debugger.
> > 
> > You are right, my code isn't correct, `return fp == search` should be
> > more appropriate.
> >
> > So I think the right way would be to do these changes:
> > - 	while (fp && nr < slab->objects) {
> > 
> > -				fp = NULL;
> > 
> > -	return fp == search;
> >
> > The first line removes the "=" so it doesnt iterate more times than
> > slab->objects.
> 
> Yes.
> 
> > The second line sets fp to NULL for the case where the code caught a
> > corrupted freelist (check_valid_pointer) and fixes it by setting 
> > the freepointer to NULL (set_freepointer). Now NULL will be in the
> > freelist.
> 
> Yes. but do we care about the return value of on_freelist()
> when the freelist is corrupted? (we don't know if it was null-terminated
> or not because it's corrupted.)
> 
> > The third line is the return value:
> > TRUE if the final fp we got happens to be the search value the caller
> > was looking for in the freelist.
> > FALSE if the final fp we got was not the same as the search value.
> > 
> > This should make the validate_slab() work right and if anyone ever uses
> > the on_freelist() again with some other search value other than NULL it
> > should also work as intended.
> 
> Yes! that makes sense to me.
> 
> > For my tests I wrote a kernel module that creates an isolated cache with
> > 8 objects per slab, allocated all 8 of them and freed them. Then called
> > validate_slab_cache() with my cache and set a breakpoint at on_freelist().
> > From there I could set any value I wanted and observe its behavior
> > through GDB (I used QEMU and GDB-ed remotely from my host).
> > This way I didn't have to set a bunch of EXPORT_SYMBOL() and change
> > stuff to not static; It made testing a lot easier.
> >
> > Here are the tests I did with this new change I just mentioned.
> > 
> > Note: By "full slab" I mean that I allocated every object in the slab
> > and freed them.
> 
> FYI in slab terms (slab->inuse == slab->objects) means full slab,
> You probably meant empty slab?
> 
> > By "partial" I mean that I only allocated and freed some
> > objects, but not every object in the slab, ie if the total objects can
> > be 8 I only alloc-ed and freed 7.
> >
> > search == NULL
> > - full slab
> > 	- correct tail				true
> 
> > 	- corrupted tail with garbage		false
> > 	- corrupted tail with valid address	false
> 
> Two falses because when the freepointer of the tail object
> is corrupted, the loop stops when nr equals slab->objects?
> 
> > - partial slab
> > 	- correct tail			        true
> 
> > 	- corrupted tail with garbage	        true
> 
> This is true because for partial slabs, the number of objects
> plus 1 for the garbage, does not exceed slab->objects?
> 
> > 	- corrupted tail with valid address	false
> >
> > search == some fake address
> > - full slab
> > 	- correct tail			        false
> > 	- corrupted tail with garbage	        false
> > 	- corrupted tail with valid address	false
> > 
> > - partial slab
> > 	- correct tail			        false
> > 	- corrupted tail with garbage	        false
> > 	- corrupted tail with valid address	false
> > 
> > 
> > search == some address in the freelist
> > - full slab
> > 	- correct tail			        true
> > 	- corrupted tail with garbage	        true
> > 	- corrupted tail with valid address	true
> > 
> > - partial slab
> > 	- correct tail			        true
> > 	- corrupted tail with garbage	        true
> > 	- corrupted tail with valid address	true
> 
> The result seems valid to me. At least, this is the best SLUB can do
> while avoiding the risk of infinite loop iteration.
> 
> > I apologize if am going into too many details with my testing, I just
> > wanna make sure I didn't miss anything.
> 
> No, it's ok ;-)
> 
> > If my proposed changes look confusing I can send a proper patch.
> > Should I send it in this chain as a reply, or send a new email
> > and add you as well to the cc?
> 
> You can either send a new email or reply to this email with
> In-Reply-To header. And please cc SLAB ALLOCATOR folks in MAINTAINERS file
> including me—I recently changed my name and email (previously Hyeonggon Yoo).
> 
> -- 
> Cheers,
> Harry

Hey, Harry.

> Yes. but do we care about the return value of on_freelist()
> when the freelist is corrupted? (we don't know if it was null-terminated
> or not because it's corrupted.)

Oh! So we shouldn't care about the return value of on_freelist() if the
freelist is corrupted? My thinking was that if the check_valid_pointer()
detects a corrupted freelist and fixes it by setting the freepointer to
NULL it fixes it, so we would care about the result. But maybe if the
whole object_err() triggers, I think that causes an OOPs if I recall, we
should consider this as corrupted and we shouldn't care about what it
returns, cause something went terribly wrong?

I guess that sounds like a sound logic.

If that is how we should do this then yeah, my second suggested line is
moot and in my later patch I shouldn't include it.

> FYI in slab terms (slab->inuse == slab->objects) means full slab,
> You probably meant empty slab?

Thats fair. I was thinking more like "I allocated everything and then
freed everything in the slab, therefore the freelist will be full".
But hopefully since I specified what I meant it wasn't too confusing.

> Two falses because when the freepointer of the tail object
> is corrupted, the loop stops when nr equals slab->objects?

Yeah! Since the freelist pointer is corrupted and doesn't end in NULL
on_freelist() won't find a NULL, and in the case of the tail having
garbage that the check_valid_pointer() would normally catch, the code
won't catch it, because it's at the tail which would exceed the
slab->objects and the While loop will exit before that, since the
freelist* (not slab, as you pointed out) is full.

> This is true because for partial slabs, the number of objects
> plus 1 for the garbage, does not exceed slab->objects?

Yeah. That goes back to that second line I suggested in the previous
email. If the number of objects in the freelist is less than the
slab->objects and the corrupted freelist has some garbage address that
the check_valid_pointer() will catch, it will set it to NULL instead, and
as I said since the freelist now includes a NULL, my thinking was that
on_freelist() should return true if we were searching for NULL.

But if thats not how on_freelist() should work in a case of a corrupted
freelist and we don't add my second line that nulls the "fp" then this
will return false instead.

> The result seems valid to me. At least, this is the best SLUB can do
> while avoiding the risk of infinite loop iteration.

Yeah! There were no infinite loop iterations in my tests inside
on_freelist(). There were in some cases in other functions, but not in
on_freelist().

Fortunately the While condition prevents any infinite loopings, even
without my patch.

> If you don't mind, could you please avoid bottom posting and
> reply with inline comments like how I reply to you?
> It makes it easier to follow the conversation.

Hopefully I did that correctly this time. Should I always include all
the previous messages in the reply chain? It was getting rather long and
I thought it would look messy.

> You can either send a new email or reply to this email with
> In-Reply-To header. And please cc SLAB ALLOCATOR folks in MAINTAINERS file
> including me—I recently changed my name and email (previously Hyeonggon Yoo).

Oh! You are one of the maintainers? That explains a lot, haha. I just
assumed you were someone from the mailing list who happened to be really
passionate about SLUB.

