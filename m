Return-Path: <linux-kernel+bounces-376923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5437D9AB788
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B51B23166
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9571CB51C;
	Tue, 22 Oct 2024 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/mmAVhQ"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B21494A8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628115; cv=none; b=UDq3lc4meIqRWcjRHXetidnKDDZwe5M0OpiA9dJ4eyeVoteRfRpktHHlK5EOYzmDSKY4fXSyWbSv/sicyiAGjAolwDmALwSkN1duy1w8R41GRWMh+UkV1U64+/+NFaCpRWrl0kj64fAyzTJDUX/5vfaX8IoYWTiIRdjdGSiyMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628115; c=relaxed/simple;
	bh=tnbvmmIlq2ulBzcFePYnsbkpZnFfvq6ELE965NMIE1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSIQ08sjb4vSEbtjzMLVXJPZIkV0W10OHUX0vzxm4U3nNpc4z/A4OEmeKEdaze7pkBStTesjweCMVGtOoJ+/iKoceFFdmOxWIB7g0sENBJWzknxLWFdnpqPXFuSIGZ/Oii4VaRGrwsp7bzd04JwZWrbieHSxOHK2RfnVUPHp/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/mmAVhQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso4032039a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729628113; x=1730232913; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CcFx6jKt7NPm7XFrJBKBBZDDhyhUeCqHIYcsin52j20=;
        b=I/mmAVhQF6jB1rB91bdXinWIsA3UiSfv2vLBSXEBHVtvhJvwjSAzcej6huET7UeOoC
         R2aO7D3RuzNi1U0taJ0IbDMlF3f91Yj+pnMpyrgkkSgnqMMGJ+oQQniq+JEUU5ndc3mG
         GAgJFjnraMpEj1YwnsRlY55FC1+tL0BYE11S41tLdMvCv6eXB4b3m0tNrxz/sawC+9T6
         9Jwp08Ihe/eTncJYjpVPN/Dy2DsT/Z+2rK7UXQ5JEkbS7Prqk7Bss9ahbp7jpVbaRLIa
         AxyjGO1KiciPk32pUiguGfrWWPO4z65pP72OB9LJeG0eCqVMfJbCuNIG56VGdpGNaeuy
         3+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729628113; x=1730232913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcFx6jKt7NPm7XFrJBKBBZDDhyhUeCqHIYcsin52j20=;
        b=M4hQo/QdgDS53zA71U/GQJeE2BcG426z+Tubl5TwSpV+FEpZjkGQ4EuBlAcorCrDDn
         uILM4q8eF+IMGBm/2CEBUrw26ZLvZ0jN0gqhHEe8cSI5z4R3bDVde5KxuWIAin26GMP7
         ORbDR8H6S5zJdutKL32dLm0l70KPAoEIaAN9ANHI4MFZY1Q6IxEw4x/vevub1DhEg/IC
         5RgInu6uBR7eUsDFpo5RC5ff5+k+8JQAbAuw2UImqUpolK9czCqKyWUXmvRFqAovQYfr
         4/V5tHkOzTVS0bSQUEVf0hLoek6TFJMifBiXQP0MT9Ka109vGG5fQ3zmOgb8jWkyUtwD
         jOvw==
X-Forwarded-Encrypted: i=1; AJvYcCW4oAtQRmEzBOQHdPtvnw+mNE+9TAaMTN8dtwa8uqov3rVnJONDWKCOcl5Cizehw+e3VLmP2qzbtmDk/uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpM3eG19jkPY4d4XPjDKdg5lm3aj0/D5XTQ4q2bWEvhuZ2COP
	cJ3Ej0QdIEMFdxUVgS/drJPTGeZj/eHGs6r/YM2dDHrKQzZniYRC9V685g==
X-Google-Smtp-Source: AGHT+IEEtCTMQAjRRS1qWU9i9c7C9Av3MT5kGXo6PBlEg9ZjL+c1+HmRQjyY8cfs+z5u8k6KAUZLPA==
X-Received: by 2002:a17:90b:246:b0:2e2:ede0:91c with SMTP id 98e67ed59e1d1-2e76b727a8emr137336a91.36.1729628112750;
        Tue, 22 Oct 2024 13:15:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e14:7:a2ff:33b0:aec2:dc1d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad518767sm6672707a91.56.2024.10.22.13.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 13:15:11 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:15:09 -0700
From: Minchan Kim <minchan.kim@gmail.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, yuzhao@google.com,
	linux-mm@kvack.org, david@redhat.com, fengbaopeng@honor.com,
	gaoxu2@honor.com, hailong.liu@oppo.com, kaleshsingh@google.com,
	linux-kernel@vger.kernel.org, lokeshgidra@google.com,
	mhocko@suse.com, ngeoffray@google.com, shli@fb.com,
	surenb@google.com, v-songbaohua@oppo.com, yipengxiang@honor.com,
	Gao Xu <gaoxu2@hihonor.com>
Subject: Re: [PATCH v2] mm: mglru: provide a separate list for lazyfree anon
 folios
Message-ID: <ZxgHzUHcWvSNqXo2@google.com>
References: <20241016033030.36990-1-21cnbao@gmail.com>
 <20241016155835.8fadc58d913d9df14099514b@linux-foundation.org>
 <CAGsJ_4xYqSSUE_zq+2UWLT7UsF_ovH=+QE_va+_dcMq4fnz0rg@mail.gmail.com>
 <ZxFQTlPfR6y25cng@google.com>
 <CAGsJ_4zYRCotNTL2kKO202Rk2o78w5pZs25Y_iq=7OfS-KoX9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zYRCotNTL2kKO202Rk2o78w5pZs25Y_iq=7OfS-KoX9w@mail.gmail.com>

Hi Barry,

Sorry for slow response.

On Fri, Oct 18, 2024 at 06:12:01PM +1300, Barry Song wrote:
> On Fri, Oct 18, 2024 at 6:58 AM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Thu, Oct 17, 2024 at 06:59:09PM +1300, Barry Song wrote:
> > > On Thu, Oct 17, 2024 at 11:58 AM Andrew Morton
> > > <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Wed, 16 Oct 2024 16:30:30 +1300 Barry Song <21cnbao@gmail.com> wrote:
> > > >
> > > > > To address this, this patch proposes maintaining a separate list
> > > > > for lazyfree anon folios while keeping them classified under the
> > > > > "file" LRU type to minimize code changes.
> > > >
> > > > Thanks.  I'll await input from other MGLRU developers before adding
> > > > this for testing.
> > >
> > > Thanks!
> > >
> > > Hi Minchan, Yu,
> > >
> > > Any comments? I understand that Minchan may have a broader plan
> > > to "enable the system to maintain a quickly reclaimable memory
> > > pool and provide a knob for admins to control its size." While I
> > > have no objection to that plan, I believe improving MADV_FREE
> > > performance is a more urgent priority and a low-hanging fruit at this
> > > stage.
> >
> > Hi Barry,
> >
> > I have no idea why my email didn't send well before. I sent following
> > reply on Sep 24. Hope it works this time.
> 
> Hi Minchan,
> 
> I guess not. Your *this* email ended up in my spam folder of gmail, and
> my oppo.com account still hasn’t received it. Any idea why?

In the end, that's my problem and don't know when it can be fixed.
Anyway, hope again this time works.

> 
> >
> > ====== &< ======
> >
> > My proposal involves the following:
> >
> > 1. Introduce an "easily reclaimable" LRU list. This list would hold pages
> >    that can be quickly freed without significant overhead.
> 
> I assume you plan to keep both lazyfree anon pages and 'reclaimed'
> file folios (reclaimed in the normal LRU lists but still in the easily-
> reclaimable list) in this 'easily reclaimable' LRU list. However, I'm
> not sure this will work, as this patch aims to help reclaim lazyfree
> anon pages before file folios to reduce both file and anon refaults.
> If we place 'reclaimed' file folios and lazyfree anon folios in the
> same list, we may need to revisit how to reclaim lazyfree anon folios
> before reclaiming the 'reclaimed' file folios.

Those reclaimed folio was already *decision-made* but just couldn't due to
the *impelementation issue*. So, that's strong candidate to be reclaimed
as long as there is no access since then rather other candidates.

> 
> >
> > 2. Implement a parameter to control the size of this list. This allows for
> >    system tuning based on available memory and performance requirements.
> 
> If we include only 'reclaimed' file folios in this 'easily
> reclaimable' LRU list, the
> parameter makes sense. However, if we also add lazyfree folios to the list, the
> parameter becomes less meaningful since we can't predict how many
> lazyfree anon folios user space might have. I still feel lazyfree anon folios
> are different with "reclaimed" file folios (I mean reclaimed from normal
> lists but still in 'easily-reclaimable' list).

I thought the ez-reclamable LRU doesn't need to be accurate since we can
put other folios later(e.g., fadvise_dontneed but couldn't at that time)

> 
> >
> > 3. Modify kswapd behavior to utilize this list. When kswapd is awakened due
> >    to memory pressure, it should attempt to drop those pages first to refill
> >    free pages up to the high watermark by first reclaiming.
> >
> > 4. Before kswapd goes to sleep, it should scan the tail of the LRU list and
> >    move cold pages to the easily reclaimable list, unmapping them from the
> >    page table.
> >
> > 5. Whenever page cache hit, move the page into evictable LRU.
> >
> > This approach allows the system to maintain a pool of readily available
> > memory, mitigating the "aging" problem. The trade-off is the potential for
> > minor page faults and LRU movement ovehreads if these pages in ez_reclaimable
> > LRU are accessed again.
> 
> I believe you're aware of an implementation from Samsung that uses
> cleancache. Although it was dropped from the mainline kernel, it still
> exists in the Android kernel. Samsung's rbincache, based on cleancache,
> maintains a reserved memory region for holding reclaimed file folios.
> Instead of LRU movement, rbincache uses memcpy to transfer data between
> the pool and the page cache.
> 
> >
> > Furthermore, we could put some asynchrnous writeback pages(e.g., swap
> > out or writeback the fs pages) into the list, too.
> > Currently, what we are doing is rotate those pages back to head of LRU
> > and once writeback is done, move the page to the tail of LRU again.
> > We can simply put the page into ez_reclaimable LRU without rotating
> > back and forth.
> 
> If this is about establishing a pool of easily reclaimable file folios, I
> fully support the idea and am eager to try it, especially for Android,
> where there are certainly strong use cases. However, I suspect it may
> be controversial and could take months to gain acceptance. Therefore,
> I’d prefer we first focus on landing a smaller change to address the
> madv_free performance issue and treat that idea as a separate
> incremental patch set.

I don't want to block the improvement, Barry.

The reason I suggested another LRU was actullay to prevent divergent
between MGLRU and split-LRU and show the same behavior introducing
additional logic in the central place.
I don't think that's desire that a usespace hint showed different
priority depending on admin config.

Personally, I belive that would be better to introudce a knob to
change MADV_FREE's behavior for both LRU algorithms at the same time
instead of only one even though we will see the LRU inversion issue.

> 
> My current patch specifically targets the issue of reclaiming lazyfree
> anon folios before reclaiming file folios. It appears your proposal is
> independent (though related) work, and I don't believe it should delay
> resolving the madv_free issue. Additionally, that pool doesn’t effectively
> address the reclamation priority between files and lazyfree anon folios.
> 
> In conclusion:
> 
> 1. I agree that the pool is valuable, and I’d like to develop it as an
> incremental patch set. However, this is a significant step that will
> require considerable time.
> 2. It could be quite tricky to include both lazyfree anon folios and
> reclaimed file folios (which are reclaimed in normal lists but not in
> the 'easily-reclaimable' list) in the same LRU list. I’d prefer to
> start by replacing Samsung's rbincache to reduce file folio I/O if we
> decide to implement the pool.
> 3. I believe we should first focus on landing this fix patch for the
> madv_free performance issue.
> 
> What are your thoughts? I spoke with Yu, and he would like to hear
> your opinion.

Sure, I don't want to block any improvement but please think one more
one more about my concern and just go with your ideas if everyone
except me don't concern it.

Thank you.

