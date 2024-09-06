Return-Path: <linux-kernel+bounces-319353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA3896FB83
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F101F282EB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB9E82499;
	Fri,  6 Sep 2024 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="efgMiD7z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2416B1B85C8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648895; cv=none; b=nMNO8X9veSVQadiHuGGq/rVjj5wCpk/gn02qIalg4aiQvaR7+fMQGDtw4VbrW3F+BYRkOttPpLZkL8zPSgfxyBfGyPYekTNJOvyp4VfaD6Sy+dzi0rW3HRKl8eWA2cczvdQn6KWWNxUmIgHg2lS+1E3XKa7dmMkghbwvywXszGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648895; c=relaxed/simple;
	bh=AAu/5hFFlWoGudbNftPQ2v+OCU5T4oYxziLv9W4hXfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=car+k6mXfNT3/uZ5JFunHWuY/K+pUKCXZlt+N6AdCYd8g7qK8kMx7jPB0xz0/dctHuTdEj9B5o557Yk7yeC3IY3verVZoG+Fr2/Trk7fGakWhYqgjWIsb3x78x264mFZnPgD9Rf/H4kY7QlHElTsfrh7iNxSWmXq6jb7tTEkeys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=efgMiD7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821CBC4CEC4;
	Fri,  6 Sep 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="efgMiD7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725648891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4fO2uD55CapDb7E2rYz7b7g+1GsC4SXbsHVZgINqmk=;
	b=efgMiD7z3gM+I+ScpKY5zOxbUYBqiKjOMk4A9og1wreeDYjHRj6B0THIElQoI+3Jmd58aG
	jbN8OZ+EGjfjZetq0p8s14rZHXsvZmJgF44HLBxsValYTFEqBGWtBGmZ4uFQFdcV3T2XXP
	ob6Ca27ME5rPao2YSrgvcj/qtr5Yf88=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6a974a26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 18:54:51 +0000 (UTC)
Date: Fri, 6 Sep 2024 20:54:49 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 2/2] Fixup for 3279be36b671 ("powerpc/vdso: Wire up
 getrandom() vDSO implementation on VDSO32")
Message-ID: <ZttP-SU9i6iOyfnG@zx2c4.com>
References: <700dbf296d02e32376329774be35cfbead08041d.1725611321.git.christophe.leroy@csgroup.eu>
 <ffd7fc255e194d1e2b0aa3d9d129e826c53219d4.1725611321.git.christophe.leroy@csgroup.eu>
 <ZtsMpcV7iLYoytdJ@zx2c4.com>
 <795db5f1-c266-4fb3-a51b-c2b3745d334b@csgroup.eu>
 <ZtsVry_LL2jjeLJ3@zx2c4.com>
 <8d0a8d03-95b3-40a8-85cd-5c2e6f92eb6b@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d0a8d03-95b3-40a8-85cd-5c2e6f92eb6b@csgroup.eu>

On Fri, Sep 06, 2024 at 05:14:43PM +0200, Christophe Leroy wrote:
> 
> 
> Le 06/09/2024 à 16:46, Jason A. Donenfeld a écrit :
> > On Fri, Sep 06, 2024 at 04:26:32PM +0200, Christophe Leroy wrote:
> > 
> >> On the long run I wonder if we should try to find a more generic
> >> solution for getrandom instead of requiring each architecture to handle
> >> it. On gettimeofday the selection of the right page is embeded in the
> >> generic part, see for instance :
> >>
> >> static __maybe_unused __kernel_old_time_t
> >> __cvdso_time_data(const struct vdso_data *vd, __kernel_old_time_t *time)
> >> {
> >> 	__kernel_old_time_t t;
> >>
> >> 	if (IS_ENABLED(CONFIG_TIME_NS) &&
> >> 	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
> >> 		vd = __arch_get_timens_vdso_data(vd);
> >>
> >> 	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
> >>
> >> 	if (time)
> >> 		*time = t;
> >>
> >> 	return t;
> >> }
> >>
> >> and powerpc just provides:
> >>
> >> static __always_inline
> >> const struct vdso_data *__arch_get_timens_vdso_data(const struct
> >> vdso_data *vd)
> >> {
> >> 	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
> >> }
> > 
> > It's tempting, but maybe a bit tricky. LoongArch, for example, doesn't
> > have this problem at all, because the layout of their vvars doesn't
> > require it. So the vd->clock_mode access is unnecessary.
> > 
> >> Or another solution could be to put random data in a third page that is
> >> always at the same place regardless of timens ?
> > 
> > Maybe that's the easier way, yea. Potentially wasteful, though.
> > 
> 
> Indeed I just looked at Loongarch and that's exactly what they do: they 
> have a third page after the two pages dedicated to TIME for arch 
> specific data, and they have added getrandom data there.
> 
> The third page is common to every process so it won't waste more than a 
> few bytes. It doesn't worry me even on the older boards that only have 
> 32 Mbytes of RAM.
> 
> So yes, I may have a look at that in the future, what we have at the 
> moment is good enough to move forward.

My x86 code is kind of icky for this:

static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
{
        if (IS_ENABLED(CONFIG_TIME_NS) && __vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
                return (void *)&__vdso_rng_data + ((void *)&__timens_vdso_data - (void *)&__vdso_data);
        return &__vdso_rng_data;
}

Doing the subtraction like that means that this is more clearly correct.
But it also makes the compiler insert two jumps for the branch, and then
reads the addresses of those variables and such.

If I change it to:

static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
{
        if (IS_ENABLED(CONFIG_TIME_NS) && __vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
                return (void *)&__vdso_rng_data + (3UL << CONFIG_PAGE_SHIFT);
        return &__vdso_rng_data;
}

Then there's a much nicer single `cmov` with no branching.

But if I want to do that for real, I'll have to figure out what set of
nice compile-time constants I can use. I haven't looked into this yet.

Jason

