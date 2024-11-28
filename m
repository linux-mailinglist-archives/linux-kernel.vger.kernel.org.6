Return-Path: <linux-kernel+bounces-424972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB469DBBED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71170164A76
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349F41C07CB;
	Thu, 28 Nov 2024 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWfIm4lG"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AF6E2BE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732815986; cv=none; b=t+u0qF8JtqF3ry97pfm8xNf9ULGKUpWIbPv5cithAP/QhcYAmK83vUS0m/AAVmpx+qbK7Fa4iY51wL+0ZrrJQCf1DpuG568j0+5oXugToUBCT56n7gJj0xySPkI8XDSXatBw8LmEuoq5dDCH1bmUOh/fqOcm9zraXsWuSy2LWp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732815986; c=relaxed/simple;
	bh=xfMtrktkr9Zu3Sugjz2kzAdSEEF9EQmcCqe5fFm09fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcYNA2ZO3M5i8HTpVsTdEiuRBo7mtmRr2+s2t5RfedhNw1yAuSw+FdkDTj+3D2D5tZCkVnHhY5HLsT0KIVXoJYPPWoNmZUUbsyappx7hxUJn5j2ny9n1czwuWra8CwZpNzRrwgdlfNeEQ0h9bKpB69GgFJgrQxjL6cQmv5BfQqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CWfIm4lG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so9100a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732815983; x=1733420783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfMtrktkr9Zu3Sugjz2kzAdSEEF9EQmcCqe5fFm09fQ=;
        b=CWfIm4lGP/olhbg1F/tMwKOnn3TN8VpF2EKjSw+P28ryniCbvb5jZhIETeqQ29K7ST
         plkIpcOCo+Tae1cmCC5c+p+VMXS9cz/WTirT8mxTpSiFnuSKdD7ecu32CjnzRTzVmGuX
         sOEyjXY7XbCeRcrW3S7q6R9pB7FKdoxRBYebyzJNdofouZ1J1RTVxSHL116yD6K7pS1F
         +xXCKiG+O3TBrAhCpIkiZ5gZATedxxgV5iLOCIORHa83tBxyxxzSJcB5zMpFyjP3hTMS
         L7zrSFjpcrAfH+FHXvsFUBf/rNazbiqwWiF6Gibn5PBUzvEnVRFpdxxeRX+rKjDnij8/
         ZSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732815983; x=1733420783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfMtrktkr9Zu3Sugjz2kzAdSEEF9EQmcCqe5fFm09fQ=;
        b=WtQxNrnakHGHafW0+zZ/5kFyr67uxcUmP1BmrtU3BF+zabmst7bFmvmIwKUf99FY75
         9pyenD5Pqjg9lAxGUFzlr+4wAbewNPYTYA5kFA89E0pC/vn5c8H3u/JdvTABIxLTznKw
         amyCywdjkCVm27LGx6AoJ+t7iwASJkLjxzF0LFHBvZaXxTXfATy376dgCdjD2ynRj5mz
         TqfTCcs2wL/pwIxxRBaqgFuiiDp6YwoBuvcGpSwwt8jIBBY4wSygnoe5SKMx1vKFFttZ
         XLXdVu8cm3K+2kWw6Zk+YImcnYK+0NnjgOwZ/M3EcZIvSQtuqdrrHaLV/OxrQbVpwT0G
         PCXg==
X-Forwarded-Encrypted: i=1; AJvYcCUSz8zIaEMMDgFb5vAXGNrvEqcoIpPFAw8bRAAexcZy6DNXx8KAsqIzncAT9XsCwD9Ic8S2MgZ5ErSbf6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYCWlc7wfdZf5ZtsQePzU2D4DLIugOitIJn4/xkYq/gFVF6492
	OgcpPLviY3AauS6MnPPM7shpC/vConUeVyDMzM08EsP7QMz8Mc/zt3mu6nJaXnk9GbtZiw2UGoU
	A/7TsDAzr+lF2JJtS0aLk8poh/1kfob4geXxc
X-Gm-Gg: ASbGncvJ/ucW1CLw1XMukI2IbnBhYyhXnH7ZEENoxPsdl5XH+k8VXHNDgv8SfUa1soo
	VugQfOMsDfKIeRr0d9FHoWZ5WN5R2oHBy/gvSVpJhbBOs9aX8Un7WfEg5e3s=
X-Google-Smtp-Source: AGHT+IFE4f8J+2OyfXEtsnJk8KQJKomP7u9NV3Lgu3wZ2xI/5CcK+/hsYP/OfXOTFHkLmSTMWEKADTKc0Ow3bC+lz64=
X-Received: by 2002:a50:8e13:0:b0:5d0:9990:ac8b with SMTP id
 4fb4d7f45d1cf-5d09990ad93mr52309a12.2.1732815982650; Thu, 28 Nov 2024
 09:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com> <99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 28 Nov 2024 18:45:46 +0100
Message-ID: <CAG48ez1OQWsaFGBs_EPz+9C=FwddyKG=r1PMbfDtwHNow2SYOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: reinstate ability to map write-sealed memfd
 mappings read-only
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Julian Orth <ju.orth@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 4:06=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> In commit 158978945f31 ("mm: perform the mapping_map_writable() check aft=
er
> call_mmap()") (and preceding changes in the same series) it became possib=
le
> to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
>
> This was previously unnecessarily disallowed, despite the man page
> documentation indicating that it would be, thereby limiting the usefulnes=
s
> of F_SEAL_WRITE logic.
>
> We fixed this by adapting logic that existed for the F_SEAL_FUTURE_WRITE
> seal (one which disallows future writes to the memfd) to also be used for
> F_SEAL_WRITE.
>
> For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE for a
> read-only mapping to disallow mprotect() from overriding the seal - an
> operation performed by seal_check_write(), invoked from shmem_mmap(), the
> f_op->mmap() hook used by shmem mappings.
>
> By extending this to F_SEAL_WRITE and critically - checking
> mapping_map_writable() to determine if we may map the memfd AFTER we invo=
ke
> shmem_mmap() - the desired logic becomes possible. This is because
> mapping_map_writable() explicitly checks for VM_MAYWRITE, which we will
> have cleared.
>
> Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> behaviour") unintentionally undid this logic by moving the
> mapping_map_writable() check before the shmem_mmap() hook is invoked,
> thereby regressing this change.
>
> We reinstate this functionality by moving the check out of shmem_mmap() a=
nd
> instead performing it in do_mmap() at the point at which VMA flags are
> being determined, which seems in any case to be a more appropriate place =
in
> which to make this determination.
>
> In order to achieve this we rework memfd seal logic to allow us access to
> this information using existing logic and eliminate the clearing of
> VM_MAYWRITE from seal_check_write() which we are performing in do_mmap()
> instead.

If we already check is_readonly_sealed() and strip VM_MAYWRITE in
do_mmap(), without holding any kind of lock or counter on the file
yet, then this check is clearly racy somehow, right? I think we have a
race where we intermittently reject shared-readonly mmap() calls?

Like:

process 1: calls mmap(PROT_READ, MAP_PRIVATE), checks is_readonly_sealed()
process 2: adds a F_SEAL_WRITE seal
process 1: enters mmap_region(), is_shared_maywrite() is true,
mapping_map_writable() fails

But even if we fix that, the same scenario would result in
F_SEAL_WRITE randomly failing depending on the ordering, so it's not
like we can actually do anything particularly sensible if these two
operations race. Taking a step back, read-only shared mappings of
F_SEAL_WRITE-sealed files are just kind of a bad idea because if
someone first creates a read-only shared mapping and *then* tries to
apply F_SEAL_WRITE, that won't work because the existing mapping will
be VM_MAYWRITE.

And the manpage is just misleading on interaction with shared mappings
in general, it says "Using the F_ADD_SEALS operation to set the
F_SEAL_WRITE seal fails with EBUSY if any writable, shared mapping
exists" when actually, it more or less fails if any shared mapping
exists at all.

@Julian Orth: Did you report this regression because this change
caused issues with existing userspace code?

> Reported-by: Julian Orth <ju.orth@gmail.com>
> Closes: https://lore.kernel.org/all/CAHijbEUMhvJTN9Xw1GmbM266FXXv=3DU7s4L=
_Jem5x3AaPZxrYpQ@mail.gmail.com/
> Fixes: 5de195060b2e ("mm: resolve faulty mmap_region() error path behavio=
ur")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

