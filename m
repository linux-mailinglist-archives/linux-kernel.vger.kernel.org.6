Return-Path: <linux-kernel+bounces-387278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED4A9B4EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FA11C225E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042BE3234;
	Tue, 29 Oct 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4gjzA3/"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2119882F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218117; cv=none; b=OyOej/INzkvEcOLSpvO4K/37JgilMfs86y6wti7YtXixnPeq8CbwiQ5N8b6a4vW2Tkh20cHKL4bXi3p9KFDLQoRX9JzdGfVSWg1m1r5jGoLdeAaM/0F0JRHpjCx6FaG2SZ+sb4OySWwmM1zs9B0WMrxym2JLfGuC/viJpcuMpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218117; c=relaxed/simple;
	bh=A06TTu4K/Hw7kYgtfoh+7pEYBjhz9PQtPavahCL9qhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/4xC0UA/XRsh5nSoL3L6KmrCaHb6JpRyCEkF9nJE+adYj+P9wRnkBOFwRJCTQA4NkUEEkBNa6BgalwyyZmkp11/dVvvqyfhgtX/PqkjPd1BZVJhz2+6svQE+bAtJGhDqr7ZM5Lx+szY1BhJ9ztN4ofzzZ/uJIWdplqysOLiG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4gjzA3/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9709c9b0cso7936444a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730218114; x=1730822914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A06TTu4K/Hw7kYgtfoh+7pEYBjhz9PQtPavahCL9qhA=;
        b=i4gjzA3/a5zcG9wmWh3JPLTyoLTXTbUn38KKzkFAAHC+fu/s+WoDCx0fzTU65oXFcv
         bCRHM/j4RwzRmSR4woyt11treUkrVDz9J7d5QAqJjfBoL/bEffFn4IO41VB0wXXJlNNR
         fA0SZDh+I28txQ8CJ171wuMy4tAOl7msDxhm2fhlFUbf0AGXTi71wdnLtDEN9QD5gNFn
         nmyCL1quVbPMZhHXl5sUqLHiFlXLnZrOjrRCrdjmYHwx9AeXDDYShzhFRjnXzvmA58Vc
         u1WyOTX+XQHKTjX3rAUF9WvtCyO8q9LcwPKt3RXVd+XFhSbVwr4tqpmCD/vGUBz+Cjae
         QUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730218114; x=1730822914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A06TTu4K/Hw7kYgtfoh+7pEYBjhz9PQtPavahCL9qhA=;
        b=d5JFK3Iaf38uiTYMg1Y1yfLxORpfYw4iyBSvhzrhTGoWoTotMnBcUMJiDK1MaItP02
         QLOrlxyyVDd27pSev8DxBNGCagTo+3WfiFlGKa/W/DFANGi5q5r6RSgsNyMDqA6jgqUT
         lC/sBkkoyilucS5M7lMN6kUtqTYxj1Lq5xC/DPw7cFpeSTxziHT6mrPrDB2NbEkSQ6xr
         jQ/NoD3BunDlFlHrcI9lTk6pqxiRCryCBMJQUtAJXE6TVC5NRmowIbnu5Z+5Q7p7ROh/
         1X4/PHrkcpPDCoz6yS3oKa1OHbVQwKmF5pqC64YVOdi5qS+9JsQ19zpEUkXkMDaEwM9P
         7eRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3Ydk+8OagKxG3N7ICUKQQOGGtrI3KEXfcG0B7LKHqf7pcflhNhZ6Zh4t1VyQwVGXCEL9AWud0yx8hJfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6hPfISMi2TO6blEcVBqcBjZnG7uaFga/M3vAMD689Lw7dabYR
	13fvjBqTq1tuXamfSuJnt0iWpY9EP6QKlAYqCjuw1C/ZujngCjSfTOmGam9bE+zSxTJ2hsgV0AN
	Z2KYhwFTX60ejVoOa9g/gZouyAaE=
X-Google-Smtp-Source: AGHT+IH74eVrjzaa4trUOcmLyXjO6CWenLrQhabobnZcdo22+AisWlEFlNRHU+rC8G3QwxoacSmfWGmdR6B2NtODF3Y=
X-Received: by 2002:a05:6402:2791:b0:5cb:b616:5eda with SMTP id
 4fb4d7f45d1cf-5cbbfa54a5amr8452059a12.25.1730218113483; Tue, 29 Oct 2024
 09:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
 <ea10a05be83c70cf610d470fe3b4c05513e3859c.1730206735.git.lorenzo.stoakes@oracle.com>
 <CAHbLzkqmDyOb9kwLKyKkThjT41UNCwb6p8XL6rEHVmvEbJEXZw@mail.gmail.com> <32e59a00-a174-4fcc-befd-56915cfb01d1@lucifer.local>
In-Reply-To: <32e59a00-a174-4fcc-befd-56915cfb01d1@lucifer.local>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 29 Oct 2024 09:08:22 -0700
Message-ID: <CAHbLzkrvwXOhjbH9pMoJq_-r9nCbwW=HrTnkA3avP2C=7QaMNg@mail.gmail.com>
Subject: Re: [PATCH hotfix 6.12 v3 4/5] mm: refactor arch_validate_flags() and
 arm64 MTE handling
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 8:52=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Oct 29, 2024 at 08:43:04AM -0700, Yang Shi wrote:
>
> >
> > Sorry for chiming in late. This looks problematic IIUC. The patch 5/5
> > moved arch_validate_flags() before call_mmap() as the commit log said.
> > But shmem_file() does this check:
> > mapping->a_ops =3D=3D &shmem_aops
> >
> > But mapping->a_ops is not initialized until shmem_mmap(), which is
> > called by call_mmap().
> >
> > So shmem_file() should always return false here. Did I miss something?
>
> Well firstly this is tested and works so you did miss something :)
>
> Bu shmem_mmap() is not setting mapping->a_ops, it's setting vma->vm_ops.
>
> __shmem_get_inode() and shmem_symlink() set mapping->a_ops.

My bad, stared at "_ops", but missed "vm" prefix. And shmem_mmap()
can't touch a_ops. Sorry for the disruption.

