Return-Path: <linux-kernel+bounces-240072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190469268D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B4E1C22BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555BD188CD3;
	Wed,  3 Jul 2024 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD1xybn4"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F9178367
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033601; cv=none; b=IVD+/dX3T6bNpRBFqfumK4/wOCiLln0o8IzxoXQXLIlM+fuldHAOSoMj9/gOSsZnhbWGbUt6uoZng1I6QTt/I/P1ejz6b8RYOGCoaO7EWtNTXMFKpwj76JLOpJZ5WOjIk1YeqWr7z2gBi3cHRSOxJAIE1VHCiLHDyBJLPCeF5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033601; c=relaxed/simple;
	bh=6P39zQQm1mhPiYLUc+P8uMCtysrA52dIYROykZYNsPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIdqP472DvmMbh24e+QKZQWAzedXZaAlFGA19AlkRJDdSG7uE3aTFEzkB+b8n2lOBplHYkEENvdxqeBUol5BCwcYKRcnGfb3F8cQqmNYnInyc62LJ5in3d8r6059mXFz9ILQxZvqzKvP8WCC6eb57mfWWHaSxNe4XaHHF81WwZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD1xybn4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f9fb3ca81bso34069735ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 12:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720033599; x=1720638399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=79l7g6TVpjXZUxamTY9AWClCT8i64EIEzq8NMS8zS+o=;
        b=VD1xybn4Dc0A7cNnOObg9Qnd/b4wFJwntujsCTBxSJv4biwYybjRIWXgoLmtCEyf2D
         0ix01IOMEHhVl+FH8V+cvBNLtXcgcBU41+Wsa/xZhhqX6LVnlXrsjYhSL5qgLg68mjhz
         K7WRkLwN8fofLQZq+cnxxmIvawZLvTBX6Qf/YxZfK/2/O9RFA3Ep28khXvICwJxJv2Vv
         OHnfQipUNmJopPpy9KlouLQ2KlGVYOqbzy2crUX4B/VsrOTq0Kp8juuZmiD5S9Hjzgm4
         erVA271CIK1WH3rXEDMnNs6hFSSqayr+TYLklpKQtyjwbkPDPJpsOHiaKhCU09wTkFm2
         7XtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720033599; x=1720638399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79l7g6TVpjXZUxamTY9AWClCT8i64EIEzq8NMS8zS+o=;
        b=ZOATsOTI2oZQQ0YzU6TG/JcKAg/TcNvs4fXV1NLhutLAcCgrXYSGfwQfXZQwQ1Ycvw
         M0dv3TCRs7FgtnMJQ7gNT3g3PlCPA65VY9uaxIMD4Rl0EkzdRSWBrVx/lpC6rEwvEH6m
         /H4FNb2jksUoJLrjRCiXS+cckVTFX9JL2J69q6rihqcNm5CFIvnKfAQxYjrluXKh64+t
         yzsFiXcZYrXpbrusX/LPR2qibaPej1sEwOhj2oiBuvTqMtLrQJd41hMddEj3XOtduUcN
         9BRRVasa0stRf1WMrdFPOxsRq/qR9DFUpKWVzE8P5HnaA1YuOIyvBPpxLTZXa3d/YNOg
         A3Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVvWxYa1WovJ4rRimMvdbNiSgFcib2DHGqMXWqPYR8HNNZ6jtrnX752uIgSuA1BB3crsWrkb6pqTiKixNYM9qDQZneVekLCqETm8chk
X-Gm-Message-State: AOJu0YzoquqDaXetB3tkLmxIWrkTGbbdHjKw1tBjTfGL73zsHUGKElfw
	lw/wjLX7rOe1TE5Jd2EAvp31u1uvHal/8XZ21597JpSfPLa+uDRu
X-Google-Smtp-Source: AGHT+IEorQWGFhcttYBEcQwHE5TgZ3phs6TgzO9ZovYMeHWQpzUOCSpwI1pOvZJCqV1bUJkDeX0dvQ==
X-Received: by 2002:a17:902:d48a:b0:1fb:30db:be0 with SMTP id d9443c01a7336-1fb30db0ef2mr2177525ad.51.1720033599369;
        Wed, 03 Jul 2024 12:06:39 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596818sm106575455ad.270.2024.07.03.12.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 12:06:38 -0700 (PDT)
Date: Wed, 3 Jul 2024 12:06:36 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] cpumask: Switch from inline to __always_inline
Message-ID: <ZoWhPFJIvGpMGKm4@yury-ThinkPad>
References: <20240514204910.1383909-1-briannorris@chromium.org>
 <ZnsML1RYMmEhhdPP@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnsML1RYMmEhhdPP@google.com>

On Tue, Jun 25, 2024 at 11:27:59AM -0700, Brian Norris wrote:
> Hi Yuri, Rasmus,
> 
> On Tue, May 14, 2024 at 01:49:01PM -0700, Brian Norris wrote:
> > On recent (v6.6+) builds with Clang (based on Clang 18.0.0) and certain
> > configurations [0], I'm finding that (lack of) inlining decisions may
> > lead to section mismatch warnings like the following:
> > 
> >   WARNING: modpost: vmlinux.o: section mismatch in reference:
> >   cpumask_andnot (section: .text) ->
> >   cpuhp_bringup_cpus_parallel.tmp_mask (section: .init.data) ERROR:
> >   modpost: Section mismatches detected.
> > 
> > or more confusingly:
> > 
> >   WARNING: modpost: vmlinux: section mismatch in reference:
> >   cpumask_andnot+0x5f (section: .text) -> efi_systab_phys (section:
> >   .init.data)
> > 
> > The first warning makes a little sense, because
> > cpuhp_bringup_cpus_parallel() (an __init function) calls
> > cpumask_andnot() on tmp_mask (an __initdata symbol). If the compiler
> > doesn't inline cpumask_andnot(), this may appear like a mismatch.
> > 
> > The second warning makes less sense, but might be because efi_systab_phys
> > and cpuhp_bringup_cpus_parallel.tmp_mask are laid out near each other,
> > and the latter isn't a proper C symbol definition.
> > 
> > In any case, it seems a reasonable solution to suggest more strongly to
> > the compiler that these cpumask macros *must* be inlined, as 'inline' is
> > just a recommendation.
> > 
> > This change (plus more) has been previously proposed for other reasons
> > -- that some of the bitmask 'const' machinery doesn't work without
> > inlining -- in the past as:
> > 
> >   Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
> >   https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/
> > 
> > It seems like a good idea to at least make all cpumask functions use
> > __always_inline; several already do.
> > 
> > According to bloat-o-meter, my ~29MB vmlinux increases by a total of 61
> > bytes (0.00%) with this change.
> > 
> > [0] CONFIG_HOTPLUG_PARALLEL=y ('select'ed for x86 as of [1]) and
> >     CONFIG_GCOV_PROFILE_ALL.
> > 
> > [1] commit 0c7ffa32dbd6 ("x86/smpboot/64: Implement
> >     arch_cpuhp_init_parallel_bringup() and enable it")
> > 
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > 
> >  include/linux/cpumask.h | 214 +++++++++++++++++++++-------------------
> >  1 file changed, 113 insertions(+), 101 deletions(-)
> 
> Any thoughts here? scripts/get_maintainer.pl suggests you are
> maintainer/reviewer here.

Hi Brian,

I never received the original email, only this reply, and can't recover
any context.

cpumask_andnot() is a pure wrapper around bitmap_andnot(), and it's
really surprising that clang decided to make it an outline function.
Maybe the bitmap_andnot() is one that outlined? Did you apply only
this patch, or my patch for bitmaps too to fix the warning?

Clang people are already in CC. Guys, can you please comment if making
cpumask API __always_inline is OK for you? Why Clang decides to make a
pure wrapper outlined?

I feel that if we decide making cpumask an __always_inline is the
right way, we also should make underlying bitmap API __always_inline
just as well. Otherwise, there will be a chance of having outlined
bitmap helpers, which may confuse clang again.

Thanks,
Yury

