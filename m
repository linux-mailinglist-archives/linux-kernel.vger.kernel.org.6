Return-Path: <linux-kernel+bounces-188098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089518CDD45
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1321C22FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D11A1292C9;
	Thu, 23 May 2024 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ItsY1AO8"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01261126F27
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505948; cv=none; b=sjCszK44r3jfVZoCur9BagpNnSegM0iewbrbdZkv6JJ4yaiVOf1mYyEO5BzjL8IwIKR+osityoM14sRZEo1GcG76Yr23+QRgrH2Be6MRpVOfDjYP7aEH7xgCipMz0E9+XX2COYDhRjNflnPJL35ZNGC0Y+gZow3W2nLCJxQfMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505948; c=relaxed/simple;
	bh=Pr5fclf/NyQdxEw21anVvy8WtHKkbRAUyx9Gl02m/X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8G+QMtVd1SDXNX0hRGZfY0uoRtLWz/5t8PMHBoDAkK4amrFRDNAt4h7ZEIiF8zVCRJbPjkbcOgVs87Y6q9znhswvI3ZAY5kLwIjgEXIrW42uIbkisTNq/j6nQR/FBTowYtPtB/AGMZ4eESYpL6N1eyyxHFA5VS0mHPYeSxjtz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ItsY1AO8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f6a045d476so2708373b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716505946; x=1717110746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mMbC5KBXhHkDvBNusLgJck71yWRaMS5suGXHx+nBss=;
        b=ItsY1AO8e5s3tqCj4FAx7kY7vbd0B8OHNnQn2JiNWjhMliCkYCt488plqHZXasqnbO
         sQxddStA6+8XOggXVsmLs7iKeFAp15gRXDgicqUYf65gJgGyyObQR4jU3cd7SEoQm74o
         KCZwCcSe9j/7Bq0+RvXzFaIFyn65EqyQUO9JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716505946; x=1717110746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mMbC5KBXhHkDvBNusLgJck71yWRaMS5suGXHx+nBss=;
        b=qGtEPhOACpSwA3eh8Ykj4g0wD+L11aHd54zcpytHz87/bZ74XDVBrDCBZgCrzkumhT
         TO+a6zl8KnlON1eAGnc15hS9FVHa6ywvu+x6DnBNlpg/67Vic5kmyB7aXQWrydyDFZtt
         6LylAONYMJLCzvfAQcIko0+5Ie5PTj1gdr456LvhzgyKXIpJURnA1gJfZV1TSDydlXvr
         w93wXe8tM3vXZxmwyy2t65fe7IrOaKHUX/Wryt69gp0DL/8cfKAlb8aPKkFoKRDfF5l9
         NMpe1BF6lyG246qh515QbxX2dcnIg9WEzW+FFZZDnGYfO9nxK50YgILuX9iQHSBaJb8O
         HR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTpNESjQhg5ZO7HFQVa7RPSq5ZlQznVo2TulP/YNm/RiitPozN6Fv/IEBex64Ys/KG8TV9PDIUEQ9A5MK/jwPVuXjcKx4tiOY4fiQc
X-Gm-Message-State: AOJu0Yy3EliNWhF866ZY69B9vs0LcP5OhqfqXya5x8IDronwxEMxIO/2
	gORyQfrZ4mIgGvzGG/n4sF+RJr7K8jkIO95i93FVW9Npn5/RNbXsx0TDo2jD8A==
X-Google-Smtp-Source: AGHT+IFbXrTeUCq7J46GiJ/p3IWwvb8fOgFDb0trMNcBbD+UJjL4KOevqFmzptXng6JsupSTGMLaXg==
X-Received: by 2002:a17:903:1d0:b0:1eb:73c2:6b4a with SMTP id d9443c01a7336-1f4486e5e10mr8167325ad.8.1716505946250;
        Thu, 23 May 2024 16:12:26 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9b2e88sm1125295ad.253.2024.05.23.16.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:12:25 -0700 (PDT)
Date: Thu, 23 May 2024 16:12:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/boot: Address clang -Wimplicit-fallthrough in
 vsprintf()
Message-ID: <202405231603.2E810E3FC@keescook>
References: <20240516-x86-boot-fix-clang-implicit-fallthrough-v1-1-04dc320ca07c@kernel.org>
 <20240517095110.GAZkcojmJQoY_zU-OT@fat_crate.local>
 <20240517151833.GB3660288@thelio-3990X>
 <20240523115734.GAZk8vLgzOzD8Tv9pq@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523115734.GAZk8vLgzOzD8Tv9pq@fat_crate.local>

On Thu, May 23, 2024 at 01:57:34PM +0200, Borislav Petkov wrote:
> On Fri, May 17, 2024 at 08:18:33AM -0700, Nathan Chancellor wrote:
> > There was a patch to make Clang match GCC's behavior a few years ago but
> > I think Kees made a good argument that GCC's behavior leaves potential
> > bugs on the table, so that was not pursued further.
> > 
> > https://reviews.llvm.org/D91895#2417170
> 
> Really? Maybe I'm being dense but I don't see real bugs there... I see
> readability issues. :-)

There isn't a bug _here_, but this is about making the code unambiguous
everywhere in the kernel. We've already done the work to get rid of
all these warnings; this one is newly introduced, so let's get it fixed.

We don't want to have the same flow-control statement reachable from two
different "case"s where the resulting behaviors are different. Otherwise
we can't determine if a "fallthrough" is missing or intentional.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook

