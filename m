Return-Path: <linux-kernel+bounces-244858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5B492AA6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD691C212BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B714737703;
	Mon,  8 Jul 2024 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnkhiXon"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD95023775
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469593; cv=none; b=jfHOq/uoOXgrQTcWMmNuHbn+UvrH8P5I3GHw/zltgY6LbIBLVRcPOzDh0AMO7aobSLP02JB+qFn8aKFODF4Zd/4IlJ4hAj59kYSiJa/P13nCRS3HSsdlIx6FTxb0EzsoIok+PUsrckzm92v9IWQO2PPdTSqv10QLsBbNG98SNio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469593; c=relaxed/simple;
	bh=/pHf0i0gH6zlSegAbbPZ0NUnVgOHYFQzHH8aB/cHLRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hR25unbVEhs7KCE9mgmBlnA9FuqNZv7BRl3poYzsbspaNMEtI6hD1gv3BvttilwOrGky30Im5JykzUUVKpZDtM7FoKvFeQ9avA4Yyc2VKWOF+aklvrcNCxzwuVw3f+AQWTJsUOKl3Hs/OkMMqZxpzO4Lw7Qff4B9Hs4H/P/6qAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnkhiXon; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af48692bcso2674702b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 13:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720469591; x=1721074391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6G9Xf95AcgLfhqZrHsPzkb+DNyt19kkhpH3o27qWc+s=;
        b=gnkhiXonTDmCDenCs4LQqdQsDg5V5cGHpBfsQrd7y+L1zGG4h64ggaQVQanazQFm3O
         W40BCriK1MB35vGD1YowprXaJG274Wl/JYaZKRCksNYwPFzl6EYGPnPLoNMrXz14aVbU
         8xEdYEYYd4HEGnIxMfIjSUoM8wXXCIVSeYC+RsTW+VvEHonpJpOJkb4P7ele+qpvM558
         MrkfyWsPl0zuuVDPMKBdQfHlTSXmgroQKvy80OVHwXU6bUlj8WRWzvORfB4+p2swmjBo
         5scDyALKMk/gEL943HuinX/IO1OO2ni9KCd+vuHudigW3z4dDyDtXGIpU0hdcfs6PK6x
         2PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720469591; x=1721074391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G9Xf95AcgLfhqZrHsPzkb+DNyt19kkhpH3o27qWc+s=;
        b=aBSCMkuwiUCvFb+xsmiDpPa4HNGX7VJv0f5JWvOW4xKpvNUwjU95MBQVb5cHOBBJyn
         WpKLIhncTMeztyTlUrXiheE3xY+AleGqCtUytqP6rc2W32v2RTZdufLpV93rftZbqCwy
         2LPFFQTCC6/jsprHAuaPmMx3CNkJFU17Ze7Tok2IyMXp+3QBvbEwwuvwQ84spMzmqs7S
         T7t9EC0bHPQQOo0r6qsxAxf0qUP7YFZrc3JmyBXbC19yuzrUQQzBpIPFq49rZ5N1QzQn
         WFH8YcepDor+T+rR3RjKvknBntfetsAuAD2RFkMGDt5JDCj6wZMJYS89GTK+pk9u+yap
         DLTg==
X-Forwarded-Encrypted: i=1; AJvYcCU3xkjtHKgk5gdbcmTLLpX8arzV6tm+M4nyllkr4wX+ZoG9fYY4dHONpE/Zi0vmv9oepzwRg47FBsqtTTGCRojXS/K3/M1WiBjW6AZW
X-Gm-Message-State: AOJu0YzGGQphZHl5gdhd4P3xgbQH9rYDv6tpyKdup80676sCR2MZrLEC
	M4DVQRlGx8GA9Qu3Eczx9WF4a77sRsmbEfyJIfmIJioVil9CcPL0
X-Google-Smtp-Source: AGHT+IGTRZ02xxBe64hPaomw/uSnXCNlhAjac6TxyA7yIzqRIq7Qh1fPwGJWHFSPGUTFtdkqRO9EnQ==
X-Received: by 2002:a05:6a00:2e87:b0:706:747c:76ba with SMTP id d2e1a72fcca58-70b434f6409mr799246b3a.2.1720469590723;
        Mon, 08 Jul 2024 13:13:10 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43968688sm272768b3a.114.2024.07.08.13.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 13:13:10 -0700 (PDT)
Date: Mon, 8 Jul 2024 13:13:07 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] cpumask: Switch from inline to __always_inline
Message-ID: <ZoxIUz_-DRigH0Rg@yury-ThinkPad>
References: <20240514204910.1383909-1-briannorris@chromium.org>
 <ZnsML1RYMmEhhdPP@google.com>
 <ZoWhPFJIvGpMGKm4@yury-ThinkPad>
 <20240703195724.GA292031@thelio-3990X>
 <ZoxA5cPpfcpKkzSM@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoxA5cPpfcpKkzSM@google.com>

On Mon, Jul 08, 2024 at 12:41:25PM -0700, Brian Norris wrote:
> Hi Yury, Nathan,
> 
> On Wed, Jul 03, 2024 at 12:57:24PM -0700, Nathan Chancellor wrote:
> > On Wed, Jul 03, 2024 at 12:06:36PM -0700, Yury Norov wrote:
> > > On Tue, Jun 25, 2024 at 11:27:59AM -0700, Brian Norris wrote:
> > > > On Tue, May 14, 2024 at 01:49:01PM -0700, Brian Norris wrote:
> > > > > This change (plus more) has been previously proposed for other reasons
> > > > > -- that some of the bitmask 'const' machinery doesn't work without
> > > > > inlining -- in the past as:
> > > > > 
> > > > >   Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
> > > > >   https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/
> > > > > 
> > > > > It seems like a good idea to at least make all cpumask functions use
> > > > > __always_inline; several already do.
> > 
> > > I feel that if we decide making cpumask an __always_inline is the
> > > right way, we also should make underlying bitmap API __always_inline
> > > just as well. Otherwise, there will be a chance of having outlined
> > > bitmap helpers, which may confuse clang again.
> > 
> > If this does not result in noticeable bloat, this may not be a bad
> > idea. I seem to recall this being an issue in the past for us but I
> > cannot seem to find the issue at this point. Commit 1dc01abad654
> > ("cpumask: Always inline helpers which use bit manipulation functions")
> > comes to mind.
> 
> In the above quote, I already referenced Yury's previous post to do just
> that (__always_inline for all of bitmask and cpumask). I don't know why
> that wasn't ever merged, so I instead chose a smaller set that resolved
> my current problems.

Hi Brian,

I felt like your observed growth of the .text is caused by inlining
only part of bitmap-related functions, and if we do inline all of
them that might help.

I ran my own builds against this __always_inline thing for all bitmap
functions and their wrappers, namely those located in:
 - bitmap.h
 - cpumask.h
 - find.h
 - nodemask.h

When all 'inline's are replaced with '__always_inline', I found that
defconfig build saves ~1800 bytes with GCC9, and 100 bytes with
clang 18:
        add/remove: 0/8 grow/shrink: 18/6 up/down: 253/-353 (-100)

(I didn't test the build against a fresher GCC and older clang, and
likely will not do that till the next weekend.)

From my past experience, newer versions of compilers tend to inline
more aggressively, and thus generate bigger binaries. In case of
bitmaps and friends, however, we should always inline because this
inline 'small_const_nbits()' part is always resolved at compile time.
Thus, aggressive inlining is always a win.

> I can dust that off, rebase it, and give it a bloat check if that's
> preferable though.

If you want to take over this work - please go ahead. To make it
complete, we basically need to make sure that all bitmap APIs are
inlined, and check that the build doesn't grow for fresh and older
compilers - both clang and gcc.

Thanks,
Yury

