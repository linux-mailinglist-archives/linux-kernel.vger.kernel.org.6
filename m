Return-Path: <linux-kernel+bounces-406661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F8E9C61E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597A128283D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE572194B2;
	Tue, 12 Nov 2024 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6akB4o2"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFD217F31
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441122; cv=none; b=I4T2IgxMsX/fNDSFgDt6DwPdSlRGoWta0rMSsllfZ3P/uvi1txQmfaaTCAhxJNPCsMYyNQQo1pqTgIDEsyENgF6snJALCB7DJu8yu81grAhwCCf1msWgoMC7rx4FvFD5fGr9CtLdQ9N7mE94zh5UetbwhDh4LN/vzh6KAqsVNwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441122; c=relaxed/simple;
	bh=cuSl46Z9K48sQguDicGT99gG9ngGrsn9DoXLZYO3cKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGapxmpfJ87Rln4xC634jnpzUE3abLkJ+gGTskvne6k7+nQK3YBjfKulsa7+thsOPgu5+D8MWFo2vDiDSnd2/+iEaSR+3Bo/jCFlJAyxdoPv9RVacj3CE23abd9Pa3jfgn2SEtKnviBkur1IeGwTfcvdJJd3Ec7GARsWCzBv7Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6akB4o2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460a8d1a9b7so37911cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731441119; x=1732045919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDNBm/U0yVHZV8qUr/3jUbrM8ULh8NcvU59R50o8V1g=;
        b=K6akB4o2mvio+bQETnxGG4IGjWeSO0Rwt3FRnvQEv350ZUujQgCdCIWnEnzeHNeKKY
         d5Kqai/hd+0qw8yroJOW4kcNHWeAeNlgW3eYUT5U7FJ0HdbmVDSsCPjaZ3H8zdu5ylPH
         mUxNo9YU2Iv0vNdltj1C5yuBZxiTASQfzO95ZKytpiL7atFyDEKlKxv1m4CSkk0t4tyd
         +6tWGlajqrSvNRx6RDzSPQPKueLzSZshk4ljemP+jOfvKkULFw6lV8+Y4K3l55FDhE28
         D5+rhPkTrCjtxcHlWFU+7hUPKbUr/qJ4pzqSO/ZJlp22NlDrScZSBQGdpd2PNsoswkt0
         oDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731441119; x=1732045919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDNBm/U0yVHZV8qUr/3jUbrM8ULh8NcvU59R50o8V1g=;
        b=AIo7irANqKqATE+cnk2M6jYmSdt3j2rT51b31WKb1CcZsEA42rR2m7W+IfZ5o+UmO2
         YyRjKhCj0ru+5vn/ATGg6TiEUuc6rawZMwa7OqxaQItMZZSB0g11zAA+mE1xbu0DZl8E
         98wrGTRNKukWCCXpA5INJZKyJsAg/+9NnmkROuxOoF4Micd4Y8gHxSmu9wDbwDkm2Qau
         HXBbKigtnzTzacLpGQ+xHEXuyL99Dax8xC3sFqP3vl800lrKyElQgwiCd/wOVlYwvv8h
         WaDwH+jcEIpbbl3rBFupZ5y9GwO3gcX4XdP9UDMCvP2lWtNRygMMe7GcspSYyDfIGPU+
         c/1w==
X-Forwarded-Encrypted: i=1; AJvYcCWVh2Oy35VayzBXVrMJrlv6l77TcXQaFYOdylQaVDhSshRaUyLqXhyfl/YAhXyzDOeIiedfI4Z/JpE+S40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1gabvcijCI3jgBd7XMSauZcR/aMc6K3bGWrGDTRTcbcR8H5YD
	RJo1rlR4vB0aLpZw0EJ5M0eoNMPCLcndCuque0YXHxQX9jqRvzDNsWrSRYQeWT7oMQCRlv8R3sv
	d0hSGZYvOdtt7OCuvBcTXG24i99Gpg1BKl4rg
X-Gm-Gg: ASbGnctHw6jxOvO9kO4gEG/K4fN8XN+jjb6zanOqjjAe8imBZpU7Tv25epSwfVCIgal
	unibHdx29qyCxH7gZWbwc/AbbF/FfT2g67yIBrbg9uC5IWQrKpOsnznvVFg5TcA==
X-Google-Smtp-Source: AGHT+IG02KzRz0I4R7IHawM0fVL6bMMsHycSuvnA+0xsEOeEU7+UlfzUSrWR2D5DsFWXSW6GCTA5mbmd8oPsAM4avhk=
X-Received: by 2002:a05:622a:2a94:b0:461:3e03:7388 with SMTP id
 d75a77b69052e-4634be3aa39mr101821cf.25.1731441118826; Tue, 12 Nov 2024
 11:51:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-6-surenb@google.com>
In-Reply-To: <20241112194635.444146-6-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Nov 2024 11:51:47 -0800
Message-ID: <CAJuCfpHuPfkq4Js02gvAPy=g4mB+55hR9VhXsiTa6bv8uXXNCw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] docs/mm: document latest changes to vm_lock
To: akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 11:47=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> Change the documentation to reflect that vm_lock is integrated into vma.
> Document newly introduced vma_start_read_locked{_nested} functions.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Sorry, forgot to CC Mr. Corbet and linux-doc@vger. Added now.

> ---
>  Documentation/mm/process_addrs.rst | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/proces=
s_addrs.rst
> index ed74685ffbf2..c8935509173e 100644
> --- a/Documentation/mm/process_addrs.rst
> +++ b/Documentation/mm/process_addrs.rst
> @@ -675,7 +675,11 @@ RCU critical section, then attempts to VMA lock it v=
ia
>  :c:func:`!vma_start_read`, before releasing the RCU lock via
>  :c:func:`!rcu_read_unlock`.
>
> -VMA read locks hold the read lock on the :c:member:`!vma->vm_lock` semap=
hore for
> +In cases when the user already holds mmap read lock, :c:func:`!vma_start=
_read_locked`
> +and :c:func:`!vma_start_read_locked_nested` can be used. These functions=
 always
> +succeed in acquiring VMA read lock.
> +
> +VMA read locks hold the read lock on the :c:member:`!vma.vm_lock` semaph=
ore for
>  their duration and the caller of :c:func:`!lock_vma_under_rcu` must rele=
ase it
>  via :c:func:`!vma_end_read`.
>
> @@ -739,7 +743,7 @@ keep VMAs locked across entirely separate write opera=
tions. It also maintains
>  correct lock ordering.
>
>  Each time a VMA read lock is acquired, we acquire a read lock on the
> -:c:member:`!vma->vm_lock` read/write semaphore and hold it, while checki=
ng that
> +:c:member:`!vma.vm_lock` read/write semaphore and hold it, while checkin=
g that
>  the sequence count of the VMA does not match that of the mm.
>
>  If it does, the read lock fails. If it does not, we hold the lock, exclu=
ding
> @@ -749,7 +753,7 @@ Importantly, maple tree operations performed in :c:fu=
nc:`!lock_vma_under_rcu`
>  are also RCU safe, so the whole read lock operation is guaranteed to fun=
ction
>  correctly.
>
> -On the write side, we acquire a write lock on the :c:member:`!vma->vm_lo=
ck`
> +On the write side, we acquire a write lock on the :c:member:`!vma.vm_loc=
k`
>  read/write semaphore, before setting the VMA's sequence number under thi=
s lock,
>  also simultaneously holding the mmap write lock.
>
> --
> 2.47.0.277.g8800431eea-goog
>

