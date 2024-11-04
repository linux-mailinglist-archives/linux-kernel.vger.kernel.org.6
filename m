Return-Path: <linux-kernel+bounces-395085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BCD9BB83F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67041281FF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FD71B6D0A;
	Mon,  4 Nov 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxM1vmuA"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182713BC2F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731692; cv=none; b=o/0Usa4QyT0p4QXaRFOOJzn4N/Xse9B4fm86Dz4iNv9uHQd90XN1tDQmxGYyWvJqlQhYFYV8phKvDJmTH2TUFrdUXaFrZu5ErtXm1hAoc6sqp6kn/P+/Qguho6orw3yz8mSspKKnTq1NcgRVbID+sd/oRYcwdaOYApoewBPV4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731692; c=relaxed/simple;
	bh=/T5Edw6cwcWgYB0CA5h17kZfKYu3hZVww4FHhB9PoNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFTDMWp6WtBSWaMZ30RPvrHxWFj3SFk+YjD1rM/XWwpqeUwommuO8KpjGTYB/fSd/dweCc3SU5yVKkkvOvnRvTswgrZdiqFzasKTMpDLkrEyAmskIr9z8pNhdnA+5QjQH/rH6315RpB9GlHc3EojhLmm1u8kISXv+r74hUZ56FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxM1vmuA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d5aedd177so2718963f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 06:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730731688; x=1731336488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u5WWnKcEl0DXoUZeV4v00gio1Ie7A1y/U+D5nXly8I=;
        b=nxM1vmuANI8D0c6N8x6Joyiq1zkc3fe/rnUYRG+tK1n5P5PvPlbh7FjDCEsykTu4Rf
         GipeF7UErPibgnu2ZReH9jA6XMI8nIVDsmSqi1d8d0N5PKrafjxn8Y5ykHXA2/LqDOaV
         dq7dLPZFmykEl5HFxP5VTC3pPN9pIlcsyidXcSsalqpWyZ1BlPzLGNe/AEJWrvsE2bPa
         TkpHilcRqCEtmCofKMVYWrEhcsFQu/QlyfRds1k3OsBEw0iW1SHFN8zVl2ldTzZCwodx
         m9lKtPZGWGsNQFs8EOuyVehoHqFYESkka48Y/VcPOj54plgR4/zTlxklH8xAqJV14RVW
         8oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730731688; x=1731336488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u5WWnKcEl0DXoUZeV4v00gio1Ie7A1y/U+D5nXly8I=;
        b=lOpM4G8bf1QohFFPhpvH4bEpjtdL/nShwrECmcKnK5c//Ba3EjnL0sJmvU/KU3cnGd
         dKfCuOOZhhWWJqtlGGYflVuh0JKJkwlJBr6qIxivINztp9f4eKEx+Q/D7JDdi660l0rf
         rVoVKkYJddoZu7wQiws9RTmc+3sI7ui8phUW115nhAPgOgTY2aRJIrcshPwg6VPiTuH1
         bkWNvoP5Ugkp3pfNAZPgXJV8X9ZcT+I44XjAhl5ltsJJQUu2afDWrswevpU1hQyAV3h1
         K10+VE7yvS9+VYdDHCmgZ+tcC8zTTiL07hy6YeQaH34x8gNyLAjCN8/zxuHYW/1jhnw9
         Pxgw==
X-Forwarded-Encrypted: i=1; AJvYcCUfIwJzJpbt1gj9p3Wdo4YT/FfDP5cadGtEmDyhymacS2xxMpa7y3y7sBkcBHz3E02xRc31W64IJE2D6PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylUT5nIbMjqp4rqmwOFD3b76t6EVPR4HufKaKpLNllX6jliN+c
	bCpQ+4sncMvGNKf9LDJAqown9CLCSpZEBhHTJK8A42BIWDThrfroAMS5DeMaMn4gz2hKbAhxUuI
	1s1+8VaOAXrrDUnfHSfeflpP5PdQ2sBdau5cO
X-Google-Smtp-Source: AGHT+IFLw3PtLMaMhDI1PhPWbZqD5k257Ad79u5K0QmJLkgLoqJXHSE9DXwZfmCLvYqsjJtZ/jdCxdE8rTzWMSDJ8Rk=
X-Received: by 2002:a05:6000:2706:b0:381:d88b:21a7 with SMTP id
 ffacd0b85a97d-381d88b2203mr2277141f8f.49.1730731688294; Mon, 04 Nov 2024
 06:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 4 Nov 2024 15:47:56 +0100
Message-ID: <CAH5fLggUZJpmSd7F_k5bVKs0-ErK_74-zpWgMyWHX4vcSM-8Lg@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 7:50=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Locking around VMAs is complicated and confusing. While we have a number =
of
> disparate comments scattered around the place, we seem to be reaching a
> level of complexity that justifies a serious effort at clearly documentin=
g
> how locks are expected to be interacted with when it comes to interacting
> with mm_struct and vm_area_struct objects.
>
> This is especially pertinent as regards efforts to find sensible
> abstractions for these fundamental objects within the kernel rust
> abstraction whose compiler strictly requires some means of expressing the=
se
> rules (and through this expression can help self-document these
> requirements as well as enforce them which is an exciting concept).
>
> The document limits scope to mmap and VMA locks and those that are
> immediately adjacent and relevant to them - so additionally covers page
> table locking as this is so very closely tied to VMA operations (and reli=
es
> upon us handling these correctly).
>
> The document tries to cover some of the nastier and more confusing edge
> cases and concerns especially around lock ordering and page table teardow=
n.
>
> The document also provides some VMA lock internals, which are up to date
> and inclusive of recent changes to recent sequence number changes.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[...]

> +Page table locks
> +----------------
> +
> +When allocating a P4D, PUD or PMD and setting the relevant entry in the =
above
> +PGD, P4D or PUD, the `mm->page_table_lock` is acquired to do so. This is
> +acquired in `__p4d_alloc()`, `__pud_alloc()` and `__pmd_alloc()` respect=
ively.
> +
> +.. note::
> +   `__pmd_alloc()` actually invokes `pud_lock()` and `pud_lockptr()` in =
turn,
> +   however at the time of writing it ultimately references the
> +   `mm->page_table_lock`.
> +
> +Allocating a PTE will either use the `mm->page_table_lock` or, if
> +`USE_SPLIT_PMD_PTLOCKS` is defined, used a lock embedded in the PMD phys=
ical
> +page metadata in the form of a `struct ptdesc`, acquired by `pmd_ptdesc(=
)`
> +called from `pmd_lock()` and ultimately `__pte_alloc()`.
> +
> +Finally, modifying the contents of the PTE has special treatment, as thi=
s is a
> +lock that we must acquire whenever we want stable and exclusive access t=
o
> +entries pointing to data pages within a PTE, especially when we wish to =
modify
> +them.
> +
> +This is performed via `pte_offset_map_lock()` which carefully checks to =
ensure
> +that the PTE hasn't changed from under us, ultimately invoking `pte_lock=
ptr()`
> +to obtain a spin lock at PTE granularity contained within the `struct pt=
desc`
> +associated with the physical PTE page. The lock must be released via
> +`pte_unmap_unlock()`.
> +
> +.. note::
> +   There are some variants on this, such as `pte_offset_map_rw_nolock()`=
 when we
> +   know we hold the PTE stable but for brevity we do not explore this.
> +   See the comment for `__pte_offset_map_lock()` for more details.
> +
> +When modifying data in ranges we typically only wish to allocate higher =
page
> +tables as necessary, using these locks to avoid races or overwriting any=
thing,
> +and set/clear data at the PTE level as required (for instance when page =
faulting
> +or zapping).

Speaking as someone who doesn't know the internals at all ... this
section doesn't really answer any questions I have about the page
table. It looks like this could use an initial section about basic
usage, and the detailed information could come after? Concretely, if I
wish to call vm_insert_page or zap some pages, what are the locking
requirements? What if I'm writing a page fault handler?

Alice

