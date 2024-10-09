Return-Path: <linux-kernel+bounces-356099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0675C995C73
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297E91C220C5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B64BA53;
	Wed,  9 Oct 2024 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQhpULs6"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FD221345
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435007; cv=none; b=EyPTTk6dHA1PYefk5OeJdz4O9E+vpqrp56xKAAaRNOVr9Ssr3aGpcn8EhGlHuYxRA06eQE9rJdpFzcxjreJD3k4qXk2M/I+XXP2dsuvn75eJRpljNIOLKakvYWTaBuTANMnFMxX2zoPMiVY7Z/AyCeZf8Cpj3SoEwQ21dWOnREw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435007; c=relaxed/simple;
	bh=P5xBkJBsHSVqAt+axJMzODbqA3UYAyFBsJSa47B8HB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reDXx69jPH/LzyVUQcbJiJLPcTtsFg9kdqvcteaixI/6NMWZ2EEWrtVlmYeLCJfaz1xfeVN/3fA9iHJdH0EceWWcdJeJ2GLkKUNbR+1VogeE2JYVZ6hwHxy237fVEb8CZExhmzYWLdqu//nWD/t5EdrCJqCePdyrIcxm6GrEsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQhpULs6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43111d23e29so8455e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 17:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728435005; x=1729039805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5xBkJBsHSVqAt+axJMzODbqA3UYAyFBsJSa47B8HB4=;
        b=wQhpULs6eJ3jSG2L+e4vjJ44HB5pmfIDFhHYLIvtGtycGlk072JDV2rO78H1awo/Bl
         9CYQvG492yAoth9YColDI5pOCNQ/QkXNfD9xdnoUInBl5BZlF/LDuWd7Sq3IBdhsaWoj
         KaE2mHf8Ceya7kd6xtdpaTLC6MVHs3UGfJsbhbuIvPHWJ3UvWBMQjNBO9HuC9/tvLtxH
         PFK1iUcKcInGBWa1TtqClkFZ2+hrrbGLlWIN55CGGxl37i5pAhXR7lr3FSjBjDB3DkVT
         8L1i2PVM54SHQDraaBpnaVk5vAWyU18c+3OshkuXSXbNOLWuiPJliZg/sGz/pc/z8otj
         QbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435005; x=1729039805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5xBkJBsHSVqAt+axJMzODbqA3UYAyFBsJSa47B8HB4=;
        b=PI9Fbylacgil12dCo8oD4/xzON6BsGxWbEwZdEcInI9VdiIxsbey5sXypvzur5/B07
         GF8uC7/HzQmnBWROEbzxUNuIivwkafwkIz2i0DDjOUCL/31GdCCdNOavMWEpRH8mga4K
         FNEmcaOqhBOW4iXFUyDlDhOGKsARF98tnV8cPps+rdBvCoJG9kAwWNOU+970CEIxISnI
         CxKJO8pjKLDfcHFI1/1ds595vtiouvuQ730wQ1g0GFKJumQOnh4VNqBCp8eXLhh8YXYx
         DVKZQytUdyuYSs6du15KqUZ8/6xvmW8vvL9NUlyq5A43luWzmwpiBr9fVU04FtJrgdsr
         4+zA==
X-Forwarded-Encrypted: i=1; AJvYcCX/ghajN1cn6H5w0T7pLx8TMfAVXwFJT2EQ/nKkvh342txaFCRtAtpN0diKQ7lR6LheQxCJItaysXiPSw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsyUlsdccazKA6Pk3f2RgFUn7L6atAyyLQHGQkDcgiC+OZ8CGv
	tmeUuntVCiU6egu2JYZLLmG13Psj3W5JMgkUAwzA7LCpjzWAdu1clqPnPTf4kqfknoPfOz1Hnun
	FhbrbCcQpBV0t2RuOoHVhrq8rglUnE93U83wf
X-Google-Smtp-Source: AGHT+IE8i1WoerH4tKasIfRlN/mHeEmDePbStRVFDY5RZAcV3AkdGjoAzKlazO6sInZgo+PAJdXEmCaNDOM+Ho3MuYA=
X-Received: by 2002:a05:600c:cc3:b0:42c:9e35:cde6 with SMTP id
 5b1f17b1804b1-43058cee8e2mr2199905e9.2.1728435004265; Tue, 08 Oct 2024
 17:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
 <CAEXW_YSxcPJG8SrsrgXGQVOYOMwHRHMrEcB7Rp2ya0Zsn9ED1g@mail.gmail.com>
In-Reply-To: <CAEXW_YSxcPJG8SrsrgXGQVOYOMwHRHMrEcB7Rp2ya0Zsn9ED1g@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 9 Oct 2024 02:49:26 +0200
Message-ID: <CAG48ez1ZMo0K0JU321vs0ovXXF2giMvVo14AxNDPzgpGMGZpDA@mail.gmail.com>
Subject: Re: [PATCH] mm/mremap: Fix move_normal_pmd/retract_page_tables race
To: Joel Fernandes <joel@joelfernandes.org>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	willy@infradead.org, hughd@google.com, lorenzo.stoakes@oracle.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:58=E2=80=AFAM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
> On Mon, Oct 7, 2024 at 5:42=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
> Not to overthink it, but do you have any insight into why copy_vma()
> only requires the rmap lock under this condition?
>
> *need_rmap_locks =3D (new_vma->vm_pgoff <=3D vma->vm_pgoff);
>
> Could a collapse still occur when need_rmap_locks is false,
> potentially triggering the bug you described? My assumption is no, but
> I wanted to double-check.

Ah, that code is a bit confusing. There are actually two circumstances
under which we take rmap locks, and that condition only captures (part
of) the first one:

1. when we might move PTEs against rmap traversal order (we need the
lock so that concurrent rmap traversal can't miss the PTEs)
2. when we move page tables (otherwise concurrent rmap traversal could
race with page table changes)

If you look at the four callsites of move_pgt_entry(), you can see
that its parameter "need_rmap_locks" sometimes comes from the caller's
"need_rmap_locks" variable (in the HPAGE_PUD and HPAGE_PMD cases), but
other times it is just hardcoded to true (in the NORMAL_PUD and
NORMAL_PMD cases).
So move_normal_pmd() always holds rmap locks.
(This code would probably be a bit clearer if we moved the rmap
locking into the helpers move_{normal,huge}_{pmd,pud} and got rid of
the helper move_pgt_entry()...)

(Also, note that when undoing the PTE moves with the second
move_page_tables() call, the "need_rmap_locks" parameter to
move_page_tables() is hardcoded to true.)

> The patch looks good to me overall. I was also curious if
> move_normal_pud() would require a similar change, though I=E2=80=99m incl=
ined
> to think that path doesn't lead to a bug.

Yeah, there is no path that would remove PUD entries pointing to page
tables through the rmap, that's a special PMD entry thing. (Well, at
least not in non-hugetlb code, I haven't looked at hugetlb in a long
time - but hugetlb has an entirely separate codepath for moving page
tables, move_hugetlb_page_tables().)

