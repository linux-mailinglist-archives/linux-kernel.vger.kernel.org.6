Return-Path: <linux-kernel+bounces-277070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58D0949BEC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F7B1C22A1E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06971176AB7;
	Tue,  6 Aug 2024 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u9NV1iaz"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77934176259
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985793; cv=none; b=ccEh//5IC7qM7AwJdc1l7T4EVG1e0KgMjLvuTNusnT866nOSeh6V7LoCySaZ7TKYfTn1IAFEFBB0EZxEht2I7XzjCKvhC8xbrbODEmx2jOVSYHVCMlmWTepl89OKo8CJ8EqNiAP3b6oMtygBdC0mjUHs1NWOhrAnMzIbTvdzv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985793; c=relaxed/simple;
	bh=3KEeJcfO/sWphu4davVmyLBGNcr1nNaw7kIV3mnnT34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHo0mSU9jzR1h1hPE6rhDdbxc+1sVbB0to38yLbZ8O2bJxx24c9E35WtXaBccqRvoHM4VeE6UkYWnhPben5v0zhKDLM9CCpAHo5uSbTXQXOxONwGAnMcwJkwL0YVp0LnomGwk9XfEoUX23RZGc6GJfUBgU3ldoEXpHsx/ICYlY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u9NV1iaz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so23690a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722985790; x=1723590590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wfG0B27yuXZf8QVm7TCISX2r/3GuYLNzlXwozjo5o0=;
        b=u9NV1iazO9B8cjvgmhdtH2LSmmqet8ywd6m6CfFSQ4sVLlj5T5eKz6hxp8463Ipla3
         j8J8beGxA+uXt9iQ/ftp6d9LXXmksjuu5CB2TDUBS5uJ4b678soYv6a9B1ea+DsmYbcX
         xVCeUnJQWIPHGaTTfHWOQRSLLg5hVJhHigIE9NQXCb9cS+lgIqnJ2qUkXhmWovPisJ/B
         msbIF/YcrQKXQxVJbdkyXaszqOiIiRWc028jAGLG34YWtErLR4ej6IUXvzFacB3usvj6
         lmcapUmwJ/fuXfCSb6AkTUYmObBsrfIO62qBk5noC0BLk9gIYbylVYrrbAr6k9++7C8+
         jW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722985790; x=1723590590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wfG0B27yuXZf8QVm7TCISX2r/3GuYLNzlXwozjo5o0=;
        b=Ud1gZ7wVFrm26ps0JatNutvongHzwHXlkMbWe7nNRvPiUIo+DszrIGHiBDAM/MCyzP
         Tvhs9KDu41aWaTYH21F6rhgsDFoxibsF8NXsPhdOjKkn4jKmo92wHUnlwVq3mQEnlWXP
         ZiWZ/srQi6iw7Vmk3BU9gh4Ag5hV1sesBs6qmZYZpmXBbBOATflNtv8G2bOcpC53r+L4
         kZxzRubTjxyqNYZa84Sevuxz5LCFMt5KfgBUD8E0gr4mt+qfJStMT5VTH3F5ooHidP/2
         GVVc2JmtSlNo6w4OiXVudY/A39v5Jg+p6kYwHS8xGs2USIAp9VwtAmxcnlpY7zQzAXOP
         VkaA==
X-Forwarded-Encrypted: i=1; AJvYcCWKkqM4asJzF9uJTzfks69LqMiwmwAcY4MkqZ5gPG6gZMzVSU0ZtN7ciKZqx7WB1Ael4PSZqWQVPpBiwOuYH4RUAKMZHO4DqJrS0WYR
X-Gm-Message-State: AOJu0YwoX1N44WD5H6ZVNn2cRLEAtM5WqAmJmhagZaDaczxYSK1OdE4g
	mV2uzkZmEPbLzsCNrW25YdgeIjdtfYJbX2aQ5aYOiCuTJFaxjgH3vTOiaB1hSPXFicZJ7rEjfz5
	Jys4sOMHRd+SL+EEs4La9QWKoHNMVDzxASuPQ
X-Google-Smtp-Source: AGHT+IEwB5XNHscH8DmO311U1n0+Zhun3ft3s2RMV5xdY2tXSyq6UUu0zpDYxv+uGC6rLVEOROZpHhkYgIDFCx1Us4U=
X-Received: by 2002:a05:6402:1ecf:b0:5ac:4ce3:8f6a with SMTP id
 4fb4d7f45d1cf-5bba28b2804mr84654a12.6.1722985789487; Tue, 06 Aug 2024
 16:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806212808.1885309-1-pedro.falcato@gmail.com> <20240806212808.1885309-5-pedro.falcato@gmail.com>
In-Reply-To: <20240806212808.1885309-5-pedro.falcato@gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 6 Aug 2024 16:09:11 -0700
Message-ID: <CALmYWFu_cnS1nHcQxVmjp=a+SdsACi+4YWWvfDGTB=pj=fmS3A@mail.gmail.com>
Subject: Re: [PATCH 4/7] mm/mremap: Replace can_modify_mm with can_modify_vma
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 2:28=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> Delegate all can_modify checks to the proper places. Unmap checks are
> done in do_unmap (et al).
>
> This patch allows for mremap partial failure in certain cases (for
> instance, when destination VMAs aren't sealed, but the source VMA is).
> It shouldn't be too troublesome, as you'd need to go out of your way to
> do illegal operations on a VMA.
>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  mm/mremap.c | 33 +++++++--------------------------
>  1 file changed, 7 insertions(+), 26 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index e7ae140fc64..8af877d7bb0 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -676,6 +676,9 @@ static unsigned long move_vma(struct vm_area_struct *=
vma,
>         if (unlikely(flags & MREMAP_DONTUNMAP))
>                 to_account =3D new_len;
>
> +       if (!can_modify_vma(vma))
> +               return -EPERM;
> +
I m not 100% sure, but I suspect you don't need this check? Is
vma_to_resize already checking the src address ?

PS. Is it possible to consolidate all the related changes (except the
fix for madvise) to a single commit ?
 It would be easier to look for dependency, e.g. the remap depends on munma=
p().

Also selftest is helpful to prove the correctness of the change. (And
I can also test it)

>         if (vma->vm_ops && vma->vm_ops->may_split) {
>                 if (vma->vm_start !=3D old_addr)
>                         err =3D vma->vm_ops->may_split(vma, old_addr);
> @@ -821,6 +824,10 @@ static struct vm_area_struct *vma_to_resize(unsigned=
 long addr,
>         if (!vma)
>                 return ERR_PTR(-EFAULT);
>
> +       /* Don't allow vma expansion when it has already been sealed */
> +       if (!can_modify_vma(vma))
> +               return ERR_PTR(-EPERM);
> +
>         /*
>          * !old_len is a special case where an attempt is made to 'duplic=
ate'
>          * a mapping.  This makes no sense for private mappings as it wil=
l
> @@ -902,19 +909,6 @@ static unsigned long mremap_to(unsigned long addr, u=
nsigned long old_len,
>         if ((mm->map_count + 2) >=3D sysctl_max_map_count - 3)
>                 return -ENOMEM;
>
> -       /*
> -        * In mremap_to().
> -        * Move a VMA to another location, check if src addr is sealed.
> -        *
> -        * Place can_modify_mm here because mremap_to()
> -        * does its own checking for address range, and we only
> -        * check the sealing after passing those checks.
> -        *
> -        * can_modify_mm assumes we have acquired the lock on MM.
> -        */
> -       if (unlikely(!can_modify_mm(mm, addr, addr + old_len)))
> -               return -EPERM;
> -
>         if (flags & MREMAP_FIXED) {
>                 /*
>                  * In mremap_to().
> @@ -1079,19 +1073,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsig=
ned long, old_len,
>                 goto out;
>         }
>
> -       /*
> -        * Below is shrink/expand case (not mremap_to())
> -        * Check if src address is sealed, if so, reject.
> -        * In other words, prevent shrinking or expanding a sealed VMA.
> -        *
> -        * Place can_modify_mm here so we can keep the logic related to
> -        * shrink/expand together.
> -        */
> -       if (unlikely(!can_modify_mm(mm, addr, addr + old_len))) {
> -               ret =3D -EPERM;
> -               goto out;
> -       }
> -
>         /*
>          * Always allow a shrinking remap: that just unmaps
>          * the unnecessary pages..
> --
> 2.46.0
>

