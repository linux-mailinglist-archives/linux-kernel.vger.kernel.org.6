Return-Path: <linux-kernel+bounces-528992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A891A41EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87F33B3A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811462571B5;
	Mon, 24 Feb 2025 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQDe5p7L"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49C2571A7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399139; cv=none; b=A52F7GQEp1JkRL6L4j0tdejKTpUWcAlmHLg4jROZIKtvuSTC6kiGiT4/hM1Ry4Hfr08Tl9kkh1nVmmyzvEsN+MsENdMzUAg1QTQNAJKB06T1ZHE+ByOgVtEBXAAElCX6wzS3QzD1m+B7WT737Eer19/wAeKZbbS6fjoE6QpEuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399139; c=relaxed/simple;
	bh=jguwttWAlIkMWRCy2StPYutL84B00Fw/KfiQN5EE6hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co6NotvfB91xtA5fRaNVpwazfq4f2irrPvj9OsqN3OhKzb9wuh8zXmgIIRdiDxQJPYk2VJFrq8R2Uh4w7bYpEsLzO+YlFpEG1/GSceh6Msu0WDLd18Jbzz++pVjVPWbAW7+fwyhuxV+n2ijlFwXPxDuogkdK5nJlZiRj8XUhroA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQDe5p7L; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso5749041a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740399136; x=1741003936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rrddu9WJI4Zglua4XbLNnvYF1mA4HBiQV2N19UniiUI=;
        b=OQDe5p7LxF67LVDIYbu0wOWiB/BqqCCVIOZOqRPGkyUqxqk0AAWyhyotcymmk/ZP0h
         73kx4Ma6awOfQJSfULXnHtx6AwfJ2gq924WNG2GveTS+Z98MzoaGGWOXytMh7uHLNBQA
         OTRdM27l+7cGJ4OO8OCZZSZWUJMosS/96u10WF06KEDJnK9wtkeKzqKjT4E9ohp9zt7M
         Xw5MQJtbwtCEFlOCcX8tZpbfTUXFAbj43mB6PP93XyTyhLL/wJrK9CDaygPBlqkpc4ml
         /UkO/Vv1JCk5Gvf61N0C6/8vd2suUIkFX2SGYXoJIReMrTgk/zZWVVVoPd0eR8Nlru5h
         PQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740399136; x=1741003936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rrddu9WJI4Zglua4XbLNnvYF1mA4HBiQV2N19UniiUI=;
        b=GHeplM8Sw4/9/Lisk5srDpfl/JF3motJ+kCjJgyS3Y2s6Wm6fBbP5+Nnqbp0JmQuqA
         TE8ko9+ELBCVYdCCuBLoNeBZy6UXpNon6cFUMcy398JgyiE8jqX4Nvohs4jwmUg9mKOE
         j5ipf2isF3mHtCfEXGd2/nF3jtBbMFErsmheV+Fj0dMuUHNVcBzbTNZsq2oQIJTKf/i5
         2FQ8tb3+Vo9Cq8sjVLBp0UrPzFADJiTAURSy30ISwP1SOMhMCnsQxzF/Fpb3ISebggfL
         PlZ96dt5jbcwi71URGQ83zzldv5sXtFeHXC/95DNC7l3KxvhQJZR/Wp/C1+LdxPJNOAr
         cUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU80PzQuHayvgOpfHKeCcbsj5RbZRrwwoq4w49DoWdNZ9f/ufM483xEKq2EVaXN36WUKHS8rEistP0aguU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTC0y21f5Gmr6iugxrWGABGOGzHxVL1uqRU2m3ZPHOY3kKZYt
	GDvoEJ5xR8HKRxTXo9ydyeedspXbfC4jVhdKZuJaQSL1Gxcj5m5n
X-Gm-Gg: ASbGnctvVCHFk5zjYgZpWHhTQ+nZeOPBBhozevKAI2umlxL8p0VSMql/h5CgvOBxNa+
	7e9SA0+tzyJ1s3DbVp6PX5V8C34NTGwE0D8LrmFPrIShrDEIqOerxxmhENbxGP/REuYAZVhsXy5
	tG/SFHv6T2ssSlPAwJ+PNEWawtbu1RrwXQSespyWz1nRyfHFoeWPjUOALtnlmXeKzg8XXJGC4dY
	EGfAw7BZjaOR0VpR8xgiMjUljJ9aEP8dIUzgMt5ebhyQ0NgpExaZgy3q8RRkG6fPU44hpsnNwWr
	rPY85Dtjxrvr1C+6oPFWs0PW/EC9
X-Google-Smtp-Source: AGHT+IHv1Tnoo5T4imaW7W/oB5X5aEzmHsKmzB619oTOb3oJ0n/kqClK7OlPUzdKUAwCKjy698Zj0g==
X-Received: by 2002:a17:907:3f16:b0:aac:619:e914 with SMTP id a640c23a62f3a-abc0d9d9740mr1312556966b.16.1740399135764;
        Mon, 24 Feb 2025 04:12:15 -0800 (PST)
Received: from localhost ([2a02:587:860d:d0f9:2a79:b9e6:e503:40e9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb843451b1sm1722365666b.42.2025.02.24.04.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:12:15 -0800 (PST)
Date: Mon, 24 Feb 2025 14:12:13 +0200
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
Message-ID: <Z7xiHTN0Q5yI-UmP@Arch>
References: <Z7DHXVNJ5aVBM2WA@Arch>
 <Z7blsPJiOPTFWEL2@harry>
 <Z7b0CvTvcS47o7ie@harry>
 <Z7iUVJA-luvNaIac@Arch>
 <Z7lLXCZB2IXth7l8@harry>
 <Z7mX6PFxUptwX0mW@Arch>
 <Z7u2jgDadOwceYeN@harry>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7u2jgDadOwceYeN@harry>

On Mon, Feb 24, 2025 at 09:00:14AM +0900, Harry Yoo wrote:
> On second thought (after reading your email),
> I think it should be (fp == NULL) && (search == NULL)?
> 
> When fp is NULL after the loop, it means (the end of the freelist
> is NULL) AND (there were equal to or less than (slab->objects - nr) objects
> on the freelist).
> 
> If the loop has ended after observing fp == NULL,
> on_freelist() should return true only when search == NULL.
> 
> If fp != NULL, it means there were more objects than it should have on          
> the free list. In that case, we can't take risk of iterating the loop
> forever and it's reasonable to assume that the freelist does not               
> end with NULL.
> 
> > The reason I m saying this is cause the While loop is looking through
> > every non-NULL freelist pointer for the "search" pattern. If someone
> > wants to search for NULL in the freelist that return 1 will never
> > trigger, even for normal freelists. If "fp" was ever null it wouldn't re
> > enter the loop. Thus the result of the function would be search == NULL
> > because the original writers assumed the freelist will always end with
> > NULL.
> 
> Agreed.
> 
> > As you correctly pointed out there might be a case where the freelist
> > is corrupted and it doesnt end in NULL. In that case two things could happen:
> > 
> > 1) The check_valid_pointer() catches it and fixes it, restoring the
> > corrupted freelist.
> > 
> > 2) The check_valid_pointer() fails to catch it and there isn't any NULL.
> > 
> > 
> > In the first case the problem fixes itself and thats probably why
> > validate_slab() worked fine all this time.
> > 
> > The second case is pretty rare, but thats the case that validate_slab()
> > wants to rout out when it checks the `!on_freelist(s, slab, NULL)`,
> > right?
> 
> Yes.
> 
> > Also to make my added suggestion of `return fp == NULL` work in the first
> > case (since it does corrrect the freelist we want it to now return TRUE)
> > we could also add a line that nulls out the fp right after the 
> > `set_freepointer(s, object, NULL);`.
> 
> Why?
> fp = get_freepionter() will observe NULL anyway.
> 
> > But words are cheap, I should test it out dynamically rather than just
> > reading the code to see how it behaves. Feel free to also test it
> > yourself.
> 
> Yes, testing is important, and you should test
> to some extent before submitting a patch.
> 
> > I know I am supposed to send a proper Patch with the multiple added
> > lines, but for now we are mostly brainstorming solutions. It will be
> > better to see its behavior first in a debugger I think.
> 
> I think it's generally considered good practice to discuss before
> writing any code.
> 
> > I hope I am making sense with the thought process I outlined for the
> > return thing. I probably shouldn't be writing emails ealry Saturday
> > morning, haha.
> > 
> > Also I really appreciate the kind feedback! The Linux Kernel is infamously
> > known for how rude and unhinged people can be, which can make it a bit
> > stressful and intimidating sending any emails, especially for someone
> > starting out such as myself.
> 
> You're welcome ;-)
> 
> -- 
> Cheers,
> Harry

Alright, I managed to run some tests through a debugger.

You are right, my code isn't correct, `return fp == search` should be
more appropriate.

So I think the right way would be to do these changes:
- 	while (fp && nr < slab->objects) {

-				fp = NULL;

-	return fp == search;

The first line removes the "=" so it doesnt iterate more times than
slab->objects.

The second line sets fp to NULL for the case where the code caught a
corrupted freelist (check_valid_pointer) and fixes it by setting 
the freepointer to NULL (set_freepointer). Now NULL will be in the
freelist.

The third line is the return value:
TRUE if the final fp we got happens to be the search value the caller
was looking for in the freelist.
FALSE if the final fp we got was not the same as the search value.

This should make the validate_slab() work right and if anyone ever uses
the on_freelist() again with some other search value other than NULL it
should also work as intended.


For my tests I wrote a kernel module that creates an isolated cache with
8 objects per slab, allocated all 8 of them and freed them. Then called
validate_slab_cache() with my cache and set a breakpoint at on_freelist().
From there I could set any value I wanted and observe its behavior
through GDB (I used QEMU and GDB-ed remotely from my host).
This way I didn't have to set a bunch of EXPORT_SYMBOL() and change
stuff to not static; It made testing a lot easier.

Here are the tests I did with this new change I just mentioned.

Note: By "full slab" I mean that I allocated every object in the slab
and freed them. By "partial" I mean that I only allocated and freed some
objects, but not every object in the slab, ie if the total objects can
be 8 I only alloc-ed and freed 7.

search == NULL
- full slab
	- correct tail				true
	- corrupted tail with garbage		false
	- corrupted tail with valid address	false

- partial slab
	- correct tail			        true
	- corrupted tail with garbage	        true
	- corrupted tail with valid address	false


search == some fake address
- full slab
	- correct tail			        false
	- corrupted tail with garbage	        false
	- corrupted tail with valid address	false

- partial slab
	- correct tail			        false
	- corrupted tail with garbage	        false
	- corrupted tail with valid address	false


search == some address in the freelist
- full slab
	- correct tail			        true
	- corrupted tail with garbage	        true
	- corrupted tail with valid address	true

- partial slab
	- correct tail			        true
	- corrupted tail with garbage	        true
	- corrupted tail with valid address	true


I apologize if am going into too many details with my testing, I just
wanna make sure I didn't miss anything.

If my proposed changes look confusing I can send a proper patch.
Should I send it in this chain as a reply, or send a new email
and add you as well to the cc?

