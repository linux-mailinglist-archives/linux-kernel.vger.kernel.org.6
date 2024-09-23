Return-Path: <linux-kernel+bounces-336089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3502597EEF7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C0C1F234FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5C19E802;
	Mon, 23 Sep 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VJjI4ca2"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BEB19CC20
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108046; cv=none; b=JMg1GP1T2/CWY2YYpXgUuKmIyuIAZvjAItzdUcNAcisGye1WF/ZM1wCPZ2jGBKHMlZ3aYzEPptkHAu8my+56dgI32n3lPNBzv5oMjeP3SX01jttOehsFQ8dHUpbyvNnCT/kUBs0X9ExoGmBFE2n9ToUCNtpdDLRYVIEhrCqquHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108046; c=relaxed/simple;
	bh=/6RBTd3w7D71uF6wj6oQf+CvB5eOPq14lNcQDd8J2rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7aUHSRSZWjNhuLZheBIUNOiAq46BScZHkAeRXLNJ8vAcfBTw/hEuRGzNnxguynLTB4NH5q6fJtTk3iJyYWyFIYEKHfzp6QgUHbKGqA6kiNb9G+SJPgXem19+zRB8Qf/tm/7RHjjDqvsrXgSkpWih2SW+Q8OPIxTalUjN4pWRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VJjI4ca2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c43003a667so6433346a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727108042; x=1727712842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KhxyB4gnJFPivYVDIfICHwK2k4/8oKwPbaN8LTyNmkY=;
        b=VJjI4ca2w3IuZxeFk6VJdHCU7BLoIRYxiWfyYKmxACyQNoP01dMtugM05kdM0ktlaA
         oPYKIJxZ0AnoAD4SPPiiMkuxeokru6VqCfsyEIL+/yCdndUErDFdXlnHR+7snIWN+bKx
         LK5qkFjtEHyOambr4VNRnwRnY/1iBav1+iho4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108042; x=1727712842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhxyB4gnJFPivYVDIfICHwK2k4/8oKwPbaN8LTyNmkY=;
        b=evVUCwd5us+ORkylGcTm+/TDPKNAszZflkOyr58aiLtcJF+x695lB+lFfQHfaZJMRY
         SO8vKQPFpt2W8XREPoiNu/Msd+4ncVt4SALj13gfhNaDUgU9GJdFzty+d2oQVE7jG9Q1
         vokwg4Z2DMqdMRjwLPTaToWY4WISGmo9zJ3UizbhmqmfM1iDKvgTvlpTI2n6eMj7YylD
         EG+np1Z6V17PbEey1Y4mgp2rBwSFRX4oSXha4u3tmln9Y5SToauRrGaoqV5681OJAsDn
         +5+SRUG/WwXR6Ix6/RliDDsIETaXjqHV+gPSDD9kSCV7GpShq9PFz8j8iSCdFFfLzXPe
         ag5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMHPj7Hc8PgxryJjLSYhyfdKAozpw75gJ6Sidf+lSk17HYzAn6axM+l6FMOFEJr8VSV+KRJzw82IhnIEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwxkt0q96/jqF0U5+AewrV2C9uiKTP2grEihyPkUtbo2Kqeen8
	rP/6I9RGFlnOM3qhh1StTyp/3ly2csPEljaR4124+LrWcRk3HNGrc9E7bYGwUQkmjG4sI0zU35t
	e9bA=
X-Google-Smtp-Source: AGHT+IE9fmTdCoxoLmHLZImhwlaj0X9hqIE1vbqq/n5DSfwYbzAmxr7tBi2kTZv7gOkGDJL91JlaNw==
X-Received: by 2002:a05:6402:34d1:b0:5c5:ba82:c3b1 with SMTP id 4fb4d7f45d1cf-5c5ba82c45emr5000840a12.29.1727108041882;
        Mon, 23 Sep 2024 09:14:01 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89f7esm10433791a12.66.2024.09.23.09.14.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:14:01 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d24f98215so613619866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:14:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIpXJgD+yetvQ00Y4JcwhNiMOFi7d7YqD6xOoP0ptWPpszTLI9hJtT2aCTimlvZjQn3LxK9NUvTxjejXQ=@vger.kernel.org
X-Received: by 2002:a17:907:36c8:b0:a8a:91f4:fd30 with SMTP id
 a640c23a62f3a-a90d51098dcmr1410438466b.56.1727108040711; Mon, 23 Sep 2024
 09:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920023317.f20c9ecbb2a2f4bf382d831c@linux-foundation.org>
 <CAMuHMdW-4_WvazciLPedP6R6XnEnHqsEh+3s7M5159zcmHit9w@mail.gmail.com>
 <CAHk-=wjUiO3qUVR6ydhGjby3yf_KQO5+m7Hfb4H09kXXPogZ7g@mail.gmail.com> <CAMuHMdU3mfA_SuPqw8ZjkECnP456R=K49fg2yHdOznrSzvTjAg@mail.gmail.com>
In-Reply-To: <CAMuHMdU3mfA_SuPqw8ZjkECnP456R=K49fg2yHdOznrSzvTjAg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 09:13:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1ZaVh2Tsc9tyXM7O1sL0eArxWHiqszZLj+MWe+f3Pwg@mail.gmail.com>
Message-ID: <CAHk-=wh1ZaVh2Tsc9tyXM7O1sL0eArxWHiqszZLj+MWe+f3Pwg@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.12-rc1
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Huang Ying <ying.huang@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 01:09, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> BTW2, the following may not work with the default PHYSMEM_END due
> to integer overflow, on both 32-bit and 64-bit:
>
> mm/sparse.c:    unsigned long max_sparsemem_pfn = (PHYSMEM_END + 1) >>
> PAGE_SHIFT;

Good point.

I've committed a truly disgusting hack, which makes the default
PHYSMEM_END in the absence of a MAX_PHYSMEM_BITS value be

 (a) always a 64-bit type (ie unsigned long long)

 (b) be the maximum value to fit in 'phys_addr_t'

 (c) _but_ with the high bit always clear in 64 bits

so it's basically either 0xffff_ffff or 0x7fff_ffff_ffff_ffff.

The disgusting macro I came up for this for this is

 # define PHYSMEM_END   (((phys_addr_t)-1)&~(1ULL<<63))

and no, I'm not proud of it. This is all horrendous.

We need to fix it properly, with the proper fix probably being to
always have a valid value for MAX_PHYSMEM_BITS (and no, 64 is not a
valid value due to the overflow issue) but the quick hack hopefully
gets the build going.

Of course, I don't have the m68k cross-environment set up, thus the
"hopefully". Let's see if this works.

               Linus

