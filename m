Return-Path: <linux-kernel+bounces-215421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B0590927A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F316E1C213DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3736A19EEDB;
	Fri, 14 Jun 2024 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aaFoKWoG"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996F1474B1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390590; cv=none; b=sI4EEcY/A3IvRkhLn0ls2L9JBriTDZR4RiQmp7kg0c23NMjdhJdhLeRJ07eSTTDkfwtqmM34p832T4NKQiFEMVZgIAuVx1VDiD5oTHkZJiWhkA/MubeoLuLQB9ASZmTP3Junc1p+iON47agLFwlWyhfZpPpJOnZ1sdY8DFj5Y80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390590; c=relaxed/simple;
	bh=pBB3ElUJ21kZg3P5naloCbgwOJT/w1v+b5Us/nKyYuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFX5ZWcs4QouzPCEgzuDx88pHyaGfG6QPDK9mKIJ3A5i/MA/utC36oK4RzQEs9Z3UezJix1VMT0FTiu7EW2ZAGoExh9GWklZmd9ztWsgM6MijX1pLLfv4Yq5NekkFADsMd+8OpuwToFqLbgYynC8/AH7Of2WNXtjCort+NgRyfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aaFoKWoG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c8bd6b655so2325a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718390587; x=1718995387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aayMcImIiHCchvGs8x1OjnqmxjPWkU2rmtvtJadc+I4=;
        b=aaFoKWoGx0liSd3qR9225SMpC6W0GkA8p01hIBfka+f+El43+YE+yGH85n4wJmQVeB
         pQiprYUxmiGysI18Hn73FM2ZoW6o2NGizxbAQ1UrU4nJH35sjQ356nOFSW56wzTNix1A
         pkq0m3Xxhsyo+6eHemVUGjX9fxxGm3aBtyJeIrVWshS4zDDxih5WvE8fVKZTpnjz6HBX
         2NnPBKGwdwKgNNpOlQ7jWVXVDTL6ljGbHKvnvedAurivFBziUZtVofQo72YVeAhVpKQc
         6IemswFMji1x1SJge/I6sYiMRx9Dax9in76Ydece33q8U5zbWSueDLTfqzzVVPBJ7KqY
         vUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718390587; x=1718995387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aayMcImIiHCchvGs8x1OjnqmxjPWkU2rmtvtJadc+I4=;
        b=w6welgWaVz3dojx/V8yoWJOFxbPRNXvN/fUg+OobnTXMohDIAboLVdQzD+dxWQb2uO
         eydrB1XuL6KNNUXVYuigB9ItvDLraKEuEjDHNXS97qX270eW2tA+MlrFDVFnMh3MQCvq
         6tFCqfwARpC7oikEGl+hYw4moj3EtlBsMyEXQ/eFOj1TlJ+zAUIeZSA2XmQUyhDFDWNk
         pAI2fM95j8X5Olu+uYZofe9pQpDOealdoG0TLiw/tWJk1UuJDM00alG/mZefUv05Y2tM
         s+3MAxmdVYA4LrNuswCplfZdAzXdnbbH+JGEgl+w8UdLKisZCqkmUBHBmryoIknwkgnS
         DNIw==
X-Forwarded-Encrypted: i=1; AJvYcCXnrN44GHN5jNcyn2qHikOoAARDTGPlCWgOrgK3AURJQPOOKHXk6tA0sO1+ds06lUSm85uWv5CovVCRDgpXrJPxXgkMB4APqDSK9mEv
X-Gm-Message-State: AOJu0Yw8qZTLfu2qrr9X93Yi0VdOeV0o5/CRP5G1DPasTsANzAvzU1vr
	7SiLCIWZuUHZZuary9mhveyJAhR1r5tml+Qy1QCAIqEl3zlIVrKH8DZO4e0ybxSVaw5QPyDN5zx
	pDxCTHEsPrQ7f8FZtPct92maY6XnD/c77+QhU
X-Google-Smtp-Source: AGHT+IHiLnsao6D4I0PlY5y01zGqUfsNOxwQfXlNIU0uLC/MCNKZUC5n20ybAQIu2EUPjg2n4pMs3QULLfqieAd5xKI=
X-Received: by 2002:a05:6402:35c1:b0:57c:bc56:811f with SMTP id
 4fb4d7f45d1cf-57cca54e76dmr25657a12.0.1718390586382; Fri, 14 Jun 2024
 11:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614182327.752156-1-jeffxu@google.com> <20240614182327.752156-2-jeffxu@google.com>
In-Reply-To: <20240614182327.752156-2-jeffxu@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 14 Jun 2024 20:42:28 +0200
Message-ID: <CAG48ez0c3PyXhaW78tCXW0_e45YJtfOGj=shKZrLu5RZJ66vGg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] /proc/pid/smaps: add mseal info for vma
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, sroettger@google.com, rdunlap@infradead.org, 
	david@redhat.com, adhemerval.zanella@linaro.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri, Jun 14, 2024 at 8:24=E2=80=AFPM <jeffxu@chromium.org> wrote:
> Add sp in /proc/pid/smaps to indicate vma is sealed
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  Documentation/filesystems/proc.rst | 1 +
>  fs/proc/task_mmu.c                 | 3 +++
>  include/linux/mm.h                 | 5 +++++
>  mm/internal.h                      | 5 -----
>  4 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
> index 7c3a565ffbef..400217a1589c 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -571,6 +571,7 @@ encoded manner. The codes are the following:
>      um    userfaultfd missing tracking
>      uw    userfaultfd wr-protect tracking
>      ss    shadow stack page
> +    sp    sealed page

Nit: Why "page"? The sealing is a property of the VMA, not of the
pages mapped into it. Maybe "sealed area" and an abbreviation like
"sl" would make sense?

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 587d34879865..8600564898fa 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -314,6 +314,11 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_NOHUGEPAGE  0x40000000      /* MADV_NOHUGEPAGE marked this vm=
a */
>  #define VM_MERGEABLE   0x80000000      /* KSM may merge identical pages =
*/
>
> +#ifdef CONFIG_64BIT
> +/* VM is sealed, in vm_flags */
> +#define VM_SEALED      _BITUL(63)
> +#endif
> +
>  #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
>  #define VM_HIGH_ARCH_BIT_0     32      /* bit only usable on 64-bit arch=
itectures */
>  #define VM_HIGH_ARCH_BIT_1     33      /* bit only usable on 64-bit arch=
itectures */

Other 64-bit flags are defined further down; maybe it would make sense
to move this definition below the definition of VM_ALLOW_ANY_UNCACHED,
so that the definitions are sorted by the number of the bit?

