Return-Path: <linux-kernel+bounces-395367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD5D9BBCF7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2D21F23156
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E58C1CACDC;
	Mon,  4 Nov 2024 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VLrMCMyx"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCBC1C2309
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743989; cv=none; b=B2LwO8O14t2HhB0ZJNWtQS/+t62u84YjmbuuPfo9Xum0RnwYpmNnuVXfqUIzorgxKQEJYcRFAGlJ1cEeWZkDjubldU/U5R1sqo/e+GCCV0P2I4sRcoM2G0ktEdQ5kWRbBwP+tZSqEbVYVUZ+oP6WTBmkRMW5tX8tBdKfKjhWFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743989; c=relaxed/simple;
	bh=Q26eLIM+swQBRch81PSrbQ60uvEOybo0NOsCt34wTBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLZZAIOEyK3hUZ7/K1taojUkH7VaMv0i+weVSSWpByjzODxJSrHBbGOm07/py5kSykYhIKH3PFEDTZNU6y3FANb9JEtBM90WyhWsme/zGGCxoqPwEVxxu6QxPcDCivKLKM80X0LvXWf5jQ8zMW1r8wj/htysBC/zzZpG7SBjNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VLrMCMyx; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46089a6849bso31280651cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 10:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730743986; x=1731348786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq65Jr156o7cXIfpMfyY2B+BHJCK8km9jpX2kv0T/W0=;
        b=VLrMCMyx7lwbn3XgeOqM2gZezzuYN+JstbdfiFbzC9Ir/QSN3mzBKqIywFWvdOoLd5
         FAjb3XJRfI7SKsMgxWRt3QRHam9gh9DL5/GZaWK+mvC/i2+jdv7/o5/rcipIaRe0nbSv
         jU1E4T/ykJChSQ+H8G0rEJBivW1qSIhJNxNXcXoBoAGEPVqyX38aDnwQaiUwUxNoVluV
         LGBtl0Tm0ETlC9N7IYpFDNaHIbMOJCf15joc5fOIhocJckng3+cU9mDZ7q+5Gm49i9ue
         j10YykHEf9/3Ghb4rsCyZwcSpmmh5pmAkPFKBv5jkVekJve4SG748rVoEbDVrDl3aDdm
         743w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730743986; x=1731348786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fq65Jr156o7cXIfpMfyY2B+BHJCK8km9jpX2kv0T/W0=;
        b=iJe2AmL3aMA9+ryCA4gXvnz2gewB0w+NIGJGEuw42iyn8y/1HFWliKtWcu8risbfzB
         V5MEiU3NvPIhHT/4xNmnSUM8jb5N94fOXFJAA71GVq3yE7MxtFEBYrCk9Zj5OyE29s+m
         eBUWnmjkkdO+vAWwYAQQuf4bTpjIJwa1FaeooMumPw1ig/DmuNZO8kwxAyM5Yfy220Zs
         KilUIhKO0O4iRuaQy1VCqsuWN8uD3xfRjW6Vygs/yeFlJj15Urc+Y3LWLY3HzuvhAxIt
         fZWC7v8u4zd80C38Zeft8Ph0fBShRjkDNo/x59spi/ztpcgnKX5AdKEKkDrkajCrXPC4
         KYog==
X-Forwarded-Encrypted: i=1; AJvYcCVJjfsNYidJYl8SEscOMoOZ8+NcYqK/AA7UAsouo0OEvR50EJNRdeFY4+tE1un8W3YE59jYW9q4yIefBF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7RMSmKKpJCLOvYAyyx+XdDNsW9RtfxQwdkak73N6ShOu500Iw
	oVAMjY8KYuWfdoxzy9ZVqSv048kjTk3wR0vZz66xW0X3y3m55XocxkI79ZFK3iU=
X-Google-Smtp-Source: AGHT+IFW3eozzyK4VqMdL5acvyw9I8slhGfHLF/JtHnAnaHK8kI5tQ6B6mtU2oEUeZcF1g6GUx8NKg==
X-Received: by 2002:ac8:530a:0:b0:462:af30:48d with SMTP id d75a77b69052e-462af30082dmr184347881cf.49.1730743985571;
        Mon, 04 Nov 2024 10:13:05 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0a004asm49304471cf.23.2024.11.04.10.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:13:04 -0800 (PST)
Date: Mon, 4 Nov 2024 13:12:57 -0500
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, david@redhat.com, nphamcs@gmail.com,
	nehagholkar@meta.com, abhishekd@meta.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
Message-ID: <ZykOqYJpgL4lw7mw@PC2K9PVX.TheFacebook.com>
References: <20240803094715.23900-1-gourry@gourry.net>
 <875xrxhs5j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZsNhgU-TiTz2WKg5@PC2K9PVX.TheFacebook.com>
 <87ikvefswp.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikvefswp.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Mon, Sep 02, 2024 at 02:53:26PM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> > On Mon, Aug 19, 2024 at 03:46:00PM +0800, Huang, Ying wrote:
> >> Gregory Price <gourry@gourry.net> writes:
> >> 
> >> > Unmapped pagecache pages can be demoted to low-tier memory, but 
> >> > they can only be promoted if a process maps the pages into the
> >> > memory space (so that NUMA hint faults can be caught).  This can
> >> > cause significant performance degradation as the pagecache ages
> >> > and unmapped, cached files are accessed.
> >> >
> >> > This patch series enables the pagecache to request a promotion of
> >> > a folio when it is accessed via the pagecache.
> >> >
> >> > We add a new `numa_hint_page_cache` counter in vmstat to capture
> >> > information on when these migrations occur.
> >> 
> >> It appears that you will promote page cache page on the second access.
> >> Do you have some better way to identify hot pages from the not-so-hot
> >> pages?  How to balance between unmapped and mapped pages?  We have hot
> >> page selection for hot pages.
> >> 
> >> [snip]
> >> 
> >
> > I've since explored moving this down under a (referenced && active) check.
> >
> > This would be more like promotion on third access within an LRU shrink
> > round (the LRU should, in theory, hack off the active bits on some decent
> > time interval when the system is pressured).
> >
> > Barring adding new counters to folios to track hits, I don't see a clear
> > and obvious way way to track hotness.  The primary observation here is 
> > that pagecache is un-mapped, and so cannot use numa-fault hints.
> >
> > This is more complicated with MGLRU, but I'm saving that for after I
> > figure out the plan for plain old LRU.
> 
> Several years ago, we have tried to use the access time tracking
> mechanism of NUMA balancing to track the access time latency of unmapped
> file cache folios.  The original implementation is as follows,
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=5f2e64ce75c0322602c2ec8c70b64bb69b1f1329
> 
> What do you think about this?
> 

Coming back around to explore this topic a bit more, dug into this old
patch and the LRU patch by Keith - I'm struggling find a good option
that doesn't over-complicate or propose something contentious.


I did a browse through lore and did not see any discussion on this patch
or on Keith's LRU patch, so i presume discussion on this happened largely
off-list.  So if you have any context as to why this wasn't RFC'd officially
I would like more information.


My observations between these 3 proposals:

- The page-lock state is complex while trying interpose in mark_folio_accessed,
  meaning inline promotion inside that interface is a non-starter.

  We found one deadlock during task exit due to the PTL being held. 

  This worries me more generally, but we did find some success changing certain
  calls to mark_folio_accessed to mark_folio_accessed_and_promote - rather than
  modifying mark_folio_accessed. This ends up changing code in similar places
  to your hook - but catches a more conditions that mark a page accessed.

- For Keith's proposal, promotions via LRU requires memory pressure on the lower
  tier to cause a shrink and therefore promotions. I'm not well versed in LRU
  LRU sematics, but it seems we could try proactive reclaim here.
  
  Doing promote-reclaim and demote/swap/evict reclaim on the same triggers
  seems counter-intuitive.

- Doing promotions inline with access creates overhead.  I've seen some research
  suggesting 60us+ per migration - so aggressiveness could harm performance.

  Doing it async would alleviate inline access overheads - but it could also make
  promotion pointless if time-to-promote is to far from liveliness of the pages.

- Doing async-promotion may also require something like PG_PROMOTABLE (as proposed
  by Keith's patch), which will obviously be a very contentious topic.


tl;dr: I'm learning towards a solution like you have here, but we may need to
make a sysfs switch similar to demotion_enabled in case of poor performance due
to heuristically degenerate access patterns, and we may need to expose some
form of adjustable aggressiveness value to make it tunable.

Reading more into the code surrounding this and other migration logic, I also
think we should explore an optimization to mempolicy that tries to aggressively
keep certain classes of memory on the local node (RX memory and stack for example).

Other areas of reclaim try to actively prevent demoting this type of memory, so we
should try not to allocate it there in the first place.

~Gregory

> --
> Best Regards,
> Huang, Ying

