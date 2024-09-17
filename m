Return-Path: <linux-kernel+bounces-332161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AEC97B635
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 01:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20C8284DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 23:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D662E1917E0;
	Tue, 17 Sep 2024 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="3Dq+i2mf"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E7166F11
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726616084; cv=none; b=ieK2IhKB5bIwqoOISBCnnIMcFTDd8wpGDiGugOpfwSiHtB75LywLI5lu96OYl1/YzbhZly5rXerszJWYFkp0sjvsGkG4X9sUp1V3QDRU9QUIg/DxFmOe/8kF6wrrOrUV7WuSqukYwlSxrRKkMzI4iQicSchEQXV/7VYecF7/2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726616084; c=relaxed/simple;
	bh=NT3D74mJDKPinv7EfAHmJxpIy4X3CPvCZzITyCth3sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEz5w/hYfrSeQVLFbf2Ukftj0U/5OOR7USFqPjMA0F7AuY301Cr2y8v+sE6y+fdzE3wglb5c4y8vNYd5SVeR+x3tkdWhkEC95wTBuaf8R1EmrxoWDu2CVj0KE6lZHdHoOl4Ycd1nOwOhflKYw/bUQp8evHBD7bPvgxx/ScWDog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=3Dq+i2mf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2053a0bd0a6so65044065ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726616082; x=1727220882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=07uea7yJ0apHmLqc69KT0AE+/9P9TTFiIR2vNmcXQ50=;
        b=3Dq+i2mfiDIU9ePiYf2mNTXsIq5zrfsH0tNs7WMn5UGv7MQKm+3pU8lJ2QMD52kbUO
         m4eczv7zKYOwxwEzXZdcdDvUUVs61PdBaCGN93iRTqIQ3YG9iCoOtkAUEEdXevHEFllr
         FHQXx64SW5un87vxTOrcJjF4jxb5PN0lvrmVOnAfZRbmKgH7t40q5wGDclvNXDdulzzQ
         Oi5mpDZGKS3/hcTWeNGzY07T8vCQK1vRizCk5KvY2aUYvQppf8JKbGqX5FsU30fDQ1GK
         UAmSD1WgyvWgqbBXJyI8LpqS6/POWmvcytqALiUP7QrVS7XvNhiJjygiMzaPvfVEqptt
         1euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726616082; x=1727220882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07uea7yJ0apHmLqc69KT0AE+/9P9TTFiIR2vNmcXQ50=;
        b=TKbrgvOZtQyHy/Haf/AQTujF6FXYGgo1YBJNKgHvuAZoPooK7eg52WUj9U2kvq4hph
         fH2tXwlzslBCSPkVLK49LILwrOMqIZIKAT9wVmqf+vapTImqswN+vc6BVgDHgtGzoZWu
         zdH+9RuBKtEzvTvbrtCIcRitMHngC4teFm7OJJVE8TOrFV2ohQMcgZupFAiCIkQfb1te
         fQ46lozdgi5grNKq+mIdbu85W+yQ77zhUNvWhMgS5Ia3cRx/kaheYfRTaG3qpALMSZKo
         wlC6vvpTRUmFW3EZt1asSiAaimM3/1v5b0ld9Hd92IVQgaMUKIfCVUXzwctexPXYQktM
         I2ow==
X-Forwarded-Encrypted: i=1; AJvYcCXq2SrSs7ZQzmJ1f/q7p7F1u3QFvRZRiKVlZ45O/BDHYJ77dAwgfsM2ml03DU8+0bCG8k5Yb4XXUJ8vpSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkr+zYGQiJMf9SyxCqCstNVfo9UkyTFPuba9HSKqVFvpOnfShD
	IMYIgWn8LhVU2mPSMVcp3xQLUzbr/WFCEgT17cPn/bgljNC9FTo0AQuVPqu3wpM=
X-Google-Smtp-Source: AGHT+IEeRN7SJSiVdQD32+EIk70Z7O5kuCKkOZtCUoWPrKpS2lC478IZc1STDoJy29E1/hZeqgFG+Q==
X-Received: by 2002:a17:902:f54d:b0:207:3a5d:69b7 with SMTP id d9443c01a7336-2076e33c532mr289966395ad.15.1726616081593;
        Tue, 17 Sep 2024 16:34:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da8dfsm54969715ad.46.2024.09.17.16.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 16:34:40 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sqhiP-006ZBD-29;
	Wed, 18 Sep 2024 09:34:37 +1000
Date: Wed, 18 Sep 2024 09:34:37 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
	dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <ZuoSDVJPOX44Fww/@dread.disaster.area>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com>
 <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <877cbq3g9i.fsf@gmail.com>
 <ZtlQt/7VHbOtQ+gY@dread.disaster.area>
 <8734m7henr.fsf@gmail.com>
 <ZufYRolfyUqEOS1c@dread.disaster.area>
 <c8a9dba5-7d02-4aa2-a01f-dd7f53b24938@oracle.com>
 <20240917205420.GB182177@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917205420.GB182177@frogsfrogsfrogs>

On Tue, Sep 17, 2024 at 01:54:20PM -0700, Darrick J. Wong wrote:
> On Mon, Sep 16, 2024 at 11:24:56AM +0100, John Garry wrote:
> > On 16/09/2024 08:03, Dave Chinner wrote:
> > > OTOH, we can't do this with atomic writes. Atomic writes require
> > > some mkfs help because they require explicit physical alignment of
> > > the filesystem to the underlying storage.
> 
> Forcealign requires agsize%extsize==0,

No it doesn't.

AG size is irrelevant when aligning extents - all
that matters is that we can find a free extent that can be trimmed
to the alignment defined by extsize. 

> it's atomicwrites that adds the
> requirement that extsize be a power of 2...

Only by explicit implementation constraint.

Atomic writes do not require power of two extsize - they only
require correctly aligned physical extents.

e.g an 8kB atomic write is always guaranteed to succeed if
we have an extsize of 24kB for laying out the physical extents
because a 24kB physical extent is always 8kB aligned and is an exact
multiple of 8kB. This meets the requirements for 8kB atomic writes to
always succeed, and hence there is no fundamental requirement for
extsize to be a power of 2.

We have *chosen* to simplify the implementation by only allowing
a single aligned atomic write to be issued at a time. This means
the alignment and size of atomic writes is always the minimum size
the hardware advertises, and that is (at present) always a power of
2.

Hence the "extsize needs to be a power of 2" comes from the
constraints exposed from the block device configuration (i.e.
minimum atomic write unit), not from a filesystem design or
implementation constraint.

At the filesystem level, we have further simplified things by only
allowing extsize = atomic write size. Hence the initial
implementation ends up only support power of 2 extsize values. This
is not a hard design or implementation constraint, however.

.....

hmmmmm.

.....

In writing this I've had further thoughts on force-align and the
sub-alloc-unit unwritten extent issue we've been discussing here.
i.e. I've stopped and considered the existing design constraints
given what I wrote above and considered what is needed for
supporting large extsize for small atomic writes.

I think we need to support large extsize with small atomic write
size for two reasons:

1. extsize is still going to be needed for preventing excessive
fragmentation with atomic writes. It's the small DIO write workloads
that see lots of fragmentation, and applications using atomic writes
are essentially being forced down the path of being small DIO write
workloads.

2. we can allow force-align w/o atomic writes behaviour to match the
existing rtvol sb_rextsize > 1 fsb behaviour without impacting
atomic write behaviour. (i.e. less behavioural differences, more
common code, better performance, etc).

To do this (and I think we do want to do this), then we have to do
two things:

1. force-align needs to add a "unwritten align" inode parameter to
allow sub-extsize unwritten extent boundaries to exist in the BMBT.
(i.e.  similar to how rt files w/ sb_rextsize > 1 fsb currently
behave.)

This is purely an in-memory value - for pure "force-align" we can
set it 1 fsb and then the behaviour will match existing RT
behaviour.  We can abstract this behaviour by replacing the hard
coded 1 block alignment for unwritten conversion with an "unwritten
align" value which would initially be set to 1.

We can also abstract this code away from being "rt specific" and
make it entirely dependent on "alloc-unit" configuration. This means
rt, force-align and atomic write will all be running the same code,
which makes testing a lot easier..

2. inodes with atomic write enabled must set the unwritten align
value to the atomic write size exposed by the hardware, and the
extsize must be an exact integer multiple of the unwritten align
size.

The initial settings of unwritten align == extsize gives the current
behaviour of all allocation and extent conversion being aligned to
atomic write constraints.

The separation of unwritten conversion from the extsize then allows
allows the situation I described above with 8kB atomic writes
and 24kB extsize. Because unwritten conversion is aligned to atomic
wriet boundaries, we can use sub-alloc-unit unwritten extents
without violating atomic write boundaries.

This would allow us to use extsize for atomic writes in the same
manner we use it for now - enable large contiguous allocations to
prevent fragmentation when doing lots of concurrent small
"immediate write" operations across many files.

I think this can all be added on top of the existing patchset - it's
not really a fundamental change to any of it. It's a little bit more
abstraction and unification, but it enables a lot more flexibility
for optimising atomic write functionality in the future.

Thoughts?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

