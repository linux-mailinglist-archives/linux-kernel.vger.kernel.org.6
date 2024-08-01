Return-Path: <linux-kernel+bounces-271594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8678C945085
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C429928191D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3051B3F1E;
	Thu,  1 Aug 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1vbfaIC1"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D71B3F14
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529540; cv=none; b=FPyntThCGZlz7p/GJKNF5O5RsC+4TBfL6KgdQS+FrEjF/Yz0/H+pbvxyKspKhk9XyiXQ0xHTvQJ2Uu9k/DKSrLU0JgC0s47aAG23vD/4BgAnsqH4aOO1+TWjZaClFi4L0G+1vjQnfW9LJTbIeowOA+FJeqvhCqqjVKULE/Yt1Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529540; c=relaxed/simple;
	bh=F30C0Uw+/rZKDQD+xwC0S0Dhh1qkY+UTNmRcgBVa5G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLh0dLql2ZOIO7zStmBwTMtNuXfNTDRVYCdvhiBOstXBU6iMKNxO7n8jp1EkfmVGcVGZccSj8lWst5DKGEYsGXKZUF4yKH20FKOWkbZTAmRD72WzR6/Z1HW8SfGuTmlfG/OywvHaTMmR0RSAssq0E0UaxsdTUf3OdKVexdNtXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1vbfaIC1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc491f9b55so57994705ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722529539; x=1723134339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4c5Ol1nE1CTS39JB64ktQJWhAmOmGaN1S0j3xOuMYE=;
        b=1vbfaIC108LkTwsu7NwCfHaPx8asxLuIOhFkNT1HZRCnxWpn2BqfcHh2T6dpP79K97
         9YJW+oLfc/dz0dnGqVIpjCQCWn/o88LaFAamQwS7lqcFtrt3dM4tCuRu4DF41PSXVArb
         ryLu8HLOIDr1YnUg/Ou6FEszdaK3iPkMQEVI9x4geKzVpZAYAZ8GNKVwtYNn4oXy+wNp
         m1kBTJjgLvQ6yPTBIhNZ6RRTSTvbx+p/PPB3cClB7H6kERpUfcnWFWokFQA/YyQ4BFry
         UqNXDoawlhfTOyIhGxyhxMl69xa7XKBMOo35IjVhsNoI5JT5CNFw2UiIWhLgdsANdsxm
         lXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722529539; x=1723134339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4c5Ol1nE1CTS39JB64ktQJWhAmOmGaN1S0j3xOuMYE=;
        b=iiGKKTfGSaKnrjxJRgXKplNuP8IyKRnKOH1fszUe7+T52dX418+nGy/L08vmuGRTYH
         7Payy7syuqK5/BddZWrrzVWFV59iAKzBgUDaNM6SLmKdXqzYhC7vsCWjTSfzLQzFMSGf
         YkPBANqR9FOHIbKWiXVjoAvyFxazQAolBdFaLt1V0/NcQsHscs6jSMNDj5ca5NMpv2CU
         5pqTtg6bdRPEDfQOUpdn3JA5RNbcgbJy+Izv/yDxNhbEghotLvJIYs603iS694RhMXLy
         FHWWrZaHMKTXVtoIvlQsCtS9SRe9Cv+uVY+51m5IUr8SU9x3kmBgxYpGgqHSfcgVMpeR
         So1g==
X-Gm-Message-State: AOJu0YwKzIG7l9ATGOQi60VLGDgtWvSx/TWRhBGDKKqFTlFbgJH7P5Ao
	SMZbZsLMS4zst55S0XydKw/e/jT1KRqJqhyfgsynz/obOzJ8O5BrMYI2rF2Hlw==
X-Google-Smtp-Source: AGHT+IGNApLbGTUsDjNNtlX7dLxDoxzbc5tgy3WDGZeJBPd68Pn4ZuvUqLXwqVnsQv2cdqS0leR5bg==
X-Received: by 2002:a17:902:ea10:b0:1fb:1afb:b864 with SMTP id d9443c01a7336-1ff5722e77emr9166495ad.5.1722529538342;
        Thu, 01 Aug 2024 09:25:38 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29d7dsm684175ad.46.2024.08.01.09.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:25:36 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:25:32 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	"J. R. Okajima" <hooanon05g@gmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] lockdep: upper limit LOCKDEP_CHAINS_BITS
Message-ID: <Zqu2_OvnXIrCMMu8@google.com>
References: <11faf952-c0f8-6e1d-3560-12d77847a8ac@i-love.sakura.ne.jp>
 <20240723164018.2489615-1-cmllamas@google.com>
 <20240731164823.c8ac96ab0f8968ce8213c02d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731164823.c8ac96ab0f8968ce8213c02d@linux-foundation.org>

On Wed, Jul 31, 2024 at 04:48:23PM -0700, Andrew Morton wrote:
[...]
> so
> 
> 	BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
> 	ie, BUILD_BUG_ON((1UL << 24) <= 5 * (1UL << 21));
> 
> is OK, whereas
> 
> 	BUILD_BUG_ON((1UL << 24) <= 5 * (1UL << 22));
> 
> will bug out.  So LGTM, I'll add it to mm.git.
>

Right. I ran into the BUILD_BUG_ON() while trying to max out
LOCKDEP_CHAINS_BITS. I initially suspected the assert was incorrect as
the static array is being indexed as chain_hlocks[base + depth], which
according to the bitfileds in 'struct lock_chain' should likely be a 30
bit shift instead:

	unsigned int    irq_contex :  2,
			depth      :  6,
			base       : 24;

In practice though, using 1UL << 30 will blow up the bss section. This
is also true for the _any_ of the CONFIG_LOCKDEP_*_BITS. As they are all
shifts to determine the size of static arrays.

I simply dug up this patch from J.R. which avoids the BUILD_BUG_ON(),
but perhaps someone should limit the rest of the configs? In practice,
nobody should be using these 30 bit shifts.


> btw, the help text "Bitsize for MAX_LOCKDEP_CHAINS" is odd.  What's a
> bitsize?  Maybe "bit shift count for..." or such.

Indeed that is odd. I'm also not sure what to make of the "*5" magic
number. I suppose it could be the typical lock depth? I could try to
clarify these points, if no one with more insight wants to do it.

--
Carlos Llamas

