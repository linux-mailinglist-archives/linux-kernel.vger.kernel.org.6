Return-Path: <linux-kernel+bounces-201446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A44C8FBEB6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92AC3B22DD2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DCA14B97F;
	Tue,  4 Jun 2024 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LFOTGf+1"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7E13F442
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539419; cv=none; b=CZ+Rn5Y4T/+oxY37fW/KcD2zldcmJvvTskzTbZxgLUVO5KUhsuy+/y2sD/R7kGbugTnbt0J23hCrVRMU5ceEq0qMigDlq2i4SFlBlSP3qZEln/D6CfJvEN1JA4F18GBPh+ALWMYRVUZ6vVsXKIxs9iDWLS6imkerMQ0MEQrtQ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539419; c=relaxed/simple;
	bh=KYtISeMzz1THihc4es05/qdOuUzfKAluc0lBC+nAkB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWlZ2kWy0bLam04XpRzmxOhquAEImaURPJE3+uTnJUKpcmhynhz5BfXq7A5VfnU2JYIlN7Ip3pCIiPk4e9dlhHI8E9CNy1QQ53shg9+bS29C556uHbbHGzntWYJPgeOXLTEbYSoYq4kZ8tO2Fp/iNqHP8IIPGAdbfP87pYjbTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LFOTGf+1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7024426c75dso4168060b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 15:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717539417; x=1718144217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LY/NgoQsOd9qvc/Z2SEg+orugNh9702LBmBQx6wrC7I=;
        b=LFOTGf+1kAjub9b4TZR3eKCCPD1Aa3B/+tqX/7IHrYjFr0Ets1on3J7mUEkRVNRTAf
         7lOh/+ZEL/qmxwXXQyuLDrRvveOdkiw2NFHO9wKSwMdNM5a4mZc9MaxoO8m6x9f26nOX
         emgG4ZovAO9JQyfOG0cBlgy2qalDyp3e9cU6RvByUS5S9DFUDADrXOoe2/ZEUy1OSlGz
         hyqI1hR4k6sWSlYRmUMLfVa4jU4nZt0SMlDTiKIS7yqdp0IbLZeXYnhFxi0LXGDu+YsL
         Z59IZhYoLDbjriTrG/VtuMft1Uggf65hifgI+LsoqjziqmR0/aXg9h1ezJidG3ybZGnA
         XFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717539417; x=1718144217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LY/NgoQsOd9qvc/Z2SEg+orugNh9702LBmBQx6wrC7I=;
        b=Ht9EJ7/39qouAqy6RvEdXqKuPOZ/LBj2ZDDRpGTR2z1luTigpyjUamOwhp7TQsK45x
         Y/IjKJzUe5aECYWmagNcH3zDG8YzCROA0KE2Kj4BvEMnN6NS2GXZ96xaZ9JLJnuJh9xC
         qoaomSxrU0tfNPIWCUev+lhRu161+LtoNKHV2Zp1dfn5yOX/9gHhPwR/vra2yLIPeIOI
         mCoMSw6QDwOydGEccm/9VSWV+uy2xf1lQeHA5CSJAFLR+e3gFf+rnf+LPNM1vU+mQ7Vi
         NsiT/uOydM5fHJdgUY3rs4YzXjZ/ZqwlazJD9xYpjbhapjQkwyvqFqV5sKi2v+jvnqeq
         k4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkzGHP0MoNu1dFCEgxEJGOrLthcqs020QbF8ws776AWOg69BnfWq92C1gb9YPHFB6tN+PaX+3s/qNGQRw9P1CsEh99ATgdxK6QjPAY
X-Gm-Message-State: AOJu0YytGisw5EonkQ5TI9Yrgo02ZJwYuRWZxoJor/cI7PnafTBcCD1b
	sUzViHPdYCDmrvcnJfHnVBUCFYMoCuBKtkY/rClyDe3raYUm6D6hd+AtQdBrAvk=
X-Google-Smtp-Source: AGHT+IFLj6Jb9OQJLgAnz7o5uvnzARVsTD2NY9IEjWnIPst4nRgRW2yWp3rYgwzJGvBwY05nQEL5lA==
X-Received: by 2002:a05:6a21:622:b0:1b2:b5af:ce6a with SMTP id adf61e73a8af0-1b2b716f151mr865384637.60.1717539416897;
        Tue, 04 Jun 2024 15:16:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:4c40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703599758b6sm584553b3a.173.2024.06.04.15.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:16:56 -0700 (PDT)
Date: Tue, 4 Jun 2024 18:16:54 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	lege.wang@jaguarmicro.com,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [HELP] FUSE writeback performance bottleneck
Message-ID: <20240604221654.GA17503@localhost.localdomain>
References: <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
 <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com>
 <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
 <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com>
 <21741978-a604-4054-8af9-793085925c82@fastmail.fm>
 <20240604165319.GG3413@localhost.localdomain>
 <6853a389-031b-4bd6-a300-dea878979d8c@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6853a389-031b-4bd6-a300-dea878979d8c@fastmail.fm>

On Tue, Jun 04, 2024 at 11:39:17PM +0200, Bernd Schubert wrote:
> 
> 
> On 6/4/24 18:53, Josef Bacik wrote:
> > On Tue, Jun 04, 2024 at 04:13:25PM +0200, Bernd Schubert wrote:
> >>
> >>
> >> On 6/4/24 12:02, Miklos Szeredi wrote:
> >>> On Tue, 4 Jun 2024 at 11:32, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> >>>
> >>>> Back to the background for the copy, so it copies pages to avoid
> >>>> blocking on memory reclaim. With that allocation it in fact increases
> >>>> memory pressure even more. Isn't the right solution to mark those pages
> >>>> as not reclaimable and to avoid blocking on it? Which is what the tmp
> >>>> pages do, just not in beautiful way.
> >>>
> >>> Copying to the tmp page is the same as marking the pages as
> >>> non-reclaimable and non-syncable.
> >>>
> >>> Conceptually it would be nice to only copy when there's something
> >>> actually waiting for writeback on the page.
> >>>
> >>> Note: normally the WRITE request would be copied to userspace along
> >>> with the contents of the pages very soon after starting writeback.
> >>> After this the contents of the page no longer matter, and we can just
> >>> clear writeback without doing the copy.
> >>>
> >>> But if the request gets stuck in the input queue before being copied
> >>> to userspace, then deadlock can still happen if the server blocks on
> >>> direct reclaim and won't continue with processing the queue.   And
> >>> sync(2) will also block in that case.>
> >>> So we'd somehow need to handle stuck WRITE requests.   I don't see an
> >>> easy way to do this "on demand", when something actually starts
> >>> waiting on PG_writeback.  Alternatively the page copy could be done
> >>> after a timeout, which is ugly, but much easier to implement.
> >>
> >> I think the timeout method would only work if we have already allocated
> >> the pages, under memory pressure page allocation might not work well.
> >> But then this still seems to be a workaround, because we don't take any
> >> less memory with these copied pages.
> >> I'm going to look into mm/ if there isn't a better solution.
> > 
> > I've thought a bit about this, and I still don't have a good solution, so I'm
> > going to throw out my random thoughts and see if it helps us get to a good spot.
> > 
> > 1. Generally we are moving away from GFP_NOFS/GFP_NOIO to instead use
> >    memalloc_*_save/memalloc_*_restore, so instead the process is marked being in
> >    these contexts.  We could do something similar for FUSE, tho this gets hairy
> >    with things that async off request handling to other threads (which is all of
> >    the FUSE file systems we have internally).  We'd need to have some way to
> >    apply this to an entire process group, but this could be a workable solution.
> > 
> 
> I'm not sure how either of of both (GFP_ and memalloc_) would work for
> userspace allocations.
> Wouldn't we basically need to have a feature to disable memory
> allocations for fuse userspace tasks? Hmm, maybe through mem_cgroup.
> Although even then, the file system might depend on other kernel
> resources (backend file system or block device or even network) that
> might do allocations on their own without the knowledge of the fuse server.
> 

Basically that only in the case that we're handling a request from memory
pressure we would invoke this, and then any allocation would automatically have
gfp_nofs protection because it's flagged at the task level.

Again there's a lot of problems with this, like how do we set it for the task,
how does it work for threads etc.

> > 2. Per-request timeouts.  This is something we're planning on tackling for other
> >    reasons, but it could fit nicely here to say "if this fuse fs has a
> >    per-request timeout, skip the copy".  That way we at least know we're upper
> >    bound on how long we would be "deadlocked".  I don't love this approach
> >    because it's still a deadlock until the timeout elapsed, but it's an idea.
> 
> Hmm, how do we know "this fuse fs has a per-request timeout"? I don't
> think we could trust initialization flags set by userspace.
> 

It would be controlled by the kernel.  So at init time the fuse file system says
"my command timeout is 30 minutes."  Then the kernel enforces this by having a
per-request timeout, and once that 30 minutes elapses we cancel the request and
EIO it.  User space doesn't do anything beyond telling the kernel what it's
timeout is, so this would be safe.

> > 
> > 3. Since we're limiting writeout per the BDI, we could just say FUSE is special,
> >    only one memory reclaim related writeout at a time.  We flag when we're doing
> >    a write via memory reclaim, and then if we try to trigger writeout via memory
> >    reclaim again we simply reject it to avoid the deadlock.  This has the
> >    downside of making it so non-fuse related things that may be triggering
> >    direct reclaim through FUSE means they'll reclaim something else, and if the
> >    dirty pages from FUSE are the ones causing the problem we could spin a bunch
> >    evicting pages that we don't care about and thrashing a bit.
> 
> 
> Isn't that what we have right now? Reclaim basically ignores fuse tmp pages.

Yes but extending it to no longer have tmp pages and tie it to the BDI instead,
my goal is to get rid of all the excess copying.  Thanks,

Josef

