Return-Path: <linux-kernel+bounces-385536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C44BF9B3850
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F104B224E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AE41DF25C;
	Mon, 28 Oct 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhlEi0rM"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682001DED40
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138107; cv=none; b=NqrZqPAjeQ7BwcMlIdsw7mpjFogVwKAND2MsBWvClgMXxuE9TnxnwCt6Ec6nJOab3dvLUn7CZI4NB64DklwrOXOxqeUsVI2uqx5p7yQGD2+dwjNN+vKNsXQ2PyL9AgqHoFTU22KstmMHV364dCUexfJbyn++RyZkrj4YjNC1MAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138107; c=relaxed/simple;
	bh=76NEiAhCULKghHCOTi8HEn+XigOAhX13pYtFw/tq9FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1WhCG+rpPUCVz1WE2K4bvYMWbC7u2os3gd6FX+HSF6oniuutsKBWc6MCuedKNGvwJcFxMqB0vYac8NsUXKeYKVq+ZRjppuYz0a1515yTQAQCI8hJy1ZBWm0CCFyweldjxMvcgrrISTo00rvnZ6opftGzDQIKj/SwD3c+QpoA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hhlEi0rM; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4a46d36c044so2489246137.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730138104; x=1730742904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76NEiAhCULKghHCOTi8HEn+XigOAhX13pYtFw/tq9FM=;
        b=hhlEi0rMhnqQcn05x7gWDN1R7sOiCquZK8TZNKUoNO2szWkJQJQCDbkTAVU3B191UL
         vHB9KnWFqd4yWHEdfLYdh5vqPx+a3e0bqOFvBGUGdU7gN1ptnqap0HT2fK5mbNdserU/
         4TM4z9DEsig6Vy3I1A2MYdKUGvEWJAl2OejjhTy6P1XE7VS0ZwDIlz+bTvOQYH8jxGwo
         iDx8gOtDGjXFpz6eGb4Pwv9OmlZoF2rgHcoEuFj6z0UFuOh564f0bQ5qoX2oe8qk6iSP
         hL/RMQPMWgGkSbbJfAi2vExV5n2Am1G12EFFW6foHtM6YbAwP3vF3illage62GL3qEE8
         IF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730138104; x=1730742904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76NEiAhCULKghHCOTi8HEn+XigOAhX13pYtFw/tq9FM=;
        b=moxsK5ODr6UfWkOv9Q7q0JxUsL4Uy3QNS0nnzP+J/D1ulV4RYRvXepy4Yas7zqa7rX
         /SlMRg9mf8d44Wjv1jy4/M5jJrHI9gISO9TnohMEFz3xs/T3qYoTS3SYkCqF2NigH/Z3
         V3zlTxTxCNzDRuVAwDF+F5lU/zbjx1gINi6urhno+Xz4H0vdKWyiCEoebr+aMRugMdas
         ji96O4TranZG/DxWA9PgOjurN3hswSGFLGpsLzCFzW5w0qTN3SBhe1F2RLTUvjN2qfat
         4VcJbca8Qv0gW+lQ93F7/P4UNPnzVp0GqYFJ4wRCtDG2x342L3vzZmgGO+YepAEsve8U
         IanQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSxFytCNjmPcb3avhB43oZr9P34EdLLicrcbkwiLboamoeB/psnI/s9l2Q7M4mtf5FGwsHsSIazNbfO0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/H+Am/fhm3yERpZj3Vc6Z+K+JG7GbwbCwChspmaoGg7noibY
	/PQBKL+M5n+dj7YlU4j6eEoBumuCvXYfIfhdxttqPUHXQCzGlwO9+chPoKKvzcAK0aXHB1dMuWc
	smCszhmf31dlCaWGTeDunuMai6C1dARQa3cd9
X-Google-Smtp-Source: AGHT+IF+Njw3B2yyWa+PFr05ljvRcXvEMDxqBd0fMPaxgVP5hF0UW3Sx2OmvHFr28RqI1EbvlEOTgzarr1bO+bd/VqY=
X-Received: by 2002:a05:6102:2908:b0:4a4:97d1:ae99 with SMTP id
 ada2fe7eead31-4a8f2bdf107mr547802137.12.1730138104112; Mon, 28 Oct 2024
 10:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026033625.2237102-1-yuzhao@google.com> <37a28ef7-e477-40b0-a8e4-3d74b747e323@suse.cz>
 <CAOUHufaS-dGAPGs1Y1=imW_nusaTDeysN3qfJc9-76DBVEHScQ@mail.gmail.com>
 <8459b884-5877-41bd-a882-546e046b9dad@suse.cz> <CAOUHufbHVXNZpW1mVhuF+4p8PbPq44w4chQX7Q6QYVDCjSqa1Q@mail.gmail.com>
 <6ac7a38f-30df-4403-8723-a43829bcdba5@suse.cz> <CAOUHufYyEjDG1+MEqRhuWPL037aSqrDhi_FT5gfyktbpQBmDVA@mail.gmail.com>
 <fb1db044-e5da-4a77-b0ba-9a059a5f5ad9@suse.cz>
In-Reply-To: <fb1db044-e5da-4a77-b0ba-9a059a5f5ad9@suse.cz>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 28 Oct 2024 11:54:27 -0600
Message-ID: <CAOUHufZB8zCwO4nT3aeZWxJO99SD9vUJxhkGedWrmmz3J-Sczw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2] mm/page_alloc: keep track of free highatomic
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Zi Yan <ziy@nvidia.com>, Mel Gorman <mgorman@techsingularity.net>, 
	Matt Fleming <mfleming@cloudflare.com>, David Rientjes <rientjes@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 5:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/28/24 1:24 AM, Yu Zhao wrote:
> > On Sun, Oct 27, 2024 at 3:05=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 10/27/24 21:51, Yu Zhao wrote:
> >>> On Sun, Oct 27, 2024 at 2:36=E2=80=AFPM Vlastimil Babka <vbabka@suse.=
cz> wrote:
> >>>>
> >>>> On 10/27/24 21:17, Yu Zhao wrote:
> >>>>> On Sun, Oct 27, 2024 at 1:53=E2=80=AFPM Vlastimil Babka <vbabka@sus=
e.cz> wrote:
> >>>>>>
> >>>>
> >>>> For example:
> >>>>
> >>>> - a page is on pcplist in MIGRATE_MOVABLE list
> >>>> - we reserve its pageblock as highatomic, which does nothing to the =
page on
> >>>> the pcplist
> >>>> - page above is flushed from pcplist to zone freelist, but it rememb=
ers it
> >>>> was MIGRATE_MOVABLE, merges with another buddy/buddies from the
> >>>> now-highatomic list, the resulting order-X page ends up on the movab=
le
> >>>> freelist despite being in highatomic pageblock. The counter of free
> >>>> highatomic is now wrong wrt the freelist reality
> >>>
> >>> This is the part I don't follow: how is it wrong w.r.t. the freelist
> >>> reality? The new nr_free_highatomic should reflect how many pages are
> >>> exactly on free_list[MIGRATE_HIGHATOMIC], because it's updated
> >>> accordingly.
> >>
> >> You'd have to try implementing your change in the kernel without that
> >> migratetype hygiene series, and see how it would either not work, or y=
ou'd
> >> end up implementing the series as part of that.
> >
> > A proper backport would need to track the MT of the free_list a page
> > is deleted from, and I see no reason why in such a proper backport
> > "the counter could drift easily" or "the counter of free highatomic is
> > now wrong wrt the freelist reality". So I assume you actually mean
> > this patch can't be backported cleanly? (Which I do agree.)
>
> Yes you're right. But since we don't plan to backport it beyond 6.12,
> sorry for sidetracking the discussion unnecessarily. More importantly,
> is it possible to change the implementation as I suggested?

The only reason I didn't fold account_highatomic_freepages() into
account_freepages() is because the former must be called under the
zone lock, which is also how the latter is called but not as a
requirement.

I understand where you come from when suggesting a new per-cpu counter
for free highatomic. I have to disagree with that because 1) free
highatomic is relatively small and drifting might defeat its purpose;
2) per-cpu memory is among the top kernel memory overhead in our fleet
-- it really adds up. So I prefer not to use per-cpu counters unless
necessary.

So if it's ok with you, I'll just fold account_highatomic_freepages()
into account_freepages(), but keep the counter as per zone, not per
cpu.

> [1] Hooking
> to __del_page_from_free_list() and __add_to_free_list() means extra work
> in every loop iteration in expand() and __free_one_page(). The
> migratetype hygiene should ensure it's not necessary to intercept every
> freelist add/move and hooking to account_freepages() should be
> sufficient and in line with the intended design.

Agreed.

