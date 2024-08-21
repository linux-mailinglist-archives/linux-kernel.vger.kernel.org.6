Return-Path: <linux-kernel+bounces-295621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7881B959F27
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37337285165
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BFF1AF4E9;
	Wed, 21 Aug 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i86X+Ayl"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F221547D7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248767; cv=none; b=m9GdJEMcmPaKs/zTSQsUC3jjHS9rwuThrNhQPGTGyxCmFRhXDJnw2z1LMz5VBZnLwHFcAtgD94CNS8r4Q9ZQeBViSim3oaIRobFlRBtkR8GP+FroatZEM5MJrRn/4J/8qs/jp9o1VTYr2O85mhEinh13IHA3IDTs0/Ge/eEaliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248767; c=relaxed/simple;
	bh=Nxst5TEEm5z8iUl+TEBEPrc5FH7ZeLnW1hV84NEgvl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xtcz5A3qLkEgpYsnaCJJmPL8L7Ho2O+QwQNF2Gw4m0aVBng5yMVT3VJzkcDpJMeIQkAmOu74zdDVINPoWGOkT1W/mPQ7MJXxhzbAUQY5pcmMe7OWPjqFpg4JRpImqukyW5KhBntC9Ij7L5B3MGBvMbbqEYpwm/kLm+bM5EjPA+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i86X+Ayl; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-45029af1408so241261cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724248765; x=1724853565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nxst5TEEm5z8iUl+TEBEPrc5FH7ZeLnW1hV84NEgvl0=;
        b=i86X+Aylb0s933AOrTcJV8KZtXwzjiiM5lKy9ec6d5v1mpCTQ/JMqAq05+jPkFXxDd
         sbbpXP8RfQIEtdY0zECddDGypd2PW8ztobhixSNhrgGpKhu0hrLekteGJ6boItk/Iu1k
         gILmkQnBtBXgwdcnWJvx96F3Z+dc2HNosVYQv3Lum37VfxrhnRZjCAiL/ILMVHdsQ4PI
         hPC21MQyF2pEpI+JjjoJnf9OSsQBGw/ZQ71IqKkwngwfW4JiM1tIDWPtRPTqlRnlwDVR
         Y8b4ZuNUVIeQBy0DHIwfSKkFuqIzATNL16aopFxzOK5WrMZ1+/vOYm5TVGskCNY0Iy/O
         YtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724248765; x=1724853565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nxst5TEEm5z8iUl+TEBEPrc5FH7ZeLnW1hV84NEgvl0=;
        b=GcodjTXyMPEwfcU0mZumZvEd5fJhR1e20/O5UU34N9xlbi98Z98EtDMHvvzWziUmzt
         w22366lijIBRNQd0xmSZttFUwGyFuigWvTEwd3Agn3Qx6o0ck0xnZTKwqqK/xyYnZwvA
         4nnzFmFPycISa8UKLC5KXvSnyPj9D1NvTnr2dMVQfGovZpudK7gIFgKwjQbUOLIxV9N9
         h6lpnVdkvA4D0JGgPLr/qx4p27JvM73Ynhrg7vu3kODgjS0yVildIYiyYVVIeLuC2snP
         dIrRX9jNPRm5Uzh/oCplChgEZ8aGTn2Zb31MVLQ+B2H1lfQSHCS04Rwj42s9v9x7YPj2
         bNfg==
X-Forwarded-Encrypted: i=1; AJvYcCXWsyurHz8+Z0lyxWcJYqoYJhNzLCBc3prgrRcwuO8WLMT5eVjk8tokV0SiTDvJwPU/WwKnv+wbNrAfSp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiR6z0REth4uDEk/6nchRfWaIGhxE2ubk8UsgQyrqX9jAHKr7k
	6ZreLVnu4mAI7YisHwj1XjgD2qG9fIuj3DyfkkeyI/fLy974emnP3uxprtGAhy9zveQkVLr6h5a
	MJx/HmxpOm0/6ozzqLPpLpRelPqf8RxjdIo8y
X-Google-Smtp-Source: AGHT+IHaKAKAmTQrt0rYQ98cgg8gxXsJZuuysW+sK0/lYbbTiqQOpt7PedEDzP9OP5rgPDX4GKwW7os42UuaOOU5wak=
X-Received: by 2002:a05:622a:5b8b:b0:447:e8bd:2fbe with SMTP id
 d75a77b69052e-454e8530e2bmr6047001cf.1.1724248764541; Wed, 21 Aug 2024
 06:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com> <20240712-asi-rfc-24-v1-16-144b319a40d8@google.com>
In-Reply-To: <20240712-asi-rfc-24-v1-16-144b319a40d8@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 21 Aug 2024 15:59:11 +0200
Message-ID: <CA+i-1C31FuFUkCMZmZ7O7423f_e-0RAEcBiMMsO4daTACVZjiw@mail.gmail.com>
Subject: Re: [PATCH 16/26] mm: asi: Map non-user buddy allocations as nonsensitive
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Jan Setje-Eilers <jan.setjeeilers@oracle.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, Paul Turner <pjt@google.com>, 
	Reiji Watanabe <reijiw@google.com>, Junaid Shahid <junaids@google.com>, Ofir Weisse <oweisse@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Patrick Bellasi <derkling@google.com>, 
	KP Singh <kpsingh@google.com>, Alexandra Sandulescu <aesa@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, Jann Horn <jannh@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This solution is silly for at least the following reasons:
>
> - If the async queue gets long, we'll run out of allocatable memory.
> - We don't batch the TLB flushing or worker wakeups at all.
> - We drop FPI flags and skip the pcplists.

While fiddling with this code I just noticed that, in my enthusiasm
for stripping the logic to the bare functional minimum, I went
overboard and totally removed the logic to wake up the kworker.

Anyway, this patch is stupid regardless for the reasons above, but
just noting this down in case anyone does read it and wonder how it
can possibly work. It just leaks memory.

If anyone wants to try out this RFC and needs their system to stay
alive for a while, let me know and I'll prepare a branch with this
issue fixed.

