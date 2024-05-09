Return-Path: <linux-kernel+bounces-173955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71BF8C0836
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A810282E40
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC531373;
	Thu,  9 May 2024 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BpolYLB2"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9736C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715213188; cv=none; b=L4ctXBZ+PuJrMA8JX2KVmdPjWnB5dBMypKrEh4chloGIer5On9QUFCOhfr5cL4SMqkrJH4OrDoPuPFJRqtmINFB/Ub9wGjajpO2W63O0v4omU9O6rFuyMFU8Bq804saOB0M8NbPBd9uCqxxPSS0zGFKwXt0abbbToIsmdDEjddE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715213188; c=relaxed/simple;
	bh=IDtem1V12nNx0FHh41q9CjFqh2Oa/zkNU2jMr995274=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIH/2XHPiuzlXXGe4YxevQ9tTj7mU5M28ykYx3Vwjg/ITyfaLfpnm2u8o/opwXAH8Kmi9YelRS6SKR8oL6nI/Pud4JGl6s4VodrSwLC1uLjYe+N5IIE2CdbtPhtQdPPFzJhIQzaNqkM7Qw2H1VaRPf4s1q91Vy8Xtdi2jDp6nrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BpolYLB2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5a1054cf61so66848566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 17:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715213185; x=1715817985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EqMDZ7IrqUxdNK1BGX9Bv8+FLqyvy2F/S5DRaEwsjkM=;
        b=BpolYLB2TQMuWl5ZJQvBBF6vUbd/E/WhtGCFYRz80rqWDLw8OH3g49shyQkXdxfKc9
         2wWpsN+JsR+8YQ9G/qbHpkPfEEiav7c78JHDhHXn6dtMP+YWvcy283aPl+HheT0+4K54
         riQ8bC7TUrcFmW7uzspGJaqc41IfqeGsGjN5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715213185; x=1715817985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqMDZ7IrqUxdNK1BGX9Bv8+FLqyvy2F/S5DRaEwsjkM=;
        b=bYbiJVUJOS74mlvPd+iKtO0kVn2HG0PVF5ElAQPbgWvRADMFVFrbtBtjSyT49gggjT
         iHPYrEqRwiuw7pa1vKEjf7BNAbMaTIG/WQ8aCbCo3kiHSl03I5KStYjHo4/FN2ZZaKib
         5i5H8PVN3z0Zc0PfRPXC/YwV42s5zklltUj0IccnVkETfW8NmTB4SW4as1MetKSYxDS/
         uQ72aZmmuMiLFq+4CXmvcmrjOfYFosbwe/cvoeKvzXF4EXOP827qJ04vk6e7NTW3IvrO
         YNWNgzmgVsK6GF9cFrVf7a2eF3S6fBvBzhgUhokS5tlutBNGYg/KGXs5VChxgI0qtS12
         sTIg==
X-Forwarded-Encrypted: i=1; AJvYcCUbFTpG0OLG7/t2rmaFYs0V/UNXGyZ9sdoglFlBzbmCDWX4Yw6g1pqHRsvXPfYxBPqVoEV1CwUfL06K46JvYZ5PlOiApvuD8FnM51Tq
X-Gm-Message-State: AOJu0YyMTAkJZIhlyJGkBKJtrLwse8fiGWjQeOAThVn/gQiNO/XCWLU+
	aR86BBGoqebB2yS0srut9yb/Oznu3oPvnQ4OP2PWi/j+MYu1l6VqtlEWglHGV4T6Wt+odCWg4zJ
	35pQ5Pw==
X-Google-Smtp-Source: AGHT+IEKkBi0SrXiTXKno3G520O9+jS2Hea1c9JF7V76gtXSca8PKgOuebdQJN9T2DR/CHx+ZF+uJQ==
X-Received: by 2002:a17:906:f9c8:b0:a59:cdf4:f948 with SMTP id a640c23a62f3a-a59fb9dac78mr290224466b.65.1715213184826;
        Wed, 08 May 2024 17:06:24 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c64esm14172666b.52.2024.05.08.17.06.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 17:06:24 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so68332266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 17:06:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRRtLHNfOsMBsYZCgY0a+Wzn15ShI4MUTuMDKT0nnNOCzhqNOaNNxUmNDkCL621Gjudby6MDZ7dj/LRgyweHAprYsTCcl9yrdPdH04
X-Received: by 2002:a17:906:57c1:b0:a59:ea34:fe0d with SMTP id
 a640c23a62f3a-a59fb9c675emr342484566b.47.1715213183807; Wed, 08 May 2024
 17:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 May 2024 17:06:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLaDBSP9MXCHc8heA7-rVNGh9yZDG_y4=87KOx_N0cRg@mail.gmail.com>
Message-ID: <CAHk-=wgLaDBSP9MXCHc8heA7-rVNGh9yZDG_y4=87KOx_N0cRg@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 May 2024 at 16:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But again, maybe it would be worth looking into, at least for some
> limited cases. To go back to your particular example, it might be
> worth trying to limit it for unusual type sizes like implicit casts to
> 'u16' or bitfields: not because those type sizes are magical, but
> because it might be a way to limit the pain.

I think it would be interesting in general to have some kind of
warning for "implicit cast drops bits".

I fear that we'd have an enormous about of them, and maybe they'd be
unsolvable without making the code *much* uglier (and sometimes the
fix might be to add an explicit cast to document intentionally dropped
bits, but explicit casts have their own issues).

So that's why I feel like it might be interesting to see if limiting
such checks to only "unusual" types might give us a manageable list of
worrisome places.

I think it *would* have flagged the perf u16 overflow case. Again: I
don't think that was actually ever overflow or wrap-around in the
arithmetic sense, and it was purely a "assignment to smaller field
truncated bits" issue.

Which again is most definitely not undefined behavior, but I would not
be at all surprised if it was a much more common issue than actual
arithmetic overflow is.

               Linus

