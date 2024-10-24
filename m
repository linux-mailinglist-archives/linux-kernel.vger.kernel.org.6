Return-Path: <linux-kernel+bounces-379978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880219AE6A8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFE71F25A35
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DF91EF096;
	Thu, 24 Oct 2024 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hYJ2wGrN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="piNrZ/LE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hYJ2wGrN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="piNrZ/LE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987751EF085
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776580; cv=none; b=Uau1kTSXCRaJG8Vf4NoaRTJseXcd7WHh5XoPDMbwbM7542/pjuZ5sJSAJmXZwfxb6o0eJ1Gxh8jdHGHtddCmnDnXLcsfKhU8/Uri0VgqidMMTSY3dWnKQXUnMLzAu4Yugoo2WA25YZBPwVAnDU39oVLc0vWMxkCt/3Mf+e661ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776580; c=relaxed/simple;
	bh=n41ey9KluEnpW0Bv+vYh+mf9iynj/6m4igRfoKcafk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ur/fxTm8mZQo+hS9GpbsyI/YD4EZvYLoc71Ig8zEIYzZF3uBD0GEo/92jGjHjrP3eaS2YuWixCP5PGvimh/U0iZRou5pjks65fN02LAVJJehlsWqug8+p0aVQo22x+N/qYPJkg4J0XqegK1rYWPfNrhfyH+FaxcrOqp/GeBEq+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hYJ2wGrN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=piNrZ/LE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hYJ2wGrN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=piNrZ/LE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E13FB21B0C;
	Thu, 24 Oct 2024 13:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729776575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DNZY010Klt7+SZxZEDHH79zA/OC0BeAqYRKohPe/UMw=;
	b=hYJ2wGrNca3iV/epxx0FD5VzFHfqPBPqJHfu6+InPuE+9+ay7EgUCIoiLFEiqMaTkbIPCT
	KXB//T7g/X1hY0liuMJ4pXWzpRhMJKHzVTKEfLJPVn2z5N8s7R1uaGsez17lFJmNnSC7vl
	G5IV7l5/G41WHPgfIEjWeanbq5mV6XU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729776575;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DNZY010Klt7+SZxZEDHH79zA/OC0BeAqYRKohPe/UMw=;
	b=piNrZ/LEiqDqFtKjY6vGWqfdFqDWwntKWlKidaS8zodwXLCZyHSFdMEV16jEAJQqgLnjdD
	1la8AY5uwz3EUpCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729776575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DNZY010Klt7+SZxZEDHH79zA/OC0BeAqYRKohPe/UMw=;
	b=hYJ2wGrNca3iV/epxx0FD5VzFHfqPBPqJHfu6+InPuE+9+ay7EgUCIoiLFEiqMaTkbIPCT
	KXB//T7g/X1hY0liuMJ4pXWzpRhMJKHzVTKEfLJPVn2z5N8s7R1uaGsez17lFJmNnSC7vl
	G5IV7l5/G41WHPgfIEjWeanbq5mV6XU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729776575;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DNZY010Klt7+SZxZEDHH79zA/OC0BeAqYRKohPe/UMw=;
	b=piNrZ/LEiqDqFtKjY6vGWqfdFqDWwntKWlKidaS8zodwXLCZyHSFdMEV16jEAJQqgLnjdD
	1la8AY5uwz3EUpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8D3F1368E;
	Thu, 24 Oct 2024 13:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iRqeML9LGmeBGwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 24 Oct 2024 13:29:35 +0000
Message-ID: <9d7c73f6-1e1a-458b-93c6-3b44959022e0@suse.cz>
Date: Thu, 24 Oct 2024 15:29:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: darktable performance regression on AMD systems caused by "mm:
 align larger anonymous mappings on THP boundaries"
Content-Language: en-US
To: Petr Tesarik <ptesarik@suse.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Rik van Riel <riel@surriel.com>, Matthias <matthias@bodenbinder.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 Yang Shi <yang@os.amperecomputing.com>, Matthew Wilcox <willy@infradead.org>
References: <2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info>
 <f81ef5bd-e930-4982-a5a8-cd4aca272912@suse.cz>
 <ce35b58e-f18c-4701-8494-fa8d1f6e5148@suse.cz>
 <20241024124953.5d77c0b3@mordecai.tesarici.cz>
 <a7585f3e-d6c7-4982-8214-63a7ec6258ad@suse.cz>
 <20241024131331.6ee16603@mordecai.tesarici.cz>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241024131331.6ee16603@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 10/24/24 13:13, Petr Tesarik wrote:
> On Thu, 24 Oct 2024 12:56:27 +0200
> Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> On 10/24/24 12:49, Petr Tesarik wrote:
>> > On Thu, 24 Oct 2024 12:23:48 +0200
>> > Vlastimil Babka <vbabka@suse.cz> wrote:
>> >   
>> >> On 10/24/24 11:58, Vlastimil Babka wrote:  
>> >> > On 10/24/24 09:45, Thorsten Leemhuis wrote:    
>> >> >> Hi, Thorsten here, the Linux kernel's regression tracker.
>> >> >> 
>> >> >> Rik, I noticed a report about a regression in bugzilla.kernel.org that
>> >> >> appears to be caused by the following change of yours:
>> >> >> 
>> >> >> efa7df3e3bb5da ("mm: align larger anonymous mappings on THP boundaries")
>> >> >> [v6.7]
>> >> >> 
>> >> >> It might be one of those "some things got faster, a few things became
>> >> >> slower" situations. Not sure. Felt odd that the reporter was able to
>> >> >> reproduce it on two AMD systems, but not on a Intel system. Maybe there
>> >> >> is a bug somewhere else that was exposed by this.    
>> >> > 
>> >> > It seems very similar to what we've seen with spec benchmarks such as cactus
>> >> > and bisected to the same commit:
>> >> > 
>> >> > https://bugzilla.suse.com/show_bug.cgi?id=1229012
>> >> > 
>> >> > The exact regression varies per system. Intel regresses too but relatively
>> >> > less. The theory is that there are many large-ish allocations that don't
>> >> > have individual sizes aligned to 2MB and would have been merged, commit
>> >> > efa7df3e3bb5da causes them to become separate areas where each aligns its
>> >> > start at 2MB boundary and there are gaps between. This (gaps and vma
>> >> > fragmentation) itself is not great, but most of the problem seemed to be
>> >> > from the start alignment, which togethter with the access pattern causes
>> >> > more TLB or cache missess due to limited associtativity.
>> >> > 
>> >> > So maybe darktable has a similar problem. A simple candidate fix could
>> >> > change commit efa7df3e3bb5da so that the mapping size has to be a multiple
>> >> > of THP size (2MB) in order to become aligned, right now it's enough if it's
>> >> > THP sized or larger.    
>> >> 
>> >> Maybe this could be enough to fix the issue? (on 6.12-rc4)  
>> > 
>> > 
>> > Yes, this should work. I was unsure if thp_get_unmapped_area_vmflags()
>> > differs in other ways from mm_get_unmapped_area_vmflags(), which might
>> > still be relevant. I mean, does mm_get_unmapped_area_vmflags() also
>> > prefer to allocate THPs if the virtual memory block is large enough?  
>> 
>> Well any sufficiently large area spanning a PMD aligned/sized block (either
>> a result of a single allocation or merging of several allocations) can
>> become populated by THPs (at least in those aligned blocks), and the
>> preference depends on system-wide THP settings and madvise(MADV_HUGEPAGE) or
>> prctl.
>> 
>> But mm_get_unmapped_area_vmflags() will AFAIK not try to align the area to
>> PMD size like the thp_ version would, even if the request is large enough.
> 
> Then it sounds like exactly what we want. But I prefer to move the
> check down to __thp_get_unmapped_area() like this:

I wanted to limit the fix to the place commit efa7df3e3bb5da changes, i.e.
anonymous mappings, because there are other callers of
__thp_get_unmapped_area(), namely the filesystems via
thp_get_unmapped_area() and I wasn't sure if that wouldn't regress them. But
since you suggested I had a brief look now...

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2fb328880b50..8d80f3af5525 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1082,6 +1082,9 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
>  	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
>  		return 0;
>  
> +	if (!IS_ALIGNED(len, size))
> +		return 0;

I think the filesystem might be asked to create a mapping for e.g. a
[1MB, 4MB] range from a file, thus the offset would be 1MB (with anonymous
pages an off=0 is passed) and the current implementation would try to do the
right thing for that (align the [2MB, 4MB] range to THP) but after your
patch it would see len is 3MB and give up, no?

> +
>  	if (off_end <= off_align || (off_end - off_align) < size)
>  		return 0;
>  


