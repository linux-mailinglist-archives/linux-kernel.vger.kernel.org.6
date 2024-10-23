Return-Path: <linux-kernel+bounces-378796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC539AD58E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E558A1F260FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F991E260F;
	Wed, 23 Oct 2024 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B7oeB1tA"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5610D1D3624
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715679; cv=none; b=aNZVqEKkQZZEcieFH05Cx1sDNp9eZDc0kdh347OIT3/Nqj3SguRzi6BwVe8bOzklt8zDs1eXYx6t6GkIuQWMZymXeojGhYniwykhvNalD857Tsnj2qBQVf17WevZ280E4aQOBkjOe+cvnx+kCypG1W2uP5oIHH0547lLam2e+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715679; c=relaxed/simple;
	bh=Eb3WWCqlJBEuYN11gpG3daPfKrsqw1rRCRAIlkwBXWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yje6BDFVvGVrqWFvkWMT7M+tIn0EjgiwJuXAEC1aRyzOseoEKd4TTKAX+ts0cGQwKQiEaOBPEBw+jMbJFzVQ3qa+KqY06JWN3noJVSxOWwVfTmmk/qQ1gJlAnatMLa7Bvh0MdBooC55207P1CU2jOclGHatEBU8rv5PHzWx5qf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B7oeB1tA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a850270e2so19909766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729715675; x=1730320475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LEsOPb+l1iotdIHwOTelo3swhljmhVTkrXLfVmt8ycc=;
        b=B7oeB1tAanN6yUFaUpOqHMi3DYp4yaHU1aquBXyc6+ogcynVard2+8QsceCFAgjLaL
         6eXHjEi7i5A7pPTKZdCQdCi6bcVUbMDIxKb0G45K2Buk5OuAidvXw852+6gkuY/6wLJD
         RpnNGvtUIvcUAvaV/KZA7wJKQGmeOFeGBpO7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729715675; x=1730320475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEsOPb+l1iotdIHwOTelo3swhljmhVTkrXLfVmt8ycc=;
        b=PaWLn9kZnJCAQJQjBs8b1bpLSsFb68tACt28L9HKSaYOftvTEoPXUeagYQwEQpzmCS
         N1lr0bKsARD0jg+7+HaScxpQuJKwVwxaLzF45WKjq6lS6mq0EEXELM3v9do+QjbHoeY/
         tfj2Yi0qFJJ8hve811oVjqMx0NfE5ymq5sdhhEbZoK5abJSOrNH/ca/uv4IsfWt4Jj9x
         HzjgcWuGaskOGsFa88sPd71u1SvcbDbZXbDXjcz2heA1LVe8JFUblkPNhL12ZYTq2rsS
         jZOttCFlHpl3Mtg0EQrYIhDvc6Herug5MAcOX95aacMTioIddklXCP5SJT6igr3SkC21
         FBPg==
X-Forwarded-Encrypted: i=1; AJvYcCUq+yj5t0cglQmefCj9L0ZaH/NmfRUCW0razoSTZHgcGJnKBGcASa+2YTcTDJUNDSo7QI/GmO4O+X5Wt4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTgmuOI+wH/4i2tzjAbNR6bOonwUof7w6RX7eJ00q9/jTlDUpF
	d9FXn3eM/rZVrAkwN0193cPIWGyIt/RSKTV+RVpspaSHNE8v7EiW+FAh6DtFZrAD/mDnKV6D7PF
	DOf7s3g==
X-Google-Smtp-Source: AGHT+IHH8DkOJvZ/fWqbT96Zgqo2W3aizShrP1Fj2dS54sOLvR7qwD84toTAYMt2sbawssgs+JazUg==
X-Received: by 2002:a17:907:9452:b0:a90:df6f:f086 with SMTP id a640c23a62f3a-a9abf851de4mr374718766b.11.1729715675498;
        Wed, 23 Oct 2024 13:34:35 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d633esm516871266b.43.2024.10.23.13.34.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 13:34:33 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a850270e2so19905366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:34:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9hTLXhikZHA2jxFSDEnDc9qZ1uVZlyGLlr2zzjcU7as35CvlU0wgKQmgoz4JDacD73MFI6/G5EvRI4Tc=@vger.kernel.org
X-Received: by 2002:a17:907:72cb:b0:a99:87ea:de57 with SMTP id
 a640c23a62f3a-a9abf852bb7mr329557766b.2.1729715672886; Wed, 23 Oct 2024
 13:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
 <20240917071246.GA27290@willie-the-truck> <4b546151-d5e1-22a3-a6d5-167a82c5724d@gentwo.org>
 <CAHk-=wgw3UErQuBuUOOfjzejGek6Cao1sSW4AosR9WPZ1dfyZg@mail.gmail.com>
 <CAHk-=wjdOX0t45a7aHerVPv_WBM3AmMi3sEp8xb19jpLFnk0dA@mail.gmail.com> <20241023194543.GD11151@noisy.programming.kicks-ass.net>
In-Reply-To: <20241023194543.GD11151@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 13:34:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=Ji6-xi32167i3M1JL_YyRj6tgUAJS=YQ94GKzMBvkg@mail.gmail.com>
Message-ID: <CAHk-=wi=Ji6-xi32167i3M1JL_YyRj6tgUAJS=YQ94GKzMBvkg@mail.gmail.com>
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load acquire
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 12:45, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Do we want to do the complementing patch and make write_seqcount_end()
> use smp_store_release() ?
>
> I think at least ARM (the 32bit thing) has wmb but uses mb for
> store_release. But I also think I don't really care about that.

So unlike the "acquire vs rmb", there are architectures where "wmb" is
noticeably cheaper than a "store release".

Just as an example, on alpha, a "store release" is a full memory
barrier followed by the store, because it needs to serialize previous
loads too. But wmp_wmb() is lightweight.

Typically in traditional (pre acquire/release) architectures "wmb"
only ordered the CPU write queues, so "wmb" has always been cheap
pretty much everywhere.

And I *suspect* that alpha isn't the outlier in having a much cheaper
wmb than store-release.

But yeah, it's kind of ugly how we now have three completely different
orderings for seqcounts:

 - the initial load is done with the smp_read_acquire

 - the final load (the "retry") is done with a smp_rmb (because an
acquire orders _subsequent_ loads, not the ones inside the lock: we'd
actually want a "smp_load_release()", but such a thing doesn't exist)

 - the writer side uses smp_wmb

(and arguably there's a fourth pattern: the latching cases uses double
smp_wmb, because it orders the sequence count wrt both preceding and
subsequent stores)

Anyway, obviously on x86 (and s390) none of this matters.

On arm64, I _suspect_ they are mostly the same, but it's going to be
very microarchitecture-dependent. Neither should be expensive, but wmb
really is a fundamentally lightweight operation.

On 32-bit arm, wmb should be cheaper ("ishst" only waits for earlier stores).

On powerpc, wmb is cheaper on older CPU's (eieio vs sync), but the
same on newer CPUs (lwsync).

On alpha, wmb is definitely cheaper, but I doubt anybody really cares.

Others? I stopped looking, and am not familiar enough.

          Linus

