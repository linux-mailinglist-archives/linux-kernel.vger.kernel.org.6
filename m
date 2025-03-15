Return-Path: <linux-kernel+bounces-562762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50E9A63287
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 21:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28580171A32
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 20:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E98E1A238E;
	Sat, 15 Mar 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVMiaIkz"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C1B197A8E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742072139; cv=none; b=L304szg9jZ6m9zWQrfgcfxoO/wRKOqT9hDz9ng24bhNb5lERsHmViLFV6Owomp18GSVI10XsJj5CQIOGld72lwl/Uvs65VObUCdFlMPd1z36lg4NPXzUQdUzg40y4jDLbfjSA7wJMrM9qXy1N18jiQJ8VFLFmEE/pTt4PxmTI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742072139; c=relaxed/simple;
	bh=1je2FBjF/asEmhxo2QnTVB/uFmiiaHxRI5F5Myc8irg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpxweUQILB2bjcEPXhRLmjaEd69P+2AhQaV0xEjHufoWt1UWqrx/1IWIal3nbs9E6GQg+H0QY22U6dOxwdNhmSfO2GPr9hfrjjzm6X2IJyWVZnJ0BuqftNNDiqJvH6pcRqSFNDy+vqOH7hheBf98/v1H+93+RTv+4jqKHM1sDvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVMiaIkz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39143200ddaso2009271f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742072136; x=1742676936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPoMtcr7suWf9yDiNFk/E9G6CwRnHAO9gby8ImRtosI=;
        b=MVMiaIkzdr5YPQNxCFdUjqJ9wDe1tGZQFLZ9bMbqoySXrdnioYn7fdr9XO0pKkpWXn
         Q0j9Xie0EVtkehbVtXwBRo1rjic9QjnHmM/twW0+c1Sz/pjAU+RVP4XLi0D9TJDpe2uT
         VjNWGo7tC7unk6pomt80mUobOz3/itu5rzVEIC94gSM3/gC64PBxGRaZ0ALG9zbConPC
         xeT5VycnUNtOHJvc4jCb/zv20DR243V8JFvYjn+uhL1SE60Q0NTaHb+VPTgJ/s1oilwz
         WU2NVH4kMnXZ+CLKTOwFAiPvNhN7VYHTe+eXJubYdyBXyWWs9WlAqjHKDv9h4uYNI9aM
         VshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742072136; x=1742676936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPoMtcr7suWf9yDiNFk/E9G6CwRnHAO9gby8ImRtosI=;
        b=d8TI67O+3k5O115pizEr8jLq4kSTFYLhl4yE4fT+3n2apDcFT9qmHXJIvBvmk1x5O1
         LXdmhX5F9Ja76C1Muc4pvgxdhBnQYTUPrVCbUUF7ncFxmhslESYGpFKzTJHwJuUlNQxS
         oFNGrb6ef42lY59rYx2XlFUtnnYfKlGOuZaO8F0qVaTeqNni0M4yEbY8NP8fDTXYZ4me
         O6KkcDKcKqAXhvH43lVHfZbvEQCw/Y1Bvt1x4SR4ehnGm+JX30VGFKe41svg2DsAApH0
         tjsl3GUK5Q2OBFYgvPl+G5k7j/r7RYQkgDFFalZZ4aIKeJ4zoukqJM8x9DuQxBmZY6d8
         FleA==
X-Gm-Message-State: AOJu0YznfuWCFGHyw5LD25ZWpg0886v5TZCDrf3t8Ih/3hOIbd1l12tj
	dydifS+Pi5BQjiH7gtAhCzhPsXv7x2DsSZ6vpni+tL8VJimXw1wK
X-Gm-Gg: ASbGncv52kIxRbsD3h1WM0863XClHPiIBJo1nCJjRgyw4OK+NW8CcCcY2orcBvqGzN7
	gGokoR8ZuSqBaUndkVSpfNns3aAv8I9KtV1hMUe/4bN7O/QZ4R5RJHarTTrZLORB8vfjJ7bINJv
	bHOu12eXa55h/jSarbXa5nviozzmyzDURWGr6cDdrIdIVOtanv85oL6YNfxsKMz0Wd0LAzUCF1s
	tPW4lzkek1Wopjd63lxyvAVA5Q+9alcawUpzMxELRtKycwO8+aXpulDy8V6mvd5C+nR5XkTgj6A
	WUg1iLS5kd0mZn2M2zNQ/FEKtvdSTSMKCxgb4YGEzfCXWjmizxASREt0aEqq5abeTGvaDvn8qvv
	l5DpwbPY=
X-Google-Smtp-Source: AGHT+IHLitts84GXrpBOrimoLhSwcYo4lk0TIuHXdQM8I2ytemVehLMaRYmc62FtgbAf+0stZDMXCw==
X-Received: by 2002:a5d:584a:0:b0:391:2192:ccd6 with SMTP id ffacd0b85a97d-3971ee44b62mr10420164f8f.39.1742072136378;
        Sat, 15 Mar 2025 13:55:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ec14bsm10023049f8f.100.2025.03.15.13.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:55:35 -0700 (PDT)
Date: Sat, 15 Mar 2025 20:55:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] random: get_random_u64_below()
Message-ID: <20250315205532.6815f2c5@pumpkin>
In-Reply-To: <olt5s7scbosagj4fpq25xun4kdvi6puwqdocgsvhpzguvpt7jt@dyy37p4uturh>
References: <20250313163810.60564-1-kent.overstreet@linux.dev>
	<20250315135234.65423e07@pumpkin>
	<olt5s7scbosagj4fpq25xun4kdvi6puwqdocgsvhpzguvpt7jt@dyy37p4uturh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Mar 2025 14:20:46 -0400
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Sat, Mar 15, 2025 at 01:52:34PM +0000, David Laight wrote:
> > On Thu, 13 Mar 2025 12:38:10 -0400
> > Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >   
> > > bcachefs needs this, for sampling devices to read from based on squared
> > > device latencies.
> > > 
> > > this uses the same algorithm as get_random_u32_below: since the multiply
> > > uses the top and bottom halves separately, it works out fairly well.  
> > 
> > Adding two separate copies of much the same code is silly.
> > Given what the code is doing, does it ever make any sense to inline it.
> > 
> > Inlining the original get_random_u32_below(ceil) that did
> > 	(random_u32() * ((1ull << 32) / ceil) >> 32
> > (for constant ceil) made sense.
> > While good enough for most purposes it was replaced by the much more
> > expensive function that guarantees that all the output values are
> > equally likely - rather than just evenly distributed.  
> 
> Expensive!? It adds a multiply.

I make it two multiplies and a loop.
Have you looked at what happens on 32bit systems?

> 
> That % gets constant folded, in the inlined case, and in the non-inline
> case it's hit only a small fraction of the, time, for typical ceil.

If the % is only a small fraction on the cost for the non-inline case
(and it is over 100 clocks on many cpu that people still use) then
why inline anything?
A quick look shows divide being 'only moderately slow' on zen3 and coffee lake.

What you might want to do is pass -ceil % ceil through to a real function
(especially if constant).

Oh I guess you haven't actually tested the version you submitted.
Time to play 'spot the silly error'.

	David
 


