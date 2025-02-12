Return-Path: <linux-kernel+bounces-511891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEA4A33110
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0550A168215
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0728202C32;
	Wed, 12 Feb 2025 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b3r02f8m"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A71EEA4A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393605; cv=none; b=QzFVBtQrlqsFOfAaX+EjZW8cgKH/zlPodIYt5RAei2jZdvcbUJ1ZIQTRsXqPXVQhATsGpxFuwC2r1usFtYZ/U+KAcw+qlk/Wr2qfwgCB4walMQr4G0TT2jOyt4APvzuMsZ/hBRWAK/lHt27YFBCHh8M5ZTwn+cmGb58iGboYwMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393605; c=relaxed/simple;
	bh=84UHxDBoYdA+kY+/UU1t3xkrj9quRKIGeHEFgRYRu8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlCpPMK0tYf9t6/utRzQJ+AuqAmkt6voDelUgNqz/vdlnFBZ4dIdSnY4NMVBgGgcv+gDQCZQOWXPVzQixt3oKC+0AiTlQE+pbNra86yYYRsJmbB2qIsKQV4g22Qew4dPY7Zr5oUUvznWZgfN4j/a6UEdJHsjxpy4MnhbRDpw0aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b3r02f8m; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de64873d18so198644a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739393601; x=1739998401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BI8Hs29AlJApHYUeKxAiymuqiMcyKQBfc27ErxehKn8=;
        b=b3r02f8mUKODtf4xML2E6jpc/1URXMT5iatYsNjNYKn7v2eier36eyU91/36+etefO
         3awqoAG+89X6p6kLeAy08o1R4D0ob/SP8wxnrtyUS5moHgvTF6qQ94tg+jXXp4zlLUDw
         PxXhcXoFCYki32QYnhTFV5bRAYFU8nd0uBRsj1wjYY4cIpzUCB4wBHHaqIMgPHbxuZdv
         h04icCOG0P/5Q3CKUHSFxHr2A9/1D0zNFoPZ8q7pn1jGQZQjheUAhbBt/fku7s5JLlbU
         k+eqBRBY19pkFGwwzdqsxpIORfgFamwS9h1oURitrGhWSpIlIfxiolNVHZJfkZfN5pgs
         7LJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739393601; x=1739998401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI8Hs29AlJApHYUeKxAiymuqiMcyKQBfc27ErxehKn8=;
        b=fcq8BIUbdyiV9dEUO9sAyretmk8sK2GjtpxYUOQM+cgUHmUAyPXzyGwzyfDJ7oQ3Dr
         nu3iOBDxfrZfZyws3ihIPHUf3h1N1aboLKxoUer0RaAVKOSG40Efjz2qrMJbj4cTSB6g
         XvTzVHfsynl8CBqerv88KZTzKc/dNfUPZqaiWxCl6RAuFq8g19e074YJU2iGXZ6Rs3oE
         RFMWdgDrdTWaBM/3A9b8xMM+5F8JI8MMjGUQd8NS7AZB26H+m7aRWbFOtgmJ1mMVTBON
         xqXEM6tZYDQIDvj6IwKWDAUN5i6LCwGXVnGzdcSO2iZW/R3IsPy7gQR0iCzJ/W4cllVK
         uKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoJfusqRUuINT/cjzyOsG2XtlPFsMJsAZYSsYwEudWmwsa0QBvgXu9VJKOHKkZyGF7b8dcgOumpgFs6+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEE0B7Xg8ciUR9Qmam/E94M5TRbA3WeXNeDQ7BPYVlpB/AUEE7
	Whq6Y5Au50vhIQXqbfFEWDehwwJNQSB6zhb2+1hvfOFl1MLKizV+v/prvZZbd1s=
X-Gm-Gg: ASbGncvV3eoYRvcYd/O5JLPQ4NGD2Faym3cp5JLVV7yPbOsytfoEpkR4PGv+hJuYQ+L
	0Jmb8luVhGeBrbfcqlW3Qm2N+gt9eliToOEMN0yPqjGoT338+quX65MNb0HcJMnvW3Eb3/SQSvm
	IlRYFQLBWrOQJjta/yBB2HAW+AXBaO50iEvhhyimucyDAXeVwM2JfXjw7y94acG9EgXPDERcjef
	SmwWmRdlOC69bmlH+NNpJEATS0hpUHk4ONB7LDiq1pfk9ixhzmQzA3GFGpFr22eTUuPQ3ojiI2i
	ssq/VSKjSr/Sx0x/J7txGRwe8dee
X-Google-Smtp-Source: AGHT+IEKdM0BPU6QxdXKNjigkoD51P8a49+kUcF9KZW04xn8FPIS+yrnI8fi3qoqlEXMlCEeuaY6oQ==
X-Received: by 2002:a17:907:971e:b0:aa6:5eae:7ece with SMTP id a640c23a62f3a-aba5018d567mr53227966b.43.1739393601385;
        Wed, 12 Feb 2025 12:53:21 -0800 (PST)
Received: from localhost (109-81-84-135.rct.o2.cz. [109.81.84.135])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7d855b61fsm452250766b.124.2025.02.12.12.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:53:21 -0800 (PST)
Date: Wed, 12 Feb 2025 21:53:20 +0100
From: Michal Hocko <mhocko@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>, Filipe Manana <fdmanana@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, percpu: do not consider sleepable allocations atomic
Message-ID: <Z60KQCuPCueqRwzc@tiehlicka>
References: <20250206122633.167896-1-mhocko@kernel.org>
 <Z6u5OJIQBw8QLGe_@slm.duckdns.org>
 <Z6zS4Dtyway78Gif@tiehlicka>
 <Z6zlC3juT46dLHr9@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6zlC3juT46dLHr9@slm.duckdns.org>

On Wed 12-02-25 08:14:35, Tejun Heo wrote:
> Hello,
> 
> On Wed, Feb 12, 2025 at 05:57:04PM +0100, Michal Hocko wrote:
> ...
> > I have gone with masking because that seemed easier to review and more
> > robust solution. vmalloc does support NOFS/NOIO contexts these days (it
> > will just uses scoped masking in those cases). Propagating the gfp
> 
> I see. Nice.
> 
> > throughout the worker code path is likely possible, but I haven't really
> > explored that in detail to be sure. Would that be preferable even if the
> > fix would be more involved?
> 
> Longer term, yeah, I think so.

I can invest more time into that direction if this is really preferred
way. Not my call but I would argue that the scope interface is actually a
good fit in the current implementation because it clearly defines the
scope of all allocation context at a single place. Ideally with a good
explanation on why is that (I guess I owe in that regards).

> > > Also, doesn't the above always prevent percpu allocations from doing fs/io
> > > reclaims? 
> > 
> > Yes it does. Probably worth mentioning in the changelog. These
> > allocations should be rare so having a constrained reclaim didn't really
> > seem problematic to me. There should be kswapd running in the background
> > with the full reclaim power.
> 
> Hmm... you'd a better judge on whether that'd be okay or not but it does
> bother me that we might be increasing the chance of allocation failures for
> GFP_KERNEL users at least under memory pressure.

Nope, this will not change the allocation failure mode. Reclaim
constrains do not change the failure mode they just change how much the
allocation might struggle to reclaim to succeed. 

My undocumented assumption (another dept on my end) is that pcp
allocations are no hot paths. So the worst case is that GFP_KERNEL
pcp_allocation could have been satisfied _easier_ (i.e. faster) because
it could have reclaimed fs/io caches and now it needs to rely on kswapd
to do that on memory tight situations. On the other hand we have a
situation when NOIO/FS allocations fail prematurely so there is
certainly some pros and cons.

As I've said I am no pcp allocator expert so I cannot really make proper
judgment calls. I can improve the changelog or move from scope to
specific gfp flags but I do not feel like I am positioned to make deeper
changes to the subsystem.

-- 
Michal Hocko
SUSE Labs

