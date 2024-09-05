Return-Path: <linux-kernel+bounces-317653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0419396E17C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292DF1C230C2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1950417A599;
	Thu,  5 Sep 2024 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xhaE1xtv"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16F15ADB4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559525; cv=none; b=tAIiEoy71W34ocRiyXGq6VqHVirr0D+DrmMzdYb5t8Q9HNA9qC8JXmI+HsV/njeimF4KZgyMbyVEUpMlehAhodr+YVXag6dTA50XYr76WIuBcCWG09AGMAFDVgA10Oo+gkUrkpd7U5BF7PMP+h7LhstAKrVCurfbK1ku8KqPEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559525; c=relaxed/simple;
	bh=fwuuqbt3N9ugUJJfYfPVVFnFlJUxa8Rgv1DY93ny0PA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SCsB/vRp/Jo/8P9I8ZOorkAMeMkAHqpzz6xCPhcJazmzH8QuA/nyaHwxzstuKGbSNCWCj46Q5D/6YmRd27xBm2sInBkrcN9lc1hS1HgGqtbJqmrHU+oHTGR732i78gZLZ0fbt8XdBcRrPGr+DscTgOPaEqq548M25IGjrYjo8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xhaE1xtv; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a018296fffso4209245ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725559523; x=1726164323; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JACy3LsEORLfoHEGD7EKNLc5Lwvyz2oKImXIztt5wps=;
        b=xhaE1xtvmnE22YaBuEsb9bBmHzgbW3Z1TImd2tXwewHjZbJKGiiBjVuMGW/Lizwsvg
         1N9SO9EEp/tH52Yv85LHfIOg+rOpjVlQMOJK8qbWqs+YtXSrHybYVG3zwfH0rk1vyRFn
         Rdyf8fFQfo6ndhduh2JM9P5sLGMAwppIlS5QOsBpsj5iYzytuPPewt8eN1QjYRsyiWu7
         dHf4mdgt+dWqeehLZeMcRFE+su7EH+4KFPyZQx5uYZk1t6r0p6UsNKIRIJSgtW71e+hB
         +jlsg60FsQwB7WgZyYIaKUirtHOyUPQy6Cr3SSjwUgNBktg5EEMkk/sqfU9SUlOo5dtE
         Y91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559523; x=1726164323;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JACy3LsEORLfoHEGD7EKNLc5Lwvyz2oKImXIztt5wps=;
        b=iHEfo5rqCFNXVyQi9hrnVVFtEV8/utAZ/qlt57+dC6BkZPQI1euOUaJ1sT2wtCkqIt
         WSmNvEaU1T4e/7slwyDj/Z22yhBNlAGI4YbY162ARQXYLIY+xUVe7uZ1MmZDWckR7utw
         FJQPgQQ7hiZ7mMOA7eUDXmvS5EeZeryVlNkj7yBWt+inFA+U2s9zvSpXJQ1YejTwiV9W
         9etLT0fVr0s8zV85pLJYtjmjGAcNeYIrSVCwCkjsFfI8riWP3bq/4z7TFykYQlKp3/XK
         AeSVShCcNTXVfqN6KdlDnBXJ90//kS0sy9l/sUQsOPeyQ4x4H27Zr4T6Lw6Ra0q3GKmC
         FgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU30m5RQHnqpDAC8iI6AmCQuxfiVF0NFz8+lGFfyRZj8i3iBwMyYxQv3ik5VIJRGOJQ7aFplNahkk4NxWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRzhrzHxSKseisBptOxu2qZ2D4jcdgloCrdvV6tQofQZppqxw
	+X7V/DLfVZE6gnpWBZ54kXt1jxDpGWBPYgRI+0kJ9x4kr1mKMgerMBUPKBGFVw==
X-Google-Smtp-Source: AGHT+IFw+wD+B0uqAGFnbHubKac3f2t2ytAlhpUog4fT3ny3a9crryvc6Qd33jM6Y3o1nron34LN/g==
X-Received: by 2002:a05:6e02:1569:b0:3a0:1828:31d9 with SMTP id e9e14a558f8ab-3a018283360mr66660025ab.24.1725559522462;
        Thu, 05 Sep 2024 11:05:22 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d5119668aasm510809a12.1.2024.09.05.11.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 11:05:21 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:05:09 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Usama Arif <usamaarif642@gmail.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, hannes@cmpxchg.org, 
    riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
    david@redhat.com, npache@redhat.com, baohua@kernel.org, 
    ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org, 
    cerasuolodomenico@gmail.com, ryncsn@gmail.com, corbet@lwn.net, 
    linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
    kernel-team@meta.com, Shuang Zhai <zhais@google.com>
Subject: Re: [PATCH v5 1/6] mm: free zapped tail pages when splitting isolated
 thp
In-Reply-To: <1ffdf94d-ce3f-4dac-8ed3-0681f98beebf@gmail.com>
Message-ID: <5efa255b-3689-0c91-1980-c0f0562d84e9@google.com>
References: <20240830100438.3623486-1-usamaarif642@gmail.com> <20240830100438.3623486-2-usamaarif642@gmail.com> <1d490ab5-5cf8-4c16-65d0-37a62999fcd5@google.com> <1ffdf94d-ce3f-4dac-8ed3-0681f98beebf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 5 Sep 2024, Usama Arif wrote:
> On 05/09/2024 09:46, Hugh Dickins wrote:
> > On Fri, 30 Aug 2024, Usama Arif wrote:
> > 
> >> From: Yu Zhao <yuzhao@google.com>
> >>
> >> If a tail page has only two references left, one inherited from the
> >> isolation of its head and the other from lru_add_page_tail() which we
> >> are about to drop, it means this tail page was concurrently zapped.
> >> Then we can safely free it and save page reclaim or migration the
> >> trouble of trying it.
> >>
> >> Signed-off-by: Yu Zhao <yuzhao@google.com>
> >> Tested-by: Shuang Zhai <zhais@google.com>
> >> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > 
> > I'm sorry, but I think this patch (just this 1/6) needs to be dropped:
> > it is only an optimization, and unless a persuasive performance case
> > can be made to extend it, it ought to go (perhaps revisited later).
> > 
> 
> I am ok for patch 1 only to be dropped. Patches 2-6 are not dependent on it.
> 
> Its an optimization and underused shrinker doesn't depend on it.
> Its possible that folio->new_folio below might fix it? But if it doesn't,
> I can retry later on to make this work and resend it only if it alone shows
> a significant performance improvement.
> 
> Thanks a lot for debugging this! and sorry it caused an issue.
> 
> 
> > The problem I kept hitting was that all my work, requiring compaction and
> > reclaim, got (killably) stuck in or repeatedly calling reclaim_throttle():
> > because nr_isolated_anon had grown high - and remained high even when the
> > load had all been killed.
> > 
> > Bisection led to the 2/6 (remap to shared zeropage), but I'd say this 1/6
> > is the one to blame. I was intending to send this patch to "fix" it:
> > 
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3295,6 +3295,8 @@ static void __split_huge_page(struct pag
> >  			folio_clear_active(new_folio);
> >  			folio_clear_unevictable(new_folio);
> >  			list_del(&new_folio->lru);
> > +			node_stat_sub_folio(folio, NR_ISOLATED_ANON +
> > +						folio_is_file_lru(folio));
> 
> Maybe this should have been below? (Notice the folio->new_folio)
> 
> +			node_stat_sub_folio(new_folio, NR_ISOLATED_ANON +
> +						folio_is_file_lru(new_folio));

Yes, how very stupid of me (I'm well aware of the earlier bugfixes here,
and ought not to have done a blind copy and paste of those lines): thanks.

However... it makes no difference. I gave yours a run, expecting a
much smaller negative number, but actually it works out much the same:
because, of course, by this point in the code "folio" is left pointing
to a small folio, and is almost equivalent to new_folio for the
node_stat calculations.

(I say "almost" because I guess there's a chance that the page at
folio got reused as part of a larger folio meanwhile, which would
throw the stats off (if they weren't off already).)

So, even with your fix to my fix, this code doesn't work.
Whereas a revert of this 1/6 does work: nr_isolated_anon and
nr_isolated_file come to 0 when the system is at rest, as expected
(and as silence from vmstat_refresh confirms - /proc/vmstat itself
presents negative stats as 0, in order to hide transient oddities).

Hugh

> 
> >  			if (!folio_batch_add(&free_folios, new_folio)) {
> >  				mem_cgroup_uncharge_folios(&free_folios);
> >  				free_unref_folios(&free_folios);
> > 
> > And that ran nicely, until I terminated the run and did
> > grep nr_isolated /proc/sys/vm/stat_refresh /proc/vmstat
> > at the end: stat_refresh kindly left a pr_warn in dmesg to say
> > nr_isolated_anon -334013737
> > 
> > My patch is not good enough. IIUC, some split_huge_pagers (reclaim?)
> > know how many pages they isolated and decremented the stats by, and
> > increment by that same number at the end; whereas other split_huge_pagers
> > (migration?) decrement one by one as they go through the list afterwards.
> > 
> > I've run out of time (I'm about to take a break): I gave up researching
> > who needs what, and was already feeling this optimization does too much
> > second guessing of what's needed (and its array of VM_WARN_ON_ONCE_FOLIOs
> > rather admits to that).
> > 
> > And I don't think it's as simple as moving the node_stat_sub_folio()
> > into 2/6 where the zero pte is substituted: that would probably handle
> > the vast majority of cases, but aren't there others which pass the
> > folio_ref_freeze(new_folio, 2) test - the title's zapped tail pages,
> > or racily truncated now that the folio has been unlocked, for example?
> > 
> > Hugh

