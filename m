Return-Path: <linux-kernel+bounces-255150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A75F933CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950F11C22646
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3D317FAA4;
	Wed, 17 Jul 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AkL4UWH0"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324817FADC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721218011; cv=none; b=Vvgp5SC4AWBkTcAM7aZdKFE8AhQ/iNyqAS9dQvpqz3LYnSOZJZEGDhyFqtmjELisZ2HFp8IegW6FxTvn1CKucPNiQpYTPhFoVocjGydji1Ge/EwSTcMlhE7hYgb+QqauCylFjf/9QzFWVwcsh/efVXgAvvq0bH9KjfbGNbxMTYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721218011; c=relaxed/simple;
	bh=yvH1bJuJPMDl0yHsKJUGXDy0li3oZEpOxlcFwqBzU0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZ4oRTsD6eI+ntwOmz3xQeoKeB+o87/6tEr+ZwwMROz1MzyAtkS3qsemYmlt+i1w19+JaqjU4bYAVGZg52t+F/F/UzemYZ9DKX/adzywby9NnNvWGBw3wiCBxZOYPf7AviqT/daxx1GuDV8BMtLGVpcUj6i9Vbq3gfs0aBxLDDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AkL4UWH0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58b447c513aso7099432a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721218008; x=1721822808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1A+uhvZFWN0/aI6TtzrTAyQXjVBtroZMv7k34eBegwY=;
        b=AkL4UWH0fjTo7/yr1I7J0TuJVaNgAI0ni3u0+qPBBRiwa2Ij2HWtnwnnDM3JEsJVBM
         AcE81Vvhm40dS2FytehJdawA0P+MxrZeGAsvruEXemt56Nfta1bKKNsIMpewCXDjZVnO
         7b//JTWbo9NXilIPE4RtKN/PLN3KFPokufLMlnGSbR0ru1ZKE2zvxzw3bjSI8QR2KufY
         ZhXvocpbvRqNSt/xCCgkQetf5GnBESeMiJujUjRYesLLqNatPvCcGR8pghQZWzE5qOj1
         6Mg6uQCOk6sKR4ZoIUtWuyVzE4L8u/bhIlCJH/RkS994CTRiIjn6ul4Uvz4F7tJ8Dqlr
         XNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721218008; x=1721822808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1A+uhvZFWN0/aI6TtzrTAyQXjVBtroZMv7k34eBegwY=;
        b=usc7qCmvhFp5CRyyGMfppaJe2E4QP1PUK/wVAytXKYGk8+blD2RP57qMxQIQoIWfxK
         Fn4DMrrcDfTciLzZdlhY4RWAhShxe0Tw/ljjqCzUbrbyQklAxP3ThxoKKfPUkBlAR6xD
         SQfqSFG+DjStxAwQyOW9txfiieiU5qEU4+qLf9pC/Ankp5P349MHZezmN6rmhw1LyvFP
         lJGxlh3sNGN3gEaLsqdEgL76rEJlqGevAeNogvtxwdrCP+nGJpbnFWZKrtiluNUHLY+D
         vPk2UO651MiqT6a9vXiru8kKPL2dpf0Bxlzfj3hmevRTv2kqQU53wK4rTWsHOKC+pV+A
         Wvfg==
X-Forwarded-Encrypted: i=1; AJvYcCWeK3spSOyut7/Ah4jtZT0PN7tjKxxyDuk9ynJjttykQhdOkKe5MfVOqL0i3WhOKsThoRUWx8ngePDcwy0NunazBUm+vPbd7PfzGdXO
X-Gm-Message-State: AOJu0YxovyCAih7FcMLLVMq7i6n0YeV4NJuO5zh6vUpIVprv0tW+H+Se
	g+ptkR2auASHnZVnXzlkcHAirJbrl1katx0XXZ7TY7ambbyfRSbA+5GRsFUQP5A=
X-Google-Smtp-Source: AGHT+IFKEQnsVc87r2NlBgc3y7tiA0/99uSXp6CQ8sd9Ors0/3XF6WibUv9rRg2aDIdfojAjEABnDQ==
X-Received: by 2002:a50:c30a:0:b0:59e:b95d:e748 with SMTP id 4fb4d7f45d1cf-5a05b416a9fmr1228473a12.8.1721218008012;
        Wed, 17 Jul 2024 05:06:48 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a0c2a750c0sm551431a12.60.2024.07.17.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 05:06:47 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:06:46 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jianxiong Gao <jxgao@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix endless reclaim on machines with unaccepted
 memory.
Message-ID: <Zpez1rkIQzVWxi7q@tiehlicka>
References: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
 <ZpdwcOv9WiILZNvz@tiehlicka>
 <xtcmz6b66wayqxzfio4funmrja7ezgmp3mvudjodt5xfx64rot@s6whj735oimb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xtcmz6b66wayqxzfio4funmrja7ezgmp3mvudjodt5xfx64rot@s6whj735oimb>

On Wed 17-07-24 14:55:08, Kirill A. Shutemov wrote:
> On Wed, Jul 17, 2024 at 09:19:12AM +0200, Michal Hocko wrote:
> > On Tue 16-07-24 16:00:13, Kirill A. Shutemov wrote:
> > > Unaccepted memory is considered unusable free memory, which is not
> > > counted as free on the zone watermark check. This causes
> > > get_page_from_freelist() to accept more memory to hit the high
> > > watermark, but it creates problems in the reclaim path.
> > > 
> > > The reclaim path encounters a failed zone watermark check and attempts
> > > to reclaim memory. This is usually successful, but if there is little or
> > > no reclaimable memory, it can result in endless reclaim with little to
> > > no progress. This can occur early in the boot process, just after start
> > > of the init process when the only reclaimable memory is the page cache
> > > of the init executable and its libraries.
> > 
> > How does this happen when try_to_accept_memory is the first thing to do
> > when wmark check fails in the allocation path?
> 
> Good question.
> 
> I've lost access to the test setup and cannot check it directly right now.
> 
> Reading the code Looks like __alloc_pages_bulk() bypasses
> get_page_from_freelist() where we usually accept more pages and goes
> directly to __rmqueue_pcplist() -> rmqueue_bulk() -> __rmqueue().
> 
> Will look more into it when I have access to the test setup.
> 
> > Could you describe what was the initial configuration of the system? How
> > much of the unaccepted memory was there to trigger this?
> 
> This is large TDX guest VM: 176 vCPUs and ~800GiB of memory.
> 
> One thing that I noticed that the problem is only triggered when LRU_GEN
> enabled. But I failed to identify why.
> 
> The system hang (or have very little progress) shortly after systemd
> starts.

Please try to investigate this further. The patch as is looks rather
questionable to me TBH. Spilling unaccepted memory into the reclaim
seems like something we should avoid if possible as this is something
page allocator should care about IMHO.

> > > To address this issue, teach shrink_node() and shrink_zones() to accept
> > > memory before attempting to reclaim.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Reported-by: Jianxiong Gao <jxgao@google.com>
> > > Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
> > > Cc: stable@vger.kernel.org # v6.5+
> > [...]
> > >  static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> > >  {
> > >  	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
> > >  	struct lruvec *target_lruvec;
> > >  	bool reclaimable = false;
> > >  
> > > +	/* Try to accept memory before going for reclaim */
> > > +	if (node_try_to_accept_memory(pgdat, sc)) {
> > > +		if (!should_continue_reclaim(pgdat, 0, sc))
> > > +			return;
> > > +	}
> > > +
> > 
> > This would need an exemption from the memcg reclaim.
> 
> Hm. Could you elaborate why?

Because memcg reclaim doesn't look for memory but rather frees charges
to reclaim for the new use so unaccepted memory is not really relevant
as it couldn't have been charged.
-- 
Michal Hocko
SUSE Labs

