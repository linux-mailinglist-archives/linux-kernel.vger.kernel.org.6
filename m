Return-Path: <linux-kernel+bounces-366383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B4D99F48F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21872284578
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD111FAF16;
	Tue, 15 Oct 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gIm+WtgA"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF316EBE8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015041; cv=none; b=mnohq53tq9IHxng3kj6G1H9ROFZvLlptdvGZfFSpg1TOkPlJERmmJypdLAoxtWv483Q/T7ji/B7n4KbGZbFleLVkvxWN8dlsi3tW7bvUbhtcsGPISftvdofBQy1340CJHNUohZWjnEPZD9tlyBMVLZmUp+mPkljFbyYuDsEWL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015041; c=relaxed/simple;
	bh=nv3qG9u+OKmIXIWmhaH262V2xcqKK6Xy1L3UzPQHK6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kbt6eIKO2BcxYngZ0ZeUCtdfHDxdSA9z6KtUGESwHHauWSr2HS2GMo9+j4d0YbT3ETu9/ETnQpogd5qsHyNYHr4voCl69FNizVGEZEk57dprhx/vxAWSL9r9jhVQ+r3SzAzg0bcPwt5mam4sH1qLAS1eK0b/q9ZMmi3PHVR8j4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gIm+WtgA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so55990a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729015037; x=1729619837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oy6hku2nGywb7rejUWih8IdQfUCvfFupUIO4ZBdAV6c=;
        b=gIm+WtgADpKpMyZHaMyuMZEa2y5rm8H1nRnGhsJ/fGE+ZSSC5bZ9rbNsK6HUbGS5EK
         ib14lLC/QxLQp6GEDcvJjwT9o/z7GTUPqoX36lqFUg2eGTpZTz5Rx/e6fIWof0q2WGAu
         w79Z9kzkSY5QTwQuMkOGig6YDIJBngQ94RNIiqvMCTbI3v+vactihGFD5FlneEoGxvFz
         rE4AMGhCSC08PTYiIM/wWTe2budlxEK8CHcqs+SFZPh6+e26MnxFy+gds8rsbjNI+SSm
         qCWS96y3dWL7/p9F6rPBv1M3oOPzcuCuvIqEkV8+3/N64nAJPvX6dMORY338YnosVrTE
         /uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729015037; x=1729619837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oy6hku2nGywb7rejUWih8IdQfUCvfFupUIO4ZBdAV6c=;
        b=ougNNYAt2Uagapag6llhM+478M2lkY1PJVi80tbH5Nx17eLo13xAxP9HNWnm8HyKLt
         84QpHLyiDIMjh8geIwDGkwNWLJHNf22/W03UQQgbTuUOjEv5HQJtUM087agfDmzkicI0
         joVYu35q0YJ/jcWbuO7GQ5stsGO6pXOnQjpk4babcOy6tjrJq1hmlD+ylsH3CODpzcGF
         czjTQs/+N4oOFGvKJ4CiqIgG0PVTVkZDou8gjvaqBEKeaCnf7tq28/orQyAwlQO6rd9k
         sn8KJ6MdENO+rLVL7SHtvJDfFj/KpWA+HTzmlYVwNad9qrJUf1XS+NHPaKImrdHaMdE2
         BNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpLBN8qdc3HmpcIN0tIty2o2QYgbxppK0DN2wSxc3vklJHzBAuUVkVz7bvpxFuqN9cQHaidFDC8ygmMHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaz+p7crtRaZJ8tNUztdxCVHVr+itoY1HBOCas3iR7Eamal0VB
	mgV4Kd7B6kj7S4N80jmAQKiX6e/VvewYg/iMoMw9tMu4y5+fT8eEptHMzxQFOjCB4OTj91zQA0d
	Rh3y1PpuGjnZ67+2YtpbKAp0/Vmuk9UfrhGJk
X-Google-Smtp-Source: AGHT+IHpC4Z2Brqidic9WYS1qahXmtTOICOECUsGWQtcS9MEDbuqtCQisOH/f0cbki1zFlHmf2Q4Vg+LPf0Vmm3cyu8=
X-Received: by 2002:a05:6402:234a:b0:5c8:a0fd:64f0 with SMTP id
 4fb4d7f45d1cf-5c9979d0b81mr8625a12.2.1729015036909; Tue, 15 Oct 2024 10:57:16
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015161135.2133951-1-Liam.Howlett@oracle.com>
In-Reply-To: <20241015161135.2133951-1-Liam.Howlett@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Oct 2024 19:56:39 +0200
Message-ID: <CAG48ez0LJEFJgOeuKwh+enbbELtd5=SNGv1eiDvb8XDbLUvvyg@mail.gmail.com>
Subject: Re: [PATCH] mm/mmap: Fix race in mmap_region() with ftrucate()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:12=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> Avoiding the zeroing of the vma tree in mmap_region() introduced a race
> with truncate in the page table walk.  To avoid any races, create a hole
> in the rmap during the operation by clearing the pagetable entries
> earlier under the mmap write lock and (critically) before the new vma is
> installed into the vma tree.  The result is that the old vma is still in
> the vma tree, but the page tables are cleared while holding the
> i_mmap_rwsem.
>
> This change extends the fix required for hugetblfs and the call_mmap()
> function by moving the cleanup higher in the function and running it
> unconditionally.
>
> Cc: Jann Horn <jannh@google.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/all/CAG48ez0ZpGzxi=3D-5O_uGQ0xKXOmbjeQ0Lj=
ZsRJ1Qtf2X5eOr1w@mail.gmail.com/
> Link: https://lore.kernel.org/all/CAG48ez0ZpGzxi=3D-5O_uGQ0xKXOmbjeQ0LjZs=
RJ1Qtf2X5eOr1w@mail.gmail.com/
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Thanks, this looks good to me.

Reviewed-by: Jann Horn <jannh@google.com>

