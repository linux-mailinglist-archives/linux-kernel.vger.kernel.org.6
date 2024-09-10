Return-Path: <linux-kernel+bounces-323362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CCC973C02
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22071C24935
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A0F19D09F;
	Tue, 10 Sep 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpLyggcg"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA7191F97
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982318; cv=none; b=vFySjYDyJVhXNdiTxZMDFGu/VsJffOnYrIju4DG79VaFA/w4nmpx49OLeqGgDByXeuvYmx7J4SmIoBtPD9rCNnYcLQRmEXrrtLu/0zya1bjcherVtd6imd++9q3YCVc8fVw8pnpQsBUsdAOkS96sBejieHq5B7yTyNEN7dhA6Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982318; c=relaxed/simple;
	bh=58vwLif2w0LcCxt3l9m+/yn4hsdJcrUKi4MUhjWQVNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeF7TWOdMbo+jzLFkCa8MC04gXU+0OxjfdlFhv3KSqU0qXSRNNJsIoudFF7cKZeJmyyYkeZtz/Sqwl2M+54skys/E4bf8+GwZYdXON7hAM6G2ISkb7s822feLedY870uCY8rEvPdO+45W9DtV6MPqs892PGqsaCGmd7h9xGFs+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rpLyggcg; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5356a2460ceso26779e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725982315; x=1726587115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11EJWGDdB3TRpoNJTX71d90zkEuZ3hMNes9yKkfvSyM=;
        b=rpLyggcglEoHYE2ZNtA8BzhU9mu6JmUzf3ioNcJLsNTuSenuz4522PpT2odQv9nRIV
         MTmgGT9K8KtuPBvXSH2CemZLOVyDXJubGPhnCgQ6M815DI3OtP1gxbZPUpC0uq4nL/pZ
         nA7b/iy68gmg+4FNPUCFH3j0n3B29zgCMoEgiovNLDIeeoyIbwseOvz5db0dUbUwBzKx
         Ca7IPMRhxyu2lrGcHFtufSJK0Uc6au11lcuP3DKMFfSd1v7AJZue5R0SWoTjNRKCT38J
         IHzfuGNHSUNgFO+uxuA173MPhY9vA0SVlRGP1bd463jE3DJ5Jk/ULHYWCYdfXNoTXRBN
         gdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725982315; x=1726587115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11EJWGDdB3TRpoNJTX71d90zkEuZ3hMNes9yKkfvSyM=;
        b=gZS9dhTCWVn85jBOfqJ07XCqWdofbC742cuGvC8twX3qC9aXnJCCCgjgRZNAQeQNLb
         adyrayEB30FYtStrs1Kk4xy4JAWYbG7gbWPqmC9g9KERaY7IQP8BTQflgOzjZfHI7GdS
         Ng2d+arHgZQ3R7XmYqm57IDHmXtZMEYisrUy4NS8FtM5Q05PGB3bLzyKzwbktW1bdapV
         IsGEiZU7lAM6VB9uOLA/KC6aoRiEmLR5LenujbHH8LOaXtacfdGdCiy7Wwd8LFr/py/L
         qit4R5z5g2bPv4IRIMp3EPT+o6d+qKwPeUeWe/ktmDZMl0SBWI26jsKkQ+GgE1KFEZ6e
         v0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6sEHfkIULJegOwGwMbAuUDFfrknVTPAInrQ/nXXumzXKCYrfHbAFf/BmofXXgTVXA8IgQkyJTxzTjaPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt30LOBpqgIfCRDjDJgZzShV9vcXYilP6P6LoNXQ1QXUSWYVlX
	T4DL4ScBgPrCigxTLEwiKnamedM019fZ0qYBHoyBQ3yJF4iuEi+sSKKJSpFLzAswmbNR3QVZFBC
	2154/A+TTQDYEKHKLc77j79P8IaEpP0/Hpp+1
X-Google-Smtp-Source: AGHT+IF7llpzPIrM5lV//xsMPBS037RtCLtLhRWp5fDTFuzae3HG0GApRNkf/Tgi/uVU1gb2WlLVcCtp5hQEeg5tgCQ=
X-Received: by 2002:a05:6512:1154:b0:52c:dd42:cf57 with SMTP id
 2adb3069b0e04-5366ca457ebmr607822e87.0.1725982315020; Tue, 10 Sep 2024
 08:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-2-andrii@kernel.org>
 <CAG48ez2hAQBj-VnimJBd3M-ioANVTk+ZQXYWD+j9G+ip2K_nfw@mail.gmail.com> <CAJuCfpFAvsMsBTBMaK5sHFkLQPrfE0nb401gEb2hmN2rbjza6g@mail.gmail.com>
In-Reply-To: <CAJuCfpFAvsMsBTBMaK5sHFkLQPrfE0nb401gEb2hmN2rbjza6g@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Sep 2024 17:31:16 +0200
Message-ID: <CAG48ez3MNkhCpwST1HH9tzZWusqk+YZaWHZ2v=sZnzMo1jk7Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce mmap_lock_speculation_{start|end}
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:09=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> On Mon, Sep 9, 2024 at 5:35=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> > On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >  static inline void mmap_write_lock(struct mm_struct *mm)
> > >  {
> > >         __mmap_lock_trace_start_locking(mm, true);
> > >         down_write(&mm->mmap_lock);
> > > +       inc_mm_lock_seq(mm);
> > >         __mmap_lock_trace_acquire_returned(mm, true, true);
> > >  }
> >
> > Similarly, inc_mm_lock_seq(), which does a store-release, can only
> > provide "release lock" semantics, not "take lock" semantics, because
> > the CPU can reorder it with later stores; for example, this code:
> >
> > inc_mm_lock_seq()
> > [locked stuff goes here]
> > inc_mm_lock_seq()
> >
> > can be reordered into this:
> >
> > [locked stuff goes here]
> > inc_mm_lock_seq()
> > inc_mm_lock_seq()
> >
> > so the lock is broken.
>
> Ugh, yes. We do need smp_wmb() AFTER the inc_mm_lock_seq(). Whenever
> we use inc_mm_lock_seq() for "take lock" semantics, it's preceded by a
> down_write(&mm->mmap_lock) with implied ACQUIRE ordering. So I thought
> we can use it but I realize now that this reordering is still
> possible:
> CPU1                        CPU2
>                                  mmap_write_lock()
>                                        down_write(&mm->mmap_lock);
>                                        vma->vm_file =3D ...;
>
> mmap_lock_speculation_start() // seq =3D mm->mm_lock_seq
> <speculate>
> mmap_lock_speculation_end() // return (mm->mm_lock_seq =3D=3D seq)
>
>                                        inc_mm_lock_seq(mm);
>                                  mmap_write_unlock() // inc_mm_lock_seq(m=
m)
>
> Is that what you were describing?

Yeah, that's the scenario I was thinking of (though I did not spend
the time to look at the surroundings to see if there are other implied
barriers that happen to stop this).

