Return-Path: <linux-kernel+bounces-192685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0EF8D20AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2601C234B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2013216D4E5;
	Tue, 28 May 2024 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIBPE85K"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6816F274
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911117; cv=none; b=G27HdKXnXpEPrm5lal7xmNVmM/Xm/R8THWcu9dhVNFW4pPKLrqeNAuYTFQCK2IjtiV2fuqP6fUdJqGGqcKEodKRl2JPmXs16McxAzDWIpzLqNdvn85CIUCgfhs1c0yIXau5P9cjNFCnE70mTyp0ns4O3UWfDhJThzm2NDwgR7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911117; c=relaxed/simple;
	bh=BAqdiD54TVKMF2ArvdIVU/2qSdxUZTE4NpBmi7flC5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMx92CyBuk5mUmZMgBHIqYeW6qjTNNOmfgMa784WyWUbSEjTRtcicBbhLxBj2jC+yacwB7SKGbH+PwK8i+V5kMIFuVxpnh3ZH2/1RQ1diSeT1dkvWwGYikMDYcIiQvVNOYxMVdw3TRdTuScIFa2qE58qX46oJkgjVcVZHYVjmt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIBPE85K; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6269885572so730008866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716911114; x=1717515914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BAqdiD54TVKMF2ArvdIVU/2qSdxUZTE4NpBmi7flC5k=;
        b=fIBPE85Kt0gTproB3Uc/n714X4xBQKzVCYlMa8vvt6+igkkmPm7bAlYXXFv3aMPgdP
         th2UBj+CPhy8+bLSm56SsUiK7GbYDaNMqoFurauvoPqr8abPm0LCnTK45MMOOobT6noR
         s6Cg5fbkyN/wwRX0zl7uePdEDZDKUqRBR984lOCPAo3KfYyTvBZubGzzxcUHBv751DFg
         z65mX54FjGFG3VLMGN5UPDKJk8h1/mEj/oKZ+UpW7+vPXFApZ/YYqpUlKgs4mWtvEVXP
         flZNgvevI9HFvpbMZAL3yBSjF4tdpKd5htuorXA6c4KuGePf19GeqtVaNTTCMeow6P5g
         uQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716911114; x=1717515914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAqdiD54TVKMF2ArvdIVU/2qSdxUZTE4NpBmi7flC5k=;
        b=dknZJD5As24QcejMEF0u0F0iamgtloZL4u5L7rNGtE6IoZwSEvdF3xQ8mHkSbqGvcp
         RDG0pT+75yN7XOemYlRB5GtVh60+QCci4Y9r8C54GFCTDnGTIQqHyoaMyNkqqtH4oA/a
         lLR5VYz2ZpxCr3DGA5kcxzuMwwU3ZcLW2w1RXrzPWTxCFf0PXJozASJAD72S2LsFUskM
         yCQfKtUr0QFl2aarlaBT/GCaktt4x0r1BBzGchcdnIFXcuqqGzPd6347Pyu01Za4E0sX
         i2Kr+ZejlLN7JeubXDjZCsX+x+GuUqgtE8DlpR6fZhzua1wN9WpAxYPfDXuUTVKOm+zd
         ktIA==
X-Forwarded-Encrypted: i=1; AJvYcCU99aNPnZuFBFwiytKSCfvB46XzYfMGwNYkn/0zEFW1Bndo+jptYCzKjF9JzXMPyik0K3UvguBGpanc3pgNoQu53SJHGB+yvVHxRy2t
X-Gm-Message-State: AOJu0Yz6+3U3tHrxzAkQhtnBrSabK8L46rWZWfmmlb/1KZIgp10KABAh
	GWFy55GLq4WC7sTcetQaODzy/PeJYfY3WryW/boD5zlf+NrcO+bV
X-Google-Smtp-Source: AGHT+IHFtIWeGvLGBGVKlslaG9Rhaz44EvKtwsAVVm17A/hYopaxtFMbiLY0nCtAu/PznGi1PKkMeg==
X-Received: by 2002:a17:906:b20a:b0:a59:c9f3:837d with SMTP id a640c23a62f3a-a623e9d5525mr1194850066b.30.1716911114010;
        Tue, 28 May 2024 08:45:14 -0700 (PDT)
Received: from rex (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e585sm621718666b.184.2024.05.28.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:45:13 -0700 (PDT)
Date: Tue, 28 May 2024 17:45:12 +0200
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmsan: introduce test_unpoison_memory()
Message-ID: <ZlX8CLwwtv5ry7FZ@rex>
References: <20240524232804.1984355-1-bjohannesmeyer@gmail.com>
 <CAG_fn=U2U5j8VxrkKGHEOdbpheVXM08ExFwkqNhz4qv2EtTjWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=U2U5j8VxrkKGHEOdbpheVXM08ExFwkqNhz4qv2EtTjWg@mail.gmail.com>

On Tue, May 28, 2024 at 12:20:15PM +0200, Alexander Potapenko wrote:
> You are right with your analysis.
> KMSAN stores a single origin for every aligned four-byte granule of
> memory, so we lose some information when more than one uninitialized
> value is combined in that granule.
> When writing an uninitialized value to memory, a viable strategy is to
> always update the origin. But if we partially initialize the granule
> with a store, it is better to preserve that granule's origin to
> prevent false negatives, so we need to check the resulting shadow slot
> before updating the origin.
> This is what the compiler instrumentation does, so
> kmsan_internal_set_shadow_origin() should behave in the same way.
> I found a similar bug in kmsan_internal_memmove_metadata() last year,
> but missed this one.

I appreciate the explanation. Makes sense.

> I am going to send a patch fixing this along with your test (with an
> updated description), if you don't object.

Yes, that's fine. Thank you.

-Brian

