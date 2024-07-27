Return-Path: <linux-kernel+bounces-264211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9787493E03B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1CD1C20E7D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC03818133C;
	Sat, 27 Jul 2024 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UWrzdf2U"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0E1DA23
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722099262; cv=none; b=fEHk4C80v3BE51Sb1xXn9Gcq3IGzu7qiv2StkUXyLiDv48n2tC/e6eRrkVUwmT0gBYm9Rn8OyFUwrbNg02pEXpRsStKeoXGnFD1KhzuVzeklzNfa0jSnKxomovbVAIfNyHPNUcttDDMj31g9kZ4p1ZpcGjnp/CyL2GU4Fwd0fKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722099262; c=relaxed/simple;
	bh=Bxk13DIOFZHvaz9dbHQ4sOyOXtF6/NwQCkdt+3hpHdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgIv+kKE1+kwXPtHs2mhoOHtSNIE/afwpSyXUyJFMsnt2FG/yxOSiw0AOTsqQX01ygtdc3SUcnxG2N0VW4FZdWSLhu84DOTk2ICk0tRgz5HDQE1SbuEY7MLIrDKtPsXtWV6rYIlXT6HCs6wxKv/QOJPqeGDLTMk0gq//tfw030M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UWrzdf2U; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so361723166b.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 09:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722099258; x=1722704058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D7vzDklINz061uw6vc7IYxuzCMDVi58hMGCrukF/eug=;
        b=UWrzdf2UEVDj9PO7KJvTPknApjc+BsH5NLkruPUlnnp3APNzcHeK5GNkdA8cvo2Rcx
         7lyk2rZTzAfeM0SSxjFg3vjoZmdvobT+lVexRy7YHCGTSB1XGCzy7FQjI1y8785MU/hG
         oLOS4WGaa+Z0LCz6IRubXdmFVE+m0Wi7VAb6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722099258; x=1722704058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7vzDklINz061uw6vc7IYxuzCMDVi58hMGCrukF/eug=;
        b=JAKzfn+65VG+Mj+N91foCjMslBiLcxp9oUsnY9v/DEhc/nnnsceHKnLkXBxVoX7U2V
         sV3ZUsUZ7Lv4TN0f6Jl+eTWIgEAoyiwTOr5pvQ4OSMFl5yYXqPwDROTyRDNEpMOhxbFp
         0KM7VpNoj4AlrfySbmsRHmv7A6saioLF9Xl/upcSBxjNqqdr3JxBNARgZfBzZ3TWnDM/
         mbwx5lNpI6x7ZVterALFmZwz2qV6l6KseFGDR3vaQVVQvEb3ThusvgRiBMT43bFcz7W3
         PoNtpG1BiroK2PDJDhzBBjoKr3888Fp0+6DTXWwg7905ev/9S8TBReUQZcSpusjAZRTJ
         uyWg==
X-Forwarded-Encrypted: i=1; AJvYcCXfMNdSqwW+Vqcl92d4PdpI/O7HW7TbxbvwP5lnpEtwvwq/WKGDP7pPq5PiAn3DqhhuIZ4zEyB67Ks7VZE1y/AyxSSuB6BQzOzmLIqs
X-Gm-Message-State: AOJu0YydKv3hGCNqfePyyA5EnnIKStOgj4GVJTurbxb+cyCNNZGMSFzI
	NIWCoJNoNuaQ6UHuXjobOatEJZNDKS6kK1xhuHJMaiteUh5AeRocx0eyByb2POSvGOaPR8FtP/o
	YfMBg8Q==
X-Google-Smtp-Source: AGHT+IHZmSzMLI4uXYhQYUHTOAhjuGK/uD7IhKUCD3ThVB08dwuPugp6ldDyP5IhmeYSspHmS58dsQ==
X-Received: by 2002:a17:907:944b:b0:a7a:bae8:f29e with SMTP id a640c23a62f3a-a7d400a0385mr181018566b.29.1722099257934;
        Sat, 27 Jul 2024 09:54:17 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4114esm295449566b.106.2024.07.27.09.54.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 09:54:17 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso3633335a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 09:54:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGpUTEODSN3EBLhN6XcQSDuFn0hLdPoZOy3GZEhQRUd7eC0sIdK1eCxvn1uPccE38uTkrdEdgH6gy1AVtuqWrf4HE1lhNTf96Ks/Vk
X-Received: by 2002:a05:6402:3508:b0:5a1:83c4:c5a8 with SMTP id
 4fb4d7f45d1cf-5b020ba89fbmr2297536a12.14.1722099256847; Sat, 27 Jul 2024
 09:54:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5e42ce13-3203-4431-b984-57d702837015@I-love.SAKURA.ne.jp>
In-Reply-To: <5e42ce13-3203-4431-b984-57d702837015@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Jul 2024 09:54:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgs52BxT4Zjmjz8aNvHWKxf5_ThBY4bYL1Y6CTaNL2dTw@mail.gmail.com>
Message-ID: <CAHk-=wgs52BxT4Zjmjz8aNvHWKxf5_ThBY4bYL1Y6CTaNL2dTw@mail.gmail.com>
Subject: Re: [PATCH] profiling: remove prof_cpu_mask
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Mel Gorman <mgorman@techsingularity.net>, 
	Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jul 2024 at 04:00, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> We could replace alloc_cpumask_var() with zalloc_cpumask_var() and
> call cpumask_copy() from create_proc_profile() on only UP kernels, for
> profile_online_cpu() calls cpumask_set_cpu() as needed via
> cpuhp_setup_state(CPUHP_AP_ONLINE_DYN) on SMP kernels. But this patch
> removes prof_cpu_mask because it seems unnecessary.

So I like this one a lot more, but it actually makes me wonder: could
we just remove the horrid per-cpu profile flip buffers entirely?

This code predates the whole "we have _real_ profiling", and dates
back to literally two decades ago.

It's there due to ancient NUMA concerns on old SGI Altix hardware in 2004:

   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=ad02973d42f6b538c7ed76c7c0a5ae8560f65913

and I think it's past time to just take all this code out of its misery.

Nobody sane should use the old profile code for any real work any
more. I'd be more than happy to just remove all the magic code and see
if anybody even notices..

                  Linus

