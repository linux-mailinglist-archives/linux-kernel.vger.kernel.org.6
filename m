Return-Path: <linux-kernel+bounces-285093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261F0950935
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F2628353A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2021A071B;
	Tue, 13 Aug 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIJb49lB"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90EB1A01D9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563378; cv=none; b=TNDsH552nO5HS+R4gWQLqgLQn63XaWtfpGXLu80V+EZlOm7jlPquDxGdxdiexQsRfnun34ZMf0Me+PvfNHdbnZkbfpMY1Zl9c1cXAGVLmSMJZWbkZ2AW0smUkWX021S36kpVAEfDiqnmoNIXqDYme+qAl2bm1v75BEv65fmI0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563378; c=relaxed/simple;
	bh=8XN8l1jauSNkrNY6DVaHPyqTBlKmM+vQ22mOTXq6Qk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjaPJn6yfQeV6YohPGO8I3aoCKnLiK7CGH0JfsUmnR+RmyVb+e6H+gd5IzFZ4ZXEGbutdiqZbx1pW9srEKw9N7NyzauWF0sf45rclRVAjv9xSORaUT5kEnrwPhYo/O5Ejg6izQ5jxiPUFddvr/3CM5opbcY7VIgE3InpiRi58wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIJb49lB; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-691bb56eb65so52512747b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723563376; x=1724168176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XN8l1jauSNkrNY6DVaHPyqTBlKmM+vQ22mOTXq6Qk8=;
        b=uIJb49lBjwhjsM7YyoerXyRVX3gB43sgf3V+wCC+G7+gorz8W9mrsqUD0+Kt/HjK8n
         W1cqPRfYIcA7xgG4ddc6Obe1JPPkkoLCaMaRd8FzzWpzhTxXP+I+/CRrNhq2ws7buw4c
         A5sTpi9i1RNaz+Zxvowl4+hw/B8AJCa7jcq2UuZvAnt2+ZYwhWF5o7bUUhEMm6NWUqi8
         fWNcfItBIY3cPL4QJQTN7UrzwH8jQcMd6REatXPcBkB6tCNIA7yfY+PpEq2ikFt6TVHL
         IkOa7324BVSSrN6o+GqNoW/j07XO7/fMB0T5B4sPSnK7zWHBYfNhdvET/pi1mNyPj5eE
         GAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723563376; x=1724168176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XN8l1jauSNkrNY6DVaHPyqTBlKmM+vQ22mOTXq6Qk8=;
        b=natgdH0JGnLcfbuJoWFnW6fgxWONkDROObZqQqmW7l1C1IBqRJa14D4wCsXmJs/KJ8
         R+P9zx8ulphpnqKAG0r4SgkrD+TH3gfTHJzUppVElgyMizrMUjofdOV7jtl1JKAdy5Kk
         CI3IB1o2Z8WVJXdofS1RW8F0boOUbQFqu9q/phhf//4VyRvI3Meuwo9No1dOM0Ov/5wB
         ZA8FTWxaeDU+3zYtll38HV9KJwWEFjPGqfdYWFccfzkeIKVCxsAdVjhBry3VyXOVC6oE
         4aUe+2kHWt5oKKgDTnQqnkmvDBxiCS4KPwbAE0n89NWqjU/rFbiu5QnF6D3lzE8QSVMN
         rZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXL0KHsWIJ0QFJWHO6suPWnXCsegyOTCpoAyLJRTXa6Y9zZkBvySfmiHzZCbXf8eKIuQ0scpbotBFU5FA18eOzgkv2ELC7gRGgepZj5
X-Gm-Message-State: AOJu0YzMksdWONQnZbZzWsuiGPXOSssgyY+NGd/o0MeJQvyEhQmieYCg
	669jbOj3X5WluVEZez9I4wZgN06SOqFDdFe/gCHeU+xYKEEcAdxV7eRi3uh8OD1A5sqU79PwgTc
	ItKS4tAAXf1/kOypEWHCrAcgDymJRMqEAwxHZ
X-Google-Smtp-Source: AGHT+IGewMdQHdmN2hlq9rjJ5cHzdQ207H+U5ZLcJ+Wx1W91wONKxrCoPZpU6MRnXFPoSPwcwCTkkq02/x8cYLzztA0=
X-Received: by 2002:a05:690c:ed5:b0:632:c442:2316 with SMTP id
 00721157ae682-6a97142715dmr47043317b3.3.1723563375488; Tue, 13 Aug 2024
 08:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240813042917.506057-14-andrii@kernel.org>
 <7byqni7pmnufzjj73eqee2hvpk47tzgwot32gez3lb2u5lucs2@5m7dvjrvtmv2>
In-Reply-To: <7byqni7pmnufzjj73eqee2hvpk47tzgwot32gez3lb2u5lucs2@5m7dvjrvtmv2>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Aug 2024 08:36:03 -0700
Message-ID: <CAJuCfpG8hCNjqmttb91yq5kPaSGaYLL1ozkHKqUjD7X3n_60+w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 13/13] uprobes: add speculative lockless VMA to
 inode resolution
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 11:18=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Mon, Aug 12, 2024 at 09:29:17PM -0700, Andrii Nakryiko wrote:
> > Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely access
> > vma->vm_file->f_inode lockless only under rcu_read_lock() protection,
> > attempting uprobe look up speculatively.
> >
> > We rely on newly added mmap_lock_speculation_{start,end}() helpers to
> > validate that mm_struct stays intact for entire duration of this
> > speculation. If not, we fall back to mmap_lock-protected lookup.
> >
> > This allows to avoid contention on mmap_lock in absolutely majority of
> > cases, nicely improving uprobe/uretprobe scalability.
> >
>
> Here I have to admit to being mostly ignorant about the mm, so bear with
> me. :>
>
> I note the result of find_active_uprobe_speculative is immediately stale
> in face of modifications.
>
> The thing I'm after is that the mmap_lock_speculation business adds
> overhead on archs where a release fence is not a de facto nop and I
> don't believe the commit message justifies it. Definitely a bummer to
> add merely it for uprobes. If there are bigger plans concerning it
> that's a different story of course.
>
> With this in mind I have to ask if instead you could perhaps get away
> with the already present per-vma sequence counter?

per-vma sequence counter does not implement acquire/release logic, it
relies on vma->vm_lock for synchronization. So if we want to use it,
we would have to add additional memory barriers here. This is likely
possible but as I mentioned before we would need to ensure the
pagefault path does not regress. OTOH mm->mm_lock_seq already halfway
there (it implements acquire/release logic), we just had to ensure
mmap_write_lock() increments mm->mm_lock_seq.

So, from the release fence overhead POV I think whether we use
mm->mm_lock_seq or vma->vm_lock, we would still need a proper fence
here.

